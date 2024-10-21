Return-Path: <cgroups+bounces-5169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDA9A5C51
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F4D282DEC
	for <lists+cgroups@lfdr.de>; Mon, 21 Oct 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798C1D150E;
	Mon, 21 Oct 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WMP29ypG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45E1F5FA
	for <cgroups@vger.kernel.org>; Mon, 21 Oct 2024 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494922; cv=none; b=VH22skbrsGJbpaM6A2Gc+Ze+CewQpXnYEw6R8w9yXSGu0mkRDKC7JfGP95jZjl1C6lGG7szwwgkKsT/D8ExEXknjLjt+3PTVk42JRsQdsBVkWLuvga8Qs/6fZOr2+Q9rf21bcLvBYtttw/E3xE9z385NrM95sgwhgzMVPiPp/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494922; c=relaxed/simple;
	bh=sL8/i6Di5DcQQ9guTOuVoJfEK/9WK5BriuxDQuYcHww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piATrMYnpCMPLrEXtSqpKc3MI466guMEKI6a9RcdPmAzzDfIo4TtGjzyFgfrYrFGpd8DoZd5VvzLCM47xsyDK3c29E8GP8jr6rPq1PrPnnQEMHnt9CM841Zg8nt0a2QocTsMDg+Et60hdk/yRo9wUUf7EWLiwjIv+fVZTF/9f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WMP29ypG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e63c8678so4845720e87.0
        for <cgroups@vger.kernel.org>; Mon, 21 Oct 2024 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729494916; x=1730099716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O66gPrArBhu1Lkf2k94VS51buUsSbDnUdJxUilOqKoU=;
        b=WMP29ypG/qGF998oKaduFfCCWqK7yqGwZpt/VcKPMSIMD/Qp6lYHcIt7in5ddrZxi6
         JO9L7J/5f4UQ2lbpCkYdks2k3DeKSAIfoJlTKg/Wt6TDyoXBvUg6DQZpKRVy2KOFDdow
         FyqoAkFmeTqFlcx0JH3bolwTLcKRlVgrMcTtPd63gObp0Rf3UwPgqyxWlw7rxrqgm9V4
         yQ7PROmmC+Qp37bqpdo+Xqr5ztvn5YUlTaF651FlPIQjCeQwc7KdcJL5bVcWhWj1pwv3
         0zKAituZ/bTKt+VKtTAE/LFNfq9K7EolxfsYNbYdMWE2OMZ2amwc0MF44cQ+lG1DSOR7
         9MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729494916; x=1730099716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O66gPrArBhu1Lkf2k94VS51buUsSbDnUdJxUilOqKoU=;
        b=ut9Q/7ibI7yPATdwNXK5Mk0lgxErG3iBiMIJG4B+Ja92aLa8dEDKeDHIoAakIbREpZ
         AxoxyN2DfNLEpP3jT2aMFbddk5wsXu5DR/sfkH6CIWpZS6j0mHzkDNaoQ2U5ew8Lj5CX
         vUe0Mx0+4gdNjiqQMbMdhGZftydXunCiepixG9FVDcgGmyvKwFtYBFI43cXMf36kk/sG
         3C1w/GLR486E8lXMM9uaTXLMu3N03e9Q4UBd7MqOAgba9pkRCCa2sx+VnmLsDuOZIl0R
         Gzc2BaZOF02G5dmjp5gj/cDFOHvG0QqfEBrUGhhpUi5pfENwycSZTa7tuRGWL+9yHYe+
         fN6g==
X-Forwarded-Encrypted: i=1; AJvYcCUCkfKKembMPUaV0jIlfI7SIwrBlkjItMzX0cdQ+U7+fxIl7GGKvvxSjuRiJ0bwGeSr7m9iyFqC@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbt3Fn7PYjB9/LoS7YNH1kUCkI1x4e0gr0Q5K/eFLWXzZusZo
	YuvUOJxXgclGQwVH0V06C/pBS4yrUBlAy2obwp8kgcY5ULqlFLkEhzGzgzkfFts=
X-Google-Smtp-Source: AGHT+IETEFXR8/cKXRm1qK4kLTWa+k3b+HsgghOppLGOl3d3G+/sF4TWEhiXzLustHLoNu+OGM33Cw==
X-Received: by 2002:a05:6512:39cd:b0:539:8ade:2d0 with SMTP id 2adb3069b0e04-53a155092a2mr4776049e87.51.1729494916059;
        Mon, 21 Oct 2024 00:15:16 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d641esm169229666b.3.2024.10.21.00.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:15:15 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:15:14 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <ZxX_gvuo8hhPlzvb@tiehlicka>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
 <20241018123122.GB71939@cmpxchg.org>
 <ZxJltegdzUYGiMfR@tiehlicka>
 <il346o3nahawquum3t5rzcuuntkdpyahidpm2ctmdibj3td7pm@2aqirlm5hrdh>
 <CAN+CAwOHE_J3yO=uMjAGamNKHFc7WXETDutvU=uWzNv5d33zYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+CAwOHE_J3yO=uMjAGamNKHFc7WXETDutvU=uWzNv5d33zYg@mail.gmail.com>

On Fri 18-10-24 14:38:48, Joshua Hahn wrote:
> On Fri, Oct 18, 2024 at 2:11 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > On Fri, Oct 18, 2024 at 03:42:13PM GMT, Michal Hocko wrote:
[...]
> > > and it would be great to have an explanation why the lack of tracking
> > > has proven problematic. Also the above doesn't really explain why those
> > > who care cannot really enabled hugetlb controller to gain the
> > > consumption information.
> >
> > Let me give my take on this. The reason is the ease and convenience to
> > see what is happening when I see unexpectedly large memory.current
> > value. Logically I would look at memory.stat to make sense of it.
> > Without this I have to remember that the user might have hugetlb memcg
> > accounting option enabled and they are use hugetlb cgroup to find the
> > answer. If they have not enabled hugetlb cgroup then I am in dark.

Yes, I thought that this was an acceptable limitation of the accounting.
If that is not the case then it is really preferable to mention reasons
in the changelog. The reasoning was that hugetlb controller which would
be a natural source of that information is not really great because of
an overhead which hasn't really been evaluated - hence my questioning.

[...]

> Aside from consistency between the two files, we can see benefits in
> observability. There are many reasons userspace might be intersted in
> understanding the hugeTLB footprint of cgroups. To name a few, system
> administrators might want to verify that hugeTLB usage is distributed as
> expected across tasks: i.e. memory-intensive tasks are using more hugeTLB
> pages than tasks that don't consume a lot of memory, or is seen to fault
> frequently. Note that this is separate from wanting to inspect the
> distribution for limiting purposes (in that case, it makes sense to use
> the controller)

Please add this information into the changelog.

> 2. Why can't you enable the hugeTLB controller, if tracking is so important?
> 
> By turning on the hugeTLB controller, we gain all of the observability
> that I mentioned above; users can just check the respective hugetlb files.
> However, the discrepancy between memory.stat and memory.current is still
> there. When I check memory.current, I expect to be able to explain the usage
> by looking at memory.stat and trying to understand the breakdown, not by going
> into the various hugetlb controller files to check how/if the memory is
> accounted for.

Well, as mentioned in the previous response this has been an acceptable
limitation of the hugetlb accounting. It is fair to reconsider this
based on existing experience but that should be a part of the changelog.

> But even if we are okay with this, I think it might be overkill to
> enable the hugeTLB controller for the convenience of being able to inspect
> the hugeTLB usage for cgroups. This is especially true in workloads where
> we can predict what usage patterns will be like, and we do not need to enforce
> specific limits on hugeTLB usage.

I am sorry but I do not understand the overkill part of the argument.
Is there any runtime or configuration cost that is visible?

> 3. What if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled?
> 
> This is a great point. The way the patch is currently implemented, it
> should still do the accounting to memory.stat, even if
> CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled. This would give us the reverse
> problem where hugeTLB usage that is reported in the statistics are no longer
> accounted for in current...

Exactly! And this is a problem.

> I think it makes sense to show hugeTLB statistics in memory.stat only if
> hugeTLB is accounted for in memory.current as well (i.e. check if
> CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is enabled before doing the accounting,
> or move the accounting from hugeTLB alloc/free --> hugeTLB charge/uncharge,
> which should only happen if hugeTLBs are accounted for in memory.current).
> 
> What do you think?

yes, not only shown but also accounted only if the feature is enabled
because we do not want to introduce any (even tiny) overhead for feature
that is not enabled.

TL;DR
1) you need to make the stats accounting aligned with the existing
   charge accounting.
2) make the stat visible only when feature is enabled
3) work more on the justification - i.e. changelog part and give us a
   better insight why a) hugetlb cgroup is seen is a bad choice and b) why
   the original limitation hasn't proven good since the feature was
   introduced.

Makes sense?
-- 
Michal Hocko
SUSE Labs

