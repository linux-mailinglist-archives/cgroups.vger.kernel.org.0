Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0801368B4C
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 04:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhDWCyY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 22:54:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:35620 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhDWCyY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 22:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=pNdDJLSkNnWH4fqdElehCQIPS74CJfpp+z5bkold+uE=; b=R0O68YghFOdzkekio
        1M0+r4JyQa4XvbKBCqjdDSTFyzKBvIDWZZ3PAAyyxeIfZzk59eH8vCN8XLM3fhI+x0VeAXbq1fsba
        Nt7ko6v+z0Xhg64Q7QCQeo14Ib3/udY8dRsF5Fy7bIxV1YvZx6LZujnCYfe0k0Z2t0OKrpgUartJ8
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZlwu-001D4I-FO; Fri, 23 Apr 2021 05:53:44 +0300
Subject: Re: [PATCH] memcg: enable accounting for pids in nested pid
 namespaces
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
 <YIIcKa/ANkQX07Nf@carbon>
 <38945563-59ad-fb5e-9f7f-eb65ae4bf55e@virtuozzo.com>
 <YIIxPAcdd4p4NTxV@carbon>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <cd6680e3-edd0-88fa-bb83-b9f2d5a65d5b@virtuozzo.com>
Date:   Fri, 23 Apr 2021 05:53:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIIxPAcdd4p4NTxV@carbon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/23/21 5:30 AM, Roman Gushchin wrote:
> On Fri, Apr 23, 2021 at 05:09:01AM +0300, Vasily Averin wrote:
>> On 4/23/21 4:00 AM, Roman Gushchin wrote:
>>> On Thu, Apr 22, 2021 at 08:44:15AM +0300, Vasily Averin wrote:
>>>> init_pid_ns.pid_cachep have enabled memcg accounting, though this
>>>> setting was disabled for nested pid namespaces.
>>>>
>>>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>>>> ---
>>>>  kernel/pid_namespace.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>>>> index 6cd6715..a46a372 100644
>>>> --- a/kernel/pid_namespace.c
>>>> +++ b/kernel/pid_namespace.c
>>>> @@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>>>>  	mutex_lock(&pid_caches_mutex);
>>>>  	/* Name collision forces to do allocation under mutex. */
>>>>  	if (!*pkc)
>>>> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
>>>> +		*pkc = kmem_cache_create(name, len, 0,
>>>> +					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
>>>>  	mutex_unlock(&pid_caches_mutex);
>>>>  	/* current can fail, but someone else can succeed. */
>>>>  	return READ_ONCE(*pkc);
>>>> -- 
>>>> 1.8.3.1
>>>>
>>>
>>> It looks good to me! It makes total sense to apply the same rules to the root
>>> and non-root levels.
>>>
>>> Acked-by: Roman Gushchin <guro@fb.com>
>>>
>>> Btw, is there any reason why this patch is not included into the series?
>>
>> It is a bugfix and I think it should be added to upstream ASAP.
> 
> Then it would be really useful to add some details on why it's a bug,
> what kind of problems it causes, etc. If it has to be backported to
> stable, please, add cc stable/fixes tag.

I mean, in this case we already decided to account pids, but forget to do it.
In another cases we did not have final decision about accounting.

I doubt we specially denied accounting for pids frem nested pid namespaces,
especially because they consumes more memory.
We can expect that all pids are accounted -- but it does not happen in fact.
