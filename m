Return-Path: <cgroups+bounces-6851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373FA53E60
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 00:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D52F188B3C7
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 23:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB6205E10;
	Wed,  5 Mar 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iELWRdRC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26131EF0BC
	for <cgroups@vger.kernel.org>; Wed,  5 Mar 2025 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217113; cv=none; b=tB2iokps+HhhToXiEMGYOZJ33hNkQLP1NrTVbQ/YR1ExRzNaIpjOp2uQixPXpJfTDvkc1FvBWqq81WFGJENvD8z3sXwdHsMIwztiAZz2qtP2foyyaQ9VxHZiaXWRW/nDPbQD4DBYuRq/3pSWzM5wFkulpBTS2hbQx+7BnB4T6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217113; c=relaxed/simple;
	bh=AnJYcyyPuSQ4pNrFrYAJyHf2ljozt32xk7TDdF8nbVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QcXcybYfa6liib6G+5muSec+wXKVHiT3+Padwwn1AtY0JSfFBgqm34m00a4L3NuB0gyd+uCfxdiEwmfCOQLjelnA53vIKPnZZpC8abFEXEmhMc8C0u+h28ZeoZZL1GeVuLouy0Y7PP9W1kRt/0TjKrahd/jD1ZzUa1wT4ogF8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iELWRdRC; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so700725ab.3
        for <cgroups@vger.kernel.org>; Wed, 05 Mar 2025 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741217109; x=1741821909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7kX7Ef8fyaxBwW7MaGLY5EScGfcxKucjoKcRNwnL6E=;
        b=iELWRdRC3yglom12TSoFzTShH7ez6cj5DJdLwQpSMiCr1tpPRtvFGeejPnRu7U/bhy
         VLGZtGdbRNGNTFbt3UZMv5gblgZatnMJHyOmPVunM6IBx7PCKmiRHCwkmB2X9c9kK+i/
         WW+JqpkOMWi+51XeZbwKSS7AfratUMT0euXzAHdV/IFSos62bu+zbc1N8Q8HggxPcDfy
         ptRINXruGoTn85heQ2xEK2ZPR7sp+PS8Ru2FE6DUWlNgK1PHPYaThECuaOFBZ1qGFsZx
         /qfwcyOjf5at5fV4BpkgETZrVMXFQDV5+QlQwij2AP/NV73hakGO/NZlpjNRpY8pYN+i
         +yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741217109; x=1741821909;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7kX7Ef8fyaxBwW7MaGLY5EScGfcxKucjoKcRNwnL6E=;
        b=rLY1jd//aJ+ZrhlfXwxjrgdNZ9aI0tUgbtJr3U61HYM9dlzemI3zKCpTGoYeRhCNTo
         4wXH5cmIiq57+F7T8Y7DOFPvtDU+v0l2LLOaR3ZRfFexh29Nc5rTkwRa/cS2ogwepQoU
         x+kye4rTtDId6qqEWMIXCh/IAbFTXbBRvLuQ3E0fK0edVbSI83q+PJJrakeueWvx28ZH
         pRgOIeBvqoJ+hd1iAPKezkvfbuHdz+xXnDgK2RwGXhn/HWNePbh9BIUamKKQcp/BoUL3
         j6d38BnIW78ZVvmoZyfJRkyEUSx54DYaqiCAIoHGQnUcoIKUtezLvaIJFa0aXhLTyeoC
         OI+Q==
X-Gm-Message-State: AOJu0YyXl7tVaDT2c8ZT2zU4dP8Tmjafr8L+nYvIp4PbZHSRuYMM9fSZ
	OGpkIF09PMC3hiUSDCg0nHAMUTNyyebpDwhsYJ3yfmxVS61e/IbCokhbDYh3FUo=
X-Gm-Gg: ASbGncsOjy67JWFrGntMNc82XuxMnZgQQzgdHo+m2pEkRACv1tn1qsj2AzNStry/vKF
	3xOzfyo3oCg3X4WiJ2GDJACfUwQRz/McocP1HM0PWoAwA5CgCo6JXFSOe7gR+hwuA0Zy8Tg6Jxt
	6hxRFDDHoff9CFqYQKBerGl6yy0+pbeENV3x0b5hXH0MzlVf+K0OdNf/bmwogZw8Xe/PxwNTBvs
	XPosq9eJYjPRN86D00qwC0XILo2P0jG0yrFvWii+MFhytUCMRIEnYjcI2IENVvwIT0E5YoRT4F/
	NJVEfygoMBw5HsA17Qv0lbn6Cb34w0Bn34c9
X-Google-Smtp-Source: AGHT+IFw7DOF2AlpkNGRt5nKYLzCwHXDlYJ9rI13bHT9B8yZEwsvGPw15V0L62f7x6TiXP73rO1Krw==
X-Received: by 2002:a92:c26d:0:b0:3d2:a637:d622 with SMTP id e9e14a558f8ab-3d42b8c1c5bmr71442235ab.12.1741217109024;
        Wed, 05 Mar 2025 15:25:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df3ea9sm17360173.27.2025.03.05.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:25:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
 vgoyal@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20250227120645.812815-1-yukuai1@huaweicloud.com>
References: <20250227120645.812815-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix lower bps rate by
 throtl_trim_slice()
Message-Id: <174121710777.165456.10255728984898278903.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 16:25:07 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 27 Feb 2025 20:06:45 +0800, Yu Kuai wrote:
> The bio submission time may be a few jiffies more than the expected
> waiting time, due to 'extra_bytes' can't be divided in
> tg_within_bps_limit(), and also due to timer wakeup delay.
> In this case, adjust slice_start to jiffies will discard the extra wait time,
> causing lower rate than expected.
> 
> Current in-tree code already covers deviation by rounddown(), but turns
> out it is not enough, because jiffies - slice_start can be a multiple of
> throtl_slice.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix lower bps rate by throtl_trim_slice()
      commit: 29cb955934302a5da525db6b327c795572538426

Best regards,
-- 
Jens Axboe




