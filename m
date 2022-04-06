Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A94F5E26
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 14:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiDFMqF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Apr 2022 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiDFMpb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Apr 2022 08:45:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443A58E558;
        Wed,  6 Apr 2022 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649234967; x=1680770967;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=jD+7cgE98PQmYfE6TYFpIJfwzOpPcHAKULKiD5IVELY=;
  b=W0Rhim8zFb6tRr4IO3YVNXQYhOazp011fsZk+w3+4dYHDs4F/8/2Xmpz
   +YfUpMSNvNIqVFBAMEv9miWnfh8VNCCipDOZTO3mOOtndgQuAMkKhHIQp
   uXqKkovaHVQUG2p7VqQlHVb+iWA8RKy/3KGW/iIb3Fr6kQO/3ylPlmvIu
   Dtiqld6Qbzw7NqE+bVL7C4W6cI8Z/p2IZSuWxMv8ZnQqv/Qowv6CGqh6n
   FHVSog09e7GZy5SRn4F30Zl9gIwhtWNadNA3YE2xl/jyt1Vwe4hGnhTKz
   8xEiOHYe3fpC4QmwxzWI5NoGAUBf8EoEhaY2ZOUskxos+WFKkbk9Q3bYd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258578296"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="258578296"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:49:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570417999"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:49:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
References: <20220331084151.2600229-1-yosryahmed@google.com>
        <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
        <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
        <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
        <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
        <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u_FVEVE+wTBNYfDibLVKsRuOwEnpigYYRiZ2MbeUs1u8w@mail.gmail.com>
        <877d82vi13.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u8u77yazFpc2R216j6ObAiANb0Lfxt7DcT9P=3eg60u9Q@mail.gmail.com>
Date:   Wed, 06 Apr 2022 16:49:20 +0800
In-Reply-To: <CAAPL-u8u77yazFpc2R216j6ObAiANb0Lfxt7DcT9P=3eg60u9Q@mail.gmail.com>
        (Wei Xu's message of "Wed, 6 Apr 2022 00:05:03 -0700")
Message-ID: <8735iqvbov.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Tue, Apr 5, 2022 at 11:32 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Wei Xu <weixugc@google.com> writes:
>>
>> > On Tue, Apr 5, 2022 at 7:50 PM Huang, Ying <ying.huang@intel.com> wrote:
>> >>
>> >> Wei Xu <weixugc@google.com> writes:
>> >>
>> >> > On Tue, Apr 5, 2022 at 5:49 PM Huang, Ying <ying.huang@intel.com> wrote:
>> >> >>
>> >> >> Wei Xu <weixugc@google.com> writes:
>> >> >>
>> >> >> > On Sat, Apr 2, 2022 at 1:13 AM Huang, Ying <ying.huang@intel.com> wrote:
>> >> >> >>
>> >> >> >> Wei Xu <weixugc@google.com> writes:
>> >> >> >>
>> >> >> >> > On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
>> >> >> >> >>
>> >> >> >> >> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
>> >> >> >> >> > From: Shakeel Butt <shakeelb@google.com>
>> >> >> >> >> >
>> >> >> >>
>> >> >> >> [snip]
>> >> >> >>
>> >> >> >> >> > Possible Extensions:
>> >> >> >> >> > --------------------
>> >> >> >> >> >
>> >> >> >> >> > - This interface can be extended with an additional parameter or flags
>> >> >> >> >> >   to allow specifying one or more types of memory to reclaim from (e.g.
>> >> >> >> >> >   file, anon, ..).
>> >> >> >> >> >
>> >> >> >> >> > - The interface can also be extended with a node mask to reclaim from
>> >> >> >> >> >   specific nodes. This has use cases for reclaim-based demotion in memory
>> >> >> >> >> >   tiering systens.
>> >> >> >> >> >
>> >> >> >> >> > - A similar per-node interface can also be added to support proactive
>> >> >> >> >> >   reclaim and reclaim-based demotion in systems without memcg.
>> >> >> >> >> >
>> >> >> >> >> > For now, let's keep things simple by adding the basic functionality.
>> >> >> >> >>
>> >> >> >> >> Yes, I am for the simplicity and this really looks like a bare minumum
>> >> >> >> >> interface. But it is not really clear who do you want to add flags on
>> >> >> >> >> top of it?
>> >> >> >> >>
>> >> >> >> >> I am not really sure we really need a node aware interface for memcg.
>> >> >> >> >> The global reclaim interface will likely need a different node because
>> >> >> >> >> we do not want to make this CONFIG_MEMCG constrained.
>> >> >> >> >
>> >> >> >> > A nodemask argument for memory.reclaim can be useful for memory
>> >> >> >> > tiering between NUMA nodes with different performance.  Similar to
>> >> >> >> > proactive reclaim, it can allow a userspace daemon to drive
>> >> >> >> > memcg-based proactive demotion via the reclaim-based demotion
>> >> >> >> > mechanism in the kernel.
>> >> >> >>
>> >> >> >> I am not sure whether nodemask is a good way for demoting pages between
>> >> >> >> different types of memory.  For example, for a system with DRAM and
>> >> >> >> PMEM, if specifying DRAM node in nodemask means demoting to PMEM, what
>> >> >> >> is the meaning of specifying PMEM node? reclaiming to disk?
>> >> >> >>
>> >> >> >> In general, I have no objection to the idea in general.  But we should
>> >> >> >> have a clear and consistent interface.  Per my understanding the default
>> >> >> >> memcg interface is for memory, regardless of memory types.  The memory
>> >> >> >> reclaiming means reduce the memory usage, regardless of memory types.
>> >> >> >> We need to either extending the semantics of memory reclaiming (to
>> >> >> >> include memory demoting too), or add another interface for memory
>> >> >> >> demoting.
>> >> >> >
>> >> >> > Good point.  With the "demote pages during reclaim" patch series,
>> >> >> > reclaim is already extended to demote pages as well.  For example,
>> >> >> > can_reclaim_anon_pages() returns true if demotion is allowed and
>> >> >> > shrink_page_list() can demote pages instead of reclaiming pages.
>> >> >>
>> >> >> These are in-kernel implementation, not the ABI.  So we still have
>> >> >> the opportunity to define the ABI now.
>> >> >>
>> >> >> > Currently, demotion is disabled for memcg reclaim, which I think can
>> >> >> > be relaxed and also necessary for memcg-based proactive demotion.  I'd
>> >> >> > like to suggest that we extend the semantics of memory.reclaim to
>> >> >> > cover memory demotion as well.  A flag can be used to enable/disable
>> >> >> > the demotion behavior.
>> >> >>
>> >> >> If so,
>> >> >>
>> >> >> # echo A > memory.reclaim
>> >> >>
>> >> >> means
>> >> >>
>> >> >> a) "A" bytes memory are freed from the memcg, regardless demoting is
>> >> >>    used or not.
>> >> >>
>> >> >> or
>> >> >>
>> >> >> b) "A" bytes memory are reclaimed from the memcg, some of them may be
>> >> >>    freed, some of them may be just demoted from DRAM to PMEM.  The total
>> >> >>    number is "A".
>> >> >>
>> >> >> For me, a) looks more reasonable.
>> >> >>
>> >> >
>> >> > We can use a DEMOTE flag to control the demotion behavior for
>> >> > memory.reclaim.  If the flag is not set (the default), then
>> >> > no_demotion of scan_control can be set to 1, similar to
>> >> > reclaim_pages().
>> >>
>> >> If we have to use a flag to control the behavior, I think it's better to
>> >> have a separate interface (e.g. memory.demote).  But do we really need b)?
>> >>
>> >
>> > I am fine with either approach: a separate interface similar to
>> > memory.reclaim, but dedicated to demotion, or multiplexing
>> > memory.reclaim for demotion with a flag.
>> >
>> > My understanding is that with the "demote pages during reclaim"
>> > support, b) is the expected behavior, or more precisely, pages that
>> > cannot be demoted may be freed or swapped out.  This is reasonable.
>> > Demotion-only can also be supported via some arguments to the
>> > interface and changes to demotion code in the kernel.  After all, this
>> > interface is being designed to be extensible based on the discussions
>> > so far.
>>
>> I think we should define the interface not from the current
>> implementation point of view, but from the requirement point of view.
>> For proactive reclaim, per my understanding, the requirement is,
>>
>>   we found that there's some cold pages in some workloads, so we can
>>   take advantage of the proactive reclaim to reclaim some pages so that
>>   other workload can use the freed memory.
>>
>> For proactive demotion, per my understanding, the requirement could be,
>>
>>   We found that there's some cold pages in fast memory (e.g. DRAM) in
>>   some workloads, so we can take advantage of the proactive demotion to
>>   demote some pages so that other workload can use the freed fast
>>   memory.  Given the DRAM partition support Tim (Cced) is working on.
>>
>> Why do we need something in the middle?
>
> Maybe there is some misunderstanding.  As you said, demotion is to
> free up fast memory.  If pages on fast memory cannot be demoted, but
> can still be reclaimed to free some fast memory, it is useful, too.
> Certainly, we can also add the support and configure the policy to
> only demote, not reclaim, from fast memory in such cases.

Yes.  I think it may be better to demote from fast memory nodes only in
such cases.  We just free some fast memory proactively.  But we may
reclaim from the slow memory node (which are demotion targets) if
necessary.

> In any case, we will not reclaim from slow memory for demotion,

If there's no free pages in the slow memory to accommodate the demoted
pages, why not just reclaim some pages in the slow memory?  What are the
disadvantages to do that?

> if that is the middle thing you refer to.

No.  I mean,

If we reclaim "A" pages proactively, we will free "A" pages, maybe from
slow memory firstly.  The target is the total memory size of a memcg.

If we demote "A" pages proactively, we will demote "A" pages from fast
memory to slow memory.  The target is the fast memory size of a memcg.
In the process, some slow memory may be reclaimed to accommodate the
demoted pages.

For me, the middle thing is,

If we demote some pages from fast memory to slow memory proactively and
free some pages from slow memory at the same time, the total number
(demote + free) is "A".  There's no clear target.  I think this is
confusing.  Per my understanding, you don't suggest this too.

> This is why nodemask is
> proposed for memory.reclaim to support the demotion use case.  With a
> separate memory.demote interface and memory tiering topology among
> NUMA nodes being well defined by the kernel and shared with the
> userspace, we can omit the nodemask argument.

Yes.  Both seems work.

Best Regards,
Huang, Ying

>>
>> >> > The question is then whether we want to rename memory.reclaim to
>> >> > something more general.  I think this name is fine if reclaim-based
>> >> > demotion is an accepted concept.
>> >>
>> >> Best Regards,
>> >> Huang, Ying
