Return-Path: <cgroups+bounces-924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5707A80F969
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDFAEB20E9E
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC1C64141;
	Tue, 12 Dec 2023 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSMeK58c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314BB3
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:32:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1e83adfe72so577359866b.1
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702416747; x=1703021547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STJ8s+1ZgorKbcpwDfrOVd1KChXP1BeRsHF4DNQJ/gw=;
        b=hSMeK58c792RnmYoJ8J2F1F9xGI3KyC+D4HUfiUyNaCRh/lgkMyvpNNTc/Qls6Soni
         lgxPubAcVOoUijFpSyhto6Rr6bNxBwx826swYgSlJfhGIfwOq1yOPN4AHmCVrS0LoXln
         hI225BSygKIp7ITrmAAT5zIkfz/lHRA76duyP3cSHBfnsy8AXoX8eGTogEEfijUZ5rmK
         OJyOUC+/O0OKLpjG9y34epF4XnlX8yytLeciTUBGADI3kGePSTWdeEJZr2W+qIkJFj+d
         vA9y2GjnfuYDEr8sSqofxqgXlN25km2FaiYffPgjTc/HG9yqFJMye6+co4oT9p7Tbo1j
         8dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416747; x=1703021547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STJ8s+1ZgorKbcpwDfrOVd1KChXP1BeRsHF4DNQJ/gw=;
        b=nACxVTNNwc513KbL/BpFuCXyj84HS1w+VX8anZFrBcVaLkJx8zF+M/nnnM+QBETqoS
         KgvA4Z4iEIQ4N5s08o44KqASdWPxyHI+TPhRZ69ttPCaB1KW9xREOQd6ShvbBvTAS/GU
         f5Z9o1dwqkTJQBiqErZrzdLIru/0G8I9djYszf0EL7GVsa6hdLA3kFvKxDEDq9BZ3T4P
         aD+1iwCdQGU8+FRRuwKa8rXaZzh2A6mLPeJECfzZU5+rGBjQhYojuRvFwJ9kcjDKeEqA
         kru7MOrl9cm4dXky7VFKumBms+b1BDmZFSmvZTg+OwA6YvAt4odXW0rZ3Oh8wR2Jslnp
         7VSw==
X-Gm-Message-State: AOJu0Yy9qbcIqqp6QC1HzDfRmUWH6HvZvf2qBUCUhimipQcbaAJy/j/S
	JcKVvwWrdpC3hP+9HDkVmyKE0CRgNPI2CXG/FBjQYA==
X-Google-Smtp-Source: AGHT+IH0fVR2m3wicfc1ELe6nAiJDzi+m6wO1H72mGA0fKcCQZvoNdz/jyd5VQOICC3W8TgaUHAOGDtzkrg1CHbJ1SM=
X-Received: by 2002:a17:906:f112:b0:9e5:2c35:50e9 with SMTP id
 gv18-20020a170906f11200b009e52c3550e9mr2896390ejb.77.1702416746431; Tue, 12
 Dec 2023 13:32:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com>
 <20231211140419.1298178-2-schatzberg.dan@gmail.com> <CAJD7tkZQ2aakT8M2bTg0bp4sDtrGYv_4i4Z4z3KBerfxZ9qFWA@mail.gmail.com>
 <ZXjQLXJViHX7kMnV@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXjQLXJViHX7kMnV@dschatzberg-fedora-PF3DHTBV>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Dec 2023 13:31:46 -0800
Message-ID: <CAJD7tkY6iTxKe4Nj00sN3vh26Cw2Sw+kTkY40r000+ttN-dFpg@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 1:27=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Mon, Dec 11, 2023 at 11:41:24AM -0800, Yosry Ahmed wrote:
> > On Mon, Dec 11, 2023 at 6:04=E2=80=AFAM Dan Schatzberg <schatzberg.dan@=
gmail.com> wrote:
> >
> > contains* the*
> >
> > I think this statement was only important because no keys were
> > supported, so I think we can remove it completely and rely on
> > documenting the supported keys below like other interfaces, see my
> > next comment.
> >
> > > +       to reclaim.
> > >
> > >         Example::
> > >
> > > @@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
> > >         This means that the networking layer will not adapt based on
> > >         reclaim induced by memory.reclaim.
> > >
> > > +       This file also allows the user to specify the swappiness valu=
e
> > > +       to be used for the reclaim. For example:
> > > +
> > > +         echo "1G swappiness=3D60" > memory.reclaim
> > > +
> > > +       The above instructs the kernel to perform the reclaim with
> > > +       a swappiness value of 60. Note that this has the same semanti=
cs
> > > +       as the vm.swappiness sysctl - it sets the relative IO cost of
> > > +       reclaiming anon vs file memory but does not allow for reclaim=
ing
> > > +       specific amounts of anon or file memory.
> > > +
> >
> > Can we instead follow the same format used by other nested-keyed files
> > (e.g. io.max)? This usually involves a table of supported keys and
> > such.
>
> Thanks, both are good suggestions. Will address these.
>
> > > +       while ((start =3D strsep(&buf, " ")) !=3D NULL) {
> > > +               if (!strlen(start))
> > > +                       continue;
> > > +               switch (match_token(start, if_tokens, args)) {
> > > +               case MEMORY_RECLAIM_SWAPPINESS:
> > > +                       if (match_int(&args[0], &swappiness))
> > > +                               return -EINVAL;
> > > +                       if (swappiness < 0 || swappiness > 200)
> >
> > I am not a fan of extending the hardcoded 0 and 200 values, and now
> > the new -1 value. Maybe it's time to create constants for the min and
> > max swappiness values instead of hardcoding them everywhere? This can
> > be a separate preparatory patch. Then, -1 (or any invalid value) can
> > also be added as a constant with a useful name, instead of passing -1
> > to all other callers.
> >
> > This should make the code a little bit more readable and easier to exte=
nd.
>
> I'm not sure I understand the concern. This check just validates that
> the swappiness value inputted is between 0 and 200 (inclusive)
> otherwise the interface returns -EINVAL. Are you just concerned that
> these constants are not named explicitly so they can be reused
> elsewhere in the code?

Yes. The 0 and 200 values are already hardcoded in multiple places,
and we are adding more places now and more hardcoded values (i.e. -1).

