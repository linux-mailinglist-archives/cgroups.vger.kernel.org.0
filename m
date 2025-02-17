Return-Path: <cgroups+bounces-6565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417C8A38382
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 13:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABAB172EE5
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6521221B199;
	Mon, 17 Feb 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1GvU5L+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221E186E2D
	for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796848; cv=none; b=VR79Dm5v0AwV1sjMPVO17u7BDs4cAPn6Te5RKlMu68DWNKjk3Tb92EtcCtvezhSNQHZ9wsWn2wInWlJPik9/vpXuMt+A2s+u7o7bXSejzxFFv0KsTpDG1/4wh6pVCnI4LAonA6uyEtGC38plnGomCyWg2ljOA3vS887R2ekRCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796848; c=relaxed/simple;
	bh=Egu4KagOY4eBm/WyUTX/bDT18tGt/RCB2UHpWbfOxIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg5KTDdhpTZE6ml8BcarrQuo7cKhfo120HprWupIqCVodiCWB7CeM9ZveWNg6DvgiUf/fIRYcdmNLvq+XBs+4Y4q3inKWKjExvU8IuB1IjHRc5DdAS8f7WkewNPD7A2GfyFVMy0SThXRlVd6j1s3O6xeOIbd8V8HwmbY4kKNftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1GvU5L+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb8e405640so183557866b.0
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 04:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739796845; x=1740401645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Egu4KagOY4eBm/WyUTX/bDT18tGt/RCB2UHpWbfOxIg=;
        b=E1GvU5L+OF7posO2qp/zAmQ3H9cmVD9DfE/9Nhm3EQZnwDw4qGqEtDAPzIajOEZAVI
         Ppv1/J1CfmGtC8KHGq94wK8fgyET+cCAtBq6pWz1+B4eJQUV4TrIORCsZp83tiyfIixo
         7AfnHeON+lNeO9tqXaSr7Bm553DjGzDMu0Mbt+TFXxawrRwxv6aVXo4QfjBxkwu1BQhP
         sc6WPvtVXJRh2P0qZvMtU98t5JfBVH+FXIECCuSnaJ6tFBUEgQcPZcvQxSlc34qO6AXZ
         /kQpXUkFSKMk3AoNL0k14uY+hckKYmpANv32PjnFBFYM/Qr6V0gYhqitXjGTUf2moOA7
         ghnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796845; x=1740401645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Egu4KagOY4eBm/WyUTX/bDT18tGt/RCB2UHpWbfOxIg=;
        b=IMHugxnm96GxXUyeYOA6jYIYT+KoAANDIJFG9pPat0pt86GgyQgR85s4qwe4EoTodZ
         zVPrwZa1xzdZOekIgEkddEY3kxfHscSaHK3LjCOkLZFrFV0zZ4nYaLXTPSKT981HNM/W
         uX9So67E898CQau4mAGY0+2rhONaAD+bZ3j57dxihUflb1lXSg4HbeFXbjrqmEm7tfyY
         JoupNhMu7wY7uOOxpyyFIlr5785d7GEltRmPjBVBTPK07vURSWe1dzHUIlx9cSW2fvL1
         xtB6LbV1fxlBMr+Avu4C6QkWMWuxlQwv8EYqGWFFEGLAkK2bRCVosqtElDIGVHJFD00f
         rJRw==
X-Forwarded-Encrypted: i=1; AJvYcCX99vwQ81gCXr4LYBwhxqiLk5tXtJAS6y7NJz7IX2f1+0LXJOLogIndGxZ+RBURkNF+ez1JFRQC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xjw4QmwXVLO346TVIKNR7La1uFPWNfl23w5voaCMPK7Qdnvs
	0LHxH7YUib+eQI9sC3gV410zCcEyLeElbpbjwTYRjzIXtcHmfgmkPsW6pvuHrGe0j0RLRSxxIwl
	sFuY=
X-Gm-Gg: ASbGnctP3zcEOZB9OFmOF5n95r2Q4aA9jCNsbWnjjRbO4VVQu9SrK1A+R4vDVaqhZ7f
	KK4Gph/piw6kwDaCr0dA6wJorK8oDJOJSzhEocq+/fCQ5KmRjNr7CRxY/KSv3xEJpk3AxGGft6z
	JheGtThBoUp3uoFiEUm4py/YonduSZoZV4qR2mca7EgxSWVehe7JCv4GBkyWHkjstGOc5WEwtqq
	FjZz8vc5p3bxQcLJ7m4yFd0Zioty11QZoB/k9VYcktKGa2noXK652BONE1dRKxR0FIJ2G4wIxMB
	wKWlww4LhReKeki7IA==
X-Google-Smtp-Source: AGHT+IFYZvC9AyQ3Qo3Ass97b7QBggJJgTgMzB8oPnoQxqXsky8Y8ZOyzFqTsX9Fo7+f9pXUVVBcjA==
X-Received: by 2002:a17:906:f5a2:b0:aae:bd4c:22c0 with SMTP id a640c23a62f3a-abb70a959e4mr845116566b.19.1739796844653;
        Mon, 17 Feb 2025 04:54:04 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322dbsm887225766b.10.2025.02.17.04.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:54:04 -0800 (PST)
Date: Mon, 17 Feb 2025 13:54:02 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jin Guojie <guojie.jin@gmail.com>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
Message-ID: <2e662ogdk63dxj4fqzv6cptsef6snwkjzdfrv6knsl2gmjial4@qmkkzrwbdpk7>
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
 <pl23stfp4qgojauntrgbfutmrstky3azcoiweddseii52vgns4@6446nbhq2zl6>
 <CA+B+MYQuz9ue1ZogpEGb8J+F8UA5P0dD-R1cRUp-4EgDBnPS+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qaouh2rpksdqyz3f"
Content-Disposition: inline
In-Reply-To: <CA+B+MYQuz9ue1ZogpEGb8J+F8UA5P0dD-R1cRUp-4EgDBnPS+Q@mail.gmail.com>


--qaouh2rpksdqyz3f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
MIME-Version: 1.0

On Fri, Feb 14, 2025 at 06:04:18PM +0800, Jin Guojie <guojie.jin@gmail.com> wrote:
> In fact, this "case cpuset_memory_pressure" has been in LTP for a long time,
> and the same error will occur when running in multiple kernel versions.

So it's an old failure that no one has looked at for a long time, i.e.
c). Thanks for the clarifier. (It might be benefitial to look at v2
nowadays ;-)

Michal

--qaouh2rpksdqyz3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7MxaAAKCRAt3Wney77B
SUlpAP9bjeJ6R1k7/Pmiwp0mqVfO9um0OFcFMps9f20Td/koTwEA8A/oqWRiRl6k
Q6NoGzllEbbBUYe7m0xz3BYdqp2xvQg=
=pa1n
-----END PGP SIGNATURE-----

--qaouh2rpksdqyz3f--

