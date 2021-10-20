Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7194E434D65
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 16:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJTOYN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 10:24:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:34038 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhJTOYM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 10:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=ggO+FpcKH1wkkXlq2EYHdQ27UcwvObsXNymYB1kX5vo=; b=qICVdC1lEfiKYzFU0
        8K47Lgduio85XZ6eCdSooKhVX2NtJObrUJsfhOgPRI1/7qkO7qepJK0z71tuX3axsSQsNHaPSDFiO
        YQxBeX7rWzBQlrSjhah3Y+4HBc3kWbSLYmtHP5nEt0pcUMUyUUPdH3GRLUO+mhlIXrBHEJUdf0+X8
        =;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdCTb-006bzD-13; Wed, 20 Oct 2021 17:21:55 +0300
Subject: Re: [PATCH memcg 2/3] memcg: remove charge forcinig for dying tasks
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
 <56180e53-b705-b1be-9b60-75e141c8560c@virtuozzo.com>
 <YXAOjQO5r1g/WKmn@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <cbda9b6b-3ee5-06ab-9a3b-debf361b55bb@virtuozzo.com>
Date:   Wed, 20 Oct 2021 17:21:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXAOjQO5r1g/WKmn@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 20.10.2021 15:41, Michal Hocko wrote:
> On Wed 20-10-21 15:13:46, Vasily Averin wrote:
>> ToDo: should we keep task_is_dying() in mem_cgroup_out_of_memory() ?
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  mm/memcontrol.c | 20 +++++++-------------
>>  1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 6da5020a8656..74a7379dbac1 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -239,7 +239,7 @@ enum res_type {
>>  	     iter != NULL;				\
>>  	     iter = mem_cgroup_iter(NULL, iter, NULL))
>>  
>> -static inline bool should_force_charge(void)
>> +static inline bool task_is_dying(void)
>>  {
>>  	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
>>  		(current->flags & PF_EXITING);
>> @@ -1575,7 +1575,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>  	 * A few threads which were not waiting at mutex_lock_killable() can
>>  	 * fail to bail out. Therefore, check again after holding oom_lock.
>>  	 */
>> -	ret = should_force_charge() || out_of_memory(&oc);
>> +	ret = task_is_dying() || out_of_memory(&oc);
> 
> Why are you keeping the task_is_dying check here? IIRC I have already
> pointed out that out_of_memory already has some means to do a bypass
> when needed.

It was a misunderstanding.
I've been waiting for your final decision.

I have no good arguments "pro" or strong objection "contra". 
However, I prefer to keep task_is_dying() so as not to touch other tasks unnecessarily.

I can't justify why its removal is necessary,
but on the other hand, it shouldn't break anything.

I can drop it if you think it's necessary.

Thank you,
	Vasily Averin

