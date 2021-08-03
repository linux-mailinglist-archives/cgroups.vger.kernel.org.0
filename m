Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1D3DF86D
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhHCXWM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 19:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhHCXWM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 19:22:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1AC061757;
        Tue,  3 Aug 2021 16:22:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628032918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sppHzO4nBHPNEurHXyRq4J2sD5L0/H0qJdAyUdF9AE=;
        b=OlCy9rBC6qHUV5lBzNzwO1zPZHPcdt/yuNv8KWZWSkX9IMEIHqv+Hqr4GtF9SS/T2hZY2K
        gRY92Lt3kL5GM04i6itLfA9ABSgbFKwZV+UcIBoS/r6q4t5oeLbFr6/B5xk7x/JdThhzMr
        AqXcsvc+wJVObdT3YIERe+xExSko/aROavBF6owO2eTsorS1LL4SAwpzkOFhatR7WeK4Tc
        liTjOwZ9BfwlKtjRFtTL+UujCKGeEW2bx9To1qAr4ohVgdyaEBfCWDxqcxRePdZjiHl4jF
        qzVjPEnxdnPlX/p0doCUUxATrDU9axWUlfkD3epp/mqV5UEhrf2Kib34gk5/Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628032918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sppHzO4nBHPNEurHXyRq4J2sD5L0/H0qJdAyUdF9AE=;
        b=F0gwUPlbBiVah6TihUcuwDEdd9xE5yjQzfsNoszSmqtS4PVc3AMwNgtD1olZ7vk6z7hq2Y
        DI82mdchpqgvkTBw==
To:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
In-Reply-To: <20210803175519.22298-1-longman@redhat.com>
References: <20210803175519.22298-1-longman@redhat.com>
Date:   Wed, 04 Aug 2021 01:21:57 +0200
Message-ID: <87h7g62jxm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Waiman,

On Tue, Aug 03 2021 at 13:55, Waiman Long wrote:

please Cc RT people on RT related patches.

> For PREEMPT_RT kernel, preempt_disable() and local_irq_save()
> are typically converted to local_lock() and local_lock_irqsave()
> respectively.

That's just wrong. local_lock has a clear value even on !RT kernels. See

  https://www.kernel.org/doc/html/latest/locking/locktypes.html#local-lock

> These two variants of local_lock() are essentially
> the same.

Only on RT kernels.

> + * For PREEMPT_RT kernel, preempt_disable() and local_irq_save() may have
> + * to be changed to variants of local_lock(). This eliminates the
> + * performance advantage of using preempt_disable(). Fall back to always
> + * use local_irq_save() and use only irq_obj for simplicity.

Instead of adding that comment you could have just done the full
conversion, but see below.

>   */
> +static inline bool use_task_obj_stock(void)
> +{
> +	return !IS_ENABLED(CONFIG_PREEMPT_RT) && likely(in_task());
> +}
> +
>  static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
>  {
>  	struct memcg_stock_pcp *stock;
>  
> -	if (likely(in_task())) {
> +	if (use_task_obj_stock()) {
>  		*pflags = 0UL;
>  		preempt_disable();
>  		stock = this_cpu_ptr(&memcg_stock);

This is clearly the kind of conditional locking which is frowned upon
rightfully.

So if we go to reenable memcg for RT we end up with:

	if (use_task_obj_stock()) {
           preempt_disable();
        } else {
           local_lock_irqsave(memcg_stock_lock, flags);
        }
        
and further down we end up with:

> @@ -2212,7 +2222,7 @@ static void drain_local_stock(struct work_struct *dummy)
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	drain_obj_stock(&stock->irq_obj);
> -	if (in_task())
> +	if (use_task_obj_stock())
>  		drain_obj_stock(&stock->task_obj);
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);

	/*
	 * The only protection from memory hotplug vs. drain_stock races is
	 * that we always operate on local CPU stock here with IRQ disabled
	 */
-	local_irq_save(flags);
+	local_lock_irqsave(memcg_stock_lock, flags);
        ...
	if (use_task_obj_stock())
  		drain_obj_stock(&stock->task_obj);

which is incomprehensible garbage.

The comment above the existing local_irq_save() is garbage w/o any local
lock conversion already today (and even before the commit which
introduced stock::task_obj) simply because that comment does not explain
the why.

I can just assume that for stock->task_obj the IRQ protection is
completely irrelevant. If not and _all_ members of stock have to be
protected against memory hotplug by disabling interrupts then any other
function which just disables preemption is broken.

To complete the analysis of drain_local_stock(). AFAICT that function
can only be called from task context. So what is the purpose of this
in_task() conditional there?

	if (in_task())
  		drain_obj_stock(&stock->task_obj);

I assume it's mechanical conversion of:

-       drain_obj_stock(stock);
+       drain_obj_stock(&stock->irq_obj);
+       if (in_task())
+               drain_obj_stock(&stock->task_obj);

all over the place without actually looking at the surrounding code,
comments and call sites.

This patch is certainly in line with that approach, but it's just adding
more confusion.

Thanks,

        tglx
