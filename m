Return-Path: <cgroups+bounces-14810-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KtPETodtGlLhQAAu9opvQ
	(envelope-from <cgroups+bounces-14810-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:20:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2E284D23
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4343C3051456
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E139527D;
	Fri, 13 Mar 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aEw2RvIL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF038D019
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411386; cv=none; b=IofcFea15moacm0qvxCQ/VIQrVUEJ5UJ1SvQE4xu7ZgNrTGZwLwikK4Bs02dnz7fgXYuKdHB83JP9sKKbIn6Fs1gC6GqrJofV5shQaaAFsuHtsaVeD6SuuT6NtnUu9zg/9ThAlnu1z3ZkrWTNhJ04iL7WBOBWScHFQBgxsUQmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411386; c=relaxed/simple;
	bh=r4tJHOXIuvSU6eCzb8FOh/FA/PToiSxcRqe99SFCYNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtM9TUXOLB94j2AhN1NxRK8setXkPqOVzhkbCbFqVF534hUx579Srb6oniGrBdOd5XtvxI7gVll6VJ3mLGVlU5Qivf/vVl0zFLuqtXM7VX7rG7dyfDaXMc2wikYC0dQj380VTyLMw6Y4a+2XKeXVaVunWUDKNAIdErmXQVoBAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aEw2RvIL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so20931335e9.2
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773411383; x=1774016183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ellTIQKUVjpV3d7rtlz+Cb1dqcrKlj/Bb25VGUxyP7U=;
        b=aEw2RvILiqltWj3Ak+8Postu7kI9zxSUWgTSWEW8bzobumzXHdTjHfDwfjdyX8nLdK
         tnpV2VkZ4HYGtYSm1+I9zFMp7sy5akWBRGaeVmitwqlEsgt7FB9CqR0Bl4SflC7/ylm2
         zAygOU4RBNGWL6pUSMQ8yGPkZ0QDFTy6AWBWw+f/KBQoPrwxui9Hrzmk5uklrn7ktMdz
         BRzVYD6ZMsQPg+pf2bcAGzRTqDfB1y9b6NTMV9LfdgpQ5506xye61EhtmuRCsvB2MdMW
         0UwCBYx2zcYDpA+nnvTlX/8aB4DnAVQDJ1DsWuTlPQ/8GYcsWk1XBN2Kb+1w2w8GaWWX
         VFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411383; x=1774016183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ellTIQKUVjpV3d7rtlz+Cb1dqcrKlj/Bb25VGUxyP7U=;
        b=CFw70wijoKeUmA92K6HCHmHhc4VUoE6WxlNialhXWnxkNldFVOKPNFapueaXGz2Wqy
         aTqUYfWwQ5MBvuia9w9S77d4/6Vc40ayNxBZrfzhEzpBbzdxmXAJQEqzdLOTG3auh1jI
         27/c2zWSlbeYl9JYrkPMEDvo2iQynLwH1OTgbAbHMQutJ3C2Q5l5+vvKeSbtf3SLBy+l
         kAhjhAkATnqua/Fm6vBeQLWQOD/G6XSq4RKu9gMwYilteyZkIpwEpK8wbytrtU1+h+g9
         /unYvygy4PnjD7VSLPTVoVhkZyhcfsyvxUIiWJ560DO7Xub7lTAwY3mac/8E0KhgZN+l
         KC2A==
X-Forwarded-Encrypted: i=1; AJvYcCUvA2L1QCU/oRvlNu47ZkcpTP2EOW0BxUFMHsX/mO8web9BfreoI2pZTpeNGC4uvMadnIniJa73@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKPj0V7HSDanjvNExKl+If+6AowDK5M/9Ui8q7Lds7/Dt4jbm
	CfodYFESohgegHuyZjy01J/OxdFcCpiD4jFw0jCGK70n01K7Nlqm/lRmH2rFuPlCAmUestA27me
	MyyLX
X-Gm-Gg: ATEYQzzhbEKvr0mk6Pq21ewHbcMbcYtQzZ4KTridbR5jwTJDpJfkvaO6Ll46OPY3N8F
	jqIXuM1j8Af0i9VwyQAPgGz45EWKHCZbqP9mjDaCktOOnlhcQWmZL8948hTNsCclOgled+GTDuB
	dw2uDOHbFKiVHf7gUUSrmKgHWEXcEwlVXR8bc8DQeUHYMKvXtvUzevTVqk1bScjc1UzBcRW01+9
	UjY9wFZj2ksghq/3kFPDEFDQaJiim7uflomj4gEwAgWjWjsY2NL6NUFID2M9vkNnDV/rHt/HDvy
	Ejk9Bx/NB73LcYunEe2VnGvwHja5fs1VpF3flbzSk7QQ7PMPmJwcyeyLrdg6x5j53g9fJ4/TUKQ
	RD+eKMyX4xve0EF+nEYU41M80CmivQDAjm7lEMv3ShM5no6q38LkRq9GTug25aEHuvcUiQs4iTV
	FBZfKQkv+mLua4ney6oLpaXXbnA9jzDcM3axxxmQa+SkA=
X-Received: by 2002:a05:600c:6287:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-485566d2ff2mr57941605e9.11.1773411382974;
        Fri, 13 Mar 2026 07:16:22 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563953dbsm43751525e9.0.2026.03.13.07.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:16:22 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:16:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
Message-ID: <cykgy6mf4nu5kkwl3uc6modkj3ppela2xgjy2ijidpyzdsnyn4@cbwivcrqa5kh>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmriianp2kll5lsk"
Content-Disposition: inline
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14810-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,cmpxchg.org,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email,suse.com:dkim]
X-Rspamd-Queue-Id: 9FE2E284D23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pmriianp2kll5lsk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
MIME-Version: 1.0

On Fri, Mar 13, 2026 at 12:40:01PM +0100, Natalie Vock <natalie.vock@gmx.de=
> wrote:
> This helps to find a common subtree of two resources, which is important
> when determining whether it's helpful to evict one resource in favor of
> another.
>=20
> To facilitate this, add a common helper to find the ancestor of two
> cgroups using each cgroup's ancestor array.
>=20
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  include/linux/cgroup.h      | 21 +++++++++++++++++++++
>  include/linux/cgroup_dmem.h |  9 +++++++++
>  kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)

When the helper is added, the idiom in
kernel/cgroup/cgroup.c:cgroup_procs_write_permission() could perhaps be
switched to it too (structured in commits) to "optimize" migrations from
large depths.

Thanks,
Michal

--pmriianp2kll5lsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabQcMBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah3wwD+M2PKuVG6OqToZYy65XLc
AgTWSOf2FCryVryu7GdRkmIA/RL1VRrV6USyp/q1q1lqwwbA6eshjCbHtFOelFXs
vd0B
=B0dw
-----END PGP SIGNATURE-----

--pmriianp2kll5lsk--

