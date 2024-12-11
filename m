Return-Path: <cgroups+bounces-5803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3C9ECDC2
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D08285A4A
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2054236915;
	Wed, 11 Dec 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YRjCGjH0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B472368E7
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925389; cv=none; b=WsQ1EL9Rx0gcoqFW+aLe9drLyIdWA7bHxQo3cGGn9i/aTpMX2CCOTNjw8Lo7RI6UX243cJROyDGqSPilrBXyOdLeQx6BWgk0asIXix5rZf+xR38EtwNwSvcfTMUkAn4hmnv7gVtImEK4/S1GbodLw6zpzblDggeUmwv2ECEYs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925389; c=relaxed/simple;
	bh=cOZOBUKJFU3Lf4npohtP1sWNz5qJuMjZHm3Mj9pQHuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlQp9ZsA3TOftmwuDVM8w+Qdh8Epgav7kWUOFLy801mnR43KsE6JlFfsWneGID5gG/A4AOPeGkFNnuSigkUpV3WsbpbVoTWVKxCJNyG81pN6ZGtL0GWKOTpiv3ML9jD3/n6TKADdnewj03OnKmeC+2T8PPvp5gpc01GR+DLrHI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YRjCGjH0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e06af753so2990027f8f.2
        for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733925386; x=1734530186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqFZPLxg9uXUUbFYl64NJ+hd5kjKxlZzEdF/XByvoc8=;
        b=YRjCGjH0FDXNesp4KlYc/6BPk1QPyKv5y2laOSxyOuAvg4FRNFcgY6VYDMhgK/gBeX
         +pmlMtf7Ak97q0MfYwGDCeBPxqxkmSoJF9FTSDl1mJnYkFtv3iLgQ6OgUz0nKTQh3Rm+
         DmLzrjaHCs91GYwdzD5SqzRT05ACJjStG9SUxQV2D1Kq5IOZ7RBA3rOf0kPhdBCSyrpk
         sHBj8w9FkydJ6zoGUm0SvdHimvJ7MQwuEfJSQiitjxYRiqEanWMFOQDCiOqYWh/ooUer
         T2G5+LdJuPOT8xODEbLxFfrNxnYEsglxAt9gv2WRIsybTYwNDJky28v8iPla7pWD06mE
         wtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925386; x=1734530186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqFZPLxg9uXUUbFYl64NJ+hd5kjKxlZzEdF/XByvoc8=;
        b=hEtRCmP789QkapIw6fVmmpBMHVtNNUKuSrfNIF2XSybj6uuqcENzuQUc9w0cLHPi92
         8Pc3wBbAHwsuF63R01NFN46C0nOi5jdvP25+dJV87qM0Om1viCtgDWGfzqLuGNKrzIuI
         o/6iVSaHhX3GpdfJYrlK4TQ6nzHJtJO4FhRzxyaAG42mBzjqb4759+zkzAL3PZRHDQcS
         l0HAR4XH2LrpGLa0kk+CyR9aMxIasdKdbTKvJ5jBJDfXp+Fp1lFNSHimMPKGzQYUPbN0
         ec/nXL7qDJeHlO/wj7nUNzvkuGgRiE3bHqXOV2DgbWzRc+sbKlOjJfo20iBGW8stoGWT
         jxkg==
X-Forwarded-Encrypted: i=1; AJvYcCUqx1D3na18CKZMKa2QbXXSyUkKt3B8ac/rJHgUHLPmaHvLWKtEdfDXcbzJ0ae6Zr3Rgz1scB0c@vger.kernel.org
X-Gm-Message-State: AOJu0YyvEOdCjDR2SHOqTrlwHLXtM/AOk20c7tuBUH26BILCdVJ5gEm8
	SyunEHj1T502KnA5N1ECRuDPGcTgw9RhuHNNrqIvQjpJLL3T1mfGaPMNNBZK8yY=
X-Gm-Gg: ASbGncsVILG0dnUQKE76ls89pJs8EWyVbJ9EFB9UJPwA6Xah/f7ZMYe51wQIcFRen3J
	2MOaPcx5Bi2sMDIhBPWBH0o4cZb2hW3RwWLneMaUXhYPEpWYvRqoXYqrhZoO0hPAebc0bIfUgFw
	ZvVjo1GgQlnaC0pNAKj5gP8P47PhuCZf/7Ya4LMBwAfphWdX0p18nC8A2RLQE45dBDwPscrPQa5
	t/X+kq1f5rsrS0duY5vpF3ZFnGhk3XCqtaHn7QXJwIKYxCie0smSrTA
X-Google-Smtp-Source: AGHT+IGN/tlBgq07nEHIVsqXdpp57QSK2WTSNBZ8RFtj64TIKDFnIwFbJhJRViM0/qs5EItfPlBiCw==
X-Received: by 2002:a05:6000:4609:b0:386:3327:bf85 with SMTP id ffacd0b85a97d-3864ced1fa5mr2757678f8f.53.1733925385737;
        Wed, 11 Dec 2024 05:56:25 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f810sm1342192f8f.22.2024.12.11.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:56:25 -0800 (PST)
Date: Wed, 11 Dec 2024 14:56:22 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, hannes@cmpxchg.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/4] sched, psi: Don't account irq time if
 sched_clock_irqtime is disabled
Message-ID: <wvqotmnk2kad3lyigbsc5vtq4ymdtaxqcjijaj2f5mdcp6m742@ltmazfge3eu4>
References: <20241211131729.43996-1-laoar.shao@gmail.com>
 <20241211131729.43996-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oebmfrqcf4dfbrm"
Content-Disposition: inline
In-Reply-To: <20241211131729.43996-4-laoar.shao@gmail.com>


--2oebmfrqcf4dfbrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 09:17:28PM GMT, Yafang Shao <laoar.shao@gmail.com> =
wrote:
> @@ -1286,7 +1286,7 @@ struct psi_trigger *psi_trigger_create(struct psi_g=
roup *group, char *buf,
>  	bool privileged;
>  	u32 window_us;
> =20
> -	if (static_branch_likely(&psi_disabled))
> +	if (static_branch_likely(&psi_disabled) || !irqtime_enabled())
>  		return ERR_PTR(-EOPNOTSUPP);

Beware this jumps out for _any_ PSI metric when only irq is disabled.
I meant to add a guard to psi_show() (this is psi_trigger_create()).

Michal

--2oebmfrqcf4dfbrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ1mZ/AAKCRAt3Wney77B
SR4pAQDZtCgrhq8IrES7YK3U84zIRXuk9NSntgVE5ogCjw0juwD9ECxBZNCypCnG
VlpO2CR82SghljzRb9NsiPYRqe+KSAQ=
=/a7w
-----END PGP SIGNATURE-----

--2oebmfrqcf4dfbrm--

