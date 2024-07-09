Return-Path: <cgroups+bounces-3579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD6C92BA9C
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37181C2252D
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50E15ECCC;
	Tue,  9 Jul 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YS0ulNsT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C96176230
	for <cgroups@vger.kernel.org>; Tue,  9 Jul 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530362; cv=none; b=n+/9p7FmMDiZYw4A1S6ntPnZOgzuq63XP2QvgYO/mbT9J3LKHLw0AtvRLPoSq6O0wQGACnF8D9p6aHcrwaCFaUP6b+8HjlXc1Qdvw4AnvTj2KTQBRkOVTScNKa7wHfR7WvCYqytSILbxDtVJ8T8QhKfWq9XLTGRLftt+C8EYk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530362; c=relaxed/simple;
	bh=EQVVYEOR5xlW6+YN0ZoEefcxKajPe32Jfjcy7Zu5DFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3QMHZF1RRWaGJZdN7KHCL5uXrzfV+/5f9VOQMq9WYJCRGiud655lejM6aK4srtg3SXVuUCswOPn6uDRzAme22LoQNwpaSeehNz5f0FLa5uGLpaTs3P6X+WvLlW0Sg8TVZoWtWBSKZqDfkNqPos0nFgWhsxoU6LyRNmXIX8MBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YS0ulNsT; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so62138741fa.3
        for <cgroups@vger.kernel.org>; Tue, 09 Jul 2024 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720530358; x=1721135158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhBjgRzpL9sQaVK76pu/ld0xnGk1Z8E8uhy7X7mxsF4=;
        b=YS0ulNsT2/R1NwZpPciwZ7CjoiZtk3raGzYkVP9+50os0AtSJw1WOFSnFvfyZ5Qld6
         s1aJjSAiE0byD/FgIwXEvEBSo2kdQYZQSCDQi5fY0GxnEb43CFEbB9LcJb9Y6dZUDaAt
         0aoJgWXIAKaDVqCKktKVecBPYbKZQ/7eath+RMOC1M9lqiX6wB0b4TDG6saMe29vAds/
         DrvdQasKG7yphBGBGt/kscrZph5gVoGC1uVQsyerRtxdiFSxwhgxX23kI1cHayY2PWGi
         kAGpzvdVJTHY0xhle4eznt/tsLvXJDXYZgKRq60DQOIBILsCnx3uaTPKAolqgYj2kQJ0
         iNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530358; x=1721135158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhBjgRzpL9sQaVK76pu/ld0xnGk1Z8E8uhy7X7mxsF4=;
        b=R4I9YvsaOur6leEm5nDCxugNJJeIdKD/SHNicwZIBnTQX1zGW63GN2zYWzFc+6QunK
         t48CMu5kliXCW+O7BQECN5COVt1zyUqm5kCnN5mDWecThArPDOwI4HZ7sfjeuLbdP0zt
         jKZ34VjGpOE7N+Ag2FwPRbeq6Rn9kfZelsmdR9XuMpjVIHhqRsWw0hXPRybUZNJtdlwM
         ABVAVBu50O02+Wn+6HeN5C4ZTXbf/U2MxxLQYaouu0hFEYKMpY+y2i+UG4NJ+7ZYDO9v
         JjzrSCfokKyyl3gT7vWFF9nbfEeMkdYwfbRTu3xedGq5JSmP2Mnd4DYKTjLLihI3Z0lp
         CRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWjwRaX9OuFbHhFPppI3exuhVoVMs2+cIA4i66l9EDzptrAfiIjJeeg7nAr0h9KRFMG2pk0Ox7Zq0zhLc/s9Rnj0GQE1CqMg==
X-Gm-Message-State: AOJu0YzOElFzMmTSQdDs/R7JkMO3HBLRtBjJrUEpHnDSxpzlQtVIFNxr
	1918I6z9vF5SPdzCfmNdHc6GWlE9lXIKmbMVcGy5JdIOHNchbpgMEg6QZ1u+fA0=
X-Google-Smtp-Source: AGHT+IHOTh69D3Wwh5wXN48yiquSobzGhHe+Le3Ut78ADxB5tyf8MU7GHpgjRa1MPh1vOGvXyEFoJw==
X-Received: by 2002:a2e:9693:0:b0:2ec:165a:224d with SMTP id 38308e7fff4ca-2eeb3169f03mr20727561fa.38.1720530358111;
        Tue, 09 Jul 2024 06:05:58 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871fe1sm76017166b.223.2024.07.09.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:05:57 -0700 (PDT)
Date: Tue, 9 Jul 2024 15:05:55 +0200
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
Message-ID: <Zo01s6_PjdO9O9Nw@tiehlicka>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
 <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
 <6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
 <20240703133804.1d8ddf90f738a7d546399b3b@linux-foundation.org>
 <ZovgDfGFJdc6lVN3@tiehlicka>
 <5ce7be39-ac42-98c9-65fc-589385b8f65b@huawei.com>
 <ZowN8FvmdiEGr_rC@tiehlicka>
 <a78f241f-9601-1033-0013-b9aa83bdeb9c@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78f241f-9601-1033-0013-b9aa83bdeb9c@huawei.com>

On Tue 09-07-24 20:47:30, xiujianfeng wrote:
> 
> 
> On 2024/7/9 0:04, Michal Hocko wrote:
> > On Mon 08-07-24 21:40:39, xiujianfeng wrote:
> >>
> >>
> >> On 2024/7/8 20:48, Michal Hocko wrote:
> >>> On Wed 03-07-24 13:38:04, Andrew Morton wrote:
> >>>> On Wed, 3 Jul 2024 10:45:56 +0800 xiujianfeng <xiujianfeng@huawei.com> wrote:
> >>>>
> >>>>>
> >>>>>
> >>>>> On 2024/7/3 9:58, Andrew Morton wrote:
> >>>>>> On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> >>>>>>
> >>>>>>> Introduce peak and rsvd.peak to v2 to show the historical maximum
> >>>>>>> usage of resources, as in some scenarios it is necessary to configure
> >>>>>>> the value of max/rsvd.max based on the peak usage of resources.
> >>>>>>
> >>>>>> "in some scenarios it is necessary" is not a strong statement.  It
> >>>>>> would be helpful to fully describe these scenarios so that others can
> >>>>>> better understand the value of this change.
> >>>>>>
> >>>>>
> >>>>> Hi Andrew,
> >>>>>
> >>>>> Is the following description acceptable for you?
> >>>>>
> >>>>>
> >>>>> Since HugeTLB doesn't support page reclaim, enforcing the limit at
> >>>>> page fault time implies that, the application will get SIGBUS signal
> >>>>> if it tries to fault in HugeTLB pages beyond its limit. Therefore the
> >>>>> application needs to know exactly how many HugeTLB pages it uses before
> >>>>> hand, and the sysadmin needs to make sure that there are enough
> >>>>> available on the machine for all the users to avoid processes getting
> >>>>> SIGBUS.
> >>>
> >>> yes, this is pretty much a definition of hugetlb.
> >>>
> >>>>> When running some open-source software, it may not be possible to know
> >>>>> the exact amount of hugetlb it consumes, so cannot correctly configure
> >>>>> the max value. If there is a peak metric, we can run the open-source
> >>>>> software first and then configure the max based on the peak value.
> >>>
> >>> I would push back on this. Hugetlb workloads pretty much require to know
> >>> the number of hugetlb pages ahead of time. Because you need to
> >>> preallocate them for the global hugetlb pool. What I am really missing
> >>> in the above justification is an explanation of how come you know how to
> >>> configure the global pool but you do not know that for a particular
> >>> cgroup. How exactly do you configure the global pool then?
> >>
> >> Yes, in this scenario, it's indeed challenging to determine the
> >> appropriate size for the global pool. Therefore, a feasible approach is
> >> to initially configure a larger value. Once the software is running
> >> within the container successfully, the maximum value for the container
> >> and the size of the system's global pool can be determined based on the
> >> peak value, otherwise, increase the size of the global pool and try
> >> again. so I believe the peak metric is useful for this scenario.
> > 
> > This sounds really backwards to me. Not that I care much about peak
> > value itself. It is not really anything disruptive to add nor maintain
> > but this approach to configuring the system just feels completely wrong.
> > You shouldn't be really using hugetlb cgroup controller if you do not
> > have a very specific idea about expected and therefore allowed hugetlb
> > pool consumption.
> > 
> 
> Thanks for sharing your thoughts.
> 
> Since the peak metric exists in the legacy hugetlb controller, do you
> have any idea what scenario it's used for? I found it was introduced by
> commit abb8206cb077 ("hugetlb/cgroup: add hugetlb cgroup control
> files"), however there is no any description about the scenario.

I do not remember but I suspect this is mimicts other cgroupv1
interfaces.

-- 
Michal Hocko
SUSE Labs

