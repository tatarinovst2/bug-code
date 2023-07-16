using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace BugCode
{
    public class TaskDescriptionViewScript : TextViewScript
    {
        [SerializeField]
        private TextMeshProUGUI _hintTextMesh;
        [SerializeField]
        private Button _button;

        public void Configure(string text, string hint)
        {
            this.Configure(text);
            _hintTextMesh.text = hint;

            if (string.IsNullOrEmpty(hint.Trim()))
            {
                _hintTextMesh.gameObject.SetActive(false);
                _button.gameObject.SetActive(false);
            }
        }

        public void ShowHint()
        {
            _hintTextMesh.gameObject.SetActive(true);
            _button.gameObject.SetActive(false);
        }
    }
}