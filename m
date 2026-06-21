Return-Path: <cgroups+bounces-17107-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pUDoBNVbN2pxMwcAu9opvQ
	(envelope-from <cgroups+bounces-17107-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:34:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F406AA1FD
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=U3UA0zDo;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17107-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17107-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8480D3034B08
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 03:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F73093CF;
	Sun, 21 Jun 2026 03:29:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C305685
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 03:29:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012566; cv=none; b=bsBFMghUruXFZ5yX+zjiLAHRnMUgdW3l8tryW5uBxt4OsCL6jV6CrVFUF4nE2z+Z8IDwi0R7N2jtD/wbnI3RxmFH3Tsdq3Yw+OxUNymncdv8si9fjWItp2eXcU6xHQyWi86pusv3BO8fZIutHNnRe+dfawlNxMjzN3xxQJ1n59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012566; c=relaxed/simple;
	bh=iyk+ssrUijXB/1XMdJKkGewxTfTbVIoV055FI/z45yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDe+ULJiT1PhUOAUqhYWChQ5sxBwnMvHbyWw05X7CiQ4Y4PeS2fZPn7EJ0o2/ZfAEBavfx60YG5U46tySjhiQEdhxh6CIzCnH0vCoPsDNu3VIFBwdEyhJdRJjLQedGw0EBoUEYUor6oFT03ihBzvW3AgO2jJ8sutc6sFPVLG/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3UA0zDo; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782012564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTbbqFbcQG8jmnLSPj0i66gU29fnMN9jsI5+qimyEsU=;
	b=U3UA0zDog7KD70DUTek+bSUpaZAqtLne6D8pXI0NwT6l451h+VoeMV+bMHSBAxmV76ab24
	qVUcL+/o3Jo1E1CYY2KXEF74liAAlV92e7w7stj9lFvTKiyWTi8shulFh5O3CJWz9Zb0bd
	xGbafcCzdY8qHf8ro11FjKKAXBkfWFY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-4xYWOM9IOwS6D6BFz3vXmQ-1; Sat,
 20 Jun 2026 23:29:18 -0400
X-MC-Unique: 4xYWOM9IOwS6D6BFz3vXmQ-1
X-Mimecast-MFC-AGG-ID: 4xYWOM9IOwS6D6BFz3vXmQ_1782012556
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BB931956065;
	Sun, 21 Jun 2026 03:29:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F531195604D;
	Sun, 21 Jun 2026 03:29:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v7 8/9] cgroup/cpuset: Support multiple source cpusets for cpuset_*attach()
Date: Sat, 20 Jun 2026 23:28:15 -0400
Message-ID: <20260621032816.1806773-9-longman@redhat.com>
In-Reply-To: <20260621032816.1806773-1-longman@redhat.com>
References: <20260621032816.1806773-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17107-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60F406AA1FD

There are 2 possible scenarios where the cgroup_taskset structure
passed into the cgroup can_attach() and attach() methods can contain
task migration data with multiple source cpusets.

 - A multithread application with threads in different cpusets is
   fully migrated into a new cpuset.
 - Disabling v2 cpuset controller will move all the tasks in child
   cpusets to the parent cpuset.

The current cpuset_can_attach() and cpuset_attach() functions still
expect task migration is from one source cpuset to one destination
cpuset.

Fix that by tracking the set of source (old) cpusets in singly linked
lists with the setting of attach_in_progress flag associated with the
insertion into the list. The list will be iterated when necessary to
properly update the internal data.

To ensure proper DL tasks accounting, the nr_migrate_dl_tasks in both
the source and destination cpusets are decremented/incremented with
their values added to nr_deadline_tasks when the migration is successful.

The setting of the global attach_cpus_updated and attach_mems_updated
flags are also moved from cpuset_attach() to cpuset_can_attach() as the
correct source cpuset can no longer be determined in cpuset_attach()
and cpuset states will not be changed between cpuset_attach() and
cpuset_can_attach() with an earlier patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 66 ++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index f7aaf01f7cd5..011993b1f756 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -149,6 +149,7 @@ struct cpuset {
 	 * Tasks are being attached to this cpuset.  Used to prevent
 	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
 	 */
+	struct llist_node attach_node;
 	int attach_in_progress;
 
 	/* partition root state */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 511afb077e2d..c2d172873166 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -37,6 +37,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/task_work.h>
+#include <linux/llist.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -584,6 +585,7 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
 		return NULL;
 
 	trial->dl_bw_cpu = -1;
+	init_llist_node(&trial->attach_node);
 
 	/* Setup cpumask pointer array */
 	cpumask_var_t *pmask[4] = {
@@ -2983,9 +2985,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
  * Protected by cpuset_mutex
  *
  * The attach_cpus_updated/attach_mems_updated flags are set in either
- * cpuset_attach() or cpuset_fork() and used in cpuset_attach_task().
+ * cpuset_can_attach() or cpuset_fork() and used in cpuset_attach_task().
  */
 static struct cpuset *cpuset_attach_old_cs;
+static LLIST_HEAD(src_cs_head);
 static bool attach_cpus_updated;
 static bool attach_mems_updated;
 
@@ -3001,6 +3004,8 @@ static bool attach_mems_updated;
 static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 				   bool *psetsched)
 {
+	bool cpus_updated, mems_updated;
+
 	if (cpumask_empty(cs->effective_cpus) ||
 	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
 		return -ENOSPC;
@@ -3008,14 +3013,25 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	if (!oldcs)
 		return 0;
 
+	if (!llist_on_list(&oldcs->attach_node)) {
+		llist_add(&oldcs->attach_node, &src_cs_head);
+		oldcs->attach_in_progress++;
+	}
+
+	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
+	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	if (cpus_updated)
+		attach_cpus_updated = true;
+	if (mems_updated)
+		attach_mems_updated = true;
+
 	/*
 	 * Skip rights over task setsched check in v2 when nothing changes,
 	 * migration permission derives from hierarchy ownership in
 	 * cgroup_procs_write_permission()).
 	 */
-	*psetsched = !cpuset_v2() ||
-		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
-		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	*psetsched = !cpuset_v2() || cpus_updated || mems_updated;
 
 	/*
 	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
@@ -3056,6 +3072,26 @@ static void reset_migrate_dl_data(struct cpuset *cs)
 	cs->dl_bw_cpu = -1;
 }
 
+/*
+ * Clear and optionally apply (@cancel is false) the attach related data in the
+ * source cpusets.
+ */
+static void clear_attach_data(struct llist_head *head, bool cancel)
+{
+	struct cpuset *cs, *next;
+	struct llist_node *lnode = __llist_del_all(head);
+
+	llist_for_each_entry_safe(cs, next, lnode, attach_node) {
+		init_llist_node(&cs->attach_node);
+		if (cs->nr_migrate_dl_tasks) {
+			if (!cancel)
+				cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+			cs->nr_migrate_dl_tasks = 0;
+		}
+		dec_attach_in_progress_locked(cs);
+	}
+}
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
@@ -3071,6 +3107,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
+	attach_cpus_updated = false;
+	attach_mems_updated = false;
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
@@ -3095,6 +3133,15 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * selected as cpuset_attach_old_cs.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *new_oldcs = task_cs(task);
+
+		if (new_oldcs != oldcs) {
+			oldcs = new_oldcs;
+			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
+			if (ret)
+				goto out_unlock;
+		}
+
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
@@ -3116,6 +3163,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			 * contribute to sum_migrate_dl_bw.
 			 */
 			cs->nr_migrate_dl_tasks++;
+			oldcs->nr_migrate_dl_tasks--;
 			if (dl_task_needs_bw_move(task, cs->effective_cpus))
 				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
@@ -3126,9 +3174,9 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 out_unlock:
 	if (ret) {
 		reset_migrate_dl_data(cs);
+		clear_attach_data(&src_cs_head, true);
 	} else {
 		cs->attach_in_progress++;
-		oldcs->attach_in_progress++;
 	}
 
 	mutex_unlock(&cpuset_mutex);
@@ -3145,6 +3193,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 
 	mutex_lock(&cpuset_mutex);
 	dec_attach_in_progress_locked(cs);
+	clear_attach_data(&src_cs_head, true);
 
 	if (cs->dl_bw_cpu >= 0)
 		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
@@ -3224,7 +3273,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
 
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
@@ -3232,9 +3280,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
 	mutex_lock(&cpuset_mutex);
 	queue_task_work = false;
-
-	attach_cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
-	attach_mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
 	/*
@@ -3256,10 +3301,10 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	if (cs->nr_migrate_dl_tasks) {
 		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
 		reset_migrate_dl_data(cs);
 	}
 
+	clear_attach_data(&src_cs_head, false);
 	dec_attach_in_progress_locked(cs);
 
 	mutex_unlock(&cpuset_mutex);
@@ -3777,6 +3822,7 @@ int __init cpuset_init(void)
 	cpumask_setall(top_cpuset.effective_xcpus);
 	cpumask_setall(top_cpuset.exclusive_cpus);
 	nodes_setall(top_cpuset.effective_mems);
+	init_llist_node(&top_cpuset.attach_node);
 
 	cpuset1_init(&top_cpuset);
 
-- 
2.54.0


