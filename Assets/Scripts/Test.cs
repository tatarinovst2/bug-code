using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Interpreter;
using Unity.VisualScripting;

namespace BugCode
{
    public class Test : MonoBehaviour
    {
        void Start()
        {
            var log_settings = new Script.LogSettings();
            log_settings.print_tokens = true;
            log_settings.print_intermediate_code = true;
            log_settings.print_statements = true;

            string source_code = "a = 1\n" +
                                 "b = 3\n" +
                                 "c = a + b\n";

            var script = new Script(source_code, log_settings);

            var run_time = new RunTime(script);
            run_time.run();

            Debug.Log("Finished");
        }

        void Update()
        {

        }
    }
}