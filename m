Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22664731A9
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbhLMQZz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbhLMQZx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 11:25:53 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AB0C061574;
        Mon, 13 Dec 2021 08:25:53 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id jo22so14814345qvb.13;
        Mon, 13 Dec 2021 08:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nu0e3REkbFkXwUCLY/t28Mz7Y046BFRzaKZrlwttw5A=;
        b=AfF1bilD8S8n3fyC8TdgEVD0nCb7TFtTyXL6lV8hjUsZ43EkGsaTXH7JrcGFrJkKad
         Pr2F3aZ53Yy/fyREFZeLULo93p539ZBfTtBZjVqZ1KeD3hDw1e6tPh1RNnrPJdQ9rfAZ
         4eOT9ab3ciHjBYtgmCBOLE4ed8/N7ROJsj8Ie9VazehcR+BLwFGsmxQ1anpdx/4KuYcm
         IdSWnsHSGBgRuNtedTLPapppi4nGCMmz2U6RFYFbitW+LXWCSvvalTKzfRxpBi5BMbnZ
         rXxBOzMs0F6BVaxF29XfcggrKFOPc0TptUvhh+TjJo1Qz5rqFYhzM6GRQyQBGAUeI9un
         1QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nu0e3REkbFkXwUCLY/t28Mz7Y046BFRzaKZrlwttw5A=;
        b=qKpgRi3EAbJ5OEpzJ9S/sV9klQZlIZBy7/S6zOo4/7nm2hc0EaHzyDeQ/9hzg18rP4
         7Ahc02izfrKmdZBmiSPapECoZJgly2TuKjxib4snnzgNvBkVQddHxDIvXAynaonS4+ea
         WKJlt8vzVCd84+L8ohx15kts/SmHtVmwjqF5Yw/9afBEbBEXByVoCge261gvuCXUQkkB
         y8eBy1ogWA14aNqdmaW0yIHO3yVNoU7iXNmh9rzAr9VlZSH/dCHolRe/5CS6QQu1HN7H
         oEB1NA9Fg3dhmzG+fg+rjYEAijIhqJu0SweZSif6D/1DUne89gWP3kKgWItjV9TKnrqz
         MBgQ==
X-Gm-Message-State: AOAM532gj7a+sz23P4HHZQFyeI9sVmPRgxMwTlTNbKfuN/EdRBozN/Ah
        anTtvtFjy2/rSZaZMhKsDa8=
X-Google-Smtp-Source: ABdhPJxGAgKYzBWVUtbmLXtj3Lh4MxUnmxMXzwDBqvwT/sapc4nAy4QeBUtdOyseR2y2m1las0eFyg==
X-Received: by 2002:a0c:f34d:: with SMTP id e13mr44354703qvm.119.1639412752642;
        Mon, 13 Dec 2021 08:25:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:42c0])
        by smtp.gmail.com with ESMTPSA id l22sm9262859qtj.68.2021.12.13.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:25:52 -0800 (PST)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH] mm: add group_oom_kill memory.event fix
Date:   Mon, 13 Dec 2021 08:25:10 -0800
Message-Id: <20211213162511.2492267-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrew, could you please amend the prior patch "mm: add group_oom_kill
memory.event" with these changes from Johannes and Chris?

Also - small nit: it makes better sense to
s/group_oom_kill/oom_group_kill/g in the patch title.

Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Chris Down <chris@chrisdown.name>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 3 +--
 mm/memcontrol.c                         | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index eec830ce2068..8269bfa240f4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1269,8 +1269,7 @@ PAGE_SIZE multiple when read back.
 		killed by any kind of OOM killer.
 
           oom_group_kill
-                The number of times all tasks in the cgroup were killed
-                due to memory.oom.group.
+                The number of times a group OOM has occurred.
 
   memory.events.local
 	Similar to memory.events but the fields in the file are local
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5ab3b9ce90de..b5454d8fc344 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4390,9 +4390,6 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
 	seq_printf(sf, "oom_kill %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
-	seq_printf(sf, "oom_group_kill %lu\n",
-		   atomic_long_read(
-			&memcg->memory_events[MEMCG_OOM_GROUP_KILL]));
 	return 0;
 }
 
-- 
2.30.2

