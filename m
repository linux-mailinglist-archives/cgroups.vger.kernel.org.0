Return-Path: <cgroups+bounces-15039-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FiMGAAUxGmfwAQAu9opvQ
	(envelope-from <cgroups+bounces-15039-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:57:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C33297B1
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 17:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 990FA3193669
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63823EB7E3;
	Wed, 25 Mar 2026 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+bVsUKG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF35F283FCF
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456950; cv=none; b=kZMkQIirpNRZHNSWIhxIdwArdp0b6cI0zoSQ4Pu5MWRtvUct9XXxOloZHv69Z64+78aE/ZG9a1RfR2Pqfm6WQQVYcewacbqg4nBCkt5GxOlXMzjjOTtS+MTRWoXRfluGrWXwVP6C6sVsujUwIPKs3lS8MrlCdMTw+VLA9JFgL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456950; c=relaxed/simple;
	bh=wmWT127/HKvUC1X1eR0VtAOdbpq8A0sdI0eZra3FEW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJcPW2tU3G3PLN/X+YaCdck3TvquWm+eecGHq8f0K0LYFxogK7HvYXgnQisaPBWytpYCc79YEJ6we8UdLQIylO3aHtCSXw659FByqoBcZivw03BlVKQYxiPteJu7HtQmsDWuc3ZVZxgOcNdvcuoYrxasxEHRTWlOpXlG4GNRFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+bVsUKG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774456946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8Ejv58wPUbDLQJ+Tj4MdIi2shlj9vonZOVFSYDuwn8=;
	b=a+bVsUKGRamtAl4D3lcOoc0Js9uWNXnFxWtdzqBRQaJH/fphAZX69dDVxPX/T3mvrHKmfu
	Wffx+rgEKlWxk3ieyre/ZYXwdxmQOB+4Ul5PK1mw/5kSAC2z/PWsiGyTE0hK05McYj0mLM
	3QJfztF3jcF1w7Z1r3ItFnSfH0vDloM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-lcagNMoDMTGvBrvVXY_vqg-1; Wed,
 25 Mar 2026 12:42:23 -0400
X-MC-Unique: lcagNMoDMTGvBrvVXY_vqg-1
X-Mimecast-MFC-AGG-ID: lcagNMoDMTGvBrvVXY_vqg_1774456938
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94F8618005B4;
	Wed, 25 Mar 2026 16:42:17 +0000 (UTC)
Received: from [10.22.90.27] (unknown [10.22.90.27])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C8571800351;
	Wed, 25 Mar 2026 16:42:13 +0000 (UTC)
Message-ID: <82661a8e-256c-4cf4-96b2-98d52cf62cde@redhat.com>
Date: Wed, 25 Mar 2026 12:42:12 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] selftests: memcg: Increase error tolerance in
 accordance with page size
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
References: <20260320204241.1613861-1-longman@redhat.com>
 <20260320204241.1613861-5-longman@redhat.com> <acDzaouBPCIpB7Ij@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <acDzaouBPCIpB7Ij@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-15039-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C82C33297B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 4:01 AM, Li Wang wrote:
> On Fri, Mar 20, 2026 at 04:42:38PM -0400, Waiman Long wrote:
>> It was found that some of the tests in test_memcontrol can fail more
>> readily if system page size is larger than 4k. It is because the
>> actual memory.current value deviates more from the expected value with
>> larger page size. This is likely due to the fact there may be up to
>> MEMCG_CHARGE_BATCH pages of charge hidden in each one of the percpu
>> memcg_stock.
>>
>> To avoid this failure, the error tolerance is now increased in accordance
>> to the current system page size value. The page size scale factor is
>> set to 2 for 64k page and 1 for 16k page.
>>
>> Changes are made in alloc_pagecache_max_30M(), test_memcg_protection()
>> and alloc_anon_50M_check_swap() to increase the error tolerance for
>> memory.current for larger page size. The current set of values are
>> chosen to ensure that the relevant test_memcontrol tests no longer
>> have any test failure in a 100 repeated run of test_memcontrol with a
>> 4k/16k/64k page size kernels on an arm64 system.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   .../cgroup/lib/include/cgroup_util.h          |  3 ++-
>>   .../selftests/cgroup/test_memcontrol.c        | 23 ++++++++++++++-----
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
>> index 77f386dab5e8..2293e770e9b4 100644
>> --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
>> +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
>> @@ -6,7 +6,8 @@
>>   #define PAGE_SIZE 4096
>>   #endif
>>   
>> -#define MB(x) (x << 20)
>> +#define KB(x) ((x) << 10)
>> +#define MB(x) ((x) << 20)
>>   
>>   #define USEC_PER_SEC	1000000L
>>   #define NSEC_PER_SEC	1000000000L
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index babbfad10aaf..c078fc458def 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -26,6 +26,7 @@
>>   static bool has_localevents;
>>   static bool has_recursiveprot;
>>   static int page_size;
>> +static int pscale_factor;	/* Page size scale factor */
>>   
>>   int get_temp_fd(void)
>>   {
>> @@ -571,16 +572,17 @@ static int test_memcg_protection(const char *root, bool min)
>>   	if (cg_run(parent[2], alloc_anon, (void *)MB(148)))
>>   		goto cleanup;
>>   
>> -	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
>> +	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50),
>> +				       3 + (min ? 0 : 4) * pscale_factor))
>>   		goto cleanup;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(children); i++)
>>   		c[i] = cg_read_long(children[i], "memory.current");
>>   
>> -	if (!values_close(c[0], MB(29), 15))
>> +	if (!values_close(c[0], MB(29), 15 + 3 * pscale_factor))
>>   		goto cleanup;
>>   
>> -	if (!values_close(c[1], MB(21), 20))
>> +	if (!values_close(c[1], MB(21), 20 + pscale_factor))
>>   		goto cleanup;
>>   
>>   	if (c[3] != 0)
>> @@ -596,7 +598,8 @@ static int test_memcg_protection(const char *root, bool min)
>>   	}
>>   
>>   	current = min ? MB(50) : MB(30);
>> -	if (!values_close(cg_read_long(parent[1], "memory.current"), current, 3))
>> +	if (!values_close(cg_read_long(parent[1], "memory.current"), current,
>> +				       9 + (min ? 0 : 6) * pscale_factor))
>>   		goto cleanup;
>>   
>>   	if (!reclaim_until(children[0], MB(10)))
>> @@ -684,7 +687,7 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
>>   		goto cleanup;
>>   
>>   	current = cg_read_long(cgroup, "memory.current");
>> -	if (!values_close(current, MB(30), 5))
>> +	if (!values_close(current, MB(30), 5 + (pscale_factor ? 2 : 0)))
>>   		goto cleanup;
>>   
>>   	ret = 0;
>> @@ -1004,7 +1007,7 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
>>   		*ptr = 0;
>>   
>>   	mem_current = cg_read_long(cgroup, "memory.current");
>> -	if (!mem_current || !values_close(mem_current, mem_max, 3))
>> +	if (!mem_current || !values_close(mem_current, mem_max, 6 + pscale_factor))
>>   		goto cleanup;
>>   
>>   	swap_current = cg_read_long(cgroup, "memory.swap.current");
>> @@ -1684,6 +1687,14 @@ int main(int argc, char **argv)
>>   	if (page_size <= 0)
>>   		page_size = PAGE_SIZE;
>>   
>> +	/*
>> +	 * It is found that the actual memory.current value can deviate more
>> +	 * from the expected value with larger page size. So error tolerance
>> +	 * will have to be increased a bit more for larger page size.
>> +	 */
>> +	if (page_size > KB(4))
>> +		pscale_factor = (page_size >= KB(64)) ? 2 : 1;
> This is a good improment but I still think the pscale_factor adjustments
> are a bit fragile, each call site needs its own hand-tuned formula, and only
> three page sizes (4K/16K/64K) are handled. If a new page size shows up,
> every call site needs revisiting.
>
> How about centralizing the page size adjustment inside values_close()
> itself? Something like:
>
>      static inline int values_close(long a, long b, int err)
>      {
>            ssize_t page_adjusted_err = ffs(page_size >> 13) + err;
>      
>            return 100 * labs(a - b) <= (a + b) * page_adjusted_err;
>      }
>
> This adds one extra percent of tolerance per doubling above 4K, scales
> continuously for any power-of-two page size, and also fixes an integer
> truncation issue in the original: (a + b) / 100 * err loses precision
> when (a + b) < 100.
>
> With this, the callers wouldn't need any changes at all.
>
> This method is inspired from LTP:
>    https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/memcontrol_common.h#L27

Good point. I will implement something like in the next version.

Cheers,
Longman


