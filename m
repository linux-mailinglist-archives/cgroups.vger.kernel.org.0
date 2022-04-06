Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71054F652A
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 18:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiDFQVf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Apr 2022 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiDFQVX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Apr 2022 12:21:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B02DCCAA;
        Tue,  5 Apr 2022 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649213399; x=1680749399;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=z3FJMwq8joZOXA61vyLoUR6apgy9wvWVJ1HAf2QRlg8=;
  b=Sq8QeBpXEQhWMifulmiCoQiTwmk46+APSOl/ZDTE40CRdZAaoLVlUJCG
   KT3rlX3S94SJm5x1NyO6BG56UqjHQJcp/eq0GNZFQ8b6Mup+s6mzT97aa
   f3fTUB6lAySUKqTyjLPJbQsMcITXIcgLfbkTaT2KvAfLHjw8j5zqlJbf7
   ThdBvpMhKTazhbbaO5E6mTIpGdVfBzmp5oLAlP9Te5jibUooOO2p4JnlD
   rRyWAfDLAxVsOCDjIRxsqJR8TIHdx2LfiyOJXam85qmghH97RyW7+GQCz
   Dky65VskAxeUFm5CXtbJA5/Ige4xX2nDlduOUcJ8eybQVOxLEW/Pac3bm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240867137"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="240867137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:49:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="570305329"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:49:53 -0700
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
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
References: <20220331084151.2600229-1-yosryahmed@google.com>
        <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
        <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
        <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
        <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
Date:   Wed, 06 Apr 2022 10:49:51 +0800
In-Reply-To: <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
        (Wei Xu's message of "Tue, 5 Apr 2022 18:07:49 -0700")
Message-ID: <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Tue, Apr 5, 2022 at 5:49 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Wei Xu <weixugc@google.com> writes:
>>
>> > On Sat, Apr 2, 2022 at 1:13 AM Huang, Ying <ying.huang@intel.com> wrote:
>> >>
>> >> Wei Xu <weixugc@google.com> writes:
>> >>
>> >> > On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
>> >> >>
>> >> >> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
>> >> >> > From: Shakeel Butt <shakeelb@google.com>
>> >> >> >
>> >>
>> >> [snip]
>> >>
>> >> >> > Possible Extensions:
>> >> >> > --------------------
>> >> >> >
>> >> >> > - This interface can be extended with an additional parameter or flags
>> >> >> >   to allow specifying one or more types of memory to reclaim from (e.g.
>> >> >> >   file, anon, ..).
>> >> >> >
>> >> >> > - The interface can also be extended with a node mask to reclaim from
>> >> >> >   specific nodes. This has use cases for reclaim-based demotion in memory
>> >> >> >   tiering systens.
>> >> >> >
>> >> >> > - A similar per-node interface can also be added to support proactive
>> >> >> >   reclaim and reclaim-based demotion in systems without memcg.
>> >> >> >
>> >> >> > For now, let's keep things simple by adding the basic functionality.
>> >> >>
>> >> >> Yes, I am for the simplicity and this really looks like a bare minumum
>> >> >> interface. But it is not really clear who do you want to add flags on
>> >> >> top of it?
>> >> >>
>> >> >> I am not really sure we really need a node aware interface for memcg.
>> >> >> The global reclaim interface will likely need a different node because
>> >> >> we do not want to make this CONFIG_MEMCG constrained.
>> >> >
>> >> > A nodemask argument for memory.reclaim can be useful for memory
>> >> > tiering between NUMA nodes with different performance.  Similar to
>> >> > proactive reclaim, it can allow a userspace daemon to drive
>> >> > memcg-based proactive demotion via the reclaim-based demotion
>> >> > mechanism in the kernel.
>> >>
>> >> I am not sure whether nodemask is a good way for demoting pages between
>> >> different types of memory.  For example, for a system with DRAM and
>> >> PMEM, if specifying DRAM node in nodemask means demoting to PMEM, what
>> >> is the meaning of specifying PMEM node? reclaiming to disk?
>> >>
>> >> In general, I have no objection to the idea in general.  But we should
>> >> have a clear and consistent interface.  Per my understanding the default
>> >> memcg interface is for memory, regardless of memory types.  The memory
>> >> reclaiming means reduce the memory usage, regardless of memory types.
>> >> We need to either extending the semantics of memory reclaiming (to
>> >> include memory demoting too), or add another interface for memory
>> >> demoting.
>> >
>> > Good point.  With the "demote pages during reclaim" patch series,
>> > reclaim is already extended to demote pages as well.  For example,
>> > can_reclaim_anon_pages() returns true if demotion is allowed and
>> > shrink_page_list() can demote pages instead of reclaiming pages.
>>
>> These are in-kernel implementation, not the ABI.  So we still have
>> the opportunity to define the ABI now.
>>
>> > Currently, demotion is disabled for memcg reclaim, which I think can
>> > be relaxed and also necessary for memcg-based proactive demotion.  I'd
>> > like to suggest that we extend the semantics of memory.reclaim to
>> > cover memory demotion as well.  A flag can be used to enable/disable
>> > the demotion behavior.
>>
>> If so,
>>
>> # echo A > memory.reclaim
>>
>> means
>>
>> a) "A" bytes memory are freed from the memcg, regardless demoting is
>>    used or not.
>>
>> or
>>
>> b) "A" bytes memory are reclaimed from the memcg, some of them may be
>>    freed, some of them may be just demoted from DRAM to PMEM.  The total
>>    number is "A".
>>
>> For me, a) looks more reasonable.
>>
>
> We can use a DEMOTE flag to control the demotion behavior for
> memory.reclaim.  If the flag is not set (the default), then
> no_demotion of scan_control can be set to 1, similar to
> reclaim_pages().

If we have to use a flag to control the behavior, I think it's better to
have a separate interface (e.g. memory.demote).  But do we really need b)?

> The question is then whether we want to rename memory.reclaim to
> something more general.  I think this name is fine if reclaim-based
> demotion is an accepted concept.

Best Regards,
Huang, Ying
