Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB3467B52
	for <lists+cgroups@lfdr.de>; Fri,  3 Dec 2021 17:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352911AbhLCQ2K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Dec 2021 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhLCQ2K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Dec 2021 11:28:10 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5335AC061751;
        Fri,  3 Dec 2021 08:24:46 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l8so3808891qtk.6;
        Fri, 03 Dec 2021 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMA0FwRsbKa8XEHQlou/tMRVIbGFsiozFUia1lQqx44=;
        b=JotK5rB5Id9ulOqmD/Pexs4DElrQW0yz1r8/r8rqXgtNglR0/3hIzYN7yHHRL330Xd
         cQQxNRjJQEzk6th5Kqrtx7HInxeu+M0Mum8gIkXD34G9KDJ62e50rBYkGxswmx5dgUee
         /kVFvzGHuZP62d6aBDM/G8FJQkngESqd5CVz7RA8lhGB/u3dV5ywDc9u6KzQiwDVczLP
         1bc75km9MsBJWzTVM8s+n5v2z5lbi8eNdvECP9abcgvmikohlmnXoDoEmiZc82bvDlJ5
         JXh434sWhWSjpEZctJHdknmRXFKTm6Z0cX01THb6hRtuFwNZAwPAb+PcbD4mMnnFpam8
         uNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMA0FwRsbKa8XEHQlou/tMRVIbGFsiozFUia1lQqx44=;
        b=VpxwyrXsiI1tIerfL/lH9WQ2skUU0pbfTwBSLsXBoUvyMTfm/+luUkFrF5d9UJUcTt
         fxzLNzW6V3GlJop/oeNP6wNoRcjaVjTCBh6ebA5u26PHbIXLb3wNKNTzlJLnIChhw2GF
         AV0KIW0gjh3RWmar1fNbdbbksKwyF2zs6bi/YcKelXr6Xuhk7D/aRzYOBZbPoEQ5GJKS
         AgMxbyrn08D/mmSb8u0uwZzZrnBEX5SGQpoZQhr/GznvXhjkA54u77x0nx5S2PtQpqsU
         TNE0Gr9pjupYQuHxHDa2ljK6C+feikf3alvrrViuqguKQD3Ck42+Is1CWnqZdSofkvnz
         fblQ==
X-Gm-Message-State: AOAM530JCTh66SiMJNpf7IWXWtibbUuELj2T7+pHt2r62iwl+7TPtTjc
        97RMbM1b/huA/dhklcibExw=
X-Google-Smtp-Source: ABdhPJx9hBtUy3zW+sJpdntlHvakHD04U0OiGAx1hflDTQiL3DarIPQF0IWxK8s8/cqFeF67zmvt6A==
X-Received: by 2002:a05:622a:307:: with SMTP id q7mr21839822qtw.330.1638548685441;
        Fri, 03 Dec 2021 08:24:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:285c])
        by smtp.gmail.com with ESMTPSA id g14sm2435522qko.55.2021.12.03.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 08:24:44 -0800 (PST)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH] mm: add group_oom_kill memory event
Date:   Fri,  3 Dec 2021 08:24:23 -0800
Message-Id: <20211203162426.3375036-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Our container agent wants to know when a container exits if it was OOM
killed or not to report to the user. We use memory.oom.group = 1 to
ensure that OOM kills within the container's cgroup kill
everything. Existing memory.events are insufficient for knowing if
this triggered:

1) Our current approach reads memory.events oom_kill and reports the
container was killed if the value is non-zero. This is erroneous in
some cases where containers create their children cgroups with
memory.oom.group=1 as such OOM kills will get counted against the
container cgroup's oom_kill counter despite not actually OOM killing
the entire container.

2) Reading memory.events.local will fail to identify OOM kills in leaf
cgroups (that don't set memory.oom.group) within the container cgroup.

This patch adds a new oom_group_kill event when memory.oom.group
triggers to allow userspace to cleanly identify when an entire cgroup
is oom killed.

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 include/linux/memcontrol.h              | 1 +
 mm/memcontrol.c                         | 5 +++++
 mm/oom_kill.c                           | 1 +
 4 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2aeb7ae8b393..eec830ce2068 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1268,6 +1268,10 @@ PAGE_SIZE multiple when read back.
 		The number of processes belonging to this cgroup
 		killed by any kind of OOM killer.
 
+          oom_group_kill
+                The number of times all tasks in the cgroup were killed
+                due to memory.oom.group.
+
   memory.events.local
 	Similar to memory.events but the fields in the file are local
 	to the cgroup i.e. not hierarchical. The file modified event
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403f4be6..951f24f42147 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -42,6 +42,7 @@ enum memcg_memory_event {
 	MEMCG_MAX,
 	MEMCG_OOM,
 	MEMCG_OOM_KILL,
+	MEMCG_OOM_GROUP_KILL,
 	MEMCG_SWAP_HIGH,
 	MEMCG_SWAP_MAX,
 	MEMCG_SWAP_FAIL,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6863a834ed42..5ab3b9ce90de 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4390,6 +4390,9 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
 	seq_printf(sf, "oom_kill %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
+	seq_printf(sf, "oom_group_kill %lu\n",
+		   atomic_long_read(
+			&memcg->memory_events[MEMCG_OOM_GROUP_KILL]));
 	return 0;
 }
 
@@ -6307,6 +6310,8 @@ static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 	seq_printf(m, "oom %lu\n", atomic_long_read(&events[MEMCG_OOM]));
 	seq_printf(m, "oom_kill %lu\n",
 		   atomic_long_read(&events[MEMCG_OOM_KILL]));
+	seq_printf(m, "oom_group_kill %lu\n",
+		   atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
 }
 
 static int memory_events_show(struct seq_file *m, void *v)
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..e52ce0b1465d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -994,6 +994,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * If necessary, kill all tasks in the selected memory cgroup.
 	 */
 	if (oom_group) {
+		memcg_memory_event(oom_group, MEMCG_OOM_GROUP_KILL);
 		mem_cgroup_print_oom_group(oom_group);
 		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member,
 				      (void *)message);
-- 
2.30.2

