Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E269F212C96
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2020 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGBSzu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jul 2020 14:55:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgGBSzu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jul 2020 14:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593716147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bv4WKkdC+fvRUd3hbwVt1FRHxjhG8fwl0G5V2XBrHX8=;
        b=J0W/rS5yebJewEkHhIoWJEX6mOo8/qv3w6C20bq7FEgdGwN2irLh55N5fjAFkTGVfRApxE
        bfqdxNbnl5cn3U7pC+oDI8uKWslWwa1FPYTZN0sbbEZVuWwlCwX9N9I1LfJASl1TwtpMgb
        0gcIiAIghC8JcYDM/ugtAGlo4ZqOB9A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-H2HRtV2VO2K-o-UBzErk5w-1; Thu, 02 Jul 2020 14:55:42 -0400
X-MC-Unique: H2HRtV2VO2K-o-UBzErk5w-1
Received: by mail-qt1-f198.google.com with SMTP id l14so631585qtr.2
        for <cgroups@vger.kernel.org>; Thu, 02 Jul 2020 11:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bv4WKkdC+fvRUd3hbwVt1FRHxjhG8fwl0G5V2XBrHX8=;
        b=S/qQCBzlyGfRKndbwYtwYQV56YGKYhg2KOAqL6l0LIdqLz1PgEpIB0ipKswWTK5ptn
         BxoGdVPhP3jQdbBP5FQnXUP9s4kom1TlVa654qPMFksAG/ud+rZDEPyfbhQRG/+xqNly
         9ch+rF4xETnea9oPpMPELLRpqnZFAQ1AToiKZ1unJq0z/4y8mobQqqpXmYipzPBE2PcJ
         Lqzg5dhl/nYaAReBx6blNv5r8qOhPBdyreZ7wB1ND/MPolkxPtKbZsEKaOs/EmESlJcH
         oFq0UPBgTGm2dB9HbAgKw49TH/7HBqmqc39AIvh0g10c/kKfJcTM64hCdY8QUPL0pbP7
         Z/6Q==
X-Gm-Message-State: AOAM531eKVYskZfSfYH88Lrz6jsPA+qPa+2TrJxwVwDLkJ3o6ra3lVYc
        uQ7dRVWR6z8+gmYXdTTHKeQOCFCbsY4hEOrDCBlqGspuX0KbfolEys97/QvlaNxfTXrgTzr4PhJ
        A3cF2/5TnrdCenitcWJJoZW1M8INTzyosUw==
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr30837128qka.29.1593716141433;
        Thu, 02 Jul 2020 11:55:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC/GKhfGSPW/4u2gS6vbyX3rvreRTTq9PBRiST/sZ1yzsqE82Z8QEBNCcVVf9zm6QL4FO/GBvYlD3O8+Du2w4=
X-Received: by 2002:a05:620a:a1d:: with SMTP id i29mr30837101qka.29.1593716141105;
 Thu, 02 Jul 2020 11:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
 <1593641660-13254-2-git-send-email-bhsharma@redhat.com> <20200702060024.GA18446@dhcp22.suse.cz>
In-Reply-To: <20200702060024.GA18446@dhcp22.suse.cz>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Fri, 3 Jul 2020 00:25:29 +0530
Message-ID: <CACi5LpPhCSzRbY=f0pAy5pMkgQWuScHs0qzChDZgy1hjYsjyRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/memcontrol: Fix OOPS inside mem_cgroup_get_nr_swap_pages()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Thu, Jul 2, 2020 at 11:30 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 02-07-20 03:44:19, Bhupesh Sharma wrote:
> > Prabhakar reported an OOPS inside mem_cgroup_get_nr_swap_pages()
> > function in a corner case seen on some arm64 boards when kdump kernel
> > runs with "cgroup_disable=memory" passed to the kdump kernel via
> > bootargs.
> >
> > The root-cause behind the same is that currently mem_cgroup_swap_init()
> > function is implemented as a subsys_initcall() call instead of a
> > core_initcall(), this means 'cgroup_memory_noswap' still
> > remains set to the default value (false) even when memcg is disabled via
> > "cgroup_disable=memory" boot parameter.
> >
> > This may result in premature OOPS inside mem_cgroup_get_nr_swap_pages()
> > function in corner cases:
> >
> >   [    0.265617] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000188
> >   [    0.274495] Mem abort info:
> >   [    0.277311]   ESR = 0x96000006
> >   [    0.280389]   EC = 0x25: DABT (current EL), IL = 32 bits
> >   [    0.285751]   SET = 0, FnV = 0
> >   [    0.288830]   EA = 0, S1PTW = 0
> >   [    0.291995] Data abort info:
> >   [    0.294897]   ISV = 0, ISS = 0x00000006
> >   [    0.298765]   CM = 0, WnR = 0
> >   [    0.301757] [0000000000000188] user address but active_mm is swapper
> >   [    0.308174] Internal error: Oops: 96000006 [#1] SMP
> >   [    0.313097] Modules linked in:
> >   <..snip..>
> >   [    0.331384] pstate: 00400009 (nzcv daif +PAN -UAO BTYPE=--)
> >   [    0.337014] pc : mem_cgroup_get_nr_swap_pages+0x9c/0xf4
> >   [    0.342289] lr : mem_cgroup_get_nr_swap_pages+0x68/0xf4
> >   [    0.347564] sp : fffffe0012b6f800
> >   [    0.350905] x29: fffffe0012b6f800 x28: fffffe00116b3000
> >   [    0.356268] x27: fffffe0012b6fb00 x26: 0000000000000020
> >   [    0.361631] x25: 0000000000000000 x24: fffffc00723ffe28
> >   [    0.366994] x23: fffffe0010d5b468 x22: fffffe00116bfa00
> >   [    0.372357] x21: fffffe0010aabda8 x20: 0000000000000000
> >   [    0.377720] x19: 0000000000000000 x18: 0000000000000010
> >   [    0.383082] x17: 0000000043e612f2 x16: 00000000a9863ed7
> >   [    0.388445] x15: ffffffffffffffff x14: 202c303d70617773
> >   [    0.393808] x13: 6f6e5f79726f6d65 x12: 6d5f70756f726763
> >   [    0.399170] x11: 2073656761705f70 x10: 6177735f726e5f74
> >   [    0.404533] x9 : fffffe00100e9580 x8 : fffffe0010628160
> >   [    0.409895] x7 : 00000000000000a8 x6 : fffffe00118f5e5e
> >   [    0.415258] x5 : 0000000000000001 x4 : 0000000000000000
> >   [    0.420621] x3 : 0000000000000000 x2 : 0000000000000000
> >   [    0.425983] x1 : 0000000000000000 x0 : fffffc0060079000
> >   [    0.431346] Call trace:
> >   [    0.433809]  mem_cgroup_get_nr_swap_pages+0x9c/0xf4
> >   [    0.438735]  shrink_lruvec+0x404/0x4f8
> >   [    0.442516]  shrink_node+0x1a8/0x688
> >   [    0.446121]  do_try_to_free_pages+0xe8/0x448
> >   [    0.450429]  try_to_free_pages+0x110/0x230
> >   [    0.454563]  __alloc_pages_slowpath.constprop.106+0x2b8/0xb48
> >   [    0.460366]  __alloc_pages_nodemask+0x2ac/0x2f8
> >   [    0.464938]  alloc_page_interleave+0x20/0x90
> >   [    0.469246]  alloc_pages_current+0xdc/0xf8
> >   [    0.473379]  atomic_pool_expand+0x60/0x210
> >   [    0.477514]  __dma_atomic_pool_init+0x50/0xa4
> >   [    0.481910]  dma_atomic_pool_init+0xac/0x158
> >   [    0.486220]  do_one_initcall+0x50/0x218
> >   [    0.490091]  kernel_init_freeable+0x22c/0x2d0
> >   [    0.494489]  kernel_init+0x18/0x110
> >   [    0.498007]  ret_from_fork+0x10/0x18
> >   [    0.501614] Code: aa1403e3 91106000 97f82a27 14000011 (f940c663)
> >   [    0.507770] ---[ end trace 9795948475817de4 ]---
> >   [    0.512429] Kernel panic - not syncing: Fatal exception
> >   [    0.517705] Rebooting in 10 seconds..
> >
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: cgroups@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: kexec@lists.infradead.org
>
> Fixes: eccb52e78809 ("mm: memcontrol: prepare swap controller setup for integration")
>
> > Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>
> This is subtle as hell, I have to say. I find the ordering in the init
> calls very unintuitive and extremely hard to follow. The above commit
> has introduced the problem but the code previously has worked mostly by
> a luck because our default was flipped.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for reviewing the patch. Indeed its quite a corner case seen
only selected arm64 machines.

Regards,
Bhupesh

> > ---
> >  mm/memcontrol.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 19622328e4b5..8323e4b7b390 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7186,6 +7186,13 @@ static struct cftype memsw_files[] = {
> >       { },    /* terminate */
> >  };
> >
> > +/*
> > + * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
> > + * instead of a core_initcall(), this could mean cgroup_memory_noswap still
> > + * remains set to false even when memcg is disabled via "cgroup_disable=memory"
> > + * boot parameter. This may result in premature OOPS inside
> > + * mem_cgroup_get_nr_swap_pages() function in corner cases.
> > + */
> >  static int __init mem_cgroup_swap_init(void)
> >  {
> >       /* No memory control -> no swap control */
> > @@ -7200,6 +7207,6 @@ static int __init mem_cgroup_swap_init(void)
> >
> >       return 0;
> >  }
> > -subsys_initcall(mem_cgroup_swap_init);
> > +core_initcall(mem_cgroup_swap_init);
> >
> >  #endif /* CONFIG_MEMCG_SWAP */
> > --
> > 2.7.4
>
> --
> Michal Hocko
> SUSE Labs
>

