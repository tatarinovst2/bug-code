using System;
using System.Collections.Generic;
using UnityEngine;

namespace BugCode
{
    public class PythonUnityIntermediator : MonoBehaviour
    {
        private static PythonUnityIntermediator _instance;
        public static PythonUnityIntermediator Instance => _instance;

        private List<string> _printOutputs = new();
        public List<string> PrintOutputs => _printOutputs;

        private List<string> _debugs = new();
        public List<string> Debugs => _debugs;

        private void Awake()
        {
            _instance = this;
        }

        private void OnDestroy()
        {
            _instance = null;
        }

        public string GetLastPrintOutput()
        {
            if (_printOutputs.Count == 0)
            {
                return "";
            }

            return _printOutputs[^1];
        }

        public void ClearOutputs()
        {
            _printOutputs.Clear();
        }

        public void AddOutput(string printOutput)
        {
            _printOutputs.Add(printOutput);
        }

        public void AddDebug(string debug)
        {
            _debugs.Add(debug);
        }
    }
}