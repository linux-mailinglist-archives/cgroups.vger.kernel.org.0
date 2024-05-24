Return-Path: <cgroups+bounces-2992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6428CE34D
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 11:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D72C1F22B47
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70084FB8;
	Fri, 24 May 2024 09:26:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854E84E07;
	Fri, 24 May 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542779; cv=none; b=mwe/ccsfFxm9jNvsjpG7ANIHWG1tpzIJOZ2o78UvmfJIGG+J5XfqWBzFveVYVu//XLmgp8yQuFZdpjJtzKKlxlHw1P76OqRq74tLFI81LBS00SBCueASDVsGbR+g8UuOXqeKDkyqm9Ow/vVGovRdjfD9KMMGRZ+XA4MIJfU1bi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542779; c=relaxed/simple;
	bh=v0Pbzh1dn71qAhHL1x9syl/5TEsTx+Rf1bs3uhhMYOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wy9aLk24ZEmuqD0TZe+pzRgZLPaROHdVfLIi+9uhu3EdQxUeoNVZ0Iq8e+2sXZzPQEFcEufnDgo7JHrlv1j1/HFGQhpEnPyd+SVEOHYlWo2NAyoLvGRlz6oMwGkUVHroD5lCUIyA41en7kqlYeeSLqs6TDPDiR9WpPw3klq1nGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vm0124JfXzVlG4;
	Fri, 24 May 2024 17:21:58 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 82ABA180A9F;
	Fri, 24 May 2024 17:26:13 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 24 May 2024 17:26:13 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup/pids: replace can_attach and cancel_attach with attach hook
Date: Fri, 24 May 2024 09:18:51 +0000
Message-ID: <20240524091851.1539589-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Currently pids_can_attach() always returns 0 and never fails, so the
can_attach() and cancel_attach() hooks can be replaced by attach(),
since attach() is guaranteed to succeed and don't need to fallback.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/pids.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 0e5ec7d59b4d..86d06f709957 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -186,7 +186,7 @@ static int pids_try_charge(struct pids_cgroup *pids, int num)
 	return -EAGAIN;
 }
 
-static int pids_can_attach(struct cgroup_taskset *tset)
+static void pids_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *dst_css;
@@ -207,26 +207,6 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 		pids_charge(pids, 1);
 		pids_uncharge(old_pids, 1);
 	}
-
-	return 0;
-}
-
-static void pids_cancel_attach(struct cgroup_taskset *tset)
-{
-	struct task_struct *task;
-	struct cgroup_subsys_state *dst_css;
-
-	cgroup_taskset_for_each(task, dst_css, tset) {
-		struct pids_cgroup *pids = css_pids(dst_css);
-		struct cgroup_subsys_state *old_css;
-		struct pids_cgroup *old_pids;
-
-		old_css = task_css(task, pids_cgrp_id);
-		old_pids = css_pids(old_css);
-
-		pids_charge(old_pids, 1);
-		pids_uncharge(pids, 1);
-	}
 }
 
 /*
@@ -374,8 +354,7 @@ static struct cftype pids_files[] = {
 struct cgroup_subsys pids_cgrp_subsys = {
 	.css_alloc	= pids_css_alloc,
 	.css_free	= pids_css_free,
-	.can_attach 	= pids_can_attach,
-	.cancel_attach 	= pids_cancel_attach,
+	.attach		= pids_attach,
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
-- 
2.34.1


