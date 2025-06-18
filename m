Return-Path: <cgroups+bounces-8586-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED60ADEA92
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 13:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9863B03F5
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B82E7167;
	Wed, 18 Jun 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LJZrP7pI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B122E54C9
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246817; cv=none; b=k+ud/3Y99CXYs3dsgVlXrgW08Rb5hSyeZPG4gID7b9142+Ua9GhQQh09uSH5WeZINk4dzfXaVY0NeWIvWGnDJGdv5LPSC+Fks3FWTPD3wOKarKwwFuLqufd/45uqVOVLA02MQNdCUYsq7RMfJfYrsygQYTpMpMr742YCFXJ2cGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246817; c=relaxed/simple;
	bh=Xb9FRJ1k9/RgyNy96wCFBU7lT5iVvfOPQD9LIgtzIs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDafkMZEeIpNXo/bokkutBsUnEP7ehsCcpQK2EvY3LTfSR6L0U/1MIh5maLTUZyUd48MiCXryBF6TFkxp+YZERc/f+Ma+bwIZtw7BsQy/Vz++uqPflvhjpGW7TtPgeY3eTMdswTe7Bu9JkUa1hxGk/e2jIiM4U4Xjx0/2BBO3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LJZrP7pI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso5066984b3a.3
        for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750246815; x=1750851615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkTX8VbuGGj597vY5glMjecPEtow6yPHbqWGQcHvVXM=;
        b=LJZrP7pI9QjZ4RduBK4aJ8z3DDwZrFx9oZV05/98JybONsYWtAEuhhfbK4JhUbYF1w
         sJB28b53ULUYNFmQ9b3ITvAY980yblMvtAq3I91othL5My1+iBQbFht1Ymjne2z970HP
         j8LfO6ZfuTnktN03uYBVGqTkuh35Z1/OIf8izdtXX1OPvwDd+PdHoftWrAl8ozBoqMez
         7lRiBIN9dtEbK2XQTLFEuoeMqeBRqMRyJyh9A/v+vpqdiwFpWZgdnjb5QCiD/29PAV34
         hBeh+zSaiyoLVkFNEXKdqRUKpXVMwP0Su/tqusz4AzMKM8PdO6Gl8C0ynlP+XiuNsJAT
         zHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750246815; x=1750851615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkTX8VbuGGj597vY5glMjecPEtow6yPHbqWGQcHvVXM=;
        b=S+B4DH4KmqIldpvbS1l+r62OrZQsZ51rYybZ3kx6aVHMS00l+fN3qxcJyrLmeVsQZF
         wnGf0QAxfnKZvrYGnIDc7uLWiDg2aTYtQb0VAX3xFz+jzfbf3HaucJwRpT5bGJkgmYYK
         iXfKZ7/QRtPJzm9TPI5KCYdIdzPPsGGlx7iuFC+DwMLCwRD58ONF3M+FU2b/FRmoaft0
         8RLo43y/VYFd/Kzgs5QXDQv/uchgHEam0oeqmUUS173SGO8jZpJgpI4wSrrBReq0C4bO
         mfzakVfXiOGoIJCC1RyoEe8nzrSQXK93mCji6s0qDoM+xGJf2qWc9cTSEmdbFtRHcCYQ
         UMKw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8LCu/cFE1Hn9FbP5dJQbTWn2jajhgNpHiBdc9JKjsnXfQzIlXaH773YTrz52ohR3DA2K8wM+@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2CtREZejSK/cpAg9PPkq1BJFHbs/2Z4qBXX9CtxsMOPzqXNU
	6ODHhn2cDIQ+uPzf2bndby9uzrGV4QoZ+aOPkOwSnutrLTgBCNGLuILoqtGh23wKA8s=
X-Gm-Gg: ASbGncsaDVhyWcXfOaKbY/hHvRe30sR58UKXkZtOppqqIrbWt9bam7nbFQFe+JqXoQe
	U2Wql5OX2oQ0EKM7OZjrFhzZclylLrvENBkz/cP1HIfupJQOqzVFSL2LmT0ocsOQDhsSuW92ADj
	z/7NpntBa9gxQf1oPHefSZEAqC6V6KSjiMoJMe9mg/IGuPNAhUAWJ+75dy2ZoZGQK2zSmsVwcLP
	fMqDRYqsGo8k076jSnPPyP+NphcIj8f2GXVIiZ/9yU+iUDM64ja+jn2pn4JgWYIFMckAJiIteIB
	DF+XK1wVo75M1mrXYW3VfMCX1sKrndG2/yhX3pHv8lnwFrhxW2mjiD3RILPWvN1jo7JXkqqUMVZ
	fgB5pIQz6+EU=
X-Google-Smtp-Source: AGHT+IHx+f2uetLjHgLndzyr0DIrDMXBz9wsvE8F730aaCeLlsGyoMf6MjcYSfWfha0j1fHQJ33mWQ==
X-Received: by 2002:a05:6a00:9087:b0:748:e5a0:aa77 with SMTP id d2e1a72fcca58-748e5a0b2c2mr3471714b3a.13.1750246814598;
        Wed, 18 Jun 2025 04:40:14 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900e3a09sm10683148b3a.180.2025.06.18.04.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:40:13 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	tytso@mit.edu,
	jack@suse.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: muchun.song@linux.dev,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/2] mm: memcg: introduce PF_MEMALLOC_ACCOUNTFORCE to postpone reclaim to return-to-userland path
Date: Wed, 18 Jun 2025 19:39:57 +0800
Message-Id: <71a4bbc284048ceb38eaac53dfa1031f92ac52b7.1750234270.git.hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
References: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PF_MEMALLOC_ACCOUNTFORCE ensures that memory allocations are forced
to be accounted to the memory cgroup, even if they exceed the cgroup's
maximum limit. In such cases, the reclaim process is postponed until
the task returns to userland. This is beneficial for users who perform
over-max reclaim while holding multiple locks or other resources
(Especially resources related to file system writeback). If a task
needs any of these resources, it would otherwise have to wait until
the other task completes reclaim and releases the resources. Postponing
reclaim to the return-to-userland path helps avoid this issue.

We have long been experiencing an issue where, if a task
holds the jbd2 handler and then enters direct reclaim due
to hitting the hard limit in a memory cgroup, the system
can become blocked for an extended period of time.
The stack trace is as follows:

0 [] __schedule at
1 [] preempt_schedule_common at
2 [] __cond_resched at
3 [] shrink_active_list at
4 [] shrink_lruvec at
5 [] shrink_node at
6 [] do_try_to_free_pages at
7 [] try_to_free_mem_cgroup_pages at
8 [] try_charge_memcg at
9 [] charge_memcg at
10 [] __mem_cgroup_charge at
11 [] __add_to_page_cache_locked at
12 [] add_to_page_cache_lru at
13 [] pagecache_get_page at
14 [] __getblk_gfp at
15 [] __ext4_get_inode_loc at  [ext4]
16 [] ext4_get_inode_loc at  [ext4]
17 [] ext4_reserve_inode_write at  [ext4]
18 [] __ext4_mark_inode_dirty at  [ext4]
19 [] __ext4_new_inode at  [ext4]
20 [] ext4_create at  [ext4]

struct scan_control {
  nr_to_reclaim = 32,
  order = 0 '\000',
  priority = 1 '\001',
  reclaim_idx = 4 '\004',
  gfp_mask = 17861706,
  nr_scanned = 27810,
  nr_reclaimed = 0,
  nr = {
    dirty = 27797,
    unqueued_dirty = 27797,
    congested = 0,
    writeback = 0,
    immediate = 0,
    file_taken = 27810,
    taken = 27810
  },
}
The direct reclaim in memcg is unable to flush dirty pages
and ends up looping with the jbd2 handler. As a result,
other tasks are blocked from writing pages that require
the jbd2 handler.

Furthermore, we observed that the memory usage far exceeds
the configured memory max, reaching around 38GB.
Max  : 134896020    514 GB
usage: 144747169    552 GB
We investigated this issue and identified the root cause:

try_charge_memcg:
    retry charge
        charge failed
          -> direct reclaim  nr_retries--
           -> memcg_oom   true-> reset the nr_retries
            -> retry charge
In this cases, the OOM killer selects a task and returns
success, and retry charge. but that task does not acknowledge
the SIGKILL signal because it is stuck in an uninterruptible
state. As a result, the current task gets stuck in a long
retry loop inside direct reclaim.

Why are there so many uninterruptible (D) state tasks?
Check the most common stack.

 __state = 2
PID: 992582   TASK: ffff8c53a15b3080  CPU: 40   COMMAND: "xx"
0 [] __schedule at ffffffff97abc6c9
1 [] schedule at ffffffff97abcd01
2 [] schedule_preempt_disabled at ffffffff97abdf1a
3 [] rwsem_down_read_slowpath at ffffffff97ac05bf
4 [] down_read at ffffffff97ac06b1
5 [] do_user_addr_fault at ffffffff9727f1e7
6 [] exc_page_fault at ffffffff97ab286e
7 [] asm_exc_page_fault at ffffffff97c00d42

Check the owner of mm_struct.mmap_lock; the current task is
waiting on lruvec->lru_lock. There are 68 tasks in this group,
with 23 of them in the shrink page context.

5 [] native_queued_spin_lock_slowpath at ffffffff972fce02
6 [] _raw_spin_lock_irq at ffffffff97ac3bb1
7 [] shrink_active_list at ffffffff9744dd46
8 [] shrink_lruvec at ffffffff97451407
9 [] shrink_node at ffffffff974517c9
10 [] do_try_to_free_pages at ffffffff97451dae
11 [] try_to_free_mem_cgroup_pages at ffffffff974542b8
12 [] try_charge_memcg at ffffffff974f0ede
13 [] obj_cgroup_charge_pages at ffffffff974f1dae
14 [] obj_cgroup_charge at ffffffff974f2fc2
15 [] kmem_cache_alloc at ffffffff974d054c
16 [] vm_area_dup at ffffffff972923f1
17 [] __split_vma at ffffffff97486c16

Many tasks enter a memory shrinking loop in UN state, other threads
blocked on mmap_lock. Although the OOM killer selects a victim,
it cannot terminate it. The task holding the jbd2 handle retries
memory charge, which fails, and reclaim continues with the handle
held. write_pages also fails waiting for jbd2, causing repeated
shrink failures and potentially leading to a system-wide block.

ps | grep UN | wc -l
1463
While the system has 1463 UN state tasks, so the way to break
this akin to "deadlock" is to let the thread holding jbd2 handler
quickly exit the memory reclamation process.

We found that a related issue has been reported and partially
addressed in previous fixes [1][2]. However, those fixes only
skip direct reclaim and return a failure for some cases like
readahead requests. Since sb_getblk() is called multiple times
in __ext4_get_inode_loc() with the NOFAIL flag, the problem
still persists.

With this patch, we can force the memory charge and defer
direct reclaim until the task returns to user space. By doing
so, all global resources such as the jbd2 handler will be
released, provided that if __GFP_ACCOUNT_FORCE flag is set.

Why not combine  __GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM to bypass
direct reclaim and force charge success?

Because we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
otherwise, we may result in lockup.[3], Besides, the flag
__GFP_DIRECT_RECLAIM is useful in global memory reclaim in
__alloc_pages_slowpath().

[1]:https://lore.kernel.org/linux-fsdevel/20230811071519.1094-1-teawaterz@linux.alibaba.com/
[2]:https://lore.kernel.org/all/20230914150011.843330-1-willy@infradead.org/T/#u
[3]:https://lore.kernel.org/all/20240830202823.21478-4-21cnbao@gmail.com/T/#u

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/memcontrol.h       |  6 +++
 include/linux/resume_user_mode.h |  1 +
 include/linux/sched.h            | 11 ++++-
 include/linux/sched/mm.h         | 35 ++++++++++++++++
 mm/memcontrol.c                  | 71 ++++++++++++++++++++++++++++++++
 5 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a..3b4393de553e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -900,6 +900,8 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 
 void mem_cgroup_handle_over_high(gfp_t gfp_mask);
 
+void mem_cgroup_handle_over_max(gfp_t gfp_mask);
+
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
 unsigned long mem_cgroup_size(struct mem_cgroup *memcg);
@@ -1354,6 +1356,10 @@ static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 }
 
+static inline void mem_cgroup_handle_over_max(gfp_t gfp_mask)
+{
+}
+
 static inline struct mem_cgroup *mem_cgroup_get_oom_group(
 	struct task_struct *victim, struct mem_cgroup *oom_domain)
 {
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mode.h
index e0135e0adae0..6189ebb8795b 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -56,6 +56,7 @@ static inline void resume_user_mode_work(struct pt_regs *regs)
 	}
 #endif
 
+	mem_cgroup_handle_over_max(GFP_KERNEL);
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..6eadd7be6810 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1549,9 +1549,12 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_MEMCG
-	/* Number of pages to reclaim on returning to userland: */
+	/* Number of pages over high to reclaim on returning to userland: */
 	unsigned int			memcg_nr_pages_over_high;
 
+	/* Number of pages over max to reclaim on returning to userland: */
+	unsigned int			memcg_nr_pages_over_max;
+
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
 
@@ -1745,7 +1748,11 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocations constrained to zones which allow long term pinning.
 						 * See memalloc_pin_save() */
 #define PF_BLOCK_TS		0x20000000	/* plug has ts that needs updating */
-#define PF__HOLE__40000000	0x40000000
+#ifdef CONFIG_MEMCG
+#define PF_MEMALLOC_ACCOUNTFORCE 0x40000000 /* See memalloc_account_force_save() */
+#else
+#define PF_MEMALLOC_ACCOUNTFORCE 0
+#endif
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
 /*
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index b13474825130..648c03b6250c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -468,6 +468,41 @@ static inline void memalloc_pin_restore(unsigned int flags)
 	memalloc_flags_restore(flags);
 }
 
+/**
+ * memalloc_account_force_save - Marks implicit PF_MEMALLOC_ACCOUNTFORCE
+ * allocation scope.
+ *
+ * The PF_MEMALLOC_ACCOUNTFORCE ensures that memory allocations are forced
+ * to be accounted to the memory cgroup, even if they exceed the cgroup's
+ * maximum limit. In such cases, the reclaim process is postponed until
+ * the task returns to userland. This is beneficial for users who perform
+ * over-max reclaim while holding multiple locks or other resources
+ * (especially resources related to file system writeback). If a task
+ * needs any of these resources, it would otherwise have to wait until
+ * the other task completes reclaim and releases the resources. Postponing
+ * reclaim to the return-to-userland path helps avoid this issue.
+ *
+ * Context: This function is safe to be used from any context.
+ * Return: The saved flags to be passed to memalloc_account_force_restore.
+ */
+static inline unsigned int memalloc_account_force_save(void)
+{
+	return memalloc_flags_save(PF_MEMALLOC_ACCOUNTFORCE);
+}
+
+/**
+ * memalloc_account_force_restore - Ends the implicit PF_MEMALLOC_ACCOUNTFORCE.
+ * @flags: Flags to restore.
+ *
+ * Ends the implicit PF_MEMALLOC_ACCOUNTFORCE scope started by memalloc_account_force_save
+ * function. Always make sure that the given flags is the return value from the pairing
+ * memalloc_account_force_save call.
+ */
+static inline void memalloc_account_force_restore(void)
+{
+	return memalloc_flags_restore(PF_MEMALLOC_ACCOUNTFORCE);
+}
+
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 902da8a9c643..8484c3a15151 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2301,6 +2301,67 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	css_put(&memcg->css);
 }
 
+static inline struct mem_cgroup *get_over_limit_memcg(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *mem_over_limit = NULL;
+
+	do {
+		if (page_counter_read(&memcg->memory) <=
+		    READ_ONCE(memcg->memory.max))
+			continue;
+
+		mem_over_limit = memcg;
+		break;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+
+	return mem_over_limit;
+}
+
+void mem_cgroup_handle_over_max(gfp_t gfp_mask)
+{
+	unsigned long nr_reclaimed = 0;
+	unsigned int nr_pages = current->memcg_nr_pages_over_max;
+	int nr_retries = MAX_RECLAIM_RETRIES;
+	struct mem_cgroup *memcg, *mem_over_limit;
+
+	if (likely(!nr_pages))
+		return;
+
+	memcg = get_mem_cgroup_from_mm(current->mm);
+	current->memcg_nr_pages_over_max = 0;
+
+retry:
+	mem_over_limit = get_over_limit_memcg(memcg);
+	if (!mem_over_limit)
+		goto out;
+
+	while (nr_reclaimed < nr_pages) {
+		unsigned long reclaimed;
+
+		reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit,
+					nr_pages, GFP_KERNEL,
+					MEMCG_RECLAIM_MAY_SWAP,
+					NULL);
+
+		if (!reclaimed && !nr_retries--)
+			break;
+
+		nr_reclaimed += reclaimed;
+	}
+
+	if ((nr_reclaimed < nr_pages) &&
+	    (page_counter_read(&mem_over_limit->memory) >
+	    READ_ONCE(mem_over_limit->memory.max)) &&
+	    mem_cgroup_oom(mem_over_limit, gfp_mask,
+			  get_order((nr_pages - nr_reclaimed)  * PAGE_SIZE))) {
+		nr_retries = MAX_RECLAIM_RETRIES;
+		goto retry;
+	}
+
+out:
+	css_put(&memcg->css);
+}
+
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
@@ -2349,6 +2410,16 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (unlikely(current->flags & PF_MEMALLOC))
 		goto force;
 
+	/*
+	 * Avoid blocking on heavyweight resources (e.g., jbd2 handle)
+	 * which may otherwise lead to system-wide stalls.
+	 */
+	if (current->flags & PF_MEMALLOC_ACCOUNTFORCE) {
+		current->memcg_nr_pages_over_max += nr_pages;
+		set_notify_resume(current);
+		goto force;
+	}
+
 	if (unlikely(task_in_memcg_oom(current)))
 		goto nomem;
 
-- 
2.39.5


