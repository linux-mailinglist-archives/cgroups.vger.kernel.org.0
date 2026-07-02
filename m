Return-Path: <cgroups+bounces-17445-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dTtyMHXdRmo4ewsAu9opvQ
	(envelope-from <cgroups+bounces-17445-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 23:51:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BDA6FD124
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 23:51:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Voom5fDB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17445-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17445-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E820330CBE53
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB23ABD9F;
	Thu,  2 Jul 2026 21:48:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98E3ACA79
	for <cgroups@vger.kernel.org>; Thu,  2 Jul 2026 21:48:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028926; cv=none; b=TNyqvZYThl7bE8FOUH9vD1LJJZTlq9AheKYtRvEpd4QXnXd1KTckV3hEBY3vChmTFS9u4XIOgW4XMJDe23olv3SJzwGCLv9CdsGrDEK+jVkd04b0+wdvYx9nigfYbOsKBR3pn+XQPM3myPSKtRi5DPBrWAF4dMDwqrSvQImH5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028926; c=relaxed/simple;
	bh=DtbeF9ZPKj/Pb/n2fXZxR08PULCu9eg0Of+Y4mEEc3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkOYjbtFmjWhSkEom+JzyttLC8n/6O/IrDxZsDsvVnqbaz5Su+h99W9cpXOKtC1vdBLycrOVGxzzxH373wzegIVbGifZc6q6QqXsx8gqAMk3n6UB7ufwjrxyLdJD1TG4vKGazmpUbMmglCheydReZZhvYFQR+bnD74gpG4UhbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Voom5fDB; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783028924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KvK3yC8EJQrgpGkBM9/qCJwVc5gvl+TUzrvP3UhAFw=;
	b=Voom5fDBJWDUabQKS3hwEGt0hHBvkcCBXLr1g++jWbFCERiXL3JoudKqRmKW1v/S0Zyv8m
	fWBoU8yhXjKtb4nHaRDyOqivcWRlRRfRfhALvG0EYRuH31U27UgBkPbRs0GjFJWaw5Vu5v
	C285iAW7jX/VmzU6XL40uTnvWETZdnc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-o9rRZ_pyOLa3E0OdS4XP-g-1; Thu,
 02 Jul 2026 17:48:40 -0400
X-MC-Unique: o9rRZ_pyOLa3E0OdS4XP-g-1
X-Mimecast-MFC-AGG-ID: o9rRZ_pyOLa3E0OdS4XP-g_1783028919
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D502B1863B07;
	Thu,  2 Jul 2026 21:48:38 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.58])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B91836F25;
	Thu,  2 Jul 2026 21:48:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH-next v10 02/11] cgroup/cpuset: Fix node inconsistencies between cpuset_update_tasks_nodemask() and cpuset_attach()
Date: Thu,  2 Jul 2026 17:47:48 -0400
Message-ID: <20260702214757.579012-3-longman@redhat.com>
In-Reply-To: <20260702214757.579012-1-longman@redhat.com>
References: <20260702214757.579012-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17445-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,m:gourry@gourry.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,gourry.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25BDA6FD124

Whenever memory node mask is changed, there are 4 places where the node
mask has to be updated or used.
 1) task's node mask via cpuset_change_task_nodemask()
 2) memory policy binding via mpol_rebind_mm()
 3) if memory migration is enabled, migrate from old_mems_allowed to
    the new node mask via cpuset_migrate_mm().
 4) setting old_mems_allowed

These memory actions are done in cpuset_update_tasks_nodemask() and
cpuset_attach(). However there are inconsistencies in what node masks
are being used in these 2 functions.

In cpuset_update_tasks_nodemask(),
 - cpuset_change_task_nodemask(): guarantee_online_mems()
 - mpol_rebind_mm(): mems_allowed
 - cpuset_migrate_mm(): guarantee_online_mems()
 - old_mems_allowed: guarantee_online_mems()

In cpuset_attach(),
 - cpuset_change_task_nodemask(): guarantee_online_mems()
 - mpol_rebind_mm(): effective_mems
 - cpuset_migrate_mm(): effective_mems
 - old_mems_allowed: effective_mems

These inconsistencies dates back to quite a long time ago and it is
hard to say what should be the correct values.

The guarantee_online_mems() function returns a node mask from current or
an ancestor cpuset that is a subset of node_states[N_MEMORY]. Nodes in
node_states[N_MEMORY] are all online, i.e. in node_states[N_ONLINE].
However, node in node_states[N_ONLINE] may not have memory. So
node_states[N_MEMORY] should be a subset of node_states[N_ONLINE].

The guarantee_online_mems() function should mostly be useful for v1
where mems_allowed is the same as effective_mems. With v2, the memory
nodes in effective_mems should be a subset of node_states[N_MEMORY]
except when a memory hot-unplug operation is in progress and a memory
node is removed from node_states[N_MEMORY] but not yet reflected in
the effective_mems's as cpuset_handle_hotplug() has not been called
from cpuset_track_online_nodes().

Let use the following setup for both of them and make them consistent.
 - cpuset_change_task_nodemask(): guarantee_online_mems()
 - mpol_rebind_mm(): effective_mems
 - cpuset_migrate_mm(): guarantee_online_mems()
 - old_mems_allowed: guarantee_online_mems()

So for v2, it is effectively all effective_mems most of the time. For
v1, mpol_rebind_mm() uses mems_allowed which may differ from what
guarantee_online_mems() returns, but it conforms to what the cpuset v1
documentation says with respect to setting memory policy.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 kernel/cgroup/cpuset.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c22e55d798cf..431bf210aa52 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -489,7 +489,10 @@ static void guarantee_active_cpus(struct task_struct *tsk,
  * Return in *pmask the portion of a cpusets's mems_allowed that
  * are online, with memory.  If none are online with memory, walk
  * up the cpuset hierarchy until we find one that does have some
- * online mems.  The top cpuset always has some mems online.
+ * online mems.  The top cpuset always has some mems online. With v2,
+ * effective_mems should always contain online memory nodes except
+ * during the transition period where a memory node hotunplug operation
+ * is in progress.
  *
  * One way or another, we guarantee to return some non-empty subset
  * of node_states[N_MEMORY].
@@ -2633,6 +2636,14 @@ static void *cpuset_being_rebound;
  * Iterate through each task of @cs updating its mems_allowed to the
  * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
+ *
+ * - cpuset_change_task_nodemask(): guarantee_online_mems()
+ * - mpol_rebind_mm(): effective_mems
+ * - cpuset_migrate_mm(): guarantee_online_mems()
+ * - old_mems_allowed: guarantee_online_mems()
+ *
+ * For v2, guarantee_online_mems() should return a node mask that is the same
+ * as the effective_mems of current cpuset.
  */
 void cpuset_update_tasks_nodemask(struct cpuset *cs)
 {
@@ -2641,7 +2652,6 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 	struct task_struct *task;
 
 	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
-
 	guarantee_online_mems(cs, &newmems);
 
 	/*
@@ -3159,19 +3169,16 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cpus_updated = !cpumask_equal(cs->effective_cpus,
 				      oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
-	 * will trigger a number of cpuset_attach() calls with no change
-	 * in effective cpus and mems. In that case, we can optimize out
-	 * by skipping the task iteration and update.
+	 * will trigger a cpuset_attach() call with no change in effective cpus
+	 * and mems. In that case, we can optimize out by skipping the task
+	 * iteration and update.
 	 */
-	if (cpuset_v2() && !cpus_updated && !mems_updated) {
-		cpuset_attach_nodemask_to = cs->effective_mems;
+	if (cpuset_v2() && !cpus_updated && !mems_updated)
 		goto out;
-	}
-
-	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
@@ -3182,7 +3189,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
 	 * not set.
 	 */
-	cpuset_attach_nodemask_to = cs->effective_mems;
 	if (!is_memory_migrate(cs) && !mems_updated)
 		goto out;
 
@@ -3190,7 +3196,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		struct mm_struct *mm = get_task_mm(leader);
 
 		if (mm) {
-			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
+			mpol_rebind_mm(mm, &cs->effective_mems);
 
 			/*
 			 * old_mems_allowed is the same with mems_allowed
-- 
2.54.0


