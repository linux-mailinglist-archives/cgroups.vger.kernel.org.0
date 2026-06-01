Return-Path: <cgroups+bounces-16528-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBCsOsTHHWrgdwkAu9opvQ
	(envelope-from <cgroups+bounces-16528-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:56:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 174736238FD
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 19:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60993038F79
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDE3DEFF7;
	Mon,  1 Jun 2026 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFeTSrGP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0B3E0C5C
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336269; cv=pass; b=isti8jxp7rHdzQuQwlvm5c4nBMFpOgbdQHUfnF7RSkwVn6NDh9pw4qEFeQk3oeinGAtb/v5e1gNHjYDJ5YyctjfUwUJZKCibhbBlC9nS1tNRuuznvBBNyNB3/KgW3HVJAXPnLPBGWraTKrBCkYDXDPDhDs9eDxTZLdhPwqHWr4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336269; c=relaxed/simple;
	bh=flOdQbFMjfUG0jkFksI2WZ1HJzXvIy8Dsk0tvu6DNig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlydGLgRDyDVuTxrteY2ndUpMH+Jl/UCQx8kp6na/e7M3kDulIMZAG7WWj37MGTZG+3ZgJP8aB4FUAblWkhn5kNFQmzfK4qFxAKskKvb0yTYS39ET2rBI9Ap+AoVhdV05As+d8D6Q1PwtSXfFaFM4gcMwsxvam/WCbuUXBlIymg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFeTSrGP; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d2342c5e6so2362330a12.3
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 10:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336266; cv=none;
        d=google.com; s=arc-20240605;
        b=OsBeobQyH0I82LrMdYbQJWw33XixoTavViWPfOkv/H09BUZgLNpanmqP2hmunC7ub9
         PAxtHxPbPl4D/aIljr6EGQq7c4UUvQKfzyNk2sz/YWPFCrKbTp9ItTYjmpdRhs5Tg1Yz
         k5vGSa7a8GSai6OZxZfd7fAyOmXmeL8QeHbKd6Xj0DVgEnE7J0wULRf0Zk+gaXRkuBl+
         xJDfHocRYgMbHgP6ni495wosRF0lQZYYYTgytIRvjedoDU8lr9kM1CEMf8I5vM8nS0ZB
         wQP+bdD+1xj22HoAOmur1uQMy++OC4sdMl7rNNaBMBJ4aOU51rdq3y5poJT2Z2tzfI+B
         nnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1oyN2GHO/W1PVNw6MHzzvIqAiryGCw8vjjyfHSwiSxY=;
        fh=PkgJPbsZtFPdQQGEZEpq8Q3G3qU5ca+kUF4xKDJK3Ds=;
        b=LHaJjYGvZCqeMW+0GQvN/E2W49siJlz5ufBItuRsXSXDNrHaz6DRKfIWOD7OSjbBS3
         ZPmCbAIS64fLlwidiEPq5MU6UGbSmMvPtscpu2aeF539Q/SE/LI4Z8CkzlfhTJ+XuL02
         l+zdvzpOYpPtJqcblsL0XPHeC2c2lXf4IEAyRq0aLwsBH4jtiYsXEX0E5aj4uOvkLzca
         bCO+kh21OTw24H6Ad3J7xYe+X5LgfQfwjWPWT4Kycb4NGvlhlnqg/hVWjEttU3n01/d9
         QR7TIRnb1bsH7+G2EAatbS9AwPM4SPkl5t1gJoh/mfWry27g86f+8n0dG4D08Cg0ANmh
         /mbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336266; x=1780941066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oyN2GHO/W1PVNw6MHzzvIqAiryGCw8vjjyfHSwiSxY=;
        b=tFeTSrGPap1yf2dbp8FM1Wl0GY22tAy1HeqCwDyDijuqOFsKzJQB3U/iZC/IkcXwkv
         JT0YYWTrK9SOhBTAsSeqIK3JSUc2fFILOIr2uWJvlqUTRWGrUg1Q89K5gYx/qfd3ESPC
         XqMnHMSgO+YgVCukGPQAXwW1NmqIXNTDqq90IgCaOqFt1vqAYYIzxY5rV51c3VUw97l9
         QLlwIs2r69eyDzv9vCg+gbKH0jsi1lK74Nlnh82Z3TJTc8ikKyGKUHrkeoXpF4LiMj2+
         6KRL1rnJ5LteFdxJOuYXJmwMClELpnX60Eb258zZLF5V6+e5d0EkWjRdt4dki3z+j9va
         V2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336266; x=1780941066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oyN2GHO/W1PVNw6MHzzvIqAiryGCw8vjjyfHSwiSxY=;
        b=N3c60vFJlLeewnPSycyFA9e0EdssUPPaBoL1lD2YSLR//QbSxa68mchwqSK6m04T4s
         xLSvLyLvdUVRsYUgjEoKWODfJCbY9Em1+3+om94AzAABLKyVq1/MciCboIb/hQlRQzIT
         rTrFUXPuFdWfdD+/bchLpWwWaeNjN4UmQ3PotrVr2TFMUTCBiEldMw4m43FZM3N4GRiq
         pbh15wjJ9AE2UcTky1Pq+xdi0lmFZW6WJr+XFdzfJDRerrlXghSq5XGf8uDGR1+rK9Ck
         ZkmT5EztueufafscdVhnnEfxtepIUXUyZFbd2aezlhqFhACQ3UY1aPrOxRjBeafNpgdA
         cTzA==
X-Forwarded-Encrypted: i=1; AFNElJ+s8wrKIEn6FmikTeMgZX3rxfed+ftDMlCs+hT1otn/Jm4spnDpD+4lRvanjk0IfI+5Kf6Zx5r/@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgL9nI1AX5RcFnnuovGec+nOEXYcuZJDeQlhD3GkX5MMECpjV
	LtS2eKvu222baYTuDJYH5GjM2U3L1NYswVDvp8c4ZySQZpbOkswY6nPKwqx57U7gYtw46x6MISD
	V3/vKk98ol6pThKx1AxbWTA54GAULRF8=
X-Gm-Gg: Acq92OG9/ZcvjD/mWOhsaU5ucNLs88oCluP+EQ1jvxSdR6jjeFxOh57QywSRTWrtOmj
	jTMeAkpSWBjvwG/vN5FS1mmLydtd0c7WtTnGu6MA5wOTwHCHi6MRdqJZBjP+lwgtVqut8iaud/N
	tA61UhH72HmlaLUXwGKACjuqYCGxr3w6cDi9UURHDnfJ2ZGZHqA36NvABPR4Kaf5bnbjLX1SC4y
	AJP5IyRyUizVbUp3Htu3RHy7eaHJQHyBpe/QHtK6jLjYn4/QK5pI8vShf+rVNEODvMbrFMYlj8k
	bRECM1ZO6ICy0oGWSBi7LMdCraf8XMz/Fye+hUw4OjIYpIN0TIU=
X-Received: by 2002:a17:907:3d55:b0:bcb:4046:63ee with SMTP id
 a640c23a62f3a-beab17aaa7fmr558548966b.31.1780336265621; Mon, 01 Jun 2026
 10:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601161501.1444829-1-shakeel.butt@linux.dev>
In-Reply-To: <20260601161501.1444829-1-shakeel.butt@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Jun 2026 01:50:28 +0800
X-Gm-Features: AVHnY4IV1F6PCCbzzYjlKLYKIUjD5M0VssnH2_2WxHth41_Ifdx4MpgpS8XDWPI
Message-ID: <CAMgjq7CQt+W5jAB1DM=nCRpLOFnCK3FkdKT6O0sznOEGpo6=Zw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/list_lru: drain before clearing xarray entry on reparent
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dave Chinner <david@fromorbit.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16528-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,fb.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 174736238FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 2, 2026 at 12:28=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
> xas_store(&xas, NULL) before reparenting its per-node lists into the
> parent. This opens a window where a concurrent list_lru_del() arriving
> for the dying memcg sees xa_load() =3D=3D NULL, walks to the parent in
> lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
> list_del_init() on an item still physically linked on the dying
> memcg's list.
>
> If another in-flight thread holds the dying memcg's per-node lock at
> the same moment (another list_lru_del, or a list_lru_walk_one running
> an isolate callback), both threads modify ->next/->prev pointers on the
> same physical list under different locks. Adjacent items can corrupt
> each other's links.
>
> Fix it by reversing the order: reparent each per-node list and mark the
> child's list lru dead and then clear the xarray entry. Any concurrent
> list_lru op that finds the still-set xarray entry either takes the dying
> memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN
> and walks to the parent, where the items now live.
>
> Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reported-by: Chris Mason <clm@fb.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1:
> - Use xa_erase_irq() instead of xa_erase() (Sashiko & Claude).
> - Added comment on CSS_DYING check in memcg_list_lru_alloc avoiding a new=
 mlru
>   allocation.
>
>  mm/list_lru.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index dd29bcf8eb5f..d454bce9a78e 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -473,26 +473,29 @@ void memcg_reparent_list_lrus(struct mem_cgroup *me=
mcg, struct mem_cgroup *paren
>         mutex_lock(&list_lrus_mutex);
>         list_for_each_entry(lru, &memcg_list_lrus, list) {
>                 struct list_lru_memcg *mlru;
> -               XA_STATE(xas, &lru->xa, memcg->kmemcg_id);
>
>                 /*
> -                * Lock the Xarray to ensure no on going list_lru_memcg
> -                * allocation and further allocation will see css_is_dyin=
g().
> +                * css_is_dying() check in memcg_list_lru_alloc() avoids
> +                * allocating a new mlru since CSS_DYING is already set f=
or this
> +                * memcg a rcu grace period ago.
>                  */
> -               xas_lock_irq(&xas);
> -               mlru =3D xas_store(&xas, NULL);
> -               xas_unlock_irq(&xas);
> +               mlru =3D xa_load(&lru->xa, memcg->kmemcg_id);
>                 if (!mlru)
>                         continue;
>
>                 /*
> -                * With Xarray value set to NULL, holding the lru lock be=
low
> -                * prevents list_lru_{add,del,isolate} from touching the =
lru,
> -                * safe to reparent.
> +                * Reparent each per-node list and mark the child dead
> +                * (LONG_MIN) before clearing xarray entry otherwise a
> +                * concurrent list_lru_del() may corrupt the list if it a=
rrives
> +                * after xarray clear but before reparenting as
> +                * lock_list_lru_of_memcg will acquire parent's lock whil=
e the
> +                * item is still on child's list.
>                  */
>                 for_each_node(i)
>                         memcg_reparent_list_lru_one(lru, i, &mlru->node[i=
], parent);
>
> +               xa_erase_irq(&lru->xa, memcg->kmemcg_id);
> +
>                 /*
>                  * Here all list_lrus corresponding to the cgroup are gua=
ranteed
>                  * to remain empty, we can safely free this lru, any furt=
her
> --
> 2.53.0-Meta
>
>

Nice catch! Thanks a lot!

Reviewed-by: Kairui Song <kasong@tencent.com>

