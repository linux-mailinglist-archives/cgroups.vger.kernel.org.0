Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4591A222D68
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 23:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgGPVH1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 17:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGPVH0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 17:07:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DAC061755
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 14:07:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so4698626lfl.5
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 14:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhmDaILswOyhVmyQVKz/Z67YTyZBy2pEH48DYKPsglc=;
        b=StyuY3xC0ybEf9QINn+RLCRsWzzEN/szSnXWiOqdTmdW3ZAel0T/Sj3SEJBKB97mgj
         anlMNSLshuKogTtaoTG5cp+JfZ/3QcoR052KjfsH/tGzTh84cQG/fqKQSxaQHh0CDcog
         z+PXiPEBETIqEpFh+qwbaST05eRFXoWXt6YhcCvf9KsfmZzPfvEdXwYbnmqQ8jLyJlRz
         CCDpJsSJeB7LZH9gMUrJSVky6IAEw3NqNRinv9GmhlGUN1GdUzuUe3vKNQhqMjPOE8x+
         iaDYXyHTDrsdZj4M9EjwhCejQQdE71k+YZ1/XFUaCiYpXlvL5bdm9aIrjrctvM1cp40o
         SKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhmDaILswOyhVmyQVKz/Z67YTyZBy2pEH48DYKPsglc=;
        b=YTlv7nVWNZx6syojT5KuWpogmMHF++owq+MllBuMjakqKTz4yRM3k/IYeqsjmZQci+
         Xq7aHi8B9SnR5BcYXh5cM1ta0FhlPAprhWDM9BfmElSKfaOh0GhU6Ja3ZSYukl8iEPBP
         I1iOM0Ns2/f5+IQy5rHUdhZswKhDdDcXJl0l+Mv4ibx1dsoG8Yp0kUZd53HwObH+1Q0f
         YFCvBh194NDl7KgCDo0eklrvb8LxnQ9JiNJFSn55ccs9w07EsQe9TPNI/gJfj65AV6nV
         8JJcJFlQGb9IxPYGyNsfwHobvGFnoF3AQaqb6RdWn80nCN82+NYetSJ+WjT6YOSgcrMO
         LhGg==
X-Gm-Message-State: AOAM532+9lOCv3zuwHH3d+fmyt1ZAJwKxwa52UyQESZmpUdhAwR0DyGN
        zayKcaaf0NF+qbn7gLfylmP89/4FfCgnI3I/X60WFQ==
X-Google-Smtp-Source: ABdhPJxJ8X8NYyUdZh6Qz2L6YvnD2ZNiBBysvaXRqhZDv4vhxV1qwjb8wEgBFdcV/Jg8h1AkcYhYzCHH7gk1brgG0QM=
X-Received: by 2002:ac2:4183:: with SMTP id z3mr241606lfh.3.1594933644436;
 Thu, 16 Jul 2020 14:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200715071522.19663-1-sjpark@amazon.com> <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 16 Jul 2020 14:07:13 -0700
Message-ID: <CALvZod6DbAUA-M9VXJW4RumeUD8qGf+BHM+9TUNeAr92JVkxsA@mail.gmail.com>
Subject: Re: [patch] mm, memcg: provide an anon_reclaimable stat
To:     David Rientjes <rientjes@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 16, 2020 at 1:58 PM David Rientjes <rientjes@google.com> wrote:
>
> Userspace can lack insight into the amount of memory that can be reclaimed
> from a memcg based on values from memory.stat.  Two specific examples:
>
>  - Lazy freeable memory (MADV_FREE) that are clean anonymous pages on the
>    inactive file LRU that can be quickly reclaimed under memory pressure
>    but otherwise shows up as mapped anon in memory.stat, and
>
>  - Memory on deferred split queues (thp) that are compound pages that can
>    be split and uncharged from the memcg under memory pressure, but
>    otherwise shows up as charged anon LRU memory in memory.stat.
>
> Both of this anonymous usage is also charged to memory.current.
>
> Userspace can currently derive this information but it depends on kernel
> implementation details for how this memory is handled for the purposes of
> reclaim (anon on inactive file LRU or unmapped anon on the LRU).
>
> For the purposes of writing portable userspace code that does not need to
> have insight into the kernel implementation for reclaimable memory, this
> exports a stat that reveals the amount of anonymous memory that can be
> reclaimed and uncharged from the memcg to start new applications.
>
> As the kernel implementation evolves for memory that can be reclaimed
> under memory pressure, this stat can be kept consistent.
>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 +++++
>  mm/memcontrol.c                         | 31 +++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1296,6 +1296,12 @@ PAGE_SIZE multiple when read back.
>                 Amount of memory used in anonymous mappings backed by
>                 transparent hugepages
>
> +         anon_reclaimable
> +               The amount of charged anonymous memory that can be reclaimed
> +               under memory pressure without swap.  This currently includes
> +               lazy freeable memory (MADV_FREE) and compound pages that can be
> +               split and uncharged.
> +
>           inactive_anon, active_anon, inactive_file, active_file, unevictable
>                 Amount of memory, swap-backed and filesystem-backed,
>                 on the internal memory management lists used by the
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1350,6 +1350,32 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>         return false;
>  }
>
> +/*
> + * Returns the amount of anon memory that is charged to the memcg that is
> + * reclaimable under memory pressure without swap, in pages.
> + */
> +static unsigned long memcg_anon_reclaimable(struct mem_cgroup *memcg)
> +{
> +       long deferred, lazyfree;
> +
> +       /*
> +        * Deferred pages are charged anonymous pages that are on the LRU but
> +        * are unmapped.  These compound pages are split under memory pressure.
> +        */
> +       deferred = max_t(long, memcg_page_state(memcg, NR_ACTIVE_ANON) +
> +                              memcg_page_state(memcg, NR_INACTIVE_ANON) -
> +                              memcg_page_state(memcg, NR_ANON_MAPPED), 0);

Please note that the NR_ANON_MAPPED does not include tmpfs memory but
NR_[IN]ACTIVE_ANON does include the tmpfs.

> +       /*
> +        * Lazyfree pages are charged clean anonymous pages that are on the file
> +        * LRU and can be reclaimed under memory pressure.
> +        */
> +       lazyfree = max_t(long, memcg_page_state(memcg, NR_ACTIVE_FILE) +
> +                              memcg_page_state(memcg, NR_INACTIVE_FILE) -
> +                              memcg_page_state(memcg, NR_FILE_PAGES), 0);

Similarly NR_FILE_PAGES includes tmpfs memory but NR_[IN]ACTIVE_FILE does not.
