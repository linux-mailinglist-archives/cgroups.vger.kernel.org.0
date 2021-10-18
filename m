Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3B4315A4
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhJRKQi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 06:16:38 -0400
Received: from relay.sw.ru ([185.231.240.75]:54776 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231397AbhJRKPT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 Oct 2021 06:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=RjQ2q0eEBKUC2hw/uFRyVd7II2frLBeK42RcVtr41GU=; b=YdtmgWLsg/9itCN0w
        gaNBRGfhIxNAIsOrvb79eZIkBpOZ7CZv91nsy63JFIByh51HEzOSr7LaoE/DPpCnbwVT7Fz6deWga
        3qvoCB+/JJird1u8Xkc8qoPNqN6hyBAQ+QqhpptZZesFoyaujeaovPqgzcP6IbmvsVDDwm/pBVKIQ
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mcPdh-006L2E-Bu; Mon, 18 Oct 2021 13:13:05 +0300
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
Message-ID: <4a6f801b-28d3-94d7-2e65-212ad8c5a412@virtuozzo.com>
Date:   Mon, 18 Oct 2021 13:12:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 18.10.2021 13:05, Vasily Averin wrote:
> On 18.10.2021 12:04, Michal Hocko wrote:
>> On Mon 18-10-21 11:13:52, Vasily Averin wrote:
>>> Partially this problem depends on one of my recent patches, disabled unlimited
>>> memory allocation for dying tasks. However I think the problem can happen
>>> on non-killed tasks too, for example because of kmem limit.
>>
>> Could you be more specific on how this can happen without your patch? I
>> have to say I haven't realized this side effect when discussing it.
> 
> We can reach obj_cgroup_charge_pages() for example via
> 
> do_user_addr_fault
> handle_mm_fault
> __handle_mm_fault
> p4d_alloc
> __p4d_alloc
> p4d_alloc_one
> get_zeroed_page
> __get_free_pages
> alloc_pages
> __alloc_pages
> __memcg_kmem_charge_page
> obj_cgroup_charge_pages
> 
> Here we call try_charge_memcg() that return success and approve the allocation,
> however then we hit into kmem limit and fail the allocation.

btw. in OpenVZ kernels we trying to cleanup the memory in when task hit kmem limit,
therefore we moved kmem limit check into try_charge_memcg.

Are any improvements for kmem controller interesting for upstream?

Thank you,
	Vasily Averin
