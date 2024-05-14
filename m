Return-Path: <cgroups+bounces-2900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 486688C5C95
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 23:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C048B21D42
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9484A180A6A;
	Tue, 14 May 2024 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTHATAbS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dweu8njF"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BE14532B;
	Tue, 14 May 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720524; cv=none; b=qWHl/p93VmEIEsbV8PcFpPxrk2gK/AylfxuY/O8AgMfXIt6xlpDJI6OA/n5ghM+4awZkEfl2M8wD6vmikGtEkdfUg7nsyb12C/QrPeYGTCRTcx2T0t4qLCFY6vtVQTB0N75wWM5hhZJaWeFjObIJbiDDZDMxqu8Z3guzTlOA7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720524; c=relaxed/simple;
	bh=oNNSswIyrt13EK8oXKF/p1rfPKlwxsz+mTptoXw8pUk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JFlc/z9lCj8L7Zw1+iSDjKAWRR3ntG12PhCNw6TicNApI17HzHywXqFHSLk/d34UA3jM0D12x27Dh7LOdLFXs6+oPcokgbgHgm91YZhPgg1ZLkb06/ksIIoWmhkT2NLtVpyLke64jKhtV/DJCaxlcwwdpyS/LWlCIcQJEWwrhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTHATAbS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dweu8njF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715720521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9IhefwFGHqUFohDsQBE0bSZV5Ni7HPgyBwTX8U3rtw=;
	b=xTHATAbS2oMlFmU6eR+Gzu1a3vT8mekSwRgnuz1YS3XvVDoHBoIMqULio2ndUn9WP2ICWF
	gVWExzS0yzfhheDls2sX765jaH+nmuOGwcZYTNnnp17kwzfWEE2fqeGibiRIgTXV6JpaFI
	qZ+DYt1ekmDlyuCWnSy9huETcMJF0wOQUINTDfiIQ8jjcgZp3wYy4FBAqBdj8WlQF7ROdx
	zHdakega01kbXTFPcLlSBWEXWpYH1LkZNQIhVcbsUywuIZybaDf0vbaSLR+yPmRTJJ2q2c
	UxJ6PT7rDT/sDk8G7COrgst9cIjlgOGxjC3DqcsuDbTVvU44Tp1Lp5yGMxAI5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715720521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9IhefwFGHqUFohDsQBE0bSZV5Ni7HPgyBwTX8U3rtw=;
	b=Dweu8njFymxpAMKfxaoBwSdUnenIrETZ5nUXq2uSyUt7JIeu5epMEk1O9qFSQ30RdiM9m/
	EMLFVyv2o679WFCg==
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
Subject: Re: [PATCH 3/6] driver core: cpu: optimize print_cpus_isolated()
In-Reply-To: <20240513220146.1461457-4-yury.norov@gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-4-yury.norov@gmail.com>
Date: Tue, 14 May 2024 23:02:00 +0200
Message-ID: <87jzjwkszb.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 13 2024 at 15:01, Yury Norov wrote:
> The function may be called with housekeeping_cpumask == cpu_possible_mask,

How so? There is no cpumask argument in the function signature. Can you
please be precise?

> and in such case the 'isolated' cpumask would be just empty.
>
> We can call cpumask_clear() in that case, and save CPU cycles.
>
> @@ -282,8 +282,10 @@ static ssize_t print_cpus_isolated(struct device *dev,
>  	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
>  		return -ENOMEM;
>  
> -	cpumask_andnot(isolated, cpu_possible_mask,
> -		       housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	if (cpu_possible_mask != housekeeping_cpumask(HK_TYPE_DOMAIN))
> +		cpumask_andnot(isolated, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
> +	else
> +		cpumask_clear(isolated);
>  	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
>  
>  	free_cpumask_var(isolated);

Seriously? You need clear() to emit an empty string via %*pbl?

	if (cpu_possible_mask != housekeeping_cpumask(HK_TYPE_DOMAIN)) {
        	if (!alloc_cpumask_var(&isolated, GFP_KERNEL))
                	return -ENOMEM;
                cpumask_andnot(isolated, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
                len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
	  	free_cpumask_var(isolated);
	} else {
        	len = sysfs_emit(buf, "\n");
        }

That actually would make sense and spare way more CPU cycles, no?

Is it actually worth the larger text size? Not really convinced about that.

Thanks,

        tglx

