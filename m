Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2390A6109F1
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJ1Fzl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 01:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJ1Fzk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 01:55:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699119DDA7;
        Thu, 27 Oct 2022 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666936539; x=1698472539;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Xo5Bp9TEV4yhmyMtrA7KFkUbHGYJBTStr4zJyd73urs=;
  b=nw5cQlzVNsVXn2HMz2FFsE2vIr9igzHtbL+ZsxcFVrEO1iiU1+2mr5KD
   OE/71xpdiUG7tFSUoChavIyX945/ZBYco7PnCf7tSOwWvPqUJGKretjFR
   XaOvpaP37EGB5x1sRL3nF1kbX3MVVTNbKg7kaf7oc3iN47FHnKEvum/23
   B3w5d9J/4EBg24KawW1vP2Rgkq+4K1b3JpmdbTrG0su8uobiS9oevrumO
   5cz8bkabMuY9RPyKT/gDfWRHrTjULlxAAIGBlvE3wIKjWv6p3EP8q0rRP
   Szh4emyjV4rW7EYYG8wGx5iMLEiJibg7RSMDBFqec/lYfko1b6Cl45YZN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="370483495"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="370483495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 22:55:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="877848613"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="877848613"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 22:55:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, "Hocko, Michal" <mhocko@suse.com>,
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
Date:   Fri, 28 Oct 2022 13:54:55 +0800
In-Reply-To: <Y1tOigFZeDzjPGsv@feng-clx> (Feng Tang's message of "Fri, 28 Oct
        2022 11:37:46 +0800")
Message-ID: <87y1t0ijbk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:

> On Thu, Oct 27, 2022 at 10:55:58AM -0700, Yang Shi wrote:
>> On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
>> >
>> > On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
>> > > On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
>> > [...]
>> > > > > > This all can get quite expensive so the primary question is, does the
>> > > > > > existing behavior generates any real issues or is this more of an
>> > > > > > correctness exercise? I mean it certainly is not great to demote to an
>> > > > > > incompatible numa node but are there any reasonable configurations when
>> > > > > > the demotion target node is explicitly excluded from memory
>> > > > > > policy/cpuset?
>> > > > >
>> > > > > We haven't got customer report on this, but there are quite some customers
>> > > > > use cpuset to bind some specific memory nodes to a docker (You've helped
>> > > > > us solve a OOM issue in such cases), so I think it's practical to respect
>> > > > > the cpuset semantics as much as we can.
>> > > >
>> > > > Yes, it is definitely better to respect cpusets and all local memory
>> > > > policies. There is no dispute there. The thing is whether this is really
>> > > > worth it. How often would cpusets (or policies in general) go actively
>> > > > against demotion nodes (i.e. exclude those nodes from their allowes node
>> > > > mask)?
>> > > >
>> > > > I can imagine workloads which wouldn't like to get their memory demoted
>> > > > for some reason but wouldn't it be more practical to tell that
>> > > > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> > > > policies explicitly?
>> > > >
>> > > > > Your concern about the expensive cost makes sense! Some raw ideas are:
>> > > > > * if the shrink_folio_list is called by kswapd, the folios come from
>> > > > >   the same per-memcg lruvec, so only one check is enough
>> > > > > * if not from kswapd, like called form madvise or DAMON code, we can
>> > > > >   save a memcg cache, and if the next folio's memcg is same as the
>> > > > >   cache, we reuse its result. And due to the locality, the real
>> > > > >   check is rarely performed.
>> > > >
>> > > > memcg is not the expensive part of the thing. You need to get from page
>> > > > -> all vmas::vm_policy -> mm -> task::mempolicy
>> > >
>> > > Yeah, on the same page with Michal. Figuring out mempolicy from page
>> > > seems quite expensive and the correctness can't be guranteed since the
>> > > mempolicy could be set per-thread and the mm->task depends on
>> > > CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
>> >
>> > Yes, you are right. Our "working" psudo code for mem policy looks like
>> > what Michal mentioned, and it can't work for all cases, but try to
>> > enforce it whenever possible:
>> >
>> > static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
>> >                 unsigned long addr, void *arg)
>> > {
>> >         bool *skip_demotion = arg;
>> >         struct mempolicy *mpol;
>> >         int nid, dnid;
>> >         bool ret = true;
>> >
>> >         mpol = __get_vma_policy(vma, addr);
>> >         if (!mpol) {
>> >                 struct task_struct *task;
>> >                 if (vma->vm_mm)
>> >                         task = vma->vm_mm->owner;
>> 
>> But this task may not be the task you want IIUC. For example, the
>> process has two threads, A and B. They have different mempolicy. The
>> vmscan is trying to demote a page belonging to thread A, but the task
>> may point to thread B, so you actually get the wrong mempolicy IIUC.
>
> Yes, this is a valid concern! We don't have good solution for this.
> For memory policy, we may only handle the per-vma policy for now whose
> cost is relatively low, as a best-effort try.

Yes.  The solution isn't perfect, especially for multiple-thread
processes with thread specific memory policy.  But the proposed code
above can support the most common cases at least, that is, run workload
with `numactl`.

Best Regards,
Huang, Ying
