Return-Path: <cgroups+bounces-10090-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A2B57B49
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 14:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F11F200580
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41491E49F;
	Mon, 15 Sep 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2sISqCN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628D5305945
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940038; cv=none; b=MyfVF1WAqmNpGREtrG8Baeg7ZdJ/iWes5cC3FsYbaPkfydHQQyiL8WiHNKnPC5wrULvqQrg/uz6WwOkgEYId4DSmZ2pqRMdtkzwvlhys8CVDpCTKgVHFNcNWo3fN6LnvOmQEeCr7pC1dedVxXu2M+667Y+ysM9mDKL5t67F28ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940038; c=relaxed/simple;
	bh=dNJnJsH0bwlUv9iv5mm0gr5b4wshCly50clBeI+rCXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpZvURD1e7+Bh+Ibk6IImb+B8ViCyKOMLetJAbIRuLPzvxey/TYzIbJ7b182fW7QALHFx0MdY9dYsa5z8wrtwAedHeU26y4YQZmCDSuXtepJUzBzpJWd8IMGWeEvdxuKtbp/7Emh5kJ9IAItwUnTNBXkYfXwBDMESe1l06uGxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2sISqCN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25d44908648so36535815ad.0
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757940036; x=1758544836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNJnJsH0bwlUv9iv5mm0gr5b4wshCly50clBeI+rCXY=;
        b=I2sISqCN0QdjPoe/B/DieEqe0D0/p/1imHlfUY3RxRhmq0g9CNuPr4BUWSUUI//aoj
         mrFnXxolSZ3AKVPZxC8JvIocAep6zTzEA4Pj6FdLq4y6FQl4e6uJkIdKU/g6N26pQ4p+
         v747gQot8tviWtnowB+/EfutA6Mp/9cOFvnWGO1POOjoZFnjeXqbd+r65aT0klJG3Mn2
         JSsmHFqtbZT0Y3kKh/F9OASFUi7cZUrQFeDHpHCxol32NxwJZK1xOhG0KADaZD3NxkW5
         PqWEE8mAf/suuN+l+opg7qBnuLiyRx6xsIhCQ7/KPWr/OgKGEJbX1ZwY708qKY4eAB1O
         NfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757940036; x=1758544836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNJnJsH0bwlUv9iv5mm0gr5b4wshCly50clBeI+rCXY=;
        b=rKScQQ6I3Xwzhd+b3uc2Fj9VoJEp3rB0A2+CpWFpwdq6zuGQZUl2YlJeaLxNtvuOYh
         xlcatfcYxYX1ie+d2iZSDPGt0pI+RkidzT4KYFiHQK0NFXsT0noTD4wwwZKNP5PKr1aD
         Lny2UNVzBabTPIYoX7Sh1yLkQ8iQvnhGiu+AJbwcC6hWLvvqWepiZvARBC1Y2fI+9f24
         c3g+3JSJznNYTzv+l7oUIbFORds6GaHLstIKsM7NFdZGFyg8D4bpckTYKYNPPhq6R84b
         k7i2fACUD/Q2d7/FFoUtpNwvrJY9x1bbrrd4/8weKKfMTuZUR5/V6dQBngDgercAnbkb
         t3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWuoVJ7GDNqJK1GLFcDKsPelo80wa4JQZ+bNzHdKID2p2GNPlkkMdu9ZHXPr/MK4QosjW5dqx4q@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAaqeN+zDLGqfMNWgDUOBHonJoOMxtWJONKJtKRcUCJlViAEA
	W5NBFa2xtIe+7mSQMP//JAC0Asckms9FcQwkqhOuanaU8zObp3DtHDIz
X-Gm-Gg: ASbGnctjA/IIHnKBDOHfS7Uzr+pfKKKVvt39dEkme0/tHo0LfDQJLTE0NLNAGnuKMwQ
	ap6wOvAnOqtYyqr8+Egq1ClaxxufDnYN4rhw6t3OtlN5gomHLl7tC95keqEJdbIQfH/nRBGAkJA
	uT+t0CiiC1HNOdivtYaasfDHKPNmEjntLbqSCJDEtEsNkFiXFRBXxaa6GiZgp+WWx9k8NTHFFqr
	n77Qy3yibPVUlCS1ApCBTCvnSolfzi0pNa9CPMRRsCjDgLj1aBt/oq80Twl8JMcyheOaC6PLzPB
	/XDZosZkb3Aej30iVyVQFcjek9Utd/2Pa55YIQWk6SWvgS+tzPAXmLxeSXCor4+bn3rAj927xeu
	LNmBf6xvXXJPNyWqrPjFJOYzY6NqRCtmswXaY
X-Google-Smtp-Source: AGHT+IHhTD9B3Sdd7GngwxsOkjj4gaAYEGinNPhIKE81JuyUWnx5sHsOsSR6QPKASvI6Pv3nndfZjQ==
X-Received: by 2002:a17:902:ef46:b0:246:bce2:e837 with SMTP id d9443c01a7336-25d271485a2mr163639975ad.49.1757940036320;
        Mon, 15 Sep 2025 05:40:36 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2635c79cd21sm55033945ad.49.2025.09.15.05.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:40:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CB28B420A6BD; Mon, 15 Sep 2025 19:40:29 +0700 (WIB)
Date: Mon, 15 Sep 2025 19:40:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
Message-ID: <aMgJPWETGVt_AE9i@archie.me>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-3-bagasdotme@gmail.com>
 <duppgeomaflt6fbymdk5443glmw7d3bgli2yu7gx6awb7q2dhn@syjq5mmia6pb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPEdF1//wg19KKDS"
Content-Disposition: inline
In-Reply-To: <duppgeomaflt6fbymdk5443glmw7d3bgli2yu7gx6awb7q2dhn@syjq5mmia6pb>


--aPEdF1//wg19KKDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 02:20:59PM +0200, Michal Koutn=C3=BD wrote:
> On Mon, Sep 15, 2025 at 03:19:25PM +0700, Bagas Sanjaya <bagasdotme@gmail=
=2Ecom> wrote:
> > Add section numbers, following the numbering scheme in the manual
> > toctree. Note that sectnum:: directive cannot be used as it also
> > numbers the docs title.
>=20
> Erm, so in addition to keeping manual ToC in sync, we'd also need to
> maintain the section numbers manually?

Right.

>=20
> What about dropping the numbers from manual ToC and sections? (If manual
> ToC is to be preserved.)

Nope. To be fair, we also want section numbers for htmldocs readers, though.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--aPEdF1//wg19KKDS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMgJNwAKCRD2uYlJVVFO
owUWAQDOV37Jt9sGtdMfo9OFbV+SKpl+FM7rQVpTGqsGX5TCAgD/YCIODJf7QdFr
0241ELSDVsy6ZHhshkKBKhCObdEmkgw=
=Y3IF
-----END PGP SIGNATURE-----

--aPEdF1//wg19KKDS--

