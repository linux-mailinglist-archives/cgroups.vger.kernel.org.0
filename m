Return-Path: <cgroups+bounces-8835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBC8B0D898
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D9A540FCE
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03BE2E424D;
	Tue, 22 Jul 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DjtDc0LH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAD2D9497
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185253; cv=none; b=lLBh6/00plmBOW46cCTdASPWLW16OsHGh4g4+6r2S2cEFB3uJnxZsmk8/ikB3ivd/qhWd4jp53sA5lagsRaqp3OsKCuiihqlm4+oK6Q1SdI09AmFwtJsim7OaNNaSWbkR9PYZXsA0f3YfyGETJhF+2j/C2WT00SaYqbOThwxtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185253; c=relaxed/simple;
	bh=Fla3OlF+/YSMx3UOhbmIQazfbvpT43e/E5z5T5vEJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg+xW/GyvtNIXhfHBAWZtO2RPGPxqXkmoR2K8yzV8z6ta+1j7IJ1DiMoHdteHc9Ogq4vEY7KOlvbTXxOQKDo/NJNVjwUOhSOFPsaaCFZMrZFlPqEktDS6xmsknxkm+zmhD2fbi+UtCwjIC57Bzag5XS1vzolJaBmO8es+XltO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DjtDc0LH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae9c2754a00so916262166b.2
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753185250; x=1753790050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kKt2BVvYAWPd9RG6IbzHHUIGJ1xcLJOliFtWnoC7pE=;
        b=DjtDc0LHqZeKUILy3s2oQKZYOl67ZHw3E6MR8ZsoFMudW1LCstl+1eVWktnLYedAyc
         QHAZDacJek7qNDVWuqyXRaQr0SahdEmxNND230oHu5FmwnW0nLv4tUMhBUQBLw6eGB79
         RX/2eypfTwu4wocmsOlkZfQrIPfk98OvbmqZJdAh+YOn4PDQTyQ3kvMocezzh3W7IBWs
         yfTyz630RbtfHiirLXjmBYuUMoTKwY74jQ55U76ttqlOKqb8HsCqMXo2/r0gsOVbeMZ0
         CK964OQlGW2Dn4GhoJftIcb33+ypxiWkR2Sy+n4aOO/oaHjtr0giypvSCv9snrk+VJb2
         nR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185250; x=1753790050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kKt2BVvYAWPd9RG6IbzHHUIGJ1xcLJOliFtWnoC7pE=;
        b=doLyNr5OdHVV8zoXJuQ8dfVigp2hjMXbZcAvG5GsO7xBeFFIGRXTwmf3oOSHo2uNlZ
         i69CjGEVher3jXds/calnmv5xBeKLvT7GPiTGNSU+i8N0yfFFKQhngcV5IvOT3cUSL5V
         wVhj7wMXfvoyusvcGUg/PbGvqkokxRBqSUqAnJcCmIWKToOCLZB1US8XOk+8U4AU0R3V
         Dg35NgBxCZK7c0ufeWO0I2mI+qJWQ+NPDLCzt1kZhgG+T1wQTaWIRULATBRqEZq3IGQM
         siUpIJA93G3mpwc1uIbW+uGbcISJBQa569mwelluE9WATOiGAD4r7eW9BEJhxKTQxlDD
         /HMA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqrqF81G2J/zSx0gQkl1O8DDnOOZRLKutcuASQN5qDW0BSDGM7lib8c1loCbs0jxYjPV3EOjU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4KtL9DwMOCW9ObwevLUIE4iltlnLZJeU6DQbXFRi9Id0deqX
	TxUkrZThP4kwApt1oqAS++I9T+WUNm5dRIYHSQMXxkoKuzKOgEhnirKqSCnflkuaiqc=
X-Gm-Gg: ASbGncvRDcAC5wGYLhXla8CSvLLzfZa+eJ8AbdDA5+iXxMyLA1V24NnEcVoEbEdgDTE
	YfEI4zxSevHeb42Fivg5qsNKEdCrBiKZNd5rTUBYCUhkptl3kM0u3+oWllOTc2KA9UmAlErMikq
	HWMbGJYGDHv5KnLgWFhcTz7Ia1DoM4xqVBKeIg9Sq6y9jVWd4QOcde5s1Jvup04I4p2rD4K8jEK
	RCxZucx3jL4queY0ty3YzOHGas6w3Ume+uZd+/9Spn2D2XQ34TBiTgfxj4fpC4Xq7TNCUQKooxF
	kZhsAkIzUweqeJSG0bXnL+gFsaJTSpHe06SmJacKww9g7oALjA7TPZqJV4aAeblC5gst7lnOJ6v
	7Zc7ENnrsnESNc3pDqyzdG7Gtyg0mb5HzLWCya9d8ha5ThOkvQy18
X-Google-Smtp-Source: AGHT+IEfIxYTONnhe+xRu0jikk0G+zzebdF83eXd074o2mrK0k86lhWSA/IBxcIozC2KvB4QKVdAMQ==
X-Received: by 2002:a17:906:165a:b0:ae7:ec3:ef41 with SMTP id a640c23a62f3a-aec4fc42368mr1727192666b.45.1753185249984;
        Tue, 22 Jul 2025 04:54:09 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2f19csm849926466b.70.2025.07.22.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:54:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 13:54:07 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, Tiffany Yang <ynaffit@google.com>, 
	linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
Message-ID: <adrjkqsqqwxcsdr5z4wmxcrvgvutkulzgka6pjjv23v6242txr@vv2ysb46nhpk>
References: <20250714050008.2167786-2-ynaffit@google.com>
 <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
 <aHvHb0i6c8A_aCIo@slm.duckdns.org>
 <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="euhvc2odhqtm7xfg"
Content-Disposition: inline
In-Reply-To: <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>


--euhvc2odhqtm7xfg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 05:01:50PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> Specifically, this change would allow us to:
>=20
> 1.Remove these CPU-specific callbacks from the core:
>   css_extra_stat_show()
>   css_local_stat_show()
> 2. Clean up the 'is_self' logic in rstat.c.

If you see an option to organize the code better, why not. (At the same
time, I currently also don't see the "why.)


> 3. Make the stat handling consistent across subsystems (currently cpu.sta=
t is the only
> subsystem-specific stat implemented in the core).

But beware that the possibility of having cpu.stat without enabling the
cpu controller on v2 is a user visible behavior and I'm quite sure some
userspace relies on it, so you'd need to preserve that.

Michal

--euhvc2odhqtm7xfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaH973QAKCRB+PQLnlNv4
CFq/AQClJUmKOphL5NvNc5AVqGOpLStkEZI+TheupLy0GZFR7gEAnedr53Iw59zU
//68DI0J9sYoXIgmUXii8bcidi8uwwY=
=Mri+
-----END PGP SIGNATURE-----

--euhvc2odhqtm7xfg--

