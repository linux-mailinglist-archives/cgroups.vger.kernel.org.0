Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2631D5AA5
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 22:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOUUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 16:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOUUi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 May 2020 16:20:38 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBF4207DA;
        Fri, 15 May 2020 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589574037;
        bh=KqiyFCMd1WD/jvaPDkl3QE7yXvdYgfk3Sd1uKHe68Ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDVYlT/mL18bhTUuiu+n/XO7SpGaPtELHgsmv/XgCUDmuSQUCJOs8Kx1cvt9IUQoq
         s4pX63pF7zceRGfi/46Ifjw+4slqJElx/q3Ivyd23abnoDQqZEXAZRkJv3J3xC7Qxx
         n8r8iklUMq0mq6H74GI/yw/zHFE5Lk5ui3QPaQG8=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v3 3/3] mm: automatically penalize tasks with high swap use
Date:   Fri, 15 May 2020 13:20:27 -0700
Message-Id: <20200515202027.3217470-4-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515202027.3217470-1-kuba@kernel.org>
References: <20200515202027.3217470-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a memory.swap.high knob, which can be used to protect the system
from SWAP exhaustion. The mechanism used for penalizing is similar
to memory.high penalty (sleep on return to user space), but with
a less steep slope.

That is not to say that the knob itself is equivalent to memory.high.
The objective is more to protect the system from potentially buggy
tasks consuming a lot of swap and impacting other tasks, or even
bringing the whole system to stand still with complete SWAP
exhaustion. Hopefully without the need to find per-task hard
limits.

Slowing misbehaving tasks down gradually allows user space oom
killers or other protection mechanisms to react. oomd and earlyoom
already do killing based on swap exhaustion, and memory.swap.high
protection will help implement such userspace oom policies more
reliably.

Use one counter for number of pages allocated under pressure
to save struct task space and avoid two separate hierarchy
walks on the hot path.

Take the new high limit into account when determining if swap
is "full". Borrowing the explanation from Johannes:

  The idea behind "swap full" is that as long as the workload has plenty
  of swap space available and it's not changing its memory contents, it
  makes sense to generously hold on to copies of data in the swap
  device, even after the swapin. A later reclaim cycle can drop the page
  without any IO. Trading disk space for IO.

  But the only two ways to reclaim a swap slot is when they're faulted
  in and the references go away, or by scanning the virtual address space
  like swapoff does - which is very expensive (one could argue it's too
  expensive even for swapoff, it's often more practical to just reboot).

  So at some point in the fill level, we have to start freeing up swap
  slots on fault/swapin. Otherwise we could eventually run out of swap
  slots while they're filled with copies of data that is also in RAM.

  We don't want to OOM a workload because its available swap space is
  filled with redundant cache.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v3:
 - count events for all groups over limit
 - add doc for high events
 - remove the magic scaling factor
 - improve commit message
v2:
 - add docs,
 - improve commit message.
---
 Documentation/admin-guide/cgroup-v2.rst | 20 ++++++
 include/linux/memcontrol.h              |  4 ++
 mm/memcontrol.c                         | 83 +++++++++++++++++++++++--
 3 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index fed4e1d2a343..1536deb2f28e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1373,6 +1373,22 @@ PAGE_SIZE multiple when read back.
 	The total amount of swap currently being used by the cgroup
 	and its descendants.
 
+  memory.swap.high
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "max".
+
+	Swap usage throttle limit.  If a cgroup's swap usage exceeds
+	this limit, all its further allocations will be throttled to
+	allow userspace to implement custom out-of-memory procedures.
+
+	This limit marks a point of no return for the cgroup. It is NOT
+	designed to manage the amount of swapping a workload does
+	during regular operation. Compare to memory.swap.max, which
+	prohibits swapping past a set amount, but lets the cgroup
+	continue unimpeded as long as other memory can be reclaimed.
+
+	Healthy workloads are not expected to reach this limit.
+
   memory.swap.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
@@ -1386,6 +1402,10 @@ PAGE_SIZE multiple when read back.
 	otherwise, a value change in this file generates a file
 	modified event.
 
+	  high
+		The number of times the cgroup's swap usage was over
+		the high threshold.
+
 	  max
 		The number of times the cgroup's swap usage was about
 		to go over the max boundary and swap allocation
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e0bcef180672..abf1d7aad48a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -42,6 +42,7 @@ enum memcg_memory_event {
 	MEMCG_MAX,
 	MEMCG_OOM,
 	MEMCG_OOM_KILL,
+	MEMCG_SWAP_HIGH,
 	MEMCG_SWAP_MAX,
 	MEMCG_SWAP_FAIL,
 	MEMCG_NR_MEMORY_EVENTS,
@@ -209,6 +210,9 @@ struct mem_cgroup {
 	/* Upper bound of normal memory consumption range */
 	unsigned long high;
 
+	/* Upper bound of swap consumption range */
+	unsigned long swap_high;
+
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b2022f98bf46..4fe6cebb5b4b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2332,6 +2332,22 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 	return max_overage;
 }
 
+static u64 swap_find_max_overage(struct mem_cgroup *memcg)
+{
+	u64 overage, max_overage = 0;
+
+	do {
+		overage = calculate_overage(page_counter_read(&memcg->swap),
+					    READ_ONCE(memcg->swap_high));
+		if (overage)
+			memcg_memory_event(memcg, MEMCG_SWAP_HIGH);
+		max_overage = max(overage, max_overage);
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		 !mem_cgroup_is_root(memcg));
+
+	return max_overage;
+}
+
 /*
  * Get the number of jiffies that we should penalise a mischievous cgroup which
  * is exceeding its memory.high by checking both it and its ancestors.
@@ -2393,6 +2409,13 @@ void mem_cgroup_handle_over_high(void)
 	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
 					       mem_find_max_overage(memcg));
 
+	/*
+	 * Make the swap curve more gradual, swap can be considered "cheaper",
+	 * and is allocated in larger chunks. We want the delays to be gradual.
+	 */
+	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
+						swap_find_max_overage(memcg));
+
 	/*
 	 * Clamp the max delay per usermode return so as to still keep the
 	 * application moving forwards and also permit diagnostics, albeit
@@ -2583,12 +2606,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim, the cost of mismatch is negligible.
 	 */
 	do {
-		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
-			/* Don't bother a random interrupted task */
-			if (in_interrupt()) {
+		bool mem_high, swap_high;
+
+		mem_high = page_counter_read(&memcg->memory) >
+			READ_ONCE(memcg->high);
+		swap_high = page_counter_read(&memcg->swap) >
+			READ_ONCE(memcg->swap_high);
+
+		/* Don't bother a random interrupted task */
+		if (in_interrupt()) {
+			if (mem_high) {
 				schedule_work(&memcg->high_work);
 				break;
 			}
+			continue;
+		}
+
+		if (mem_high || swap_high) {
 			current->memcg_nr_pages_over_high += batch;
 			set_notify_resume(current);
 			break;
@@ -5005,6 +5039,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->swap_high, PAGE_COUNTER_MAX);
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
@@ -5158,6 +5193,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->swap_high, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
 
@@ -6978,10 +7014,13 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (!memcg)
 		return false;
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
-		if (page_counter_read(&memcg->swap) * 2 >=
-		    READ_ONCE(memcg->swap.max))
+	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
+		unsigned long usage = page_counter_read(&memcg->swap);
+
+		if (usage * 2 >= READ_ONCE(memcg->swap_high) ||
+		    usage * 2 >= READ_ONCE(memcg->swap.max))
 			return true;
+	}
 
 	return false;
 }
@@ -7004,6 +7043,30 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
 }
 
+static int swap_high_show(struct seq_file *m, void *v)
+{
+	unsigned long high = READ_ONCE(mem_cgroup_from_seq(m)->swap_high);
+
+	return seq_puts_memcg_tunable(m, high);
+}
+
+static ssize_t swap_high_write(struct kernfs_open_file *of,
+			       char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long high;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &high);
+	if (err)
+		return err;
+
+	WRITE_ONCE(memcg->swap_high, high);
+
+	return nbytes;
+}
+
 static int swap_max_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -7031,6 +7094,8 @@ static int swap_events_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
+	seq_printf(m, "high %lu\n",
+		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_HIGH]));
 	seq_printf(m, "max %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MAX]));
 	seq_printf(m, "fail %lu\n",
@@ -7045,6 +7110,12 @@ static struct cftype swap_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = swap_current_read,
 	},
+	{
+		.name = "swap.high",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_high_show,
+		.write = swap_high_write,
+	},
 	{
 		.name = "swap.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.25.4

