Return-Path: <cgroups+bounces-5739-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8C9E18EB
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 11:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A5B37942
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90971E04BD;
	Tue,  3 Dec 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JrcEo5/W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB91E009A
	for <cgroups@vger.kernel.org>; Tue,  3 Dec 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220098; cv=none; b=ju6U+uekxudRjoTf4Bm80Yg1FrCcy8b6rmVWynCGqhfgrpE89lC1LUWfMexDJ7DGeeYOIK6oEAHzCfhrLnZNOXBtqf7dTcH6Q94VWR3md0RGTs85uRH7hlP8mAr91OIvnFfuk9bDcsh23qchE6JEnvcf41piNU+CyavL/Qhq6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220098; c=relaxed/simple;
	bh=sTaUZHI2tA84h8s1smjIA8SchVj4beLWUzNFEdnsLGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1Y+BeYj1j1moNYwg9ym0VlPoQ3YGnHQF6nlKCgxnUxTBfdCMN+Xs6JkNrXS9tL5zyyYfl4xEvxlerwTE+pZG4ZKVrtebFRBZbODiv+tZs50OYBlxDMU3TmfBLap88Pw9n9Av1JqsDujdl1laYUk/XeGH1NxGIfmNARe8rf6usA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JrcEo5/W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a1639637so49438565e9.1
        for <cgroups@vger.kernel.org>; Tue, 03 Dec 2024 02:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733220095; x=1733824895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhTW3NC1pbn/g5iDVajml/TzAYdzfRHRj7mqxdaAUTg=;
        b=JrcEo5/WIv5Y9slnLjpi/tW3KI5MOSebxJKEa1pKNvnxP7V45KTywrZEpAyV+MO+h6
         P+HFFvS/OvRo2a2UTRC/5BZqi2M4p7keEErCrp07MRCXW6qksy3UmoPWE2oQIUtGwPEq
         ezwqftIybC1xeHnQ05tif/2y7yXAG+rjVp+SJ4NEO16SMIfV/FYTpRo/NY5b/Ar5ONqN
         rJ05Tk/cDGZYM+Fj0QtP/ZnCsnIOHr6Xp2TtEnhpBtFyLHJJPLRysjvDPjOVSgiMbgBB
         ej0VPLItBX1FiOet0tH0GQ1wdG/5rPV7VBlseKeuKX21I8pyUmwx+q/JE5lfUHkitm8m
         n/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733220095; x=1733824895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhTW3NC1pbn/g5iDVajml/TzAYdzfRHRj7mqxdaAUTg=;
        b=cVERQaJLZSzcnnDCep4wgk4RnbMNsPmiTXOELTVnxsxsjgCfmnnmz1JU4DIc8Sv4Im
         UCWdQ2yY6G5L+evD+ISQfT7UMy6RxOf199o3Y+3UbAbhQf4K94d99bl61RKNI3j5EwTj
         hA3HZuqYwA4O+aVchUvNMSJPnSOmOytSGhfRld5Jh9iubCTX49PqtCZMPa6y0bKttyxt
         AmdU45fUw2wwfdlkC9e1wJ6i9loV2eaKL/HGsJ4I33UY8q7AYgFDs8xJP/o9l+mfUwJd
         /ql9vMiUFOOH5uZ8rVhJkD3hcMUZFgAKVGCpWeQSfDxIgi/TNXvh8iAALw9M9dBGipHF
         ix3A==
X-Forwarded-Encrypted: i=1; AJvYcCUMCnGNvDfwDh3nZu4vLix7m4Hcb/U+PG+ft24/fkdKug3sENmPsN+lhB2SZYY1egdZqPcXh50F@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1g5/UEOaQlibWaev32Hj72V0m/dJBFI8+3mrJzJfXMVXx4BcL
	QF/ssbeElFmdCmoDBkJDDq/45zIf8HvNgF0GmFqwbBuBIhlUykyp5NXXEyf++aE=
X-Gm-Gg: ASbGnctoxsMYA2tzcjVbey24dugA/JGFnm6TSJyD+kywQMp06bbecYHMrDwMSerSeYD
	bZHaAR9KrYLU2KxSWIhTxmJtbDfOeWyBsfCcme0v/DsvivIEzoWfKT0z7iOUeO0QR+SuhVied3J
	f8th3OrtF8G3Daxd1S4YVHO0fRpZ2zzYpA/zDAQje+nA3Oqil3XO7UyvT5R5QVJLB1jtvAjwY77
	hgWaNxf/A9ni0U4VRlpKjvbR0uQXJ/u3t/eAqxdy+2mUkf6jbBU
X-Google-Smtp-Source: AGHT+IGq5X9mSPxxsAFmS7My9jVFZsDOIyBErQpUdlf+4yk/lCrnKIeVD1Y0clKPxw7cqtpmcqfo2g==
X-Received: by 2002:a05:600c:4748:b0:431:59ab:15cf with SMTP id 5b1f17b1804b1-434d09c37bcmr15948935e9.19.1733220095018;
        Tue, 03 Dec 2024 02:01:35 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc91sm188449525e9.9.2024.12.03.02.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 02:01:34 -0800 (PST)
Date: Tue, 3 Dec 2024 11:01:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org, 
	surenb@google.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] sched: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <odrc34bhhsgvrbpwenhppuhoqonhwzd7gboiib27lkwdcblbd7@sp2nukpotx3u>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <20241108132904.6932-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ea4zwagibntp3e67"
Content-Disposition: inline
In-Reply-To: <20241108132904.6932-3-laoar.shao@gmail.com>


--ea4zwagibntp3e67
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 09:29:02PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> sched_clock_irqtime may be disabled due to the clock source, in which case
> IRQ time should not be accounted. Let's add a conditional check to avoid
> unnecessary logic.
>=20
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/core.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

This is actually a good catch!

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--ea4zwagibntp3e67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ07W+wAKCRAt3Wney77B
SUToAP0bf3KX+N5xm3vm8owfdlzAy/cVhQL1fm1fSrhXqDheCQD+Ks6ccQNENKEb
o0qFsPqS2NnoPMupbIr+Hyuox4gA+As=
=N/M7
-----END PGP SIGNATURE-----

--ea4zwagibntp3e67--

