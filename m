Return-Path: <cgroups+bounces-5505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20D9C30A3
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 03:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315F5B2180F
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041D5FB8D;
	Sun, 10 Nov 2024 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bv7RgIuD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1316145B10
	for <cgroups@vger.kernel.org>; Sun, 10 Nov 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731207072; cv=none; b=tI1NEop2drc1CCgvFLECrheU1CyaE8WFnAWndNdF3vUG+togQYy7+NudQsL8GFPVR75k9wLNyd6rySUfXMMvsSTP1JZVwInjVpsfvK6brM20KxS43k1M3kg35dHzdJ2k/03aSv0cIwNS4n/Kypmf3w0IPmrCZakMMGDek7a/ZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731207072; c=relaxed/simple;
	bh=VkABoRS40YwKCapl/BEodM6a31840wxOObed6PtN25Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqtiiRwtv9A2tW0pYJDQO5manc/V79yy27Q35h75yeEF7JTE03ZdLVV0qgp2bbx0gnsT5YhvAK9yIrI5nSGMPus6hO2JSpKid3QdBvpZhGjfGNb9DN1K1vPFF9+OZdBxh6dpKEYp7WTk6++ohSczp9p8NLWNYJjMl2kqh19SIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bv7RgIuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731207069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Av4tAKFK4UZNMFciRKYaBpM+xzAwa9/mZjq8A81Jims=;
	b=bv7RgIuDyxrZPxPrIlTuI7RHc7h0efkKqFu56bTSvgl0zi45PMxdXTaWSsil8eyPlnFSNv
	70vqpJZU/+sqdfFsAlbMh7gGYa/rS6sB0zvTP0hUM+u2mlvMQeiWj7cQYQQ23etCvAI6ZQ
	8Yc8/InP91yiZWDT9gFnaNpKgjtMuVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-Kt63064kNEa6r180dQo0Ug-1; Sat,
 09 Nov 2024 21:51:08 -0500
X-MC-Unique: Kt63064kNEa6r180dQo0Ug-1
X-Mimecast-MFC-AGG-ID: Kt63064kNEa6r180dQo0Ug
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A4361956089;
	Sun, 10 Nov 2024 02:51:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6317300019F;
	Sun, 10 Nov 2024 02:51:04 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] cgroup/cpuset: Enforce at most one rebuild_sched_domains_locked() call per operation
Date: Sat,  9 Nov 2024 21:50:22 -0500
Message-ID: <20241110025023.664487-3-longman@redhat.com>
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

Since commit ff0ce721ec21 ("cgroup/cpuset: Eliminate unncessary
sched domains rebuilds in hotplug"), there is only one
rebuild_sched_domains_locked() call per hotplug operation. However,
writing to the various cpuset control files may still casue more than
one rebuild_sched_domains_locked() call to happen in some cases.

Juri had found that two rebuild_sched_domains_locked() calls in
update_prstate(), one from update_cpumasks_hier() and another one from
update_partition_sd_lb() could cause cpuset partition to be created
with null total_bw for DL tasks. IOW, DL tasks may not be scheduled
correctly in such a partition.

A sample command sequence that can reproduce null total_bw is as
follows.

  # echo Y >/sys/kernel/debug/sched/verbose
  # echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control
  # mkdir /sys/fs/cgroup/test
  # echo 0-7 > /sys/fs/cgroup/test/cpuset.cpus
  # echo 6-7 > /sys/fs/cgroup/test/cpuset.cpus.exclusive
  # echo root >/sys/fs/cgroup/test/cpuset.cpus.partition

Fix this double rebuild_sched_domains_locked() calls problem
by replacing existing calls with cpuset_force_rebuild() except
the rebuild_sched_domains_cpuslocked() call at the end of
cpuset_handle_hotplug(). Checking of the force_sd_rebuild flag is
now done at the end of cpuset_write_resmask() and update_prstate()
to determine if rebuild_sched_domains_locked() should be called or not.

The cpuset v1 code can still call rebuild_sched_domains_locked()
directly as double rebuild_sched_domains_locked() calls is not possible.

Reported-by: Juri Lelli <juri.lelli@redhat.com>
Closes: https://lore.kernel.org/lkml/ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb/
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 49 ++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 565280193922..0d56a226c522 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -84,9 +84,19 @@ static bool		have_boot_isolcpus;
 static struct list_head remote_children;
 
 /*
- * A flag to force sched domain rebuild at the end of an operation while
- * inhibiting it in the intermediate stages when set. Currently it is only
- * set in hotplug code.
+ * A flag to force sched domain rebuild at the end of an operation.
+ * It can be set in
+ *  - update_partition_sd_lb()
+ *  - remote_partition_check()
+ *  - update_cpumasks_hier()
+ *  - cpuset_update_flag()
+ *  - cpuset_hotplug_update_tasks()
+ *  - cpuset_handle_hotplug()
+ *
+ * Protected by cpuset_mutex (with cpus_read_lock held) or cpus_write_lock.
+ *
+ * Note that update_relax_domain_level() in cpuset-v1.c can still call
+ * rebuild_sched_domains_locked() directly without using this flag.
  */
 static bool force_sd_rebuild;
 
@@ -990,6 +1000,7 @@ void rebuild_sched_domains_locked(void)
 
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&cpuset_mutex);
+	force_sd_rebuild = false;
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1164,8 +1175,8 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
-	if (rebuild_domains && !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (rebuild_domains)
+		cpuset_force_rebuild();
 }
 
 /*
@@ -1512,8 +1523,8 @@ static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
 			remote_partition_disable(child, tmp);
 			disable_cnt++;
 		}
-	if (disable_cnt && !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (disable_cnt)
+		cpuset_force_rebuild();
 }
 
 /*
@@ -2106,8 +2117,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains && !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (need_rebuild_sched_domains)
+		cpuset_force_rebuild();
 }
 
 /**
@@ -2726,9 +2737,13 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
 
-	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed &&
-	    !force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed) {
+		if (!IS_ENABLED(CONFIG_CPUSETS_V1) ||
+		    cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+			cpuset_force_rebuild();
+		else
+			rebuild_sched_domains_locked();
+	}
 
 	if (spread_flag_changed)
 		cpuset1_update_tasks_flags(cs);
@@ -2848,6 +2863,8 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	update_partition_sd_lb(cs, old_prs);
 
 	notify_partition_change(cs, old_prs);
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
 	free_cpumasks(NULL, &tmpmask);
 	return 0;
 }
@@ -3141,6 +3158,8 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	}
 
 	free_cpuset(trialcs);
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
@@ -3885,11 +3904,9 @@ static void cpuset_handle_hotplug(void)
 		rcu_read_unlock();
 	}
 
-	/* rebuild sched domains if cpus_allowed has changed */
-	if (force_sd_rebuild) {
-		force_sd_rebuild = false;
+	/* rebuild sched domains if necessary */
+	if (force_sd_rebuild)
 		rebuild_sched_domains_cpuslocked();
-	}
 
 	free_cpumasks(NULL, ptmp);
 }
-- 
2.47.0


