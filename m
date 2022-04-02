Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F367E4EFF9D
	for <lists+cgroups@lfdr.de>; Sat,  2 Apr 2022 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiDBIPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Apr 2022 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiDBIPN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Apr 2022 04:15:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874ECC7;
        Sat,  2 Apr 2022 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648887202; x=1680423202;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tUJDWtBsVmdyxP5li7Z+DxSKC/ML2/OMaCS+cELECpE=;
  b=Tot79oCv9KXklW3aXS5YkJ3ZXltkr65lzGhnDHD6RjoWmIyszZoeLtY2
   3AYh+Fbgm5VQqrghqFZib373pZVJHR+ilkmDuS1L1iCIyvZ7liC7hidOt
   mb7O11xcMlVhGVTUGUK5cMTNXY74kAf6YJJj+cq7hwrM+j5fmtepGn/xD
   tPGPco9PtMHv56ro3csSPn9TWNtO1tV2zZTJ0WLixnrkFrhyamKG/2BGR
   TvW7+It7IOo52ryvzA4ycBGGctH4I/E2xTxEB9MfSNJ+yglly4kOXAly1
   8ZQtbU01tqYY0+EUNL80IVwLHwNPT1Bg3HqM8cr9Y3jEmPY8hNimfPlgt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="260274263"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="260274263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 01:13:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="568127496"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 01:13:17 -0700
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
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
References: <20220331084151.2600229-1-yosryahmed@google.com>
        <YkcEMdsi9G5y8mX4@dhcp22.suse.cz>
        <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
Date:   Sat, 02 Apr 2022 16:13:15 +0800
In-Reply-To: <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
        (Wei Xu's message of "Fri, 1 Apr 2022 09:56:08 -0700")
Message-ID: <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
>> > From: Shakeel Butt <shakeelb@google.com>
>> >

[snip]

>> > Possible Extensions:
>> > --------------------
>> >
>> > - This interface can be extended with an additional parameter or flags
>> >   to allow specifying one or more types of memory to reclaim from (e.g.
>> >   file, anon, ..).
>> >
>> > - The interface can also be extended with a node mask to reclaim from
>> >   specific nodes. This has use cases for reclaim-based demotion in memory
>> >   tiering systens.
>> >
>> > - A similar per-node interface can also be added to support proactive
>> >   reclaim and reclaim-based demotion in systems without memcg.
>> >
>> > For now, let's keep things simple by adding the basic functionality.
>>
>> Yes, I am for the simplicity and this really looks like a bare minumum
>> interface. But it is not really clear who do you want to add flags on
>> top of it?
>>
>> I am not really sure we really need a node aware interface for memcg.
>> The global reclaim interface will likely need a different node because
>> we do not want to make this CONFIG_MEMCG constrained.
>
> A nodemask argument for memory.reclaim can be useful for memory
> tiering between NUMA nodes with different performance.  Similar to
> proactive reclaim, it can allow a userspace daemon to drive
> memcg-based proactive demotion via the reclaim-based demotion
> mechanism in the kernel.

I am not sure whether nodemask is a good way for demoting pages between
different types of memory.  For example, for a system with DRAM and
PMEM, if specifying DRAM node in nodemask means demoting to PMEM, what
is the meaning of specifying PMEM node? reclaiming to disk?

In general, I have no objection to the idea in general.  But we should
have a clear and consistent interface.  Per my understanding the default
memcg interface is for memory, regardless of memory types.  The memory
reclaiming means reduce the memory usage, regardless of memory types.
We need to either extending the semantics of memory reclaiming (to
include memory demoting too), or add another interface for memory
demoting.

Best Regards,
Huang, Ying

[snip]
