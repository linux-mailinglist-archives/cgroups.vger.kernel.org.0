Return-Path: <cgroups+bounces-4354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387D95742E
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 21:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3862856D1
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934471D6DB6;
	Mon, 19 Aug 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoGnGo5D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74B1D6DA7
	for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094589; cv=none; b=JCdm93T2+sJFhE7iMmp9D3x1I9sT/Ae31sHblRFC4Cq8IOnuMF3gn6fxzXYH6FoztdCV/iKx+3cjqa5oFhqH35GUhNunKH/oP7EtsoEDGUOMgtXbL5BmJYjGTLXZtP5b7w+86CcCadGnxnfAQDiJLrx72C9LKG2mpqlskZHSCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094589; c=relaxed/simple;
	bh=38M6B6nAfyLtnpECmOFdqw/6sYPFm0aJQrtir4RF/q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1aNAfJxvQtGyvUqLP4mzQbNqzDr5c00VrLJwVcGSKmQj9/woP9E5TMbsSh40SkZOKd2mNaAEYn7WoXOZtvQ8mZ/biS4zaMOBV5n4F5mMDwgz5XiBmh8505dMJ2Xt0XubR6BCSFkPw2hs29DLU6JVHH5bKXMUhIeNKsZWQocXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoGnGo5D; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a81bd549eso383109966b.3
        for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724094586; x=1724699386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8keNgyq5Y1CiFPJpkWT/ZTIazYWWYL5qY5ay8DSsuU=;
        b=IoGnGo5DtHiBfKYXvXJUZsIOt9sFyvikUdF4s98FcWwCPbO2A21mv3mTcS96YDdH26
         +jKnwNrp7ss+nQ7dbtxce/2R19Zw5qU94JJy2FfGLbWYtGu6pE/SBww8y3534hJOuGb3
         wkEDyWUoOV6xyjWrGnrX9/3SBwj1QXFCUJ4ry8ae/fIYgTwFN3R4lU36cM5ga/PAxQkO
         J3EaPMTqZvQXqNyEbA+vA8oQOV4JI0i0qL2navbLtEv1cYAk4E9YDe4CXxCIs5izqi2t
         fPKyY/UtHkpLvejnrYLyR2sRRtZzyt3x45nckQfomUI5ngK1j/f6Sp0UAYt3n9PNpct4
         0hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094586; x=1724699386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8keNgyq5Y1CiFPJpkWT/ZTIazYWWYL5qY5ay8DSsuU=;
        b=J1pNPXmOySUYZy8GrQah/5sl55tjm1m31nm4sSA/HI8vt+Jn7FN51EoMc/+b3E3llz
         5GxXmNiLuZ+L6NdhCdH3XnlPSbN8fFqsHMm82F/fntc4nv/VfSpJcxgIh6NZ1PyjZoaz
         aigXcUZzkwrqcQ8t+j2BMt4L72hbwMm+04e747IN1t6BZ3x2+DfnX+pjBB0RI9H3J4Dp
         MpdbNUBh+8w0vRu2BITuEg8ki5fwQVrix+hrtaOkPIkaVm/4Z42VJVgcgkMeh4N30xM7
         LKydbmTH1d/u5j69Abou1eXL+3t0PLADlGtW5JlyxbQGxpS+AmT+vfbdvn6IgSx45Z8k
         Yl/A==
X-Forwarded-Encrypted: i=1; AJvYcCVcNcFe7bFdN5Bqjdh924HYhinVaEjoevAMdH9HA/+6T/WREkMUu6jwq1i0Lh9c0QM+Pl+axzolGLhsxSOF0epuLh/jmn5szQ==
X-Gm-Message-State: AOJu0YyYn3pKGJbICK271aDsabMrswx0uxg5C54p+WfOV3oS4mxpM3DU
	gbUAgUDGEB52SfDVaQXjgk8fdKtypkNWA10FflbGFdWnG3dEcPSGBVmkL7ZXMxy94peRtZMUPVT
	JajIg+1Cz/jaCkR/uJaiWqLHzHa64dzSIzDR9U4tEr+Mq4cwhmg==
X-Google-Smtp-Source: AGHT+IGuKI69R41BZuJTwuz2InUwf8+whd8Hm0hr6/vouCAUsHezmuQBN4on3koeWHj1yT93eqQMGmKyg9R2P+SWPgw=
X-Received: by 2002:a17:907:97c3:b0:a7a:bae8:f2a1 with SMTP id
 a640c23a62f3a-a8392a03c21mr988519966b.42.1724094585132; Mon, 19 Aug 2024
 12:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816144344.18135-1-me@yhndnzj.com>
In-Reply-To: <20240816144344.18135-1-me@yhndnzj.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 19 Aug 2024 12:09:09 -0700
Message-ID: <CAJD7tkajuiBDV9Hk8Z+f_-f4ZZf81o4CP3LFLVbfZbrvn4RrUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memcontrol: respect zswap.writeback setting
 from parent cg too
To: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
>
> Currently, the behavior of zswap.writeback wrt.
> the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> it doesn't honor the value from parent cgroups. This
> surfaced when people tried to globally disable zswap writeback,
> i.e. reserve physical swap space only for hibernation [1] -
> disabling zswap.writeback only for the root cgroup results
> in subcgroups with zswap.writeback=3D1 still performing writeback.
>
> The inconsistency became more noticeable after I introduced
> the MemoryZSwapWriteback=3D systemd unit setting [2] for
> controlling the knob. The patch assumed that the kernel would
> enforce the value of parent cgroups. It could probably be
> workarounded from systemd's side, by going up the slice unit
> tree and inheriting the value. Yet I think it's more sensible
> to make it behave consistently with zswap.max and friends.
>
> [1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hiberna=
te#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
> [2] https://github.com/systemd/systemd/pull/31734
>
> Changes in v2:
> - Actually base on latest tree (is_zswap_enabled() -> zswap_is_enabled())
> - Updated Documentation/admin-guide/cgroup-v2.rst to reflect the change
>
> Link to v1: https://lore.kernel.org/linux-kernel/20240814171800.23558-1-m=
e@yhndnzj.com/
>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

LGTM,
Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  Documentation/admin-guide/cgroup-v2.rst | 5 ++++-
>  mm/memcontrol.c                         | 9 ++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 86311c2907cd..80906cea4264 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1719,7 +1719,10 @@ The following nested keys are defined.
>    memory.zswap.writeback
>         A read-write single value file. The default value is "1". The
>         initial value of the root cgroup is 1, and when a new cgroup is
> -       created, it inherits the current value of its parent.
> +       created, it inherits the current value of its parent. Note that
> +       this setting is hierarchical, i.e. the writeback would be
> +       implicitly disabled for child cgroups if the upper hierarchy
> +       does so.
>
>         When this is set to 0, all swapping attempts to swapping devices
>         are disabled. This included both zswap writebacks, and swapping d=
ue
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f29157288b7d..327b2b030639 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5320,7 +5320,14 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *=
objcg, size_t size)
>  bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>  {
>         /* if zswap is disabled, do not block pages going to the swapping=
 device */
> -       return !zswap_is_enabled() || !memcg || READ_ONCE(memcg->zswap_wr=
iteback);
> +       if (!zswap_is_enabled())
> +               return true;

This is orthogonal to this patch, but I just realized that we
completely ignore memory.zswap_writeback if zswap is disabled. This
means that if a cgroup has disabled writeback, then zswap is globally
disabled for some reason, we stop respecting the cgroup knob. I guess
the rationale could be that we want to help get pages out of zswap as
much as possible to honor zswap's disablement? Nhat, did I get that
right?

I feel like it's a little bit odd to be honest, but I don't have a
strong opinion on it. Maybe we should document this behavior better.


> +
> +       for (; memcg; memcg =3D parent_mem_cgroup(memcg))
> +               if (!READ_ONCE(memcg->zswap_writeback))
> +                       return false;
> +
> +       return true;
>  }
>
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
>
> base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
> --
> 2.46.0
>
>

