Return-Path: <cgroups+bounces-5860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C69EF462
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D8D28CA00
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4F2210E5;
	Thu, 12 Dec 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MV4nfPeY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FD4F218
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023225; cv=none; b=hFtT2X6SI1SG2ostInh+VGKOEG6mFnHwNC6n6fr7rSnmZdmbuh1hprHDtb7I32i2zt0X1gebrRhrFqrEA3o7BoqaYglmgli0ZklAbQvbHJzNdSOT2whE6JPYutMQ+0krzrypKV4rCAlqOysIY6KyHBO09+h1atFERx7s5xkAMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023225; c=relaxed/simple;
	bh=6x6ZloTOP8xG7QluZoqD1vHcIrDmSAcWjBCNgzaKeTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh9P0VKF3Mjebh6kIueJmAKnL/w5fGcZG+2v4DpY7kmMqL+HjEh0owjLwBbu/eZGNjQCsNUSM1OXYoobmKGR9+LrVL4ZHbHWpzg81nvx+WpRAEg6lU/hJmcwB/tstVejdAc28Nkg2X/68CF0VSWf2lH91PnleNsfk5gu1GuE7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MV4nfPeY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8ece4937fso6246166d6.2
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734023222; x=1734628022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCU6Io7K5lloOjr5AqAuJ1H3CWWQOcWOOH73iAc8mqI=;
        b=MV4nfPeYWQRMNACsO0m5W8xd9jqjrj3aXmUDAWGS4eqylzIPbs8mfSBTaYFPGXUNjF
         jZh8Lu5ceTmR12aztjrXui1HdHLCC1B1RXDsOTJB38Yoq7yn8WgM+CIvdF2xDJYu9lUH
         DWWd/EPU8TuuIUesTzM4o4/YjdgdVQQiBDIaNgmSFCLZz0s7XPORuuwpFg3PXrGWTkuL
         RqoIBwjwl4C1hZJCRKtbJW7JaN3RdK+tdFSJF0f829y3vh9f8vz6mXSesCCnKEjBzs3I
         pwi2KbFNdLBD/9LDMOvdKLkj7WOLga1q4Dqzkx+viiPvtZeNymav6M1H4W3UMKSyW/Np
         Nc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734023222; x=1734628022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCU6Io7K5lloOjr5AqAuJ1H3CWWQOcWOOH73iAc8mqI=;
        b=LEdWORwXXK6vNI7eM3qRzL8lsMknXchEp/L47kCc/x1Ba2+t74rNaA1Qb6C/cp8pAR
         V8KQbu1/MowRPke0EN+bk/ZgLf8QYN8i4PiZzCjxsKtLr8kHo7xRBbLft/5qlDsaT8HA
         3QTEHhGKiQ+Uj5Obj55HDz0R/iddsv/ofpPp3zIzexj38rdkGqq9JmMTgSrNs0eY7aJp
         twFVXsRAPYu+b+qBKAeGnQ6RKa1DZ9qMwVxtRMBX9t+hstFPJ6jUFkjmEZuthSZZLUWK
         iWdbjEa00PVryoUIxA9/X1PcOV0RQj8JnuUr/gaNZWnZf6QLrlZcnLGpC9au0+auZwQf
         oofw==
X-Forwarded-Encrypted: i=1; AJvYcCUue5+dLS8mteewScaQj8KVFphN3KxyBMTED2magpGubDtH94tc7/nz/da2o6F8a1U7tjPbh3PX@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmFSji9tqRnaKYWZDeX2PUxdFkzfo2Mqx1JgGWuPx3FzQGlT9
	vKEDm4Vyzpr/umOuyZwaXHYSwMiJOwMSMrLl8rLwozXqBc9eHssu19CH7H5p5Q7bNkhveJYZGkn
	gzIglB0AfXfDtvlBITi2Q6lJH3HklSoYnmBfc
X-Gm-Gg: ASbGncs+AR4QIITxuIgKx64jU5rL25J9lLz/+zWms3hMx9ryovKvzvgjdpBkCaIctJv
	8bzV+65M5B4jOFctESgeHFNEolOYCyGrEsDI=
X-Google-Smtp-Source: AGHT+IEWYnxKGd+UY4guVytg68DPFmVI424eT9T154/j96Ckzc2xwC/UXvDBjuCYYXtvEZKkQodesHCobvjymkaBzwE=
X-Received: by 2002:a05:6214:1d04:b0:6cb:edd7:ac32 with SMTP id
 6a1803df08f44-6db0f744d63mr13338916d6.12.1734023222307; Thu, 12 Dec 2024
 09:07:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212115754.38f798b3@fangorn>
In-Reply-To: <20241212115754.38f798b3@fangorn>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Dec 2024 09:06:25 -0800
X-Gm-Features: AbW1kvYqCkeLbtm1kn4Hmr1w3G_jj-nRHwu7-NDzHzt7kzJ52IijDm_4rEdM63c
Message-ID: <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
To: Rik van Riel <riel@surriel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	hakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 8:58=E2=80=AFAM Rik van Riel <riel@surriel.com> wro=
te:
>
> A task already in exit can get stuck trying to allocate pages, if its
> cgroup is at the memory.max limit, the cgroup is using zswap, but
> zswap writeback is enabled, and the remaining memory in the cgroup is
> not compressible.
>
> This seems like an unlikely confluence of events, but it can happen
> quite easily if a cgroup is OOM killed due to exceeding its memory.max
> limit, and all the tasks in the cgroup are trying to exit simultaneously.
>
> When this happens, it can sometimes take hours for tasks to exit,
> as they are all trying to squeeze things into zswap to bring the group's
> memory consumption below memory.max.
>
> Allowing these exiting programs to push some memory from their own
> cgroup into swap allows them to quickly bring the cgroup's memory
> consumption below memory.max, and exit in seconds rather than hours.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>

Thanks for sending a v2.

I still think maybe this needs to be fixed on the memcg side, at least
by not making exiting tasks try really hard to reclaim memory to the
point where this becomes a problem. IIUC there could be other reasons
why reclaim may take too long, but maybe not as pathological as this
case to be fair. I will let the memcg maintainers chime in for this.

If there's a fundamental reason why this cannot be fixed on the memcg
side, I don't object to this change.

Nhat, any objections on your end? I think your fleet workloads were
the first users of this interface. Does this break their expectations?

> ---
> v2: use mm_match_cgroup as suggested by Yosry Ahmed
>
>  mm/memcontrol.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..ba1cd9c04a02 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5371,6 +5371,18 @@ bool mem_cgroup_zswap_writeback_enabled(struct mem=
_cgroup *memcg)
>         if (!zswap_is_enabled())
>                 return true;
>
> +       /*
> +        * Always allow exiting tasks to push data to swap. A process in
> +        * the middle of exit cannot get OOM killed, but may need to push
> +        * uncompressible data to swap in order to get the cgroup memory
> +        * use below the limit, and make progress with the exit.
> +        */
> +       if (unlikely(current->flags & PF_EXITING)) {
> +               struct mm_struct *mm =3D READ_ONCE(current->mm);
> +               if (mm && mm_match_cgroup(mm, memcg))
> +                       return true;
> +       }
> +
>         for (; memcg; memcg =3D parent_mem_cgroup(memcg))
>                 if (!READ_ONCE(memcg->zswap_writeback))
>                         return false;
> --
> 2.47.0
>
>

