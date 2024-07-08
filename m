Return-Path: <cgroups+bounces-3567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D592A6BC
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F30D1C2169C
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18897145325;
	Mon,  8 Jul 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="URFzPikS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3213D278
	for <cgroups@vger.kernel.org>; Mon,  8 Jul 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454647; cv=none; b=YVHru5/C1fCdKRQoK0w/9tyGzuoodoYgP+4K6tx9DDOyXraDE/PW5ya11teTuKrXdpFRElpL2fr/wakCT+F4hq/h+PQ67EMXrU/nLAX0r1zbqkzVvOpbRLxwpv6wkY9LTwkAr3JaCwtAEhEwQhK01YqZU9uFxksvRDll7i7/LJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454647; c=relaxed/simple;
	bh=mdC7qLfFrgQ8uCM8Z3hnLHwWYWU+viqJ55STx1SEfkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBafNsyvUHuTMoVGa23rGBasP4HHrMwZsoj21dzLaupPzA16FeY0T9nREuXhiKv85s/qM8eqR7F0Uo+PiXVVOEd6nnicerv7/MDTnKEQeSisv4KXI06pbnHB58qTLDQ8ofxe2QFh1oblXCbuELJKNRWoOJDmpLp8HzC6FeyYmHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=URFzPikS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so5529107a12.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jul 2024 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720454642; x=1721059442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/Nh20E7oiLudtA0FS0qlhX52m/6CLHQileRH4RyzWg=;
        b=URFzPikS5R1yeCqZMErFXW/dv/vk5FWrGul9qMVs7Jr0BuCLIB9HriDK1miOiVWpAg
         JIoWn7MuxSDrNTV5cEoIFuXaOsBKhEhfISYQyQY/uWY4lJG5SMF8qrrIpqVGHus7VTjM
         LcfnvAt8waFAoCc6AUpf6EpEEWravCksyZnG0x0EhlXlo1XUOJ0xghWu+7weqjXvF1VJ
         b9iWQnNJNQZ4BfqqOTjlLha3s6zgvWQDSMzmlpzpmNSRIg2+6d0EgLfCT0FlnvwxeVau
         DLWu0V9R/D8VZi5tWqqqPFgzVMJYHSXvw2sLErViqljUKQ0a5ABVaHPtqKQQ0L6NkDJ+
         va9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454642; x=1721059442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/Nh20E7oiLudtA0FS0qlhX52m/6CLHQileRH4RyzWg=;
        b=qa9A+PYws+odviiIh7ElxDvwOGSgZIG1nvxCc2bgWREVkBNzM4XVLf4RCV3zLmVxAp
         pVvgvOZAbSUsVDZp8Unc+nqbLtmrleii0y8w8vy9ikoNB7bxFyv6ow+FlhZ+TDQWPSJ5
         sFQd+6xPqcvOG8ItmTJMc4yG5S0uBHlm/ePuKPjK0m3PYkBzMXMPukUMt9wLdIUBUWLa
         h3i3KnrGd40cBABBhDxYbNGszPvgnFz/e3MaQM40t9UXkdl78gJmx88Jc+g81xKBoywJ
         LdUNtLSqgfYtpK9XLmObddTyr2m7HHnib1ccmFYdohDcKAS1D4VSaGcw6mTHMk4X0XuY
         nWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdChCDQLLeYBWNik4pRH4luwCRsHflux3ZD3nXd3WaFkFmv5HkSuguggH1kj2qrV1FSmfR37JthXwp89YlV3Nutn6jzMMXyw==
X-Gm-Message-State: AOJu0YxIyCKMiP+BplsqMWkM2SrrRZWdAchHGmnFHDWJK2L8mG8zSrBe
	ubBcSVPzQCEvAzwZ0o8DsEgiDXXrkK3IZR+QXETrLMsvSeiei9rUb70vo0MP9hY=
X-Google-Smtp-Source: AGHT+IHVj7SwwtCWqG3e/oHvkJvsv6UgptYMNeGBr1++0ZWNEn4UoPauERNteSei9ct3YpU1AQM7fQ==
X-Received: by 2002:a05:6402:2353:b0:57c:c166:ba6 with SMTP id 4fb4d7f45d1cf-594bb58015cmr35695a12.19.1720454641745;
        Mon, 08 Jul 2024 09:04:01 -0700 (PDT)
Received: from localhost (109-81-92-226.rct.o2.cz. [109.81.92.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc3efb13sm7321a12.42.2024.07.08.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:04:01 -0700 (PDT)
Date: Mon, 8 Jul 2024 18:04:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak to
 v2
Message-ID: <ZowN8FvmdiEGr_rC@tiehlicka>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
 <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
 <6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
 <20240703133804.1d8ddf90f738a7d546399b3b@linux-foundation.org>
 <ZovgDfGFJdc6lVN3@tiehlicka>
 <5ce7be39-ac42-98c9-65fc-589385b8f65b@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce7be39-ac42-98c9-65fc-589385b8f65b@huawei.com>

On Mon 08-07-24 21:40:39, xiujianfeng wrote:
> 
> 
> On 2024/7/8 20:48, Michal Hocko wrote:
> > On Wed 03-07-24 13:38:04, Andrew Morton wrote:
> >> On Wed, 3 Jul 2024 10:45:56 +0800 xiujianfeng <xiujianfeng@huawei.com> wrote:
> >>
> >>>
> >>>
> >>> On 2024/7/3 9:58, Andrew Morton wrote:
> >>>> On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> >>>>
> >>>>> Introduce peak and rsvd.peak to v2 to show the historical maximum
> >>>>> usage of resources, as in some scenarios it is necessary to configure
> >>>>> the value of max/rsvd.max based on the peak usage of resources.
> >>>>
> >>>> "in some scenarios it is necessary" is not a strong statement.  It
> >>>> would be helpful to fully describe these scenarios so that others can
> >>>> better understand the value of this change.
> >>>>
> >>>
> >>> Hi Andrew,
> >>>
> >>> Is the following description acceptable for you?
> >>>
> >>>
> >>> Since HugeTLB doesn't support page reclaim, enforcing the limit at
> >>> page fault time implies that, the application will get SIGBUS signal
> >>> if it tries to fault in HugeTLB pages beyond its limit. Therefore the
> >>> application needs to know exactly how many HugeTLB pages it uses before
> >>> hand, and the sysadmin needs to make sure that there are enough
> >>> available on the machine for all the users to avoid processes getting
> >>> SIGBUS.
> > 
> > yes, this is pretty much a definition of hugetlb.
> > 
> >>> When running some open-source software, it may not be possible to know
> >>> the exact amount of hugetlb it consumes, so cannot correctly configure
> >>> the max value. If there is a peak metric, we can run the open-source
> >>> software first and then configure the max based on the peak value.
> > 
> > I would push back on this. Hugetlb workloads pretty much require to know
> > the number of hugetlb pages ahead of time. Because you need to
> > preallocate them for the global hugetlb pool. What I am really missing
> > in the above justification is an explanation of how come you know how to
> > configure the global pool but you do not know that for a particular
> > cgroup. How exactly do you configure the global pool then?
> 
> Yes, in this scenario, it's indeed challenging to determine the
> appropriate size for the global pool. Therefore, a feasible approach is
> to initially configure a larger value. Once the software is running
> within the container successfully, the maximum value for the container
> and the size of the system's global pool can be determined based on the
> peak value, otherwise, increase the size of the global pool and try
> again. so I believe the peak metric is useful for this scenario.

This sounds really backwards to me. Not that I care much about peak
value itself. It is not really anything disruptive to add nor maintain
but this approach to configuring the system just feels completely wrong.
You shouldn't be really using hugetlb cgroup controller if you do not
have a very specific idea about expected and therefore allowed hugetlb
pool consumption.

-- 
Michal Hocko
SUSE Labs

