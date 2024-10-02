Return-Path: <cgroups+bounces-5007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB098CED2
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886091C20FFB
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3287195B1A;
	Wed,  2 Oct 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5bWtM38"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644E12C491
	for <cgroups@vger.kernel.org>; Wed,  2 Oct 2024 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858198; cv=none; b=Dwv0gb8WqGpL0ve/ckSQVyFJEHTiiYElIsTgwZS9H9Vf0hDJ4VI/+H0RwaLVYRIQKLPzKOZlb7Kbg0gNOAKuey4eO4udhfZV4wpdmGsCHnda3Ggt3a7f0dT7AT4Er/guohMjKO5pGNcr7/2CdhJ2uSmmxNr5TKvdVslF6HdIVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858198; c=relaxed/simple;
	bh=bNOrYjkHCBg/Fcd/LdNcDAu/YaCl9tCbo2Xxck+PiHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z0CtzagViYDpft1Dr5MnfgJJDob/s3ruAH4gHdGQQYdv3G1ZIjOBi+z3z0UZjY1caWSaazSa8w4Gs8Ni3V9PVTeit5zuMl24vKIpKArhTGHhbu09g58Flkf6z8KqsnQW8qBDIrAJh0bQWfa2kWtmT3truR9kPdGQ7KwgG9lHPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5bWtM38; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so51785775e9.3
        for <cgroups@vger.kernel.org>; Wed, 02 Oct 2024 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727858195; x=1728462995; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kc6BiyuSD579Sv6LzlSE+1CxGu9PgjAtpw64mVktEYA=;
        b=a5bWtM38berS6MTkRq0hzVwB38eTLheAiA3K9tFXCpYJK0u272XC5zg32EpNqCcAy+
         mpmIyb7ZgQ7j6xpq0tMYDywixYOvV8+rf6ibo2s4SHVquZvmo8cEnEJKdDtSEpH8qRNP
         zAh4sH+0BFaaEg56jVwJPU1YBHjJbPQ3lLBP04JT+PRZkKnU7Iq4y/BNgACbOr8a0htL
         4FJLMYYG5X+laz8JPh/TZq1jY42Z1EairGY01POCR5Wu0Yk16IPswIduYjS50R4de0e2
         99Zd7tRIanhUHq1OmSVd823nyuQ+B3hfRnIkBnVMXRku9l2fL79JHq/Jln5Hpc9q4XGX
         2GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858195; x=1728462995;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kc6BiyuSD579Sv6LzlSE+1CxGu9PgjAtpw64mVktEYA=;
        b=lGg/B+qM/MViqXRIT74Ui+NOFvGgXoPwHOkhbjCnkiQGiUcngOxSCnIhmxtMpi2Cvp
         yEqpjNaKlMf2fObwd9xTABQknvV9dvkZ8Llq4ux/NRrVtQhOAFcVjXy0M2gnktKUSd2y
         z01FEAppXGxtvfb9VLQQmYdBowJpQT/h5QbjoJLQCfF1M/5sbKKRdED9oLu5cmOFf6lf
         F57FSFDcQOAiL/gNvHzCOL77NELVjwbPCDDr8xSxt4kJEaswJCP2pGqxQGN/Y38d77Es
         Nc/BerSOrIGuLEzxaxc4DaTC8BPQsx/p7AgtIFfbtiP/W0GLqUNvbqHCS/RpLo+pKwLO
         bSAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBxEMQFb6x9uHtbTIzm0DG01iW3jJcolHqeHT7JcZT7U45D+at8GTvbp88F8YcgQTmpFPXrhRf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VxH8gmN/qZEgh1iKDqHW+nHtgc6BmdaXWZpPoJu4go71h26a
	8v6bFeK16cYXVdguNqe6jKiArL0kTT5Q9URWM99GMIHpHT7BwB4m3CNUoR2G9Gc=
X-Google-Smtp-Source: AGHT+IE49N9Qfy5+dsTk1nkwupACM5L0mU69EfhPe8nDnMTvJtXqKCmy5mqr/pcTmPLWRDJ6zsXonA==
X-Received: by 2002:a05:600c:896:b0:42f:7717:ac04 with SMTP id 5b1f17b1804b1-42f77957a32mr15915725e9.16.1727858195297;
        Wed, 02 Oct 2024 01:36:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eadd8csm12217495e9.16.2024.10.02.01.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:36:32 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:36:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] blk_iocost: remove some dupicate irq disable/enables
Message-ID: <d6cc543a-e354-4500-b47b-aa7f9afa30de@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These are called from blkcg_print_blkgs() which already disables IRQs so
disabling it again is wrong.  It means that IRQs will be enabled slightly
earlier than intended, however, so far as I can see, this bug is harmless.

Fixes: 35198e323001 ("blk-iocost: read params inside lock in sysfs apis")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 block/blk-iocost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9dc9323f84ac..384aa15e8260 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3166,7 +3166,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (!dname)
 		return 0;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock(&ioc->lock);
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
 		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
@@ -3179,7 +3179,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 		   ioc->params.qos[QOS_MIN] % 10000 / 100,
 		   ioc->params.qos[QOS_MAX] / 10000,
 		   ioc->params.qos[QOS_MAX] % 10000 / 100);
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock(&ioc->lock);
 	return 0;
 }
 
@@ -3366,14 +3366,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 	if (!dname)
 		return 0;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock(&ioc->lock);
 	seq_printf(sf, "%s ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock(&ioc->lock);
 	return 0;
 }
 
-- 
2.45.2


