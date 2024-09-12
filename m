Return-Path: <cgroups+bounces-4855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77515975E82
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 03:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB61C2266D
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC02D02E;
	Thu, 12 Sep 2024 01:28:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CD2A1CA
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104528; cv=none; b=PN5dn4vf2CATeQ2L+kSbjwCxZNQgpZoYMZbF02XLr1h7+1WyccaLpMrfYKX1mrxsQNKeiUcFHIJ7D5zC7UTVmHcB6iJcp0cfrGjEfndAg3X6MDm0bPGw7l7iRZZ9EQe4T+xU6k3Ytx4IfhSGUE2tdFTX39UXsM/FDdqKCRI6Ldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104528; c=relaxed/simple;
	bh=I8I7UJsfsjG1jFT8o5/Or+dsqXlOfwsRo//uwzCiOi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnHebPHNDhpQJO2UCF970ck2T4QvLX0XmRwe9lBylH44jrOw08OtKGmS0upzyBgvy3uY/49b33ZgrpDZLRomgyry9qfcc+5N7MIKeqcBSt4b4GjW4r0Yem3scJUoibaHawHwObxkkOGDXKRpH0EX3Ax8vwSwAvYoXGnh25Fdm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X409c1TkKz1HJW7;
	Thu, 12 Sep 2024 09:25:08 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 08B9B1401F1;
	Thu, 12 Sep 2024 09:28:44 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 12 Sep
 2024 09:28:43 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>, <guro@fb.com>
CC: <cgroups@vger.kernel.org>
Subject: [PATCH v2 -next 1/3] cgroup/freezer: Reduce redundant traversal for cgroup_freeze
Date: Thu, 12 Sep 2024 01:20:35 +0000
Message-ID: <20240912012037.1324165-2-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912012037.1324165-1-chenridong@huawei.com>
References: <20240912012037.1324165-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Whether a cgroup is frozen is determined solely by whether it is set to
to be frozen and whether its parent is frozen. Currently, when is cgroup
is frozen or unfrozen, it iterates through the entire subtree to freeze
or unfreeze its descentdants. However, this is unesessary for a cgroup
that does not change its effective frozen status. This path aims to skip
the subtree if its parent does not have a change in effective freeze.

For an example, subtree like, a-b-c-d-e-f-g, when a is frozen, the
entire tree is frozen. If we freeze b and c again, it is unesessary to
iterate d, e, f and g. So does that If we unfreeze b/c.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cgroup-defs.h |  2 +-
 kernel/cgroup/freezer.c     | 30 ++++++++++++++----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 47ae4c4d924c..dd1ecab99eeb 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -397,7 +397,7 @@ struct cgroup_freezer_state {
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


