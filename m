Return-Path: <cgroups+bounces-12375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88DCC1DF5
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 10:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22CD0304D55B
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4C33A70D;
	Tue, 16 Dec 2025 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OnRUhq95"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4253328E3
	for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878707; cv=none; b=SrpkL8gApU968ex0soa4MaG5qGMoGKPw6GPUKlcG2xHF9U+tvpK/xoCMTdCSdIRwypvR9YCA8ZB/JQm63Fub9P00Tg8Gj898Ydh+wF9rsIXCi+8Japri7TJ3jYJKk7+xeXvaJPHisRIC1wtBnuSfLDs4UF16utNjlM4Y7YhzF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878707; c=relaxed/simple;
	bh=5+tp2UYitv2fm0n21+HdpMnCAaCKdABwxgrNU8zsH+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0f8RX1X4zm5XmWt/T3GGtvy2EgJB0XlW2d265zW/UyjNKcJXv9BU67N3zYKfczRsiUkpyLA9O2DF/IzByX9JB27poMqL5vd2X/zvIF4fWH7QCSadMOS9QcbtLzXWC7OgiHmJqEXtYpAqOpD8u9sZV5X3hvIHuQTi9lOsaRDQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OnRUhq95; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a637712so29307275e9.1
        for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 01:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765878703; x=1766483503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4KHLKCgdvHljKH0KooqKxxS07H4rqH19ntCiCj9EYE=;
        b=OnRUhq95Sk1VZFOzu6GuBZUxfXN0WzuZQA82sQAkiCRXJtZNMzz3GH9+xi9zOfbQQ4
         gH4EQ0CQSfeP75E4i5CSGjtNLTtfTyT7ri1hYgVedNkU9vCaStOv0tZ9jCuTs1fhR41x
         QZeiIpxoedI2LrZDO0o4DZMYO2cz243Anmi7gdbAsvXK5SewlW9X9ZvwMq45ca0gtxii
         q6KdkQ7hu4KRjwISxXIRp7C1Zea5DyuupVB8dJmrAvd0eYNaLs6imU1HlXjjNKwR6etI
         QEEU0EW6SRWgh90gQ/PY6iKjXoZArYoUNJeq4yoyCORMAUSV5m7tQi5uK+f8tCk2yAuw
         rgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765878703; x=1766483503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4KHLKCgdvHljKH0KooqKxxS07H4rqH19ntCiCj9EYE=;
        b=wBusenU1+pRAFHU3HtIW2j88yDfyl6LZJzqYPgFQur04ukmvZ/ohiSF255uuBRdsof
         m+j7T3V/Qu8iBm76VrPO4CdWHKfOlD+ALl/TJe3xHlP2iAJAD0cXC/xH1K+WKAjn6Z0L
         cnXvUlzza/pdNMqmFggDczW4+FNu897H38VnKSQtID6m6oGQdRP2n8EO9bgI2UV1M2uZ
         Mbd/vFJ7/ApjXG9p1cdwWe/ziFfKFwvwEGuT/dRHkJ0X06eBIrNjMuROVlEmBQJt/Zdd
         5W+MkZbt85wU83AfaIHfyVoa3G9g287PnxqwzpTcEpdTYG+PeIFej3IYwpM2lcSBQbY9
         5S/A==
X-Forwarded-Encrypted: i=1; AJvYcCX38buy1xNLG+hrp+VLhCKvs65INHAVlDyf/Mjb565XMQ9Pp7l2me7MYsPqwM3ENXe1WgNmt8K8@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwGCTn48qu01gPuJzco9tuWWQUpGbBIVuRFqnJGbuftVoPP5i
	tnpDR6WUEyEGlhJfPtv09/6NehFsdi2/M+d++e0X0mkRuO/Fo96LA/5yXPbCK8PVzgU=
X-Gm-Gg: AY/fxX7HBahNDgmPcMO51RHZS7NfPrCT9Pz7vQUgZ5lKqAwd6B8ff8Zwdwo3liOqV7l
	6Q470qNSo4LbVjjYzlw2iJOpc8dgqA5j7y0G72dFTTyCcUmZKDzibiT7L5Ogm/uHXIerI22U/m8
	8g0ie5MEtkRpyrE4LCJzmYJHbRQYdXhkkoWat7Itui6I3DS8+8HL8aiXlVi1JyASutzFNr79tjV
	SApVv0lXrVRi7YwITrHYsdxeT2eozCVcnfAP2brHd5WMv5fYFYyJqitnthElH8vTwoqooGLw9/N
	oGmKBUw9W3au9mAmleLd41ZhyvB9T64l6vGtGIMtKqmzfq2bKXmlFJd7rrO6RWwyTsNQCsnq2Jy
	EVD69GQFGNEneDfj4+EUrSMKdZd3g4ADcMR6PPoI/vxUIhmzGee0bnHbfAP/UA0Eu96s3JJcKZU
	3ELy10jSXqFY3vkcw8VSLMz+ZRwSAc9go=
X-Google-Smtp-Source: AGHT+IGa17zKZkqqc3uPVbnBRJzGO+tFfUG7BnwFwvwCM4xVeELcZJhyBxHcq9OVqFTjK/owwWVvew==
X-Received: by 2002:a05:600c:5252:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47a8f708ebamr137710275e9.0.1765878703400;
        Tue, 16 Dec 2025 01:51:43 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd909383csm7271035e9.2.2025.12.16.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 01:51:42 -0800 (PST)
Date: Tue, 16 Dec 2025 10:51:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
Message-ID: <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
References: <20251216012845.2437419-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hi7obu2hrnpqvu4n"
Content-Disposition: inline
In-Reply-To: <20251216012845.2437419-1-chenridong@huaweicloud.com>


--hi7obu2hrnpqvu4n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
MIME-Version: 1.0

On Tue, Dec 16, 2025 at 01:28:45AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> This commit introduces the cpuset1_online_css helper to centralize
> v1-specific handling during cpuset online. It performs operations such as
> updating the CS_SPREAD_PAGE, CS_SPREAD_SLAB, and CGRP_CPUSET_CLONE_CHILDR=
EN
> flags, which are unique to the cpuset v1 control group interface.
>=20
> The helper is now placed in cpuset-v1.c to maintain clear separation
> between v1 and v2 logic.

It makes sense to me.

> +/* v1-specific operation =E2=80=94 caller must hold cpuset_full_lock. */
> +void cpuset1_online_css(struct cgroup_subsys_state *css)
> +{
> +	struct cpuset *tmp_cs;
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cs =3D css_cs(css);
> +	struct cpuset *parent =3D parent_cs(cs);
> +

+	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpus_held();

When it's carved out from under cpuset_full_lock().


> @@ -3636,39 +3630,8 @@ static int cpuset_css_online(struct cgroup_subsys_=
state *css)
>  		cs->effective_mems =3D parent->effective_mems;
>  	}
>  	spin_unlock_irq(&callback_lock);
> +	cpuset1_online_css(css);

guard with !is_in_v2mode()

Thanks,
Michal

--hi7obu2hrnpqvu4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUErqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjHCAD/W6zIT4KJZVFTtqCoJXHx
gQBSzimOVhvWoOGpOeOtxgUBALYhxkJe1K9FQWRHYeSUh8XuKbp45LG/eSrSe6bO
IB0P
=mtr2
-----END PGP SIGNATURE-----

--hi7obu2hrnpqvu4n--

