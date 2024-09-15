Return-Path: <cgroups+bounces-4885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BB979500
	for <lists+cgroups@lfdr.de>; Sun, 15 Sep 2024 09:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2801C20EA7
	for <lists+cgroups@lfdr.de>; Sun, 15 Sep 2024 07:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990102868B;
	Sun, 15 Sep 2024 07:21:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88D11CA0
	for <cgroups@vger.kernel.org>; Sun, 15 Sep 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384889; cv=none; b=A05ysCLkwX5/ZONHiCRv8Bgh5ew6BAXmp9cuJR73IR0ULq3PieKK7Pxz0v18yYuuZ2Ski3WeOxU6a12OvbTN+SL3cDMSQ0mLNkGj9Vwt3t7L+SVLoq8IEg3rAamKuckS+CtFpuh3bHh/2lTLFwewtRIbFrUq2FjJeleXEQe5B1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384889; c=relaxed/simple;
	bh=56lBpuBtp28/uZNGFyulJ22rK3WOIREtNyNkVXYugCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFM9+fmRqCz2GFqwTrkl6SG9X0NnNBk4R/kw22UlG/jZRLkSm7fxzAaQ26dNt/ceTTfCwd+GdZ4Ylva2FuUjSTie5mj/7bqnybuFkY+mlR3xNvNDtYsfhUosMxl0QzLd6C08q//hn9w3u3U7AiU/itqHPpz7WkHv1r8x8Pn06cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X5zxB4KPlz2FbMP;
	Sun, 15 Sep 2024 15:21:18 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D1901A016C;
	Sun, 15 Sep 2024 15:21:19 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sun, 15 Sep
 2024 15:21:18 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>, <guro@fb.com>
CC: <cgroups@vger.kernel.org>
Subject: [PATHC v3 -next 2/3] cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper
Date: Sun, 15 Sep 2024 07:13:06 +0000
Message-ID: <20240915071307.1976026-3-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915071307.1976026-1-chenridong@huawei.com>
References: <20240915071307.1976026-1-chenridong@huawei.com>
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

Add help to update cgroup CGRP_FROZEN flag. Both cgroup_propagate_frozen
and cgroup_update_frozen functions update CGRP_FROZEN flag, this makes
code concise.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/freezer.c | 67 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 188d5f2aeb5a..bf1690a167dd 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -8,6 +8,28 @@
 
 #include <trace/events/cgroup.h>
 
+/*
+ * Update CGRP_FROZEN of cgroup.flag
+ * Return true if flags is updated; false if flags has no change
+ */
+static bool cgroup_update_frozen_flag(struct cgroup *cgrp, bool frozen)
+{
+	lockdep_assert_held(&css_set_lock);
+
+	/* Already there? */
+	if (test_bit(CGRP_FROZEN, &cgrp->flags) == frozen)
+		return false;
+
+	if (frozen)
+		set_bit(CGRP_FROZEN, &cgrp->flags);
+	else
+		clear_bit(CGRP_FROZEN, &cgrp->flags);
+
+	cgroup_file_notify(&cgrp->events_file);
+	TRACE_CGROUP_PATH(notify_frozen, cgrp, frozen);
+	return true;
+}
+
 /*
  * Propagate the cgroup frozen state upwards by the cgroup tree.
  */
@@ -24,24 +46,16 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 	while ((cgrp = cgroup_parent(cgrp))) {
 		if (frozen) {
 			cgrp->freezer.nr_frozen_descendants += desc;
-			if (!test_bit(CGRP_FROZEN, &cgrp->flags) &&
-			    test_bit(CGRP_FREEZE, &cgrp->flags) &&
-			    cgrp->freezer.nr_frozen_descendants ==
-			    cgrp->nr_descendants) {
-				set_bit(CGRP_FROZEN, &cgrp->flags);
-				cgroup_file_notify(&cgrp->events_file);
-				TRACE_CGROUP_PATH(notify_frozen, cgrp, 1);
-				desc++;
-			}
+			if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
+			    (cgrp->freezer.nr_frozen_descendants !=
+			    cgrp->nr_descendants))
+				continue;
 		} else {
 			cgrp->freezer.nr_frozen_descendants -= desc;
-			if (test_bit(CGRP_FROZEN, &cgrp->flags)) {
-				clear_bit(CGRP_FROZEN, &cgrp->flags);
-				cgroup_file_notify(&cgrp->events_file);
-				TRACE_CGROUP_PATH(notify_frozen, cgrp, 0);
-				desc++;
-			}
 		}
+
+		if (cgroup_update_frozen_flag(cgrp, frozen))
+			desc++;
 	}
 }
 
@@ -53,8 +67,6 @@ void cgroup_update_frozen(struct cgroup *cgrp)
 {
 	bool frozen;
 
-	lockdep_assert_held(&css_set_lock);
-
 	/*
 	 * If the cgroup has to be frozen (CGRP_FREEZE bit set),
 	 * and all tasks are frozen and/or stopped, let's consider
@@ -63,24 +75,9 @@ void cgroup_update_frozen(struct cgroup *cgrp)
 	frozen = test_bit(CGRP_FREEZE, &cgrp->flags) &&
 		cgrp->freezer.nr_frozen_tasks == __cgroup_task_count(cgrp);
 
-	if (frozen) {
-		/* Already there? */
-		if (test_bit(CGRP_FROZEN, &cgrp->flags))
-			return;
-
-		set_bit(CGRP_FROZEN, &cgrp->flags);
-	} else {
-		/* Already there? */
-		if (!test_bit(CGRP_FROZEN, &cgrp->flags))
-			return;
-
-		clear_bit(CGRP_FROZEN, &cgrp->flags);
-	}
-	cgroup_file_notify(&cgrp->events_file);
-	TRACE_CGROUP_PATH(notify_frozen, cgrp, frozen);
-
-	/* Update the state of ancestor cgroups. */
-	cgroup_propagate_frozen(cgrp, frozen);
+	/* If flags is updated, update the state of ancestor cgroups. */
+	if (cgroup_update_frozen_flag(cgrp, frozen))
+		cgroup_propagate_frozen(cgrp, frozen);
 }
 
 /*
-- 
2.34.1


