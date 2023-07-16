using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class InputFieldAlwaysSelectedScript : MonoBehaviour
{
    private TMP_InputField _inputField;
    
    private void Awake()
    {
        _inputField = GetComponent<TMP_InputField>();
    }
    
    private void Update()
    {
        if (_inputField.isFocused == false)
        {
            _inputField.ActivateInputField();
        }
    }
}
