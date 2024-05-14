Return-Path: <cgroups+bounces-2878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA25E8C4DD7
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 10:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69911C2166A
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075691CFBE;
	Tue, 14 May 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iz6tzHlZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaePvhSw"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600991799B;
	Tue, 14 May 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676169; cv=none; b=Og6vJVBgTIYOs1BGbW2bHxtS1tMUhXvelPUnXP4+N1aXOV0mbUgN7LiPlAKlC2CAPeimRirEiJtnS7nEBBJllPHQAnD1RweuBVHK+TZvyzkreqVVC/HluHqpxSZYg0ioseg6gi1YLsZvgG/uht4dFR83UyMqULH0/SuzuTItIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676169; c=relaxed/simple;
	bh=LTyvoXyrXlLqUbyp8anKtFEOFWbs9dtC7E/LhYcNvA8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQhaWcImVvXkGpmgmRnbqhbKsSeRzruyJOAr613u78keoE0u705zJtEue7tWe61jcFHfG/P6i0ve7XTqQE7vvf7293W4Avv+ll16lNnoMQ8ZdttOKW6WxTQqpcZUfra4FZuD+wY4jY14zfbH9V79H2rjq3PEaYST/BHjOZW/BHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iz6tzHlZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaePvhSw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715676166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKDRuc1srV9gybrmHs64Jn+lPZhJpy610DEDeydMnhA=;
	b=iz6tzHlZq+DeelfFJI3qyULE+4TJG9X6+b76gAkxetCvGY+PxHJeOerrsUxaT6Qln9CjWk
	5pEYnzPLt6cWovYNYGsyJSq1YhZoivaHkziYGz86YRv2wCoh3yXpO1cJU5I4t0fLOytMx7
	nZOyNLcX7Ef0nA9MwzL9iJf2SUcZnySwPuoCRkCmu00LLAeaB8JfB7+cpsUsJAPBSfZOQZ
	QnGiQ0X/4Mp5kkaWr/mxplrtrkVASBluNQCR4ToqAJcPEHg7fBU5b9U6h7mI+Ib/jYmi6z
	4uNtPdK0y+NkI8kFyQmnspW/KZkUyAIcVsvIewxPaxTVFZlggOug8ivjRlInpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715676166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BKDRuc1srV9gybrmHs64Jn+lPZhJpy610DEDeydMnhA=;
	b=TaePvhSwMtq2SSjRgSe/F8xG4t68FPylVxhieZghkpnQWCu8MaiQfwSjq6NizUx40Xd24g
	cbTUu+yY0iz5FSDw==
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Ben Segall <bsegall@google.com>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann
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
In-Reply-To: <878r0cn6a5.ffs@tglx>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-7-yury.norov@gmail.com> <878r0cn6a5.ffs@tglx>
Date: Tue, 14 May 2024 10:42:46 +0200
Message-ID: <874jb0n5rt.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 14 2024 at 10:31, Thomas Gleixner wrote:
> On Mon, May 13 2024 at 15:01, Yury Norov wrote:
>> Some functions in the file call cpumask_equal() with src1p == src2p.
>> We can obviously just skip comparison entirely in this case.
>>
>> This patch fixes cpumask_equal invocations when boot-test or LTP detect
>> such condition.
>
> Please write your changelogs in imperative mood.
>
> git grep 'This patch' Documentation/process/
>
> Also please see Documentation/process/maintainer-tip.rst
>
>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>> ---
>>  kernel/time/tick-common.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
>> index d88b13076b79..b31fef292833 100644
>> --- a/kernel/time/tick-common.c
>> +++ b/kernel/time/tick-common.c
>> @@ -253,7 +253,8 @@ static void tick_setup_device(struct tick_device *td,
>>  	 * When the device is not per cpu, pin the interrupt to the
>>  	 * current cpu:
>>  	 */
>> -	if (!cpumask_equal(newdev->cpumask, cpumask))
>> +	if (newdev->cpumask != cpumask &&
>> +			!cpumask_equal(newdev->cpumask, cpumask))
>>  		irq_set_affinity(newdev->irq, cpumask);
>
> I'm not seeing the benefit. This is slow path setup code so the extra
> comparison does not really buy anything aside of malformatted line
> breaks.

Instead of sprinkling these conditional all over the place, can't you
just do the obvious and check for ptr1 == ptr2 in bitmap_copy() and
bitmap_equal()?

Thanks,

	tglx

