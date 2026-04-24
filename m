Return-Path: <cgroups+bounces-15500-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA8xMnub62naPAAAu9opvQ
	(envelope-from <cgroups+bounces-15500-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:34:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80A461541
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A624300C001
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB27373BEE;
	Fri, 24 Apr 2026 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DYzVo1/Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588221D86FF
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048409; cv=none; b=Qf9XAJe+8b3kgweTxt3tofr4d32vH2nt02U75RXAOApFqkPcCvkQRMAqNmVZQpBsqG90NChGQADVpkRT2+0kTiog6BUp/QB3C/Ddnnx4/FzrGEeIngUifbDs9m0xh0+9Fyj0pYOG8mfVaYxMfrcDcPL8mScTcOp6d9jlNSM3kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048409; c=relaxed/simple;
	bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEiMh8z8jTdtGy5iqRtOwO/FmfMI731TiX7W0Gzv+mppcqwwdE21+z6H71bc2EmmaAw6rFx6wHIwxXcZhHMGmyzZr1oquys2q6bGBQ6LrNoKcuu3xMKdn15nBFLe7MNVTcVCuZW25cbBEIFfhWaWJ+vxVtRki8szlEOj2gHMtHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DYzVo1/Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so101233335e9.2
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777048407; x=1777653207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
        b=DYzVo1/QZZ2Nknahn7Iw/wL5jC0a0UNcFaTX8WrPurHijhw4QbO2PQaPkzgF5TdTDj
         6KyMykM59hMJrmRCw+o0qFT31AzH+p/Zs2ms0eIVjSX4J1orXC05C9s4nN+y5zoMGeYh
         WAimnWFzNSFkD+I0EwoL0RZqHnQxMqGTwzPQiXgtOwAhSiioNfIytJft4ox5voPQcvNO
         MAUbMiuTXW0IR1AAogHRP4X2fsJNH+uikcSY9iTrU9/J6BHGHPGHezzFqqg8dYRLLMe8
         HKT+sNQif5thN6c7ta6ZI6KnTpnJASEcfcZq5YgF9OxiaLIw3LESAahfyviFgk9sEVNJ
         Qagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777048407; x=1777653207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
        b=rqtTYHQrcPTAmUg1hpkNRHTdJykxgIjkHF0FYH9XMH6N8LwfukPdt5ywdAMu1CqEbP
         3TJVP9Ncj93DlrE+1yepsarw4hYeqq9X1LhcT7sJwDmtv7te07CbiqdhAz/pjBKVLABk
         A/pVU+jWt+viC8YrlTF+jOz95vf/0tvnUX4+6uQFgVeWzfLNhXlVLFdNTXeTbVCpTez8
         FnseccX9yD7saP1AJfOLZ+ac+oIUePljM/cjbvBfRc8WduMStfxbha7gukRFoMGfMUhU
         OBgT+ilC0vlH4+TjirdkvNYWIbghInsVCFuzged21MZwVgzz2la9MSwVwg8v2Iha4uVe
         Bsag==
X-Forwarded-Encrypted: i=1; AFNElJ/Rnpx3LV8c/juQxCmj4lPdxn4hxLat4DhKE87mJK0SvwzBWGBaXvkYDI8nFvvrY5z1sOg1uJ49@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hQptaK5fJxFVKDUSP3Mrmi5iwvLekTJcefBbwrsCS3MVrtxy
	yq+EBU/B4MfbracrgkRqNUVFqCEsb5a99MHwoKD27K1D2K1hpy+Kck3Aga03IRZllHI=
X-Gm-Gg: AeBDieuLQwEm5TLhBneu4H0Z2FDvWBJm7BjXXsuNdHQ5C/rkqDOhozYAi5MWpeTAFDw
	Wy5m49faDWKZtpsrRoK4Z4OmGY0M34kmROa/25MEAQ96jLYPDK2iyFet2OhCtBJbMWkyn7Gy3ZN
	0X2RBM08jthrWrb/PWc/rDJAa7xr5grYgwZki5fvlH+HDcKYWt6UV5foSEIlyFui5yDESEX482N
	06j7Oe9LGX+uLKEGj2JZEs5HuZIJOubW77ZiXCIfFHNs2kKPTP8ImZaMqceq9v7NFzK2irGH1RL
	RNMpS7Xgy5QH1jnj3wO50Xh+nwzgfiKqT+8ZHOXc4ziR6AF9DEI6yDvpm73knJMRPdaVD34gQcF
	/mGCL9FbiYnGhsdPK9CVEuHGAn3eG+AOat3ZlFfp0rKQJFAVRotD1664xDIhkvfOa02i4oEmJWH
	1CQSbE7J0q5hsdOGA7wnyWiSgfWFLLP1vZPXrXDDakGpYMlOpSgNf26A==
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-488fb73d9ffmr351003145e9.5.1777048406745;
        Fri, 24 Apr 2026 09:33:26 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm702405535e9.1.2026.04.24.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:33:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 18:33:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>, 
	Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
Message-ID: <soifu3hpmugejzevzggs57dreexuoammqkufegpjfvr6dzkt7u@7chmb3ppce6d>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
 <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
 <398623a092c65ce4e53d1713112fa39ac0979fd7.camel@linux.intel.com>
 <8ecda206-d290-4895-bf57-346419afdc3c@linux.intel.com>
 <3b662522e17e380953d9b981d8c2febecf42455e.camel@linux.intel.com>
 <4f74cacc-ff98-426f-ac31-c25e6cbec314@linux.intel.com>
 <fb353b64e9084bc8fff01f8d5cc45701a2a60a60.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dosxmscoevitfoas"
Content-Disposition: inline
In-Reply-To: <fb353b64e9084bc8fff01f8d5cc45701a2a60a60.camel@linux.intel.com>
X-Rspamd-Queue-Id: 2F80A461541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,lists.freedesktop.org,gmx.de,cmpxchg.org,kernel.org,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,igalia.com];
	TAGGED_FROM(0.00)[bounces-15500-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]


--dosxmscoevitfoas
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
MIME-Version: 1.0

On Wed, Apr 22, 2026 at 12:36:50PM +0200, Thomas Hellstr=F6m <thomas.hellst=
rom@linux.intel.com> wrote:
> > The task writing to max will not trigger a reclaim,
> > only set the new max value.
>=20
> I still read *synchronous* reclaim.
>=20
> >=20
> > But when a process, part of the affected cgroup, tries to allocate
> > memory,
> > it will be forced to reclaim memory until below max again.=20
> >=20
> > This is a workflow where instead of the updater doing all
> > the evictions, the evictions handled by a process in the cgroup
> > itself.
>=20
> But kswapd is still used to do background per-cgroup reclaim in this
> case, right?

kswapd is driven by the global zone watermarks, it would only reclaim in
the cgroup proportionally to its usage to fulfill that global "limit".
The actual memcg's memory.max doesn't affect kswapd, it's really when
reclaim is triggered upon hitting the limit from within the memcg.

(The background per-cgroup analogy of kswapd for memcgs is proactive
memory.reclaim but there's no dedicated kthread, it's up to the user to
decide when and what to write into memory.reclaim.)

HTH,
Michal

--dosxmscoevitfoas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeubUBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai0HQD+Jgif2K031TYm0YfdjAty
B0TzqcqwBBNpvrgnUgC67EkA/14ZknnuVjDttRPWZYhls33OFy1aAPEoFVVOc+Zd
XuMF
=AICI
-----END PGP SIGNATURE-----

--dosxmscoevitfoas--

