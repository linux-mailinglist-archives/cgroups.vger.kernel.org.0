Return-Path: <cgroups+bounces-1128-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE282B56F
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 20:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF4F1C23A93
	for <lists+cgroups@lfdr.de>; Thu, 11 Jan 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6856754;
	Thu, 11 Jan 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nmJ5p7aV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA315646A
	for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5efb0e180f0so59411707b3.1
        for <cgroups@vger.kernel.org>; Thu, 11 Jan 2024 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705002599; x=1705607399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPLi6O7KBw3YUZoVBDLnn1CzKaqAZdl95OpUhCOdcb4=;
        b=nmJ5p7aVuI6GemWk/mx+M8Ac+UWFMjqWazXUL2eIGyVpPJlohFgaXqt22cMRAdHosy
         hDyiWvdzaxb0V3Vcr225fBuxsRRJUyYOVWkrfFWigGotHHUENjLlDNfiZVDOmXJFowQr
         C47IpQ+ilNHXPJxNP4C3W6Imn6FcZHFBR/o0Tb1P4REsV9ObL8JjFXOSYYJUWCYvqb77
         5XX2BsOY2uuJ+5MnckXsPWWw+FYAwP3E65ZUwQ2uL5mrEm32tR+mvlf2Oz5phbe0Uf4A
         yXXwZpH6pxv+2xkglzG9JvKxwL7dd9OTb2xSLR0LxHUqw+0p0tSNty6dnWUR3NE1AN9l
         ou4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002599; x=1705607399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPLi6O7KBw3YUZoVBDLnn1CzKaqAZdl95OpUhCOdcb4=;
        b=sT7kLCwtulRgWjomRVctCmuFhpi7R/nspw0mpT5bpzSb1EjpGalfrz1kH7olCvw6k8
         J3c3QaHVyGFil3T3aCFw0mxru+jNmhl4XZ+CSRrCRCCLt0jrM5MnWt+hrGyZhQRdA3pb
         F4ROe3HyyCK5FWKUTUf4Z3GZPQLZ1cPQ9L9pf7cF4cVAkVfpmAy+xGZyFGLRnDE+UHMc
         kah+qOjy95puYQRYHIDMa6hQnEds5/+JdxsLA1bKS+t/xFpJmCb9G7msezifOvJlVQx+
         VmfuxKbRGGWjoo8wwexmbyZ3piOX9nMvOMvGyrtZenQpuIB4UVKLPPUZhbWUeuionMKV
         oRNw==
X-Gm-Message-State: AOJu0YxKVX99Uk7I/TI2kiAlAOQhqOibYVEvQ0doDrK3zs9tmb8WXq5K
	Da10EKVw20trJarX+kzl2dXksYUgwMpzBg==
X-Google-Smtp-Source: AGHT+IGr58ORL/4tsY0NmadHO/euuWEOjPSFK1YDN/fjDiHc7MtekwE5jbkY7/Xj8Mu8VFaC8KDVAQ==
X-Received: by 2002:a25:245:0:b0:dbc:c592:5a3c with SMTP id 66-20020a250245000000b00dbcc5925a3cmr162118ybc.2.1705002598993;
        Thu, 11 Jan 2024 11:49:58 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id c25-20020ac853d9000000b004283695a39bsm685648qtq.94.2024.01.11.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:49:58 -0800 (PST)
Date: Thu, 11 Jan 2024 14:49:57 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: don't throttle dying tasks on memory.high
Message-ID: <20240111194957.GA440376@cmpxchg.org>
References: <20240111132902.389862-1-hannes@cmpxchg.org>
 <ZaAsbwFP-ttYNwIe@P9FQF9L96D>
 <20240111192807.GA424308@cmpxchg.org>
 <ZaBDoRr90kPNMrv7@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaBDoRr90kPNMrv7@P9FQF9L96D>

On Thu, Jan 11, 2024 at 11:38:09AM -0800, Roman Gushchin wrote:
> On Thu, Jan 11, 2024 at 02:28:07PM -0500, Johannes Weiner wrote:
> > On Thu, Jan 11, 2024 at 09:59:11AM -0800, Roman Gushchin wrote:
> > > On Thu, Jan 11, 2024 at 08:29:02AM -0500, Johannes Weiner wrote:
> > > > While investigating hosts with high cgroup memory pressures, Tejun
> > > > found culprit zombie tasks that had were holding on to a lot of
> > > > memory, had SIGKILL pending, but were stuck in memory.high reclaim.
> > > > 
> > > > In the past, we used to always force-charge allocations from tasks
> > > > that were exiting in order to accelerate them dying and freeing up
> > > > their rss. This changed for memory.max in a4ebf1b6ca1e ("memcg:
> > > > prohibit unconditional exceeding the limit of dying tasks"); it noted
> > > > that this can cause (userspace inducable) containment failures, so it
> > > > added a mandatory reclaim and OOM kill cycle before forcing charges.
> > > > At the time, memory.high enforcement was handled in the userspace
> > > > return path, which isn't reached by dying tasks, and so memory.high
> > > > was still never enforced by dying tasks.
> > > > 
> > > > When c9afe31ec443 ("memcg: synchronously enforce memory.high for large
> > > > overcharges") added synchronous reclaim for memory.high, it added
> > > > unconditional memory.high enforcement for dying tasks as well. The
> > > > callstack shows that this path is where the zombie is stuck in.
> > > > 
> > > > We need to accelerate dying tasks getting past memory.high, but we
> > > > cannot do it quite the same way as we do for memory.max: memory.max is
> > > > enforced strictly, and tasks aren't allowed to move past it without
> > > > FIRST reclaiming and OOM killing if necessary. This ensures very small
> > > > levels of excess. With memory.high, though, enforcement happens lazily
> > > > after the charge, and OOM killing is never triggered. A lot of
> > > > concurrent threads could have pushed, or could actively be pushing,
> > > > the cgroup into excess. The dying task will enter reclaim on every
> > > > allocation attempt, with little hope of restoring balance.
> > > > 
> > > > To fix this, skip synchronous memory.high enforcement on dying tasks
> > > > altogether again. Update memory.high path documentation while at it.
> > > 
> > > It makes total sense to me.
> > > Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> > 
> > Thanks
> > 
> > > However if tasks can stuck for a long time in the "high reclaim" state,
> > > shouldn't we also handle the case when tasks are being killed during the
> > > reclaim? E. g. something like this (completely untested):
> > 
> > Yes, that's probably a good idea.
> > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index c4c422c81f93..9f971fc6aae8 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2465,6 +2465,9 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
> > >                     READ_ONCE(memcg->memory.high))
> > >                         continue;
> > > 
> > > +               if (task_is_dying())
> > > +                       break;
> > > +
> > >                 memcg_memory_event(memcg, MEMCG_HIGH);
> > > 
> > >                 psi_memstall_enter(&pflags);
> > 
> > I think we can skip this one. The loop is for traversing from the
> > charging cgroup to the one that has memory.high set and breached, and
> > then reclaim it. It's not expected to run multiple reclaims.
> 
> Yes, the next one is probably enough (hard to say for me without knowing
> exactly where whose dying processes are getting stuck - you should have
> actual stacktraces I guess).

A bit tricky to say. Tejun managed to get a trace from a crashdump,
but you can't tell where exactly it's looping:

#0 arch_atomic_dec_and_test (./arch/x86/include/asm/atomic.h:123:9)
#1 atomic_dec_and_test (./include/linux/atomic/atomic-instrumented.h:576:9)
#2 page_ref_dec_and_test (./include/linux/page_ref.h:210:12)
#3 put_page_testzero (./include/linux/mm.h:999:9)
#4 folio_put_testzero (./include/linux/mm.h:1004:9)
#5 move_folios_to_lru (mm/vmscan.c:2495:7)
#6 shrink_inactive_list (mm/vmscan.c:2594:2)
#7 shrink_list (mm/vmscan.c:2835:9)
#8 shrink_lruvec (mm/vmscan.c:6271:21)
#9 shrink_node_memcgs (mm/vmscan.c:6458:3)
#10 shrink_node (mm/vmscan.c:6493:2)
#11 shrink_zones (mm/vmscan.c:6728:3)
#12 do_try_to_free_pages (mm/vmscan.c:6790:3)
#13 try_to_free_mem_cgroup_pages (mm/vmscan.c:7105:17)
#14 reclaim_high (mm/memcontrol.c:2451:19)
#15 mem_cgroup_handle_over_high (mm/memcontrol.c:2670:17)
#16 try_charge_memcg (mm/memcontrol.c:2887:3)
#17 try_charge (mm/memcontrol.c:2898:9)
#18 charge_memcg (mm/memcontrol.c:7062:8)
#19 __mem_cgroup_charge (mm/memcontrol.c:7083:8)
#20 mem_cgroup_charge (./include/linux/memcontrol.h:682:9)
#21 __filemap_add_folio (mm/filemap.c:860:15)
#22 filemap_add_folio (mm/filemap.c:942:8)
#23 page_cache_ra_unbounded (mm/readahead.c:251:7)
#24 do_sync_mmap_readahead (mm/filemap.c:0)
#25 filemap_fault (mm/filemap.c:3288:10)
#26 __do_fault (mm/memory.c:4184:8)
#27 do_read_fault (mm/memory.c:4538:8)
#28 do_fault (mm/memory.c:4667:9)
#29 do_pte_missing (mm/memory.c:3648:10)
#30 handle_pte_fault (mm/memory.c:4955:10)
#31 __handle_mm_fault (mm/memory.c:5097:9)
#32 handle_mm_fault (mm/memory.c:5251:9)
#33 do_user_addr_fault (arch/x86/mm/fault.c:1392:10)
#34 handle_page_fault (arch/x86/mm/fault.c:1486:3)
#35 exc_page_fault (arch/x86/mm/fault.c:1542:2)
#36 asm_exc_page_fault+0x22/0x27 (./arch/x86/include/asm/idtentry.h:570)

There is some circumstantial evidence: this thread has SIGKILL set and
memory pressure is high in its cgroup. When memory.high is reset, the
task exits and pressure drops. So the most likely culprit is the
somewhat vaguely bounded loop in mem_cgroup_handle_over_high().

> > > @@ -2645,6 +2648,9 @@ void mem_cgroup_handle_over_high(gfp_t gfp_mask)
> > >         current->memcg_nr_pages_over_high = 0;
> > > 
> > >  retry_reclaim:
> > > +       if (task_is_dying())
> > > +               return;
> > > +
> > >         /*
> > >          * The allocating task should reclaim at least the batch size, but for
> > >          * subsequent retries we only want to do what's necessary to prevent oom
> > 
> > Yeah this is the better place for this check.
> > 
> > How about this?
> 
> Looks really good to me!
> 
> I actually thought about moving the check into mem_cgroup_handle_over_high(),
> and you already did it in this version.

Excellent, thanks for your input.

