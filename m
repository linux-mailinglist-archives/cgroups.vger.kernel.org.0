Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA46432771
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 21:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhJRTVa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 15:21:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:54414 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhJRTV3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 Oct 2021 15:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=4jQhvYjT9e4GBOeEOpVGTS9SaUVXdZehoAqLumPkuB4=; b=BJk6ixEhC6GggosfS
        drD0XYECS0NtOWJdkYysnHFAK3NUBY+8RheLTcA44GdguZbNpj3BRm189Gyzn1Px/cF3Y/O/nx2El
        BkFfXhQpsHXlqPQeOunogHD6a/FRsulQdWnndAg0XUNt5LOBKuKiAefJ3xBLBOy6yqbngYxkO41TM
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mcYAE-006OiF-Uy; Mon, 18 Oct 2021 22:19:15 +0300
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz>
 <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
 <153f7aa6-39ef-f064-8745-a9489e088239@virtuozzo.com>
Message-ID: <4a30aa18-e2a2-693c-8237-b75fffac9838@virtuozzo.com>
Date:   Mon, 18 Oct 2021 22:18:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <153f7aa6-39ef-f064-8745-a9489e088239@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 18.10.2021 21:52, Vasily Averin wrote:
> On 18.10.2021 18:07, Shakeel Butt wrote:
>> On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
>>>
>>> [restore the cc list]
>>>
>>> On Mon 18-10-21 15:14:26, Vasily Averin wrote:
>>>> On 18.10.2021 14:53, Michal Hocko wrote:
>>>>> On Mon 18-10-21 13:05:35, Vasily Averin wrote:
>>>>>> On 18.10.2021 12:04, Michal Hocko wrote:
>>>>>> Here we call try_charge_memcg() that return success and approve the allocation,
>>>>>> however then we hit into kmem limit and fail the allocation.
>>>>>
>>>>> Just to make sure I understand this would be for the v1 kmem explicit
>>>>> limit, correct?
>>>>
>>>> yes, I mean this limit.
>>>
>>> OK, thanks for the clarification. This is a known problem. Have a look
>>> at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
>>> kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
>>> status since 2019 without any actual report sugested by the kernel
>>> message. Maybe we should try and remove it and see whether that prompts
>>> some pushback.
>>>
>>
>> Yes, I think now should be the right time to take the next step for
>> deprecation of kmem limits:
>> https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/
> 
> Are you going to push it to stable kernels too?

Btw CONFIG_MEMCG_KMEM=y is set both in RHEL8 kernels and in ubuntu 20.04 LTS kernel 5.11.0-37.


