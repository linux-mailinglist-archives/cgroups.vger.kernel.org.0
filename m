Return-Path: <cgroups+bounces-7135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5976A67874
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 16:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CC63A9A0B
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C6A2101A0;
	Tue, 18 Mar 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Et/URCv9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A620F07A
	for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313118; cv=none; b=QRUlOq95mCjjErAvkb5hPfhb/UqX6WdULixHek4UVnKU1Z+91muEMRUjrmpAlE9t5RND331dkGWN4Wj9TOBBHzvM4sx4Mwq2YuCkizClbX/+DsxUBAS5mKBvoUlXbS3Q14HAQXwL+jszXqEXnk/L5zt59B1hVHlUkliQKCJT04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313118; c=relaxed/simple;
	bh=DGxt/C9Irx935A9Pm++nZrOSxRQnuPRkq/va9N8kXGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH2P4gSOypw94Ytxr9UbQLFVPkv0wfXGD+KlELASJGgJq0hQM6PPprCqQTTopFGZVU5NWq2DUk8RQU2N11BZpD/0ct/d+X3JdIbN7ayhmIb5A24zNa+mqwLLvDJ4GPZfGl30nnpnKGubpsiwEdPiQj1srCJ5yKsQ7AgLkYrrPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Et/URCv9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so17108545e9.1
        for <cgroups@vger.kernel.org>; Tue, 18 Mar 2025 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742313114; x=1742917914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LC+nF3SpDbrztDI/MPmvjDr2ML72AXfztVInSF11ZLQ=;
        b=Et/URCv9VUqhbbCuh2OiA40TUlZTJKIo4NrqYpYx4anoeTsHY693SRXZrI+o0+4Aru
         0730BET89aTdA0xl/EQaqbOvGYDIGvQQ7Bi7ukSpTdvXpedOokPNitrbfsLT7uVCFa3n
         FV5GUuywMYOqMHK8kKxQU0Deti3eYEBktIcRRt3ThEaOm33VqoFlr1O0klqggcYqNwJk
         OcVVUoMgGOF2p3qMHxX7pHccKlUhyqWjiun5mV3DPnbo6UxYeOjph8BD7F/kB3mejYxi
         gotEDBILVR95etF0e6Biwar+7wcpe9dsSZCzoY4RtOz276QoMAAheIT8xZZ9TnYimZ1U
         CmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313114; x=1742917914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC+nF3SpDbrztDI/MPmvjDr2ML72AXfztVInSF11ZLQ=;
        b=HlylkTWaW9CSERhvwjiyXFoXGKwmCAUpMLMNhSZtnAdjTAYfXPCtrvABxyeQ4koqdg
         AJXFqQd5zFopqIs9CEcOQT8dsn7OFGMr0GCMJi6kUqDkEd+zyXK/r1dwjIXCfz89ZvbO
         pD9gNh/cI342JgDJIWKZilq0QFdh6Z+5yxw98z8WMSHj6y3WpW6SouTtTFtub/IALxDu
         T2oxJ3z5iAK2Ti31ZVY+ZTx2k8B1SHX8boaAbunOyFO2JVtzIFzBAKkjZnGpp78w5h1H
         /efMfFzXq/OU9HDQ6+A5LR2gL8mKTe1GgbFZwrhpLH27i5Qn5cWZXKQ9gN1dqPEdZVL3
         FVJA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6ME961m7RfOIUKtCv+DPlhJldMJiqC6mtWavdgLym9hWqbn55/h407qjU/6tHDIW8gZ9Kyog@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWzdbmRClg0+MGsaRFp2jVLkaUKV0iXao5n5sZkX86yWQUk9o
	6Km2e7/dU6SPih0861ZbH2V3LCs9r2/Yu5XPGf8Lw1YOEHhgDMMHtFYlPorbCA8=
X-Gm-Gg: ASbGncvSxNksyCFMeIyiOQaN2EgnBrqknN5/XKJ2Z5xu4WSAw8zc66CT0bqhO8IbCqu
	/OFikGzxx/6TTrBCASl0J/N9MuZ3TyIJC0oOLLMcQSYVd3u4j17S0h5vCVEf181JydGgiu8xXcG
	c6KFSXE2o+PJjVP4PS+lwueP4jeotfyawZUtp1ixAbpl97t05mk8DlZo129szJUKtThPxdGnJQ0
	nlJihdN9L5y/w+YNK5tnDrPB9hb7ULFwDSlkkLxEe2bWalHmFKXJvawn+r0OdOwK7FB9N6biAJF
	XjATxCfLM9+/A+Zs7ww4j5gVG7cao1po7ZgGwEmkGdLyzr8=
X-Google-Smtp-Source: AGHT+IGue5dNi02epZqdFwISRO2DqY6eSFTBAINSLQ09pyo7v2ItFYvRcQhhbHm998Hg1ISsTrUK4Q==
X-Received: by 2002:a05:600c:1da4:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-43d3b950035mr32588205e9.5.1742313114536;
        Tue, 18 Mar 2025 08:51:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda2dbsm138960905e9.2.2025.03.18.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:51:54 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:51:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, Wen Tao <wentao@uniontech.com>, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration error
 handling
Message-ID: <sb7dgl6e22jsskvtiqvfny64pdxfxuyijcj2zxc46s27kwecfw@xqyutig7nlem>
References: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezfht26i7an4lh3x"
Content-Disposition: inline
In-Reply-To: <3E333A73B6B6DFC0+20250317022924.150907-1-chenlinxuan@uniontech.com>


--ezfht26i7an4lh3x
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND v2] blk-cgroup: improve policy registration error
 handling
MIME-Version: 1.0

On Mon, Mar 17, 2025 at 10:29:24AM +0800, Chen Linxuan <chenlinxuan@unionte=
ch.com> wrote:
> This patch improve the returned error code of blkcg_policy_register().
>=20
> 1. Move the validation check for cpd/pd_alloc_fn and cpd/pd_free_fn
>    function pairs to the start of blkcg_policy_register(). This ensures
>    we immediately return -EINVAL if the function pairs are not correctly
>    provided, rather than returning -ENOSPC after locking and unlocking
>    mutexes unnecessarily.
>=20
>    Those locks should not contention any problems, as error of policy
>    registration is a super cold path.
>=20
> 2. Return -ENOMEM when cpd_alloc_fn() failed.
>=20
> Co-authored-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Wen Tao <wentao@uniontech.com>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
>  block/blk-cgroup.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--ezfht26i7an4lh3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9mWlgAKCRAt3Wney77B
SVbeAP0R3rvFXNGUuUa13r5copvUVvPw7HFAvwgRKTH+2St7xwEAnNOyY8KO5Bq3
vaXcX0HdBl1zK/D6EeT9tE9kZc1RHQ8=
=Rk6K
-----END PGP SIGNATURE-----

--ezfht26i7an4lh3x--

