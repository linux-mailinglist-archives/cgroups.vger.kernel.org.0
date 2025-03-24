Return-Path: <cgroups+bounces-7224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D0A6E1DC
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 18:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33E13B6553
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936422641FC;
	Mon, 24 Mar 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S5RI1yF1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2A26389D
	for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838503; cv=none; b=BM7H7fmiVBMYbXC37yz5U0N1isBoVJwgK4A0GJkUZgJ3QaJn3YqkyJVYey88r/HbE/0rtpflZP1FFFw2G9rl6uzCd2N9BJjxj8zwS7H7HI9q4hG9n33dFmXRSSTYGrj5Dxb7SvvspQC9dKCqoXvXbaxPpBA0kkj4P/LAV2SuBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838503; c=relaxed/simple;
	bh=XQYbNKGAa5tmW22LP2BhWc7/gSFU3vk9b4E2hDmbelk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE0+nlSA/aJyfvItrMscULZj6D29R1fvL58+9tVi8ygQN3b0vommic4iIeFqo+UFgUW8VcvM6+RaS9zqF9N3+FOAfEzoDrnt3e0WvArVdMWd/LJv7nauRU3EcjqcmzspxQusV0HEfJGJO4Ci9CksLOyuF2KvoYLGBdoWnuU+UfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S5RI1yF1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0618746bso31931395e9.2
        for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742838499; x=1743443299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2fnp6shvw9hnQWeNOFwj+HGFjOKb2GCTSLXK9jM82M=;
        b=S5RI1yF1Gg5AgWWt2nUZi9XrxvdXWdH97dhVYl5XF8sT+bfwsgDNkN3rn+ePU5naam
         ATddhBD072MGbPbmaTGzVJs290WKBClkmbYpYMQhEx9XshLf2ce+QJGdAbLo5TKeDHEF
         7wJkAM4bh6mL1CQMsTtRrXHyTY1q/TJoag8lfM9qMTqr2a3ysEBlvwA7lKCQ408/qrm7
         RYDUhFcS0A6QbNkyWmvtVlXTokHgx5eCNCn9T3tWFziHAjkQ2fNSVYmPS5C3blUl9dNX
         XeO/KDd20OTgIqHY9Uspk/JvCNNd3NsEjyJYs+tkr+ZnNm0RVdbLOyqywFwTHQIBa49Y
         WN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838499; x=1743443299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2fnp6shvw9hnQWeNOFwj+HGFjOKb2GCTSLXK9jM82M=;
        b=bsvO5SY/sw6ZuAeigx5htKuXqVu56O5qW2doS+BYOoN/bDNNcJCaVGEx3Yfox7Sntr
         9g/filBqAigmSK69sSVINGi6+FwCfSgA2HSNUvvSzeXtV0zBQZn7uY7VXeqtzQ9IcLHd
         1Vw9TrkODIOKI7LcBVkdaU0bgkpvIG0A3H/az5IBWK6Qw7Bz5/lOyYDGVdyCzQK/2t7s
         zEjNKdlcCKVpDsU1y/lji971Lx9YeR1mSePs7L+lzAXN946UfMWMpWrjcS8NavSLpwnL
         1WaATfxVotstc4s3o+dL21ff5kD6LMKOxgEb/7zA5zBS4/BKAfR+baxX0Xod2QbVcuXQ
         vHpw==
X-Forwarded-Encrypted: i=1; AJvYcCXGKb2ez6OyO/vThrwaDgNDMUvfstWhevIXG+L9xOYOS2dgg0ntfMy8WR+VCv5LDg2SywbKt9xT@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+eLTlNYHgOoaPJ5/023mMs/pAP1qSbmPwfaKautHe4Mml62p
	HD2iTjLyb4egCaaQhn6zq1VNvSRNxucTxebOpaHqG1hCBiho48gbys0B5bY21zY=
X-Gm-Gg: ASbGncuSn0u18SmP/kJ1d4MYYIWHXsWYTU/gg5cNbaprVjdLwXZ39WdZkB7TCo8JqvG
	HYruPDyC5iOhZFKaFWuiDO8Tf4WHuMjKDGd1pWFNGEiul7tlPsoMTZsPQh2JuBfgzDZi5J8raXj
	kMtv7CSrwlKo3/SwzsjFE+HS8V7cfHPCbptm1F4A7xoUqP5OoHvjbQMU4imFVER4yfAx+U1Aob+
	NRuVe+L5pNRI1g/80o+qtmNvMttKH5iakIyekI5b61863sLvQs5o8wpUoRUJ182GobnVG3/ZC12
	hfi4dOhKi0yz8p2KyG7gMzkTvMSY0Nl0JTke5AKSxfc2AVpWMNXOPAHrPQ==
X-Google-Smtp-Source: AGHT+IExAHqqsKOcxE7n6h/EWdZmTNJMD3wEo3cTebnUNe87wsJOe5/915dDfyOx/qiguLvpWVNNzQ==
X-Received: by 2002:a05:600c:83cf:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43d509ec70cmr161589055e9.10.1742838499485;
        Mon, 24 Mar 2025 10:48:19 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f332adsm179041365e9.3.2025.03.24.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:48:19 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:48:17 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v3] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <p7uojyqriqy5qjen5zg45qxggwbnrvdf32pyabbah4arai4vin@g62jjsikdcqw>
References: <20250319222150.71813-1-inwardvessel@gmail.com>
 <20250319222150.71813-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpw6po2lm5fp2lam"
Content-Disposition: inline
In-Reply-To: <20250319222150.71813-4-inwardvessel@gmail.com>


--lpw6po2lm5fp2lam
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 3/4 v3] cgroup: use subsystem-specific rstat locks to
 avoid contention
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 03:21:49PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index a28c00b11736..ffd7ac6bcefc 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
...
> +static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
> +{
> +	if (ss)
> +		return &ss->lock;
> +
> +	return &rstat_base_lock;
> +}
> +
> +static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
> +{
> +	if (ss)
> +		return per_cpu_ptr(ss->percpu_lock, cpu);
> +
> +	return per_cpu_ptr(&rstat_base_cpu_lock, cpu);
> +}

rstat_ss_lock
rstat_ss_cpu_lock

(judgment call only)


Michal

--lpw6po2lm5fp2lam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+Ga3wAKCRAt3Wney77B
SZYGAP9LUeQCF4HCTFUtka9FD6zGHaRPoUOtugfygxxe9p8oiAEAiTLlDTgTEUoE
7s8ddTx2wfezw+zc3VWeSYokTOF1xgc=
=yZiy
-----END PGP SIGNATURE-----

--lpw6po2lm5fp2lam--

