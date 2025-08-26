Return-Path: <cgroups+bounces-9426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB0B36A5C
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 16:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070411C4081D
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773A35A29E;
	Tue, 26 Aug 2025 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WUIF0PYV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99163353359
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218372; cv=none; b=WQi1Mm9Ayim5ezTvkwerx2obeeDsx8mQXVTZAHy1qtBW6JLJaC3+5LEeHWXLZ6OXYgn4VEeuQfavWe0QJ35dqqsEadLcev2LXz6kDzxaSN506F0WUmqhBBc6lyjz2Oj3JYpUsVkPNKeUA7/KWVQN+JCC6GYRsqvPo6xTyezQpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218372; c=relaxed/simple;
	bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrKkY5A0rHAjm/iPA8rVmxMLNiJTZHU3h0O5jmDuNBGqEEbuRExoDiX0IYgfOgE8D0LYAt21ajHcrFqi7+2SoCA7QieqlXeteAsC0Wks5BacHU8DsQFmpNISz7+S44lJZ0I6eC2gYYUIiGyX1iS14U0KI4hoVXL6OKVG7ODLr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WUIF0PYV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c854b6459fso1746785f8f.3
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218369; x=1756823169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
        b=WUIF0PYVPiP61ALt5gogMALHqiaWz/BjzD7eEHWaUi5ZNbc3CFbkrwCZngCUd5Xrfg
         XtZM/elqZtL9XlkqFYAH+uC+uZqIvP6AG3XI1lXB1LeU9I6InRqAXPE1kJsNrY+L5c7A
         K9kLx/hEmYvQEON37u/5ziS7tZsu4bh50LmRHdhGoUk3YJmf4t2ahz8yGTkbUKSQEIft
         yGnqDCxda1n3nUz2n9noWr4Fqo64+MLCG1gr3yZgErNhQ/KwjD7LUFTzC3k8xiBlzITQ
         gt0ueC0mzs8B3B9W0Fn9nuo1IGQ7c7ejQlfToC0ZKyrVLOeG0/0B6C4KRyuFUwIrAodq
         criQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218369; x=1756823169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
        b=SFdR8fGZ+4KGaY95xjjrxumkQDy2fc8lbXtx5XpH9ViXGe/SzW9E2e6c28wmUlD705
         oLrkmGMCKsT3HMXvxiaIdU8OgOLJDPEQa367IXHiPykl4GlZA1qe9X1RX3g+C03zPzA5
         iZat3Os94Q5t7UAQBR2WqYFWIRFHRo+VCD+yaqz1uKIo2+HUSnGFH+/U129NM+KkkT7M
         bfa68KJvEsuEZx4AePupJ7/DzrP2X+daaj9ZeZXO1U2IkIbTdz+h4hTvR6sP9tVvPAya
         pD+gf2Ae1trH3mL9WaDGUt2Pv57l9e+zgmjsXxK1dZkMzZhXfqanEyGcMm9Q6sjH90iL
         N56Q==
X-Gm-Message-State: AOJu0YwX/OKNT1n/wUZlmZgSGr2kISKSVaZ8IZLX3VZcnTZV8QCAq8h9
	TlUNlA3ZnktQ9JMkk6XVdZphImLHhoeR/ki+/NeL3fzH3itEOpgyGarwdj1cmW4S9MI=
X-Gm-Gg: ASbGncuRabqSnXTbhvrtPg3TL6+vUA3H5r3HSXF9IWk32+E96cOsYACXJQCTkw3cFN2
	yBz031wJ8F/sPL6SxvCS/e1zb1qZaXXAxpjYHKkxHzv1SV9JQm/fqelMuvx448DCQGDnJ0ws2pk
	OgJo9/NR7B8eEYFU78b8ye0TRJKac/IGs05ED/AF5KvF3FyPVWS+3GyfT2liLyN5+K0ruel6JZk
	SZDVtztUDy2JxD/WookCfTVgoTlJdINqSymUA9g+BRau4efCq7v7jFq0gtpx+vDl5OlWyaSsxbo
	krnW9qT8SNxmVJIOw1fKhjSAkEXX/mzXKG7sLEQEfU6d4XCRYRWq6QO1BXCXGJVybwHHIEHx9/g
	+G8zRsCbKexeMNrM9Jg5a8iLATwy0/QZNp2tAkGx6RrI=
X-Google-Smtp-Source: AGHT+IHNuSehu+kC/8JT6eOvIgtP+0NWIiWUAOSb8fB6NxBNImXOnuq9wHCo/AxRrqB9def2TYx5ig==
X-Received: by 2002:a05:6000:40cd:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3c5dcefcf18mr14788726f8f.58.1756218368812;
        Tue, 26 Aug 2025 07:26:08 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880368sm97231965ad.109.2025.08.26.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:26:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:25:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Cgroups <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kamalesh.babulal@oracle.com
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
Message-ID: <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23hhozo72xquqq7g"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>


--23hhozo72xquqq7g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
MIME-Version: 1.0

Hi.

On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@li=
naro.org> wrote:
> Regressions noticed intermittently on AmpereOne while running selftest
> cgroup testing
> with Linux next-20250805 and earlier seen on next-20250722 tag also.
>=20
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Intermittent
>=20
> First seen on the next-20250722 and after next-20250805.

Naresh, can you determine also the last good revision? That would be
ideal to have some endpoints for bisection. (To look for any interacting
changes that Waiman was getting at.)

Thanks,
Michal

--23hhozo72xquqq7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3D8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjraQEA/sATM9lqrOJV8YGvjMwn
+GWni0VR34BMM7mWvDUzGxEBAJpsvXzuNyDJBDJGhCreK69pFRuLZ5En4BTai+Fu
Oc0F
=Z4+0
-----END PGP SIGNATURE-----

--23hhozo72xquqq7g--

