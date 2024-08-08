Return-Path: <cgroups+bounces-4163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671394B42D
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 02:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D901C214B0
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2024 00:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5789BA37;
	Thu,  8 Aug 2024 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzizEU6f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01968C13;
	Thu,  8 Aug 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076761; cv=none; b=GQ/IzYCHtRpGqWv5Wgsk14U/lYtbQYAa20yY1zyhg3Gz4g8j132F4py7ofaSmoLl66mzCb8O5o99jm8zmYeEbVEDzFmxpKbIFRPxxU5INtbYjt6ZZSOp+RnCAC41gDKMLEAUKcNOYU72SNn6v/SVe/RfyIiMVnbBaWsP99WLDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076761; c=relaxed/simple;
	bh=m8uv1X8zSX7Xw3xhi0FANkpb4daTM+lkh8W0Uz5qiug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLVy+GItLE6Jw3nn27EOzL50NXP+ZG8mI6GTYhkdLPpjxZpm/CP4St67DpZRyoAJrZnf+I3w4cAV+B3OxbO/Y4KUAfD2Ywuc1StsNXPONlI/tt9CKArP1y21XbQwIW/FGtzNJx81e7WDE0DSzX7WZu90WTxIVk/0jCTQyObMTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzizEU6f; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb55ff1007so418747a91.0;
        Wed, 07 Aug 2024 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076759; x=1723681559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/Jse/E2nwZQdA1RD6cqA67l0MVQl8BpaW8pyPtwdw0=;
        b=QzizEU6f2DZQ6wniGsPvAy86uGHhdejEFLjL37trjf7G+h/5whhl2Dtc9I1dJYe7bL
         hLksbyp6k/QKz41nTYAegBE100McTplQeeLVz+2kTpQYNxuY2pW5hAYIB4El94/YJZfi
         S16QAPTrFjrAz+wBHrd12syiBbJLqKkVXCyqcYmPG8OVDyosSGtd2aJYTm9tPOCbrTGH
         WeUzF/e0ZgdIuQBZOZenYyJ64eqYk1dD6m4EulM1CyJBgsho7TY8HdcivZ0gqT+d9nT+
         3br3CVuY1pg4vAbpSdsSIqUndPJvf4K8CdjZ0B97kFwW6jykftOdfRVUqog5c2qjYbOO
         R71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076759; x=1723681559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/Jse/E2nwZQdA1RD6cqA67l0MVQl8BpaW8pyPtwdw0=;
        b=p5KD0MFVeBvrmvekTZ3k8fxVBpVexE534sn3hB21w3+iQRt6XWmutxfpdX7NlY1pn7
         0IqCUtnApODkSF02fB0LGy0WEAYn6PVPMgO84rF5BLZC3TZx2L4rSkplRYy1GOwlg6Hn
         OpwxOdLDbu2KmmAcQT6HQPUV9gSpFW6EFGAL59G0DT/ex2vN5bF1MyeEsqJqGISnYl6G
         xaKgfYIy2IB2MhGRYetp5n9eJDCSIf2tK/MHN5vVg/1K+gqB2HNPQPWfY8pgEpG0/zBm
         lZQqlBYRb6vJWG1R+n1GZak6uBvKjEQozWl1If0KIvPO9SpjNvoDSrkurIObIj0gEH8D
         VhQg==
X-Forwarded-Encrypted: i=1; AJvYcCUHrS6ctFsO+I+sfco/MD/gUKQYvjnzXlv0AE72Z3qISTQHsYlfOz2tRhPy1Q8UORQcKYZKriGMX7XwZiJvEvIj2O2wcbsFIeqAj0t7
X-Gm-Message-State: AOJu0Yy/Ovwvk+6Hoc0z7LZphsQ4BRudx4THPs4f/s+KD/e37zWQYbgn
	c4Jxpf+dzi7SIiQRNRYHypT2fRbVEJxEBuC8eha0XzC7fes7RVPr
X-Google-Smtp-Source: AGHT+IHiCJdoZpKUEsqtes8OWkZxKMBaCH+nsu9YzR7zd63uGflDhu4609/cLvmCrk8mhqFBWlyFYw==
X-Received: by 2002:a17:90a:9a92:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2d1c337141amr306024a91.5.1723076759133;
        Wed, 07 Aug 2024 17:25:59 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab39d6sm2236748a91.13.2024.08.07.17.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:25:58 -0700 (PDT)
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
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>
Subject: [PATCH 3/7] sched: Enumerate CPU cgroup file types
Date: Wed,  7 Aug 2024 14:25:25 -1000
Message-ID: <20240808002550.731248-4-tj@kernel.org>
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

Rename cpu[_legacy]_files to cpu[_legacy]_cftypes for clarity and add
cpu_cftype_id which enumerates every cgroup2 interface file type. This
doesn't make any functional difference now. The enums will be used to access
specific cftypes by a new BPF extensible sched_class to selectively show and
hide CPU controller interface files depending on the capability of the
currently loaded BPF scheduler progs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 22 +++++++++++-----------
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c9678614e476..49ddc7bc63f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9572,7 +9572,7 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static struct cftype cpu_legacy_files[] = {
+static struct cftype cpu_legacy_cftypes[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
 		.name = "shares",
@@ -9801,21 +9801,21 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 }
 #endif
 
-static struct cftype cpu_files[] = {
+struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	{
+	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_weight_read_u64,
 		.write_u64 = cpu_weight_write_u64,
 	},
-	{
+	[CPU_CFTYPE_WEIGHT_NICE] = {
 		.name = "weight.nice",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
-	{
+	[CPU_CFTYPE_IDLE] = {
 		.name = "idle",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_s64 = cpu_idle_read_s64,
@@ -9823,13 +9823,13 @@ static struct cftype cpu_files[] = {
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
-	{
+	[CPU_CFTYPE_MAX] = {
 		.name = "max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
-	{
+	[CPU_CFTYPE_MAX_BURST] = {
 		.name = "max.burst",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_cfs_burst_read_u64,
@@ -9837,13 +9837,13 @@ static struct cftype cpu_files[] = {
 	},
 #endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-	{
+	[CPU_CFTYPE_UCLAMP_MIN] = {
 		.name = "uclamp.min",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_uclamp_min_show,
 		.write = cpu_uclamp_min_write,
 	},
-	{
+	[CPU_CFTYPE_UCLAMP_MAX] = {
 		.name = "uclamp.max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = cpu_uclamp_max_show,
@@ -9864,8 +9864,8 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.can_attach	= cpu_cgroup_can_attach,
 #endif
 	.attach		= cpu_cgroup_attach,
-	.legacy_cftypes	= cpu_legacy_files,
-	.dfl_cftypes	= cpu_files,
+	.legacy_cftypes	= cpu_legacy_cftypes,
+	.dfl_cftypes	= cpu_cftypes,
 	.early_init	= true,
 	.threaded	= true,
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e38e25d00d88..f365585488dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3785,4 +3785,25 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
 
 #include "ext.h"
 
+#ifdef CONFIG_CGROUP_SCHED
+enum cpu_cftype_id {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	CPU_CFTYPE_WEIGHT,
+	CPU_CFTYPE_WEIGHT_NICE,
+	CPU_CFTYPE_IDLE,
+#endif
+#ifdef CONFIG_CFS_BANDWIDTH
+	CPU_CFTYPE_MAX,
+	CPU_CFTYPE_MAX_BURST,
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	CPU_CFTYPE_UCLAMP_MIN,
+	CPU_CFTYPE_UCLAMP_MAX,
+#endif
+	CPU_CFTYPE_CNT,
+};
+
+extern struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1];
+#endif /* CONFIG_CGROUP_SCHED */
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.46.0


