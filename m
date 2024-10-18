Return-Path: <cgroups+bounces-5162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060199A4044
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 15:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BB81C247F8
	for <lists+cgroups@lfdr.de>; Fri, 18 Oct 2024 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3671D043D;
	Fri, 18 Oct 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fjvuVCet"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B617C9E9
	for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258939; cv=none; b=WqoxYOJTTufBxllvs7aHsToTmdocnFRaqOaOYmmm4lgcEuz3A2W0T2Zhw1vCQYqwnVhRML9Ph+1MKRDxiMlOhvB36/60sUXTYX7BEfPJDtWIgILpRByDUpvfizcQUcxRdZPs98heN2ltUwqresqALT2ghSEgdWbKoqmtwjHvtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258939; c=relaxed/simple;
	bh=xBePZnsK3Nudyza72rvI8w1t5GSr3TU0LqaYiARoEDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maMUdVU2nGlaT+uQbtyEjo0rTLCqTIf4/6sy4RKjnE+UR7ipOSInAYeCUmT6zgABfX2e1eXl7xpm1IYNj4D3C+XxTRyqUDzUHJUSK428ye8lkQKger2vwv3LH6b2GwCJud5BtQx53/GneMqEoX6gdelje6x+nHlmOAN1xqmnb7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fjvuVCet; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99fa009adcso107966066b.0
        for <cgroups@vger.kernel.org>; Fri, 18 Oct 2024 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729258935; x=1729863735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZa7Ue1oIcLGAigjL4zuYAAZ2xEAi56JLa+QFpctN6s=;
        b=fjvuVCettQKqxe9GMf0pUA6JCkFbEiOELajjTNBCmfQn39l7s7uB4tCrKYVLnEHH/m
         JwIFA8dpeJ/bYVR1YUUJpceVNyC6+Qtj091mAG4ehgxf6jJ11J50N/+WvMdLh8aBqZ75
         3BDC+zOWlSKPTDm52pvxKs5006kI2Z9YWcaUTH9uwAle20qw2um5fM5gFCtSUNqQtWzX
         t7FsfVBjaKtqSft6nnI1Odv/5s/iUCPh+3Zon98Owr5ZVGMfqH+PQlWMyYYSzS4wqQWk
         CrF8GVsXC9amz6nsXuUCaRn/9jpES60b0BORtzBc6M4q4xhAXo0b4L71oUZwK/Wh9P/i
         LTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258935; x=1729863735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZa7Ue1oIcLGAigjL4zuYAAZ2xEAi56JLa+QFpctN6s=;
        b=MDFvqBo/ma9JNHHFZMZ5mq5mjrbC6RWWx+Y4+9f2sg1jOkXzd+9UnjgOOAPekFsYYj
         MBKGerl1/CFhfZ/7CLTzOV4543+34xjhI8o4AXvUextNuSUbcHvvFR7As8vMyJda3/Wc
         yIFlGl1Bjr3CyU5aLVIVkJaRvHuWHwCfbtyNxXaPQ81u+Sm/2B6db8wvMi4S8/0usBFo
         DxPj/6YR5vAKGUp32bhpsikEswU3hot38as/RatSfM3DBh0LMxnc55KFqiJ2jW3xLOJ4
         wb97KlAWfQLa3aX6Gtt11CEQjLPEf9YA9RDQKI9EQrng37QQAyJFF2zZ1+tfjh/gtmXW
         tgAA==
X-Forwarded-Encrypted: i=1; AJvYcCXqG6tUDKUNzwI29QQQtcVGc4yE/rusnuL/cu0yNH3w9OKEHoEpJw64WNrjL2F3AG1rz18mGOYA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mKlEb5R6rQYBPyI9qeFuCZzhWuqoH+Ms9YmHwKYbA3eNXs1i
	3LuJRFGZ5ZBGKfSYkoB3D079EY7KhwP8iowe9U3VOrPXP5Z/oaW86bUuFPc64a0=
X-Google-Smtp-Source: AGHT+IG6Fxgb4NHCkIX3/dnlPvjFLsVzKH6Jek9DA+hqFWFwOWxceGjaQg5r7AgnL5NBc1jgnzfu1g==
X-Received: by 2002:a05:6402:274d:b0:5c7:1f16:78e3 with SMTP id 4fb4d7f45d1cf-5ca0ae81acbmr2408464a12.22.1729258934653;
        Fri, 18 Oct 2024 06:42:14 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ca0b0fec43sm751287a12.91.2024.10.18.06.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:42:14 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:42:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, nphamcs@gmail.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lnyng@meta.com
Subject: Re: [PATCH 0/1] memcg/hugetlb: Adding hugeTLB counters to memory
 controller
Message-ID: <ZxJltegdzUYGiMfR@tiehlicka>
References: <20241017160438.3893293-1-joshua.hahnjy@gmail.com>
 <ZxI0cBwXIuVUmElU@tiehlicka>
 <20241018123122.GB71939@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018123122.GB71939@cmpxchg.org>

On Fri 18-10-24 08:31:22, Johannes Weiner wrote:
> On Fri, Oct 18, 2024 at 12:12:00PM +0200, Michal Hocko wrote:
> > On Thu 17-10-24 09:04:37, Joshua Hahn wrote:
> > > HugeTLB usage is a metric that can provide utility for monitors hoping
> > > to get more insight into the memory usage patterns in cgroups. It also
> > > helps identify if large folios are being distributed efficiently across
> > > workloads, so that tasks that can take most advantage of reduced TLB
> > > misses are prioritized.
> > > 
> > > While cgroupv2's hugeTLB controller does report this value, some users
> > > who wish to track hugeTLB usage might not want to take on the additional
> > > overhead or the features of the controller just to use the metric.
> > > This patch introduces hugeTLB usage in the memcg stats, mirroring the
> > > value in the hugeTLB controller and offering a more fine-grained
> > > cgroup-level breakdown of the value in /proc/meminfo.
> > 
> > This seems really confusing because memcg controller is not responsible
> > for the hugetlb memory. Could you be more specific why enabling hugetlb
> > controller is not really desirable when the actual per-group tracking is
> > needed?
> 
> We have competition over memory, but not specifically over hugetlb.
> 
> The maximum hugetlb footprint of jobs is known in advance, and we
> configure hugetlb_cma= accordingly. There are no static boot time
> hugetlb reservations, and there is no opportunistic use of hugetlb
> from jobs or other parts of the system. So we don't need control over
> the hugetlb pool, and no limit enforcement on hugetlb specifically.
> 
> However, memory overall is overcommitted between job and system
> management. If the main job is using hugetlb, we need that to show up
> in memory.current and be taken into account for memory.high and
> memory.low enforcement. It's the old memory fungibility argument: if
> you use hugetlb, it should reduce the budget for cache/anon.
> 
> Nhat's recent patch to charge hugetlb to memcg accomplishes that.
> 
> However, we now have potentially a sizable portion of memory in
> memory.current that doesn't show up in memory.stat. Joshua's patch
> addresses that, so userspace can understand its memory footprint.
> 
> I hope that makes sense.

Looking at 8cba9576df60 ("hugetlb: memcg: account hugetlb-backed memory
in memory controller") describes this limitation

      * Hugetlb pages utilized while this option is not selected will not
        be tracked by the memory controller (even if cgroup v2 is remounted
        later on).

and it would be great to have an explanation why the lack of tracking
has proven problematic. Also the above doesn't really explain why those
who care cannot really enabled hugetlb controller to gain the
consumption information.

Also what happens if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is disabled.
Should we report potentially misleading data?
-- 
Michal Hocko
SUSE Labs

