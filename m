Return-Path: <cgroups+bounces-1613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49468569ED
	for <lists+cgroups@lfdr.de>; Thu, 15 Feb 2024 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB49283EDB
	for <lists+cgroups@lfdr.de>; Thu, 15 Feb 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54C13666E;
	Thu, 15 Feb 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnbnGvf6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B5135A7D
	for <cgroups@vger.kernel.org>; Thu, 15 Feb 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015696; cv=none; b=VmxfdhRjzp4Jps85mCQ5PJ+m71TMR/Jp+GcyWLnzmH0/yreLKttcQ21510WSgtlOjWFP9JL8NOUELLQXWjjezFvPqopeQ+YkJs2r4uo3AstKVpLh0KmwA3GNJtGiy1m9EK2AIs+ruVgEYRHS9rACNBGPoYPhS+x3Io9Ucz05DI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015696; c=relaxed/simple;
	bh=9TO9rM05PYsgFPIWymZY990BiwuTMGTPoVWKOTW/5Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTp0r1K/Ykixb4Plw6zvH+7tEQOUaDM/hC6Vt8erMlcP5HViGoVfGpy+OWPnlqsYYGUx1Q8iLlI7VnXYmebUNr8TCiFCdRvrXqC1nzfDfweD3h2nIGqzuDmESgX/vCow+WYBwdp2lZEVuBnL5a5U4+mDOi7V4X7vj2DpqKLAJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EnbnGvf6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-607eefeea90so1783737b3.1
        for <cgroups@vger.kernel.org>; Thu, 15 Feb 2024 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708015693; x=1708620493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tI+hCE30y1jp9jG4DD8d4tpJXQ3JxVVysbuWcCVNic=;
        b=EnbnGvf6qBn9DluDjUFMBAug9LH7ehPIMjVzChKOmKVWGkO63uM5+P3eGmEMu3I2+w
         hYuNs6tQjTBwhzzn++VcATWdzg+9YbCpgJZ5rvZDxB8pBCpF2KUAWXuOvFK83srCGZMz
         6IbiUFFa6jk6vPBIZUSJnbtJpTUTpXNCogIDyhOeoOxNLuNIXM1CLL2MGzJhuM/BbA/E
         +N+WDdBEqgqmMStAyx5IPIuVotUpX9veTsI3Uc+uYFEZrQxAKLLI/BYMjSsgmXrO5zM9
         9l93uMw5tho6Dc3A/WLlne58nbwFGCC6PVVUqrfcZqfgHbYIy8bc9hIx4CMUp9G9l1xm
         pzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015693; x=1708620493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tI+hCE30y1jp9jG4DD8d4tpJXQ3JxVVysbuWcCVNic=;
        b=C2rodSyQtykhotyfpIt7SUYqWGg503ZsxEhQOPJuamzIe7lG4i9zY6ld6998BtdhN3
         9aj0pVaTWeXCNA2zSr85Rv8E4PSSzrW8FsbSU+3lh2ywbLhhqBQgYhn1Nsjw8+JOLQiQ
         xkH0djweifGCOed3sFXYCtjrWzCr4LW0sV8NG62hq5/yL0eMEDkBhfRk46vGog7rF3tV
         Qd3gXOvjOl9vNVNYE4iJ3m487GTDyMO8EW4PLMJv3n06hdw+u5BnV/cLWeeYGBAlVe4A
         OS0LQjmXYM6i37qGm4h2bDeAYxx2K2TWe7q0hGzrVU81YXUTXXus+0hZFUTRwgbA7/hR
         q47w==
X-Forwarded-Encrypted: i=1; AJvYcCVb2JsVQ7y5HUoz8P5LZx39v19DYWqHgbNCK1pnUfdXMRPcUkEIlVhnin/+ED8oT0KvsxprJOxAkoF+yxS1XKzogy1duoAFRw==
X-Gm-Message-State: AOJu0YxjQyFa53XxScecGzowRIx9hLo3TaEnpFrhtVTQ5ZxsW4ekQDh4
	lDmESHbWyYeYqxRD+/br2ung+dwSoitbaXmnihxNgCoc9rMIObHo4fpTP5ULrdZPjKY5Oi2d3Oq
	n4jTev/ElVhHFFJMA+4YWR8IgF3ZFc071VqC6
X-Google-Smtp-Source: AGHT+IEpKo2L6oplIyxSXpvbYHFzpW3S2D2HSJYFHw3+xQqVKIR17Ywy1D0gSKm8xVOUSCj/xezJ/KNnf15e7J0VTMo=
X-Received: by 2002:a0d:e284:0:b0:607:77bd:711 with SMTP id
 l126-20020a0de284000000b0060777bd0711mr1808635ywe.11.1708015692595; Thu, 15
 Feb 2024 08:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-32-surenb@google.com>
 <Zc3X8XlnrZmh2mgN@tiehlicka> <CAJuCfpHc2ee_V6SGAc_31O_ikjGGNivhdSG+2XNcc9vVmzO-9g@mail.gmail.com>
 <Zc4_i_ED6qjGDmhR@tiehlicka>
In-Reply-To: <Zc4_i_ED6qjGDmhR@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Feb 2024 08:47:59 -0800
Message-ID: <CAJuCfpHq3N0h6dGieHxD6Au+qs=iKAifFrHAMxTsHTcDrOwSQA@mail.gmail.com>
Subject: Re: [PATCH v3 31/35] lib: add memory allocations report in show_mem()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
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

On Thu, Feb 15, 2024 at 8:45=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 15-02-24 06:58:42, Suren Baghdasaryan wrote:
> > On Thu, Feb 15, 2024 at 1:22=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 12-02-24 13:39:17, Suren Baghdasaryan wrote:
> > > [...]
> > > > @@ -423,4 +424,18 @@ void __show_mem(unsigned int filter, nodemask_=
t *nodemask, int max_zone_idx)
> > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > >       printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poison=
ed_pages));
> > > >  #endif
> > > > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > +     {
> > > > +             struct seq_buf s;
> > > > +             char *buf =3D kmalloc(4096, GFP_ATOMIC);
> > > > +
> > > > +             if (buf) {
> > > > +                     printk("Memory allocations:\n");
> > > > +                     seq_buf_init(&s, buf, 4096);
> > > > +                     alloc_tags_show_mem_report(&s);
> > > > +                     printk("%s", buf);
> > > > +                     kfree(buf);
> > > > +             }
> > > > +     }
> > > > +#endif
> > >
> > > I am pretty sure I have already objected to this. Memory allocations =
in
> > > the oom path are simply no go unless there is absolutely no other way
> > > around that. In this case the buffer could be preallocated.
> >
> > Good point. We will change this to a smaller buffer allocated on the
> > stack and will print records one-by-one. Thanks!
>
> __show_mem could be called with a very deep call chains. A single
> pre-allocated buffer should just do ok.

Ack. Will do.

>
> --
> Michal Hocko
> SUSE Labs

