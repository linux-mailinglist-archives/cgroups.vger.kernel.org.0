Return-Path: <cgroups+bounces-4086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45094730D
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC06280E6D
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257C4204B;
	Mon,  5 Aug 2024 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsvGmmxV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0121213CFAB
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821494; cv=none; b=JdXa7wbDSUYeouk+Iyjbih1triIL9iQFB2qw6HqT4LUZuXSVksIV4U90e9Eo5MuXxvx95ONOXKnXNWRvjuPnASX/+MfoZSC+pQ5O0ct40064dTRDlsfsOPVzsAYTCHMVgkjOQDaYoBHGyy62gIk5tfSaAPRD2j/1/NeKNTrqhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821494; c=relaxed/simple;
	bh=mxtcofD8yXEaAR/bV6+10SBjgxhGaO0FQnNefKPZM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEnz1xSLrprfjufzsS+JYgKOQaIpzrIl2DsBwboYeMKHlGoYcCDPH6nKrEE6d2TRhn0o24oQfOH9Huwm8AuqGRxGzvhIXwecZ5EC7ZN5a1YZ7vDp3NueFspiMId3EpFn+183Z8Fj+v/lo4/s21DIwOYPOAID2D92GgLmVZWieVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fsvGmmxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2Qnd3fWt0i6b5mUAj4mng7D982ubzp7a0Vw45AxyrM=;
	b=fsvGmmxV5HU17NJyuJF3QZeZGAtzD/oPywjRcvGaEyZddkxy1CfRuBhhZOR5l3MEMYstv5
	KQGhnDHD5QxSTrhxXEnIu3Kg4Ixln6GaRq8tiLKvIqsB386CFiPFT5hzg9VBtWmxxd4mb1
	UfZoryF1EGHBmBZ5V9EZzxXi3Zh5hBk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-jiT3B-jtOT6E-BAjZNHBrw-1; Sun,
 04 Aug 2024 21:30:56 -0400
X-MC-Unique: jiT3B-jtOT6E-BAjZNHBrw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39266195609F;
	Mon,  5 Aug 2024 01:30:55 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEDC31955E80;
	Mon,  5 Aug 2024 01:30:52 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 3/5] cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug
Date: Sun,  4 Aug 2024 21:30:17 -0400
Message-ID: <20240805013019.724300-4-longman@redhat.com>
In-Reply-To: <20240805013019.724300-1-longman@redhat.com>
References: <20240805013019.724300-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

It was found that some hotplug operations may cause multiple
rebuild_sched_domains_locked() calls. Some of those intermediate calls
may use cpuset states not in the final correct form leading to incorrect
sched domain setting.

Fix this problem by using the existing force_rebuild flag to inhibit
immediate rebuild_sched_domains_locked() calls if set and only doing
one final call at the end. Also renaming the force_rebuild flag to
force_sd_rebuild to make its meaning for clear.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7287cecb27d1..e070e391d7a8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -231,6 +231,13 @@ static cpumask_var_t	isolated_cpus;
 /* List of remote partition root children */
 static struct list_head remote_children;
 
+/*
+ * A flag to force sched domain rebuild at the end of an operation while
+ * inhibiting it in the intermediate stages when set. Currently it is only
+ * set in hotplug code.
+ */
+static bool force_sd_rebuild;
+
 /*
  * Partition root states:
  *
@@ -1467,7 +1474,7 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
 			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 	}
 
-	if (rebuild_domains)
+	if (rebuild_domains && !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -1820,7 +1827,7 @@ static void remote_partition_check(struct cpuset *cs, struct cpumask *newmask,
 			remote_partition_disable(child, tmp);
 			disable_cnt++;
 		}
-	if (disable_cnt)
+	if (disable_cnt && !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -2425,7 +2432,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 	}
 	rcu_read_unlock();
 
-	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD))
+	if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD) &&
+	    !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 }
 
@@ -3087,7 +3095,8 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
 
-	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
+	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed &&
+	    !force_sd_rebuild)
 		rebuild_sched_domains_locked();
 
 	if (spread_flag_changed)
@@ -4468,11 +4477,9 @@ hotplug_update_tasks(struct cpuset *cs,
 		update_tasks_nodemask(cs);
 }
 
-static bool force_rebuild;
-
 void cpuset_force_rebuild(void)
 {
-	force_rebuild = true;
+	force_sd_rebuild = true;
 }
 
 /**
@@ -4620,15 +4627,9 @@ static void cpuset_handle_hotplug(void)
 		       !cpumask_empty(subpartitions_cpus);
 	mems_updated = !nodes_equal(top_cpuset.effective_mems, new_mems);
 
-	/*
-	 * In the rare case that hotplug removes all the cpus in
-	 * subpartitions_cpus, we assumed that cpus are updated.
-	 */
-	if (!cpus_updated && !cpumask_empty(subpartitions_cpus))
-		cpus_updated = true;
-
 	/* For v1, synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
+		cpuset_force_rebuild();
 		spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
@@ -4684,8 +4685,8 @@ static void cpuset_handle_hotplug(void)
 	}
 
 	/* rebuild sched domains if cpus_allowed has changed */
-	if (cpus_updated || force_rebuild) {
-		force_rebuild = false;
+	if (force_sd_rebuild) {
+		force_sd_rebuild = false;
 		rebuild_sched_domains_cpuslocked();
 	}
 
-- 
2.43.5


