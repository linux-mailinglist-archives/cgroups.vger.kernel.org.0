Return-Path: <cgroups+bounces-6564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BFA3836E
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED411893E84
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809B21B8FE;
	Mon, 17 Feb 2025 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GKyRUeGt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BFB2F5B
	for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796706; cv=none; b=LmwQKS4EH0UT8kVELAPgituRPkpJraDKxwBXEJYiz0FrIcQyuBfuEW3IrH5k7X+jUK+tIDBdC5vs8ujXn8Cxs7NE54WDHjse8r3eYfXRayPpvSJqBNO7iHv0RP8dholZY9j3xB9TXJeTc97cQiVdH+Zd8whvXc17TgVA903Xi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796706; c=relaxed/simple;
	bh=jiX0y0MTU/alODmjaoSPV0vx0SMSc3fr+qbU/rvNdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4fXbARJdzT2z53+iLYHQUMTyS7YBDhP0oGZiF7P0mehopsLAs4+yOFqVp+V1rKIFYvUm2Mc6A9yDPRDMPy5fIgUT7k6gI2Zy7rgJ4MWxs/raPiUlFbwD8BmWdXyKOmQcJ+kvWAc80rzOpK7oda6KgLnLfmqbeGbzAZ3bblmofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GKyRUeGt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso5819495a12.3
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739796701; x=1740401501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nj1L+8nX/9kMXQDQ3FNBhb9ptIaN0gRET18ncQ6m0oY=;
        b=GKyRUeGtEXXKVk4uBLiaODmpGADXH1aYplLiDhSUGZFqM9KA7/B9/rnnz2tjqokxHB
         fmXthWHSMuyzU18w04tdjd0X+ig+AfJX37I6/20fYMs9DjIWqvkntzSls9uL7F1nztKi
         B1P2sv5YTJ2Tru1FvijHlUzuwpa25J3kauiKbin8h+1X9QkMs3aZWk7zbkC6Nt+9+EU6
         bCb/ZC/MZrrWeEs6YDU5OGEoYqzlgRmUkRgRJm9+/MybVdozeiwJNDFc9I/dRvzOn52Y
         h7AIJpa4/CwxIATAebJBOCIELjqH6Tr0LE3iclpMTEcuHq6ZTrKI16T0FYj+oLal/7yR
         8u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796701; x=1740401501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj1L+8nX/9kMXQDQ3FNBhb9ptIaN0gRET18ncQ6m0oY=;
        b=q1Wxk/AQiH1iDLKX4aun1/1IhHy6BCfndEVBiCJ09BMKdK/X0jxK2beMt+Nso14Nw1
         2sJ28QU2t/Oq4B2JFWZbvLxqtH+x4hEYZ18y4S89jJnAZyA4ygZ8hzR757ThoUdv64tW
         YPa5ZIA0Xi2SGnnTZk6YQRcKK5w/C7axD8C9yhXQayKHxS01EZbULuextRtFoyQIT+oI
         CuUGrBYgwH/JXmPLZG8eMKbZp9kBnIQp7zWbo+26j19U0lVYAueElYeMRkN3P3+iiNd4
         uyG3L6xoV+bFq9lSLVfJeOdYVe0mPFHzy4SswfWKJuDFvWQgmZ9t2Q3KTiK2JyMGCKwv
         K1IA==
X-Gm-Message-State: AOJu0YzlWT7y5EuUFLb8T3/grZYFu7gfS0LvhMxZP6qdM1oZX+TLeuMj
	QRtDjJSGtfoqDySh6HtslVC8kX/03XARVdqlExm8i0HUu6FZcyAUlH27AvaT2kc=
X-Gm-Gg: ASbGncsvm0G/XJ9zINt0OWJ7AzdR0f78eSqnmUH02TfoNHlad377x41ha7pLE8uUh5D
	2nPGKcLg24iKEbTqEjV394j4buP7wGLLmHs4BWhM1aTXHydNQf9svzQHDBA1W5GdY1rRRGdtcPd
	pHWm44Uk/Sv9+U/EW1+N+BAkPDIEx5NmdA4XcgbeYI3b+NTRT7a29T3Q+GrbQKQs5H5VkURS6Ny
	BT5LyqLheQ1YSmDa5F+JRyHGhSCrzc0Rph1zT4c0wToj6v4oSh94ktONKsAJtkDFp5uEGIXxRZ2
	BPUJj22a52vJ6hB4SQ==
X-Google-Smtp-Source: AGHT+IEBAv8od2qJ58LSnXUp5OhSn10k7UUZV8kIh6qmxvoneMQrnZi+5A69qII0l0WJNpneUQ7E0w==
X-Received: by 2002:a17:906:c154:b0:aaf:74dc:5dbc with SMTP id a640c23a62f3a-abb70bbe128mr1078545566b.29.1739796701300;
        Mon, 17 Feb 2025 04:51:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba9cf8a262sm593031566b.22.2025.02.17.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:51:40 -0800 (PST)
Date: Mon, 17 Feb 2025 13:51:39 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jin Guojie <guojie.jin@gmail.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
Message-ID: <tswmetugmdpeu663sdyx2pb6aawhiajb64g4gmjjup2riz23ha@r6vsgo5tdv2w>
References: <20250217071500.1947773-1-guojie.jin@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuy5tgvimnzk3spp"
Content-Disposition: inline
In-Reply-To: <20250217071500.1947773-1-guojie.jin@gmail.com>


--zuy5tgvimnzk3spp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 07:15:00AM +0000, Jin Guojie <guojie.jin@gmail.com>=
 wrote:
> In the current kernel, the variable cpuset_memory_pressure_enabled is
> not actually used=E3=80=82

This statement is weird, it's generally not true and not false without
further context.

> This patch modifies fmeter_getrate() to determine whether to return 0
> based on cpuset_memory_pressure_enabled.
>=20
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>

I'm not sure I'd still suggest this :-) but
Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>

> Suggested-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset-v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


--zuy5tgvimnzk3spp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7Mw2QAKCRAt3Wney77B
SdBYAP42ZtNzkfLFN+EdzJxWj0fhqLNVOhJk8lW9kQMc2GVciQEAvMW0vKe9ljBB
t5oDLrSLU3smNd2JN+gSpdECc51yPQU=
=fO+q
-----END PGP SIGNATURE-----

--zuy5tgvimnzk3spp--

