Return-Path: <cgroups+bounces-4975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0698893E
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188D528342E
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D121C1748;
	Fri, 27 Sep 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqxIcL9b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E513AA47;
	Fri, 27 Sep 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455274; cv=none; b=iOV9BhT1b4iQc/Guv2eZVB4TLLlMJ0DrRl2wrkSDcZ0BjDxulRAZzUVD4vx/KV6KpfMMdibea5dFnvLlNGxvoXmduvXZv9P+lD8oOS41qcNk93Q34+fq7gltzreEx5xa+SMzk8dL+IgAK5JX0HRUeTD5uwoRzt8UHaM3SSj743Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455274; c=relaxed/simple;
	bh=8u5Av3AJg+Z/BbalDYPhMZPtlm215Q5+jjmCKOSVDiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCAn+sv9MNl4ruU+5/rn10M6KJZ3FxQ6ftNpTU6TgOCW21ci+mA9YnNs8wTfix33ojqLikfTyFXUqab2g0jHuE3XT4eVEcUoXG7xEDohXD1SXVcUCvDYxHwKX7yobCRHyhWcPTxOZNuHMdrT6QyCiq31+VGtpreZ3Fwu1o8DVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqxIcL9b; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-458362e898aso15966521cf.0;
        Fri, 27 Sep 2024 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727455268; x=1728060068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3aLam3ii1BoY06ylPVYnFDjPB5q96zwrcB98znTpIw=;
        b=nqxIcL9bP/ZNwH6cesbtIfFEINQtpWjofI7NSC76xxoo3AApbD9Yp2Sgnuwt3REsY9
         XKXj8+IakZmYDQkbB7aFwgYXIzgh/YpjCqM4U9RnCcLpA8dMKt5DzwuYm4It4T4hpZzB
         J0MrDke57vWifF6KxtAmTKmV2urh+32B6zpryr4BkWK8SMCfrf4J7LhwzSvqwlzZuprT
         ZDs5GPo3Siai2ttjkf0jBdd8QTsyIHeUilRfR6JtfEGJeaFvgqyKITbdwgJVLW1pHjaa
         BoDEnwlFmPnKiUwZbvMRuI3uu4QXirhQ1FD58ZMkIlhDkxZiovmx4rb9/5wlHJ32vEPu
         L19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455268; x=1728060068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3aLam3ii1BoY06ylPVYnFDjPB5q96zwrcB98znTpIw=;
        b=Kx4dh0jIoK1+yC5EJtHuvco3MbMj1mfHS1d3dCFVfRcyhz2MrS0s9ZYWT1auB6s6ew
         eAxMleSX696Vic4TkCFOJE0uC5vP+eCPGM9CV8zuW6MX2ELXzgvfQa+fEpAwdOazfU9o
         ev9fzVZIN1n/L+FuvPg4cUlE6OmyFrY9u0a3J48IZy8WS5aJva4+P7pRebTkD6ToK5V+
         c1CsNTWVvvHNJ2r6Jphx5xb2d9ii8xs7U6Z/eoEZ9mbqkdEk7UiFFM3Z28XRLkA2jQzn
         Be6GK9KlOTNcrL3CHstsSx2lyFwgrrxvZ3sAfNh/lwpM76nLyQFN/CYoAMIlwvGRaeia
         Wl8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSIrjiTYUuGd0bwZ8d5Cj9cN6hTBOuRudu0viCl0eORp11oBHO3BMQhJEeqKV1gBkN/z5PnOke@vger.kernel.org, AJvYcCXIQHr9bH4A3Dt0pxmwiwg5P+Yf+ikQwgEZi9fUFEF9SUuSr8irDl/UhnLtNSmzQ63hnS2g9mw3Ov5zcWRh@vger.kernel.org, AJvYcCXvGuqogV/ZM0Z6HKn+MQ6hu2q1SBccX8Q5A83ZYumIb1A0SwWcspyCuiPYYA+pQbE45IQ9dyDNRTR9@vger.kernel.org
X-Gm-Message-State: AOJu0YwboWE2RM7jVNIKKvSvLfl6lJ8wkE41K2lcVE4/XGB2qCucEQuq
	uNe80S2o/VJHqTfMxivziXdC4wuh4QDXhCUIeJ9cRMJIzg0AoEe6e4LtFFslrNHpfZ3jvUxZMxm
	4V8gUFMYpFjzkuuHiFjDIYijQ9JQeRHyd
X-Google-Smtp-Source: AGHT+IHhFxiJIKOZQd9ObN+Bow9DnfeccCKDA+4HeO5e3KFOZo82DqxOsuBi8pqEMQvdlAwG2bxDBPuo1+y+Brz4sRY=
X-Received: by 2002:a0c:fa49:0:b0:6cb:3bc0:c2c6 with SMTP id
 6a1803df08f44-6cb3bc0c330mr53625576d6.10.1727455268393; Fri, 27 Sep 2024
 09:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926225531.700742-1-intelfx@intelfx.name> <CAKEwX=O=Qu4LZt79==FztxFjgBu2+q7C6EDji-ZmW5Ga38_dSg@mail.gmail.com>
 <5hnu3xa5hcusvmvg37m5ktsfcutghk2z3dh7lcoctyyfluabqv@u4ma5mafchpw>
In-Reply-To: <5hnu3xa5hcusvmvg37m5ktsfcutghk2z3dh7lcoctyyfluabqv@u4ma5mafchpw>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 27 Sep 2024 09:40:56 -0700
Message-ID: <CAKEwX=MPtsX0OexWfL3j-4TcPuAdoDWP4E2BzehrkFs67bTv9Q@mail.gmail.com>
Subject: Re: [PATCH] zswap: improve memory.zswap.writeback inheritance
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Ivan Shapovalov <intelfx@intelfx.name>, linux-kernel@vger.kernel.org, 
	Mike Yuan <me@yhndnzj.com>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 8:01=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
>
> What about assigning this semantic to an empty string ("")?
> That would be the default behavior and also the value shown when reading
> the file (to distinguish this for explicitly configured values).

Yeah that's better than -1, I agree. Still a bit confusing, but at
least the semantic is "we are not making a choice at the memcg".

>
> (The weirdness of 0, 1, -1, -1, -1  would remain. Maybe switching this
> via the mount option could satisfy any user. Admittedly, I tend to
> confuse this knob with swap.max.)

Yeah a mount option, or in general some sort of global knob (with
proper documentation) would be preferable.

And yeah, I hear you with the swap.max confusion. That's why I tried
to make it explicit in the documentation, because the difference is
subtle and can trip up users. Hopefully, when zswap and swap are
decoupled, users can conceptualize them as two separate tiers, and the
confusion will lessen...

