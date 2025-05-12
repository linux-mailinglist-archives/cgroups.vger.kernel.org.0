Return-Path: <cgroups+bounces-8138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724FAB34C0
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90F51782CB
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 10:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0026137F;
	Mon, 12 May 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G8WbJXU5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D1DDCD
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045216; cv=none; b=K5/VNoHNJbp8EIz97cNAWjhi8XiAp4v8VqyD196lYo0XoItwie+dMusdxWYA+I2EQ2Xzm6K4COETJA6TVFPyqC1EfznA3rpoIA16aSPWgSImjjyGeMq1rzHc0nPl/NB58l6+IvP3yJpAlrQ0EgwX+ZxdmG3Zps+39t5etyTWId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045216; c=relaxed/simple;
	bh=kUnlC7NyTAMEtEffczBHSiagZwvWftD9sbC8qLtEHJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFGthW34f9dz2L2SjT6EBBaXb1XY3LJGvgT5DAVSkFK5WVU4lqLiMCpUunjEIxTW+F90qzGOrmoGu2um6gJDCITZDNcRysYqtqZQVrp7UMvmImJs04Irne+e5xiyzp4m5usOIGPYJGKvlvMhhJg2Ck1rR16S1hVyJuAcxQjEx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G8WbJXU5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so8123755a12.0
        for <cgroups@vger.kernel.org>; Mon, 12 May 2025 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747045212; x=1747650012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUnlC7NyTAMEtEffczBHSiagZwvWftD9sbC8qLtEHJA=;
        b=G8WbJXU5UJTOtbBSAvLPQ0Bv8RpIuLcfJGrqC+MPExSTVX9f1+vshgheoK7tWLCumt
         S0MksvgIoET4dPmOBSPZJXERH48TsFvoDudGu8gzHsuhwcnDc85Tgkekw7oHOrwZYbWB
         0VrUA2TjlziI2jauOsb7fbMWRvBl2+NvnEAfdeg4MdQNJ4SHbhQ0E2puzf1502hYsZft
         DWF9oTT4ZFmcxphV70Tpls0palamRwUhe8tqu+N8JTEhYUE0AzjQ5dPOoRuF1jQxZIfi
         nyhuF8z386AuT5DTVMK0WhYq9H2ZZ0a5XLUDmJVJShu9TdPI7V/WCpsL8B1pkZ7OI/eL
         MeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747045212; x=1747650012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUnlC7NyTAMEtEffczBHSiagZwvWftD9sbC8qLtEHJA=;
        b=u7FB/+mJQhz09XJ6sp31tP+8TgtO+ZfI+w0MgDjFG6PpwImN2c2pF6t+iI1LuP5ziT
         Ns05OLvato/fFbAfLfT/GO75zlrq8yZoHPphDkw6B5aSKzFaGotfFUshyrTbPziZjLCP
         PCGwWoDi6/I0U52yATJYVrcfYo+zOWty2U9eqg9+hKhXKiOAnnIIY7ONxH04RlPcnqPR
         p/mcdEXxJtUcesEV0TZpR0A8f26WLsQKbMVvezZUx7W8lbcA4nVyTntuPX19jL0NSmDe
         PHtom+4BJkjaZJnnSRs35kfnobgl4ajE0jUfYQt91bB4dHeWZRrlkSGTzqDbC0qMus6G
         R1KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1oyb2kq7BE3T+L4iV9vqieKlxDsnwutRYsxjkFwuJPr9aYS4XTEltxFeK19m7HtlOWjOPa33k@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG8Sq/3PAALXaVSzx6MLVm5JhBR6LtrJrQGvSdLv9zbp9UoQl
	M+XZaalJwytfgZPVuHK1mO8wwm2PCqDZnzykHPk3fUkhwtkcqRt3/MkEv7hIZZM=
X-Gm-Gg: ASbGncvHAK//rwamRSyBTwfoA95hWZNoJHADyILQR0hSM4Fw6xfpc8m3ozuPjyeCdJx
	5MD0lbQN/p5Sue48m9bcFXMC271XWNIG/J4gS3pMMLjtWimiyobKsYYFgpT/10FTK3aH+zozZMc
	myvr81xYPyewdLaWyJFDqcJBrfSRKFeprU896kRQsBuH7bNn5t1LqWvIl3gbbxepNxpQ7G0hn0S
	GPVNaVKgXoyXAy9jquOfQRyb+wCrBg579gjeAcvGs8vbj56s0VntaP47kFOTpTMZTmiuwdKpdSn
	66IxDHDx3cs4DIvFNPdzkezoaz3tNNBOUcMDwerOAALsrMvWwgnJ6w==
X-Google-Smtp-Source: AGHT+IFUAbxYrukJJZfaN2RoAV8/y3rGTOsQXQjzWfgCtVE3ocfvNLmhTM4rjN/+iktiYHhkshhdoA==
X-Received: by 2002:a05:6402:274a:b0:5fe:17be:a93 with SMTP id 4fb4d7f45d1cf-5fe17be0c7bmr2867590a12.29.1747045212130;
        Mon, 12 May 2025 03:20:12 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d7010f9sm5470504a12.63.2025.05.12.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:20:11 -0700 (PDT)
Date: Mon, 12 May 2025 12:20:10 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH PoC] kernel/cgroup/pids: refactor "pids.forks" into
 "pids.stat"
Message-ID: <m2ak6nayh25g7zzsnm6ouik5uovctaa6kfstxbfboupvbsik3u@7f3wzsfayhhg>
References: <aBkqeM0DoXUHHdgq@slm.duckdns.org>
 <20250506153057.210213-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5d52j3js6og7sab"
Content-Disposition: inline
In-Reply-To: <20250506153057.210213-1-max.kellermann@ionos.com>


--f5d52j3js6og7sab
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH PoC] kernel/cgroup/pids: refactor "pids.forks" into
 "pids.stat"
MIME-Version: 1.0

Hi.

On Tue, May 06, 2025 at 05:30:56PM +0200, Max Kellermann <max.kellermann@io=
nos.com> wrote:
> Proof-of-concept patch as reply to
> https://lore.kernel.org/cgroups/aBkqeM0DoXUHHdgq@slm.duckdns.org/ to
> be applied on top of
> https://lore.kernel.org/lkml/20250502121930.4008251-1-max.kellermann@iono=
s.com/
>=20

I'm still curious about the reasoning for the introduction of permanent
metric like this -- why isn't cgroup's cpu.stat and memory.stat (that
are more tied to actual resources) sufficient to troubleshoot. I'd like
to see that in the commit message that introduces pids.stat.

> This is quick'n'dirty, with a lot of code copied from mm/memcontrol.c
> and adjusted.

I think the transfer of PIDS_CHARGE_BATCH into the implementation is
overkill at this stage (and it skews the stat field).

Thanks,
Michal

--f5d52j3js6og7sab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaCHLWAAKCRAt3Wney77B
SYfKAQCYFIQaxufq/TL8dGsRMnijkRIDsvWAaqB78asTbtd14wD9EXx+G1YPxjSs
s8po33xydIe+XMeE9sTi8DnUMRufFA4=
=/iaI
-----END PGP SIGNATURE-----

--f5d52j3js6og7sab--

