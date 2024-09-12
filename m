Return-Path: <cgroups+bounces-4857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CEA975E84
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FFDC1C22450
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2F2209B;
	Thu, 12 Sep 2024 01:28:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACE1D545
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104533; cv=none; b=C3i41T5sc0aGzas2fy/sh/IpYimBpcyFR61itta/p315EwEPgK6U++k4udiYM15nW8xHLygFg4ChLVqAgFrnNTsvM4+UlOhoNwX17O1bphYFRMm3YaoM3j46NOAAeNoZZMenLWtWKwj0AtRWlIorb9a+IPY/4uXz3hUoX8kg7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104533; c=relaxed/simple;
	bh=56lBpuBtp28/uZNGFyulJ22rK3WOIREtNyNkVXYugCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxX8RrlghqCN/WbumVjrV8vmmr2HK0mvZOB1to7Q9mzSOHT/qkLCM23QbxuByhDIIjx705DTlg8NfIWirEz4vfz1hweAsR0O7SvBiWhHer6M5Fwjl+CxWtIMLsJzJOs/vExIqgVUz1EGHgHtncrTmChWETzryg5c7VUchB0QUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X40Fl2CdczjM9B;
	Thu, 12 Sep 2024 09:28:43 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 64DC31401F2;
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
Subject: [PATCH v2 -next 2/3] cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper
Date: Thu, 12 Sep 2024 01:20:36 +0000
Message-ID: <20240912012037.1324165-3-chenridong@huawei.com>
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


