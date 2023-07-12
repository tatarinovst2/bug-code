using UnityEngine;

namespace BugCode
{
    [DefaultExecutionOrder(-100)]
    [RequireComponent(typeof(Canvas))]
    public class CanvasScript : MonoBehaviour
    {
        private static Canvas _canvas;
        public static Canvas Canvas => _canvas;

        private void Awake()
        {
            _canvas = GetComponent<Canvas>();
        }

        private void OnDestroy()
        {
            _canvas = null;
        }

        private static GameObject CreateMenu(GameObject prefab, Transform parentTransform,
            Vector2 localPosition = new(), float zPosition = 0f)
        {
            GameObject menuObject = Instantiate(prefab, parentTransform, false);

            if (_canvas is null)
            {
                Debug.LogError("Error - no canvas found");
            }

            menuObject.transform.localPosition = new Vector3(localPosition.x, localPosition.y, zPosition);

            return menuObject;
        }

        public static GameObject CreateMenu(GameObject prefab, GameObject parent, Vector2 localPosition = new(),
            float zPosition = 0f)
        {
            return CreateMenu(prefab, parent.transform, localPosition, zPosition);
        }

        public static GameObject CreateMenu(GameObject prefab, Vector2 localPosition = new(), float zPosition = 0f)
        {
            return CreateMenu(prefab, _canvas.transform, localPosition, zPosition);
        }

        public static GameObject CreateMenu(string path, GameObject parent, Vector2 localPosition = new(),
            float zPosition = 0f)
        {
            return CreateMenu(Resources.Load<GameObject>(path), parent.transform, localPosition, zPosition);
        }

        public static GameObject CreateMenu(string path, Vector2 localPosition = new(), float zPosition = 0f)
        {
            return CreateMenu(Resources.Load<GameObject>(path), _canvas.transform, localPosition, zPosition);
        }
    }
}