Return-Path: <cgroups+bounces-9811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121EB4A38D
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43764E2823
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C82FB093;
	Tue,  9 Sep 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9KDnpYX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D37246789;
	Tue,  9 Sep 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403059; cv=none; b=flcvIc1ttDdG7AS9SOiEPvKCgKeLoNtQPZALEo5zPZvg1IR67BgG5dUyUR3L4JoOXlF0MQIkuDdlZtkYIS+0YxWyg2Kwo4FnmRF0c4eQnSCHORweflL1v0pLx1DFcRSmo0M9pOzz3m7T1p1abbajsxKe7DP3tPXL8CeRUMHA13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403059; c=relaxed/simple;
	bh=fj5eUZndmYua/VDPNwQJrNruNi8Z6UOIgoMENtU7NAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBnPt/p8S/sn/Ug924DJ8LQZJVj01mwG9arC1XVd9fUhB0Uy0gTeOAxklEhsW+e8VQFizIq75hUzConoopYcWjEA5QkzOXWhXefKugU9d6OOnJfAFEB2gyuN/IJG7RM/lxQnFzKQQgJJKOD3Y6UgGG9vihW7hOVz1BY6vtk7XMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9KDnpYX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so6347781a12.0;
        Tue, 09 Sep 2025 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403056; x=1758007856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3+Kk/XPyaoPFAGQbNe7IovKooJsmlYdWhO37WXBxdc=;
        b=f9KDnpYXbtgxaYuYkBSUvljwx+wj/oKJzQw0sY8UE8KngOol+oJyp/xu2t4T2zexmh
         VBBVPAvY3va3Ekimy53m4ij6Ze8MrDe96QoPSqp04/3K06LvEu9gKFMhJmJbGWF3exgq
         b2eFt0gvH+HTQX/24vGrcexN+JXJldpdMJtuXHiRxZwIgLiBvui0LQnKSDUtRIOgPPCW
         nSpbOMt92061UtZiR5zl3Rgitutn+lsnmT6zMGGv2wSWO21F8VaYMjYakUDeb+tseMr5
         KCgaxRhWTvmC9BhhrQFrWrMGbSpfG+kB4uvXdOztpUNnbqYeAvRZT1kJHXWD+YZy0UHP
         YERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403056; x=1758007856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3+Kk/XPyaoPFAGQbNe7IovKooJsmlYdWhO37WXBxdc=;
        b=eDgEFcoPxtL9NhY8kt1rF9L1WhC4fSPzXn/JwKsOqgW19Ln7QI1bIsJJkgCL4GP3Iw
         bQuGqRkOLBkOqN2V9N4VKhCJoV0e/1dCYajyvo2cdjceD27o9D4EgZbZsSCl2x3KQ1S6
         ptSwcyjB1sP5zq/dAtw0urlOdmH/gl3vDzKEvmBHv3DVZdbipqW9wG6ChpFn/2EtWQD/
         ru4+nxbbYtwjxC4d5wVUxKz4auz/Y6N6j9t0k26vxP3Qh/P7ckKGcotFmKB8pTt5lh1k
         qYbTdnJ7G/slNX0Z+jzLKVEgvnbEs+DoLwwsgre5jNMxKq02nQlABzNc6+BLAOWzEQ37
         +evA==
X-Forwarded-Encrypted: i=1; AJvYcCU43fUqKEG0dZ4Umkx5IybL/kZrQ9ERI0OfGSs1S0RAg4lmgcRkY1+QxhMgJ2aCJwdcBtJorbvG@vger.kernel.org, AJvYcCWxncO9Ky8z0LOLoVEAgGeyIRh5pj0patZ0OORLe6KHiXp/XJcGhwSlmR5EegIC8BogU0UaCPlqZ8uLvMwt@vger.kernel.org
X-Gm-Message-State: AOJu0YyBn+h5i592KpRcXVYMZQE/1p3f5bJEnnDxk0oxNA69GzfzTh7t
	dnZfWM1IgFwCsPk4vO1qjSlZejfXU1f68BMHTDRrvmnrDOWs6vMJDWeRhS2tjv3LYXI1HbVPgJS
	MO5RgT71IdWnO+Ss2/6MgZ/8k4GA/fDk=
X-Gm-Gg: ASbGncuIy52WS6nvUpVju+rbCd9RL9k9ozd5RjWQuWy20TwPsrbvNw5HL6oV9VHNwl4
	2IutnDaHoRG2dvlyH2V8I/7BLmUgnAE706NUaL5rGEvD112TAlxFy+6wLXdZNZk2a0w7Dw34c5u
	mYSv1oQ4J4Rt8w27GcMXJHyF4ZZNgwuA6uFEA3sKrUudelBMc76JrxpvNMUOUxsmgtymhim8Fr3
	wiYvzqEWz4=
X-Google-Smtp-Source: AGHT+IGjr2QZ8D0kU0BkyVOPs2gj5QrOqZDajV1M594DAyIble/NtY0CSQ0leCeRkPIN8ags32/XQWc6jRZA9F0e5sU=
X-Received: by 2002:a05:6402:2343:b0:61e:ca25:3502 with SMTP id
 4fb4d7f45d1cf-623771096b8mr10416425a12.17.1757403055674; Tue, 09 Sep 2025
 00:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
In-Reply-To: <20250909065349.574894-1-liulei.rjpt@vivo.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 9 Sep 2025 15:30:19 +0800
X-Gm-Features: AS18NWAz3XTJvUfnFn8DaSWQ-_PUj4IEFkaKqEP-Sn1HvdPmymYZeK_WshKPDek
Message-ID: <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
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

On Tue, Sep 9, 2025 at 3:04=E2=80=AFPM Lei Liu <liulei.rjpt@vivo.com> wrote=
:
>

Hi Lei,

> 1. Problem Scenario
> On systems with ZRAM and swap enabled, simultaneous process exits create
> contention. The primary bottleneck occurs during swap entry release
> operations, causing exiting processes to monopolize CPU resources. This
> leads to scheduling delays for high-priority processes.
>
> 2. Android Use Case
> During camera launch, LMKD terminates background processes to free memory=
.
> Exiting processes compete for CPU cycles, delaying the camera preview
> thread and causing visible stuttering - directly impacting user
> experience.
>
> 3. Root Cause Analysis
> When background applications heavily utilize swap space, process exit
> profiling reveals 55% of time spent in free_swap_and_cache_nr():
>
> Function              Duration (ms)   Percentage
> do_signal               791.813     **********100%
> do_group_exit           791.813     **********100%
> do_exit                 791.813     **********100%
> exit_mm                 577.859        *******73%
> exit_mmap               577.497        *******73%
> zap_pte_range           558.645        *******71%
> free_swap_and_cache_nr  433.381          *****55%
> free_swap_slot          403.568          *****51%

Thanks for sharing this case.

One problem is that now the free_swap_slot function no longer exists
after 0ff67f990bd4. Have you tested the latest kernel? Or what is the
actual overhead here?

Some batch freeing optimizations are introduced. And we have reworked
the whole locking mechanism for swap, so even on a system with 96t the
contention seems barely observable with common workloads.

And another series is further reducing the contention and the overall
overhead (24% faster freeing for phase 1):
https://lore.kernel.org/linux-mm/20250905191357.78298-1-ryncsn@gmail.com/

Will these be helpful for you? I think optimizing the root problem is
better than just deferring the overhead with async workers, which may
increase the overall overhead and complexity.


> swap_entry_free         393.863          *****50%
> swap_range_free         372.602           ****47%
>
> 4. Optimization Approach
> a) For processes exceeding swap entry threshold: aggregate and isolate
> swap entries to enable fast exit
> b) Asynchronously release batched entries when isolation reaches
> configured threshold
>
> 5. Performance Gains (User Scenario: Camera Cold Launch)
> a) 74% reduction in process exit latency (>500ms cases)
> b) ~4% lower peak CPU load during concurrent process exits
> c) ~70MB additional free memory during camera preview initialization
> d) 40% reduction in camera preview stuttering probability
>
> 6. Prior Art & Improvements
> Reference: Zhiguo Jiang's patch
> (https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/)
>
> Key enhancements:
> a) Reimplemented logic moved from mmu_gather.c to swapfile.c for clarity
> b) Async release delegated to workqueue kworkers with configurable
> max_active for NUMA-optimized concurrency
>
> Lei Liu (2):
>   mm: swap: Gather swap entries and batch async release core
>   mm: swap: Forced swap entries release under memory pressure
>
>  include/linux/oom.h           |  23 ++++++
>  include/linux/swapfile.h      |   2 +
>  include/linux/vm_event_item.h |   1 +
>  kernel/exit.c                 |   2 +
>  mm/memcontrol.c               |   6 --
>  mm/memory.c                   |   4 +-
>  mm/page_alloc.c               |   4 +
>  mm/swapfile.c                 | 134 ++++++++++++++++++++++++++++++++++
>  mm/vmstat.c                   |   1 +
>  9 files changed, 170 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
>

