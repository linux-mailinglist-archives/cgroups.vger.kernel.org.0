Return-Path: <cgroups+bounces-12291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF18CADF6C
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 19:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67AF8305A822
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA17265606;
	Mon,  8 Dec 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R+bV8BGV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965A23D7D2
	for <cgroups@vger.kernel.org>; Mon,  8 Dec 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217497; cv=none; b=F6/0dSEgRM2JMRmH5yzQ2YbSvV2NPiKCQv5ukqXxJygGv/mLPc1WAfcSy1+jIjYkIGMxoROLmZLt9ye92gUsct90e/jEmvHIRsKPAgb77AwAWh3hHcy7EhGov1pvRIDMuk1kIMJkirknc7pjK71bwIkouB5rTppenxuzLhWo+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217497; c=relaxed/simple;
	bh=lAVxCtgsHDTISHvy9/P05UNsVuYDEFlartNvwhkv40M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8UQNEnGskEYuHKhB9Us9Z6nTqUq9hKZA4IaDbVth8zi+o7NZUv3sXtcn1ZkN5hLF+NmLiLJedoeIrkNDJhIgZp13gszXKeu+KBf+7vwYrdBOofBJXyZX3PGxdEosO4TsFvlnicG4m+1ptSJ3bPE3ZlXBOUiTnjeLtqnaxfASOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R+bV8BGV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e3c3a83so2165156f8f.1
        for <cgroups@vger.kernel.org>; Mon, 08 Dec 2025 10:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765217493; x=1765822293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAVxCtgsHDTISHvy9/P05UNsVuYDEFlartNvwhkv40M=;
        b=R+bV8BGVkHVOy2wVonfG6b+DApZd2HFIu1RuecRpkGqBd6hHEwQbRdYWb3ZQVE/Rmt
         DABHV9yoz/QS1Md/E2kBDpegggmFo+fGkfjUUAWe0BYfLi/8amQpmzciBTvrVTdZfBnv
         xCWLIwWOi6yzS+mQnI2x9UUddRZubEzCTkKsBtlRlBfpgfwn9/gauDtvYSuRkxWSwtbd
         jBNIHUSMI8oJjGtdGFyJKURScx6HTBkUbE7nGpdhunAvlgK2ZIm+j8dC662V0vmZBwo/
         lwcFt26BBB2hBH5o53errsfNljolO2fXmFB1m/c9SEDzMqS7Y2tWYeJwkQ/jvnVx71a4
         NgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765217493; x=1765822293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAVxCtgsHDTISHvy9/P05UNsVuYDEFlartNvwhkv40M=;
        b=jJfJ+gjs6mxdefqKkN8MYmcB1pttn1oHHj8k8Sdd8lLPUj+xh5aNgdg74SZNnH4epB
         MmIBaKJUBYVR3qQ5UEY84qfXjuId61ZzrA45/a60/LHADgEIBUMxtOvv+SuRrrwlMMwa
         AIP8esNezFeJrJf8gMR7uVs8LdyeuSOdFnHOZzwlFlZoPi6PzrlNLBUjmCsrmh07GwC5
         FKiFRTXj+Y58g3s81hqFU5PQ+eyWTlz1TgA/ARKL5/L274j3NBjgS1yNMCBiOZxPeNSI
         QCz0Zb6cn9/tjiJupnGAKuLvlJXUvxyL4itkmQD/5rNPoob8AnyeabbrVUb8Jp8ksYav
         0fRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsuzhx/Ny1DMHV5ZGJacKBxWiu9TZrVZBl/+yxasswtD1pjsXIgs1cSc1IUhY0BqpZv2ngtxKx@vger.kernel.org
X-Gm-Message-State: AOJu0YyjA8wtb1BbnwTyr/Tfk4lqVtRoh6lzaNKtUi48vqPSgZ1UEFnw
	ThEuUevSm1bGNmAI7MrzKRarAfhadLPE3ZkbNqaA05sWtA2jPMCOJ9I0U/h8MY8uyP8=
X-Gm-Gg: ASbGncvXzzzYYuUB0RvaQaYAgzXu7mSdMCCqSjFY4S7dbDBhRiNX0yqNDmpY47Gz8Js
	A5UULkEdiKU/4/B1ybgnelAH7hVMAvON1Tcyp+K+6bhqUGE82oSEZLupFMtfdKNtdt/htPbdpbe
	xT/PaNSshEoYemuXrqrdFouPMxL6hdFnhweZ4tYmgytiJZuiutlbcFrn0w3xQgaxdYZz2JkWDGa
	JWaUpGo9Ec6WevWk+7HKKC4qM3Iy+caXitu49kX+TAwNJGij50GV/gEN5xWZA/Hx7xwFEKoxTx4
	mTUiv7AZiSqXkLtzT51esFZgtbjqxsgyg5y61JMdmHLN5mVYjnXHsFGUzZZghR+PkE8U7hNKm1g
	V7OmoblyEJk0q5kjmaG/dp5AbMZf6yFy1iozhcbSoQ6iMYmghMR1qtl/LQAlixykkSPG8ooaF2t
	kxagJTJY2Q+64Po3Tni7veaARzIeRCdF4=
X-Google-Smtp-Source: AGHT+IE+2cVlYAMMuUHrQ6cEon/NMQFTDjniz+P5clfRxxL6UeMGxUZ/BfmxJjmjGXBtngb+pB63Gw==
X-Received: by 2002:a05:6000:430d:b0:42b:55a1:2174 with SMTP id ffacd0b85a97d-42f89f70f4emr9230131f8f.59.1765217493354;
        Mon, 08 Dec 2025 10:11:33 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm26981207f8f.17.2025.12.08.10.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 10:11:32 -0800 (PST)
Date: Mon, 8 Dec 2025 19:11:31 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Message-ID: <rrpswcxeciypobup7rdwvjknnsjkcnov2xdabbfng7se5yihk5@4wayqftotykw>
References: <20251205200106.3909330-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xxdwkhj7rhflr6ss"
Content-Disposition: inline
In-Reply-To: <20251205200106.3909330-1-shakeel.butt@linux.dev>


--xxdwkhj7rhflr6ss
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
MIME-Version: 1.0

On Fri, Dec 05, 2025 at 12:01:06PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> On x86-64, this_cpu_cmpxchg() uses CMPXCHG without LOCK prefix which
> means it is only safe for the local CPU and not for multiple CPUs.
=2E..
> The CMPXCNG without LOCK on CPU A is not safe and thus we need LOCK
> prefix.

Does it mean that this_cpu_cmpxchg() is generally useless? (It appears
so from your analysis.)

> Now concurrently CPU B is running the flusher and it calls
> llist_del_first_init() for CPU A and got rstatc_pcpu->lnode of cgroup C
> which was added by the IRQ/NMI updater.

Or it's rather the case where rstat code combines both this_cpu_* and
remote access from the flusher.

Documentation/core-api/this_cpu_ops.rst washes its hands with:
| Please note that accesses by remote processors to a per cpu area are
| exceptional situations and may impact performance and/or correctness
| (remote write operations) of local RMW operations via this_cpu_*.

I see there's currently only one other user of that in kernel/scs.c
(__scs_alloc() vs scs_cleanup() without even WRITE_ONCE, but the race
would involve CPU hotplug, so its impact may be limited(?)).

I think your learnt-the-hard-way discovery should not only be in
cgroup.c but also in this this_cpu_ops.rst document to be wary
especially with this_cpu_cmpxchg (when dealing with pointers and not
more tolerable counters).


> Consider this scenario: Updater for cgroup stat C on CPU A in process
> context is after llist_on_list() check and before this_cpu_cmpxchg() in
> css_rstat_updated() where it get interrupted by IRQ/NMI. In the IRQ/NMI
> context, a new updater calls css_rstat_updated() for same cgroup C and
> successfully inserts rstatc_pcpu->lnode.
>=20
> Now imagine CPU B calling init_llist_node() on cgroup C's
> rstatc_pcpu->lnode of CPU A and on CPU A, the process context updater
> calling this_cpu_cmpxchg(rstatc_pcpu->lnode) concurrently.

Sounds feasible to me.

Thanks,
Michal

--xxdwkhj7rhflr6ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTcU0RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ah/WgD+KoG41+NA0shwqndSMfLf
NKaf3TLNxpT5rbMR72AmSkIA/0gUzIXL2v+ADYvYPkK/71qUo+l1A7Ki6u8nCkZi
f5gN
=Aghw
-----END PGP SIGNATURE-----

--xxdwkhj7rhflr6ss--

