Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35082220DF
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2019 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfERAS0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 20:18:26 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:43619 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfERAS0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 20:18:26 -0400
Received: by mail-qt1-f202.google.com with SMTP id q32so8077906qtk.10
        for <cgroups@vger.kernel.org>; Fri, 17 May 2019 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qkDr2UAFkscvX8ezXGKmGGmc+dl6f/FAMKwyKcz0Ozc=;
        b=QI3CMrbUSisbO3F4zPF1hI/gUiK8dDCRjfX1TsAw9fftIwjnK8TdYw9nsLJY+RumM7
         Shb9J86yo+n5aXxg08eiEqZj+2z9qtyWZZf7Tpv3HzS5PRcNpiIGroILaSRAMUzE9Dzh
         kVb8DvXdY9osu7DCtFy07wfSZzUCDwO0B7L2gRNjrgKvc+pUzdBc9TTYDb3H+uw5c31O
         4WDfAt3UWxQtKDB3C5AoRY4WnPyNHBQgtUUhRMKQdjs8CEz6bIrXQF+O0EBBG6tjURat
         PomO6vvTPD6Sch2zcwASVvtsnQ3dhWAfNTYq9HRAlrpqLUGzo0UNA6yQgo8+kwneUm74
         fPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qkDr2UAFkscvX8ezXGKmGGmc+dl6f/FAMKwyKcz0Ozc=;
        b=heT8MM9kkEPYvhVh5C0/pMUSv9XQ0xP7swFaHZohdvUYaZnoYLTFSLIfmLNRZHcbYb
         GMpHJAde2a6bH+2O06AmmlVVESExsnicWkQh9v5Yxh+KYZo6vHc2e5cVWYSAbL/UAT2x
         ctWzryNQXg3yYcB48/CoG3ztbaFCVoQ/HrEiTloRSay7Mjn9Jfp5he+Vdfek0ALFNu1T
         ZZKgI04I9x7RsuMaOujh6thh5ACVVye07ffpiU3qYVjBCCsESG2hzCbVfiD1CqViWqoD
         gjqwB1iJebRIYavao6wrvo/BRpNIjTPJR+lPSovsdUhe9CZmC/7osJVajDlNwU8yxXyq
         gNUA==
X-Gm-Message-State: APjAAAVm9q5D38ojMrZh/4FRSEKoVpzet5TA4M6u8o+vLzzP4l81Y+Ku
        TZ7lE7VU4xZe3ARbagSop8XQOQ3Duj3yvA==
X-Google-Smtp-Source: APXvYqzjvHIrSFCW8O8i+BzHoGWkysNM/KdQQ3zDtRn0LUwcgEMg0FCe79ufJdlJrN78yJCcMfe/ggmKl62N5A==
X-Received: by 2002:ac8:2817:: with SMTP id 23mr16045714qtq.174.1558138704651;
 Fri, 17 May 2019 17:18:24 -0700 (PDT)
Date:   Fri, 17 May 2019 17:18:18 -0700
Message-Id: <20190518001818.193336-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2] mm, memcg: introduce memory.events.local
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
---
Changelog since v1:
- refactor memory_events_show to share between events and events.local

 include/linux/memcontrol.h |  7 ++++++-
 mm/memcontrol.c            | 34 ++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 11 deletions(-)

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
2.21.0.1020.gf2820cf01a-goog

