Return-Path: <cgroups+bounces-1239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F7483DECE
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3011C2350D
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD1E1DFD2;
	Fri, 26 Jan 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iG3pWC+W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69711DA3F
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286862; cv=none; b=IwqV2OP8PIEuGhClkyiaT3gunH/oyzznvIAxwR/i24aZROcT3L31I3VZxIBYhoydTIoLQGyua8LEScjr20OP2AdQJgqok4itGuNfLpiQmr+Y4RUirw6xjEOXM9AkPSdoWbP2tV1HtZlwG1o3X2JSR2e/fG6WvrQxvDqr+X2XJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286862; c=relaxed/simple;
	bh=017GdyE1IE2uKm0Y+x/yCoiXpG39BJE37eyLPVYEpnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lijjQupkUxH9yYRN6TxvEDC0J4zRRm475c4+zrpkyO+z6gfEeadBVs5qJ/E4XqpmYh6keVoX+/K7zaDuONH8NZ5JmLgg8XmMiaRotoSbV0cqSaquuB6FefgVVOCYK8k3fE1Zzvx1SP9fhm6Qb086p10UaWXSlKNNgoDXn8f1s9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=iG3pWC+W; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a7aa96669so4316431cf.3
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 08:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706286858; x=1706891658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKRWQpKoDhVi11EbJncjcZq8dzTJ4ms1gdUVmVL1vMo=;
        b=iG3pWC+W+7NC04JDOnObeYobCnyM9DRLB24VDrbC+Pt70FMUeYFoGYjkHvhAvuRtL+
         IZziTrbWWuL5mnqhEAMPZq/nl+pLNwZubHhGumprMq5CnaGx/19DQKsTQRW5DObEN4YG
         Mh37uC2O1Xo+vgF3mIWIMTVAvp9uN7s45X3rfkA6Cf1Zfu5KhTsZxBzJs6QTLBYI7EZD
         bIkFiXYtuc/geI2CdHRQ5lwlFQGgB7SdqR39Qqi5OwEPSHNfu9l0jUbCaA6ANBusTsfW
         b2Nhhx3VjgRyJ8IrXB3bRu0Dp3BFLRzHKiiJaJ/6kdeYT4vTnyWrqgP32FmS+aD/n/KQ
         qDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706286858; x=1706891658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKRWQpKoDhVi11EbJncjcZq8dzTJ4ms1gdUVmVL1vMo=;
        b=pHlifOk55mKJyME7/CIwxC8t3tfe7mCo2V2qJ7wb9wDC4BcAgCObGuAGLa1rMJZszj
         wALPXBGyiF4rx+/CzVgLl4peVpRQupEWf3DDd8Mx6gszdkaLuQXt2iEKJ57Es7ti8aLO
         RLUwR3fYvguN6VEdBPfg1J+lkcB+brzn2U19m/G80S7VEdtqHhozJOsM/a+yXNG4Nghv
         WFSiio5+klgwhNupqnqDid6b/wzK8C6kkPWyxgxiSyKsp5eHy4OHxiSwBQY8j0rttSOC
         gR71JU7b8HgKcW8fGby4c438+9mVqUYUjsd7gGHWC3ccSH+rXjzyskSW90nOCJogroIX
         iR1g==
X-Gm-Message-State: AOJu0Yzq35HCeGvZO6+hhpy83nKeeQx2xNFp2O7TbcKOUNtQaeYfbHkf
	VZaspr4us/8txUbcurRCzcvGXcFPjqsmKTtKmOzTyEGk/lL50w85pEdQv9o80prHV8RMmmxiUBS
	i
X-Google-Smtp-Source: AGHT+IGUR0dOLRsatsRzJjXg2S4qZHwNs1TSu/FR2bKyi/XH0DHAoB6rSk6mIGDhkpJJg+zzwH+lTA==
X-Received: by 2002:ac8:5710:0:b0:42a:504b:67ac with SMTP id 16-20020ac85710000000b0042a504b67acmr107263qtw.68.1706286858505;
        Fri, 26 Jan 2024 08:34:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id hh10-20020a05622a618a00b00428346b88bfsm640126qtb.65.2024.01.26.08.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 08:34:17 -0800 (PST)
Date: Fri, 26 Jan 2024 11:34:01 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com,
	yuzhao@google.com, yangyifei03@kuaishou.com,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
Message-ID: <20240126163401.GJ1567330@cmpxchg.org>
References: <20240121214413.833776-1-tjmercier@google.com>
 <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com>
 <20240123164819.GB1745986@cmpxchg.org>
 <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:46:23AM -0800, T.J. Mercier wrote:
> In the meantime, instead of a revert how about changing the batch size
> geometrically instead of the SWAP_CLUSTER_MAX constant:
> 
>                 reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -                                       min(nr_to_reclaim -
> nr_reclaimed, SWAP_CLUSTER_MAX),
> +                                       (nr_to_reclaim - nr_reclaimed)/2,
>                                         GFP_KERNEL, reclaim_options);
> 
> I think that should address the overreclaim concern (it was mentioned
> that the upper bound of overreclaim was 2 * request), and this should
> also increase the reclaim rate for root reclaim with MGLRU closer to
> what it was before.

Hahaha. Would /4 work for you?

I genuinely think the idea is worth a shot. /4 would give us a bit
more margin for error, since the bailout/fairness cutoffs have changed
back and forth over time. And it should still give you a reasonable
convergence on MGLRU.

try_to_free_reclaim_pages() already does max(nr_to_reclaim,
SWAP_CLUSTER_MAX) which will avoid the painful final approach loops
the integer division would produce on its own.

Please add a comment mentioning the compromise between the two reclaim
implementations though.

