Return-Path: <cgroups+bounces-9030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16983B1E5C0
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 11:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEABB564BB8
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C156272E7F;
	Fri,  8 Aug 2025 09:39:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D224E01D;
	Fri,  8 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645987; cv=none; b=X7E5Bz+Y4YuBn5dXislu/RfMN7ZMVqNfgktIzMao5Om3tfI7gG7TuZDh6itIGR8XwHiYo6F88aGI8umfA/E8w/D9+JTEJlW6YfrDm+W98HVazzBDOB5nPZbivrSMds2I3nkgAF0bXOuN5RNLonLOKNYOIo78Cu509Dpzg+gqPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645987; c=relaxed/simple;
	bh=Ex95s0uF8ODB8eGIswPHwhKG9L1mxT9yhGmcc8dJy9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dg2172inAgj5KvK8wXRphjasj1mC3b5BZrrpieYlPoAxlTDUCUeaTUYAiRxwQwI6AW6c8JlvRHmp7hUS+9G+knofPW6wyu3DoHTUrLHpR5FACa9QLc3BildvXs0ps+VOSs8Q5CzdvwX2ckziG323pk+hAGENOTuuZLyrebgLlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4byzWy1D66zKHMsW;
	Fri,  8 Aug 2025 17:39:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 464C81A018D;
	Fri,  8 Aug 2025 17:39:41 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCXo7XPxZVooOS_Cw--.51716S6;
	Fri, 08 Aug 2025 17:39:41 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 4/4] cpuset: replace cpuset_lock() with guard_cpuset()
Date: Fri,  8 Aug 2025 09:25:15 +0000
Message-Id: <20250808092515.764820-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808092515.764820-1-chenridong@huaweicloud.com>
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXo7XPxZVooOS_Cw--.51716S6
X-Coremail-Antispam: 1UD129KBjvJXoWxur17Zr18Jw1UtryxuF43GFg_yoW5XFW5pF
	ZI9347JFWrAr18u34UWw15uFySgw1kCa1UAF95G34rAry2yF429r1kJa9xGr1rKry3CFW5
	WF9rK3ya9FyDtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U0189tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The guard_cpuset() is introduced, we can replace all cpuset_lock()
usage with it and remove the cpuset_lock().

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cpuset.h  |  2 --
 kernel/cgroup/cpuset.c  | 10 ----------
 kernel/sched/syscalls.c | 15 +++++----------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 6153de28acf0..1baf12f4be19 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -72,8 +72,6 @@ extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void inc_dl_tasks_cs(struct task_struct *task);
 extern void dec_dl_tasks_cs(struct task_struct *task);
-extern void cpuset_lock(void);
-extern void cpuset_unlock(void);
 extern void guard_cpuset(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 110d2b93ff96..04ed73d0887e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -250,16 +250,6 @@ static struct cpuset top_cpuset = {
 
 static DEFINE_MUTEX(cpuset_mutex);
 
-void cpuset_lock(void)
-{
-	mutex_lock(&cpuset_mutex);
-}
-
-void cpuset_unlock(void)
-{
-	mutex_unlock(&cpuset_mutex);
-}
-
 void guard_cpuset(void)
 {
 	guard(mutex)(&cpuset_mutex);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f36e84..954f6e9af41b 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -577,8 +577,10 @@ int __sched_setscheduler(struct task_struct *p,
 	 * information.
 	 */
 	if (dl_policy(policy) || dl_policy(p->policy)) {
-		cpuset_locked = true;
-		cpuset_lock();
+		if (!cpuset_locked) {
+			guard_cpuset();
+			cpuset_locked = true;
+		}
 	}
 
 	/*
@@ -660,8 +662,6 @@ int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (cpuset_locked)
-			cpuset_unlock();
 		goto recheck;
 	}
 
@@ -733,11 +733,8 @@ int __sched_setscheduler(struct task_struct *p,
 	head = splice_balance_callbacks(rq);
 	task_rq_unlock(rq, p, &rf);
 
-	if (pi) {
-		if (cpuset_locked)
-			cpuset_unlock();
+	if (pi)
 		rt_mutex_adjust_pi(p);
-	}
 
 	/* Run balance callbacks after we've adjusted the PI chain: */
 	balance_callbacks(rq, head);
@@ -747,8 +744,6 @@ int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	if (cpuset_locked)
-		cpuset_unlock();
 	return retval;
 }
 
-- 
2.34.1


