Return-Path: <cgroups+bounces-4716-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CA96DACB
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D91F232D8
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327619DFA2;
	Thu,  5 Sep 2024 13:49:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DF19DF63;
	Thu,  5 Sep 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544181; cv=none; b=J+HTI8d20a+TXL+MWvizL8YYAJFzf9XEVV8WplGNewepP8YC1z6hELX/dM5vUjVQ2WsL8kkCCK8kJp9uQG0rz63j8KiAPDzZO9SuydezJIQMYgPHsjNy6Gfiz7x3R7N91AVrJvACv8BDlUEg7QgKIOnop8AekRn2uG4nMgxyqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544181; c=relaxed/simple;
	bh=R+Vnw5tKaSfBtW48WqKC3LkRd2Ii+HXWOaCPrYYNEWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYEZvZfgngZkOm3YVRF8YRVnLp9swXBxV51Ayg9L3fAi6P/cFxRstQYgbU0w9jqRh4ZBZy25P1vlq+iqvrgPt4IuVYMglrRUVdSiitRqh+fleWSBtzHCp0CG97bUMCSbpkvWePJk84U3NwZWLPZwGpUGwQ7F5fv+FFZhElI5xrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X010h1PFLzyR9v;
	Thu,  5 Sep 2024 21:48:36 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 569EC18006C;
	Thu,  5 Sep 2024 21:49:35 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Sep
 2024 21:49:34 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v1 -next 1/3] cgroup/freezer: Reduce redundant traversal for cgroup_freeze
Date: Thu, 5 Sep 2024 13:41:28 +0000
Message-ID: <20240905134130.1176443-2-chenridong@huawei.com>
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
 kernel/cgroup/freezer.c     | 41 ++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index d3aca2c61154..e9d175a1bf94 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -393,7 +393,7 @@ struct cgroup_freezer_state {
 	bool freeze;
 
 	/* Should the cgroup actually be frozen? */
-	int e_freeze;
+	bool e_freeze;
 
 	/* Fields below are protected by css_set_lock */
 
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 617861a54793..02af6c1fa957 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -45,6 +45,21 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
 	}
 }
 
+/*
+ * Update cgroup freezer.e_freeze
+ * e_freeze will be set to true if freeze == true or parent's e_freeze == true
+ */
+static inline void cgroup_update_efreeze(struct cgroup *cgrp)
+{
+	struct cgroup *parent = cgroup_parent(cgrp);
+	bool p_e = false;
+
+	if (parent)
+		p_e = parent->freezer.e_freeze;
+
+	cgrp->freezer.e_freeze = cgrp->freezer.freeze | p_e;
+}
+
 /*
  * Revisit the cgroup frozen state.
  * Checks if the cgroup is really frozen and perform all state transitions.
@@ -262,6 +277,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 	struct cgroup_subsys_state *css;
 	struct cgroup *dsct;
 	bool applied = false;
+	bool old_e;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -282,22 +298,15 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
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
+		 * If old e_freeze eq new e_freeze, no change, its children
+		 * will not be affected. So do nothing and skip the subtree
+		 */
+		old_e = dsct->freezer.e_freeze;
+		cgroup_update_efreeze(dsct);
+		if (dsct->freezer.e_freeze == old_e) {
+			css = css_rightmost_descendant(css);
+			continue;
 		}
 
 		/*
-- 
2.34.1


