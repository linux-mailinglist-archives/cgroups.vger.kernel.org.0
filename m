Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D8612EC4
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 02:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJaB5N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 21:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaB5M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 21:57:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9895B5;
        Sun, 30 Oct 2022 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667181431; x=1698717431;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=GNeMy0+rkU8bzJflExJakiVFZ25hLlIrgDvJ2rJh3I4=;
  b=Lpd4CxFzE5sDbfD7/9jQjSX/8G8uavuTtDtCJvXYLohMyfn+99kr7gYQ
   ubvyvyghKFaFvdbQuadmd9BKnZBYi7JDgxzJzAjgjIT1FcUVgQK0b7dK5
   AIT+UuP1T2Ix2OyaALGQM24pEsBsh1MaMXclSbJNa5JY/mB6K25sKzRMB
   DrRSw6jFAOlqcckwf//wfjWlrKLnlcJ8IgP070mhWmFkuXgx7XdSD7Cma
   OrsjeycGKQXEg+X7iBwIgRtYG8LGtA+XYxKxlLwYfTUckgKGD4HXnT7n1
   x8kAE+Ei6C3klJKGMwm49j6bWL3OF7Wd41a0SQzR7PxUOdw67ljh/N4nv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="310494533"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="310494533"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:57:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="878563686"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="878563686"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:57:07 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>, "Hocko, Michal" <mhocko@suse.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
References: <20221026074343.6517-1-feng.tang@intel.com>
        <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
        <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
        <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
        <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
        <Y1ovOeEPXT1fxCuc@feng-clx>
        <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
        <Y1tOigFZeDzjPGsv@feng-clx>
        <87y1t0ijbk.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHbLzkpO46yTiSVrKWRnABNW_PutuudEkB3RD-_YKxamW9SyaA@mail.gmail.com>
Date:   Mon, 31 Oct 2022 09:56:28 +0800
In-Reply-To: <CAHbLzkpO46yTiSVrKWRnABNW_PutuudEkB3RD-_YKxamW9SyaA@mail.gmail.com>
        (Yang Shi's message of "Fri, 28 Oct 2022 10:23:53 -0700")
Message-ID: <878rkweoxf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Thu, Oct 27, 2022 at 10:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Feng Tang <feng.tang@intel.com> writes:
>>
>> > On Thu, Oct 27, 2022 at 10:55:58AM -0700, Yang Shi wrote:
>> >> On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
>> >> >
>> >> > On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
>> >> > > On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
>> >> > [...]
>> >> > > > > > This all can get quite expensive so the primary question is, does the
>> >> > > > > > existing behavior generates any real issues or is this more of an
>> >> > > > > > correctness exercise? I mean it certainly is not great to demote to an
>> >> > > > > > incompatible numa node but are there any reasonable configurations when
>> >> > > > > > the demotion target node is explicitly excluded from memory
>> >> > > > > > policy/cpuset?
>> >> > > > >
>> >> > > > > We haven't got customer report on this, but there are quite some customers
>> >> > > > > use cpuset to bind some specific memory nodes to a docker (You've helped
>> >> > > > > us solve a OOM issue in such cases), so I think it's practical to respect
>> >> > > > > the cpuset semantics as much as we can.
>> >> > > >
>> >> > > > Yes, it is definitely better to respect cpusets and all local memory
>> >> > > > policies. There is no dispute there. The thing is whether this is really
>> >> > > > worth it. How often would cpusets (or policies in general) go actively
>> >> > > > against demotion nodes (i.e. exclude those nodes from their allowes node
>> >> > > > mask)?
>> >> > > >
>> >> > > > I can imagine workloads which wouldn't like to get their memory demoted
>> >> > > > for some reason but wouldn't it be more practical to tell that
>> >> > > > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> >> > > > policies explicitly?
>> >> > > >
>> >> > > > > Your concern about the expensive cost makes sense! Some raw ideas are:
>> >> > > > > * if the shrink_folio_list is called by kswapd, the folios come from
>> >> > > > >   the same per-memcg lruvec, so only one check is enough
>> >> > > > > * if not from kswapd, like called form madvise or DAMON code, we can
>> >> > > > >   save a memcg cache, and if the next folio's memcg is same as the
>> >> > > > >   cache, we reuse its result. And due to the locality, the real
>> >> > > > >   check is rarely performed.
>> >> > > >
>> >> > > > memcg is not the expensive part of the thing. You need to get from page
>> >> > > > -> all vmas::vm_policy -> mm -> task::mempolicy
>> >> > >
>> >> > > Yeah, on the same page with Michal. Figuring out mempolicy from page
>> >> > > seems quite expensive and the correctness can't be guranteed since the
>> >> > > mempolicy could be set per-thread and the mm->task depends on
>> >> > > CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
>> >> >
>> >> > Yes, you are right. Our "working" psudo code for mem policy looks like
>> >> > what Michal mentioned, and it can't work for all cases, but try to
>> >> > enforce it whenever possible:
>> >> >
>> >> > static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
>> >> >                 unsigned long addr, void *arg)
>> >> > {
>> >> >         bool *skip_demotion = arg;
>> >> >         struct mempolicy *mpol;
>> >> >         int nid, dnid;
>> >> >         bool ret = true;
>> >> >
>> >> >         mpol = __get_vma_policy(vma, addr);
>> >> >         if (!mpol) {
>> >> >                 struct task_struct *task;
>> >> >                 if (vma->vm_mm)
>> >> >                         task = vma->vm_mm->owner;
>> >>
>> >> But this task may not be the task you want IIUC. For example, the
>> >> process has two threads, A and B. They have different mempolicy. The
>> >> vmscan is trying to demote a page belonging to thread A, but the task
>> >> may point to thread B, so you actually get the wrong mempolicy IIUC.
>> >
>> > Yes, this is a valid concern! We don't have good solution for this.
>> > For memory policy, we may only handle the per-vma policy for now whose
>> > cost is relatively low, as a best-effort try.
>>
>> Yes.  The solution isn't perfect, especially for multiple-thread
>> processes with thread specific memory policy.  But the proposed code
>> above can support the most common cases at least, that is, run workload
>> with `numactl`.
>
> Not only multi threads, but also may be broken for shared pages. When
> you do rmap walk, you may get multiple contradict mempolicy, which one
> would you like to obey?
>
> TBH I'm not sure whether such half-baked solution is worth it or not,
> at least at this moment. The cost is not cheap, but the gain may not
> be worth it IMHO.

Per my understanding, this can cover most cases.  For example, run
workload with `numactl`, or control the page placement of some memory
areas via mbind().  Although there are some issue in the corner cases.

Best Regards,
Huang, Ying
