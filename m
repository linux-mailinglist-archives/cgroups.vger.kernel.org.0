Return-Path: <cgroups+bounces-1909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD9E86BED1
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 03:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4865AB2453C
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 02:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057A376E5;
	Thu, 29 Feb 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUP0xRFq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51A36B11
	for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172902; cv=none; b=EthnqR1jj5gxWZUNeDFzRCRNZQCSh7By2VdH75WllJ5wvTRNaTec43IqZBuibVCQE1aE4sFUdUTz0gwZljCnpZZz88cyGz65PKEN7jG7tMpIrh99LTqMMzVVlw3jZ5iANwKbVnbYxDBO5qfJ/l9DXuUtK/z+c641FmJ14Anwnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172902; c=relaxed/simple;
	bh=ZJ/fljn/Qv75UAjs1VLdo2uoQDDup88nyCXUQF/cxT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3v9z1fmjImHUS8WDGhxXlS0AzBTDeJHRniQZi0YrHI/ZaBcJAWGZJRzLjWyQYDxx2u+5/sTWjDEz4ZCenRlrrtR64moCkI2CeDHyzNWaG0KF2MjfBtTkfyXL57kCYHcPyWm63CNyluBoMQbFnqSh8+gVVIqgI70wIHUoLSC8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUP0xRFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709172899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iw2m/lgdJeZzD7aZQt9cEYEaJ4jQS/QQ20bKstBiolo=;
	b=IUP0xRFqd/4KgkFEcQzuv/ptz1IWLhvcRvOg/z68rMD0jMkGAFK0IrkjS3k8xU1xHanspF
	sdE5mBKQLiGotFuiW/KLLwluHxZxRIJw1pS+7Fb70bzJBvQigYmSPMZ/eSR+X/M3X2LuIJ
	AAlS8f9D9qD+uAy2mzqIdX5n4P5Nl9k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-SgMkZ3S1OoO-MwiCMniSfA-1; Wed, 28 Feb 2024 21:14:53 -0500
X-MC-Unique: SgMkZ3S1OoO-MwiCMniSfA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AB33863012;
	Thu, 29 Feb 2024 02:14:52 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDDBC492BE8;
	Thu, 29 Feb 2024 02:14:50 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Cestmir Kalina <ckalina@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] sched/isolation: Exclude dynamically isolated CPUs from housekeeping masks
Date: Wed, 28 Feb 2024 21:14:13 -0500
Message-Id: <20240229021414.508972-2-longman@redhat.com>
In-Reply-To: <20240229021414.508972-1-longman@redhat.com>
References: <20240229021414.508972-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected CPUs
from running some kernel background processes to minimize disturbance
to latency sensitive userspace applications. Some of housekeeping CPU
masks are also checked at run time to avoid using those isolated CPUs.

The cpuset subsystem is now able to dynamically create a set of isolated
CPUs to be used in isolated cpuset partitions. The long term goal is
to make the degree of isolation as close as possible to what can be
done statically using those boot command line options.

This patch is a step in that direction by making the housekeeping CPU
mask APIs exclude the dynamically isolated CPUs when they are called
at run time. The housekeeping CPU masks will fall back to the bootup
default when all the dynamically isolated CPUs are released.

A new housekeeping_exlude_isolcpus() function is added which is to be
called by the cpuset subsystem to provide a list of isolated CPUs to
be excluded.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h |   8 +++
 kernel/sched/isolation.c        | 101 +++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..d64fa4e60138 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -27,6 +27,8 @@ extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern void __init housekeeping_init(void);
+extern int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus,
+					unsigned long flags);
 
 #else
 
@@ -54,6 +56,12 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 
 static inline void housekeeping_init(void) { }
+
+static inline int housekeeping_exlude_isolcpus(struct cpumask *isolcpus,
+					       unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..f47ff04ac77c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -28,7 +28,8 @@ struct housekeeping {
 	unsigned long flags;
 };
 
-static struct housekeeping housekeeping;
+static struct housekeeping housekeeping __read_mostly;
+static struct housekeeping housekeeping_boot __read_mostly;
 
 bool housekeeping_enabled(enum hk_type type)
 {
@@ -239,3 +240,101 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	return housekeeping_setup(str, flags);
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
+
+/*
+ * Save init housekeeping masks to housekeeping_boot
+ */
+static int housekeeping_copy2_boot(void)
+{
+	enum hk_type type;
+
+	housekeeping_boot.flags = housekeeping.flags;
+	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
+		if (!alloc_cpumask_var(&housekeeping_boot.cpumasks[type],
+				       GFP_KERNEL))
+			return -ENOMEM;
+		cpumask_copy(housekeeping_boot.cpumasks[type],
+			     housekeeping.cpumasks[type]);
+	}
+	return 0;
+}
+
+/*
+ * Exclude the given dynamically isolated CPUs from the housekeeping CPUs
+ * External synchronization is required to make sure that concurrent call to
+ * this function will not happen.
+ *
+ * Return: 0 if successful, an error code if not
+ */
+int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long flags)
+{
+	static unsigned long alloc_flags;
+	static cpumask_var_t tmp_mask;
+	static bool excluded;	/* @true if some CPUs have been excluded */
+	static bool inited;	/* @true if called before */
+
+	bool mask_empty = !isolcpus || cpumask_empty(isolcpus);
+	enum hk_type type;
+
+	lockdep_assert_cpus_held();
+
+	if (mask_empty && (!inited || !excluded))
+		return 0;
+
+	if (unlikely(!inited)) {
+		if (!alloc_cpumask_var(&tmp_mask, GFP_KERNEL))
+			return -ENOMEM;
+		if (housekeeping.flags) {
+			int err = housekeeping_copy2_boot();
+
+			if (err)
+				return err;
+		}
+		alloc_flags = housekeeping.flags;
+		inited = true;
+	}
+
+	if (mask_empty) {
+		excluded = false;
+
+		/*
+		 * Reset housekeeping to bootup default
+		 */
+		for_each_set_bit(type, &housekeeping_boot.flags, HK_TYPE_MAX)
+			cpumask_copy(housekeeping.cpumasks[type],
+				     housekeeping_boot.cpumasks[type]);
+
+		WRITE_ONCE(housekeeping.flags, housekeeping_boot.flags);
+		if (!housekeeping_boot.flags &&
+		    static_branch_unlikely(&housekeeping_overridden))
+			static_key_disable_cpuslocked(&housekeeping_overridden.key);
+		return 0;
+	}
+
+	/*
+	 * Setting up the new housekeeping cpumasks
+	 */
+	for_each_set_bit(type, &flags, HK_TYPE_MAX) {
+		const struct cpumask *src_mask;
+
+		if (!(BIT(type) & alloc_flags)) {
+			if (!alloc_cpumask_var(&housekeeping.cpumasks[type], GFP_KERNEL))
+				return -ENOMEM;
+			alloc_flags |= BIT(type);
+		}
+		src_mask = (BIT(type) & housekeeping_boot.flags)
+			 ? housekeeping_boot.cpumasks[type] : cpu_possible_mask;
+		/*
+		 * Make sure there is at least one online housekeeping CPU
+		 */
+		cpumask_andnot(tmp_mask, src_mask, isolcpus);
+		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
+			return -EINVAL;	/* Invalid isolated CPUs */
+		cpumask_copy(housekeeping.cpumasks[type], tmp_mask);
+	}
+	WRITE_ONCE(housekeeping.flags, housekeeping_boot.flags | flags);
+	excluded = true;
+	if (!static_branch_unlikely(&housekeeping_overridden))
+		static_key_enable_cpuslocked(&housekeeping_overridden.key);
+	return 0;
+}
-- 
2.39.3


