Return-Path: <cgroups+bounces-11935-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C079C591B2
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0556E35FF85
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6588B358D38;
	Thu, 13 Nov 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bv8M1sdP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC172F0C68
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053659; cv=none; b=pFlw/pI1Z1ea2PCjMilA1yHhNGf6xCVMyoO5KTaW7t1mK2iGZCN/q9DLQ00qKcOuroItqo0LuXEfUMpJD9wCf7ekFMjH0AV3GILLl1zqA1JgyIhnsxjGFwHgDknpJed1Vre0BN9EzJkdGLuLo73/YtvffXlSpyD7nQdVA26tAxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053659; c=relaxed/simple;
	bh=3wHzdTnzv/9koblQs4sk6PY2OUVV0EFT9zAT0iA+YQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz/Lg4b0E6O5wHkWYEpjwfG4JiGnQz0u7Q/psGXq3FGo2udEZLWAIJXaN+YJjerPrAKRziBMNM5dT/o9n4BiSKlZmqFcOXMR07xSlqxI4WatxklLBQOa5VgpXM777sIKt48HzeS3cnDUO/LHuKgKhlyhnAo2q+//MZqdv5xjY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bv8M1sdP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47117f92e32so9225685e9.1
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763053655; x=1763658455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJwtOPWKmmTBRwvu3K3EIMtulS3eBFOLsMuoPcJT6P4=;
        b=bv8M1sdPv9k28oZt7NxnZh8yQ8JaHVqhx1lnLNb2BqCHU2JFNpAsrWi98GuW0VRHlS
         0vfV9gWXmN5ghLZrutVLjEZLAE3W2O4dnAFRII6fabQ45fHxrV/JqYa6trTeq2ZZh7Hb
         oZDA+8a9590BfSHIDVpTTLX/gRFXSvyiYqh8devGZtpnMXDsLbeCsVTgYBiU4yP8OUKz
         0pty2mr0yHspYF06nM3zwBiqiLWLhwR5x+NMquWtK3AIpNzMNA9LK9zgT2EGMZNLIHOS
         /c5ep+jEJEPsz4Ep6Q1VLaHxW8ZS4El4r0mgF7u6VJbEAAFzSJ//VZ0KIKVo+UX2zt63
         s7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053655; x=1763658455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJwtOPWKmmTBRwvu3K3EIMtulS3eBFOLsMuoPcJT6P4=;
        b=tQjGI7MZCHribmjkI43ds7MdLuY/ScYD/z17XdrmlPE40joLoc4MEqU02yRCN3NKiF
         GNAoGLYgD7ftEHUC+o7K7f9I/4k6AxjPIoExQb4Sn0pJELU96eHFpAdfcU49yEzfiT62
         oM+K1ZJ6yhU3NdCsXL9AXw/GSj01LqVmJkceZ9Z76yPuHV4PF+MrjwEeh0Tiq9bnhrcH
         YHxGZfCYFwMraJjlxsZ6HWSK6t/3Wh7DbPXGCyHM2wyko5HzcsOHBfTPjQpJfRrJVKhg
         ZxTAEvKBZaEZD/d5Ag+QxLcD/U7SyKKKReckn9oSVP++D4csZ3mW/1EJXUa1nPhsufHK
         E0pA==
X-Forwarded-Encrypted: i=1; AJvYcCUIxNKCMOtEDUYgs/DqbIVKCUnkHJRrELWhlyunVIPAyHSnpR2Qwpe0TobmloWzNsv8CaBQyaC4@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQu6awpL5Jb75cFw72ln4akAeDk4/oGhklBJR0V0qpFGkQ8Mj
	PiE0y4xpHYtVT3Y3q722o9bb6H73uKBK4YzsNsUXu2iHA6AUYlrRC5xFaxk9R03a5JI=
X-Gm-Gg: ASbGnct/91ovMXH3IsZqUZaQnTE3TEIB4SFJHRSP57BpHumxM/ncxKyOGb/XRObcrHQ
	7SFXkT4IjCMepVKIoty4U+q/uDhP7cRnhcioSFhICI40/x1SP4ZLTORBCXh3LUQKumLHSiB0O30
	XPy/fHvl3GcLcoV1f6t5QxxojnsNWeFnSH/3c5rpLsZQriY6oiBOV7KCdmw29SsdUTJVHwxkizL
	KGM82lU9Q7nOkmSRvAJ54wep18vHtEvw0SYf1XXfTC8L3F2kMMr8MboUf681KFIchP1lFpxrZPg
	qYn/LYtK9nWNcWbIoPmm9poqH3LzMGLUZuYWRJgRHoVIE0l8FoAhoFykglTTdSg42lWziRlBTco
	3ZJQ/E5uoUH2QsesmemlOx+LWRO0/ary75tKi17bcoTQZrA7jyx3pCKkxORItEgVkNSATZEoCTP
	08/xouWwCTuCfXQqkoE/nW
X-Google-Smtp-Source: AGHT+IGEwb65FvPJGLb66aSr9nqC7poeWs9ugZLSftaq0Hld+3M0XPCgYNsTqP6hCKw35URKMlz8sQ==
X-Received: by 2002:a05:600c:4f07:b0:477:63b5:6f3a with SMTP id 5b1f17b1804b1-4778fead9a4mr1762145e9.27.1763053655325;
        Thu, 13 Nov 2025 09:07:35 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e442c2sm106055695e9.7.2025.11.13.09.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 09:07:35 -0800 (PST)
Date: Thu, 13 Nov 2025 18:07:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Message-ID: <lhfcykirz5afdzdc6wnroubsdhasww4gsfri4dxpzagiejjbep@322rtmyvwiyd>
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7h7ewfrvbadf2ean"
Content-Disposition: inline
In-Reply-To: <20251113131434.606961-1-sunshaojie@kylinos.cn>


--7h7ewfrvbadf2ean
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
MIME-Version: 1.0

Hello.

On Thu, Nov 13, 2025 at 09:14:34PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
>=20
> The table 1 shows the partition states of A1 and B1 after each step before
> applying this patch.
>=20
> Table 1: Before applying the patch
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> mkdir -p A1                            | member       |             =
 |
>  #2> echo "0-1" > A1/cpuset.cpus            | member       |             =
 |
>  #3> echo "root" > A1/cpuset.cpus.partition | root         |             =
 |
>  #4> mkdir -p B1                            | root         | member      =
 |
>  #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member      =
 |
>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid=
 |
>=20
> After step #5, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."

I remember there was the addition of cgroup_file_notify() for the
cpuset.cpus.partition so that such changes can be watched for.

I may not be seeing whole picture, so I ask -- why would it be "more
reasonable" for A1 to remain root. From this description it looks like
you'd silently convert B1's effective cpus to 2-3 but IIUC the code
change that won't happen but you'd reject the write of "0-3" instead.

Isn't here missing Table 2: After applying the patch? I'm asking because
of the number 1 but also because it'd make the intention clearer
;-), perhaps with a column for cpuset.cpus.effective.

Thanks,
Michal

--7h7ewfrvbadf2ean
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRYQTBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhD4AEA/GWWlwm3wrl5ni3OWMly
l1jxes5Q5f9YIl+tVi4awEQBALGU4JhCDZ5CMZflO9yIUuFRu7zXymMjo3Zgx7Wf
1OAH
=gUoG
-----END PGP SIGNATURE-----

--7h7ewfrvbadf2ean--

