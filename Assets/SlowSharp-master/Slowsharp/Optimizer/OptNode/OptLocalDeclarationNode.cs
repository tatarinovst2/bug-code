﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Slowsharp
{
    internal struct OptLocalDeclarationNode : OptNodeBase
    {
        public HybType type;
        public bool isVar;
    }
}
