Return-Path: <cgroups+bounces-5476-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07409C162B
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 06:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C4AB22436
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF01CF5F4;
	Fri,  8 Nov 2024 05:50:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B81CB333;
	Fri,  8 Nov 2024 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045001; cv=none; b=qgP478Myi7CBjFvx9l1UBLH/GEivaVK7rivnYfCAY25rn8BYO2Er0+0BP2snFuBObIuWX9u4CBMnrV6ekF2Hfjn1V9409zVycJLoQ0gE0O096AFFQnnR3W0zP4TR2XHQ1uDiteci4qp8HfX1suEAp6SeJ6BBWni1y1uQRAU6rpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045001; c=relaxed/simple;
	bh=4xR53PDd98NzuHtm+coyCSCBhYZ8NGUQWuYXvFMdskQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eD8SP7VdmJhJS/IgRdpNv9PTvzHSnSXH301X1GRuCi29+P+m25uXIWXH4/e9/L6BhKGMOhhjiOOBVxKVdwsUwq4mFs8Ecbqcub2GUxkWUwBY36EjpaI/kvWR+1iUx/DtDM5EXjuzqHoOfJ89q49HhwdTdeE7FqmBBXFQwrZMhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315abed18aso15432005e9.2;
        Thu, 07 Nov 2024 21:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731044997; x=1731649797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjrFbWx5GMxfzojIwOC1+rm9ruecZ0O8uYiOirOduV4=;
        b=lk5++fyipn5yUAby0jDAHMsntnxlf1XKhjOVNmAzai+LkW/Wrlk8HWPq+UlEMMcx//
         J3gBHK+IeilUvik6VQ6KJ9URcFgQWbJPSUgFCB9dsapSMukAe+P6Y1RKtHJt06XBGQ4I
         2uCfnvEUJJOuhXyiGt7weXvU89Sw1O2JAiLPNoSNP617DCKrgFfAMDNFrPK8gI500L16
         uCn+RdyxECGYz5VvCBGajq4vaLMs4fr1Jz7qa0iyyOAO9WtnJVjZCdu2NuM5z8hc1TUP
         DSLw70WEmt9PKChJKidDrwse2lynH7wHhN5LEL5drWm2wsg4bE76XcjSdmkqqpXxoj0Q
         CWEw==
X-Forwarded-Encrypted: i=1; AJvYcCW5LDzcjSwQ83GMtGIMkJ3Kg0Puhx7Kn3vTwsjTHI38+3Rf2jWmH4N20dUHxV9z6rstQex2s285@vger.kernel.org, AJvYcCWMEsV2+rbOUnA+8mamXUIcAdVarfgWBKiaJn+/vza86om9pDyuFgYyBrFc1zu4YnZU6paYJNmLoyc/3tH9@vger.kernel.org, AJvYcCX4EcyoryQvFD8Q64u0MTCE5aWTcBz7Ri1o5jDbxM9poUsZngYadubn4OjkMEa5Y1caydAOSh8488uFzZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8Hw9+47n7PQ1f6zbecPT91UDEpBoR0KKJ9tO+VGQGSvlufVS
	eRcUqZVWFMTt3n1MGYoRs3jex/GJYM5lwOMOt4bANhoEau8olIc0yGwvbVXeYJk=
X-Google-Smtp-Source: AGHT+IFzviccxJHzJWJN3Rz0zs35SXPPkUsqbCz5gPgCEJvg2M+bZQVPkHvz/bBLz2AFkrOMflrFOA==
X-Received: by 2002:a05:6000:470f:b0:37d:5113:cdff with SMTP id ffacd0b85a97d-381f18805c8mr1209692f8f.37.1731044997106;
        Thu, 07 Nov 2024 21:49:57 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c26e3sm50505655e9.33.2024.11.07.21.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:49:55 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: ming.lei@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	Waiman Long <longman@redhat.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
Date: Fri,  8 Nov 2024 07:48:30 +0200
Message-ID: <20241108054831.2094883-3-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected
CPUs from running some kernel housekeeping subsystems to minimize
disturbance to latency sensitive userspace applications such as DPDK.
This options can only be changed with a reboot. This is a problem for
containerized workloads running on OpenShift/Kubernetes where a
mix of low latency and "normal" workloads can be created/destroyed
dynamically and the number of CPUs allocated to each workload is often
not known at boot time.

Cgroups allow configuring isolated_cpus at runtime.
However, blk-mq may still use managed interrupts on the
newly isolated CPUs.

Rebuild hctx->cpumask considering isolated CPUs to avoid
managed interrupts on those CPUs and reclaim non-isolated ones.

The patch is based on
isolation: Exclude dynamically isolated CPUs from housekeeping masks:
https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 block/blk-mq.c         | 30 ++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  1 +
 kernel/cgroup/cpuset.c |  2 ++
 3 files changed, 33 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 12ee37986331..d5786b953d17 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4145,6 +4145,36 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	}
 }
 
+/**
+ * blk_mq_isolate_cpus() - rebuild hctx->cpumask considering isolated CPUs
+ * to avoid managed interrupts on those CPUs.
+ */
+
+void blk_mq_isolate_cpus(const struct cpumask *isolcpus)
+{
+	struct class_dev_iter iter;
+	struct device *dev;
+
+	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
+	while ((dev = class_dev_iter_next(&iter))) {
+		struct request_queue *q = bdev_get_queue(dev_to_bdev(dev));
+		struct blk_mq_hw_ctx *hctx;
+		unsigned long i;
+
+		if (!queue_is_mq(q))
+			continue;
+
+		blk_mq_map_swqueue(q);
+		/*
+		 * Postcondition:
+		 * cpumask must not intersect with isolated CPUs.
+		 */
+		queue_for_each_hw_ctx(q, hctx, i)
+			WARN_ON_ONCE(cpumask_intersects(hctx->cpumask, isolcpus));
+	}
+	class_dev_iter_exit(&iter);
+}
+
 /*
  * Caller needs to ensure that we're either frozen/quiesced, or that
  * the queue isn't live yet.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131f..a1f57b5ad46d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -924,6 +924,7 @@ void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
+void blk_mq_isolate_cpus(const struct cpumask *isolcpus);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5066397899c9..cad17f3f3315 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -41,6 +41,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/blk-mq.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)    "%s:%d: %s " fmt, __FILE__, __LINE__, __func__
@@ -1317,6 +1318,7 @@ static void update_isolation_cpumasks(bool isolcpus_updated)
 		return;
 	ret = housekeeping_exlude_isolcpus(isolated_cpus, HOUSEKEEPING_FLAGS);
 	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
+	blk_mq_isolate_cpus(isolated_cpus);
 }
 
 /**
-- 
2.47.0


