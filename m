Return-Path: <cgroups+bounces-1290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C878446B0
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A1328C8FF
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CF12DDBB;
	Wed, 31 Jan 2024 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBkMEFZP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595F12FF6F
	for <cgroups@vger.kernel.org>; Wed, 31 Jan 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724102; cv=none; b=srxRfJGDgm1RTt7Udeck6p0DpqztNKbAHBa8psW2CEfztA5RMfh2kTESJ5z3r5gxuL/n0m9PriUrBCIEqce+XwyvVsxR5oB/rajY8RNq+ZorN4742lFBtRfe1QhmBi3cAHA+qRSwV1UKeLa/6NtHKpU9Zphth5eR1ECZNw1j6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724102; c=relaxed/simple;
	bh=dw1Oip4wRjgWUJ+FAPu4sBruNGGxhiV3wiraGZMOsts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPWA0VvMIUIe/AN+8lMRlBPVY6eh4gpMFKNwOq2OxZM1xuw322PaXvHbRjTdsT78UoPel4pYKySEEXKbj1ajuCcO29fihqYYPvSZwbexzn3O+YcWhhXv75Ok8Tw+R4bjgdzADv6UXVXXd3s857Als9FDgoax6r7MuRzL3h3O+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBkMEFZP; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bd5c4cffefso68863b6e.1
        for <cgroups@vger.kernel.org>; Wed, 31 Jan 2024 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706724100; x=1707328900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWmR64VE/smMIa7JDm7Z3BdAsseThN2dj0ieIZ3vXbg=;
        b=KBkMEFZP/HO6DdwaQualeBvsfQHlLrkggRJthYx9SUX+MvTAT9pZTHPH6COKABfQvG
         kISgOzeLliFsdh6mlqP0caj56UBHruI+kEOUGvwXOoQRbKW1ezZ859YAJS/MY1P0Blw1
         7QnmoFegsnUZzaZC9RMyKboFya9TIAE3C9rVaOanM0tLXVKOTX/fWin8iZrWENGn+dKw
         ILUyvS93urs3EsEAYCMVSPjeBPbToJ6oXhEZaeSA0Ll+msh8/msFE14GwAsNY5JavXC4
         Ytok+YEnGaow6WQhCbtv2ejjxAdhbeO5TWqvB64FP7v55tCkF8OgWxEjuCYNrvuCmrsq
         s/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724100; x=1707328900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWmR64VE/smMIa7JDm7Z3BdAsseThN2dj0ieIZ3vXbg=;
        b=wDhnYP5sPjYd0WGuiJkyAYlTJk9Z25Pa/+yHJqsZKz29D+MLrGTSxlY5rzMon+WXpv
         GrPI5AU6hZOWfmbLzZsLip/shaDiMDhk68e/jCfXaYVIstiIOQ/tI6UagzGvjc27hEvS
         qlDugHO8HdILk0hYVG1OApZsgcd7J6A1SDtTy29kJ+JhIAi/UeBLX3FzAtG7Z8MKLMU/
         G/pRyof1SqnLZKJn6FMZPckV32ge1bVKaK/cfg5lBWGa3tBBXN8MpSyxXXPMUbBhtuKG
         KRCQtTjvdwCRvpyTpArPjKkpGgxTtgWMSpNn1u31S4h5eKhwG86gnu777fTYYwgQ+a4I
         lWoA==
X-Gm-Message-State: AOJu0YznyDlGVN9Ms937B3EuK52EUIwvMH6Mx5UMihl5No4RtnSdHFAO
	ZEARNIz0qv8LTcnN/OXDCUsbf4cqSM8NG2UBVGiXYM0bpM6G5kTAnCNK+ZnGJ6tlgOmph2Q0KqB
	l6gJjrgKzWVjf77BZ1gDgmWdt+sIOjc9pPvYE
X-Google-Smtp-Source: AGHT+IGtHgEj8tA6DKcs4XLUjgq1qppyqHJDhhSHFflfn5xowdZDCma3tgxFRdeRXZw280nYsPg3hG3q94c3E1S24sU=
X-Received: by 2002:a54:4187:0:b0:3be:c69f:ec08 with SMTP id
 7-20020a544187000000b003bec69fec08mr1500145oiy.59.1706724099702; Wed, 31 Jan
 2024 10:01:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131162442.3487473-1-tjmercier@google.com> <20240131175059.GC1227330@cmpxchg.org>
In-Reply-To: <20240131175059.GC1227330@cmpxchg.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 31 Jan 2024 10:01:27 -0800
Message-ID: <CABdmKX2WRQyBpDaV0CuL4E0OdR9FEff5NAZ0hFv8W8U7e82=UA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:51=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jan 31, 2024 at 04:24:41PM +0000, T.J. Mercier wrote:
> > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> > reclaim") we passed the number of pages for the reclaim request directl=
y
> > to try_to_free_mem_cgroup_pages, which could lead to significant
> > overreclaim in order to achieve fairness. After 0388536ac291 the number
> > of pages was limited to a maxmimum of 32 (SWAP_CLUSTER_MAX) to reduce
> > the amount of overreclaim. However such a small chunk size caused a
> > regression in reclaim performance due to many more reclaim start/stop
> > cycles inside memory_reclaim.
> >
> > Instead of limiting reclaim chunk size to the SWAP_CLUSTER_MAX constant=
,
> > adjust the chunk size proportionally with number of pages left to
> > reclaim. This allows for higher reclaim efficiency with large chunk
> > sizes during the beginning of memory_reclaim, and reduces the amount of
> > potential overreclaim by using small chunk sizes as the total reclaim
> > amount is approached. Using 1/4 of the amount left to reclaim as the
> > chunk size gives a good compromise between reclaim performance and
> > overreclaim:
> >
> > root - full reclaim       pages/sec   time (sec)
> > pre-0388536ac291      :    68047        10.46
> > post-0388536ac291     :    13742        inf
> > (reclaim-reclaimed)/4 :    67352        10.51
> >
> > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> > pre-0388536ac291      :    258822       1.12            107.8
> > post-0388536ac291     :    105174       2.49            3.5
> > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> >
> > /uid_0 - full reclaim     pages/sec   time (sec)
> > pre-0388536ac291      :    72334        7.09
> > post-0388536ac291     :    38105        14.45
> > (reclaim-reclaimed)/4 :    72914        6.96
> >
> > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactiv=
e reclaim")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  mm/memcontrol.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 46d8d02114cf..d68fb89eadd2 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6977,7 +6977,8 @@ static ssize_t memory_reclaim(struct kernfs_open_=
file *of, char *buf,
> >                       lru_add_drain_all();
> >
> >               reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > -                                     min(nr_to_reclaim - nr_reclaimed,=
 SWAP_CLUSTER_MAX),
> > +                                     max((nr_to_reclaim - nr_reclaimed=
) / 4,
> > +                                         (nr_to_reclaim - nr_reclaimed=
) % 4),
>
> I don't see why the % 4 is needed. It only kicks in when the delta
> drops below 4, but try_to_free_mem_cgroup_pages() already has
>
>                 .nr_to_reclaim =3D max(nr_pages, SWAP_CLUSTER_MAX),
>
> so it looks like dead code.

That right, it's only there for when the integer division reaches
zero. I didn't want to assume anything about the implementation of
try_to_free_mem_cgroup_pages, but I can just remove it entirely if
you'd like.

