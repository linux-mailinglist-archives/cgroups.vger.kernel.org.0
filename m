Return-Path: <cgroups+bounces-3757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274779345CA
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 03:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CF21F23D1B
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0E15C9;
	Thu, 18 Jul 2024 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC6md1y0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8799394;
	Thu, 18 Jul 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721266067; cv=none; b=mSUm8QBJLKZdVMeEuBPNgd4Au3sz28GypZH4LzNb8q9XLHIYbO/U02BxsypNF++2+6/aRRSN2cgCrOghtprk99B+uxOvn53hVzqrzNVuCsVTWXW9H7JaM0CW1bsnf02myMuFGofEdWfvlmSRy3tBO8XJmrvdPHtdBabyPyPXwhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721266067; c=relaxed/simple;
	bh=iu6CKfJt3C2PrK2EYYcvUZWys67ejVF77qvWw1WKZbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cge6+8KF4RoKw9cRA73e9iTEBiXcuikLHsBUy9aIro/LoX5n9nkq5NBYkmNgzx0yZXYw21ac7I/RCvibWBRpCr1pCosZr18vwQgxtJqadJobwrDXyZAPrzUU7qThmjspeMjdB0gMck7s5APMDtg8+EcN6BP96N9rMlcpy7x9ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC6md1y0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb4fa1bb34so2187205ad.0;
        Wed, 17 Jul 2024 18:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721266065; x=1721870865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4ozxE+CESJqEyygZCUvpW9+U/UE2rBQc20tR/KurlY=;
        b=IC6md1y0k/bNnmubsBdvUCa3a5yrS2QyBz56YTxmdqn4af+Lh4XWKXIY95Am0wwf6D
         irhppLrweBEsRpp+aPiHYBv3b46ElViUkmv0LsP5BLGofyU9FCCLejzxVRIb48+0KaLp
         X5MPVg4IZ3MRHlp60/yS3fxD1QDVSy9wyyYiXGGUenQ6TLSNSsb8fcoSocPcBn27YgC7
         oR/6QkfmZr3VSGwjyWq5e3hsWDYzOmcAAYxX3hOtipyhyR3Yqt01UZIaSdjMbh/qo9QU
         c33cbgbLAmkiB586zBR6Y1dYJWQUxdBkOPQNzOn1UzasmCWNHNgtGpD1Q59IBYV319b1
         7yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721266065; x=1721870865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4ozxE+CESJqEyygZCUvpW9+U/UE2rBQc20tR/KurlY=;
        b=UedutAjLskGJXOROAC+1YpBFEsamOdKak4NRE4zuM/Fx2sWdXtgM+5kOiHbzG3YZMY
         wgTzCl73Vcgj8bfYxO3zfX22RvBu7ZBZWVLoMYnDh6dsC+uIIw3ETi0xhP47Q1+v5N+O
         IYk9B6hzhtnCzPMR3LWo/B6VOxQddZIvwJCAHTvWWxOCEC7HSFN59LRhXc7uefItc1Jt
         agQnebldL/MXqtfqR49/svh0kRocQHmdIxgk8kOCwljg93cIicCYRiGrbpBg7LOpY6MH
         QIdyVlc5l+rRZdkUR0pTpgEWeeDHXB2yVGz4lO2RHApyWi2sKjn/jOdk6zLsyHYXzhpa
         PnBA==
X-Forwarded-Encrypted: i=1; AJvYcCUYo3duvzmfzhWTdKeOcMTQoW5JhHY78wU4TsxsB3GFcNhxh1MTkb4BsFga/a6u8xcbNX8IpmOK4weUpJu6H64NWr4RcoSvxVm2+A1ch5DAnP54J3uk7GU2EMdY8bHEm+nMIFtf
X-Gm-Message-State: AOJu0YwqwQ+v337ak2EZaGs8ISAk7bHWLiCvIPGy76amlJEGc77Aloye
	gJ96S3seVW2v2J7urY14jH7Pwi46d18nAYE4UYLbU3lkIPwhEanc
X-Google-Smtp-Source: AGHT+IGFzhGd/HPG0T+63S0zeLibabNl6AfaM7YtnEYUXk0y2kUd+9RFKrltbxyfxtzY5ZszEYEhRA==
X-Received: by 2002:a17:902:d511:b0:1fb:8f62:a7bc with SMTP id d9443c01a7336-1fc4e571fdemr32851955ad.52.1721266064946;
        Wed, 17 Jul 2024 18:27:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4656dsm81461375ad.258.2024.07.17.18.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 18:27:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 15:27:43 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Message-ID: <Zphvj1kXK2xcKj7J@slm.duckdns.org>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
 <99af713e187a92f0501482e8344be469f1b3e454.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99af713e187a92f0501482e8344be469f1b3e454.camel@mediatek.com>

Hello,

On Thu, Jul 18, 2024 at 01:21:32AM +0000, Boy Wu (吳勃誼) wrote:
...
> I think this will work, but as I mentioned before, this issue is only
> on 32 bit SMP systems. Replacing u64 sync with spinlock will increase
> overhead on 64 bit systems, because u64 sync does nothing on 64 bit
> systems. However, if it is acceptable, we can proceed with this
> solution.

We can encapsulate the spinlock in some helpers and make them conditional on
32bit. However, the u64_sync -> spinlock conversions in the suggested patch
are all on cold paths, so I doubt it'd be all that noticeable especially
given that the hottest path of them all is already grabbing blkg_stat_lock,
but either way is fine by me.

Thanks.

-- 
tejun

