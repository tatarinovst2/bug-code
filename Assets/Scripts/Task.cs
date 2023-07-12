using System.Threading.Tasks;
using UnityEngine;

namespace BugCode
{
    public enum TaskDifficulty
    {
        Easy,
        Medium,
        Hard
    }

    public enum TaskLanguage
    {
        CSharp,
        Python
    }

    [System.Serializable]
    public class TestCode
    {
        [SerializeField]
        [TextArea]
        private string _code;
        public string Code => _code;
        
        [SerializeField]
        private bool _shouldThrow;
        public bool ShouldThrow => _shouldThrow;
        
        [SerializeField]
        private string[] _expectedOutputs;
        public string[] ExpectedOutputs => _expectedOutputs;
    }

    [CreateAssetMenu(fileName = "Task", menuName = "Task", order = 0)]
    public class Task : ScriptableObject
    {
        [SerializeField]
        private string _taskName;
        public string TaskName => _taskName;
        
        [SerializeField]
        private TaskLanguage _taskLanguage;
        public TaskLanguage TaskLanguage => _taskLanguage;
        [TextArea]
        [SerializeField]
        private string _initialCode;
        public string InitialCode => _initialCode;
        private string _lastSavedCode;
        public string LastSavedCode => _lastSavedCode;
        [TextArea]
        [SerializeField]
        private string _taskDescription;
        public string TaskDescription => _taskDescription;
        [TextArea]
        [SerializeField]
        private string _hint;
        public string Hint => _hint;
        [SerializeField]
        private TaskDifficulty _taskDifficulty;
        public TaskDifficulty TaskDifficulty => _taskDifficulty;
        
        [SerializeField]
        private TestCode[] _testCodes;
        public TestCode[] TestCodes => _testCodes;

        [SerializeField]
        [TextArea]
        private string _extras;
        public string Extras => _extras;

        [SerializeField]
        private Task _nextTask;
        public Task NextTask => _nextTask;

        private bool _isSolved;
        public bool IsSolved => _isSolved;

        public void UpdateLastSavedCode(string code)
        {
            _lastSavedCode = code;
        }

        public void SetAsSolved()
        {
            _isSolved = true;
        }
    }
}