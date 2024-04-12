Return-Path: <cgroups+bounces-2448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DB8A34AF
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7271C2282F
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DA14D44D;
	Fri, 12 Apr 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3TMWLHd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE614B08C;
	Fri, 12 Apr 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943022; cv=none; b=TCi6WjngNeXSHWPi24fEAd0AaDMJvwao5b2BR69hmobSswvZEEv1eSNx1n+HgT8ZjKOtMpNX5vBBx8ufPt4wnRWmSn7+f3srrzwdzUcBF5MY5euhs2bbVVVwlPM9C1XNvPIFLol5taeuANFfqRnMHn2iS9ofJFfIQbWzbG3SXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943022; c=relaxed/simple;
	bh=3qJ7GhB7zga96XAHaSCPJZvl5n9zOw5sVXvClxshX7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpUQUyCqTiYADpP3AUmQTc/g1yvdWL/pNdT3HnqfMHOUEOiCbCI6ZSA4kOjtJdy5Qn1VikgIWCl2iC44DHGClZcgn1pJNK2HJSyvxr6k/jqWuGWIZMvk/hPCCk6TbGh1U8dV2vjxn/Vx0X3IpG+hWzh8vRVxxzxxEgR2yIbP89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3TMWLHd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so835159a12.1;
        Fri, 12 Apr 2024 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712943020; x=1713547820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HvIZ4yZMepG+cf7hgtKWjOqNNehIy9rYBxOFPB9Ngs=;
        b=K3TMWLHdSDKvB6VO2pv3KOET7c6UAMKCL14GDAfhlASun5ZP3nm89ujzVIq9ZXZR2Q
         RZQEoeXjvOsMzrdGX2oyQDu8VODPdiIotPaNZhPV/ZianruoxiHIdDLmLrnttPgBjc6+
         DdrDbOskr3zcNPymUIi0sZXBIBVlVloiYNbmwRKNcale4fy6aDsebPpAu0lz53BxivhH
         KQfnRJOzKy0KVrqIOAgQe/Tw7PNskIi+ubfTn8n0lH5CzwSmsCuQQcz8itS41eSCdI6M
         qKoXpJAE1hphFaaYCsZ8Zp1GHvjaTnoAC3/EsawDXZczPT2on7/kpgL6FeFtFQIWMKs3
         GShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943020; x=1713547820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HvIZ4yZMepG+cf7hgtKWjOqNNehIy9rYBxOFPB9Ngs=;
        b=iHj838AH/LsXIGzv6/FbZrMfu84Rz1e8+tx3+SJ92Ttvc8mohZtBvRPSoXTgk+Ja82
         lMQoeOWrcczJes2xqE5ZZNdlORIutcyb22fIZCZIAbZwzmg/i9zMIOKsRYeAyOWRhX8h
         XBkjaDx3sQtNSsGuKrdzrAPGU71ofBENUW3GiaJfBOEHhAi8k2m9W7mibUusKIPVQom8
         egfrxSlTkddTmHlMQneHvkT+OHFAlREctTWMFFCITNHbjxULRFzF7MGv3Vnq2OUuJseg
         5Ggo1wHGS7J0RVXHEadmETUE0ayMX3xOsAoHuA6b2IrSHfiy1ufgcsqUiKdGhdbGpE1W
         JE0g==
X-Forwarded-Encrypted: i=1; AJvYcCU/EKndAdAYOKYHPZpR8Okb/7uwpSAkObTQEH7gOazk6u8S2giw6BBRq/RpmuwuDHr2bmYePwodim8Mt3OSt7xltmDQDPkkOvaJd8xz4O+tkU8/ZD5h/vcSTkyau7J2Mg0KkF2VxJzwTPKhFW10vyklhdxZ4QwcpKVrpY6H6f3gC5Z2
X-Gm-Message-State: AOJu0YzC7r2PAx8EJ842EKHBMDEieFyCG9jEQC0Gx1d3ginPD4DpH+lj
	+rNI8ezD45MiCjyDn61YRvwfOZvKWQZqOOmq3aAjzijZYTVjwqdu
X-Google-Smtp-Source: AGHT+IFOQoE69f87zpD6YQnq234Mfpz5JzC0OB8EMW5zXOYwpclZRKZ6e8Pe0OO53ph+5XZzIgFyYQ==
X-Received: by 2002:a17:90a:fa08:b0:2a4:7df8:bd71 with SMTP id cm8-20020a17090afa0800b002a47df8bd71mr3093948pjb.13.1712943020326;
        Fri, 12 Apr 2024 10:30:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a6d0200b002a5290ad3d4sm3322636pjj.3.2024.04.12.10.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:30:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Apr 2024 07:30:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, yukuai3@huawei.com, qde@naccy.de,
	zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 1/6] blk-throttle: remove
 CONFIG_BLK_DEV_THROTTLING_LOW
Message-ID: <ZhlvqqtSo_Aw2Hjo@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406080059.2248314-2-yukuai1@huaweicloud.com>

On Sat, Apr 06, 2024 at 04:00:54PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> One the one hand, it's marked EXPERIMENTAL since 2017, and looks like
> there are no users since then, and no testers and no developers, it's
> just not active at all.
> 
> On the other hand, even if the config is disabled, there are still many
> fields in throtl_grp and throtl_data and many functions that are only
> used for throtl low.
> 
> At last, currently blk-throtl is initialized during disk initialization,
> and destroyed during disk removal, and it exposes many functions to be
> called directly from block layer. Hence I'm planning to optimize
> blk-throtl and finially support building it as kernel module. Remove
> throtl low will make the work much easier.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

I haven't seen any usage but let's see if anyone complains.

Thanks.

-- 
tejun

