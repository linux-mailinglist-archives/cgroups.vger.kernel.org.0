Return-Path: <cgroups+bounces-16441-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKygDqirGWpEyQgAu9opvQ
	(envelope-from <cgroups+bounces-16441-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:07:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ED3604406
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1B5930B5F58
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613553DF01F;
	Fri, 29 May 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c8wev59v"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C03DF008
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066344; cv=none; b=ZNQSeE/A1oR5kQlI87Y9vv4acnDd5o3PrSxMCSwgO2hhltvgBLTkoZ6ERpaEYZMRnAr/i2zptbomls7vERCx7u1OBvpoCczl0ObLnBrKi4dAnnF5MUWaw21v+p6ZU4NKgSlKq1hGi0zRgDaBrv+h8saueKkiZpiwlZcSeR9MLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066344; c=relaxed/simple;
	bh=pCZ3fEPjMOOKoFCjZxoSxM67ExDXIpbafDhQNDMrHi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2Isteg/Hg7KpqpN4x4BNB9hCiRo8N1cpRx/0PtOa6MiM9sGSWZwfv05sNmF8GrguJd8fgrfFvJDMW3Tt2FO9CjgvMuvMzoZF6ZfiDmmX9oyy6uc/9rQgu2yF4pL80TSEwBshGUgbA4CMOIIBYRY77ZbXjMybT2xkOKK0GkdUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c8wev59v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso66133675e9.2
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780066340; x=1780671140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmSOuhBgxBhu7Is1B1Rw2/yoQpGrUuGnNNhQRjRyvrQ=;
        b=c8wev59vAWhLrSqSBoZ0Ikjbpnq76hJ7OtUmYXGqZuFonXJ7nRg2v8NenCSlkf32FZ
         DDNGpfjRu55N0ypfEKZGH2cLSEoWDFa9B3JcYeoYgMMx5fM1nZxwz0XlMK+k0V63PGXD
         /O7ACiiP5JmQ+bfSaoGKXaPp2zXfwk7EnfeR8y5bK+BpfIKM3nIwLEN+9t9sGOFwb0sN
         bRN99enezj6SCJkgKT3wvMAhBLpTLhn1bANhU0Hgn7osFM5B7aiHd/9TubC8/Z2kfQLR
         XQlwmQHWrtxPpfWS72Iwoia3+D3jtQrEGY+rrBI6lzvgfuw9AXICaZTKNwQnZIac9tIr
         nocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066340; x=1780671140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmSOuhBgxBhu7Is1B1Rw2/yoQpGrUuGnNNhQRjRyvrQ=;
        b=M3mSYY+GoucMVJH6Av8jgnCRWfvOQmmTkGnnUKp+ISnhhZC6zrlXpGIPcLESuqxdf2
         teDShhmxOaEa3MBZOHuzpbl/i9Lgd7n7hWBaXGyAaNsjeuyi1665j9zV5Soj2Wff8JVn
         BX0r+tsa1sD4K/8Lb7aUZiOqAInJ769AbJ+Gpc/Tl83CdU9iCn4Qaek0FFOrDWPj7NzI
         9prgOkWkyrdIYHzmXEboMidau/7rRJuJ92ck1MX56d30/ju+rZvkHBjCHEvuzSnCrI8w
         GkYWxeNYniVc2Ht8YN3AuGsRU8yFuwPcFAQ7pgs8blIzZ2a0unnOOPLvnOkd3QEVb/c8
         r6/A==
X-Forwarded-Encrypted: i=1; AFNElJ8PXiT3vn4GcVz5g8kehVy8HXTXYJrmEzIe5ASrhqQaLerlWy8pAMLtSAkLPZpprZwWRqidRExD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Smz7bBy5hMDTOAQ8LpSiAogKEXGg9xYjrCabIDQKnaeJNPPs
	yoJUBDgNXhqXHPBwq+IKqVN4rv7HxdwDUzOS2Gmsf7bBG/bufg2mcQojU1ffyWULyfQ=
X-Gm-Gg: Acq92OGohTTyutdO7dHDlxDCYhM9Wre8n5boLwz1lCNupyE/ESDnhqg1SdiNKKzuCrY
	3K3o9K8WIxCQFNhVgp2EyXMwEauLeWY6e/tgJTwaIxilDaMiezTgeiRwmQxhzfCjmsVvrtWeKI2
	4aTwT/N/qWupHnfPv4fknsWgTE+m4u6Hkc4A0Is9ScWUYY3nmB3W694QPrJFcEDoW0AYwNRLUJe
	raQ0mfptNujxmTeo9137c9gO0lUWqTFYZZwxzUKqw2qu6yi02p5HHD4CgUFFTYyLHHz+7JHZGFM
	La5fBL4ebH45bnNAUHyx1YIfducKrSAZUD9zIk7bRlrpsRpgVqyIWK+xfY6PUw/nlceCVZ5fxwt
	w8H7DHizFiE0RTCXvIYc5KITjCYr0ckDFW1/+JBtHWRbfTkRdIA+Eb+U7icwkFZyde9W6aZ6cRT
	JhtMpWkWXSRAnUU9bo6ItluID0caGHin8YfDod/Py9GxHpJDcBRF24ueOQJOt4Mkg5Ptx3ZQ==
X-Received: by 2002:a05:600c:1453:b0:490:9536:c513 with SMTP id 5b1f17b1804b1-4909c0b0012mr41744015e9.19.1780066339778;
        Fri, 29 May 2026 07:52:19 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d696f25sm62858365e9.5.2026.05.29.07.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:52:19 -0700 (PDT)
Date: Fri, 29 May 2026 16:52:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
Message-ID: <ahmceQfFPpXa_6Qe@localhost.localdomain>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
 <ahB7pCu_G4vuswc0@linux.dev>
 <ahWfypvuTVsB-pHQ@x1nano>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rw7fy7kfpwloyodg"
Content-Disposition: inline
In-Reply-To: <ahWfypvuTVsB-pHQ@x1nano>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16441-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,kernel.org,linux-foundation.org,lankhorst.se,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Queue-Id: A0ED3604406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rw7fy7kfpwloyodg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
MIME-Version: 1.0

On Wed, May 27, 2026 at 03:10:47PM -0400, Eric Chanudet <echanude@redhat.co=
m> wrote:
> but that made me realize there is a catch with
> this patch set, with something like:
> A: +memory{max:32M}/+dmem
> A/B: +memory{max:16M}
>=20
> It gets the CSS from the dmem's cgroup with
>   cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
>   mem_cgroup_from_css(mem_css);
>=20
> Which would resolve to A's memcg and not enforce the memory.max limit
> set in B when dmem.memcg is set for that region.

One perspective is that this is in accordance with dmem's limit granularity.
If the user wanted to distinguish dmem charges below A, they need to
enable the controller there too. IOW, the depends_on in one direction is
correct. dmem is primary when it comes to those charges and memcg
secondary.

Another possibility would be to always use the highest precision
available (wrt where current resides) and then the API should refer to
struct cgroup from task_dfl_cgroup(current) (and make this only
available on v2), or to struct css_set and extract respective subsys
csses in the double charging function.

In either case, it's worth mentioning the behavior in the dmem docs.

HTH,
Michal

--rw7fy7kfpwloyodg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmoHRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ahb7AD/ReCU/1qelso4Se3AlOZq
R+fmGmGVDlgPYs7gBkJUqqEBALvZg8zd4ig7QW/B4SdBdSv8RGm7SPB7R9vTNMP8
dKYO
=3pZx
-----END PGP SIGNATURE-----

--rw7fy7kfpwloyodg--

