Return-Path: <cgroups+bounces-7631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1C9A92CD2
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE64B1B6435C
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251A2063C2;
	Thu, 17 Apr 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWi9QmVW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B91CEADB
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926344; cv=none; b=G8NDSFu3ioGZIZWJNmFBS5DHERAvlPSJgR+Jc1ekhhhLUEs3YYuW08ZOiUI/UqPsgXznbl/iRYtJwK+2gJek7UcknMUzG2a7fvSiQUu5a7/p4M37sEAI1tTN0fMwmJW9AinK9+FMruvOmww/fZ+gLrjNgWJlehD+3lvRXCIwyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926344; c=relaxed/simple;
	bh=xHJ0U/NNew0D9559C+9DS7UY5fxxKEpGxBszJk6LAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO5eonZVOpVO8OCQEj8UF+DedyiSqybHe6Y9l9QG/579wW3CQWvilcMTAXIllZMMN60smdAXXM48uYBlAZZqh6f9FmIyI7mGaJss4I6r/iyl3CkMGFgKrmiAHrLfAraIOC9dhgSf6fsvrG4b/QDu0gLpUs7KaVMp7VZK+VRzCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWi9QmVW; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Apr 2025 21:45:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744926337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyL22TIdx0Q5a8q6LIr4f7OFCQiot5vdD9q+5r2Pq1M=;
	b=fWi9QmVWTQXLS+cHrsXzp9VdFCl1Wu6eF3gWaUI/LYpxjL8da362t/2VrISfu29y/nqiFp
	7ppv8G5hA1hR6BA2OWNgdTxsQc/elTxKxO3iQ+TP9ZtPCI050IpT+KTUCT2gOJ1a/ZG7Xv
	Rvu6+PRuCarcI1mA0/+dFIUbp5DvO5Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
	mhocko@kernel.org, shakeel.butt@linux.dev,
	akpm@linux-foundation.org, david@fromorbit.com,
	zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, yuzhao@google.com
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
Message-ID: <aAF2eUG26_xDYIDU@google.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
 <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
> On Tue, Apr 15, 2025 at 4:02 PM Muchun Song <muchun.song@linux.dev> wrote:
> >
> >
> >
> > > On Apr 15, 2025, at 14:19, Kairui Song <ryncsn@gmail.com> wrote:
> > >
> > > On Tue, Apr 15, 2025 at 10:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >>
> > >> This patchset is based on v6.15-rc2. It functions correctly only when
> > >> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were encountered
> > >> during rebasing onto the latest code. For more details and assistance, refer
> > >> to the "Challenges" section. This is the reason for adding the RFC tag.
> > >>
> > >> ## Introduction
> > >>
> > >> This patchset is intended to transfer the LRU pages to the object cgroup
> > >> without holding a reference to the original memory cgroup in order to
> > >> address the issue of the dying memory cgroup. A consensus has already been
> > >> reached regarding this approach recently [1].
> > >>
> > >> ## Background
> > >>
> > >> The issue of a dying memory cgroup refers to a situation where a memory
> > >> cgroup is no longer being used by users, but memory (the metadata
> > >> associated with memory cgroups) remains allocated to it. This situation
> > >> may potentially result in memory leaks or inefficiencies in memory
> > >> reclamation and has persisted as an issue for several years. Any memory
> > >> allocation that endures longer than the lifespan (from the users'
> > >> perspective) of a memory cgroup can lead to the issue of dying memory
> > >> cgroup. We have exerted greater efforts to tackle this problem by
> > >> introducing the infrastructure of object cgroup [2].
> > >>
> > >> Presently, numerous types of objects (slab objects, non-slab kernel
> > >> allocations, per-CPU objects) are charged to the object cgroup without
> > >> holding a reference to the original memory cgroup. The final allocations
> > >> for LRU pages (anonymous pages and file pages) are charged at allocation
> > >> time and continues to hold a reference to the original memory cgroup
> > >> until reclaimed.
> > >>
> > >> File pages are more complex than anonymous pages as they can be shared
> > >> among different memory cgroups and may persist beyond the lifespan of
> > >> the memory cgroup. The long-term pinning of file pages to memory cgroups
> > >> is a widespread issue that causes recurring problems in practical
> > >> scenarios [3]. File pages remain unreclaimed for extended periods.
> > >> Additionally, they are accessed by successive instances (second, third,
> > >> fourth, etc.) of the same job, which is restarted into a new cgroup each
> > >> time. As a result, unreclaimable dying memory cgroups accumulate,
> > >> leading to memory wastage and significantly reducing the efficiency
> > >> of page reclamation.
> > >>
> > >> ## Fundamentals
> > >>
> > >> A folio will no longer pin its corresponding memory cgroup. It is necessary
> > >> to ensure that the memory cgroup or the lruvec associated with the memory
> > >> cgroup is not released when a user obtains a pointer to the memory cgroup
> > >> or lruvec returned by folio_memcg() or folio_lruvec(). Users are required
> > >> to hold the RCU read lock or acquire a reference to the memory cgroup
> > >> associated with the folio to prevent its release if they are not concerned
> > >> about the binding stability between the folio and its corresponding memory
> > >> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
> > >> desire a stable binding between the folio and its corresponding memory
> > >> cgroup. An approach is needed to ensure the stability of the binding while
> > >> the lruvec lock is held, and to detect the situation of holding the
> > >> incorrect lruvec lock when there is a race condition during memory cgroup
> > >> reparenting. The following four steps are taken to achieve these goals.
> > >>
> > >> 1. The first step  to be taken is to identify all users of both functions
> > >>   (folio_memcg() and folio_lruvec()) who are not concerned about binding
> > >>   stability and implement appropriate measures (such as holding a RCU read
> > >>   lock or temporarily obtaining a reference to the memory cgroup for a
> > >>   brief period) to prevent the release of the memory cgroup.
> > >>
> > >> 2. Secondly, the following refactoring of folio_lruvec_lock() demonstrates
> > >>   how to ensure the binding stability from the user's perspective of
> > >>   folio_lruvec().
> > >>
> > >>   struct lruvec *folio_lruvec_lock(struct folio *folio)
> > >>   {
> > >>           struct lruvec *lruvec;
> > >>
> > >>           rcu_read_lock();
> > >>   retry:
> > >>           lruvec = folio_lruvec(folio);
> > >>           spin_lock(&lruvec->lru_lock);
> > >>           if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > >>                   spin_unlock(&lruvec->lru_lock);
> > >>                   goto retry;
> > >>           }
> > >>
> > >>           return lruvec;
> > >>   }
> > >>
> > >>   From the perspective of memory cgroup removal, the entire reparenting
> > >>   process (altering the binding relationship between folio and its memory
> > >>   cgroup and moving the LRU lists to its parental memory cgroup) should be
> > >>   carried out under both the lruvec lock of the memory cgroup being removed
> > >>   and the lruvec lock of its parent.
> > >>
> > >> 3. Thirdly, another lock that requires the same approach is the split-queue
> > >>   lock of THP.
> > >>
> > >> 4. Finally, transfer the LRU pages to the object cgroup without holding a
> > >>   reference to the original memory cgroup.
> > >>
> > >
> > > Hi, Muchun, thanks for the patch.
> >
> > Thanks for your reply and attention.
> >
> > >
> > >> ## Challenges
> > >>
> > >> In a non-MGLRU scenario, each lruvec of every memory cgroup comprises four
> > >> LRU lists (i.e., two active lists for anonymous and file folios, and two
> > >> inactive lists for anonymous and file folios). Due to the symmetry of the
> > >> LRU lists, it is feasible to transfer the LRU lists from a memory cgroup
> > >> to its parent memory cgroup during the reparenting process.
> > >
> > > Symmetry of LRU lists doesn't mean symmetry 'hotness', it's totally
> > > possible that a child's active LRU is colder and should be evicted
> > > first before the parent's inactive LRU (might even be a common
> > > scenario for certain workloads).
> >
> > Yes.
> >
> > > This only affects the performance not the correctness though, so not a
> > > big problem.
> > >
> > > So will it be easier to just assume dying cgroup's folios are colder?
> > > Simply move them to parent's LRU tail is OK. This will make the logic
> > > appliable for both active/inactive LRU and MGLRU.
> >
> > I think you mean moving all child LRU list to the parent memcg's inactive
> > list. It works well for your case. But sometimes, due to shared page cache
> > pages, some pages in the child list may be accessed more frequently than
> > those in the parent's. Still, it's okay as they can be promoted quickly
> > later. So I am fine with this change.
> >
> > >
> > >>
> > >> In a MGLRU scenario, each lruvec of every memory cgroup comprises at least
> > >> 2 (MIN_NR_GENS) generations and at most 4 (MAX_NR_GENS) generations.
> > >>
> > >> 1. The first question is how to move the LRU lists from a memory cgroup to
> > >>   its parent memory cgroup during the reparenting process. This is due to
> > >>   the fact that the quantity of LRU lists (aka generations) may differ
> > >>   between a child memory cgroup and its parent memory cgroup.
> > >>
> > >> 2. The second question is how to make the process of reparenting more
> > >>   efficient, since each folio charged to a memory cgroup stores its
> > >>   generation counter into its ->flags. And the generation counter may
> > >>   differ between a child memory cgroup and its parent memory cgroup because
> > >>   the values of ->min_seq and ->max_seq are not identical. Should those
> > >>   generation counters be updated correspondingly?
> > >
> > > I think you do have to iterate through the folios to set or clear
> > > their generation flags if you want to put the folio in the right gen.
> > >
> > > MGLRU does similar thing in inc_min_seq. MGLRU uses the gen flags to
> > > defer the actual LRU movement of folios, that's a very important
> > > optimization per my test.
> >
> > I noticed that, which is why I asked the second question. It's
> > inefficient when dealing with numerous pages related to a memory
> > cgroup.
> >
> > >
> > >>
> > >> I am uncertain about how to handle them appropriately as I am not an
> > >> expert at MGLRU. I would appreciate it if you could offer some suggestions.
> > >> Moreover, if you are willing to directly provide your patches, I would be
> > >> glad to incorporate them into this patchset.
> > >
> > > If we just follow the above idea (move them to parent's tail), we can
> > > just keep the folio's tier info untouched here.
> > >
> > > For mapped file folios, they will still be promoted upon eviction if
> > > their access bit are set (rmap walk), and MGLRU's table walker might
> > > just promote them just fine.
> > >
> > > For unmapped file folios, if we just keep their tier info and add
> > > child's MGLRU tier PID counter back to the parent. Workingset
> > > protection of MGLRU should still work just fine.
> > >
> > >>
> > >> ## Compositions
> > >>
> > >> Patches 1-8 involve code refactoring and cleanup with the aim of
> > >> facilitating the transfer LRU folios to object cgroup infrastructures.
> > >>
> > >> Patches 9-10 aim to allocate the object cgroup for non-kmem scenarios,
> > >> enabling the ability that LRU folios could be charged to it and aligning
> > >> the behavior of object-cgroup-related APIs with that of the memory cgroup.
> > >>
> > >> Patches 11-19 aim to prevent memory cgroup returned by folio_memcg() from
> > >> being released.
> > >>
> > >> Patches 20-23 aim to prevent lruvec returned by folio_lruvec() from being
> > >> released.
> > >>
> > >> Patches 24-25 implement the core mechanism to guarantee binding stability
> > >> between the folio and its corresponding memory cgroup while holding lruvec
> > >> lock or split-queue lock of THP.
> > >>
> > >> Patches 26-27 are intended to transfer the LRU pages to the object cgroup
> > >> without holding a reference to the original memory cgroup in order to
> > >> address the issue of the dying memory cgroup.
> > >>
> > >> Patch 28 aims to add VM_WARN_ON_ONCE_FOLIO to LRU maintenance helpers to
> > >> ensure correct folio operations in the future.
> > >>
> > >> ## Effect
> > >>
> > >> Finally, it can be observed that the quantity of dying memory cgroups will
> > >> not experience a significant increase if the following test script is
> > >> executed to reproduce the issue.
> > >>
> > >> ```bash
> > >> #!/bin/bash
> > >>
> > >> # Create a temporary file 'temp' filled with zero bytes
> > >> dd if=/dev/zero of=temp bs=4096 count=1
> > >>
> > >> # Display memory-cgroup info from /proc/cgroups
> > >> cat /proc/cgroups | grep memory
> > >>
> > >> for i in {0..2000}
> > >> do
> > >>    mkdir /sys/fs/cgroup/memory/test$i
> > >>    echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> > >>
> > >>    # Append 'temp' file content to 'log'
> > >>    cat temp >> log
> > >>
> > >>    echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> > >>
> > >>    # Potentially create a dying memory cgroup
> > >>    rmdir /sys/fs/cgroup/memory/test$i
> > >> done
> > >>
> > >> # Display memory-cgroup info after test
> > >> cat /proc/cgroups | grep memory
> > >>
> > >> rm -f temp log
> > >> ```
> > >>
> > >> ## References
> > >>
> > >> [1] https://lore.kernel.org/linux-mm/Z6OkXXYDorPrBvEQ@hm-sls2/
> > >> [2] https://lwn.net/Articles/895431/
> > >> [3] https://github.com/systemd/systemd/pull/36827
> > >
> > > How much overhead will it be? Objcj has some extra overhead, and we
> > > have some extra convention for retrieving memcg of a folio now, not
> > > sure if this will have an observable slow down.
> >
> > I don't think there'll be an observable slowdown. I think objcg is
> > more effective for slab objects as they're more sensitive than user
> > pages. If it's acceptable for slab objects, it should be acceptable
> > for user pages too.
> 
> We currently have some workloads running with `nokmem` due to objcg
> performance issues. I know there are efforts to improve them, but so
> far it's still not painless to have. So I'm a bit worried about
> this...

Do you mind sharing more details here?

Thanks!

