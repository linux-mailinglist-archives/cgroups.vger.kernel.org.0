Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D638821BEF9
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2020 23:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgGJVFT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jul 2020 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGJVFS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jul 2020 17:05:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B1C08C5DC
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2020 14:05:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so7521630eje.1
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2020 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knKCGO/TFZKmvezoCtPFxOWQQYS0S9SrfSJaD988IlQ=;
        b=ZwAlQGHv/53vyRlAA/pgP4ejQrYZEO9WBuZ97orWg9JVqECbBB1qAb9fzz1MXWBJLq
         xiYBseSkAnoLcPgAekoTjxZ+YTpFLZZqIgwAXEylYIDb+8OZRR/EKzVtx8oRlFH1aLiW
         6mr119vYLxGfTQVhJuQb7L6H9QyC9kaeTBf+DByR6WV7dCexpTqdjTDQkjJlPQwpTry+
         g28Ey5ba98fxDvcHP11mUbk2NCs4buS6+rP6MMV0EfczuazJATO04b0EHE3SmUcindIR
         nW3eUGt5re+JD3ug4x4fEKJsWZuZdhQo3fZAwK2h9TMg6pBJV3ZXKk4CTeh51GhKRPG4
         GxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knKCGO/TFZKmvezoCtPFxOWQQYS0S9SrfSJaD988IlQ=;
        b=aVbxcLZoLvMRUDPUE1qCj5p7RvvmWGb56zOILp2UVCv42bRpqmMXGSf7mVk2WYGfbD
         cHEZXEgUP/5gDc/Tm8ZcM8unmUPjxHIvc0/Au05UmReD9b0QAIarLNvUkVwLZMBSUKgf
         ld4k1E7Af5LouW2oQzIIEDP2k0PqXXXKnixOiODoMQn2pdu5sMZTivpuWtD70RTZw0ky
         MFbU1MV1IFeiGIQZwUTWUViIo+We34QXSXeMw+wLmCf7hVWhQgCWKMyWG3Hzzz6bhQt3
         u1/aNhPVC73f7IoNKtLxK6r9lVnBVxDfbB6gNgxgpQnLEVQeEy/vz1L6tOXylRW9kglK
         6Rhw==
X-Gm-Message-State: AOAM53074Mu85WxSQGg7Kehclur7G0OFBJljuljCA85OfDhWfw5T+m82
        BEFLUaYCo8tqcAGpE6pDO8CTssE8NHPD5ALCxaw=
X-Google-Smtp-Source: ABdhPJx2IUiJD1OxCtVUpCL5i2Fhcm7yWlqe4EFHqwKCrIDxNyKrGjlOCqwlULecplvCwT5kbqw2huLNx/tP9gMVO9I=
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr58596966ejb.488.1594415116480;
 Fri, 10 Jul 2020 14:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com>
 <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com>
 <20200703081538.GO18446@dhcp22.suse.cz> <alpine.DEB.2.23.453.2007071210410.396729@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2007101223470.1178541@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.23.453.2007101223470.1178541@chino.kir.corp.google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jul 2020 14:04:57 -0700
Message-ID: <CAHbLzkoCNt7GPrwN1uPEvd==-Lz9-j6-2RS0CCL0s2e-M_omiw@mail.gmail.com>
Subject: Re: Memcg stat for available memory
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 10, 2020 at 12:49 PM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 7 Jul 2020, David Rientjes wrote:
>
> > Another use case would be motivated by exactly the MemAvailable use case:
> > when bound to a memcg hierarchy, how much memory is available without
> > substantial swap or risk of oom for starting a new process or service?
> > This would not trigger any memory.low or PSI notification but is a
> > heuristic that can be used to determine what can and cannot be started
> > without incurring substantial memory reclaim.
> >
> > I'm indifferent to whether this would be a "reclaimable" or "available"
> > metric, with a slight preference toward making it as similar in
> > calculation to MemAvailable as possible, so I think the question is
> > whether this is something the user should be deriving themselves based on
> > memcg stats that are exported or whether we should solidify this based on
> > how the kernel handles reclaim as a metric that will carry over across
> > kernel vesions?
> >
>
> To try to get more discussion on the subject, consider a malloc
> implementation, like tcmalloc, that does MADV_DONTNEED to free memory back
> to the system and how this freed memory is then described to userspace
> depending on the kernel implementation.
>
>  [ For the sake of this discussion, consider we have precise memcg stats
>    available to us although the actual implementation allows for some
>    variance (MEMCG_CHARGE_BATCH). ]
>
> With a 64MB heap backed by thp on x86, for example, the vma starts with an
> rss of 64MB, all of which is anon and backed by hugepages.  Imagine some
> aggressive MADV_DONTNEED freeing that ends up with only a single 4KB page
> mapped in each 2MB aligned range.  The rss is now 32 * 4KB = 128KB.
>
> Before freeing, anon, anon_thp, and active_anon in memory.stat would all
> be the same for this vma (64MB).  64MB would also be charged to
> memory.current.  That's all working as intended and to the expectation of
> userspace.
>
> After freeing, however, we have the kernel implementation specific detail
> of how huge pmd splitting is handled (rss) in comparison to the underlying
> split of the compound page (deferred split queue).  The huge pmd is always
> split synchronously after MADV_DONTNEED so, as mentioned, the rss is 128KB
> for this vma and none of it is backed by thp.
>
> What is charged to the memcg (memory.current) and what is on active_anon
> is unchanged, however, because the underlying compound pages are still
> charged to the memcg.  The amount of anon and anon_thp are decreased
> in compliance with the splitting of the page tables, however.
>
> So after freeing, for this vma: anon = 128KB, anon_thp = 0,
> active_anon = 64MB, memory.current = 64MB.
>
> In this case, because of the deferred split queue, which is a kernel
> implementation detail, userspace may be unclear on what is actually
> reclaimable -- and this memory is reclaimable under memory pressure.  For
> the motivation of MemAvailable (what amount of memory is available for
> starting new work), userspace *could* determine this through the
> aforementioned active_anon - anon (or some combination of
> memory.current - anon - file - slab), but I think it's a fair point that
> userspace's view of reclaimable memory as the kernel implementation
> changes is something that can and should remain consistent between
> versions.
>
> Otherwise, an earlier implementation before deferred split queues could
> have safely assumed that active_anon was unreclaimable unless swap were
> enabled.  It doesn't have the foresight based on future kernel
> implementation detail to reconcile what the amount of reclaimable memory
> actually is.
>
> Same discussion could happen for lazy free memory which is anon but now
> appears on the file lru stats and not the anon lru stats: it's easily
> reclaimable under memory pressure but you need to reconcile the difference
> between the anon metric and what is revealed in the anon lru stats.
>
> That gave way to my original thought of a si_mem_available()-like
> calculation ("avail") by doing
>
>         free = memory.high - memory.current

I'm wondering what if high or max is set to max limit. Don't you end
up seeing a super large memavail?

>         lazyfree = file - (active_file + inactive_file)

Isn't it (active_file + inactive_file) - file ? It looks MADV_FREE
just updates inactive lru size.

>         deferred = active_anon - anon
>
>         avail = free + lazyfree + deferred +
>                 (active_file + inactive_file + slab_reclaimable) / 2
>
> And we have the ability to change this formula based on kernel
> implementation details as they evolve.  Idea is to provide a consistent
> field that userspace can use to determine the rough amount of reclaimable
> memory in a MemAvailable-like way.
>
