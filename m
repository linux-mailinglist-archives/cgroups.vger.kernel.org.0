Return-Path: <cgroups+bounces-163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D77DFAAD
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 20:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0ECCB20E5A
	for <lists+cgroups@lfdr.de>; Thu,  2 Nov 2023 19:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5021353;
	Thu,  2 Nov 2023 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg8eLvku"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939C200D4
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 19:07:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EC9192
	for <cgroups@vger.kernel.org>; Thu,  2 Nov 2023 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698952041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3K3OmvqH5lzaH4yBBJivGjTa0UMweaOBbHusKFdRvM=;
	b=cg8eLvkuMY+AL/emCsWYjHa6ENOY/cLDuHQFD4eyiPt1K5ToKFBWwDhkpJ3yFQ3/E+0CDL
	1GURV9e9D6Ze/6a2lO36rLhjnjmYE7HjmZ2O+wjlLZMfuzcc/mu9kh/H2l2/KmPfepyD09
	mKjSs9cSIsdburDCnWmRv95njMXlxts=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-nZ-r8DN8NEyonLN5Q80LVQ-1; Thu,
 02 Nov 2023 15:07:15 -0400
X-MC-Unique: nZ-r8DN8NEyonLN5Q80LVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19CAB2801A4A;
	Thu,  2 Nov 2023 19:07:15 +0000 (UTC)
Received: from [10.22.17.8] (unknown [10.22.17.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 543B02026D4C;
	Thu,  2 Nov 2023 19:07:14 +0000 (UTC)
Message-ID: <19251b0c-a6b6-ba5b-3b7b-620416165121@redhat.com>
Date: Thu, 2 Nov 2023 15:07:14 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] cgroup/rstat: Reduce cpu_lock hold time in
 cgroup_rstat_flush_locked()
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
 Sebastian Jug <sejug@redhat.com>
References: <20231102005310.439588-1-longman@redhat.com>
 <CAJD7tkZLKiKJQRgJ6MexFwt2_iDHeBzyDxuT3ZWtL0yjN+7pHg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkZLKiKJQRgJ6MexFwt2_iDHeBzyDxuT3ZWtL0yjN+7pHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 11/2/23 00:35, Yosry Ahmed wrote:
> On Wed, Nov 1, 2023 at 5:53 PM Waiman Long <longman@redhat.com> wrote:
>> When cgroup_rstat_updated() isn't being called concurrently with
>> cgroup_rstat_flush_locked(), its run time is pretty short. When
>> both are called concurrently, the cgroup_rstat_updated() run time
>> can spike to a pretty high value due to high cpu_lock hold time in
>> cgroup_rstat_flush_locked(). This can be problematic if the task calling
>> cgroup_rstat_updated() is a realtime task running on an isolated CPU
>> with a strict latency requirement. The cgroup_rstat_updated() call can
>> happens when there is a page fault even though the task is running in
> s/happens/happen
>
>> user space most of the time.
>>
>> The percpu cpu_lock is used to protect the update tree -
>> updated_next and updated_children. This protection is only needed
>> when cgroup_rstat_cpu_pop_updated() is being called. The subsequent
>> flushing operation which can take a much longer time does not need
>> that protection.
> nit: add: as it is already protected by cgroup_rstat_lock.
>
>> To reduce the cpu_lock hold time, we need to perform all the
>> cgroup_rstat_cpu_pop_updated() calls up front with the lock
>> released afterward before doing any flushing. This patch adds a new
>> cgroup_rstat_updated_list() function to return a singly linked list of
>> cgroups to be flushed.
>>
>> By adding some instrumentation code to measure the maximum elapsed times
>> of the new cgroup_rstat_updated_list() function and each cpu iteration of
>> cgroup_rstat_updated_locked() around the old cpu_lock lock/unlock pair
>> on a 2-socket x86-64 server running parallel kernel build, the maximum
>> elapsed times are 27us and 88us respectively. The maximum cpu_lock hold
>> time is now reduced to about 30% of the original.
>>
>> Below were the run time distribution of cgroup_rstat_updated_list()
>> during the same period:
>>
>>        Run time             Count
>>        --------             -----
>>           t <= 1us       12,574,302
>>     1us < t <= 5us        2,127,482
>>     5us < t <= 10us           8,445
>>    10us < t <= 20us           6,425
>>    20us < t <= 30us              50
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> LGTM with some nits.
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
>> ---
>>   include/linux/cgroup-defs.h |  6 +++++
>>   kernel/cgroup/rstat.c       | 45 ++++++++++++++++++++++++-------------
>>   2 files changed, 36 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 265da00a1a8b..daaf6d4eb8b6 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -491,6 +491,12 @@ struct cgroup {
>>          struct cgroup_rstat_cpu __percpu *rstat_cpu;
>>          struct list_head rstat_css_list;
>>
>> +       /*
>> +        * A singly-linked list of cgroup structures to be rstat flushed.
>> +        * Protected by cgroup_rstat_lock.
> Do you think we should mention that this is a scratch area for
> cgroup_rstat_flush_locked()? IOW, this field will be invalid or may
> contain garbage otherwise.
I can certainly add that into the comment.
>
> It might be also useful to mention that the scope of usage for this is
> for each percpu flushing iteration. The cgroup_rstat_lock can be
> dropped between percpu flushing iterations, so different flushers can
> reuse this field safely because it is re-initialized in every
> iteration and only used there.
>
>> +        */
>> +       struct cgroup   *rstat_flush_next;
>> +
>>          /* cgroup basic resource statistics */
>>          struct cgroup_base_stat last_bstat;
>>          struct cgroup_base_stat bstat;
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index d80d7a608141..a86d40ed8bda 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -145,6 +145,34 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>>          return pos;
>>   }
>>
>> +/*
>> + * Return a list of updated cgroups to be flushed
>> + */
> Why not just on a single line?
> /* Return a list of updated cgroups to be flushed */

Yes, it can be compressed into a one liner.

Thanks for the review and suggestion.

Cheers,
Longman


