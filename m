Return-Path: <cgroups+bounces-4703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AFC96C99C
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18DB1F26824
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC31714B2;
	Wed,  4 Sep 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF6OnJVR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E03166F13
	for <cgroups@vger.kernel.org>; Wed,  4 Sep 2024 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485959; cv=none; b=reOeefLyKwDLDp1MWBg9S2/XoA1ZyJxntimNGaaYsyqgR96xjg/PExCRc+rYmFeyNcc40Zi6Jkpgtrk1EXjpc3Kuqp0iydM2ibgX2Xpa80m1PVZZBZIMphVk+5EsE3jU2iWfSFLwadEwVS71WU+Q1EIg44+y0rngXNJr1y4oWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485959; c=relaxed/simple;
	bh=rilxRBy8H/TW9SQb3Jd3rlJ4uWvpZ3oeAmSp0ONbM5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDi3Q0xEoWCYB6j8V1QxGajgK9fYOs7UNR5kLzrAzXOMdTBoYg7e0ur/UnfyO3aguLZwdLEJzDnv0Di4OEhVlTLz+PTrpJEc8Hm8y9kRwdkJx/0m6P7X1BhcnmV3Cef6Mkq7PA+1EHVqdDhwx+PxJw6+5bBO6fLqS8jJOkrkfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF6OnJVR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725485956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7sVZRygMt8WVBp9EDmrb53irfdcUMzJKYJx8kYK3v4=;
	b=MF6OnJVRZMRxz3+nG+s1FSkrwf5OCw2dMoRbxCTOUwGwoG2Kgk6kTQvbv70HDxbqYZNGYD
	TzBXqaD1RxH+AkebFUfuvQixF5NWfZKC9ojV8NDeLLWpwyEJhlTx/k7Pxq8S2wkUVMPDLd
	9rf/ECEOWRPZIKp9WDzxae6smrNmhjI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-X8Ry8Vj1N_27BdOOg6-sbQ-1; Wed,
 04 Sep 2024 17:39:10 -0400
X-MC-Unique: X8Ry8Vj1N_27BdOOg6-sbQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEF601955F65;
	Wed,  4 Sep 2024 21:39:06 +0000 (UTC)
Received: from [10.2.16.172] (unknown [10.2.16.172])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B88F1956052;
	Wed,  4 Sep 2024 21:39:02 +0000 (UTC)
Message-ID: <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
Date: Wed, 4 Sep 2024 17:39:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue &
 flush work
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
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240622035815.569665-2-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 6/21/24 23:58, Leonardo Bras wrote:
> Some places in the kernel implement a parallel programming strategy
> consisting on local_locks() for most of the work, and some rare remote
> operations are scheduled on target cpu. This keeps cache bouncing low since
> cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> kernels, even though the very few remote operations will be expensive due
> to scheduling overhead.
>
> On the other hand, for RT workloads this can represent a problem: getting
> an important workload scheduled out to deal with some unrelated task is
> sure to introduce unexpected deadline misses.
>
> It's interesting, though, that local_lock()s in RT kernels become
> spinlock(). We can make use of those to avoid scheduling work on a remote
> cpu by directly updating another cpu's per_cpu structure, while holding
> it's spinlock().
>
> In order to do that, it's necessary to introduce a new set of functions to
> make it possible to get another cpu's per-cpu "local" lock (qpw_{un,}lock*)
> and also the corresponding queue_percpu_work_on() and flush_percpu_work()
> helpers to run the remote work.
>
> On non-RT kernels, no changes are expected, as every one of the introduced
> helpers work the exactly same as the current implementation:
> qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
> queue_percpu_work_on()  ->  queue_work_on()
> flush_percpu_work()     ->  flush_work()
>
> For RT kernels, though, qpw_{un,}lock*() will use the extra cpu parameter
> to select the correct per-cpu structure to work on, and acquire the
> spinlock for that cpu.
>
> queue_percpu_work_on() will just call the requested function in the current
> cpu, which will operate in another cpu's per-cpu object. Since the
> local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.
>
> flush_percpu_work() then becomes a no-op since no work is actually
> scheduled on a remote cpu.
>
> Some minimal code rework is needed in order to make this mechanism work:
> The calls for local_{un,}lock*() on the functions that are currently
> scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), so in
> RT kernels they can reference a different cpu. It's also necessary to use a
> qpw_struct instead of a work_struct, but it just contains a work struct
> and, in PREEMPT_RT, the target cpu.
>
> This should have almost no impact on non-RT kernels: few this_cpu_ptr()
> will become per_cpu_ptr(,smp_processor_id()).
>
> On RT kernels, this should improve performance and reduce latency by
> removing scheduling noise.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>   include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 include/linux/qpw.h
>
> diff --git a/include/linux/qpw.h b/include/linux/qpw.h
> new file mode 100644
> index 000000000000..ea2686a01e5e
> --- /dev/null
> +++ b/include/linux/qpw.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_QPW_H
> +#define _LINUX_QPW_H
> +
> +#include "linux/local_lock.h"
> +#include "linux/workqueue.h"
> +
> +#ifndef CONFIG_PREEMPT_RT
> +
> +struct qpw_struct {
> +	struct work_struct work;
> +};
> +
> +#define qpw_lock(lock, cpu)					\
> +	local_lock(lock)
> +
> +#define qpw_unlock(lock, cpu)					\
> +	local_unlock(lock)
> +
> +#define qpw_lock_irqsave(lock, flags, cpu)			\
> +	local_lock_irqsave(lock, flags)
> +
> +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
> +	local_unlock_irqrestore(lock, flags)
> +
> +#define queue_percpu_work_on(c, wq, qpw)			\
> +	queue_work_on(c, wq, &(qpw)->work)
> +
> +#define flush_percpu_work(qpw)					\
> +	flush_work(&(qpw)->work)
> +
> +#define qpw_get_cpu(qpw)					\
> +	smp_processor_id()
> +
> +#define INIT_QPW(qpw, func, c)					\
> +	INIT_WORK(&(qpw)->work, (func))
> +
> +#else /* !CONFIG_PREEMPT_RT */
> +
> +struct qpw_struct {
> +	struct work_struct work;
> +	int cpu;
> +};
> +
> +#define qpw_lock(__lock, cpu)					\
> +	do {							\
> +		migrate_disable();				\
> +		spin_lock(per_cpu_ptr((__lock), cpu));		\
> +	} while (0)
> +
> +#define qpw_unlock(__lock, cpu)					\
> +	do {							\
> +		spin_unlock(per_cpu_ptr((__lock), cpu));	\
> +		migrate_enable();				\
> +	} while (0)

Why there is a migrate_disable/enable() call in qpw_lock/unlock()? The 
rt_spin_lock/unlock() calls have already include a 
migrate_disable/enable() pair.

> +
> +#define qpw_lock_irqsave(lock, flags, cpu)			\
> +	do {							\
> +		typecheck(unsigned long, flags);		\
> +		flags = 0;					\
> +		qpw_lock(lock, cpu);				\
> +	} while (0)
> +
> +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
> +	qpw_unlock(lock, cpu)
> +
> +#define queue_percpu_work_on(c, wq, qpw)			\
> +	do {							\
> +		struct qpw_struct *__qpw = (qpw);		\
> +		WARN_ON((c) != __qpw->cpu);			\
> +		__qpw->work.func(&__qpw->work);			\
> +	} while (0)
> +
> +#define flush_percpu_work(qpw)					\
> +	do {} while (0)
> +
> +#define qpw_get_cpu(w)						\
> +	container_of((w), struct qpw_struct, work)->cpu
> +
> +#define INIT_QPW(qpw, func, c)					\
> +	do {							\
> +		struct qpw_struct *__qpw = (qpw);		\
> +		INIT_WORK(&__qpw->work, (func));		\
> +		__qpw->cpu = (c);				\
> +	} while (0)
> +
> +#endif /* CONFIG_PREEMPT_RT */
> +#endif /* LINUX_QPW_H */

You may also consider adding a documentation file about the 
qpw_lock/unlock() calls.

Cheers,
Longman


