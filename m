Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88B81B466A
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgDVNlq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 09:41:46 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45232 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgDVNlq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 09:41:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwKjoiT_1587562901;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwKjoiT_1587562901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Apr 2020 21:41:42 +0800
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral part
 of memory control
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>, Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-16-hannes@cmpxchg.org>
 <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
 <20200421143923.GC341682@cmpxchg.org>
 <2721c508-9b32-d0e7-454d-386129bfda1b@linux.alibaba.com>
 <20200422133001.GE358439@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <66573da2-f863-bf6e-cc48-fb2540148d1d@linux.alibaba.com>
Date:   Wed, 22 Apr 2020 21:40:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422133001.GE358439@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/4/22 下午9:30, Johannes Weiner 写道:
> On Wed, Apr 22, 2020 at 11:14:40AM +0800, Alex Shi wrote:
>>
>>
>> 在 2020/4/21 下午10:39, Johannes Weiner 写道:
>>> Hi Alex,
>>>
>>> thanks for your quick review so far, I'll add the tags to the patches.
>>>
>>> On Tue, Apr 21, 2020 at 05:27:30PM +0800, Alex Shi wrote:
>>>>
>>>>
>>>> 在 2020/4/21 上午6:11, Johannes Weiner 写道:
>>>>> The swapaccount=0 boot option will continue to exist, and it will
>>>>> eliminate the page_counter overhead and hide the swap control files,
>>>>> but it won't disable swap slot ownership tracking.
>>>>
>>>> May we add extra explanation for this change to user? and the default
>>>> memsw limitations?
>>>
>>> Can you elaborate what you think is missing and where you would like
>>> to see it documented?
>>>
>> Maybe the following doc change is better after whole patchset? 
>> Guess users would would happy to know details of this change.
> 
> Thanks, I stole your patch and extended/tweaked it a little. Would you
> mind providing your Signed-off-by:?

My pleasure. :)

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

> 
> From 589d3c1b505e6671b4a9b424436c9eda88a0b08c Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Wed, 22 Apr 2020 11:14:40 +0800
> Subject: [PATCH] mm: memcontrol: document the new swap control behavior
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  .../admin-guide/cgroup-v1/memory.rst          | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 0ae4f564c2d6..12757e63b26c 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -199,11 +199,11 @@ An RSS page is unaccounted when it's fully unmapped. A PageCache page is
>  unaccounted when it's removed from radix-tree. Even if RSS pages are fully
>  unmapped (by kswapd), they may exist as SwapCache in the system until they
>  are really freed. Such SwapCaches are also accounted.
> -A swapped-in page is not accounted until it's mapped.
> +A swapped-in page is accounted after adding into swapcache.
>  
>  Note: The kernel does swapin-readahead and reads multiple swaps at once.
> -This means swapped-in pages may contain pages for other tasks than a task
> -causing page fault. So, we avoid accounting at swap-in I/O.
> +Since page's memcg recorded into swap whatever memsw enabled, the page will
> +be accounted after swapin.
>  
>  At page migration, accounting information is kept.
>  
> @@ -222,18 +222,13 @@ the cgroup that brought it in -- this will happen on memory pressure).
>  But see section 8.2: when moving a task to another cgroup, its pages may
>  be recharged to the new cgroup, if move_charge_at_immigrate has been chosen.
>  
> -Exception: If CONFIG_MEMCG_SWAP is not used.
> -When you do swapoff and make swapped-out pages of shmem(tmpfs) to
> -be backed into memory in force, charges for pages are accounted against the
> -caller of swapoff rather than the users of shmem.
> -
> -2.4 Swap Extension (CONFIG_MEMCG_SWAP)
> +2.4 Swap Extension
>  --------------------------------------
>  
> -Swap Extension allows you to record charge for swap. A swapped-in page is
> -charged back to original page allocator if possible.
> +Swap usage is always recorded for each of cgroup. Swap Extension allows you to
> +read and limit it.
>  
> -When swap is accounted, following files are added.
> +When CONFIG_SWAP is enabled, following files are added.
>  
>   - memory.memsw.usage_in_bytes.
>   - memory.memsw.limit_in_bytes.
> 
