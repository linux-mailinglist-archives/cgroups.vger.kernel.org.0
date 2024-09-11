Return-Path: <cgroups+bounces-4844-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F8975452
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD7C1F26B5B
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404851A7AF9;
	Wed, 11 Sep 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U16vg97Q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4201A3A98
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061991; cv=none; b=eFyR4eKEt9fy6Rt2/PNCw57iS7Kdpq3lNPOUv+WQlf+o9k8fS0PCN/6icjmcP6WaY2km2/zOKfjEm4JDk44pFqsex69ZePKtbTulp9ZhtmoS8icT98BZzjP4wasFdUx2nAabIJEihlEJJmcd4sGBaVnhqpGPRqtFmH2AshmZl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061991; c=relaxed/simple;
	bh=j0hfvJ4Zgr0nQD+pP1C+IElAPHeSAWmAVfVG9dK27pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/VEskPSs8lXdqmVmljhLzazi+NTG9IUclreR+hOmg7N8fNigtek96cQrYQMNt7PNqpyPpUgvRx57poL32lbPk2yoDAgMppYTHnpyrLpmrXTg/90pRQWeoIxL8Frjarkwm7h1P/ygnk3HeDND7gZaNfRQhHzYlbNeJS5LE5bXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U16vg97Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726061988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvwU4cqki9TtrB27KP2JwOIZHnNDzLJG2G+q3XLkyHM=;
	b=U16vg97QLxg2tSqkxWo/Uec7VzN7UTyTS+MXwToXbhJj7mfRCyxZNhuE5BshaBy2VZuFMT
	2iOcK+ZZO2iAkSPLRzAMGmjz1fh6eR6uu3wA+dXbcnvVdflulxvgWqJHrL00DeGF4MzwOF
	qOdPNiLZgmZUEdDmBjcklis8pVR08V0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-VyqdG2tONZesNhXAM0qVnw-1; Wed,
 11 Sep 2024 09:39:47 -0400
X-MC-Unique: VyqdG2tONZesNhXAM0qVnw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96CDF1955F45;
	Wed, 11 Sep 2024 13:39:43 +0000 (UTC)
Received: from [10.2.16.53] (unknown [10.2.16.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57EFB19560AB;
	Wed, 11 Sep 2024 13:39:38 +0000 (UTC)
Message-ID: <c2776802-1136-405f-a172-2996fafd3780@redhat.com>
Date: Wed, 11 Sep 2024 09:39:37 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue &
 flush work
To: Leonardo Bras <leobras@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20240622035815.569665-1-leobras@redhat.com>
 <20240622035815.569665-2-leobras@redhat.com>
 <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com> <ZuFD8bR01GhPbPH6@LeoBras>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZuFD8bR01GhPbPH6@LeoBras>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 9/11/24 03:17, Leonardo Bras wrote:
> On Wed, Sep 04, 2024 at 05:39:01PM -0400, Waiman Long wrote:
>> On 6/21/24 23:58, Leonardo Bras wrote:
>>> Some places in the kernel implement a parallel programming strategy
>>> consisting on local_locks() for most of the work, and some rare remote
>>> operations are scheduled on target cpu. This keeps cache bouncing low since
>>> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
>>> kernels, even though the very few remote operations will be expensive due
>>> to scheduling overhead.
>>>
>>> On the other hand, for RT workloads this can represent a problem: getting
>>> an important workload scheduled out to deal with some unrelated task is
>>> sure to introduce unexpected deadline misses.
>>>
>>> It's interesting, though, that local_lock()s in RT kernels become
>>> spinlock(). We can make use of those to avoid scheduling work on a remote
>>> cpu by directly updating another cpu's per_cpu structure, while holding
>>> it's spinlock().
>>>
>>> In order to do that, it's necessary to introduce a new set of functions to
>>> make it possible to get another cpu's per-cpu "local" lock (qpw_{un,}lock*)
>>> and also the corresponding queue_percpu_work_on() and flush_percpu_work()
>>> helpers to run the remote work.
>>>
>>> On non-RT kernels, no changes are expected, as every one of the introduced
>>> helpers work the exactly same as the current implementation:
>>> qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
>>> queue_percpu_work_on()  ->  queue_work_on()
>>> flush_percpu_work()     ->  flush_work()
>>>
>>> For RT kernels, though, qpw_{un,}lock*() will use the extra cpu parameter
>>> to select the correct per-cpu structure to work on, and acquire the
>>> spinlock for that cpu.
>>>
>>> queue_percpu_work_on() will just call the requested function in the current
>>> cpu, which will operate in another cpu's per-cpu object. Since the
>>> local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.
>>>
>>> flush_percpu_work() then becomes a no-op since no work is actually
>>> scheduled on a remote cpu.
>>>
>>> Some minimal code rework is needed in order to make this mechanism work:
>>> The calls for local_{un,}lock*() on the functions that are currently
>>> scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), so in
>>> RT kernels they can reference a different cpu. It's also necessary to use a
>>> qpw_struct instead of a work_struct, but it just contains a work struct
>>> and, in PREEMPT_RT, the target cpu.
>>>
>>> This should have almost no impact on non-RT kernels: few this_cpu_ptr()
>>> will become per_cpu_ptr(,smp_processor_id()).
>>>
>>> On RT kernels, this should improve performance and reduce latency by
>>> removing scheduling noise.
>>>
>>> Signed-off-by: Leonardo Bras <leobras@redhat.com>
>>> ---
>>>    include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 88 insertions(+)
>>>    create mode 100644 include/linux/qpw.h
>>>
>>> diff --git a/include/linux/qpw.h b/include/linux/qpw.h
>>> new file mode 100644
>>> index 000000000000..ea2686a01e5e
>>> --- /dev/null
>>> +++ b/include/linux/qpw.h
>>> @@ -0,0 +1,88 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _LINUX_QPW_H
>>> +#define _LINUX_QPW_H
>>> +
>>> +#include "linux/local_lock.h"
>>> +#include "linux/workqueue.h"
>>> +
>>> +#ifndef CONFIG_PREEMPT_RT
>>> +
>>> +struct qpw_struct {
>>> +	struct work_struct work;
>>> +};
>>> +
>>> +#define qpw_lock(lock, cpu)					\
>>> +	local_lock(lock)
>>> +
>>> +#define qpw_unlock(lock, cpu)					\
>>> +	local_unlock(lock)
>>> +
>>> +#define qpw_lock_irqsave(lock, flags, cpu)			\
>>> +	local_lock_irqsave(lock, flags)
>>> +
>>> +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
>>> +	local_unlock_irqrestore(lock, flags)
>>> +
>>> +#define queue_percpu_work_on(c, wq, qpw)			\
>>> +	queue_work_on(c, wq, &(qpw)->work)
>>> +
>>> +#define flush_percpu_work(qpw)					\
>>> +	flush_work(&(qpw)->work)
>>> +
>>> +#define qpw_get_cpu(qpw)					\
>>> +	smp_processor_id()
>>> +
>>> +#define INIT_QPW(qpw, func, c)					\
>>> +	INIT_WORK(&(qpw)->work, (func))
>>> +
>>> +#else /* !CONFIG_PREEMPT_RT */
>>> +
>>> +struct qpw_struct {
>>> +	struct work_struct work;
>>> +	int cpu;
>>> +};
>>> +
>>> +#define qpw_lock(__lock, cpu)					\
>>> +	do {							\
>>> +		migrate_disable();				\
>>> +		spin_lock(per_cpu_ptr((__lock), cpu));		\
>>> +	} while (0)
>>> +
>>> +#define qpw_unlock(__lock, cpu)					\
>>> +	do {							\
>>> +		spin_unlock(per_cpu_ptr((__lock), cpu));	\
>>> +		migrate_enable();				\
>>> +	} while (0)
>> Why there is a migrate_disable/enable() call in qpw_lock/unlock()? The
>> rt_spin_lock/unlock() calls have already include a migrate_disable/enable()
>> pair.
> This was copied from PREEMPT_RT=y local_locks.
>
> In my tree, I see:
>
> #define __local_unlock(__lock)					\
> 	do {							\
> 		spin_unlock(this_cpu_ptr((__lock)));		\
> 		migrate_enable();				\
> 	} while (0)
>
> But you are right:
> For PREEMPT_RT=y, spin_{un,}lock() will be defined in spinlock_rt.h
> as rt_spin{un,}lock(), which already runs migrate_{en,dis}able().
>
> On the other hand, for spin_lock() will run migrate_disable() just before
> finishing the function, and local_lock() will run it before calling
> spin_lock() and thus, before spin_acquire().
>
> (local_unlock looks like to have an unnecessary extra migrate_enable(),
> though).
>
> I am not sure if it's actually necessary to run this extra
> migrate_disable() in local_lock() case, maybe Thomas could help us
> understand this.
>
> But sure, if we can remove this from local_{un,}lock(), I am sure we can
> also remove this from qpw.

I see. I believe the reason for this extra migrate_disable/enable() is 
to protect the this_cpu_ptr() call to prevent switching to another CPU 
right after this_cpu_ptr() but before the migrate_disable() inside 
rt_spin_lock(). So keep the migrate_disable/enable() as is.

Cheers,
Longman


