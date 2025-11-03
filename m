Return-Path: <cgroups+bounces-11475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278BC29C97
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 02:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3D394E9AA6
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 01:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058B277CB3;
	Mon,  3 Nov 2025 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3Jp27IV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B22773F1
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133690; cv=none; b=OZUPdYNUsAve6Fp8P+hGcmsH3D3Sn6IZVSTVcqTv7JUjWrx7qMlEnmRbVVSjIER61kGA92JtISlwf5L/sm1L+zVH9NYNUu7hRINZmfrJr3kp/krx+u6SL6SfE5nf+P4gtJvXO5vQmn+VBvhayBfm5w0qSO1UgQfneYYdXeqcSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133690; c=relaxed/simple;
	bh=QSMtuZJlhpfZlw9xjWM2VWoOgLqSemwPU5bvVsW8OIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8PYdRn/SdqkxdtGSnNjOe6yijJA1rhU8ZdEE7j91hfqFUhWs7+mDM4zi3mDmUZdpvR5/KU2fUwb3txzF2Izi1rq9xW51sfS1wPYqZ8zX7C7jBpTt27a7KGE3r8MDRGK0Iz2bXqbDW2lqomh/DJ1Busy6ZI1iZagkeTTIjqTGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3Jp27IV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762133687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHTWsmFtq1a6G99r8MhP4nYSCSSdkZKXE/3thNe7Rmg=;
	b=M3Jp27IVqAH0zUKC0RTpNQ1f0Oiqapmbld6wLba58hm9RVZKXkWzUvcBvgDjkJiW+nK3nf
	GvXRRsYCueiF60WNkgLzI0KJWr0fWKnkZPryqUFXA/KRgzYUfNg8jaiJuhGlioYGzc4GZf
	0oUjxnpDiv617eTzxgGBTRmRtzeTOQs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-0dqW8CewORCsdZfIpKMGUA-1; Sun,
 02 Nov 2025 20:34:46 -0500
X-MC-Unique: 0dqW8CewORCsdZfIpKMGUA-1
X-Mimecast-MFC-AGG-ID: 0dqW8CewORCsdZfIpKMGUA_1762133685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48B241956066;
	Mon,  3 Nov 2025 01:34:45 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 695B71956056;
	Mon,  3 Nov 2025 01:34:43 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and nohz_full don't leave any housekeeping
Date: Sun,  2 Nov 2025 20:34:10 -0500
Message-ID: <20251103013411.239610-3-longman@redhat.com>
In-Reply-To: <20251103013411.239610-1-longman@redhat.com>
References: <20251103013411.239610-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Gabriele Monaco <gmonaco@redhat.com>

Currently the user can set up isolated cpus via cpuset and nohz_full in
such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
domain isolated nor nohz full). This can be a problem for other
subsystems (e.g. the timer wheel imgration).

Prevent this configuration by blocking any assignation that would cause
the union of domain isolated cpus and nohz_full to covers all CPUs.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index da770dac955e..d6d459c95d82 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1329,6 +1329,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
 }
 
+/*
+ * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
+ * @prs: new or old partition_root_state
+ * @parent: parent cpuset
+ * Return: true if isolated_cpus needs modification, false otherwise
+ */
+static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
+{
+	if (!parent)
+		parent = &top_cpuset;
+	return prs != parent->partition_root_state;
+}
+
 /*
  * partition_xcpus_add - Add new exclusive CPUs to partition
  * @new_prs: new partition_root_state
@@ -1393,6 +1406,42 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
+/*
+ * isolated_cpus_can_update - check for isolated & nohz_full conflicts
+ * @add_cpus: cpu mask for cpus that are going to be isolated
+ * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
+ * Return: false if there is conflict, true otherwise
+ *
+ * If nohz_full is enabled and we have isolated CPUs, their combination must
+ * still leave housekeeping CPUs.
+ */
+static bool isolated_cpus_can_update(struct cpumask *add_cpus,
+				     struct cpumask *del_cpus)
+{
+	cpumask_var_t full_hk_cpus;
+	int res = true;
+
+	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return true;
+
+	if (del_cpus && cpumask_weight_and(del_cpus,
+			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
+		return true;
+
+	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
+		return false;
+
+	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
+		    housekeeping_cpumask(HK_TYPE_DOMAIN));
+	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
+	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_active_mask);
+	if (!cpumask_weight_andnot(full_hk_cpus, add_cpus))
+		res = false;
+
+	free_cpumask_var(full_hk_cpus);
+	return res;
+}
+
 static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
@@ -1551,6 +1600,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
+	if (isolated_cpus_should_update(new_prs, NULL) &&
+	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
+		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
 	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
@@ -1650,6 +1702,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
 			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
 			cs->prs_err = PERR_NOCPUS;
+		else if (isolated_cpus_should_update(prs, NULL) &&
+			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
+			cs->prs_err = PERR_HKEEPING;
 		if (cs->prs_err)
 			goto invalidate;
 	}
@@ -1988,6 +2043,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			return err;
 	}
 
+	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
+	    !isolated_cpus_can_update(tmp->delmask, tmp->addmask)) {
+		cs->prs_err = PERR_HKEEPING;
+		return PERR_HKEEPING;
+	}
+
 	/*
 	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
 	 * only).
@@ -2994,7 +3055,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * A change in load balance state only, no change in cpumasks.
 		 * Need to update isolated_cpus.
 		 */
-		isolcpus_updated = true;
+		if ((new_prs == PRS_ISOLATED) &&
+		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
+			err = PERR_HKEEPING;
+		else
+			isolcpus_updated = true;
 	} else {
 		/*
 		 * Switching back to member is always allowed even if it
-- 
2.51.1


