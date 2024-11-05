Return-Path: <cgroups+bounces-5444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B09BCD9B
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730ED1C2130F
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2024 13:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758061D63CC;
	Tue,  5 Nov 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rh0AQUT4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0A1D5AA9
	for <cgroups@vger.kernel.org>; Tue,  5 Nov 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812499; cv=none; b=fM5ZpBK2AyOxN7TCFVCq2lZ/hMjLumE79l1jwYgjtUehTwpGTQfFf/e1o2F1EOMahES3+LppADJSODHdnE+7Mj1NbmT7sfB7hjsjGLN3WWV8rL8ouCK2gMlW6MJ4iTrvI54uqBeOEw1IxgFQ8vKGOsMcb2vjOCK0ZC+DjPswyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812499; c=relaxed/simple;
	bh=nIfRuCv8NOVzvOxVlZqFNtL7vNI/sQ8/tUTt7WPlACo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caCyAs0SfDPC9+PAZ4RnoXqCW7zZEkV2VNWzkcKGuY8RWi8AmPCZmzT2KCBdt8qji7BRAJmdl0tHsRo73lzNikhE3zVV9MvfciYemdyT7XzB5D2eT7ky5QF5oIwW6XtSjfhfNVABuP/Y6MXjulsnuJ7/mtRfSBbdRyrhRekd3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rh0AQUT4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cebcf96fabso4973667a12.3
        for <cgroups@vger.kernel.org>; Tue, 05 Nov 2024 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730812495; x=1731417295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nIfRuCv8NOVzvOxVlZqFNtL7vNI/sQ8/tUTt7WPlACo=;
        b=Rh0AQUT40T3yxAOvwll+ZDF8g7rJXzH9G3WxDL3gXNCF5T130Ms9qF/AmE/fqUXGeh
         jCw9Cgb/oDmMP0M2EnwJ9ITxN4F6qXMjh0dJvaewCsbsCvV1IXoT8yKQ5tUy6kyuU4Cz
         uRu07x1DUUvtVSnNBHxLPMcHCXSxPskktQi2y0K0zzJQWlMRPvAZVVXZZIehCST4PSJn
         4VlHeuXUgpUK4zx/cl/pANyCovnYdMOkaWP/Rs55U4R1I9dO/oL8R5mKqT9t6dMdlAbt
         7zq4KTxXKNZJwtsYZcG6H9B/i8nWaBN4wn3gcWYybbE/c0UmNxv1qf/W/ewk9T0Oby2C
         7g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730812495; x=1731417295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIfRuCv8NOVzvOxVlZqFNtL7vNI/sQ8/tUTt7WPlACo=;
        b=JLO2h2P6RClSLart2Xs511EUjpIj3lVT+NK6u7QojJnpz0dpJZZVUQkjn2lKaQEfyg
         U9t9oWp63x/1m+z97lWQgbgA4uVm6AY8oYhv8lUEmjtYQyf6VrBzhJS6N1SmEvb4iaRf
         1lpbQLb/7SIZx91lB6RuEbKg9s8U2D32xUhYl9b7GnniY9KVyySMNPTL2rbexf5wHPy4
         spKGkPb2UyuwC++vS3ap5X5BZDQx3p1HJKxI8v4fJQuctBpxC8xjHA6hjaGMaCugVHBv
         Hw++u1X8vqfYUbnQzmGAcDAOGutIbxAiJqt24beCIzxwxPToMMPFCSve+pVCBkgknNU4
         Xf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3oCIPFlVQgIbo1GwNt/WGB/qQ3j3ncAyibJ6KtrmJnHNKEfMnHGW3e9nI3qn+Pa+CjX9aM1w1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MV9OkYn5Jq5/LASzehYllkwaZCHoHIxo8kWLMQDVrRAJu0+Y
	S5l+dp5bjCpDcCEvnAwv3nKHmhdXPazRvczXnLsqxmf0LicdwJKxtvpq3HgHFsE=
X-Google-Smtp-Source: AGHT+IHVOo+x/THWNs3/mHtaNNJeAx+rDnTMptfCEAVraFtB0d4G6Dagju4LnspKhatdDFwS1cWHxg==
X-Received: by 2002:a17:907:2d8e:b0:a9a:3705:9ad9 with SMTP id a640c23a62f3a-a9e50b95730mr1721715366b.50.1730812494709;
        Tue, 05 Nov 2024 05:14:54 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17ceb1dsm134961666b.101.2024.11.05.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:14:54 -0800 (PST)
Date: Tue, 5 Nov 2024 14:14:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Zefan Li <lizf.kern@gmail.com>, 
	Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v2] MAINTAINERS: remove Zefan Li
Message-ID: <lplrh5jp3iuoy5esckhc4pbed2fhi4nriqxlswknlxiyvcrbod@pxvho7abga5b>
References: <20241105030252.82419-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqyjwghnwb2xyzmv"
Content-Disposition: inline
In-Reply-To: <20241105030252.82419-1-songmuchun@bytedance.com>


--pqyjwghnwb2xyzmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 11:02:52AM GMT, Muchun Song <songmuchun@bytedance.c=
om> wrote:
> From: Zefan Li <lizf.kern@gmail.com>
>=20
> Not active for a long time, so remove myself from MAINTAINERS.
>=20
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Signed-off-by: Zefan Li <lizf.kern@gmail.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I trust this comes from lizf.kern@gmail.com so

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

(And thanks for the past work too.)

Michal

--pqyjwghnwb2xyzmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZyoaSgAKCRAt3Wney77B
SZjXAQDoJlx7lBPFcdB9S4uIo37WQs7bEjiKDaP89P4fbiw78AEA6AxPnD8IJMAB
R8DLE56cwcmwIU6FuGTQp/d9GqIAqQM=
=LWDx
-----END PGP SIGNATURE-----

--pqyjwghnwb2xyzmv--

