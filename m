Return-Path: <cgroups+bounces-1170-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E7830F21
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 23:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01C6283DFB
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0528DB8;
	Wed, 17 Jan 2024 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oo9nK5OL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBF28DB6
	for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530030; cv=none; b=d6JsNRm1s5vYj6dgXbnaM89xHXtNS6gGTKW6Z56wQ8RjsiS1/n6rvCWclLaU95vkpgmz4rRS97NUdjlue3MshQpP/wi6kE5ddWCKT3HEISzNEhx2z25437HlAtMwOnnapDo4SBtBy10zdSEJIdOXD8uuvKC7tY8g3OOeSM5bKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530030; c=relaxed/simple;
	bh=FePaCUEty5gnqt0K9AD8pYf32kGcc5Fn+FiwW9+63Wc=;
	h=Date:DKIM-Signature:X-Report-Abuse:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Migadu-Flow; b=cVwg7XXmlpN6ScvuE3LbDrBfM1wc+F7Zw62khxw/cb2cZYjDmpfOu0TcpkeyXrv9HMw+vD+jJs50Fu184qw9ecnKS5SCGYGttTBQBqz9rV9va3SINyQJAcdX9D5Aq5dGKN9fmMfvuz+UlYpe6EwmUuHGPL3bySZreLzW4j+V/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oo9nK5OL; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 17 Jan 2024 14:20:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705530026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEcZHshrstC6C+wvUe816o9OqrS9R+Ox74x4Ua6+cNg=;
	b=oo9nK5OLo2HbxZhIYJMCnLJpYtsivfboaj7C7gJ0VoDQxxdFw+ieXQh3sl0taplJs8h6VR
	QHtAdhqNaftf5uCuLcn+Gug1pTa/9k1srBFS3O8bcAo1Y2G6At7h0Cmc+rTWn5qcGvGUQg
	h1JE6ZW/8v0YWbpn8rfHURYglSWqHUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeelb@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
Message-ID: <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble>
 <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 17, 2024 at 01:02:19PM -0800, Shakeel Butt wrote:
> On Wed, Jan 17, 2024 at 12:21 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > That's a good point.  If the microbenchmark isn't likely to be even
> > > remotely realistic, maybe we should just revert the revert until if/when
> > > somebody shows a real world impact.
> > >
> > > Linus, any objections to that?
> >
> > We use SLAB_ACCOUNT for much more common allocations like queued
> > signals, so I would tend to agree with Jeff that it's probably just
> > some not very interesting microbenchmark that shows any file locking
> > effects from SLAB_ALLOC, not any real use.
> >
> > That said, those benchmarks do matter. It's very easy to say "not
> > relevant in the big picture" and then the end result is that
> > everything is a bit of a pig.
> >
> > And the regression was absolutely *ENORMOUS*. We're not talking "a few
> > percent". We're talking a 33% regression that caused the revert:
> >
> >    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-9020/
> >
> > I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
> > single allocation, it would be much nicer to account at a bigger
> > granularity, possibly by having per-thread counters first before
> > falling back to the obj_cgroup_charge. Whatever.
> >
> > It's kind of stupid to have a benchmark that just allocates and
> > deallocates a file lock in quick succession spend lots of time
> > incrementing and decrementing cgroup charges for that repeated
> > alloc/free.
> >
> > However, that problem with SLAB_ACCOUNT is not the fault of file
> > locking, but more of a slab issue.
> >
> > End result: I think we should bring in Vlastimil and whoever else is
> > doing SLAB_ACCOUNT things, and have them look at that side.
> >
> > And then just enable SLAB_ACCOUNT for file locks. But very much look
> > at silly costs in SLAB_ACCOUNT first, at least for trivial
> > "alloc/free" patterns..
> >
> > Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
> > thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
> > file lock caches") for the history here.
> >
> 
> Roman last looked into optimizing this code path. I suspect
> mod_objcg_state() to be more costly than obj_cgroup_charge(). I will
> try to measure this path and see if I can improve it.

It's roughly an equal split between mod_objcg_state() and obj_cgroup_charge().
And each is comparable (by order of magnitude) to the slab allocation cost
itself. On the free() path a significant cost comes simple from reading
the objcg pointer (it's usually a cache miss).

So I don't see how we can make it really cheap (say, less than 5% overhead)
without caching pre-accounted objects.

I thought about merging of charge and stats handling paths, which _maybe_ can
shave off another 20-30%, but there still will be a double-digit% accounting
overhead.

I'm curious to hear other ideas and suggestions.

Thanks!

