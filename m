Return-Path: <cgroups+bounces-7042-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FEA5FCFA
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 18:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD219C1F0C
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7526A0CB;
	Thu, 13 Mar 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaMHO2E6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14915747D
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885423; cv=none; b=EXmzhJxKsNAGGhyKAj4Jtwc4LPWyUQXIPqVFfUI4ws0LMGQv/3ecFdPFMsEBbg+EgBELxkUtoXXBiUjtztIz0SbpM+Ro0DSD3vvmUwqceE3UlAMZ0osa/KH1Ef6tWX61qa2WL1aRKRFn5cijfyqQGmqo4ouNSARejjcD5DWLG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885423; c=relaxed/simple;
	bh=rWzzcRlgHWgNn6FgV0nYpza0tAY2jpiBU7Yx3Kp/uJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrET4PJDvOzKpahVz94LvadRahRG+/NUE+Tn1vmODdLsQhkEv5BrNkij5JRCiL72ASpC0n2PNEbxljlzAL+12z55U828xe+ZUVcP2n/JsPEkPsfkSD/cpXN7X5lP3dpBaM6VVqccWjtCStvdH1dcW2+9RJscSU6kdpP7Nyy1NfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaMHO2E6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpKB27UpoppNUohxUmSpnADUhWYwKjiQjBLjD49aA4Q=;
	b=NaMHO2E6RHhYcwYF+2RXMBSGTOkiprA5EBEdBFGtcgmAR8x95rr/l6LuJhANmgUyosOald
	BOiB10A0vJ0M4+9CKdp++nB0ecCSg+oo2652bMaTcFCK8kUc3iQsBaZRgawEB4UcV8fRKq
	OD99GCxmv66ttnOv5FTqCRTYFAPSTik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-yXrav3t8MrWlAc6SdE6Lhg-1; Thu, 13 Mar 2025 13:03:39 -0400
X-MC-Unique: yXrav3t8MrWlAc6SdE6Lhg-1
X-Mimecast-MFC-AGG-ID: yXrav3t8MrWlAc6SdE6Lhg_1741885418
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so8517645e9.2
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 10:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885417; x=1742490217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpKB27UpoppNUohxUmSpnADUhWYwKjiQjBLjD49aA4Q=;
        b=FLB3p+F+bn94y22PgFB23PhSxuGWyfb6MrjecToTmeFrHw9pCF68d5ngMu0eJWefrq
         xdmmK2FApWiR3qlkK+T0HNqhg/uOpB4h7wQq8yFwuz8LJewwpPL5v4eZiuo9fBWXi2lM
         rcQUMDeByT2p2TJqO39y0ybC2yZXYy4cy8bR4Te64GikziACOfwUYRXv1N9+dccrE2Or
         ngR9bwn3iap0Wa0PoJHc7Wb7w4pL1R2ijen3SlmEpewN9jVI8INwwZoBJEqtkDdYHETk
         RFnPGlrRQxv0K8j1uMdrJrSEEYLHmOreX89HZwHcxc8gybUiosqM/Z3bdqWp/Rqld/ZD
         Cx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUklOeiqS/M2bGxDLGTflLtin7s379+kF0HC+SKc/53iRZAsr92VORZC7nWpIfyQheYFwsaRRYV@vger.kernel.org
X-Gm-Message-State: AOJu0YzOOhvqmRzB3KkTaXti5pyUYqvUl2YDk4POjVqf6S4XMyqg9QYQ
	dJ1JVGGFoSZXSv2dwAR/vGKgGyZSU4W979oOC2PkkuP7q0jjslwCIVgqCdclkHfEHW1SmPGVRtR
	0u943JX1tfbZDAO/QayMyybUgYNb47my4VHX2v92aAzZMBIHSbeiJz7c=
X-Gm-Gg: ASbGncs7bOiFIjKj1cyAuyqvXp0vK3w8r44BaYayhiimHrh5+Hzu9lhfPbCm1VZycfP
	tE1UDOO6yEK3tAaFqJ/S4+8X8xKdzuUCk3hcJyV01ubVDV0tiO2D9MDAiJID9c4Kw2t89FovtWl
	wVDcguvKG7fdDkqlX1nDK9bht35zDpJUOxqCv9ltMReGMnMBpOMzHl5akHB5CqGIrYE3Z/eAg22
	XCKQfSHySjxMLfcBA/YHJfzLH/tb5bxZrzq7T4qkh3PqgMzhORpiWzTkquQXTLRVIaRvgmONh7Q
	vDr4QFilvkTS8g/yqFhcUorgyRZ1ZU5LHGWYzA2iHng=
X-Received: by 2002:a05:600c:1ca4:b0:43c:f575:e305 with SMTP id 5b1f17b1804b1-43d1d897558mr4273325e9.8.1741885417499;
        Thu, 13 Mar 2025 10:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE30aiOWpsPCl2pqvgKR9tHw0iFo0nuAsz0qQ6ZBddzYfWJm0vgp05kaC7GI1re3vo/9t8k9g==
X-Received: by 2002:a05:600c:1ca4:b0:43c:f575:e305 with SMTP id 5b1f17b1804b1-43d1d897558mr4272595e9.8.1741885416975;
        Thu, 13 Mar 2025 10:03:36 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm2737097f8f.71.2025.03.13.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:03:35 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:03:32 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z9MP5Oq9RB8jBs3y@jlelli-thinkpadt14gen4.remote.csb>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h   |  5 +++++
 kernel/cgroup/cpuset.c  |  4 ++--
 kernel/sched/core.c     |  4 ++--
 kernel/sched/debug.c    |  8 ++++----
 kernel/sched/topology.c | 12 ++++++++++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9c15365a30c0..4659898c0299 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -382,6 +382,11 @@ enum uclamp_id {
 #ifdef CONFIG_SMP
 extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
+extern void sched_domains_mutex_lock(void);
+extern void sched_domains_mutex_unlock(void);
+#else
+static inline void sched_domains_mutex_lock(void) { }
+static inline void sched_domains_mutex_unlock(void) { }
 #endif
 
 struct sched_param {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973..f87526edb2a4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -994,10 +994,10 @@ static void
 partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	dl_rebuild_rd_accounting();
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d..58593f4d09a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8424,9 +8424,9 @@ void __init sched_init_smp(void)
 	 * CPU masks are stable and all blatant races in the below code cannot
 	 * happen.
 	 */
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	sched_init_domains(cpu_active_mask);
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..a0893a483d35 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -292,7 +292,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 	bool orig;
 
 	cpus_read_lock();
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 
 	orig = sched_debug_verbose;
 	result = debugfs_write_file_bool(filp, ubuf, cnt, ppos);
@@ -304,7 +304,7 @@ static ssize_t sched_verbose_write(struct file *filp, const char __user *ubuf,
 		sd_dentry = NULL;
 	}
 
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 	cpus_read_unlock();
 
 	return result;
@@ -515,9 +515,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
 	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
 
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	update_sched_domain_debugfs();
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 #endif
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..296ff2acfd32 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -6,6 +6,14 @@
 #include <linux/bsearch.h>
 
 DEFINE_MUTEX(sched_domains_mutex);
+void sched_domains_mutex_lock(void)
+{
+	mutex_lock(&sched_domains_mutex);
+}
+void sched_domains_mutex_unlock(void)
+{
+	mutex_unlock(&sched_domains_mutex);
+}
 
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
@@ -2791,7 +2799,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			     struct sched_domain_attr *dattr_new)
 {
-	mutex_lock(&sched_domains_mutex);
+	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	mutex_unlock(&sched_domains_mutex);
+	sched_domains_mutex_unlock();
 }
-- 
2.48.1


