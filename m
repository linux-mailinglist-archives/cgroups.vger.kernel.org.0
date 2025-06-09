Return-Path: <cgroups+bounces-8461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30879AD1C88
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20C616B29E
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B125228E;
	Mon,  9 Jun 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KbCNGTy8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274C1C8604
	for <cgroups@vger.kernel.org>; Mon,  9 Jun 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749469458; cv=none; b=SyUdSVEqhe+vbPdV7NWzMhBXIL5Jc4/81b/Fr1y7OJFP6R0Z/1msG6/VA+5Xg9uz7ilZBknQ5epe/Q2Z0iCCid4jrb9JZ6WOMGQtzQPEa6yC3aVbC+aNdy6IdfXB7FE8hI60Jpb7XZjcYlsYLHaXdUnEbwYu1gaPkVJtOCefA2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749469458; c=relaxed/simple;
	bh=zeHzgmvMo4kT+nqZaZUlerAkM5GChqsGWSsjTjcoogs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWiF9HhUVLYsnVRHKkrX4nMN8B/1bxzb+HTwplWPNV7jDSG4jZS6umC5TaeoZRexxsUxWTr4iBlyeyxXrnhU2MZvFKEt3Z5ULA8dqWL8b3V5HWUqLjjpShQJrDB/w7vChJzIFKsnwrR9DVHjdo41RFgy8CffryEgdU5hehi2l2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KbCNGTy8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so3497782f8f.3
        for <cgroups@vger.kernel.org>; Mon, 09 Jun 2025 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749469454; x=1750074254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDJBJhjg5OJ53rHN+kjssK0nNcY+e5meMvsnHTIe/NE=;
        b=KbCNGTy8tk2LR+uOm17P5deEksR42Vf/xFaRCySSWN5qQuuIkPvxXF9TF8JQrhFHwk
         +J+kXX8tC/dxaf19KJ9ErtXiZdxXDPfVQdtvurLgwMQEdH/yyt/yDPIML+7urqMLfQzT
         9rjgux3cOtArag5oPz4BYfiRX1qHuHzIpklgyLupNegsfvhSEALhdpQIMAkr6sS5bYNM
         MZFrPP+Va7VV7l47mt2fhj2Cvt19fog+AKn83T86N0SLsGofZC+dBY8/IEIG6CEC+GhV
         V2nHXYVyAxOqYdE3LFiuYFT51OKYrbPEcsEP2QFVp/i+OUWzSai587GSwrk3XnBh10JP
         VuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749469454; x=1750074254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDJBJhjg5OJ53rHN+kjssK0nNcY+e5meMvsnHTIe/NE=;
        b=WzADN7KoWstQZ2sRI2tvjtbqUKIzs09DohXNa6ldFA2NHztC+TYH2XytMjOyqs3SMI
         IfgvcWIYmvEdnf/zo249WU2KHKI4cFS5et+8qInV4OUX1AqcVTFQRgc2Cro4SnyBkWE2
         xlfAQYu8F2fSoLYFI9Pd+ptXP4eJ6ul9V6Mmzy+79830WEyYxjg4Yo+8ET6cCfU1otcg
         tG0wHi/P1aOw4V4FMm2Sjl+hXC701FT+znDXKPQxXU1AqyTMLmiEuIJRm9ZpDkWBuuuv
         z0GKoPHpwI3yBbC2+dOVdhdZyxZqMWvCvh8KMIaTQV6ODSYenv+mBrn8paarrFCw7Z7e
         mrGg==
X-Forwarded-Encrypted: i=1; AJvYcCW3IEJpZnFSJKoaJSVcToJAhVLGomrTMN08rJneYd38+6gF0F4H70ZKpf/ZXJrDkQEpvdsKfAN7@vger.kernel.org
X-Gm-Message-State: AOJu0YyVn9vCqi1dfONpFiwBZVPa8uvb30K6VsarfjMwCpwS6D4Jz1ph
	jRMNR+VI/uMZItbqZ4zyvdKcipgsAa6j9giqLGImIFewBC0xz6L3gI5BK/vBnP7rS5w=
X-Gm-Gg: ASbGncuKNZtlqMM4e8hZyGNSDhTM6deXBX7ktYnwzvkkyPhlznMI9+mNg+NI4nhAZAx
	p6HVsw/tdazDM/eRflQyugC4l1NYCDSN8jWipeLhCd0aEzmPKXaxbhi3gr+VnsVIJB1w6RPgRYb
	ZszyCcXr+GvvRbxPC/Cf1vTD20YcvgbvI8927oHzM92n9wHmhqaXWpLoE6fa0tkl4/0Rd7fLTpa
	5dprkABWN1TI571t+lfMOn8FzVPDLz4qUna+xTc3OnXgfSetTM8LDDIflkvPWt+ZLdbQEiHzV+e
	GgGDBz9jgcXBRQOipaHqUpuccq+W0FzQi9obuGewSYSdWM+KnnSjXQ==
X-Google-Smtp-Source: AGHT+IEqVTlmLfphpuy8ag0CYOQqHWfNuxJKrQowvkGCIt+x0WvJgUBgA21mrVlVzbLRWzR2FoeSMQ==
X-Received: by 2002:a05:6000:178f:b0:3a5:2694:d75f with SMTP id ffacd0b85a97d-3a531ce73bbmr10195650f8f.52.1749469454236;
        Mon, 09 Jun 2025 04:44:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm108852525e9.35.2025.06.09.04.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 04:44:13 -0700 (PDT)
Date: Mon, 9 Jun 2025 13:44:12 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Wei Gao <wegao@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it, 
	Li Wang <liwang@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
Message-ID: <rugkmu3bcsrqgehibgy3dn7nsisuv6lip7b5cmo3bewq4zjcdn@zuo6hg25pqyz>
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
 <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
 <aESIDuS42cY_sLBe@MiWiFi-CR6608-srv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qt3frmna7xgxwqh7"
Content-Disposition: inline
In-Reply-To: <aESIDuS42cY_sLBe@MiWiFi-CR6608-srv>


--qt3frmna7xgxwqh7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
MIME-Version: 1.0

On Sat, Jun 07, 2025 at 02:42:22PM -0400, Wei Gao <wegao@suse.com> wrote:
> @Michal Koutn=FD  So we should skip test cgroupv2 with CONFIG_RT_GROUP_SC=
HED=3Dyes, correct?=20

Ideally, no one should run v2 with CONFIG_RT_GROUP_SCHED=3Dy, so this
would never fail :-p

> Like following change?

But if there are such poor souls, that skip should make the test not
obstruct the rest of LTP.

Thanks,
Michal

--qt3frmna7xgxwqh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaEbJAwAKCRAt3Wney77B
Sb7qAP90GPa1SJAkY3j3BiLhujkNOrdENJP+gG9OL+jpDILnEgD/b89X7a2GiqP5
lnjXvOho9Bt2q+qPmst+4z6QUTg3hQE=
=9dwR
-----END PGP SIGNATURE-----

--qt3frmna7xgxwqh7--

