Return-Path: <cgroups+bounces-2877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA508C4DB8
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564AA28415F
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3912B83;
	Tue, 14 May 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sHlO3rCF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8whJTUXt"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A8AD58;
	Tue, 14 May 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675510; cv=none; b=WlN0jFgrvT4wLno3kFpSz81DVOqoQz1ha7Yw+b6uLAv1ybMgB/F6UwVoA60oxDXXchptd96FTOznoWEEtdsC2xZsxAi+bEAGuh4qmwco1mdoQloEDpTRtkc3QKHpyqgVX52iBmU9ejaCcOxVu1KGNoukXbiims2Abe2tDhEo04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675510; c=relaxed/simple;
	bh=D5V5Vlz28AnMUFbWtT4/nkFKtqlK/exeeNTnjhpKyBU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1yfkl6DujylCgSwTjYPmf3twsf+qvCTuSDBjaC8r8d11xJNBNoEtwDe1f0PshJ1LKcjm4inasItELTj/dOO2h01OYlzJ2b9G1JtdE/HFvqX6w6ZG4wE9YbzCuioxMjL7Bb6Memj8LIhwHo2A8gIkQ+pJiYHx8ITNzkJfpumhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sHlO3rCF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8whJTUXt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715675506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKAgEzIfgJRZRaemvfk+xP86DopN5RrKmXQomodN5HM=;
	b=sHlO3rCFQ4Qkcg9zLUrc1r3xbaegMu1etwy1Qj32tQiKFQXPGiOB2wUHdGuO6Fv1cbiwQd
	tUliSmnwwxk2x1aKJqaTgPJ7MKxfaWp/JTuU7AhnwpNBdhWEKXP77grTPzYt10CjswFq6H
	Wz1IdDAozSyxzm1kXM4xKWjl0ulkYr0b324ETbdLHtrP4tpeRqz04D26zcUXmEsKqb5m0t
	mZTTEp3ze3NXTAw//76cZe+oB69w6UI5B5MNKc0TQAByUdSA7+J1jw4qMvb/IxoGHvIuxD
	+HAnCk5+2wFUCblF0RQo1DI1p64an4Vu1savFC7cyJw5G/gVQC6Gi82iWAcyDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715675506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKAgEzIfgJRZRaemvfk+xP86DopN5RrKmXQomodN5HM=;
	b=8whJTUXtqUUAwcx0cnBHUPSkg8kBO2oOeTxYo4gRAFj3EVadHQTA9aF9oN/ef02Zvia4TB
	Hn2ZLLtCPMpBYTDw==
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Frederic Weisbecker <frederic@kernel.org>,
 Imran Khan <imran.f.khan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>, Peter
 Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Valentin
 Schneider <vschneid@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Waiman Long <longman@redhat.com>, Yury Norov
 <yury.norov@gmail.com>, Zefan Li <lizefan.x@bytedance.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH 6/6] tick/common: optimize cpumask_equal() usage
In-Reply-To: <20240513220146.1461457-7-yury.norov@gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-7-yury.norov@gmail.com>
Date: Tue, 14 May 2024 10:31:46 +0200
Message-ID: <878r0cn6a5.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 13 2024 at 15:01, Yury Norov wrote:
> Some functions in the file call cpumask_equal() with src1p == src2p.
> We can obviously just skip comparison entirely in this case.
>
> This patch fixes cpumask_equal invocations when boot-test or LTP detect
> such condition.

Please write your changelogs in imperative mood.

git grep 'This patch' Documentation/process/

Also please see Documentation/process/maintainer-tip.rst

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  kernel/time/tick-common.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index d88b13076b79..b31fef292833 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -253,7 +253,8 @@ static void tick_setup_device(struct tick_device *td,
>  	 * When the device is not per cpu, pin the interrupt to the
>  	 * current cpu:
>  	 */
> -	if (!cpumask_equal(newdev->cpumask, cpumask))
> +	if (newdev->cpumask != cpumask &&
> +			!cpumask_equal(newdev->cpumask, cpumask))
>  		irq_set_affinity(newdev->irq, cpumask);

I'm not seeing the benefit. This is slow path setup code so the extra
comparison does not really buy anything aside of malformatted line
breaks.

Thanks,

        tglx

