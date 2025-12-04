Return-Path: <cgroups+bounces-12263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD941CA569A
	for <lists+cgroups@lfdr.de>; Thu, 04 Dec 2025 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D8430AA197
	for <lists+cgroups@lfdr.de>; Thu,  4 Dec 2025 21:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C9357739;
	Thu,  4 Dec 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hFj7MC3a"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78C357729;
	Thu,  4 Dec 2025 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882377; cv=none; b=Bh5yoN1qcXXzCfGRPo9ndzkVYoEk3AFkgD018nAb4zpkTfbvW9ktEIz+pU+LQq67pLZC3EL9F0j1gugxTES7opFOYpMGW5gyUxkWNwQr2nrDVb/+jDxw/NOq1PmDv97ytanL3KXWfKlwZ4OgkSVVeUnHSlr0RhngrZP7NDyG6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882377; c=relaxed/simple;
	bh=Wqb9DuXgsp5JICyqREfOWXKdGY64mCilkyJN5l5koMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KunV/wl2nRzfiQGQ4iXQN7of5qUs8ihMY/CEAzSAyPQy9tYmDKQIYG3wkeT5uZzzNWIix+WiGtO3HgZfOCF9Gm1PMbMgeqf55QL+WEZta2WEp+lqFogT4S2Az5YmLM2bMpu1o7nVjzmSME0WAXSydZwqVwIi3fOHPnExqTYOOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hFj7MC3a; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764882372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0j67/z7yk6sd+zTCJWqAb0hXxvwGHY4UbGjl3Fe8flE=;
	b=hFj7MC3acdifeWtieWAoehDskmNBka9rHl/IULh6FoUzZ2bguCTJGvcRwIEpH/QQSX2diQ
	vDXcEkK4kNkbUzv/LkdhjpAQ+wDyKI0VA2tjThW8vueIQBggN2ygIIlRDE/1CcdHsE/koT
	x0zbc2mtDlhvAOQRrdw6NHT1k0I+OtE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] cgroup: rstat: force flush on css exit
Date: Thu,  4 Dec 2025 13:06:00 -0800
Message-ID: <20251204210600.2899011-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cuurently the rstat update side is lockless and transfers the css of
cgroup whose stats has been updated through lockless list (llist). There
is an expected race where rstat updater skips adding css to the llist
because it was already in the list but the flusher might not see those
updates done by the skipped updater.

Usually the subsequent updater will take care of such situation but what
if the skipped updater was the last updater before the cgroup is removed
by the user. In that case stat updates by the skipped updater will be
lost. To avoid that let's always flush the stats of the offlined cgroup.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Fixes: 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi safe")
---
 kernel/cgroup/rstat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a198e40c799b..91b34ebd5370 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -283,6 +283,16 @@ static struct cgroup_subsys_state *css_rstat_updated_list(
 
 	css_process_update_tree(root->ss, cpu);
 
+	/*
+	 * We allow race between rstat updater and flusher which can cause a
+	 * scenario where the updater skips adding the css to the list but the
+	 * flusher might not see updater's updates. Usually the subsequent
+	 * updater would take care of that but what if that was the last updater
+	 * on that CPU before getting removed. Handle that scenario here.
+	 */
+	if (!css_is_online(root))
+		__css_process_update_tree(root, cpu);
+
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
 		return NULL;
-- 
2.47.3


