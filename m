Return-Path: <cgroups+bounces-2898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710F8C5C74
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 22:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4025C1F21A2D
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DD17F36E;
	Tue, 14 May 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8PUNoqv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8NACxmF7"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956851DFD1;
	Tue, 14 May 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719682; cv=none; b=slEYcqx9QcY6dPcnbn3lTPM5h5mm7+Z4OO2RropY2CXjfBKSWU+Lm4/2OxgJtxVCzrVUR4OVrq5awTJ4TbHQMtT7aVHTTFRupSxw0cHqUeYlesGrRK9Y8wxrYm6D5j5LEwySW5fJuddA7M6AS9an4iusrapcjczfectfaMX2tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719682; c=relaxed/simple;
	bh=voK/yZS/mI07lLRJzdQ3NNqRzfZtfnrJUYswFWYYp1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rk2I1eL7MtSa2dNHgccvAm3bzaCyZB72l2lMWwUm7SHqVGKKW8gijhWdkLqRvlUMvry8N9AdMtYmzeT7qUc9+822dDLqk6SHk7mI17ks2qpsWmmdJ5L3Ou8HIIXdXSsb7HK2J2MgFhn6zCO0oyqZ51wmRPFBivWot4YmL/dDDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8PUNoqv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8NACxmF7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715719678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWGGR9WNQtfowXxmZrt+1GRML6oRarKOdd0NAWuZUm8=;
	b=G8PUNoqvKv4z1tIWxNeqOsG3FMX1YDcJSgi7g6DYWHRfxiHx3UQ9KkpdD7HeVJE/wiDCmW
	if50fXqsOQz8m5tg0xSHvNH69j5kR/0fJcx4IQ/GECKUJoK9KFDrC4NN9TbJEwS15CxiIX
	aj+VVvsm+c5T8aagiUDFTzo//JPp0aVUrBGGJkFQLT7CvDiW3gYjGOIuyAIkmMTf5NIF1A
	xq1fTqu19AJtDtnW/8RRjk4cERR9iRuHZMFGBtPyPQqOXiDkt/PZ3yxOVDqBfmP7tKWE/h
	BV0KTSdUPe0ho8HGiorZ2flBt9ozRPnCra7sY8YJhdRdp4tcZhK3ziS256NJLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715719678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWGGR9WNQtfowXxmZrt+1GRML6oRarKOdd0NAWuZUm8=;
	b=8NACxmF7BQjmO6dBW+VOwCq0qcvrezGzRoN8f+svY9p4Q0Ha3mUgMqzEkAvreHWjQABzUL
	TChXfM4eivuek5Dw==
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Ben Segall <bsegall@google.com>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Frederic Weisbecker <frederic@kernel.org>,
 Imran Khan <imran.f.khan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>, Peter
 Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, Valentin
 Schneider <vschneid@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Waiman Long <longman@redhat.com>, Zefan Li
 <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 6/6] tick/common: optimize cpumask_equal() usage
In-Reply-To: <CAAH8bW-o_zz_C_NFnjL3uP1BXyC4OF-BAR2Dk2Xd-DFDOZpodQ@mail.gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-7-yury.norov@gmail.com> <878r0cn6a5.ffs@tglx>
 <874jb0n5rt.ffs@tglx>
 <CAAH8bW-o_zz_C_NFnjL3uP1BXyC4OF-BAR2Dk2Xd-DFDOZpodQ@mail.gmail.com>
Date: Tue, 14 May 2024 22:47:57 +0200
Message-ID: <87msosktmq.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 14 2024 at 09:47, Yury Norov wrote:
>> Instead of sprinkling these conditional all over the place, can't you
>> just do the obvious and check for ptr1 == ptr2 in bitmap_copy() and
>> bitmap_equal()?
>
> I proposed this a while (few years) ago, and it has been rejected. On
> bitmaps level we decided not to do that for the reasons memcpy() and
> memcmp() doesn't, and on cpumasks and nodemasks level it hasn't
> been discussed at all.
>
> Now that most of bitmap ops have inline and outline implementation,
> we technically can move this checks in outline code, as inline bitmap
> ops are very lightweight already.
>
> So I see the following options:
>  - Implement these sanity checks in outline bitmap API (lib/bitmap.c);
>  - Implement them on cpumask and nodemask level; or
>  - add a new family of helpers that do this check, like
>   bitmap_copy_if_needed() (better name appreciated).
>
> The argument against #1 and #2 these days was that memcpy() and
> similarly bitmap_copy() with dst == src may be a sign of error, and
> we don't want to add a code that optimizes for it.

That's a fair argument.

> Now, I ran the kernel through the LTP test and in practice all the
> cases that I spot look pretty normal. So I can continue sprinkling
> the checks once a few years, or do something like described above.

I don't see these checks as valuable in most cases and I detest them as
they make the code harder to read.

Except for smp_call_function_many_cond() and to a lesser extent
irq_do_set_affinity() none of them you added really matters.

Though it might be worth to have helper functions which make it obvious
that the src == dst case is intentional.

Thanks,

        tglx

