Return-Path: <cgroups+bounces-4051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBC943D96
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 03:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A4BB280A7
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 01:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43671B32BA;
	Thu,  1 Aug 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRXIZ5qD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEE1B32AF;
	Thu,  1 Aug 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471950; cv=none; b=St91EpYv436ctEVGo0N8iA+cjzKD4Vi37V7qQ62Itgxg9djEURLcMUSjJ/D4I9qYTgCyg+QPfxxJnu7YEeMi+r47j0fJv4sJMJJ8CZx/dx2TGsZ2MtBR6W63cvE8vTv/oCch5S/xP09BvSy5L0jEmmJ+gtoH+SNcXc42NuPU2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471950; c=relaxed/simple;
	bh=fkUQ1UoP5kPbdFdxmZtBFvGRCRK2lPeYBWGMRdYICEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRmFo9EmnB27y+RVl9U+bq8KwmuckZdIrnOcxXG4OwTaO6cYJrCGmEmFiEuNSZ93Fe3SnHwMu2TDMYiyXEXk05RfhwXZ8yms8zsrUi0+BqKgHdoPkax2GAWj80duILBebSVTNqtk6e3sNmJiPJZsCmL1rwtmL5aXiXwUMLpb+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRXIZ5qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52997C4AF0C;
	Thu,  1 Aug 2024 00:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471950;
	bh=fkUQ1UoP5kPbdFdxmZtBFvGRCRK2lPeYBWGMRdYICEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRXIZ5qDDrFwQXK3FHEWGEJwxyL7aM/WfCBhMkUe0vThIcrX7+6vkcl5sJnD2g4eK
	 fOM7a5WRmw87ayyTn2zm5SVPRyJX7XBiN48XjND6WVUBnGjyUMfxQ7eTFGTw/MtXyP
	 XXZRYVmiyOWAw43UmtA1xRMtkeUmikB/RLNxA7i8Ump5cfOliuOi4OhmIKTOLKzlKA
	 srLPZhko+rpNxBLcg5BCEEZJzp1x8TVXe+96CDhYHgzA7R9w2HdC1HWBIHOiBonLt7
	 4FT5fgbQ8GHfubwp4PGouy3AlP6r4tsw0/jokZtiWCXzlRTG9wGKknBT3qZtA4l2US
	 S4A70pRCZZ3xQ==
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
Subject: [PATCH AUTOSEL 6.6 71/83] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:18:26 -0400
Message-ID: <20240801002107.3934037-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 518725b57200c..9f6659c817365 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1820,9 +1820,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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


