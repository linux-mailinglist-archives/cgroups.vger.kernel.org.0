Return-Path: <cgroups+bounces-5313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35D9B5230
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 19:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58EB0B2218C
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EB20515A;
	Tue, 29 Oct 2024 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffX1zRQu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEc+vx35"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAB1DB37A;
	Tue, 29 Oct 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228056; cv=none; b=P3L4UFXXAhmhDeycP8VDlAWQ4WNiE6HYVN5FBaD+SuYWMWOy3D+hyhVhSOV5uySgNDOawYeZCr2J6HJb6eYi/uLSTrPtxQzZlKlriaTIwsQZ/jbKuify6INUHEnm3mld5lxQkVqgXcq6EyBi3T3x4Na1uUR7987b4rdavia1h0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228056; c=relaxed/simple;
	bh=zn7PZW4n3kySNBlFmDmbgJXfh8wj3gXDPwYY1lCMGls=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqRxkqcSwRm0lHWdyBbSbhm6+RZEF2zKUjccQr0pBMphD0fFFy9GBRtQ9rQmjnrikTT4iJvOMsdomfcGs2bo5b52oCiQIJHkkCkjfCySHO1eUN3rG2HHK+UHUXI9WkfC5deVSG6B0W/H3bPXfGdp3jyIEAz+zfFQ5VQ8lFJgR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffX1zRQu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEc+vx35; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730228052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wjko7eOTjNCaKUVt6NyN0ek4f+g4AUdfFDp2yMrN8f8=;
	b=ffX1zRQuijJ5YCDe1nRAHciPrVxKrvIW8FlPReAqTRMooIUpLLcWr2aavwDZjmbBF0rEQz
	wOkKAmNPLBtFlsQln7ygVI2iUlwnEzOt9x856Hgu0aZgGk/mRO7KO1IqYpzYuJgN2VDwDn
	ZMPEi7tWkwKcSKdzV6XrFNFelTHtetUF8CUk6ZYf3FglSKkgDFS39WCWGwhxNAmfgqSGdy
	+D4r++rD+ibus8fLCLkMMOK1v1WQfaw7TVs0NixaiEpHcryZzNpAzdku6o6c6YvGFVXlRK
	VsKA087ePF8nfW5XB4/qFJ2UEd0DFXIfO0FxQj0qucMWa/S4AGTdxHxxMP4S9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730228052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wjko7eOTjNCaKUVt6NyN0ek4f+g4AUdfFDp2yMrN8f8=;
	b=pEc+vx35vTZoOd3ja48aHiKYvUZD6d4ocpbJOcEpZeSF+7O1yel6cfIuUGCdOT7dzvJHnn
	9BlMxkLTtkFVtwDA==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 ming.lei@redhat.com, pauld@redhat.com, juri.lelli@redhat.com,
 vschneid@redhat.com, Jens Axboe <axboe@kernel.dk>, Peter Zijlstra
 <peterz@infradead.org>, Zefan Li <lizefan.x@bytedance.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Costa Shulyupin <costa.shul@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v3 3/3] genirq/cpuhotplug: Adjust managed irqs
 according to change of housekeeping CPU
In-Reply-To: <20241029120534.3983734-4-costa.shul@redhat.com>
References: <20241029120534.3983734-1-costa.shul@redhat.com>
 <20241029120534.3983734-4-costa.shul@redhat.com>
Date: Tue, 29 Oct 2024 19:54:12 +0100
Message-ID: <87bjz2210r.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 29 2024 at 14:05, Costa Shulyupin wrote:
> index afc920116d42..44c7da0e1b8d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -171,7 +171,7 @@ static bool cpuhp_step_empty(bool bringup, struct cpuhp_step *step)
>   *
>   * Return: %0 on success or a negative errno code
>   */
> -static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
> +int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
>  				 bool bringup, struct hlist_node *node,
>  				 struct hlist_node **lastp)

This is deep internal functionality of cpu hotplug and only valid when
the hotplug lock is write held or if it is read held _and_ the state
mutex is held.

Otherwise it is completely unprotected against a concurrent state or
instance insertion/removal and concurrent invocations of this function.

And no, we are not going to expose the state mutex just because. CPU
hotplug is complex enough already and we really don't need more side
channels into it.

There is another issue with this approach in general:

   1) The 3 block states are just the tip of the iceberg. You are going
      to play a whack a mole game to add other subsystems/drivers as
      well.

   2) The whole logic has ordering constraints. The states have strict
      ordering for a reason. So what guarantees that e.g. BLK_MQ_ONLINE
      has no dependencies on non BLK related states to be invoked before
      that. I'm failing to see the analysis of correctness here.

      Just because it did not explode right away does not make it
      correct. We've had enough subtle problems with ordering and
      dependencies in the past. No need to introduce new ones.

CPU hotplug solves this problem without any hackery. Take a CPU offline,
change the mask of that CPU and bring it online again. Repeat until all
CPU changes are done.

If some user space component cannot deal with that, then fix that
instead of inflicting fragile and unmaintainable complexity on the
kernel. That kubernetes problem is known since 2018 and nobody has
actually sat down and solved it. Now we waste another 6 years to make it
"work" in the kernel magically.

This needs userspace awareness anyway. If you isolate a CPU then tasks
or containers which are assigned to that CPU need to move away and the
container has to exclude that CPU. If you remove the isolation then what
is opening the CPU for existing containers magically?

I'm not buying any of this "will" just work and nobody notices
handwaving.

Thanks,

        tglx

