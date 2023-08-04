Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5076FC37
	for <lists+cgroups@lfdr.de>; Fri,  4 Aug 2023 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjHDIoE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Aug 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHDIng (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Aug 2023 04:43:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA88430E5
        for <cgroups@vger.kernel.org>; Fri,  4 Aug 2023 01:43:34 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691138613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIX5Dsgxv66hvOE4oXAUqRvhLzE8L1Q499d9gD373/s=;
        b=4DicEuBojYxAmx3CHpfEjftZZnmBXDWvJcixSe6sEn0xPjqIXVLfiX91xX6nWki4aFlDTD
        Kr1zCvWWpenO9CjbvOr8hY3PZIkBjiI1hIFp019zYVKz5b+0KsBercXHT7MPbb37MMbFK/
        a1inejTf19o+H1L5z3jtH3dZqBvP+0x+bjYhRQ5a35PDjDcal9fHYAM++sRmv7sh4bFG5l
        +IBv3JXy0Rb3EJIeJYIAigI+fR1pROAqHMxfV3RShTyqFzEVPj42hFzTNLeGpQLyFtFriy
        R6JyV5u8kZfZPK4nE9tElRacQcCGA3gnu3kAZpDwJeV6aurW1NQLcMQajvmF6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691138613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OIX5Dsgxv66hvOE4oXAUqRvhLzE8L1Q499d9gD373/s=;
        b=3Mg6CnuEkWZzHECqZwmdmiLQCTy5wCHsUrkPEB1zPiGiQql+z2NcGCR++Mn/aMKVpr7sBS
        eIxKviMoKx4ffEBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     cgroups@vger.kernel.org
Subject: Re: [bug report] cgroup: use irqsave in cgroup_rstat_flush_locked().
Message-ID: <20230804084331.VgJtYXG2@linutronix.de>
References: <39c0d51f-eae4-4895-8913-a290bba27d78@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39c0d51f-eae4-4895-8913-a290bba27d78@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023-08-04 10:28:28 [+0300], Dan Carpenter wrote:
> Hello Sebastian Andrzej Siewior,
Hi Dan,

> The patch b1e2c8df0f00: "cgroup: use irqsave in
> cgroup_rstat_flush_locked()." from Mar 23, 2022 (linux-next), leads
> to the following Smatch static checker warning:
> 
> 	kernel/cgroup/rstat.c:212 cgroup_rstat_flush_locked()
> 	warn: mixing irqsave and irq
> 
> kernel/cgroup/rstat.c
>     174 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>     175         __releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>     176 {
>     177         int cpu;
>     178 
>     179         lockdep_assert_held(&cgroup_rstat_lock);
>     180 
>     181         for_each_possible_cpu(cpu) {
>     182                 raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
>     183                                                        cpu);
>     184                 struct cgroup *pos = NULL;
>     185                 unsigned long flags;
>     186 
>     187                 /*
>     188                  * The _irqsave() is needed because cgroup_rstat_lock is
>     189                  * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
>     190                  * this lock with the _irq() suffix only disables interrupts on
>     191                  * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
>     192                  * interrupts on both configurations. The _irqsave() ensures
>     193                  * that interrupts are always disabled and later restored.
>     194                  */
>     195                 raw_spin_lock_irqsave(cpu_lock, flags);
> 
> There is obviously a giant comment explaining why irqsave is required
> instead of irq.

You have to notice that the caller used spinlock_t while here
raw_spinlock_t is used. Different lock types, same implementation/
behaviour on !PREEMPT_RT. With PREEMPT_RT enabled those two use a
different implementation and therefore lead to different behaviour.
Therefore the comment and the explanation.

>     196                 while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
>     197                         struct cgroup_subsys_state *css;
>     198 
>     199                         cgroup_base_stat_flush(pos, cpu);
>     200                         bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
>     201 
>     202                         rcu_read_lock();
>     203                         list_for_each_entry_rcu(css, &pos->rstat_css_list,
>     204                                                 rstat_css_node)
>     205                                 css->ss->css_rstat_flush(css, cpu);
>     206                         rcu_read_unlock();
>     207                 }
>     208                 raw_spin_unlock_irqrestore(cpu_lock, flags);
>     209 
>     210                 /* play nice and yield if necessary */
>     211                 if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
> --> 212                         spin_unlock_irq(&cgroup_rstat_lock);
> 
> But it's sort of confusing that irqsave isn't used here.  It's so
> weird that irq doesn't disable interrupts on some configs where _irqsave
> does.  That seems like the naming is bad.

There are two lock types. Each type match lock/unlock-irq and
save/restore.

To explain/ demonstrate it in this context:
- !RT
  spin_lock_irq()		/* disables interrupts */
  raw_spin_lock_irqsave() 	/* keeps interrupts disabled */
  raw_spin_unlock_irqrestore() 	/* keeps interrupts disabled */
  spin_unlock_irq()		/* enabled interrupts */

- RT
  spin_lock_irq()		/* does not touch interrupts */
  raw_pin_lock_irqsave() 	/* disables interrupts, saves previous state */
  raw_spin_unlock_irqrestore() 	/* enables interrupts, restores previous state */
  spin_unlock_irq()		/* does not touch interrupts */

So the raw_* type needs to save/restore the state because it is used
within spin_lock.*.

The version:
  spin_lock_irq()
  raw_pin_lock()
  raw_spin_unlock()
  spin_unlock_irq()

would be fine _unless_ the inner raw_spinlock_t is used in IRQ context
(which is the case here).

Not sure if you want to take any of this to update the checker. It would
probably make sense to distinguish between spinlock_t and raw_spinlock_t
because they are different.
Also, something like
  spin_lock_irqsave()
  spin_unlock()
  local_irq_restore()

and
  spin_lock_irqsave()
  raw_spin_lock()
  spin_unlock();
  raw_spin_unlock_irqrestore()

is both invalid on a PREEMPT_RT enabled config. 

If you want to replace spin_lock_irq.*() with something else because it
does not disable interrupts on PREEMPT_RT be aware that this discussion
can trigger a longer debate for the need and the right naming. Also, as
of -rc4 we have over 20k user of spin_lock_irq.*. So the whole process
could exceed my best case lifespan ;)

>     213                         if (!cond_resched())
>     214                                 cpu_relax();
>     215                         spin_lock_irq(&cgroup_rstat_lock);
>     216                 }
>     217         }
>     218 }
> 
> regards,
> dan carpenter

Sebastian
