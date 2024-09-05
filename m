Return-Path: <cgroups+bounces-4704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20C96CB8B
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 02:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0C31F2376D
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228720E6;
	Thu,  5 Sep 2024 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adrF772B"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F87FD
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494909; cv=none; b=u5J7WdIMjZ1dKoImZoDmiD6TGeeUqB1xkHkIPR0rq/L7CkuWaFpCPXnYcBEwCfMPN+Vlq2JNGFDDJsdTKYzJaBTxY5nRclSCE+bcWNMFbzDnOYj8edqEtwe3Q1/1puV63S7LJA6o7mcw+GYthexqmT4iFY9uLUcWfUds7vDD6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494909; c=relaxed/simple;
	bh=xBRl5lCEw9Aaa1Gcw7JKGR18nO9scrn+v/5PHEBHzTM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f22YcyJ34vL4gVI2+0UwHxWeqUCxkzXRBcRs0PxJ3onCRVC5/1MtGJsf4WEVa1wBAi/y75054uJ3v/tjJ7OAUvxDKpSHEBhnm/Yax0ODjj0tv9N50oCa+X08EQ7O6GDtlcQ0RlS/Z/7g9g9Yt/CHA7O+vypgqKDTmVMNUVVS1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adrF772B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725494906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHS4zP9jA0mTvK7JF/ePZcYsAK2+oZaSxTHPolbumnA=;
	b=adrF772B09M+jZF9ku78jI/t8jkl2MDLbh9TSxv3TNGT1H0XlCsOaAfqWClQffd7EYknsX
	xKMt+ln9SDp2apVTGJfBu0kADuJqvbfr6kZHj2uFzZ902Oe5cndDGRoHAwnEWzbyXABHCy
	+sAF8oLuLplqLunhmFJn1XmCOMWYfeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-SmZMspabPjaLULqbFRBxhQ-1; Wed,
 04 Sep 2024 20:08:20 -0400
X-MC-Unique: SmZMspabPjaLULqbFRBxhQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2AD31955D45;
	Thu,  5 Sep 2024 00:08:17 +0000 (UTC)
Received: from [10.2.16.172] (unknown [10.2.16.172])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 902B21956086;
	Thu,  5 Sep 2024 00:08:13 +0000 (UTC)
Message-ID: <a9fdcd85-633c-4e88-9e1f-db0b9d3b745c@redhat.com>
Date: Wed, 4 Sep 2024 20:08:12 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue &
 flush work
From: Waiman Long <longman@redhat.com>
To: Leonardo Bras <leobras@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20240622035815.569665-1-leobras@redhat.com>
 <20240622035815.569665-2-leobras@redhat.com>
 <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
Content-Language: en-US
In-Reply-To: <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 9/4/24 17:39, Waiman Long wrote:
> On 6/21/24 23:58, Leonardo Bras wrote:
>> Some places in the kernel implement a parallel programming strategy
>> consisting on local_locks() for most of the work, and some rare remote
>> operations are scheduled on target cpu. This keeps cache bouncing low 
>> since
>> cacheline tends to be mostly local, and avoids the cost of locks in 
>> non-RT
>> kernels, even though the very few remote operations will be expensive 
>> due
>> to scheduling overhead.
>>
>> On the other hand, for RT workloads this can represent a problem: 
>> getting
>> an important workload scheduled out to deal with some unrelated task is
>> sure to introduce unexpected deadline misses.
>>
>> It's interesting, though, that local_lock()s in RT kernels become
>> spinlock(). We can make use of those to avoid scheduling work on a 
>> remote
>> cpu by directly updating another cpu's per_cpu structure, while holding
>> it's spinlock().
>>
>> In order to do that, it's necessary to introduce a new set of 
>> functions to
>> make it possible to get another cpu's per-cpu "local" lock 
>> (qpw_{un,}lock*)
>> and also the corresponding queue_percpu_work_on() and 
>> flush_percpu_work()
>> helpers to run the remote work.
>>
>> On non-RT kernels, no changes are expected, as every one of the 
>> introduced
>> helpers work the exactly same as the current implementation:
>> qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
>> queue_percpu_work_on()  ->  queue_work_on()
>> flush_percpu_work()     ->  flush_work()
>>
>> For RT kernels, though, qpw_{un,}lock*() will use the extra cpu 
>> parameter
>> to select the correct per-cpu structure to work on, and acquire the
>> spinlock for that cpu.
>>
>> queue_percpu_work_on() will just call the requested function in the 
>> current
>> cpu, which will operate in another cpu's per-cpu object. Since the
>> local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.
>>
>> flush_percpu_work() then becomes a no-op since no work is actually
>> scheduled on a remote cpu.
>>
>> Some minimal code rework is needed in order to make this mechanism work:
>> The calls for local_{un,}lock*() on the functions that are currently
>> scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), 
>> so in
>> RT kernels they can reference a different cpu. It's also necessary to 
>> use a
>> qpw_struct instead of a work_struct, but it just contains a work struct
>> and, in PREEMPT_RT, the target cpu.
>>
>> This should have almost no impact on non-RT kernels: few this_cpu_ptr()
>> will become per_cpu_ptr(,smp_processor_id()).
>>
>> On RT kernels, this should improve performance and reduce latency by
>> removing scheduling noise.
>>
>> Signed-off-by: Leonardo Bras <leobras@redhat.com>
>> ---
>>   include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>   create mode 100644 include/linux/qpw.h
>>
>> diff --git a/include/linux/qpw.h b/include/linux/qpw.h
>> new file mode 100644
>> index 000000000000..ea2686a01e5e
>> --- /dev/null
>> +++ b/include/linux/qpw.h
>> @@ -0,0 +1,88 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_QPW_H
>> +#define _LINUX_QPW_H

I would suggest adding a comment with a brief description of what 
qpw_lock/unlock() are for and their use cases. The "qpw" prefix itself 
isn't intuitive enough for a casual reader to understand what they are for.

Cheers,
Longman


