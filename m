Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D85787CA6
	for <lists+cgroups@lfdr.de>; Fri, 25 Aug 2023 02:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjHYAtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Aug 2023 20:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHYAta (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Aug 2023 20:49:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863331AD;
        Thu, 24 Aug 2023 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692924567; x=1724460567;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=SC3CeduAi6sdHjQnC1nP/afnUY7oCpZu6CQrcY684L0=;
  b=nZxl6YtDq6oe0vMJi7aRlBXzoHjP0srbA25AzSUuH/FuHV+26KDbn5eC
   paG64ifPJDzUQc8sGP+FIYWeSE5pbp5QFWow70v65A6T6Eh/cTDNbWJld
   /sUfax1lOD/X28O2mWB9AOf9lU0WxhJ+qWx68HFjrkv11zsztcyY0KNrW
   cPBPiOePtztZ4c+VQl5yiPpEoteVBmMiToblYWbjc6qC/JNGaJbteT0CK
   ytbe2uGuldUyyZPV5XjLfY4rQxDNZ2JqFwxIIWiL0aIaJNwmSJhsmuKd+
   9iNAJvmrNXpt/c1ApgqN5EzyAlWk479QDSlXQZIpRS2X8QjMn4OOiKMpj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354927219"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354927219"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 17:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="827386888"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827386888"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 17:49:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are
 swapcache pages
References: <20230822024901.2412520-1-liushixin2@huawei.com>
        <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
        <87wmxk6d1m.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAJD7tkbRyDt6cCo6_UJgt_51BznbTVQx+qX9LmSM7ThLfU+hQg@mail.gmail.com>
Date:   Fri, 25 Aug 2023 08:47:15 +0800
In-Reply-To: <CAJD7tkbRyDt6cCo6_UJgt_51BznbTVQx+qX9LmSM7ThLfU+hQg@mail.gmail.com>
        (Yosry Ahmed's message of "Thu, 24 Aug 2023 11:31:47 -0700")
Message-ID: <87sf8854oc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> On Thu, Aug 24, 2023 at 1:51=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>> > On Mon, Aug 21, 2023 at 6:54=E2=80=AFPM Liu Shixin <liushixin2@huawei.=
com> wrote:
>> >>
>> >> When spaces of swap devices are exhausted, only file pages can be rec=
laimed.
>> >> But there are still some swapcache pages in anon lru list. This can l=
ead
>> >> to a premature out-of-memory.
>> >>
>> >> This problem can be fixed by checking number of swapcache pages in
>> >> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat that=
 can
>> >> be used directly. For memcg v1, use total_swapcache_pages() instead, =
which
>> >> may not accurate but can solve the problem.
>> >
>> > Interesting find. I wonder if we really don't have any handling of
>> > this situation.
>> >
>> >>
>> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> >> ---
>> >>  include/linux/swap.h |  6 ++++++
>> >>  mm/memcontrol.c      |  8 ++++++++
>> >>  mm/vmscan.c          | 12 ++++++++----
>> >>  3 files changed, 22 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> >> index 456546443f1f..0318e918bfa4 100644
>> >> --- a/include/linux/swap.h
>> >> +++ b/include/linux/swap.h
>> >> @@ -669,6 +669,7 @@ static inline void mem_cgroup_uncharge_swap(swp_e=
ntry_t entry, unsigned int nr_p
>> >>  }
>> >>
>> >>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>> >> +extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *mem=
cg);
>> >>  extern bool mem_cgroup_swap_full(struct folio *folio);
>> >>  #else
>> >>  static inline void mem_cgroup_swapout(struct folio *folio, swp_entry=
_t entry)
>> >> @@ -691,6 +692,11 @@ static inline long mem_cgroup_get_nr_swap_pages(=
struct mem_cgroup *memcg)
>> >>         return get_nr_swap_pages();
>> >>  }
>> >>
>> >> +static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgro=
up *memcg)
>> >> +{
>> >> +       return total_swapcache_pages();
>> >> +}
>> >> +
>> >>  static inline bool mem_cgroup_swap_full(struct folio *folio)
>> >>  {
>> >>         return vm_swap_full();
>> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> >> index e8ca4bdcb03c..3e578f41023e 100644
>> >> --- a/mm/memcontrol.c
>> >> +++ b/mm/memcontrol.c
>> >> @@ -7567,6 +7567,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_c=
group *memcg)
>> >>         return nr_swap_pages;
>> >>  }
>> >>
>> >> +long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
>> >> +{
>> >> +       if (mem_cgroup_disabled() || do_memsw_account())
>> >> +               return total_swapcache_pages();
>> >> +
>> >> +       return memcg_page_state(memcg, NR_SWAPCACHE);
>> >> +}
>> >
>> > Is there a reason why we cannot use NR_SWAPCACHE for cgroup v1? Isn't
>> > that being maintained regardless of cgroup version? It is not exposed
>> > in cgroup v1's memory.stat, but I don't think there is a reason we
>> > can't do that -- if only to document that it is being used with cgroup
>> > v1.
>> >
>> >
>> >> +
>> >>  bool mem_cgroup_swap_full(struct folio *folio)
>> >>  {
>> >>         struct mem_cgroup *memcg;
>> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> >> index 7c33c5b653ef..bcb6279cbae7 100644
>> >> --- a/mm/vmscan.c
>> >> +++ b/mm/vmscan.c
>> >> @@ -609,13 +609,17 @@ static inline bool can_reclaim_anon_pages(struc=
t mem_cgroup *memcg,
>> >>         if (memcg =3D=3D NULL) {
>> >>                 /*
>> >>                  * For non-memcg reclaim, is there
>> >> -                * space in any swap device?
>> >> +                * space in any swap device or swapcache pages?
>> >>                  */
>> >> -               if (get_nr_swap_pages() > 0)
>> >> +               if (get_nr_swap_pages() + total_swapcache_pages() > 0)
>> >>                         return true;
>> >>         } else {
>> >> -               /* Is the memcg below its swap limit? */
>> >> -               if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
>> >> +               /*
>> >> +                * Is the memcg below its swap limit or is there swap=
cache
>> >> +                * pages can be freed?
>> >> +                */
>> >> +               if (mem_cgroup_get_nr_swap_pages(memcg) +
>> >> +                   mem_cgroup_get_nr_swapcache_pages(memcg) > 0)
>> >>                         return true;
>> >>         }
>> >
>> > I wonder if it would be more efficient to set a bit in struct
>> > scan_control if we only are out of swap spaces but have swap cache
>> > pages, and only isolate anon pages that are in the swap cache, instead
>> > of isolating random anon pages. We may end up isolating pages that are
>> > not in the swap cache for a few iterations and wasting cycles.
>>
>> Scanning swap cache directly will make the code more complex.  IIUC, the
>> possibility for the swap device to be used up isn't high.  If so, I
>> prefer the simpler implementation as that in this series.
>
> I did not mean that, sorry if I wasn't clear. I meant to set a bit in
> struct scan_control, and then in isolate_lru_folios() for anon lrus,
> we can skip isolating folios that are not in the swapcache if that bit
> is set.
>
> My main concern was that if we have a few pages in the swapcache we
> may end up wasting cycles scanning through a lot of other anonymous
> pages until we reach them. If that's too much complexity that's
> understandable.

Sorry, I misunderstood your idea.  This sounds reasonable to me.  We can
check swap space and swap cache in isolate_lru_folios(), either in
isolate_lru_folios() directly, or via a bit in scan_control.

--
Best Regards,
Huang, Ying
