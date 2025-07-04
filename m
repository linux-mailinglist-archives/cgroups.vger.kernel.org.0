Return-Path: <cgroups+bounces-8681-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA100AF8555
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CAF1C822A6
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 01:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5581D6DB6;
	Fri,  4 Jul 2025 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i4z+AGVW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784401D435F
	for <cgroups@vger.kernel.org>; Fri,  4 Jul 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594072; cv=none; b=O4sFrWuibhvRGzvQ2m4WcAVMzaBJN5lOXI5MQM/fLRIaRKQwGzecseMEBUZn4Fe2PbKifTjGAhfa7Sabu0czgqJGwIYgxAHr46WHS9Fiai5jDX1wn6+qCDMZgvyREznbJBII8P+xreshbBgf+Opi4nWd1RbOEdYxN4QM9AM62b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594072; c=relaxed/simple;
	bh=ruukrF8SuAMY/rRR1Jo/Ra+SgmM3R3oJ7P8PMzTsEQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfcWZx/iECny7R9w7OPsJ18yG7dLc6oKPn8kkkGJ7ebYaHloZcxitx+oIChG/klB0lEMnN6TJLc5aQsjQ1DHGAzpDVxt7ac5Xk0OG4jrOw5lxZRBLvrHRaP0bXDlXZRHOssHfYFIIkJG2dc/R5DU6j6OHMtlUIwpBykli33RgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i4z+AGVW; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUYwyXvIF9ZodjWAu3hHaTcbuX8NC1B0zxQwwv6SXvm0ubkzYfC1KJIJMR5D5EGDFfJiBEaLlSVNg==@vger.kernel.org, AJvYcCV1DlZJRyMlyxkMuqS79ocnnZ6yu7D76707H8ZS9ZLiaRqVqiwcXncP6eg9wNVfGQk0his=@vger.kernel.org, AJvYcCWZeXipZ+XHH/LhgjFKAu++KzYHnp2NhcYU71MNfCKNa1SBshOn11ZLiYWLZBWnwAZYHeTvV6+jidlBES1/@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751594058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zUFgNGFp2OU4bUfryivIV0PkBSaxkBjWLGPlV+/kxg=;
	b=i4z+AGVWaKSna0myZX6oVmjel9tQ3ISAmXupQYDlJvwZMlnUWu2emMuRxApot4npPz7cxh
	4vHBVFITErZg2j2bahe7tGUhwuvGDD6Yo9zQ92dfEJEtCqUI5AG+OlDENDqzMd6/9eUM54
	/q/Hw4sVsdDxXbrieKjrZiMGRFvko/Q=
X-Gm-Message-State: AOJu0Yx/C4jjEgav/jGGB/63wd7dKHHQiIzzVwFeFHY6NJWC7tE79LH7
	6Z0ajTwigujF7kvxOuZQraVTBkDsItPkIZl4u8RllcvTyJDcQs62NFXbCfxC8pf3HxkG4aXTjH3
	VmpWXObk708yNaXWTYEob7wP3ca2rHuc=
X-Google-Smtp-Source: AGHT+IHRp6cTYv2ZHhR/OqEQNvtHD+Kd9XEFyWCdJBjr2fL9kfV74hSEp+yyV6sRdSRdWq6c0+lR+1sTP0wHrzTW07E=
X-Received: by 2002:a05:6102:6c1:b0:4ec:b2cc:de60 with SMTP id
 ada2fe7eead31-4f2f1ebdc71mr162883137.11.1751594053446; Thu, 03 Jul 2025
 18:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev> <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
 <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t> <f6900de7-bfab-47da-b29d-138c75c172fd@paulmck-laptop>
In-Reply-To: <f6900de7-bfab-47da-b29d-138c75c172fd@paulmck-laptop>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 3 Jul 2025 18:54:02 -0700
X-Gmail-Original-Message-ID: <CAGj-7pUdbtumOmfmW52F3aHJfkd5F+nGeH5LAf5muKqYR+xV-w@mail.gmail.com>
X-Gm-Features: Ac12FXx-lZjWHd45ZSUnauMrY3R7tVAdMQDZfFbYy-kqIPMaM-Muufg8oe5W5TU
Message-ID: <CAGj-7pUdbtumOmfmW52F3aHJfkd5F+nGeH5LAf5muKqYR+xV-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
To: paulmck@kernel.org
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Ying Huang <huang.ying.caritas@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 3, 2025 at 4:53=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Thu, Jul 03, 2025 at 03:46:07PM -0700, Shakeel Butt wrote:
[...]
> > Let me answer this one first. The previous patch actually made
> > init_llist_node() do WRITE_ONCE().
> >
> > So the actual question is why do we need
> > data_race([READ|WRITE]_ONCE()) instead of just [READ|WRITE]_ONCE()?
>
> You should *almost* always use [READ|WRITE]_ONCE() instead of data_race()=
.
>
> > Actually I had the similar question myself and found the following
> > comment in include/linux/compiler.h:
> >
> > /**
> >  * data_race - mark an expression as containing intentional data races
> >  *
> >  * This data_race() macro is useful for situations in which data races
> >  * should be forgiven.  One example is diagnostic code that accesses
> >  * shared variables but is not a part of the core synchronization desig=
n.
> >  * For example, if accesses to a given variable are protected by a lock=
,
> >  * except for diagnostic code, then the accesses under the lock should
> >  * be plain C-language accesses and those in the diagnostic code should
> >  * use data_race().  This way, KCSAN will complain if buggy lockless
> >  * accesses to that variable are introduced, even if the buggy accesses
> >  * are protected by READ_ONCE() or WRITE_ONCE().
> >  *
> >  * This macro *does not* affect normal code generation, but is a hint
> >  * to tooling that data races here are to be ignored.  If the access mu=
st
> >  * be atomic *and* KCSAN should ignore the access, use both data_race()
> >  * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> >  */
> >
> > IIUC correctly, I need to protect llist_node against tearing and as wel=
l
> > as tell KCSAN to ignore the access for race then I should use both.
> > Though I think KCSAN treat [READ|WRITE]_ONCE similar to data_race(), so
> > it kind of seem redundant but I think at least I want to convey that we
> > need protection against tearing and ignore KCSAN and using both conveys
> > that. Let me know if you think otherwise.
> >
> > thanks a lot for taking a look.
>
> The thing to remember is that data_race() does not affect the
> generated code (except of course when running KCSAN), and thus does
> absolutely nothing to prevent load/store tearing.  You need things like
> [READ|WRITE]_ONCE() to prevent tearing.
>
> So if it does not affect the generated code, what is the point of
> data_race()?
>
> One answer to this question is for diagnostics where you want KCSAN
> to check the main algorithm, but you don't want KCSAN to be confused
> by the diagnostic accesses.  For example, you might use something like
> ASSERT_EXCLUSIVE_ACCESS() as in __list_splice_init_rcu(), and not want
> your diagnostic accesses to result in false-positive KCSAN reports
> due to interactions with ASSERT_EXCLUSIVE_ACCESS() on some particular
> memory location.  And if you were to use READ_ONCE() to access that same
> memory location in your diagnostics, KCSAN would complain if they ran
> concurrently with that ASSERT_EXCLUSIVE_ACCESS().  So you would instead
> use data_race() to suppress such complaints.
>
> Does that make sense?
>

Thanks a lot Paul for the awesome explanation. Do you think keeping
data_race() here would be harmful in a sense that it might cause
confusion in future?

