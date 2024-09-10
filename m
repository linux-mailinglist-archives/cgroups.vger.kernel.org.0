Return-Path: <cgroups+bounces-4791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C948D972B2A
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9021F2370A
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C951181B9A;
	Tue, 10 Sep 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ckyc9NiD"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47D17E00A;
	Tue, 10 Sep 2024 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954536; cv=none; b=D1XiepCbqUwjEPqMKax5YYDgZ+ZHd88odsi8JnOenyjZZQcSsaN9e9VOSX9zMua9Ywyh2V+0TvDZQ2BkQXs9Qs0u8E0GWg1dbYyZsqtZMxMTFF2UWGBVrDQ5H4+4souYKZHf9aMk401LyDFBdWYC9ihLbuW+fFsJUskinVHHWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954536; c=relaxed/simple;
	bh=HOHVrdoi1+eH8qohrRBQf4/a6+x7SJsmj2ojmQX2gl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=At5qv4Zl2qy3SHXfwUdmDZrpBqdaOorXHJTQ5eEDUYG02Gc9IH17KSLpit1KyFOb6AFQQYlNE55wz3LesCIGZytdhDqhb49ZNRbnH1RL+lWx5kezBvSFzLEU+GRmLZRI36sIHRpD2HXdilrLWboRyVilrH89P/8b7nkhcevwtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ckyc9NiD; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725954530; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ORSeM/D/iyAEx3ScduXILHkRmDH4FWmKtuAsaeTitYc=;
	b=Ckyc9NiDBwDQzDmZe9f40itTBxbrPKBDeFGtFKN3XGzLKrk5kg/iZq8h/nlhv5iBcIG2/VR5sKbmmXzNXDc2KQYHiODI+WO+2aHdszrna/lRe1GQLS2f6M8kEVx2MRBdzpLQS/YQl2UFUQ7v874vHFT+2QNRSZM8bUWh/0Up1G0=
Received: from e69e13503.et15sqa.tbsite.net(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0WEjgEnu_1725954512)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 15:48:50 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liusong@linux.alibaba.com
Subject: [RFC PATCH] sched, cgroup: cgroup1 can also take the non-RUNTIME_INF min
Date: Tue, 10 Sep 2024 15:48:32 +0800
Message-Id: <20240910074832.62536-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the handling logic of child_quota, there is no need to distinguish
between cgroup1 and cgroup2, so unify the handling logic here.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/core.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e752146e59a4..8418c67faa69 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9501,23 +9501,12 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
 		parent_quota = parent_b->hierarchical_quota;
 
 		/*
-		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
-		 * always take the non-RUNTIME_INF min.  On cgroup1, only
-		 * inherit when no limit is set. In both cases this is used
-		 * by the scheduler to determine if a given CFS task has a
-		 * bandwidth constraint at some higher level.
+		 * Ensure max(child_quota) <= parent_quota.
 		 */
-		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
-			if (quota == RUNTIME_INF)
-				quota = parent_quota;
-			else if (parent_quota != RUNTIME_INF)
-				quota = min(quota, parent_quota);
-		} else {
-			if (quota == RUNTIME_INF)
-				quota = parent_quota;
-			else if (parent_quota != RUNTIME_INF && quota > parent_quota)
-				return -EINVAL;
-		}
+		if (quota == RUNTIME_INF)
+			quota = parent_quota;
+		else if (parent_quota != RUNTIME_INF)
+			quota = min(quota, parent_quota);
 	}
 	cfs_b->hierarchical_quota = quota;
 
-- 
2.19.1.6.gb485710b


