using UnityEngine;
using UnityEngine.UI;

namespace BugCode
{
    public class ButtonTapSound : MonoBehaviour
    {
        [SerializeField]
        private AudioClip _audioClip;
        [SerializeField]
        [Range(0.0f, 1.0f)]
        private float _volume = 1;
        private AudioSource _audioSource;
     
        private void Awake ()
        {
            _audioSource = gameObject.AddComponent<AudioSource>();
            if (_audioClip != null)
                _audioSource.clip = _audioClip;
            _audioSource.playOnAwake = false;
            _audioSource.volume = _volume;
            GetComponent<Button>().onClick.AddListener(() => _audioSource.Play());
        }
    }
}