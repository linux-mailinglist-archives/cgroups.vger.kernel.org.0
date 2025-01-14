Return-Path: <cgroups+bounces-6138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9BBA10BDE
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 17:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B0F1881ABB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695C189B8F;
	Tue, 14 Jan 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uKz+nwx/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569C3596E
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871005; cv=none; b=KuFPFxK27qlWBBVMEeIM8qjxEzy7nTkGl1XesQoKWHlixDFsmKT8AbZsTnEAa1H8PfZbTgdvIlf95NBKSsvXd4gPTNBdPyLG/BwqmUJ+eaN0hu1e9e3qKZrvnIyYLS58QSkq8xbRoEjeKubySpblpg1Ofn+7MlI78S+tDlrCw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871005; c=relaxed/simple;
	bh=lqS/A3MjFRS6UUcmxBnNHyNlkBa/4wApPqrANutVOBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaWC3dTf+up6URc2dRRDp0m6Sjn7wJ2E6dEiBJtYfRuvFU7/G33Sc58FT2hIdSrzpxCZVzEP2CRmRLbheqNfX/J5paLjQ5yFGIPPa01YHP+O057aXsO0alWwta9GMSU3SOyLymepYQW+/K51NOBFhk5oB+rGlv/uvCDNh+O/4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uKz+nwx/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e8814842so550129385a.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 08:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1736871001; x=1737475801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCbhAAOfgSy4gG11/slI/9NU/Jb4WeqNzdw5obZWbgE=;
        b=uKz+nwx/G+PH+JxaCLwbBTjvvZKDc+qSDbWw0ln7il/wRmNhCMkAKQqrunrTofkC4y
         STL6BgAryp8AjTVHJykzTYJbOKEAzFNG57k7frMAH4PEGiCNZLbPc6BdZ4m4caa6HAlZ
         86wG0Ee97gm8kjbILrR2y9UikP/FaypH2XVtDV1ZGh7mUn5oGAk340ig+uzCyR8uWYdc
         hfeGBPsYgOfVj2+JStfRwRPwrcNWRMzPEgirmdmWf8fCEzsDXgL6uN1BKtWO0pNecCLX
         +NAWB2p7MTtvwoJQohPByv2L5qIHGmDMqnO6tYFUAkVf++gI1QLiO0x08kB6g+UmhaVd
         a7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871001; x=1737475801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCbhAAOfgSy4gG11/slI/9NU/Jb4WeqNzdw5obZWbgE=;
        b=DHclvjBaBu2mOKUTg5wHSAxAYzBohJO5JMUgTwVx4amTw9qgwlZhmYNXWdMpfPms0R
         4oSbtLk0AQGydvQ3IayNeJiK/vhkmqkOmahPktoryEkJ5WQxxvUv+/d8PHtwbpBkGmO2
         DP83UFfjBQS15EWexNTgFTngBUHq94tp+Xu27moEts+vHPJ06IlHFR6unbn9CsqvIzSK
         TemGOag/KqziI2cLv7FMsAIbCXC4ChybbMxjnHo91huCfHgNf1xNvTSIWTd607D+kmnn
         CAXvrDRqjV8/xuY3dJYP188aBqCas1jyqObNnwxPi7whAWhdMvSFi9sq8G/fBQyHCwXo
         V8Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUT5u8AE8o2b5bILF3xvTDJjuJro7JaWKWiQYnA4zEsxbhuMD059YzRPONoPkdeV97055T8LqA9@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEKmd2EuUeR2v1r+QwmMUO4PBuRwYGCzkneppV7uK3r7+TjJ2
	ME2kxMW1ycIAycMUZEvoctY7utDae+lChlRGUkJetqwyz4p83MQY/uB74rhTgAc=
X-Gm-Gg: ASbGncvLEpjAY49Rl5ukhvHxdeTQfoFi7W/yZNK99UkulhyFuVtddTbvbP+ynsz83iC
	wg/ahHtcPIMXYo/sFxUwUkX3m70vXBGsob+TYFYO+UbtIqbFIR/gy+1SFLZtj0eKxYM6Hs4NQ1f
	dx4aH82wzDkNj4GSf9j760u5lAbXX9bDzvms9pQ7CB0qT/gNAl2jqoF3fg+xvCfpc0aKcKaeIlf
	yMO2fqHchDELUGHJP29HuNL3xsahK9H3oiKYecoPuHOTh0M3WalVgQ=
X-Google-Smtp-Source: AGHT+IEmpSB8/ppdMkBcq1yLq4xC6DDou+fUzob81MKPvq3WpvvOoJ+9eGO861F9B/iwhNhEwhsskQ==
X-Received: by 2002:a05:620a:f06:b0:7b0:6e8:94ef with SMTP id af79cd13be357-7bcd96146cfmr621646685a.0.1736871000826;
        Tue, 14 Jan 2025 08:10:00 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248304sm615976685a.31.2025.01.14.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:09:59 -0800 (PST)
Date: Tue, 14 Jan 2025 11:09:55 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <20250114160955.GA1115056@cmpxchg.org>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z2BJoDsMeKi4LQGe@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2BJoDsMeKi4LQGe@tiehlicka>

Hi,

On Mon, Dec 16, 2024 at 04:39:12PM +0100, Michal Hocko wrote:
> On Thu 12-12-24 13:30:12, Johannes Weiner wrote:
> [...]
> > So I'm also inclined to think this needs a reclaim/memcg-side fix. We
> > have a somewhat tumultous history of policy in that space:
> > 
> > commit 7775face207922ea62a4e96b9cd45abfdc7b9840
> > Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date:   Tue Mar 5 15:46:47 2019 -0800
> > 
> >     memcg: killed threads should not invoke memcg OOM killer
> > 
> > allowed dying tasks to simply force all charges and move on. This
> > turned out to be too aggressive; there were instances of exiting,
> > uncontained memcg tasks causing global OOMs. This lead to that:
> > 
> > commit a4ebf1b6ca1e011289677239a2a361fde4a88076
> > Author: Vasily Averin <vasily.averin@linux.dev>
> > Date:   Fri Nov 5 13:38:09 2021 -0700
> > 
> >     memcg: prohibit unconditional exceeding the limit of dying tasks
> > 
> > which reverted the bypass rather thoroughly. Now NO dying tasks, *not
> > even OOM victims*, can force charges. I am not sure this is correct,
> > either:
> 
> IIRC the reason going this route was a lack of per-memcg oom reserves.
> Global oom victims are getting some slack because the amount of reserves
> be bound. This is not the case for memcgs though.
> 
> > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > will re-trigger OOM, which will find the existing OOM victim and do
> > nothing, then restart the fault.
> 
> IIRC the task will handle the pending SIGKILL if the #PF fails. If the
> charge happens from the exit path then we rely on ENOMEM returned from
> gup as a signal to back off. Do we have any caller that keeps retrying
> on ENOMEM?

We managed to extract a stack trace of the livelocked task:

obj_cgroup_may_swap
zswap_store
swap_writepage
shrink_folio_list
shrink_lruvec
shrink_node
do_try_to_free_pages
try_to_free_mem_cgroup_pages
charge_memcg
mem_cgroup_swapin_charge_folio
__read_swap_cache_async
swapin_readahead
do_swap_page
handle_mm_fault
do_user_addr_fault
exc_page_fault
asm_exc_page_fault
__get_user
futex_cleanup
fuxtex_exit_release
do_exit
do_group_exit
get_signal
arch_do_signal_or_restart
exit_to_user_mode_prepare
syscall_exit_to_user_mode
do_syscall
entry_SYSCALL_64
syscall

Both memory.max and memory.zswap.max are hit. I don't see how this
could ever make forward progress - the futex fault will retry until it
succeeds. The only workaround for this state right now is to manually
raise memory.max to let the fault succeed and the exit complete.

> > This is a memory deadlock. The page
> > allocator gives OOM victims access to reserves for that reason.
> 
> > Actually, it looks even worse. For some reason we're not triggering
> > OOM from dying tasks:
> > 
> >         ret = task_is_dying() || out_of_memory(&oc);
> > 
> > Even though dying tasks are in no way privileged or allowed to exit
> > expediently. Why shouldn't they trigger the OOM killer like anybody
> > else trying to allocate memory?
> 
> Good question! I suspect this early bail out is based on an assumption
> that a dying task will free up the memory soon so oom killer is
> unnecessary.

Correct. It's not about the kill. The important thing is that at least
one exiting task is getting the extra memory headroom usually afforded
to the OOM victim, to guarantee forward progress in the exit path.

> > As it stands, it seems we have dying tasks getting trapped in an
> > endless fault->reclaim cycle; with no access to the OOM killer and no
> > access to reserves. Presumably this is what's going on here?
> 
> As mentioned above this seems really surprising and it would indicate
> that something in the exit path would keep retrying when getting ENOMEM
> from gup or GFP_ACCOUNT allocation. GFP_NOFAIL requests are allowed to
> over-consume.

I hope the path is clear from the stack trace above.

> > I think we want something like this:
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 53db98d2c4a1..be6b6e72bde5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1596,11 +1596,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	if (mem_cgroup_margin(memcg) >= (1 << order))
> >  		goto unlock;
> >  
> > -	/*
> > -	 * A few threads which were not waiting at mutex_lock_killable() can
> > -	 * fail to bail out. Therefore, check again after holding oom_lock.
> > -	 */
> > -	ret = task_is_dying() || out_of_memory(&oc);
> > +	ret = out_of_memory(&oc);
> 
> I am not against this as it would allow to do an async oom_reaper memory
> reclaim in the worst case. This could potentially reintroduce the "No
> victim available" case described by 7775face2079 ("memcg: killed threads
> should not invoke memcg OOM killer") but that seemed to be a very
> specific and artificial usecase IIRC.

+1

> >  unlock:
> >  	mutex_unlock(&oom_lock);
> > @@ -2198,6 +2194,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	if (unlikely(current->flags & PF_MEMALLOC))
> >  		goto force;
> >  
> > +	if (unlikely(tsk_is_oom_victim(current)))
> > +		goto force;
> > +
> >  	if (unlikely(task_in_memcg_oom(current)))
> >  		goto nomem;
> 
> This is more problematic as it doesn't cap a potential runaway and
> eventual global OOM which is not really great. In the past this could be
> possible through vmalloc which didn't bail out early for killed tasks.
> That risk has been mitigated by dd544141b9eb ("vmalloc: back off when
> the current task is OOM-killed"). I would like to keep some sort of
> protection from those runaways. Whether that is a limited "reserve" for
> oom victims that would be per memcg or do no let them consume above the
> hard limit at all. Fundamentally a limited reserves doesn't solve the
> underlying problem, it just make it less likely so the latter would be
> preferred by me TBH.

Right. There is no way to limit an OOM victim without risking a memory
deadlock.

