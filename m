Return-Path: <cgroups+bounces-11955-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47087C5DAC9
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C49E136663F
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361D32824B;
	Fri, 14 Nov 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U/iWaspM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B33277AA
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130760; cv=none; b=llrx7fWrsOWMSnimg7h6lgTdY7koB2v6Wq2PL1qOw3Wr1GjwjD6Qp/Cmy6c4hd2Wf2q8IaFCxo4c2FcxpZpUBI9Md4d3aQkE1BFu5eUgckMOnPSIYSUVH8HgWH+1sniTp+VWOXUEROsJLYtyBBUuOMVaGx00gFycu6r051Xf0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130760; c=relaxed/simple;
	bh=HN3jnmUy+Cud7sca2nzou+9fsUG3OJoMB2unjr//I7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8/XJd6Jde28aB/zVeSDdLsJQClV/Vzj/kABGir2bOf2jlj4W70o4B1LNYucrw6XMz+X0cg2r3fb/KzyfWAd1T8Kpo14zVkuNi8g+bKgE4SVhWBzDRZn44GMDO4WLcAfX3qnL7vfIu33rdJxpalpyVd9SOu20Zrf/v0DXVczGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U/iWaspM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so1608140f8f.0
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 06:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763130757; x=1763735557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HN3jnmUy+Cud7sca2nzou+9fsUG3OJoMB2unjr//I7Y=;
        b=U/iWaspMoTD/e2lIs9AM+3/XgbYqp6QstaOAl+YZhvy9MmJCi3XjpnW9bHmziQEaqs
         UqKrDRXaqjLkX5OWkrT2g2aulQJrlnDmkmDCYAutzGiCODIVhSrJTLy3g4+Lnu1cKFEL
         6fjLJVPMu2J14s7ZnbRQmoQGv0DdxkwML7VbwrNn/H66EXT+4tAzM8iIfVyBo9iyt0EE
         zQ4HDazCnatbWN9UbuHvM6w7kOE3xASNSTzCS/BpRTKjrOAnC/koYyiT/S6771S1z+67
         b7SDhu6Z+ARQwu3HkEOXBRFpREl9/Md4Ph06yksDJk1CUh8ZmYJ54qrZ0FYAUZbC+YdY
         9cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130757; x=1763735557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN3jnmUy+Cud7sca2nzou+9fsUG3OJoMB2unjr//I7Y=;
        b=c9IZh5tilGJEB3qoAmnOBW5pHUUFqaAGHzw69MqWVf77ra+M2j8PKjzOamKAACI6tc
         tZgPah1EA3NkMeCOZfCjwpEQ1vjAPA1N+IkQDVQSrMwQ1xzlOHMszbbue3/VPdgP0wmb
         GXTtv0XCYx91I0Unv2Ku6Mhnhp9Kj2JVyH8sSsUvWBr89MxLXB3jM1tNrMa9PbJJfr8m
         0pRha2mApqyCbHSxC8lFSDmaTuwJHRSdhNTzjobEbmGu7RbEATq/0hHZrDWDBdsZSx8A
         LSk8VBko8RhiyQh+sjixVEVrwma4v25/1LBNwXIUg5MCX15YIr2GUkbTgg7T/7ZovfZa
         RlNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAmNqw1QbIdOMc5NRx0YYLC04phX/uHZVyob4aKqwsGCnCbaHdbPNvuDzP6QcX6DGuo0OjwIkE@vger.kernel.org
X-Gm-Message-State: AOJu0YywlH9ysVCj/A9yeNoxM8AO+jx+RuJRGx5bhFFvThc74ZvTF1vH
	jtEI5rw+ZIVNQLyT2uJtH90LPddtR155EVu/7SYx09VLh1asn9wXLM+q699xRPcHgmA=
X-Gm-Gg: ASbGncvFcCL8n76v0bCAv5kKtCnswKA+aFm+560cIVSeMfHCVlt2QkOS8IoauNwra9Z
	v2+Sxi3u5Bs5yZpBS52W45esvdS0eyNiJWsdVMZZdBigdPBV6rERzj6x6N4YWOOoBlZQPg3jI0Q
	W2F365ij8aUvrVwWu3u5mm271xt82k/XAn7bRdT+yfyGBPMRVo7DC+H7wyZL19CKKeWIbBJFABB
	3Syt5ObLLTZ7wIiKjziZKoC+94QpxRHvh4PNxkPsvhB3cj3dyPQuxgg7SMVo5wHwmZ/+QnVYDRv
	RB0ZgfIkaIe0myyjw6Gs3FphsEKZ/Wyg1Bk1HYMSNkMdjwA5eQVDVUtiOpDU1eJKpPAmLP4bxCP
	YFsAELm8Qh+2iLsk3dyrIie+V9QTHQXtgtDzOU4vAaGJaqxM9mP+qX8JywttrVhYhcNCoBUYVVs
	+ccgSdB+2Eajr+WzgK7vz8
X-Google-Smtp-Source: AGHT+IG/wsNger26E0V0m6xgXzA1Oo9csceQsjfNfsN8BI+4W7SPfZqWJAu79dOI4diXiuEuLjz23Q==
X-Received: by 2002:a05:6000:2c0f:b0:42b:41d3:daf9 with SMTP id ffacd0b85a97d-42b5933ce36mr2926758f8f.2.1763130756418;
        Fri, 14 Nov 2025 06:32:36 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e982d6sm10480919f8f.21.2025.11.14.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:32:36 -0800 (PST)
Date: Fri, 14 Nov 2025 15:32:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sebastian.chlad@suse.com, longman@redhat.com
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
Message-ID: <4h54pkcisk5fmevglu3qldk5fb2rgo5355vfds3wplhekfumtz@qtwtixmuw2hz>
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
 <6916a8f5.050a0220.23bb4.ab7dSMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6uqnsagtupmqone"
Content-Disposition: inline
In-Reply-To: <6916a8f5.050a0220.23bb4.ab7dSMTPIN_ADDED_BROKEN@mx.google.com>


--s6uqnsagtupmqone
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
MIME-Version: 1.0

On Fri, Nov 14, 2025 at 11:55:48AM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> Actually, selftests are no longer just something for developers to view l=
ocally; they are now extensively=20
> run in CI and stable branch regression testing. Using a standardized layo=
ut means that general test runners=20
> and CI systems can parse the cgroup test results without any special hand=
ling.

Nice. I appreciate you took this up.

> This patch is not part of a formal, tree-wide conversion series I am runn=
ing; it is an incremental step to align the=20
> cgroup C tests with the existing TAP usage. I started here because these =
tests already use ksft_test_result_*() and=20
> only require minor changes to generate proper TAP output.

The tests are in various state of usage, correctness and usefulness,
hence...

>=20
> > I'm asking to better asses whether also the scripts listed in
> > Makefile:TEST_PROGS should be converted too.
>=20
> I agree that having them produce TAP output would benefit tooling and CI.=
 I did not want to mix=20
> that into this change, but if you and other maintainers think this direct=
ion is reasonable,=20
> I would be happy to follow up and convert the cgroup shell tests to TAP a=
s well.

=2E..I'd suggest next focus on test_cpuset_prs.sh (as discussed, it may
need more changes to adapt its output too).

Michal

--s6uqnsagtupmqone
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRc9gBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgLgQD/fbe7S0AtogwfuP1y5Bqn
wM4mhSkCc3blXh/7ObpsjqEA/3cTt2T97D0h3i5iLPdSu/NO3AwScgRBygMG5F3I
dJUB
=rsPe
-----END PGP SIGNATURE-----

--s6uqnsagtupmqone--

