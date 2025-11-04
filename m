Return-Path: <cgroups+bounces-11549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED2C2EC47
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 02:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEC5F4F4AE9
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 01:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41470239594;
	Tue,  4 Nov 2025 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjqMfQKJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57137212FAA
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219861; cv=none; b=MyujKezK8aufHU+c54z/lmAPajToKTls380/czmOzCfp4W/Rqy6d781SEb/DUvzee3jDLO1v11JgZAHndz1zdI6Jkgbj6mq+W/4B3H7TlNjtDo+vrZiMtH85VDMTQFNJPbZdKKE/PlOBW/Xe5rqs1NOF7kGOmFIyjGvqfSFZpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219861; c=relaxed/simple;
	bh=7jHpmWcYJsUU2T2hOdNuXivoRepIQIj6fE27OiNmH70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLX2m/7odw+1SKEoAMlSdWPMEPQCTpKJeD6nlh566xOASu320RpBg9LKPjpBroUmsxh9at2v2632tBjZ/cylKEI+LW4hlvf8ifRJnvN+Jihg0k9lymqWo8+Q1vFkhT+lwISSObzMxz4s5qb42/uyIiillDuVrryZH1RJ7a6UFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjqMfQKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762219858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGxlyxFIeeJQWfJtkFlh/X5lpM+PZPG/dxHQARwfodM=;
	b=FjqMfQKJFcnqwg+XfoSbZNj7s0CwUCYmquWtba+A7poQ1lHPnAV66j1vg+b4GkFLWaNN7L
	VL36QYiOaZXUGfEVxJBtrhRlVeNYjkgJvJXI/+Jdl8sPEHuKG+2VimMl+XgjmS3P/LU/XQ
	S4OGwJUKHYZsXW/1IoNIjKONGwxPBLw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-z1XXSx8TOSerwHJDBz5W2A-1; Mon,
 03 Nov 2025 20:30:55 -0500
X-MC-Unique: z1XXSx8TOSerwHJDBz5W2A-1
X-Mimecast-MFC-AGG-ID: z1XXSx8TOSerwHJDBz5W2A_1762219853
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04CBB18009C0;
	Tue,  4 Nov 2025 01:30:53 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.236])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A2CB430001A8;
	Tue,  4 Nov 2025 01:30:50 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>
Subject: [cgroup/for-6.19 PATCH v2 1/3] cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_isolation_cpumasks()
Date: Mon,  3 Nov 2025 20:30:35 -0500
Message-ID: <20251104013037.296013-2-longman@redhat.com>
In-Reply-To: <20251104013037.296013-1-longman@redhat.com>
References: <20251104013037.296013-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Gabriele Monaco <gmonaco@redhat.com>

update_unbound_workqueue_cpumask() updates unbound workqueues settings
when there's a change in isolated CPUs, but it can be used for other
subsystems requiring updated when isolated CPUs change.

Generalise the name to update_isolation_cpumasks() to prepare for other
functions unrelated to workqueues to be called in that spot.

[longman: Change the function name to update_isolation_cpumasks()]

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7aef59ea9627..da770dac955e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1393,7 +1393,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1557,7 +1557,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1598,7 +1598,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 
 	/*
@@ -1667,7 +1667,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -2011,7 +2011,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 							tmp->delmask);
 
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -3029,7 +3029,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
-- 
2.51.1


