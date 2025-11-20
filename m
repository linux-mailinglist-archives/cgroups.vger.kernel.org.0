Return-Path: <cgroups+bounces-12136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E295C74C03
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0722135AC6D
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126592BDC02;
	Thu, 20 Nov 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L8+X/Epj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="931FtcyY"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA42BE620;
	Thu, 20 Nov 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650844; cv=none; b=oTHZTiWn69kWL+b8hDMJvloZF163ftF5MVmua29ECXiavaD+pT7z/iWTi09bCCZwiytHnXCrxCiGg2Rjb2PIe73MEkSlXTexYOkJ4QLC6yU7Io6MmavMClC9d6cf2xg1gJoYbM/ggD+TClQLSubhhc75Q7nRjtoX00A4P1nzhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650844; c=relaxed/simple;
	bh=uwBU2PPgA6W6CmBzxknjBqt5LSogUR5poaN1qugjKZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dVSrHyJacE0G1637kwr8y3RHvqzpuLldxW5hEVtVgRtcLIwqvLyiXQMHLYTg82bLQL+eyYD7aRWru7Yajhu4l0GKrUKhVr/O5Nywz/2KgN/z1XQbBlb4xU8gXK0C0hyqQDRgG9jYE1+biMFeNLP1AapZ7kv2iEXipuWLdEqYZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L8+X/Epj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=931FtcyY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763650840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LpGqZhaaYXzA4hdibOg5WRDbLO44FNcTLiM76SYeOI=;
	b=L8+X/EpjB9f8avr0IYkzsGaJikZMPvaUUTOTi8VN3whByblBFig7f4gOOYwjYva8PHcC6N
	V7d7bepBfQHrUyqLc71NCXHxP6tvXcMDEmR6bRMutOQmTBhG7zSC0+3Iiyx8lYgXrDE8fD
	OUEC2OneX24w+Y4tXoD1VeM1pmzilwMfMdOi3g8FuDpWnp1PeQRMGaDODKwv8d2Y8CaEtT
	M60EQVrKwGyJEe85yUUbMzTpL2Hqb+WU4ENo8+/JPji2OdJ4EWlmGiPegQjRo5/u8vbY50
	6awekPM1yozlOnnokNfUJo5FhedWMOZh0b5THHamNfXUVc4ezZP2zxEjGgtiVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763650840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LpGqZhaaYXzA4hdibOg5WRDbLO44FNcTLiM76SYeOI=;
	b=931FtcyY+520bLgB8StFc9bN6yPm2UKqiNtOzjLk2hHVhf3lT2eeKW8/E32sj1051HLqxD
	+RMO/3R6wCzfrKAw==
To: Frederic Weisbecker <frederic@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
 <marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
In-Reply-To: <aR8VoUxBncOu4H47@localhost.localdomain>
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>
 <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
 <aR8VoUxBncOu4H47@localhost.localdomain>
Date: Thu, 20 Nov 2025 16:00:39 +0100
Message-ID: <87tsyokaug.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20 2025 at 14:20, Frederic Weisbecker wrote:
> Le Thu, Nov 20, 2025 at 12:51:31PM +0100, Marek Szyprowski a =C3=A9crit :
>> On 18.11.2025 15:30, Frederic Weisbecker wrote:
>> > When a cpuset isolated partition is created / updated or destroyed,
>> > the IRQ threads are affine blindly to all the non-isolated CPUs. And
>> > this happens without taking into account the IRQ thread initial
>> > affinity that becomes ignored.
>> >
>> > For example in a system with 8 CPUs, if an IRQ and its kthread are
>> > initially affine to CPU 5, creating an isolated partition with only
>> > CPU 2 inside will eventually end up affining the IRQ kthread to all
>> > CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference f=
or
>> > CPU 5.
>> >
>> > Besides the blind re-affinity, this doesn't take care of the actual
>> > low level interrupt which isn't migrated. As of today the only way to
>> > isolate non managed interrupts, along with their kthreads, is to
>> > overwrite their affinity separately, for example through /proc/irq/
>> >
>> > To avoid doing that manually, future development should focus on
>> > updating the IRQs affinity whenever cpuset isolated partitions are
>> > updated.
>> >
>> > In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
>> > To prevent from that, set the PF_NO_SETAFFINITY flag to them.
>> >
>> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>=20
>> This patch landed in today's linux-next as commit 844dcacab287 ("genirq:=
=20
>> Fix interrupt threads affinity vs. cpuset isolated partitions"). In my=20
>> tests I found that it triggers a warnings on some of my test systems.=20
>> This is example of such warning:
>>=20
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at kernel/kthread.c:599 kthread_bind_mask+0x2c/0x=
84
>
> Erm, does this means that the IRQ thread got awaken before the first offi=
cial
> wakeup in wake_up_and_wait_for_irq_thread_ready()? This looks wrong...
>
> irq_startup() may be called on a few occcasions before. So perhaps
> the IRQ already fired and woke up the kthread once before the "official"
> first wake up?
>
> There seem to be some initialization ordering issue here...

That's unavoidable because of locking and hen and egg ordering problems.

When the thread is created the interrupt is not yet started up and
therefore effective affinity is not known. So doing a bind there is
pointless.

The action has to be made visible _before_ starting it up as once the
interrupt is unmasked it might fire. That's even more true for shared
interrupts.

The wakeup/bind/... muck cannot be invoked with the descriptor lock
held, so it has to be done _after_ the thing went live.

So yes an interrupt which fires before kthread_bind() is invoked might
exactly have that effect. It wakes it from the kthread() wait and it
goes straight through to the thread function.

That's why the original code just set the affinity bit and let the
thread itself handle it.

There are three options to solve that:

      1) Bind the thread right after kthread_create() to a random
         housekeeping task and let move itself over to the real place
         once it came up (at this point the affinity is established)

      2) Serialize the setup so that the thread (even, when woken up
         early) get's stuck in UNINTERRUPTIBLE state _before_ it can
         reach wait_for_interrupt() which waits with INTERRUPTIBLE

      3) Teach kthread_create() that the thread is subject to being
         bound to something later on and implement that serialization
         there.

#1 is pretty straight forward. See untested below.

#2 is ugly (I tried)

#3 could be useful in general, but that needs more thoughts

Thanks

        tglx
---
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -133,7 +133,15 @@ void __irq_wake_thread(struct irq_desc *
 	 */
 	atomic_inc(&desc->threads_active);
=20
-	wake_up_process(action->thread);
+	/*
+	 * This might be a premature wakeup before the thread reached the
+	 * thread function and set the IRQTF_READY bit. It's waiting in
+	 * kthread code with state UNINTERRUPTIBLE. Once it reaches the
+	 * thread function it waits with INTERRUPTIBLE. The wakeup is not
+	 * lost in that case because the thread is guaranteed to observe
+	 * the RUN flag before it goes to sleep in wait_for_interrupt().
+	 */
+	wake_up_state(action->thread, TASK_INTERRUPTIBLE);
 }
=20
 static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1026,16 +1026,8 @@ static void irq_thread_check_affinity(st
 	set_cpus_allowed_ptr(current, mask);
 	free_cpumask_var(mask);
 }
-
-static inline void irq_thread_set_affinity(struct task_struct *t,
-					   struct irq_desc *desc)
-{
-	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data=
));
-}
 #else
 static inline void irq_thread_check_affinity(struct irq_desc *desc, struct=
 irqaction *action) { }
-static inline void irq_thread_set_affinity(struct task_struct *t,
-					   struct irq_desc *desc) { }
 #endif
=20
 static int irq_wait_for_interrupt(struct irq_desc *desc,
@@ -1220,7 +1212,6 @@ static void wake_up_and_wait_for_irq_thr
 	if (!action || !action->thread)
 		return;
=20
-	irq_thread_set_affinity(action->thread, desc);
 	wake_up_process(action->thread);
 	wait_event(desc->wait_for_threads,
 		   test_bit(IRQTF_READY, &action->thread_flags));
@@ -1389,26 +1380,35 @@ static void irq_nmi_teardown(struct irq_
 static int
 setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 {
+	/*
+	 * At this point interrupt affinity is not known. just assume that
+	 * the current CPU is not isolated and valid to bring the thread
+	 * up. The thread will move itself over to the right place once the
+	 * whole setup is complete.
+	 */
+	unsigned int cpu =3D raw_smp_processor_id();
 	struct task_struct *t;
=20
-	if (!secondary) {
-		t =3D kthread_create(irq_thread, new, "irq/%d-%s", irq,
-				   new->name);
-	} else {
-		t =3D kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
-				   new->name);
-	}
+	if (!secondary)
+		t =3D kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-%s", irq, new-=
>name);
+	else
+		t =3D kthread_create_on_cpu(irq_thread, new, cpu, "irq/%d-s-%s", irq, ne=
w->name);
=20
 	if (IS_ERR(t))
 		return PTR_ERR(t);
=20
 	/*
-	 * We keep the reference to the task struct even if
-	 * the thread dies to avoid that the interrupt code
-	 * references an already freed task_struct.
+	 * We keep the reference to the task struct even if the thread dies
+	 * to avoid that the interrupt code references an already freed
+	 * task_struct.
 	 */
 	new->thread =3D get_task_struct(t);
=20
+	/*
+	 * Ensure the thread adjusts the affinity once it reaches the
+	 * thread function.
+	 */
+	new->thread_flags =3D BIT(IRQTF_AFFINITY);
 	return 0;
 }
=20



