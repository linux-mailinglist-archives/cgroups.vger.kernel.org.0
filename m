Return-Path: <cgroups+bounces-15180-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMV4NBH91GnOzQcAu9opvQ
	(envelope-from <cgroups+bounces-15180-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 14:48:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622753AE9FA
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 826DE3011145
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4493B47D8;
	Tue,  7 Apr 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LrOghNTZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96E3A9637
	for <cgroups@vger.kernel.org>; Tue,  7 Apr 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566091; cv=none; b=LKFl+7lWSPOHHG6xzF+qFcS/HjthcpJx76AN7lrzs0Ac6nNmiMS69GQ/6fVWU/x0+FK38sQfKC4bGa031kJ1gtIYSDBrVrURghcS6MhgwecHUJDsegeZApkSKQlXMGWNQR5kh8K33oQ/JFPYF5jKrHHXkUqMXaKkKtcyVGUpmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566091; c=relaxed/simple;
	bh=iFxoJSHMVrVVsmA8za4CC1kT2wSoZvAPrz5roaKyMYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaWIKVIj7D7lt3GjGtgRHrDxTPUxFPL0YzI6z3RJu4cgUN2+1hYC7lbpPHJdvf8f0xcjGFuJVIsie1+OJ73d48Zmcic6vBY0Yaqa1YIN1HG4rYpKiTUegaqLA2kcvn/YjriHRMyllUlOCHBfr3GGXfRWyCXUH388J9V5jRjcLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LrOghNTZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so66769935e9.3
        for <cgroups@vger.kernel.org>; Tue, 07 Apr 2026 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775566088; x=1776170888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsPjgRVFyADCET9OBAbphHMErVazIwO74nJ/z5grGXg=;
        b=LrOghNTZTeJjgiPo6ZqLJGR/nsl0owqfmiP+mMZ6zx71p80alpptj6qwaTak9Y6W7D
         dOK6fUSBR+3v/aihLfWHYhEdvWI6o5EewIJ4YctTf/ROGlf0kegT0F3jmfVcQ6s2jq4o
         unr+Ux+ri13V2LyS+fQBWmCJhiTDHM5gx9d6E9S4LdbbfLCPq1KKIHdTK/J22uHLTyVO
         Q917dlsNMR35wb4XDA3JwojGw5FZ6ibA0rVOX5F/P/QxGedqru3Sf7rLqAOqTCb+kXa4
         uXYwJ5R959ft8nyg4azLMAfEIIm1IxRwaSVenb5xeuqi7aEMvlL0oX10W50d/EOAXhlV
         8qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775566088; x=1776170888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsPjgRVFyADCET9OBAbphHMErVazIwO74nJ/z5grGXg=;
        b=q6HdcZPdfeAfb0TWH8eDId/TD+umVlxq+vJN+UCjxOOzHJ3XElYIlZ5meK1sROTX1r
         3slpseEMOF0xIZhaXsJf7elCJh8tcHQuI/VoUVocRID/T9Wwtwl+4/6zMUm0XQoRQODA
         o5ZD3rRhhk5miXGvOHQjceDd4Cykcu4fNoVCWHvBiSF/0fph9v2Ze8wMb285U+DlFTBS
         E3gSP1SSxnb2oaSe52pyfWurQxisvB+Xeip/gni5owF+Fi/m0QjUambLJUIrLsoE4NyF
         n8Z5A6DuE7uHgIF/hsjyI4YIjzNhQv923Vobhx2KHcKZ573zdXp6RsoB/rYkfhAE5c1f
         QPXA==
X-Forwarded-Encrypted: i=1; AJvYcCUTPjdnG2yp3joO8tne7SuKp1uWGyiAvElF4XhDls1JBeRK/n42bSv6EIzZeY+vfbWyWHyi75oc@vger.kernel.org
X-Gm-Message-State: AOJu0YxVmQS4+nedkvEk52wFCblIegJ3APX/8Et4HnTsyk6DJwGrO4LF
	35NfTj7hiKzGMS1jKkhP90zZI6xQgpepoZtbBZ0UP+vtsg5VxlxpFAS5VuhTJTa0IGI=
X-Gm-Gg: AeBDieu2J/eB5VBrEMyrFFXjVRuF2uzjWcz/O9FCEc+pCnkW4L/zt24aHJtaCqwKD4i
	N8L3bDudmBTGf8V6haprHwxNuBmasmqyvCC7m4R4WP5kor71gWNMZI7gZ/8RjhP0bwo0lPPKzjb
	fpHCVH3Mwzc6fkX7gyMYryDxsX/VXyyu6V2Bm1W2t6IRs+PKDegB4bbCTPb98Dd65xd/bMNqymd
	jXzoiXevCbwKUlQY/skUhxvUfM+fxUIfPPRWhPmJKSiMPYy/2SFSFSN1NCdgU843M6Af3dGO/Ml
	jfwtfHvrIwJhbBBdBlj/VqdaGgMJHXIhcpU4v99EKLNtTl/66djgo2rIdlOdN0uSzl3tgIRtDqu
	gnbJVKWHE1p5XTFs+IIn71GcXDLnUzbr3/h8ZmcVIimWER6Usm3BKRkt5DSvHyLaRAPpTepkxAJ
	ZcSoieysN8F8zhKV2QQjWeoAkB14lvbs1f65Vhnhr+g70=
X-Received: by 2002:a05:600c:4593:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-488997de1c6mr263906175e9.25.1775566087832;
        Tue, 07 Apr 2026 05:48:07 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm50268531f8f.23.2026.04.07.05.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:48:07 -0700 (PDT)
Date: Tue, 7 Apr 2026 14:48:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
Message-ID: <auzxmkl5jxlvlxpryibtz7srdnssguiaylb3uisheclrqelcgh@owm2nve7axb5>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
 <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3iqnq37lhwpyhhg3"
Content-Disposition: inline
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15180-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Queue-Id: 622753AE9FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3iqnq37lhwpyhhg3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
MIME-Version: 1.0

Hi.

On Fri, Apr 03, 2026 at 10:08:36AM -0400, Eric Chanudet <echanude@redhat.co=
m> wrote:
> Introduce /cgroupfs/<>/dmem.memcg to make allocations in a dmem
> controlled region also be charged in memcg.
>=20
> This is disabled by default and requires the administrator to configure
> it through the cgroupfs before the first charge occurs.

This somehow dropped the reason from [1] that this should be per-cgroup
controllable. Is that still valid? (Otherwise, I'd ask why not make this
a simple boot cmdline parameter like cgroup.memory=3Dnokmem.)



> @@ -624,6 +656,13 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_st=
ate *pool, u64 size)
>  		return;
> =20
>  	page_counter_uncharge(&pool->cnt, size);
> +
> +	struct mem_cgroup *memcg =3D mem_cgroup_from_cgroup(pool->cs->css.cgrou=
p);

This is not necessarily same memcg as when the dmem was charged via
current (imagine dmem controller to depth N, but memcg only to N-1;
charge, then memcg is enabled up to N so this would attempt uncharge
=66rom new memcg at level N, possibly going negative).

There is a question whether dmem should enforce same-depth hierarchies
with `dmem_cgrp_subsys.depends_on =3D 1 << memory_cgrp_id` (see
io_cgrp_subsys for comparison).

And eventually, if per-cgroup attribute is desired, it would make
greater sense to me if that attribute was on the parent level, so that
siblings competing among each other are always of the same composition
(i.e. all w/out dmem or all including dmem). This likely results in this
extra-charging attribute to be properly hierarchical.

HTH,
Michal

[1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.co=
m/

--3iqnq37lhwpyhhg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCadT9ARsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhOewD9F+F9qnpuYx39EPNVVkg/
SKfJIBup3dSTrvEji8kA2RQA/RMerQbaK2QZn1VEv4D6kzXZgky62HGmS4B6FfWf
8XoH
=uSlM
-----END PGP SIGNATURE-----

--3iqnq37lhwpyhhg3--

