using UnityEngine;

namespace BugCode
{
    public class MusicPlayer : MonoBehaviour
    {
        [SerializeField]
        private AudioSource _audioSource;
        [SerializeField]
        private AudioClip[] _tracks;
        private int _currentTrackIndex;

        private void Start()
        {
            PlayTrack(_currentTrackIndex);
        }

        public void SwitchEnable()
        {
            gameObject.SetActive(!gameObject.activeSelf);
        }

        private void PlayTrack(int trackIndex)
        {
            _audioSource.Stop();
            _audioSource.clip = _tracks[trackIndex];
            _audioSource.Play();
            _currentTrackIndex++;

            if (_currentTrackIndex >= _tracks.Length)
            {
                _currentTrackIndex = 0;
            }
        }

        private void Update()
        {
            if (!_audioSource.isPlaying)
            {
                PlayTrack(_currentTrackIndex);
            }
        }
    }
}