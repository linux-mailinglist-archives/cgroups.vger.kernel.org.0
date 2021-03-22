Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2C23449E6
	for <lists+cgroups@lfdr.de>; Mon, 22 Mar 2021 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhCVPxv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Mar 2021 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhCVPxp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Mar 2021 11:53:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0D1C061756
        for <cgroups@vger.kernel.org>; Mon, 22 Mar 2021 08:53:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x14so11027239qki.10
        for <cgroups@vger.kernel.org>; Mon, 22 Mar 2021 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E5pR4bhxZETSxTpVA3uMOpN6g18ZTkn19HmQ/Nnh+4o=;
        b=EHV7q9LwYDxGRVPpLfLVmAGUPg55im2cpNJ3+h7ZlJ1Ip9KZXSuVb095YaAk3LoOe/
         TgStUPZvFQicUOGPKSakFK2kCfiXea14bbW2LFqTMzJHAQ699cVZK8BAkp+LNTaytRUn
         Xp4dYojRqHJtOPYC1Y+13U+2/rglDmFPvm8uzwDef0JIWnPky/yXvAcfWJVfTw1hGDwY
         QkFU8zUYaLJLXnZzSQddyAL1Lp/z6sVM4sS/u2Utm0nw571hVtcoCo3bbORJzj5JccAO
         05Tbf0Ttjbba+BA460+lrwKiAcZ1gqEgq2hUl1t2MsaiTHwbFZ74Gz6I60bixo9cDDrQ
         GvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E5pR4bhxZETSxTpVA3uMOpN6g18ZTkn19HmQ/Nnh+4o=;
        b=X+JTJxiIUgy2AzVA2sbMWVfKOZO3dUKZcpfiC2myEdxDgJJ4kCvaUZXV+90jPZR+V6
         Xk0zTD7/Zcjm0m+hz+gshLNWx+cnAMNgFqF5DUHf8mxlaVK2pNjLVooAbo+oudsxuNPu
         62laE8G93vaElNnGN1FrGvnqaW3SBYjK7DosBP2pyLo5Dp4urAdR7mPkmjEG/uZCJkzX
         etWrRYkvSeWSI38cog5r70mUJQyRxZOMO1zsMU0rxxvWW6wpzEy2SyX4oiKmcyIoelPN
         GwKkDnKcNywHhwaEUToKSV5XcSN2jv27rCWfNIuFmTY+Rt/19VgmQxmEcr8ApRPd+5Im
         7v1g==
X-Gm-Message-State: AOAM531whgli0Kxl5dnCSASbNjCGuG8rwwJ2ZS+VDtOnF4sR865dT8Yd
        WOhk1EdarnEiVchWgy/vR3NABg==
X-Google-Smtp-Source: ABdhPJwOPDa0VeHX2SUaYbWSspS6E9g6n6b7KiPDGxc8+VLv8EfhQeQgWB9cMaa8ljeevDtYUcNFKA==
X-Received: by 2002:a37:94f:: with SMTP id 76mr760874qkj.222.1616428423644;
        Mon, 22 Mar 2021 08:53:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b54e])
        by smtp.gmail.com with ESMTPSA id m3sm10989585qkk.15.2021.03.22.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:53:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:53:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcontrol: deprecate swapaccounting=0 mode
Message-ID: <YFi9hVQM9maWyhWv@cmpxchg.org>
References: <20210319054944.50048-1-hannes@cmpxchg.org>
 <20210319054944.50048-2-hannes@cmpxchg.org>
 <alpine.LSU.2.11.2103191633350.1043@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103191633350.1043@eggly.anvils>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 05:37:05PM -0700, Hugh Dickins wrote:
> On Fri, 19 Mar 2021, Johannes Weiner wrote:
> 
> > The swapaccounting= commandline option already does very little
> > today. To close a trivial containment failure case, the swap ownership
> > tracking part of the swap controller has recently become mandatory
> > (see commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> > integral part of memory control") for details), which makes up the
> > majority of the work during swapout, swapin, and the swap slot map.
> > 
> > The only thing left under this flag is the page_counter operations and
> > the visibility of the swap control files in the first place, which are
> > rather meager savings. There also aren't many scenarios, if any, where
> > controlling the memory of a cgroup while allowing it unlimited access
> > to a global swap space is a workable resource isolation stragegy.
> > 
> > On the other hand, there have been several bugs and confusion around
> > the many possible swap controller states (cgroup1 vs cgroup2 behavior,
> > memory accounting without swap accounting, memcg runtime disabled).
> > 
> > This puts the maintenance overhead of retaining the toggle above its
> > practical benefits. Deprecate it.
> > 
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> This crashes, and needs a fix: see below (plus some nits).
> 
> But it's a very welcome cleanup: just getting rid of all those
> !cgroup_memory_noswap double negatives is a relief in itself.
> 
> It does suggest eliminating CONFIG_MEMCG_SWAP altogether (just
> using #ifdef CONFIG_SWAP instead, in those parts of CONFIG_MEMCG code);
> but you're right that's a separate cleanup, and not nearly so worthwhile
> as this one (I notice CONFIG_MEMCG_SWAP in some of the arch defconfigs,
> and don't know whether whoever removes CONFIG_MEMCG_SWAP would be
> obligated to remove those too).

2d1c498072de ("mm: memcontrol: make swap tracking an integral part of
memory control") made it invisible to the user already, I only kept
the symbol for convenience in the Makefile:

obj-$(CONFIG_MEMCG_SWAP) += swap_cgroup.o

But I guess we could replace it with

ifdef CONFIG_SWAP
obj-$(CONFIG_MEMCG) += swap_cgroup.c
endif

and I agree, everywhere else it's currently used would be nicer
without it. I'll send a separate patch.

> > @@ -99,7 +92,11 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
> >  /* Whether legacy memory+swap accounting is active */
> >  static bool do_memsw_account(void)
> >  {
> > -	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap;
> > +	/* cgroup2 doesn't do mem+swap accounting */
> > +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +		return false;
> > +
> > +	return true;
> 
> Nit: I'm not fond of the "if (boolean()) return true; else return false;"
> codestyle, and would prefer the straightforward
> 
> 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> 
> but you've chosen otherwise, so, okay.

I prefer a series of branches if a single expression becomes unwieldy,
and individual conditions deserve their own comments.

But it's indeed pretty silly in this case, I'll make it a single line.

> > @@ -7124,7 +7121,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
> >  {
> >  	long nr_swap_pages = get_nr_swap_pages();
> >  
> > -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> 
> That needs to check mem_cgroup_disabled() where it used to check
> cgroup_memory_noswap.  The convolutions are confusing (which is
> precisely why this is such a welcome cleanup), but without a
> mem_cgroup_disabled() (or NULL memcg) check there, the
> cgroup_disable=memory case oopses on NULLish pointer dereference
> when mem_cgroup_get_nr_swap_pages() is called from get_scan_count().
> 
> (This little function has been repeatedly troublesome that way.)

Sigh, yes, this will hopefully be the last instance of this bug...

Thanks for catching that, I'll fix it up.

> > @@ -7141,7 +7138,7 @@ bool mem_cgroup_swap_full(struct page *page)
> >  
> >  	if (vm_swap_full())
> >  		return true;
> > -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> 
> Would it now be better to say "if (do_memsw_account())" there?

Yes, I'll change that.

> Or would it be better to eliminate do_memsw_account() altogether,
> and just use !cgroup_subsys_on_dfl(memory_cgrp_subsys) throughout?

I have found do_memsw_account() useful in the past to find those
related pieces. The details elude me know but I remember searching for
this string often during the recent work in this area.

> (Though I don't find "cgroup_subsys_on_dfl" very informative.)

This routinely bothers me as well, but I have not been able to come up
with a good replacement.

memcg_v1()? memcg_legacy_mode()? memory_cgroup_in_bytes()?

> > @@ -7291,27 +7287,13 @@ static struct cftype memsw_files[] = {
> >  	{ },	/* terminate */
> >  };
> >  
> > -/*
> > - * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
> > - * instead of a core_initcall(), this could mean cgroup_memory_noswap still
> > - * remains set to false even when memcg is disabled via "cgroup_disable=memory"
> > - * boot parameter. This may result in premature OOPS inside
> > - * mem_cgroup_get_nr_swap_pages() function in corner cases.
> > - */
> >  static int __init mem_cgroup_swap_init(void)
> >  {
> > -	/* No memory control -> no swap control */
> > -	if (mem_cgroup_disabled())
> > -		cgroup_memory_noswap = true;
> > -
> > -	if (cgroup_memory_noswap)
> > -		return 0;
> > -
> 
> Shakeel suggested "if (mem_cgroup_disabled()) return 0;" here,
> and that was the first thing I tried when I got the crash.

It really isn't obviously safe. I'll put it back in.
