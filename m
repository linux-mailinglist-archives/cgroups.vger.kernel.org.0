Return-Path: <cgroups+bounces-4895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96097A21D
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A81C210EE
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38256154C14;
	Mon, 16 Sep 2024 12:23:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0714B094;
	Mon, 16 Sep 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489403; cv=none; b=Tl9zrrHPgWrckzz2esg3RpM4cBircyoGhaJJL0wq0LygoHz1u2keBnnlxfol8L4fafUA3rxr1b8tHfGM93uGIFVCCbUV7clSyLD4+bHC6tMB2XZtxVPvsucQbkKPb5KY3zx5nXOi7xAySv+HDtTi8eDAl2a65IqfLEo1teWy0h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489403; c=relaxed/simple;
	bh=SxLsXlxTP2H5dHNDB2XckZNzj6N1DE/5WRZf4FZZvsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbd+a9OQtMRyZUNOCX0bGjGMgGkkspCOEYV0pqQqz1XtgLzZjWdWRHR6SHcSWP6CZkaehsWwEcQXkM4zGK1l3LNQkR5scdvITzRyS5wYg9BgxrPCGs1WhhnXt2p7XLjbRxXDSjyAjFAuyhQSe9Tcigtmy47f+UZAGkpK0fWqdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso33802115e9.0;
        Mon, 16 Sep 2024 05:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489399; x=1727094199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XP7JYTPswuC1MNC97EWdOwUS12t/7UGSoTDEE9+Gmw=;
        b=C+hgv4K/NN+msVfa3b8k3R4UuWMw0OrEMIaZrZKcLIb9Zv21XFRsfdd3AhQT6xtT3X
         4Hlsz9k25T+6iZqmA2E2cjJmm3eJFTqsiiHx44HFCWZwjPGVZuw4f9FKusLf3gs1I2gl
         8q8FlUq8LjmibKwCipBOpR9MHZu5FeGEdGCwYKAOp1290fFI1op07/7Yp3bDx27kLV+0
         A+ujwXQTZyYHzVx5HmgIZygcfhpSG5iypJbziY7SmidHndCB/OMARuGz/UBoB/X5Es3a
         VQCe0gC7ymwMl7a2z87aTbHQk7AhfQrsiIyPZm9m7iK/DZrXzUPo9w6cByP1mHcOdrBo
         hZAA==
X-Forwarded-Encrypted: i=1; AJvYcCWjjH04tq5GUaqCVWdoIROU5oEkp16TiIbTS4m/Z62g9sCc6bIuycvlx/uTOMp5/0hzuWBH7Bai@vger.kernel.org, AJvYcCXurA7z4eD2XwaEr9ZmqGWuwzlC1v9GTamN9DVg9aoxR7z2zBuQJDyDHOxZsinbCAoOIV/ju2F7vBc9EEcB@vger.kernel.org
X-Gm-Message-State: AOJu0YxJUlVde4kSxNsWKmT8RkaVkxw4LMNUtoIn7DZZy3KtW8YRaKZV
	GhKHqTd/J0skVIN7deTxmhAorf0hnRobVP1NgnX9IfQpuHzTdFI1
X-Google-Smtp-Source: AGHT+IFNI4iYpjMKYAcaWjWoU/iNfgpzX74OJKJcuWhd59WCiBCwFyoNGw6iT8rIvbAFpRO0GYaD9w==
X-Received: by 2002:a5d:4d51:0:b0:374:d2a3:d213 with SMTP id ffacd0b85a97d-378c27b4d25mr8711614f8f.18.1726489399460;
        Mon, 16 Sep 2024 05:23:19 -0700 (PDT)
Received: from costa-tp.. ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800243sm7117272f8f.86.2024.09.16.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:23:18 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 1/3] sched/isolation: Add infrastructure for dynamic CPU isolation
Date: Mon, 16 Sep 2024 15:20:42 +0300
Message-ID: <20240916122044.3056787-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240916122044.3056787-1-costa.shul@redhat.com>
References: <20240916122044.3056787-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce infrastructure function housekeeping_update() to change
housekeeping_cpumask during runtime and adjust configurations of depended
subsystems.

Configuration adjustments of subsystems follow in subsequent patches.

Parent patch:
sched/isolation: Exclude dynamically isolated CPUs from housekeeping masks
https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
Changes in v2:
- remove unnecessary `err` variable
- add for_each_clear_bit... to clear isolated CPUs
- Address Gleixner's comments:
- use WRITE_ONCE to change housekeeping.flags
- use `struct cpumask *update` in signature of housekeeping_update

v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-2-costa.shul@redhat.com/
---
 kernel/sched/isolation.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3018ba81eb65d..3f24921b929a0 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -124,6 +124,36 @@ static void __init housekeeping_setup_type(enum hk_type type,
 		     housekeeping_staging);
 }
 
+/*
+ * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
+ * change.
+ */
+static int housekeeping_update(enum hk_type type, const struct cpumask *update)
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
+	WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
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
@@ -327,8 +357,11 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
 		/*
 		 * Reset housekeeping to bootup default
 		 */
+
+		for_each_clear_bit(type, &boot_hk_flags, HK_TYPE_MAX)
+			housekeeping_update(type, cpu_possible_mask);
 		for_each_set_bit(type, &boot_hk_flags, HK_TYPE_MAX)
-			cpumask_copy(housekeeping.cpumasks[type], boot_hk_cpumask);
+			housekeeping_update(type, boot_hk_cpumask);
 
 		WRITE_ONCE(housekeeping.flags, boot_hk_flags);
 		if (!boot_hk_flags && static_key_enabled(&housekeeping_overridden))
@@ -355,9 +388,8 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
 		cpumask_andnot(tmp_mask, src_mask, isolcpus);
 		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
 			return -EINVAL;	/* Invalid isolated CPUs */
-		cpumask_copy(housekeeping.cpumasks[type], tmp_mask);
+		housekeeping_update(type, tmp_mask);
 	}
-	WRITE_ONCE(housekeeping.flags, boot_hk_flags | flags);
 	excluded = true;
 	if (!static_key_enabled(&housekeeping_overridden))
 		static_key_enable_cpuslocked(&housekeeping_overridden.key);
-- 
2.45.0


