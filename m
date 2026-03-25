Return-Path: <cgroups+bounces-15036-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB0VNPNaw2m1qQQAu9opvQ
	(envelope-from <cgroups+bounces-15036-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 04:48:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B2531F34E
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 04:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3334303A916
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 03:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E7D1428F4;
	Wed, 25 Mar 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZuZz6C1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E1202997
	for <cgroups@vger.kernel.org>; Wed, 25 Mar 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774410480; cv=none; b=DUbeh9mWauah129zlooxAyqhqxdYxR++peAYDSpjwC4gBCLWAXr/ye/spbJ+tKdIaQ+u/fC9D2gWjWNiFtH51tb5Y964gF0JJBztPsWxQErjNPfZmSWZ9XCShndsyeEM/O8XwLBe56iGHIhAwbP5XKeiuPec9FtuNixE1ZdNhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774410480; c=relaxed/simple;
	bh=Yej5S8iXi8AbZgFW+ajB9NiRW2qyCJsWwCuW84ZFsW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXfOSROB2lG7TzujuRAeWToh0FddkqF84pI9CP1+BibTbUP4mCDDmUN1QECC9ICZm+1StbpmmhvWNxQqR3g1TOjBemDhtGEnZYgp0qv79P6cWVmtnx9sG+egquO1NrEuUr6Q0LhDKQn2hSjhpXHkKcAag1i0Z9bV/12UTiMUGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZuZz6C1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774410478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTWuW19SzsgMBofMGpQhLndrrAHyvaqK2jt4CAJhThs=;
	b=AZuZz6C1Rv1YwxyIqhimjzOBXqk4kFuCk638KQM+yUJJvbLICiexsnWclPzFd/256VMnrF
	w5bJHIq2CmtutDQxT0G1u8DbW4M+xp8tErr/cO4rdbi4k3kKdMt8DZpiG/fB2Shr4JeiSh
	AcWWkdI2/oqRrKftiHocPOgvOjwQP8o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-9zpRRRgTOyyAahvbGz0crA-1; Tue,
 24 Mar 2026 23:47:56 -0400
X-MC-Unique: 9zpRRRgTOyyAahvbGz0crA-1
X-Mimecast-MFC-AGG-ID: 9zpRRRgTOyyAahvbGz0crA_1774410474
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 328D0195609E;
	Wed, 25 Mar 2026 03:47:53 +0000 (UTC)
Received: from [10.22.65.192] (unknown [10.22.65.192])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E51103000223;
	Wed, 25 Mar 2026 03:47:48 +0000 (UTC)
Message-ID: <ac21dea1-4fbd-4003-9723-1c02fdb5d03a@redhat.com>
Date: Tue, 24 Mar 2026 23:47:47 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] selftests: memcg: Reduce the expected swap.peak
 with larger page size
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
 <20260320204241.1613861-6-longman@redhat.com> <acD4vGZKveXJ4GuW@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <acD4vGZKveXJ4GuW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,suse.com,vger.kernel.org,kvack.org,google.com,gmail.com,kylinos.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-15036-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B2531F34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 4:24 AM, Li Wang wrote:
> On Fri, Mar 20, 2026 at 04:42:39PM -0400, Waiman Long wrote:
>> When running the test_memcg_swap_max_peak test which sets swap.max
>> to 30M on an arm64 system with 64k page size, the test failed as the
>> swap.peak could only reach up only to 27,328,512 bytes (about 25.45
>> MB which is lower than the expected 29M) before the allocating task
>> got oom-killed.
>>
>> It is likely due to the fact that it takes longer to write out a larger
>> page to swap and hence a lower swap.peak is being reached. Setting
>> memory.high to 29M to throttle memory allocation when nearing memory.max
>> helps, but it still could only reach up to 29,032,448 bytes (about
>> 27.04M). As a result, we have to reduce the expected swap.peak with
>> larger page size. Now swap.peak is expected to reach only 27M with 64k
>> page, 29M with 4k page and 28M with 16k page.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   .../selftests/cgroup/test_memcontrol.c        | 26 ++++++++++++++++---
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
>> index c078fc458def..3832ded1e47b 100644
>> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
>> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
>> @@ -1032,6 +1032,7 @@ static int test_memcg_swap_max_peak(const char *root)
>>   	char *memcg;
>>   	long max, peak;
>>   	struct stat ss;
>> +	long swap_peak;
>>   	int swap_peak_fd = -1, mem_peak_fd = -1;
>>   
>>   	/* any non-empty string resets */
>> @@ -1119,6 +1120,23 @@ static int test_memcg_swap_max_peak(const char *root)
>>   	if (cg_write(memcg, "memory.max", "30M"))
>>   		goto cleanup;
>>   
>> +	/*
>> +	 * The swap.peak that can be reached will depend on the system page
>> +	 * size. With larger page size (e.g. 64k), it takes more time to write
>> +	 * the anonymous memory page to swap and so the peak reached will be
>> +	 * lower before the memory allocation process get oom-killed. One way
>> +	 * to allow the swap.peak to go higher is to throttle memory allocation
>> +	 * by setting memory.high to, say, 29M to give more time to swap out the
>> +	 * memory before oom-kill. This is still not enough for it to reach
>> +	 * 29M reachable with 4k page. So we still need to reduce the expected
>> +	 * swap.peak accordingly.
>> +	 */
>> +	swap_peak = (page_size == KB(4)) ? MB(29) :
>> +		   ((page_size <= KB(16)) ? MB(28) : MB(27));
> Or, go with a dynamic adjustment based on page size?
>
>      swap_peak = MB(29) - ilog2(page_size / KB(4)) * MB(1);
>
It is a good suggestion. I will adopt a dynamic base adjustment as 
suggested.

Cheers,
Longman


