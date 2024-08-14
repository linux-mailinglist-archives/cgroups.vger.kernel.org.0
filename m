Return-Path: <cgroups+bounces-4250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB158951742
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688CD1F26403
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C7145B0D;
	Wed, 14 Aug 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HmGiSlZt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A972144D0C
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626031; cv=none; b=qVP+LIdZi2tV9XX8zWhymoJeQAuuc+pTuGJ8wPlHcdEcOXpvgmbVSRqIoHyKdXAYQXikzWkNyZMgKwUmmvIOk7AQBZLpqtOGNeeW6YLbB85QuxhK4d/LvQUG8p5iLMzwlw/y4ZGbxwqrHNVse1czHuh59rQNhp+yFVS4husu7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626031; c=relaxed/simple;
	bh=b+Wtda2iYnSZWvMXTMr6gkdKX03az6OeFmtiXJm/YjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klcQYDBWqCzaIG7/8jcKpZpDqVn7F5gzPILUwbW4KA1PfltrboXDRo34X5glcXFEMMGsV36PUJhW+sZ7R9/v4AtMbjlaOjlL9/ohg16P4QhJRpN6gN3kBCJ+fD5MigHel/nKw7GpmGIAFdiaJ1xB6ZsXm8r2TQIWOEM6uT8QovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HmGiSlZt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so34363245e9.0
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723626028; x=1724230828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0VrBpxRv+L1cvAlfJueXS2O7eGCDgmOcojPruWBRGc=;
        b=HmGiSlZtPHtMu6Tr6FgJI7INgaO2iTNqxSTMaqfZ7UNkvQFhqeKy3Pf/U3MPs48ton
         vIDoLmujNkdCzSoDyscim45CgnfT6uqMM4Xt5AcnIbd5p5mR7uORnfuchLFQAww05BAV
         DzJSif34yz4Y364ddhydnsz7HB+7JR0YrPe4jYy0c2bbCXczczFlAp38wVeKVVPsBZdJ
         szGLKjt/hsJp/SfxuFT4jnAL03XupnLe4Xf2BClHnCpzfFeY7UHKmmoUO4OQ5aFbrDR9
         Gwf4vs90N3NgUOpWGEm+ev38OHHrVq2WTswb76Y//MEK1MYRdLwnSAyh5okG6iZEXDft
         Sndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626028; x=1724230828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0VrBpxRv+L1cvAlfJueXS2O7eGCDgmOcojPruWBRGc=;
        b=sr8lFlkvYgXaUHY3mGYETA+0blDM2vxTgbFbERv/QIB2L+ONz6hmw4VyLIxNykQQVw
         +YgSjf20qA27FvWbmN6qbG/EvmROFbVEItxI9Dza0wIiVV4TLgRAdCuI2V5m89+RE2+y
         1dbkmxRVg+b5bt79+l1aCVH0fZgKXZbm/IQRa4D4UAFJMQuqPQfxhOEGTH04Nu7Nv+LK
         TV3lcCu0FUCrSsu0zo/YTlK6m3nn+yRW3+J5KeWo/vrPKl90BNUwsj+FNb1TwP8w20PZ
         sY2zRq511Ql7mIwdMr873LClPYhDI/bGlf1dM8tGRpd+gihjB7jb0Go9NjOia3wxe7Td
         n1SA==
X-Forwarded-Encrypted: i=1; AJvYcCU2XQN3gryQN/cIAee1vqZoma80Cvd2z1Jg2tBvn3JzN8QCvYUHo/fsWppfpUhtDTCN5ovoJ/oMiCx88jUUsb8Ya5QvpDeIkw==
X-Gm-Message-State: AOJu0YzHYwHNYgPN9d9xaOYsNcHsYfVFiBIPFodgO7ytmTqcLZjcDYKJ
	6RGCAdIyhKxeSCM4nO/gvcDyuLNtrr74Bel0wzyUO8itVkySzsWUK7Dt6T7XmY0=
X-Google-Smtp-Source: AGHT+IFyfm3ym+AqlP5pRWLc/xKd5ydJyd/NB3v7AWxcNKzihK2+5E2i19SYg9/O9xIa5ABkRI0+Hg==
X-Received: by 2002:a05:6000:1a8d:b0:367:8a2e:b550 with SMTP id ffacd0b85a97d-37177832cd1mr1808313f8f.60.1723626027663;
        Wed, 14 Aug 2024 02:00:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3717314e38bsm3500857f8f.97.2024.08.14.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:00:26 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:00:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH mm-unstable v2 2/5] mm: don't hold css->refcnt during
 traversal
Message-ID: <qh77aw6nnsytwtux6f2bkzmene3fzrh4skegvqktlw4b47jgea@oxovqnsrulef>
References: <20240813204716.842811-1-kinseyho@google.com>
 <20240813204716.842811-3-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nj7zfqzlclqebzss"
Content-Disposition: inline
In-Reply-To: <20240813204716.842811-3-kinseyho@google.com>


--nj7zfqzlclqebzss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:47:12PM GMT, Kinsey Ho <kinseyho@google.com> wro=
te:
> To obtain the pointer to the next memcg position, mem_cgroup_iter()
> currently holds css->refcnt during memcg traversal only to put
> css->refcnt at the end of the routine. This isn't necessary as an
> rcu_read_lock is already held throughout the function. The use of
> the RCU read lock with css_next_descendant_pre() guarantees that
> sibling linkage is safe without holding a ref on the passed-in @css.
>=20
> Remove css->refcnt usage during traversal by leveraging RCU.
>=20
> Signed-off-by: Kinsey Ho <kinseyho@google.com>
> ---
>  include/linux/memcontrol.h |  2 +-
>  mm/memcontrol.c            | 18 +-----------------
>  2 files changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 90ecd2dbca06..1aaed2f1f6ae 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -75,7 +75,7 @@ struct lruvec_stats_percpu;
>  struct lruvec_stats;
> =20
>  struct mem_cgroup_reclaim_iter {
> -	struct mem_cgroup *position;
> +	struct mem_cgroup __rcu *position;

I'm not sure about this annotation.
This pointer could be modified concurrently with RCU read sections with
the cmpxchg which would assume that's equivalent with
rcu_assign_pointer(). (Which it might be but it's not idiomatic, so it
causes some head wrapping.)
Isn't this situation covered with a regular pointer and
READ_ONCE()+cmpxchg?

Regards,
Michal

--nj7zfqzlclqebzss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrxyJwAKCRAt3Wney77B
ScF3AP9cGpM5R3nEkhyTYVHmwEk8lBkIAZEhJSg7XT8+mjoBAgEA8MHPEk593wkd
iR6vP0rVJwmIoAqYDttw3aJO8G+bXA8=
=7ASr
-----END PGP SIGNATURE-----

--nj7zfqzlclqebzss--

