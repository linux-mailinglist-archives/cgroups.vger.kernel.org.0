Return-Path: <cgroups+bounces-6917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33644A58FC3
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AF5188FE3B
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DE224221;
	Mon, 10 Mar 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goJldcwQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269442048
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599191; cv=none; b=Vgru4v+HroObE6/yk8fwYYC7SCAIAKbnQ+KToRy+YN6Hu0WMHftwgs8bybbxW9PdUQOWnEsy5vJlbLMUjBje2VYiszv2HuRk1iyuWZlLzc6GCuXQ0PItexNsZCo79iCyYzC9imp4QVU+cYuPPydXtg8DIcGeO7X3ybUHYCHVftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599191; c=relaxed/simple;
	bh=wJpaHcARR3YB5XnG3M9UeeHERjXf318a8M9J0vLqzxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzOEjoNh9sXMi7Jutu0k1zbkyRSuy/oXpFKZP4GKqcQu7FgBP3RsHw9UZ8Ze4XWyQUSgu4pghGx6DCuOeVpUj05RFHnxHAPLwuCFaiTm3efWeEESwux6HeUIWNjZ0myQenEY3olbOu1aJ6Owv0iu70n7HwUwT8s11lRe5kgz7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goJldcwQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1c5i2Qm2DUrkZQHaLsmF680F9xe+Pb2YDsGrDb31LY=;
	b=goJldcwQSGtkKUMOBo9T6jnss0vuJUdn0aiM2RXnOwNqyvBP68XTqIDCsjP16Qisv8en5B
	7topKOFSQe47laJiGuW/HY5/BRhVopClT/vb2qR1OCcCn6nfk4TC7EptedEMvkTJJ5kclx
	gvZyAngztAIJl+Ee7b72beu4EOqWGPQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-w1WhJMksN7W2LbnspLj65Q-1; Mon, 10 Mar 2025 05:33:07 -0400
X-MC-Unique: w1WhJMksN7W2LbnspLj65Q-1
X-Mimecast-MFC-AGG-ID: w1WhJMksN7W2LbnspLj65Q_1741599186
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso14713045e9.2
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 02:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599186; x=1742203986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1c5i2Qm2DUrkZQHaLsmF680F9xe+Pb2YDsGrDb31LY=;
        b=hQM4E/bC8sP+m5kh0CFmVlZGOuGOQGm2l51rDUuSPMv5KzewEgZOEM8tdMxCLpVjyp
         n6fLdTKOgaKe5EbCNxiFFmJVw7FSNTn6QDw6/zRTjvzZMyVlZbVhvcLmeEywCdCU1ljD
         mdT/zAjZRoXoIFHZCXSEJieSCqNR27WSM1ZbtAKOCCX49U6bdi0xsbyBjiE4vo9bBho1
         34jikuOwHQZbcGCFd+j2Mwk5vCcclr5DvPnugmSNFbRubrcTygaOla0yLK6Rw76dQiZF
         3GWIQMg/2r5sa4+LGMlJXkrY9tN9phWJwAIZcIugIVyWuZ/nzZ9CLpRtcw0tjvMzgH5l
         uCWw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Zvl2pKQ5msQYlq0EBkZvQZw7SUdwe8mdcM1LeW8tiKF52diBXmymXrjazBVGAA0SbouLkcUt@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpObpZ44pFThoscYQKslA6D8STJw2z71JJ4E0yQXcZoOGJEYv
	XYtilsG/WmjZ53T0xOoIiNMV+8193JKCRPlxB/rs8XZRuBPP0h7l85ncOnj4prMuXfws47qhYPD
	sSI6AvKWS/CzXBkpFvwnrvD4UQDq5zcWWxKpGJ6qiiq0OxRfFxzEWIiA=
X-Gm-Gg: ASbGnctBlB+eVHe8tK9k2nyr5IbdxLQcWLwgvwjI1ZXyO77Zcft5eL1Q5gEuzEFvVOx
	fNQl0P+96KKQ+u8zwdu0jE/I1uUdpMCuvQqLWJJxakyfemTGTcVqUKlCGKE7jFq+uqqFprh+/Kr
	Dx0AneAg1aQpuKrEKppE97zYZjGsaxpaMiOM4p7u4Zor1AhKLmU2uOy+5x/LKulA3qYoaAquCSa
	dJUpM6zT3xCaX7H6bCjfLQha+M7Nj/JOdNeff6ChlDOYZm47+PY54NRZKCsEvTFRCnG8RxVK5SE
	a6pwWz+YMFGFl70OYW2whynzZAM8lRs0NHDGiMeIQ8Q=
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id 5b1f17b1804b1-43ce5c2054emr52822405e9.0.1741599185770;
        Mon, 10 Mar 2025 02:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLMiRzgA5hzMsBbSiJbAqQMr/pIjjtP9IG0cEEYXnbRD0gQZrY8zGFUbNgAmgSDjVV8Tx22w==
X-Received: by 2002:a05:600c:1f92:b0:43c:e5c2:394 with SMTP id 5b1f17b1804b1-43ce5c2054emr52822125e9.0.1741599185397;
        Mon, 10 Mar 2025 02:33:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfac24345sm19535045e9.22.2025.03.10.02.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:33:03 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:33:00 +0100
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
Subject: [PATCH v3 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z86xzGyT3av5dh1p@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310091935.22923-1-juri.lelli@redhat.com>

Create wrappers for sched_domains_mutex so that it can transparently be
used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
do.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
v2 -> v3: Add wrappers back for the !SMP case as sched_rt_handler()
          needs them
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


