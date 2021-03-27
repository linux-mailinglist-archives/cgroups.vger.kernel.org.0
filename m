Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD534B963
	for <lists+cgroups@lfdr.de>; Sat, 27 Mar 2021 22:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhC0VCE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Mar 2021 17:02:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0VBy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Mar 2021 17:01:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616878897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=vXrmY9bc2ySse5fwfJoSC1CigkAt9LHEzqv4IukdY0g=;
        b=Hs0WTWgw3TUNOXiMwCQ/nG5EZmAH0e9/zdy6Rg//eGEMbhsRsjOWee5IqD3hbUgKlpYnEI
        gOlP9mPCs58vuCwffiKj1xFhndN+tBjF8aKmhLKgiwMFdrjwoI+lx+YStfS4IXrVY5MHOM
        0qQhpxy61YSb8kR09ghFzNayIBRFb2SgsH3gzXQcmRnH/rk/R+3lUn3cAW4JdKaVQGBhyV
        DmNnuxdwvcB/PsE/7xDYVBbBA05HAtiX1t5Gv8dCPh1tu/oF6GXg1oRbWnEx1r2wt9gMnM
        Ybpm15E6dSsUjqnRhTgz4qZcYeNLCu9x9fC17ixIW118Ah+VWkCZP97gCH2MuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616878897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=vXrmY9bc2ySse5fwfJoSC1CigkAt9LHEzqv4IukdY0g=;
        b=Gl1Li9r3LFpwaPBcXl/sl8pGgdZm/shgw96Y7wPFQktRSygIk6I0L3o5D11Kdw3XbRKZrK
        Or9aV15dByapceDA==
To:     Alexey Klimov <aklimov@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com,
        daniel.m.jordan@oracle.com, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, qais.yousef@arm.com,
        hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on cpu onlining
In-Reply-To: <20210317003616.2817418-1-aklimov@redhat.com>
Date:   Sat, 27 Mar 2021 22:01:36 +0100
Message-ID: <87tuowcnv3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Alexey,

On Wed, Mar 17 2021 at 00:36, Alexey Klimov wrote:
> When a CPU offlined and onlined via device_offline() and device_online()
> the userspace gets uevent notification. If, after receiving "online" uevent,
> userspace executes sched_setaffinity() on some task trying to move it
> to a recently onlined CPU, then it sometimes fails with -EINVAL. Userspace
> needs to wait around 5..30 ms before sched_setaffinity() will succeed for
> recently onlined CPU after receiving uevent.
>
> Cpusets used in guarantee_online_cpus() are updated using workqueue from
> cpuset_update_active_cpus() which in its turn is called from cpu hotplug callback
> sched_cpu_activate() hence it may not be observable by sched_setaffinity() if
> it is called immediately after uevent.

And because cpusets are using a workqueue just to deal with their
backwards lock order we need to cure the symptom in the CPU hotplug
code, right?

> Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
> has run to completion using cpuset_wait_for_hotplug() after onlining the
> cpu in cpu_device_up() and in cpuhp_smt_enable().

It can also be avoided by fixing the root cause which is _NOT_ in the
CPU hotplug code at all.

The fundamental assumption of CPU hotplug is that if the state machine
reaches a given state, which might have user space visible effects or
even just kernel visible effects, the overall state of the system has to
be consistent.

cpusets violate this assumption. And they do so since 2013 due to commit
3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside get_online_cpus()").

If that cannot be fixed in cgroups/cpusets with out rewriting the whole
cpusets/cgroups muck, then this want's to be explained and justified in the
changelog.

Looking at the changelog of 3a5a6d0c2b03 it's entirely clear that this
is non trivial because that changelog clearly states that the lock order
is a design decision and that design decision required that workqueue
workaround....

See? Now we suddenly have a proper root cause and not just a description
of the symptom with some hidden hint about workqueues. And we have an
argument why fixing the root cause is close to impossible.

>  int cpu_device_up(struct device *dev)
>  {
> -	return cpu_up(dev->id, CPUHP_ONLINE);
> +	int err;
> +
> +	err = cpu_up(dev->id, CPUHP_ONLINE);
> +	/*
> +	 * Wait for cpuset updates to cpumasks to finish.  Later on this path
> +	 * may generate uevents whose consumers rely on the updates.
> +	 */
> +	if (!err)
> +		cpuset_wait_for_hotplug();

No. Quite some people wasted^Wspent a considerable amount of time to get
the hotplug trainwreck cleaned up and we are not sprinkling random
workarounds all over the place again.

>  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  {
> -	int cpu, ret = 0;
> +	cpumask_var_t mask;
> +	int cpu, ret;
>  
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	ret = 0;
>  	cpu_maps_update_begin();
>  	for_each_online_cpu(cpu) {
>  		if (topology_is_primary_thread(cpu))
> @@ -2093,31 +2109,42 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>  		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
>  		if (ret)
>  			break;
> -		/*
> -		 * As this needs to hold the cpu maps lock it's impossible
> -		 * to call device_offline() because that ends up calling
> -		 * cpu_down() which takes cpu maps lock. cpu maps lock
> -		 * needs to be held as this might race against in kernel
> -		 * abusers of the hotplug machinery (thermal management).
> -		 *
> -		 * So nothing would update device:offline state. That would
> -		 * leave the sysfs entry stale and prevent onlining after
> -		 * smt control has been changed to 'off' again. This is
> -		 * called under the sysfs hotplug lock, so it is properly
> -		 * serialized against the regular offline usage.
> -		 */
> -		cpuhp_offline_cpu_device(cpu);
> +
> +		cpumask_set_cpu(cpu, mask);
>  	}
>  	if (!ret)
>  		cpu_smt_control = ctrlval;
>  	cpu_maps_update_done();
> +
> +	/*
> +	 * When the cpu maps lock was taken above it was impossible
> +	 * to call device_offline() because that ends up calling
> +	 * cpu_down() which takes cpu maps lock. cpu maps lock
> +	 * needed to be held as this might race against in-kernel
> +	 * abusers of the hotplug machinery (thermal management).
> +	 *
> +	 * So nothing would update device:offline state. That would
> +	 * leave the sysfs entry stale and prevent onlining after
> +	 * smt control has been changed to 'off' again. This is
> +	 * called under the sysfs hotplug lock, so it is properly
> +	 * serialized against the regular offline usage.
> +	 */
> +	for_each_cpu(cpu, mask)
> +		cpuhp_offline_cpu_device(cpu);
> +
> +	free_cpumask_var(mask);
>  	return ret;

Brilliant stuff that. All this does is to move the uevent out of the cpu
maps locked region. What for? There is no wait here? Why?

The work is scheduled whenever the active state of a CPU is changed. And
just because on unplug it's not triggering any test program failure
(yet) does not make it more correct. The uevent is again delivered
before consistent state is reached.

And to be clear, it's not about uevent at all. That's the observable
side of it.

The point is that the state is inconsistent when the hotplug functions
return. That's the only really interesting statement here.

And while you carefully reworded the comment, did you actually read what
it said and what is says now?

> -		 * cpu_down() which takes cpu maps lock. cpu maps lock
> -		 * needs to be held as this might race against in kernel
> -		 * abusers of the hotplug machinery (thermal management).

vs.

> +	 * cpu_down() which takes cpu maps lock. cpu maps lock
> +	 * needed to be held as this might race against in-kernel
> +	 * abusers of the hotplug machinery (thermal management).

The big fat hint is: "cpu maps lock needs to be held as this ...." and
it still needs to be held for the above loop to work correctly at
all. See also below.

So just moving comments blindly around and making them past tense is not
cutting it. Quite the contrary the comments make no sense anymore. They
became uncomprehensible word salad.

Now for the second part of that comment:

> +      *                                          ....  This is
> +	 * called under the sysfs hotplug lock, so it is properly
> +	 * serialized against the regular offline usage.

So there are two layers of protection:

   cpu_maps_lock and sysfs hotplug lock

One protects surprisingly against concurrent sysfs writes and the other
is required to serialize in kernel usage.

Now lets look at the original protection:

   lock(sysfs)
     lock(cpu_maps)
       hotplug
        dev->offline = new_state
        uevent()
     unlock(cpu_maps)
   unlock(sysfs)

and the one you created:

   lock(sysfs)
     lock(cpu_maps)
       hotplug
     unlock(cpu_maps)
     dev->offline = new_state
     uevent()
   unlock(sysfs)

Where is that protection scope change mentioned in the change log and
where is the analysis that it is correct?

Now you also completely fail to explain _why_ the uevent and the
wait_for() muck have to be done _outside_ of the cpu maps locked region.

workqueues and cpusets/cgroups have exactly zero lock relationship to
the map lock.

The actual problematic lock nesting is

    cgroup_mutex -> cpu_hotplug_lock

and for the hotplug synchronous case this turns into

    cpu_hotplug_lock -> cgroup_mutex

which is an obvious deadlock.

So the only requirement is to avoid _that_ particular lock nesting, but
having:

    cpu_add_remove_lock -> cpu_hotplug_lock

and

    cpu_add_remove_lock -> cgroup_mutex -> cpu_hotplug_lock

which is built via waiting on the work to finish is perfectly fine.

Waiting under cpu_add_remove_lock is also perfectly fine and there are
other things in the hotplug callbacks which wait on stuff for way
longer.

Which in turn points to the obvious spots to add the required _two_ lines
of code which solve this without creating an unholy mess and sprinkling
that call all over the place.

 _cpu_up()
 {
        ...
        cpus_write_unlock(); <- Drops cpu_hotplug_lock
        ...
+       if (!tasks_frozen)
+		cpusets_wait_for_hotplug();
        return ret;

And the same for _cpu_down(), which obviously begs for a helper
function, which in turn needs tons of comments to explain why that place
is not a dump ground for random hacks of the day and what might if at
all be justified to be called there along with the implications of that

But that's a documentation thing, which would also be necessary when the
requirement would be to move it outside of cpu_add_remove_lock.

And none of this has anything to do with uevents.

Thanks,

        tglx
---
Subject: cpu/hotplug: Cure the cpusets trainwreck
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 27 Mar 2021 15:57:29 +0100

Alexey and Joshua tried to solve a cpusets related hotplug problem which is
user space visible and results in unexpected behaviour for some time after
a CPU has been plugged in and the corresponding uevent was delivered.

cpusets delegate the hotplug work (rebuilding cpumasks etc.) to a
workqueue. This is done because the cpusets code has already a lock
nesting of cgroups_mutex -> cpu_hotplug_lock. A synchronous callback or
waiting for the work to finish with cpu_hotplug_lock held can and will
deadlock because that results in the reverse lock order.

As a consequence the uevent can be delivered before cpusets have consistent
state which means that a user space invocation of sched_setaffinity() to
move a task to the plugged CPU fails up to the point where the scheduled
work has been processed.

The same is true for CPU unplug, but that does not create user observable
failure (yet).

It's still inconsistent to claim that an operation is finished before it
actually is and that's the real issue at hand. uevents just make it
reliably observable.

Obviously the problem should be fixed in cpusets/cgroups, but untangling
that is pretty much impossible because according to the changelog of the
commit which introduced this 8 years ago:

 3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside get_online_cpus()")

the lock order cgroups_mutex -> cpu_hotplug_lock is a design decision and
the whole code is built around that.

So bite the bullet and invoke the relevant cpuset function, which waits for
the work to finish, in _cpu_up/down() after dropping cpu_hotplug_lock and
only when tasks are not frozen by suspend/hibernate because that would
obviously wait forever.

Waiting there with cpu_add_remove_lock, which is protecting the present
and possible CPU maps, held is not a problem at all because neither work
queues nor cpusets/cgroups have any lockchains related to that lock.

Waiting in the hotplug machinery is not problematic either because there
are already state callbacks which wait for hardware queues to drain. It
makes the operations slightly slower, but hotplug is slow anyway.

This ensures that state is consistent before returning from a hotplug
up/down operation. It's still inconsistent during the operation, but that's
a different story.

Add a large comment which explains why this is done and why this is not a
dump ground for the hack of the day to work around half thought out locking
schemes. Document also the implications vs. hotplug operations and
serialization or the lack of it.

Thanks to Alexy and Joshua for analyzing why this temporary
sched_setaffinity() failure happened.

Reported-by: Alexey Klimov <aklimov@redhat.com>
Reported-by: Joshua Baker <jobaker@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Qais Yousef <qais.yousef@arm.com>
---
 kernel/cpu.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -32,6 +32,7 @@
 #include <linux/relay.h>
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/cpuset.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -867,6 +868,52 @@ void clear_tasks_mm_cpumask(int cpu)
 	rcu_read_unlock();
 }
 
+/*
+ *
+ * Serialize hotplug trainwrecks outside of the cpu_hotplug_lock
+ * protected region.
+ *
+ * The operation is still serialized against concurrent CPU hotplug via
+ * cpu_add_remove_lock, i.e. CPU map protection.  But it is _not_
+ * serialized against other hotplug related activity like adding or
+ * removing of state callbacks and state instances, which invoke either the
+ * startup or the teardown callback of the affected state.
+ *
+ * This is required for subsystems which are unfixable vs. CPU hotplug and
+ * evade lock inversion problems by scheduling work which has to be
+ * completed _before_ cpu_up()/_cpu_down() returns.
+ *
+ * Don't even think about adding anything to this for any new code or even
+ * drivers. It's only purpose is to keep existing lock order trainwrecks
+ * working.
+ *
+ * For cpu_down() there might be valid reasons to finish cleanups which are
+ * not required to be done under cpu_hotplug_lock, but that's a different
+ * story and would be not invoked via this.
+ */
+static void cpu_up_down_serialize_trainwrecks(bool tasks_frozen)
+{
+	/*
+	 * cpusets delegate hotplug operations to a worker to "solve" the
+	 * lock order problems. Wait for the worker, but only if tasks are
+	 * _not_ frozen (suspend, hibernate) as that would wait forever.
+	 *
+	 * The wait is required because otherwise the hotplug operation
+	 * returns with inconsistent state, which could even be observed in
+	 * user space when a new CPU is brought up. The CPU plug uevent
+	 * would be delivered and user space reacting on it would fail to
+	 * move tasks to the newly plugged CPU up to the point where the
+	 * work has finished because up to that point the newly plugged CPU
+	 * is not assignable in cpusets/cgroups. On unplug that's not
+	 * necessarily a visible issue, but it is still inconsistent state,
+	 * which is the real problem which needs to be "fixed". This can't
+	 * prevent the transient state between scheduling the work and
+	 * returning from waiting for it.
+	 */
+	if (!tasks_frozen)
+		cpuset_wait_for_hotplug();
+}
+
 /* Take this CPU down. */
 static int take_cpu_down(void *_param)
 {
@@ -1058,6 +1105,7 @@ static int __ref _cpu_down(unsigned int
 	 */
 	lockup_detector_cleanup();
 	arch_smt_update();
+	cpu_up_down_serialize_trainwrecks(tasks_frozen);
 	return ret;
 }
 
@@ -1254,6 +1302,7 @@ static int _cpu_up(unsigned int cpu, int
 out:
 	cpus_write_unlock();
 	arch_smt_update();
+	cpu_up_down_serialize_trainwrecks(tasks_frozen);
 	return ret;
 }
 
