Return-Path: <cgroups+bounces-8412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B47ACB6C4
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F6168471
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E2822B8B0;
	Mon,  2 Jun 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQZvvNMo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AEEEBD
	for <cgroups@vger.kernel.org>; Mon,  2 Jun 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876866; cv=none; b=q98fr6UOqPQzwK3eigec0dYzTku438FNpArxWWDgPgQyADBEUHmmGE9y/4qq2A5xAwe0XyPLXOaX6atHZdq21e6PEW5rstbpl/cttAr4bAmeXXa+uCznOEC76zOVFMYRgi8eM3EM7iTI4bYAJl8kdBMwsVyt6OIylYfdVZNaw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876866; c=relaxed/simple;
	bh=YS7JBPHbS6sCNPOiRhuoVUZgpPJBUX9cs2X5mWxMiZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW7mEy9YOmWA7DYv5gFisM4Ppkgj/FLsIcqM0YyhP7msfwfpux+JJ1ivod04Pn8Na1N0kjndQhIpiW3zrONepjp7n7XzQ0QFTKAXyV8IuHGbclMPZDg2u2leX53swoy7+bwWeo2A7Wzk7YTfK07ENBr99sWSyQiSHsa1vOCP+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQZvvNMo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso30487565e9.1
        for <cgroups@vger.kernel.org>; Mon, 02 Jun 2025 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748876863; x=1749481663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmZbX0hlsaI3hZ8qq+l4gSqxZaZCX/s2ZALq5WLxKE8=;
        b=dQZvvNMoEvGoJYpCcHGcll5p8jJ8u2dlv9VpCaO9pibvvbNCEKH+dtqqM6aRQmqT/p
         f75gWERJ1i9NIYh3hbmIDQrCkaMYb/6fp3TaQU22UFdkbeNZXq4voa9C6LOxKix8nGYf
         IEfMy5EuaJAQZLqFun7CRYMlk9MjgPMwfHRYE4QVcDYMprPJFy3BkevWdZrMez6ZUr5l
         SbY09De5xrWOcgbU0tFY9RnIAOrZUgAWYt5hkBcBCLOyjcvqwAYfeOHkiOSISce9LPEf
         C0SYxhIZmGvS5VQQzaTeGEIbQsKxFFscUU1bV1VyENn2UDEjbaoe7nwz3jf59Z57RZhQ
         HM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748876863; x=1749481663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmZbX0hlsaI3hZ8qq+l4gSqxZaZCX/s2ZALq5WLxKE8=;
        b=H2SPpw6aAdjCYCIDtAxghE5/AOjZ+mIVMfRrpABMuEdyf9fTh+QFfooTPKnif/obAr
         LAFU5OtBgixSbCHtNJXgD2geAZBtLy1ma9MDRyafLASpsHg1aqTsy7fj2jYXVHSVu8Po
         j55qxanTXbEJ4Fzu91ZmXzkdifvircIj3f+/hxWOMw4slTziW0Ymj87U1njyRgsLZgPM
         xDrC9Wn2Dr/xCHPnt9kWHS/EQAama/u02k9YLSwzSkO/Pv5boqtj1A6hn+24c6YCvUhP
         vljINrbThEKh7pBFFUWY10Q6CrMUjxf0lfTb7haq4w2S96PDttZmU64IYHzmUokmVVQb
         o1oA==
X-Forwarded-Encrypted: i=1; AJvYcCW2HlFn2dHuF9Q2FFgN8KvzHHHCKo50uK4GON0PTYsULuk3GUM/ttJ4T18cTpqd8sKqEPuyKyXP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AHi2BJrSQL3+IvdKPN7ivYMR+W1o2/JLn+Xw4C4jwoOMGetN
	m0fi4H/wsBy+6KXYB5LxwhMsFtfEb5spQVvLgcqKuP7EQShikxj6YYF+7gm+2g0vRkU=
X-Gm-Gg: ASbGncsShalj+5zhGYqduG2Ktdu2QbUWx9Bz06Ws0Sjc5IDSPsWRvtVKRtKp4CoQXna
	XxOEA3S8xTjfN3YG27b2KUA1h/sFXmfD88fQwqUXPkxoA5R2zI3CMrRpM26ykD/vVDqTGhqQXAJ
	JwDHrXPW1/blKzbYVD+fwwO5pcDG1CHzFBDxBdvU8WAFxcOtEBURRrO1j9uj7JiiWGE6ZHUjVGd
	huQA0W+tGJ/x4q1ZYx+y0gFceCn2kxhb8qclbpZDhy5vwF6I5X3SJGQMmARbo5VEycFcWVjDUz4
	qYfqcxLxCoGraNQaFo3xSPMc4ojbAVWGzbfXRERz5W53m9cil61L8tWDz3hkz3KE
X-Google-Smtp-Source: AGHT+IEV3ITHhmGwWx2FlchqXvrVWIl3FpfBnBI/wAlqdH3JCQ/rjbxCxS0wIzpVGp9Z5bEQIbTdVA==
X-Received: by 2002:a05:600c:4e92:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-450d882488dmr131286665e9.10.1748876861445;
        Mon, 02 Jun 2025 08:07:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa2342sm129350345e9.10.2025.06.02.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 08:07:40 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:07:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3 cgroup/for-6.16] sched_ext: Introduce
 cgroup_lifetime_notifier
Message-ID: <kzgswr6dlvzvcxcd6yajoqshpumus7fiwft7mmsh5vcygdc5zd@mfauedvifz7f>
References: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
 <aCQfvCuVWOYkv_X5@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mpvcqhixvxwskac"
Content-Disposition: inline
In-Reply-To: <aCQfvCuVWOYkv_X5@mtj.duckdns.org>


--7mpvcqhixvxwskac
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3 cgroup/for-6.16] sched_ext: Introduce
 cgroup_lifetime_notifier
MIME-Version: 1.0

On Wed, May 14, 2025 at 12:44:44AM -0400, Tejun Heo <tj@kernel.org> wrote:
> Other subsystems may make use of the cgroup hierarchy with the cgroup_bpf
> support being one such example. For such a feature, it's useful to be able
<snip>

> other uses are planned.
<snip>

> @@ -5753,6 +5765,15 @@ static struct cgroup *cgroup_create(stru
>  			goto out_psi_free;
>  	}
> =20
> +	ret =3D blocking_notifier_call_chain_robust(&cgroup_lifetime_notifier,
> +						  CGROUP_LIFETIME_ONLINE,
> +						  CGROUP_LIFETIME_OFFLINE, cgrp);

This is with cgroup_mutex taken.

Wouldn't it be more prudent to start with atomic or raw notifier chain?
(To prevent future unwitting expansion of cgroup_mutex.)


Thanks,
Michal

--7mpvcqhixvxwskac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaD2+OAAKCRAt3Wney77B
SYMKAP4kKLubHhxkJ4m+25CaI+uUpkXSQYSkq6ZvnVwycFJtHwD9FXw1ryxaxlez
wPFLo2G1jfcEoXRQWwzLuL6Qe0BsdA0=
=KPDi
-----END PGP SIGNATURE-----

--7mpvcqhixvxwskac--

