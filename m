Return-Path: <cgroups+bounces-2935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A578C7D01
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ACE1F2211E
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36302158D95;
	Thu, 16 May 2024 19:07:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60412158D72;
	Thu, 16 May 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886467; cv=none; b=iyp6aSSdE6tqupwZD7mfE+MSUXMBwkt9DXvPeTID44CqXU6iKFklc+J26d9JuKT0XNgyVWYw+2rvM41qQwRI+KFF03A+vbbBDOrVF4xkPPeQdhDORiJG4DkM4KOn51p7gDEGvhFG+VuM1eyezzzFGembhZzvRRDbjnFEfSJD0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886467; c=relaxed/simple;
	bh=EmFSx8/Ii7PDX25whTQOapn04D9/HEs4Zzlo9FTr/5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnLvNplX5VozThf9gUVsy8UYK4Y8Gogo90Ytg1ExkR2w1k6Bi1ClpkIForkFtb/Rmi7FDlpsTReWrQIMI2P+AKwFA4tVFNWvcryQNjYVqLIlOxqcuV99nCKDTcJGo9snzjUF1/u1pOYYuRfce+HlcvESMELKQQwTcosSLEor6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so33208275e9.2;
        Thu, 16 May 2024 12:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886464; x=1716491264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61LwWLE7vVj50HZOr0xZhY/e3UrTUHc9jD8In45+Uew=;
        b=SCYCtO24VQHRUl/Z1D2vfoR3Xd+qjz7bCNLlux16gb++RFvygVgpMI/dSHhYRj+FJD
         dRUAzao1z4cTAtubeZq2GWVjk/gaNenSU5HYu4K1odYoJ+qOHSF1HTT9Ilpyr7NKJUvD
         R0Nm5VP5IneWoNr9j9J8hJRAm7tV081KPbKPgzek4XOLoIdM8tBGxGfH6uceulyQ214X
         4KgSVuC405rUXDnt9INU6/1fPKqEH93hRrwloLM4ysOc9oCZ3xcqhlWCriFna7/HSvNy
         tsY8yATMcVz5U0LV4J7rB91ekb3dmo8WGOW2YqDJ5j3TvPn79jaLZs5yqnXdAoifJ7OY
         llGA==
X-Forwarded-Encrypted: i=1; AJvYcCXSRlJM1mcBtnR15flDV1dr550aDIXdjJJht8t1jWr4WQydxnPl8ghzLmAJzvhzyF26HFeNXzOmpSF4a6yp7NKVInKIUfOAHsy3Zt3nId9oHPLL88vRBXFNzauxTisZMQ03EsUwFw==
X-Gm-Message-State: AOJu0YyHryGzBM2baZXx6Bm1PPADyLJlx9pl2pQPM02sZlOTAf12M3zh
	QaEza/Sxq2bFLWCHxrKGcFnxcQfEr1fAP8Nkrv9SG3pRHEL3MV+d
X-Google-Smtp-Source: AGHT+IEBxb/kDHNUZLNkFrbcua9vIlbfeC4Qz918TjIq4cHJPBlssgEmoiIGckrGbwvB1Tfo4KE0bg==
X-Received: by 2002:a05:600c:5487:b0:41b:851a:af43 with SMTP id 5b1f17b1804b1-41feaa38f9dmr133889165e9.11.1715886463488;
        Thu, 16 May 2024 12:07:43 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:07:43 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	prarit@redhat.com,
	vschneid@redhat.com,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH v1 1/7] sched/isolation: Add infrastructure to adjust affinity for dynamic CPU isolation
Date: Thu, 16 May 2024 22:04:31 +0300
Message-ID: <20240516190437.3545310-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516190437.3545310-1-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce infrastructure function housekeeping_update() to change
housekeeping_cpumask during runtime and adjust affinities of depended
subsystems.

Affinity adjustments of subsystems follow in subsequent patches.

Parent patch:
"sched/isolation: Exclude dynamically isolated CPUs from housekeeping masks"
https://lore.kernel.org/lkml/20240229021414.508972-2-longman@redhat.com/

Test example for cgroup2:

cd /sys/fs/cgroup/
echo +cpuset > cgroup.subtree_control
mkdir test
echo isolated > test/cpuset.cpus.partition
echo $isolate > test/cpuset.cpus

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/sched/isolation.c | 48 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 948b9ee0dc2cc..036e48f0e7d1b 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -116,6 +116,39 @@ static void __init housekeeping_setup_type(enum hk_type type,
 		     housekeeping_staging);
 }
 
+/*
+ * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
+ * change.
+ *
+ * Assuming cpuset_mutex is held in sched_partition_write or
+ * cpuset_write_resmask.
+ */
+static int housekeeping_update(enum hk_type type, cpumask_var_t update)
+{
+	struct {
+		struct cpumask changed;
+		struct cpumask enable;
+		struct cpumask disable;
+	} *masks;
+
+	masks = kmalloc(sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		return -ENOMEM;
+
+	lockdep_assert_cpus_held();
+	cpumask_xor(&masks->changed, housekeeping_cpumask(type), update);
+	cpumask_and(&masks->enable, &masks->changed, update);
+	cpumask_andnot(&masks->disable, &masks->changed, update);
+	cpumask_copy(housekeeping.cpumasks[type], update);
+	housekeeping.flags |= BIT(type);
+	if (!static_branch_unlikely(&housekeeping_overridden))
+		static_key_enable_cpuslocked(&housekeeping_overridden.key);
+
+	kfree(masks);
+
+	return 0;
+}
+
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
@@ -314,9 +347,12 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
 		/*
 		 * Reset housekeeping to bootup default
 		 */
-		for_each_set_bit(type, &housekeeping_boot.flags, HK_TYPE_MAX)
-			cpumask_copy(housekeeping.cpumasks[type],
-				     housekeeping_boot.cpumasks[type]);
+		for_each_set_bit(type, &housekeeping_boot.flags, HK_TYPE_MAX) {
+			int err = housekeeping_update(type, housekeeping_boot.cpumasks[type]);
+
+			if (err)
+				return err;
+		}
 
 		WRITE_ONCE(housekeeping.flags, housekeeping_boot.flags);
 		if (!housekeeping_boot.flags &&
@@ -344,9 +380,11 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
 		cpumask_andnot(tmp_mask, src_mask, isolcpus);
 		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
 			return -EINVAL;	/* Invalid isolated CPUs */
-		cpumask_copy(housekeeping.cpumasks[type], tmp_mask);
+		int err = housekeeping_update(type, tmp_mask);
+
+		if (err)
+			return err;
 	}
-	WRITE_ONCE(housekeeping.flags, housekeeping_boot.flags | flags);
 	excluded = true;
 	if (!static_branch_unlikely(&housekeeping_overridden))
 		static_key_enable_cpuslocked(&housekeeping_overridden.key);
-- 
2.45.0


