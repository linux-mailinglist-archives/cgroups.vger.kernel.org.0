Return-Path: <cgroups+bounces-9405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0371B35265
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 05:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2101C7AB891
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273572D3ECC;
	Tue, 26 Aug 2025 03:55:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEBE571;
	Tue, 26 Aug 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180521; cv=none; b=ZrKp9F8X7gOJWuNUze/992jp9NVo0MjWheeiWi1+ryyqK/kGGFDDrX+yhwsOdVcBm1WCdE/hs5hv65NsuL2Q6CJETNmpn/XQsgsTS0iqgGSEh1MRHvhaSriYAwAnohFuhCDcxfCGvfUdWbLxvntaxsaqea3A4+nKJ1wQHCrlxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180521; c=relaxed/simple;
	bh=ten0Lr96KhbpXoPXjw0B6qY68FXSiotUZ/FF9blsbzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKWdGcssu3Hozq84VhPmk0rvbo/gymWBS9HxNWMo5RUDg3OUuouA3wd6yEXb/Lybyu+1AH3VfdM5UVWrkwxCPbnWbYwl1stcz68mlKpgAu9ijM6ntUK/NnVoBM9d970WtorsmiZ2r/1nJWEEH/ZvlVZ8Phk/qU5vw9J4R0s2eVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9v2D4NzqzKHMq5;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3C7BC1A0E0B;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHsJcQMK1o1ZJFAQ--.52077S5;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next 3/3] cgroup: rename css offline related functions
Date: Tue, 26 Aug 2025 03:40:22 +0000
Message-Id: <20250826034022.1736249-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826034022.1736249-1-chenridong@huaweicloud.com>
References: <20250826034022.1736249-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHsJcQMK1o1ZJFAQ--.52077S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fuF4rAFWDCryUurWfXwb_yoWrtw4fpF
	ZxA3sxtan5GaykW39aq3409FySgFs5J34UK3yxG34Syr43JFyUtF42vr1jyFW5GrZ7ur4f
	ArsYvr1fCw1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwhFxUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The cgroup_destroy_wq has been split into three separate workqueues:
cgroup_offline_wq, cgroup_release_wq, and cgroup_free_wq. The cgroup
destroy work is now enqueued sequentially into these queues. To clarify
the three distinct stages of the destruction process, it will introduce
helper functions or rename existing ones accordingly. The resulting
structure is as follows:

work            workqueue               work_fn
css_offline     cgroup_offline_wq       css_offline_work_fn
css_release     cgroup_release_wq       css_release_work_fn
css_free        cgroup_free_wq          css_free_rwork_fn

This patch renames css_killed_ref_fn to css_offline_work_fn and
css_killed_work_fn to css_offline_work_fn to align with the new
multi-phase destruction workflow.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ad1f6a59a27b..1c75ebad7a88 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5447,20 +5447,20 @@ static struct cftype cgroup_psi_files[] = {
 /*
  * css destruction is four-stage process.
  *
- * 1. Destruction starts.  Killing of the percpu_ref is initiated.
- *    Implemented in kill_css().
+ * 1. kill_css: Destruction starts.  Killing of the percpu_ref is
+ *    initiated. Implemented in kill_css().
  *
- * 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
- *    and thus css_tryget_online() is guaranteed to fail, the css can be
- *    offlined by invoking offline_css().  After offlining, the base ref is
- *    put.  Implemented in css_killed_work_fn().
+ * 2. css_offline: When the percpu_ref is confirmed to be visible as
+ *    killed on all CPUs and thus css_tryget_online() is guaranteed to
+ *    fail, the css can be offlined by invoking __css_offline(). After
+ *    offlining, the base ref is put. Implemented in css_offline_work_fn().
  *
- * 3. When the percpu_ref reaches zero, the only possible remaining
- *    accessors are inside RCU read sections.  css_release() schedules the
- *    RCU callback.
+ * 3. css_release: When the percpu_ref reaches zero, the only possible
+ *    remaining accessors are inside RCU read sections. css_release()
+ *    schedules the RCU callback.
  *
- * 4. After the grace period, the css can be freed.  Implemented in
- *    css_free_rwork_fn().
+ * 4. css_free: After the grace period, the css can be freed. Implemented
+ *    in css_free_rwork_fn().
  *
  * It is actually hairier because both step 2 and 4 require process context
  * and thus involve punting to css->destroy_work adding two additional
@@ -5642,7 +5642,7 @@ static int online_css(struct cgroup_subsys_state *css)
 }
 
 /* if the CSS is online, invoke ->css_offline() on it and mark it offline */
-static void offline_css(struct cgroup_subsys_state *css)
+static void __css_offline(struct cgroup_subsys_state *css)
 {
 	struct cgroup_subsys *ss = css->ss;
 
@@ -5936,7 +5936,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
  * css_tryget_online() is now guaranteed to fail.  Tell the subsystem to
  * initiate destruction and put the css ref from kill_css().
  */
-static void css_killed_work_fn(struct work_struct *work)
+static void css_offline_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
@@ -5944,7 +5944,7 @@ static void css_killed_work_fn(struct work_struct *work)
 	cgroup_lock();
 
 	do {
-		offline_css(css);
+		__css_offline(css);
 		css_put(css);
 		/* @css can't go away while we're holding cgroup_mutex */
 		css = css->parent;
@@ -5954,13 +5954,13 @@ static void css_killed_work_fn(struct work_struct *work)
 }
 
 /* css kill confirmation processing requires process context, bounce */
-static void css_killed_ref_fn(struct percpu_ref *ref)
+static void css_offline(struct percpu_ref *ref)
 {
 	struct cgroup_subsys_state *css =
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	if (!css->nr_descendants) {
-		INIT_WORK(&css->destroy_work, css_killed_work_fn);
+		INIT_WORK(&css->destroy_work, css_offline_work_fn);
 		queue_work(cgroup_offline_wq, &css->destroy_work);
 	}
 }
@@ -6011,7 +6011,7 @@ static void kill_css(struct cgroup_subsys_state *css)
 	 * Use percpu_ref_kill_and_confirm() to get notifications as each
 	 * css is confirmed to be seen as killed on all CPUs.
 	 */
-	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
+	percpu_ref_kill_and_confirm(&css->refcnt, css_offline);
 }
 
 /**
-- 
2.34.1


