Return-Path: <cgroups+bounces-5925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 083739F3A95
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5189916D0B8
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1B1D86D6;
	Mon, 16 Dec 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CWeZVFj5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6F1D5CD1
	for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380002; cv=none; b=WzL/ntkw8C7F96hhrei8jiS+srlt4MojEnvfl5IlVt6hqh3HZ98BQ5kmUFEJC+Fi8TPbk/4wDYn5URsELCQVGb4l2q0xtNr3z9hi6AjIoKhDyNeBHUXlHy2SdCfWXba3TjdqGHaU88RG/UXC6+N4M96wnB/myTv8hfs/344fc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380002; c=relaxed/simple;
	bh=BgnE3y0aEkA+6mEwxppauEiIwzvGAc2MheHabRKMMzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeRliQQiBwtI4fPbL6g33PUuh4e3lFqV003XLJnIByUwJf4dp7SnxXdNwezS/ZfTCGQ+VKesXJdhXSltJmC3jRy6jT/u3i+/cxuERcN8Z1EafrPDoLOKQ48cunIcIDLofWfjYVZKW6YD+J8QNxV7I7Pli1RXp6k0Scbr9RnL5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWeZVFj5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43622267b2eso48231025e9.0
        for <cgroups@vger.kernel.org>; Mon, 16 Dec 2024 12:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379999; x=1734984799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+uDEQRPgLnIuRhkfP+uF78Vcg5q4+H6L1oWNhvU8jc=;
        b=CWeZVFj545qKgLqsnPIpmdOJSkO4XpUJygw1kdtE8G7ePbk3/c87SlkGneCVxQQem3
         UhCrZmn+1k0oW3TVE6jiFtsHa8CyUrHLYCCNOz8gUlEKnyNgOtOgPBWiDoSW/A831j/3
         k5orv2kLboI5piGGpjTL7JXmYF7spb8O8KlJ0IsebdJbJ9YV9p9SmRruXs7ry0IZOMnL
         6tHcD0sMY4oqxBNk9/bupIrTiwSSSULSqqW6vzRSG4mMdXTYQMc2yYoyyMuFN1iuwmsJ
         RxI7CMuY0M/nGMYxLLeQ8VZ6AJtFdUkuSDRKxPXdyedkNRhbEuans8hOGLwFPtxIfRpo
         m/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379999; x=1734984799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+uDEQRPgLnIuRhkfP+uF78Vcg5q4+H6L1oWNhvU8jc=;
        b=w3/p7h5AXEUsUW3x6gkhdlfNyLIonBn7zippikQG6GRdNuP5UMKwRDex7ze7F4l88L
         /mNqmX/WmJe47y4EwN6CfGqgtTEv78/T96jIzr8q8FRYDyZVEVFf/8Qs6wnHo+onenXn
         fe7KtiMthVZPjjhjy5kP4o5XOijukSSrek1MELqVnO+ZCFeJpL2BFyHOEkIUtqEf4AIW
         bnmkOw+komS32VhUtOgx4GM1AtPCqdEpFuftP/yaMTzIy00ITXAUMPSrMqUToEyS7bd+
         3QK5+ZLRYxIXx94NMnF0ca/sUj9Fc8HK/YhkUul2f/Idg1wu5QilOQz6vC+DWiFoN7D9
         TvGA==
X-Gm-Message-State: AOJu0YwjtLGdyuv89Ct7CT3VGkxfs6M4TAZsLvMtKYKkiBBUR/vRyXXY
	/s3jhnRFshLHHo85DYcY1D2OYvw2IAf4JfRNZ0X8rfxS3+U5rM2hnvGYirfDZFlSRheJP8qPZ8e
	V
X-Gm-Gg: ASbGnctgBezXMsb3JsrWtB5R1lxwwttLip0Ydl9qiQQihqDHBEpy/raVWm6xwXvqyK0
	+h0iBEM4QsPkPpLvjVzO1+Px7HbtUlD1s3fxmOIWf+iOs0AVzg5DVbRmHnEmfGmyBm+n/0USMAO
	IKWWD2JLx0R3KBvqPKQJvNdl0nvF//jOOP995C2Eqvv/JrAOtDYzwt/82wG2TAlkPX5fhzmQlyk
	R6wyXBRY8w/g3Qwv9MZWW+clLS47LWuR2MIhkubeZQXJTt5XzHc+27Ilg==
X-Google-Smtp-Source: AGHT+IE0YPWhe33Skc7Ao7kIv0JHWWBX92wx7RBLT/PPrRR4qswieUBdDloiYM0Sh7mx0mPRokcAOg==
X-Received: by 2002:a05:600c:4e11:b0:434:f804:a9b0 with SMTP id 5b1f17b1804b1-4362aaa49b1mr125287635e9.29.1734379998887;
        Mon, 16 Dec 2024 12:13:18 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:18 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 7/9] sched: Do not construct nor expose RT_GROUP_SCHED structures if disabled
Date: Mon, 16 Dec 2024 21:13:03 +0100
Message-ID: <20241216201305.19761-8-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks to kernel cmdline being available early, before any
cgroup hierarchy exists, we can achieve the RT_GROUP_SCHED boottime
disabling goal by simply skipping any creation (and destruction) of
RT_GROUP data and its exposure via RT attributes.

We can do this thanks to previously placed runtime guards that would
redirect all operations to root_task_group's data when RT_GROUP_SCHED
disabled.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++------------
 kernel/sched/rt.c   |  9 +++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e21e0885557d..300a1a83e1a3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9819,18 +9819,6 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_cfs_local_stat_show,
 	},
 #endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	{
-		.name = "rt_runtime_us",
-		.read_s64 = cpu_rt_runtime_read,
-		.write_s64 = cpu_rt_runtime_write,
-	},
-	{
-		.name = "rt_period_us",
-		.read_u64 = cpu_rt_period_read_uint,
-		.write_u64 = cpu_rt_period_write_uint,
-	},
-#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -9849,6 +9837,20 @@ static struct cftype cpu_legacy_files[] = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
+static struct cftype rt_group_files[] = {
+	{
+		.name = "rt_runtime_us",
+		.read_s64 = cpu_rt_runtime_read,
+		.write_s64 = cpu_rt_runtime_write,
+	},
+	{
+		.name = "rt_period_us",
+		.read_u64 = cpu_rt_period_read_uint,
+		.write_u64 = cpu_rt_period_write_uint,
+	},
+	{ }	/* Terminate */
+};
+
 # ifdef RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -9871,6 +9873,16 @@ static int __init setup_rt_group_sched(char *str)
 	return 1;
 }
 __setup("rt_group_sched=", setup_rt_group_sched);
+
+static int __init cpu_rt_group_init(void)
+{
+	if (!rt_group_sched_enabled())
+		return 0;
+
+	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
+	return 0;
+}
+subsys_initcall(cpu_rt_group_init);
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 static int cpu_extra_stat_show(struct seq_file *sf,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 161d91f7479b4..db7cdc82003bd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -195,6 +195,9 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 
 void unregister_rt_sched_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return;
+
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
 }
@@ -203,6 +206,9 @@ void free_rt_sched_group(struct task_group *tg)
 {
 	int i;
 
+	if (!rt_group_sched_enabled())
+		return;
+
 	for_each_possible_cpu(i) {
 		if (tg->rt_rq)
 			kfree(tg->rt_rq[i]);
@@ -247,6 +253,9 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 	struct sched_rt_entity *rt_se;
 	int i;
 
+	if (!rt_group_sched_enabled())
+		return 1;
+
 	tg->rt_rq = kcalloc(nr_cpu_ids, sizeof(rt_rq), GFP_KERNEL);
 	if (!tg->rt_rq)
 		goto err;
-- 
2.47.1


