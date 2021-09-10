Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E16406CD2
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 15:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhIJNWO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 09:22:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:58268 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhIJNWN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 10 Sep 2021 09:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=JVXUl/vOizFbXr36SIPs7G3RFOBb+JiAbzjybBgSVzo=; b=JLfwkFXuuXp3vd0TC
        /NFlQV+FNFjxEFpmxjyN2Xcau1dZ7GgOhyPyo4HrLhWmnInQ5e1thC1wdt+G+EvfHG8LCuyDQMo4D
        6/cxxh6G/QICGAi+EGhYighds6CAGImWsDXVSdQm/rVweBBVKGuOa2flWL+Ih1/ZygDxHCACfnIBw
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mOgSg-001V2v-Il; Fri, 10 Sep 2021 16:20:58 +0300
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <099aa0db-045a-e5b8-6df7-b7c3fc4d3caa@i-love.sakura.ne.jp>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <4a407474-ff7a-9e4f-d314-ab85f0eeaadf@virtuozzo.com>
Date:   Fri, 10 Sep 2021 16:20:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <099aa0db-045a-e5b8-6df7-b7c3fc4d3caa@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/10/21 4:04 PM, Tetsuo Handa wrote:
> On 2021/09/10 21:39, Vasily Averin wrote:
>> The kernel currently allows dying tasks to exceed the memcg limits.
>> The allocation is expected to be the last one and the occupied memory
>> will be freed soon.
>> This is not always true because it can be part of the huge vmalloc
>> allocation. Allowed once, they will repeat over and over again.
>> Moreover lifetime of the allocated object can differ from
>> In addition the lifetime of the dying task.
> 
> Can't we add fatal_signal_pending(current) test to vmalloc() loop?

1) this has been done in the past but has been reverted later.
2) any vmalloc changes will affect non-memcg allocations too.
 If we're doing memcg-related checks it's better to do it in one place.
3) it is not vmalloc-only issue. Huge number of  kmalloc page allocations 
from N concurrent threads will lead to the same problem. 

>> Multiple such allocations running concurrently can not only overuse
>> the memcg limit, but can lead to a global out of memory and,
>> in the worst case, cause the host to panic.
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

