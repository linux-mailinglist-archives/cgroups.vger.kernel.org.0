Return-Path: <cgroups+bounces-6855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC0A540F7
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 04:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A7C188E06C
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955918DB2A;
	Thu,  6 Mar 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLhse0Dc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358EF11713;
	Thu,  6 Mar 2025 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230280; cv=none; b=ZtG1wWi07Trqa5JdPfzRUOIEl3cFZDyy2b/MEZdv2Ec1Wf4hT8EWr+/FHjuqR7M0Jepwz3r/xLjRmEA7xKMoMlkZAv9qlucG3yxEgeMDFActRqQjBTCN4CkH//17rEn7qNs6A9L1DlW1ZwlrnFyELK+dxySe031+SFKaZfXjzFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230280; c=relaxed/simple;
	bh=N4mBheWqh6kAg026mOO7Fk8R9XdS3A/sI7+NNljxvok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiIAblnhBcovkH+NONpWY3W0rrzKUorLvlDKQTUQZst5RhZQteEiu108kvamtpW6EqMBwM617GKKEPVWCRpHVFJZ27N22sx3WjO94Ru7hzV55uevCenpjrk4JGn2+e/543CxhLPLZfhyJlDNbRtfD9nrub1dOKEAtRnC4hBHzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLhse0Dc; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ce87d31480so684795ab.2;
        Wed, 05 Mar 2025 19:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741230278; x=1741835078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTPHjQ6rOvRQ5e3N9KhKF5WRS1IcdBRxGAtFt0rhx/4=;
        b=lLhse0DcgY9MK+/JMvY34rR+yQ5VKNzhXPj1DTO0XEcuf1pR1g+WtVPL2kOAle7yRk
         AOpmbuAQXvWootQSXLxMoOinWdCGZal4IYbJqme1wSPmqe4P9mjJa77edvF+671nAyOQ
         rrCStyE5B2Nc7PPU/pbRO0JNNz+ONJ8CVEC1NE9qxEFcUxl1XXDkcXb9AvSXZIM9qkuV
         YhsPzZGk2Tb29m6uMSEQgitfvb1LxCzi3HZUFNi4k5dqHXeXMYEzxVvr1/rr19kCuJDa
         ufqwnR9TdXAVDQv4GjdTeIKn5WA2jCppldKi6rd0CKlT0WLX1vtUsv8kElLrTaeNIL9Q
         o4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230278; x=1741835078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTPHjQ6rOvRQ5e3N9KhKF5WRS1IcdBRxGAtFt0rhx/4=;
        b=Ts+dB4Gn8WCaVC91E7sAGjKpeHy9zWZz+F7Tz/1CpqYB+LbMi8/aFWSGfj69xD81dh
         eN/dkx+dHJGsdeTd1OFeUQhZ5mX1aTGOWvYRgikGkpfJ33sWyf2ojr4YhwgwtRQcn/E+
         M66+TP+0o+IK8mh1m7VutAMUlZNfZ7zdPiYxnjbT2V9f89qjj0YNpAbdJbcDgB2VwI4z
         GDkWbgUwcEstUaBVWc5VqUFBqY9SOhHZ1B7myv3BYLxTUOfWFrFNN13weyFHGsw6ojl7
         3u3O20LwERSZyAByRDREOR8OrTe/OzvAxX1AmKhYEY0REzhuKGINFRcPVl4Hb6oxmpb9
         m2tw==
X-Forwarded-Encrypted: i=1; AJvYcCUNMTpdHXhNloydu3s9Cngh5kYvTuq1h+M2P8Bg/mL/6VjD9RmmqLx6P5dRxAv12YHvxJ2N3nLi@vger.kernel.org, AJvYcCUcN3Oh6Z9rLOWv1/2ALOuF+HINEooP/aV4SYpp9bQgtjA14J2A4ezafASwgCArUD5phwu4pKDaJLy95ulo@vger.kernel.org, AJvYcCVYsyMW0h6J3yqC++Pn6I175EvnRek0UXQyt9dqoWy9Sb/joMBETHK9UBplmFjY1TdL6Va+iKiW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Dr9SYOttzaTReq4WsBRRqIZDxfSAb4c1irsBa40asH4oCI1L
	gJF3ybfwYhisFzxKtpThadnVSSHPQEr8QaE43XMgzQO/yAofF9V+992pPfAnl/YFCu+GpsuuOzC
	eO9t4T2hm3NRSt6vmYd4gYvcAy1s=
X-Gm-Gg: ASbGncsnxjQjDqna5f2zpqLiNk0h6MHNyOD92vctOR8MZQbItdLd2Di1dA7Bl0t/5An
	W9QwtU0yJa493yH5vVVx0RaPpFbC7XUQCyfy2yeW6IAte1mJKiqP4W/7i+53QYZOrwAFUJwylRM
	xirn3Poprybh8+Ne5KzdVLb/+AgA==
X-Google-Smtp-Source: AGHT+IH89Mf6uZW7zjqo37+0Io0+nUfpejpIczRhLGghrBlP2RlfzIQi3LmPucbaOaoUZehmx8fIZ7dKtXzt26eVxto=
X-Received: by 2002:a05:6e02:20e1:b0:3d3:fdcc:8fb8 with SMTP id
 e9e14a558f8ab-3d42b8a703fmr55085455ab.10.1741230278206; Wed, 05 Mar 2025
 19:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306023133.44838-1-songmuchun@bytedance.com> <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>
In-Reply-To: <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 6 Mar 2025 11:04:20 +0800
X-Gm-Features: AQ5f1JqlzzBmoVJPCwzzjxlr6WNIti1gz7UAYuLUOM8w67kVdbaEmjLyT5pOa1E
Message-ID: <CAMgjq7AgMFn2CzSxppZb_sSgksmHbmvR4RXzfnWjL3ZYsoQ7ew@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:54=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Mar 6, 2025 at 10:32=E2=80=AFAM Muchun Song <songmuchun@bytedance=
.com> wrote:
> >
> > The commit 6769183166b3 has removed the parameter of id from
> > swap_cgroup_record() and get the memcg id from
> > mem_cgroup_id(folio_memcg(folio)). However, the caller of it
> > may update a different memcg's counter instead of
> > folio_memcg(folio). E.g. in the caller of mem_cgroup_swapout(),
> > @swap_memcg could be different with @memcg and update the counter
> > of @swap_memcg, but swap_cgroup_record() records the wrong memcg's
> > ID. When it is uncharged from __mem_cgroup_uncharge_swap(), the
> > swap counter will leak since the wrong recorded ID. Fix it by
> > bring the parameter of id back.
> >
> > Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording an=
d clearing")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/swap_cgroup.h | 4 ++--
> >  mm/memcontrol.c             | 4 ++--
> >  mm/swap_cgroup.c            | 7 ++++---
> >  3 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
> > index b5ec038069dab..91cdf12190a03 100644
> > --- a/include/linux/swap_cgroup.h
> > +++ b/include/linux/swap_cgroup.h
> > @@ -6,7 +6,7 @@
> >
> >  #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
> >
> > -extern void swap_cgroup_record(struct folio *folio, swp_entry_t ent);
> > +extern void swap_cgroup_record(struct folio *folio, unsigned short id,=
 swp_entry_t ent);
> >  extern unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int =
nr_ents);
> >  extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
> >  extern int swap_cgroup_swapon(int type, unsigned long max_pages);
> > @@ -15,7 +15,7 @@ extern void swap_cgroup_swapoff(int type);
> >  #else
> >
> >  static inline
> > -void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
> > +void swap_cgroup_record(struct folio *folio, unsigned short id, swp_en=
try_t ent)
> >  {
> >  }
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a5d870fbb4321..a5ab603806fbb 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4988,7 +4988,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_=
entry_t entry)
> >                 mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
> >         mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
> >
> > -       swap_cgroup_record(folio, entry);
> > +       swap_cgroup_record(folio, mem_cgroup_id(swap_memcg), entry);
> >
> >         folio_unqueue_deferred_split(folio);
> >         folio->memcg_data =3D 0;
> > @@ -5050,7 +5050,7 @@ int __mem_cgroup_try_charge_swap(struct folio *fo=
lio, swp_entry_t entry)
> >                 mem_cgroup_id_get_many(memcg, nr_pages - 1);
> >         mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
> >
> > -       swap_cgroup_record(folio, entry);
> > +       swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
> >
> >         return 0;
> >  }
> > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > index be39078f255be..1007c30f12e2c 100644
> > --- a/mm/swap_cgroup.c
> > +++ b/mm/swap_cgroup.c
> > @@ -58,9 +58,11 @@ static unsigned short __swap_cgroup_id_xchg(struct s=
wap_cgroup *map,
> >   * entries must not have been charged
> >   *
> >   * @folio: the folio that the swap entry belongs to
> > + * @id: mem_cgroup ID to be recorded
> >   * @ent: the first swap entry to be recorded
> >   */
> > -void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
> > +void swap_cgroup_record(struct folio *folio, unsigned short id,
> > +                       swp_entry_t ent)
> >  {
> >         unsigned int nr_ents =3D folio_nr_pages(folio);
> >         struct swap_cgroup *map;
> > @@ -72,8 +74,7 @@ void swap_cgroup_record(struct folio *folio, swp_entr=
y_t ent)
> >         map =3D swap_cgroup_ctrl[swp_type(ent)].map;
> >
> >         do {
> > -               old =3D __swap_cgroup_id_xchg(map, offset,
> > -                                           mem_cgroup_id(folio_memcg(f=
olio)));
> > +               old =3D __swap_cgroup_id_xchg(map, offset, id);
> >                 VM_BUG_ON(old);
> >         } while (++offset !=3D end);
> >  }
> > --
> > 2.20.1
> >
>
> Good catch, Thanks!
>
> Reviewed-by: Kairui Song <kasong@tencent.com>

BTW, it need to be fixed in 6.14, no stable fix is needed, just double
checked the commit is not in 6.13.

