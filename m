Return-Path: <cgroups+bounces-6043-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4496A00C64
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21C116454E
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B651FBCAD;
	Fri,  3 Jan 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LOr3pPPu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D312C499
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922884; cv=none; b=bKMB2W/pGmx0io0ceS3EP3wAJaRnORbowccYM9qy6q44TV5/wgt9oE/y2+HJlknwflGFrEO5Ba44IRgXMt7BqvAPC/r2SPRr6DIMHGfvyHPe52hbvTDnlT6QieuR4/BbM52w/ROaN9v0EWkVzMFKtZw1KOqzuCGU5ScVVRp7hYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922884; c=relaxed/simple;
	bh=UMOzZTlZJnP66G8G0MWdhI9Orw1WE0ZjSbLhMds3cGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWHBrxabH6Rh6p+icFEq6JlOfkcsJRia1degp5VeVVnO0ReJ1zHoedI4ZFLNRUn0W5+yafpukngkdUNxA+mARZgt3Zj/p/LWOCwIYxRD9FHRKsJgllLKwoH9k8XI0E5jwaZOZ7eM0TdZQgcThngL+p3Trl2VY8MIM1EGeqDX2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LOr3pPPu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38632b8ae71so8785787f8f.0
        for <cgroups@vger.kernel.org>; Fri, 03 Jan 2025 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735922880; x=1736527680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJWunwdeOUXOL/ulAucxSPzYAG2tF7e/98W4/Qfq0Uw=;
        b=LOr3pPPu/kB52xiFM697cCoR4Tg9OJH8AK+W89cTfifTB5sJ7fmCu1uj6xkTUMqG4X
         vDboJ2CJJ4M2Ti/ohu1677tBWf8ZTx3R7e0tVHB8i/VB4x1BL+jqaU69+sqlCsSTx2Vq
         L8ZdmHEQPpQnUZimpTsv2TeEks3p3LnUCiW0lAcym1Nb8lwVPNPI9rasXr7CAFAlDRli
         /7mAMIXZQkSlIWAacDdhtVgHMbJHrVGOZMnzT3g2Rxtv/jtxImxAfJSBNG4SXaIFH/ea
         kmO0Q3R00U4Ur4cdCxQV5qLXWVoFh/jOB6alPPygYc7P246QSlvFH8Ok92U3/CkSm3YC
         2BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735922880; x=1736527680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJWunwdeOUXOL/ulAucxSPzYAG2tF7e/98W4/Qfq0Uw=;
        b=FNb9iClcuGtzM4Cd8ROvxY4roCv5mqpg76j6JqI5Wwuaf+SgVZ04wLmhEnLWM129fe
         h+pUMNPI2Mw+SeMwVKEJ62Wkoaf8Ksthaix7Bj3Ou3P19b1Y0OAzjAM1//3ZcUSVSUBe
         /DiX0dkvGLNcJf9lb0PxocJZtlMXfa96FitRViTgFWCOreHEXlsAG0JlCeo2RRCtM2fX
         7vo2/voAY73FWgI1nw6Dv/9iuvDuF5wnNv6yTyaFK4co9NJLNsJf3vLyhB88GcPuJq8d
         /VZQUYAbdtvVUUS85kw7F1Co9o3BKIBWH8B9bLldb0oXW1TgmFhIBngRxaCY4+ccA8L9
         UgIw==
X-Forwarded-Encrypted: i=1; AJvYcCV9n5NJ5Ng+rbbJxe49kycRuVi7mbJD1TDFz1H0reXoGp05CcZzRNnBCpnGZQharfa/xKjh0R3t@vger.kernel.org
X-Gm-Message-State: AOJu0YzuD6xNStVmH6pEk5sOSJ6JDAfWl/2HQLdxWylnk54piMB0KihE
	1rGS5oZAfyp78A2CQfJRuI5buBRtbqHwUS9AdSkvq3VUPnOZ/71CiI6hP3RwhKE=
X-Gm-Gg: ASbGnctYgS2/75BND8FruuQx1hmJH5FxeHTL3s/52ayotfAH6koZbS0t5Tn45E8LKmA
	/uMuPJ+lrnQK8ljQtytEvr+jACFlmU+G7J3Xu5edgG66B1kihCqVX4+Cw3ezA9x9n9SG3hWuN47
	RU4pmqEK5dBCuKg7jDBYA/hI+AVRWl148ofAa73gf8Z3YcgjmHYSHPof8Z+3Kz7ejZ2rEjFlQpD
	IIGBnbP7sMBtrfwGDIPCLbQkIhmdA8VbbfPRsLoWYaKGWS7mdS1xBSuRQU=
X-Google-Smtp-Source: AGHT+IHmEJgRYECTl1efkalkxKCHIyqqbFs6KKGhjse2730J0xGUzqTU9XTRMkk25rom4EarWa2kxg==
X-Received: by 2002:a5d:588b:0:b0:385:de8d:c0f5 with SMTP id ffacd0b85a97d-38a221eabecmr48476084f8f.16.1735922879648;
        Fri, 03 Jan 2025 08:47:59 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013ecsm521759085e9.16.2025.01.03.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:47:59 -0800 (PST)
Date: Fri, 3 Jan 2025 17:47:57 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jin Guojie <guojie.jin@gmail.com>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: fmeter_getrate() returns 0 when
 cpuset.memory_pressure disabled
Message-ID: <y77ijz3fimrjvt4tbnbfsa3jm74ttobdxqvh4q4bblc474h3kb@57qsirzrwply>
References: <4f605f58-4658-40a2-afc2-e1f24d11e79e.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGguKep36ZHe6HMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ak3qjkvzzqrb5mj3"
Content-Disposition: inline
In-Reply-To: <CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGguKep36ZHe6HMQ@mail.gmail.com>


--ak3qjkvzzqrb5mj3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: fmeter_getrate() returns 0 when
 cpuset.memory_pressure disabled
MIME-Version: 1.0

On Thu, Dec 19, 2024 at 05:06:31PM +0800, Jin Guojie <guojie.jin@gmail.com>=
 wrote:
> According to admin-guide/cgroup-v1/cpusets.rst,
>=20
> "1.5 What is memory_pressure ?
>  ...
>   So only systems that enable this feature
>   (i.e. memory_pressure_enabled) will compute the metric."
>=20
> To be consistent with the documentation, when memory_pressure_enabled is =
0,
> cpuset.memory_pressure should always returns 0.

IMO a clearer fix would be to call fmeter_init() (again) when writing 1
to the memory_pressure_enabled.
At the same time, the docs interpretation is lose in what should be
shown (e.g. show last value, don't calculate updates), so it may need no
fix.

HTH,
Michal

--ak3qjkvzzqrb5mj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ3gUuwAKCRAt3Wney77B
Sb2GAQCCp6ndMlUugyu1V4o2mAy8k2+7FKr9f4Pi+VNDqG3LhAEAksfduKM5Qa+g
5nC9mkjoK+EzrO+iAKhgND/i3eje1Q0=
=NosI
-----END PGP SIGNATURE-----

--ak3qjkvzzqrb5mj3--

