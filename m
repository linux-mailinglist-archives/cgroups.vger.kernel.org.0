Return-Path: <cgroups+bounces-2831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25BB8C0A2B
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 05:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E71C21CC0
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484F5146D71;
	Thu,  9 May 2024 03:33:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919E13C3D3;
	Thu,  9 May 2024 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715225609; cv=none; b=tik+SwUmOhTtLULMC8f+IhPErKo2DLQkDSvLKF2XScXo5WXP++MCc7VLzANTyxOHqBm/DA3CTi7nt5pABBUHe8MOrBSFK29vkT5nqpFW1XmAVlLK7gfmrpX1vOreu85ixL78e+5XGAhIqSZ+Adh/DALlWjtH1QThfcokhkfeQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715225609; c=relaxed/simple;
	bh=pd7bAii/qeFuRcjl+QTgSWHftIrkr1j19A+devePA/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d4sa6ajOmHUcxZMJJwa0yM1qMC7iHxeQmWlA2Fy65RTbXc2eM1VNZqrJdagP3/Iuz+FoabF+KgP/e5r76wDhFikJSu2P9gML0yh7q5pPG0a/pFXw+lx93+PbLUxKGxpbYeK+fBJSWaa6ssvMe080mS+2IHUO9tlQgqpRYZKMDJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VZcvJ09hCzYnBp;
	Thu,  9 May 2024 11:29:32 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id C49D5180080;
	Thu,  9 May 2024 11:33:23 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 11:33:23 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeel.butt@linux.dev>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH -next] memcg, oom: cleanup unused memcg_oom_gfp_mask and memcg_oom_order
Date: Thu, 9 May 2024 03:26:28 +0000
Message-ID: <20240509032628.1217652-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Since commit 857f21397f71 ("memcg, oom: remove unnecessary check in
mem_cgroup_oom_synchronize()"), memcg_oom_gfp_mask and memcg_oom_order
are no longer used any more.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/sched.h | 2 --
 mm/memcontrol.c       | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d1cf672ac4c..61591ac6eab6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1449,8 +1449,6 @@ struct task_struct {
 
 #ifdef CONFIG_MEMCG
 	struct mem_cgroup		*memcg_in_oom;
-	gfp_t				memcg_oom_gfp_mask;
-	int				memcg_oom_order;
 
 	/* Number of pages to reclaim on returning to userland: */
 	unsigned int			memcg_nr_pages_over_high;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5d4da23264fa..d127c9c5fabf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2192,8 +2192,6 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 		if (current->in_user_fault) {
 			css_get(&memcg->css);
 			current->memcg_in_oom = memcg;
-			current->memcg_oom_gfp_mask = mask;
-			current->memcg_oom_order = order;
 		}
 		return false;
 	}
-- 
2.34.1


