Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9E434CBE
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJTNzf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 09:55:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:46986 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhJTNzf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=rwHiENVsU+PAyCq6R1IGWsHjEjN7UJ7KRwgz3+7hO5Y=; b=TXtVaBAvdC04JlrqI
        NKpx1GC690M5p+aueGyGido9fpz0EtSupAgjPy2+2FCv/K9yxQ5YAFhVhpRuduJnse480vwpxvco9
        f+Zm8GCu8Rv71SX6ne3seHmN7MS4qLdk25HFf5+oG9eozcYhOPv4UjskRhZFiB0wy5UCtSLcbJMlE
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdC1q-006bpi-TY; Wed, 20 Oct 2021 16:53:14 +0300
Subject: Re: [PATCH memcg 1/3] mm: do not firce global OOM from inside dying
 tasks
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <2c13c739-7282-e6f4-da0a-c0b69e68581e@virtuozzo.com>
 <YXAMpxjuV/h2awqG@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <f7329c84-3687-459e-88b6-c3395f538a0b@virtuozzo.com>
Date:   Wed, 20 Oct 2021 16:52:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXAMpxjuV/h2awqG@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 20.10.2021 15:33, Michal Hocko wrote:
> s@firce@force@
> 
> On Wed 20-10-21 15:12:19, Vasily Averin wrote:
>> There is no sense to force global OOM if current task is dying.
> 
> This really begs for much more information. Feel free to get an
> inspiration from my previous attempt to achieve something similar.
> In minimum it is important to mention that the OOM killer is already
> handled at the page allocator level for the global OOM and at the
> charging level for the memcg one. Both have much more information
> about the scope of allocation/charge request. This means that either the
> OOM killer has been invoked properly and didn't lead to the allocation
> success or it has been skipped because it couldn't have been invoked.
> In both cases triggering it from here is pointless and even harmful.
> 
> Another argument is that it is more reasonable to let killed task die
> rather than hit the oom killer and retry the allocation.

Thank you,
I'll update  patch description later,
this time I would like to clarify patch content. 

>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  mm/oom_kill.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 831340e7ad8b..1deef8c7a71b 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -1137,6 +1137,9 @@ void pagefault_out_of_memory(void)
>>  	if (mem_cgroup_oom_synchronize(true))
>>  		return;
>>  
>> +	if (fatal_signal_pending(current))
>> +		return;
>> +
>>  	if (!mutex_trylock(&oom_lock))
>>  		return;
>>  	out_of_memory(&oc);
>> -- 
>> 2.32.0
> 

