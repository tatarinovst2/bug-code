using TMPro;
using UnityEngine;

namespace BugCode
{
    public class TextViewScript : WindowScript
    {
        [SerializeField]
        private TextMeshProUGUI _textMesh;

        public void Configure(string text)
        {
            _textMesh.text = text;
        }
    }
}