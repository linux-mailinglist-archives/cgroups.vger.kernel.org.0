Return-Path: <cgroups+bounces-4405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00004959FB4
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A01F24105
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089441B2ED1;
	Wed, 21 Aug 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIngLvTD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC831B2522
	for <cgroups@vger.kernel.org>; Wed, 21 Aug 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250261; cv=none; b=OL3uc/alObjJbTe0JSlixXE1ycEAHKFzGoRyYaRF1vQf48E9xpNjTODSmwAGJfMzF7zX2JRHfL78ZDdCJlDfdgP5XX9q7JU1BcGjPH7dfHh+e7VGk19kCCEFrzLVkPu9J98RNz4sdsx1DWA5bMjz+lZaHLO49Bc7dekjcNaqpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250261; c=relaxed/simple;
	bh=SbaKy7M3iE/iWGnMcfHyAGQhs+86ELqmpXUKEJwfOsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrwxMapcBvfs2Lywk5MIxXRfGhxI0VgjJbZhwgG62yTPnqObEueGkWXSI2YNZzyNzckqz7IBMl2Md5G8Bt+4nDIk3pvdlY+bfDNViUbWGrQuXI7ASogSLPgMk5X4Ed18WnK0b7fRzHzgCXiearQhkOAqAuLzUFngYTWAL0ZcMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIngLvTD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724250258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJv1xpOkewDzgnM873vJ2OOFBXS4HrZ11ebZ2D3bLl8=;
	b=gIngLvTDP6keeIOm2pUAdAKpPyDVOfTT56oV4Ml9eFgr+TdHzpaWGgqtAjeURLcrwfRoab
	sDkW2iSupsowljnP+MXiwleav6N52jXhrYs0Ya+1EDMPK9WBu4GnEheEph5u2QtTfSYSbD
	rGR9Sry/+l5s4yToqk9eYGIuUD/qVRU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-MJswKancPfOAfp4rZEyvCQ-1; Wed,
 21 Aug 2024 10:24:11 -0400
X-MC-Unique: MJswKancPfOAfp4rZEyvCQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C3F11955BFE;
	Wed, 21 Aug 2024 14:24:03 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.124])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1BB71955BF7;
	Wed, 21 Aug 2024 14:23:50 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks
Date: Wed, 21 Aug 2024 10:23:12 -0400
Message-ID: <20240821142312.236970-3-longman@redhat.com>
In-Reply-To: <20240821142312.236970-1-longman@redhat.com>
References: <20240821142312.236970-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Call the newly introduced housekeeping_exlude_isolcpus() function to
exclude isolated CPUs from the selected housekeeping CPU masks. This
is in addition to the exclusion of isolated CPUs from the workqueue
unbound CPU mask.

Almost all the existing housekeeping cpumasks can be referenced at run
time. Right now all of them except HK_TYPE_TICK and HK_TYPE_MANAGED_IRQ
will be updated in the creation, deletion and modification of isolated
partitions. More investigation will be done on the other two types.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cpuset.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8b40df89c3c1..d3cf4b2e44c7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -233,6 +233,15 @@ static bool		have_boot_isolcpus;
 /* List of remote partition root children */
 static struct list_head remote_children;
 
+/*
+ * The following sets of housekeeping cpumasks can be referenced at run time
+ * and hence should be updated for CPU isolation.
+ */
+#define HOUSEKEEPING_FLAGS	(BIT(HK_TYPE_TIMER)  | BIT(HK_TYPE_RCU)  |\
+				 BIT(HK_TYPE_SCHED)  | BIT(HK_TYPE_MISC) |\
+				 BIT(HK_TYPE_DOMAIN) | BIT(HK_TYPE_WQ)   |\
+				 BIT(HK_TYPE_KTHREAD))
+
 /*
  * A flag to force sched domain rebuild at the end of an operation while
  * inhibiting it in the intermediate stages when set. Currently it is only
@@ -1588,7 +1597,15 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+/**
+ * update_isolation_cpumasks - Update external isolation CPU masks
+ * @isolcpus_updated - @true if isolation CPU masks update needed
+ *
+ * The following external CPU masks will be updated if necessary:
+ * - workqueue unbound cpumask
+ * - housekeeping cpumasks
+ */
+static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1598,7 +1615,10 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 		return;
 
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
+	if (WARN_ON_ONCE(ret < 0))
+		return;
+	ret = housekeeping_exlude_isolcpus(isolated_cpus, HOUSEKEEPING_FLAGS);
+	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
 }
 
 /**
@@ -1681,7 +1701,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
 	list_add(&cs->remote_sibling, &remote_children);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1717,7 +1737,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 		cs->prs_err = PERR_INVCPUS;
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1769,7 +1789,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	if (deleting)
 		isolcpus_updated += partition_xcpus_del(prs, NULL, tmp->delmask);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -2140,7 +2160,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive(cs, new_prs);
@@ -3193,7 +3213,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (new_xcpus_state)
 		partition_xcpus_newstate(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(new_xcpus_state);
+	update_isolation_cpumasks(new_xcpus_state);
 
 	/* Force update if switching back to member */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs ? HIER_CHECKALL : 0);
-- 
2.43.5


