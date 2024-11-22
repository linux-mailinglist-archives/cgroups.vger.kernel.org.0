Return-Path: <cgroups+bounces-5663-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE61B9D59F7
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2024 08:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D6F2810EF
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2024 07:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE9176ADB;
	Fri, 22 Nov 2024 07:30:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 92354170A20;
	Fri, 22 Nov 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260606; cv=none; b=NS40tM5X5YcM/d5LEA/p2OJOZ/hAKJAdOOeDMwmeEqpiPcOW2W6xelkq7I0+/h9T4uRM7IW5xIpwPHTHLbfX9pcZ8irJ+wVCkCeRd0k9b4ftKGYpHV7KLYY7Ab/GKDOYXcg7C+t3umMHEo37vW1oRLtpd12cqTUOvW1rUknWPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260606; c=relaxed/simple;
	bh=wTLY4T5iGr3yUJ3tE5OwvBJD8swNQQaDzyCuvtZJaFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lEJ3Rn9LJ5QLtIaXgITsRpfH9j3oSDBA84RVGA5zWn1upEXeihv5UqUZlttOfL93xE2NlNTxl4SDfR0QKSo1YE1sglGXIscuIxKUWIRPFyYAzwuB3TWg41GEH9KDgVioT2/4sXfxmVJM5nVwKxNiquV5VEX8nO5HscNs8wio9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.35])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id AECE0185EAF24C;
	Fri, 22 Nov 2024 15:26:12 +0800 (CST)
Received: from BJ02-ACTMBX-03.didichuxing.com (10.79.65.11) by
 ZJY03-ACTMBX-05.didichuxing.com (10.79.71.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 15:26:30 +0800
Received: from localhost.localdomain (10.79.71.101) by
 BJ02-ACTMBX-03.didichuxing.com (10.79.65.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 22 Nov 2024 15:26:29 +0800
X-MD-Sfrom: daikunhai@didiglobal.com
X-MD-SrcIP: 10.79.71.35
From: Kunhai Dai <daikunhai@didiglobal.com>
To: <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kunhai Dai <daikunhai@didiglobal.com>
Subject: [PATCH] block: iocost: ensure hweight_inuse is at least 1
Date: Fri, 22 Nov 2024 15:26:09 +0800
Message-ID: <20241122072609.29429-1-daikunhai@didiglobal.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ02-PUBMBX-01.didichuxing.com (10.79.65.22) To
 BJ02-ACTMBX-03.didichuxing.com (10.79.65.11)

The hweight_inuse calculation in transfer_surpluses() could potentially
result in a value of 0, which would lead to division by zero errors in
subsequent calculations that use this value as a divisor.

Signed-off-by: Kunhai Dai <daikunhai@didiglobal.com>
---
 block/blk-iocost.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 384aa15e8260..65cdb55d30cc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1999,9 +1999,10 @@ static void transfer_surpluses(struct list_head *surpluses, struct ioc_now *now)
 		parent = iocg->ancestors[iocg->level - 1];
 
 		/* b' = gamma * b_f + b_t' */
-		iocg->hweight_inuse = DIV64_U64_ROUND_UP(
-			(u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
-			WEIGHT_ONE) + iocg->hweight_after_donation;
+		iocg->hweight_inuse = max_t(u64, 1,
+			DIV64_U64_ROUND_UP(
+				(u64)gamma * (iocg->hweight_active - iocg->hweight_donating),
+				WEIGHT_ONE) + iocg->hweight_after_donation);
 
 		/* w' = s' * b' / b'_p */
 		inuse = DIV64_U64_ROUND_UP(
-- 
2.27.0


