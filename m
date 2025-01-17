Return-Path: <cgroups+bounces-6230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85777A155B7
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B67188D48B
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDF19F495;
	Fri, 17 Jan 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E4wCnFGj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F9725A636
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134970; cv=none; b=goKuf4Md/ZscHVc2qj62Ug/9WFgXHfRfl4ZF1dCi0XEGFkftv5K/Bk2KUhOGveiz1jJPeLdbW5Ct051UZVS7Ats3E88TRnzfsg1SbG5TaIbKf8wyp4NY3ab0tiYlneLGpiAiIbPePUva3oJoU/csIcUYCex17mKO4A96u4A6neo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134970; c=relaxed/simple;
	bh=CKOLl1ci2veAiEIeBmdl6Gx5POAz0SNektA/2B0Jfi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP/1+TzHnG6HPSmSj7/TzbPnddZyIu0+dkzoxzc4P0WT0P6sxQN/Rx0WYaAfGGjjKx5asXXXDcJ6n/0UDcTyK7AcTrsF5AVtvRrbVH4A4UjMfaFfHaEff/ldjuFTjF6DhpmTpyPhSyNovIuRd3XkLQ7iupb56pqmQJt+gSXmuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E4wCnFGj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436202dd730so16446895e9.2
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737134967; x=1737739767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsXeTDpN3LmohLv7MAiOIweQD1yeDmykm13NwCHWMEg=;
        b=E4wCnFGjRykphZGTIVk/kYMH2stCx/I3wJOQnwhOsC7ojK7UNzzMtK3rT7Y1z5xvy4
         tSlFaccUoDkJ+4J9LhZo2OvDWb3BGI1angmRuqzCOaJfjHocQ4kP2u0GjgnuDn/YyJJ2
         HMKRtvxAmVigcrAxj99TMBI8JAdD8l7+qtgxopXwyqFEzIVRQ1Uz6GujrybyYd0/VQ82
         6aeKbNRPFWY6z6w/b8X+ppcrUtSf6NBv23kzSW5Kvhm5nfGfgt/GGpcUyMTN5ajOsUIQ
         8zhB18JU5IJbMDUT/Cbk+bC7PA0SHuxFaFDW5REj72EpmckbfC0l/TLIKe0uB46kFW48
         3V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134967; x=1737739767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsXeTDpN3LmohLv7MAiOIweQD1yeDmykm13NwCHWMEg=;
        b=k405NNqHPhUIZpzUZJGGaq2Gt0umpOlb66FKgcnL8iJ7OObjXOp6Y4Q4aPe8MoKZDr
         kb43gA6pzzZlBv51Pqr4vtY5cx5gqQwJSUZAFcSun0645AeI8aEozXTJe0j2wF01qnYr
         Itbcd1gj4j0sPI5EvxHcpNJ5/yoZ9cJDBxPJC7Wz+LGUxfUeVaTd3UiXzICQXLOA/gPY
         4yhJb7Pbiln2Wr3seGqgu2X2IEbC9SMIsXx/m5qg0jiatodS2+RQZd8NVPIRa1f+/wTP
         3yUz9kGMaHvleuoUOsF+gsT1mZQ8Pa2TSEU99DELvnMdrUmBXXp4lnIv/cvz/aqWGkMs
         4Q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9wpD4gYBrws4hK1rzuRPxDlij0kmdnSboc57wY7MLamWLImYT9UYUCtanKSE9wuO1COa8bRje@vger.kernel.org
X-Gm-Message-State: AOJu0YzILTnKpNz49lhN/3IlKTUrs0oBWyq5P5qqbO4b6Bszigfywhp3
	oleXzlgA65kjmocXCjNLbfdsZ5YTZcJHH1B6D4dbFnP8YYNjbhehsRegReEFLE8=
X-Gm-Gg: ASbGncvLM246f0kQ+lsO1erHPE5AR28Bui1MAME9bEhnZUSZkVEJ3vRa7tKe4lr77xp
	wWCQC3AICiJVIBXlrnCykHyCxLXATh8oSta+in+nxisw0eXQILRe058lSMimOhWzhTT7SghpWMg
	ctbZIDIdhF4rt1n6jA/4vQ4KagVLIzvv7dkGi7IXZYbGTI5CweIQE+js4Ddy9JCxyTS4wa17d1Q
	wFOWzjUVI2ojKEgPBmRDKyEbbvMejee+0twRtbvFxRpLe8b7QLQ0fSv4pQ=
X-Google-Smtp-Source: AGHT+IERF4iHOHPcbM5nuH3FJfAV1BNIQj1Wcp7xUmZ3b+laxqzqes1j3Dh3jvwp9n1JkYnyhv16EQ==
X-Received: by 2002:a05:600c:3542:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-4389145137dmr31233705e9.25.1737134967041;
        Fri, 17 Jan 2025 09:29:27 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ace90sm101507705e9.16.2025.01.17.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:29:26 -0800 (PST)
Date: Fri, 17 Jan 2025 18:29:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
Message-ID: <oe3qgfb3jfzoacfh7efpvmuosravx5kra3ss67zqem6rbtctws@5dmmklctrg3x>
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <ijjhmxsu5l7nvabyorzqxd5b5xml7eantom4wtgdwqeq7bmy73@cz7doxxi57ig>
 <4d6ccc9a-3db9-4d5b-87c9-267b659c2a1b@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7hm3w7xjc6ubac3y"
Content-Disposition: inline
In-Reply-To: <4d6ccc9a-3db9-4d5b-87c9-267b659c2a1b@gmx.de>


--7hm3w7xjc6ubac3y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
MIME-Version: 1.0

On Thu, Jan 16, 2025 at 09:20:08AM +0100, Friedrich Vock <friedrich.vock@gm=
x.de> wrote:
> These pools are allocated on-demand, so if a
> cgroup has not made any allocations for a specific device, there will be
> no pool corresponding to that device's memory.

Here I understand.

> Pools have a hierarchy of their own (that is, for a given cgroup's
> pool corresponding to some device, the "parent pool" refers to the
> parent cgroup's pool corresponding to the same device).
>=20
> In dmem_cgroup_calculate_protection, we're trying to update the
> protection values for the entire pool hierarchy between
> limit_pool/test_pool (with the end goal of having accurate
> effective-protection values for test_pool).

If you check and bail out at start:
	if (!cgroup_is_descendant(test_pool->cs->css.cgroup, limit_pool->cs->css.c=
group))
		return;
=2E..

> Since pools only store parent pointers to establish that hierarchy, to
> find child pools given only the parent pool, we iterate over the pools
> of all child cgroups and check if the parent pointer matches with our
> current "parent pool" pointer.
=20
> The bug happens when some cgroup doesn't have any pool in the hierarchy
> we're iterating over (that is, we iterate over all pools but don't find
> any pool whose parent matches our current "parent pool" pointer).

=2E..then the initial check ensures, you always find a pool that is
a descendant of limit_pool (at least the test_pool).
And there are pools for whole path between limit_pool and test_pool, or
am I mistaken here?

> The cgroup itself is part of the (cgroup) hierarchy, so the result of
> cgroup_is_descendant is obviously true - but because of how we
> allocate pools on-demand, it's still possible there is no pool that is
> part of the (pool) hierarchy we're iterating over.

Can there be a pool without cgroup?

Thanks,
Michal

--7hm3w7xjc6ubac3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4qTcwAKCRAt3Wney77B
SXjDAQCncLM/XCLLSWKy6chCwIjuq/y0pPpusJ/lNYAoUxKz/AD+KrmKYQl6E53c
NXucf48+OersRlcXPZxZtqCIfNK3PQ0=
=tx46
-----END PGP SIGNATURE-----

--7hm3w7xjc6ubac3y--

