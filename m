Return-Path: <cgroups+bounces-16538-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPgJMeRAHmraiAkAu9opvQ
	(envelope-from <cgroups+bounces-16538-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:33:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E17627426
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1EEA30465D7
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4B3659EB;
	Tue,  2 Jun 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq8DDmSZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC514363C62
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367545; cv=none; b=PQ9cmuoIePy3rOx+7FIpNpVGON9s0i2Saj1+HqG1R3am8ZZUH5gzHLWRYr9enb2c637P0wKfIvERf4sULe6Mv0q5wRX3Hwwe+XMfuZ2hCYINBVzcIwqjJTH4YvItLbYEVaHViqhEEYDIBeYv7QT69LqksGqtW6+F4WFXYowzEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367545; c=relaxed/simple;
	bh=XBAJxyZqUX0ALETEDD0MgcI+6Bp7AfBfOWB4lGG4Oko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTvkQqmihVAxGOw85bbpNqUFDjkBqqk5BPN50vFfDfZaOlmz+SGm2Zqn6hgQ5Xxh2adWie35YgTp6yY7plfS0sHqIj9QzYYwuJvgEBAoAXalJ6A0+nBbrvZB2JmVL2M8ATJco3lDuA4gmDhtWiYKq+CsVPhxZqYYgp5Rsy6srnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq8DDmSZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780367543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1m/cWlSGK8FWpAi8JBVhmx5QFYxTp9JmxVDregWSNs=;
	b=Cq8DDmSZvFOc7TUgBMfwhNxWNu1mEphvU0SpsTyKinAAZjoI+3tcwcbId5gZNU0GJGY+Kw
	kpKtF5mmJ/FDNL31bnMRuVWXk5Iqok+RZEFAI/O0R10KctV1bP7AaQD0FWMl1m+AoMj9e6
	+YGU/QwU6AfgtfWEJSvRm3IsYBJDrYo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-guPd016aN2CimhZFjAg3jw-1; Mon,
 01 Jun 2026 22:32:18 -0400
X-MC-Unique: guPd016aN2CimhZFjAg3jw-1
X-Mimecast-MFC-AGG-ID: guPd016aN2CimhZFjAg3jw_1780367537
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B34E8195608B;
	Tue,  2 Jun 2026 02:32:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70BCE19560A6;
	Tue,  2 Jun 2026 02:32:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v5 1/6] cgroup/cpuset: Fix node inconsistencies between cpuset_update_tasks_nodemask() and cpuset_attach()
Date: Mon,  1 Jun 2026 22:31:58 -0400
Message-ID: <20260602023203.248077-2-longman@redhat.com>
In-Reply-To: <20260602023203.248077-1-longman@redhat.com>
References: <20260602023203.248077-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-16538-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 75E17627426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

The guarantee_online_mems() function should only be useful for v1 where
mems_allowed is the same as effective_mems. With v2, the memory nodes
in effective_mems should always be a subset of node_states[N_MEMORY].
The only time that may not be true is when a memory hot-unplug operation
is in progress and a memory node is removed from node_states[N_MEMORY]
but not yet reflected in effective_mems as cpuset_handle_hotplug()
has not yet been called from cpuset_track_online_nodes(). When
cpuset_handle_hotplug() is called later, the memory node setting
of the relevant cpusets and tasks will be updated. So replacing the
guarantee_online_mems() call by just using cs->effective_mems should
be fine.

Let use the following setup for both of them and make them consistent.
 - cpuset_change_task_nodemask(): guarantee_online_mems()
 - mpol_rebind_mm(): effective_mems
 - cpuset_migrate_mm(): guarantee_online_mems()
 - old_mems_allowed: guarantee_online_mems()

So for v2, it is effectively all effective_mems. For v1, mpol_rebind_mm()
uses cpus_allowed which may differ from what guarantee_online_mems()
returns.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6bdb68689c24..987456b6d879 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2616,6 +2616,13 @@ static void *cpuset_being_rebound;
  * Iterate through each task of @cs updating its mems_allowed to the
  * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
+ *
+ * - cpuset_change_task_nodemask(): guarantee_online_mems()
+ * - mpol_rebind_mm(): effective_mems
+ * - cpuset_migrate_mm(): guarantee_online_mems()
+ * - old_mems_allowed: guarantee_online_mems()
+ *
+ * For v2, guarantee_online_mems() should just return effective_mems.
  */
 void cpuset_update_tasks_nodemask(struct cpuset *cs)
 {
@@ -2625,7 +2632,10 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 
 	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
 
-	guarantee_online_mems(cs, &newmems);
+	if (cpuset_v2())
+		newmems = cs->effective_mems;
+	else
+		guarantee_online_mems(cs, &newmems);
 
 	/*
 	 * The mpol_rebind_mm() call takes mmap_lock, which we couldn't
@@ -2650,7 +2660,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 
 		migrate = is_memory_migrate(cs);
 
-		mpol_rebind_mm(mm, &cs->mems_allowed);
+		mpol_rebind_mm(mm, &cs->effective_mems);
 		if (migrate)
 			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
 		else
@@ -3148,17 +3158,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
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
+	if (cpuset_v2()) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
-		goto out;
+		if (!cpus_updated && !mems_updated)
+			goto out;
+	} else {
+		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	}
 
-	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
-
 	cgroup_taskset_for_each(task, css, tset)
 		cpuset_attach_task(cs, task);
 
@@ -3168,7 +3179,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
 	 * not set.
 	 */
-	cpuset_attach_nodemask_to = cs->effective_mems;
 	if (!is_memory_migrate(cs) && !mems_updated)
 		goto out;
 
@@ -3176,7 +3186,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		struct mm_struct *mm = get_task_mm(leader);
 
 		if (mm) {
-			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
+			mpol_rebind_mm(mm, &cs->effective_mems);
 
 			/*
 			 * old_mems_allowed is the same with mems_allowed
-- 
2.54.0


