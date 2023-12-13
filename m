Return-Path: <cgroups+bounces-928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3880FC0C
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 01:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF1B20B0C
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE320FB;
	Wed, 13 Dec 2023 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BieWfkoS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1620E7
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 00:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6B1C433CC
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426336;
	bh=3F4dsqpRhuQwOEtTQukyRXUSM+s6kv9hJnJvZec4ghk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BieWfkoSn4fzWvNABtWqwni1BeXblwzuk94SWrXYYLRr93rhvnfIHABcCSNhWE8kn
	 ZJDO/pyDy9wX3Hh6UZqpilCgnp2cURvqTG4QWhajKJBIEz5xQtYxUQC6CjvOf2kUYI
	 AHfHkKV4R/VAgccaS86s7P4CY1DBztU23AJ0T6evUmxcZ0q3Eeep2aKE6XwSerpCRb
	 J0KmHWnbpZ/pGQg6Tx5NczchKxfHVCuhycJa96HW8O0I97yXvWNoB5/EDviolRHu7z
	 1tRhYPAGMdQZTTJbB4dyrPCkPs20BchCRGPnqhupLOYFV+g8AEo6QVSGZIew4P5as/
	 mYFJh7uDw/jyg==
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d347b4d676so6717305ad.2
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 16:12:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyQIWnNd0n2xZfJBaqNOJjp35bOq/HnaUsh/rcD4UblA7SN66eS
	Y4e5d2671+oBfNreeiRim5PhwyoFknRdofYs0IzODA==
X-Google-Smtp-Source: AGHT+IGkbsUfD9WhztVNCjlcyZqRmTLHlOxzRjPUbeqATssEHNZVzY+SpfoaeCTLYKZPrGLmgfnkbwehTlMcfLrZTl0=
X-Received: by 2002:a17:902:f549:b0:1d0:708c:d04b with SMTP id
 h9-20020a170902f54900b001d0708cd04bmr8657498plf.31.1702426335471; Tue, 12 Dec
 2023 16:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
 <20231211140419.1298178-2-schatzberg.dan@gmail.com> <CAF8kJuOhwjZZWab1poi1rPiV4u8O1CEZSO0cO23+aewt6S74-g@mail.gmail.com>
 <ZXjUFMwlz3P+4Nmk@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXjUFMwlz3P+4Nmk@dschatzberg-fedora-PF3DHTBV>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 12 Dec 2023 16:12:04 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP3m2gVs+FRXWPKT5JUZ7eExUMS9f9jibgtqA-GObN66A@mail.gmail.com>
Message-ID: <CAF8kJuP3m2gVs+FRXWPKT5JUZ7eExUMS9f9jibgtqA-GObN66A@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, Dec 12, 2023 at 1:43=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> > I am curious what prompted you to develop this patch. I understand
> > what this patch does, just want to know more of your background story
> > why this is needed.
>
> I wrote about this in some detail in the cover letter (0/1). Take a
> look and let me know if the rationale is still unclear.

Ah, found it. I was not CC on the cover letter but CC on the 1/1
patch.  That is why I did not pick up the cover letter.

Yes, the cover letter explanation was great. Exactly what I am looking for.


>
> > Instead of passing -1, maybe we can use mem_cgroup_swappiness(memcg);
> >
>
> Yeah this makes sense, I'll go ahead and make that change and
> eliminate the -1.

Thanks

>
> > >                                 nr_reclaims--;
> > >                         continue;
> > >                 }
> > > @@ -6895,6 +6896,16 @@ static ssize_t memory_oom_group_write(struct k=
ernfs_open_file *of,
> > >         return nbytes;
> > >  }
> > >
> > > +enum {
> > > +       MEMORY_RECLAIM_SWAPPINESS =3D 0,
> > > +       MEMORY_RECLAIM_NULL,
> > > +};
> > > +
> > > +static const match_table_t if_tokens =3D {
> >
> > What this is called "if_tokens"? I am trying to figure out what "if" re=
fers to.
>
> I used the same logic as in "mm: Add nodes=3D arg to memory.reclaim". I
> can just call it tokens.

Thanks. I will take a look at that change.


> > > +
> > > +       old_buf =3D buf;
> > > +       nr_to_reclaim =3D memparse(buf, &buf) / PAGE_SIZE;
> > > +       if (buf =3D=3D old_buf)
> > > +               return -EINVAL;
> > > +
> > > +       buf =3D strstrip(buf);
> > > +
> > > +       while ((start =3D strsep(&buf, " ")) !=3D NULL) {
> > > +               if (!strlen(start))
> > > +                       continue;
> > > +               switch (match_token(start, if_tokens, args)) {
> > > +               case MEMORY_RECLAIM_SWAPPINESS:
> > > +                       if (match_int(&args[0], &swappiness))
> > > +                               return -EINVAL;
> > > +                       if (swappiness < 0 || swappiness > 200)
> >
> > Agree with Yosry on the 200 magic value.
> >
> > I am also wondering if there is an easier way to just parse one
> > keyword. Will using strcmp("swappiness=3D") be a bad idea? I haven't
> > tried it myself though.
>
> As above, "mm: Add nodes=3D arg to memory.reclaim" was previously in the
> mm tree doing it this way, so I duplicated it. I think given that
> there have been lots of discussions about extending this interface,
> this match table has some potential future value and I don't see a
> major downside to using it in favor of strcmp.

Yes, that is totally your call. I am fine as it is. Just the micro
optimization of me trying to see if there is a slimmer way to do it.

Chris

