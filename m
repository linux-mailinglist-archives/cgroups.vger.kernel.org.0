Return-Path: <cgroups+bounces-2799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF5C8BD38E
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 19:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704F51C22974
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595B156F5D;
	Mon,  6 May 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE+kzatp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92790156F43
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014956; cv=none; b=EcvcrbEU2YshkrE1pBKYLalFLh3EQ5ij+TqFFaSN9046ipZDBluneJY1SEE3/mkTFbdLbuujbTPPjFZuZTfTScMxe2ccS0kLVefkHd3pmisFC0aWC/+4Pl/CulEqIoCM58nGSo3mzQdaD8pKiuKjgGOqSRAW0xcTyceUk9DKEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014956; c=relaxed/simple;
	bh=NdjHAsSBpWstZn/HYUpuRlnDtObWLi+ESwC8JAudwV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkSzCQ9gPj3iLX0794zh6ny58+YIMA1Ia4Y33TmwsGhxJzNnOWgapI/++zYYwAFI7hxALdnCbSLgugyTkIk4MGz3TIQOUqtn3wHm+/k0/KdyftzBwc9iC3AgrEqHTyjOE7gOiA4Yk04M4WqURlU4Kh1iSh/R+eq2XWD7eQ7/2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE+kzatp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c0a6415fso413063266b.1
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715014953; x=1715619753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHUuIg1EPJOixoiveJwfsUUpdyu5w7k323oGfOqRFbU=;
        b=qE+kzatpczyu0XYqDAVvStb2aTPG03FUwuQsF8OA/AIb0JBRmuqE1Pfz1T/L262ONG
         Kq0ZrXjjgd+fpR+17qEUhOVO/vAaymEWoMzZxpmUTYwBFvh0vrMs+C4vk9+tU9Um06Mi
         66HmafxcAV1l8/SVgY74oyDt9KTbODDKtGnxiz4BYVp9pmJokifVrLPgngmCxs07zs5m
         Oyoyw1n035302/AUlxmMP7tU9aO4e05wAyGx1z1iD6Ec9IoI+RCSoDd5IdokDCDKR7Me
         DmZIzSHcptW1THLbprof1hDL9j/pXTF5mg5xxOD+GCKU4MTJupdebiFfbOsX6TnWhlKu
         SnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014953; x=1715619753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHUuIg1EPJOixoiveJwfsUUpdyu5w7k323oGfOqRFbU=;
        b=INcP3ToXO76fEWwV/6njAgl1hwphNcrnUBazgpA2CNK22tNvtGfGAC/0n3WQBuJMNd
         /Cmr87rzUubhDVLbskRByK5O9sDTVdYB28qCoc9ipP90I3Zmxq4MPSudTBTM1Y/2IyBR
         1YvXZZcS1F5sFH0oULFwXOCqxJvwjyuHnZIwidPOFXbhDzYApm+YrCJWi3hxuAo+Z238
         PGiZf5YObX5Os07d3+H4XGsUrr9uO/9emyNOrBBnVhAdmdgoLD+qGTzodZYeyXQjILXA
         QauEcbIYkR7dP0jgW1P2nyebDJf9ifnKY63jLXT3dn0o2bbRCnzsZ9X/uMpc/TBL22TO
         Jglw==
X-Forwarded-Encrypted: i=1; AJvYcCUA/3OiMhDVu7D46Thu+4fjV//N9R3oPLdSBBGmFX+HkVmtef9ediA7D/M5uWqxPp5pMmg84qyrJj866k8fmxyK9HnOLc9fFw==
X-Gm-Message-State: AOJu0YwW4rleW+KuSGjjp9BQ/vn00J5UU8y6BAsHhfXSCE6ejHowgOvp
	7Ga81jqdO0ce7ZgUYIZMe0LudKhu+icyeE2vEcEb8ceCXsIsnoCkdXGdb0gOfQ3lvpzUcVgvplv
	5Lo/aq1ocKpXiXq7g0g9lnw2H2U/35R4Z09pR
X-Google-Smtp-Source: AGHT+IEIInvjyGer8PqSYIUNJ70IvWgRV34lzO8tdHFMlQ1h1nswMVPYZHYBJMaY/e0gKepTU0c+ycHOnV3VjwTmTCY=
X-Received: by 2002:a17:906:3446:b0:a59:c52b:993d with SMTP id
 d6-20020a170906344600b00a59c52b993dmr2629241ejb.20.1715014952709; Mon, 06 May
 2024 10:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506170024.202111-1-yosryahmed@google.com>
In-Reply-To: <20240506170024.202111-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 May 2024 10:01:54 -0700
Message-ID: <CAJD7tkbmtmmnnNLaEC4dzUaYjV7d-SPgfphXdByAdBPi3XuatQ@mail.gmail.com>
Subject: Re: [PATCH] mm: do not update memcg stats for NR_{FILE/SHMEM}_PMDMAPPED
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:00=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
> NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
> __mod_node_page_state() instead, which updates the global per-node stats
> only.
>
> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.=
com
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/rmap.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12be4241474ab..c2cfb750d2535 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_rmap=
(struct folio *folio,
>                 struct page *page, int nr_pages, struct vm_area_struct *v=
ma,
>                 enum rmap_level level)
>  {
> +       pg_data_t *pgdat =3D folio_pgdat(folio);
>         int nr, nr_pmdmapped =3D 0;
>
>         VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>
>         nr =3D __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapp=
ed);
>         if (nr_pmdmapped)
> -               __lruvec_stat_mod_folio(folio, folio_test_swapbacked(foli=
o) ?
> +               __mod_node_page_state(pgdat, folio_test_swapbacked(folio)=
 ?
>                         NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmap=
ped);
>         if (nr)
>                 __lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
> @@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                 enum rmap_level level)
>  {
>         atomic_t *mapped =3D &folio->_nr_pages_mapped;
> +       pg_data_t *pgdat =3D folio_pgdat(folio);
>         int last, nr =3D 0, nr_pmdmapped =3D 0;
>         bool partially_mapped =3D false;
>         enum node_stat_item idx;
> @@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
>         }
>
>         if (nr_pmdmapped) {
> +               /* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg=
 */
>                 if (folio_test_anon(folio))
> -                       idx =3D NR_ANON_THPS;
> -               else if (folio_test_swapbacked(folio))
> -                       idx =3D NR_SHMEM_PMDMAPPED;
> +                       __lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_=
pmdmapped);
>                 else
> -                       idx =3D NR_FILE_PMDMAPPED;
> -               __lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
> +                       __mod_node_page_state(pgdat,
> +                                       folio_test_swapbacked(folio) ?
> +                                       NR_SHMEM_PMDMAPPED : NR_FILE_PMDM=
APPED,
> +                                       nr_pmdmapped);

..and of course right after I press send I realized this should be
-nr_pmdmapped.

>         }
>         if (nr) {
>                 idx =3D folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE=
_MAPPED;
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

