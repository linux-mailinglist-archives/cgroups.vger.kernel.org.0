Return-Path: <cgroups+bounces-4542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB032962F1E
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 19:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BDD1C21C4F
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC31A76A0;
	Wed, 28 Aug 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnDikNKm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19315ECD7
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867919; cv=none; b=TcHnXyFd7dyl/q0wC9RJMUaHkkljN8xxl9kn4x6tEiYB7fVsHWcudOT6GinGIiXwKQUjTXVVdz2XwaqZcCJMD5LgLi5ScQ3q5TGEovbwS6Jm6edYbQHVuVlXECdf38d4SVar13HFIo2QcPwpohXLMD6R+ieMjKbZiHGm5Hxq/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867919; c=relaxed/simple;
	bh=5HfJVoZUf09/yyuSOEaoOPwo1/GxAhoJbnY8gPaxN5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFO7w13WwVfVFBbJEgUfU+D30J5fdlJJfEdcz4Yx0y0AhgKBCB8fT/Q9wTOREyTsLnTWXwbp6WVRmTkXg1XIQMvlkJhKl3vtgaO4k90EJ6sBMTDn5qayJWh8yi/fG3/Qtg1UIcve+DuJVZGaBrb0lDnv65iv9E0DanudgnFzbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnDikNKm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4567fe32141so7161cf.0
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724867917; x=1725472717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV5dbJzassVE92Ckkqje6sBzWbYCfklUNPbX30/kMzA=;
        b=UnDikNKm9FnpJysjhjq1+aiSze3y/qbtK8R/4gurBq2i0hcCXRQTi9bZE0tS4C1NDr
         ur8cN4xFXl97lo2fPrXEvALQy5/h4fP5Dptr/+dKB5LQleJ3TKApTgDsd4LAEBs0+WmQ
         i3pKR3dI5akQujm8wFaytZDMRBx4bmtpS2t8ubgy/ktIOHlpX2+1H9kN1J+uQtBy6YzJ
         su9B7xoEU462O4BY2nFKB3apSFHgjrNDA51FToQICrLfI5aieDUZTILW+SYmg4FqItCx
         WPxaghP8nESrZ3atXPZ0MujI+1SHJeYqaeIjB5LvhEDHF7recsq3MPYKiOHOvDcsaAfc
         OfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867917; x=1725472717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV5dbJzassVE92Ckkqje6sBzWbYCfklUNPbX30/kMzA=;
        b=IuL03TTzwHpqngBz0lWWBycpb6BdDe50vlF//m1aZb6+fRGkYTgeW8kVxEyFPUhPC2
         T0ryDeVaAn+GyA7SCApILqxl58nGH9JtlQUeZ+bq8tnHUv4wl1I0W12jUu0xr6kRLFCh
         K7BBlfcqiuuY0TnEie9C/YQ8hVV1scPYn26BDgX7D8q7BINr+vExYFPA6qepTLiA8WA4
         zeVFkFfirFJ09WqSElJUTkqkPq4q9DAIXFkvw5yf6Ylco3FiT6duopJSeRBY/w9+puMY
         EnNLn3KmiRfvpkxM2VBzkK9WS08LsMb17/259gtgkRvP09x7uOOLyFTIOnie2DPKAy8v
         0fAA==
X-Forwarded-Encrypted: i=1; AJvYcCV04c4Mad+ut4TKLsNEQ6qqZGVD1FQtOWDChOshBJBfgmk5m6msKXVgjIbGkpV9JF6gsRCFXS2q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CAo7dk5VgCxtHCHZERD80mfQmOoem7LfymEuw514wEklRrdC
	j7L88esq9yDy64/El5UYp0TAGXtPsucL8RisAqeXXlVB6UOWHvahEzK5uJv7+xO+VRDWA8O0GXX
	MAlk4aPmaHImJWtr2BG/BhEJ2+XLxu2NWFBMO
X-Google-Smtp-Source: AGHT+IGVPYdTHR5UwWuRVhw4md8Wv5OEpWr/gP/bx0HY4TvrXmMLFX6yrNpCmoZP/otzyEYzbYJw4zSUNRD68rtuOrA=
X-Received: by 2002:ac8:7e47:0:b0:456:7ec0:39a9 with SMTP id
 d75a77b69052e-456801069e8mr39051cf.5.1724867916761; Wed, 28 Aug 2024 10:58:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-3-kinseyho@google.com>
In-Reply-To: <20240827230753.2073580-3-kinseyho@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Aug 2024 10:58:25 -0700
Message-ID: <CABdmKX3vOnjrLyZ1BMJ27cMU52+gPKWAYE+OrkeC5JLehS8Zaw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 2/5] mm: don't hold css->refcnt during traversal
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:11=E2=80=AFPM Kinsey Ho <kinseyho@google.com> wro=
te:
>
> To obtain the pointer to the next memcg position, mem_cgroup_iter()
> currently holds css->refcnt during memcg traversal only to put
> css->refcnt at the end of the routine. This isn't necessary as an
> rcu_read_lock is already held throughout the function. The use of
> the RCU read lock with css_next_descendant_pre() guarantees that
> sibling linkage is safe without holding a ref on the passed-in @css.
>
> Remove css->refcnt usage during traversal by leveraging RCU.
>
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

I found a different place where a more trivial css get/put pair than
this could be removed, but I couldn't measure a perf difference. Like
Yosry, I appreciate the simplicity gains here though.

> ---
>  mm/memcontrol.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 35431035e782..67b1994377b7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1013,20 +1013,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgro=
up *root,
>                 else if (reclaim->generation !=3D iter->generation)
>                         goto out_unlock;
>
> -               while (1) {
> -                       pos =3D READ_ONCE(iter->position);
> -                       if (!pos || css_tryget(&pos->css))
> -                               break;
> -                       /*
> -                        * css reference reached zero, so iter->position =
will
> -                        * be cleared by ->css_released. However, we shou=
ld not
> -                        * rely on this happening soon, because ->css_rel=
eased
> -                        * is called from a work queue, and by busy-waiti=
ng we
> -                        * might block it. So we clear iter->position rig=
ht
> -                        * away.
> -                        */
> -                       (void)cmpxchg(&iter->position, pos, NULL);
> -               }
> +               pos =3D READ_ONCE(iter->position);
>         } else if (prev) {
>                 pos =3D prev;
>         }
> @@ -1067,9 +1054,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgrou=
p *root,
>                  */
>                 (void)cmpxchg(&iter->position, pos, memcg);
>
> -               if (pos)
> -                       css_put(&pos->css);
> -
>                 if (!memcg)
>                         iter->generation++;
>         }
> --
> 2.46.0.295.g3b9ea8a38a-goog
>
>

