Return-Path: <cgroups+bounces-5470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47249C0D74
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738FE2836C4
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC72170A3;
	Thu,  7 Nov 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrylWrsn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203792161E6
	for <cgroups@vger.kernel.org>; Thu,  7 Nov 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002752; cv=none; b=dHeJbEFXX+t0NjOVzLE7p4OVCKlRgfQ4W53+h+uD131rhQv7fc3aO8LB0nCIWJZyHfP7/9YViO0nrUxYtxKnT2Fm1b2daUx1aarDZZngBoevPzS7Gk57Cd9pOih9OqqSS1875bKqJ5m0ObCsfyJM6NMcwsYjoP6Yq6pMMKnnaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002752; c=relaxed/simple;
	bh=KUxyXwz3ijMwI9yruBeARGSaKdWcNDBaCOKWP0VGGm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOvaQsVfZjBhau9/OsiOlAcGhbyy+4y6/mM4KPteMdgCQJEw6Ik0l9Vp7NF0YYf7EPst9WMgyiBsL1ojXJSyhP1RB3a8ytQZfS4kLBf5vUucozGdxy9XWtn5eBGdF56RCbq1XaDPoMjuX+sEbBd6KJAqbnPk2VS8e/ev/AklvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrylWrsn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso194964566b.2
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2024 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731002748; x=1731607548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSbrYYBrI/p/5x0d2n3UNYuWW/+v5ncY+edUOAUibFk=;
        b=WrylWrsn+dmnKPImq81fa+6sZpwIF5WozWtdbebYEyjW8lBhqZSrovghVy0jKE44IY
         OZPyFwz6+wfGa6tPmfRdRyiujvOUh5lU+JSHGxf3FBAkIb3UKbw4w4co8KxldlngJtuP
         JsJuMOxFDQKSshcxzTzERdisOcrUUkmhhSwQw/f/YM9nj6Hh/c7aKUFAFFkixz6Im6YE
         3x/pwwoypVA22RzxQgx7tXgtqSLuVBnruWVnUB7ahY5EkCpfuLPQJDhSnEE2iyMFd8Xl
         MVT5iwepusXCviU9k0Ggr8GCVEu+xyUOBn0zjxU+kgEWFy7++YrO0VNV0i3om5QPNTTz
         EDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002748; x=1731607548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSbrYYBrI/p/5x0d2n3UNYuWW/+v5ncY+edUOAUibFk=;
        b=mHerJPOO/fQjRc+k0aZP5zD/Fx8uagpzs7+u88vhxuJgAzXt1SzxxyIuqLsqmJPyJU
         Q7VPhomM4Sp2gkAoib8FX9WzI40Pk90o3kRBPu2qSiKyNg45vSrbZbrokyltOykp5qQZ
         fKMrpVhRVcjGktqOmtnW7KnUo7gKcvN37aZwaiQTMjSiKsX9E2+deuFXWKv0GXV5XQE4
         h1/Ge8iMD9KOGjpjwtXm/mPxLVOQ8Zqeb3SfihZSEw7YpcxeFEXj9B8k2X0mCZFg9+mq
         FAsGmcMWGotVsnF5YRaBAk5xuT2A5XZtrlDiplQjFVixVkBShRK0pB6skAnDVDHHPl/Z
         pjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdFg+saS8RdHFi8mYY94Z68JlRg1vcR1U2rhGPZ/auxdUdVsNy/Ue80nVTWEN9kH6uvP9EYYc9@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsekTLc9lKe8wbd5RRReIwDAdV3fVScGZyaXPC2cbhZG8umLv
	gW7cXdz5sZy55I3G/h5rble3jSYwOMtOoBfsJKE4Fi4fSLzG559sWiFYfFPBgqc=
X-Google-Smtp-Source: AGHT+IH/KWT01CAzD8ky5ouYbcYfN5C3FED8l6ogIpQP/5B/enmGcQM4WkUVsaO/f92hCV5EgwfPEA==
X-Received: by 2002:a17:907:3f02:b0:a9a:e0b8:5b7c with SMTP id a640c23a62f3a-a9de5c91d25mr4463270266b.7.1731002748381;
        Thu, 07 Nov 2024 10:05:48 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abf305sm126140866b.86.2024.11.07.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:05:47 -0800 (PST)
Date: Thu, 7 Nov 2024 19:05:46 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Luca Boccassi <bluca@debian.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, kvm@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
Message-ID: <nlcen6mwyduof423wzfyf3gmvt77uqywzikby2gionpu4mz6za@635i633henks>
References: <ZyAnSAw34jwWicJl@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2flxw46ilch26h54"
Content-Disposition: inline
In-Reply-To: <ZyAnSAw34jwWicJl@slm.duckdns.org>


--2flxw46ilch26h54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 02:07:36PM GMT, Tejun Heo <tj@kernel.org> wrote:
> There are two paths that we can take:
>=20
> 1. Make kvm_vm_worker_thread() call into signal delivery path.
>    io_wq_worker() is in a similar boat and handles signal delivery and can
>    be frozen and trapped like regular threads.
>=20
> 2. Keep the count of threads which can't be frozen per cgroup so that cgr=
oup
>    freezer can ignore these threads.
>=20
> #1 is better in that the cgroup will actually be frozen when reported
> frozen. However, the rather ambiguous criterion we've been using for cgro=
up
> freezer is whether the cgroup can be safely snapshotted whil frozen and as
> long as the workers not being frozen doesn't break that, we can go for #2
> too.
>=20
> What do you guys think?

I'd first ask why the kvm_vm_worker_thread needs to be in the KVM task's
cgroup (and copy its priority at creation time but no later adjustments)?

If it can remain inside root cgroup (like any other good kthread) its
job may be even chunked into periodic/deferred workqueue pieces with no
kthread per KVM at all.

If there are resource control/charging concerns, I was thinking about
the approach of cloning from the KVM task and never returning to
userspace, which I see you already discussed with PF_USER_WORKER (based
on #1). All context would be regularly inherited and no migration would
be needed.

(I remember issues with the kvm_vm_worker_thread surviving lifespan of
KVM task and preventing removal of the cgroup. Not sure if that was only
a race or there's real need for doing some cleanups on an exited task.)

As for #2, I'm not sure there's a good criterion for what to ignore.
Here it could possibly be PF_KTHREAD or PF_NOFREEZE (I get the latter
has purpose for system-wide (or v1) freezer). Generally, we can't tell
what's the effect of thread's liveliness so it seems better to
conservatively treat the cgroup as unfrozen.


HTH,
Michal

--2flxw46ilch26h54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZy0BdwAKCRAt3Wney77B
SYLIAQCuNDE3wTgZN3p9SAWDtSNXhwYcoK26f77RKTJcTmBEUwD8Cs/j4rnKyut3
wTfnUQ9EoseHo9YzGHkO2Hhuq3vjTgY=
=An9+
-----END PGP SIGNATURE-----

--2flxw46ilch26h54--

