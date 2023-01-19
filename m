Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782A6733B0
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 09:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjASIan (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 03:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjASIal (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 03:30:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA45AC;
        Thu, 19 Jan 2023 00:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674117040; x=1705653040;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=LxcRD6HtB+g61OccydTNj4VaTJvaQZCVLDO3oTLNvDo=;
  b=Yo8OWacdV5VyAA28nuKCWPqrUuKpurkwTynHun6DX4vRWBjbZm1WlhwU
   UyBGtrprcdqBfzni5UI7OEaeIYEbaD/LctX4siQrJGih3EL8Ne6tRdGh0
   jeo8sBkLXc65VGugEXzRvD7rik0S0eS0bLmIADye/Pl7yAtvVukoSQRi3
   FQai+gOLJJZAVqpzmYbCXgA7ZewfWKnlPH336QWvmWOdD3nmMXzWwxxEg
   0kWTYAXP554lhH5CtIcoTrU3aL2U4fFaQDPCDOoUVksn8/jCfPMEQPUg5
   TdYpXi75mMfRKolPAxbOmevQuasPo5DUEyFr5jgzNmlvgLnRxAf7mHmHi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327303773"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="327303773"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:30:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="768119456"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="768119456"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 00:30:32 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, fvdl@google.com,
        bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yuanchu Xie <yuanchu@google.com>
Subject: Re: Proactive reclaim/demote discussion (was Re: [PATCH] Revert
 "mm: add nodes= arg to memory.reclaim")
References: <20221202223533.1785418-1-almasrymina@google.com>
        <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz> <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
        <20221216101820.3f4a370af2c93d3c2e78ed8a@linux-foundation.org>
        <Y52Scge3ynvn/mB4@dhcp22.suse.cz>
        <20221219144252.f3da256e75e176905346b4d1@linux-foundation.org>
        <Y7PpYsbv1xC6m/Hu@dhcp22.suse.cz>
        <87lemiitdd.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
        <Y8gqkub3AM6c+Z5y@dhcp22.suse.cz>
Date:   Thu, 19 Jan 2023 16:29:33 +0800
In-Reply-To: <Y8gqkub3AM6c+Z5y@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 18 Jan 2023 18:21:22 +0100")
Message-ID: <87a62fdj0y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 04-01-23 16:41:50, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> [snip]
>> 
>> > This really requires more discussion.
>> 
>> Let's start the discussion with some summary.
>> 
>> Requirements:
>> 
>> - Proactive reclaim.  The counting of current per-memcg proactive
>>   reclaim (memory.reclaim) isn't correct.  The demoted, but not
>>   reclaimed pages will be counted as reclaimed.  So "echo XXM >
>>   memory.reclaim" may exit prematurely before the specified number of
>>   memory is reclaimed.
>
> This is reportedly a problem because memory.reclaim interface cannot be
> used for proper memcg sizing IIRC.
>
>> - Proactive demote.  We need an interface to do per-memcg proactive
>>   demote.
>
> For the further discussion it would be useful to reference the usecase
> that is requiring this functionality. I believe this has been mentioned
> somewhere but having it in this thread would help.

Sure.

Google people in [1] and [2] request a per-cgroup interface to demote
but not reclaim proactively.

"
For jobs of some latency tiers, we would like to trigger proactive
demotion (which incurs relatively low latency on the job), but not
trigger proactive reclaim (which incurs a pagefault).
"

Meta people (Johannes) in [3] say they used per-cgroup memory.reclaim
for demote and reclaim proactively.

 [1] https://lore.kernel.org/linux-mm/CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com/
 [2] https://lore.kernel.org/linux-mm/CAJD7tkZNW=u1TD-Fd_3RuzRNtaFjxihbGm0836QHkdp0Nn-vyQ@mail.gmail.com/
 [3] https://lore.kernel.org/linux-mm/Y35fw2JSAeAddONg@cmpxchg.org/

>> We may reuse memory.reclaim via extending the concept of
>>   reclaiming to include demoting.  Or, we can add a new interface for
>>   that (for example, memory.demote).  In addition to demote from fast
>>   tier to slow tier, in theory, we may need to demote from a set of
>>   nodes to another set of nodes for something like general node
>>   balancing.
>> 
>> - Proactive promote.  In theory, this is possible, but there's no real
>>   life requirements yet.  And it should use a separate interface, so I
>>   don't think we need to discuss that here.
>
> Yes, proactive promotion is not backed by any real usecase at the
> moment. We do not really have to focus on it but we should be aware of
> the posibility and alow future extentions towards that functionality.

OK.

> There is one requirement missing here.
>  - Per NUMA node control - this is what makes the distinction between
>    demotion and charge reclaim really semantically challenging - e.g.
>    should demotions constrained by the provided nodemask or they should
>    be implicit?

Yes.  We may need to specify the NUMA nodes for demotion/reclaiming
source, target, or even path.  That is, to fine control the proactive
demotion/reclaiming.

>> Open questions:
>> 
>> - Use memory.reclaim or memory.demote for proactive demote.  In current
>>   memcg context, reclaiming and demoting is quite different, because
>>   reclaiming will uncharge, while demoting will not.  But if we will add
>>   per-memory-tier charging finally, the difference disappears.  So the
>>   question becomes whether will we add per-memory-tier charging.
>
> The question is not whether but when IMHO. We've had a similar situation
> with the swap accounting. Originally we have considered swap as a shared
> resource but cgroupv2 goes with per swap limits because contention for
> the swap space is really something people do care about.

So, when we design user space interface for proactive demotion, we
should keep per-memory-tier charging in mind.

>> - Whether should we demote from faster tier nodes to lower tier nodes
>>   during the proactive reclaiming.
>
> I thought we are aligned on that. Demotion is a part of aging and that
> is an integral part of the reclaim.

As in the choice A/B of the below text, we should keep more fast memory
size or slow memory size?  For original active/inactive LRU lists, we
will balance the size of lists.  But we don't have similar stuff for the
memory tiers.  What is the preferred balancing policy?  Choice A/B below
are 2 extreme policies that are defined clearly.

>>   Choice A is to keep as much fast
>>   memory as possible.  That is, reclaim from the lowest tier nodes
>>   firstly, then the secondary lowest tier nodes, and so on.  Choice B is
>>   to demote at the same time of reclaiming.  In this way, if we
>>   proactively reclaim XX MB memory, we may free XX MB memory on the
>>   fastest memory nodes.
>> 
>> - When we proactively demote some memory from a fast memory tier, should
>>   we trigger memory competition in the slower memory tiers?  That is,
>>   whether to wake up kswapd of the slower memory tiers nodes?
>
> Johannes made some very strong arguments that there is no other choice
> than involve kswapd (https://lore.kernel.org/all/Y5nEQeXj6HQBEHEY@cmpxchg.org/).

I have no objection for that too.  The below is just another choice.  If
people don't think it's useful.  I will not insist on it.

>>   If we
>>   want to make per-memcg proactive demoting to be per-memcg strictly, we
>>   should avoid to trigger the global behavior such as triggering memory
>>   competition in the slower memory tiers.  Instead, we can add a global
>>   proactive demote interface for that (such as per-memory-tier or
>>   per-node).
>
> I suspect we are left with a real usecase and then follow the path we
> took for the swap accounting.

Thanks for adding that.

> Other open questions I do see are
> - what to do when the memory.reclaim is constrained by a nodemask as
>   mentioned above. Is the whole reclaim process (including aging) bound to
>   the given nodemask or does demotion escape from it.

Per my understanding, we can use multiple node masks if necessary.  For
example, for "source=<mask1>", we may demote from <mask1> to other
nodes; for "source=<mask1> destination=<mask2>", we will demote from
<mask1> to <mask2>, but will not demote to other nodes.

> - should the demotion be specific to multi-tier systems or the interface
>   should be just NUMA based and users could use the scheme to shuffle
>   memory around and allow numa balancing from userspace that way. That
>   would imply that demotion is a dedicated interface of course.

It appears that if we can force the demotion target nodes (even in the
same tier).  We can implement numa balancing from user space?

> - there are other usecases that would like to trigger aging from
>   userspace (http://lkml.kernel.org/r/20221214225123.2770216-1-yuanchu@google.com).
>   Isn't demotion just a special case of aging in general or should we
>   end up with 3 different interfaces?

Thanks for pointer!  If my understanding were correct, this appears a
user of proactive reclaiming/demotion interface?  Cced the patch author
for any further requirements for the interface.

Best Regards,
Huang, Ying
