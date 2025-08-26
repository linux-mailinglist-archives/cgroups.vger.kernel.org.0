Return-Path: <cgroups+bounces-9404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C89FB35264
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 05:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7B13ADDEE
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90F2D3A9E;
	Tue, 26 Aug 2025 03:55:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BB69460;
	Tue, 26 Aug 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180520; cv=none; b=fnZXMndmw5msrfklVvmnVgSf/WdrkSmDLVq0eu+EF+jyrCb7iyWQruOWji9QnU9vFCAiCk7Trep222awagQ8IDTvJ0ecexWXsDWT54OkEgkKOauQRSnbyTLfFgBGTc+TvQkG0TUjpU3sdiTzChuxgDiK7ljLZM9tjSu5ojAAP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180520; c=relaxed/simple;
	bh=Oh4h5BQmXD8YR7KU2yvzzrjC4/3l+EXXXiAFAjMo0lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3jePXYJSdEBLaA1W26Wq50is0D4vl7A5+F0Arq1K420hAIFl8AlJbG4A4FuO0o6wtbohCK9geObOy91mdRX5/yEuwQC9NT8p4DCjvruecjBXiiItV8MtpUj3C3i9nudxxOCetFqL1untN5nxmKvyaepjtR5a1eGGab1l3yYRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9v2D3FWgzKHMrK;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 16FFA1A1327;
	Tue, 26 Aug 2025 11:55:16 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCHsJcQMK1o1ZJFAQ--.52077S3;
	Tue, 26 Aug 2025 11:55:15 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH cgroup/for-next 1/3] cgroup: remove redundancy online_cnt
Date: Tue, 26 Aug 2025 03:40:20 +0000
Message-Id: <20250826034022.1736249-2-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCHsJcQMK1o1ZJFAQ--.52077S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWrKFy5Gw17AFWfZry3twb_yoW5CFykpF
	n5Za47tw45GFy5G34qy34qgr1Sgr4F934UK3y8G3WfXrW3tF1Iqr18AFy5tF1rAFZa9ry3
	AF4Yv34jkw17trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU773kDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Both online_cnt and nr_descendants can indicate whether acitive
descendants exist. To make code simple, remove redundancy online_cnt,
use nr_descendants instead.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cgroup-defs.h |  6 ------
 kernel/cgroup/cgroup.c      | 13 ++++---------
 kernel/cgroup/debug.c       |  2 +-
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..d084c5c34c09 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -210,12 +210,6 @@ struct cgroup_subsys_state {
 	 */
 	u64 serial_nr;
 
-	/*
-	 * Incremented by online self and children.  Used to guarantee that
-	 * parents are not offlined before their children.
-	 */
-	atomic_t online_cnt;
-
 	/* percpu_ref killing and RCU release */
 	struct work_struct destroy_work;
 	struct rcu_work destroy_rwork;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 79b1d79f86a3..5eb747a038f7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5607,7 +5607,6 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	INIT_LIST_HEAD(&css->sibling);
 	INIT_LIST_HEAD(&css->children);
 	css->serial_nr = css_serial_nr_next++;
-	atomic_set(&css->online_cnt, 0);
 
 	if (cgroup_parent(cgrp)) {
 		css->parent = cgroup_css(cgroup_parent(cgrp), ss);
@@ -5631,12 +5630,8 @@ static int online_css(struct cgroup_subsys_state *css)
 		css->flags |= CSS_ONLINE;
 		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
 
-		atomic_inc(&css->online_cnt);
-		if (css->parent) {
-			atomic_inc(&css->parent->online_cnt);
-			while ((css = css->parent))
-				css->nr_descendants++;
-		}
+		while ((css = css->parent))
+			css->nr_descendants++;
 	}
 	return ret;
 }
@@ -5949,7 +5944,7 @@ static void css_killed_work_fn(struct work_struct *work)
 		css_put(css);
 		/* @css can't go away while we're holding cgroup_mutex */
 		css = css->parent;
-	} while (css && atomic_dec_and_test(&css->online_cnt));
+	} while (css && css_is_dying(css) && !css->nr_descendants);
 
 	cgroup_unlock();
 }
@@ -5960,7 +5955,7 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 	struct cgroup_subsys_state *css =
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
-	if (atomic_dec_and_test(&css->online_cnt)) {
+	if (!css->nr_descendants) {
 		INIT_WORK(&css->destroy_work, css_killed_work_fn);
 		queue_work(cgroup_offline_wq, &css->destroy_work);
 	}
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..fc2f3216173a 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -226,7 +226,7 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
 				 css->parent->id);
 		seq_printf(seq, "%2d: %-4s\t- %p[%d] %d%s\n", ss->id, ss->name,
 			  css, css->id,
-			  atomic_read(&css->online_cnt), pbuf);
+			  css->nr_descendants, pbuf);
 	}
 
 	cgroup_kn_unlock(of->kn);
-- 
2.34.1


