Return-Path: <cgroups+bounces-12434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA99CC8D9E
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D618230BC283
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79231357708;
	Wed, 17 Dec 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZMi5D8fu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF03559C0
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988891; cv=none; b=dmbeLWg619Rf0M7jzWYcs1kewpI9Uzfc1ripL2aUxpWK3wQhxCbzbxt4MJk3TbVv9vVUFd5Qnpn/k0z46BgGMa9FpReazBwRbX84d5xy5hC4zL302SfgcLOwuox2HEwQXsKorL3l9O6+Fjswtm1t8a2bhNaACI94ahq0I+BD9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988891; c=relaxed/simple;
	bh=hHiQ13HsCnnPciHjNgpzJZ953n8TCFCJOtTwd/r8PoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8RZeH3flq/4R0pmSYI4lGQVWMe4utNRSEfGPFzkKrjLyKsRsK/Tu2ubEut0okp17T/6lr4+G9IKF/6xxKG0YGuRrexroXYzFN2ce6F5KDr43pVXvJg+4OpboKyUa01T4rIPYylaIgKit9Ajhc+UTBFfYlf3Po/URG/VK1Q9aHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZMi5D8fu; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so2253884f8f.2
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988887; x=1766593687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJElybK4r9OmuCr9uVdpcrBwONyPRzk09mZYQhniuJw=;
        b=ZMi5D8fu2ODKZpQGF1dOBw90mD2ODR5ig/yMm0KcbgkCLTaKc7hUdNzas614aB0+la
         ZOdRXudFavbdltCYbV90KhV0AHlhXQJxomZOFxqwm0qWWC8ZkUIuNY/2sqzcBQTKu2Ot
         cOU16w/Gfn1W1aGN6SzYtljEtJhE/vZgvFjnuLZhshDu704kAWXtENMSMFXK/VlE7OAa
         2yFeN5Xyrl2iRm4AxNUHHMO1O91lyN8wpDgMflZOcAij5h2ZNP7fpc42mSmyDC76ekwR
         /jJRYLBKKan1IUtLdHd941qEcKgshI3HNqBM5V1tl3mvVQwng89xHSnW798Vu6HdMkf3
         U0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988887; x=1766593687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJElybK4r9OmuCr9uVdpcrBwONyPRzk09mZYQhniuJw=;
        b=stP7X/6PS1HCtmFxa3BZMzpw4MOgj3B/rImOOSw4emcTlBQnr9L3wLHWSEi8+XEiKI
         TAM5oVjqtO6bdJeHRPC2esAZGiigQ+OnS95vYEDqewXsiFV5rTDgo2/+usWt2+vG2fzh
         lHLCqnTqMaFEqRYSKoTfnu2xcL/a0lkTjwnRnOmDDmbkDLqaRhxjgVW9QMXkPbB6nYoM
         RLEPazpgDx7D+zH/6WUABgwAQuhERFBxjGfewQz34zZSbeCxwEYwR6bgRifO//iBrlkO
         KJvNdUnXHBSpUGnWO6JuT5o3lrf+T7DpYrfc62bXkmImYT86l70ITV+AugrW+L8uIMR/
         LUqA==
X-Gm-Message-State: AOJu0YzaA1grK7RpfUKMNo3ND5VAJNBoCkcR6/bhjNba+PhjhdeT1y/v
	1EzikJ1/LTnBYnws0OOsxBbH52zjPDiUTqvnUMc3FkWFAjRxBYDFPEX0QiH/Xn5cCsO4gnjTarC
	RI7PE
X-Gm-Gg: AY/fxX6oSP+p2SwPHPjisVxPE0/dfWAXTB/Gwc1YFb8CGgQUtquORWBO282oX8ggoeL
	lf1hfs0J+aPdh6CkxYI5KBu9drsdxkGi0HJRzeDPH92QUqw9akVNAEV4+mFPKgvCd/Gv0j19zo0
	nAd85Xk0+D81jLfvv/NUBtswsKhHQhpqSHb+KXciUWXs5hQrkJxWaJuLnh55J4vk7E1xEBO5Gkk
	tbjFYL1v6cGvcSw1YBG+OnE1+z4f/KNGlpWuUT/+Z+SJPLVhodzQj2vS3+bAalGjNXKl5IMh9md
	UGbHfKa2ZxQhpBjTOXyplbQPPY1zM5ZQ8AQZC8xt9xmUrmJUndRmP3aY537YzHp8uDKineP1GNi
	U/UZ4cJE6vuftQ8y6jVGg+EQjGnQ+j8FEJvrN5/cl3ScfFCmHM0X/PkKMUHGl6vHIExjyxrgm7p
	FQK12jU061hkFvMvRHZm1Wr8yKoIhNyL0=
X-Google-Smtp-Source: AGHT+IGbhlvyzEjuDTSV+fNvDCFi8GKeD7MdXF7NnWLDDEh5pN2MML+EtVLT61FA020HJ60pRPL1yg==
X-Received: by 2002:a05:6000:22c3:b0:431:656:c726 with SMTP id ffacd0b85a97d-4310656ca9dmr6412349f8f.3.1765988886936;
        Wed, 17 Dec 2025 08:28:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:06 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 4/4] blk-iocost: Correct comment ioc_gq::level
Date: Wed, 17 Dec 2025 17:27:36 +0100
Message-ID: <20251217162744.352391-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This comment is simpler than reworking level users for possible
ioc_gq::ancestors __counted_by annotation.

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/blk-iocost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index b4eebe61dca7f..c5e09ebae5ab0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -545,7 +545,7 @@ struct ioc_gq {
 	u64				indebt_since;
 	u64				indelay_since;
 
-	/* this iocg's depth in the hierarchy and ancestors including self */
+	/* this iocg's depth in the hierarchy and ancestors excluding self */
 	int				level;
 	struct ioc_gq			*ancestors[];
 };
-- 
2.52.0


