Return-Path: <cgroups+bounces-15641-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFo6DQlI+2lPYgMAu9opvQ
	(envelope-from <cgroups+bounces-15641-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 15:54:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FAA4DB62B
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 368E53006803
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F7B47F2D2;
	Wed,  6 May 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AmC1CSPt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9444CF59
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075648; cv=none; b=uuJqCQ3b2GRM/glIWjzjY7h8N+pgbR7YvfZZnDekkMz4it3wOnIGKJOW+eIzg83vl0nMn42RbMUg14DQmSGyh2i6A28AX9jMx0kvniAKNYUI3ie9kGprCjuzxNKQDz+brYUTps5w91SJxQS67+1Lo6mJLCd05D/RgB4kPl+EpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075648; c=relaxed/simple;
	bh=6KlB82Gzxw6Ep4hdvTnTO13cUo4z1IlE435VWxqkbhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhdyplJ4Qnk5kaZgj3lbLfYSIaq0GsFicbUEIOh7LNUOqVTuulNha/8nSsoH0wusW8V7nvO6SL4Ie/Z+xpNva99IYhEVJorMqBh+tfhxLB9V1rnY4pzL3OsAsbChooChTR76g+U+vW72ZL92JQo4wUd4Im3gXAj+hhRYpTJdJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AmC1CSPt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488d2079582so67213135e9.2
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778075643; x=1778680443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KlB82Gzxw6Ep4hdvTnTO13cUo4z1IlE435VWxqkbhM=;
        b=AmC1CSPtD90l14uOt/dZlSzXuFtzGtRWgvFplLurCwwjAVxJquPNO/vF6nxFvcXfN/
         LQSeKVJX5FCRgKX5EGUpi6uemWTBtN69d1arDcoqA23j5iOnahrLtMaJpgHc3B4rRBqB
         rhaMwMWxO1Vt5KYUFZdq7an9sdYYxoqnwIBh3QlSYvZ5XL3n05psuvqO9stkwbdaxkwp
         eziocMkxqfwZHH6vUYOKHWQvmQwhAYJif1imJ++9Amdg11Me3fI4VcQS+lg34gvCJ+8H
         ZAl5S+2GQ8Vt1LKQghlf4oavfmtI961bu9j37Fc4u6x5HpgJMXXa3ANFKAk/mzf77LI9
         ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075643; x=1778680443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KlB82Gzxw6Ep4hdvTnTO13cUo4z1IlE435VWxqkbhM=;
        b=AszOqdZkx1MO10mkkcwLBtFZT2l/0X4PcSDjn/H/ebubdUqtt8pVmlFmxzCpqyXD9H
         9KXQIF4fy03URiVUbHdztZTE8YX1MCmTMSqOj6tP+Zvwj8bbYrNljMdCXi9EmMV5cEUR
         vWpBiYBG2ifKbTU5f5kLRmvcR6Gdq7moFDsDTkcJ6If96hb8dQ8BWdLBkGJ2KdaUCqTr
         a9ZLSrHQyWn/fwXLODsdAek+dJqztx16daEqzGZycdRZGePR5IphXqimocYz5ZxjZsrm
         U6H7A4y46/APfh7Zz3+0zCr3c4AC5/hov3ehP+1MmUGhwDiEYtEmLVU0q8GYegXSOtgj
         Z6UQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yQGTXFJ4ZjXPuRFns8K59G7cKglN06EUABmJ5zjtVAphwM5FhL6Byud+1lQD8Om4f29V7+CDm@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRL4mBnDPBfQk+heT+kR7baNB7Ua7nPuYd3GheqHlFhrEwudi
	An8cNA2UnM6r0UgYApPFQ5DsGdHQSMIkjpDhKULQUEwMmebV+k2KF76y7rJTE2TZVRk=
X-Gm-Gg: AeBDietn+dvNZrIFo4EkNR86IjVOtPcbZ/SvM40XIAhvz9zC+4atrHWkhf3KG93vLu4
	HROhzfSFeaozo0ruvK7ZXbC6DxkKesG4rIoiu2uca2c68nsVwd1dPPtBLWC7KJbRKiVE/k22hNx
	0pBiGDYmvvVZOTpB76fE70FFfIksHRJE0y6Sy3oS+xp+mZDdXO/X3DnQqL4dogFtTPJTm9beacc
	E33dfUU4EA9tXcHzXIV6UX9mLxkxPSuKjDzlBOrzJ0i/TebyrPAIK36A22i+tchopouvYw1EQQY
	6fzpXQqrVmGPrdKh6z1P1n210ZCfdVCaippx/ZMdRdpwLwGX66hWJ00aTmqAOpgmFtsl/ZqeINo
	GPu2JcMPzllIjD9MnNFmliKU3SIwn4aTD4xGXkQ+/zCLf5EzYLPgpV7gsbDQ6oMH0/S8kNZF1vB
	zNQ6e1klV4KY403KvFY12KPAuRZvf3v3iZ3LQ78z9AdvYLjbau7o3NYcqEcqk=
X-Received: by 2002:a05:600c:c082:b0:489:6c22:e081 with SMTP id 5b1f17b1804b1-48e51dd3a1bmr46595295e9.0.1778075643420;
        Wed, 06 May 2026 06:54:03 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b19adsm17343205e9.3.2026.05.06.06.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:54:02 -0700 (PDT)
Date: Wed, 6 May 2026 15:53:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
Message-ID: <aftB-cc5EhDXxCGA@localhost.localdomain>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="reykr6qmcqnxtkqn"
Content-Disposition: inline
In-Reply-To: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
X-Rspamd-Queue-Id: 30FAA4DB62B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15641-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com,vger.kernel.org,kvack.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim]


--reykr6qmcqnxtkqn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

Hello Thadeu.

On Wed, May 06, 2026 at 08:58:23AM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> Just like we have memory.peak, introduce a dmem.peak, which uses the
> page_counter support for that.
>=20
> It can be written to in order to reset the peak, but different from
> memory.peak, which expects any write, dmem.peak expects the region name to
> be written to it. That region peak is the one that is reset.
>=20
> That requires ofp_peak to carry a pointer to the pool that was reset.

(It'd be nicer to have generic data in that generic structure, at least
some void *priv. But see below.)

> Writing a different region name will reset the different region and make
> the original region peak get back to its non-reset value.

I'm slightly confused by this fds x pool matricity when there's only
a single slot in cgroup_file_ctx::cgroup_of_peak.

The intended use case is that users should maintain one fd per pool and
not mix it up?
This stanza would better fit to cgroup-v2.rst proper than the commit
message. Or make it simpler and start with non-resettable peak file
(like memory.peak had started too) and see how it fares. WDYT?


Thanks,
Michal

--reykr6qmcqnxtkqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaftH6xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgWBgEA78n1QkHtqLX1e7j+HqA5
/0hULtuyP0LvN9r2E3h2FskA/0/p9uNIv1XoJqaVguIXjyHW7Kp9SnAM0puHxrMQ
TzMA
=pFLa
-----END PGP SIGNATURE-----

--reykr6qmcqnxtkqn--

