using System;
using UnityEngine;
using UnityEngine.UI;

namespace BugCode
{
    public class MenuViewScript : WindowScript
    {
        [SerializeField]
        private Button[] _buttons;

        private void Awake()
        {
            for (int i = 0; i < _buttons.Length; i++)
            {
                var i1 = i;
                _buttons[i].onClick.AddListener(delegate { LoadTask(i1); });
            }
        }

        private void LoadTask(int taskNumber)
        {
            TaskScript.Instance.Configure(TaskManager.Instance.Tasks[taskNumber]);
            Close();
        }
    }
}