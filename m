Return-Path: <cgroups+bounces-7131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC107A67108
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DFC3AC7AE
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4702E169AE6;
	Tue, 18 Mar 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UT0Qy1+7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60E206F18
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293133; cv=none; b=rdiOnN7xU2wLNFb0bzVsw2HA9yj7O4K9aXfKvkCLr68tlkM135m0l6SnoE9K6CletWbIe0hpI7Ppoxzxuc2mM+9T+uTF29KKo20OblhSCfVT2fvcxx5WU7aqDjoVHZdsW4u/pnLrG0KqokfclhOfkkZZJaZX0ikbJLLVy8Aeb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293133; c=relaxed/simple;
	bh=4ssJsJxIWYpA3fFkasszhPUhMVSzH9qY3MwdoCqp/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcOx0B2YUOW/N6oKpyIGGrdEAaa/aHuSTgijPA6y8QvnWstZ9zIOsnxNNSCq9fWcJbJS6f/gx89tSPHpanTtTzC4tG6frEaXCRPmAkwwDLntmkc2LJ9UiYDgpzJ7k7k5Bap+VzLeRFBaD47ccB9rnBDZgpQn/Joafj1vMOJYfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UT0Qy1+7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso22001825e9.0
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742293129; x=1742897929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7xGOMAuQUF7MWyNDY6Z3/tomm5PbBSvhnd4ckgMx6g=;
        b=UT0Qy1+7UWpCaH/QVVmkp+9HAWJag4LEgdwwnzby6gS2CyaMOCRwkQTy4YbwaubF8H
         2abQZDC/Ua/YiM/V8mKxkwkM4eP+KRBWedKbPZdXI281fKp1umeNnIDRNyJY2RtRU4lb
         vHYt4VAbdXYpo0evg1PoaywwasJG+Gn7MR9fz7Nyqy5jRFpOSX9Y3EimxKJ4P+sY6JaV
         RM8NndL2vGcyk7lQ8BS6cNmA/RIavjKZgcBdkAIiGlT54XdiyK6ymcHw02egnVc6Xems
         zCDTnUVB32TWOvtWk25Z8GQ2AcRy/ouB+s/p1jzX+Gvy/wEn/r32BCwiYq2eyaJWsqY9
         06EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293129; x=1742897929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7xGOMAuQUF7MWyNDY6Z3/tomm5PbBSvhnd4ckgMx6g=;
        b=lYyDv4Q7EZ9i6SsavFLu8My4xXVjqfF1fUSGZlB9j4yIjvE43Kg5s+iBldmjvvgE64
         kDdQ8k87eL3Mrfz5AwZJkMOWCnDHkY17nAw8dtp7xDYuxlcH9Arqnmw/5XZ2Ub+Rzrb+
         1wr6zCxh7XeG6wb1AEI8XdgDUA8flSSMfZlr065vpZYHeykjU5U8WtAZsF/Y5zhSkPjX
         ydv0gKEThek+svFI/8UchpTkYcsvt4YPpOcKFPKIw/9zHn8H46xoKV9X0Y7dtE9LJb2s
         w8/wPBvs+bppSNcBsrx8LUrVTHzTnU70Pon1QLC8E9PPpgkNILRFIO/RFULgxYIKFRLl
         MKWg==
X-Forwarded-Encrypted: i=1; AJvYcCWnLVkttPccmkvxEzK06YXF/fZJ7EBU7cTUfVRtt7M3i/u/mpC8AZccfJ7GAI0Vkp87el8+foYX@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDt4g6dCJJdMBP2CDGhPgDzFBlmu0PNJ1tEN9JoohTf758rZD
	65wCdsQ2sSgLumk1BwXx8MRn7D5h4ynL6Ut3IYeF1rpU5GExoNmq/u7gMEOs25g=
X-Gm-Gg: ASbGncs8uh5Jx854jjnRk21EnWv1/OJRgA4lcbpFOG7B0szotLE3q3Nij/GNMbs2ckG
	NxjadBNBFm4vvW8WAOQqT3L0QAOtZXLbZrCNQLUj/cXh9srR/7m9lRTtlLilzVCnUKqIcWQUoIN
	LFzb33gcryVE2C67w2xszDZYMt1PSj6XKEfu74PD4uGzip0s5lhHlL2wT34xiKA4ENJ4Mxdwz3r
	DgHTroYXvL0Sza/u5j/kEYGrhza/2J+AX/E8APw+wxaHj8DJ1OsNjHpNDs9jnwZ0VjGUMYKCpkj
	TgxBgQ04bCyoFZUu62ovYHsVyK5xk2Eb9raAdN1OpnXjdTA=
X-Google-Smtp-Source: AGHT+IFrT2crDX0AazaJrXxMyeiUJbVXB4waHwmUEuTI2Pk2priOkOM8LHglNdNkvzmeJCEOd9dpDg==
X-Received: by 2002:a05:600c:4ec6:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43d3b987ec2mr14873995e9.12.1742293129530;
        Tue, 18 Mar 2025 03:18:49 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda208sm132395975e9.6.2025.03.18.03.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:18:49 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:18:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
Message-ID: <2bzz6n6ugfuvw7kpnewqhdzmv3yxghe5o4y4jxrwtrw65f6jsd@zgnh7qkpw33y>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-3-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceucqiazdoxttvyr"
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-3-jiahao.kernel@gmail.com>


--ceucqiazdoxttvyr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
MIME-Version: 1.0

On Tue, Mar 18, 2025 at 03:58:33PM +0800, Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> From: Hao Jia <jiahao1@lixiang.com>
>=20
> The commit 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin
> counter") introduced the pswpin and pswpout items in the memory.stat
> of cgroup v2. Therefore, update them accordingly in the cgroup-v2
> documentation.

Fixes: 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin counter")=
=20

> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks,
Michal

--ceucqiazdoxttvyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9lIhQAKCRAt3Wney77B
SQcmAPj5mu7c5i0F7YE9fLx+JKryDsiUXIhpYvodLh4TGWAxAQCdwaT9YNeayOac
3hnyVehCiIPruqy8kwaAR7cXejMfAw==
=IbXD
-----END PGP SIGNATURE-----

--ceucqiazdoxttvyr--

