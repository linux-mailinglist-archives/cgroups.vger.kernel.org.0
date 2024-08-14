Return-Path: <cgroups+bounces-4270-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A474952463
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 23:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3BA1F21CDF
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0271C7B6C;
	Wed, 14 Aug 2024 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/Nwcb8J"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3A1B9B59
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669286; cv=none; b=b+G5WS4BYNtg4XO+MOlxDku+Y8iBsWarM/E/1HqqkYL1HJcxOtVsxHqrdLPLj3c6r+e2SyVJzxhZZBZe3mANT0vgmSrNWTmZb/61HSozYGFZ4Zzp64HPZgEmGVBfI0NSgcsd0cQ13/mFz5PumkJP4UjvFNFNMcce083yNgXDil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669286; c=relaxed/simple;
	bh=QFUMlwKJJ22GxYAqA6y3hNWVCyOLZH77nEyNH3dVRVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHtComqUTlHkrWRqLUtP9q7lC98zBtzVdABtzbLrCQ5YXxj/EH4l7+X1kRkGEf7cyd64DOiialLTALli5/y32TDm69dLnNl+SV1Hu+tq6aAW4JPbwFBxQNfnQyo1jdSGYR6GUlWa7stRwEW7WrDdrqiWvV/4dt278y9LViQXZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/Nwcb8J; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso558390a12.1
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669281; x=1724274081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtSWn6D+L1i0S8D9pk47VhJVmM2hM2e0bEFMHwPQzZo=;
        b=g/Nwcb8J1eH6FtKoBGBgheeUSE9s8w9ugmA+ABJSCJJmg1Rs9nVw+0tp3HRmFgXp/b
         EmnIX6AcUCLvPaZTHrjEnH2CijGpTbMLPwGW8AmQMdU88EbYzmiYlW24oCBypsexIrCy
         1Chs+TuOgaFbWkIj8bcafatNVbe4lpYYV39pyjWqukVhK4dZvIVWaOhwX53GBFNA0ADK
         Fz9vEECNix4AJWdQ3nylXt4S5BvexYgw6CqLui8oYOsvMcgUD3pzqTyguADdGj02QqXE
         6dVVcfGAfGNNwkKavyFkPzrnq0JKFJfMoFz5bG/O1rsiW39rc6Z5kej2JpAn6p7J+gWv
         Qw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669281; x=1724274081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtSWn6D+L1i0S8D9pk47VhJVmM2hM2e0bEFMHwPQzZo=;
        b=SdtGJgVov19SKWKYn7DVWVUEMvnftDxM2AmWsWbgOOn5drjwJZgQKFu5dfiLgtvgty
         V4I30jFcjMCB44GxlJX+THOqZGME2ef4sahsTTN/oU6x/1DbpfPI6hz8N+EeK36/0tHj
         NJy5HvnY1VGnycrfH2rKo5lVNRZSYqSPz/EjCKlEqzavgt99YZ40eYtDRus5fYZO81Mq
         M++6cX5kklv5mH+cX+9u2FR77/3WZL2XuhcNPyXk+o0CJ67GrfC9x5Wxboje+QQfuFXD
         Psu2znu6vlgcGxU20pBq9Y9bpFvWedVr9fQYeGwauRhgX+fcqfliqM3nWOL1X9utm227
         vEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBx9yNIl61lFiKc6OE0c1CGOjzjuH85r7S6VBQxazMGBZsCXkrsb6mm+zsXnrU8SM0wIcilQP98dmbH24NRYeAwvhAup/1ew==
X-Gm-Message-State: AOJu0Yyf6eNZ1G7XkxjQoLmLkEW4LY5fBlNiu+afoxx1+mfHsQIo5zrb
	R4pM81MNHvZQ+Z0OYESg18UiHGmxJhYa4Grhie08snh9O/V1M3T5V/h9Ai12hB8mNZ16rnWMBAY
	qXF369WWaY2ramJ5s3+Opg0HdQP0O0lel8Gb5
X-Google-Smtp-Source: AGHT+IGRA6vdncRy2nz6tiF7hG9ZotPO8yndJSxBHfEImNy31+XsN/M4EX4g0JuPoNUaluTpzizpWso7xAtF766k5Fw=
X-Received: by 2002:a05:6402:3514:b0:57c:7471:a0dd with SMTP id
 4fb4d7f45d1cf-5bea1c739c4mr2561925a12.12.1723669281004; Wed, 14 Aug 2024
 14:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814202825.2694077-1-shakeel.butt@linux.dev> <20240814202825.2694077-5-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-5-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 14:01:06 -0700
Message-ID: <CABdmKX1adgyideAM+hggM2vYSQqoXVPNPDicAi2iGHL2MG-SMA@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg: initiate deprecation of pressure_level
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The pressure_level in memcg v1 provides memory pressure notifications to
> the user space. At the moment it provides notifications for three levels
> of memory pressure i.e. low, medium and critical, which are defined
> based on internal memory reclaim implementation details. More
> specifically the ratio or scanned and reclaimed pages during a memory
> reclaim. However this is not robust as there are workloads with mostly
> unreclaimable user memory or kernel memory.
>
> For v2, the users can use PSI for memory pressure status of the system
> or the cgroup. Let's start the deprecation process for pressure_level
> and add warnings to gather the info on how the current users are using
> this interface and how they can be used to PSI.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 74cea6712d06..8ec1faf08b6b 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -86,6 +86,8 @@ Brief summary of control files.
>                                       used.
>   memory.force_empty                 trigger forced page reclaim
>   memory.pressure_level              set memory pressure notifications
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.swappiness                  set/show swappiness parameter of vms=
can
>                                      (See sysctl's vm.swappiness)
>   memory.move_charge_at_immigrate     set/show controls of moving charges
> @@ -898,8 +900,10 @@ At reading, current status of OOM is shown.
>            The number of processes belonging to this cgroup killed by any
>            kind of OOM killer.
>
> -11. Memory Pressure
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +11. Memory Pressure (DEPRECATED)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +THIS IS DEPRECATED!
>
>  The pressure level notifications can be used to monitor the memory
>  allocation cost; based on the pressure, applications can implement
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 07343e338e4e..420c7d15f12a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1913,6 +1913,9 @@ static ssize_t memcg_write_event_control(struct ker=
nfs_open_file *of,
>                 event->register_event =3D mem_cgroup_oom_register_event;
>                 event->unregister_event =3D mem_cgroup_oom_unregister_eve=
nt;
>         } else if (!strcmp(name, "memory.pressure_level")) {
> +               pr_warn_once("pressure_level is deprecated and will be re=
moved. "
> +                            "Please report your usecase to linux-mm-@kva=
ck.org "
> +                            "if you depend on this functionality. \n";

Missing close paren? Extra space at the end too.

>                 event->register_event =3D vmpressure_register_event;
>                 event->unregister_event =3D vmpressure_unregister_event;
>         } else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> --
> 2.43.5
>
>

