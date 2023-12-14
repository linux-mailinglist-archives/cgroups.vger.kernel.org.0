Return-Path: <cgroups+bounces-962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F08139F7
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 19:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130FD282332
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404B68B89;
	Thu, 14 Dec 2023 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tX6h8nLb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB2B112
	for <cgroups@vger.kernel.org>; Thu, 14 Dec 2023 10:28:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1e35c2807fso1116917966b.3
        for <cgroups@vger.kernel.org>; Thu, 14 Dec 2023 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578517; x=1703183317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH4CLT11soXgvi/oQe5hBTiRESQ8UWLQkTtFerePfus=;
        b=tX6h8nLb1kYr8Fz4Aask5U8JKI7e50dBBD+xcXQhmoqLhmp8LfoWHORUw/kn+gw97E
         gAv0lMfGOyKT2bSf/Ms0umF0YWrGKyXpsNwSnHefmlw/dceZhXJVOESB8OHnmuBB0MSz
         cBKtmp3DZQ7VFkF1BsQSGeNAznQsY7Zle2g/BTA0B7XCV3jBYWUiTjrFrX32IQMe0a6I
         VChW/DqiaxlBoVeMxlIO7fEcCHPpNWnkcvCoeb/lxEeRhj5aKbBvoZUCFcLCmuJO4TdL
         bHW4auLthuMvzhVnLjWkMBesRGSKoV+vGiAXH18GRplVkxivED/+WR81qjuPln+3lfD2
         cBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578517; x=1703183317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH4CLT11soXgvi/oQe5hBTiRESQ8UWLQkTtFerePfus=;
        b=rhr6QxRzMnftZB8y+NQlp+D1bu3LGAA7TMuCBg2p+F6tRHu5tRWjQ6b9I+96wUpy9Y
         KspQqhjGxX+zI2SrAa1rbIwxP1aZiCyMwDW7y45LXyNLB3XY5lq4A5E/FroBtasKjm/4
         st79r1DQBhIX80v//ADA0aVCfb84Vz8lJ1/adscehAlLe+9vdkRIcLcuXFrP8BHZfUuo
         n/I/nHRZ1WnkilG5ZU3/Iaxr5R+l9grjGi5WJhPQ6DZNcI9j/IS5xIOOgJKSJ5SvHFjN
         /Rvsvomaz2Mwa3ap6zGdbTIyvCqnygHqhRszcDzafBdAFMLqO11CpmPR+aXVv9zv+j17
         65Pg==
X-Gm-Message-State: AOJu0YwBBBYGZN478mk4AnSwPwt7ehqkCJ7lCaa0BJDtsy2GHZfnfbLW
	X/hvsvpBc7Q6tEuwVynUgdrIvJYxjvskKHHtjORO+A==
X-Google-Smtp-Source: AGHT+IHRwu9vWZ1HNkcpck/GZz1PmTPXDUEpaeLXHi9jKbPJ12eb2WfPX3ltH5XMfAwVgTTcxoc64P3ITxj2/N55KrE=
X-Received: by 2002:a17:907:962a:b0:a1d:53d8:427e with SMTP id
 gb42-20020a170907962a00b00a1d53d8427emr6349710ejc.119.1702578517047; Thu, 14
 Dec 2023 10:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com> <ZXq_H4St_NSEFkcD@tiehlicka>
 <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 14 Dec 2023 10:28:01 -0800
Message-ID: <CAJD7tkYAzW-8isZFjAaebrw8s4-h1LCRtZV-HckHa5_A-2oY7A@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:22=E2=80=AFAM Dan Schatzberg
<schatzberg.dan@gmail.com> wrote:
>
> On Thu, Dec 14, 2023 at 09:38:55AM +0100, Michal Hocko wrote:
> > On Tue 12-12-23 17:38:03, Dan Schatzberg wrote:
> > > Allow proactive reclaimers to submit an additional swappiness=3D<val>
> > > argument to memory.reclaim. This overrides the global or per-memcg
> > > swappiness setting for that reclaim attempt.
> >
> > You are providing the usecase in the cover letter and Andrew usually
> > appends that to the first patch in the series. I think it would be
> > better to have the usecase described here.
> >
> > [...]
> > > @@ -1304,6 +1297,18 @@ PAGE_SIZE multiple when read back.
> > >     This means that the networking layer will not adapt based on
> > >     reclaim induced by memory.reclaim.
> > >
> > > +The following nested keys are defined.
> > > +
> > > +     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +     swappiness            Swappiness value to reclaim with
> > > +     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +   Specifying a swappiness value instructs the kernel to perform
> > > +   the reclaim with that swappiness value. Note that this has the
> > > +   same semantics as the vm.swappiness sysctl - it sets the
> >
> > same semantics as vm.swappiness applied to memcg reclaim with all the
> > existing limitations and potential future extensions.
>
> Thanks, will make this change.
>
> >
> > > +   relative IO cost of reclaiming anon vs file memory but does
> > > +   not allow for reclaiming specific amounts of anon or file memory.
> > > +
> > >    memory.peak
> > >     A read-only single value file which exists on non-root
> > >     cgroups.
> >
> > The biggest problem with the implementation I can see, and others have
> > pointed out the same, is how fragile this is. You really have to check
> > the code and _every_ place which defines scan_control to learn that
> > mem_cgroup_shrink_node, reclaim_clean_pages_from_list,
> > reclaim_folio_list, lru_gen_seq_write, try_to_free_pages, balance_pgdat=
,
> > shrink_all_memory and __node_reclaim. I have only checked couple of
> > them, like direct reclaim and kswapd and none of them really sets up
> > swappiness to the default memcg nor global value. So you effectively en=
d
> > up with swappiness =3D=3D 0.
> >
> > While the review can point those out it is quite easy to break and you
> > will only learn about that very indirectly. I think it would be easier
> > to review and maintain if you go with a pointer that would fallback to
> > mem_cgroup_swappiness() if NULL which will be the case for every
> > existing reclaimer except memory.reclaim with swappiness value.
>
> I agree. My initial implementation used a pointer for this
> reason. I'll switch this back. Just to be clear - I still need to
> initialize scan_control.swappiness in all these other places right? It
> appears to mostly be stack-initialized which means it has
> indeterminate value, not necessarily zero.

My understanding is that in a partially initialized struct,
uninitialized members default to 0, but I am not a C expert :)

