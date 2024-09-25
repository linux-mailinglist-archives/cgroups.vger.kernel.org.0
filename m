Return-Path: <cgroups+bounces-4947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94DB986597
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 19:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47500B20DB1
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFD5381B;
	Wed, 25 Sep 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IOiKOnOY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA731210E9
	for <cgroups@vger.kernel.org>; Wed, 25 Sep 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285363; cv=none; b=pFoBkmaEN0fnQAjMpIE1n3LUc8cQOrELfPMxMyQp2fc9ZuhYTQOe3z203SbfOKDtQXQSRi5fqzvCB9lqL1OrMjvFyaOT/axWFOyi8v7Qnam7nIGKnBjpv8xZBQhryp1tSNPCPtVyGQqclCb6t9CLTjiuAgqJE8eTpsvgqU8bhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285363; c=relaxed/simple;
	bh=fGhCrm4ONLGYhEcqqBKSgg6l1j8xQDQ2SMMU1ssUi2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBTIGFPQbw/fn+t3GM+lKmmsC1z52WYC3UjMpX8r0iAiq+WqHuM2HS1K8nnTi3QWcRa4x/AhXc4m/ztbrn7zcxEMZV3V6BwqqcRsdYas6W70a7uNKi/kBaBwDjd5F8Q50KTNmY8RyvRn88xG+7wv/iVepwo+g8pC6fzQnpgYWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IOiKOnOY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90188ae58eso13701266b.1
        for <cgroups@vger.kernel.org>; Wed, 25 Sep 2024 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727285360; x=1727890160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPsLoFtiTWUjjmsA1rJ5MAluKVYhAgSJSenvC8qY/s8=;
        b=IOiKOnOYtClavMex8HX3/WhCGWRKhZ23IbpmtGDGucn20ldEZP7fGf6KpwB5vPLBUb
         DofpvR/xKSwtwsMvIdgHdzfDjqQ9TNEGIDH+tFl0OUJlV4d5y1GtyMXDlhRS7ZWkwsL/
         6as8uNx0qpGnecFmkQiDD6tCWnOemY0QLYgZXLLJ9lHI80zvPzhtWEYk9SEISmh7CEz8
         vSszR6Qt7nLAOS1qHJ4jaEgwM4Mw+0c74Nd45UP3d9VVCHaOCLhlU1sjOQu+MIMnpg9l
         nhJOJMG7f4pfgR//8tZUkAyP1G1qk6mRh4lVBmxriTBmTbF7dMEqMN6P9o1d1IuMYwlU
         liaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285360; x=1727890160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPsLoFtiTWUjjmsA1rJ5MAluKVYhAgSJSenvC8qY/s8=;
        b=puS8uSVMQf323MrGZtTdzfuUIgMhBU3zezO7eypKK4ThE/vPFAo7DQS7N05RYT3qIZ
         BuM/ltRnaTQXguyBAhFYmfKxVKumpVeQnM/BjSindjRTDGTmvvniR4CCne8kyqR0jo4C
         +GEf8H4uA4thMKwHp09cqxZMS5rdRZP4V2LTPYQRpsjgknaxpoc5Q9J9adWBWZDupttP
         lVip2Ve2W+FbgM0tjBLXLfzsgEIbsRlk3Qy/ZthmQGl7cPm5lvQqnTeGgHxCL1gIuC3q
         G6KbfEuZadVrCqtOaWmSPW6yB3z+CY5lYBYOWC1PQ9e6zqIfeP2oTSK+sQN0f4cIAGxx
         UVww==
X-Forwarded-Encrypted: i=1; AJvYcCVos02wloY2qhz71FkDkZn/zy9Ng+FzpWSUFS+GgexfrD3EmPoncOcd1mHOEmX6ATuTom5tZohJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlatZszf7p8QpsYbMJ/nWLG9Vg5+FtK29e8QyG+FBFfkyQu8n
	vvNNcHqfkhh7CkuKTZtw+0KzCP6KdLmgS/WIpYa5SqiWsnE3M8mdc50mnpAmvOo=
X-Google-Smtp-Source: AGHT+IFeHFgRLlp82pURLjIMGUzAYeW3x05ZKYokz4hPodjl7149NNpRrYJpShubDa0DVyJ0o3esUA==
X-Received: by 2002:a17:907:96a1:b0:a8d:2d35:3dc6 with SMTP id a640c23a62f3a-a93a0360accmr290998566b.26.1727285359736;
        Wed, 25 Sep 2024 10:29:19 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930c8a7fsm232280466b.130.2024.09.25.10.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:29:19 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:29:18 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, guro@fb.com, 
	cgroups@vger.kernel.org
Subject: Re: [PATHC v3 -next 2/3] cgroup/freezer: Add cgroup CGRP_FROZEN flag
 update helper
Message-ID: <xhsoggiadzaod6lcd2tf2dyhisoobzoap6st26aj4yv7wegu5m@7osb4v5w2m6t>
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <20240915071307.1976026-3-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y43yx5a6464v2r6i"
Content-Disposition: inline
In-Reply-To: <20240915071307.1976026-3-chenridong@huawei.com>


--y43yx5a6464v2r6i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 07:13:06AM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> Add help to update cgroup CGRP_FROZEN flag. Both cgroup_propagate_frozen
> and cgroup_update_frozen functions update CGRP_FROZEN flag, this makes
> code concise.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/freezer.c | 67 ++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 35 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--y43yx5a6464v2r6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvRIawAKCRAt3Wney77B
SaURAP9SAev+fLiC0R/MtYem5eSbTcqDNMuD5wH0qDC7vVXbcQEA+PVUipa4a+8+
QT1GuLZo6nXc4cWEYRHdl5bFqmph+g4=
=iAcF
-----END PGP SIGNATURE-----

--y43yx5a6464v2r6i--

