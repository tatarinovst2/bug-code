using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace BugCode
{
    public class NextTaskViewScript : WindowScript
    {
        public void LoadNext()
        {
            TaskScript.Instance.LoadNext();
            Close();
        }
    }
}
