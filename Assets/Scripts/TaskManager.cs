using System;
using UnityEngine;

namespace BugCode
{
    public class TaskManager : MonoBehaviour
    {
        private static TaskManager _instance;
        public static TaskManager Instance => _instance;

        [SerializeField]
        private Task[] _tasks;
        public Task[] Tasks => _tasks;

        private void Awake()
        {
            _instance = this;
        }

        private void OnDestroy()
        {
            _instance = null;
        }
    }
}