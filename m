Return-Path: <cgroups+bounces-2433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA918A00B5
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CA8B23271
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA2181327;
	Wed, 10 Apr 2024 19:36:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D017BB11;
	Wed, 10 Apr 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777819; cv=none; b=ISp6F5k94xhjR0RVCtEwiMcR0VxxF1X5bWYtzISVgFA62ISU2Ce16sV2asvJ+SPnKpxuYpT4gXal/O2b9FQsinAJByJ1200i016cdLqglKNKjHD2gIFJnkyTyarh61TgAE2EyJSyzT3ziGGHvHv0urP205QoZdTj1PQ2dRlRAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777819; c=relaxed/simple;
	bh=S5BTEarz0iSmxy+b2TcZC93iyXKdiNlysOtVgmMET4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBYW9E7W+ar3T6jd0M0vCdAQvRKaSJ0XNW2R++b363D7sKfPTA06LJ0Zi06jiIqO1vjSYYABHLrGJILxmypGLyHjMyvqxUYeftUbz7s4WSS7BG5PgEhzxQRsvEQWV7huZBVjAOynGlHkS3dQhLX6q9BajTEN5hykjJRUVCHANjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4702457ccbso907962766b.3;
        Wed, 10 Apr 2024 12:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712777815; x=1713382615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LV9OTU7lN1JB10Lq12VkN+Km9fa4QtfBk3DiQf/p+wE=;
        b=H1K+tMJQ4V79Vkp4SGoyvXp9aNOc6H7xOwQ9OuQ/8u5vgD9i73+uHHXw/5HM6bCQtV
         OoevfthjwAZDzCOZ5c8e8pBHqidMmccI7xhtT3cyVy8UCXlm47jetxeqavF8BTVHxbOb
         3IhrEOwp/rnznYZq/WYF+yscR/CyHYQOcNqPoq7N98kEaVsz1n6fnq4cBWxccIauvR3y
         VSCL2M3Y98aMmcDemXCnkqNlDKjokWo3iCaWFF0r/E5GKdJiMqldPBGE2aCtIL9X8QlR
         srexKP+vyGiO128JlD+y5QjeguAp0SzCzNHtEpOpE2sY4Ef5xJBfw72pS6Uau9PcZ5jo
         vbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3YeDC6uQ79JKjaQcTkVVaEX3f2dJf7OsxSF4qrHsu8NDXdVcYVdBYSrttNP6NetDOMchjHbxY4893Deg5p1PLj4WULL8fVnitcsKqnKSyW4Q8Wm+KsF8/LIqzNuuSCMsjY6WkaGs+yuqKrwY/q2IL1Ew/jvwXislk72V9Zgyo9fDW
X-Gm-Message-State: AOJu0YxFTiD8ghG04cMt6EjePfedYFnnqvefEMWcv+Azx5+FaOfGghD/
	ErbHQ/5OC9DCUFc2THLzI/TO9IMmaGV0fGzVZOX1slw3tv6XCAl2
X-Google-Smtp-Source: AGHT+IHr28Czx4c87y8DMCQwDkaWkAuvwyA5LRX41vrj3tkYSdhx1rqHWjUXnt1TtLrm19V+Tc6fRQ==
X-Received: by 2002:a17:907:6089:b0:a45:ad29:725c with SMTP id ht9-20020a170907608900b00a45ad29725cmr2762322ejc.62.1712777815193;
        Wed, 10 Apr 2024 12:36:55 -0700 (PDT)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906830500b00a4734125fd2sm7268231ejx.31.2024.04.10.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 12:36:54 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: leit@meta.com,
	cgroups@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)),
	linux-block@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] blk-iocost: Fix shift-out-of-bounds in iocg_kick_delay()
Date: Wed, 10 Apr 2024 12:36:41 -0700
Message-ID: <20240410193642.1303741-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running iocg_kick_delay(), iocg->delay_at could be way behind "now",
which causes a huge tdelta difference.

The tdelta value is used to shift some bits around, raising the
following UBSAN splat:

	UBSAN: shift-out-of-bounds in block/blk-iocost.c:1366:23

Debugging this, these are some values I got in my machine with 6.9-rc3.

 now = 3626064295
 iocg->delay_at = 3275794093

Fix this by validating that the shift if valid, otherwise bail out,
similarly to commit 2a427b49d029 ("blk-iocost: Fix an UBSAN
shift-out-of-bounds warning")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 block/blk-iocost.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9a85bfbbc45a..398fe19db4ca 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1347,7 +1347,7 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
-	u64 tdelta, delay, new_delay;
+	u64 tdelta, delay, new_delay, shift;
 	s64 vover, vover_pct;
 	u32 hwa;
 
@@ -1362,8 +1362,13 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
+
+	shift = div64_u64(tdelta, USEC_PER_SEC);
+	if (shift >= BITS_PER_LONG)
+		return false;
+
 	if (iocg->delay)
-		delay = iocg->delay >> div64_u64(tdelta, USEC_PER_SEC);
+		delay = iocg->delay >> shift;
 	else
 		delay = 0;
 
-- 
2.43.0


