Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC57900A3
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2019 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfHPLTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Aug 2019 07:19:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfHPLS7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Aug 2019 07:18:59 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyaG0-0008PI-Vy; Fri, 16 Aug 2019 13:18:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] cgroup: Remove ->css_rstat_flush()
Date:   Fri, 16 Aug 2019 13:18:14 +0200
Message-Id: <20190816111817.834-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816111817.834-1-bigeasy@linutronix.de>
References: <20190816111817.834-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I was looking at the lifetime of the the ->css_rstat_flush() to see if
cgroup_rstat_cpu_lock should remain a raw_spinlock_t. I didn't find any
users and is unused since it was introduced in commit
  8f53470bab042 ("cgroup: Add cgroup_subsys->css_rstat_flush()")

Remove the css_rstat_flush callback because it has no users.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/cgroup-defs.h |  5 -----
 kernel/cgroup/cgroup.c      | 12 ------------
 kernel/cgroup/rstat.c       | 10 +---------
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 430e219e3abaf..5708205542bf8 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -144,9 +144,6 @@ struct cgroup_subsys_state {
 	struct list_head sibling;
 	struct list_head children;
=20
-	/* flush target list anchored at cgrp->rstat_css_list */
-	struct list_head rstat_css_node;
-
 	/*
 	 * PI: Subsys-unique ID.  0 is unused and root is always 1.  The
 	 * matching css can be looked up using css_from_id().
@@ -455,7 +452,6 @@ struct cgroup {
=20
 	/* per-cpu recursive resource statistics */
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
-	struct list_head rstat_css_list;
=20
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat pending_bstat;	/* pending from children */
@@ -633,7 +629,6 @@ struct cgroup_subsys {
 	void (*css_released)(struct cgroup_subsys_state *css);
 	void (*css_free)(struct cgroup_subsys_state *css);
 	void (*css_reset)(struct cgroup_subsys_state *css);
-	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
=20
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 753afbca549fd..a9c20e9076431 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1957,7 +1957,6 @@ static void init_cgroup_housekeeping(struct cgroup *c=
grp)
 	cgrp->dom_cgrp =3D cgrp;
 	cgrp->max_descendants =3D INT_MAX;
 	cgrp->max_depth =3D INT_MAX;
-	INIT_LIST_HEAD(&cgrp->rstat_css_list);
 	prev_cputime_init(&cgrp->prev_cputime);
=20
 	for_each_subsys(ss, ssid)
@@ -5012,12 +5011,6 @@ static void css_release_work_fn(struct work_struct *=
work)
 	list_del_rcu(&css->sibling);
=20
 	if (ss) {
-		/* css release path */
-		if (!list_empty(&css->rstat_css_node)) {
-			cgroup_rstat_flush(cgrp);
-			list_del_rcu(&css->rstat_css_node);
-		}
-
 		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
 		if (ss->css_released)
 			ss->css_released(css);
@@ -5079,7 +5072,6 @@ static void init_and_link_css(struct cgroup_subsys_st=
ate *css,
 	css->id =3D -1;
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
-	INIT_LIST_HEAD(&css->rstat_css_node);
 	css->serial_nr =3D css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
=20
@@ -5088,9 +5080,6 @@ static void init_and_link_css(struct cgroup_subsys_st=
ate *css,
 		css_get(css->parent);
 	}
=20
-	if (cgroup_on_dfl(cgrp) && ss->css_rstat_flush)
-		list_add_rcu(&css->rstat_css_node, &cgrp->rstat_css_list);
-
 	BUG_ON(cgroup_css(cgrp, ss));
 }
=20
@@ -5192,7 +5181,6 @@ static struct cgroup_subsys_state *css_create(struct =
cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	list_del_rcu(&css->rstat_css_node);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index ca19b4c8acf53..72ba0ec4ae209 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -162,17 +162,9 @@ static void cgroup_rstat_flush_locked(struct cgroup *c=
grp, bool may_sleep)
 		struct cgroup *pos =3D NULL;
=20
 		raw_spin_lock(cpu_lock);
-		while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
-			struct cgroup_subsys_state *css;
-
+		while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu)))
 			cgroup_base_stat_flush(pos, cpu);
=20
-			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos->rstat_css_list,
-						rstat_css_node)
-				css->ss->css_rstat_flush(css, cpu);
-			rcu_read_unlock();
-		}
 		raw_spin_unlock(cpu_lock);
=20
 		/* if @may_sleep, play nice and yield if necessary */
--=20
2.23.0.rc1

