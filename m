Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F042B982
	for <lists+cgroups@lfdr.de>; Mon, 27 May 2019 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfE0RrL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 May 2019 13:47:11 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:49643 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfE0RrL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 May 2019 13:47:11 -0400
Received: by mail-ua1-f73.google.com with SMTP id j43so3927527uae.16
        for <cgroups@vger.kernel.org>; Mon, 27 May 2019 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WabwXVWKHDF9Gj73vwc0I/pwrF46pP20FoOfyIilig8=;
        b=JwAG/FOCufiHwOPhwR/U8FpRywH60cnD+4+jDfx6S4A///ABXalQdR96p/DGNSiINt
         taQAVzi4ZWYDlppGDunCnKCNi5U8BJB8Ytw4L2DJRBZO1g1Re6PWcNpn6UDYZSUkQWkB
         IepdDzZx5Kgi7HIlAX8OeDAag68w+Znn93OZRx0meQF2zD2u7gKnDQxpsQZT9fK2gIWa
         mIY6D3mPHsyHG7SVQhl75Ss/FIBUzprB9kA/K4Wr7eWTYv+q+JrprJphWF2gcAp5fyg+
         mE+PUeHZzG74iVppBlJ7SW1XU4rhwK1VvZYszfeEqkhWJwngLRqmQhx8OrIDksadQBnd
         aZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WabwXVWKHDF9Gj73vwc0I/pwrF46pP20FoOfyIilig8=;
        b=H7fF2b+1i06zG2tvowwFBdpFHbxwPufI93Xe8pIYiSc2WXi63oCkuKm4UMvGEX3t0q
         eC6wj7HN5qjL8LCYfmkqDE16QlHpZWeYK7FSbyij/w8dh2CO5V6AUxZzoryKP9rixsij
         EO06gHZ7gmnBvQBIyoE/DWe4hFJn8AVIbKgsEDaLG4LcNSYHNxLkzfRKK3JPBY0sRfMg
         zjnxI9Bni3UgGD4weRtY/ZgDc7/VKWsPQ7t1wqPBGf8jjsN6TnGnlnkX6VZnjr8FD5KZ
         K3BswxQ8lJGwxhDHI6yfV+IP/BX/KEyPR4aFpG5xpzZ/KreE2Vlr5rj/+sVb/1nDjs5d
         lLhw==
X-Gm-Message-State: APjAAAW395H4WpJ057sJkuHy790f3iuCWSwfoM6PGIVcHijNNX5BFbhM
        DR1xXyEA/93vxSW44+vIxTox9eTHD6Ggyw==
X-Google-Smtp-Source: APXvYqxRk9l2Xm/VuGGKrKk6z1pZngrkZJw9tB+kHYOSMI90hyZqW/59RtYGljuqxAiUAnNldNNH4TeiKvMH4g==
X-Received: by 2002:ab0:28c9:: with SMTP id g9mr46031261uaq.73.1558979229956;
 Mon, 27 May 2019 10:47:09 -0700 (PDT)
Date:   Mon, 27 May 2019 10:46:43 -0700
Message-Id: <20190527174643.209172-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3] mm, memcg: introduce memory.events.local
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memory controller in cgroup v2 exposes memory.events file for each
memcg which shows the number of times events like low, high, max, oom
and oom_kill have happened for the whole tree rooted at that memcg.
Users can also poll or register notification to monitor the changes in
that file. Any event at any level of the tree rooted at memcg will
notify all the listeners along the path till root_mem_cgroup. There are
existing users which depend on this behavior.

However there are users which are only interested in the events
happening at a specific level of the memcg tree and not in the events in
the underlying tree rooted at that memcg. One such use-case is a
centralized resource monitor which can dynamically adjust the limits of
the jobs running on a system. The jobs can create their sub-hierarchy
for their own sub-tasks. The centralized monitor is only interested in
the events at the top level memcgs of the jobs as it can then act and
adjust the limits of the jobs. Using the current memory.events for such
centralized monitor is very inconvenient. The monitor will keep
receiving events which it is not interested and to find if the received
event is interesting, it has to read memory.event files of the next
level and compare it with the top level one. So, let's introduce
memory.events.local to the memcg which shows and notify for the events
at the memcg level.

Now, does memory.stat and memory.pressure need their local versions.
IMHO no due to the no internal process contraint of the cgroup v2. The
memory.stat file of the top level memcg of a job shows the stats and
vmevents of the whole tree. The local stats or vmevents of the top level
memcg will only change if there is a process running in that memcg but
v2 does not allow that. Similarly for memory.pressure there will not be
any process in the internal nodes and thus no chance of local pressure.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
Changelog since v2:
- Added documentation.

Changelog since v1:
- refactor memory_events_show to share between events and events.local

 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++
 include/linux/memcontrol.h              |  7 ++++-
 mm/memcontrol.c                         | 34 +++++++++++++++++--------
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 19c4e78666ff..0e961fc90cd9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1119,6 +1119,11 @@ PAGE_SIZE multiple when read back.
 	otherwise, a value change in this file generates a file
 	modified event.
 
+	Note that all fields in this file are hierarchical and the
+	file modified event can be generated due to an event down the
+	hierarchy. For for the local events at the cgroup level see
+	memory.events.local.
+
 	  low
 		The number of times the cgroup is reclaimed due to
 		high memory pressure even though its usage is under
@@ -1158,6 +1163,11 @@ PAGE_SIZE multiple when read back.
 		The number of processes belonging to this cgroup
 		killed by any kind of OOM killer.
 
+  memory.events.local
+	Similar to memory.events but the fields in the file are local
+	to the cgroup i.e. not hierarchical. The file modified event
+	generated on this file reflects only the local events.
+
   memory.stat
 	A read-only flat-keyed file which exists on non-root cgroups.
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 36bdfe8e5965..de77405eec46 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -239,8 +239,9 @@ struct mem_cgroup {
 	/* OOM-Killer disable */
 	int		oom_kill_disable;
 
-	/* memory.events */
+	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
+	struct cgroup_file events_local_file;
 
 	/* handle for "memory.swap.events" */
 	struct cgroup_file swap_events_file;
@@ -286,6 +287,7 @@ struct mem_cgroup {
 	atomic_long_t		vmevents_local[NR_VM_EVENT_ITEMS];
 
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
+	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
 	unsigned long		socket_pressure;
 
@@ -761,6 +763,9 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
+	atomic_long_inc(&memcg->memory_events_local[event]);
+	cgroup_file_notify(&memcg->events_local_file);
+
 	do {
 		atomic_long_inc(&memcg->memory_events[event]);
 		cgroup_file_notify(&memcg->events_file);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2713b45ec3f0..a57dfcc4c4a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5630,21 +5630,29 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
+{
+	seq_printf(m, "low %lu\n", atomic_long_read(&events[MEMCG_LOW]));
+	seq_printf(m, "high %lu\n", atomic_long_read(&events[MEMCG_HIGH]));
+	seq_printf(m, "max %lu\n", atomic_long_read(&events[MEMCG_MAX]));
+	seq_printf(m, "oom %lu\n", atomic_long_read(&events[MEMCG_OOM]));
+	seq_printf(m, "oom_kill %lu\n",
+		   atomic_long_read(&events[MEMCG_OOM_KILL]));
+}
+
 static int memory_events_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "low %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_LOW]));
-	seq_printf(m, "high %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_HIGH]));
-	seq_printf(m, "max %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_MAX]));
-	seq_printf(m, "oom %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_OOM]));
-	seq_printf(m, "oom_kill %lu\n",
-		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
+	__memory_events_show(m, memcg->memory_events);
+	return 0;
+}
+
+static int memory_events_local_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
+	__memory_events_show(m, memcg->memory_events_local);
 	return 0;
 }
 
@@ -5806,6 +5814,12 @@ static struct cftype memory_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, events_file),
 		.seq_show = memory_events_show,
 	},
+	{
+		.name = "events.local",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct mem_cgroup, events_local_file),
+		.seq_show = memory_events_local_show,
+	},
 	{
 		.name = "stat",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.22.0.rc1.257.g3120a18244-goog

