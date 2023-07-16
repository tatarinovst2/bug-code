using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text.RegularExpressions;
using UnityEngine;
using Interpreter;
using Slowsharp;
using UnityEngine.UI;
using TMPro;

namespace BugCode
{
    public class TaskScript : MonoBehaviour
    {
        private static TaskScript _instance;
        public static TaskScript Instance => _instance;
        
        private Task _task;
        [SerializeField]
        private TMP_InputField _inputField;

        [SerializeField]
        private Task _defaultTask;

        private void Awake()
        {
            _instance = this;

            if (_task == null)
            {
                Configure(_defaultTask);
            }
        }

        private void Start()
        {
            ShowCurrentTask();
            
            GameObject instructions = CanvasScript.CreateMenu("Long Text View");

            TextViewScript textViewScript = instructions.GetComponent<TextViewScript>();
            string instruction = @"You are coder in real life, but right now you are having a nightmare. You are forced to create buggy code by an unseen force...

You can choose C# or Python or both. Each language has 3 tasks. You can switch between them in the menu.

Task: you can check what the task is by clicking it.
Test: tests the code.
Menu: opens the menu where you can choose the task

To exit press the X in the upper left corner.
";
            textViewScript.Configure(instruction);
        }

        private void OnDestroy()
        {
            _instance = null;
        }

        public void Configure(Task task)
        {
            _task = task;

            if (string.IsNullOrEmpty(_task.LastSavedCode))
            {
                _inputField.text = _task.InitialCode;
            }
            else
            {
                _inputField.text = _task.LastSavedCode;
            }
        }

        private bool DoPrintOutputsMatch(string[] outputs, string[] expectedOutputs)
        {
            if (outputs.Length == 0)
            {
                return false;
            }
            Debug.Log("_______");
            
            for (int i = 0; i < expectedOutputs.Length; i++)
            {
                Debug.Log(ConvertToFloatIfPossible(outputs[^1].Trim().ToLower().Replace("\t", " ").Replace("\n", " ")) + " " + 
                          ConvertToFloatIfPossible(expectedOutputs[i].Trim().ToLower().Replace("\t", " ").Replace("\n", " ")));
                string string1 =
                    ConvertToFloatIfPossible(outputs[^1].Trim().ToLower().Replace("\t", " ").Replace("\n", " "));
                string string2 =
                    ConvertToFloatIfPossible(expectedOutputs[i].Trim().ToLower().Replace("\t", " ").Replace("\n", " "));

                string1 = Regex.Replace(string1, @"\s", " ");
                string2 = Regex.Replace(string2, @"\s", " ");
                
                if (string.Equals(string1, string2))
                {
                    return true;
                }
            }

            return false;
        }

        public void ShowCurrentTask()
        {
            GameObject taskView = CanvasScript.CreateMenu("Task View");
            TaskDescriptionViewScript taskDescriptionViewScript = taskView.GetComponent<TaskDescriptionViewScript>();
            
            taskDescriptionViewScript.Configure(_task.TaskDescription, _task.Hint);
        }

        public void ShowMenu()
        {
            GameObject menuView = CanvasScript.CreateMenu("Menu View");
            MenuViewScript menuViewScript = menuView.GetComponent<MenuViewScript>();
        }

        public void ShowExitView()
        {
            GameObject exitView = CanvasScript.CreateMenu("Exit View");
            ExitViewScript exitViewScript = exitView.GetComponent<ExitViewScript>();
        }

        public void ShowTextView(string text)
        {
            GameObject textView = CanvasScript.CreateMenu("Text View");
            TextViewScript textViewScript = textView.GetComponent<TextViewScript>();
            
            textViewScript.Configure(text);
        }

        public void ShowNextTaskView()
        {
            GameObject nextTaskView = CanvasScript.CreateMenu("Next Task View");
        }
        
        public void LoadNext()
        {
            // bool sawCurrentTask = false;
            //
            // foreach (Task task in TaskManager.Instance.Tasks)
            // {
            //     if (sawCurrentTask && task.TaskLanguage == _task.TaskLanguage)
            //     {
            //         Configure(task);
            //         return;
            //     }
            //     else if (task == _task)
            //     {
            //         sawCurrentTask = true;
            //     }
            // }

            if (_task.NextTask != null)
            {
                Configure(_task.NextTask);
            }
            
            ShowCurrentTask();
        }

        private void TestPython()
        {
            PythonUnityIntermediator.Instance.Debugs.Clear();
            
            foreach (TestCode testCode in _task.TestCodes)
            {
                PythonUnityIntermediator.Instance.ClearOutputs();

                try
                {
                    Script script = new Script(_inputField.text + "\n" + testCode.Code);

                    RunTime runTime = new RunTime(script);
                    runTime.run();

                    if (DoPrintOutputsMatch(PythonUnityIntermediator.Instance.PrintOutputs.ToArray(), testCode.ExpectedOutputs) == false)
                    {
                        string output = $"Wrong output for {testCode.Code}!\n" +
                                        $"Expected: {string.Join(" or ", testCode.ExpectedOutputs)}\n" +
                                        $"Actual: {ArrayToString(PythonUnityIntermediator.Instance.PrintOutputs.ToArray())}";
                        ShowTextView(output);
                        return;
                    }
                }
                catch (Exception e)
                {
                    ShowTextView(e.Message);
                    return;
                }
            }

            if (PythonUnityIntermediator.Instance.Debugs.Count > 0)
            {
                ShowTextView("Debugs: \n" + string.Join(" ", PythonUnityIntermediator.Instance.Debugs));
            }
            
            ShowNextTaskView();
        }

        private void TestCSharp()
        {
            foreach (TestCode testCode in _task.TestCodes)
            {
                ScriptConfig scriptConfig = new ScriptConfig();
                // scriptConfig.DefaultUsings = new[] { "System", "System.Collections.Generic" };
                //
                // Debug.Log(_task.Extras + "\n" + _inputField.text + "\n" + testCode.Code);
                CScript runner = CScript.CreateRunner(_task.Extras + "\n" + _inputField.text + "\n" + testCode.Code, scriptConfig);

                try
                {
                    var outputMain = runner.RunMain();
                
                    if (testCode.ExpectedOutputs[0].ToLower().Trim() != outputMain.ToString().ToLower().Trim())
                    {
                        string output = $"Wrong output for {testCode.Code}!\n" +
                                        $"Expected: {testCode.ExpectedOutputs[0]}\n" +
                                        $"Actual: {outputMain}";
                        ShowTextView(output);
                        return;
                    }
                }
                catch (Exception e)
                {
                    ShowTextView(e.Message);
                    return;
                }

                // var solution = runner.Instantiate("Solution");
                // Debug.Log(solution.Invoke("CanLogin", "Cat", ""));
            }

            ShowNextTaskView();
        }

        public void Test()
        {
            if (_task.TaskLanguage == TaskLanguage.Python)
            {
                TestPython();
            }
            else
            {
                TestCSharp();
            }
        }

        private string ArrayToString(string[] array)
        {
            if (array.Length == 1)
            {
                return array[0];
            }

            List<string> reprs = new();

            foreach (var value in array)
            {
                try
                {
                    reprs.Add(int.Parse(value).ToString());
                }
                catch
                {
                    try
                    {
                        reprs.Add(float.Parse(value).ToString());
                    }
                    catch
                    {
                        reprs.Add("\"" + value + "\"");
                    }
                }
            }
            
            return "[" + string.Join(", ", reprs) + "]";
        }

        private string ConvertToFloatIfPossible(string number)
        {
            try
            {
                return float.Parse(number).ToString();
            }
            catch
            {
                return number;
            }
        }
    }
}