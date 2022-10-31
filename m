Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A15612EC1
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 02:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJaByS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 21:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJaByE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 21:54:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232D9FF8;
        Sun, 30 Oct 2022 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667181241; x=1698717241;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=vKTxKFC2/vSuOxK8JQIPDsJlamPAXJJtp+Mi/KUNe1c=;
  b=D3vJwxZ+5Xnoi3hl3dDf5HKjFVVR8H3SqP84or6MzXvAI9qzac2sUeuk
   oUmDWnDSUo6n/br8+XY32RoRZzimzbgYYee4UYWJrPEy0x6ntUxGTFg0y
   omvF2atP9MBVVd6+uVrbRkZWoqXaIb6EkyRzZfzUZgpHcq1iW97/kRypR
   V+zGBoh1q2Xns9xhjwxtuiNZDOBDU2IFVK3AFFNnXtPu8d88PLzFJzFu6
   0FbCVBiYEpvtnG3j7+mzes7M+SFqUnTrI9exEATjHV9XF8+fvzkgpIYbs
   tqdMdl/1Nx0W6Goz46nH4vbSxRgyxmt7JQpdw3HXGP/3PIjwu5YOOM4Hk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="289189456"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="289189456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:54:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="635886910"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="635886910"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:53:57 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Feng Tang <feng.tang@intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
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
        <7b5f533d-4b2e-b45b-ee42-5e1cc3e8a279@linux.ibm.com>
        <CAHbLzkrqaCF8wvtsAmvaZUqCAoRfO1qPSFyK7bVq5O5m1zuksg@mail.gmail.com>
Date:   Mon, 31 Oct 2022 09:53:18 +0800
In-Reply-To: <CAHbLzkrqaCF8wvtsAmvaZUqCAoRfO1qPSFyK7bVq5O5m1zuksg@mail.gmail.com>
        (Yang Shi's message of "Fri, 28 Oct 2022 10:16:50 -0700")
Message-ID: <87cza8ep2p.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Oct 27, 2022 at 10:09 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 10/27/22 11:25 PM, Yang Shi wrote:
>> > On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
>> >>
>> >> On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
>> >>> On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
>> >> [...]
>> >>>>>> This all can get quite expensive so the primary question is, does the
>> >>>>>> existing behavior generates any real issues or is this more of an
>> >>>>>> correctness exercise? I mean it certainly is not great to demote to an
>> >>>>>> incompatible numa node but are there any reasonable configurations when
>> >>>>>> the demotion target node is explicitly excluded from memory
>> >>>>>> policy/cpuset?
>> >>>>>
>> >>>>> We haven't got customer report on this, but there are quite some customers
>> >>>>> use cpuset to bind some specific memory nodes to a docker (You've helped
>> >>>>> us solve a OOM issue in such cases), so I think it's practical to respect
>> >>>>> the cpuset semantics as much as we can.
>> >>>>
>> >>>> Yes, it is definitely better to respect cpusets and all local memory
>> >>>> policies. There is no dispute there. The thing is whether this is really
>> >>>> worth it. How often would cpusets (or policies in general) go actively
>> >>>> against demotion nodes (i.e. exclude those nodes from their allowes node
>> >>>> mask)?
>> >>>>
>> >>>> I can imagine workloads which wouldn't like to get their memory demoted
>> >>>> for some reason but wouldn't it be more practical to tell that
>> >>>> explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> >>>> policies explicitly?
>> >>>>
>> >>>>> Your concern about the expensive cost makes sense! Some raw ideas are:
>> >>>>> * if the shrink_folio_list is called by kswapd, the folios come from
>> >>>>>   the same per-memcg lruvec, so only one check is enough
>> >>>>> * if not from kswapd, like called form madvise or DAMON code, we can
>> >>>>>   save a memcg cache, and if the next folio's memcg is same as the
>> >>>>>   cache, we reuse its result. And due to the locality, the real
>> >>>>>   check is rarely performed.
>> >>>>
>> >>>> memcg is not the expensive part of the thing. You need to get from page
>> >>>> -> all vmas::vm_policy -> mm -> task::mempolicy
>> >>>
>> >>> Yeah, on the same page with Michal. Figuring out mempolicy from page
>> >>> seems quite expensive and the correctness can't be guranteed since the
>> >>> mempolicy could be set per-thread and the mm->task depends on
>> >>> CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
>> >>
>> >> Yes, you are right. Our "working" psudo code for mem policy looks like
>> >> what Michal mentioned, and it can't work for all cases, but try to
>> >> enforce it whenever possible:
>> >>
>> >> static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
>> >>                 unsigned long addr, void *arg)
>> >> {
>> >>         bool *skip_demotion = arg;
>> >>         struct mempolicy *mpol;
>> >>         int nid, dnid;
>> >>         bool ret = true;
>> >>
>> >>         mpol = __get_vma_policy(vma, addr);
>> >>         if (!mpol) {
>> >>                 struct task_struct *task;
>> >>                 if (vma->vm_mm)
>> >>                         task = vma->vm_mm->owner;
>> >
>> > But this task may not be the task you want IIUC. For example, the
>> > process has two threads, A and B. They have different mempolicy. The
>> > vmscan is trying to demote a page belonging to thread A, but the task
>> > may point to thread B, so you actually get the wrong mempolicy IIUC.
>> >
>>
>> But if we swap out this page and fault back in via thread B the page would
>> get allocated as per thread B mempolicy. So if we demote based on thread B
>> policy are we breaking anything?
>
> If the page is demoted by following thread B's mempolicy, didn't it
> already break thread A's mempolicy in the first place if you care
> about it? If thread A and thread B have the same mempolicy, then it is
> not a problem.
>
> Actually there is another problem for shared page. If a page is shared
> by two processes, P1 and P2, when you do rmap walk to find the task,
> you may find two contradict mempolicy, what mempolicy would you like
> to obey? Do you have to save all the intermediate mempolicy results
> somewhere or you just bail out once the first mempolicy is found?

Yes.  There's no perfect solution for this.  I suggest to avoid demoting
if any VMA (or task) prevent it.  Because allowing demoting is the
default policy.  And we will not promote the page back if it becomes hot
later by default because promotion only works for default memory policy
by default.

Best Regards,
Huang, Ying
