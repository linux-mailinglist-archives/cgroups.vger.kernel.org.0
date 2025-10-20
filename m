Return-Path: <cgroups+bounces-10889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD35BEF164
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 04:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2487D3BFFE4
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 02:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404E29ACC5;
	Mon, 20 Oct 2025 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/WDFXjx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE128469E
	for <cgroups@vger.kernel.org>; Mon, 20 Oct 2025 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927556; cv=none; b=FL+JPKOkjd1qbCw3pTOXaQMT6tLDScPtUrNJYqRpwOnO0QNisNgNrfcbIGedP4i5YNexSTNbxNKiEhzPUbNut5ksnzMR55ZWQtjiAb9QHDWn38f5DNR8BzBBCHk5EM8z+uIcVqmFyFfWToB5fbpK2/2DrZ9l4K+yzDJVgvTh6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927556; c=relaxed/simple;
	bh=ZFH70HHYYS8se/8pH/YbN9iTnRsSUrCR+MtfKraLtI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOyY6JrgWBh7isY8tq/k5uVeFGGoFozaBDTw/xE9An6uhebtpPTPCnXRCyV35o9ui8VbNKlsVnlFROPgcikBXvkRZZ1eSYcdrgcSdrJwhxpTOnFPMZ74K/dCaTexa/iEcJXfcwErV8542YNgPCE4eatYhoAlhkEGOerFmNle/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/WDFXjx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760927554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJnK9vCTGoXNPiKeUWER4wPRwhKuIqBHuR3E/a39jYg=;
	b=h/WDFXjxJXDO2vDFm8vjyYvcDmGafUcamGS6Vo2LrNYf906djqWwBayoggt+e8kqt79Ahi
	FOeoWZYTtHy4Rr5JK0tX1/5eNMyHqgI2Fm9N1Zzq68BnUBH1rPvY4EGFXFhTJaqzEjKlDc
	BN+pThxQobzQqkcHfMUKoC8jPQO3XJM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-0GxzBX0OOvG90-zaAtF3cg-1; Sun,
 19 Oct 2025 22:32:30 -0400
X-MC-Unique: 0GxzBX0OOvG90-zaAtF3cg-1
X-Mimecast-MFC-AGG-ID: 0GxzBX0OOvG90-zaAtF3cg_1760927549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7931E1800592;
	Mon, 20 Oct 2025 02:32:29 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89E15180057E;
	Mon, 20 Oct 2025 02:32:27 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] cgroup/cpuset: Don't track # of local child partitions
Date: Sun, 19 Oct 2025 22:32:06 -0400
Message-ID: <20251020023207.177809-2-longman@redhat.com>
In-Reply-To: <20251020023207.177809-1-longman@redhat.com>
References: <20251020023207.177809-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The cpuset structure has a nr_subparts field which tracks the number
of child local partitions underneath a particular cpuset. Right now,
nr_subparts is only used in partition_is_populated() to avoid iteration
of child cpusets if the condition is right. So by always performing the
child iteration, we can avoid tracking the number of child partitions
and simplify the code a bit.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |  3 ---
 kernel/cgroup/cpuset.c          | 41 +++++++++++----------------------
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 337608f408ce..5cac42c5fd97 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -155,9 +155,6 @@ struct cpuset {
 	/* for custom sched domain */
 	int relax_domain_level;
 
-	/* number of valid local child partitions */
-	int nr_subparts;
-
 	/* partition root state */
 	int partition_root_state;
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..7aef59ea9627 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -358,8 +358,13 @@ static inline bool is_in_v2_mode(void)
  * @excluded_child: a child cpuset to be excluded in task checking
  * Return: true if there are tasks, false otherwise
  *
- * It is assumed that @cs is a valid partition root. @excluded_child should
- * be non-NULL when this cpuset is going to become a partition itself.
+ * @cs should be a valid partition root or going to become a partition root.
+ * @excluded_child should be non-NULL when this cpuset is going to become a
+ * partition itself.
+ *
+ * Note that a remote partition is not allowed underneath a valid local
+ * or remote partition. So if a non-partition root child is populated,
+ * the whole partition is considered populated.
  */
 static inline bool partition_is_populated(struct cpuset *cs,
 					  struct cpuset *excluded_child)
@@ -369,8 +374,6 @@ static inline bool partition_is_populated(struct cpuset *cs,
 
 	if (cs->css.cgroup->nr_populated_csets)
 		return true;
-	if (!excluded_child && !cs->nr_subparts)
-		return cgroup_is_populated(cs->css.cgroup);
 
 	rcu_read_lock();
 	cpuset_for_each_child(child, css, cs) {
@@ -1302,7 +1305,6 @@ static void reset_partition_data(struct cpuset *cs)
 
 	lockdep_assert_held(&callback_lock);
 
-	cs->nr_subparts = 0;
 	if (cpumask_empty(cs->exclusive_cpus)) {
 		cpumask_clear(cs->effective_xcpus);
 		if (is_cpu_exclusive(cs))
@@ -1746,7 +1748,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int deleting;	/* Deleting cpus from parent's effective_cpus	*/
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
-	int subparts_delta = 0;
 	int isolcpus_updated = 0;
 	struct cpumask *xcpus = user_xcpus(cs);
 	bool nocpu;
@@ -1771,10 +1772,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (is_partition_valid(parent))
 			adding = cpumask_and(tmp->addmask,
 					     xcpus, parent->effective_xcpus);
-		if (old_prs > 0) {
+		if (old_prs > 0)
 			new_prs = -old_prs;
-			subparts_delta--;
-		}
+
 		goto write_error;
 	}
 
@@ -1829,7 +1829,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
 
 		deleting = true;
-		subparts_delta++;
 	} else if (cmd == partcmd_disable) {
 		/*
 		 * May need to add cpus back to parent's effective_cpus
@@ -1840,7 +1839,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (is_partition_valid(cs)) {
 			cpumask_copy(tmp->addmask, cs->effective_xcpus);
 			adding = true;
-			subparts_delta--;
 		}
 		new_prs = PRS_MEMBER;
 	} else if (newmask) {
@@ -1963,17 +1961,13 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		switch (cs->partition_root_state) {
 		case PRS_ROOT:
 		case PRS_ISOLATED:
-			if (part_error) {
+			if (part_error)
 				new_prs = -old_prs;
-				subparts_delta--;
-			}
 			break;
 		case PRS_INVALID_ROOT:
 		case PRS_INVALID_ISOLATED:
-			if (!part_error) {
+			if (!part_error)
 				new_prs = -old_prs;
-				subparts_delta++;
-			}
 			break;
 		}
 	}
@@ -2002,11 +1996,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
 	spin_lock_irq(&callback_lock);
-	if (old_prs != new_prs) {
+	if (old_prs != new_prs)
 		cs->partition_root_state = new_prs;
-		if (new_prs <= 0)
-			cs->nr_subparts = 0;
-	}
+
 	/*
 	 * Adding to parent's effective_cpus means deletion CPUs from cs
 	 * and vice versa.
@@ -2018,10 +2010,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		isolcpus_updated += partition_xcpus_add(new_prs, parent,
 							tmp->delmask);
 
-	if (is_partition_valid(parent)) {
-		parent->nr_subparts += subparts_delta;
-		WARN_ON_ONCE(parent->nr_subparts < 0);
-	}
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
@@ -2105,8 +2093,6 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 			 */
 			spin_lock_irq(&callback_lock);
 			make_partition_invalid(child);
-			cs->nr_subparts--;
-			child->nr_subparts = 0;
 			spin_unlock_irq(&callback_lock);
 			notify_partition_change(child, old_prs);
 			continue;
@@ -4021,7 +4007,6 @@ static void cpuset_handle_hotplug(void)
 		 */
 		if (!cpumask_empty(subpartitions_cpus)) {
 			if (cpumask_subset(&new_cpus, subpartitions_cpus)) {
-				top_cpuset.nr_subparts = 0;
 				cpumask_clear(subpartitions_cpus);
 			} else {
 				cpumask_andnot(&new_cpus, &new_cpus,
-- 
2.51.0


