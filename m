Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE69564001C
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 07:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiLBGFM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 2 Dec 2022 01:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiLBGFK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 01:05:10 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4299DC4FB;
        Thu,  1 Dec 2022 22:05:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAHS8izOn3Kr8vqxHYxEoGVoCXKmysRKNsvXpJ2EumxDU6JfSDQ@mail.gmail.com>
Date:   Fri, 2 Dec 2022 14:04:45 +0800
Cc:     Shakeel Butt <shakeelb@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        gthelen@google.com, fvdl@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F2917C72-A6F4-4969-B044-211F0D3856F1@linux.dev>
References: <20221130020328.1009347-1-almasrymina@google.com>
 <20221201213202.ycdaymwojd5plyrk@google.com>
 <CAHS8izOn3Kr8vqxHYxEoGVoCXKmysRKNsvXpJ2EumxDU6JfSDQ@mail.gmail.com>
To:     Mina Almasry <almasrymina@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Dec 2, 2022, at 06:10, Mina Almasry <almasrymina@google.com> wrote:
> 
> On Thu, Dec 1, 2022 at 1:32 PM Shakeel Butt <shakeelb@google.com> wrote:
>> 
>> On Tue, Nov 29, 2022 at 06:03:27PM -0800, Mina Almasry wrote:
>> [...]
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 7b8e8e43806b..23fc5b523764 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>>> unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>>                                         unsigned long nr_pages,
>>>                                         gfp_t gfp_mask,
>>> -                                        unsigned int reclaim_options)
>>> +                                        unsigned int reclaim_options,
>>> +                                        nodemask_t nodemask)
>> 
>> Can you please make this parameter a nodemask_t* and pass NULL instead
>> of NODE_MASK_ALL?
> 
> Thank you very much for the review. I sure can in the next version. To
> be honest I thought about that and made the parameter nodemask_t
> because I thought the call sites would be more readable. I.e. this:
> 
>    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> MEMCG_RECLAIM_MAY_SWAP,  NODE_MASK_ALL);

nodemask_t is an array, which can be large depending on CONFIG_NODES_SHIFT.
I don't think passing a big array is an efficient way. So I agree with Shakeel.

Thanks.

> 
> Would be more readable than this:
> 
>    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> MEMCG_RECLAIM_MAY_SWAP,  NULL);
> 
> But the tradeoff is that the callers need include/linux/nodemask.h.
> But yes I can fix in the next version.
> 

