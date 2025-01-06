Return-Path: <cgroups+bounces-6060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A800A03333
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47531634C7
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90DA1E0DFD;
	Mon,  6 Jan 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bM2kIo10"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB641C69D
	for <cgroups@vger.kernel.org>; Mon,  6 Jan 2025 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205226; cv=none; b=lIl1DZGItTcwpSEU4Lmrz+wZ6NI7mU22BhUtJdw4uNhCdqsWm7UBvrTFCGgyStcxpAw5ic7JYSMk6I5T1nXAqnuI3LVt7McquyMjFN0zlZo2JIAe1h2viAlkyDFNOc+X+GX01oGS70qJHG5MxcV1MNo9t8/DXZkbah0gST5/3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205226; c=relaxed/simple;
	bh=i23iAS6JrIxT16mD2Q/2YXsTbRhScbe6dgRDxxW5wUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWiQgtx1WFuaVkJRo3lh6ybB1Nnwix6qUpbvPZq2P6eBYSDyS/zSiU8PYWX8Pxevxz+2NYvZZmW6TQNGFKF5RBJm6Bruv0p1s/H/m/8v4hwTfpxAYqE3jWBGV94csh8EO7fDHw1sVZztvFnwND0Zy2QoxXyMWevoE9P/mxj8VsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bM2kIo10; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6c3629816so768360585a.1
        for <cgroups@vger.kernel.org>; Mon, 06 Jan 2025 15:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736205223; x=1736810023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwp+vRjxgRIF9zCRQ8EF3eMxpCJjfxIuCjiuC1fjLTc=;
        b=bM2kIo10rUMFtSh/beUtkZ93mTucRe0w6vSYWdy5qHiTFDI81feWbKAQ74mprl0YYh
         x3hNa2iqr+GOEBp1L1yne4TrIEY8rrwGRXX5dnuklYh7yReyYZ8PGvxYFbKIkga+zLP8
         E4mvQG/4pIL/AiqcBpc6c/DXMvVp1XEdwTMPac5d7lWE/wcm9wKX60KW3Xbpo1lOay+C
         fjP5I4kaTgJFvfdHqfB2L+26g/xofLVqb/dO7k/49fBjhKck2FvAyUV3pXPcoh4jkH6K
         4mKgJPilbINevh1nZJENj7J2VigoZB1BHTtJE1J/RnWRI+2Xzzmdz8WoPGrH61IfldzJ
         M7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205223; x=1736810023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uwp+vRjxgRIF9zCRQ8EF3eMxpCJjfxIuCjiuC1fjLTc=;
        b=rqtW6p6PLbCid7msG7XtjhJl1TgeIxH6OAuBM+IYQKbyCTmayikq4Czm4RXjiBefkS
         pSRBuYK+w8eSulxk/UZndv0ODXb2IO2YocW9JcCqbaa6P/efR689pVQBvTII8FdE+rbr
         XXziTEcZl12FqHmJPZVCBeYWyvSFBMg7IgfgCQtpMtNyC/QGX5LnC7KnyL0SxNREVerj
         eUDocvexhkBm+IZKf/JZaCJqvArgH4SJyL6wtz8dHGkj69lNFQEIH0i+kEFkQGkMldZm
         JeeuZplQLMhIEwbC21AZXT5QFzxFwjvj0StA65WN7guxySy9AhxYudbTp+Kn+edSbbyE
         Q/pg==
X-Forwarded-Encrypted: i=1; AJvYcCVuKzSWJV7sxIOQOLpT3zo66ZAumi8K7qXv7Kp5+Ot5buWojZX4iaJIHyaVyPgSDQgrFSwhMwQA@vger.kernel.org
X-Gm-Message-State: AOJu0YxizwtO3Y3PJpraPwV1BqDub4Z45WaIv779f1FxkOCAjw6CSvAs
	2ZXxHFIApSqrjrsRpq5m50gMlxST7b0sN2jgXs+n92meujAGFJMvRAJ6oioMlDLwcNgKwdOvykw
	GSDQdF97TyczSSSD+S1I14UxsDZze8v2ct+JjGuG1hNq5C42Kqywx
X-Gm-Gg: ASbGnctyuuFsgU6oQDTqU3Q49sHdkCdZgyX+2RJkU1uoetECfbUvWIaa1ZS0ITS2lJy
	muRGYvm3V9kNrHt/h0RMw428qJ8TaLKzEguk=
X-Google-Smtp-Source: AGHT+IFTmheYQkfNiE+wJra3WcyiDIXlm/GreXbGIHMXplrOAJC93cASbVnS3x6U6C1tSzdpOkSdnIfbGx+i2SwafTE=
X-Received: by 2002:a05:620a:4103:b0:7b6:f0e4:d9a0 with SMTP id
 af79cd13be357-7b9ba7aa42dmr7541193985a.33.1736205223411; Mon, 06 Jan 2025
 15:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103015020.78547-1-inwardvessel@gmail.com>
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 Jan 2025 15:13:07 -0800
X-Gm-Features: AbW1kvYCXQfp5C1npainbuqrtpNxN9kB7R6ptH2Kber27aGZVMvx59IyF5hLLxk
Message-ID: <CAJD7tkY=bQEY0TuOixXYRERO7Z1xE_j7airy+FK5m7u0DD4MXg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9 v2] cgroup: separate per-subsystem rstat trees
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, tj@kernel.org, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 5:50=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> w=
rote:
>
> The current rstat model is set up to keep track of cgroup stats on a per-=
cpu
> basis. When a stat (of any subsystem) is updated, the updater notes this =
change
> using the cgroup_rstat_updated() API call. This change is propagated to t=
he
> cpu-specific rstat tree, by appending the updated cgroup to the tree (unl=
ess
> it's already on the tree). So for each cpu, an rstat tree will consist of=
 the
> cgroups that reported one or more updated stats. Later on when a flush is
> requested via cgroup_rstat_flush(), each per-cpu rstat tree is traversed
> starting at the requested cgroup and the subsystem-specific flush callbac=
ks
> (via css_rstat_flush) are invoked along the way. During the flush, the se=
ction
> of the tree starting at the requested cgroup through its descendants are
> removed.
>
> Using the cgroup struct to represent nodes of change means that the chang=
es
> represented by a given tree are heterogeneous - the tree can consist of n=
odes
> that have changes from different subsystems; i.e. changes in stats from t=
he
> memory subsystem and the io subsystem can coexist in the same tree. The
> implication is that when a flush is requested, usually in the context of =
a
> single subsystem, all other subsystems need to be flushed along with it. =
This
> seems to have become a drawback due to how expensive the flushing of the
> memory-specific stats have become [0][1]. Another implication is when upd=
ates
> are performed, subsystems may contend with each other over the locks invo=
lved.
>
> I've been experimenting with an idea that allows for isolating the updati=
ng and
> flushing of cgroup stats on a per-subsystem basis. The idea was instead o=
f
> having a per-cpu rstat tree for managing stats across all subsystems, we =
could
> split up the per-cpu trees into separate trees for each subsystem. So eac=
h cpu
> would have separate trees for each subsystem. It would allow subsystems t=
o
> update and flush their stats without any contention or extra overhead fro=
m
> other subsystems. The core change is moving ownership of the the rstat en=
tities
> from the cgroup struct onto the cgroup_subsystem_state struct.
>
> To complement the ownership change, the lockng scheme was adjusted. The g=
lobal
> cgroup_rstat_lock for synchronizing updates and flushes was replaced with
> subsystem-specific locks (in the cgroup_subsystem struct). An additional =
global
> lock was added to allow the base stats pseudo-subsystem to be synchronize=
d in a
> similar way. The per-cpu locks called cgroup_rstat_cpu_lock have changed =
to a
> per-cpu array of locks which is indexed by subsystem id. Following suit, =
there
> is also a per-cpu array of locks dedicated to the base subsystem. The ded=
icated
> locks for the base stats was added since the base stats have a NULL subsy=
stem
> so it did not fit the subsystem id index approach.
>
> I reached a point where this started to feel stable in my local testing, =
so I
> wanted to share and get feedback on this approach.

I remember discussing this with Shakeel and Michal Koutn=C3=BD in LPC two
years ago. I suggested it multiple times over the last few years, most
recently in: https://lore.kernel.org/lkml/CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QL=
PmgNyOnaTrm+hZ_9hA@mail.gmail.com/.

I think it conceptually makes sense, and I took a stab at it when I
was working on fixing the hard lockups due to atomic flushing, but the
system I was working on was using cgroup v1, so different subsystems
had different hierarchies (and hence different trees) anyway, so it
wouldn't have helped.

This is especially true for the MM subsystem, which apparently flushes
most often and has the most expensive flushes, so other subsystems are
probably being unnecessarily taxed.

>
> [0] https://lore.kernel.org/all/CAOm-9arwY3VLUx5189JAR9J7B=3DMiad9nQjjet_=
VNdT3i+J+5FA@mail.gmail.com/
> [1] https://github.blog/engineering/debugging-network-stalls-on-kubernete=
s/
>
> Changelog
> v2: updated cover letter and some patch text. no code changes.
>
> JP Kobryn (8):
>   change cgroup to css in rstat updated and flush api
>   change cgroup to css in rstat internal flush and lock funcs
>   change cgroup to css in rstat init and exit api
>   split rstat from cgroup into separate css
>   separate locking between base css and others
>   isolate base stat flush
>   remove unneeded rcu list
>   remove bpf rstat flush from css generic flush
>
>  block/blk-cgroup.c              |   4 +-
>  include/linux/cgroup-defs.h     |  35 ++---
>  include/linux/cgroup.h          |   8 +-
>  kernel/cgroup/cgroup-internal.h |   4 +-
>  kernel/cgroup/cgroup.c          |  79 ++++++-----
>  kernel/cgroup/rstat.c           | 225 +++++++++++++++++++-------------
>  mm/memcontrol.c                 |   4 +-
>  7 files changed, 203 insertions(+), 156 deletions(-)
>
> --
> 2.47.1
>

