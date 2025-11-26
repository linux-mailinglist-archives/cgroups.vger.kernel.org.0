Return-Path: <cgroups+bounces-12218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328BC8A401
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1A454E9235
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951D2E6CC7;
	Wed, 26 Nov 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ow+WSYzH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FA2D6E61
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166400; cv=none; b=j43q4uu5g56CSl7WOGr0BoU3PxXaeLnftTSP0bF97KMtL5Q76CW/5Xu+AK27xbEkSI098gfd6OqZJWbfnQZXvx085/i12yeBqjhyhloykXzcfs+psFRGFlsYWvJHcugEWjpzg6YF7k5pEWkjKD9vxrFZ0WMooULno/eIjUWuKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166400; c=relaxed/simple;
	bh=96w/vSZov7cBrj27bPBTT7wqoYkKqeoQGU3Tn1tHPEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3M/pOP8EbBZxxorhTGmMeyWl1+L2JZ8Xk5CwWBFGhs9FX+/EbdDhQWSt3psJPK4lVD6fseoU365byQJ7jnn5N1S/ukzrlZZWq4V63USbHPEAesZLfrA/Ghv/73xkAo9ZA3P6k5y0PDbYmAc+H53LDW3YWk768h8dhZJsXOktPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ow+WSYzH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so6672765e9.1
        for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 06:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764166396; x=1764771196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYJtSYn0sTnnUNyC2BpO7YwdsARB7tsY5WZqK7dpiQk=;
        b=Ow+WSYzHbqkoIHa8p0X9uZbqXC44mDTiwUq88u6HURWsw97/3oDfqLUdeU/oDvPsra
         QaakW9VpeAKzIpWKrXzsrpF/uN5gQT5IIClI+ZJqW4tw03CHIX6tjl83mKG7/RF6iNxr
         SqBBG0DPTYkTSKjKqyouV2YlO6Oj8RytQyPxU/70uCqetFENKOYAL2E90b6+acttcmsV
         xb080dP68YlRcNUcV6z4hFS4loz7ZRIBo3rfyhYHs+Vq4pXaD2hTpiE0taCZrCUbPnaV
         wRNpbKg2lUBreddhiEuzGJVMf16kgZnJNP40PRkDPotr7VxLRw0cvIxa0+HgWRaqtIzU
         z0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764166396; x=1764771196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYJtSYn0sTnnUNyC2BpO7YwdsARB7tsY5WZqK7dpiQk=;
        b=Mm1YQjbJ4rqP9i5XvdctGZzLwVBR/h5gOsI+QlvIH22CjXLl2bsWBRXdhFemmcEqSz
         kI3MEb35+2qfQLoq9Ag+gvE/puGhoW5AWn8teC/jfyNn/idy7XikpWkgfLP2ntNPq2ju
         wYNskTXCaEA8NY0q4142sW/GQIRRI2MFde4g3kBAFBIrA165ShMgpwueqZxoxurgUDzc
         TszrS8EWpqGbpo25FMaSiYrwyiXo/uM130RmZS/90IrqvNAbUvhsojCLHaDptegT8rAN
         RR22BqEj1WUY2Kkef3pw/zHkSIaD8UFNaovZ2qavTObFztiCqr+fCQu2Ls3T4HVGJ4Z0
         ypnA==
X-Gm-Message-State: AOJu0Yw+3ipCibqtwBswefDgY4GSx87afoyMt3FkgnRYL90RrgVw8k0/
	GOCYnHOosdR4NiAihhh5Umlpu74FVJYKCPweQ+G5q8HCDkDfqhEqEHhyKh/DD0r8JVw=
X-Gm-Gg: ASbGnctfrKGbKT/wX+0wbajO4r5gid8CyiuJ+7orPH6EdIol9dP4lap+XyuIxcoc9Wt
	JdGbHu6cFLNvAz0rMteLhT8usYg4dnAif6MosvnEwy80LS22TfqU3lhy3MdVwxSzwYLXlxnGPrz
	hHA2gqx01z9wEVvu165QNiClFpGKZby8VYYJ4f21oLxZYmaEm16lkxSHSQl7LpVohiTKarwikt0
	ALArCdAELpKNzeSF+FfuGESE3EakVyroIM55vVyE4D0yZ3FO4g39gTt9njWczGuI0Eor3jc6LBf
	/fjAZwAwcVPcj3d9X2KnojI4AhvR0ecpH1g8eQK9LxXnDRzUfb6iQjs3curt66Fn5xsi/jLysg0
	LR/0tIWG7XaO+4XxeFMsPhlJBrCEHz4ReiptYtMABf0kDh62fhI/Ne3+pq9ruymYDPPusBgsrDZ
	oIuh8mRtWsXhfncDt3vWUC2WOJrv8X0fs=
X-Google-Smtp-Source: AGHT+IEYHWFRx27gpi/36olBWtedpbGYH8f2uhXyKYy83An6nNQGkpIHvG2lTLE3HsaeDBVFKi63HA==
X-Received: by 2002:a05:600c:4685:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-477c052f04bmr209223545e9.13.1764166395978;
        Wed, 26 Nov 2025 06:13:15 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040d3c72sm45217325e9.6.2025.11.26.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 06:13:15 -0800 (PST)
Date: Wed, 26 Nov 2025 15:13:13 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llong@redhat.com, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
Message-ID: <nfg4xqeoa4qqz7xypddzj756jhlsieeqfnpgvzwsltb7lnqz57@qgatuaufa7hq>
References: <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
 <20251120130557.1554118-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3o3p565py2noybuv"
Content-Disposition: inline
In-Reply-To: <20251120130557.1554118-1-sunshaojie@kylinos.cn>


--3o3p565py2noybuv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
MIME-Version: 1.0

On Thu, Nov 20, 2025 at 09:05:57PM +0800, Sun Shaojie <sunshaojie@kylinos.c=
n> wrote:
> >Do you actually want to achieve this or is it an implementation
> >side-effect of the Case 1 scenario that you want to achieve?
>=20
> Yes, this is indeed the functionality I intended to achieve, as I find it=
=20
> follows the same logic as Case 1.

So you want to achieve a stable [1] set of CPUs for a cgroup that cannot
be taken away from you by any sibling, correct?
My reasoning is that the siblings should be under one management entity
and therefore such overcommitment should be avoided already in the
configuration. Invalidating all conflicting siblings is then the most
fair result achievable.
B1 is a second-class partition _only_ because it starts later or why is
it OK to not fulfill its requirement?

[1] Note that A1 should still watch its cpuset.cpus.partition if it
takes exclusivity seriously because its cpus may be taken away by
hot(un)plug or ancestry reconfiguration.
=09

> As for your point that "the effective config cannot be derived just from=
=20
> the applied values," even before this patch, we couldn't derive the final=
=20
> effective configuration solely from the applied values.
>=20
> For example, consider the following scenario: (not apply this patch)
> Table 1:
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member      =
 |
>  #3> echo "1-2" > B1/cpuset.cpus            | root invalid | member      =
 |
>=20
> Table 2:
>  Step                                       | A1's prstate | B1's prstate=
 |
>  #1> echo "1-2" > B1/cpuset.cpus            | member       | member      =
 |
>  #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member      =
 |
>  #3> echo "0-1" > A1/cpuset.cpus            | root         | member      =
 |
>=20
> After step #3, both Table 1 and Table 2 have identical value settings,=20
> yet A1's partition state differs between them.

Aha, I must admit I didn't expect that. IMO, nothing (documented)
prevents the latter (Table 2) behavior (here I'm referring to
cpuset.cpus, not sure about cpuset.cpus.exclusive).
Which of Table 1 or Table do you prefer?

Thanks,
Michal

--3o3p565py2noybuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaScK9xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjlCgD8Chru8eEJcO455E6x5OIy
03805uMmppnAHExEHc0rYrUBAJ3MWb9RiNR2/Iu/XaNBQkl5LklsCdnu3Eo9idTS
HB8H
=8VGV
-----END PGP SIGNATURE-----

--3o3p565py2noybuv--

