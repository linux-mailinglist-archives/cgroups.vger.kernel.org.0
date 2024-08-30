Return-Path: <cgroups+bounces-4613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3C965E0D
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233531C20627
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DA189BA4;
	Fri, 30 Aug 2024 10:10:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43617BB1E;
	Fri, 30 Aug 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012627; cv=none; b=Hs3JjIjK/F6MxMvW2cgAijXW+h7NE/z7cEfHdRn1/8R9ZCJNvzIhTU3H3CeuwKaXIPpbQLFhNnNAvOI1x6CYLyC2nu0Zw89jsJ4CUcu/L0D6sMrIJnyAzmi5sg8lWxrq0DNUieoQw1jUfQ9aeZOa8uwOTW6TyY1GH42WNjWIB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012627; c=relaxed/simple;
	bh=DkDXcSckXmiVbJCh7WTsGtiSGDTJngFNen4GjNAU+XM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyzcWuZ6t9Cbk1vYoWt/dH83pHiFN2I3jKj8wU/7XcbFwsW5N0VHMcWNNUIXzTxeHbBv0cLp2+wHZhLkaPhBFWp9Y+NiZexnzJCbMHvz6I0N0/P+hzlIR+c42rnuq5tf1BgG3les66KcJhbwRYHgOd+rAxhqTlQpIeY+i7FvT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WwDPN1ZLSz1xwWw;
	Fri, 30 Aug 2024 18:08:24 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id AF081140361;
	Fri, 30 Aug 2024 18:10:22 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 18:10:21 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v4 -next 06/12] cgroup/cpuset: add callback_lock helper
Date: Fri, 30 Aug 2024 10:02:23 +0000
Message-ID: <20240830100229.953012-7-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
References: <20240830100229.953012-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

To modify cpuset, both cpuset_mutex and callback_lock are needed. Add
helpers for cpuset-v1 to get callback_lock.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  2 ++
 kernel/cgroup/cpuset.c          | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 02c4b0c74fa9..9a60dd6681e4 100644
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
index 0a3347e4dddc..2b2dc963299b 100644
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


