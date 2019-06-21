Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5786A4E17C
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 09:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUH7L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 03:59:11 -0400
Received: from mail2.tencent.com ([163.177.67.195]:46540 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfFUH7L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 03:59:11 -0400
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 50BD18E7CE;
        Fri, 21 Jun 2019 15:47:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.22.120.143) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 15:47:21 +0800
From:   <xiaoggchen@tencent.com>
To:     <jasperwang@tencent.com>, <heddchen@tencent.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, chen xiaoguang <xiaoggchen@tencent.com>,
        Newton Gao <newtongao@tencent.com>,
        Shook Liu <shookliu@tencent.com>,
        Zhiguang Peng <zgpeng@tencent.com>
Subject: [PATCH 2/5] sched/BT: implement the BT scheduling class
Date:   Fri, 21 Jun 2019 15:45:54 +0800
Message-ID: <1561103157-11246-3-git-send-email-xiaoggchen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
References: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.22.120.143]
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: chen xiaoguang <xiaoggchen@tencent.com>

Signed-off-by: Newton Gao <newtongao@tencent.com>
Signed-off-by: Shook Liu <shookliu@tencent.com>
Signed-off-by: Zhiguang Peng <zgpeng@tencent.com>
Signed-off-by: Xiaoguang Chen <xiaoggchen@tencent.com>
---
 kernel/sched/bt.c    | 1012 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  |    4 +-
 kernel/sched/sched.h |    5 +-
 3 files changed, 1018 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/bt.c b/kernel/sched/bt.c
index 56566e6..87eb04f 100644
--- a/kernel/sched/bt.c
+++ b/kernel/sched/bt.c
@@ -5,6 +5,8 @@
 
 #include "sched.h"
 
+#include <trace/events/sched.h>
+
 void init_bt_rq(struct bt_rq *bt_rq)
 {
 	bt_rq->tasks_timeline = RB_ROOT;
@@ -14,4 +16,1014 @@ void init_bt_rq(struct bt_rq *bt_rq)
 #endif
 }
 
+static inline struct bt_rq *task_bt_rq(struct task_struct *p)
+{
+	return &task_rq(p)->bt;
+}
+
+static inline struct task_struct *bt_task_of(struct sched_bt_entity *bt_se)
+{
+	return container_of(bt_se, struct task_struct, bt);
+}
+
+static inline struct bt_rq *bt_rq_of(struct sched_bt_entity *bt_se)
+{
+	struct task_struct *p = bt_task_of(bt_se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->bt;
+}
+
+static inline struct rq *rq_of_bt_rq(struct bt_rq *bt_rq)
+{
+	return container_of(bt_rq, struct rq, bt);
+}
+
+static u64 __calc_delta(u64 delta_exec, unsigned long weight,
+		struct load_weight *lw);
+
+/*
+ * delta /= w
+ */
+static inline unsigned long
+calc_delta_bt(unsigned long delta, struct sched_bt_entity *bt_se)
+{
+	if (unlikely(bt_se->load.weight != NICE_0_LOAD))
+		delta = __calc_delta(delta, NICE_0_LOAD, &bt_se->load);
+
+	return delta;
+}
+
+static inline void update_load_add(struct load_weight *lw, unsigned long inc)
+{
+	lw->weight += inc;
+	lw->inv_weight = 0;
+}
+
+/*
+ * The idea is to set a period in which each task runs once.
+ *
+ * When there are too many tasks (sched_nr_latency) we have to stretch
+ * this period because otherwise the slices get too small.
+ *
+ * p = (nr <= nl) ? l : l*nr/nl
+ */
+static u64 __sched_period(unsigned long nr_running)
+{
+if (unlikely(nr_running > sched_nr_latency))
+	return nr_running * sysctl_sched_min_granularity;
+else
+	return sysctl_sched_latency;
+}
+
+/*
+ * We calculate the wall-time slice from the period by taking a part
+ * proportional to the weight.
+ *
+ * s = p*P[w/rw]
+ */
+static u64 sched_bt_slice(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	u64 slice = __sched_period(bt_rq->bt_nr_running + !se->on_rq);
+	struct load_weight *load;
+	struct load_weight lw;
+
+	bt_rq = bt_rq_of(se);
+	load = &bt_rq->load;
+
+	if (unlikely(!se->on_rq)) {
+		lw = bt_rq->load;
+		update_load_add(&lw, se->load.weight);
+		load = &lw;
+	}
+	slice = __calc_delta(slice, se->load.weight, load);
+	return slice;
+}
+
+/*
+ * We calculate the vruntime slice of a to-be-inserted task.
+ *
+ * vs = s/w
+ */
+static u64 sched_bt_vslice(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	return calc_delta_bt(sched_bt_slice(bt_rq, se), se);
+}
+
+static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
+{
+	s64 delta = (s64)(vruntime - max_vruntime);
+
+	if (delta > 0)
+		max_vruntime = vruntime;
+
+	return max_vruntime;
+}
+
+static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
+{
+	s64 delta = (s64)(vruntime - min_vruntime);
+
+	if (delta < 0)
+		min_vruntime = vruntime;
+
+	return min_vruntime;
+}
+
+static inline int bt_entity_before(struct sched_bt_entity *a,
+				struct sched_bt_entity *b)
+{
+	return (s64)(a->vruntime - b->vruntime) < 0;
+}
+
+static void
+place_bt_entity(struct bt_rq *bt_rq, struct sched_bt_entity *se, int initial)
+{
+	u64 vruntime = bt_rq->min_vruntime;
+
+	/*
+	 * The 'current' period is already promised to the current tasks,
+	 * however the extra weight of the new task will slow them down a
+	 * little, place the new task so that it fits in the slot that
+	 * stays open at the end.
+	 */
+	if (initial && sched_feat(START_DEBIT))
+		vruntime += sched_bt_vslice(bt_rq, se);
+
+	/* sleeps up to a single latency don't count. */
+	if (!initial) {
+		unsigned long thresh = sysctl_sched_latency;
+
+		/*
+		 * Halve their sleep time's effect, to allow
+		 * for a gentler effect of sleepers:
+		 */
+		if (sched_feat(GENTLE_FAIR_SLEEPERS))
+			thresh >>= 1;
+
+		vruntime -= thresh;
+	}
+
+	/* ensure we never gain time by being placed backwards. */
+	se->vruntime = max_vruntime(se->vruntime, vruntime);
+}
+
+static void update_bt_min_vruntime(struct bt_rq *bt_rq)
+{
+	u64 vruntime = bt_rq->min_vruntime;
+
+	if (bt_rq->curr)
+		vruntime = bt_rq->curr->vruntime;
+
+	if (bt_rq->rb_leftmost) {
+		struct sched_bt_entity *bt_se = rb_entry(bt_rq->rb_leftmost,
+				struct sched_bt_entity,
+				run_node);
+
+		if (!bt_rq->curr)
+			vruntime = bt_se->vruntime;
+		else
+			vruntime = min_vruntime(vruntime, bt_se->vruntime);
+	}
+
+	/* ensure we never gain time by being placed backwards. */
+	bt_rq->min_vruntime = max_vruntime(bt_rq->min_vruntime, vruntime);
+#ifndef CONFIG_64BIT
+	smp_wmb();
+	bt_rq->min_vruntime_copy = bt_rq->min_vruntime;
+#endif
+}
+
+/*
+ * Update the current task's runtime statistics. Skip current tasks that
+ * are not in our scheduling class.
+ */
+static inline void
+__update_curr_bt(struct bt_rq *bt_rq, struct sched_bt_entity *curr,
+		unsigned long delta_exec)
+{
+	unsigned long delta_exec_weighted;
+
+	schedstat_set(curr->statistics->exec_max,
+		max((u64)delta_exec, curr->statistics->exec_max));
+
+	curr->sum_exec_runtime += delta_exec;
+	schedstat_add(bt_rq->exec_clock, delta_exec);
+	delta_exec_weighted = calc_delta_bt(delta_exec, curr);
+
+	curr->vruntime += delta_exec_weighted;
+	update_bt_min_vruntime(bt_rq);
+}
+
+static void
+account_bt_entity_enqueue(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	update_load_add(&bt_rq->load, se->load.weight);
+	bt_rq->bt_nr_running++;
+}
+
+static inline void
+update_stats_wait_start_bt(struct bt_rq *bt_rq, struct sched_bt_entity *bt_se)
+{
+	schedstat_set(bt_se->statistics->wait_start, rq_of_bt_rq(bt_rq)->clock);
+}
+
+static void update_stats_enqueue_bt(struct bt_rq *bt_rq,
+				struct sched_bt_entity *se)
+{
+	/*
+	 * Are we enqueueing a waiting task? (for current tasks
+	 * a dequeue/enqueue event is a NOP)
+	 */
+	if (se != bt_rq->curr)
+		update_stats_wait_start_bt(bt_rq, se);
+}
+
+static void update_curr(struct bt_rq *bt_rq)
+{
+	struct sched_bt_entity *curr = bt_rq->curr;
+	u64 now = rq_of_bt_rq(bt_rq)->clock_task;
+	unsigned long delta_exec;
+	struct task_struct *tsk;
+
+	if (unlikely(!curr))
+		return;
+
+	/*
+	 * Get the amount of time the current task was running
+	 * since the last time we changed load (this cannot
+	 * overflow on 32 bits):
+	 */
+	delta_exec = (unsigned long)(now - curr->exec_start);
+	if (!delta_exec)
+		return;
+
+	__update_curr_bt(bt_rq, curr, delta_exec);
+	curr->exec_start = now;
+
+	tsk = bt_task_of(curr);
+	trace_sched_stat_runtime(tsk, delta_exec, curr->vruntime);
+	cpuacct_charge(tsk, delta_exec);
+}
+
+static void __enqueue_bt_entity(struct bt_rq *bt_rq,
+				struct sched_bt_entity *bt_se)
+{
+	struct rb_node **link = &bt_rq->tasks_timeline.rb_node;
+	struct rb_node *parent = NULL;
+	struct sched_bt_entity *entry;
+	int leftmost = 1;
+
+	/*
+	 * Find the right place in the rbtree:
+	 */
+	while (*link) {
+		parent = *link;
+		entry = rb_entry(parent, struct sched_bt_entity, run_node);
+		/*
+		 * We dont care about collisions. Nodes with
+		 * the same key stay together.
+		 */
+		if (bt_entity_before(bt_se, entry)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = 0;
+		}
+	}
+
+	/*
+	 * Maintain a cache of leftmost tree entries (it is frequently
+	 * used):
+	 */
+	if (leftmost)
+		bt_rq->rb_leftmost = &bt_se->run_node;
+
+	rb_link_node(&bt_se->run_node, parent, link);
+	rb_insert_color(&bt_se->run_node, &bt_rq->tasks_timeline);
+}
+
+
+static void
+enqueue_bt_entity(struct bt_rq *bt_rq, struct sched_bt_entity *bt_se, int flags)
+{
+	bool renorm = !(flags && ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
+
+	/*
+	 * Update the normalized vruntime before updating min_vruntime
+	 * through callig update_curr().
+	 */
+	if (renorm && (bt_rq->curr == bt_se))
+		bt_se->vruntime += bt_rq->min_vruntime;
+
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(bt_rq);
+	account_bt_entity_enqueue(bt_rq, bt_se);
+
+	if (flags & ENQUEUE_WAKEUP)
+		place_bt_entity(bt_rq, bt_se, 0);
+
+	update_stats_enqueue_bt(bt_rq, bt_se);
+	if (bt_se != bt_rq->curr)
+		__enqueue_bt_entity(bt_rq, bt_se);
+	bt_se->on_rq = 1;
+}
+
+/*
+ * The enqueue_task method is called before nr_running is
+ * increased. Here we update the fair scheduling stats and
+ * then put the task into the rbtree:
+ */
+static void
+enqueue_task_bt(struct rq *rq, struct task_struct *p, int flags)
+{
+	struct bt_rq *bt_rq;
+	struct sched_bt_entity *se = &p->bt;
+
+	if (se->on_rq)
+		return;
+
+	bt_rq = bt_rq_of(se);
+	flags = ENQUEUE_WAKEUP;
+	enqueue_bt_entity(bt_rq, se, flags);
+
+	add_nr_running(rq, 1);
+}
+
+static void
+update_stats_wait_end_bt(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	schedstat_set(se->statistics->wait_max, max(se->statistics->wait_max,
+		rq_of_bt_rq(bt_rq)->clock - se->statistics->wait_start));
+	schedstat_set(se->statistics->wait_count, se->statistics->wait_count
+			+ 1);
+	schedstat_set(se->statistics->wait_sum, se->statistics->wait_sum +
+		rq_of_bt_rq(bt_rq)->clock - se->statistics->wait_start);
+#ifdef CONFIG_SCHEDSTATS
+	trace_sched_stat_wait(bt_task_of(se),
+	rq_of_bt_rq(bt_rq)->clock - se->statistics->wait_start);
+#endif
+	schedstat_set(se->statistics->wait_start, 0);
+}
+
+static inline void
+update_stats_dequeue_bt(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	/*
+	 * Mark the end of the wait period if dequeueing a
+	 * waiting task:
+	 */
+	if (se != bt_rq->curr)
+		update_stats_wait_end_bt(bt_rq, se);
+}
+
+static void __clear_buddies_next_bt(struct sched_bt_entity *se)
+{
+	struct bt_rq *bt_rq = bt_rq_of(se);
+
+	bt_rq->next = NULL;
+}
+
+static void __clear_buddies_skip_bt(struct sched_bt_entity *se)
+{
+	struct bt_rq *bt_rq = bt_rq_of(se);
+
+	bt_rq->skip = NULL;
+}
+
+static void set_skip_buddy_bt(struct sched_bt_entity *se)
+{
+	bt_rq_of(se)->skip = se;
+}
+
+static void clear_buddies_bt(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	if (bt_rq->next == se)
+		__clear_buddies_next_bt(se);
+	if (bt_rq->skip == se)
+		__clear_buddies_skip_bt(se);
+}
+
+static void __dequeue_bt_entity(struct bt_rq *bt_rq,
+				struct sched_bt_entity *bt_se)
+{
+	if (bt_rq->rb_leftmost == &bt_se->run_node) {
+		struct rb_node *next_node;
+
+		next_node = rb_next(&bt_se->run_node);
+		bt_rq->rb_leftmost = next_node;
+	}
+	rb_erase(&bt_se->run_node, &bt_rq->tasks_timeline);
+}
+
+static inline void update_load_sub(struct load_weight *lw, unsigned long dec)
+{
+	lw->weight -= dec;
+	lw->inv_weight = 0;
+}
+
+static void
+account_bt_entity_dequeue(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	update_load_sub(&bt_rq->load, se->load.weight);
+	bt_rq->bt_nr_running--;
+}
+
+static void
+dequeue_bt_entity(struct bt_rq *bt_rq, struct sched_bt_entity *se, int flags)
+{
+	struct task_struct *tsk = bt_task_of(se);
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(bt_rq);
+
+	update_stats_dequeue_bt(bt_rq, se);
+	if (flags & DEQUEUE_SLEEP) {
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_LATENCYTOP)
+		if (tsk->state & TASK_INTERRUPTIBLE)
+			se->statistics->sleep_start = rq_of_bt_rq(bt_rq)->clock;
+		if (tsk->state & TASK_UNINTERRUPTIBLE)
+			se->statistics->block_start = rq_of_bt_rq(bt_rq)->clock;
+	}
+#endif
+	clear_buddies_bt(bt_rq, se);
+
+	if (se != bt_rq->curr)
+		__dequeue_bt_entity(bt_rq, se);
+	se->on_rq = 0;
+	account_bt_entity_dequeue(bt_rq, se);
+
+	/*
+	 * Normalize the entity after updating the min_vruntime because the
+	 * update can refer to the ->curr item and we need to reflect this
+	 * movement in our normalized position.
+	 */
+	if (!(flags & DEQUEUE_SLEEP))
+		se->vruntime -= bt_rq->min_vruntime;
+
+	update_bt_min_vruntime(bt_rq);
+}
+
+/*
+ * The dequeue_task method is called before nr_running is
+ * decreased. We remove the task from the rbtree and
+ * update the fair scheduling stats:
+ */
+static void dequeue_task_bt(struct rq *rq, struct task_struct *p, int flags)
+{
+	struct bt_rq *bt_rq;
+	struct sched_bt_entity *se = &p->bt;
+
+	bt_rq = bt_rq_of(se);
+	flags = DEQUEUE_SLEEP;
+	dequeue_bt_entity(bt_rq, se, flags);
+
+	bt_rq->bt_nr_running--;
+
+	sub_nr_running(rq, 1);
+}
+
+static void update_curr_bt(struct rq *rq)
+{
+	update_curr(&rq->bt);
+}
+
+/*
+ * sched_yield() is very simple
+ *
+ * The magic of dealing with the ->skip buddy is in pick_next_entity.
+ */
+static void yield_task_bt(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct bt_rq *bt_rq = task_bt_rq(curr);
+	struct sched_bt_entity *se = &curr->bt;
+
+	/*
+	 * Are we the only task in the tree?
+	 */
+	if (unlikely(rq->nr_running == 1))
+		return;
+
+	clear_buddies_bt(bt_rq, se);
+	update_rq_clock(rq);
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(bt_rq);
+	rq_clock_skip_update(rq);
+	set_skip_buddy_bt(se);
+}
+
+struct sched_bt_entity *__pick_first_bt_entity(struct bt_rq *bt_rq)
+{
+	struct rb_node *left = bt_rq->rb_leftmost;
+
+	if (!left)
+		return NULL;
+
+	return rb_entry(left, struct sched_bt_entity, run_node);
+}
+
+
+#define WMULT_CONST    (~0U)
+#define WMULT_SHIFT    32
+
+static void __update_inv_weight(struct load_weight *lw)
+{
+	unsigned long w;
+
+	if (likely(lw->inv_weight))
+		return;
+
+	w = scale_load_down(lw->weight);
+
+	if (BITS_PER_LONG > 32 && unlikely(w >= WMULT_CONST))
+		lw->inv_weight = 1;
+	else if (unlikely(!w))
+		lw->inv_weight = WMULT_CONST;
+	else
+		lw->inv_weight = WMULT_CONST / w;
+}
+
+/*
+ * delta_exec * weight / lw.weight
+ *   OR
+ * (delta_exec * (weight * lw->inv_weight)) >> WMULT_SHIFT
+ *
+ * Either weight := NICE_0_LOAD and lw \e sched_prio_to_wmult[], in which case
+ * we're guaranteed shift stays positive because inv_weight is guaranteed to
+ * fit 32 bits, and NICE_0_LOAD gives another 10 bits; therefore shift >= 22.
+ *
+ * Or, weight =< lw.weight (because lw.weight is the runqueue weight), thus
+ * weight/lw.weight <= 1, and therefore our shift will also be positive.
+ */
+static u64 __calc_delta(u64 delta_exec, unsigned long weight,
+			struct load_weight *lw)
+{
+	u64 fact = scale_load_down(weight);
+	int shift = WMULT_SHIFT;
+
+	__update_inv_weight(lw);
+
+	if (unlikely(fact >> 32)) {
+		while (fact >> 32) {
+			fact >>= 1;
+			shift--;
+		}
+	}
+
+	/* hint to use a 32x32->64 mul */
+	fact = (u64)(u32)fact * lw->inv_weight;
+
+	while (fact >> 32) {
+		fact >>= 1;
+		shift--;
+	}
+
+	return mul_u64_u32_shr(delta_exec, fact, shift);
+}
+
+static unsigned long
+wakeup_gran_bt(struct sched_bt_entity *curr, struct sched_bt_entity *se)
+{
+	unsigned long gran = sysctl_sched_wakeup_granularity;
+
+	/*
+	 * Since its curr running now, convert the gran from real-time
+	 * to virtual-time in his units.
+	 *
+	 * By using 'se' instead of 'curr' we penalize light tasks, so
+	 * they get preempted easier. That is, if 'se' < 'curr' then
+	 * the resulting gran will be larger, therefore penalizing the
+	 * lighter, if otoh 'se' > 'curr' then the resulting gran will
+	 * be smaller, again penalizing the lighter task.
+	 *
+	 * This is especially important for buddies when the leftmost
+	 * task is higher priority than the buddy.
+	 */
+	return calc_delta_bt(gran, se);
+}
+
+
+static int
+wakeup_preempt_bt_entity(struct sched_bt_entity *curr,
+			struct sched_bt_entity *se)
+{
+	s64 gran, vdiff = curr->vruntime - se->vruntime;
+
+	if (vdiff <= 0)
+		return -1;
+
+	gran = wakeup_gran_bt(curr, se);
+	if (vdiff > gran)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Preempt the current task with a newly woken task if needed:
+ */
+static void
+check_preempt_tick_bt(struct bt_rq *bt_rq, struct sched_bt_entity *curr)
+{
+	unsigned long ideal_runtime, delta_exec;
+	struct sched_bt_entity *se;
+	s64 delta;
+
+	ideal_runtime = sched_bt_slice(bt_rq, curr);
+	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
+	if (delta_exec > ideal_runtime) {
+		resched_curr(rq_of_bt_rq(bt_rq));
+		/*
+		 * The current task ran long enough, ensure it doesn't get
+		 * re-elected due to buddy favours.
+		 */
+		clear_buddies_bt(bt_rq, curr);
+		return;
+	}
+
+	/*
+	 * Ensure that a task that missed wakeup preemption by a
+	 * narrow margin doesn't have to wait for a full slice.
+	 * This also mitigates buddy induced latencies under load.
+	 */
+	if (delta_exec < sysctl_sched_min_granularity)
+		return;
+
+	se = __pick_first_bt_entity(bt_rq);
+	delta = curr->vruntime - se->vruntime;
+
+	if (delta < 0)
+		return;
+
+	if (delta > ideal_runtime)
+		resched_curr(rq_of_bt_rq(bt_rq));
+}
+
+static void set_next_buddy_bt(struct sched_bt_entity *se)
+{
+	if (unlikely(task_has_idle_policy(bt_task_of(se))))
+		return;
+
+	bt_rq_of(se)->next = se;
+}
+
+/*
+ * Preempt the current task with a newly woken task if needed:
+ */
+static void check_preempt_wakeup_bt(struct rq *rq, struct task_struct *p,
+				int wake_flags)
+{
+	struct task_struct *curr = rq->curr;
+	struct sched_bt_entity *se = &curr->bt, *pse = &p->bt;
+	struct bt_rq *bt_rq = task_bt_rq(curr);
+	int scale = bt_rq->bt_nr_running >= sched_nr_latency;
+	int next_buddy_marked = 0;
+
+	if (unlikely(se == pse))
+		return;
+
+	if (sched_feat(NEXT_BUDDY) && scale && !(wake_flags & WF_FORK)) {
+		set_next_buddy_bt(pse);
+		next_buddy_marked = 1;
+	}
+
+	/*
+	 * We can come here with TIF_NEED_RESCHED already set from new task
+	 * wake up path.
+	 *
+	 * Note: this also catches the edge-case of curr being in a throttled
+	 * group (e.g. via set_curr_task), since update_curr() (in the
+	 * enqueue of curr) will have resulted in resched being set.  This
+	 * prevents us from potentially nominating it as a false LAST_BUDDY
+	 * below.
+	 */
+	if (test_tsk_need_resched(curr))
+		return;
+
+	/* BT tasks are by definition preempted by non-bt tasks. */
+	if (likely(p->policy < SCHED_BT))
+		goto preempt;
+
+	if (!sched_feat(WAKEUP_PREEMPTION))
+		return;
+
+	update_curr(bt_rq_of(se));
+	BUG_ON(!pse);
+	if (wakeup_preempt_bt_entity(se, pse) == 1) {
+		/*
+		 * Bias pick_next to pick the sched entity that is
+		 * triggering this preemption.
+		 */
+		if (!next_buddy_marked)
+			set_next_buddy_bt(pse);
+		goto preempt;
+	}
+
+	return;
+
+preempt:
+	resched_curr(rq);
+	/*
+	 * Only set the backward buddy when the current task is still
+	 * on the rq. This can happen when a wakeup gets interleaved
+	 * with schedule on the ->pre_schedule() or idle_balance()
+	 * point, either of which can * drop the rq lock.
+	 *
+	 * Also, during early boot the idle thread is in the fair class,
+	 * for obvious reasons its a bad idea to schedule back to it.
+	 */
+	if (unlikely(!se->on_rq || curr == rq->idle))
+		return;
+}
+
+static struct sched_bt_entity *__pick_next_bt_entity(
+					struct sched_bt_entity *bt_se)
+{
+	struct rb_node *next = rb_next(&bt_se->run_node);
+
+	if (!next)
+		return NULL;
+
+	return rb_entry(next, struct sched_bt_entity, run_node);
+}
+
+/*
+ * We are picking a new current task - update its stats:
+ */
+static inline void
+update_stats_curr_start_bt(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	/*
+	 * We are starting a new run period:
+	 */
+	se->exec_start = rq_of_bt_rq(bt_rq)->clock_task;
+}
+
+static void
+set_next_bt_entity(struct bt_rq *bt_rq, struct sched_bt_entity *se)
+{
+	/* 'current' is not kept within the tree. */
+	if (se->on_rq) {
+		/*
+		 * Any task has to be enqueued before it get to execute on
+		 * a CPU. So account for the time it spent waiting on the
+		 * runqueue.
+		 */
+		update_stats_wait_end_bt(bt_rq, se);
+		__dequeue_bt_entity(bt_rq, se);
+	}
+
+	update_stats_curr_start_bt(bt_rq, se);
+	bt_rq->curr = se;
+#ifdef CONFIG_SCHEDSTATS
+	/*
+	 * Track our maximum slice length, if the CPU's load is at
+	 * least twice that of our own weight (i.e. dont track it
+	 * when there are only lesser-weight tasks around):
+	 */
+	if (bt_rq->load.weight >= 2*se->load.weight) {
+		se->statistics->slice_max = max(se->statistics->slice_max,
+			se->sum_exec_runtime - se->prev_sum_exec_runtime);
+	}
+#endif
+	se->prev_sum_exec_runtime = se->sum_exec_runtime;
+}
+
+/*
+ * Pick the next process, keeping these things in mind, in this order:
+ * 1) keep things fair between processes/task groups
+ * 2) pick the "next" process, since someone really wants that to run
+ * 3) do not run the "skip" process, if something else is available
+ */
+static struct sched_bt_entity *pick_next_bt_entity(struct bt_rq *bt_rq)
+{
+	struct sched_bt_entity *se = __pick_first_bt_entity(bt_rq);
+	struct sched_bt_entity *left = se;
+
+	/*
+	 * Avoid running the skip buddy, if running something else can
+	 * be done without getting too unfair.
+	 */
+	if (bt_rq->skip == se) {
+		struct sched_bt_entity *second = __pick_next_bt_entity(se);
+
+		if (second && wakeup_preempt_bt_entity(second, left) < 1)
+			se = second;
+	}
+
+	/*
+	 * Someone really wants this to run. If it's not unfair, run it.
+	 */
+	if (bt_rq->next && wakeup_preempt_bt_entity(bt_rq->next, left) < 1)
+		se = bt_rq->next;
+
+	clear_buddies_bt(bt_rq, se);
+
+	return se;
+}
+
+
+static struct task_struct *
+pick_next_task_bt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
+{
+	struct task_struct *p;
+	struct bt_rq *bt_rq;
+	struct sched_bt_entity *se;
+
+	bt_rq = &rq->bt;
+
+	if (!bt_rq->bt_nr_running)
+		return NULL;
+
+	put_prev_task(rq, prev);
+
+	se = pick_next_bt_entity(bt_rq);
+	set_next_bt_entity(bt_rq, se);
+
+	p = bt_task_of(se);
+
+	return p;
+}
+
+static void put_prev_bt_entity(struct bt_rq *bt_rq,
+				struct sched_bt_entity *prev)
+{
+	/*
+	 * If still on the runqueue then deactivate_task()
+	 * was not called and update_curr() has to be done:
+	 */
+	if (prev->on_rq)
+		update_curr(bt_rq);
+
+	if (prev->on_rq) {
+		update_stats_wait_start_bt(bt_rq, prev);
+		/* Put 'current' back into the tree. */
+		__enqueue_bt_entity(bt_rq, prev);
+	}
+	bt_rq->curr = NULL;
+}
+
+/*
+ * Account for a descheduled task:
+ */
+static void put_prev_task_bt(struct rq *rq, struct task_struct *prev)
+{
+	struct sched_bt_entity *se = &prev->bt;
+	struct bt_rq *bt_rq;
+
+	bt_rq = bt_rq_of(se);
+	put_prev_bt_entity(bt_rq, se);
+}
+
+#ifdef CONFIG_SMP
+static int
+select_task_rq_bt(struct task_struct *p, int prev_cpu, int sd_flag,
+		int wake_flags)
+{
+	struct sched_domain *tmp;
+	int cpu = smp_processor_id();
+	int new_cpu = cpu;
+
+	if (p->nr_cpus_allowed == 1)
+		return prev_cpu;
+
+	rcu_read_lock();
+	for_each_domain(cpu, tmp) {
+		if (cpumask_test_cpu(cpu, &p->cpus_allowed)) {
+			new_cpu = cpu;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return new_cpu;
+}
+#endif
+/* Account for a task changing its policy or group.
+ *
+ * This routine is mostly called to set bt_rq->curr field when a task
+ * migrates between groups/classes.
+ */
+static void set_curr_task_bt(struct rq *rq)
+{
+	struct sched_bt_entity *se = &rq->curr->bt;
+	struct bt_rq *bt_rq = bt_rq_of(se);
+
+	set_next_bt_entity(bt_rq, se);
+}
+
+static void
+bt_entity_tick(struct bt_rq *bt_rq, struct sched_bt_entity *curr, int queued)
+{
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(bt_rq);
+
+#ifdef CONFIG_SCHED_HRTICK
+	/*
+	 * queued ticks are scheduled to match the slice, so don't bother
+	 * validating it and just reschedule.
+	 */
+	if (queued) {
+		resched_curr(rq_of_bt_rq(bt_rq));
+		return;
+	}
+#endif
+
+	if (bt_rq->bt_nr_running > 1)
+		check_preempt_tick_bt(bt_rq, curr);
+}
+
+/*
+ * scheduler tick hitting a task of our scheduling class:
+ */
+static void task_tick_bt(struct rq *rq, struct task_struct *curr, int queued)
+{
+	struct bt_rq *bt_rq;
+	struct sched_bt_entity *se = &curr->bt;
+
+	bt_rq = bt_rq_of(se);
+	bt_entity_tick(bt_rq, se, queued);
+}
+/*
+ * Priority of the task has changed. Check to see if we preempt
+ * the current task.
+ */
+static void
+prio_changed_bt(struct rq *rq, struct task_struct *p, int oldprio)
+{
+	if (!p->bt.on_rq)
+		return;
+
+	/*
+	 * Reschedule if we are currently running on this runqueue and
+	 * our priority decreased, or if we are not currently running on
+	 * this runqueue and our priority is higher than the current's
+	 */
+	if (rq->curr == p) {
+		if (p->prio > oldprio)
+			resched_curr(rq);
+	} else
+		check_preempt_curr(rq, p, 0);
+}
+
+/*
+ * We switched to the sched_fair class.
+ */
+static void switched_to_bt(struct rq *rq, struct task_struct *p)
+{
+	if (!p->bt.on_rq)
+		return;
+	/*
+	 * We were most likely switched from sched_rt, so
+	 * kick off the schedule if running, otherwise just see
+	 * if we can still preempt the current task.
+	 */
+	if (rq->curr == p)
+		resched_curr(rq);
+	else
+		check_preempt_curr(rq, p, 0);
+}
+
+static unsigned int get_rr_interval_bt(struct rq *rq, struct task_struct *task)
+{
+	struct sched_bt_entity *se = &task->bt;
+	unsigned int rr_interval = 0;
+
+	/*
+	 * Time slice is 0 for SCHED_OTHER tasks that are on an otherwise
+	 * idle runqueue:
+	 */
+	if (rq->bt.load.weight)
+		rr_interval = NS_TO_JIFFIES(sched_bt_slice(bt_rq_of(se), se));
+
+	return rr_interval;
+}
+
+const struct sched_class bt_sched_class = {
+	.next                   = &idle_sched_class,
+	.enqueue_task           = enqueue_task_bt,
+	.dequeue_task           = dequeue_task_bt,
+	.yield_task             = yield_task_bt,
+	.check_preempt_curr     = check_preempt_wakeup_bt,
+	.pick_next_task         = pick_next_task_bt,
+	.put_prev_task          = put_prev_task_bt,
+#ifdef CONFIG_SMP
+	.select_task_rq         = select_task_rq_bt,
+	.set_cpus_allowed       = set_cpus_allowed_common,
+#endif
+	.set_curr_task          = set_curr_task_bt,
+	.task_tick              = task_tick_bt,
+	.prio_changed           = prio_changed_bt,
+	.switched_to            = switched_to_bt,
+	.get_rr_interval        = get_rr_interval_bt,
+	.update_curr            = update_curr_bt,
+};
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..5299ce8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -64,7 +64,7 @@
 /*
  * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
  */
-static unsigned int sched_nr_latency = 8;
+unsigned int sched_nr_latency = 8;
 
 /*
  * After fork, child runs first. If set to 0 (default) then
@@ -10653,7 +10653,7 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
  * All the scheduling class methods:
  */
 const struct sched_class fair_sched_class = {
-	.next			= &idle_sched_class,
+	.next			= &bt_sched_class,
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 320c80d..68007be 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -593,7 +593,7 @@ struct bt_rq {
 	struct rb_root tasks_timeline;
 	struct rb_node *rb_leftmost;
 
-	struct sched_bt_entity *curr, *next;
+	struct sched_bt_entity *curr, *next, *skip;
 };
 
 static inline int rt_bandwidth_enabled(void)
@@ -1754,6 +1754,7 @@ static inline void set_curr_task(struct rq *rq, struct task_struct *curr)
 extern const struct sched_class rt_sched_class;
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
+extern const struct sched_class bt_sched_class;
 
 
 #ifdef CONFIG_SMP
@@ -2362,4 +2363,6 @@ static inline bool sched_energy_enabled(void)
 #define perf_domain_span(pd) NULL
 static inline bool sched_energy_enabled(void) { return false; }
 
+extern unsigned int sched_nr_latency;
+
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-- 
1.8.3.1

