Return-Path: <cgroups+bounces-1177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A083253E
	for <lists+cgroups@lfdr.de>; Fri, 19 Jan 2024 08:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B71C2867D7
	for <lists+cgroups@lfdr.de>; Fri, 19 Jan 2024 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDB8D51D;
	Fri, 19 Jan 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhZMrL3n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1D6AA0
	for <cgroups@vger.kernel.org>; Fri, 19 Jan 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650485; cv=none; b=c25y5NZP18BvcmnYGAnAMh8mXNP3zMXsWwnehRC5HZkhnMZfF2QvtZnxExRFUwUdeAFvwVIoXb8AkZIhsy5cER1J0xNEYhL06bVw9ZVLGM6795Ov+3KOKtbB3FE7ouILY3YeZ1X2RH3+4XRvGr14OiUCOi9jmD1uRu1ZLYZdRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650485; c=relaxed/simple;
	bh=dbAOVjE2Wm0t88Ow3HMtoG1SG9rDYNwruAB84WPN1zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywx2OQVNLJj5cCSU3hpx/JoJLWK8dQgmf3A2CKI2P8CKVyLvVXtk5CI9TTOVhnEiyXxslbGxrJIkugZMK3xaUyH3vnssyNEW2DiUmHha5VfZBG37vqIiabAAPypiGYirTZCe0oV9y1hAhev8iBSmWAX5Rfbp4bwHV8wxb4QdIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhZMrL3n; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d5ce88b51cso120085ad.0
        for <cgroups@vger.kernel.org>; Thu, 18 Jan 2024 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705650483; x=1706255283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B24ukB2YP6slYCgEIRmf+Hk92TM7//n+GaGioxlv0Yk=;
        b=PhZMrL3nk+wOOaxOMXQa47MUncl0Hxz0c3CwC9/rFasFzE5q2he0g3fZeyfjzkmOQp
         Jq/0jFPVhElgp0wpw5tii65jqaqUDay0v4B1Id/CVbg2La9uHdt50CcDkpz1G26lQ8qu
         /BIaMYRO0uDlbBEmNoZ/lRhcpO6Skdej/KW9gud6BbkXYbDNoeLqVkSkB7IdmCEw+HUE
         roNRkhA42BLFo/ABEBlBmZbvkjRb3BamPKNZJbJxOBFsRUxBeC23vT4xHEUa/jZAWTD6
         VC5UCt0f4GiIJDeWLE/CYBmRafe4umiFf7s2mWEA51cUjhb8ahlDoHUzD/LoJZpB+fvf
         3nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650483; x=1706255283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B24ukB2YP6slYCgEIRmf+Hk92TM7//n+GaGioxlv0Yk=;
        b=Z4jcsnJ1wNDNGgrdPOKtG/Y/h/fI2TzPWJeXYqQ28qP1UHWWTd0c76pAOYbn/+xdh0
         HEFrACsQFg55Es+DDrwkGF5R6kd+QB8IvJarBix/lNO+W/dPI9cRsOeQT++YQ3ePYy86
         YpiSgA5UZYBxpDOaO4FH4ERpo+0TzjHzCUcoS06XDicBoyIcK2tL/KFxZgXRkEHVdHNL
         qwqCg4HjJ1IbB2/Nvf2UQ0fxO5gr5Hy5/TvaAtq7RL5xRIO5aP9ee/WtfhIzNZ+/5J1F
         eWrcWon+43lTja3D+E0Ezeu1lr1cdVIg3vfEeLzWOPPyXuvOS1w30Ww6q4zipADEeUK1
         fVxQ==
X-Gm-Message-State: AOJu0YyDt1NzaBAndgU4s7NR6pAGhzgz4RZ5w4VhFqP6wLO07Z7CzXHj
	UjB4XAhWzl3A/6dBEUlaMjkG2p2h0kWgVdKHmBe7q+mkrzWCcBs8qvxUOd4SRWrAMpP2eUjgOIT
	nWqLZ3j/xJNHl0toYQvsIGy0p8zpG88kTcJ9K
X-Google-Smtp-Source: AGHT+IGH3WXcjH0pc0MDrqdUz2dR/fcNlao+XhL+WRfT60dYLM8gHj0I+P+3/OgoIn2uGsadlUi4OA4BIncXcva5REw=
X-Received: by 2002:a17:903:110c:b0:1d5:4c40:bf01 with SMTP id
 n12-20020a170903110c00b001d54c40bf01mr127187plh.17.1705650482720; Thu, 18 Jan
 2024 23:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble> <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com> <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 18 Jan 2024 23:47:51 -0800
Message-ID: <CALvZod7T=gops1B6gU3M7rOJ8D2mOrSwQ2hfpLaE-tNWZynAug@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:20=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Wed, Jan 17, 2024 at 01:02:19PM -0800, Shakeel Butt wrote:
> > On Wed, Jan 17, 2024 at 12:21=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wr=
ote:
> > > >
> > > > That's a good point.  If the microbenchmark isn't likely to be even
> > > > remotely realistic, maybe we should just revert the revert until if=
/when
> > > > somebody shows a real world impact.
> > > >
> > > > Linus, any objections to that?
> > >
> > > We use SLAB_ACCOUNT for much more common allocations like queued
> > > signals, so I would tend to agree with Jeff that it's probably just
> > > some not very interesting microbenchmark that shows any file locking
> > > effects from SLAB_ALLOC, not any real use.
> > >
> > > That said, those benchmarks do matter. It's very easy to say "not
> > > relevant in the big picture" and then the end result is that
> > > everything is a bit of a pig.
> > >
> > > And the regression was absolutely *ENORMOUS*. We're not talking "a fe=
w
> > > percent". We're talking a 33% regression that caused the revert:
> > >
> > >    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex=
-9020/
> > >
> > > I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
> > > single allocation, it would be much nicer to account at a bigger
> > > granularity, possibly by having per-thread counters first before
> > > falling back to the obj_cgroup_charge. Whatever.
> > >
> > > It's kind of stupid to have a benchmark that just allocates and
> > > deallocates a file lock in quick succession spend lots of time
> > > incrementing and decrementing cgroup charges for that repeated
> > > alloc/free.
> > >
> > > However, that problem with SLAB_ACCOUNT is not the fault of file
> > > locking, but more of a slab issue.
> > >
> > > End result: I think we should bring in Vlastimil and whoever else is
> > > doing SLAB_ACCOUNT things, and have them look at that side.
> > >
> > > And then just enable SLAB_ACCOUNT for file locks. But very much look
> > > at silly costs in SLAB_ACCOUNT first, at least for trivial
> > > "alloc/free" patterns..
> > >
> > > Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
> > > thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
> > > file lock caches") for the history here.
> > >
> >
> > Roman last looked into optimizing this code path. I suspect
> > mod_objcg_state() to be more costly than obj_cgroup_charge(). I will
> > try to measure this path and see if I can improve it.
>
> It's roughly an equal split between mod_objcg_state() and obj_cgroup_char=
ge().
> And each is comparable (by order of magnitude) to the slab allocation cos=
t
> itself. On the free() path a significant cost comes simple from reading
> the objcg pointer (it's usually a cache miss).
>
> So I don't see how we can make it really cheap (say, less than 5% overhea=
d)
> without caching pre-accounted objects.
>
> I thought about merging of charge and stats handling paths, which _maybe_=
 can
> shave off another 20-30%, but there still will be a double-digit% account=
ing
> overhead.
>
> I'm curious to hear other ideas and suggestions.
>
> Thanks!

I profiled (perf record -a) the same benchmark i.e. lock1_processes on
an icelake machine with 72 cores and got the following results:

  12.72%  lock1_processes  [kernel.kallsyms]   [k] mod_objcg_state
  10.89%  lock1_processes  [kernel.kallsyms]   [k] kmem_cache_free
   8.40%  lock1_processes  [kernel.kallsyms]   [k] slab_post_alloc_hook
   8.36%  lock1_processes  [kernel.kallsyms]   [k] kmem_cache_alloc
   5.18%  lock1_processes  [kernel.kallsyms]   [k] refill_obj_stock
   5.18%  lock1_processes  [kernel.kallsyms]   [k] _copy_from_user

On annotating mod_objcg_state(), the following irq disabling
instructions are taking 30% of its time.

  6.64 =E2=94=82       pushfq
 10.26=E2=94=82       popq   -0x38(%rbp)
  6.05 =E2=94=82       mov    -0x38(%rbp),%rcx
  7.60 =E2=94=82       cli

For kmem_cache_free() & kmem_cache_alloc(), the following instruction
was expensive, which corresponds to __update_cpu_freelist_fast().

 16.33 =E2=94=82      cmpxchg16b %gs:(%rsi)

For slab_post_alloc_hook(), it's all over the place and
refill_obj_stock() is very similar to mod_objcg_state().

I will dig more in the next couple of days.

