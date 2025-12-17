Return-Path: <cgroups+bounces-12421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFACC6C21
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 10:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E608330CEABE
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2832233A9C2;
	Wed, 17 Dec 2025 09:04:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441F33B6F9;
	Wed, 17 Dec 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962293; cv=none; b=a6wqu9B6KlGz+D6kVpFgvlgeyVkd2TiNsFX6YOA5XRi1nnO86d4zkTptCy95VzBgP5/mXPBIQpN+32SgOIBEiue0NGWF6vivFVxjvh0HlgWuAjwI2AqMzNRtV2XucVbHyBTlOE0mG+mik419tNVNlREBg9gg6wDlrvUG0uYXg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962293; c=relaxed/simple;
	bh=D5U2QiVikoYwaXTRQ0/n7A0CEj3uycwFr4Li2hQW4fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oKyI6JBqv5+E1Yej/VyqRhfCnGqv2PoO0l7+j4sNwLVHQDRFPAL5fJlbP0jmnSXzgYGTY6kTKceLJedOfboIr6SD+P8/zs5tW3HyVokpKb1Lhz8IdnPPsrf1BU6QRiVNFQuZHWYrJOvZv6VLW39k7ehjxGog4/Au7SXSTa2YaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWSXd2lXlzYQvFq;
	Wed, 17 Dec 2025 17:04:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 07B0F40592;
	Wed, 17 Dec 2025 17:04:44 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCHNvcackJp5AL6AQ--.18103S3;
	Wed, 17 Dec 2025 17:04:43 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next 1/6] cpuset: add assert_cpuset_lock_held helper
Date: Wed, 17 Dec 2025 08:49:37 +0000
Message-Id: <20251217084942.2666405-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217084942.2666405-1-chenridong@huaweicloud.com>
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHNvcackJp5AL6AQ--.18103S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW8Xr1DKr48Zr4fKrW5trb_yoW8CF4kpF
	92k34UJ3yYyFy09a4DXwsrua4Sgw1kCF15JFn5t34FyFy3tF4I93WkXF9xJr13tr1fCF12
	gFZFkw4a9FyDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfDGrUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add assert_cpuset_lock_held() to allow other subsystems to verify that
cpuset_mutex is held.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cpuset.h | 2 ++
 kernel/cgroup/cpuset.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index a98d3330385c..af0e76d10476 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -74,6 +74,7 @@ extern void inc_dl_tasks_cs(struct task_struct *task);
 extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
+extern void assert_cpuset_lock_held(void);
 extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
@@ -195,6 +196,7 @@ static inline void inc_dl_tasks_cs(struct task_struct *task) { }
 static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
 static inline void cpuset_unlock(void) { }
+static inline void assert_cpuset_lock_held(void) { }
 
 static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
 					struct cpumask *mask)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fea577b4016a..a5ad124ea1cf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -271,6 +271,11 @@ void cpuset_unlock(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+void assert_cpuset_lock_held(void)
+{
+	lockdep_assert_held(&cpuset_mutex);
+}
+
 /**
  * cpuset_full_lock - Acquire full protection for cpuset modification
  *
-- 
2.34.1


