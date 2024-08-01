Return-Path: <cgroups+bounces-4053-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A6943EF4
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB801C22C0A
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 01:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544121BDA93;
	Thu,  1 Aug 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrgK3252"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA581BDA8B;
	Thu,  1 Aug 2024 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472524; cv=none; b=QPH+93sD3xUxwuDBvRHUbkpkTQniDHR6TCTkVwAS0ZA3ytVaIVre/AcULxFRq5nV6Pnpn6ZreiLexBKUjm4NtBGZNJQcZkza6YdarcoscnpYCpoJIGICixW2OIOuBNwhuC1vBkFFI3ScdxBQKLg+KhVLy5jidnvTl52vahAKFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472524; c=relaxed/simple;
	bh=VIDEt+zUCbHxo7WFFhbzlhOw5RPJS+Ev6gYLNqEXYeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXGCB0Jkojd7KyRJB0Hdn3Qc86fmU693bb84GwZmzrYokLDL4eUk8HLzKHn9AsnKHlm97bRRhgmgUYSwqrDheBtNhlkH8QoKvrZJtWO20Ucuh1xvJPkhRIVs/xLK7FWsTiq0h7HuoLRVcO0Y9TOIzhyvIqNprXqfmHcAYT/zObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrgK3252; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FB5C116B1;
	Thu,  1 Aug 2024 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472523;
	bh=VIDEt+zUCbHxo7WFFhbzlhOw5RPJS+Ev6gYLNqEXYeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrgK32523kO2LpTkt95/7zNvU5VNEAGW+tLaBkxkFDMKgGSdwbYs16kvLHd11MNXO
	 w6tQggNmYqh9ZdB/D80TE4uovxJe6VrgmcHMrAlgCVe4+aNq2mr0oPCnyZI0z5zK25
	 xyp6FRz2EONhETTryESfb72RIEoZzA/V7FXULp7oH1WJKjuvaf9BmIuWEPB6WjCKSG
	 Rp05tziPMKY+EDacVpkrxAVk8XE6ZhRwvrW6AlgLJ0eV4FcGWDwjbv5mLNo9Ti0lLn
	 NEGInG7ADHTtpwNOaspt5wln2A5uN3fQJPkY7fk+TapceXLd2k4G2yKCUk+bp2cNjv
	 fItIKCq4xhF3g==
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
Subject: [PATCH AUTOSEL 5.15 39/47] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:31:29 -0400
Message-ID: <20240801003256.3937416-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index be467aea457e7..84e85561a87c0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1802,9 +1802,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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


