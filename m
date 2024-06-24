Return-Path: <cgroups+bounces-3318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B552915A1C
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 00:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AEABB21A03
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684BF1A2553;
	Mon, 24 Jun 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsvwQWzD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6647A64;
	Mon, 24 Jun 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269693; cv=none; b=Cui6woEafsaDUsxh0Oh6JTKOzVS9C+tkWIJCu48Jl1Oslobl5xSVgFZiwIfWLOymPL0K8vqw8zXJzLHl4cDQQJkBx6mXbn40X9OQIxFuDNT9uqXoEhfv5RNiqKkhVbdSreh7vQqjIBlONDxMPBD3pVuLSbatq0hLxLhzC4G0a6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269693; c=relaxed/simple;
	bh=sElc2XuU2ff3on4aXynI8Tx39Edi1GwfSAQ4ACgrydk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObbUTPC7q3PsNZPUsmbYShnsecgmFtfwb7Sq/PiD6yYazCDdE68GyMso4h4YRWtvpZCIslZNK8PcwTiYMOqtIigxnRYi3vN/3kJa1lvVOZUaF0RgV2AYUhDG++XN7AODEdUSzrjkXPr6GtJ5NH0Suu8QKvVyTQfHG1LCMh8VBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsvwQWzD; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70089223245so2824988a34.2;
        Mon, 24 Jun 2024 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719269690; x=1719874490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmrF0dTmcOIfg8IkJIqr7iTWstwct6FH7y6vme7yHSs=;
        b=VsvwQWzD5MQHpWajYQDYvNn6PZizHmFcL3kYuokfsQDrM9JRKXuY4h9QEg7uHljJwH
         9uxfNjk8FWwOH6+7H5QsEg2lxa+CUsyObkGNl10kvhr3zJ7SisYjRnriR9+DiDppVl9t
         6vr9LsJ1Q1mC92nzYdIj8sbiEmcPGLw0j4gU9MkEaren/OmYqU0JH0JQpI8/fgCO/Kz8
         Mk+kNwexJptIQuPbS8Y0mdjKH8QMscWQn+2+ayffW9VUQG+1xzXK6GY5o+X95GictAkd
         jHb4vB3MDM6I+OK5S5ZkHADgUS2NPKwGohYMlSU7aN+IokL9SJ0FB2gUHIj2Gm55r2Us
         qkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719269690; x=1719874490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmrF0dTmcOIfg8IkJIqr7iTWstwct6FH7y6vme7yHSs=;
        b=vytOKg//2Ae5NLEYuq1OXhgB1ovlYHkLkT9odTPQfmkfXm7VaJS5LqYcuW+HxuiIK0
         OfaT7bWGhupT9FLS5ojzkdsv1c2QU8mTW6hJyOWUAxjhUoQ7cCoDNRExWhCz6JNUScBJ
         tK2D0XBltuqHlqIy3Q1mdbjuTVcBVY49ZM1k5hgfJ2g7gCpOTl6vJ0MYaMewYxhyLvEN
         IpjHTRTNqQs7qUejnyhTFH02wTot9dM2EquSt5PVX8Q50/6loYxy/2ToZvoXAtnY6r5o
         XMJZlBACCmqoRMkluvzEchc1mjQd8F7Z3hUcF8M8+ix0D+vzfoCCU77ot8+PToc8bCyv
         ap6A==
X-Forwarded-Encrypted: i=1; AJvYcCU2tL7XMVT9dQ5Df44EIcGHgy0BaSbtcdx3OAnKoNRYRotP8YfMSYtX2jhfkcm/E8gu1TaOQo9aCkeTR42Wf50fLs1geB2cW2Lfk4wDUaOjHTjBXwokOzR+Xl6Wcv9Y9LXQwDBQXA==
X-Gm-Message-State: AOJu0YzRn9pLYEOcw/0MFidb2UF2XjK9qWjZTP4AJ274lTZGqnLIeDvx
	BXCl+rWNQqr0RG/2NwqCBnHZ4AWpzut152QJxWcufDuabDB7lZBj
X-Google-Smtp-Source: AGHT+IF1LmdDz568NfaQSwCT7YStZy+hquXQ5WPIRwD8wqfSpoWD/xHua/MASQDacD79OmYmZMmJnQ==
X-Received: by 2002:a9d:7b43:0:b0:6f9:62e9:9f93 with SMTP id 46e09a7af769-700b12a1d3emr6253705a34.35.1719269690460;
        Mon, 24 Jun 2024 15:54:50 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c3775sm351009885a.59.2024.06.24.15.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 15:54:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F3F1A120006B;
	Mon, 24 Jun 2024 18:54:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 24 Jun 2024 18:54:49 -0400
X-ME-Sender: <xms:OPl5ZmtK0iI6Fi6Fmj2yDiYNs5sfVi4xWofdYtVeq7HtMb6VrORxfw>
    <xme:OPl5Zrft_270b-F7XNcrI-fVMbT7rFfKk1ffl6KgnJ6rriqQbUaKfubg0dofoAeVR
    zIbZvMBOW5onjyFUw>
X-ME-Received: <xmr:OPl5Zhz5ngCrP5c7fRAaswsMD2tD_YRI3Ne8Qp6a2iHaWvZoJekD_J7Yxk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhteffveeuhefhveefgfehvdejkeefuefgfeegvedtheegvdelueevvdeg
    teffueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlphgtrdgvvhgvnhhtshenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:OPl5ZhOlMkoJgkxgJIsdhuiePPWijGaeMtXqsXL78gbK33Hj0UxT0Q>
    <xmx:OPl5Zm8fp_sewk5eULcag-LXjClikhGnzB3gmlQ_MV8lscpvQLlY2g>
    <xmx:OPl5ZpW4oAlTlHShqh-g_gba_UeIawTK97MDGix8R_cak6yEqnWmJw>
    <xmx:OPl5ZvcGPlEDTBm5JZkjPJ345taw5lW9bwjSC5GWPnP4aq-9mpQjdQ>
    <xmx:OPl5ZgeuD_g7bwcthIgo-o5M_gsriF6XWingqBniSPEcjLatoOxMzm1n>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 18:54:48 -0400 (EDT)
Date: Mon, 24 Jun 2024 15:54:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Leonardo Bras <leobras@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Message-ID: <Znn5FgqoCAUAfQhu@boqun-archlinux>
References: <20240622035815.569665-1-leobras@redhat.com>
 <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>

On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> Hi,
> 
> you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> section in MAINTAINERS so I've added folks from there in my reply.

Thanks!

> Link to full series:
> https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/
> 

And apologies to Leonardo... I think this is a follow-up of:

	https://lpc.events/event/17/contributions/1484/

and I did remember we had a quick chat after that which I suggested it's
better to change to a different name, sorry that I never found time to
write a proper rely to your previous seriese [1] as promised.

[1]: https://lore.kernel.org/lkml/20230729083737.38699-2-leobras@redhat.com/

> On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > The problem:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with remote requests is
> > sure to introduce unexpected deadline misses.
> > 
> > The idea:
> > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > In this case, instead of scheduling work on a remote cpu, it should
> > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > work locally. Tha major cost, which is un/locking in every local function,
> > already happens in PREEMPT_RT.
> 
> I've also noticed this a while ago (likely in the context of rewriting SLUB
> to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> the idea. But I forgot the details about why, so I'll let the the locking
> experts reply...
> 

I think it's a good idea, especially the new name is less confusing ;-)
So I wonder Thomas' thoughts as well.

And I think a few (micro-)benchmark numbers will help.

Regards,
Boqun

> > Also, there is no need to worry about extra cache bouncing:
> > The cacheline invalidation already happens due to schedule_work_on().
> > 
> > This will avoid schedule_work_on(), and thus avoid scheduling-out an 
> > RT workload. 
> > 
> > For patches 2, 3 & 4, I noticed just grabing the lock and executing
> > the function locally is much faster than just scheduling it on a
> > remote cpu.
> > 
> > Proposed solution:
> > A new interface called Queue PerCPU Work (QPW), which should replace
> > Work Queue in the above mentioned use case. 
> > 
> > If PREEMPT_RT=n, this interfaces just wraps the current 
> > local_locks + WorkQueue behavior, so no expected change in runtime.
> > 
> > If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
> > per-cpu structure and perform work on it locally. This is possible
> > because on functions that can be used for performing remote work on
> > remote per-cpu structures, the local_lock (which is already
> > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > 
> > Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
> > current local_lock + WorkQueue interface by the QPW interface in
> > swap, memcontrol & slub interface.
> > 
> > Please let me know what you think on that, and please suggest
> > improvements.
> > 
> > Thanks a lot!
> > Leo
> > 
> > Leonardo Bras (4):
> >   Introducing qpw_lock() and per-cpu queue & flush work
> >   swap: apply new queue_percpu_work_on() interface
> >   memcontrol: apply new queue_percpu_work_on() interface
> >   slub: apply new queue_percpu_work_on() interface
> > 
> >  include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/memcontrol.c     | 20 ++++++-----
> >  mm/slub.c           | 26 ++++++++------
> >  mm/swap.c           | 26 +++++++-------
> >  4 files changed, 127 insertions(+), 33 deletions(-)
> >  create mode 100644 include/linux/qpw.h
> > 
> > 
> > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> 

