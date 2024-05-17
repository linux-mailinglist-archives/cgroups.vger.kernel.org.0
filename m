Return-Path: <cgroups+bounces-2943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4324E8C7F99
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 03:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7463D1C20C92
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1BECC;
	Fri, 17 May 2024 01:36:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81921C32;
	Fri, 17 May 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909771; cv=none; b=fxg0UYyKO4oYyXiJdmZx4E8KXM+f4msWflm+V7s4ibMOmA5HG1sX/I29qiX6cm10FNevAVrzztnUnkJSHq3LMrF5hDBaBXCqVfrq0seQN+yBrRm7NBaRflmA8j/G+QsqjFFAD59D0a7pOKL4P4rI7f9ZZD6kSyHeBsv9OSujZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909771; c=relaxed/simple;
	bh=9nsWiDoqMP+bv7hNgD63p3KLfvgHyLkg/2/dE4fN4Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ESCekR/n3ZcdrNCVGWVX2PjfFn5p3pVra7iqow1CrZ6J+by+A3x52hfKuRZFNVCDbMRkKgw1UgZtJVlH7hMqaXw8Hjkjx0SyPkPrHYaFMeEDe6GEHni7nCnA85ca8ef1PNUyNgf26Xd8l0LqlhTnvn1PTBrG0hhcQx1q/SN4lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VgTzF3zCYzchgY;
	Fri, 17 May 2024 09:34:49 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C6A0140384;
	Fri, 17 May 2024 09:36:04 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 17 May
 2024 09:36:00 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cyphar@cyphar.com>
Subject: [PATCH -next] cgroup/pids: remove pids_cancel_attach
Date: Fri, 17 May 2024 01:30:01 +0000
Message-ID: <20240517013001.215350-1-chenridong@huawei.com>
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
 kwepemd100013.china.huawei.com (7.221.188.163)

In pids subsystem, pids_can_attach never returns an error.
Therefore, pids_cancel_attach is unnecessary and is never called.
As a result, it should be removed.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/pids.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 0e5ec7d59b4d..a7a719495547 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -211,24 +211,6 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 	return 0;
 }
 
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
-}
-
 /*
  * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
  * on cgroup_threadgroup_change_begin() held by the copy_process().
@@ -375,7 +357,6 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.css_alloc	= pids_css_alloc,
 	.css_free	= pids_css_free,
 	.can_attach 	= pids_can_attach,
-	.cancel_attach 	= pids_cancel_attach,
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
 	.release	= pids_release,
-- 
2.34.1


