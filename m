Return-Path: <cgroups+bounces-3870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0693AA7B
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 03:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9918D284547
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 01:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119D33C9;
	Wed, 24 Jul 2024 01:15:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB48D520;
	Wed, 24 Jul 2024 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783725; cv=none; b=HloCPHIufDBmv0FfF9t0fVNJ9f4XrbNOUvy2JdSNkeIdv1xjnFctpqgMFXAIJZQZ5mKUUO3S3Sy9OusVrijOwBuTMQEzgJjh0sNwH+sIiZcyE5yZDdPeGU/8NwDmoMgVbgekc/CT/kaT14Z0dGJxaWJXEwb+Qy+ZjCsVd9PN7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783725; c=relaxed/simple;
	bh=lW2m5iVKPpm0+RMHbNOubqiUOyTGy/9/MrRD/c2T7tE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZILjxYBQFo3J4XeoCfPemC06WkbNJOhALmWXSmkji340QsD3oy7FLsm0qFt4UfPdk795Z0RnN0IJXU08YQmDsLTr+KNYJdjGrqjFrff8Zgq86ay+xus5mj5V1wmQ8yjEEezK9UcMrXsip1qELk51g/Yoif2Rjb7ANxFZ4rqmpa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WTGD9732fz2ClSf;
	Wed, 24 Jul 2024 09:10:49 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EE9918002B;
	Wed, 24 Jul 2024 09:15:14 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 24 Jul
 2024 09:15:13 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/cpuset: remove child_ecpus_count
Date: Wed, 24 Jul 2024 01:08:03 +0000
Message-ID: <20240724010803.2195033-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)

The child_ecpus_count variable was previously used to update
sibling cpumask when parent's effective_cpus is updated. However, it became
obsolete after commit e2ffe502ba45 ("cgroup/cpuset: Add
cpuset.cpus.exclusive for v2"). It should be removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 40ec4abaf440..146bf9258db2 100644
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
@@ -1689,10 +1686,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	if (cs->use_parent_ecpus) {
-		struct cpuset *parent = parent_cs(cs);
-
 		cs->use_parent_ecpus = false;
-		parent->child_ecpus_count--;
 	}
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
@@ -2320,12 +2314,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
 			if (!cp->use_parent_ecpus) {
 				cp->use_parent_ecpus = true;
-				parent->child_ecpus_count++;
 			}
 		} else if (cp->use_parent_ecpus) {
 			cp->use_parent_ecpus = false;
-			WARN_ON_ONCE(!parent->child_ecpus_count);
-			parent->child_ecpus_count--;
 		}
 
 		if (remote)
@@ -4139,7 +4130,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
-		parent->child_ecpus_count++;
 	}
 	spin_unlock_irq(&callback_lock);
 
@@ -4206,10 +4196,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	if (cs->use_parent_ecpus) {
-		struct cpuset *parent = parent_cs(cs);
-
 		cs->use_parent_ecpus = false;
-		parent->child_ecpus_count--;
 	}
 
 	cpuset_dec();
-- 
2.34.1


