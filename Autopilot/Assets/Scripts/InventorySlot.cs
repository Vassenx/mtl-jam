﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI; 

public class InventorySlot : MonoBehaviour
{
    public Image icon;

    GameItem item; 
    
    public void AddItem (GameItem newItem)
    {
        item = newItem;

        icon.sprite = item.Icon;
        icon.enabled = true; 
    }

    public void ClearSlot()
    {
        item = null;

        icon.sprite = null;
        icon.enabled = false; 
    }
}
