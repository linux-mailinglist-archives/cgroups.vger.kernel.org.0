Return-Path: <cgroups+bounces-6789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EFA4CB3E
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 19:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665741893212
	for <lists+cgroups@lfdr.de>; Mon,  3 Mar 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7222CBE2;
	Mon,  3 Mar 2025 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gi7cdPVe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211B215F7D
	for <cgroups@vger.kernel.org>; Mon,  3 Mar 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027781; cv=none; b=LfS8iyCyh4Yya/gXvOoRHYM+z0uvVe3UKPUkUnhG6uGePXsNaI/njTxVnmJs3y1JQX1IouQoBq+dwWw6heaWjvoEO93IQmv8yZjwy2Fujifkj8IIEnIYn+Aca8r5i6F+G/NrFO2xANO180a1u/2L8PWqa0pJLER8E0W0L4xtyIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027781; c=relaxed/simple;
	bh=Ge9KqRcXNYd4LLxZxbu27MXjAkjH/1J01HpE/fmgI2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7ZEwAbWyTknMoHmmwPbMZDPagkNzj/1OknGCMz4vVl0mgBQbS9H7XWJj7Ky4fGaLXkqlocZnPw15YAvr6ohaXtImH8Ap+JeQCLsluMe8sHSLy7oehAEwkQut+47Me+4u6vA3fBtApZrpkd+0UDcxR8SrBKim6D/EBz0Hdo7hZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gi7cdPVe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43996e95114so32982625e9.3
        for <cgroups@vger.kernel.org>; Mon, 03 Mar 2025 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741027777; x=1741632577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ3AOo7ZiuvjycKimf2408qcwXYSNrjFLmS1bhz3pm0=;
        b=Gi7cdPVeWBB7x8/xnQoPJL22SXbu45PcaG8zBoL8KUJ8fu6CQn3Z4iIIpv8DCLoVzu
         0HVhk3buGMQgGGPK1gGiSDWV4UYs1CkNhtAUqRzPu/5qwKYsatQxgxE5CjBhm9juMeRE
         8KyP5ePrH1mAqQFp4t+n8yLHzyE+5S0BhcSVyC9bgtCu+02JSMc2DKphvd7IXBekzRHZ
         iUcJG+8AxW1iDlfmSa04xz14O1/08VZfcMtTXWpyKAqR14rQVaB3PbTkKv4fx8/rySWk
         32xjn/TG988751n0TyMPoDHR8T7eowIy3NE/b1Jb1lxN8smMIqZaZSzAnsBOu8kbR+jn
         Zz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027777; x=1741632577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ3AOo7ZiuvjycKimf2408qcwXYSNrjFLmS1bhz3pm0=;
        b=Brt4c5g15XDqmX2wmtZ3rRxoAiRPRjOmuvn3On+cgJCROw5JQCPszQkApHeigKzeku
         MYSZ9rob0BpGLQNRJ3wWsZG0t2DaV9FyIe01WifT1Hhu6mcbdJVqGYnndHu+INgBzX8f
         NcMbpdr+ZK2bmKqEhsyH1LfHkYpgdNjyQBb84KSFBRjA5mhKOxKoOTQoDcnvkq2qmQHk
         3NATD7wO6tKI/6x9dg9zVaRpWwnp9WPs4QrtLCCvJHxhBGXDPfVVVf/IN1AzEr5F/GwL
         nDevFs9kad6C2I+/cnQYSqzlYP5XArpJRB5N1drAh3OtLhFofDEv4GQutCzzDdwyx70z
         uVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNkX2eUkzF1MuSqwEGO3QsALx6fHk9PTzC4PkMuIBq5hCMepKXeVBJpJ/BvcY+efK4UgrV22el@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzKd93yuypTnNayozc6i7B36i7D8cFL8n0fYFDh1CBnKcXEip
	QILaQhBOCKObYx2a3VCFOAgo2yZVL/bcn/zq3FdlU210NpIKoC93SLO7rJQY6xk=
X-Gm-Gg: ASbGnctyTjEz4YY46s4v6zmq2UiQFxopSG9xGPZmctRJ07IIMUTmow/xvYFWsnXyo29
	tWW3HISlvn/tL7mcTx1Sp5nY1ZQDQ3oSz5iD0SSvYIirlOKbKyyUx+fEiD6tfcxF3Y346mDzr3V
	ZCodBgXVs51aVZXwa70sRFqrsmrM+MBS+f7tkkMUFu2KXUlzFD3Jtzd0zEzxa1ohNcV9g0kQ/7f
	MuK6HIzDgCcHghu8hVngVrx2qaI9lQ9nkvjKRuvlPEoIZ+bmdhpDbDN7d2wHtuFrmM/itzVOIAS
	62hDZkfzJX8+tdUiXw0IQrgUbhR6tDR8EDVy6q6bEoRJoCs=
X-Google-Smtp-Source: AGHT+IFtNmz6wge1SlabS8tcj/AuEo1GBKfPoMfurFtufMptx0c+/p+3ih7mSXHrP8VuHgcIB6zLRA==
X-Received: by 2002:a05:6000:2ce:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-390eca07164mr10964581f8f.42.1741027777381;
        Mon, 03 Mar 2025 10:49:37 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc03dcb13sm50106185e9.37.2025.03.03.10.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:49:36 -0800 (PST)
Date: Mon, 3 Mar 2025 19:49:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: inwardvessel <inwardvessel@gmail.com>, tj@kernel.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <6no5upfirmqnmyfz2vdbcuuxgnrfttvieznj6xjamvtpaz5ysv@swb4vfaqdmbh>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obwbcojauwsjjxr6"
Content-Disposition: inline
In-Reply-To: <Z8X1IfzdjbKEg5OM@google.com>


--obwbcojauwsjjxr6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
MIME-Version: 1.0

On Mon, Mar 03, 2025 at 06:29:53PM +0000, Yosry Ahmed <yosry.ahmed@linux.de=
v> wrote:
> I thought about this, but this would have unnecessary memory overhead as
> we only need one lock per-subsystem. So having a lock in every single
> css is wasteful.
>=20
> Maybe we can put the lock in struct cgroup_subsys? Then we can still
> initialize them in cgroup_init_subsys().

Ah, yes, muscle memory, of course I had struct cgroup_subsys\> in mind.

> I think it will be confusing to have cgroup_rstat_boot() only initialize
> some of the locks.
>=20
> I think if we initialize the subsys locks in cgroup_init_subsys(), then
> we should open code initializing the base locks in cgroup_init(), and
> remove cgroup_rstat_boot().

Can this work?

DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock) =3D
	__RAW_SPIN_LOCK_INITIALIZER(cgroup_rstat_base_cpu_lock);

(I see other places in kernel that assign into the per-cpu definition
but I have no idea whether that does expands and links to what's
expected. Neglecting the fact that the lock initializer is apparently
not for external use.)

> Alternatively, we can make cgroup_rstat_boot() take in a subsys and
> initialize its lock. If we pass NULL, then it initialize the base locks.
> In this case we can call cgroup_rstat_boot() for each subsystem that has
> an rstat callback in cgroup_init() (or cgroup_init_subsys()), and then
> once for the base locks.
>=20
> WDYT?

Such calls from cgroup_init_subsys() are fine too.

--obwbcojauwsjjxr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8X5vAAKCRAt3Wney77B
SRgbAQDeQ7I2hYMnOwimwqQODn6GloN/rmgTR3tXGEK2Yw6SbQD9Hu0Vwnfv88pK
009vzj7AYz7SO3XUnhuNa1gMLTEd6QQ=
=Twgp
-----END PGP SIGNATURE-----

--obwbcojauwsjjxr6--

