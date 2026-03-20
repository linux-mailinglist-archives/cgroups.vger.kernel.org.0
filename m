Return-Path: <cgroups+bounces-14943-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKyVDituvWnL9gIAu9opvQ
	(envelope-from <cgroups+bounces-14943-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 16:56:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8342DCF2E
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02DEE300C023
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80C3CD8DA;
	Fri, 20 Mar 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9W2p4S0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14593BA25B
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022178; cv=none; b=XteYu4RyrJt8+18oLltg8y+iUi6vu8zTcQAe+Ale4DEwvrdUX8CU6a9Dq7CxbbRwEWx4qFI/WN6eTWLDx5T/kZs8WmW6UaVJnC31rO+m6auYWWEy3GfgjTzzFS54DgcGnv4qtUBjr02ouSia9dSwp1KHgfbgHYku6fenavdjbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022178; c=relaxed/simple;
	bh=WGdtQ9UkwN4syyRueLwIRxyFlSFJNuxcmGW3V1qyyno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwYL/RvWxA59DHFP1oq6rU3xvdhj8pA06xxoc790jp0zYyTU4D+jyV8lEQBl5Z/o1TfhaXBtUmgBRizn3gZn1T45jOeWQXg6Iuwt6Od0gJgR1hoy6jcKrvqPW/m3VVvy6Jf5KzYUTA4VgGhsv+2KNj/4VZgHltl6qaYW4a841ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9W2p4S0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774022176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/kXLhgt9Yr5ai3YcsOwThZq2jmSWvfhZOWzfA73NkI=;
	b=d9W2p4S0yZgcPjGm7Nwtn1yYDjbMvOQVYvyyPlEu5/JuaS0vIKtwfUn1HLOwVJUUVyE0xA
	kLpXAmXeHiGwC03Rh6VdnC2ma8lk5Gk8r3ybyY2fy6JnnSSqgzX96VodmNe74LhB148CLL
	Xj5ta7u6lN3w+ZerBLODBw1Gm8Tzqr4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-oJYtEbrqM3WWis1jFTd7-A-1; Fri,
 20 Mar 2026 11:56:10 -0400
X-MC-Unique: oJYtEbrqM3WWis1jFTd7-A-1
X-Mimecast-MFC-AGG-ID: oJYtEbrqM3WWis1jFTd7-A_1774022168
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2E421944EBE;
	Fri, 20 Mar 2026 15:56:07 +0000 (UTC)
Received: from [10.22.65.139] (unknown [10.22.65.139])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC2CA1953944;
	Fri, 20 Mar 2026 15:56:03 +0000 (UTC)
Message-ID: <cee91a5b-5b37-4e19-b0c9-eea985ab490b@redhat.com>
Date: Fri, 20 Mar 2026 11:56:03 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] selftests: memcg: Fix test_memcontrol test failures
 with large page sizes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 James Houghton <jthoughton@google.com>,
 Sebastian Chlad <sebastianchlad@gmail.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>, Li Wang <liwan@redhat.com>
References: <20260319173752.1472864-1-longman@redhat.com>
 <20260319194347.1048fc8d737b6e8f9d82663d@linux-foundation.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260319194347.1048fc8d737b6e8f9d82663d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-14943-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB8342DCF2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 10:43 PM, Andrew Morton wrote:
> On Thu, 19 Mar 2026 13:37:45 -0400 Waiman Long <longman@redhat.com> wrote:
>
>> There are a number of test failures with the running of the
>> test_memcontrol selftest on a 128-core arm64 system on kernels with
>> 4k/16k/64k page sizes. This patch series makes some minor changes to
>> the kernel and the test_memcontrol selftest to address these failures.
>>
>> The first kernel patch scales the memcg vmstats flush threshold
>> logarithmetically instead of linearly with the total number of CPUs. The
>> second kernel patch scale down MEMCG_CHARGE_BATCH with increases in page
>> size. These 2 patches help to reduce the discrepancies between the
>> reported usage data with the real ones.
>>
>> The next 5 test_memcontrol selftest patches adjust the testing code to
>> greatly reduce the chance that it will report failure, though some
>> occasional failures is still possible.
>>
>> To verify the changes, the test_memcontrol selftest was run 100
>> times each on a 128-core arm64 system on kernels with 4k/16k/64k
>> page sizes.  No failure was observed other than some failures of the
>> test_memcg_reclaim test when running on a 16k page size kernel. The
>> reclaim_until() call failed because of the unexpected over-reclaim of
>> memory. This will need a further look but it happens with the 16k page
>> size kernel only and I don't have a production ready kernel config file
>> to use in buildinig this 16k page size kernel. The new test_memcontrol
>> selftest and kernel were also run on a 96-core x86 system to make sure
>> there was no regression.
> AI reviewbot asks questions:
> 	https://sashiko.dev/#/patchset/20260319173752.1472864-1-longman%40redhat.com

 >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
 >> --- a/mm/memcontrol.c
 >> +++ b/mm/memcontrol.c
 >> @@ -548,20 +548,20 @@ struct memcg_vmstats {
 >>   *    rstat update tree grow unbounded.
 >>   *
 >>   * 2) Flush the stats synchronously on reader side only when there 
are more than
 >> - *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this 
optimization
 >> - *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * 
nr_cpus) but
 >> - *    only for 2 seconds due to (1).
 >> + *    (MEMCG_CHARGE_BATCH * (ilog2(nr_cpus) + 1)) update events. 
Though this
 >> + *    optimization will let stats be out of sync by up to that 
amount but only
 >> + *    for 2 seconds due to (1).
 > Is this description accurate regarding the maximum out of sync amount?
 > Looking at memcg_rstat_updated(), updates are buffered locally on 
each CPU
 > up to MEMCG_CHARGE_BATCH - 1 before they are added to the global
 > vmstats->stats_updates counter.
 > Because memcg_vmstats_needs_flush() only checks the global counter, could
 > N CPUs each buffer MEMCG_CHARGE_BATCH - 1 updates without triggering a
 > synchronous flush?
 > If so, wouldn't the actual worst-case out-of-sync error be
 > N * (MEMCG_CHARGE_BATCH - 1) + vmstats_flush_threshold, which remains
 > linear with the number of CPUs rather than scaling logarithmically?

Good point, the worst case scenario can indeed be worse than that. I
will update the comment accordingly.

 >> @@ -328,8 +328,14 @@ struct mem_cgroup {
 >>   * size of first charge trial.
 >>   * TODO: maybe necessary to use big numbers in big irons or dynamic 
based of the
 >>   * workload.
 >> + *
 >> + * There are 3 common base page sizes - 4k, 16k & 64k. In order to 
limit the
 >> + * amount of memory that can be hidden in each percpu memcg_stock 
for a given
 >> + * memcg, we scale down MEMCG_CHARGE_BATCH by 2 for 16k and 4 for 64k.
 >>   */
 >> -#define MEMCG_CHARGE_BATCH 64U
 >> +#define MEMCG_CHARGE_BATCH_BASE  64U
 >> +#define MEMCG_CHARGE_BATCH_SHIFT ((PAGE_SHIFT <= 16) ? (PAGE_SHIFT 
- 12)/2 : 2)
 >> +#define MEMCG_CHARGE_BATCH     (MEMCG_CHARGE_BATCH_BASE >> 
MEMCG_CHARGE_BATCH_SHIFT)
 > Will this cause false failures in the cgroup selftests on systems with
 > larger page sizes?

Exactly, Li Wang had posted a patch [1] to address this issue. We will have
to update this code again if this patch is adopted to reduce the expected
MAX_VMSTAT_ERROR accordingly.

[1] https://lore.kernel.org/lkml/20260306071843.149147-1-liwang@redhat.com/

 > In tools/testing/selftests/cgroup/test_kmem.c, MAX_VMSTAT_ERROR is 
hardcoded
 > assuming a 4KB page size and a 64-page charge batch (256KB per CPU):
 > #define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
 > ...
 >     if (labs(sum - current) < MAX_VMSTAT_ERROR) {
 > ...
 > With this change, a 64KB page system will have a batch size of 16. The
 > theoretical per-CPU error becomes 16 pages * 64KB = 1024KB per CPU, which
 > is 4 times larger than the hardcoded MAX_VMSTAT_ERROR.
 > Does MAX_VMSTAT_ERROR in test_kmem.c need to be updated to compute 
the error
 > using the runtime system page size and the adjusted batch limit?

 >> diff --git 
a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h 
b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
 >> index 77f386dab5e8..c25228a78b8b 100644
 >> --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
 >> +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
 >> @@ -6,6 +6,7 @@
 >>  #define PAGE_SIZE 4096
 >>  #endif
 >>
 >> +#define KB(x) (x << 10)
 > This isn't a bug, but could this macro definition risk operator 
precedence
 > issues if invoked with an expression? Should it be defined with inner
 > parentheses around the argument, like #define KB(x) ((x) << 10)?

So far, only a single integer value is used for x. So the current macro
is still OK. Yes, I do agree that adding parenthesis will be more safe
for future use cases.

 >> @@ -1181,7 +1199,7 @@ static int test_memcg_swap_max_peak(const char 
*root)
 >>      if (cg_read_long(memcg, "memory.peak") < MB(29))
 >>          goto cleanup;
 >>
 >> -    if (cg_read_long(memcg, "memory.swap.peak") < MB(29))
 >> +    if (cg_read_long(memcg, "memory.swap.peak") < swap_peak)
 >>          goto cleanup;
 >>
 >>      if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
 >>          goto cleanup;
 > Does leaving memory.high set to 29M alter the semantics of the subsequent
 > alloc_anon_50M_check_swap test?
 > When alloc_anon_50M_check_swap runs, it allocates 50MB and expects
 > memory.current to be close to the 30MB memory.max limit.
 > Because memory.high is still set to 29MB from the earlier operation, 
the 50MB
 > allocation gets throttled at 29MB and enters synchronous reclaim before
 > reaching the 30MB memory.max limit.
 > Could this inadvertently change the second test from verifying swap 
behavior
 > under a hard limit to verifying it under a soft limit?

The purpose of setting memory.high to 29M is to slow down the memory
allocation process in order to enable the swapping code to swap out
more anonymous memory before the OOM killer comes in and kill the
process. Otherwise, the actual swap out value will be even lower with
larger page size. I can drop setting memory.high and set the threshold
even lower in order to avoid expected failures.

 >> @@ -1477,12 +1477,20 @@ static int test_memcg_sock(const char *root)
 >>       * Poll memory.stat for up to 3 seconds (~FLUSH_TIME plus some
 >>       * scheduling slack) and require that the "sock " counter
 >>       * eventually drops to zero.
 >> +     *
 >> +     * The actual run-to-run elapse time between consecutive run
 >> +     * of asynchronous memcg rstat flush may varies quite a bit.
 >> +     * So the 3 seconds wait time may not be enough for the "sock"
 >> +     * counter to go down to 0. Treat it as a XFAIL instead of
 >> +     * a FAIL.
 >>       */
 >>      sock_post = cg_read_key_long_poll(memcg, "memory.stat", "sock ", 0,
 >>                       MEMCG_SOCKSTAT_WAIT_RETRIES,
 >>                       DEFAULT_WAIT_INTERVAL_US);
 >> -    if (sock_post)
 >> +    if (sock_post) {
 >> +        ret = KSFT_XFAIL;
 >>          goto cleanup;
 >> +    }
 > Does this code inadvertently mask actual system or I/O errors?
 > If cg_read_key_long_poll() returns -1 because it failed to read the 
file or
 > the key is missing, this check will treat it as an expected timeout 
failure
 > rather than an actual test failure.

I will add a positive value check before setting KSFT_XFAIL.

 > Does marking this condition as KSFT_XFAIL prevent the test from catching
 > genuine socket memory leaks?
 > If a kernel regression causes socket memory to actually leak, the 
test will
 > time out and report an expected failure, which CI systems might ignore.
 > Would it be more robust to increase the polling timeout to 
accommodate the
 > maximum latency observed, or manually trigger a synchronous flush, 
instead
 > of masking the timeout?

We may have to increase the timeout excessively in order to allow for
the possible variations of the asynchronous vmstats flush delay. That may
make the test take too long to run. In my own test, the current code 
will fail
rather frequently without this change.

I do suggest that we will have to look into this issue and we can remove 
this expected failure if the issue is fixed.

Cheers,
Longman


