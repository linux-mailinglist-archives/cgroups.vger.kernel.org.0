Return-Path: <cgroups+bounces-4165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EE94B431
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28131F239BE
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342491DFE1;
	Thu,  8 Aug 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6h44gMX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F160FC12;
	Thu,  8 Aug 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076765; cv=none; b=F6K0xESqjzDCLupCQJekphzZF3IxX2+M3avktfJim+AjT76yvjakos2xUEE5XV31QeCAk1iVUdsl6VnRCFne8qqAMKMpcHuObSkKGwwWqtJzg1+MQOCpv1/cBVcjlhF/vB2Aa+IrgUl1vO6UaxESLd60lC7ku+eqRnFatgFJ4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076765; c=relaxed/simple;
	bh=uwqf9hq1lXSpt42mr9SuVizeGUAq3GMZ1bspYmS65UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV12wUTDSNKXNLhmkQjrK9QYcf2FkNrUanqQJurBqXGoAiCzUzYmEniS2L5C7Mb7UacEiaJhoqfcNcbOpxeumhyL9lWBGsRdcS1GDqR8jDK+/DumtPqkyD/PkBm3Hbon4i70qQ/O+dyRDZ4qhOC4cr0n6BmeJ2Qr8Pjj/GUEYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6h44gMX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso428103b3a.0;
        Wed, 07 Aug 2024 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076763; x=1723681563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah4zU07qTwVq0XTHbOAJ8N5j8+nlWMuF29o5OQKSg04=;
        b=l6h44gMXA3YUlMWx0F2IIM1dKqzDs4jS3PiDyRLPbcIBwnX+rM10Hx0vpzrh/Bg9pu
         bOBJeC7vR2ctVXHjYtMXhZteqmyivjaAGkgFuH/8DuM+OfjDd+P/YgWeOK0qY2j0RJgk
         PXuPjInrsHrRT5QUyGXw9nGzNLQADgqbMYe8ii73nALm8VzQF9rQu5gc+dOefzwLPeVz
         tgtqLgxVzxESOSwyfi56rlq6Q5DllWShsd+tz/0wNA1fNjeCh+2TbnXuYYEk8tqhzMRm
         mY2+6vWEaTSf+rPxLCk3znhcXsS/zJQ+HQq2EkZARm3+C9aOYprgyoYu7J3JLhzHcw2H
         kKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076763; x=1723681563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah4zU07qTwVq0XTHbOAJ8N5j8+nlWMuF29o5OQKSg04=;
        b=AYKZj/NSzD7dnQvO9Q4U46m+IpzBwzFdPWRd8TRz3gQG1SUEAgbKVxznXwDH6q3a1B
         lXH7RBvMCNDo3YQszvgxnVPcVsUM2giIlMmMqCFs3Hd2aeFD//NXhxO+Aym6oqrslf7B
         6kyz4aNA6V1yvBxhkVLFzHgYCGUI8v/HjsGmD6NeKiS4jjqIzQ7+ZeIY8LqtmIZ/6bas
         RHwFtI0RckBWxZiPP4tId+F5Ak2Kl8yUon1I1XPQQrmDB7i2WJYnRXdQ0QctF42L+5ha
         WoFSlC8E4vT3E42+V7PsXo+F3ErshsUnSP9Fewx9cRtUjTj5yZGPQoBPIRyE2Z6gdadV
         8Q9w==
X-Forwarded-Encrypted: i=1; AJvYcCUfYQM3gHHRHFpDfjR/3YlqoAycnVnUsB3A+87CLMK4aTCCLpVJDlHh/CqOy73j1LBygHhXAORRd5kG+amiCC6t1GudlfJVfSKIWZcF
X-Gm-Message-State: AOJu0YzrZYjJc6zljI1mRZXAG9XkhN7bjrwAJL9mFiiX1NMA6fZ1gvAk
	+VWkKVDijL3lUT70W5MUlMb2d2DrWYTMfEn3g5Hp/sO4R1xCR+Cg3XarRQ==
X-Google-Smtp-Source: AGHT+IEFmWr8dnYsFu+bSG8VoeVTBlj/xQ1teMDuhligl9aK3toqQb4v7tXQ93cvk4WvCBwGBj6B3A==
X-Received: by 2002:a05:6a21:3398:b0:1c6:ecee:184c with SMTP id adf61e73a8af0-1c6fcf2828amr182730637.32.1723076762711;
        Wed, 07 Aug 2024 17:26:02 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763a3c6bdsm7589029a12.43.2024.08.07.17.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:26:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/7] sched: Introduce CONFIG_GROUP_SCHED_WEIGHT
Date: Wed,  7 Aug 2024 14:25:27 -1000
Message-ID: <20240808002550.731248-6-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808002550.731248-1-tj@kernel.org>
References: <20240808002550.731248-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext will soon add cgroup cpu.weigh support. The cgroup interface code
is currently gated behind CONFIG_FAIR_GROUP_SCHED. As the fair class and/or
SCX may implement the feature, put the interface code behind the new
CONFIG_CGROUP_SCHED_WEIGHT which is selected by CONFIG_FAIR_GROUP_SCHED.
This allows either sched class to enable the itnerface code without ading
more complex CONFIG tests.

When !CONFIG_FAIR_GROUP_SCHED, a dummy version of sched_group_set_shares()
is added to support later CONFIG_CGROUP_SCHED_WEIGHT &&
!CONFIG_FAIR_GROUP_SCHED builds.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 init/Kconfig         |  4 ++++
 kernel/sched/core.c  | 16 ++++++++++------
 kernel/sched/sched.h |  6 ++++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a465ea9525bd..84332d3594d0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1024,9 +1024,13 @@ menuconfig CGROUP_SCHED
 	  tasks.
 
 if CGROUP_SCHED
+config GROUP_SCHED_WEIGHT
+	def_bool n
+
 config FAIR_GROUP_SCHED
 	bool "Group scheduling for SCHED_OTHER"
 	depends on CGROUP_SCHED
+	select GROUP_SCHED_WEIGHT
 	default CGROUP_SCHED
 
 config CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43a62e9ada84..235fcaf087f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9169,7 +9169,7 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 static unsigned long tg_weight(struct task_group *tg)
 {
 	return scale_load_down(tg->shares);
@@ -9188,6 +9188,7 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 {
 	return tg_weight(css_tg(css));
 }
+#endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 #ifdef CONFIG_CFS_BANDWIDTH
 static DEFINE_MUTEX(cfs_constraints_mutex);
@@ -9533,7 +9534,6 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
-#endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
 static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
@@ -9576,12 +9576,14 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 #endif
 
 static struct cftype cpu_legacy_cftypes[] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 	{
 		.name = "shares",
 		.read_u64 = cpu_shares_read_u64,
 		.write_u64 = cpu_shares_write_u64,
 	},
+#endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "idle",
 		.read_s64 = cpu_idle_read_s64,
@@ -9686,7 +9688,7 @@ static int cpu_local_stat_show(struct seq_file *sf,
 	return 0;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
@@ -9740,7 +9742,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
-#endif
+#endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
 static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
 						  long period, long quota)
@@ -9800,7 +9802,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 #endif
 
 struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -9813,6 +9815,8 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
+#endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	[CPU_CFTYPE_IDLE] = {
 		.name = "idle",
 		.flags = CFTYPE_NOT_ON_ROOT,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f365585488dd..2439d6f9729c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -483,7 +483,7 @@ struct task_group {
 
 };
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
 /*
@@ -575,6 +575,8 @@ extern void set_task_rq_fair(struct sched_entity *se,
 static inline void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next) { }
 #endif /* CONFIG_SMP */
+#else /* !CONFIG_FAIR_GROUP_SCHED */
+static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #else /* CONFIG_CGROUP_SCHED */
@@ -3787,7 +3789,7 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
 
 #ifdef CONFIG_CGROUP_SCHED
 enum cpu_cftype_id {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 	CPU_CFTYPE_WEIGHT,
 	CPU_CFTYPE_WEIGHT_NICE,
 	CPU_CFTYPE_IDLE,
-- 
2.46.0


