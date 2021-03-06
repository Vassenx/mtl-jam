﻿using System.Collections.Generic;
using UnityEngine;

namespace Assets.Scripts
{
    class GameEvent
    {
        private bool Flag;
        private int Counter;
        private int Thresh;
        private string EventName;
        public delegate void FlagHasChanged();
        public event FlagHasChanged flagHasChanged;

        public GameEvent(string name, int threshold, List<GameItem> myItems)
        {
            Flag = false;
            Counter = 0;
            Thresh = threshold;
            EventName = name;
            if(myItems != null)
            {
                foreach (GameItem item in myItems)
                {
                    item.collectedHasChanged += IncCounter;
                }
            }
        }

        public void IncCounter()
        {
            //probably should unsub to avoid memory leaks
            Counter++;
            if(Counter>=Thresh && !Flag)
            {
                Flag = true;
                Debug.Log("You have " + EventName);
                if(flagHasChanged != null)
                    flagHasChanged();
            }
        }

    }
}
