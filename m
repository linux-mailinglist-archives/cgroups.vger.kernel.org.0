Return-Path: <cgroups+bounces-925-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56080F96A
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE831C20D5D
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90764142;
	Tue, 12 Dec 2023 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iurCXjmM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916765A9E
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 21:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFA5C433AD
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702416759;
	bh=mfEW7Jo7qwzsMBHWmcox+E4i/5RV7VxXJqvDtAte4Y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iurCXjmMTiNWcT6JXNwQ2WjwtRQu0gEcGPsFUjV39XCd8Mq/xT0qR0gFDZmPn2kx4
	 p69HydF5iz89VyCEhjoGRL/3ttSjdVJl2GEE7zoGGN5BWHD0LDKTgyJ+rsSiACKgY4
	 9pFPkOscKtqapzzG9GqUuqJwPy1Di2rjZszdd4ao4X8JI9HT9JsChTUG+iLTMhcI+i
	 7ZmbSejEBVcGEDQ0P81NFJCTmdb2T9q4iantr9pLcyoc6xusyeLCAa72iHAuZCaiyZ
	 l/VBjc36HCU+sDESkHfm6XA3QSeSi/NJuicozbREArV2NmLrTyloTAAeIfOrtXHELT
	 JbmJJ8j3OEukQ==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28ae217726fso28555a91.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:32:39 -0800 (PST)
X-Gm-Message-State: AOJu0Yy4K+IKyOre1M8Og9SPV80XgCmtMZpSdLjA2Uu8OeWXENxnWBl1
	pGkIQ7/RrC/dErKcfjbSDkO4w9KvBl8lRyFVnNgbSg==
X-Google-Smtp-Source: AGHT+IGlVCqZJncPdqqBPXo0+sqvyKBlHQlD1C+GbTv+WgaSKSNQbps5gPlwHn8M31pDWV1qZTMqmVQodyQZH8b40zE=
X-Received: by 2002:a17:90b:fcd:b0:28a:beae:454a with SMTP id
 gd13-20020a17090b0fcd00b0028abeae454amr1348327pjb.25.1702416758683; Tue, 12
 Dec 2023 13:32:38 -0800 (PST)
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
From: Chris Li <chrisl@kernel.org>
Date: Tue, 12 Dec 2023 13:32:27 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO7eM5EJPJaw0eh3r8QZdchjpsLxKE3BQ64Z_U9gXomaA@mail.gmail.com>
Message-ID: <CAF8kJuO7eM5EJPJaw0eh3r8QZdchjpsLxKE3BQ64Z_U9gXomaA@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
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

On Tue, Dec 12, 2023 at 1:27=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
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
>

I think the concern is why 200? Why not 400 or 600?

The user might write bigger values and expect the reclaim to work with
those values.
If there is some hard coded limit enforced somewhere else so writing
more than 200 does not make sense. It would be nice to have those
other places reference this limit as well. Thus give 200 a name and
use it in other places of the code as well.

Chris

