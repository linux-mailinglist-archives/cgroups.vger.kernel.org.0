Return-Path: <cgroups+bounces-12361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A0CBEEB8
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 17:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8249300E7AA
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E212B3101AD;
	Mon, 15 Dec 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NEym9ZV7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04730BB9B
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816106; cv=none; b=FdzABSfwv+ctT+IlsqHUiymdeRDa9CeNOm39icpWtnytxTrV7QAnkJfBabKAY+btf4840y68qvck1JeRqFZZH/iuNeWHu8MVgCIe1Oc+VloHCsHmKFdqwmV3zsnIioPHXtShFkSRGBvy71Ll9rou8GyMDCme2qnq47xIH6OLeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816106; c=relaxed/simple;
	bh=/DxlE5J94ZZdlSh9KO1bZB7j+GGcQwOit2v/TLAm6q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qewA+mSlw5aRKl7NqHNINuo1efDCQoIU1DZXH8yhJOqr9Zo3Q6Axm4fUW0JcHOCe62Moqwvdob5Eg6JKMh/ASlaDiGv0wCFGg/7B6kdg3a2VXQyF6NJGVZhDSIZSbVNY4ca1VQ80ifz3bUlRJsPPqfEi5O1UAtJ/ABMP+UJBShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NEym9ZV7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso29674725e9.3
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 08:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765816103; x=1766420903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VZxtE7Htd0xG0D9835NYXF1K/HCgvvqAiOScoqB/3Q=;
        b=NEym9ZV7i/lbih04s8MKYMqtdglYS9xH1TAE6MwCzrl4yVWMhe7qpzc9t/TgE8fBUk
         XLjqA4HZVd1go4XPXWInq1zHrNr62SGPK6HluYlEX2ufcFpwUKybIBOcPz97mMPxX+u+
         lPtgKXsewkJFohViRBkd6vX4nihJ9i9vIUyuXAVS4ebXX0JsxZDzlan7Z2TYv2Xg6jS9
         qGP1yvOmB3M1LnYOyOB6GCqiARZiauUav7WgK/VUX1hKuKzPWIe4ZrGnvwLSUlYRx2Ll
         +YiFQr4WskbqAk9imdmIKECqh2PCgJIgKGNJ4amhmhZpYRisewz7bvkUnGhr11EuLYTc
         a7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816103; x=1766420903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VZxtE7Htd0xG0D9835NYXF1K/HCgvvqAiOScoqB/3Q=;
        b=NneJ5vcdrVPjnVfLqqZptQHViq012wMIZIkc4/W5i3+Mtk0ayCL0ViJk5T4xQuo7SL
         EWGM8hWnafHoLW2F4FexJNRkuFzEL+gfqGl5MsLSjMlFmJd7S+NNvCZs61tTHhizn2g7
         48EjgiF5jy5lJsDuF5zfsG+px59sL7JabB9ikP7665H2caYuDJ9L+BUKyBMf5W3ZqMrG
         Hztcash2T+9lVJDz6Rw1pPRuNUoQKK50y6gSjvKdXFaFcbMolWaN0rH5TKEBcFpiamMs
         74WMpQdI1QecyxgTb5vLx7tgjEiKK6yF1GgMDfZLKL2iCG6lplFO9vxXDZMMRgj1CNwW
         m9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVGmRuMWCEAGUhrD1rrORGHcYA9D9oSYX/rb5pi8iiq5ObH1P/r4qjvv27lGHjeZlKQFmPMoj3S@vger.kernel.org
X-Gm-Message-State: AOJu0YwndtRvjG3fY95LBmWGbOp7CL6reJiYkEYw/sg9pYlj5VQT0AEX
	IlfjcRbj8W5f8BGa7iXLTwiU9p0uogpQgeDmoRgUly2w9Nz8Ql05ikP3LabqEStDGN8=
X-Gm-Gg: AY/fxX6utYA5FOm03fwdyHxAUrZF2KtMqFO5WBpmfJb2Pg3ooUCY1RBYT2alyza0nA2
	Nl2ZpgZYkKRT/furLLX9iOvYPkDIOICqaxxPxuoxst8aLRU7W2wZ1EqR/UqZ+2E65MENvky7qyw
	zYlM2qhiXokD4h5owst3V6GgNQ01kpO7T5JjRB5NyqZck2SU26/BJvYEVfl7opWgtLXTefqdvr5
	WckTSWdZJrqMdXzpVlSGFFhYWArI9WR4PM2r6jUJzF0vfDq5b5gXzuPQ4Nepn6NH69fboLSTh24
	s8rEBvebsbUa5OlLxoJD2tTu9YQo8OxMo153Rd11IQ2W0rUW62cqRnbnB8TUhQHNpwdAsF9umGA
	0sXfai9N6uUjuFLieZTAJVdf8+vD2P1PNLWmWrOrwHaV2g8JZhJzEqLr6FCRtEJ42ettVHTsd8U
	d1i5fVYK5nzv9QNNidlBZQbkDWZnZFlILP0wL8o0lHiQ==
X-Google-Smtp-Source: AGHT+IH+vEtmKMOaFGcV/3hvyaO/eJLWmQIOS8AvWE84qSFAfqhronuuYlLf4lGjWK+MYs+zJqABGA==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-47bd3d41de0mr10847475e9.11.1765816102873;
        Mon, 15 Dec 2025 08:28:22 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f38a4b7sm197204695e9.3.2025.12.15.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:28:22 -0800 (PST)
Date: Mon, 15 Dec 2025 17:28:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, david@kernel.org, 
	zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
Message-ID: <o3hmzratjkcxms3ylnjiuashclllf7mvz6ttkfrz4lybdiwhhp@yeo5my374trx>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lc2v3gcqh4z4ltd"
Content-Disposition: inline
In-Reply-To: <20251211013019.2080004-3-chenridong@huaweicloud.com>


--6lc2v3gcqh4z4ltd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next v3 2/2] memcg: remove mem_cgroup_size()
MIME-Version: 1.0

Hi Ridong.

On Thu, Dec 11, 2025 at 01:30:19AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The mem_cgroup_size helper is used only in apply_proportional_protection
> to read the current memory usage. Its semantics are unclear and
> inconsistent with other sites, which directly call page_counter_read for
> the same purpose.
>=20
> Remove this helper and get its usage via mem_cgroup_protection for
> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
> to better reflect its meaning.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Why does mem_cgroup_calculate_protection "calculate" usage for its
callers? Couldn't you just the change source in
apply_proportional_protection()?

Thanks,
Michal

> @@ -2485,7 +2485,6 @@ static unsigned long apply_proportional_protection(=
struct mem_cgroup *memcg,
>  		 * again by how much of the total memory used is under
>  		 * hard protection.
>  		 */
> -		unsigned long cgroup_size =3D mem_cgroup_size(memcg);
+		unsigned long cgroup_size =3D page_counter_read(memcg);

>  		unsigned long protection;
> =20
>  		/* memory.low scaling, make sure we retry before OOM */
> @@ -2497,9 +2496,9 @@ static unsigned long apply_proportional_protection(=
struct mem_cgroup *memcg,
>  		}
> =20
>  		/* Avoid TOCTOU with earlier protection check */
> -		cgroup_size =3D max(cgroup_size, protection);
> +		usage =3D max(usage, protection);
> =20
> -		scan -=3D scan * protection / (cgroup_size + 1);
> +		scan -=3D scan * protection / (usage + 1);
> =20
>  		/*
>  		 * Minimally target SWAP_CLUSTER_MAX pages to keep

--6lc2v3gcqh4z4ltd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUA3IhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhHDAEA3ePRl1oqqoJs1d3McZRX
xevo8ebBHTd4DUJSJvbhJhwA/19a+3X/nxewd71A03xJ+bHGn1w01e1sr6huB0U7
URQP
=OXfw
-----END PGP SIGNATURE-----

--6lc2v3gcqh4z4ltd--

