Return-Path: <cgroups+bounces-5181-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA49AA191
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 13:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073A02824DD
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44219CC3E;
	Tue, 22 Oct 2024 11:58:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85197199FAB
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598309; cv=none; b=tpmSELR/y9Lh679YenY47BATzrYZM1U4tbxUEZR+CRVup1bVYSvlTheqJZ+Afg/lxRnQa6B+j6qPFk3K12AFgCNvpZ1YC9XTRAMDkrKL7eVRwsyLR9QX2/1V1YUYkfjWGtfCPdavQMOLNDKsFfpqfbm1dN5aYSmKGLhdcUOfgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598309; c=relaxed/simple;
	bh=6MuDd/B9XBcnPGO518BpeVqNjeNv+vtDOUhDwn/aQaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp2lQsy2QE4X/yIY5XXtC72+wgnBec7wgf0UTGwI7lT/yLafeI7rH3rbCix6azlvzYphNX2QuvjMiDpx1LEuZoVUJK+x8/dwOOxQwSFBoYdtsJYOoabkMT8Z93sD3Rx7L3DjoYIHYxS6virl0k3wR7NmNI8+jhcWmxM5I5whBGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXrKY2DGNz4f3l8B
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 19:58:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 89C521A0568
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 19:58:21 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgAXtoJTkxdnHcucEg--.31107S3;
	Tue, 22 Oct 2024 19:58:21 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	longman@redhat.com,
	adityakali@google.com,
	sergeh@kernel.org,
	mkoutny@suse.com,
	guro@fb.com
Cc: cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH -next v4 1/2] cgroup/freezer: Reduce redundant traversal for cgroup_freeze
Date: Tue, 22 Oct 2024 11:49:45 +0000
Message-Id: <20241022114946.811862-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022114946.811862-1-chenridong@huaweicloud.com>
References: <20241022114946.811862-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXtoJTkxdnHcucEg--.31107S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4xGw1xArWkAr4xZw15CFg_yoW5XFy3pr
	ZIkrn7tw4rtr18Zrs8Ja4jq3Z3tw4fXa1UGFyUt34rJFs3Xa4vqrn7CF15Gw1jyFZFgrW3
	t3WY9r48Cr1qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7mLv
	DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Whether a cgroup is frozen is determined solely by whether it is set to
to be frozen and whether its parent is frozen. Currently, when is cgroup
is frozen or unfrozen, it iterates through the entire subtree to freeze
or unfreeze its descentdants. However, this is unesessary for a cgroup
that does not change its effective frozen status. This path aims to skip
the subtree if its parent does not have a change in effective freeze.

For an example, subtree like, a-b-c-d-e-f-g, when a is frozen, the
entire tree is frozen. If we freeze b and c again, it is unesessary to
iterate d, e, f and g. So does that If we unfreeze b/c.

Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cgroup-defs.h |  2 +-
 kernel/cgroup/freezer.c     | 30 ++++++++++++++----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 0a80ef9191a6..1b20d2d8ef7c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -398,7 +398,7 @@ struct cgroup_freezer_state {
 	bool freeze;
 
 	/* Should the cgroup actually be frozen? */
-	int e_freeze;
+	bool e_freeze;
 
 	/* Fields below are protected by css_set_lock */
 
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 617861a54793..188d5f2aeb5a 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -260,8 +260,10 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
 void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 {
 	struct cgroup_subsys_state *css;
+	struct cgroup *parent;
 	struct cgroup *dsct;
 	bool applied = false;
+	bool old_e;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -282,22 +284,18 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 		if (cgroup_is_dead(dsct))
 			continue;
 
-		if (freeze) {
-			dsct->freezer.e_freeze++;
-			/*
-			 * Already frozen because of ancestor's settings?
-			 */
-			if (dsct->freezer.e_freeze > 1)
-				continue;
-		} else {
-			dsct->freezer.e_freeze--;
-			/*
-			 * Still frozen because of ancestor's settings?
-			 */
-			if (dsct->freezer.e_freeze > 0)
-				continue;
-
-			WARN_ON_ONCE(dsct->freezer.e_freeze < 0);
+		/*
+		 * e_freeze is affected by parent's e_freeze and dst's freeze.
+		 * If old e_freeze eq new e_freeze, no change, its children
+		 * will not be affected. So do nothing and skip the subtree
+		 */
+		old_e = dsct->freezer.e_freeze;
+		parent = cgroup_parent(dsct);
+		dsct->freezer.e_freeze = (dsct->freezer.freeze ||
+					  parent->freezer.e_freeze);
+		if (dsct->freezer.e_freeze == old_e) {
+			css = css_rightmost_descendant(css);
+			continue;
 		}
 
 		/*
-- 
2.34.1


