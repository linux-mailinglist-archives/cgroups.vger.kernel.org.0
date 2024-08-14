Return-Path: <cgroups+bounces-4249-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A5951740
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E920D1C22B36
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5591442F7;
	Wed, 14 Aug 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TP2/LV1l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486636134
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626027; cv=none; b=SUZqgshLg+mlCeFUOeTob/ArQg0v3imF/bazxIYpvAH6Jn3uycURyyEr4DoR2/ndZcmO2NYrPXL5VF7kSw8J9kxrb3EAKS0+T+2dxOKOlHL37wuJijbU2zbU01bFOk0fZ76V/Pw9jbUwRSYDSGd8AbU8h1ZkP9FkypsJBph3l6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626027; c=relaxed/simple;
	bh=gXxlIlQ3EOincyEWslqnAwuFuJghTWyOpHUNsqq3XYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK1MedgjuniWSrK1DoMp4XIHhLOxORKhKcdWGjyjJ+GRbUc8L6PGOGVzU8Wc0EmR6msFWs/vz9Bchx4cCW/OqTHt2uF7RSCSu94lr7lKkskGLeIP5636wphqKpnUTQ+stXxmioiqQ5eSvcD4N08H8qrFZ3EHYjxfnILncVDhmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TP2/LV1l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso12428105e9.2
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723626024; x=1724230824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pteG83gVaufdudJefczaWE/asvX/A9MjU7KHPVY3kzA=;
        b=TP2/LV1lDn2J7cQ71i6mZ22oMXlJr36MA0xyPJUI/mPL0/ifZ9DrIFkGaAVqxey7Mx
         LVF4nssshMnYsUcnpPiFs9B9gBBasnH8u/qLa7m8ZpFhW0JMkA4UP3J6wklvzUbf3qQG
         eFhMaj5V+3NVVaAtUAy9m1re46lkvx0ibGUBfXZZyfpnzzJNFG1xMPLgmJi6CYb2cXZs
         SvOFILZzyHAhiPTdTLcMdAYe74vT0+xypeQDODU9Dv8ZVwsc/ZIzhCIMwm0ah34qi8yC
         M1TSc4BXbDBuqQiASWB0HdrrdqnTGaPWXdwP6sDgPsOQTg0pmDRenjALQUkGXRYakwRa
         IsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626024; x=1724230824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pteG83gVaufdudJefczaWE/asvX/A9MjU7KHPVY3kzA=;
        b=rE/BR86XsRdx3DLKYpsPuaEk7gQyX8riLJ7jbVwFFWm7RrxXyRe/GI1DWVpD7MGoTs
         EnvQEt7nM/LivHht05mSZkugORUhHCmE4lYwHWN26Xjbs2sJV4MwfHucPCM20mGHmAVI
         1Qv36RaM07fEmESpL2RXrTwZQIMTCJoU1tLfVUuoGDkmrkn6jzjGswBUMDlAVMmgBwlO
         zKgTMAbzpX+DtgvQqZeTxPuEZ2pKQOqRiq4LO0d4HgWJJSuGN0XJNVx0dY9w67mdHUcU
         I15+9JDMXPsC9vDfD1aBmBNbt+0h8TGPROywUTCVdVcLz9SMjpHc8IqktJUghTz1BX+q
         JsJw==
X-Forwarded-Encrypted: i=1; AJvYcCXgfGcv2WUbBFb7sz2Ihw5ru2KimhrqoPnHxMtdrvRmq88Ha/lkyATVANcGg7GyUBj9bFohAXLxv/KBGp52gDtvfffbS8hGdA==
X-Gm-Message-State: AOJu0YxEFMPTAtv4GyDp48VVTYwsokv44HTFtiU1qxnSm9lNboxuMzvk
	GjAVfsmppeoQrnRymSsUh/k7G4bP9S5zMrdxPdpPo0FuKmZIvo23xcqgRhq0kdg=
X-Google-Smtp-Source: AGHT+IEfaKgysHFnacwzzzTQKgCJVEmQuk0aPxOC7j04talTUiUX34+7xIMMplZhDYBWthouaVkhBA==
X-Received: by 2002:a05:600c:4706:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-429dd2365c1mr16103745e9.11.1723626023923;
        Wed, 14 Aug 2024 02:00:23 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded31e19sm13324485e9.15.2024.08.14.02.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:00:23 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:00:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH mm-unstable v2 4/5] mm: restart if multiple traversals
 raced
Message-ID: <zh4ccaje54qbi6a62rvlhclysyaymw76bona4qtd53k4ogjuv7@tppv2q4zgyjk>
References: <20240813204716.842811-1-kinseyho@google.com>
 <20240813204716.842811-5-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7u5m3mmofm2gmeqj"
Content-Disposition: inline
In-Reply-To: <20240813204716.842811-5-kinseyho@google.com>


--7u5m3mmofm2gmeqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:47:14PM GMT, Kinsey Ho <kinseyho@google.com> wro=
te:
> @@ -1072,21 +1073,26 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgr=
oup *root,
>  		 * and kicking, and don't take an extra reference.
>  		 */
>  		if (css =3D=3D &root->css || css_tryget(css)) {
> -			memcg =3D mem_cgroup_from_css(css);
>  			break;
>  		}
>  	}
> =20
> +	memcg =3D mem_cgroup_from_css(css);
> +
>  	if (reclaim) {
>  		/*
>  		 * The position could have already been updated by a competing
>  		 * thread, so check that the value hasn't changed since we read
>  		 * it to avoid reclaiming from the same cgroup twice.
>  		 */
> -		(void)cmpxchg(&iter->position, pos, memcg);
> +		if (cmpxchg(&iter->position, pos, memcg) !=3D pos) {
> +			if (css && css !=3D &root->css)
> +				css_put(css);
> +			goto restart;
> +		}

I may be missing (literal) context but I'd suggest not moving the memcg
assignment and leverage
	if (memcg !=3D NULL)
		css_put(memcg->css)
so that the is-root comparison needn't be repeated.

Thanks,
Michal

--7u5m3mmofm2gmeqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrxyIAAKCRAt3Wney77B
SYKsAQD5fmVCdF+nm0mGrmT0+x5ogK2m8VCEriQpCK6PmawfwAD/Y5ceRaiYsOrt
WpZ551lbq/yPf1Dnfxl8y42Xq+Ogiwk=
=Q7ol
-----END PGP SIGNATURE-----

--7u5m3mmofm2gmeqj--

