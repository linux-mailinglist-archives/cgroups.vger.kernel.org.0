Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAB32328E
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 21:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBWU5T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 15:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhBWU5S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 15:57:18 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9BC06174A
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 12:56:36 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z9so10757169plg.19
        for <cgroups@vger.kernel.org>; Tue, 23 Feb 2021 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VjQqR/dV9CmTvhJpIjv+GuV8z4P1stvvAwZgqfJoGxA=;
        b=mbSLgPRCosw1LgNbfZCQnOf60JkRnE/oZ2dfceOMIrdTSFDoq5FVwWZlenlEN3duNu
         LohQcoryhXyJfYxvHKWMDVRZhlyTZN7TguKnQS+JgyeHcABPQA1vfuCU7zw9y6PF1NOv
         vGNMRvc4MSRHE6B10Jeh5MZeB0RSzfOZyOgAKPzC3jN/FH0WswJOXI6mLvbQZC2XS8eW
         CD7xkAu51CFETtgUy622hl5ARPc+8WRj+WqSjXWQPSYcsO4OkXu6hPon8zk01OvAKWke
         aFpjOavUMmudXnqIgS/YEaSbEtC8nBwWU4YEvd78Nyscbp3L6S+HxqkqJOSntxdwCHId
         MHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VjQqR/dV9CmTvhJpIjv+GuV8z4P1stvvAwZgqfJoGxA=;
        b=Wq2R/Sc86ZWI/WhwlAvqaRzVkdqS8oLGDeTxUFZX27juD79wpmBDvMyBAMjCSFlZ3P
         SHuwQT20ALbKczs0/kStUcORh8JrnII+c0t1sL+LOuzA4+cXKrgq4G9Dn2vUcUoMidX2
         T6JHtUla8b3CMXfVk+80AiZdy6xLwhcVAG8uAWnb2AfwGenrNAVkqOeM4qBa8NBLfIc0
         A1fHQcHlsvr0Eq9mtkaa+4uuZ0m3ro+eMGvI6EvcqC3XVB+7qlaGCesC5e/9e9p9QNkV
         uMZ3EOLB5mzhHOV+YovXWNr0bWwKXuEWnH3useq0N9CfA/j/YtmV6X78m+nUE7dmlvGR
         WPCg==
X-Gm-Message-State: AOAM533TPon+GSwycmIecejDo1T6e8+FGmke9Gdn45UXKsWHjSjbX9IO
        +i1I5SZKfRWqhst3dh36sWTRDv8NU3tDLA==
X-Google-Smtp-Source: ABdhPJwty35ymd10NafwoqU0YOhxPbcs9qNH9tWIjjldDeiHkjvYzVWjgVg+F5/TZM+guUKIA4j6kxGHHK/4sw==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:8ccd:3283:c85b:61eb])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:ab8b:: with SMTP id
 n11mr607117pjq.85.1614113794713; Tue, 23 Feb 2021 12:56:34 -0800 (PST)
Date:   Tue, 23 Feb 2021 12:56:25 -0800
Message-Id: <20210223205625.2792891-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] memcg: cleanup root memcg checks
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace the implicit checking of root memcg with explicit root memcg
checking i.e. !css->parent with mem_cgroup_is_root().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dcb5665aeb69..79046ad3eec0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4141,7 +4141,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	if (val > 100)
 		return -EINVAL;
 
-	if (css->parent)
+	if (!mem_cgroup_is_root(memcg))
 		memcg->swappiness = val;
 	else
 		vm_swappiness = val;
@@ -4491,7 +4491,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	/* cannot set to root cgroup and only 0 and 1 are allowed */
-	if (!css->parent || !((val == 0) || (val == 1)))
+	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
 		return -EINVAL;
 
 	memcg->oom_kill_disable = val;
-- 
2.30.0.617.g56c4b15f3c-goog

