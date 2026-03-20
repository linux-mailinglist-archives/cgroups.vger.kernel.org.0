Return-Path: <cgroups+bounces-14941-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE9BFvdJvWlr8gIAu9opvQ
	(envelope-from <cgroups+bounces-14941-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 14:21:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FB2DAE3B
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 14:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D6E3108D00
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 13:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06A3B2FCC;
	Fri, 20 Mar 2026 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrfn8dhk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F23B2FE5
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012758; cv=none; b=Jx8jsRwdLX/Vut2STlMKwrHKtgljd+73AzcWICU2XRJved7mqB02U7TE42GZQXZqUPXuBAoDWrs1K3wpF8RLhd0l3OtenB4os9EL2S75tYuORgip5ZHTF4/MOU5L698ZuD1x2TgemNY+Ja09UN/J7TKIP9dYB0BzSt3u207FfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012758; c=relaxed/simple;
	bh=WV9hcbYlupbtukPiCM8NtmyfxfIRaBt9WcLShLCKT3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmLayK/2Q/lpfusS6tQWCxMow7DW1KGgR8AljhOGJYG9wsJMYG6X8pFzVanI1Y5YrhClGeAWVSVltmDA1GmtOd71f6R+OLy9YijbfOHKEGr61x3U4yIh5DwebpJkXDYynled10A9wI7t5nVk6XjEg9d5vn5rTMb4XE3xaez/Pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrfn8dhk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774012756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43pI9Rxx7g/U6KWY+aHGDiY4UP4hzBP1C6y0vyJ/NMo=;
	b=hrfn8dhk7IpFk7BFLqwEfHud+K7AnjazJInR8SgeFa2izinu2r1UO0HosJFIOUYuybtZO0
	+0PdWgoVDqlokl+dmJazfrwiAHb0tpfq2mfPLRovqCiViyZhgk72NgMTPb5bJsx4eH+hSF
	0LDFL10fDQi+KYNa2Abq6/SB03tJMLU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-CeVCNg7WP_inUj0MZw47nw-1; Fri,
 20 Mar 2026 09:19:10 -0400
X-MC-Unique: CeVCNg7WP_inUj0MZw47nw-1
X-Mimecast-MFC-AGG-ID: CeVCNg7WP_inUj0MZw47nw_1774012748
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBBF51944F01;
	Fri, 20 Mar 2026 13:19:07 +0000 (UTC)
Received: from [10.22.65.139] (unknown [10.22.65.139])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B29951955F25;
	Fri, 20 Mar 2026 13:19:03 +0000 (UTC)
Message-ID: <bf33746b-46ae-47ec-a735-d2a29226bf9c@redhat.com>
Date: Fri, 20 Mar 2026 09:19:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] memcg: Scale up vmstats flush threshold with
 log2(nums_possible_cpus)
To: Li Wang <liwang@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 Sebastian Chlad <sebastianchlad@gmail.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319173752.1472864-2-longman@redhat.com> <ab0kAE7mJkEL9kWb@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ab0kAE7mJkEL9kWb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14941-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D20FB2DAE3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/20/26 6:40 AM, Li Wang wrote:
> On Thu, Mar 19, 2026 at 01:37:46PM -0400, Waiman Long wrote:
>> The vmstats flush threshold currently increases linearly with the
>> number of online CPUs. As the number of CPUs increases over time, it
>> will become increasingly difficult to meet the threshold and update the
>> vmstats data in a timely manner. These days, systems with hundreds of
>> CPUs or even thousands of them are becoming more common.
>>
>> For example, the test_memcg_sock test of test_memcontrol always fails
>> when running on an arm64 system with 128 CPUs. It is because the
>> threshold is now 64*128 = 8192. With 4k page size, it needs changes in
>> 32 MB of memory. It will be even worse with larger page size like 64k.
>>
>> To make the output of memory.stat more correct, it is better to
>> scale up the threshold logarithmically instead of linearly with the
>> number of CPUs. With the log2 scale, we can use the possibly larger
>> num_possible_cpus() instead of num_online_cpus() which may change at
>> run time.
>>
>> Although there is supposed to be a periodic and asynchronous flush of
>> vmstats every 2 seconds, the actual time lag between succesive runs
>> can actually vary quite a bit. In fact, I have seen time lags of up
>> to 10s of seconds in some cases. So we couldn't too rely on the hope
>> that there will be an asynchronous vmstats flush every 2 seconds. This
>> may be something we need to look into.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 772bac21d155..8d4ede72f05c 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -548,20 +548,20 @@ struct memcg_vmstats {
>>    *    rstat update tree grow unbounded.
>>    *
>>    * 2) Flush the stats synchronously on reader side only when there are more than
>> - *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this optimization
>> - *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * nr_cpus) but
>> - *    only for 2 seconds due to (1).
>> + *    (MEMCG_CHARGE_BATCH * (ilog2(nr_cpus) + 1)) update events. Though this
>> + *    optimization will let stats be out of sync by up to that amount but only
>> + *    for 2 seconds due to (1).
>>    */
>>   static void flush_memcg_stats_dwork(struct work_struct *w);
>>   static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>>   static u64 flush_last_time;
>> +static int vmstats_flush_threshold __ro_after_init;
>>   
>>   #define FLUSH_TIME (2UL*HZ)
>>   
>>   static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
>>   {
>> -	return atomic_read(&vmstats->stats_updates) >
>> -		MEMCG_CHARGE_BATCH * num_online_cpus();
>> +	return atomic_read(&vmstats->stats_updates) > vmstats_flush_threshold;
>>   }
>>   
>>   static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
>> @@ -5191,6 +5191,13 @@ int __init mem_cgroup_init(void)
>>   
>>   	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
>>   				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
>> +	/*
>> +	 * Logarithmically scale up vmstats flush threshold with the number
>> +	 * of CPUs.
>> +	 * N.B. ilog2(1) = 0.
>> +	 */
>> +	vmstats_flush_threshold = MEMCG_CHARGE_BATCH *
>> +				  (ilog2(num_possible_cpus()) + 1);
> Changing the threashold from linearly to logarithmically looks smarter,
> but my concern is that, on large systems (hundreds/thousands of CPUs),
> the threshold drops dramatically.
>
> For example, 1024 CPUs it goes from 65536 (256MB) to only 704 (2.7MB),
> that's almost 100x. Could this potentially raise a performance issue
> as frequently read 'memory.stat' on a heavily loaded system?
>
> Maybe go with MEMCG_CHARGE_BATCH * int_sqrt(num_possible_cpus()),
> which sits between linear and log2?

I have also been thinking about scaling faster than log2 but still below 
linear. I believe int_sqrt() is a good suggestion and I will adopt it in 
the next version.

Thanks,
Longman


