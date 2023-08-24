Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9987877ED
	for <lists+cgroups@lfdr.de>; Thu, 24 Aug 2023 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbjHXSch (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Aug 2023 14:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbjHXScc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Aug 2023 14:32:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3BB1BF6
        for <cgroups@vger.kernel.org>; Thu, 24 Aug 2023 11:32:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a18a4136a9so7662266b.2
        for <cgroups@vger.kernel.org>; Thu, 24 Aug 2023 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692901943; x=1693506743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+3+dmlDnZFrI+rLYEmzONKPLNzgiZ+Y0780EKixBdg=;
        b=VaTMowRbb97l4wYN4V2TLMO0Cysl0+5fgFw3XRKsQ8NPtmJDHYaNb/FZgIWGmAScXP
         i0m3sP8CYsNfnkCAZqhTLk69U2t4Su8N7fzPHkjWzf6woVlnpYeTFJOdjbopcSU9YCiF
         K5VOjyT+0YB8As89VDM4WJ2PBnhiuDLKYnwTdtz1IUhQtKgNCsdNHwF2TmL6CKAbhRVe
         ELJuJ7gUgXTjR2og1xgmSII2lWgoERtPErGIHtCAqigeM9aQoBfeCqpKRZXLtV8M6NjX
         a0hkF1seKyj1+2BALJuILa8X+9xvHZMEWnp1iBRL2vVChfej1BhDCaLnelJCStbdNT/J
         saMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901943; x=1693506743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+3+dmlDnZFrI+rLYEmzONKPLNzgiZ+Y0780EKixBdg=;
        b=K3UfBe/y7kkt9RcrahwhBkvIt6BtHuR1zM4lKzhkR1a5SQ7CiDfjL1SnHHN/yGYj7T
         VM9p89tPtg7XQp8sgPZGLroIAurpTeLcGtkZ8Jth2EOn5TmXpl1jP33YBD4JpTL4r129
         MU5ttmf8F2Vq+Rf9KYVVdVWRUUqwEEA1afKtsMc1leZWf2tS9Zg+zQ0c4/W1L9Uz2zpA
         hMgfJAXs+voMGImRB/YbBIjG7i8ooB01z1VW6WyKYDkuN+LBJPuxpsLSCdOX+dQfL9ij
         1f5UrBVTMHf8XLHkzLD3wU3MYsTpOISOHNQFHIZxXq5ITqFKu8cnmFBhQNELdFAe+ff2
         wzJw==
X-Gm-Message-State: AOJu0Yx077cFTBQRIiQdTnAaQ8O0L4BnjmpPf66F74PY/IbZli3yprTY
        jrBSPi2ET2iTvZBMCMgFBHXq+JOppWQehn3wrOVdUxBb2QBB5ssDzdXPzmnM
X-Google-Smtp-Source: AGHT+IHJSKeLVD6DR6KD6Xl66mDzcoycjKCoC9D3oU+ptw9RIDjabfvwWZJS27LYyh3lvexlD3+GdljBpK6hwuC4Fp4=
X-Received: by 2002:a17:906:5307:b0:9a2:40e:2cad with SMTP id
 h7-20020a170906530700b009a2040e2cadmr2354481ejo.48.1692901943411; Thu, 24 Aug
 2023 11:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230822024901.2412520-1-liushixin2@huawei.com>
 <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com> <87wmxk6d1m.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmxk6d1m.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 24 Aug 2023 11:31:47 -0700
Message-ID: <CAJD7tkbRyDt6cCo6_UJgt_51BznbTVQx+qX9LmSM7ThLfU+hQg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache pages
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 24, 2023 at 1:51=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Aug 21, 2023 at 6:54=E2=80=AFPM Liu Shixin <liushixin2@huawei.c=
om> wrote:
> >>
> >> When spaces of swap devices are exhausted, only file pages can be recl=
aimed.
> >> But there are still some swapcache pages in anon lru list. This can le=
ad
> >> to a premature out-of-memory.
> >>
> >> This problem can be fixed by checking number of swapcache pages in
> >> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat that =
can
> >> be used directly. For memcg v1, use total_swapcache_pages() instead, w=
hich
> >> may not accurate but can solve the problem.
> >
> > Interesting find. I wonder if we really don't have any handling of
> > this situation.
> >
> >>
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >> ---
> >>  include/linux/swap.h |  6 ++++++
> >>  mm/memcontrol.c      |  8 ++++++++
> >>  mm/vmscan.c          | 12 ++++++++----
> >>  3 files changed, 22 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index 456546443f1f..0318e918bfa4 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_en=
try_t entry, unsigned int nr_p
> >>  }
> >>
> >>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> >> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memc=
g);
> >>  extern bool mem_cgroup_swap_full(struct folio *folio);
> >>  #else
> >>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_=
t entry)
> >> @@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(s=
truct mem_cgroup *memcg)
> >>         return get_nr_swap_pages();
> >>  }
> >>
> >> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgrou=
p *memcg)
> >> +{
> >> +       return total_swapcache_pages();
> >> +}
> >> +
> >>  static inline bool mem_cgroup_swap_full(struct folio *folio)
> >>  {
> >>         return vm_swap_full();
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index e8ca4bdcb03c..3e578f41023e 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cg=
roup *memcg)
> >>         return nr_swap_pages;
> >>  }
> >>
> >> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
> >> +{
> >> +       if (mem_cgroup_disabled() || do_memsw_account())
> >> +               return total_swapcache_pages();
> >> +
> >> +       return memcg_page_state(memcg, NR_SWAPCACHE);
> >> +}
> >
> > Is there a reason why we cannot use NR_SWAPCACHE for cgroup v1? Isn't
> > that being maintained regardless of cgroup version? It is not exposed
> > in cgroup v1's memory.stat, but I don't think there is a reason we
> > can't do that -- if only to document that it is being used with cgroup
> > v1.
> >
> >
> >> +
> >>  bool mem_cgroup_swap_full(struct folio *folio)
> >>  {
> >>         struct mem_cgroup *memcg;
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 7c33c5b653ef..bcb6279cbae7 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -609,13 +609,17 @@ static inline bool can_reclaim_anon_pages(struct=
 mem_cgroup *memcg,
> >>         if (memcg =3D=3D NULL) {
> >>                 /*
> >>                  * For non-memcg reclaim, is there
> >> -                * space in any swap device?
> >> +                * space in any swap device or swapcache pages?
> >>                  */
> >> -               if (get_nr_swap_pages() > 0)
> >> +               if (get_nr_swap_pages() + total_swapcache_pages() > 0)
> >>                         return true;
> >>         } else {
> >> -               /* Is the memcg below its swap limit? */
> >> -               if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
> >> +               /*
> >> +                * Is the memcg below its swap limit or is there swapc=
ache
> >> +                * pages can be freed?
> >> +                */
> >> +               if (mem_cgroup_get_nr_swap_pages(memcg) +
> >> +                   mem_cgroup_get_nr_swapcache_pages(memcg) > 0)
> >>                         return true;
> >>         }
> >
> > I wonder if it would be more efficient to set a bit in struct
> > scan_control if we only are out of swap spaces but have swap cache
> > pages, and only isolate anon pages that are in the swap cache, instead
> > of isolating random anon pages. We may end up isolating pages that are
> > not in the swap cache for a few iterations and wasting cycles.
>
> Scanning swap cache directly will make the code more complex.  IIUC, the
> possibility for the swap device to be used up isn't high.  If so, I
> prefer the simpler implementation as that in this series.

I did not mean that, sorry if I wasn't clear. I meant to set a bit in
struct scan_control, and then in isolate_lru_folios() for anon lrus,
we can skip isolating folios that are not in the swapcache if that bit
is set.

My main concern was that if we have a few pages in the swapcache we
may end up wasting cycles scanning through a lot of other anonymous
pages until we reach them. If that's too much complexity that's
understandable.

>
> --
> Best Regards,
> Huang, Ying
