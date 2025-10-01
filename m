Return-Path: <cgroups+bounces-10506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF3BAFD36
	for <lists+cgroups@lfdr.de>; Wed, 01 Oct 2025 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173737A33C1
	for <lists+cgroups@lfdr.de>; Wed,  1 Oct 2025 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC022DF12B;
	Wed,  1 Oct 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7+OTDyV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BB2DAFA9
	for <cgroups@vger.kernel.org>; Wed,  1 Oct 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309952; cv=none; b=oT/2O5hkUFH/wIjbqh/eRtKec4iBVR5mtR8QRvI7jPBl9/MLSO+N1kPnsh1+8zd61Hw5okI70r4fqYkZ7Lva1TIcvkT3BC0rRW7fCleX55/WvaJBz/iLt4cuFldCHPXneeKx82HcMVGAMHtZp0w8DFYTzu0U9w/7UzHn+/Zw42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309952; c=relaxed/simple;
	bh=pcPGB/dkNVmNUPRNo+DXzWGtd/nCSRGlepjtH4sr4w0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwNNj7/nDEAUDZPazkVBBhYGXemQbLYlkhZivtD6andB9vIe7wh/R5pZ9I5JoezCjjQwZh0nO323dJQZdiiXymUrko6QmOqAO/HkwLA6hHrHXesTu3GbTi7yJOxl4BvS2svPwfd687Y1MShh7kBMD1ZD5QuxOWfCsBZzyESuvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7+OTDyV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-28a5b8b12a1so33099145ad.0
        for <cgroups@vger.kernel.org>; Wed, 01 Oct 2025 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759309950; x=1759914750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HpzxFyHZ2ZMy/pC4mNA7Ri5h9xiXLEXZ6WUw3XUfTw=;
        b=h7+OTDyVoIL24waxbOivVa5UWbsSaVD+23bqdi8RTSrGRXW44ut3wCCVknyNAQeqCg
         3MKTASkX5ZwN7PRx4xzsrjWSQ8t3DS9k/pFayibTsnvdYU1As/fyP1HUWd4sBf78EB44
         7obd5wiQgz6hyqmFGJvMyj5DwkC3j4tTHZlbRw63/p17eDjaCqYEFiicLxvzhB8T8a4y
         W6r6lrz53QGqOSn+6NkuZEgErCUhR/Xc0YegONeVTFOhLo8GwlgkrBOXAms+PEUc9P1n
         KGu/ZvWDBMVBJo5W4zo04yMwNAikxIXiLESaHogiJ6ppKsL7gmH3DQld+6InV77TIXhp
         iK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759309950; x=1759914750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HpzxFyHZ2ZMy/pC4mNA7Ri5h9xiXLEXZ6WUw3XUfTw=;
        b=l8Ajna0yIY74HLCv0/bMOVbUV3stOqpFBKit1Gy5DUlheN5zcPnMZPzl5Be5Vq0TGf
         ZRlopghxOlRPrFOIMzqa+cU1myfcDQcouwd1QH0lLrnK5fha4swt0WvZyKJI79Ni/oCZ
         5jsI5vppLA1a5WfiE1b4lFv8JKlvFT+PAiXjA+dkTFarBeylw+M9IXpzlwt2ZrL1VreJ
         8BEWWr+duoU2iAD0hFe77wI/mECNuAuwYHiaTH4Dd0PZHRFI4adyG9n+dKQoCYLUEr3I
         cOdtHiHj7ieupB4t7Jp+UIe8PHqmdlputJstRK4u794trP1Wu+W8+LH0jxq8LPUqwUA2
         yHDw==
X-Forwarded-Encrypted: i=1; AJvYcCWpJ1narPZ8gHoGi/sHO98FU6mkguXX51iVeJvnz/YgsWeeLwtjaTaqBtR4X7i1zJGIzG9KmUnM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jJX0lNfkrTnsWSiDW4Nqi+xhYfPyHCOUNGF3TG5l/7Hr6Kyh
	4GFLxfxGCdCIWH6Ov6Cw2g9gduEc58hVO953dCXPcr2RD981OiQbcHzSpMT/Qf8Q
X-Gm-Gg: ASbGncuFbCFbwDgA9a9dmkgxq3anio35Gs/SXugqyakbPLa7aQqvkFoKvbYRjpkXGrI
	DJ1ndzrqjO2Nh7t6bPKDq/C6n61XxeHoCsEJ5MhTsx/6viRteK+l5PG+Sddyk+D3S+8ID9+adDW
	i4frEn9MmxPPX2Rb8pYCzbWJZO/thvhuZRMXtBEqxRxp/u2GjMXUNdggEzVIVu5YO84kDWbH5au
	DLSUpmesMVTJyYcrKVhGloXkAVGkpvg1ZrGuw1I4nQ9wfQxwBSWqTXkWijs1hLcZlUNOZqv5u36
	C5FF64vIgDnKqJL12gwX3mPH+85YtMspv7kj+aVoQm0HtA6+9SzVEEkxtnYB+Y0GaTD3oaJcf6W
	YGZ8xRKJ649Cc4ZJuPcvcAAUiGUMuw6Y+oANRmdlsHdqFbabAYPwYuhHPOC9G8RQrl6N+kbcUJA
	==
X-Google-Smtp-Source: AGHT+IFhUZ/mGMyT3exSWSnoljUD1zZiQFnygIrQDjToqp+r+F99aKI9B8d5mZOODf5Cfr3g259Sdw==
X-Received: by 2002:a17:902:ce0f:b0:27e:f16f:618b with SMTP id d9443c01a7336-28e7f2a6437mr33385785ad.24.1759309950202;
        Wed, 01 Oct 2025 02:12:30 -0700 (PDT)
Received: from ti-am64x-sdk.. ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-281fd60835bsm120299255ad.19.2025.10.01.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 02:12:29 -0700 (PDT)
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: bhanuseshukumar@gmail.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] block: Fix typo in doc comments
Date: Wed,  1 Oct 2025 14:42:20 +0530
Message-Id: <20251001091220.46343-1-bhanuseshukumar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

heirarchy => hierarchy

Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
---
 Note: No functionality change is intended.
 block/blk-iolatency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2f8fdecdd7a9..f2e65fad71da 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -34,7 +34,7 @@
  * throttle "unloved", but nobody else.
  *
  * In this example "fast", "slow", and "normal" will be the only groups actually
- * accounting their io latencies.  We have to walk up the heirarchy to the root
+ * accounting their io latencies.  We have to walk up the hierarchy to the root
  * on every submit and complete so we can do the appropriate stat recording and
  * adjust the queue depth of ourselves if needed.
  *
-- 
2.34.1


