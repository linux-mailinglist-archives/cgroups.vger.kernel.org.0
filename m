Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F344F06C1
	for <lists+cgroups@lfdr.de>; Sun,  3 Apr 2022 04:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiDCCKn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Apr 2022 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDCCKm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Apr 2022 22:10:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B01AF0F
        for <cgroups@vger.kernel.org>; Sat,  2 Apr 2022 19:08:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dr20so13290956ejc.6
        for <cgroups@vger.kernel.org>; Sat, 02 Apr 2022 19:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=C7M3sxnNh9ju9tb2x0yLZLDmlvAi9UQAlTWRcM/JN90=;
        b=iw1q4VQH1xO+kN+VCt9RffVSCNxDWS53ujTgERnK+15z2eisOdiIC7FaCeeWhxumRi
         Tbx2nAEMNJj7OdLQQYC6hr2oMKRnVDUtVyvRAzYV6gnzpsVSS+xfiTcE/0acVLcxwqy9
         SONTxEpBrvtds2Lxz+Zh8zmGvWmkClCwiOS4QGpAB6ssxp5AdbC09+EeB9Y8kVAL4U25
         Fc3NLRSS4OI6B5++JH22GH3nnm7ZOlx/2n84xGBg8NNey7eG078CslnwvBzweEPzohKf
         LuVCEtvp3zA8lMQKUah3SB68McfJNek0VUc+lxRkfxjKHdntX4e0bjdDXZizwM46EYe9
         2TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C7M3sxnNh9ju9tb2x0yLZLDmlvAi9UQAlTWRcM/JN90=;
        b=sg16iKNsLHOXlwgI6JoErxv05FVKunjP0XTy8+ffc+PD/LNUGcm9e/XoS83d7zMDZj
         a1klBJ7ueu7qsmVArXj1Jgy0kHp307QhN3LPrlc6tViqMk5hCea+5EuaIBXUNZ/K+t2+
         K7p9AUyMJYOdtB9gl2cfC/AbGstT/bIqRZMCweesffOgwBCfv+gjlH7mt7gyulLLFX2o
         ulv8hnylTBkYeBpLD23xL9Kgh4Xve7XPi+S/2rGKMQCUfnnSjEeX6k8V23Ei/G+V4vNz
         PyxhL4MA1Ba2/I8/7T8uF4Gnr8ATamC2e1mbNbMVoGgBwHfcPvGr3+Jrgu2yGK/8IeEA
         3MOA==
X-Gm-Message-State: AOAM530fum54msRNnnbUNPFZLksDYwN/GUdqswPxP+qoqVeA/JpJKm3M
        q0l6wUkJHyFldLDIMUiVzYo=
X-Google-Smtp-Source: ABdhPJzPihh5MnM9zl87IEzyXxnubntZliOJ1aSl0fp3Aq0FzR0SpueXYx0GhjTzS6VRJ52xxVrtrA==
X-Received: by 2002:a17:906:ae0b:b0:6df:c7d6:9235 with SMTP id le11-20020a170906ae0b00b006dfc7d69235mr5708345ejb.664.1648951727733;
        Sat, 02 Apr 2022 19:08:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090654cd00b006e0db351d01sm2692639ejp.124.2022.04.02.19.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Apr 2022 19:08:47 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] mm/memcg: non-hierarchical mode is deprecated
Date:   Sun,  3 Apr 2022 02:08:33 +0000
Message-Id: <20220403020833.26164-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
mode"), we won't have a NULL parent except root_mem_cgroup. And this
case is handled when (memcg == root).

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Roman Gushchin <roman.gushchin@linux.dev>
CC: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2cd8bfdec379..3ceb9b8592b1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6587,9 +6587,6 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 		return;
 
 	parent = parent_mem_cgroup(memcg);
-	/* No parent means a non-hierarchical mode on v1 memcg */
-	if (!parent)
-		return;
 
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
-- 
2.33.1

