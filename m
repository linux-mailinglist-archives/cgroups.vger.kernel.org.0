Return-Path: <cgroups+bounces-3728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0989336FB
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F48B20CE6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BE21400A;
	Wed, 17 Jul 2024 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4bTEgSD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEEE2FB6
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197566; cv=none; b=jrshY2tYdAAItcE2qrVpn2dGb5Y+n+fat2PODClxrRk+VKRbS4+BOSTyQYj7REOueOUp+cBiV4poX2ZPHtCrpLImDxPVbW4YZvXCoLTC2ElOfF3NV34lVQ4R4UW8MdWhHdNSp1oW4CbD4nLNOnd244mdhmZGLu+p0UuslNMT06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197566; c=relaxed/simple;
	bh=ByuZeLQzwZ5x3nXl8kE+pf2jxHURXs8b01VJ/XfnZeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz58b/JDRsUxQzVTaBlsfcinGwJFgSxMreWWI4g45gSLFdeQk/yTvbIQkQxSuD+o74tjVgTAFM+UC7bkoiBi5vvHgC0t+VrA4paEt+B57OdHzcLeIvKjLtl19CHihI19oEd6O1s3jjV4HS2bP+xa4Io2qeB7XiJ9weo79r9QUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4bTEgSD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso7648069e87.0
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721197562; x=1721802362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kRZCoDkETaEFOBCewGIFpdrgG+eZN4FZNraXMVegoL0=;
        b=e4bTEgSDEfWn7rENkpLoF+hCc9fKY8oY++rP9JBYSRBR7RxLje7itpWbdi3VSGWjIn
         asaYcjERfn+fP3lnAyyXvTbzvs+etHxKUeSntA4XHTyTX+S9OZeiCBxdT45wnXD2lJ6W
         tS9ccv3uPT2fFP9ZIO5EMwGVcnwKvNO09kxXAXmULeZTzcVB74tfbvBXxemzePDl4BJz
         B1GiEYq3ZU+6305EFZUeX6liW5EpBfbK467EgIPNG5AyrEF5vT3byKYjiAhq2FdHpgyS
         qhxVkO8h1V367NglYzcuxBdJpPtYH4VZBF/AlHvAjvdP+hmS2OIenbbumhhI99Znyl/1
         R8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197562; x=1721802362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRZCoDkETaEFOBCewGIFpdrgG+eZN4FZNraXMVegoL0=;
        b=IECWzRL9GqFAtRDAd8AYao2QagsbfgwUNP8s4TbZOivbKPQfXRE+EhayPlfnh2oh2U
         c/vaPfA4x7xQBx+glKA5DvcYDiERJLUkbn4mlMYmb2XOhjzdQChsidBTtO9igtmVHlup
         vqsyS+z1w94ROmrc1FmBIz0CQS77Pr/b0UcwdmjxoxxiieXa6aKYILbSFaJByyNTK5km
         7btQLHvs+6A6ZoPWnh6x0CW4+3AFk7LSYtA8iY0WXDuJXERw0RnemHqVksqCbrIO8CGy
         NqC1sZCtDvNCcxy8d0oMd69LDkWGLf362cQUM/sKTOJDkddjFvWtibXn9GWTntsNBV1D
         O0+A==
X-Forwarded-Encrypted: i=1; AJvYcCWPayMSd4xoOGC3rJNfOY3DZsJ96rAhhDrWLFK5iiJCFSa1HhhXcw6JZ5qhECmNyRvN+9D3AsbJBDTigZqGoaJ58jxJ/uKDpA==
X-Gm-Message-State: AOJu0YxUbsbHCcB32bwdZhO95xy0Mb2J35FXm2JuNv9r4xCTpmr8/3z3
	dNmrkdB9Qtquhp1EYn7DUm+21nUu98AVBgvta7pvHMZxSA8WKIFFKhdmljoOMY8=
X-Google-Smtp-Source: AGHT+IGDEwk+nZqPqfNzpH3tY2qHsGGwHFWpWnZPOMmrbDmZO3jaXfhbMrl3VS0/+lWJ0Ywpz+aWEA==
X-Received: by 2002:a05:6512:104a:b0:52e:9ec8:a3fd with SMTP id 2adb3069b0e04-52ee542718dmr459428e87.45.1721197561796;
        Tue, 16 Jul 2024 23:26:01 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b4f87sm406498866b.48.2024.07.16.23.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:26:01 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:26:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <Zpdj-DVZ5U5EdvqL@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka>
 <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
 <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>

On Tue 16-07-24 18:06:17, David Finkel wrote:
> On Tue, Jul 16, 2024 at 4:00 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
> > ...
> > > > If we want to allow peak measurement of time periods, I wonder whether we
> > > > could do something similar to pressure triggers - ie. let users register
> > > > watchers so that each user can define their own watch periods. This is more
> > > > involved but more useful and less error-inducing than adding reset to a
> > > > single counter.
> > >
> > > I would rather not get back to that unless we have many more users that
> > > really need that. Absolute value of the memory consumption is a long
> > > living concept that doesn't make much sense most of the time. People
> > > just tend to still use it because it is much simpler to compare two different
> > > values rather than something as dynamic as PSI similar metrics.
> >
> > The initial justification for adding memory.peak was that it's mostly to
> > monitor short lived cgroups. Adding reset would make it used more widely,
> > which isn't necessarily a bad thing and people most likely will find ways to
> > use it creatively. I'm mostly worried that that's going to create a mess
> > down the road. Yeah, so, it's not widely useful now but adding reset makes
> > it more useful and in a way which can potentially paint us into a corner.
> 
> This is a pretty low-overhead feature as-is, but we can reduce it further by
> changing it so instead of resetting the watermark on any non-empty string,
> we reset only on one particular string.
> 
> I'm thinking of something like "global_reset\n", so if we do something like the
> PSI interface later, users can write "fd_local_reset\n", and get that
> nicer behavior.
> 
> This also has the benefit of allowing "echo global_reset >
> /sys/fs/cgroup/.../memory.peak" to do the right thing.
> (better names welcome)

This would be a different behavior than in v1 and therefore confusing
for those who rely on this in v1 already. So I wouldn't overengineer it
and keep the semantic as simple as possible. If we decide to add PSI
triggers they are completely independent on peak value because that is
reclaim based interface which by definition makes peak value very
dubious.
-- 
Michal Hocko
SUSE Labs

