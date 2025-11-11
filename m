Return-Path: <cgroups+bounces-11825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B4C4F874
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7011A4F0BEB
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59458253B42;
	Tue, 11 Nov 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YU38gCer"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083E19258E
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887682; cv=none; b=YZGpG7Te92vLgUUA3N8BIhwW96T74ExLNe1qVeqQjU0qULk7QhZ6voEM+cTuIUncyJvkkFjch6og5YlvD44nwoiPA/CSqtOBMJkoDWTjQGmeO/b0p+ZO2j4S/FccZUBCaeIR6I05FNLWneqn19YztB3xkR/MMX3Icj6pzblCKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887682; c=relaxed/simple;
	bh=Epb41NgFerG0tgs3sczL0A6VdBeDJhkEgRYHHk2JhIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHOnUR5QhKRYYOjtNzvwIPuJ9B6+/SEKfNBTK4oB3zwW/F+ULc5KGXTXVVCl4h0MtnOaa+dQvJquABECjGptB5vPueC7W/Zy7qnfL3dKXPAerfyYvjyIZdDxFw8C5A4GxtVBM73+usey3Ie+4M5OcJgOguEAsaBsQ8/UrI+JoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YU38gCer; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3b29153fso1632984f8f.3
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762887678; x=1763492478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Epb41NgFerG0tgs3sczL0A6VdBeDJhkEgRYHHk2JhIg=;
        b=YU38gCerCh3gS7SUuYCEaqWJZryQU/qAZo3ICR4CL3WeRGzzd8iXAYKAgMEwL/Su04
         TEJWZl+a+LZsTROjHKPpNzur5KOSeLTbx33C9qcU4J3SWI7PHiUmBCBpqbeB+kdzoc+5
         MN/wj5iBqvyRF7XLTADRSUrq2iuznPtLE1RA5Lfzw9BbnSmVAiXgZ3b2r37Wa7p4GJW1
         yUidqxeICV6t1ah4aq8ANz3K/sSFRQn1c4fbyzGI5wwnbiUxK2COGAZAHEt9NAwx3nx1
         LrRIwDJKAmHFSC94i+2zn8U2YmKyYtGpvGNCe3hoHoG4OSEFXEiYWG73LTheXZV5tmvx
         HOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762887678; x=1763492478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Epb41NgFerG0tgs3sczL0A6VdBeDJhkEgRYHHk2JhIg=;
        b=XeUyg+P3eD6Sszv56Mn7adwwImy53t3oPeTIzqfasDrq3YJl3NO7Zz+3deN1U+52xS
         z1au/kA5CG7uWnnPPp3SvCxDeePx0Wc0BT9D+wqUBFF/kqGV8ypCMUhApBzy1TPA0dro
         vBVHT9veJODdF4sFfLFfFNQPcMXwd4OtAlL7/HnGxEYWj7Xwy465G74f17dRqNlvKqRj
         891P9wYmJ2MqiGg5R6R5pohipORF+DKFxCpcZnxIs4GOFKXIpfg4WKdzWHJYpYO32ODv
         O9+CrtD7YdguHf1vaB4NAdNcgnhwaGmyAmxup8GTgQiir9xXMK/gcd6vyHMBlUkZimwM
         Ih4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbY5H1JzM6u02d868vtdM3qzWF54j4KLPlnZEV856qmvi0W9bwRbN1MEWqrlVCrPlTlR2OATsf@vger.kernel.org
X-Gm-Message-State: AOJu0YyGYb2hSDt9bSIMryWoqz+TuQTbyvGRGs2WrNncCVzrFgDsg4xm
	AfscLPb2nmZQHs/0L2s7zSZjBu9FqWXcKdtJ4RwAvqMJZ0rR40vCdr0cxgZS9b6RVJc=
X-Gm-Gg: ASbGncuD7UCZ/JEniPB5UAzIx8sON1Mci5dA5696GnihqvHJC+EsGafhiNjCNcoTWwx
	QGPSpJ979t20Si1HDsmWkjFcQ4+vc83AqRiqz75Pyt4doQ7z/Fyk6qhkujv6UG4KO1RGR+jHMne
	vXdMQN72gvr7u4V1YPClq5IDzAcrA5z+XN2RgeD3XezCkiZHISLYMqo2M/Dc5u+eQuKQxNA0TVS
	uTWVhTEhg6hMVr4I8KSDvH4j2nOwP7ikJou/Ajbv29UFw9jDXFkulwgoLHbVTpFbYr0WXQUBcL6
	1kKDZX56Vcq5VUAOgzFpkf3aEiir8wvptSK9ZUNJG+swKZ3qvKFuX1IiqtHaNe8v9akPwOUyMlb
	w2brPIeBHbwDTZbXH5W0qjPnjgBhLIQYpXKSdIjsccAyB3zmoiG8c8CP3qwcrdeqW+q9LBtHmiw
	Uj3ghneCqpdd3QzLqU1QhBJGycJF/rpW0=
X-Google-Smtp-Source: AGHT+IFjd4Z8ZyYwgjnX/oawjyx5P78Okty05jRhzRxhhnb1ZsNUnhRLUldhAazDANfsJjvK+WSEYw==
X-Received: by 2002:a05:6000:2c09:b0:42b:39ee:288e with SMTP id ffacd0b85a97d-42b4bb8b9d5mr281057f8f.13.1762887678240;
        Tue, 11 Nov 2025 11:01:18 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2e052f32sm22848861f8f.17.2025.11.11.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:01:17 -0800 (PST)
Date: Tue, 11 Nov 2025 20:01:16 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net, 
	hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org, kyle.meyer@hpe.com, 
	lance.yang@linux.dev, laoar.shao@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mclapinski@google.com, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <5xyq3w4jlewi4gt326exj45piti46vrsqkxnh4jzxmsgl24rm6@ivoslsgvgkp3>
References: <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
 <20251111061343.71045-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="csbfp2a7l72eto4t"
Content-Disposition: inline
In-Reply-To: <20251111061343.71045-1-leon.huangfu@shopee.com>


--csbfp2a7l72eto4t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
MIME-Version: 1.0

On Tue, Nov 11, 2025 at 02:13:42PM +0800, Leon Huang Fu <leon.huangfu@shope=
e.com> wrote:
> Fewer CPUs?

Your surprise makes me realize I confused this with something else [1]
where harnessing the job to a subset of CPUs (e.g. with cpuset) would
reduce the accumulated error. But memory.stat's threshold is static (and
stricter affinity would actually render the threshold relatively worse).

> We are going to run kernels on 224/256 cores machines, and the flush thre=
shold
> is 16384 on a 256-core machine. That means we will have stale statistics =
often,
> and we will need a way to improve the stats accuracy.

(The theory behind the threshold is that you'd also need to amortize
proportionally more updates.)

> The bpf code and the error message are attached at last section.

(Thanks, wondering about it...)

>=20
> >
> > All in all, I'd like to have more backing data on insufficiency of (all
> > the) rstat optimizations before opening explicit flushes like this
> > (especially when it's meant to be exposed by BPF already).
> >
>=20
> It's proving non-trivial to capture a persuasive delta. The global worker
> already flushes rstat every two seconds (2UL*HZ), so the window where
> userspace can observe stale numbers is short.

This is the important bit -- even though you can see it only rarely do
you refer to the LTPs failures or do you have some consumer of the stats
that fails terribly with the imprecise numbers?

Thanks,
Michal

[1] Per-cpu stocks that affect memory.current.


--csbfp2a7l72eto4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaROH+RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiN9QEA6sXoc/oeJj+mDnKkROmk
nkeyTszvrZYKIEtJBQFSBuYBAJ76dUKkXJVOhrMBSE2sGSx9Ye0xq8mM3w8ZTrQk
jKIN
=qop6
-----END PGP SIGNATURE-----

--csbfp2a7l72eto4t--

