using UnityEngine;

namespace BugCode
{
    public class WindowScript : MonoBehaviour
    {
        public void Close()
        {
            Destroy(gameObject);
        }
    }
}