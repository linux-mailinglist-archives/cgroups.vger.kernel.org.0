Return-Path: <cgroups+bounces-6059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D350A02F4B
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 18:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F340163F72
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2025 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2BE198832;
	Mon,  6 Jan 2025 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GZXxGeUy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8913AD11
	for <cgroups@vger.kernel.org>; Mon,  6 Jan 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185717; cv=none; b=TTaHRAfTRT8C3yy8gqtqp86KzWGryr8qExluHb05RudsbrxK9PXYkKCSD3/7QsMJPcvpGJznCEayaksNMoaE7yar5jtw5EY//ftI9X8iQpf1a07utEBJED4NPWs4Z6J+v9ftspO0xkZUVetWoTPNyl87fELT9Qd3hYZFMmzXd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185717; c=relaxed/simple;
	bh=rA+Ohg67XqV1U9yNvjqFfWdnC6me7K6AfpR1fcP1KBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/WeBmVe/zbGzE578FqtA2v2RpD5SUQSoWOai7J5qsO7tIszeJbvmGidzpltFhBzhfoFd4y2GaEkwpJJrb6frVcjyXI79wuesUKVpSdw2wfCteuL8f2BgOaR51WCnqYCiPYVac2PGjL2bz1luJ9ZjBrAk18veR+5LnEqSJmQCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GZXxGeUy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43675b1155bso139262135e9.2
        for <cgroups@vger.kernel.org>; Mon, 06 Jan 2025 09:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736185713; x=1736790513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyGA4lAiCzsKD8bpG2OLbm7SvOEgsIMLWbFXGinwzoo=;
        b=GZXxGeUyZqpL8CnLAz3Ha2gPrRkCYnD3cOKSdIat0kKs7vsHrApH/tBNWprvzh6D/Z
         3guNyNtrx6dm+mD/m6Q76cs5Qbmm5UcYYkS3g6GZ9VCJabbZwqjWqWCBV90F1M8Q2c3A
         G8TNexIZpW6EnU9pn1onLoMbXFrJQr7WLI02q+5JvUnrgLL8mFC+53hPMMCNMGyX9zLX
         UPOef+Hn3Ge4RVEMBFrI5YHnQMswIyTpFyNHFBwVvVy1uznkse0JlDZ7KhHBz9+kYVwm
         rrZuuoQ113JxUJ8CQHzNkzbNsUeCbLa8OHKBYLKNXKLuh6691SXwO7i0X18jaueVcH41
         9E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185713; x=1736790513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyGA4lAiCzsKD8bpG2OLbm7SvOEgsIMLWbFXGinwzoo=;
        b=guC2C1vZj2GANvzWRcP/gaZv5uHa2Kf1mqxaAHIbHFG2Nrn/yKMAAv64IVj8z/YaFV
         lzDZIoipUadIRklHQs3loTaFd668H2UpmGWAjUrrIk2o5WhsPOe/UklHt+V/LdETzOKg
         I8Xtd1+wQE9SuHbBr17zgp4rr8QKFRg4nx6cgwWuaPeqluXSxAi8aVO8VXSmv8RaN9tg
         mpbe3PYoLf8mjvDat0Zs/LDyhkvz2kkWX1fOCk2+gz+/trz180BHkqLDJfnCDSrs/VW/
         MyusU2a9c4Mb4uC0ap0jWG9Wvxm37P6lfXZJFy1a6zmEjWGzWfAbscp444A8JA/gOiw8
         g2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4bYB6BLR9+VaXsiyC/uhsTdY/EkhkmHy98nxh4ihWxZGCaboM9D7Wc0R4KWpt5xIA5JvaOaCq@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFVn56BD0UDobC+fKQF77L5I8pMn50N1RolVFZeiQcEmhzBLp
	GbRLE0hILn8I5Lmgf5mlmfHJq4tUKoIgG/hYoDjNJXnrkwzjuySHuxV9i1/XZ6Y=
X-Gm-Gg: ASbGncu8EketeXgRHPtA23NyF2NlZMVBkL3SvauU8ZTCzHPGSroi7k4V9aBPG3RbGOs
	iDh8xjdq+RAA4KH4hoLV/894b2zL+3EtNKLId+StWVRIHGUvhlx11TD//9Yi5wTmbINl3yrp/8E
	p+IxN7lc19nW6lhs0FIX+NtkVxoCL6uvli2YBVMVIX1TjY1byGoEFE8UQIy1LK2tScbS4W3gVFQ
	6abzi96QLFF+2I6i1Tmc8KdqtwxoIQz+3fe9NPKkuKrDDzLeKA9sP30HZg=
X-Google-Smtp-Source: AGHT+IGkwIuJtbwbUThZtAjQyXw8sV6HWFXnREb8nnP6DrTXZ11YQLIKmj95wr8m/cODFINVqbqcRA==
X-Received: by 2002:a7b:cb14:0:b0:436:90d4:5f3e with SMTP id 5b1f17b1804b1-43690d46037mr324429325e9.6.1736185713421;
        Mon, 06 Jan 2025 09:48:33 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661289d3dsm580766155e9.41.2025.01.06.09.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 09:48:33 -0800 (PST)
Date: Mon, 6 Jan 2025 18:48:31 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Friedrich Vock <friedrich.vock@gmx.de>, Maxime Ripard <mripard@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 1/7] kernel/cgroup: Add "dmem" memory accounting cgroup
Message-ID: <uj6railxyazpu6ocl2ygo6lw4lavbsgg26oq57pxxqe5uzxw42@fhnqvq3tia6n>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241204134410.1161769-2-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3gfwd2ja7fjanltd"
Content-Disposition: inline
In-Reply-To: <20241204134410.1161769-2-dev@lankhorst.se>


--3gfwd2ja7fjanltd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/7] kernel/cgroup: Add "dmem" memory accounting cgroup
MIME-Version: 1.0

Hello.

On Wed, Dec 04, 2024 at 02:44:01PM +0100, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> +bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *lim=
it_pool,
> +				      struct dmem_cgroup_pool_state *test_pool,
> +				      bool ignore_low, bool *ret_hit_low)
> +{
> +	struct dmem_cgroup_pool_state *pool =3D test_pool;
> +	struct page_counter *climit, *ctest;
> +	u64 used, min, low;
> +
> +	/* Can always evict from current pool, despite limits */
> +	if (limit_pool =3D=3D test_pool)
> +		return true;
> +

> +	if (limit_pool) {
> +		if (!parent_dmemcs(limit_pool->cs))
> +			return true;
> +
> +		for (pool =3D test_pool; pool && limit_pool !=3D pool; pool =3D pool_p=
arent(pool))
> +			{}
> +
> +		if (!pool)
> +			return false;
> +	} else {
> +		/*
> +		 * If there is no cgroup limiting memory usage, use the root
> +		 * cgroup instead for limit calculations.
> +		 */
> +		for (limit_pool =3D test_pool; pool_parent(limit_pool); limit_pool =3D=
 pool_parent(limit_pool))
> +			{}
> +	}

I'm trying to understand the two branches above. If limit_pool is a root
one, eviction is granted and no protection is evaluated.

Then it checks that test_pool is below limit_pool (can this ever fail,
given the limit_pool must have been above when charging in test_pool?).
(OK, this may be called arbitrarily by modules.)

I think it could be simplified and corrected like this:

	/* Resolve NULL limit_pool */
	if (!limit_pool)
		for (limit_pool =3D test_pool; pool_parent(limit_pool); limit_pool =3D po=
ol_parent(limit_pool));
=09
	/* Check ancestry */
	if (!cgroup_is_descendant(test_pool->cs->css.cgroup, limit_pool->cs->css.c=
group))
		return false;

HTH,
Michal

--3gfwd2ja7fjanltd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ3wXbAAKCRAt3Wney77B
Sc3yAP9ovqhdPX1shEVmXcwsztc0uf1lRR+Wsxf3kwK/GFzF/AEA62OrZTWy+e7K
cKrPC5As6ORKo4sBmoUVQk/+c0xCRgY=
=per/
-----END PGP SIGNATURE-----

--3gfwd2ja7fjanltd--

