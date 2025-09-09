Return-Path: <cgroups+bounces-9834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15DB50195
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA533BA679
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D2322DB4;
	Tue,  9 Sep 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeNwSRUy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8A22DCF6B
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432324; cv=none; b=Tq6r8a/y0KkmQdRE8ukqst4pORLWTkFz3kCCy/M5mt4BkOmSPiyXtiRktAM4ME+eeqBZ2EbTqp4d0Y4ece/3bMmKXXmKCXrcCMhwQLd/PoN5n0W7oJutODPVkmv4KvSmreTKpbClQPxNFAn9lhi3+zdgQwAU8ppILLqE7vP+yMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432324; c=relaxed/simple;
	bh=H59vSg6yqfeTagI2KSz0Mh1AfpBoCyroWytvOOs3WK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xo8qoFxLtzY87AL8Mnf0s/TD5bUVTIQawzlwOvKXeU2r2GIyfvucAqn891lKfMdh4wViB0it0mxPyyxSU2EPsF0uILhjPeupi8Qdr/H+fksq8sg9vGsjbtI4JCHrlgZwnnWgLLvlYt3ajtT8T6xQkFRy8/IhTz5mtV+E7m4dhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeNwSRUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C46C4CEF4
	for <cgroups@vger.kernel.org>; Tue,  9 Sep 2025 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432323;
	bh=H59vSg6yqfeTagI2KSz0Mh1AfpBoCyroWytvOOs3WK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZeNwSRUyi9tF9LsPemQ+0THBknwkv8YOxgR7tleEpBzdPsaACKTvX3/TSLmqwVPZc
	 doSr+a62KpXTOE9kA7z+bvAKQhaKOLVunEewU68i/MsfvHrd8jiPBITcEMe3yzLiar
	 Fyk6jdXPZN4F53RViFM96NMa0toe0bXjYRB3mFSxc9+eAYeYqrQCoXV7Xzrjf2XNC+
	 Bk4bCla7U31Bo5+5/+7QM6Mx64S84FvK/MJmIp1BvkyGnPSBC8Xu48UOeC9fIpag+D
	 xH9p8aP3hdMIdtQo5yr0AmEfdycPmwjE6sue7UgdQoU/Ary3CGUs3g+TbVL3upndGB
	 /BZvGTDGSKU1Q==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-408c236c500so508335ab.1
        for <cgroups@vger.kernel.org>; Tue, 09 Sep 2025 08:38:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFcLEV1EO/aOP76AdKqde/2bQdhSZ3DoBTNRhF6Ukyg7MVxe6k/MkZ4V6MYX9EKSIHXk5uamUi@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDgNNqZ8CW0R1+JRsRZqdk7bNXnYFd3yIsRE3BBJZnFvK0Qwu
	x+M/omkBtf2HjXSHbZg1uzfrprZ5gi40EPLruTOQvRDyGbPloCEnZWz5B15gCilFZ4dX+jmjW4c
	Lr1fm+VFPn/uMcS9U0lBJZmcIiRTKv4XjfJGOj94y
X-Google-Smtp-Source: AGHT+IGBqVO3oKD8XjGxL3juBwWFjRrPmj4mgsVkHCfdV6oZc06DcMQABIJXslbc8xt54PHxByce6Tv2wQ2REfxHIBc=
X-Received: by 2002:a05:6e02:219a:b0:40b:590b:7d98 with SMTP id
 e9e14a558f8ab-40b590b7e67mr11544725ab.8.1757432322295; Tue, 09 Sep 2025
 08:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
In-Reply-To: <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 9 Sep 2025 08:38:29 -0700
X-Gmail-Original-Message-ID: <CAF8kJuN7cw2TBKvjPZQER8Yh586pwahMSSou5P0=TFL+vtd1=Q@mail.gmail.com>
X-Gm-Features: Ac12FXyeFnTZyXJdqqEHEE7Eg5jvsdu3zTidMhrtm5s_2H33PC3oRecmiAsko9Q
Message-ID: <CAF8kJuN7cw2TBKvjPZQER8Yh586pwahMSSou5P0=TFL+vtd1=Q@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Kairui Song <ryncsn@gmail.com>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:31=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Sep 9, 2025 at 3:04=E2=80=AFPM Lei Liu <liulei.rjpt@vivo.com> wro=
te:
> >
>
> Hi Lei,
>
> > 1. Problem Scenario
> > On systems with ZRAM and swap enabled, simultaneous process exits creat=
e
> > contention. The primary bottleneck occurs during swap entry release
> > operations, causing exiting processes to monopolize CPU resources. This
> > leads to scheduling delays for high-priority processes.
> >
> > 2. Android Use Case
> > During camera launch, LMKD terminates background processes to free memo=
ry.
> > Exiting processes compete for CPU cycles, delaying the camera preview
> > thread and causing visible stuttering - directly impacting user
> > experience.
> >
> > 3. Root Cause Analysis
> > When background applications heavily utilize swap space, process exit
> > profiling reveals 55% of time spent in free_swap_and_cache_nr():
> >
> > Function              Duration (ms)   Percentage
> > do_signal               791.813     **********100%
> > do_group_exit           791.813     **********100%
> > do_exit                 791.813     **********100%
> > exit_mm                 577.859        *******73%
> > exit_mmap               577.497        *******73%
> > zap_pte_range           558.645        *******71%
> > free_swap_and_cache_nr  433.381          *****55%
> > free_swap_slot          403.568          *****51%
>
> Thanks for sharing this case.
>
> One problem is that now the free_swap_slot function no longer exists
> after 0ff67f990bd4. Have you tested the latest kernel? Or what is the
> actual overhead here?
>
> Some batch freeing optimizations are introduced. And we have reworked
> the whole locking mechanism for swap, so even on a system with 96t the
> contention seems barely observable with common workloads.
>
> And another series is further reducing the contention and the overall
> overhead (24% faster freeing for phase 1):
> https://lore.kernel.org/linux-mm/20250905191357.78298-1-ryncsn@gmail.com/
>
> Will these be helpful for you? I think optimizing the root problem is
> better than just deferring the overhead with async workers, which may
> increase the overall overhead and complexity.

+100.

Hi Lei,

This CC list is very long :-)

Is it similar to this one a while back?

https://lore.kernel.org/linux-mm/20240213-async-free-v3-1-b89c3cc48384@kern=
el.org/

I ultimately abandoned this approach and considered it harmful. Yes, I
can be as harsh as I like for my own previous bad ideas. The better
solution is as Kairui did, just remove the swap slot caching
completely. It is the harder path to take and get better results. I
recall having a discussion with Kairui on this and we are aligned on
removing the swap slot caching eventually . Thanks Kairui for the
heavy lifting of actually removing the swap slot cache. I am just
cheerleading on the side :-)

So no, we are not getting the async free of swap slot caching again.
We shouldn't need to.

Chris




>
>
> > swap_entry_free         393.863          *****50%
> > swap_range_free         372.602           ****47%
> >
> > 4. Optimization Approach
> > a) For processes exceeding swap entry threshold: aggregate and isolate
> > swap entries to enable fast exit
> > b) Asynchronously release batched entries when isolation reaches
> > configured threshold
> >
> > 5. Performance Gains (User Scenario: Camera Cold Launch)
> > a) 74% reduction in process exit latency (>500ms cases)
> > b) ~4% lower peak CPU load during concurrent process exits
> > c) ~70MB additional free memory during camera preview initialization
> > d) 40% reduction in camera preview stuttering probability
> >
> > 6. Prior Art & Improvements
> > Reference: Zhiguo Jiang's patch
> > (https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com=
/)
> >
> > Key enhancements:
> > a) Reimplemented logic moved from mmu_gather.c to swapfile.c for clarit=
y
> > b) Async release delegated to workqueue kworkers with configurable
> > max_active for NUMA-optimized concurrency
> >
> > Lei Liu (2):
> >   mm: swap: Gather swap entries and batch async release core
> >   mm: swap: Forced swap entries release under memory pressure
> >
> >  include/linux/oom.h           |  23 ++++++
> >  include/linux/swapfile.h      |   2 +
> >  include/linux/vm_event_item.h |   1 +
> >  kernel/exit.c                 |   2 +
> >  mm/memcontrol.c               |   6 --
> >  mm/memory.c                   |   4 +-
> >  mm/page_alloc.c               |   4 +
> >  mm/swapfile.c                 | 134 ++++++++++++++++++++++++++++++++++
> >  mm/vmstat.c                   |   1 +
> >  9 files changed, 170 insertions(+), 7 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
>

