Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA41964C458
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 08:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiLNHV6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 02:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiLNHVw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 02:21:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F011DF82;
        Tue, 13 Dec 2022 23:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671002511; x=1702538511;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HblZg3PBBDPB1t0Kwe0mL0LavoSCTJKSmagehy3+X4s=;
  b=ETqGdD7/E42oW4bO01VSLjPb1JDuSgIkMD41yknUIqV1smCLYGhLACn/
   nzO0dOUZZb8iJfadQL48gzzs6NsXS08Xc/aEjUIh/ipy8LbALiQhdDf3j
   ZLjn3OaYTmjOT5mYGCLDuWbVI4AdoHnQLRuqK5JoJnYcF0oTbC6B1vNvK
   pO0WRET25nt8nRmOiyIyUsxQCxzFftmGrgTh5zIkVHS7RRJPRFH7RW8yC
   7b27LRe6AS1D3ljIsEYeYpK/OAVvaFcuJfXlg1nUxeIODtV036VkZ8fNu
   nNtbrCjNewF6U3gOgXRenv/hkcMaKWWW2peQ/N9LfxoXqnqylhzrhhZcr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320195450"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="320195450"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:21:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="712410374"
X-IronPort-AV: E=Sophos;i="5.96,243,1665471600"; 
   d="scan'208";a="712410374"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 23:21:46 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
References: <20221202223533.1785418-1-almasrymina@google.com>
        <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
        <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
        <Y5g41HF2TcLzro4o@dhcp22.suse.cz> <Y5iet+ch24YrvExA@cmpxchg.org>
        <CAHS8izPVbCZOeXxr=Fawa6N92WqJ=6CgP4vHuh-LA_aOH1QOvQ@mail.gmail.com>
Date:   Wed, 14 Dec 2022 15:20:58 +0800
In-Reply-To: <CAHS8izPVbCZOeXxr=Fawa6N92WqJ=6CgP4vHuh-LA_aOH1QOvQ@mail.gmail.com>
        (Mina Almasry's message of "Tue, 13 Dec 2022 11:53:42 -0800")
Message-ID: <87bko6fo2t.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Mina Almasry <almasrymina@google.com> writes:

> On Tue, Dec 13, 2022 at 7:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Tue, Dec 13, 2022 at 09:33:24AM +0100, Michal Hocko wrote:
>> > I do recognize your need to control the demotion but I argue that it is
>> > a bad idea to rely on an implicit behavior of the memory reclaim and an
>> > interface which is _documented_ to primarily _reclaim_ memory.
>>
>> I think memory.reclaim should demote as part of page aging. What I'd
>> like to avoid is *having* to manually control the aging component in
>> the interface (e.g. making memory.reclaim *only* reclaim, and
>> *requiring* a coordinated use of memory.demote to ensure progress.)
>>
>> > Really, consider that the current demotion implementation will change
>> > in the future and based on a newly added heuristic memory reclaim or
>> > compression would be preferred over migration to a different tier.  This
>> > might completely break your current assumptions and break your usecase
>> > which relies on an implicit demotion behavior.  Do you see that as a
>> > potential problem at all? What shall we do in that case? Special case
>> > memory.reclaim behavior?
>>
>> Shouldn't that be derived from the distance propertiers in the tier
>> configuration?
>>
>> I.e. if local compression is faster than demoting to a slower node, we
>> should maybe have a separate tier for that. Ignoring proactive reclaim
>> or demotion commands for a second: on that node, global memory
>> pressure should always compress first, while the oldest pages from the
>> compression cache should demote to the other node(s) - until they
>> eventually get swapped out.
>>
>> However fine-grained we make proactive reclaim control over these
>> stages, it should at least be possible for the user to request the
>> default behavior that global pressure follows, without jumping through
>> hoops or requiring the coordinated use of multiple knobs. So IMO there
>> is an argument for having a singular knob that requests comprehensive
>> aging and reclaiming across the configured hierarchy.
>>
>> As far as explicit control over the individual stages goes - no idea
>> if you would call the compression stage demotion or reclaim. The
>> distinction still does not make much of sense to me, since reclaim is
>> just another form of demotion. Sure, page faults have a different
>> access latency than dax to slower memory. But you could also have 3
>> tiers of memory where the difference between tier 1 and 2 is much
>> smaller than the difference between 2 and 3, and you might want to
>> apply different demotion rates between them as well.
>>
>> The other argument is that demotion does not free cgroup memory,
>> whereas reclaim does. But with multiple memory tiers of vastly
>> different performance, isn't there also an argument for granting
>> cgroups different shares of each memory? So that a higher priority
>> group has access to a bigger share of the fastest memory, and lower
>> prio cgroups are relegated to lower tiers. If we split those pools,
>> then "demotion" will actually free memory in a cgroup.
>>
>
> I would also like to say I implemented something in line with that in [1].
>
> In this patch, pages demoted from inside the nodemask to outside the
> nodemask count as 'reclaimed'. This, in my mind, is a very generic
> solution to the 'should demoted pages count as reclaim?' problem, and
> will work in all scenarios as long as the nodemask passed to
> shrink_folio_list() is set correctly by the call stack.

It's still not clear that how many pages should be demoted among the
nodes inside the nodemask.  One possibility is to keep as many higher
tier pages as possible.

Best Regards,
Huang, Ying
