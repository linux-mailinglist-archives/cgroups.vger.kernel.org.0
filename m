Return-Path: <cgroups+bounces-8682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01994AF86D8
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 06:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995EB4882EC
	for <lists+cgroups@lfdr.de>; Fri,  4 Jul 2025 04:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE221EB5C2;
	Fri,  4 Jul 2025 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNT2sAA9"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAA2AE96;
	Fri,  4 Jul 2025 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604300; cv=none; b=g4LtH81r2jEN6sH4aLSoH5l56EXMTU1bhn0MJjDO8H4kJRbHOW60WtW4oSBobWQ4yrcL08NRI6WvDwaGSrspp+gIDpg0/fkOKYbrEw+G9lgbCb6Nu035yvFxvuDEfh1iv//F3MlV/S6+GnSIZ345pwVmqUD4TShjh6+ap17Sld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604300; c=relaxed/simple;
	bh=8LL5dfM4+fApXtGjqf/V6JOtfextTXNNY3ao2nJLhgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeGI1zR0lpMjrCrp0Wlw+3s8xFIOIhXqwDtZpike4ZO5jwZBQC6myyTNImn9aniXR1wNvskPG8W2Dd0ahzUfy83/eUsEJDIKf7lcl7tj1qIHyitMMpYgjOAVjWYRgTxIMo2zD8KmY2+Whx6pNO2gvQC6nNCNJzmA3d91sms19B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNT2sAA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520A6C4CEE3;
	Fri,  4 Jul 2025 04:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604299;
	bh=8LL5dfM4+fApXtGjqf/V6JOtfextTXNNY3ao2nJLhgI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QNT2sAA9S6skXbsMPwoX70+PnJmgNecblMkkgk7iB9K5OUglNMjplv+Sjd5JGKGtZ
	 MBnP9FcS1HflpNA2loUWJZszkknB7LUlYJ4YpPasZL1piFHrZSdm2qzwijxFeBOQTD
	 BxqAbmx5eCaRkIn41Jw6Je3dh96dPZwV2VTQxYAAE9lQ4wFct3iB5DLmo5TkPzxOYM
	 JokDdLbmWKiQYvklkPVK4+5RfIvl07RnDQlp5e0sIGVQi249xXB8O1n8EZGvMsNpdN
	 z14Yx542Xq01u+jKKrbTqDVU7QVNYc4fyXc6rAdhj/nkzz+tXM0WhfipDW2YUGN33L
	 LMMTHNVAsBfBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DAFEFCE0D3B; Thu,  3 Jul 2025 21:44:58 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:44:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/2] cgroup: explain the race between updater and flusher
Message-ID: <da934450-db48-4ef9-ac1b-6b3fbb412862@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250703200012.3734798-1-shakeel.butt@linux.dev>
 <20250703200012.3734798-2-shakeel.butt@linux.dev>
 <ae928815-d3ba-4ae4-aa8a-67e1dee899ec@paulmck-laptop>
 <l3ta543lv3fn3qhcbokmt2ihmkynkfsv3wz2hmrgsfxu4epwgg@udpv5a4aai7t>
 <f6900de7-bfab-47da-b29d-138c75c172fd@paulmck-laptop>
 <CAGj-7pUdbtumOmfmW52F3aHJfkd5F+nGeH5LAf5muKqYR+xV-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGj-7pUdbtumOmfmW52F3aHJfkd5F+nGeH5LAf5muKqYR+xV-w@mail.gmail.com>

On Thu, Jul 03, 2025 at 06:54:02PM -0700, Shakeel Butt wrote:
> On Thu, Jul 3, 2025 at 4:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jul 03, 2025 at 03:46:07PM -0700, Shakeel Butt wrote:
> [...]
> > > Let me answer this one first. The previous patch actually made
> > > init_llist_node() do WRITE_ONCE().
> > >
> > > So the actual question is why do we need
> > > data_race([READ|WRITE]_ONCE()) instead of just [READ|WRITE]_ONCE()?
> >
> > You should *almost* always use [READ|WRITE]_ONCE() instead of data_race().
> >
> > > Actually I had the similar question myself and found the following
> > > comment in include/linux/compiler.h:
> > >
> > > /**
> > >  * data_race - mark an expression as containing intentional data races
> > >  *
> > >  * This data_race() macro is useful for situations in which data races
> > >  * should be forgiven.  One example is diagnostic code that accesses
> > >  * shared variables but is not a part of the core synchronization design.
> > >  * For example, if accesses to a given variable are protected by a lock,
> > >  * except for diagnostic code, then the accesses under the lock should
> > >  * be plain C-language accesses and those in the diagnostic code should
> > >  * use data_race().  This way, KCSAN will complain if buggy lockless
> > >  * accesses to that variable are introduced, even if the buggy accesses
> > >  * are protected by READ_ONCE() or WRITE_ONCE().
> > >  *
> > >  * This macro *does not* affect normal code generation, but is a hint
> > >  * to tooling that data races here are to be ignored.  If the access must
> > >  * be atomic *and* KCSAN should ignore the access, use both data_race()
> > >  * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> > >  */
> > >
> > > IIUC correctly, I need to protect llist_node against tearing and as well
> > > as tell KCSAN to ignore the access for race then I should use both.
> > > Though I think KCSAN treat [READ|WRITE]_ONCE similar to data_race(), so
> > > it kind of seem redundant but I think at least I want to convey that we
> > > need protection against tearing and ignore KCSAN and using both conveys
> > > that. Let me know if you think otherwise.
> > >
> > > thanks a lot for taking a look.
> >
> > The thing to remember is that data_race() does not affect the
> > generated code (except of course when running KCSAN), and thus does
> > absolutely nothing to prevent load/store tearing.  You need things like
> > [READ|WRITE]_ONCE() to prevent tearing.
> >
> > So if it does not affect the generated code, what is the point of
> > data_race()?
> >
> > One answer to this question is for diagnostics where you want KCSAN
> > to check the main algorithm, but you don't want KCSAN to be confused
> > by the diagnostic accesses.  For example, you might use something like
> > ASSERT_EXCLUSIVE_ACCESS() as in __list_splice_init_rcu(), and not want
> > your diagnostic accesses to result in false-positive KCSAN reports
> > due to interactions with ASSERT_EXCLUSIVE_ACCESS() on some particular
> > memory location.  And if you were to use READ_ONCE() to access that same
> > memory location in your diagnostics, KCSAN would complain if they ran
> > concurrently with that ASSERT_EXCLUSIVE_ACCESS().  So you would instead
> > use data_race() to suppress such complaints.
> >
> > Does that make sense?
> 
> Thanks a lot Paul for the awesome explanation. Do you think keeping
> data_race() here would be harmful in a sense that it might cause
> confusion in future?

Yes, plus it might incorrectly suppress a KCSAN warning for a very
real bug.  So I strongly recommend removing the data_race() in this case.

							Thanx, Paul

