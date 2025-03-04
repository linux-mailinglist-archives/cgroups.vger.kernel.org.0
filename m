Return-Path: <cgroups+bounces-6803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F54A4D6C2
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 09:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C40188DC87
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80081FC7D8;
	Tue,  4 Mar 2025 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhU6xGzI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE531FC10F
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077687; cv=none; b=Wk0liqa1RvpfZBlOpyiqRmFKGW+lTpGopwfmb8QQERQ4RR57bMqs7P5Akf2MPVn5iW2rlxnd0QZJ3b7Cf+9RpECiQ56+on0dYBUvif79UYFyOW71lzhzi5raWdQRZa8ioB37G/WklXSXg875YSdPK4uSQgWy4AvhbckYs76u9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077687; c=relaxed/simple;
	bh=2OdxPjBtShQTPyHN8NcfqpKvYvdCrpr/1DGz7fpEkaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVXns3PN7+ebhhGpCL4JH1H7IT8w6UK/Q+KK8v6Gu/PqNengR3ps0a2DYOgOn1hKnB0LY93rtc839Wr/czKdGm0gpC2BaZKQd2W+79KCMpGssQ28IxQLKsbtkbhlDf+cu1h6O6JFJHqUxAjWMlWUVOo/kX9E0vDZX4m1qny3yHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhU6xGzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khI8Y+GNMlGI4nyBCsweph1yNgRlDOyD6T4E6SKR/uA=;
	b=hhU6xGzIcs0rFQywwh6P3oVgIBdTa8hTcY8LlBoFmo13JmNktIreGm1YE2HNG8hS8kNEwL
	K0w1NZxg0uhMkmSXrtJSoQu8mfr5xEuTBnnTUPR/LAaf3EZrLd+Kxh5GJMJEv7xryAzlP2
	0EMBqtGth3GsBXleEf61SqUyOmwoHvM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-KqijAR-KO72iZZqurFkHbA-1; Tue, 04 Mar 2025 03:41:18 -0500
X-MC-Unique: KqijAR-KO72iZZqurFkHbA-1
X-Mimecast-MFC-AGG-ID: KqijAR-KO72iZZqurFkHbA_1741077678
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3c03b6990so274785285a.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 00:41:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077678; x=1741682478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khI8Y+GNMlGI4nyBCsweph1yNgRlDOyD6T4E6SKR/uA=;
        b=Q/GlWTXzaXUglg0rmFV4q5Oax5SWUVDVafmy8T/bmI43Net3ha7lXPMUE8WuO9i/4v
         eIw6IB+dFrF26sGwvrxkXv4kTFdlgtXc2uebUl71WDkwjFKUidHZ9jEaxx5Kprug2mTx
         dFuVb5QsVCbIBptnSPhBtZbgoU1BeVPqMZ2Z0B72cReawSzPZEz/kaMnucLgmMXGq+2H
         JyzFaOb+857HmPu8JfxNj5HYGPdIjQw3qhLaOi95rRshs6mvv04SkdEdux35JIVFCoR5
         Hl6y7Pz9Ylw+nHUlpijzPD8iYdIKxEumwzgSnnLvcovsldDL8gluZnvgQsVz4TWFyN3j
         +sQw==
X-Forwarded-Encrypted: i=1; AJvYcCUu1nfI1wn6eM+SoP15NZg0XH3g7VNUMtNYjth9izvsJlBAQLBiXgqXPG/ax9u+xcLXVHh3Scgb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8xaGjtruegIAasTD2RBw1mX1ZAKlxsZeYhUMI//qnEBHeBRAn
	P/diw/xlr8ZHFPTQcQ68JC6JdNHD6+I63BelcDi0fstf16pGVowWDH2eZoFGldkIKXTXx/dyqsB
	p1TLO9P42t6fh8tIduAUP69SV0D66N36z7egAOsMdU+RMcY1we65tp2o=
X-Gm-Gg: ASbGncsStrxUZ+xH9bHSS8/ZqX9njQelGRk6pL8vKI8GwJapbLPXrp8JjNI0qrpoDWw
	E7L84gEP67Vxf9Ab9kImtptLbbnLlmS+9dPmHiSMMobrV7UG/CeGt8hp8YT0cGECkQSgxYltApy
	0YSQ56UHSk6EGZR84YNA7e13fzGz8czVTfh4symopz++iFdywTb0cwz0WYhusEgAtWfgcEi+/xU
	hTJLgdCw8/1IHWNYdQesNuoELiQ5xk8Wo58Kv433DQGIn9rhi3ONZo1l2kRBL34I5TLa13ZxUs+
	nKJS1KO+Jsc22gOEIyJ1oyjtObIGC/EkwX7AvpZBwG9Zn6eWpEStyKEc1Z2pRlX5arijl/yFhYM
	udHFg
X-Received: by 2002:a05:620a:4803:b0:7c3:c7a6:cf33 with SMTP id af79cd13be357-7c3c7a6d582mr642146285a.44.1741077677929;
        Tue, 04 Mar 2025 00:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+ZRnOSkJPb3pUSFJp1khxekA5ckD6U6RwBZseGWQ1If920oExHtAQHufEewSrz+n2y3uI+g==
X-Received: by 2002:a05:620a:4803:b0:7c3:c7a6:cf33 with SMTP id af79cd13be357-7c3c7a6d582mr642142385a.44.1741077677648;
        Tue, 04 Mar 2025 00:41:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:15 -0800 (PST)
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
Subject: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
Date: Tue,  4 Mar 2025 08:40:42 +0000
Message-ID: <20250304084045.62554-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
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
 include/linux/sched.h   |  2 ++
 kernel/cgroup/cpuset.c  |  4 ++--
 kernel/sched/core.c     |  4 ++--
 kernel/sched/debug.c    |  8 ++++----
 kernel/sched/topology.c | 17 +++++++++++++++--
 5 files changed, 25 insertions(+), 10 deletions(-)

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
index 9aecd914ac69..7b14500d731b 100644
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
index c49aea8c1025..e2b879ec9458 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -6,6 +6,19 @@
 #include <linux/bsearch.h>
 
 DEFINE_MUTEX(sched_domains_mutex);
+#ifdef CONFIG_SMP
+void sched_domains_mutex_lock(void)
+{
+	mutex_lock(&sched_domains_mutex);
+}
+void sched_domains_mutex_unlock(void)
+{
+	mutex_unlock(&sched_domains_mutex);
+}
+#else
+void sched_domains_mutex_lock(void) { }
+void sched_domains_mutex_unlock(void) { }
+#endif
 
 /* Protected by sched_domains_mutex: */
 static cpumask_var_t sched_domains_tmpmask;
@@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
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


