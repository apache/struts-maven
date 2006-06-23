/*
 * $Id: RequestUtils.java 394468 2006-04-16 12:16:03Z tmjee $
 *
 * Copyright 2006 The Apache Software Foundation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.myComp.myApp;

import junit.framework.TestCase;

import com.opensymphony.xwork.Action;

/**
 * 
 */
public class IndexActionTest extends TestCase {
    
    public void testIndexAction() throws Exception {
        IndexAction action = new IndexAction();
        String result = action.execute();
        assertEquals(Action.SUCCESS, result);
    }
}