Return-Path: <cgroups+bounces-8559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41FDADCD01
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 15:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56E7401609
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52B6199E9D;
	Tue, 17 Jun 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M0TvgCGb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156112E717E
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166196; cv=none; b=cXpsn8+KchbJmhhaLPoCKaAxpsbR2lXkji/bckwE8vhcrZfoeO2BT0J/n3jPNwkncjab3ATOHK41Gbk9t7Pm+nk1zmw0Fqn9amNynHUtba+kdRkYpIYPXk8wTDP3cTMKTMrdUiRwplWYHQzPU4IIRYxeBfLExUAdfhtpJ+cl4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166196; c=relaxed/simple;
	bh=vilBjKqDGQ25FawROby/z0qFfVJPGzxTS8vaHzO1axU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4V/HgcPsjLmdqwvLAA2Kq2OYYmgT7+kGZuMOQwPUr1saciyvgCjrQnOWFR03xQADP4ZqpBuhANTaF2YQKh9Ph4HZ/L6GB9G9sTNzKtrTPx3B93pvBnkwm9RZtVm/4+Y45ZVjPDJYHQrm6EkXJqALtcEhD9xln/BlEdUJBnKBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M0TvgCGb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb79177so35030475e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750166192; x=1750770992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vilBjKqDGQ25FawROby/z0qFfVJPGzxTS8vaHzO1axU=;
        b=M0TvgCGbFDwLL+XmxdhJjWspu+iw05bJDIX0ivHBOo/cnw/dGH+ehsX6o6fBon397J
         A26OjIKQx7EkkZG3bhkm3rsnRAAyGxgVuJHFvr3yttori0s3rUtHLbGmGOkG8BmLmtFR
         CyG/1GkX9WF47ZGO+5m1C2/GjfCYFLGdkqKu6LKLmyxOPTiPdYCei5XpCCa5h8oWwXcj
         IUMjxf4r0j37LjhBg+YuSf7SackfiFV2znZIPD4cXL36FV6p0DtD8+MtIX8wSg9M+gNq
         LSE28JoQQfQpP/aV4HxHy9b1TRwGxzrWBI42bvPVIoLiHwt4Bkp6liHi8kIKYdZux+SA
         2FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750166192; x=1750770992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vilBjKqDGQ25FawROby/z0qFfVJPGzxTS8vaHzO1axU=;
        b=V+en04Uqyb3MdhxBze8QFCLj9KshN4R54nZmgVebBxWNnSDuMpScmdc9VSFqY1GDYc
         iQc4t61VeWXUuo5jN55k8MfzP/iMBOYILRh3ntMPISU9iAcr+FDL7MmtRYbGvl5ZrFXm
         90n6fknqTQnAnwFKWeWndB5EgfRJ9ZwFmBOAryzlF1asUiQmq4PB+w+rZa7Raxj3uWBz
         yB/rrifHxBtKxHgJkcEMEBUwwl+ffkmgxYsHNLWUwNOn9EtAybEAr6jij/tz98GDWU5R
         XHkC7GpXLFIAy3FTAAmKJJj1m+4YqPj+4vf0mQfeT/q758XttjEpx9PuOsTX+YcdT27k
         tG5w==
X-Forwarded-Encrypted: i=1; AJvYcCXHirzKwH0/HHlKlc/nVSTfIYbgtqfsgzzaQeEelFUyn/PtbbacIKe8Py6fWn7CkqrDWjD0KtyM@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmS1hLMKhLNtHgr9N2PWuoOQKnlp7outjbJvzDi9QiaRE9maN
	53bdT+hgd1y5rk34YATOQffMQ0f8Ioslzo3r8b87WeHa11jw8WHqTyhweZxKRi9JgpA=
X-Gm-Gg: ASbGnctT8f8MnebtuB5+kWDG+xaDJ9t0j2oK++Up2/DYMiyWCsKDNFm3fOEZe8tCci6
	iHtUpR/GBIVEIDAHUK6WGn83gYPpIZUPKZUpUBCzWUl8uOD5tRmPdr0n0CU2c7vaGC8n49kZIsk
	aCHCNZhe8x7Rh4PL/f7N4UcDEuJjN6ScggVu1xSKo0zJuPcv9fP/KCKAdpvRj7+fllu+2qRjBHC
	pQNmMHzysGtsDsAzNKyoJwwkLZBixjZKfyEYmwV/R1ee50LupGVV5tzyhof2YimhBfMKo2SbeND
	/s94Ikie7Ei5m8YIvnOCXS0MqWeNUSumjaL31tgN2q3A0pac6lRgGTXJbR0tjZOn
X-Google-Smtp-Source: AGHT+IHysJ08+pzr7UCdPT0UGdBC9YYU3cJA+cs7HKuUS6c65alf3G9CO8oJ2h20auenaGh6kPbrag==
X-Received: by 2002:a05:600c:4f4a:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-4533c9efc7amr139976505e9.0.1750166192163;
        Tue, 17 Jun 2025 06:16:32 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm178254615e9.4.2025.06.17.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:16:31 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:16:30 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <ftih3vsbegjha32tjoktayjyak6zs6n7cbfuwzjasutexqiluo@pjauxm2b6xmn>
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbtvuy725qgnutu4"
Content-Disposition: inline
In-Reply-To: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>


--tbtvuy725qgnutu4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
MIME-Version: 1.0

Hello.

This is interesting.

On Tue, Jun 17, 2025 at 12:26:45PM +0200, Bertrand Wlodarczyk <bertrand.wlo=
darczyk@intel.com> wrote:
> The kernel currently faces scalability issues when multiple userspace
> programs attempt to read cgroup statistics concurrently.

Does "currently" mean that you didn't observe this before per-subsys
split?

> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,
> which prevents access and updates to the statistics
> of the css from multiple CPUs in parallel.

I think this description needs some refresh on top of the current
mainline (at least after the commit 748922dcfabdd ("cgroup: use
subsystem-specific rstat locks to avoid contention") to be clear which
lock (and locking functions) is apparently contentious.

> Given that rstat operates on a per-CPU basis and only aggregates
> statistics in the parent cgroup, there is no compelling reason
> why these statistics cannot be atomic.
> By eliminating the lock, each CPU can traverse its rstat hierarchy
> independently, without blocking. Synchronization is achieved during
> parent propagation through atomic operations.
>=20
> This change significantly enhances performance in scenarios
> where multiple CPUs access CPU rstat within a single cgroup hierarchy,
> yielding a performance improvement of around 50 times compared
> to the mainline version.

Given the recent changes and to be on the same page, it'd be better if
you referred to particular commits/tags when benchmarking so that it's
unambiguous what is compared with what.

> Notably, performance for memory and I/O rstats remains unchanged,
> as these are managed in separate submodules.
=20

> Additionally, this patch addresses a race condition detectable
> in the current mainline by KCSAN in __cgroup_account_cputime,
> which occurs when attempting to read a single hierarchy
> from multiple CPUs.

Could you please extract this fix and send it separately?

Thanks,
Michal

--tbtvuy725qgnutu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFFqqwAKCRB+PQLnlNv4
CJWBAPwO2FSSQNlPj92zV3HJKlnIboB+NjndaeBWIuJw53GzxAD/aMA7zfPeMpx4
86uB3wcvm2dJdtfMWrBlqYUmY7CIOww=
=ZlDq
-----END PGP SIGNATURE-----

--tbtvuy725qgnutu4--

