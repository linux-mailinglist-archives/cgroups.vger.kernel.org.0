Return-Path: <cgroups+bounces-1216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F383889D
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 09:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4A1281DB0
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D23C56472;
	Tue, 23 Jan 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="A0D1hSU1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A556452
	for <cgroups@vger.kernel.org>; Tue, 23 Jan 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997576; cv=none; b=UuykhTelzhfX0f1xNoLZl0w12pMO0PDPq77CtEj9elNGAZk0iCgG7WMP2PkEQDDUeh1g8DQa9BiZXPlyw1uLboPJqnGtMIrSqLyfIeBzHv++B42KOeXJYMkwnrfJIj4YL6hrL94MCiil7NL+RHtMtOvORB5Gzpb6G8dfeq7aPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997576; c=relaxed/simple;
	bh=R7RQ/PfRCLCtq5n5pcF6Xl5ipxi0QZFoalAKE+tfwB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfRBncgW1oqtGBid6iNqxKDJLeTJYDgibTqckrZ/zUVAbx0T0Al+ELIJGFGi+PhnwV5aqF8+EGiBugbYEhIRKC54P3/0lQHVr/2oPDSIrYTxsc5Fp9qW8TvjXz4qNjNm3dqGuJa17AeBUWAQSK7pEDXxfbqhRcUAcOusuSXKNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=A0D1hSU1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71b62fa87so22086135ad.0
        for <cgroups@vger.kernel.org>; Tue, 23 Jan 2024 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1705997574; x=1706602374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inxZJymqVSs5ffJSXOVp5zCbMBHlALxa4MBGgugNy3w=;
        b=A0D1hSU1MCduEjtZVDWLL9LU5Tc15v33sxmMMxOfG2aAERztpLuwKI0Iy+MDB1+p4b
         aWCfZqiQrhJEJBqmt7gLewBHqXT/0irvj3kh+LmCG3th4Ret+ZFYereZTmMtLlk9kxlC
         IoQidMYULLOvEwslwfuDuVGfbuFv3HHM14zvJJNHH3L1anHVMS4fB064re7FPIayZIEC
         EbMsDBvs14Ts7t60gkSidSiDLQm0oXmvgZhYbUsjbcy+zUa+QtISh6ZYhOQh2O+fcEWb
         yE1xUjwb/95BOOwloY+7HvwncB4/0Kyaijltj1WznQB6SiErBdvL5yJ3CwyIxq7zVsax
         VhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997574; x=1706602374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inxZJymqVSs5ffJSXOVp5zCbMBHlALxa4MBGgugNy3w=;
        b=VagVIPM/ecqBq3w9QKyJ0WQnEH56mH07AcCAmKB53PsMQB7VSvFedDN++kmNa4IWeU
         zrcdJYFdsmWNJUaMdjymu3C8E7R1VAUeoAhCqAmQmYCCbDtuTeHCs4rWrmCkRf3TWbTh
         G0hdDojRh9l4plndQNQAoLBTCxgOKCfkBKhvbv5XlGWdlRUwGQDAZDPlMdSSg8/pgngy
         1nlx6G9EbiwsMeB6A6pTno354eyNwORsjzJrrVMx8uhg6HJlRh59iyTcVcbIHXYDPOwZ
         au9xoRz9irlu/hlRyTnuDAvmp+y8fBjc7XORBgaBzd6BZH1zvp+JLzFbZXMDXYccCBXL
         l5XQ==
X-Gm-Message-State: AOJu0YyS3SHBBYzJccmFPXOba0lPkjyOrWsFK8fbGVrndK4HPAsy5Buq
	cwKBFKzZ+3CpPOL+vVV2Z1jhg8H5BclDyCOn96dEdTIDs/FDf67r66A9Ysax768=
X-Google-Smtp-Source: AGHT+IFm8k6VzAwvXCSNbOrkx9mrdc5qgT4K4r8v61fd8ma+XY3H46IblYtRR1lMGCX/HBClqr/TBw==
X-Received: by 2002:a17:902:cec4:b0:1d7:7583:6d1c with SMTP id d4-20020a170902cec400b001d775836d1cmr88475plg.16.1705997574253;
        Tue, 23 Jan 2024 00:12:54 -0800 (PST)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm3911643plx.154.2024.01.23.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:12:53 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chunguang.xu@shopee.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-throttle: Eliminate redundant checks for data direction
Date: Tue, 23 Jan 2024 16:12:48 +0800
Message-Id: <20240123081248.3752878-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

After calling throtl_peek_queued(), the data direction can be determined so
there is no need to call bio_data_dir() to check the direction again.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16f5766620a4..2ad4f6cd465b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1098,7 +1098,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
 	       tg_may_dispatch(tg, bio, NULL)) {
 
-		tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		tg_dispatch_one_bio(tg, READ);
 		nr_reads++;
 
 		if (nr_reads >= max_nr_reads)
@@ -1108,7 +1108,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
 	       tg_may_dispatch(tg, bio, NULL)) {
 
-		tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		tg_dispatch_one_bio(tg, WRITE);
 		nr_writes++;
 
 		if (nr_writes >= max_nr_writes)
-- 
2.25.1


