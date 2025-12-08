Return-Path: <cgroups+bounces-12292-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C384CADF87
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 19:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2DC830141DF
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD34279DB4;
	Mon,  8 Dec 2025 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gTkqLDQM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC271DD0EF
	for <cgroups@vger.kernel.org>; Mon,  8 Dec 2025 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217754; cv=none; b=rBLPuCWdtABvteOqnGxIKmwljRlRT0zjsolgEc2l0eOE5Z8KYChaX4+fEcBAXjk79yNVO+eU3iI8/qth/Ret9mIhAMZtj262cE02nv+IMJDOogR6rJgW8d35oNbx+YgOK4kLCxA1uC0rDf4X3N6s2tnZmI62vAQfLz7qySV65cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217754; c=relaxed/simple;
	bh=POy9j2glOCHn2z0XuLaCsaJ6K4oxeo6DA/EsY9wn9Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/VoHZ0HMCjIbMvE/dEVg5xj7uzwkolKcPo4UI7GLP+mcyfFwjQTboJsst6JWXatTvucLHNkEk4WeTbrpUZ2LInyjWuvjOnHZV8s2SxSXrLL3Zap7qp+A8Sfp9K0+aNzHzsAAfFIZ22C+ZC5gF0Pfdh5xEj2GaGVirJV8OuDVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gTkqLDQM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so62447365e9.2
        for <cgroups@vger.kernel.org>; Mon, 08 Dec 2025 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765217751; x=1765822551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8J43gCwQQgVAiJUJZGTrDPf/rsilcNMXDG/0Q408jc=;
        b=gTkqLDQMbAQRBPivWPrdWcmv2kwAlPbI9YUD72B5aUEplDYSS4PE2jRpILEWMmhAYb
         bp+PoBSH6LWMWSOlgzYVOhudXbvf+VEz7Ff1DcDThiL/9Cpnah4q8SRS5sTGX1sywLf2
         J0GsQATp9N6KEpQLlkfMb1LRTfZ1QyV4jtbiuZxakyjm2lTBwUgwqeTpWi2T/sqIq0vH
         2iyZOyQJKAzXa/F/eDxGvrVRfpqmt6iTAtBxus9ib4sJoumBRi6c/zWujiBTqA7i0wYw
         WLCN+kwc2ACtx0lTYz0Sif5he7xV2NFH5gXJPwyNo29l4P7xsbzvP+/z7Q3kdCZ/HWRW
         3vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765217751; x=1765822551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8J43gCwQQgVAiJUJZGTrDPf/rsilcNMXDG/0Q408jc=;
        b=CbawZXak8FKgbzQMgL0ywSj1SM6IAyJhZ7vpX/VVgxSPm4zZ4vDMF3GE6Uqolw5lMG
         ksBszbbVVx34sh8PS54qxezvfh2UqgynqcspWTvYkivYEKmvPqbjrRMs7DPnm9n/5Sko
         aVvFC3/ek5/HRG0HFEnvgpM0wj5G/jOz31IfShZvZn/brDkTYbKoYnGCQisocvu/N+93
         5VxQKc6Qxr8lyRtzJV5zgd5E7+h8tyDoOeKV5GvsCLPpwr86A65vmOEhuJlvOiMUh0TE
         vnyUQf+7kf/LpNaeXDTgB00koILGyWzmWwDlp7UFgY93ojtSCpuMl1O3uJm3FMlzH9mH
         pTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHLbmbAqfwQrlbTo4dbYk5BO956IQopzXXniApC9jKdg1mgQPSqTbw//XYrxDGgicKKtyDo1YZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuojPXHpw+8C7hINWFRqd8suusTaXRd5/t7L+IWpebMT5NtHVW
	LXFuLWNf0oGXrZE0cMEnw+1V+UMW+g9yM8XsbjF5uQTa8uNktEO6E15qWsluEzM+Phk=
X-Gm-Gg: ASbGncu6So7bW3WzIwF+pGxcZeuGPqOE+p8+xoccgIqHuzi7rsjk7gKJtL/9iyj9jVs
	rB8ihz/RuhpZK8MX1cKtejhw9TmflshSkIEALykBPm6WEEb6DMVpV5lrVT+Gcruka3HNK1KQ+9p
	cd6w23OO5W/wvD7W5ASUnEsD8p/kuDRo4z6s/FwP7g99PExn2r1lOQv2TWXoedS5fBu0lXnDlgG
	LcqkMCZ52dMgeHmmFYaMc2rrivqR1bPEtwoO0uiZZ1VKKpIQXfMKP5QtqVO+Ypf4AYDPgWO3DVJ
	Vc7yw7mEE54ybQvEedr7lQZxokxwuYYKjltJB3DeEdeeh8ffOf5AW3MAPqCCeG+fpbqhuITc10W
	zlpdad+9xqR/42ZdgW5h+Tx8NOgYq5lv566mT0PyUyd9+tyiF/bcGfJcJFMd2pxpzEWSkJjNolz
	h7X/880rsYiK5uyKdSw0CVQkelRNaZCBo=
X-Google-Smtp-Source: AGHT+IEt36ETzJErLHmXOiRn3Ib/UQS4igGV7/dPjeHWIxOPurlffSBsz4CtRRk4uiSDBZs1fMFwhg==
X-Received: by 2002:a05:6000:2f83:b0:42b:3ace:63c6 with SMTP id ffacd0b85a97d-42f89f0c50emr8583747f8f.16.1765217750626;
        Mon, 08 Dec 2025 10:15:50 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm26358878f8f.19.2025.12.08.10.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 10:15:49 -0800 (PST)
Date: Mon, 8 Dec 2025 19:15:48 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Message-ID: <okpn5az3myvmz4amfkhyixxzb3zemcm23omfqzggbp2vr4jnsl@r2rdp4xmbsfz>
References: <20251205200106.3909330-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qwow556tghczrm2t"
Content-Disposition: inline
In-Reply-To: <20251205200106.3909330-1-shakeel.butt@linux.dev>


--qwow556tghczrm2t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
MIME-Version: 1.0

On Fri, Dec 05, 2025 at 12:01:06PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> On x86-64, this_cpu_cmpxchg() uses CMPXCHG without LOCK prefix which
> means it is only safe for the local CPU and not for multiple CPUs.
> Recently the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
> safe") make css_rstat_updated lockless and uses lockless list to allow
> reentrancy. Since css_rstat_updated can invoked from process context,
					be

> IRQ and NMI, it uses this_cpu_cmpxchg() to select the winner which will
> inset the lockless lnode into the global per-cpu lockless list.
   insert

>=20
> However the commit missed one case where lockless node of a cgroup can
> be accessed and modified by another CPU doing the flushing. Basically
> llist_del_first_init() in css_process_update_tree().
>=20
> On a cursory look, it can be questioned how css_process_update_tree()
> can see a lockless node in global lockless list where the updater is at
> this_cpu_cmpxchg() and before llist_add() call in css_rstat_updated().
> This can indeed happen in the presence of IRQs/NMI.
>=20
> Consider this scenario: Updater for cgroup stat C on CPU A in process
> context is after llist_on_list() check and before this_cpu_cmpxchg() in
> css_rstat_updated() where it get interrupted by IRQ/NMI. In the IRQ/NMI
				gets


(sorry for another mail, when I read it I noticed those in a different
buffer that may be applied if you decide for v2+)


--qwow556tghczrm2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTcV0RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ag1bAD8DcVIeicwScrrr2qtm+AA
jyCckJM/q3WC/BusHmg8lhcBAP4FV0SLsim3T7JWzj8yc21NS+nT+TMN99yeRx8w
1AoE
=+If1
-----END PGP SIGNATURE-----

--qwow556tghczrm2t--

