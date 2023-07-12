using System.Collections.Generic;

class Solution
{
    private Dictionary<string, string> database = new Dictionary<string, string>()
    {
        { "Cat", "Iamacat2015_" },
        { "Dog", "woof_1" }
    };

    private bool CanLogin(string nickname, string password)
    {
        if (!database.ContainsKey(nickname))
        {
            return false;
        }
        if (database[nickname] != password)
        {
            return false;
        }
        return true;
    }
}