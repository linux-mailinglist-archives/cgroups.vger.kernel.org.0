Return-Path: <cgroups+bounces-6854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC8A540E0
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 03:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D635B1888C4C
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 02:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716F1946DA;
	Thu,  6 Mar 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn8VJhor"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBE19342E;
	Thu,  6 Mar 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229673; cv=none; b=NwlCaZWrl3uDdzJfLP3j6HGxEh+k23szkEl0i0EdF1GlGt9ouU+OJUgCl0NEvP3WPSozRwK+ZjxQxhoZnFuakbnuWLO9A8gAwTVXur/KZCYpfUK7nBRaDe2r3/3AnOFV8VplI7/cISPGEFeDXXegp+kaC7RvwXNJ8pnen9LaH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229673; c=relaxed/simple;
	bh=AOEzvbbLywvKrHC1thVnHqNCN4jpDd36x98Q1oY//Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/SLPbwurc1SzPNi4qhw+1CdJF588Pwure6iEzLuIn4dGCph7SB4aNnYgcUS+1gbwmb3rsoTNoFYUzkJ1IXOenRFKWGczIUFmrzTeLSZGkT6FVdJRdYAXN9Wd7TcHWoXseKFpji+31PARFZaXU4y5CswI+91ZxQJHCaL3pIevos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn8VJhor; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-547bcef2f96so234106e87.1;
        Wed, 05 Mar 2025 18:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741229669; x=1741834469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th9BnbvFSv/H4LV5KRUlInal6A2L1r1zSMusFTF7La0=;
        b=Nn8VJhorYdeM4+0oIujGh8H9cm6xYlBJZsrBMsqs7TcPhM44dDEJgXFtGiosHNVW7l
         r3IYaDL9oS5fA1LW3TxQ8b5l1VJq5jddbxpO2z+/hELUZbZ7mlvXiUT2MyxuUd1KrkhL
         y9CKcWX/YEQyCQpL5/SBiYpRvzDadB9p/Sp83hfHRbk/EXoWTVQMl42+MSVgyhwWoSOl
         TkKxF2FQvGZqwmKmODsrkPc2CDDTfqy60MoZCLei3BpSqJHci2UuCqANdr/R464D398l
         ucmuDZTVZ8IKDBm+BC7nSTPikGPodRZItkTD7XUUgZHl8BfHS6dc7d4LZGP/5PrfroTX
         /eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741229669; x=1741834469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th9BnbvFSv/H4LV5KRUlInal6A2L1r1zSMusFTF7La0=;
        b=QCbai3VzzLjUEdFLGfmVOYlSlsUpxopq394sZfyTMWzDVyA5tnQM8bhe8pDKg3DGDr
         P8AXZZR20nixufel94wEwfzRIO4BGRONh5S7FJnLCZ3WTSNZFcl7qqVCc6gXavcw+n8m
         KT1D9vNNgJdMZ0U5+krPvZtuLzcHZxiBTmZJ7sZLCiSHHSwaDE5AJ+WKVEkFxTbZKQF1
         aKKbf9GeONR7YOavw27cO29Het2Y66a46EvMQd28cQtXnikqf3mfvlLJwYRaM368UjZI
         W7VqskKpKxZz7cGZ3i7irm4SzguEhaZ9sr6ufFuLDeGjMGErdFOmUrW/80Saf7m6jTkl
         MvtA==
X-Forwarded-Encrypted: i=1; AJvYcCUVOgOBujagcHktcBzN2Fa4BEKEwmIcXRbqfg5axyuAZ6UXzQUrtFvtfbgdyebznD9viBLqO/bVgfa2dbmn@vger.kernel.org, AJvYcCVhTl+OOkFYVRdLGkQDX8RHqkGwJSOEhLDT8FtLSRgNIAiYKxN6PSiCtLCaKJoQsWMkV4xf5ggQ@vger.kernel.org, AJvYcCViVZ3xeQ2qANAzSXTLmO/iNbnrrpek4CI+NaoRLblaIsRUY9nsuTAeIoIXwSbMIIMbnF1G6Cf6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5e6gB13AoFmKVIg4Ew2rtfeZ1glo3odPcUUUZnHrW5mV6gwK4
	l4xe33Tcd5S/XhujyfIyARoeOjLoYUFGG7ZAoPYcm2m59QRPcLxAR8sClVaGuTY/DOECbCzVRuY
	kHxCaRZCaIig6COYL79NAqclD3eM=
X-Gm-Gg: ASbGnctmZOHROc8ZBbco9SIQ7vWGTITajXkOuhZNxmE3IGYaWgm85FSDxqPLkLWWocI
	uhBEYXwdu1lVipUg3AyItQJfgOEMqykifnNsuEUFVn+UCcFHeqS2b33UtzteLolSFEFAa+yBG7N
	auB3YpaEdNHJWlMUUohvO9wU/lOA==
X-Google-Smtp-Source: AGHT+IEJfVTrJM22yJTFgts9tci5nFp84rzjL9nZelaYrsIqHQ0VTM31zK+owTJLFjPMRhkTZOP1AOKhm9lNe6TiUlU=
X-Received: by 2002:a05:6512:2309:b0:545:b89:309b with SMTP id
 2adb3069b0e04-5497d3806ebmr1990378e87.44.1741229668765; Wed, 05 Mar 2025
 18:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306023133.44838-1-songmuchun@bytedance.com>
In-Reply-To: <20250306023133.44838-1-songmuchun@bytedance.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 6 Mar 2025 10:54:12 +0800
X-Gm-Features: AQ5f1Jo_jQXxQST2BfF6to7nckWMOdtZOnQRa7kHnH_qKevSEQD4MehIIfl6GcU
Message-ID: <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:32=E2=80=AFAM Muchun Song <songmuchun@bytedance.c=
om> wrote:
>
> The commit 6769183166b3 has removed the parameter of id from
> swap_cgroup_record() and get the memcg id from
> mem_cgroup_id(folio_memcg(folio)). However, the caller of it
> may update a different memcg's counter instead of
> folio_memcg(folio). E.g. in the caller of mem_cgroup_swapout(),
> @swap_memcg could be different with @memcg and update the counter
> of @swap_memcg, but swap_cgroup_record() records the wrong memcg's
> ID. When it is uncharged from __mem_cgroup_uncharge_swap(), the
> swap counter will leak since the wrong recorded ID. Fix it by
> bring the parameter of id back.
>
> Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording and =
clearing")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/swap_cgroup.h | 4 ++--
>  mm/memcontrol.c             | 4 ++--
>  mm/swap_cgroup.c            | 7 ++++---
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
> index b5ec038069dab..91cdf12190a03 100644
> --- a/include/linux/swap_cgroup.h
> +++ b/include/linux/swap_cgroup.h
> @@ -6,7 +6,7 @@
>
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
>
> -extern void swap_cgroup_record(struct folio *folio, swp_entry_t ent);
> +extern void swap_cgroup_record(struct folio *folio, unsigned short id, s=
wp_entry_t ent);
>  extern unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr=
_ents);
>  extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
>  extern int swap_cgroup_swapon(int type, unsigned long max_pages);
> @@ -15,7 +15,7 @@ extern void swap_cgroup_swapoff(int type);
>  #else
>
>  static inline
> -void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
> +void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entr=
y_t ent)
>  {
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a5d870fbb4321..a5ab603806fbb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4988,7 +4988,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_en=
try_t entry)
>                 mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
>         mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>
> -       swap_cgroup_record(folio, entry);
> +       swap_cgroup_record(folio, mem_cgroup_id(swap_memcg), entry);
>
>         folio_unqueue_deferred_split(folio);
>         folio->memcg_data =3D 0;
> @@ -5050,7 +5050,7 @@ int __mem_cgroup_try_charge_swap(struct folio *foli=
o, swp_entry_t entry)
>                 mem_cgroup_id_get_many(memcg, nr_pages - 1);
>         mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
>
> -       swap_cgroup_record(folio, entry);
> +       swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
>
>         return 0;
>  }
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index be39078f255be..1007c30f12e2c 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -58,9 +58,11 @@ static unsigned short __swap_cgroup_id_xchg(struct swa=
p_cgroup *map,
>   * entries must not have been charged
>   *
>   * @folio: the folio that the swap entry belongs to
> + * @id: mem_cgroup ID to be recorded
>   * @ent: the first swap entry to be recorded
>   */
> -void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
> +void swap_cgroup_record(struct folio *folio, unsigned short id,
> +                       swp_entry_t ent)
>  {
>         unsigned int nr_ents =3D folio_nr_pages(folio);
>         struct swap_cgroup *map;
> @@ -72,8 +74,7 @@ void swap_cgroup_record(struct folio *folio, swp_entry_=
t ent)
>         map =3D swap_cgroup_ctrl[swp_type(ent)].map;
>
>         do {
> -               old =3D __swap_cgroup_id_xchg(map, offset,
> -                                           mem_cgroup_id(folio_memcg(fol=
io)));
> +               old =3D __swap_cgroup_id_xchg(map, offset, id);
>                 VM_BUG_ON(old);
>         } while (++offset !=3D end);
>  }
> --
> 2.20.1
>

Good catch, Thanks!

Reviewed-by: Kairui Song <kasong@tencent.com>

