Return-Path: <cgroups+bounces-4901-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961397B7C3
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2024 08:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5371C2182E
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2024 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B24158521;
	Wed, 18 Sep 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lN4/S6z7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD534C81
	for <cgroups@vger.kernel.org>; Wed, 18 Sep 2024 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640207; cv=none; b=L3Nk6M8n0OnS447rlgE7mD1TxuQ2oGxnIl6NI+ZLLyMdKPtFJl+iYMDVNNv8JibLTIx6/3Ck4wU92QB4HYtyf78ma7cVT0Q9d9iBDaiygv2T8f3QBB6I6S082vGrDBvPmoRTIjvNa+7+uNUv5iGgE+mgneRl5nHQpg5j97uat0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640207; c=relaxed/simple;
	bh=h1x8IJe7lN71i2zcyIYHpbVMlL8euNj1bt8GoLm/poc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSeb55eePdMBgygkUWw6wYMDt27xe1uNWZp9AJXtc6462BdnEWlEtwfD1IVkCPdkpzzwJVqup+a78YVWRIOFAPQJo4mB2Q7AIU1LQaXbVXKLSwW7KZdaZ+/+IGtimdM7JcAqLxwgtYsWMCZCDwCQY0bePEsOD7laY2CO9RNcQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lN4/S6z7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso63124625e9.2
        for <cgroups@vger.kernel.org>; Tue, 17 Sep 2024 23:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726640203; x=1727245003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIPhQLcvTE4j+71hp94TpiU+POERqSJhs24nbUaj6GI=;
        b=lN4/S6z7mQaK5vKh8F0fZmMOk4JaEwrDg4Omu4frLz9GvDPu7IMYiGPEJ5bPQna6+x
         CDxUFpuVxy6vJxpZcXFW223jat3nFVyADDoEwA1hr+A7mnPi9b1oSuCJCicFlghsCLn1
         H1wgc0GbRfw59taNgl9saqQMaXd6eDdvuwB2+5fgzkVkc5hFL0HOQNAxaR95J8ZPv7pu
         LHD4YWNgwN4cezYLGN5Bha29o4AWwedPH4fORVkoZt4/DaTNpYASsubOqapz5zq0z6RO
         HJhir+X6/gJWNBGAU3HyBJOh0jeudh+t7AjaM7xYBewuEWu8vy7hNSc0SqyGKh8gDvqu
         jRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726640203; x=1727245003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIPhQLcvTE4j+71hp94TpiU+POERqSJhs24nbUaj6GI=;
        b=LWTy4YE2EUR5SjzRY22rmceWPtALfqrSsn/Y2Gcf6gP0bnrDE5NRnDPyD7Ys8WOtbM
         IO3YZBFF901bs3Q4Lb53JtJz5xV063TNrusnmrhOa1GNOZdVECEhODsk9R8ne5sqgCDu
         4fwkQux6GHUe5NQG2L2girY3Vqr3DZl7gL7vMfbn5aNQHeMW4VB7ntKbg4FlASm92IUE
         s/JAuIc2eq4al50muLeEXkgB1uA4nQqSaomoZB8UNGUW7RmCmwMWZ/9UBfUfnerTUWbU
         PqwxJvIAoyBqKHwAuM2pEaxNxS8662McNle395s53XFm2zbkD7fHgyqjLTy8rhUQAnDg
         WOMA==
X-Forwarded-Encrypted: i=1; AJvYcCXFmB3urrp8jW79dMtJY/VKt6ik765sL61+IDn+EA9moE7sWPlUwiM818xv7HgYp2rlCWAmUlBc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqf7R8jGF6FZiQ4rXE8K60lU/913buRQvLvKe/6HWnvsc20sd3
	XruuieZFpM4yoCPrIIGKJryz0klKSuAnILt/aA0GyhGSp14hccKsZ+1iELsTHJQ=
X-Google-Smtp-Source: AGHT+IF482qm71OBg3dA9iPtz3GXklywXbZ8iO2oGy5tKPfIAb/pGMdrJk3Kh+CMA8pz8uQTeQT01Q==
X-Received: by 2002:adf:9c09:0:b0:374:c3a2:2b5e with SMTP id ffacd0b85a97d-378c2d5b1cbmr10327577f8f.37.1726640203319;
        Tue, 17 Sep 2024 23:16:43 -0700 (PDT)
Received: from [192.168.0.216] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78044easm11411043f8f.91.2024.09.17.23.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 23:16:42 -0700 (PDT)
Message-ID: <5237b4c0-973f-44cc-a6ee-08302871fd19@kernel.dk>
Date: Wed, 18 Sep 2024 00:16:41 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/sqpoll: do not allow pinning outside of
 cpuset
To: "Lai, Yi" <yi1.lai@linux.intel.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com,
 florian.bezdeka@siemens.com, stable@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, pengfei.xu@intel.com, yi1.lai@intel.com
References: <20240909150036.55921-1-felix.moessbauer@siemens.com>
 <ZupPb3OH3tnM2ARj@ly-workstation>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZupPb3OH3tnM2ARj@ly-workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/24 9:56 PM, Lai, Yi wrote:
> Hi Felix Moessbauer,
> 
> Greetings!
> 
> I used Syzkaller and found that there is KASAN: use-after-free Read in io_sq_offload_create in Linux-next tree - next-20240916.
> 
> After bisection and the first bad commit is:
> "
> f011c9cf04c0 io_uring/sqpoll: do not allow pinning outside of cpuset
> "

This is known and fixed:

https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/io_uring&id=a09c17240bdf2e9fa6d0591afa9448b59785f7d4

-- 
Jens Axboe

