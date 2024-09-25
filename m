Return-Path: <cgroups+bounces-4940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98398588C
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 13:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28CA1F20FB3
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2434618EFEE;
	Wed, 25 Sep 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4MazaC/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141B18EFE0;
	Wed, 25 Sep 2024 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264267; cv=none; b=mJDgrm7sQME+qXX66cEw5mDJQGsAeSmga57hPzdzYgSoofXzslDuNLCYukH5wkQPzGd/RwVwjL+D2cjzxkOfonoC+4GQ+XYj3ttRxFtTPb7zSL7bSPGZIJP5jwCzU/SBVk02sFvAuwntgEVlZZuLAx0d5VIF9PeKgX4zTbjXVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264267; c=relaxed/simple;
	bh=7u+2A3YZEtGiBP27HjS6d6XYN9k0QAaxK0YBbUrwuYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebgsNAXzR7Fmwll9K9LSWxardvDmV6R/oHamMDxWLoCpiF4CiKUSuzMNLREl+rePtnSo8QmtUC32PBLkCt9NoLYSOOTs6pRByhCZbjXEN0Xj+8YDxfLZP+WRKsbQiWn7zqfg++nmaySJspRYjyvp6tRJVX2m6JOJZ6q18gB2sqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4MazaC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC57C4CEC7;
	Wed, 25 Sep 2024 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264267;
	bh=7u+2A3YZEtGiBP27HjS6d6XYN9k0QAaxK0YBbUrwuYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4MazaC/8zVYXUHCb7eCYGVn7iUyAQ50jwlWdmtcN+a9rxQl0KfLeweO34xHVvaRN
	 VczeOeZiK3GQfYLy4exJ2e3kRaMQD+JOwbC0Oz1Sz2qifrPG0DKrxkgC3X0bpND0o9
	 rAVRWCaU1HQJSfQep/0SYpCiP0M4igkBgVds9GvGAKQlNn5tTS52BkZ4CuM29ClOKH
	 oDaso1r72+4To4WL91F0J0de2SRWSzgFVXlhJLq4EFXxTiTmMgTyhYt4+YI7Hm7L8C
	 zqb+UzVEdrVaVYf7i0TL35xh+kO5h78P9UFVRAcvVeo4H55iRw419YFzFGst6V+jeY
	 EDdz0qkJjPp9g==
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
Subject: [PATCH AUTOSEL 6.11 030/244] blk_iocost: fix more out of bound shifts
Date: Wed, 25 Sep 2024 07:24:11 -0400
Message-ID: <20240925113641.1297102-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


