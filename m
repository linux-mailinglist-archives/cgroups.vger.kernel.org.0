Return-Path: <cgroups+bounces-4282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721495260F
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D91F258EC
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0A514EC79;
	Wed, 14 Aug 2024 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE/MFm5w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377F14C5AF
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676314; cv=none; b=mYArCpdEIi7XHC0D2GxhsMut2yqyI+lALkxPsDu8v+mWqbchjJU4MhZlGqgqgATBkf88sVJHydW0J9JCSwtr8n2ux6J7inoxVmLj2CEGmCfgsEwjmG364GSwNUOD+7l9taifVUUvzDLYfn+Mlg2srFQl1jlmnk3KRE1rB1/LLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676314; c=relaxed/simple;
	bh=sEi7TbGO5Ntmfn1pMdHe8wajqxgmYCz4bKVOA5JfU/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gp6iLiku4z87arDDoPnTPu8aXS6cMiDEcCuCp3Xcizykwx9K7lSDy46+GBR3tP6KPMtjepm1VHopFMXdOSkgwf0I+RQDhjQt3qdN/3BadkDBxE06w5sibHpZJi0EQS7iZszDmmgPt4fzfnzB/JG669qMmt7FCpLv8RPcwpp5dTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE/MFm5w; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690ad83d4d7so4386647b3.3
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723676310; x=1724281110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUWhNpMZkVm29wzcKzyvQXZAILOf6Dv4XUMwNXkvgdM=;
        b=lE/MFm5ws8bJAKH4HcVUqvlxk56e5Mc/rjdt7xJVKVcSaqH3GsxaspWUvHKRusE1Ru
         pf/eYRayXZ6IaHQe/dy1xhPSBvDb/2KedDKPFqbvoGFBxt2bKtLj9jcT/MZF9/4wmFtA
         /yIHMVzd0D5Eh8BLdTOwPFbiY9fwbDXM+bEJeBgxwDZq/ok3XFDKsSQfAo+92760EoaP
         XWjRX9eYFgooqh0XzbHozG+4NKe6ownpRznGBD4REz3AxcnaDVnj6+qpakPlu/HyWu1/
         qyor267bS3r99LDTNYE1AJoNti9vwQMFWZ805mPXt8xEC93QkjJ8KDFZwXuVI015V3/E
         Q20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676310; x=1724281110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUWhNpMZkVm29wzcKzyvQXZAILOf6Dv4XUMwNXkvgdM=;
        b=q/PBaFFhkqt+0fwdH7W5ZGy6Q9rjeRdFQ0HCHVnaRm1UTjcvWZhF/+XmcreZmShnN8
         XkbragkWEhO3u+FVTXZpVRb9qy7jG70cCe3cgK/Azdm+Q4sZwZlg85b+yAMEKCi/+Izj
         iOf385AYU/m1dP6/FerfNKRosHbz/wVWV2ss/BiQWBezA3aat3i9X4VIBbgOJ+TG6OMv
         Jgb+DGb/kMy+UJ7SzifNoHNMyqOZFWohWVh6Eb7YwNVY3jpDVKN7c61bGR8ac4YHzBGQ
         PDOIACkjYBXjki/72BpIpw4cqUfPAEMgxQgKE00TdmL7w9q0RkiLcdgt1T2/CEkj0unG
         D1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Gorj8nKZkltEfPzW1hi3fI02trVG5uVR12lDSiPkHd/U1MRWq3GpjEOo8Vg49qSsPWKVvpULBDDWfmlL+Oflzj6cRVhMQg==
X-Gm-Message-State: AOJu0YyCrNOzdfRRjyaBFn9+Q38I+hLLQZefPzH8ual/UrHPhBm5chl3
	xO7y2dj2kXJV9LTWew5yLsKlq723HM7lR5SZuYfE1GJ8IxUuovenhWPc2/FB39kTUTvbYAoYcU4
	T9VO3RAcuHaUdMtVpRttx8UIY7NmZttO06O6y
X-Google-Smtp-Source: AGHT+IH159x/1XCLV9wWews52LhEjNNWRHC/963OVVJzDAiE2ggKEqH5sqJkpLLbOepWnA2AvwREk7Iozx3FPc4qEkk=
X-Received: by 2002:a5b:60c:0:b0:e11:67d7:e7cb with SMTP id
 3f1490d57ef6-e1167d7ed0emr2635021276.19.1723676309851; Wed, 14 Aug 2024
 15:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814220021.3208384-1-shakeel.butt@linux.dev> <20240814220021.3208384-5-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-5-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 15:58:18 -0700
Message-ID: <CABdmKX0Kv57Lo2xC7mJXOePObFhkCDdr1mAK71nurXZOQNVDPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] memcg: initiate deprecation of pressure_level
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The pressure_level in memcg v1 provides memory pressure notifications to
> the user space. At the moment it provides notifications for three levels
> of memory pressure i.e. low, medium and critical, which are defined
> based on internal memory reclaim implementation details. More
> specifically the ratio or scanned and reclaimed pages during a memory

"ratio of"

> reclaim. However this is not robust as there are workloads with mostly
> unreclaimable user memory or kernel memory.
>
> For v2, the users can use PSI for memory pressure status of the system
> or the cgroup. Let's start the deprecation process for pressure_level
> and add warnings to gather the info on how the current users are using
> this interface and how they can be used to PSI.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>


> ---
> Changes since v1:
> - Fix build (T.J. Mercier)
>
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 0042206414c8..270501db9f4e 100644
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
> index 334a02597d9a..52aecdae2c28 100644
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
> +                            "if you depend on this functionality. \n");
>                 event->register_event =3D vmpressure_register_event;
>                 event->unregister_event =3D vmpressure_unregister_event;
>         } else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> --
> 2.43.5
>

