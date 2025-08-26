Return-Path: <cgroups+bounces-9403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF6B35263
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 05:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E30C2410D9
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144402D3A7B;
	Tue, 26 Aug 2025 03:55:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7029A2;
	Tue, 26 Aug 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180520; cv=none; b=JsfN03QtrtFjue11Ut0ixRqR+HUiKywbs1dTGfJvQxbZVsAkhL20mLP9IXgIiy5NEWxOYmf95SxhC7sEz3UOAo0f368tkE0PQeBd2qWfsXjo9xDmGIB9NYzQDBP1OK0G4gitt/CrokwlQIx/UU/qn47d7rFGXHe32+6JLLMZcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180520; c=relaxed/simple;
	bh=d6xAZ85XEU+kuFKR/t3HJtQ52J9tdjaLF4zCsAYSxjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbtyGHJbPRxYnxDW/qRZx2tNorq7RWfqxmeu4VJnXO7OD0vDFdhXmC3c1sCei4ds6CJBDnf7OFlyriyen3ciqk6LxFAB1lunRSYXiMEsW7Pa3fstQPi0XraEBELZcCfqmE2CIFffPTC57CD1shhakghSkIfqgjewIsHnDAPMduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9v2D40tRzKHMq5;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2BF851A0CC0;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHsJcQMK1o1ZJFAQ--.52077S4;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next 2/3] cgroup: add css_free helper
Date: Tue, 26 Aug 2025 03:40:21 +0000
Message-Id: <20250826034022.1736249-3-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHsJcQMK1o1ZJFAQ--.52077S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4Utr1kGw4xJw48Xw1kZrb_yoW8ZFW7pF
	s5Aw1Uta1rCF4kG39IvayjgFyfKF4Fqw1UGrW8G34rAr43Jryqqa1UZryjgF15AF93Wr1f
	ZFs09r42kF12krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcBT5DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The cgroup_destroy_wq has been split into three separate workqueues:
cgroup_offline_wq, cgroup_release_wq, and cgroup_free_wq. The cgroup
destroy work is now enqueued sequentially into these queues. To clarify
the three distinct stages of the destruction process, it will introduce
helper functions or rename existing ones accordingly. The resulting
structure is as follows:

work		workqueue		work_fn
css_offline	cgroup_offline_wq	css_offline_work_fn
css_release	cgroup_release_wq	css_release_work_fn
css_free	cgroup_free_wq		css_free_rwork_fn

This patch is to add css_free helper.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cgroup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5eb747a038f7..ad1f6a59a27b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5517,6 +5517,12 @@ static void css_free_rwork_fn(struct work_struct *work)
 	}
 }
 
+static void css_free(struct cgroup_subsys_state *css)
+{
+	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
+	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
+}
+
 static void css_release_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
@@ -5580,8 +5586,7 @@ static void css_release_work_fn(struct work_struct *work)
 
 	cgroup_unlock();
 
-	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
-	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
+	css_free(css);
 }
 
 static void css_release(struct percpu_ref *ref)
@@ -5718,8 +5723,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
-	queue_rcu_work(cgroup_free_wq, &css->destroy_rwork);
+	css_free(css);
 	return ERR_PTR(err);
 }
 
-- 
2.34.1


