Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0B610651
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 01:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJ0XXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 19:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbiJ0XXR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 19:23:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02FF844D6;
        Thu, 27 Oct 2022 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666912996; x=1698448996;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=qctRSNSWHaYKZhhzWADPStHUQ6ZRSzyF7S51wP2f2Yw=;
  b=FxoZ08b6wdLmyocQYaFuKieP0dbrFofime6cfFZ8rOOWqb285fDo9NU3
   /IMQZJqotWMEkCu7ubaDHJ+8Z+KwxZ8JspjFU3aOJG5XyqlI7/PThbmjZ
   CbZkRWD+Jxt9IYS2yZHbbJuPpthaPAE2rYnSTlZvLLjx+hfhrZkrgSluy
   LKW53Giipd0HE9oirJCETDWmm7b+0Lo+8CdGbCj0dmekTcEmqFHrBya/S
   k0U+TNfDok5T+kOyNWielUFrcaBHu57CVyAq9VdvRmAT1avXDV2NJkTuU
   zJEuQ3g5VcsvWaN8DQATqA9FR9qZdMuNGk6ctAuRg0SdZj+djf5eHPbmp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288760502"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="288760502"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 16:23:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627340917"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="627340917"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 16:23:12 -0700
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
References: <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
        <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
        <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
        <87wn8lkbk5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1ou5DGHrEsKnhri@dhcp22.suse.cz>
        <87o7txk963.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1o63SWD2KmQkT3v@dhcp22.suse.cz>
        <87fsf9k3yg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz>
Date:   Fri, 28 Oct 2022 07:22:27 +0800
In-Reply-To: <Y1p5vaN1AWhpNWZx@dhcp22.suse.cz> (Michal Hocko's message of
        "Thu, 27 Oct 2022 14:29:49 +0200")
Message-ID: <87bkpwkg24.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu 27-10-22 17:31:35, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Thu 27-10-22 15:39:00, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> >> 
>> >> > On Thu 27-10-22 14:47:22, Huang, Ying wrote:
>> >> >> Michal Hocko <mhocko@suse.com> writes:
>> >> > [...]
>> >> >> > I can imagine workloads which wouldn't like to get their memory demoted
>> >> >> > for some reason but wouldn't it be more practical to tell that
>> >> >> > explicitly (e.g. via prctl) rather than configuring cpusets/memory
>> >> >> > policies explicitly?
>> >> >> 
>> >> >> If my understanding were correct, prctl() configures the process or
>> >> >> thread.
>> >> >
>> >> > Not necessarily. There are properties which are per adddress space like
>> >> > PR_[GS]ET_THP_DISABLE. This could be very similar.
>> >> >
>> >> >> How can we get process/thread configuration at demotion time?
>> >> >
>> >> > As already pointed out in previous emails. You could hook into
>> >> > folio_check_references path, more specifically folio_referenced_one
>> >> > where you have all that you need already - all vmas mapping the page and
>> >> > then it is trivial to get the corresponding vm_mm. If at least one of
>> >> > them has the flag set then the demotion is not allowed (essentially the
>> >> > same model as VM_LOCKED).
>> >> 
>> >> Got it!  Thanks for detailed explanation.
>> >> 
>> >> One bit may be not sufficient.  For example, if we want to avoid or
>> >> control cross-socket demotion and still allow demoting to slow memory
>> >> nodes in local socket, we need to specify a node mask to exclude some
>> >> NUMA nodes from demotion targets.
>> >
>> > Isn't this something to be configured on the demotion topology side? Or
>> > do you expect there will be per process/address space usecases? I mean
>> > different processes running on the same topology, one requesting local
>> > demotion while other ok with the whole demotion topology?
>> 
>> I think that it's possible for different processes have different
>> requirements.
>> 
>> - Some processes don't care about where the memory is placed, prefer
>>   local, then fall back to remote if no free space.
>> 
>> - Some processes want to avoid cross-socket traffic, bind to nodes of
>>   local socket.
>> 
>> - Some processes want to avoid to use slow memory, bind to fast memory
>>   node only.
>
> Yes, I do understand that. Do you have any specific examples in mind?
> [...]

Sorry, I don't have specific examples.

>> > If we really need/want to give a fine grained control over demotion
>> > nodemask then we would have to go with vma->mempolicy interface. In
>> > any case a per process on/off knob sounds like a reasonable first step
>> > before we learn more about real usecases.
>> 
>> Yes.  Per-mm or per-vma property is much better than per-task property.
>> Another possibility, how about add a new flag to set_mempolicy() system
>> call to set the per-mm mempolicy?  `numactl` can use that by default.
>
> Do you mean a flag to control whether the given policy is applied to a
> task or mm?

Yes.  That is the idea.

Best Regards,
Huang, Ying
