Return-Path: <cgroups+bounces-4948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11A9865EB
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856A01F256DC
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27ED12B176;
	Wed, 25 Sep 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b7/BO43y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D214962B
	for <cgroups@vger.kernel.org>; Wed, 25 Sep 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286417; cv=none; b=XpsdlSpZWALFo/B1cqqRqPDDpwMl6KmAYY1UvJrTa5IlZ+GmrVbV79v03aUPGejZUPZWIYyppwBj0YVKKfKAtdkbRAkC31/jJXqhB2VONJBqdvXnkWi8vNlufYL98PhW5f1FjkwplyAcBHhCJNKBWQinAVbu3jb8c/Pzn+wBIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286417; c=relaxed/simple;
	bh=0cJiuSaHLjW8zYIryHFxfyf6Jc2GEXPEis6plAr88HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2xgK/HSIsQlQsa2fhnjZBWWmMXm0e+BhFQl1GwAB/ESSPSZb7ca53KjUNQdUlyQRnx+eHXCJl+t6L1uhIAj/6MKbq0TPXpIVSKh5XRpbyj0uEOu7YnRWcHnQ5xGQNrekCYiVY0Sf76DeEPhAICQEDXhl69haTcZP9WvYcz//ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b7/BO43y; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a8d60e23b33so16349766b.0
        for <cgroups@vger.kernel.org>; Wed, 25 Sep 2024 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727286414; x=1727891214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEP8vRBLzyHsoHKbcOs5cEs2gKA5aD96CPEST9Jmp4I=;
        b=b7/BO43yAHpiJNRnM7fbr3BV9chK/HZAVnbuYRRTC+bVIhGG1LKrl5DgsOt+tcHTOl
         GnvT4gkCjKwB6Ry/GqJSm6sIlYv7PNV7V3H7r9O5ZXQ8YgZ63+kfjo5rG2M8zvmJAbao
         tcPgkLG/HnRKNIBj/AXYBPi3HFYz88YQBFmYrfBur51HAQ05l654TI8jJp/OA8A3UFm9
         yetZSb4QvDC+8wu2u9RCet2lzKBN1R7VP3MQcgOTQO06vdPFxqDS71ZCqlsyTqmMiG/m
         q/JiNIctK6xcNw5V7H7T+m0nGaW/9cZ8XpcGaCj21ubjKZpRpY9U/cUigTRpfgovSAep
         GMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286414; x=1727891214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEP8vRBLzyHsoHKbcOs5cEs2gKA5aD96CPEST9Jmp4I=;
        b=sDoDaRlGIi2JCJ38wqCJvJstUYqzFeaxCAP2X6+NbowhbR2yyDsW518+q2wL7n7npb
         wXl2HELSxjClauHqj9kSWkoOUiYt0A+q0K5xUOzt6TIdvSNpHSWGGqHOVom0+OwIgc2b
         nwKwiFUFcN5/Ik2GLuQGRL9svcSRExnmXe/EWSQj1UfemAoxtghjkxP4VoEKqFTlV87Y
         yb1gtbmvwvfnR4QZz3aa5xO0dd8ymQL5L9tWvMHjpi6l23/Xet/lV9wTKX+5HnS1JbC2
         CNtk/wJPcaSM1M267va/I2+WDFtnB1OBAXLfb5MKUnf2DyNnfOO1ocRvibzULLAxYrVd
         Nbuw==
X-Forwarded-Encrypted: i=1; AJvYcCUoYDuds7Ozajj0itfI8lsSK+5JD5aDGdZ6IqMVyLyMg1beULJgY9NuvPHFrxrAE+bEfb7LnH0R@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eVKtes3ZQXkDb8S9jQwr7QxWlO8etxgjs5od91ozLnUbaBxg
	sMmFV7RbymDGpDb5LrF+iw8QBmS8pZi3HgZzVNEBFQ7PAv+YfgXv+s8qycs+1xI=
X-Google-Smtp-Source: AGHT+IFvS3zxUqhHTUHEBU+9gvZZiGo1tqJCqlGxyabmkeoNwWmh93XC4JI5Ou//T7dY9RwBvhi4Ug==
X-Received: by 2002:a17:907:1c1f:b0:a8a:926a:d02a with SMTP id a640c23a62f3a-a93a05e7ea0mr314011966b.49.1727286413632;
        Wed, 25 Sep 2024 10:46:53 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93931347e4sm234108366b.194.2024.09.25.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:46:52 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:46:51 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, guro@fb.com, 
	cgroups@vger.kernel.org
Subject: Re: [PATHC v3 -next 3/3] cgroup/freezer: Reduce redundant
 propagation for cgroup_propagate_frozen
Message-ID: <7j6zywvbd2lavlj5wc3yevc4s7ofrusjlpwcmuchhknlhp2mxo@77rwal3h2x65>
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <20240915071307.1976026-4-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mo7qcledrcidh3j"
Content-Disposition: inline
In-Reply-To: <20240915071307.1976026-4-chenridong@huawei.com>


--2mo7qcledrcidh3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 07:13:07AM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index dd1ecab99eeb..41e4e5a7ae55 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -401,7 +401,9 @@ struct cgroup_freezer_state {
> =20
>  	/* Fields below are protected by css_set_lock */
> =20
> -	/* Number of frozen descendant cgroups */
> +	/* Aggregating frozen descendant cgroups, only when all
> +	 * descendants of a child are frozen will the count increase.
> +	 */
>  	int nr_frozen_descendants;
> =20
>  	/*
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index bf1690a167dd..4ee33198d6fb 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -35,27 +35,34 @@ static bool cgroup_update_frozen_flag(struct cgroup *=
cgrp, bool frozen)
>   */
>  static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>  {
> -	int desc =3D 1;
> -
> +	int deta;
            delta

> +	struct cgroup *parent;

I'd suggest here something like

	/* root cgroup never changes freeze state */
	if (WARN_ON(cgroup_parent(cgrp))
		return;

so that the parent-> dereference below is explicitly safe.

>  	/*
>  	 * If the new state is frozen, some freezing ancestor cgroups may change
>  	 * their state too, depending on if all their descendants are frozen.
>  	 *
>  	 * Otherwise, all ancestor cgroups are forced into the non-frozen state.
>  	 */
> -	while ((cgrp =3D cgroup_parent(cgrp))) {
> +	for (; cgrp; cgrp =3D cgroup_parent(cgrp)) {
>  		if (frozen) {
> -			cgrp->freezer.nr_frozen_descendants +=3D desc;
> +			/* If freezer is not set, or cgrp has descendants
> +			 * that are not frozen, cgrp can't be frozen
> +			 */
>  			if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
>  			    (cgrp->freezer.nr_frozen_descendants !=3D
> -			    cgrp->nr_descendants))
> -				continue;
> +			     cgrp->nr_descendants))
> +				break;
> +			deta =3D cgrp->freezer.nr_frozen_descendants + 1;
>  		} else {
> -			cgrp->freezer.nr_frozen_descendants -=3D desc;
> +			deta =3D -(cgrp->freezer.nr_frozen_descendants + 1);

In this branch, if cgrp is unfrozen, delta =3D -1 is cgrp itself,
however is delta =3D -cgrp->freezer.nr_frozen_descendants warranted?
What if they are frozen empty children (of cgrp)? They likely shouldn't
be subtracted from ancestors nf_frozen_descendants.

(This refers to a situation when

	C	CGRP_FREEZE is set
	|\
	D E	both CGRP_FREEZE is set

and an unfrozen task is migrated into C which would make C (temporarily)
unfrozen but not D nor E.)


>  		}
> =20
> -		if (cgroup_update_frozen_flag(cgrp, frozen))
> -			desc++;
> +		/* No change, stop propagate */
> +		if (!cgroup_update_frozen_flag(cgrp, frozen))
> +			break;
> +
> +		parent =3D cgroup_parent(cgrp);
> +		parent->freezer.nr_frozen_descendants +=3D deta;


Thanks,
Michal

--2mo7qcledrcidh3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvRMiAAKCRAt3Wney77B
SQtPAPwJ/3CUMPiK0ylsiumLqJ8YE0Hq7cJiUqKVdFU4u+G4igD+LXTWjchM/JiY
i8Tc+ajNJzz+it/eVCPn0Txz2T4DAQc=
=ZAAK
-----END PGP SIGNATURE-----

--2mo7qcledrcidh3j--

