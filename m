Return-Path: <cgroups+bounces-1698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237A285A969
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 17:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4867C1C227B6
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 16:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC74439F;
	Mon, 19 Feb 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkZ/IxZ4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA241C85
	for <cgroups@vger.kernel.org>; Mon, 19 Feb 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361738; cv=none; b=O0+LPhfxX30tbWfwNcSvmXeAzxjYvvey5YJHQXYEaP9f6q4ZKohMGQ0imBVX3v6BRvF5kwMEeU27EErLO3PZC6KupycNFRC7DPgjlUYkqFkM9SiZzcLu8OeM5dUx0oNty8OMj/Tl705umSD4/ofR355S5YOoDDOs8O22WcewHOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361738; c=relaxed/simple;
	bh=L2Wk+KfPMqWFy+4dwx61nIYX1yKhjaAyyhWHKrdqFeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwsRUKDxMv550zliVs5btoLjiAbkeN/pgqmfSu66pVc6i0C+/BzIEFVWBWij+h97FO/bj76TC10OwDNzHrdPVPZ7Vnqa5r6bGzZWE1BLMcU4T1llX996Z24BqbOYrTu/Zl0NEggnH9tYMpZ+I9MEG7Nct3KTn3OEa9+2jx6a9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkZ/IxZ4; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso2787950276.1
        for <cgroups@vger.kernel.org>; Mon, 19 Feb 2024 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708361736; x=1708966536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC1JxayV7V5FEwBjiEEHat04AtMi8UdAlknxmmQHPbY=;
        b=MkZ/IxZ4QGXfI4ZTy9QDCdF6dyp0wZD+oD0HD8XIChpTjEQYwWiVrhhdipzC9NyIoX
         wLHW5WsTCcZTnzLVnhOYOz3zmUpOSnmKSJYLgsyjrRwWTGVpsApwlptLts+qEn4Qk0Un
         /dW/ZG24LaZivpClFG7/ubvZNAzi5kJ580ayfAjWOzSsccD70WRH6FVh2D9d+2PH2YOc
         MSc7F68O3oyldG67kbMOC+F6XuYzndFaavEgloTQqjeveKnHJse9DTh2pD9aMrYwTEK6
         zlGzqZLMGn+1gmyVal04viaSjc+d0e5VrUXYKev2lgQbl5RMAAxRBv/mbKeatIQWWwjz
         /QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361736; x=1708966536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC1JxayV7V5FEwBjiEEHat04AtMi8UdAlknxmmQHPbY=;
        b=ny5lAneTrwQLBAVbnjMOqmI5FihrnL4Fb1+LGuhwKJ7WYlne9tNaTA0bJEDcneJVqP
         HZu36PQNRtQNRjBBaEOg3EwtZB3BPg492RplVNlpCMMsEBtsiam5dXyzQpE9wUCCZihW
         KlTMhzYidjKmFFp6oELHHTTdggCdBp8fAtcjyBumqksKfnaHoQO9mOmf//gHj3quS2wm
         bCf9mYCF3Nzr09Mf1zJPYpm3OYXMdneNhraeyOxZTec6hE893sQ3TnvRxl6LHSmCaL+9
         FxJbxDPaVgtbfGXuylWMLq77CvK30ZhfXnYWlmKwaK26Z9ifHQ766DIr2Alc0UdvwzTd
         8MpA==
X-Forwarded-Encrypted: i=1; AJvYcCXFyKqq8QKGceKKG+pjYV/SUKeLGRy/+7HGIJALDTWtzTWIoM2T8tyI7OL/EGIMIfEAveIWEL72JKA21S42MfzFywlDTqukzw==
X-Gm-Message-State: AOJu0YxQpRZlxLl41HMMU3ysjcfS0Rh4iKiZyBiyH98Zv5HbonqukHxu
	/9AuE3bAiA4LYlu/qsfDIZ840adpZy7tJmwQgNW/udawLeb7r/aL/byhguZNl4naJ6qGU6FFgkF
	Ges9M6hAyV5tdw9UWrTmY7AE9En5+6qE1W+Y3
X-Google-Smtp-Source: AGHT+IE9e4H9CxOF/Wkt1BmMwgF6wG5QNpfKFX5SyoOVKH5zyjhHqyJSbZUQlTjCIfZiNsAQiQ1++39gCNndnejh6es=
X-Received: by 2002:a25:d68b:0:b0:dc6:aed5:718a with SMTP id
 n133-20020a25d68b000000b00dc6aed5718amr10952783ybg.26.1708361735183; Mon, 19
 Feb 2024 08:55:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-33-surenb@google.com>
 <f0a56027-472d-44a6-aba5-912bd50ee3ae@suse.cz> <CAJuCfpGUTu7uhcR-23=0d3Wnn8ZbDtNwTaFnukd9qYYVHS9aSA@mail.gmail.com>
 <5bd3761f-217d-45bb-bcd2-797f82c8a44f@suse.cz>
In-Reply-To: <5bd3761f-217d-45bb-bcd2-797f82c8a44f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 Feb 2024 08:55:22 -0800
Message-ID: <CAJuCfpHRqiV2LZEnCB0hwwoexw+8U_XzqH1f+LwLjsQxmXR3Tw@mail.gmail.com>
Subject: Re: [PATCH v3 32/35] codetag: debug: skip objext checking when it's
 for objext itself
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:17=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/19/24 02:04, Suren Baghdasaryan wrote:
> > On Fri, Feb 16, 2024 at 6:39=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> >>
> >> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> >> > objext objects are created with __GFP_NO_OBJ_EXT flag and therefore =
have
> >> > no corresponding objext themselves (otherwise we would get an infini=
te
> >> > recursion). When freeing these objects their codetag will be empty a=
nd
> >> > when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled this will lead to f=
alse
> >> > warnings. Introduce CODETAG_EMPTY special codetag value to mark
> >> > allocations which intentionally lack codetag to avoid these warnings=
.
> >> > Set objext codetags to CODETAG_EMPTY before freeing to indicate that
> >> > the codetag is expected to be empty.
> >> >
> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> > ---
> >> >  include/linux/alloc_tag.h | 26 ++++++++++++++++++++++++++
> >> >  mm/slab.h                 | 25 +++++++++++++++++++++++++
> >> >  mm/slab_common.c          |  1 +
> >> >  mm/slub.c                 |  8 ++++++++
> >> >  4 files changed, 60 insertions(+)
> >> >
> >> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> >> > index 0a5973c4ad77..1f3207097b03 100644
> >>
> >> ...
> >>
> >> > index c4bd0d5348cb..cf332a839bf4 100644
> >> > --- a/mm/slab.h
> >> > +++ b/mm/slab.h
> >> > @@ -567,6 +567,31 @@ static inline struct slabobj_ext *slab_obj_exts=
(struct slab *slab)
> >> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >> >                       gfp_t gfp, bool new_slab);
> >> >
> >> > +
> >> > +#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
> >> > +
> >> > +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
> >> > +{
> >> > +     struct slabobj_ext *slab_exts;
> >> > +     struct slab *obj_exts_slab;
> >> > +
> >> > +     obj_exts_slab =3D virt_to_slab(obj_exts);
> >> > +     slab_exts =3D slab_obj_exts(obj_exts_slab);
> >> > +     if (slab_exts) {
> >> > +             unsigned int offs =3D obj_to_index(obj_exts_slab->slab=
_cache,
> >> > +                                              obj_exts_slab, obj_ex=
ts);
> >> > +             /* codetag should be NULL */
> >> > +             WARN_ON(slab_exts[offs].ref.ct);
> >> > +             set_codetag_empty(&slab_exts[offs].ref);
> >> > +     }
> >> > +}
> >> > +
> >> > +#else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> >> > +
> >> > +static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)=
 {}
> >> > +
> >> > +#endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
> >> > +
> >>
> >> I assume with alloc_slab_obj_exts() moved to slub.c, mark_objexts_empt=
y()
> >> could move there too.
> >
> > No, I think mark_objexts_empty() belongs here. This patch introduced
> > the function and uses it. Makes sense to me to keep it all together.
>
> Hi,
>
> here I didn't mean moving between patches, but files. alloc_slab_obj_exts=
()
> in slub.c means all callers of mark_objexts_empty() are in slub.c so it
> doesn't need to be in slab.h

Ah, I see. I misunderstood your comment. Yes, after slab/slob cleanup
this makes sense.

>
> Also same thing with mark_failed_objexts_alloc() and
> handle_failed_objexts_alloc() in patch 34/35.

Ack. Thanks!

>

