Return-Path: <cgroups+bounces-6272-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29DFA1B9B5
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 16:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82E91886724
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469B15A84E;
	Fri, 24 Jan 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Bz/pUqP7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D1156676
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734071; cv=none; b=eBbgSlyrPFI6s1QPnOc7ScbPkJCJJPUx4Hc6IaBk8Mkb9eVLUyn/GWcAX8OUgwgEkgtqk0HOVD7rKs013LVo0qHrYnZ5wloTNP5UQggwVZcUIkQJqYFHnCiUFp0SJa0ywVvUkBtMByEkAcdBch/AlmlTPl47T38ynj4mUan/Z9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734071; c=relaxed/simple;
	bh=qxridkHxaY97JQm3SeHc/9g4JU7IA7islWSnMI7J1+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDyjkK0RRc7Da2xjrlVKKcXjWWreXmhVpOn2bLrtejs4/+o2zSWXTXVSmJKxhLd27hGrKSsybmjcTzslT3kPGh8/ToEgdKDhqk8+h5xpT8NUT2KV8PIzj4/fKaMSycIhUdcc/5285z6NX/ObdQoW55rZ0ytBjYo6z8HT8T9PaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Bz/pUqP7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e8814842so236546685a.0
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737734066; x=1738338866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jaO5J1OLleA0s2cJXfqZOWGHbYpMpsF93JnDLodR8mk=;
        b=Bz/pUqP7PpkO+XA/K1NdBjAmG3zenV9T+5PIwRnF9+1UHTFGJbXxElHcNa5+d9sIr9
         1c6Pl6aMiyE830EXCnBu8J9zhTyOYXhWhRMMXP0i+BFreT6Nq3VeV/AKP1uj0Nh8QAFf
         tuKBKvsImN0VNozoF8egGEJZM66825J6T5eUYwp9ro4PTtzF9afgJxF0QMV1iSz9TRB1
         c19Qu57bRR/3tMDdqXvYqkq83QI5ICGauILXs1E0fnCPRi9b60MBpayyC1epNLypXYBB
         kjofTiyrg7cQ7mJGXeEJXQ+2PM1NBiGITY9X2f/kYYMrz0qX78FEhId7Tt6CzjHzQTpw
         B95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734066; x=1738338866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaO5J1OLleA0s2cJXfqZOWGHbYpMpsF93JnDLodR8mk=;
        b=e3QEb8Wm4uOeXsS3PucpEHHoCQyJ64Y7VO0QDsNZ52BsCE8f/4Kj1yT3fpMoczIvCZ
         0LLzvULuCZqZJZmiYlboukvnJATgl4XeZQdEkXobDwQauY/agYDJGWFBjMsLw6ey9nMt
         nPxl/ov/iAhKD/6ghK4XmzSdPuUc6Kd6hCPka4lYM3PcNw9ppVHLQzM2XQ9+Cdl4NLPw
         sljJ+XQGAtGFEdEQlW4iP+qo8a+Rk98DqgoDmcofEF1BKPIWqvLg2vSpAiF9NfTq9x6a
         ITbMmWsHPqPU/oKbKFhKMdGCKjTsUqk0MshpDb9iy+BsX0pBH+rq1lYx1P3BrKfyfXSP
         z1+g==
X-Forwarded-Encrypted: i=1; AJvYcCVmQnTX8fk9pM/FcvTtxlKOC/OOujh00iZLO/b9ZsTsBGEoxikbRbB/TmtmBNKdxNBkPv77cXf2@vger.kernel.org
X-Gm-Message-State: AOJu0YweszegA2YgfFbjjaQw2CR1qFdy/PFySXz4IYW2hsva7MYq0dC5
	ls/sqlya/f8gJNJU1LHDHELFUlG72jBwPpSyETEDg+M+Owg8GMOB8ifZ++S9iio=
X-Gm-Gg: ASbGnctv6/Ds9F3SvNBD1tk0lmnO3y9+bMnZymmVTVt64m+pmZWc6QGAR/xA4SCmQ5w
	40Qtaj1bHnfV2mPXyD6veryXCytYh7GRiMIbGrX9cCM+G4W8GfYCOgUEM7GHx5jClaJpFIml8O5
	a0S8d7C4usub/aUms2j/YSMosGLq+CeGS49+AXumxfw4IMlY/cMTsExUthi31MnPGelhK3jmHQ3
	ZgEgehojYiIzxKJ1iIgVEJPwXSGa6WyqfeoO9eUdxeYB1jd3SqmmJbaSqsw8Vx6bYm/dOoW8MVt
	HU8=
X-Google-Smtp-Source: AGHT+IF7MEA53OVqDa9yY3jpDkbRjQbEp6o5hVbXuPIzBO08qcAzX4X3mShK2xIPJXxXgBs5Mq02Uw==
X-Received: by 2002:a05:620a:29c1:b0:7b6:e8c3:4b60 with SMTP id af79cd13be357-7be632385c7mr4427127285a.28.1737734066003;
        Fri, 24 Jan 2025 07:54:26 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7be9ae7ec0asm105917285a.12.2025.01.24.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:54:25 -0800 (PST)
Date: Fri, 24 Jan 2025 10:54:20 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
Message-ID: <20250124155420.GA1222@cmpxchg.org>
References: <20250124054132.45643-1-hannes@cmpxchg.org>
 <a90b33c3-7ea3-5375-3fcd-c97cc13c9964@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90b33c3-7ea3-5375-3fcd-c97cc13c9964@google.com>

On Thu, Jan 23, 2025 at 10:53:04PM -0800, Hugh Dickins wrote:
> On Fri, 24 Jan 2025, Johannes Weiner wrote:
> 
> > The interweaving of two entirely different swap accounting strategies
> > has been one of the more confusing parts of the memcg code. Split out
> > the v1 code to clarify the implementation and a handful of callsites,
> > and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> > 
> >    text	  data	   bss	   dec	   hex	filename
> >   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
> >   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I'm not really looking at this, but want to chime in that I found the
> memcg1 swap stuff in mm/memcontrol.c, not in mm/memcontrol-v1.c, very
> misleading when I was doing the folio_unqueue_deferred_split() business:
> so, without looking into the details of it, strongly approve of the
> direction you're taking here - thank you.

Thanks, I'm glad to hear that!

> But thought you could go even further, given that
> static inline bool do_memsw_account(void)
> {
> 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> }
> 
> I thought that amounted to do_memsw_account iff memcg_v1;
> but I never did grasp cgroup_subsys_on_dfl very well,
> so ignore me if I'm making no sense to you.

Yes, technically we should be able to move all the code guarded by
this check to v1 proper in some form.

[ It's a runtime check for whether the memory controller is attached
  to a cgroup1 or a cgroup2 mount. You can still mount the v1
  controller when !CONFIG_MEMCG_V1, but in that case it won't have any
  memory control files, so whether we update the memsw counter or not,
  the results of it won't be visible. ]

But memcg1_swapout()/swapin() are special in that they are completely
separate, v1-specific memcg entry points. The same is not true for the
other occurrences:

- mem_cgroup_margin():
- mem_cgroup_get_max():

	The v1 part is about half the function in both cases. We could
	split that out into a v1 subfunction, but IMO at a relatively
	high cost to the readability of the v1 control flow.

- drain_stock:
- try_charge_memcg:
- uncharge_batch:
- mem_cgroup_replace_folio:
- __mem_cgroup_try_charge_swap:
- __mem_cgroup_uncharge_swap:
- mem_cgroup_get_nr_swap_pages:
- mem_cgroup_swap_full:

	The majority of the code applies to v2 or both versions, and
	the v1 checks either cause an early return or guard the update
	to the memsw page_counter.

	So not much to farm out code-wise. And the test uses a static
	branch, so not much overhead to be cut either.

