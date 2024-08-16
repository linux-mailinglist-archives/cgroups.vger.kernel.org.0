Return-Path: <cgroups+bounces-4327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD382954492
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 10:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D15B25DF0
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAB143C45;
	Fri, 16 Aug 2024 08:35:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76107136E21;
	Fri, 16 Aug 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797310; cv=none; b=PfAgzbYktOM8I0rVXl5NGi0MJD+2alYdRbzprerHvapeUqF4bfBq5VFwBZPzyr7TlEnlF6IJpxeUxJd6BRU0fOvm6KAiOZEpXRnfUtRXFw0LnxDxSNPvD9+EnRQZD6yMI4NC2qkT5WWcJX9DkmWZhxG9YnVr6xkC2TYMXD1E3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797310; c=relaxed/simple;
	bh=SCwFfgAFPR5wylSjlK+s1jBfcRqdchYZvSsCvVnfYPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VoPqmpTzqNxAK0nHt2/ptXEfMgJBYtiSWM9/lhL7ouyITTzjIEhNoV9GRp6rfhvKOcn4i/QXURx/ZZElB3fdduidV9vVqPLLCWxWzOJ3nwjBrCnuAhfiKVtvyYhx3GDEFeeTiD+8WSYAS/aiVB/kJX6d1obFXSAKmCfIP5Sly/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WlZtT4cMTz1j6YG;
	Fri, 16 Aug 2024 16:30:09 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id E183C1A016C;
	Fri, 16 Aug 2024 16:35:03 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 16 Aug
 2024 16:35:03 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 3/3] cgroup/cpuset: remove use_parent_ecpus of cpuset
Date: Fri, 16 Aug 2024 08:27:27 +0000
Message-ID: <20240816082727.2779-4-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816082727.2779-1-chenridong@huawei.com>
References: <20240816082727.2779-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)

use_parent_ecpus is used to track whether the children are using the
parent's effective_cpus. When a parent's effective_cpus is changed
due to changes in a child partition's effective_xcpus, any child
using parent'effective_cpus must call update_cpumasks_hier. However,
if a child is not a valid partition, it is sufficient to determine
whether to call update_cpumasks_hier based on whether the child's
effective_cpus is going to change. To make the code more succinct,
it is suggested to remove use_parent_ecpus.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8be0259065f5..71c24542966b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -185,12 +185,6 @@ struct cpuset {
 	/* partition root state */
 	int partition_root_state;
 
-	/*
-	 * Default hierarchy only:
-	 * use_parent_ecpus - set if using parent's effective_cpus
-	 */
-	int use_parent_ecpus;
-
 	/*
 	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
 	 * know when to rebuild associated root domain bandwidth information.
@@ -1505,11 +1499,8 @@ static void reset_partition_data(struct cpuset *cs)
 		if (is_cpu_exclusive(cs))
 			clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
 	}
-	if (!cpumask_and(cs->effective_cpus,
-			 parent->effective_cpus, cs->cpus_allowed)) {
-		cs->use_parent_ecpus = true;
+	if (!cpumask_and(cs->effective_cpus, parent->effective_cpus, cs->cpus_allowed))
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
-	}
 }
 
 /*
@@ -1683,8 +1674,6 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
-	if (cs->use_parent_ecpus)
-		cs->use_parent_ecpus = false;
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
@@ -2309,13 +2298,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * it is a partition root that has explicitly distributed
 		 * out all its CPUs.
 		 */
-		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
+		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus))
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
-			if (!cp->use_parent_ecpus)
-				cp->use_parent_ecpus = true;
-		} else if (cp->use_parent_ecpus) {
-			cp->use_parent_ecpus = false;
-		}
 
 		if (remote)
 			goto get_css;
@@ -2452,8 +2436,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	 * Check all its siblings and call update_cpumasks_hier()
 	 * if their effective_cpus will need to be changed.
 	 *
-	 * With the addition of effective_xcpus which is a subset of
-	 * cpus_allowed. It is possible a change in parent's effective_cpus
+	 * It is possible a change in parent's effective_cpus
 	 * due to a change in a child partition's effective_xcpus will impact
 	 * its siblings even if they do not inherit parent's effective_cpus
 	 * directly.
@@ -2467,8 +2450,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	cpuset_for_each_child(sibling, pos_css, parent) {
 		if (sibling == cs)
 			continue;
-		if (!sibling->use_parent_ecpus &&
-		    !is_partition_valid(sibling)) {
+		if (!is_partition_valid(sibling)) {
 			compute_effective_cpumask(tmp->new_cpus, sibling,
 						  parent);
 			if (cpumask_equal(tmp->new_cpus, sibling->effective_cpus))
@@ -4128,7 +4110,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
-		cs->use_parent_ecpus = true;
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -4194,9 +4175,6 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	    is_sched_load_balance(cs))
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
-	if (cs->use_parent_ecpus)
-		cs->use_parent_ecpus = false;
-
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-- 
2.34.1


