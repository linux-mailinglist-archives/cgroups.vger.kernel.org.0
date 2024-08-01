Return-Path: <cgroups+bounces-4052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D19943E25
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 03:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F201C224E2
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F861D6196;
	Thu,  1 Aug 2024 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyuDAUXR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3A1D6198;
	Thu,  1 Aug 2024 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472276; cv=none; b=Wvp+npCWCLV6yLFhRjGdpIje0RBVrc8TpREZfJL4APqcIbiXoEX0f3oYaoATaaLhY/UOcfwgdYLvqfYApbxo4xyXFmgKFMxKEAXU52y+UBZuOwb5QrJnghq2ZLuOWr90TggiO9H+6OVCT/GuKeL9XKqszbTVdw+fxWmdiP93EKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472276; c=relaxed/simple;
	bh=wL+5/ryNsE0RM1k6MObetlU/kpjtJC8pWFkcVlLji6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CULHJR6dz1FuTwgz0SClLG+oqynUSRwYRG8bF1OZ/UXgot1mj1t1CPjO19dJyzESFNMpShUmaROj4HxYDIh7cndNjj4L6R0r+6zwaZ5vugsucbJPiOmloSDZdIFawDgLQ39aXKRde0d1ergsakDJ8eveQWSWZvWIYydWuZzluuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyuDAUXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F5FC4AF0E;
	Thu,  1 Aug 2024 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472276;
	bh=wL+5/ryNsE0RM1k6MObetlU/kpjtJC8pWFkcVlLji6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyuDAUXR75pnrxYT/K2z6jJpu5wAz5hI0LPM7afiQp2oPQr5VPX6fmGY1suQ1Unnc
	 keZBM3a6SAPVg2RYE/qDRfHHBzOGrgSXLVsUU+rBCa0mdigGglCcppBacE62U92xzi
	 9CBaTqDNXLQgbGuJSWOMusTwAp0OpLgWzUBTRbXC5KoKEDa//NK73oVlLIvZ9VBe6q
	 MnvR/KYP2Z19szyF4iPRNdZ6LOtfc0C3GFOnLZ4gmlLE/vYr02YDZ+Ig2Acm8eXpk5
	 lqKXmg2WEY3J+qzwpBblMRW3H3TwM4KMx5Ys+CdfCb8Kiuv/DBTMZqfUbuBBlJXQ5i
	 xYC1RROLjVLxA==
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
Subject: [PATCH AUTOSEL 6.1 52/61] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:26:10 -0400
Message-ID: <20240801002803.3935985-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 97ecca43386d9..2656c6d8b085c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1843,9 +1843,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
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


