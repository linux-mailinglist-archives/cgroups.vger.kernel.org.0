Return-Path: <cgroups+bounces-5504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3637B9C30A2
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 03:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3755B2170A
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2014600C;
	Sun, 10 Nov 2024 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdvTWDqt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21121428E7
	for <cgroups@vger.kernel.org>; Sun, 10 Nov 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731207071; cv=none; b=eB9IduVNQ3wtvayxr8J9bbLbYQMG6Lz4myCC9GSLxg173/r4iBrFtNbZeHtRgfgMFKna069QcGtNesN3Zw+L3lJL9xxXUHODu3u1+zEpueE3OzQOz2lB5boApNLATUEYWLK8zMDtL5lKlpVN80C4P1GB+7raIHzf3oYzHE+ztJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731207071; c=relaxed/simple;
	bh=DfO1JOsqzbqASInTeV9hHIzImiQVdyIjji/vA4kwjNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+Y8uw+vZOnkFFJlQmxQmJDzjx8p7OvZVT+XcoavPvu8R/5G9eyRhQ6VffiLCNUODcS75WtIoEhAZgKjOzW0gpEUzePc/ULOgi5W3YEcHstoEtTWCRCCTAh67hQi3vftVkZ970KBFzCZVP27YkwfMlKtBTMVLwdsxaOXvePR5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdvTWDqt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731207067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O37r0KO3DmNZhw8U4o1ldqxUUb1pNcn1hd7Mfod66L0=;
	b=bdvTWDqtUZjw1qmgCOfR23rsDrMRch1hKSCRXIjJdBejI+zQaB95Mp/2D7b1FHX6SzddKi
	yq5YL/IkE0h4TsFfNn0eVTqnelwrOWtLIvI/65KmXNjdh3EuF/DBqDGTrvuMej9MHc2vht
	pVHYC1ubuzrdb9kYVzLoE8+zzpA9RHE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-T1oFcOKPPu2ANKJnxQYTSA-1; Sat,
 09 Nov 2024 21:51:06 -0500
X-MC-Unique: T1oFcOKPPu2ANKJnxQYTSA-1
X-Mimecast-MFC-AGG-ID: T1oFcOKPPu2ANKJnxQYTSA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B0A21956096;
	Sun, 10 Nov 2024 02:51:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D86EB300019E;
	Sun, 10 Nov 2024 02:51:01 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] cgroup/cpuset: Revert "Allow suppression of sched domain rebuild in update_cpumasks_hier()"
Date: Sat,  9 Nov 2024 21:50:21 -0500
Message-ID: <20241110025023.664487-2-longman@redhat.com>
In-Reply-To: <20241110025023.664487-1-longman@redhat.com>
References: <20241110025023.664487-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Revert commit 3ae0b773211e ("cgroup/cpuset: Allow suppression of sched
domain rebuild in update_cpumasks_hier()") to allow for an alternative
way to suppress unnecessary rebuild_sched_domains_locked() calls in
update_cpumasks_hier() and elsewhere in a following commit.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a4dd285cdf39..565280193922 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1922,12 +1922,6 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
 	rcu_read_unlock();
 }
 
-/*
- * update_cpumasks_hier() flags
- */
-#define HIER_CHECKALL		0x01	/* Check all cpusets with no skipping */
-#define HIER_NO_SD_REBUILD	0x02	/* Don't rebuild sched domains */
-
 /*
  * update_cpumasks_hier - Update effective cpumasks and tasks in the subtree
  * @cs:  the cpuset to consider
@@ -1942,7 +1936,7 @@ static void compute_partition_effective_cpumask(struct cpuset *cs,
  * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
-				 int flags)
+				 bool force)
 {
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
@@ -2007,10 +2001,10 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * Skip the whole subtree if
 		 * 1) the cpumask remains the same,
 		 * 2) has no partition root state,
-		 * 3) HIER_CHECKALL flag not set, and
+		 * 3) force flag not set, and
 		 * 4) for v2 load balance state same as its parent.
 		 */
-		if (!cp->partition_root_state && !(flags & HIER_CHECKALL) &&
+		if (!cp->partition_root_state && !force &&
 		    cpumask_equal(tmp->new_cpus, cp->effective_cpus) &&
 		    (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
 		    (is_sched_load_balance(parent) == is_sched_load_balance(cp)))) {
@@ -2112,8 +2106,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD) &&
-	    !force_sd_rebuild)
+	if (need_rebuild_sched_domains && !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -2141,9 +2134,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	 * directly.
 	 *
 	 * The update_cpumasks_hier() function may sleep. So we have to
-	 * release the RCU read lock before calling it. HIER_NO_SD_REBUILD
-	 * flag is used to suppress rebuild of sched domains as the callers
-	 * will take care of that.
+	 * release the RCU read lock before calling it.
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, pos_css, parent) {
@@ -2159,7 +2150,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 			continue;
 
 		rcu_read_unlock();
-		update_cpumasks_hier(sibling, tmp, HIER_NO_SD_REBUILD);
+		update_cpumasks_hier(sibling, tmp, false);
 		rcu_read_lock();
 		css_put(&sibling->css);
 	}
@@ -2179,7 +2170,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	struct tmpmasks tmp;
 	struct cpuset *parent = parent_cs(cs);
 	bool invalidate = false;
-	int hier_flags = 0;
+	bool force = false;
 	int old_prs = cs->partition_root_state;
 
 	/* top_cpuset.cpus_allowed tracks cpu_online_mask; it's read-only */
@@ -2240,8 +2231,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * Check all the descendants in update_cpumasks_hier() if
 	 * effective_xcpus is to be changed.
 	 */
-	if (!cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus))
-		hier_flags = HIER_CHECKALL;
+	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
 	retval = validate_change(cs, trialcs);
 
@@ -2309,7 +2299,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	spin_unlock_irq(&callback_lock);
 
 	/* effective_cpus/effective_xcpus will be updated here */
-	update_cpumasks_hier(cs, &tmp, hier_flags);
+	update_cpumasks_hier(cs, &tmp, force);
 
 	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
 	if (cs->partition_root_state)
@@ -2334,7 +2324,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	struct tmpmasks tmp;
 	struct cpuset *parent = parent_cs(cs);
 	bool invalidate = false;
-	int hier_flags = 0;
+	bool force = false;
 	int old_prs = cs->partition_root_state;
 
 	if (!*buf) {
@@ -2357,8 +2347,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * Check all the descendants in update_cpumasks_hier() if
 	 * effective_xcpus is to be changed.
 	 */
-	if (!cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus))
-		hier_flags = HIER_CHECKALL;
+	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
 
 	retval = validate_change(cs, trialcs);
 	if (retval)
@@ -2411,8 +2400,8 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 * of the subtree when it is a valid partition root or effective_xcpus
 	 * is updated.
 	 */
-	if (is_partition_valid(cs) || hier_flags)
-		update_cpumasks_hier(cs, &tmp, hier_flags);
+	if (is_partition_valid(cs) || force)
+		update_cpumasks_hier(cs, &tmp, force);
 
 	/* Update CS_SCHED_LOAD_BALANCE and/or sched_domains, if necessary */
 	if (cs->partition_root_state)
@@ -2853,7 +2842,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	update_unbound_workqueue_cpumask(new_xcpus_state);
 
 	/* Force update if switching back to member */
-	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
+	update_cpumasks_hier(cs, &tmpmask, !new_prs);
 
 	/* Update sched domains and load balance flag */
 	update_partition_sd_lb(cs, old_prs);
-- 
2.47.0


