Return-Path: <cgroups+bounces-10794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B53BE1000
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F97D19C5C07
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 23:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639323164CB;
	Wed, 15 Oct 2025 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M37ZrIlu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E33164A9
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569941; cv=none; b=gAwXD/dAcvwowWsWW22LFONem4/XnmKxmKDI3Nc/wtDEmFz7glyCrkmFM0e6jrTNfj1aiLYFnj8wh9DOMJ4qVJO/lQ2JxOmIzKGGidOnsRLXBuHIbeJxsgyoCvzXzNrn5jk4RcWdgaha5Z4Sl21lz4BYSGkVJOCHE2ZpzEQWyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569941; c=relaxed/simple;
	bh=r44UktmLfbn87icefxwzup3DZAKCpa44gU2sA9H0npw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULz79f0NW7kXx4uRyyjIK1L9MDfILcnzlrVpsb+8B9rKbwahfM9W/LtxekiJw9qUdaC78kUwbEFT9u5KVfttW/IhJFcpy6C8WlV0vMwvvxXpZKwcF3FS5bl+fz67ooGdOxhCNGpo5wQsWzInhC6cTVIgJskngzQD3A7QM7DlSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M37ZrIlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD9C19423
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 23:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760569940;
	bh=r44UktmLfbn87icefxwzup3DZAKCpa44gU2sA9H0npw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M37ZrIluwq5EeNwUaKS8VbE2fDg3ZFE1Bt8q8AASK4XuvaEBY9UHPgrR6Vo6hQTvO
	 HwjHoag6GWY3w6vHPNSMU/2soplGUj7M/aZANKW2HEZLqT8xeoo4TJqyupgBGMoUVE
	 NDvWoRBjbJZ9ALVMRE15YaBgrDcdI/Bf0bv4mMbNYj8uU5LCFxPKgFYMDazmdZmWeL
	 h2oBkg2tBO1iQlyVZBtk3uTFGK4OfKV1yhNiV0cJ+5jgVr+MAIDwJbJqkWCBuWJ8yY
	 ZVNOmyFKaGGYjWuBAq/23b3P+Kl4MqNBbwsdIL3XK6p9ghk/HLQ6rHSeEhaKHvKUTi
	 Rb+Nf9Ho011+w==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-791875a9071so2035446d6.1
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 16:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzmzaliFd2IBisop/gbnmEXbo/dI6ggK3gtZ4AeHpVq5qW9Mi/vF+aHHlEhDVG9Qgcs8jkX+5r@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMphnh+dlF3WUNsVXxaGM7Jqgs8dubWN1SXQXsp7JxfkTftbF
	lWQJuLscJBYI4efyur0e8Vojgb56uG3ojOwXzSZMKcRSmT5Vf2IGfUXoSsk37MHf/oD2Creg4eZ
	2cv3QZJ51T8DjwD9W4eWpgwB05YnmDXc=
X-Google-Smtp-Source: AGHT+IFLrZdMNDEHSuM1l+l7K0Igp2TgGHURmcyfMZduSiR21b8bfTpAX6I0Lw+bgngZoJ0JLG8z/3PI1EZqoF171Qs=
X-Received: by 2002:a05:6214:ac4:b0:802:7214:5bb with SMTP id
 6a1803df08f44-87b21031efemr529272216d6.28.1760569939755; Wed, 15 Oct 2025
 16:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015190813.80163-1-inwardvessel@gmail.com> <20251015190813.80163-2-inwardvessel@gmail.com>
In-Reply-To: <20251015190813.80163-2-inwardvessel@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 15 Oct 2025 16:12:06 -0700
X-Gmail-Original-Message-ID: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
X-Gm-Features: AS18NWCRhZ0HbfQIAsuNZF3o7IVIRRvXVmXcToP6BTqFWLZSUci3-Th1d7PMPqA
Message-ID: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, andrii@kernel.org, ast@kernel.org, 
	mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:08=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com>=
 wrote:
>
[...]
> ---
>  mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4deda33625f4..6547c27d4430 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *=
memcg, int event)
>  }
>  #endif
>
> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
> +{
> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) :=
 NULL;
> +}
> +

We should add __bpf_kfunc_start_defs() here, and __bpf_kfunc_end_defs()
after all the kfuncs.

> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)

We mostly do not make kfunc static, but it seems to also work.

> +{
> +       struct mem_cgroup *memcg =3D memcg_from_cgroup(cgrp);
> +
> +       if (!memcg)
> +               return;

Maybe we can let memcg_flush_stats return int, and return -EINVAL
on memcg =3D=3D NULL cases?

> +
> +       mem_cgroup_flush_stats(memcg);
> +}
> +
[...]

