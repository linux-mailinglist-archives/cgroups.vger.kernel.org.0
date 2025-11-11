Return-Path: <cgroups+bounces-11815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80DC4E49A
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 15:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB471883F26
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A0312836;
	Tue, 11 Nov 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HEMLuLA0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C530FC3D
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869678; cv=none; b=KNbusEgqOzKghsxEXcqEQlrpJknqWjKNbe4R1YHYP8QkayvGs0cwZVFcd1iSUeXtSFmF1p5Si8UqBOs7oM5Eeuex6Yfi2NLVWYwPE/w83AXq99oo68I7ju1yPmF4QQPNDSEhJai8WE08TH3bfhEVdiFo4BkFzPC8y4y382loCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869678; c=relaxed/simple;
	bh=MmPuidlZt07s4AArPnUosAo0InWy7W9DsbE+xadi5Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTg9E+49Y809pfbYh5fRT0LPqvoPbZ3xQwWVPY6Q0zc5koslA471D8mJGZ1QUf/YOMXyLi7gXE5ne7aLwsG8pzjIQIERXtuO+xiBJtB7Wv5ksSrVLivFuUk/Tnt/cL3gQ9/nqA8lJ3YHKzHRQzLLJxvrEHUSbcSGmIHEiMV2O4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HEMLuLA0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso1829302f8f.0
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762869674; x=1763474474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpiqZtSLPb9pkXftVPi7ug5otBL3UKnspA9VU1n6xWk=;
        b=HEMLuLA0nHP/hWkHbvJzyn9vWh5gbU94nFfKrMs3NVFh2FK9dCpzh9fj5DLeGfEHoj
         1dtCLNPsydxIYOaEfA6Zr7JqWUD60+i/7SEThxOxKulejWE908NaqBJ8cIfApj+DypJh
         v23zODuudIg+6aDSXuqowMVfPrFThmRLGrBRvhtijzTtNBaZ/ZWxQMLhrSkIqqZtGaTp
         mZx2Wkdv0LpdbOvvQ6leS2pWnjqqRo6nYUjjxjWN5Bd8OkG4/j6RthdI/gBOhBuqc2bW
         W3FgYssV6UC1vGJAR4henIGQA790MZWI/16yhciVt4d6BShNqdAe/BLOM8NW14qrqG0E
         n1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869674; x=1763474474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpiqZtSLPb9pkXftVPi7ug5otBL3UKnspA9VU1n6xWk=;
        b=em2CU3Zh7NCsL/27JROm0Dw0py9i9wmOUeDUrJi41OKio7I1D3XtE1942TE6G291Ez
         CzMx3nTVlMLmw3FTFiH3o3m1RNgN88HHO8I2gXOnbtbJTI7L1L77clltfYElknxGtDEs
         Axhqha68cmwenbpsJYSfp6JqjG4j0V2EaRQYc8gUYTyc4g7R7d+OFhlP5wqBlzzBYRFD
         yBzh0rLO/UqUjB23EXBnMmEyB9P2O5N8UYx2Q1X+6zooHEdb8zkJ3PI0GQvbDjMAVR/r
         Q8RYB/dRJfvJXspqBEVqclgKZvhkM8SuAt+kNbm2FuiJjSF+AFe/cE3Ci22kkH6t703R
         FGhw==
X-Forwarded-Encrypted: i=1; AJvYcCWZUChZ8A5XvoNnjXsbR5NeFRixnXw7DMeT1FDSXKj45Uc9zWwxpmNJEqdtvsrKBNCE5KxLmhaz@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRN8t+cXXwH5lhQIOfA95wHU+Xvvt5qDEMvXzp06wCNHJhKUz
	N0kGLbLy+c2Lugm03+0nacEBAr81bSbqLoNczkOWixE86UufqRGOjeOhzc/caAJ43fw=
X-Gm-Gg: ASbGncun2M5gOiX8XXWenYu13FHX4Gas4RRtf28dmbHvB1YNNWyQOpLIV/t+85aKv94
	EmLRtPJ9Wpd6BmWMVRzT93Z5cX6GNYvuOocc9LUjLibI4TJAThAC7qaXPnT2l7i06US4YwJ3YYD
	uCgWYZPdvPc2w3IpbRamGIl95jVKHDbcn/NL4gpCnFyoFV9rMrvFkedU2ir0EnYptw876fUnJng
	frl0Tr8gkEq6GinZQGFBg49brQ8GmFpHqZ43TiT1Y/EFxxvzDhMjTjCEKyxmQYX/w7RB5S/FUEZ
	W82eOrr4iM3mgtmFzbKjaFnk8pKK78JyNdMhM5Lay6KSGs+RhlRXu7Iy0pW/e2/1nIGsitP3Uax
	0ilUQK5m/ByTHB6H30qONsDSr6Dt9UY/n+wa+uG/kZIb7J3DwRGEV70amiyNNpM9Y6bNU50QQ84
	ApKO3Wnsb9bL4xgIMnl1j67ZJCSnBDmYY=
X-Google-Smtp-Source: AGHT+IEtS9kXeRt+yPfdXbLZRQn0tq8TDEceP/3cBHD9mJp5+UHkC3XzPNI/FE4yTh1BLvPK7nSCGw==
X-Received: by 2002:adf:9ccd:0:b0:42b:32c3:3947 with SMTP id ffacd0b85a97d-42b32c340ecmr8237525f8f.62.1762869674223;
        Tue, 11 Nov 2025 06:01:14 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675caecsm28286957f8f.30.2025.11.11.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:01:13 -0800 (PST)
Date: Tue, 11 Nov 2025 15:01:12 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
Message-ID: <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4rgfcjtzn66yxrpg"
Content-Disposition: inline
In-Reply-To: <20251111132632.950430-1-chenridong@huaweicloud.com>


--4rgfcjtzn66yxrpg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
MIME-Version: 1.0

Hi Ridong.

On Tue, Nov 11, 2025 at 01:26:32PM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
...
> +static inline bool cs_is_populated(struct cpuset *cs)
> +{
> +	/* Tasks in the process of attaching should be considered as populated */
> +	return cgroup_is_populated(cs->css.cgroup) ||
> +		cs->attach_in_progress;
> +}

s/process/cpuset/ in the subject
and
s/Tasks/Cpusets/ in the comment above

Also, should there be some lockdep_assert_held() in this helper (for
documentation purposes but also for correctly synchronized validity of
the returned value.)

Thanks,
Michal

--4rgfcjtzn66yxrpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRNBphsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjEngD+Pbj8lKpXg7czhZJuriUA
P2ytUsPi0gTjlYIwQ3ecaYYBANqMamr1EB4EFwZobwKE7XxaO9Y87ABBUNVrLRk1
xOsJ
=S2KI
-----END PGP SIGNATURE-----

--4rgfcjtzn66yxrpg--

