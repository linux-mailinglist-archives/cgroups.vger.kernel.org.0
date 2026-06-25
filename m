Return-Path: <cgroups+bounces-17283-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TDsgCbLyPGpZuwgAu9opvQ
	(envelope-from <cgroups+bounces-17283-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 11:19:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E16C4267
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 11:19:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=BIL4Rip+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17283-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17283-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 733DC3002D20
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6768737D118;
	Thu, 25 Jun 2026 09:19:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E82FD665
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 09:19:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379166; cv=none; b=h7Rby4++ppShfQ4zi0Igz9ZIR9AWVxj79TYnAgYWbR7f8/wNOcc2DupsW2auFM8Bgzpe4EFshyBYgYhvPyp07Z8l5HAxAzMHt1DVpEY4vHtWRZIn92PeXF8UJdrsEZkIRXhCqAIIuGbeCeOZNOuMW54L6tFMWjwdIhEo8p0ZMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379166; c=relaxed/simple;
	bh=ECEn+V2NhWD3Cl+wFoaowjzh5mZpSqtDy2oOQW/aJbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJy+bX2BX7NwfAyjXh6wGrzF51GLkxwJJ43eM6mC/jT1i0TvLSqCx5q+BHr8nL8c+1dyyXYwHAFBHaxFIpznlHsbU9JSuN7zftN/WJARaqwCb0VM7693WcimW82oX+xN4wB1feX/ZvEcgjEKYhtLg90qSC87qccUxc9ZuU3EQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BIL4Rip+; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49263703c6eso10945645e9.0
        for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782379163; x=1782983963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECEn+V2NhWD3Cl+wFoaowjzh5mZpSqtDy2oOQW/aJbc=;
        b=BIL4Rip+vokMneBEDiPNxbSED0D7TbDycXaI1wXebLwhUsble6kqzOjoDCCt8seqoC
         AjatLjimIBmHCd7J3rJoeJHhfY7LUVj9dTViIZqwhRv4aKfkGff9WOYkkClUI1Fs4LPD
         9xYjGt6vtiS9HnBLuC1TqaaJCl3aM+M38tsJUhfKuAK3NL6pRLN2GQxZttqWp5N6A67O
         lWb7cCTgN+1EUaOzD9ZeP0a3s78KeN23dtebAHlaTFmKgU27ExMviuxIA4roIHa5XiTw
         JwjzZM7XDXKlohwUqwXDabkTzR6q+MdrhRmwrZccXDfc0ztRVRWzrsWY8cjVS4pNbH0f
         kLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782379163; x=1782983963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECEn+V2NhWD3Cl+wFoaowjzh5mZpSqtDy2oOQW/aJbc=;
        b=OGnsDk3Ek/sYHd6azh230eC2Z8edjOF02WDmKHfDp85rBroXy+q0s7sdAQWAYkSxZQ
         OuzEmo7Bedev/qFJRhfHv3YJzShZDebRjZcR1xX2Hn71g+F1adKKNMHzH212nLhV+WqF
         3hxCXm3pKlW9+ZAM643HlyYglxQm6se/zsBldfsAdWMr2JjYxHKydqU/EDQ7fySQKjV+
         eIx23u8rd8cfS6nOtJVJXLGAH+6/CnzWNh4MUaX/j3UuX9cFX1MJCmo0b3iNIO8OyWfO
         IW2cEV6dKXDov2w2skGiEAXOBPj17dCQZJ9j+RWUf8feYjeTsIApukkUdnfjNSWz2wJB
         L8dg==
X-Forwarded-Encrypted: i=1; AFNElJ+9enV7oNJdCJ9/SFp/qy9gFyNoDvQHDlJ4TqvWQeotjt8ubQwUZoXUP+M+j5GMf8/2ev+uPq+C@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/o9SsY7GWgwWc28P75rmWw4lcYby65Gph2X/w7lkyt/E6nNRL
	kk0rtiqhkOuRisGgNHHjR4epqmOPIdCgQ6g0epyMxI3qExvsVJEOk0vtAn5d46Eittk=
X-Gm-Gg: AfdE7ckjCRF+yuou1btPog2R1nWKsJFweT9PsWJM1TbbMm5kHRqq5ouOcMCQUnPEgQ5
	07eqYxUROzqqTkM7YvJH3az4C3lyKAMf6bct0Dl6zierK+EpICRoCdLM+TE/QyW2s2f79iw/ilj
	aVvvIV0Ki8QSoiLLjtEuRhWQMlkfYP307RrxvvD4QQE1xqn34bRO5Js5BkEHbAddqhJzxyYuwi3
	jRCXXOHXaoB+oNDPLVCExhovj4MlY5Lb7qXoRCK9Q/kdJXIYaw0KvqcRl7aRqqlInIU8UNmV2d5
	RNZw1ywNAPQkXkrQf9/5BjzycnFdNdCbJcfimzhvwnLOCZehMrUhQZpwbKwYX4MmafPz8DsxPY+
	aFjGSTs6lK2mTaf8HYwq/t+8mDl4SObF5AKiqvPg3FAayWqtOJQSr3Z/sgnzOM3Qbwr+9Nc6hdI
	RnOaIrMCk7ivo0cFoffg==
X-Received: by 2002:a05:600d:8443:10b0:490:d32b:39c3 with SMTP id 5b1f17b1804b1-4926685feb6mr16924745e9.6.1782379163017;
        Thu, 25 Jun 2026 02:19:23 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49264082426sm60418065e9.9.2026.06.25.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:19:22 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:19:19 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org, 
	Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, 
	Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>, 
	Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <ajzxLABtnWym81Dp@localhost.localdomain>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
 <ajBLAsNoKesXmFcs@slm.duckdns.org>
 <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrl2vho5y5eomexp"
Content-Disposition: inline
In-Reply-To: <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,lists.freedesktop.org,gmx.de,cmpxchg.org,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-17283-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:cascardo@igalia.com,m:tj@kernel.org,m:thomas.hellstrom@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:from_mime,localhost.localdomain:mid,igalia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 263E16C4267


--lrl2vho5y5eomexp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 12:26:54PM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> As far as I understood the patchset, it doesn't fail the write if it fails
> to reclaim. It sets the new max, then, if the write is blocking, starts
> reclaim and eventually returns after multiple attempts. But it still
> returns success.
>=20
> So I believe this is behaving as you would expect.

I was alarmed by the EBUSY mention similarly to Tejun but then I
couldn't find it in pre-patch (840ef6c78e6a2) nor in patched (v5) code.
Please make sure the EBUSY return behavior is not introduced
(essentially match memory.max behavior) and that the accompanying
message refers up to date code ;-)

Michal

--lrl2vho5y5eomexp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajzykhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AihGwEA1SCEBfnAwyeubLR7IllY
8xY1mJBt88wz9mCIeM9+iY8A/0e+2PnPs29VJ7kdk24/ZbM72Eltcu2Pv4++6deM
lMAL
=i/jW
-----END PGP SIGNATURE-----

--lrl2vho5y5eomexp--

