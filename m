Return-Path: <cgroups+bounces-4411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7028695BAC0
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 17:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FB86B284E0
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750F1CCB32;
	Thu, 22 Aug 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ovs.to header.i=@ovs.to header.b="C0xpy0xL"
X-Original-To: cgroups@vger.kernel.org
Received: from qs51p00im-qukt01072102.me.com (qs51p00im-qukt01072102.me.com [17.57.155.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E981CC164
	for <cgroups@vger.kernel.org>; Thu, 22 Aug 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341304; cv=none; b=cEAalwWhEtwdECp1+M2+cAx0AIsgdXiO2AmgdR9CZGanFwudNkNc15hFRJuSdmKvU9z9ifdTGSqY66C+wN/sYtwXNRof4KUCfKHKUApCyi+XUkfiZaEKOwb2rVLzsmBBjId9FgNOXDO0NVW0yd6rbg4Cx60Vj6qpg1w7AZxgm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341304; c=relaxed/simple;
	bh=gJf+WP3qPo8Mj4YRr2X4VxgDyom2ZYEm9UHgmYR3aTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X100QHvM//5b5gP2yiH1FOAqKmc7tQpyCnAr6Xo+HIZNgLpFk8tnRkG7KdBRl0NhKgxCPoWcXEmEsVXd1ZWE77mvygyD/+9dMWVm2/QrhjEQgbvPm4rlVyT93ZigjrQf6K61ZP+HY0Bwhd747Ks3TEC30PRSjpjK+LOXiL2EgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovs.to; spf=pass smtp.mailfrom=ovs.to; dkim=pass (2048-bit key) header.d=ovs.to header.i=@ovs.to header.b=C0xpy0xL; arc=none smtp.client-ip=17.57.155.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovs.to
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovs.to
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ovs.to; s=sig1;
	t=1724341301; bh=J2P0ooKk+oC7F7/g+fMxDtMyooWKC/Yb36wlelM+op4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=C0xpy0xLTuXV1q6Uya/4lxsaYNXJH0QrTkptBsoCP3Wdxb0xu8a+f4G7v1M4lhkXS
	 Fa5jK1eIiUp5xCj6vBck33KmUm3aHvp3MmrfHmSOc2UZinLAjgJdxVAprRo+/ckPTa
	 xPnEhTxbxdgty979iXlFC4e3zsc4nNJy9ehK96UDK+FKGIL4jqVbfhG+SBaW/Vai5Q
	 SrKG6eCnz/YjdbJmhQy71POzKGhUvoRH9qn+TVEHPVyXLdXZo9PRlAACc47wDeOrb3
	 S+lTmnu6aVr7UULOuwB+C0Er0Zp7e9/t7/kaI8P6Dq6e2/m45fm1zXAAoJPjC+Lj7r
	 Z310qPavlgNfg==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072102.me.com (Postfix) with ESMTPSA id E22603402D2;
	Thu, 22 Aug 2024 15:41:39 +0000 (UTC)
From: Konstantin Ovsepian <ovs@ovs.to>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: leitao@debian.org,
	ovs@meta.com
Subject: [PATCH] blk_iocost: fix more out of bound shifts
Date: Thu, 22 Aug 2024 08:41:36 -0700
Message-ID: <20240822154137.2627818-1-ovs@ovs.to>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RLwHhUOxEtne5qUSfsKGQJ35PAHUIzDD
X-Proofpoint-ORIG-GUID: RLwHhUOxEtne5qUSfsKGQJ35PAHUIzDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_09,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1030 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=805 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408220118

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
---
 block/blk-iocost.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca..5a6098a3db57 100644
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
2.43.5


