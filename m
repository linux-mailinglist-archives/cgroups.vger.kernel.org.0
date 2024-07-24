Return-Path: <cgroups+bounces-3878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 753D493AFDD
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2131C2237D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29415099A;
	Wed, 24 Jul 2024 10:31:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AB1C6A3;
	Wed, 24 Jul 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817094; cv=none; b=h+vleaqLP8menq+Y8VTkgXeyXKWVJafWKbayV9v/ZrFmR0/gjVG+sgxDDyJ0vcv//SQcvxTnChsrInh5s2hSs5ciMjOXlgedNRaeebDkGLhMqA3oPlJ79XqjJBNoMr+RGQ3YuJ5P0FSdEHd+nqauVmTLOuL8QYKK2qqT0QVJZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817094; c=relaxed/simple;
	bh=w0wktJIDPkZ5XL009t7kRPm6AfiMdDyu0W+392dIUvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smKWoPmj17LkcPuPUFTpXqK9djs8w/4o+sPqWHUp0US1CjwY/M2TMAzLlb7kS1oLvT0Ewl1rzmXlCe85Y8gvPqXhfF2uRsiz3ZM9sWM9chEZffW1Vwrw58ti7ZI9l1TIoh6mA7j1AGBXqqQt43Mje/UkFgdWj598INFdeF5PR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WTVZF4mFXzQmDN;
	Wed, 24 Jul 2024 18:27:17 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id D5CD8180100;
	Wed, 24 Jul 2024 18:31:28 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 24 Jul
 2024 18:31:28 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] cgroup/cpuset: remove child_ecpus_count
Date: Wed, 24 Jul 2024 10:24:18 +0000
Message-ID: <20240724102418.2213801-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The child_ecpus_count variable was previously used to update
sibling cpumask when parent's effective_cpus is updated. However, it became
obsolete after commit e2ffe502ba45 ("cgroup/cpuset: Add
cpuset.cpus.exclusive for v2"). It should be removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 40ec4abaf440..d4322619e59a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -188,10 +188,8 @@ struct cpuset {
 	/*
 	 * Default hierarchy only:
 	 * use_parent_ecpus - set if using parent's effective_cpus
-	 * child_ecpus_count - # of children with use_parent_ecpus set
 	 */
 	int use_parent_ecpus;
-	int child_ecpus_count;
 
 	/*
 	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
@@ -1512,7 +1510,6 @@ static void reset_partition_data(struct cpuset *cs)
 	if (!cpumask_and(cs->effective_cpus,
 			 parent->effective_cpus, cs->cpus_allowed)) {
 		cs->use_parent_ecpus = true;
-		parent->child_ecpus_count++;
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 	}
 }
@@ -1688,12 +1685,8 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
-	if (cs->use_parent_ecpus) {
-		struct cpuset *parent = parent_cs(cs);
-
+	if (cs->use_parent_ecpus)
 		cs->use_parent_ecpus = false;
-		parent->child_ecpus_count--;
-	}
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
 
@@ -2318,15 +2311,10 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 */
 		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus)) {
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
-			if (!cp->use_parent_ecpus) {
+			if (!cp->use_parent_ecpus)
 				cp->use_parent_ecpus = true;
-				parent->child_ecpus_count++;
-			}
-		} else if (cp->use_parent_ecpus) {
+		} else if (cp->use_parent_ecpus)
 			cp->use_parent_ecpus = false;
-			WARN_ON_ONCE(!parent->child_ecpus_count);
-			parent->child_ecpus_count--;
-		}
 
 		if (remote)
 			goto get_css;
@@ -4139,7 +4127,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
-		parent->child_ecpus_count++;
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -4205,12 +4192,8 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	    is_sched_load_balance(cs))
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
-	if (cs->use_parent_ecpus) {
-		struct cpuset *parent = parent_cs(cs);
-
+	if (cs->use_parent_ecpus)
 		cs->use_parent_ecpus = false;
-		parent->child_ecpus_count--;
-	}
 
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
-- 
2.34.1


