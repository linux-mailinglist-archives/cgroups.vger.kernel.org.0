Return-Path: <cgroups+bounces-4840-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BC974B15
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 09:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C8B1C246EB
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A013C80C;
	Wed, 11 Sep 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLnpR3zM"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778F1311B6
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039055; cv=none; b=VFo+1A5g4RGjcW5Gcwq5y5l2j/V6Rzc+RWGU/rvD5zxXk+OS4TokTfQa8PfsIqucx5IYY0XWZFPYp4jqr7yTZ68Sx5rHh/6Rot0CFi+IK4xBjah4NE9kv+iGfvgeuzG3NsTdy0j2TEQVCvU2cMNFinaSPSYFh2x9grRehTGjyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039055; c=relaxed/simple;
	bh=rAXfuwy7B2+QXySHJ14taKQMc/nkJ5KahS/kgFJm4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=HEdUJZcYhSj3mqEnpHy10QS92CB66Ys642zTWyGGTdaRwysb7QyMOVwKlsga11SnYSXJ6CEoP+rByjBST3XSvxv1H01gwLguC4AKgvUCAvb0EjWS72Il895gWqS5eL5A3Dwef6G58cn9RIhNX7hv2ssxtmH24Cg770hDbkV3JR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLnpR3zM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726039051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWS0zdSRA6QBuHeVPu9p9QQM9sNJybBO18pUWus00es=;
	b=aLnpR3zMgnFoTWzjOX2FV1arDVLmrebiMwrfyAkj+znGb7cpMIsdLwgnOuG2qDsKekdVvj
	35WTW82AGZuyDiG7YB0EsccKTuxP+IBdw1bT9ROTi03bFc0FX7uLOETBE/Zyv6sLKOG049
	a7v2EoT6MtuiCfxWLHsEVUTOfyhgpxw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-1MMtOtQ8OXGtjJFHuJiCPg-1; Wed, 11 Sep 2024 03:17:30 -0400
X-MC-Unique: 1MMtOtQ8OXGtjJFHuJiCPg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7d4f9974c64so5180766a12.1
        for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 00:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039049; x=1726643849;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWS0zdSRA6QBuHeVPu9p9QQM9sNJybBO18pUWus00es=;
        b=Nqn4hEmPxV+IqKCB2NTfueNKT4i45dF+wjrPY0hBbUPmo4zXF3Q7GaeZCD40C9S3/u
         DAxsfX8D1dR8EdAMHZsJQdd2NKkNr7oaiEvWOV+yYq+dAlxkiW6aYQ/DUgW8rblutR1y
         1ineJ+c4G7ZypCuARt/jybJREOvcx2W7Hp+WgPubMn/55PhngnLZLT6rKS38ASgycT1R
         PP9bpVIv9yXUERrD3nxmIT0vP5NfyvqtxuSxzbO3mh8PrU73/EJBrUeI9LHNTxNLnu9w
         RPqx76glompydgZ/eenAVr7nNIkEJhHU9QzfNgD2G5ycje+gk2ft+44qi1sjvs7wNgM3
         W6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXvagFt/jqpVoMwFBrdm2cjuXM0xeqKG/cfr4fT+hKAPwklRunSuyE0vzM3kk68wZDsy0V7Rz5Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+gsPSKgT7eH2vy7uSjK1+Hh7fD3SvRGxjfybBVeb07O7mytT
	q2Hn5V8SIrm2CFSoPVvg6JO85K1+maqj5XK95zpA+DR0JI8bKVMW0WtiPosxKd3l0bjxJsG29q+
	eFi8/LD3rjbXLzWA7VdNPQSF/b2fF5Rbfg3jf7iOurhKTsrwWdbbapDo=
X-Received: by 2002:a05:6a20:d526:b0:1ce:cde2:4458 with SMTP id adf61e73a8af0-1cf5e15710amr5116826637.35.1726039049179;
        Wed, 11 Sep 2024 00:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfPMdzQCpRyvsuzf833UGi7nTs6J1w1LxjL6dvBwUdC2XXOTOBOy5/7LWeNy6FfSCYJeydpA==
X-Received: by 2002:a05:6a20:d526:b0:1ce:cde2:4458 with SMTP id adf61e73a8af0-1cf5e15710amr5116788637.35.1726039048478;
        Wed, 11 Sep 2024 00:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:3c59:c8f1:7d33:571a:fde2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db12af2c69sm419278a12.38.2024.09.11.00.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:17:27 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Date: Wed, 11 Sep 2024 04:17:05 -0300
Message-ID: <ZuFD8bR01GhPbPH6@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
References: <20240622035815.569665-1-leobras@redhat.com> <20240622035815.569665-2-leobras@redhat.com> <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 04, 2024 at 05:39:01PM -0400, Waiman Long wrote:
> On 6/21/24 23:58, Leonardo Bras wrote:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with some unrelated task is
> > sure to introduce unexpected deadline misses.
> > 
> > It's interesting, though, that local_lock()s in RT kernels become
> > spinlock(). We can make use of those to avoid scheduling work on a remote
> > cpu by directly updating another cpu's per_cpu structure, while holding
> > it's spinlock().
> > 
> > In order to do that, it's necessary to introduce a new set of functions to
> > make it possible to get another cpu's per-cpu "local" lock (qpw_{un,}lock*)
> > and also the corresponding queue_percpu_work_on() and flush_percpu_work()
> > helpers to run the remote work.
> > 
> > On non-RT kernels, no changes are expected, as every one of the introduced
> > helpers work the exactly same as the current implementation:
> > qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
> > queue_percpu_work_on()  ->  queue_work_on()
> > flush_percpu_work()     ->  flush_work()
> > 
> > For RT kernels, though, qpw_{un,}lock*() will use the extra cpu parameter
> > to select the correct per-cpu structure to work on, and acquire the
> > spinlock for that cpu.
> > 
> > queue_percpu_work_on() will just call the requested function in the current
> > cpu, which will operate in another cpu's per-cpu object. Since the
> > local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.
> > 
> > flush_percpu_work() then becomes a no-op since no work is actually
> > scheduled on a remote cpu.
> > 
> > Some minimal code rework is needed in order to make this mechanism work:
> > The calls for local_{un,}lock*() on the functions that are currently
> > scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), so in
> > RT kernels they can reference a different cpu. It's also necessary to use a
> > qpw_struct instead of a work_struct, but it just contains a work struct
> > and, in PREEMPT_RT, the target cpu.
> > 
> > This should have almost no impact on non-RT kernels: few this_cpu_ptr()
> > will become per_cpu_ptr(,smp_processor_id()).
> > 
> > On RT kernels, this should improve performance and reduce latency by
> > removing scheduling noise.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >   include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100644 include/linux/qpw.h
> > 
> > diff --git a/include/linux/qpw.h b/include/linux/qpw.h
> > new file mode 100644
> > index 000000000000..ea2686a01e5e
> > --- /dev/null
> > +++ b/include/linux/qpw.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_QPW_H
> > +#define _LINUX_QPW_H
> > +
> > +#include "linux/local_lock.h"
> > +#include "linux/workqueue.h"
> > +
> > +#ifndef CONFIG_PREEMPT_RT
> > +
> > +struct qpw_struct {
> > +	struct work_struct work;
> > +};
> > +
> > +#define qpw_lock(lock, cpu)					\
> > +	local_lock(lock)
> > +
> > +#define qpw_unlock(lock, cpu)					\
> > +	local_unlock(lock)
> > +
> > +#define qpw_lock_irqsave(lock, flags, cpu)			\
> > +	local_lock_irqsave(lock, flags)
> > +
> > +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
> > +	local_unlock_irqrestore(lock, flags)
> > +
> > +#define queue_percpu_work_on(c, wq, qpw)			\
> > +	queue_work_on(c, wq, &(qpw)->work)
> > +
> > +#define flush_percpu_work(qpw)					\
> > +	flush_work(&(qpw)->work)
> > +
> > +#define qpw_get_cpu(qpw)					\
> > +	smp_processor_id()
> > +
> > +#define INIT_QPW(qpw, func, c)					\
> > +	INIT_WORK(&(qpw)->work, (func))
> > +
> > +#else /* !CONFIG_PREEMPT_RT */
> > +
> > +struct qpw_struct {
> > +	struct work_struct work;
> > +	int cpu;
> > +};
> > +
> > +#define qpw_lock(__lock, cpu)					\
> > +	do {							\
> > +		migrate_disable();				\
> > +		spin_lock(per_cpu_ptr((__lock), cpu));		\
> > +	} while (0)
> > +
> > +#define qpw_unlock(__lock, cpu)					\
> > +	do {							\
> > +		spin_unlock(per_cpu_ptr((__lock), cpu));	\
> > +		migrate_enable();				\
> > +	} while (0)
> 
> Why there is a migrate_disable/enable() call in qpw_lock/unlock()? The
> rt_spin_lock/unlock() calls have already include a migrate_disable/enable()
> pair.

This was copied from PREEMPT_RT=y local_locks.

In my tree, I see:

#define __local_unlock(__lock)					\
	do {							\
		spin_unlock(this_cpu_ptr((__lock)));		\
		migrate_enable();				\
	} while (0)

But you are right:
For PREEMPT_RT=y, spin_{un,}lock() will be defined in spinlock_rt.h
as rt_spin{un,}lock(), which already runs migrate_{en,dis}able().

On the other hand, for spin_lock() will run migrate_disable() just before 
finishing the function, and local_lock() will run it before calling 
spin_lock() and thus, before spin_acquire().

(local_unlock looks like to have an unnecessary extra migrate_enable(), 
though).

I am not sure if it's actually necessary to run this extra 
migrate_disable() in local_lock() case, maybe Thomas could help us 
understand this.

But sure, if we can remove this from local_{un,}lock(), I am sure we can 
also remove this from qpw.


> 
> > +
> > +#define qpw_lock_irqsave(lock, flags, cpu)			\
> > +	do {							\
> > +		typecheck(unsigned long, flags);		\
> > +		flags = 0;					\
> > +		qpw_lock(lock, cpu);				\
> > +	} while (0)
> > +
> > +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
> > +	qpw_unlock(lock, cpu)
> > +
> > +#define queue_percpu_work_on(c, wq, qpw)			\
> > +	do {							\
> > +		struct qpw_struct *__qpw = (qpw);		\
> > +		WARN_ON((c) != __qpw->cpu);			\
> > +		__qpw->work.func(&__qpw->work);			\
> > +	} while (0)
> > +
> > +#define flush_percpu_work(qpw)					\
> > +	do {} while (0)
> > +
> > +#define qpw_get_cpu(w)						\
> > +	container_of((w), struct qpw_struct, work)->cpu
> > +
> > +#define INIT_QPW(qpw, func, c)					\
> > +	do {							\
> > +		struct qpw_struct *__qpw = (qpw);		\
> > +		INIT_WORK(&__qpw->work, (func));		\
> > +		__qpw->cpu = (c);				\
> > +	} while (0)
> > +
> > +#endif /* CONFIG_PREEMPT_RT */
> > +#endif /* LINUX_QPW_H */
> 
> You may also consider adding a documentation file about the
> qpw_lock/unlock() calls.

Sure, will do when I send the non-RFC version. Thanks for pointing that 
out!

> 
> Cheers,
> Longman
> 

Thanks!
Leo


