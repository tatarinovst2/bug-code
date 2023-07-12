﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Threading.Tasks;

namespace Slowsharp
{
    internal class TypeResolver
    {
        private RunContext Ctx;
        private Assembly[] Assemblies;

        private TypeCache TypeCache;

        public TypeResolver(RunContext ctx, Assembly[] assemblies)
        {
            this.Ctx = ctx;
            this.Assemblies = assemblies;

            this.TypeCache = new TypeCache(ctx, assemblies);
        }

        public void AddLookupNamespace(string ns)
        {
            TypeCache.AddLookupNamespace(ns);
        }

        public void CacheType(Type type)
        {
            if (type == null)
                throw new ArgumentNullException(nameof(type));

            TypeCache.CacheType(type);
        }

        private bool IsGeneric(string id)
        {
            return id.Count(x => x == '<') != 0;
        }
        private int GetArrayRank(string id)
        {
            if (!(id.Contains("[") && id.Contains("]")))
                return 0;
            return id.Count(x => x == ',') + 1;
        }

        /// <summary>
        /// Retrives a pure name which does not contains 
        /// generic or array symbols.
        /// </summary>
        private string GetPureName(string id)
        {
            if (id.Contains("<"))
                return id.Split('<')[0];
            if (id.Contains("["))
                return id.Split('[')[0];
            return id;
        }
        /// <summary>
        /// Retrives signature name which is compatible with .Net
        /// </summary>
        private string GetSignatureName(string id, out string[] genericArgs)
        {
            if (id.Contains("<"))
            {
                int depth = 0;
                var count = 0;
                var args = new List<string>();
                var offset = 0;

                for (int i = 0; i < id.Length; i++)
                {
                    if (id[i] == '<')
                    {
                        depth++;
                        if (depth == 1)
                            offset = i + 1;
                    }
                    if (id[i] == '>')
                    {
                        depth--;
                        if (depth == 0)
                            args.Add(id.Substring(offset, i - offset).Trim());
                    }

                    if (depth == 1 && id[i] == ',')
                    {
                        count++;
                        args.Add(id.Substring(offset, i - offset).Trim());
                        offset = i + 1;
                    }
                }

                genericArgs = args.ToArray();
                return $"{GetPureName(id)}`{count + 1}";
            }

            genericArgs = null;
            return id;
        }

        public virtual bool TryGetType(string id, out HybType type, Assembly hintAssembly = null)
        {
            var sig = GetPureName(id);
            var rank = GetArrayRank(id);
            var isGeneric = IsGeneric(id);
            string[] genericArgs = null;

            if (isGeneric)
                sig = GetSignatureName(id, out genericArgs);

            type = TypeCache.GetType(sig, hintAssembly);
            if (type == null)
                return false;    

            var ac = Ctx.Config.AccessControl;
            if (ac.IsSafeType(type) == false)
                throw new SandboxException($"{id} is not allowed to use.");

            if (isGeneric)
            {
                var genericArgTypes = new HybType[genericArgs.Length];
                for (int i = 0; i < genericArgTypes.Length; i++)
                    genericArgTypes[i] = GetType(genericArgs[i]);
                type = type.MakeGenericType(genericArgTypes);
            }
            if (rank > 0)
                type = type.MakeArrayType(rank);

            return true;
        }
        public virtual HybType GetType(string id)
        {
            HybType type;
            if (TryGetType(id, out type))
                return type;

            throw new SemanticViolationException($"Unrecognized type {id}");
        }
        
        public virtual HybType GetGenericType(string id, int n)
        {
            id = $"{id}`{n}";

            foreach (var asm in Assemblies)
            {
                foreach (var type in asm.GetTypesSafe())
                {
                    if (type.Name.Split('[')[0] == id)
                        return HybTypeCache.GetHybType(type);
                    if (type.FullName.Split('[')[0] == id)
                        return HybTypeCache.GetHybType(type);
                }
            }

            return null;
        }
    }
}