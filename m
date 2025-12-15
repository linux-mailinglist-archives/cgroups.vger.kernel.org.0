Return-Path: <cgroups+bounces-12362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B0FCBEEBE
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A671303213F
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751B30F550;
	Mon, 15 Dec 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TyDbRDUC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA23093C9
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816127; cv=none; b=Eei1xm4p1WR6dyfPqtC7RQ9SJJIcnfAGmmfInZsQWlcMqOC0KCCTgiMtPfxq1lMPPjWM3W2AcLbHUht0D2MHevEi2pBM187lVuq08MkznfHYqCn4DLUMjBWhrmPVlP162AaMcaOPgj1r68n1aTWlPlxanq/yX2+eF0g7R98TSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816127; c=relaxed/simple;
	bh=66EUcAUTpTndsSJRL7Prll91qMrWzC6inIEzHOQBibs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX0QGX3bzwhRCu1kJQi5EYS3LEzyzybA6BVOwQ/5j8/B44kfjhKC+EC9CfNh4zigDsacycADpV6qwv3/c7/X0m7lWUMaBluZLEKMWVBr7YOHwL5iSk76FL3CEiLL23OHUfCn+y8JAs79xecSzeP6INXMZLWdFvfqWFOCvR1zYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TyDbRDUC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso1958965f8f.2
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 08:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765816124; x=1766420924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWw+tWmkHo6tPMqmZEk9P+niRGJoCGV4ZzodtDdGtk0=;
        b=TyDbRDUChemKwzTSnruWGmcqkT+vrsIMsNgsNKimy6Vv5jfGre+qV98Eqw8cKp7jeM
         TsjEbvEZ8HtxhSb+R+NxvpCH4tMbEZ/JsIaj5jVkOFBNRv7g21bDsgActT2FXyjgJbCn
         tSLcvym0sVl3/oWxwymc+FSmQ2nCwvlcRw2wd3wCAkgfGzgFZyStMMv2S+Bt69Ma2If2
         BnnpVz+tkailB5qPqErxKfQ+uo+MTR8zhHIpn4mauL6PaCI2h1dNxzHvGzoykT7VBGKc
         eILB/mrVMmzLS3d2CQJmZ9q0TPB67+IF889Zk5r6rxjMCd0PIbDcPDpd9aRpQ3ueHGm0
         QzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816124; x=1766420924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWw+tWmkHo6tPMqmZEk9P+niRGJoCGV4ZzodtDdGtk0=;
        b=FTHvVZiqXGQ8/I0tlYDRzb3jpAFe9h83Je4gY2OWNZlhSQRoRIVzckiZQtVX+xvDLy
         YJ/FNSgmpdV3g+QP+Zv/S/AK6oyp1auFP48wkIfV9sROZnE/jnfVS/CPD1aproO2eDNM
         FCRdHeWj6+/p3zN6n67kWDg9SAQD1e69UWIf189Fccy4VcKULckqw/i4zRw4R0+zAufq
         4D+ayWGR3BtbQduREorv9upD4wAV0QmqAdn9JVrZaywS1OIKN0YoScI5XmFcfx329oTL
         jIOEzr5Wp1nKrFX7Y29xmySNQs93TJEzy7aQC6wajnoVN+ACKZqCajgDNHfy661KtdEz
         stiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlBL2GKTOvupdY9H/a+OdVquyzAWB7BPicDjLI+dbFdeP1zzh0yDt3pkjtBH9n+9Jg616wTY46@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFKmzF3LvI77Fu9j0k37LN4WP7xB6EWOmojuXGOTGq+R7G8yB
	UwCKoXOidY0mzMN4iWMrZOqcyqumr6pAGjq8Y67kpSYE5ps/0DXKm/lXx/UoFkRCwCo=
X-Gm-Gg: AY/fxX54Uu48O52WxaDGa550ipv52h8D4NuOpW8121O5JvE2qVqw4RNIS0PwLmg+Mpo
	9CMUNuptOBZGraXiRqMZDS6kz5fRb/01qbG3og/DjXCvNMm8Dow7TG3CARvj29LEPX2zVOMhXRJ
	JX+/RjaStFc8YBvtbwpJUlpkPfTCE6S5q0iqRZFfNp/+FaD2+kPakjJYrH5vzxtdWyD6PlWC4e6
	Xo5xLh9W4Wj/xBFGO95Vl7ZjXxUE2JTxOb/dxBFMitvSykHQ3+g+IpKHPlHR5wWqEpVsfXs1BIS
	pa0mb/HOqjXidzRQQZD+4ceHd+zXZp8EkrIIDFiZtN/goQbupkhyUbJntyDYPdGAqLXKDyBoJgs
	TZH9eG3hQYgwz43JgGCPus+nY2rCkB8/m4u5rNheP/fjQvJ78YqxHPMvGEWlK8BcY39xpBTZu85
	ohwbXYyZ3rm6Of7nidPKuaaIa/UXRKf4jQ9IzRyrqYRA==
X-Google-Smtp-Source: AGHT+IEWUVPMrA6Fi5wvb0Db1pxM3XzOxI5IqMeRhxio+HMtumGqZc07ye0kb4axZ8m9cm5bX784HQ==
X-Received: by 2002:a05:6000:240a:b0:430:f494:6a9c with SMTP id ffacd0b85a97d-430f4946d3amr6708612f8f.17.1765816124058;
        Mon, 15 Dec 2025 08:28:44 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f42a3290sm14751671f8f.17.2025.12.15.08.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:28:43 -0800 (PST)
Date: Mon, 15 Dec 2025 17:28:42 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, david@kernel.org, 
	zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next v3 1/2] memcg: move mem_cgroup_usage memcontrol-v1.c
Message-ID: <oshmc47mt6ivnxcozgztsltxa5enqztrsyrk4ph73yfbwigx77@k3t3vhni5gvq>
References: <20251211013019.2080004-1-chenridong@huaweicloud.com>
 <20251211013019.2080004-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zggmhi5oxztkuphy"
Content-Disposition: inline
In-Reply-To: <20251211013019.2080004-2-chenridong@huaweicloud.com>


--zggmhi5oxztkuphy
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next v3 1/2] memcg: move mem_cgroup_usage memcontrol-v1.c
MIME-Version: 1.0

On Thu, Dec 11, 2025 at 01:30:18AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> Currently, mem_cgroup_usage is only used for v1, just move it to
> memcontrol-v1.c
>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol-v1.c | 22 ++++++++++++++++++++++
>  mm/memcontrol-v1.h |  2 --
>  mm/memcontrol.c    | 22 ----------------------
>  3 files changed, 22 insertions(+), 24 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--zggmhi5oxztkuphy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUA3NxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjUkQEA8FJ0+x7VlY8tI4SBieqx
WYg8Xzg+uuluC8BrRJr0YLoA/2y5h9r0vvPhhNNWV698p+QJS52s9tRUAMFU4Aiz
G+YO
=xXct
-----END PGP SIGNATURE-----

--zggmhi5oxztkuphy--

