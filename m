Return-Path: <cgroups+bounces-4164-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3300B94B42F
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45241F2312A
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 00:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E5D530;
	Thu,  8 Aug 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUKexqIz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93134BA2D;
	Thu,  8 Aug 2024 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076762; cv=none; b=LChVQ3hthA5rmpMIQn4uV65xUrghvM/SZSX6h+eM0wyN0luSuBj/+UIbIJf7w89saK2RMSfnjk3qeSri2/ZoqDtOsSdaN8l69pJ4Yr3bV/Sc6KBY/qG9v5R2t5KON54CGCihkIMILGA0b0jmnxBlDPiiM0XSBCANxnjNth8ygq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076762; c=relaxed/simple;
	bh=qJ4wgqlIWhAbFkKfdcMVSoBREb2yWKFURbSjFGlii/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKV4GgA2gD1sF7A1d4fZP34o9QLuztIvXWieky//rrU6y2Jh7I8imrFUi2PY+uri9idxPvujW7PBn6u6AOfTeTBnpLZs9ZafVhMCTZxTBduvmDR5N2YxOjtV846KX+V3+SJIEWbVulbdTVSMVOhl0JSBAWRYmZFHqiI9CVho+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUKexqIz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7bb75419123so338163a12.3;
        Wed, 07 Aug 2024 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076761; x=1723681561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp7+N3S0vmqdWZLsDXCfXaBoDhFSEKQqN0yHT10BI/g=;
        b=aUKexqIzgarVKMoB3GmR2XVzs9m7uyi07wg+EmpxQnRk9aHgqKSx7eqPQgrceDVTUV
         HRuf1SyQunsgvoDanW1/zNn27JwHvqFnSf870zMLf2dDQ/VMgn9CNiw2I7HSdY8nDvvC
         eGQOaDNqfWZDrS7EbB4J3YXFIXHpSuGKPqp8hRq7hnO2MuECL5LPh/JnLya2+KfY+PXb
         3lEf+mvTXG0PKw+4JkEqJv9EGik+X3xCff6MSW8sQD1dFL/SkFyGIkKpO7ZJFZYl3d66
         wCfuMoDhhhhCGNv2fipJ0Rv4Xbjwt+4GWy1S8+qWDBK2luzZUV4ZtGpbPZqK6Xg6L72u
         Y9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076761; x=1723681561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cp7+N3S0vmqdWZLsDXCfXaBoDhFSEKQqN0yHT10BI/g=;
        b=n5NQcqrULbRIsXTmmENFzUQ8aHGMKLch9j+zVkShLoGSVBvCRCL7hpi5eBkAFsf7ks
         urX3+B1i0Hk2IcXfYTpdd4QU/FNMQWKI8DcCWtnzAgEKAwklUSAdkdfjifomUqShGKTI
         E9w3Hk2E2uDGzzDb64HTJaX+DoGK17DD3nlOsrOnpbkTypsUeGkpYpnbF0YRjwmUW5P7
         z9e7J1tKwRyKCFmeWNT8nCwvip89zmAfgUmdWC880ZuwUziVn2Zo53BgTEVEeYMS0+Op
         GGBoQykdXhuQRTCeoS9u89EuxuTO4hpSEfwzze78xjY084CE/Kll1pJvYbOBao+S5Adl
         QgWA==
X-Forwarded-Encrypted: i=1; AJvYcCUFvxtok8jPc8SQLH/gkNPFw7WWEhzhrrULW8ufmjGVV6nllzVR+WHZ7zDee/fOiSKySLI52FugiePOSwIESQkNOtglvi+ef+C70yIA
X-Gm-Message-State: AOJu0YzBW76kQ5HwqV5RwMISAriC8xL/g0sFnYKvz9nxlTd9ty5Gw4DS
	p4cmNZrbriBigOCYrBB+xaxVeCBBUJNhPHbBudA6LtxqpcaygUQB
X-Google-Smtp-Source: AGHT+IHOaCrYWOR3jypRGBa60tufEoWbxsy96IAjiARmSrVrpJWjPcMxwHPLRGY1hGHdTE+CJE8j5Q==
X-Received: by 2002:a17:90b:3a4b:b0:2c9:69cc:3a6f with SMTP id 98e67ed59e1d1-2d1c347b714mr298297a91.31.1723076760812;
        Wed, 07 Aug 2024 17:26:00 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3adaac6sm2212649a91.24.2024.08.07.17.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:26:00 -0700 (PDT)
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
Subject: [PATCH 4/7] sched: Make cpu_shares_read_u64() use tg_weight()
Date: Wed,  7 Aug 2024 14:25:26 -1000
Message-ID: <20240808002550.731248-5-tj@kernel.org>
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

Move tg_weight() upward and make cpu_shares_read_u64() use it too. This
makes the weight retrieval shared between cgroup v1 and v2 paths and will be
used to implement cgroup support for sched_ext.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 49ddc7bc63f5..43a62e9ada84 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9170,6 +9170,11 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+static unsigned long tg_weight(struct task_group *tg)
+{
+	return scale_load_down(tg->shares);
+}
+
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
@@ -9181,9 +9186,7 @@ static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
-	struct task_group *tg = css_tg(css);
-
-	return (u64) scale_load_down(tg->shares);
+	return tg_weight(css_tg(css));
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -9685,11 +9688,6 @@ static int cpu_local_stat_show(struct seq_file *sf,
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static unsigned long tg_weight(struct task_group *tg)
-{
-	return scale_load_down(tg->shares);
-}
-
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
-- 
2.46.0


