Return-Path: <cgroups+bounces-6456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E5A2C238
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 13:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F375216B252
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24B1DF724;
	Fri,  7 Feb 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H7QVQrRR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519E1DF240
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930128; cv=none; b=gbf2cirhrOOWLWvxIwJi1sq/8/1tRAsmRr2VwHTkf6+//IRevai087DOEizsFpDwTGNSopV5c0qnA3x8/jWJUEGdsLGf+/d1nz6SceAS47py6gAnbowtHQwzQuRHlJ5bZaeWo3d+/StbGH9VRl+mSzuS5xz7ABTPZ7sZymzXdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930128; c=relaxed/simple;
	bh=U/Jgdjvqr++otkbN/M1auVdgDYGAuQtYyO3IkQ7iUrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZEkOUwMYYd3KQXhiyX3d+gI4CjSJ1SK4dFJZSV0pAeYXWIq2sxVu1yFLDAonMHZi+RzFuJkpLMcp+wPKA+gQKpJZuRckDmFJYEUVncvvKgD61XCSwDq82xEVWvlItGRMjOikVElJYRgo/rF5xJJFEXZmv/ZSFo+kSJMBsq5IS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H7QVQrRR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso13622425e9.0
        for <cgroups@vger.kernel.org>; Fri, 07 Feb 2025 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738930124; x=1739534924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/Jgdjvqr++otkbN/M1auVdgDYGAuQtYyO3IkQ7iUrs=;
        b=H7QVQrRRsLTgItSc57CDXHCe4OJIc0bvpzWo8igZ8sxJGT9NjafoIawmO1SQ8bPAA+
         QySXWygJd+hwiSQMg+TqWrUGldqonNBSPi5t8wYA8bi+dt5QKc8e8szB4crxeG7YMKuM
         39WSFYf8y5C51G9k6Sz1P1bfYs33pLtJjFhnNOjoamEoGRouU36VXVppZ0JrXMHAtU4i
         cwhta6LmhzAoXKd37cTWpNb+Ax2fpQHqeSO0VOh5EP5E22Q5cCjtNHSaursgWY+KjouN
         olrCJZZ7f/2N7tAkpDA4RBMEP3oRoxFz9Kk+PWHy3d4mX67ZDxnTqeak/gbEru0EjbvR
         hXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930124; x=1739534924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Jgdjvqr++otkbN/M1auVdgDYGAuQtYyO3IkQ7iUrs=;
        b=Y/CldCaDbjOD6YSmlzbgkfEenSYEte/7pbE5x5uGGV7GM7yqiJGPLqCZpC/7YvkJ70
         gB04XZ4lgMnm8vq1F2loknZiT8jzac0W6mXXINy7ldumThuEdHrNfTWpix8s17vyC31t
         yEb0Z3X1gQxB9utGp8petmNdOgGTgqBoBjFqyQvw9x3IeLdqqyTxUWCmSBtTeQSblSu3
         kwyAfDEUKtOCGmvNgDc7FT+Q+l5zq9ioXOQM5v/Psevn0o4d+w0FKUbFeZwX/IkUhPpG
         2zW/bGAoAY39dX2U4bxl5u4pMq6gD3jvZBrvelg32CoKavG90+gqQ9Nqf4xLGrxI3UbW
         zirg==
X-Gm-Message-State: AOJu0YzkX7Gi4m6b1CRTn3OmrENVf8sXHA0lrrZon/fFfJAg3kN9nzlt
	aLt7slnmBeA+FTi5L0VdYPVXaPC0qbSMlyJe8Jn2dcnQYsKV6EaD9HfwVqDBLxF4De4m1uKHyJe
	2
X-Gm-Gg: ASbGncs3T0XBRl0c4u5tJg5Nqzt/690vOI/WGO30fPNRKdjbE1MAmDTgbwkbOuL2mcs
	/dfXGFtGjijY/Lb8B5yI+XIztgvi4yn7F9uAq/rySx4ogKXIhoWl8THqmHL6QhQi0MaZxluMPQK
	Z7+9RmN/KihpVbaWt+2Iq3k6BTR1QSEb4gqcNCwQIsVoTQFSP/N+PeBBokYQcpJ8H7v0FzVL30E
	N5LXul2umluqsfxuOEIgjoYKW9mIOtGSo0jq7lzTca2kF9hh7HPsd1iXHei7WbhJ0g2kzB0NFMA
	QctLEpykIFm+qKSk8w==
X-Google-Smtp-Source: AGHT+IHl8/eQfroUs5dQZ3q9J5Inzi3aWhbqn3imacga5NT8+D677SYP2EHIfv+FTGTcNLeBanxXkA==
X-Received: by 2002:a05:6000:1567:b0:38d:c433:a87 with SMTP id ffacd0b85a97d-38dc8ddebe3mr1949397f8f.22.1738930123631;
        Fri, 07 Feb 2025 04:08:43 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d40csm87748375e9.9.2025.02.07.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:08:43 -0800 (PST)
Date: Fri, 7 Feb 2025 13:08:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Muhammad Adeel <Muhammad.Adeel@ibm.com>
Cc: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	Axel Busch <Axel.Busch@ibm.com>, Boris Burkov <boris@bur.io>
Subject: Re: Remove steal time from usage_usec
Message-ID: <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
References: <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lj5sdpuc7n6pvuiz"
Content-Disposition: inline
In-Reply-To: <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>


--lj5sdpuc7n6pvuiz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Remove steal time from usage_usec
MIME-Version: 1.0

Hi Muhammad.

On Fri, Feb 07, 2025 at 10:23:41AM +0000, Muhammad Adeel <Muhammad.Adeel@ib=
m.com> wrote:
> The CPU usage time is the time when user, system or both are using the CP=
U.=20
> Steal time is the time when CPU is waiting to be run by the Hypervisor. I=
t should not be
> added to the CPU usage time, hence removing it from the usage_usec entry.=
=20

It sounds like inclusion of the steal time in the original commit was
rather accidental (+Cc: Boris), so this sounds a reasonable change.
Could you also please add
Fixes: 936f2a70f2077 ("cgroup: add cpu.stat file to root cgroup")


> Acked-by: Axel Busch <axel.busch@.ibm.com>
(this doesn't look valid domain)

The mail doesn't have proper patch subject line, I'd suggest the tips
=66rom Documentation/process/submitting-patches.rst about patch
formatting.

Thanks,
Michal

--lj5sdpuc7n6pvuiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6X3xgAKCRAt3Wney77B
SQIpAP9BNU25csyhJQZWISr1jgyT9aFyxaweg5dlfgKShxgTrAEA+Z4mcL4pIQMp
8EYzmjXLXHGCM3Yd4SmVYhqo1drPggI=
=EfGw
-----END PGP SIGNATURE-----

--lj5sdpuc7n6pvuiz--

