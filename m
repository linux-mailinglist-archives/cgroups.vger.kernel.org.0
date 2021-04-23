Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B8C368AF2
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 04:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhDWCJn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 22:09:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:59532 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhDWCJn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 22:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=YyvzTBXOZaej9Iif+I45XB+57Mj/H9zw9b1SnxCqh14=; b=A0p1hY4ZtFRZna+gt
        ISa88C+xCiGWrQnFgpL4ySg6FqUXKSm+wkm8wt0oymsbi7jRduiYwpX5pXyc7le7xEcMQylW3TpWK
        7EqLPvmf3XHviQza4d65+tQQR+1n4h+GuGLy3pqJkaxt3YZDBZTK3vZiVuv67MrnIGRGAU99bBlbY
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZlFd-001D2f-U9; Fri, 23 Apr 2021 05:09:01 +0300
Subject: Re: [PATCH] memcg: enable accounting for pids in nested pid
 namespaces
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
 <YIIcKa/ANkQX07Nf@carbon>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <38945563-59ad-fb5e-9f7f-eb65ae4bf55e@virtuozzo.com>
Date:   Fri, 23 Apr 2021 05:09:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIIcKa/ANkQX07Nf@carbon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/23/21 4:00 AM, Roman Gushchin wrote:
> On Thu, Apr 22, 2021 at 08:44:15AM +0300, Vasily Averin wrote:
>> init_pid_ns.pid_cachep have enabled memcg accounting, though this
>> setting was disabled for nested pid namespaces.
>>
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  kernel/pid_namespace.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>> index 6cd6715..a46a372 100644
>> --- a/kernel/pid_namespace.c
>> +++ b/kernel/pid_namespace.c
>> @@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>>  	mutex_lock(&pid_caches_mutex);
>>  	/* Name collision forces to do allocation under mutex. */
>>  	if (!*pkc)
>> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
>> +		*pkc = kmem_cache_create(name, len, 0,
>> +					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
>>  	mutex_unlock(&pid_caches_mutex);
>>  	/* current can fail, but someone else can succeed. */
>>  	return READ_ONCE(*pkc);
>> -- 
>> 1.8.3.1
>>
> 
> It looks good to me! It makes total sense to apply the same rules to the root
> and non-root levels.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> 
> Btw, is there any reason why this patch is not included into the series?

It is a bugfix and I think it should be added to upstream ASAP.
Another patches adds a new functionality, they can cause questions or objections
and anyway can wait.

Thank you,
	Vasily Averin
