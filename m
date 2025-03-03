Return-Path: <cgroups+bounces-6760-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB8A4C4E4
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 16:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322F67A9C22
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383CF2135CB;
	Mon,  3 Mar 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zj/amn1Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89178F40
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015233; cv=none; b=dmcKd2LG9wNfgjp4w+XwR/HFNEAqkntEd2MkYZQHVjW36q+ViQArMIVokTrbpnR5X/jJ+IYrAGXINlPL577Nm+1Czo5xYNya82gpH931iflYmUHFx2rxL7hFZ8m6bLbDTPdK525etLakiApIiucRwj7MlnKp0AGm7/88dWVHsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015233; c=relaxed/simple;
	bh=nf1qPTktPOQVgidFTphoJxaGLI5IF+vbYLTNZpaLZ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnvHWurpv8530HTlRiJEZs3Ane1Sn3x1zZxm9Oyym+oGIsIVbCAasRhHoCWPc1DZJxu8nYmZToHphJhtTVB2ALVA12XaSOwXKVnAP6NPqD4efJkDKGUmgW+APoLBLYCpMxvL4J6rTq88NZn8fKHv08O/ZBFBJmExTjK9ShWc7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zj/amn1Y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390f5556579so1566441f8f.1
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741015229; x=1741620029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PT8hIH46ghzeJYoH2LwftKa+OP7HKfkS3jL/D2rOeU4=;
        b=Zj/amn1Ys7nXSKnytuqgJCakXVD+mFKX9b3R/k9vUzK40xUCEhi66wvHHSuuoO6Pnw
         d0EWMCXANcpFCA6ZDL31CgzLVSGEBZSeDiMSyzxxt6RBw6pl6ZmCmkvdXXJ7jJRTLGW2
         Tqtp40GzN3qL61aUinj4He1Gj09HY79IliEDQ2EpQ0OT/ET4FxzZqfqEnVnrcC97bAeL
         lI9CRtGcA0XGcnTaXNjv7AJZMDaNYnPVGwz0OU/RnVNodQWHzW+/EwV/sJr2Y7gsNNpL
         p8o8y3cJQ8D9oNqpayg9eZKYXsCtAuW+r77I64s1MTdXOe5oZiR5YylMDvTBQzqm6F57
         TySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015229; x=1741620029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT8hIH46ghzeJYoH2LwftKa+OP7HKfkS3jL/D2rOeU4=;
        b=mcIvrVXWDbvrXYqT2X2akFITiZSe46ofaxGHryDpVUopb2gy46KCXRGAS57phKbdP9
         EAgVfylk3lh0GDNWvATM6zcZnaHH4fZADzxGOT30dMztUNZr4usRXGkmQrxpxgL9oTx9
         WWk+xqFyJvaTzqTY5gOMvIQpSmWKHaux0dd7C19hA4fnxY9/ZuCQ0I2il3Pct5UOvl5s
         SV5uXhO0KR6PagjnRwuxtRUjzyc8yZ5K1akLYF4B+/CO/1ZeLCvUr+p4kGfNNUQqtNYr
         DnVHpIIB62oFVM3tHjnPMF0HIzL2S6i0Eeianr/89ezeAElIH8SNvu+UdA+VwHb0+wkH
         ZM7A==
X-Forwarded-Encrypted: i=1; AJvYcCXTbIHsXcJH5z39jqTBT/SopdT7sz0KroUaBKb5+AkNrM79NIJvmQ76R/E1Np76hquVnowEytDe@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJjnGKwb578p3egqPRDkEF31T5MRANXUNN+H9T+cgTGMQDMRO
	oC1QGIoM4XQ7c3fAdyRLLGthT7tcPo6TchlIM+NXw3UHHVkfpk2czBWW7eZx3ZE=
X-Gm-Gg: ASbGncuRqosme7KL8IzGZgoDocIGojDPD7FLVieNLAAyx+c1uvkZ2GQW46BrhTLEKss
	bq5sbLFWvnzSXndXEIRI8ZJFoM2YhKgBx52r7BS2H3RaVkwBtqLEF48p1Mws/wHPhZNCABGdBlH
	X+SbxbOIohGidZi1kuLb7f0QGPMxNCHPVjlYLKQt1sHcSLS7Yh5MupG7Y+yQEgaS8DkO07erNEO
	5MjojHLspXF4nfKw2zsnF30s4vpAwEIR25rY/3qYMQ+t33FWDazTPub6zxdJOLuowuY+hVszXl+
	q68xbYMAvy7h9qyqqOf7QuCs3FxsPYr8dRZn4eKpukow+ig=
X-Google-Smtp-Source: AGHT+IFgcdKlV4KN4Ns6CbroK7lY5wl/9jYO7RuRWHGQ+RkhY0tkO1j5V1H+eO9bwNfsdUP+Zaa9bg==
X-Received: by 2002:a05:6000:1563:b0:390:d796:b946 with SMTP id ffacd0b85a97d-390eca414efmr12713565f8f.44.1741015229384;
        Mon, 03 Mar 2025 07:20:29 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e46f580bsm14580280f8f.0.2025.03.03.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:20:29 -0800 (PST)
Date: Mon, 3 Mar 2025 16:20:27 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
Message-ID: <gilziqko6ynfgvi73fljk6uc56xgipbdnsoxllg27vmhl5mzix@3ixl334f4aju>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajgjukcubjc7bifs"
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-2-inwardvessel@gmail.com>


--ajgjukcubjc7bifs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
MIME-Version: 1.0

On Thu, Feb 27, 2025 at 01:55:40PM -0800, inwardvessel <inwardvessel@gmail.com> wrote:
 ...
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
>  /*
>   * rstat.c
>   */
> -int cgroup_rstat_init(struct cgroup *cgrp);
> -void cgroup_rstat_exit(struct cgroup *cgrp);
> +int cgroup_rstat_init(struct cgroup_subsys_state *css);
> +void cgroup_rstat_exit(struct cgroup_subsys_state *css);

Given the functions have little in common with struct cgroup now, I'd
not be afraid of renaming them to css_rstat_* so that names match the
processed structure.
(Similar, _updated and _flush and others.)



--ajgjukcubjc7bifs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8XIuQAKCRAt3Wney77B
SV94AP4saMw3ibrbjwN8HcxInkXlNMb7HYSvooBl0KbOqGTUbAD+KN8yJ7U3s4M9
mdHNJeONgwAI48p7vxXj8a5rTz7O6g8=
=wP0y
-----END PGP SIGNATURE-----

--ajgjukcubjc7bifs--

