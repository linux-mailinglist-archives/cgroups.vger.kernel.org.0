Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0549E1A2
	for <lists+cgroups@lfdr.de>; Thu, 27 Jan 2022 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiA0Lxn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jan 2022 06:53:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240859AbiA0Lxm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jan 2022 06:53:42 -0500
Date:   Thu, 27 Jan 2022 12:53:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643284421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh4cPYGS34OUHJIV5r2WJGaHoK9dUv70fUYTBGGzNQY=;
        b=QwQ7pI6+GjjryrMxQlXnLF8v0uXoHZvkb2tayUPCdWOdIxZ5DE01V/0HkDU1L6azVecxBe
        TnPzOOT92omH6tyfN0ZhVlyeMaZ07fTYUibz5hUrNKvLsctBbY1m/rOmtqVw6pa9wYhn/9
        XqV+avkAMNl3UYfFEwIkEJS1znlX3Si0mVD0wB3zV/8VhRJhmzmXNUX5+sHMBrBydAN0Xj
        1j2MrwxnWsJE8VmI9zTKyZ5aqUZWPgoXUcXaNUcdF3L04WilFgDRUK1qmrK9aCbpIgtDUh
        Ifuyyyb+2EN4o1Sz6MjfPSGg0yVkl3HKLWOsIDrqe/NtC7Dp8DVOAU2BGlpVvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643284421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh4cPYGS34OUHJIV5r2WJGaHoK9dUv70fUYTBGGzNQY=;
        b=454kCZF92Zx0Z10AEtLlBRJFcYbRIg0bMWVzJ4Z6CDt7YkGzqVrSQW8Bt8tJxMVTHMyecL
        u8iBvFQUSm67DtDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <YfKHxKda7bGJmrLJ@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
 <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-26 16:20:36 [+0100], Michal Hocko wrote:
> I do not see any obvious problem with this patch. The code is ugly as
> hell, though, but a large part of that is because of the weird locking
> scheme we already have. I've had a look at 559271146efc ("mm/memcg:
> optimize user context object stock access") and while I agree that it
> makes sense to optimize for user context I do not really see any numbers
> justifying the awkward locking scheme. Is this complexity really worth
> it?

From https://https://lkml.kernel.org/r/.kernel.org/all/YdX+INO9gQje6d0S@linutronix.de/:

|        Sandy Bridge   Haswell        Skylake         AMD-A8 7100    Zen2           ARM64
|PREEMPT 5,123,896,822  5,215,055,226   5,077,611,590  6,012,287,874  6,234,674,489  20,000,000,100
|IRQ     7,494,119,638  6,810,367,629  10,620,130,377  4,178,546,086  4,898,076,012  13,538,461,925

basically if PREEMPT < IRQ then preempt_disable() + enable() was cheaper
than local_irq_save() + restore().

| Sandy Bridge
|                  SERVER OPT   SERVER NO-OPT    PREEMPT OPT     PREEMPT NO-OPT
| ALLOC/FREE    8,519,295,176   9,051,200,652    10,627,431,395  11,198,189,843
| SD                5,309,768      29,253,976       129,102,317      40,681,909
| ALLOC/FREE BH 9,996,704,330   8,927,026,031    11,680,149,900  11,139,356,465
| SD               38,237,534      72,913,120        23,626,932     116,413,331

OPT is code as-is while "NO-OPT" is with the following patch which
disables the optimisation (so it should be a revert of the optimisation
commit).

ALLOC/FREE is kfree(kmalloc()).
ALLOC/FREE BH is the same but in_interrupt() reported true.
The numbers are are time needed in ns for 100,000,000 iterations of the
free+alloc. SD is standard deviation.
I also let the test run on a Zen2 box:

|                  SERVER OPT   SERVER NO-OPT   PREEMPT OPT      PREEMPT NO-OPT
| ALLOC/FREE    8,126,735,313   8,751,307,383    9,822,927,142   10,045,105,425
| SD              100,806,471      87,234,047       55,170,179       25,832,386
| ALLOC/FREE BH 9,197,455,885   8,394,337,053   10,671,227,095    9,904,954,934
| SD              155,223,919      57,800,997       47,529,496      105,260,566

Is this what you asked for?

Sebastian
