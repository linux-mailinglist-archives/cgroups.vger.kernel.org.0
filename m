Return-Path: <cgroups+bounces-3430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961291B46A
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3875AB212C2
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73343FC01;
	Fri, 28 Jun 2024 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqpNC25W"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D13D8E
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536801; cv=none; b=UhlJNCsU4wO98ABx7GDMYYZu4hCLHmDDxmu6MhtV+Ljc5kkmXEq2CyLi59CFG/vayqv3RSSiWFdJUDEYHS7vhNn3jey6XPwJ142rXcYK+JvsB17Ni1N6G3fKRgq7LVk/RxbvcOjgjPt6fq9g8/u0HGKh6NM3zE9ntv+QwnCxnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536801; c=relaxed/simple;
	bh=EdWj89pVbXZmQQrbfZ+xE1Hxi0Y4Z/pBNi+RgO87Lgc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mu5xVOOWy/2bTRff9aYuHRnUbg8S+j72LfP+J6jb3dwpARWeKqzIZNBI+gnwph3ydnwWA83wRncu4NxZbbqOJFfcSBW+htyKKWzug4BpVZ2srFBnH9Zq5P0UdU9p6EqPULRq3weEt42wMpTV6/2ydxrSEVlih9Stjusyq/rLkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqpNC25W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719536796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njkkozG9EFlh7coxFPh179Qtw83r0T/2ltt/6G5V93o=;
	b=OqpNC25WaNh2cpmkzqneOpKAi4+F5c8sGIW20FJSMVhmMSzfYxBT5OqOkFgbmMbXux3NY3
	U4WHCJ8S1FUOG1QTnd7DXRV9eiY6l47c/xVh1OjqhN+rdAW5/zbi0UIr7m/wQHAPSSV6M6
	L3fRhcTmN9yPXkgmiLk+pgQ7jgIKoIQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-DsioewEANdKRqGGg7Q38Eg-1; Thu,
 27 Jun 2024 21:06:32 -0400
X-MC-Unique: DsioewEANdKRqGGg7Q38Eg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499A31955F03;
	Fri, 28 Jun 2024 01:06:30 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEB0F300021A;
	Fri, 28 Jun 2024 01:06:27 +0000 (UTC)
Message-ID: <4b86e9ec-f94d-4838-ad24-e1a3c89c9939@redhat.com>
Date: Thu, 27 Jun 2024 21:06:26 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] cgroup/rstat: Helper functions for locking expose
 trylock
From: Waiman Long <longman@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
 cgroups@vger.kernel.org, yosryahmed@google.com, shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <08062501-f3fb-4e4d-b72c-f1b0f964640f@redhat.com>
Content-Language: en-US
In-Reply-To: <08062501-f3fb-4e4d-b72c-f1b0f964640f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6/27/24 18:22, Waiman Long wrote:
>
> On 6/27/24 17:18, Jesper Dangaard Brouer wrote:
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>>   kernel/cgroup/rstat.c |   40 ++++++++++++++++++++++++++++++----------
>>   1 file changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index fb8b49437573..2a42be3a9bb3 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -279,17 +279,30 @@ __bpf_hook_end();
>>    * value -1 is used when obtaining the main lock else this is the CPU
>>    * number processed last.
>>    */
>> -static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int 
>> cpu_in_loop)
>> +static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int 
>> cpu_in_loop)
>> +{
>> +    bool locked;
>> +
>> +    locked = spin_trylock_irq(&cgroup_rstat_lock);
>> +    if (!locked)
>> +        trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, !locked);
>> +
>> +    return locked;
>> +}
>> +
>> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int 
>> cpu_in_loop,
>> +                       bool check_contention)
>>       __acquires(&cgroup_rstat_lock)
>>   {
>> -    bool contended;
>> +    bool locked = false;
>>   -    contended = !spin_trylock_irq(&cgroup_rstat_lock);
>> -    if (contended) {
>> -        trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, 
>> contended);
>> +    if (check_contention)
>> +        locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
>> +
>> +    if (!locked)
>>           spin_lock_irq(&cgroup_rstat_lock);
>> -    }
>> -    trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>> +
>> +    trace_cgroup_rstat_locked(cgrp, cpu_in_loop, !locked);
>>   }
>>     static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int 
>> cpu_in_loop)
>> @@ -328,7 +341,7 @@ static void cgroup_rstat_flush_locked(struct 
>> cgroup *cgrp)
>>               __cgroup_rstat_unlock(cgrp, cpu);
>>               if (!cond_resched())
>>                   cpu_relax();
>> -            __cgroup_rstat_lock(cgrp, cpu);
>> +            __cgroup_rstat_lock(cgrp, cpu, true);
>>           }
>>       }
>>   }
>> @@ -348,9 +361,16 @@ static void cgroup_rstat_flush_locked(struct 
>> cgroup *cgrp)
>>    */
>>   __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>>   {
>> +    bool locked;
>> +
>>       might_sleep();
>>   -    __cgroup_rstat_lock(cgrp, -1);
>> +    locked = __cgroup_rstat_trylock(cgrp, -1);
>> +    if (!locked) {
>> +        /* Opportunity to ongoing flush detection */
>> +        __cgroup_rstat_lock(cgrp, -1, false);
>> +    }
>> +
>>       cgroup_rstat_flush_locked(cgrp);
>>       __cgroup_rstat_unlock(cgrp, -1);
>>   }
>> @@ -368,7 +388,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>       __acquires(&cgroup_rstat_lock)
>>   {
>>       might_sleep();
>> -    __cgroup_rstat_lock(cgrp, -1);
>> +    __cgroup_rstat_lock(cgrp, -1, true);
>>       cgroup_rstat_flush_locked(cgrp);
>>   }
>>
>>
> Will it be cleaner to add a "bool *flushed" output parameter to 
> __cgroup_rstat_lock() so that the caller can respond differently 
> whether the flushed flag is set or not? In that way, you don't need to 
> expose a separate trylock() API. Also your commit log is empty.

Looking at the use case in patch 2, I would suggest the following APIs.

- bool cgroup_rstat_lock(struct cgroup *cgrp)
- bool cgroup_rstat_lock_or_flushed(struct cgroup *cgrp)

Both will return a bool indicating a flush has already been done if 
true. The 2nd function will not take the lock if a flush is ongoing. 
Both will wait if a flush is ongoing.

Cheers,
Longman



