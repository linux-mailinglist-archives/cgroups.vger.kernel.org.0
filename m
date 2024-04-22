Return-Path: <cgroups+bounces-2650-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7468AD35E
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 19:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4671F2240C
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C8153BEC;
	Mon, 22 Apr 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHi8xcaa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418A146A6A;
	Mon, 22 Apr 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807582; cv=none; b=bjEjr2OtdheX3M143wXbr9yeF3bVP6RBzRmQuxPZ/FfxcQJ/R1xlBBB5gYTSgSOolaBDAiFyUJSUK2O0n1yiFo9oS1qHCdVcS1ZawU3hZyZ5Xmu7MbI7tr6w9Vl0gZ9ogeAWY1vV8ZuzBmbkVEiXb87SEgmzR5pEoUO4jkhyMtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807582; c=relaxed/simple;
	bh=pbO9enzFWQcbWpVyNcMF39gz0D5Bx4UfTAmhBYARJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVEGdeKzGwF6E1K+n06c4PfOYtiQV6hVGHWphD6BdOEpSCX6tIHSjWy5Cdr1Ff8JXRhZz5PpIQF7448+bMMVe8keJd5X55f26wMt74IYcuWaHyIw6ywuHAIbj7Ux1nj6ZWYM1vq90HSxZOfEl8XDeipJwybrHuWQbei5gi2JDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHi8xcaa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6effe9c852eso3905841b3a.3;
        Mon, 22 Apr 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713807580; x=1714412380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxuAZhKShuQ4A9YR+YcBtY1x9WESatpl4z3NLeFgqH4=;
        b=XHi8xcaazFbK28Qx0DNcZCiMjfhI536Zd1aCMaC7d59E7o8UMey087s/1lLDSF5PVu
         ROTNEG3KW/m8lJQTZyDz9zdzvfsDqorDvMJOPuwSiS9zifRxxn5JYTQunv5SvYii6nzA
         P2Kt1tXxOxNJMYHor3QDKMj5vMc5KVQiWugcbn+Ca4xyLvep9rwpD/w4IFxf7PDEyt1X
         a4LJudRvCDlqL7mlOipyz29P/M5Il5p7EYs24lrAOFFp+kK/RUKnIeAMHTEiO2rzu6tn
         CNKiSn1iFchkkjn/hPeUTksiUmpn+1WDuQPPiCE7KzY1sIm/Z/6sWHsolBiD6x7nSHVs
         p/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713807580; x=1714412380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxuAZhKShuQ4A9YR+YcBtY1x9WESatpl4z3NLeFgqH4=;
        b=pP9myBQab2TFLH0gZquJGBlmn8itbaDxxZsZ+0aM/zjMXze1T9moeH+iabUKaMXpaH
         1IStTj1dC55+ExZhOVrnlcvdNhDqw+z9nmVaF5v/saBetktMWjB3t6lkpppNxoXaBq4e
         7Fem13K36loFCUOwU1whlyyBJzMbBpU5XAtgKkcMnq8kSDxVi9iNvArr0NOUdSXiph+j
         vfGUCLM1EnudYf28x/8P0q/VvNeMA62lZj4NVIo4eUKs63atze1gzG0lx1dCWIznXpJY
         +lUu+gcBHdYMzZstP73pLX6ygjeUDGMnYiXqAi30+jOpE0APYDCOHsJUbsWWUL2Sy0nW
         4aFw==
X-Forwarded-Encrypted: i=1; AJvYcCVSCsPnzx8w8ZDBqHC1m8qRHaFOYOagvnNRI/bd31gMX8e4JLuTXGBzTBRHVCyyPRX6wnPQJGMemNr/6N0vFm4zsvI0RRP4Ru+LzU0U4QLsjMuKoiLPl59bzaeVUjZXA1W/SeKVCSqn+1g2EDB8rn47S7KuVoffRm3u2ikdUE3J1Ysk
X-Gm-Message-State: AOJu0Yx2ymI4toKFa0lGQ48MdS4BCgg8XcCxvti4haor54tOxcnq51F+
	P/tozlIS4QlKJAxiFYaWoUxQyM1iDh+c4HjrOKtszWuZdTBVCLeB
X-Google-Smtp-Source: AGHT+IEvptDlvv43YylrzaDynUVlS/RC6xKVrkMEyyn0e/g7Y7VPkYnsR2eiZpB4ehXEwzA6+Ln4kg==
X-Received: by 2002:a05:6a00:4b50:b0:6e8:f57d:f1ec with SMTP id kr16-20020a056a004b5000b006e8f57df1ecmr14462049pfb.17.1713807579805;
        Mon, 22 Apr 2024 10:39:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id t8-20020a056a0021c800b006ecffb316ccsm8053439pfj.202.2024.04.22.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 10:39:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 07:39:37 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: =?utf-8?B?5ZGo5rOw5a6H?= <zhoutaiyu@kuaishou.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
Message-ID: <Ziag2TL_BqmTRK5D@slm.duckdns.org>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
 <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
 <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
 <fbf135e8-de16-8eb4-9ade-1b979a335e33@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbf135e8-de16-8eb4-9ade-1b979a335e33@huaweicloud.com>

Hello, Yu Kuai.

On Mon, Apr 22, 2024 at 11:47:41AM +0800, Yu Kuai wrote:
> Hi!
> 
> 在 2024/04/22 11:33, 周泰宇 写道:
> > What I want to do here was to set an easy to reach value to BPS_LIMIT (10M/s in this example) and an unable to reach value to IOPS_LIMIT (100000 in this example).
> > 
> > 
> > Under this setting, the iostat shows that the bps is far less than 10M/s and sometimes is far larger than 10M/s.
> 
> Yes, I know this behaviour, and this is because blk-throttle works
> before IO split, and io stats is accounting bps for rq-based disk after
> IO split, if you using Q2C for bps you'll see that bps is stable as
> limit.
>
> Hi, Tejun！
> 
> Do you think this *phenomenon* need to be fixed? If so, I don't see a
> easy way other than throttle bio after *IO split*. Perhaps ohter than
> bio merge case, this can be another motivation to move blk-throttle to
> rq_qos_throttle().

Yeah, blk-throtl is sitting too early in the pipeline to easily track how
the bios actually get issued. However, given that it's been available for
bio-based drivers for a really long time, I don't think it'd be a good idea
to move it, so iops limit is always going to be a bit unreliable w.r.t. what
actually get issued to the device. So, IMHO, if the oddity is just about how
IOs are counted, I don't think it's a critical problem on its own.

Thanks.

-- 
tejun

