Return-Path: <cgroups+bounces-2585-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0DE8A9A66
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD7B1C21DBC
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251815E5C9;
	Thu, 18 Apr 2024 12:50:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16713A86B;
	Thu, 18 Apr 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444623; cv=none; b=S6izGEeS/u69iPG6+/xsbMuU84yPDxe2cLiF1AiZvC618TFGHQ8RbzgVmI4FoNJENZowDhEOqlgNGFfL5WKXqelU7CLpgObdnGdGQk8drFc9hbTE4Hf/3ueZeY3eaD1JDTgLNx5vwEDtkQkUJIPtX2hfF96NrZIbDW41/PPYkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444623; c=relaxed/simple;
	bh=m17shzuosOvHU/kE5f6ihW08W3NrfbNpnfTEWvxWw6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qU0GC2nK4Iy1qb5EC0yMkRkjg3mQyD2mUPloi91USEob5RiAq2WZVJKBshh3PAgMeXDpe2mK5WDkHg7WKyH8L5El7Xeut0brHKYdMUQ+MbyjaIFC9RbqLw6m8ObvqGldRqffgR8bEmZnHqn9wC6eYzEOu9w/x6UIXvr3FNYnxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VKyGf2Dq9z1R8ZH;
	Thu, 18 Apr 2024 20:47:22 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 21D26140382;
	Thu, 18 Apr 2024 20:50:16 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 20:50:15 +0800
From: Xiu Jianfeng <xiujianfeng@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup, legacy_freezer: update comment for freezer_css_offline()
Date: Thu, 18 Apr 2024 12:43:49 +0000
Message-ID: <20240418124349.916770-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)

After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
system_freezing_count was replaced by freezer_active.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/legacy_freezer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 66d1708042a7..afbf7f8a86c0 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -133,7 +133,7 @@ static int freezer_css_online(struct cgroup_subsys_state *css)
  * freezer_css_offline - initiate destruction of a freezer css
  * @css: css being destroyed
  *
- * @css is going away.  Mark it dead and decrement system_freezing_count if
+ * @css is going away.  Mark it dead and decrement freezer_active if
  * it was holding one.
  */
 static void freezer_css_offline(struct cgroup_subsys_state *css)
-- 
2.34.1


