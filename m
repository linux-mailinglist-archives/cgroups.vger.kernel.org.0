Return-Path: <cgroups+bounces-8444-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DEACF37E
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691FD1892801
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD151DE3DF;
	Thu,  5 Jun 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PRa3K8GJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713417A317
	for <cgroups@vger.kernel.org>; Thu,  5 Jun 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138978; cv=none; b=Q56pPqWGbhz8xJoob4hJ1xZFIiGWtdkazPMBlznO81wFEVrWh42HRNyUG9LrQJll0cPsp0lKCppnI32iz9+Xy/Xw48TGtM5OPNLREVt9ZklKafSO/vleIU4eEjtBLsOdrv1/JvmrysPfB3YKzCk8td81zc1/C8Gf6h8jOMni9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138978; c=relaxed/simple;
	bh=jpQgaH8wFXbv+35WbhkmYOzDhiWEYy7uoJQPiwInUVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzHOR2r3L2fPkNDfSGZOoq5AE2e/a8kvuoaQJHElBmYw6Z3X6T+9EDotd8wE2/bblGAVrGFuXikWMkx8z2la2pzbvcXSutyz8linFSe4O34A6fkVjeqi3tIzHA7TfE6n7OiXdVJJUDkiySKzhZ2YJ4fe8nnYluBsPgeT5l7i/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PRa3K8GJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso11511065e9.0
        for <cgroups@vger.kernel.org>; Thu, 05 Jun 2025 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749138974; x=1749743774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpQgaH8wFXbv+35WbhkmYOzDhiWEYy7uoJQPiwInUVg=;
        b=PRa3K8GJoGp7SzEjphTT1oPoR2hWVfbN0KHco4/qoHOo1fek0A02pjl7siN8F3/0rs
         7tFCazIC7KAV/tSY7ElWCWsQdx7NOdkmY4P7KiwjTdaNqiRaZyNe7oslgHdgPiNmI1RQ
         tnW/zIiveiXM16KacIDofKdAnMGhZw4hxBzwm0sq5lNhB+RxaT8QErYnIaS2SVK9xgDw
         QRqdqnad9KRQoBF7IWeZOw0ng44pqEVlP7P6UIaB7iLG3M/NiBaRExpUmSLfSgFYDcL0
         N2yiLRNbbpgRzel9ClRzhUST0aFdqoesqsT5DynWyuia6JG8r97/RW9GDh64zNnCeg/E
         WtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749138974; x=1749743774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpQgaH8wFXbv+35WbhkmYOzDhiWEYy7uoJQPiwInUVg=;
        b=Qz5/qLH6II2PAUlmlZMeC1tXToXXZaCPN6c/21SwDkTMh0FeChj2EzfpL6OueO/3YO
         q7Dw0RfOHoZfTPHpSuidSTicpqzfvim+Msdu9CUQwxVVa3gOJqPV1i9ZEyit1eLBLe33
         vuTLG7QGWMommob+H7OZtcVy/b/y8HeXEeCMqxPmux1f4lQsuWkuI+5WQLSb4o7LJE6/
         uKX4QO6r6f5QxOjc4ZbyI4L7DScQYVlfQixphNTmz1UlLfVha8fLVd0+s1QWfOEJFfq1
         B8xLKCt2k+u1eo0Ubo6sSVwXDWZnxW+PvMIJZGP4wk2lbeS9bW32Hf4eSmTzWRdwkkkZ
         8w3A==
X-Forwarded-Encrypted: i=1; AJvYcCU3BZd5EO6m5nspcztSjNUCmYi5D4MwVAQBhWQCw75pmgHnqQODAs3oBNCnK5ISdP2UlSc1SFIx@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoSGaf0liXDwhj9yukShMmmwyUP9OhhQj/JW5PZ4SQYnImSPj
	ZM7iOb61WmzpphiEh7Oj3Pw4tjZ+SKABZll0qHnzG62vKI+e3Hx/aJmX6CS8rF2oIfI=
X-Gm-Gg: ASbGnctDT3MFs6xu0J23UK8LE16q/PrRKJ5laYQwysCwJj/o4FxZJyOOo0vboXX2UZE
	x9I6kvxrstwxsqrxgOcug2kMBFLB56IzwSP1XA7zPBMWx1Ka2X2a8TZ3gC5HsHRshDSR3EQdRUL
	jXi+cd7xDcEefR4xc6pI/hffk92YihL66wHlnsqYOCMaqBjF8U2u5SUMnO5uoqDXjPIzZOezZID
	ga8GSJYTfQB/JO3Qt0mJ+mbezAUazSkILCwucgvPdChvAVseVJ9l1snvA6f8HaH9QucaZuYWkHU
	laeCnv60H8gKikwS1pA1HWmn+kqaS2Np3EGTfNbK3IgPws2o3S+ELA==
X-Google-Smtp-Source: AGHT+IFFmBAhnVX8IUhPRnVLWnisgdixtDYIcvxhtyfsZEwnyPPr5+yPFKOrDQJjj8yw9qHuR4RZvw==
X-Received: by 2002:a05:600c:34c2:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-451f0b0c75emr82051185e9.17.1749138973721;
        Thu, 05 Jun 2025 08:56:13 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f9919648sm28627985e9.31.2025.06.05.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:56:13 -0700 (PDT)
Date: Thu, 5 Jun 2025 17:56:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: Wei Gao <wegao@suse.com>, ltp@lists.linux.it, 
	Li Wang <liwang@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
Message-ID: <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grtnxv332clrob65"
Content-Disposition: inline
In-Reply-To: <20250605094019.GA1206250@pevik>


--grtnxv332clrob65
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
MIME-Version: 1.0

On Thu, Jun 05, 2025 at 11:40:19AM +0200, Petr Vorel <pvorel@suse.cz> wrote:
> @Michal @Li WDYT?

RT_GROUP scheduling is v1 feature as of now.

Testing cgroup v2 makes only sense with=20
CONFIG_RT_GROUP_SCHED=3Dy and CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED=3Dy
(this combination is equivalent to CONFIG_RT_GROUP_SCHED=3Dn on v2).

HTH,
Michal

--grtnxv332clrob65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaEG+GQAKCRAt3Wney77B
SXlrAQDg5ZgbQDLnV+ge4dnVWhKZwV9mQ8OjZSjTj2AoLYJo7QEAhzFp/gYI/GWS
Djje2xIK9NJgX+LeaGnfReiFK7sv4wM=
=m7Nf
-----END PGP SIGNATURE-----

--grtnxv332clrob65--

