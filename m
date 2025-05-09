Return-Path: <cgroups+bounces-8104-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10BAB1557
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831A7500307
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F22900B6;
	Fri,  9 May 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gstMkIx9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900D2AC17
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797749; cv=none; b=uYWWTvdAmYV1psyin1EIZBScvdNBLzShyuU/+AcclHi7BmansmAjIyW3Mu9R3fp+zolvdoIsTZypzH3T66im0Wh4fjPGukaNHrHSGGBvPW4YeC8Ud04A27T+hvA0xJRsa9PoltNxi5SfMVgq4I5FKSBRzPiqt0jBrVv1d4i4CJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797749; c=relaxed/simple;
	bh=Dx+DkEzhbxvytOQXjorEQqxJ6zeAnsoM4QWfOqiHclo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk3iInc4K69rsVE0l3j+xRbdeNv0IvMimF7dUHb3SO31qOhE0BKwCCLWMPZHHPZp3bdY+3U7vFieHjKgJTKIEEJs+2WD6eHyiPb4upTVF8mvbdquGdX0x2W2jD9tjmy3AnyfxTqD0Tl3VlifjMbD44cYeqJ44/GuZ+c9XJJVUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gstMkIx9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so6051004a12.0
        for <cgroups@vger.kernel.org>; Fri, 09 May 2025 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746797745; x=1747402545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjxNnSRsyTmUOjnyHt3URsc7lY8Eum3urENUO1QtEX8=;
        b=gstMkIx9ACSlXcuNxvTuVvVo1zG1k3w/rFVWKTxJ2FrNM3oKg8eyfB1WmQZlv9FJD/
         bo7Ium2xOI8Wlter6mNOOJpxfSHZAwFVedfV1NRvHJAOPk08uJ2lMGR8gJ/9h2KtVb1f
         ek1jzdWVHatzCWlNQ1aHOTnblunExrZvhQCi2VOQsnIed7EmRGdhGxobGL0dre6MyI5p
         g9MYDC3dkp7Wtyv7i5DIEZmsGtrWEtb9oRdHx3T4FgiXGBBUvQXgk9oS1czBuYn0YzWb
         PuGVqpy/FyHkqevQ0ZxWas7+umIj4+mETSRBmInuHLscuac2dbQTERnFUa0gP8N+f128
         aFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797745; x=1747402545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjxNnSRsyTmUOjnyHt3URsc7lY8Eum3urENUO1QtEX8=;
        b=NJi4c6YM/Vz0VQpBZzVIvPb8wSrzxX0/prAfTzl4kfVnYtZUqRjizSOlO95mseIzJ/
         8SREa6RO7BJb4tvZ6p8uqsexqEQlRmZZ/AmOCmhHBbB6E1IE37PVjuH/nrzusvrrPgLy
         yg0SzqOHjQ4vmTm5LFysoqcrD0SXO7VV2zKlm2RthLdDn9+MUzI9KNyuALJ8zek/oRGR
         JLC/lzmrQ/inMa58x+j+cXl2nFA8lfcfK+47dxAGoJLn6fUA0MqdGAZrsnOclbC9qfsa
         RJWhEjxj10NpjMe0ZUNVIeZWIoB2xfcyTuXz59oCklldLw5a/x9xX3g/KkwFGvZLPoDW
         HeFg==
X-Forwarded-Encrypted: i=1; AJvYcCVXPCfuXG+klYKMDxGtL7hUgq4jqFIQf0v95JxwF8WFYScfx0jQAMzWs+P1q/j4v1WO3cJHkFxO@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+Hhqq30ejy7Z3A/3IbUjTTPaDP0XB1xp7xL11GGkQzxy/Rn/
	CgH4BVFsQgAfnl2iwVmaY5UtH0fplgu5H6wS8uFbToL9bTRtsZJUw1b2rg7MvGs=
X-Gm-Gg: ASbGncsTa45vIcbFL6cy6/6v/cTjREEJg/sqJa1v9BdQ1ut5bFgpIcXuwWzsKcXGGEX
	3vJU6W1ivEjv/4BNnVTBK9K+LcPN8GEGEbfaTywyawc0lPc2Xz71TvpDZbt4xHJzVkycuox0gmM
	2c0CPZysKZ3/edfkGW8UmcAqfNDOBEh+tPNf5fIq9QukUxJKdt99nxbKUBl2tyA5sz2D+z5L9HF
	1YjeyeECYyxjejgrIwMRQ2OQnxF5HSZtuL6hP/TlypRdR8E7PB1Av8PRTkPGF1HznzGhlZcJ+jN
	gUtWu1N7Nz19DbaLTVz1rmdBOT8iZDxO6uPTFA8CdMJpsWeAL6wlIA==
X-Google-Smtp-Source: AGHT+IEC92HkUWApzjxSiVUUdHJiD7B2GP+/NDWqDaw0SPDYKaXpVgjz3afQ5uNreNHfpLDNqtzMrQ==
X-Received: by 2002:a17:907:94d5:b0:acb:3acd:2845 with SMTP id a640c23a62f3a-ad1fccfced9mr670506766b.25.1746797745416;
        Fri, 09 May 2025 06:35:45 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21933be9esm150415666b.46.2025.05.09.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:35:44 -0700 (PDT)
Date: Fri, 9 May 2025 15:35:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joel Savitz <jsavitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] include/cgroup: separate {get,put}_cgroup_ns
 no-op case
Message-ID: <mknmd2234xviy6lv632hruk2sgc4senbrodlkt4xju6w7lo6zr@l5ky5h4uxddz>
References: <20250508184930.183040-1-jsavitz@redhat.com>
 <20250508184930.183040-3-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oljps4cr2ouzgs4l"
Content-Disposition: inline
In-Reply-To: <20250508184930.183040-3-jsavitz@redhat.com>


--oljps4cr2ouzgs4l
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] include/cgroup: separate {get,put}_cgroup_ns
 no-op case
MIME-Version: 1.0

On Thu, May 08, 2025 at 02:49:30PM -0400, Joel Savitz <jsavitz@redhat.com> =
wrote:
> When CONFIG_CGROUPS is not selected, {get,put}_cgroup_ns become no-ops
> and therefore it is not necessary to compile in the code for changing
> the reference count.
>=20
> When CONFIG_CGROUP is selected, there is no valid case where
> either of {get,put}_cgroup_ns() will be called with a NULL argument.
>=20
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  include/linux/cgroup.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--oljps4cr2ouzgs4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaB4ErQAKCRAt3Wney77B
SQsrAP0VTZn7auE6/HrbxVoNF7Vv8NJvFJ1/IdLWOsVS78MmbgEA0yEfBtfcjj5h
rZ2Rv7wf/M+OODWfIF2BQm05c/pI7A4=
=LhpG
-----END PGP SIGNATURE-----

--oljps4cr2ouzgs4l--

