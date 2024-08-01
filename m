Return-Path: <cgroups+bounces-4050-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D27943CB5
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 02:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B941C21291
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB71C9ECF;
	Thu,  1 Aug 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLFmss1j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE171C9EC4;
	Thu,  1 Aug 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471484; cv=none; b=AbTg0p2OlFTT1LD3qzidOqOJDM2qagPoBTcJ7swxW/hhWccYLaaXucCVT7Fdepp4Gm5LgwZSOBqs0OyECrOsdutBo27YW7TPZUXoKbGNgMyYGW78Vo9si9M+vvfXh9iqzqNdDYVj0a8GbxKdVAEfqqZar638d5NKJwALLlnkMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471484; c=relaxed/simple;
	bh=zt1fmIGR2fnnR3IT7pxsG3QuLa70S86ANQFOeJNanpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTEkMWp1vajzHiC3MwhRon0zuMyUAgCkomrxuBJHCQbgoOe58W7c2BXu+OHkzh9KgR71wBB7GppNHC1+kZx6fnFSaMhzz5BHbbIU44wiLj5h/nttf+H5tVn1YtmUBxJrKxUNsF1YjxgSV3YJ4mSzFq6fl0EiJmYBUCSjXTOOrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLFmss1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0558EC32786;
	Thu,  1 Aug 2024 00:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471484;
	bh=zt1fmIGR2fnnR3IT7pxsG3QuLa70S86ANQFOeJNanpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLFmss1j1QEJ9cv1nxUo7nL8H6OfxotDao2SKJhi9nXlb33pVUs0AB0EQYre9v5z/
	 EFJz0dOZoOLR168YIKO47YSQ1nCdOhPCkbz/S1KUq0ns/KXm+nF3O0ADCNDKuIh2BN
	 3LtDLV4AUaZVPOkd23N7NiMeI7FcuxibAC2s45fRF/VQiT7JOdUTgXF3bu3qW7bTLy
	 rCSdS769oSXK91lWSRQuAyyfEm/BVPDbWNyIWjZkp3JeDm/oixgzqKY6/KGC1UOOXA
	 yWKkk/zhU/bqk2mrLUKrqaqRt8Capyrc1wWVTCe+CdFNQcQPmW23WWYoIlzBMFQcrd
	 muITIU+4G8TUA==
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
Subject: [PATCH AUTOSEL 6.10 106/121] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:00:44 -0400
Message-ID: <20240801000834.3930818-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index e32b6972c4784..278889170f941 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1839,9 +1839,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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


