Return-Path: <cgroups+bounces-4851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F1975C99
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 23:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1081C1C22839
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECAB15665E;
	Wed, 11 Sep 2024 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTtt1GdV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15529143C6C;
	Wed, 11 Sep 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090889; cv=none; b=gNWsRXcMAt7ReY7Y6Fj72jpA+uYCJOsUMYYot9SlljcDdMbiddoiMX3UWSCbTGNlDOcy9XggEh/AbsvvTYApkbJNZK2HODhJoQXg7CCEgWc9ZScjgpwgIJPxlshBs8thHi5pvYEN5X5NF2vEne1s/xrVkDZuytKeUSNouVoSoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090889; c=relaxed/simple;
	bh=OsQ/ErDxq5Cp/EpzRGKRQ6lXYYYmmTG/7CUmdQSRqPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bjmehjd9RXniw+K6GCaIFDyHdIVat7hVAykKqXIZGmjhdlYNsd5AEEXOf+nNQLJ7tvzaxM8+NFa2GBiVsoeW5T+W5327h02Dk+pAnTCBsG/38lBcUuH1V/d3UUbVRjJXwursy7wXQpZBWjQ5FWnVMgyeByHlpRyp3gziHsV+18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTtt1GdV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so2439225e9.3;
        Wed, 11 Sep 2024 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726090886; x=1726695686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUiQ0q90idaAw/e84mkxPzOZ9Y+GKa0GQ3Ju/u8lPW0=;
        b=kTtt1GdV86AhVe0FmDpLt/M+pMPpOOq4NGDQ6mBL2kpgpzPwVUEMp65I387U3Eqhaj
         1sCfYIZFRDhGqBmIO+u0zEai2sghJ2lV8mGx3aXlVJOLFzQ/UkS14xKc5jn9q/qIeVsP
         Md+g5YipsAeYvS/TyoJNbtC2khPUXFwm9739LnSDfYFvdIsSTWkdGskNZzbhYs7Eqxpp
         A8IM4RdW2guSZ4WGQuepzBOU2xtMPIFhsLLsNy7O5m5NDj8gHzky8Fr4MsjUI8DZ/fxh
         If/k7d3J1keIpep1MpaU+7f6bFs7FkfRIPOG3kUf1gA7aZSIY/aYJAf8mUcEBB7R9pfO
         Fx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726090886; x=1726695686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUiQ0q90idaAw/e84mkxPzOZ9Y+GKa0GQ3Ju/u8lPW0=;
        b=qz4ecayOXuYb7BU3lN/LI3uuIx2oG/Vef5P1oCnGE8Z+hJxakN85Vhx+JSPA2Ca9qS
         vVpM65Vjh0vEo4qtur2eaFDod9sIAanBlU9yCjIvDO4aESMdycKHeq0lOn3SrlEuX8Nj
         VUizAZCQ1ioSwsdK3Wu6MCDMpsip6UGlhl/JZyYt08WFGE6SfXYThlIonWLWUeTLPc7Q
         5lwAdS0d1rYvRrb77NxJK8j2M2KmzxtUyqeFIqLN7m7QWa5qDwY69lqwOZLjH4lWbPsQ
         fYIrnTHiQaIU+C4Ri+nUE0RpIm7deecM3oT/1OqvNpKtV+iZ9rU1dPbykPiAswvxvWMg
         ahRg==
X-Forwarded-Encrypted: i=1; AJvYcCUgSfIuTT1ChBVenU3ig306/ElmSMveLhJ0J0qlzxOregfQUImZO0LsTUYK4ePSyf/stVh+ZtGi@vger.kernel.org, AJvYcCWBwH1+72q5Q+rlcAMu0/YcLGSjnXdK6uQGcNU/8whMq1HJV3bHQ597l0DwjnUbfwsiD4xxKdapsztsIfT7@vger.kernel.org, AJvYcCWUMCPqZ0TWMs7/Cz7YEyZBVW9pnzE6LpgPqjD01vHxppJ8L/Bi5yEVtf6klObsNjHqDyqQa7RA/9jdqpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMXUj1hptur7WrWPGu00+4EuwgiCTSdlJno50q2ep+tQTFJAL
	de3MXzt+3vyjMCQZJCK273yajWoZrpS86Y0R23OB+2Dl5Zbr1PzU
X-Google-Smtp-Source: AGHT+IFMN7DMsm1Fih4Vy1OboNqeu0t297hmZOOnw4ntOwHnbLugOeZKPhxB/K8zvx4zjRRxWV7j0w==
X-Received: by 2002:a05:600c:4f54:b0:42c:ba83:3f00 with SMTP id 5b1f17b1804b1-42cdb511317mr7822095e9.1.1726090885957;
        Wed, 11 Sep 2024 14:41:25 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb58d815esm122804235e9.31.2024.09.11.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 14:41:25 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] blk_iocost: make read-only static array vrate_adj_pct const
Date: Wed, 11 Sep 2024 22:41:24 +0100
Message-Id: <20240911214124.197403-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The static array vrate_adj_pct is read-only, so make it const as
well.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5a6098a3db57..9dc9323f84ac 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -648,7 +648,7 @@ static const struct ioc_params autop[] = {
  * vrate adjust percentages indexed by ioc->busy_level.  We adjust up on
  * vtime credit shortage and down on device saturation.
  */
-static u32 vrate_adj_pct[] =
+static const u32 vrate_adj_pct[] =
 	{ 0, 0, 0, 0,
 	  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 	  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
-- 
2.39.2


