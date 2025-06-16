Return-Path: <cgroups+bounces-8538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E025ADAC55
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0EE188BD9B
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB50270578;
	Mon, 16 Jun 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VT/0QbrY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4518E025
	for <cgroups@vger.kernel.org>; Mon, 16 Jun 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067424; cv=none; b=UPdkKCeQT56nHz1WOr4T1IumhDZIiW6onYCLldrmegadY4dngxQ6bgKCPyO7VCI62xa4TH5fhT8goN973E8dfndQGCXvsMoYIxESlYNTEcjsN0LJHM7Mk6oteQ8EeSzXWi1IHHfL7i5VRWNXV6wl8hdjXcCzwpEap4foeg6EUPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067424; c=relaxed/simple;
	bh=/8kgAEgozy45w/iUV6if2qg8E3JCiqcMplEm7kzRpKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMrosFEaEC5DMJpT223yK2UPVFxTZ92sMIgDsE/YtoDrTtw7yX7h0hw9Nz5YrOarRdshOCfJQdBrJ4ZfvND12VgpyK/u3j0Lr1O0nifK+JFZGbMFEygJNsT7Wga19NbD+glRwM5wSixHDXzs6StRTy0G/kKVecA63rHjTNQb46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VT/0QbrY; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so47950455e9.1
        for <cgroups@vger.kernel.org>; Mon, 16 Jun 2025 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750067421; x=1750672221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ajWSqawneitf2a63O3Vr9RZuagx7iIr5XGjwVXy7Bw=;
        b=VT/0QbrYqE4tUm4DFo+qhA3B7jMDvpb1UsehdOSttAqfy/SmGL0e3F4MGOvOIj6bXy
         vmbPFfr8HkD15ZzI7RPMnEvHZ/+Yv8DyWUN0tiI7YFN39so/gBVxwKfrr5JzL+B4K7X4
         EHq1gF8pqZCPBX5TT+tfbMsDHCA4PQ4pDTm2cj2/17nk6/CnhNQr/Bo6MLjlOEjkToqj
         J5GGj/PfI3d3j09o3hdE6CVBzNUsP35RVF9cHD9bPqyiINGHkwynUx3JizG8IqNFGpAL
         fDtwhrYk1fLaezFngAjNQwWgXLcAmBL1hHf6jXj12wGvtbBj/YGnhL4VbQLM89g5BJkg
         K4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067421; x=1750672221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ajWSqawneitf2a63O3Vr9RZuagx7iIr5XGjwVXy7Bw=;
        b=tS8x/+aYj2W827dGUpMrAWvqAC3GCg8oXWHbHwdKBPY7vo5eEcK6DC5qUUYnwQhvRx
         kpz6KWbyJ5Eqjnz45z9lDn/xzTIyzqhAza8XsJBAPIFzJnb86IRfBYYNy5DiWalBh40Q
         adwl34TBJQE/7odVvn4yJG4UdofS06KtbXV2HNIyVmqbl9moi4rcIYwpl5HZOJqASxXz
         IASKX2r43e6XItUHJN/qKT1HDBJr9S3Syv0k8kZm0Ji2kJ4+f6wv4FNlW9XX9mEV7X76
         cBDfjWZUHLldF9LLSnjjh74juYasZs/gp3Mw92Elg8E1vMGheWQhfU+orPEjD5xJN6Zi
         rFgQ==
X-Gm-Message-State: AOJu0YxMCbm02wehV1RLcd2TmdmFSwOPw3tbGVtkFJ2xllpZqmh8y++t
	zLRQF8E+yDmFYDNOyitRWzthlq5G9SjG0T9h+EKtVeOtcXop6KhAPW4VK5odZxWC+Qyve/IbWe5
	JBpMQNGUW4w==
X-Gm-Gg: ASbGncuXUsnzufKMjDsTenHd07kODHmENCPnNvrnBxR5emRiHjSKWXYQNWPk/SJKGK1
	O6xatOV6MGkLZScDsT0q4UHqy6RnEa5lap4sjPYLRJswWiegscaQkBi3SEXJrcVFj+rIZVLzDpE
	t41s0VJqmHMK8z+YmVg47TpiCt+rEJVOx4xRs8nSbCnTZ0sUFRX+5+ADyGqurPBitN0nPYhAwL8
	i+UfrN2QR3ESU1HhI2BjVriSwAIO7qpGjj6J6rUksoi92tqYR9uW5Fn7xJcrLWkSrQJq1ZAmAsf
	rcrENhJRyrlt7YT9bfZiAkhH1BeB6LwnWQa0QhJnx6bCN9DWGhn2cOIoARcOme/O
X-Google-Smtp-Source: AGHT+IEk5/+TEpUz7jLMLE6hLBpf7r9+GYt/UetGf4aLcx/IH7vYvqvBD6BR10JeNscBjMv7QX9m0A==
X-Received: by 2002:a05:600c:6207:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-4533ca76ff8mr89242775e9.15.1750067420788;
        Mon, 16 Jun 2025 02:50:20 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2384cesm137359895e9.16.2025.06.16.02.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 02:50:20 -0700 (PDT)
Date: Mon, 16 Jun 2025 11:50:18 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+ee0ddd3c79cac08cd4f6@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [cgroups?] WARNING in NUM (2)
Message-ID: <qcwg7zdvsyvcxnkyn4wdn7xbzi3urqzy25m4qkb2t6zeb6fjm4@n3up3tlxjurw>
References: <684f296b.a00a0220.279073.0033.GAE@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="puayfpkzkxs45w6x"
Content-Disposition: inline
In-Reply-To: <684f296b.a00a0220.279073.0033.GAE@google.com>


--puayfpkzkxs45w6x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] WARNING in NUM (2)
MIME-Version: 1.0

On Sun, Jun 15, 2025 at 01:13:31PM -0700, syzbot <syzbot+ee0ddd3c79cac08cd4=
f6@syzkaller.appspotmail.com> wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    19272b37aa4f Linux 6.16-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
=2Egit for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1005b682580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8409c4d4e51ac=
27

Is this report a new lockdep occurence or has CONFIG_DEBUG_OBJECTS=3Dy
changed recently here?

Thanks,
Michal

--puayfpkzkxs45w6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaE/o2AAKCRB+PQLnlNv4
CMA8AQCCcXjNhexkroeo2pYBPQr38AMp0EMNGh/nNH3Ct0ifvwD/aZp2GgBP0N+f
DMaWMmj6wmXshLtEBD8OaummB6o+3AI=
=EvjT
-----END PGP SIGNATURE-----

--puayfpkzkxs45w6x--

