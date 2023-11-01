Return-Path: <cgroups+bounces-155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD8C7DE7E6
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AC61C20DEB
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071AF1B274;
	Wed,  1 Nov 2023 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T67tUEHV"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FF1BDDB
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 22:03:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B7125
	for <cgroups@vger.kernel.org>; Wed,  1 Nov 2023 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698876234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqSv+dngOizenCCZDEe3c0pCWMK4IpYs575U6VfGGQA=;
	b=T67tUEHVsdQYA2mCrHz8i3XK19GT39pVJiPzHVewuKgrT9eric5Qd0dDWhHDLP6Hjy63AE
	m9HB4DcR+5xOphM7ZJ4FxOh7Sa1nZi7Zh7Sj1HPESU+NQJ3vQVQwClAnmLFGsLtKftzCXm
	ThwKIV830P8oP+3iyDbylnxsTpFUV1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-zXPTfJAmM-K_1ExMANLdkw-1; Wed, 01 Nov 2023 18:03:47 -0400
X-MC-Unique: zXPTfJAmM-K_1ExMANLdkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4939A811E7E;
	Wed,  1 Nov 2023 22:03:47 +0000 (UTC)
Received: from [10.22.33.245] (unknown [10.22.33.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87A6A492BFA;
	Wed,  1 Nov 2023 22:03:46 +0000 (UTC)
Message-ID: <5df1fa23-1a17-d2e8-7a3a-0a44478bc1de@redhat.com>
Date: Wed, 1 Nov 2023 18:03:46 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] cgroup/rstat: Reduce cpu_lock hold time in
 cgroup_rstat_flush_locked()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
 Sebastian Jug <sejug@redhat.com>
References: <20231101160911.394526-1-longman@redhat.com>
 <CAJD7tka7+_Kxtg4R64_gSH=bGnhU4NUBcQLH6nauE4Bdivrynw@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tka7+_Kxtg4R64_gSH=bGnhU4NUBcQLH6nauE4Bdivrynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 11/1/23 15:11, Yosry Ahmed wrote:
> On Wed, Nov 1, 2023 at 9:09 AM Waiman Long <longman@redhat.com> wrote:
>> When cgroup_rstat_updated() isn't being called concurrently with
>> cgroup_rstat_flush_locked(), its run time is pretty short. When
>> both are called concurrently, the cgroup_rstat_updated() run time
>> can spike to a pretty high value due to high cpu_lock hold time in
>> cgroup_rstat_flush_locked(). This can be problematic if the task calling
>> cgroup_rstat_updated() is a realtime task running on an isolated CPU
>> with a strict latency requirement. The cgroup_rstat_updated() call can
>> happens when there is a page fault even though the task is running in
>> user space most of the time.
>>
>> The percpu cpu_lock is used to protect the update tree -
>> updated_next and updated_children. This protection is only needed
>> when cgroup_rstat_cpu_pop_updated() is being called. The subsequent
>> flushing operation which can take a much longer time does not need
>> that protection.
>>
>> To reduce the cpu_lock hold time, we need to perform all the
>> cgroup_rstat_cpu_pop_updated() calls up front with the lock
>> released afterward before doing any flushing. This patch adds a new
>> cgroup_rstat_flush_list() function to do just that and return a singly
>> linked list of cgroup_rstat_cpu structures to be flushed.
>>
>> By adding some instrumentation code to measure the maximum elapsed times
>> of the new cgroup_rstat_flush_list() function and each cpu iteration
>> of cgroup_rstat_flush_locked() around the old cpu_lock lock/unlock pair
>> on a 2-socket x86-64 server running parallel kernel build, the maximum
>> elapsed times are 31us and 118us respectively. The maximum cpu_lock
>> hold time is now reduced to about 1/4 of the original.
> This sounds promising. It's smart to empty the whole tree while
> holding the lock, then do the flush only under cgroup_rstat_lock.
> Thanks for doing this.
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/cgroup-defs.h |  7 +++++
>>   kernel/cgroup/rstat.c       | 57 +++++++++++++++++++++++++++----------
>>   2 files changed, 49 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 265da00a1a8b..22adb94ebb74 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -368,6 +368,13 @@ struct cgroup_rstat_cpu {
>>           */
>>          struct cgroup *updated_children;        /* terminated by self cgroup */
>>          struct cgroup *updated_next;            /* NULL iff not on the list */
>> +
>> +       /*
>> +        * A singly-linked list of cgroup_rstat_cpu structures to be flushed.
>> +        * Protected by cgroup_rstat_lock.
>> +        */
>> +       struct cgroup_rstat_cpu *flush_next;
>> +       struct cgroup *cgroup;                  /* Cgroup back pointer */
> Why are we linking struct cgroup_rstat_cpu instead of directly linking
> struct cgroup? AFAICT we only ever use the cgroup back pointer during
> flushing anyway, right?
You are right.
> Given that only one cpu can be flushed at a time, I think it should be
> okay to run the list directly through struct cgroup, and have all cpus
> reuse it. That pointer would essentially be scratch space for the
> flushing code to use. This should also save a bit of memory:
> O(cgroups) vs O(cgroups * cpus). It's not a lot either way though.
>
> I think this may also simplify the code a bit.
Moving the flush_next pointer to struct cgroup does save a bit of 
memory. Thanks for the suggestion. I will do that in the next version.
>
>>   };
>>
>>   struct cgroup_freezer_state {
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index d80d7a608141..93ef2795a68d 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -145,6 +145,42 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>>          return pos;
>>   }
>>
>> +/*
>> + * Return a list of cgroup_rstat_cpu structures to be flushed
>> + */
>> +static struct cgroup_rstat_cpu *cgroup_rstat_flush_list(struct cgroup *root,
> nit: the name sounds like the function will flush a list, rather than
> return a list of cgroups to be flushed. What about
> cgroup_rstat_updated_list?

I am not good at naming. cgroup_rstat_updated_list looks good to me.

Cheers,
Longman



