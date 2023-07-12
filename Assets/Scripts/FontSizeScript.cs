using System;
using TMPro;
using UnityEngine;

namespace BugCode
{
    public class FontSizeScript : MonoBehaviour
    {
        private TMP_InputField _inputField;

        [SerializeField]
        private int _minSize = 15;
        [SerializeField]
        private int _maxSize = 40;
        [SerializeField]
        private int _step = 5;

        private void Awake()
        {
            _inputField = GetComponent<TMP_InputField>();
        }

        public void TryIncreaseSize()
        {
            if (_inputField.textComponent.fontSize + _step > _maxSize)
            {
                return;
            }

            _inputField.textComponent.fontSize += 5;
            _inputField.placeholder.GetComponent<TextMeshProUGUI>().fontSize += 5;
        }
        
        public void TryDecreaseSize()
        {
            if (_inputField.textComponent.fontSize - _step < _minSize)
            {
                return;
            }

            _inputField.textComponent.fontSize -= 5;
            _inputField.placeholder.GetComponent<TextMeshProUGUI>().fontSize -= 5;
        }
    }
}