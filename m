Return-Path: <cgroups+bounces-6859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7415A54D11
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418B5188F5C1
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CB157A48;
	Thu,  6 Mar 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1bH4+2G"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFD13C80C
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270254; cv=none; b=ejzDjtVhesZBjiBplfaONVHXdZdirsuSy7VNVmvdWRAXcZMjNCLn3mbxtOT/05oyaKUfomHNiU/2Ji48a54qqae6Ze/HUT3RPV0j4jsIORJyKUUR7a9d1/plflRnljtSa4cDkp3FeKln7x7GH35aLUIBlbeiKArLwOu270DZHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270254; c=relaxed/simple;
	bh=ii6TTr/Kfs0THoD/TLkO2GrRbGTYaTjd5DJR+PvNb0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnP3MZXDwqd3zGR2uqLI4g9tkKU9Fg4uzbBZ5wgUybBrXil0iHe6zpPKQ3SLEQ8fjA6tVy+c0n5MviTBLTVs3AWvM7yE2sW0XWJWURsCEv7fbILhmvFJ+BBAmMXiZR2oZSFldPIiU++4z0d7fdRPiYmmqr6gBlx5Tt59qzyajDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1bH4+2G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7oYHBUSYWKBFrKzxLyJf0TyZmdB6vfG7gH9DRnS/aE=;
	b=O1bH4+2GG+WxxR2vR0gkQmU22W1pNsljhak6ax04npkRp1tSy7Gb44xFUIrwYvJco5oamP
	jf6lEa8wmFdAMK+s+/5sK1Wxo3sBtsQGKj1mWhWEcSfXSsF73hfv88ui0lEBIqgNam1Um6
	rV6ecpMqcqkonfay/uXwBDqLCZscNVE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-YBQxOivoOMqzbxyKAvUkYA-1; Thu, 06 Mar 2025 09:10:51 -0500
X-MC-Unique: YBQxOivoOMqzbxyKAvUkYA-1
X-Mimecast-MFC-AGG-ID: YBQxOivoOMqzbxyKAvUkYA_1741270250
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b53373faso124978985a.0
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270250; x=1741875050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7oYHBUSYWKBFrKzxLyJf0TyZmdB6vfG7gH9DRnS/aE=;
        b=iYk4w5lUaQ3oxUg478yRT/NIzt3e2nBngZEYZ14Io+QVc6ZfZ7ra/ml5M7aWdGHRMj
         kSoa5p4bmcC//N2uR77KCDL50em8c3JKgYOYl13cc104OQjRROjPx6ltvLiAqfHoCNaz
         uLMIJXIerobiBqMH2b8FPlM6+umS4A7YryCFnNueCTBLBLhymenCv2IEECNUsKa6WbNv
         N6k4R6ZyoXtRQ25JIL4OyVEbDg8SKYKZV5AoSmN3I3SVOYD5ogoUe4q2WnhVrls7UczW
         LrnRc0HVQ6mdfnqGmbUac0xBjVuQ0dr1nxzzsHYNX//NamnIWjMARLJm0OpkJXsbWpW8
         RweQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC9NEU4hwuSQCxoGB7e+oGpq/Fk2w2qs4AxsUefaprs8KvuObOukPxnyt8KZ3O7E8HsOOSr/GU@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEXe9jNNU3PGU7/S+U5vEQ9uMynfS0BLMbz9zSvOpo+DT3V9n
	7xCtRCyqPY5b6Fyc6vMM4i7bRp8n4YTQfljHN1EuH93J7vUClMXXrnGJ2ticKAesyNF3wXVJPaN
	7wJQRxcclA6+PyX56SftC5PLKQlFxhnncOEVAOcvC9f8CGuFPWqh39T8=
X-Gm-Gg: ASbGncu2kaYW49N3Et8WIq60y1sghbHp0lcnyy6wN2SEFtxmqxVa6inBHZKZ+QyYTkB
	EuHK5YgSMNAIwPzyn8sXi/t6uLIK1eL9CeVcXfLS9UmGdxFY2373KKYZI038x59bVuRs1Q6QDHB
	xQfTwz5tYchO6BI9mpuRIPaB3z9Vr2VZJafQ5x4f070pOArNLdu/EywoYG2NODbM6rLdrAQWj5v
	V/j3rJSVe2W8+AtfbHwWqFNBmuHW50F8pCz7SZ6La60oJUPIMQpvhp2/eWgcPtSSRjLhOCqhLIC
	Ii9jj8/XtqlQfAKPDtqlzmT3ryE9FMTvyJcVdBbbiuCMNrGbS+m7GgIqus5/AWMczW2PvvMNDtk
	8YXGs
X-Received: by 2002:a05:620a:4895:b0:7c0:c891:1e77 with SMTP id af79cd13be357-7c3d8e6f70bmr1208829385a.49.1741270250318;
        Thu, 06 Mar 2025 06:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEapf8emAvcjT0ZEquex2SbAKsDJBQjnPQ+wdDeLlrDgq2lW0+5MJIRR1jizGu94GkTg7cprg==
X-Received: by 2002:a05:620a:4895:b0:7c0:c891:1e77 with SMTP id af79cd13be357-7c3d8e6f70bmr1208825085a.49.1741270250020;
        Thu, 06 Mar 2025 06:10:50 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:44 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
Date: Thu,  6 Mar 2025 14:10:10 +0000
Message-ID: <20250306141016.268313-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
          either in that case
---
 include/linux/sched.h   |  2 ++
 kernel/cgroup/cpuset.c  |  4 ++--
 kernel/sched/core.c     |  4 ++--
 kernel/sched/debug.c    |  8 ++++----
 kernel/sched/topology.c | 12 ++++++++++--
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..d5f8c161d852 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -383,6 +383,8 @@ enum uclamp_id {
 extern struct root_domain def_root_domain;
 extern struct mutex sched_domains_mutex;
 #endif
+extern void sched_domains_mutex_lock(void);
+extern void sched_domains_mutex_unlock(void);
 
 struct sched_param {
 	int sched_priority;
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


