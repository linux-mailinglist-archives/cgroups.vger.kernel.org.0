Return-Path: <cgroups+bounces-1672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E08583B9
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 18:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE1D282383
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A81353EC;
	Fri, 16 Feb 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KimFcXg2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93A1353EB
	for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103495; cv=none; b=c0Y9DTpRhmlJ/N8c9zYcZ6O/2La1/20AQI7eBTOpG3AzKpfV9CiAFmB/OZkEQLICK/dVWW1ChAngE4fAhN4MXR4ZNTJ0FhEzJ6QZisZI9pwD+XQltftJAN8inv7uMnlLNz68s7qZDkmMyypMgU6RNZ5/7UOBuZ7xE9fI8K+0QIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103495; c=relaxed/simple;
	bh=s5/J21l0Vb16qAasTR2af/DM49VlLYJehTHe2iQrZgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVZ3g0pYFkUiXzQjjC895cCnfW2xmJb4tdidpPCdMFz5+C26ndAkkCWvP703MnUklN9ZhQfCaBapZ9NDac+6sozsKyNfo4Sv8dtDOZzyJ6VT1JGsGE2jbt3/51yWx4noCLKYoWlysNZw3fcxdnUdcaXLEOSZaUDZP8GjMAo24Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KimFcXg2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso2305720276.0
        for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 09:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708103493; x=1708708293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuBxuiKdZN3KVCrAhLvxlGbAMwEHkyTmKhPVF6pp06o=;
        b=KimFcXg2C4cCytgZyCIT0srknZMq00HfxE12Dj7bA1s3r381iz6R5sE7SeDFmrk+PT
         O3ONzwrB3pNa92xTGDaKc4VLgfd4T+uY2g+6NUauZXKuFBXxijpyHyxBgiHPwFs4nKO7
         1wmeoDTmLocZTh3Yi4A5ASqiNh0i0uq7fnEbKVhrBqtlA7p+qEFXlFvmk3fM6kf+Af+N
         EfFJ5HkPOYlJYZiVwnyYq5+DmlSpAOSsP8ggJMej4wRkFsQN5zqxOTJ0fMnClmzAKgY+
         fM2z1zn1h821nQ+UL/2bzrskSP585dtzkL4nCTQRjB1BsaTLZdoaI195ty8A6uo+E6Gn
         R/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103493; x=1708708293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuBxuiKdZN3KVCrAhLvxlGbAMwEHkyTmKhPVF6pp06o=;
        b=SDvyPSA9c20P3Mb+wFm7al4UO5vPswzfIo78W7cT62/NWji7aAizlc3vBNJqXktFfT
         Mk92o955G94SpR4vejJuYkgWcfIO9YRzWHq3TMvnS0/a5aCPCBdJ80/HIrIC0a2vH3bQ
         /mVsw7oR8g+QRTWzp8igEgMTC9jGpeCC5SVRw+EPJ2hVRclSIMzv9EbcRzF9RBjp9p4O
         /dcpGd6I1Urv7Ih5GBi3PLSFF9oo8ClT7Aqq9zEbBwtQIjForb7ZVul0MGXBXDVRNOfI
         W9q2yOsC53Sn7dCKmI1mJyeh+dNoq5C90KDd4ZqojulEx9TpTwZMWy0sYKD/p1QL3m98
         jynw==
X-Forwarded-Encrypted: i=1; AJvYcCWIQudGb6lYECWJb3f9LtMXcFQTfnrD6f1o8yw83E0ZHrhp0tLVbRp2UbkRrvXjaPP/R+Wx7wrUbP45tYVoHLOJA9pa1g33/Q==
X-Gm-Message-State: AOJu0YyFgOsivXMzB3EURw5udAWuyAVWjTWN0X5/U+PtmlrxwUYsCwu8
	Sa772h3kh++cBAMtQ2h+HEZqeMSt94LusbtZawm6DVfhPlnUqfL15kFyt/WcfEUifD0zNU+Ln6E
	RjGVxsX2K+eGtMMPs0i73GIQhjNHs3CWGzY+R
X-Google-Smtp-Source: AGHT+IGrTdDphKuPSMMFIAFPJovR9x9JDU4EDFPzTY0y3WFZl7FqMruLomlujQStik0SDQEztF8S9x7Y+PwqmZ025HY=
X-Received: by 2002:a81:8391:0:b0:607:e1c0:450b with SMTP id
 t139-20020a818391000000b00607e1c0450bmr4624095ywf.0.1708103488010; Fri, 16
 Feb 2024 09:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-22-surenb@google.com>
 <ec0f9be2-d544-45a6-b6a9-178872b27bd4@suse.cz> <vjtuo55tzxrezoxz54zav5oxp5djngtyftkgrj2mnimf4wqq6a@hedzv4xlrgv7>
In-Reply-To: <vjtuo55tzxrezoxz54zav5oxp5djngtyftkgrj2mnimf4wqq6a@hedzv4xlrgv7>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 09:11:17 -0800
Message-ID: <CAJuCfpEsoC_hkhwOU8dNSe5HCFX-xiKsVivqyXbVmuEE-_F2ow@mail.gmail.com>
Subject: Re: [PATCH v3 21/35] mm/slab: add allocation accounting into slab
 allocation and free paths
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, mhocko@suse.com, 
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

On Fri, Feb 16, 2024 at 8:39=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Feb 16, 2024 at 05:31:11PM +0100, Vlastimil Babka wrote:
> > On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > > Account slab allocations using codetag reference embedded into slabob=
j_ext.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  mm/slab.h | 26 ++++++++++++++++++++++++++
> > >  mm/slub.c |  5 +++++
> > >  2 files changed, 31 insertions(+)
> > >
> > > diff --git a/mm/slab.h b/mm/slab.h
> > > index 224a4b2305fb..c4bd0d5348cb 100644
> > > --- a/mm/slab.h
> > > +++ b/mm/slab.h
> > > @@ -629,6 +629,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s,=
 gfp_t flags, void *p)
> > >
> > >  #endif /* CONFIG_SLAB_OBJ_EXT */
> > >
> > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > +
> > > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s=
, struct slab *slab,
> > > +                                   void **p, int objects)
> > > +{
> > > +   struct slabobj_ext *obj_exts;
> > > +   int i;
> > > +
> > > +   obj_exts =3D slab_obj_exts(slab);
> > > +   if (!obj_exts)
> > > +           return;
> > > +
> > > +   for (i =3D 0; i < objects; i++) {
> > > +           unsigned int off =3D obj_to_index(s, slab, p[i]);
> > > +
> > > +           alloc_tag_sub(&obj_exts[off].ref, s->size);
> > > +   }
> > > +}
> > > +
> > > +#else
> > > +
> > > +static inline void alloc_tagging_slab_free_hook(struct kmem_cache *s=
, struct slab *slab,
> > > +                                   void **p, int objects) {}
> > > +
> > > +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> >
> > You don't actually use the alloc_tagging_slab_free_hook() anywhere? I s=
ee
> > it's in the next patch, but logically should belong to this one.
>
> I don't think it makes any sense to quibble about introducing something
> in one patch that's not used until the next patch; often times, it's
> just easier to review that way.

Yeah, there were several cases where I was debating with myself which
way to split a patch (same was, as you noticed, with
prepare_slab_obj_exts_hook()). Since we already moved
prepare_slab_obj_exts_hook(), alloc_tagging_slab_free_hook() will
probably move into the same patch. I'll go over the results once more
to see if the new split makes more sense, if not will keep it here.
Thanks!

