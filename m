Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7360F3C2
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiJ0JdP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 05:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiJ0Jcr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 05:32:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678C3BC7C;
        Thu, 27 Oct 2022 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666863151; x=1698399151;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=o45ZowjyZfFdbT4eNKTF4OINZYO4WatGCLArdaxRHBY=;
  b=FoSXwyWGnVDYFV+RAtBWi3/5B72N5umz+1mKeNE1lOUOuZuoOAL8vq3u
   H1rZ4Qp6SDeMWHXh25SVPxUrvpt45XpLI4sgrdi/tN7gBpAKVBP2wPZdA
   kk5cCWwxXBnPhHvJEDWOidtR4rsqza2lY9ppoB79S5UOfgLRiuYzhhe2M
   60FjffCyI9QnG1FtgKeIIHfOfLVy7OexLYtSCAd26k0ZhBFR6Q7V0efrH
   LYmV3/d5BeQkNTuzqDuwW0qgqyZH76BmRZAvbsSKgi021w438n50EPuVV
   dX99Qaz9KEgN0IFG4yEj2MPduoLCNeH4RQfO/eDWwfGeH/ngodwJRbknq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309873060"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="309873060"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:32:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="877518330"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="877518330"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:32:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
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
        <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
        <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
Date:   Thu, 27 Oct 2022 17:31:35 +0800
In-Reply-To: <Y1o63SWD2KmQkT3v@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 27 Oct 2022 10:01:33 +0200")
Message-ID: <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Michal Hocko <mhocko@suse.com> writes:

> On Thu 27-10-22 15:39:00, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Thu 27-10-22 14:47:22, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> > [...]
>> >> > I can imagine workloads which wouldn't like to get their memory demoted
>> >> > for some reason but wouldn't it be more practical to tell that
>> >> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> >> > policies explicitly?
>> >> 
>> >> If my understanding were correct, prctl() configures the process or
>> >> thread.
>> >
>> > Not necessarily. There are properties which are per adddress space like
>> > PR_[GS]ET_THP_DISABLE. This could be very similar.
>> >
>> >> How can we get process/thread configuration at demotion time?
>> >
>> > As already pointed out in previous emails. You could hook into
>> > folio_check_references path, more specifically folio_referenced_one
>> > where you have all that you need already - all vmas mapping the page and
>> > then it is trivial to get the corresponding vm_mm. If at least one of
>> > them has the flag set then the demotion is not allowed (essentially the
>> > same model as VM_LOCKED).
>> 
>> Got it!  Thanks for detailed explanation.
>> 
>> One bit may be not sufficient.  For example, if we want to avoid or
>> control cross-socket demotion and still allow demoting to slow memory
>> nodes in local socket, we need to specify a node mask to exclude some
>> NUMA nodes from demotion targets.
>
> Isn't this something to be configured on the demotion topology side? Or
> do you expect there will be per process/address space usecases? I mean
> different processes running on the same topology, one requesting local
> demotion while other ok with the whole demotion topology?

I think that it's possible for different processes have different
requirements.

- Some processes don't care about where the memory is placed, prefer
  local, then fall back to remote if no free space.

- Some processes want to avoid cross-socket traffic, bind to nodes of
  local socket.

- Some processes want to avoid to use slow memory, bind to fast memory
  node only.

>> >From overhead point of view, this appears similar as that of VMA/task
>> memory policy?  We can make mm->owner available for memory tiers
>> (CONFIG_NUMA && CONFIG_MIGRATION).  The advantage is that we don't need
>> to introduce new ABI.  I guess users may prefer to use `numactl` than a
>> new ABI?
>
> mm->owner is a wrong direction. It doesn't have a strong meaning because
> there is no one task explicitly responsible for the mm so there is no
> real owner (our clone() semantic is just to permissive for that). The
> memcg::owner is a crude and ugly hack and it should go away over time
> rather than build new uses.
>
> Besides that, and as I have already tried to explain, per task demotion
> policy is what makes this whole thing expensive. So this better be a per
> mm or per vma property. Whether it is a on/off knob like PR_[GS]ET_THP_DISABLE
> or there are explicit requirements for fine grain control on the vma
> level I dunno. I haven't seen those usecases yet and it is really easy
> to overengineer this.
>
> To be completely honest I would much rather wait for those usecases
> before adding a more complex APIs.  PR_[GS]_DEMOTION_DISABLED sounds
> like a reasonable first step. Should we have more fine grained
> requirements wrt address space I would follow the MADV_{NO}HUGEPAGE
> lead.
>
> If we really need/want to give a fine grained control over demotion
> nodemask then we would have to go with vma->mempolicy interface. In
> any case a per process on/off knob sounds like a reasonable first step
> before we learn more about real usecases.

Yes.  Per-mm or per-vma property is much better than per-task property.
Another possibility, how about add a new flag to set_mempolicy() system
call to set the per-mm mempolicy?  `numactl` can use that by default.

Best Regards,
Huang, Ying
