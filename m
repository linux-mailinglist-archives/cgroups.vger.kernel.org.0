Return-Path: <cgroups+bounces-5165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6959A464F
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8735B21135
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 18:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559AF204097;
	Fri, 18 Oct 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="3ZxYHRCu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57604202F71
	for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277845; cv=none; b=P2taboWcrXuEVN4JQcxWj8qTvwpKDwQQiLcOkHJ7VMPEX4rW0yskTG4Ft7tQYaQbNhB7ESia93vSLCUFs14nFtDcjBuFniLAYkYuygRvkR6/pt9vnnsK0j1ngaOzqSVveQMnoyVegrZoL05lhf0N6Avoa/E7XXM4ZpxAADNVhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277845; c=relaxed/simple;
	bh=LC0THKi60XSf6Rs76nPewkIzh1cFMQWvtnW1iEDcv58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBhfU46oBd5ROEYdzGbdI0w6KfDbg/+AgEJE1T+CROhbcao2FxvpJNeuDsNqjq9wlzXmRiGefkDdPEDjls8Zk901XzR3ly60OPWy/mkypYw1bUz4AU66s4dtuMbjnZwsF1JurHoUW499z0KapNvtaGz/T/fvdgpDkTlnSY8Y5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=3ZxYHRCu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so18571736d6.0
        for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 11:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1729277841; x=1729882641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s4xPE1nr+Xi0Dvh9jf2xWIR8MzeS9sAig5u4V7FCQVk=;
        b=3ZxYHRCuza/lX6kV9XKDHSmESyrsXES7ps6N4UsXgod4yZtwV7U0cpWZLk7dUaYgoQ
         eNFqKsmP80AHaCLruLkZ1YgZdgipgG1WYeFOLlHFAn9QHZxgUUDLAp0lEr/+ybxttmfx
         jGYKD4bwESvabnXxoupu5NzHbhCE4OM6fzHz+qMfHxyMx2JKlsbssuES9GtVsrGxBaM5
         /xaZUYM6LeXyorGmVPX68ZCnZ37ZxOQPVBiQq+lhxEFXNXSM3Gy8l+NKzlaiQ2i2fR57
         iq/q2vY93aPyBx3WVqT1RxVd4Yh+EuJW0dY9MbUgGjo5cdixPTTHUV0Jim4KAt1wZo87
         NN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729277841; x=1729882641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4xPE1nr+Xi0Dvh9jf2xWIR8MzeS9sAig5u4V7FCQVk=;
        b=kR9J3IeejLls8FTB3t6KR1ugn7ZFamLQWDuf+Q9ZBDaiHYaPmPlTUrFmrgZaa8M/nu
         +LdKOGtfOhmwijyvAX/6ITVXGSe9o5cAEmRAFoi7v10FoVaUWwB6+JUHGZ33CinsNZ+w
         j7fnaxC+4A0uAdIJPMDPeU6r3/3OIKC0/fTGQ+bfABUsOZEqWeB0WBhUQHkkDqP8yH+T
         h7IKyO385SHhLW7UpVdFteLOPJgR4CQgREp/lhgbIzKxHJ3+da2EFPzkc0EQhSYbC5ME
         Lw+cR+KSqicnkkPiWNCLK0GVsaQOwiWs3j7LIc1yXvsXaSDYA8jojn7k5CRLM47rm80x
         nzxg==
X-Forwarded-Encrypted: i=1; AJvYcCU5LLWhe+xXfS1Bv1Vk7UQkpH9ZeICi4bNNeX6kfSbSBiOOMIb1oY5RftPQu/mAxfFy7x1af1PL@vger.kernel.org
X-Gm-Message-State: AOJu0YwfeFx/StexPcMvHFcANEylfossz3Z+4ezT6msOxUSUveSKyFp6
	q03sjV7NWaCT38HOmob0u6rxgWNN04r+XeQEINnaTDvjzk+YCz80ozNJ1CRUXtA=
X-Google-Smtp-Source: AGHT+IEuuGSdfEcgR68BP9v0JkgMFSUHwOyBoM4Mf66gDspCSViiSEAWC/C55KbM/GlLKRr9IvX+wA==
X-Received: by 2002:a05:6214:4808:b0:6cc:2ba7:7f7b with SMTP id 6a1803df08f44-6cde1553260mr52975886d6.28.1729277840921;
        Fri, 18 Oct 2024 11:57:20 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122a159sm9406996d6.100.2024.10.18.11.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:57:19 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:57:15 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <20241018185715.GA81612@cmpxchg.org>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
 <20241018123122.GB71939@cmpxchg.org>
 <ZxJltegdzUYGiMfR@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxJltegdzUYGiMfR@tiehlicka>

On Fri, Oct 18, 2024 at 03:42:13PM +0200, Michal Hocko wrote:
> On Fri 18-10-24 08:31:22, Johannes Weiner wrote:
> > On Fri, Oct 18, 2024 at 12:12:00PM +0200, Michal Hocko wrote:
> > > On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> > > > HugeTLB usage is a metric that can provide utility for monitors hoping
> > > > to get more insight into the memory usage patterns in cgroups. It also
> > > > helps identify if large folios are being distributed efficiently across
> > > > workloads, so that tasks that can take most advantage of reduced TLB
> > > > misses are prioritized.
> > > > 
> > > > While cgroupv2's hugeTLB controller does report this value, some users
> > > > who wish to track hugeTLB usage might not want to take on the additional
> > > > overhead or the features of the controller just to use the metric.
> > > > This patch introduces hugeTLB usage in the memcg stats, mirroring the
> > > > value in the hugeTLB controller and offering a more fine-grained
> > > > cgroup-level breakdown of the value in /proc/meminfo.
> > > 
> > > This seems really confusing because memcg controller is not responsible
> > > for the hugetlb memory. Could you be more specific why enabling hugetlb
> > > controller is not really desirable when the actual per-group tracking is
> > > needed?
> > 
> > We have competition over memory, but not specifically over hugetlb.
> > 
> > The maximum hugetlb footprint of jobs is known in advance, and we
> > configure hugetlb_cma= accordingly. There are no static boot time
> > hugetlb reservations, and there is no opportunistic use of hugetlb
> > from jobs or other parts of the system. So we don't need control over
> > the hugetlb pool, and no limit enforcement on hugetlb specifically.
> > 
> > However, memory overall is overcommitted between job and system
> > management. If the main job is using hugetlb, we need that to show up
> > in memory.current and be taken into account for memory.high and
> > memory.low enforcement. It's the old memory fungibility argument: if
> > you use hugetlb, it should reduce the budget for cache/anon.
> > 
> > Nhat's recent patch to charge hugetlb to memcg accomplishes that.
> > 
> > However, we now have potentially a sizable portion of memory in
> > memory.current that doesn't show up in memory.stat. Joshua's patch
> > addresses that, so userspace can understand its memory footprint.
> > 
> > I hope that makes sense.
> 
> Looking at 8cba9576df60 ("hugetlb: memcg: account hugetlb-backed memory
> in memory controller") describes this limitation
> 
>       * Hugetlb pages utilized while this option is not selected will not
>         be tracked by the memory controller (even if cgroup v2 is remounted
>         later on).
> 
> and it would be great to have an explanation why the lack of tracking
> has proven problematic.

Yes, I agree it would be good to outline this in the changelog.

The argument being that memory.stat breaks down the consumers that are
charged to memory.current. hugetlb is (can be) charged, but is not
broken out. This is a significant gap in the memcg stats picture.

> Also the above doesn't really explain why those who care cannot
> really enabled hugetlb controller to gain the consumption
> information.

Well, I have explained why we don't need it at least. Enabling almost
a thousand lines of basically abandoned code, compared to the few
lines in this patch, doesn't strike me as reasonable.

That said, I don't think the hugetlb controller is relevant. With
hugetlb being part of memory.current (for arguments that are already
settled), it needs to be itemized in memory.stat. It's a gap in the
memory controller in any case.

> Also what happens if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled.
> Should we report potentially misleading data?

Good point. The stat item tracking should follow the same rules as
charging, such that memory.current and memory.stat are always in sync.

A stat helper that mirrors the mem_cgroup_hugetlb_try_charge() checks
would make sense to me. E.g. lruvec_stat_mod_hugetlb_folio().

