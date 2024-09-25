Return-Path: <cgroups+bounces-4942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4B985C67
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5335281B47
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992451CF2B4;
	Wed, 25 Sep 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTf2zReX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513531CF2AA;
	Wed, 25 Sep 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265569; cv=none; b=pZN+wEadc+UV4f40giC6XQEEv67oX9hCmV0Vs+dV0ozcFXQ/2AyjgUCEFqcPECCewSa1MZ4RrZYbd/vsnDaHrespCaCaYVdcHMYoY8IebTYhRVo/9ewS6axnreyefibcg3ztLHqzbafmHsKxMA1hplgYtGpfH2QrnV1c2Yehqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265569; c=relaxed/simple;
	bh=7u+2A3YZEtGiBP27HjS6d6XYN9k0QAaxK0YBbUrwuYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMJblxBE34lvf5FkXUZFlsQo9LHNjeKWmlaGcSb41jcrja3ROfjO+7bwSccfMJqDmxV/acNSOyPlZYWwbp450szlp2Lw4hjH6qhN4OVSdrwCULwXn8ZRt+sKcURxmCpjg2yIlZBSrNoX+6oInNy4sgu0549QkuLnZuipWOtcqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTf2zReX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDA9C4CEC7;
	Wed, 25 Sep 2024 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265569;
	bh=7u+2A3YZEtGiBP27HjS6d6XYN9k0QAaxK0YBbUrwuYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTf2zReXtXmwMRiEQFIzQg0zBmyHs34qTiOBUcBgoF4oW0xVGaO+sChz78kvKUSCY
	 Z4mQ7p5Jh7XFstG07xpoCMAl1dFWuu2RzsU1WEQwgrRNe0JO8ueCWkjiNaQngwOFVB
	 hw2jEidM73+m0Rac2mKOfJSbaIjc4o/+NCgWSPJs49cUcIDhOGCNmq9/N8PeMiwAPP
	 uUCmUx5Xfc4XMsuL3Hzr26dTvOFH8HtOA0KTag/I5ez1thFGXwCTwMdwPynKhWJkuZ
	 Zbn01TbyQl5Knts2XGC6o3x/ENt1Btsta1/jcy4AIMp5H92XvwniiIWdqS+ms3rlPJ
	 iVAbjmZhprGrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Ovsepian <ovs@ovs.to>,
	Breno Leitao <leitao@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 027/197] blk_iocost: fix more out of bound shifts
Date: Wed, 25 Sep 2024 07:50:46 -0400
Message-ID: <20240925115823.1303019-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Konstantin Ovsepian <ovs@ovs.to>

[ Upstream commit 9bce8005ec0dcb23a58300e8522fe4a31da606fa ]

Recently running UBSAN caught few out of bound shifts in the
ioc_forgive_debts() function:

UBSAN: shift-out-of-bounds in block/blk-iocost.c:2142:38
shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
long')
...
UBSAN: shift-out-of-bounds in block/blk-iocost.c:2144:30
shift exponent 80 is too large for 64-bit type 'u64' (aka 'unsigned long
long')
...
Call Trace:
<IRQ>
dump_stack_lvl+0xca/0x130
__ubsan_handle_shift_out_of_bounds+0x22c/0x280
? __lock_acquire+0x6441/0x7c10
ioc_timer_fn+0x6cec/0x7750
? blk_iocost_init+0x720/0x720
? call_timer_fn+0x5d/0x470
call_timer_fn+0xfa/0x470
? blk_iocost_init+0x720/0x720
__run_timer_base+0x519/0x700
...

Actual impact of this issue was not identified but I propose to fix the
undefined behaviour.
The proposed fix to prevent those out of bound shifts consist of
precalculating exponent before using it the shift operations by taking
min value from the actual exponent and maximum possible number of bits.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Konstantin Ovsepian <ovs@ovs.to>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20240822154137.2627818-1-ovs@ovs.to
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-iocost.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca6..5a6098a3db57e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2076,7 +2076,7 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 			      struct ioc_now *now)
 {
 	struct ioc_gq *iocg;
-	u64 dur, usage_pct, nr_cycles;
+	u64 dur, usage_pct, nr_cycles, nr_cycles_shift;
 
 	/* if no debtor, reset the cycle */
 	if (!nr_debtors) {
@@ -2138,10 +2138,12 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 		old_debt = iocg->abs_vdebt;
 		old_delay = iocg->delay;
 
+		nr_cycles_shift = min_t(u64, nr_cycles, BITS_PER_LONG - 1);
 		if (iocg->abs_vdebt)
-			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles ?: 1;
+			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles_shift ?: 1;
+
 		if (iocg->delay)
-			iocg->delay = iocg->delay >> nr_cycles ?: 1;
+			iocg->delay = iocg->delay >> nr_cycles_shift ?: 1;
 
 		iocg_kick_waitq(iocg, true, now);
 
-- 
2.43.0


