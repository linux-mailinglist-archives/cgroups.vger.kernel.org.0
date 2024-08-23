Return-Path: <cgroups+bounces-4419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484C95CA0E
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C20282CFF
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422DA188A04;
	Fri, 23 Aug 2024 10:09:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043D183061;
	Fri, 23 Aug 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407742; cv=none; b=HEIBcD3TB0UC5fmmyPMhBm8foFz+s3cn0wi9zTXPgUP1AAhcqj47htEgzK/96w6cNUGCjeSFGfKceoDPTq//VHtxWqFT7Z5qMHlNH5YE3iMt2Ef2EvuAOldKMBGV79PKUp+g4kXdnb+odF+z1oK+eBmFqrKXDgOgnvPBbAwaZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407742; c=relaxed/simple;
	bh=VrBfp3g7SZTrWGg8jE2hHvpW3SVZ0+n3/LsJIdLGf5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yev/s5MY5/87HMbMMoFxPg7h8n3JPk2fwC7TlyxVnlGa4TURUWCGvjxQbyz+Ojee6zK3qnejWl+8SUeV7rZnUeu/QWhvMkDx89osuysr/+sVp3Uz0biAm0kxs0B+L1jNRNhOIqhDcSpiFljWDDhdISuHcvtkMgk+G1lvaJ0BamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wqwl76qv2z2CnB3;
	Fri, 23 Aug 2024 18:08:51 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C530818001B;
	Fri, 23 Aug 2024 18:08:56 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 18:08:56 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <mkoutny@suse.com>, <chenridong@huawei.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 -next 06/11] cgroup/cpuset: add callback_lock helper
Date: Fri, 23 Aug 2024 10:01:05 +0000
Message-ID: <20240823100110.472120-7-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823100110.472120-1-chenridong@huawei.com>
References: <20240823100110.472120-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

To modify cpuset, both cpuset_mutex and callback_lock are needed. Add
helpers for cpuset-v1 to get callback_lock.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  2 ++
 kernel/cgroup/cpuset.c          | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index e5ab71d9d06f..15d967e32d4c 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -239,6 +239,8 @@ static inline int is_spread_slab(const struct cpuset *cs)
 }
 
 void rebuild_sched_domains_locked(void);
+void callback_lock_irq(void);
+void callback_unlock_irq(void);
 
 /*
  * cpuset-v1.c
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2b588ea47079..196cf618535d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -269,6 +269,16 @@ void cpuset_unlock(void)
 
 static DEFINE_SPINLOCK(callback_lock);
 
+void callback_lock_irq(void)
+{
+	spin_lock_irq(&callback_lock);
+}
+
+void callback_unlock_irq(void)
+{
+	spin_unlock_irq(&callback_lock);
+}
+
 static struct workqueue_struct *cpuset_migrate_mm_wq;
 
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
-- 
2.34.1


