Return-Path: <cgroups+bounces-5179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E69AA190
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 13:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5755DB21B1A
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3E19CCF9;
	Tue, 22 Oct 2024 11:58:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851EE19CC21
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598308; cv=none; b=hcnF7R9+D9zdCoeELtBLC/vqWZ1NONOcj8fFKtkscHhiParLnHu9czTmR95JFFGvsu0a20Cilhx+U5qHcqwe7ZJ3YzIXutcAmsMrAaRFy/X6mlg/LA4WiVzVa8RRDDYcVcU8xRQHRUaYUNbm0vqW/uF24YmIwjkYZRL9p18G34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598308; c=relaxed/simple;
	bh=1F9wRaakJyo3UoPFwr2ee+N0gHusRRTkPoQMkJY/NQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8TwWuSs1w+XUDGfImBzfeGD3CfzNvofQdWf47rd2OzSkJNVuLNOFLwGULNWw/7uWtCo3FSmosIkhfmNlNkhM7dbSs4sOhH5kxnfT6imdhzb91rZhVFBp3frXN4hRtVvxqbGyrsdnjSXvcaVww8nuI8c3Xd0JTSb2M9UM+ChH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXrKY2cNRz4f3l96
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 19:58:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A50051A018C
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 19:58:21 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgAXtoJTkxdnHcucEg--.31107S4;
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
Subject: [PATCH -next v4 2/2] cgroup/freezer: Add cgroup CGRP_FROZEN flag update helper
Date: Tue, 22 Oct 2024 11:49:46 +0000
Message-Id: <20241022114946.811862-3-chenridong@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAXtoJTkxdnHcucEg--.31107S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrCryrWw43JFy8ZF1fWFg_yoW5tr1xpa
	n5AFWfKw4vy3Wjvrs7t34FqFZYgFs3try0krWUXa4xJF4SqryktryxAas5W345ArZ7ZFy5
	Ja15ArnrC3Z2v3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUob18
	DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Add help to update cgroup CGRP_FROZEN flag. Both cgroup_propagate_frozen
and cgroup_update_frozen functions update CGRP_FROZEN flag, this makes
code concise.

Reviewed-by: Michal Koutný <mkoutny@suse.com>
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


