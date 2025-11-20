Return-Path: <cgroups+bounces-12134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3BEC74A29
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 3046E289AD
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA712FBE17;
	Thu, 20 Nov 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nuiVj335"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B0528136F
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649901; cv=none; b=cF32qdZulo0BnYlRUFudI35jYuqJ/WvKD4eNkpQVLKQ/aQkHRPONogbQdGlUmVTnUKfMSAXBQw1NGTKacB1+sjeaWIBMJwYRL3kECBVAU+yfBoZ+88+KZRo29dhISzjwk2+RJl/TLh1mcf5oI0gB7IUFErRotZVZEyTMGRPkfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649901; c=relaxed/simple;
	bh=ONNkBGi+pAcXAGfOCa4th/uzV5GK3jLbFcpMbgswvGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwmuW/TnAnKhUmIAxTot7GJeX9fnoysDevPYS3tvKi0yByr4qO0yMvymrBQF1StQmP7jbXDSOotF52xtAwTjRTlOsOo5I6nMX3XF7TZG7BUolTaFF8TSOYHWmKscjdFgnF85jMKO6q4rBxN+UVk+oHET13fsJa3c94/c5KhbQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nuiVj335; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-43377ee4825so4871835ab.2
        for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763649896; x=1764254696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIxJYE0wvk3wLqfYeDU58+f9Hu//Bm8wil67l0346m4=;
        b=nuiVj335IoySHCd5luaPE97MZ0Dk4VSukc1ZbgfDl39ep4bvbv8EfLH5YOJy0hY5NH
         /JPwKejoyOxaLVlawIJpej0B7dCREpkK4rVaG7Mw7zwBT01grcKpkrlqgku3FVdrp3iW
         L0w3choL0SRI0FirwVpbvHIaHj/04iCmXxZj39Nt55X/K2kOPDjNwIPk80byDFbBEM3T
         JG3XBK695M3riS7Sa1B8SqRa8hbTWiCvIS8HbwVfUhXh68bUjQRpVgmvO3CH4b8+9pD2
         ftGBkUQITW1bn/iFbuTQzV4bYTOTTTzmZAmr+U2X160XHKMjxK5kaKyYNcB7TrxRFVoW
         xiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763649896; x=1764254696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIxJYE0wvk3wLqfYeDU58+f9Hu//Bm8wil67l0346m4=;
        b=drZaKQdvukyVzOQ8vJWPleO17ek6Ip6/2A4OPQY5r9ae6aVREgrTJrKDnO38gt+xIG
         hZZMTNQsvk4v6GDlcXon3Xxr8M4eSifxMiTD4HWJurVH00YcTtQsUcw0yUC0yXSuGgn4
         IWhCXSHq4fQAQeBOx1xdVc6L+QL2LCDgDpSYwQc3P2uRel29Y+xjrIi8ym0Dps/HX71r
         XeQzMn0Z2Jgs9qkp4WN2D0ID6OTIfcgOm7NwGNNZn0HFsMoVhrmuclJOxc5FTNRwA1KH
         YzyMcAwM7QtPey6CBhoYt0wHDlZSCDgdNHCO64pfR+rZiXeZFAteBTd1Ia8B59Ek2fGY
         ZLHA==
X-Forwarded-Encrypted: i=1; AJvYcCXhqmnyR94rW91tkRyMQV+RoMYDBdWTxHNOyiPv795dI3wg1TJ4Y7nM7bvoOMVUTD2oOEdhSO92@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFb2P4ynUS96OjcRipM+ikArBMqlpOtiDHUCV+QZekT4fzLAm
	twkadR5A+gqe0yF52P6SlSI7yXNUbRXi8ACQJMtupBdcR7CwPDh31RHX5DqTvl18XiQ=
X-Gm-Gg: ASbGncvO/4BwBxw0ZD3QwmYDSJFW+75isCY8GNcM9eKF0OTxVypy9Z1WMVrtops28xl
	2pX6DLdow7JMW23Lh0cndhTiL2eOd7mSrpK+uy9PUp+GQjU8JYw8If7949r8p5Auh5ILOKfDcFV
	UBi4l9Kjkj+bMvN1UxLsiXH/tp9wE2a1AOH5QTI02a6T0hdpGiE2r78J9+fvA81/0qerKnu5162
	rI+UyAs5wx4A7V5/60k3mpo7FAt4V/hsjMAyKPc6dbFg1JdRg6A7QSRoNySWfyPUSmfRw+f6lFq
	WleQTsYCpwiS1TRWG3qF8Var9cldobdvxxEtkQYjOJlKyszQ+C85x234hnViIrZUmKxDi/hKuZK
	g9b7/zA11DamQrRowCji72O0QoVzIa0cUn0mOCo8UW/flIT05sgRYON8YRyKLkX9NT2pGC4Kkpt
	CHbeuaNA==
X-Google-Smtp-Source: AGHT+IGH129qdY0Bs8r1fTwuv2Zd+f3v8A11zGOrfEH1/mLJCq3AZQFHWR1rZfoTVBVyrWsHXJBc/w==
X-Received: by 2002:a05:6e02:3a03:b0:433:7e2f:839d with SMTP id e9e14a558f8ab-435a9074d95mr27932015ab.21.1763649896290;
        Thu, 20 Nov 2025 06:44:56 -0800 (PST)
Received: from [192.168.1.96] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a905e7fasm11606795ab.14.2025.11.20.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:44:55 -0800 (PST)
Message-ID: <32c1c5a1-840c-4faa-91e1-cc9165a7f241@kernel.dk>
Date: Thu, 20 Nov 2025 07:44:54 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/44] block: use min() instead of min_t()
To: david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-efi@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Josef Bacik <josef@toxicpanda.com>,
 Tejun Heo <tj@kernel.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-13-david.laight.linux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251119224140.8616-13-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 3:41 PM, david.laight.linux@gmail.com wrote:
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index d74b13ec8e54..4e0c23e68fac 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -472,7 +472,7 @@ int blk_validate_limits(struct queue_limits *lim)
>  		seg_size = lim->max_segment_size;
>  	else
>  		seg_size = lim->seg_boundary_mask + 1;
> -	lim->min_segment_size = min_t(unsigned int, seg_size, PAGE_SIZE);
> +	lim->min_segment_size = min(seg_size, PAGE_SIZE);
>  
>  	/*
>  	 * We require drivers to at least do logical block aligned I/O, but

This doesn't exist in the 6.19 branch, dropped.

-- 
Jens Axboe

