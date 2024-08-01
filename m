Return-Path: <cgroups+bounces-4055-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85072943F92
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 03:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4058F281283
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 01:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160861E7A40;
	Thu,  1 Aug 2024 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx2GXqQ/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24571E7A37;
	Thu,  1 Aug 2024 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472805; cv=none; b=JmeQjLVOHplEWmFdhs8q6GlKpa0BZ4VtQO0PQvtgRH4HPP22LgI/xpdfs3kk8FnGEgE4rpI1ySN0HSQlLODn+6NXImgej46hJAGB6TKbNUtFfrIG5nWuDdsSzQgQIaQ8P5BwEm6Q9vP5e9qRyc2+dN42As6nKYoDJsm/AJd1j5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472805; c=relaxed/simple;
	bh=eLugRl+pNbrBa0y6hwdVIlCEvrzvgNE13wAef26NF6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzFdzxw0TvUpxsC+x6x93M3X2ttlzDuxvga87TzPx4Au625YNJ3y0w8Fy1Bd3nYF47aapW4X+5rZTtzUxa9SqtgRNGg55zap8zW7y3HIGBYVqVau0iyxW7DJ+G+3vVgn95e3wKWrJrDNlCuf602lepJu8i66EndaHKH11RTDv5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx2GXqQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA75C116B1;
	Thu,  1 Aug 2024 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472805;
	bh=eLugRl+pNbrBa0y6hwdVIlCEvrzvgNE13wAef26NF6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kx2GXqQ/MgZB6O0R+cvAZH8F38NKBcT92Ok8MuyuMlo/UjA6CdDYEf/+IZ9BHT7QK
	 gYo8USodA+PVkWM/DPRXljNzby9Kv8UPoJt2ZNg46F1JqHdT7rE35LvMrE86ZDnZfB
	 XW9LRFATF8mzAPGVFQlFeuxkVZOjSHMormshn7PdgfgAHsmSWTYn9IjZMpnB4wT4oc
	 3xIa0GlOQuzZyynmWFFZqf+i0lyvlMI8K8JT4xotOWrIZpqVN0w7FXeG7Da7Fzy95x
	 hvdeUlHjEM1rdQLoGMszx54bLT0uJ47xBHNl4jvhXzew329+FG5TXxpD5d/9bq25AL
	 LwQzRB9SN+umw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 15/22] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:38:44 -0400
Message-ID: <20240801003918.3939431-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 57b56d16800e8961278ecff0dc755d46c4575092 ]

The writing of css->cgroup associated with the cgroup root in
rebind_subsystems() is currently protected only by cgroup_mutex.
However, the reading of css->cgroup in both proc_cpuset_show() and
proc_cgroup_show() is protected just by css_set_lock. That makes the
readers susceptible to racing problems like data tearing or caching.
It is also a problem that can be reported by KCSAN.

This can be fixed by using READ_ONCE() and WRITE_ONCE() to access
css->cgroup. Alternatively, the writing of css->cgroup can be moved
under css_set_lock as well which is done by this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 62a7a50750149..16ae868941211 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1783,9 +1783,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
-- 
2.43.0


