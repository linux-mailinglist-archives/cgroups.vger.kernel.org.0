Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D004703B9
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbhLJPZj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 10:25:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbhLJPZi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 10:25:38 -0500
Date:   Fri, 10 Dec 2021 16:22:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639149722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFLPu42940dvMO+OtrkN09Ewj78DLFD7wDRKNKEeFhE=;
        b=KHl69uo+VpxgkXbBnEkxhP1fJrYgQ/dFp7jQV4s3JIvemU2Gxl5lTAjJCwJVAi0exp7j/4
        tF/uHagC22rmznjtKon/E0uhDmnZobDaNIg29NCvaLqKOTtyNUDfiDOCuRQx/su46e4JSX
        5tu6T6uyO3Lq94AAd+03tCcuzFiMdvdE+gmxTHVohbFZrV/6n9DgWM+VhP6/8Q2YWHlcnY
        Q0m7B5czjy6cfsMnh0PWnZ6vM1Gu7p+4zGrkYHHydQh/tNm5C6B+TXtKpX+xQzKB/vPG7z
        a2IbhKOHUIxcmIV2JGpGR2e/giRUh+c4XjcnPOy5nd7wtXxvOJj3VYz8uZquSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639149722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFLPu42940dvMO+OtrkN09Ewj78DLFD7wDRKNKEeFhE=;
        b=PlwDuvP0OEqKmzBJYLcT+HsqBJcpKkXZ4XX+Gdb+0Z/rsRn9gzHV3UIVRG5+s25ySjcHug
        cg5cT2AZP0BF6SDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Message-ID: <YbNwmUMPFM/MO0cX@linutronix.de>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
 <Ya+SCkLOLBVN/kiY@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ya+SCkLOLBVN/kiY@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-07 11:55:38 [-0500], Johannes Weiner wrote:
> On Tue, Dec 07, 2021 at 04:52:08PM +0100, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > MEMCG has a few constructs which are not compatible with PREEMPT_RT's
> > requirements. This includes:
> > - relying on disabled interrupts from spin_lock_irqsave() locking for
> >   something not related to lock itself (like the per-CPU counter).
> 
> If memory serves me right, this is the VM_BUG_ON() in workingset.c:
> 
> 	VM_WARN_ON_ONCE(!irqs_disabled());  /* For __inc_lruvec_page_state */
> 
> This isn't memcg specific. This is the serialization model of the
> generic MM page counters. They can be updated from process and irq
> context, and need to avoid preemption (and corruption) during RMW.
> 
> !CONFIG_MEMCG:
> 
> static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> 					 int val)
> {
> 	struct page *page = virt_to_head_page(p);
> 
> 	mod_node_page_state(page_pgdat(page), idx, val);
> }
> 
> which does:
> 
> void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> 					long delta)
> {
> 	unsigned long flags;
> 
> 	local_irq_save(flags);
> 	__mod_node_page_state(pgdat, item, delta);
> 	local_irq_restore(flags);
> }
> 
> If this breaks PREEMPT_RT, it's broken without memcg too.

The mod_node_page_state() looks fine. But if we use disabling interrupts
as protecting the RMW operation then this has be used everywhere and can
not be assumed to be inherited from spin_lock_irq(). Also, none of the
code here should be invoked from IRQ context on PREEMPT_RT.

If the locking scope is known then local_irq_disable() could be replaced
with a local_lock_t to avoid other things that appear unrelated like the
memcg_check_events() invocation in uncharge_batch(). The problematic
part here is mem_cgroup_tree_per_node::lock which can not be acquired
with disabled interrupts on PREEMPT_RT.
The "locking scope" is not always clear to me.
Also, if it is _just_ the counter, then we might solve this differently.

> > - explicitly disabling interrupts and acquiring a spinlock_t based lock
> >   like in memcg_check_events() -> eventfd_signal().
> 
> Similar problem to the above: we disable interrupts to protect RMW
> sequences that can (on non-preemptrt) be initiated through process
> context as well as irq context.
> 
> IIUC, the PREEMPT_RT construct for handling exactly that scenario is
> the "local lock". Is that correct?

On !PREEMPT_RT this_cpu_inc() can be used in hard-IRQ and task context
equally while __this_cpu_inc() is "optimized" to be used in IRQ-context/
a context where it can not be interrupted during its operation.
local_irq_save() and spin_lock_irq() both disable interrupts here.

On PREEMPT_RT chances are high that the code never runs with disabled
interrupts. local_irq_save() disables interrupts, yes, but
spin_lock_irq() does not.
Therefore a per-object lock, say address_space::i_pages, can
not be used to protect an otherwise unrelated per-CPU data, a global
DEFINE_PER_CPU(). The reason is that you can acquire
address_space::i_pages and get preempted in the middle of
__this_cpu_inc(). Then another task on the same CPU can acquire
address_space::i_pages of another struct address_space and perform
__this_cpu_inc() on the very same per-CPU date. There is your
interruption of a RMW operation.

local_lock_t is a per-CPU lock which can be used to synchronize access
to per-CPU variables which are otherwise unprotected / rely on disabled
preemption / interrupts. So yes, it could be used as a substitute in
situations where the !PREEMPT_RT needs to manually disable interrupts.

So this:

|func1(struct address_space *m)
|{
|  spin_lock_irq(&m->i_pages);
|  /* other m changes */
|  __this_cpu_add(counter);
|  spin_unlock_irq(&m->i_pages);
|}
|
|func2(void)
|{
|  local_irq_disable();
|  __this_cpu_add(counter);
|  local_irq_enable();
|}

construct breaks on PREEMPT_RT. With local_lock_t that would be:

|func1(struct address_space *m)
|{
|  spin_lock_irq(&m->i_pages);
|  /* other m changes */
|  local_lock(&counter_lock);
|  __this_cpu_add(counter);
|  local_unlock(&counter_lock);
|  spin_unlock_irq(&m->i_pages);
|}
|
|func2(void)
|{
|  local_lock_irq(&counter_lock);
|  __this_cpu_add(counter);
|  local_unlock_irq(&counter_lock);
|}

Ideally you would attach counter_lock to the same struct where the
counter is defined so the protection scope is obvious.
As you see, the local_irq_disable() was substituted with a
local_lock_irq() but also a local_lock() was added to func1().

> It appears Ingo has already fixed the LRU cache, which for non-rt also
> relies on irq disabling:
> 
> commit b01b2141999936ac3e4746b7f76c0f204ae4b445
> Author: Ingo Molnar <mingo@kernel.org>
> Date:   Wed May 27 22:11:15 2020 +0200
> 
>     mm/swap: Use local_lock for protection
> 
> The memcg charge cache should be fixable the same way.
> 
> Likewise, if you fix the generic vmstat counters like this, the memcg
> implementation can follow suit.

The vmstat counters should be fixed since commit
   c68ed7945701a ("mm/vmstat: protect per cpu variables with preempt disable on RT")

again by Ingo.

We need to agree how to proceed with these counters. And then we can tackle
what is left things :)
It should be enough to disable preemption during the update since on
PREEMPT_RT that update does not happen in IRQ context.

Sebastian
