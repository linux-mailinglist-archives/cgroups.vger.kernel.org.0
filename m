Return-Path: <cgroups+bounces-1167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAF830E58
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 22:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7402D283E28
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3025555;
	Wed, 17 Jan 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjrrNFBf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92060250E2
	for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525353; cv=none; b=Mw1ILhEDqQjKJQD7ZmU3ZDWA3o9oE9DOyQ5KxET5pGX9gwP/pXD+LW2+aRzstBH8ujrIuoqbepYWK1/1IY/unzVvBdNBE9FhU7XqCmIvOfUWYxu5AUfFBeTfOFuqYBj5CJiVhSN/XOL39j834iIQgF/On3jV3rC9ed2VOcx/tOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525353; c=relaxed/simple;
	bh=x2ltNTRVY40OZPPI4mwfRvVr6yiGl4dOpCTU/Sebxb8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=B6fpVucIIXZaPloXkh6VY0u9CJr6QFC7qN48EBWUnmR8SRDCZCh0DANMwWsE6vXEAxj7Lg46M7VRPUL1JeIc5KELAfZIvWEiphaxCXMH83uTWFc1sRKwFQmy8aExDh6Xk89gesxmNFsJclsq3saYHiG1FCEcMby1mSkFNh2dCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjrrNFBf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d6f1df9355so151325ad.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jan 2024 13:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705525352; x=1706130152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsaUVhsK+enKkBw1KIJtxzFPjcPyIBpdkEzOvagjDdM=;
        b=TjrrNFBfTNTDBlHsEIFwOR9AmuxRwYRzYW0Zg2PtHW6FqeOV8A2oh95y9/OotD7tLu
         n6po1eHC/V4H/2rfP4nDM61zILpMjSrRTHfoxdnFF0RTtVp/248GhZWi28E2/sUi4Kcx
         RQ3L20VF3JQrZ4tW28olUr++xCz9QPD3L8d2ZrlE4GKV7cFPbsQRcHc9xAxSflko7ctE
         cCnxuXhIw8jtk75Uzl6AR7LYoSJSpOu3K2j9AA6uHacOInofDMz004lriyb2u4z7SL9V
         XVFooG3L6LK6Wpk4/vskvNe1z9Y1FEUeZzLNT2NEjmj3wgVAQobIjx5vF8slzrp8XSVF
         rlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525352; x=1706130152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsaUVhsK+enKkBw1KIJtxzFPjcPyIBpdkEzOvagjDdM=;
        b=Xc0YwgIMD1pt/yd1hd1K3mNmr5FlB/X8oRqMZw100+jl7Wx4OnpbAp5pmXVx9eHep0
         xSGHV3R2A50Jol8mCWF2NeoQ1EHxIMYRMGG/CfkYbVH/zCqYSP2Smq4gR7onAw/Cd7NQ
         bElesoMIsmuZXVnYM3hZ7uV+UgiIWzVhIAT8RpPrDOTGqdgDcuuMyX0OnFnNGWMGnBcO
         K4ZdTO22Yu++wTpMyEhTK6Cz1+Tv/Qix7gVNalzZ4WyziTZJgrzhGhlI/GYnSK6nVXwh
         Klsd7j1FQFI2sseNq182jKL6Q0qg1XuILr5oPGOsIYHXxq6OffiGQ4B9ALeJ9Zk129Zy
         w8uA==
X-Gm-Message-State: AOJu0YwsIv2E3k3Vb/5cEzXuPYwATueNs89sgFrhLqjRiNmbrnLGSe8j
	bOG97fpEXN2dMDUVWBg3seSkfU9aTkhct18+FHzVfPkO338z06AnqEwciu7dyGU5EmiVQ6YFaRL
	918QggyacQKGn8u06VnjrrRFGA/UntYa5Ndzm
X-Google-Smtp-Source: AGHT+IGWIZhqLzcx2+bVk3ob7lrZPkCBExq2fGpUqcnbH0YOKIaCLZflhVKVys1PkHM7n5+U05d1eOq+VDzUvlTq/vI=
X-Received: by 2002:a17:902:aa98:b0:1d5:b931:911a with SMTP id
 d24-20020a170902aa9800b001d5b931911amr234007plr.27.1705525351695; Wed, 17 Jan
 2024 13:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705507931.git.jpoimboe@kernel.org> <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble> <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
In-Reply-To: <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 17 Jan 2024 13:02:19 -0800
Message-ID: <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Vasily Averin <vasily.averin@linux.dev>, 
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 17 Jan 2024 at 11:39, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > That's a good point.  If the microbenchmark isn't likely to be even
> > remotely realistic, maybe we should just revert the revert until if/whe=
n
> > somebody shows a real world impact.
> >
> > Linus, any objections to that?
>
> We use SLAB_ACCOUNT for much more common allocations like queued
> signals, so I would tend to agree with Jeff that it's probably just
> some not very interesting microbenchmark that shows any file locking
> effects from SLAB_ALLOC, not any real use.
>
> That said, those benchmarks do matter. It's very easy to say "not
> relevant in the big picture" and then the end result is that
> everything is a bit of a pig.
>
> And the regression was absolutely *ENORMOUS*. We're not talking "a few
> percent". We're talking a 33% regression that caused the revert:
>
>    https://lore.kernel.org/lkml/20210907150757.GE17617@xsang-OptiPlex-902=
0/
>
> I wish our SLAB_ACCOUNT wasn't such a pig. Rather than account every
> single allocation, it would be much nicer to account at a bigger
> granularity, possibly by having per-thread counters first before
> falling back to the obj_cgroup_charge. Whatever.
>
> It's kind of stupid to have a benchmark that just allocates and
> deallocates a file lock in quick succession spend lots of time
> incrementing and decrementing cgroup charges for that repeated
> alloc/free.
>
> However, that problem with SLAB_ACCOUNT is not the fault of file
> locking, but more of a slab issue.
>
> End result: I think we should bring in Vlastimil and whoever else is
> doing SLAB_ACCOUNT things, and have them look at that side.
>
> And then just enable SLAB_ACCOUNT for file locks. But very much look
> at silly costs in SLAB_ACCOUNT first, at least for trivial
> "alloc/free" patterns..
>
> Vlastimil? Who would be the best person to look at that SLAB_ACCOUNT
> thing? See commit 3754707bcc3e (Revert "memcg: enable accounting for
> file lock caches") for the history here.
>

Roman last looked into optimizing this code path. I suspect
mod_objcg_state() to be more costly than obj_cgroup_charge(). I will
try to measure this path and see if I can improve it.

