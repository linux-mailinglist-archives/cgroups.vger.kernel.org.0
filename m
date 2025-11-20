Return-Path: <cgroups+bounces-12131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1774C74664
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FA4FBB20
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04D345CAC;
	Thu, 20 Nov 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iiA7pQiu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frpsbROp"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D2345740;
	Thu, 20 Nov 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646306; cv=none; b=Jo8ixUH8YwQjGvmCle36cwUlbABh772oABcN0e8p/PLiNU0NRArl8RnpU8ZEA84y3YFWhtSzxSKi1IJy5PZEZkbe0WDMkVMgAFc9+CSCTj+saIQz2dWZs5h67XS87d+3nETnMCPZq0FXwWZvpig8kBjIag3brcF7QnWJKUh9+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646306; c=relaxed/simple;
	bh=oUAi5krh6uTcg34CzazQImLZetne4f0l6tu/fhPst10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJffwehsgczMgG89LY1B4jT4h0uDoWo1TNJgE9MNVlPU25oMzg5wX6WR0BZ1b3bJbg9uqwkSDcwQkyM/irN6s91oIDOVPUbXvqhwiYFQCaerWr4/JKZ0A6u6DX98O3KEdDVcdgYKdCc9//obcxC64UQV+aV9b1MJlBeUKRUSLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iiA7pQiu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frpsbROp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763646302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iF8rPSfDYi/YjnXdlmkH8+8vLUjtk9rsKhMZm+awUCo=;
	b=iiA7pQiudS+4jRrwjC0IfAKk4g4WOwyrjsfWzcOQG9nALDdKP5U4M1uAGigQx9OBzzDKmI
	2tp65VY8JDupPUVD80Tdg2ZkIrYi+05wxYZIFsYwXPELInnOeZl7MecgJobdtXozC2Fe+g
	doK/ps7dLvb3X1At2RuC4mLM+mg+dGvkNHfOgCxCkb/NBINMI/EyKStSe4wpvBFQWtfbVL
	TyUMV8N2pRhDQDnE3RtIDXlvKQU0upOepEf1f5d6d70hs6g4qrbeYYzmR7ltZx0gbF5bL2
	whJClURiXmzoSyqS4a3AEJwgShPjVAALfF+7Pv14vzjAxx842bUsLobwfaatxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763646302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iF8rPSfDYi/YjnXdlmkH8+8vLUjtk9rsKhMZm+awUCo=;
	b=frpsbROpKgPYLKcaq9oPqUV/WvAA7CmzOTtItvzKC2Xp94c7NIDeImvrytTvpmXGfmSVtk
	rW31UM7PuPwn3hBw==
To: Marek Szyprowski <m.szyprowski@samsung.com>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
 <marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated
 partitions
In-Reply-To: <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
References: <20251118143052.68778-1-frederic@kernel.org>
 <20251118143052.68778-2-frederic@kernel.org>
 <CGME20251120115132eucas1p160658ba63831911aadd0b0c2f70b7e28@eucas1p1.samsung.com>
 <73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com>
Date: Thu, 20 Nov 2025 14:45:01 +0100
Message-ID: <87y0o0keci.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20 2025 at 12:51, Marek Szyprowski wrote:
> On 18.11.2025 15:30, Frederic Weisbecker wrote:
>> In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
>> To prevent from that, set the PF_NO_SETAFFINITY flag to them.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>
> This patch landed in today's linux-next as commit 844dcacab287 ("genirq:=
=20
> Fix interrupt threads affinity vs. cpuset isolated partitions"). In my=20
> tests I found that it triggers a warnings on some of my test systems.=20
> This is example of such warning:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/kthread.c:599 kthread_bind_mask+0x2c/0x84
> Modules linked in:
> CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted=20
> 6.18.0-rc1-00031-g844dcacab287 #16177 PREEMPT
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Call trace:
>  =C2=A0unwind_backtrace from show_stack+0x10/0x14
>  =C2=A0show_stack from dump_stack_lvl+0x68/0x88
>  =C2=A0dump_stack_lvl from __warn+0x80/0x1d0
>  =C2=A0__warn from warn_slowpath_fmt+0x1b0/0x1bc
>  =C2=A0warn_slowpath_fmt from kthread_bind_mask+0x2c/0x84
>  =C2=A0kthread_bind_mask from wake_up_and_wait_for_irq_thread_ready+0x3c/=
0xd4
>  =C2=A0wake_up_and_wait_for_irq_thread_ready from __setup_irq+0x3e8/0x894

Hmm. The only explaination for that is that the thread got woken up
already and left the initial UNINTERRUPTIBLE state and is now waiting
for an interrupt wakeup with INTERRUPTIBLE state.

To validate that theory, can you please apply the patch below? The extra
warning I added should trigger first.

Let me think about a proper cure...

Thanks,

        tglx
---
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -615,6 +615,8 @@ static void __kthread_bind(struct task_s
 void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
 	struct kthread *kthread =3D to_kthread(p);
+
+	WARN_ON_ONCE(kthread->started);
 	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
 	WARN_ON_ONCE(kthread->started);
 }
@@ -631,6 +633,8 @@ void kthread_bind_mask(struct task_struc
 void kthread_bind(struct task_struct *p, unsigned int cpu)
 {
 	struct kthread *kthread =3D to_kthread(p);
+
+	WARN_ON_ONCE(kthread->started);
 	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
 	WARN_ON_ONCE(kthread->started);
 }



