Return-Path: <cgroups+bounces-4718-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9475396DAD0
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DB31F238E6
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC319EEA7;
	Thu,  5 Sep 2024 13:49:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F019DF4D;
	Thu,  5 Sep 2024 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544186; cv=none; b=aSNCyA6SFcqGdcK2K6rxpJjkXacpa6VRXHq6ws7aHQ4hS8uDHs6wjT9xL2trh8zT3WibmZqVwNukuoEsejTLw/ln3Y+amez4ZZSSSACKB7w/dFNsv105Q/RDVEfu4XWU61o7DqLMz0FOzqL8a8ZqMoaPBzOTT8Dit0BJ+0hfyoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544186; c=relaxed/simple;
	bh=eaNJhufH2kiE0k+7vdq6DTSxFjm+o875MPHJ4a7ZTOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFwZ4EPK9nBbVLG8w4SaCcA+IxHj2j5kbI6WSiREgtNOdUr5Y8mpy1cCt+ypyljHE1vh4H+/kwJuO/ekZgdVlU5/RYnatlZJoNxc4yZ6BEYtYAenVua4X8ZJDyUcd06MXk9e3OWqZjcphw1H/jmaGJF2K5bltU517qaozfc+jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X00w50Tgpz69VN;
	Thu,  5 Sep 2024 21:44:37 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id C52BB140417;
	Thu,  5 Sep 2024 21:49:35 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Sep
 2024 21:49:35 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v1 -next 2/3] cgroup/freezer: Reduce redundant propagation for cgroup_propagate_frozen
Date: Thu, 5 Sep 2024 13:41:29 +0000
Message-ID: <20240905134130.1176443-3-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905134130.1176443-1-chenridong@huawei.com>
References: <20240905134130.1176443-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)

When a cgroup is frozen/unfrozen, it will always propagate down to up.
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

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/freezer.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 02af6c1fa957..e4bcc41b6a30 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -13,7 +13,7 @@
  */
 static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 {
-	int desc = 1;
+	struct cgroup *child = cgrp;
 
 	/*
 	 * If the new state is frozen, some freezing ancestor cgroups may change
@@ -23,23 +23,38 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 	 */
 	while ((cgrp = cgroup_parent(cgrp))) {
 		if (frozen) {
-			cgrp->freezer.nr_frozen_descendants += desc;
+			/*
+			 * A cgroup is frozen, parent nr frozen descendants should add
+			 * nr cgroups of the entire subtree , including child itself.
+			 */
+			cgrp->freezer.nr_frozen_descendants += child->nr_descendants + 1;
+
+			/*
+			 * If there is other descendant is not frozen,
+			 * cgrp and its parent couldn't be frozen, just break
+			 */
+			if (cgrp->freezer.nr_frozen_descendants !=
+			    cgrp->nr_descendants)
+				break;
+
+			child = cgrp;
 			if (!test_bit(CGRP_FROZEN, &cgrp->flags) &&
-			    test_bit(CGRP_FREEZE, &cgrp->flags) &&
-			    cgrp->freezer.nr_frozen_descendants ==
-			    cgrp->nr_descendants) {
+			    test_bit(CGRP_FREEZE, &cgrp->flags)) {
 				set_bit(CGRP_FROZEN, &cgrp->flags);
 				cgroup_file_notify(&cgrp->events_file);
 				TRACE_CGROUP_PATH(notify_frozen, cgrp, 1);
-				desc++;
 			}
 		} else {
-			cgrp->freezer.nr_frozen_descendants -= desc;
+			cgrp->freezer.nr_frozen_descendants -= (child->nr_descendants + 1);
+
+			child = cgrp;
 			if (test_bit(CGRP_FROZEN, &cgrp->flags)) {
 				clear_bit(CGRP_FROZEN, &cgrp->flags);
 				cgroup_file_notify(&cgrp->events_file);
 				TRACE_CGROUP_PATH(notify_frozen, cgrp, 0);
-				desc++;
+			} else {
+				/* If parent is unfrozen, don't have to propagate more */
+				break;
 			}
 		}
 	}
-- 
2.34.1


