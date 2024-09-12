Return-Path: <cgroups+bounces-4856-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7C975E83
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 03:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514991C22540
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2E36124;
	Thu, 12 Sep 2024 01:28:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B982BB1C
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104529; cv=none; b=Afy7bpiBW8US2QZRMKU8/Z+AsluAl3oOZ0AHswNfBbnYISlKnU3WxS7CiqnRzmGuC391FiO8wwSvNASQkaiSt2dTvzWhoBxRV+3IZXwHmMHFjdktcwrUcSkr76sHQAhRpHyixkA8kpZHM3pSrG05G22UEVxCPCcbPfrwlkU2ugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104529; c=relaxed/simple;
	bh=4pkFNZi+X+D8OUjCn7jWKXxGrDAey9HNibcIHGYkM/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEWnpNrfS8odL0BqunBX3fhlym8kP+EyRbwslS5oa8DEatC9rQsFLFSJxhjMnJMP33T3jncVF6qf2G16sjhkbzg6ra/fXF3kKsH2D7eFbT9zcpn2rJsi7beZrzlX91iKd1Msl78GryOuqs1Dl72r4OoR8YOpapDcX0G6UwHknCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X40Fd6STNz69Wc;
	Thu, 12 Sep 2024 09:28:37 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id BB3251403D3;
	Thu, 12 Sep 2024 09:28:44 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 12 Sep
 2024 09:28:44 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>, <guro@fb.com>
CC: <cgroups@vger.kernel.org>
Subject: [PATCH v2 -next 3/3] cgroup/freezer: Reduce redundant propagation for cgroup_propagate_frozen
Date: Thu, 12 Sep 2024 01:20:37 +0000
Message-ID: <20240912012037.1324165-4-chenridong@huawei.com>
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

When a cgroup is frozen/unfrozen, it will always propagate bottom up.
However it is unnecessary to propagate to the top every time. This patch
aims to reduce redundant propagation for cgroup_propagate_frozen.

For example, subtree like:
	a
	|
	b
      / | \
     c  d  e
If c is frozen, and d and e are not frozen now, it doesn't have to
propagate to a; Only when c, d and e are all frozen, b and a could be set
to frozen. Therefore, if nr_frozen_descendants is not equal to
nr_descendants, just stop propagate. If a descendant is frozen, the
parent's nr_frozen_descendants add child->nr_descendants + 1. This can
reduce redundant propagation.

Additionally, cgroup_propagate_frozen is not only used to update the
ancestor state but also to update itself. This approach can make the code
clearer and significantly simplify cgroup_update_frozen.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cgroup-defs.h |  4 +++-
 kernel/cgroup/freezer.c     | 29 +++++++++++++++++------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index dd1ecab99eeb..41e4e5a7ae55 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -401,7 +401,9 @@ struct cgroup_freezer_state {
 
 	/* Fields below are protected by css_set_lock */
 
-	/* Number of frozen descendant cgroups */
+	/* Aggregating frozen descendant cgroups, only when all
+	 * descendants of a child are frozen will the count increase.
+	 */
 	int nr_frozen_descendants;
 
 	/*
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index bf1690a167dd..0b9d20012a5a 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -35,27 +35,34 @@ static bool cgroup_update_frozen_flag(struct cgroup *cgrp, bool frozen)
  */
 static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 {
-	int desc = 1;
-
+	int deta;
+	struct cgroup *parent;
 	/*
 	 * If the new state is frozen, some freezing ancestor cgroups may change
 	 * their state too, depending on if all their descendants are frozen.
 	 *
 	 * Otherwise, all ancestor cgroups are forced into the non-frozen state.
 	 */
-	while ((cgrp = cgroup_parent(cgrp))) {
+	for (cgrp = cgrp; cgrp; cgrp = cgroup_parent(cgrp)) {
 		if (frozen) {
-			cgrp->freezer.nr_frozen_descendants += desc;
+			/* If freezer is not set, or cgrp has descendants
+			 * that are not frozen, cgrp can't be frozen
+			 */
 			if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
 			    (cgrp->freezer.nr_frozen_descendants !=
-			    cgrp->nr_descendants))
-				continue;
+			     cgrp->nr_descendants))
+				break;
+			deta = cgrp->freezer.nr_frozen_descendants + 1;
 		} else {
-			cgrp->freezer.nr_frozen_descendants -= desc;
+			deta = -(cgrp->freezer.nr_frozen_descendants + 1);
 		}
 
-		if (cgroup_update_frozen_flag(cgrp, frozen))
-			desc++;
+		/* No change, stop propagate */
+		if (!cgroup_update_frozen_flag(cgrp, frozen))
+			break;
+
+		parent = cgroup_parent(cgrp);
+		parent->freezer.nr_frozen_descendants += deta;
 	}
 }
 
@@ -75,9 +82,7 @@ void cgroup_update_frozen(struct cgroup *cgrp)
 	frozen = test_bit(CGRP_FREEZE, &cgrp->flags) &&
 		cgrp->freezer.nr_frozen_tasks == __cgroup_task_count(cgrp);
 
-	/* If flags is updated, update the state of ancestor cgroups. */
-	if (cgroup_update_frozen_flag(cgrp, frozen))
-		cgroup_propagate_frozen(cgrp, frozen);
+	cgroup_propagate_frozen(cgrp, frozen);
 }
 
 /*
-- 
2.34.1


