Return-Path: <cgroups+bounces-17108-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id awCbJdJaN2pLMwcAu9opvQ
	(envelope-from <cgroups+bounces-17108-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:30:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E61E6AA1A8
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IVpwJceA;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17108-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17108-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 288AD30143F9
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91830C14E;
	Sun, 21 Jun 2026 03:29:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC81305E28
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 03:29:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012566; cv=none; b=eqKXaEqxnZvdx4+ECTifRyXdP5nRZdv5a1PfosDLCqASxFhwzywV0ag4DSokrg3Kbpfq1J0GsGg8olhxR/nYCAbvMNedXS8OV75SD/wt64WC0XF69DcN/nXnlvthL7wNkAYD+nHEoAqy0qINTe6E4Wmo98FUe5Obw+PngA0w3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012566; c=relaxed/simple;
	bh=uRlTGpIgPUjXMTeM7vdD1nEN8CXBybTOKfAzMDPhVQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uksrck12FJOv1NeXoasRfgXnAU/HHtPxvXwGDMhZHWrF84PdHWlxcE8pL+VOKVLnZ3HZfedxKwBVCIY5nrU8ocmPJtMHa8ts3Wp74x7kkbjs3R0svmhCD8QSg1Cx0h8eHBD4RDXwBLGkeSBzD4PFZY26A+fJISCwiwdojW3w26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVpwJceA; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782012564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciTuAl1PM3SgYhMElc0WzP2Qs/UtDyqgrppcUWKHdUU=;
	b=IVpwJceAV2LDKCpFmOq8Y8Fd1ASee/9ZoZw3kp4UcPZHq5jH0bSlN3rRyawZ0jhjBfbNTB
	s7e9r2fqANxQoSjo2/5XHVwCvuU838/qkD/pcFIFrYKuEU6OAyCpkhK7BKTR4ke/e74SyD
	F5Hy7r0PGkc0MUNpwUIQHwJOWxX7qqE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-j-XQ9vPtOqmLqy0aohgxDw-1; Sat,
 20 Jun 2026 23:29:20 -0400
X-MC-Unique: j-XQ9vPtOqmLqy0aohgxDw-1
X-Mimecast-MFC-AGG-ID: j-XQ9vPtOqmLqy0aohgxDw_1782012558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C419B1956057;
	Sun, 21 Jun 2026 03:29:18 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2C19195604D;
	Sun, 21 Jun 2026 03:29:16 +0000 (UTC)
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
Subject: [PATCH v7 9/9] cgroup/cpuset: Support multiple destination cpusets for cpuset_*attach()
Date: Sat, 20 Jun 2026 23:28:16 -0400
Message-ID: <20260621032816.1806773-10-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17108-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E61E6AA1A8

The only case where the cgroup_taskset structure requires task migration
to multiple cpusets is when enabling a cpuset controller in cgroup v2
where the newly created child cpusets inherits the same effective CPUs
and memory nodes from the parent. In that case, task migration can happen
directly with no update to tasks' CPU and memory nodes assignment and no
further work needed from the cpuset side exact updating nr_deadline_tasks
when DL tasks are involved and setting old_mems_allowed in the child
cpusets.

Do that by tracking all the destination cpusets with a new dst_cs_head
singly linked list again with the setting of attach_in_progress
associated with the insertion into the list.

It is assumed that a given cpuset cannot be both a source and a
destination cpuset. If such condition happens or when there are multiple
destination cpusets with CPU or memory nodes changes, the current code
will not handle it correctly. So it will print a warning and fail the
attach operation in these unexpected cases as we will have to enhance
the code to support this if such use cases are valid and not coding bugs.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |   1 +
 kernel/cgroup/cpuset.c          | 121 +++++++++++++++++++-------------
 2 files changed, 75 insertions(+), 47 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 011993b1f756..900e74ac3538 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -151,6 +151,7 @@ struct cpuset {
 	 */
 	struct llist_node attach_node;
 	int attach_in_progress;
+	bool attach_source;
 
 	/* partition root state */
 	int partition_root_state;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c2d172873166..aff86acea701 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2986,11 +2986,16 @@ static int update_prstate(struct cpuset *cs, int new_prs)
  *
  * The attach_cpus_updated/attach_mems_updated flags are set in either
  * cpuset_can_attach() or cpuset_fork() and used in cpuset_attach_task().
+ *
+ * The attach_many_dest_cs is set when there are multiple destination cpusets
+ * for task migration.
  */
 static struct cpuset *cpuset_attach_old_cs;
 static LLIST_HEAD(src_cs_head);
+static LLIST_HEAD(dst_cs_head);
 static bool attach_cpus_updated;
 static bool attach_mems_updated;
+static bool attach_many_dest_cs;
 
 /*
  * Check to see if a cpuset can accept a new task
@@ -3013,9 +3018,25 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	if (!oldcs)
 		return 0;
 
+	/*
+	 * The same cpuset cannot be both a source and a destination.
+	 * The current code does not support that, print a warning and
+	 * fail the attach if so.
+	 */
+	if (WARN_ON_ONCE((!oldcs->attach_source &&
+			  llist_on_list(&oldcs->attach_node)) ||
+			  cs->attach_source))
+		return -EINVAL;
+
 	if (!llist_on_list(&oldcs->attach_node)) {
 		llist_add(&oldcs->attach_node, &src_cs_head);
 		oldcs->attach_in_progress++;
+		oldcs->attach_source = true;
+	}
+
+	if (!llist_on_list(&cs->attach_node)) {
+		llist_add(&cs->attach_node, &dst_cs_head);
+		cs->attach_in_progress++;
 	}
 
 	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
@@ -3046,35 +3067,31 @@ static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
 	return 0;
 }
 
-static int cpuset_reserve_dl_bw(struct cpuset *cs)
+static int cpuset_reserve_dl_bw(void)
 {
+	struct cpuset *cs;
 	int cpu, ret;
 
-	if (!cs->sum_migrate_dl_bw)
-		return 0;
+	llist_for_each_entry(cs, dst_cs_head.first, attach_node) {
+		if (!cs->sum_migrate_dl_bw)
+			continue;
 
-	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-	if (unlikely(cpu >= nr_cpu_ids))
-		return -EINVAL;
+		cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+		if (unlikely(cpu >= nr_cpu_ids))
+			return -EINVAL;
 
-	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-	if (ret)
-		return ret;
+		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+		if (ret)
+			return ret;
 
-	cs->dl_bw_cpu = cpu;
+		cs->dl_bw_cpu = cpu;
+	}
 	return 0;
 }
 
-static void reset_migrate_dl_data(struct cpuset *cs)
-{
-	cs->nr_migrate_dl_tasks = 0;
-	cs->sum_migrate_dl_bw = 0;
-	cs->dl_bw_cpu = -1;
-}
-
 /*
  * Clear and optionally apply (@cancel is false) the attach related data in the
- * source cpusets.
+ * source or destination cpuset.
  */
 static void clear_attach_data(struct llist_head *head, bool cancel)
 {
@@ -3086,9 +3103,14 @@ static void clear_attach_data(struct llist_head *head, bool cancel)
 		if (cs->nr_migrate_dl_tasks) {
 			if (!cancel)
 				cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+			else if (cs->dl_bw_cpu >= 0) /* && cacnel */
+				dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
 			cs->nr_migrate_dl_tasks = 0;
+			cs->sum_migrate_dl_bw = 0;
+			cs->dl_bw_cpu = -1;
 		}
 		dec_attach_in_progress_locked(cs);
+		cs->attach_source = false;
 	}
 }
 
@@ -3109,6 +3131,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	mutex_lock(&cpuset_mutex);
 	attach_cpus_updated = false;
 	attach_mems_updated = false;
+	attach_many_dest_cs = false;
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
@@ -3133,9 +3156,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * selected as cpuset_attach_old_cs.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
+		struct cpuset *new_cs = css_cs(css);
 		struct cpuset *new_oldcs = task_cs(task);
 
-		if (new_oldcs != oldcs) {
+		if ((new_oldcs != oldcs) || (new_cs != cs)) {
+			if (new_cs != cs)
+				attach_many_dest_cs = true;
+			cs = new_cs;
 			oldcs = new_oldcs;
 			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
 			if (ret)
@@ -3169,14 +3196,28 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 	}
 
-	ret = cpuset_reserve_dl_bw(cs);
+	/*
+	 * The only case where there are multiple destination cpusets for
+	 * task migration is when enabling a v2 cpuset controllers where
+	 * tasks will be migrated to multiple child cpusets from a parent
+	 * cpuset with the same effective CPUs and memory nodes. IOW,
+	 * both attach_cpus_updated and attach_mems_updated should be false.
+	 * If not, it is a condition that the current code cannot handled.
+	 * Print a warning and abort the attach operation as further code
+	 * change will be needed.
+	 */
+	if (WARN_ON_ONCE(attach_many_dest_cs && (!cpuset_v2() ||
+			 attach_cpus_updated || attach_mems_updated))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = cpuset_reserve_dl_bw();
 
 out_unlock:
 	if (ret) {
-		reset_migrate_dl_data(cs);
 		clear_attach_data(&src_cs_head, true);
-	} else {
-		cs->attach_in_progress++;
+		clear_attach_data(&dst_cs_head, true);
 	}
 
 	mutex_unlock(&cpuset_mutex);
@@ -3185,22 +3226,9 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
-	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
-
-	cgroup_taskset_first(tset, &css);
-	cs = css_cs(css);
-
 	mutex_lock(&cpuset_mutex);
-	dec_attach_in_progress_locked(cs);
 	clear_attach_data(&src_cs_head, true);
-
-	if (cs->dl_bw_cpu >= 0)
-		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
-
-	if (cs->nr_migrate_dl_tasks)
-		reset_migrate_dl_data(cs);
-
+	clear_attach_data(&dst_cs_head, true);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -3286,26 +3314,25 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * In the default hierarchy, enabling cpuset in the child cgroups
 	 * will trigger a cpuset_attach() call with no change in effective cpus
 	 * and mems. In that case, we can optimize out by skipping the task
-	 * iteration and update.
+	 * iteration and update, but the destination cpuset list is iterated to
+	 * set old_mems_allowed.
 	 */
-	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated)
+	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated) {
+		llist_for_each_entry(cs, dst_cs_head.first, attach_node)
+			cs->old_mems_allowed = cpuset_attach_nodemask_to;
 		goto out;
+	}
 
+	/* Task iteration shouldn't happen with attach_many_dest_cs set */
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
 
-out:
 	if (queue_task_work)
 		schedule_flush_migrate_mm();
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
-
-	if (cs->nr_migrate_dl_tasks) {
-		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
-		reset_migrate_dl_data(cs);
-	}
-
+out:
 	clear_attach_data(&src_cs_head, false);
-	dec_attach_in_progress_locked(cs);
+	clear_attach_data(&dst_cs_head, false);
 
 	mutex_unlock(&cpuset_mutex);
 }
-- 
2.54.0


