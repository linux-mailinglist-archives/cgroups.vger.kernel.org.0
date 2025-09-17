Return-Path: <cgroups+bounces-10205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404DB7F580
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B19188EF96
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51047275B1F;
	Wed, 17 Sep 2025 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rW2uJWgm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F829ACD1
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115676; cv=none; b=hsjXyiQC4HD5JCtcxC1UDUQ2asWBpbtDaJHB5YXrZPxtILw3pAKgo3+bPHfx7HZyVuTwJ6DXk+HY7MywqsVnSNN3aiOtP+omd29qwxYle8HU7SXjbFqL6VFoOF09d1IrZMqQQGj9mRpvAzwLVyv5W7cIU2wX+2OJy0A/u/dvoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115676; c=relaxed/simple;
	bh=M62rwCb3WpopXPBEr/TcsBpZz+0Rl4/4oOOAHyk9RDw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=drOlU6HSNMdMRljYctm5/BMlkRqx2DfloXaTRgTbWuNgIRWNMd7MspuvjzA+mx1/ymlsZ0b1Ns7OLK9dL9uqZe+t38Ko0X/qN4XyrARKKGLTN2d6RyUXDvQRvGlS5fdzNONuhT0fkWCSsRLUyCHMHL5QYjEVs1seSEXUvk4K4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rW2uJWgm; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-423fbb45255so18113835ab.3
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758115673; x=1758720473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7GZOzuObGtag5EoNFyxDUa3UQRVufAOUXVJL/ng3BY=;
        b=rW2uJWgm9RkT7sU7lJ6WTwko6WKw1X0irnKRN7chSnATbsi2S1SQQ2Lq/Y0pJ4EkP+
         MWwUaIe6JYCqrT4qZsrweJPfQbEzJqGBGFinwY23VhEUDFJNfWXn/gVmqVEcTyZ4dN6Q
         aLDvg7B2uZENuEt0oZ5S+OSQ7+hqcg6MmuOXh58sVWyNVIhfGrJJ0J+vICVp4dqw72kk
         urZWwoCWL58g+qidpl4CNb873QGKs1TsOTfjNiH0yI73QWDfqk0tBqsAgRag/jGocquH
         +rjEu/Gs8hrkoz19o6mgE5ajOYCLitLhXdmj6VxU22NgkEeC9m5mubtL6DAZz474okRY
         tKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115673; x=1758720473;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7GZOzuObGtag5EoNFyxDUa3UQRVufAOUXVJL/ng3BY=;
        b=qHH2w8DzGECS6PpRpKPiS5YuxUQD6eMiarTlXO9neEYS1RQlt5OklonTwTqcEOHDvS
         ie/JQRYbKFgqORPa7IVwBou37VaY80uiWMx5teBU97C5RWM+/X4w8bpQTbiBmTDA0b7/
         /26NmeYaYhajGEiBRGegFYA/d7xWAUkG0JLQo/qcunPO0SieQlJqvz1Fdx61u6r15NwY
         1mNh1OY8criqWeZ8pv2ClIyjC1VOO7pKeQBd8ihko987w35o9ytsXCjtclHlLk5kY2XP
         frEE24pemqHOOxi/PqNkMFDAHjmLa7Ln6uZIJua3WDvzR/F67ZgcCTzXNHc7ZPOZcDR4
         WIMA==
X-Gm-Message-State: AOJu0Yz3vFwtWPhUZrFHELzeCRaqqNWDBOT4S9jiKtBPqc/+/I4UxoZV
	FiZ/R03RQFXnQajWYkNnOIhMR3XS6SqSM3isLUjV5cQMCGDeOUnwnizXNNCUjaaLXbw=
X-Gm-Gg: ASbGncuz8W9ohLoQNBg+9Q459c1jlVu2NTSb5DprZIS02o4IietcaD5xbNMhzbf6Gm1
	HrL23b+axlWjPkQH7D+LkGFpytDYEArU6rkbPPWdV3awHemt2WNAbzzL4R/Aub91dtQpF8ZkYvb
	s0aWGHOR3ujVcP8T2m3oDPC8/iCF699qQh1RyyXYMdS6uvWHahsRI2lLjxuY6s0ucOUV5Dt59DS
	r1q9yuJqjP647m2+OFBUH5lMqEUon32jElYnKedUHg52LRVw0OSwnkyT9IzPXlA3HmoS54UZQYB
	brqTCJX6genXNFKHtZsJwrrSoQbWKiKgAgADtqz/YFxqDeJGf/Y0ue8b72ZQ/3k1Xru7L8DQ5bN
	fa/kSm2Ojj+MmUYwVquW8lx/g
X-Google-Smtp-Source: AGHT+IFn/OaWveSG0AWC87YfzNDHOK3c2Lkvjfj2pXX0BCsm8FFh9R1/lMuhrdFs8NTkuH8A65JvwA==
X-Received: by 2002:a05:6e02:1a6f:b0:410:cae9:a083 with SMTP id e9e14a558f8ab-4241a4b998dmr29796965ab.3.1758115673240;
        Wed, 17 Sep 2025 06:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3062bc3sm7216527173.47.2025.09.17.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:27:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yi.zhang@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
 hanguangjiang@lixiang.com, liangjie@lixiang.com, yukuai3@huawei.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250917075539.62003-1-yukuai1@huaweicloud.com>
References: <20250917075539.62003-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-throttle: fix throtl_data leak during disk
 release
Message-Id: <175811567232.367585.6804225420415541020.b4-ty@kernel.dk>
Date: Wed, 17 Sep 2025 07:27:52 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 17 Sep 2025 15:55:39 +0800, Yu Kuai wrote:
> Tightening the throttle activation check in blk_throtl_activated() to
> require both q->td presence and policy bit set introduced a memory leak
> during disk release:
> 
> blkg_destroy_all() clears the policy bit first during queue deactivation,
> causing subsequent blk_throtl_exit() to skip throtl_data cleanup when
> blk_throtl_activated() fails policy check.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: fix throtl_data leak during disk release
      (no commit info)

Best regards,
-- 
Jens Axboe




