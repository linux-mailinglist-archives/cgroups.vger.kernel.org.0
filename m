Return-Path: <cgroups+bounces-4493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E899601AB
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 08:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F6A2832FA
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EE8153838;
	Tue, 27 Aug 2024 06:29:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC25145B3F;
	Tue, 27 Aug 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740143; cv=none; b=V9o3r79jd2F0rpaTwNkDdRKfmsaQg852xVmZRo6wTl5Cu4zP8zswxQPuBUst47+ZpgIy6Z7cRz9Yf118V3BBaV2KaDfalJCHi/YsAAx5/4x+h8Hqyg83F9O/EKaDrOZChw/tY5T/NUqBn0nfJMv6gchZDKdL+acYdxpAG9eJOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740143; c=relaxed/simple;
	bh=DkDXcSckXmiVbJCh7WTsGtiSGDTJngFNen4GjNAU+XM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF+IS2lks0yURuoXhIPHTeINHzdgulaJZrM/909rlHq6/Bn9JOaf5WrbmKxgkoghMIMNJJ8c3WYxyp4IugkXNYxDh/7dYL3pC8J4Inkhu6PczIYAaFn984bkij+iOwJYYlDNc1v5gMkD9fisFX7i1H0vdWONt0ri9hP0l35buNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtHgQ31H6z1j7T4;
	Tue, 27 Aug 2024 14:28:50 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 094D71A016C;
	Tue, 27 Aug 2024 14:29:00 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 14:28:59 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next 06/12] cgroup/cpuset: add callback_lock helper
Date: Tue, 27 Aug 2024 06:21:05 +0000
Message-ID: <20240827062111.580296-7-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827062111.580296-1-chenridong@huawei.com>
References: <20240827062111.580296-1-chenridong@huawei.com>
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


