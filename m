Return-Path: <cgroups+bounces-15568-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFrpIJ2x82mD6AEAu9opvQ
	(envelope-from <cgroups+bounces-15568-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 21:46:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0D4A773B
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 21:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D57B30226BD
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122833F58E;
	Thu, 30 Apr 2026 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GOYs4v8H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9C335564
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578393; cv=none; b=ooJ0DDW0P5ULoHvuLovuVQ6OtFx+EKjmvIh9SzZZT9cc81cKGLHIfFL0ZZ/193oRxMjbjn9IOErOACDnOuvWK3wR7iXDKa/tE3r4MWKjFTz+O5XiMfQhU72yq6nFtQIrUMW4fOqrJpONY09C2uP2hRj0LLiPs2qc9Og7zoH/Z8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578393; c=relaxed/simple;
	bh=hsnuKszqwUnXW6gTOwMCMEQcekU0fo8nLxh7jZIg+RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rASB05uVGXEO0fm7tk9kArf+J1BKTo+l0XT/4VUueXAL2noJkydujHEV7wM/XYaJi7kI9KEWLhxdRqG1yjApzNkMuPMfe/hlgnnBy7XJW822hkwDG/wDEv9UuX0NUa4y193KDIaI9vu5THaR2CwrhiWK1EGQO/ICxWUur9AYWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GOYs4v8H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ba840146so10995995e9.1
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777578390; x=1778183190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sePdHJFH0sEo8KzmXLcQsXcQ13LFg+J1qgOmUd0oKAc=;
        b=GOYs4v8HTEQeoBhPJ6GHfAse0YjIHiQx2meiOpzne4i0xLUG478eGBz1myTv2AUM12
         NnimpA7JWjxQ+pvDwHJD34wrZm/4Rin4T9U9OaTHEM6ZKkZR4rJbxs1FjfImF67aH14k
         p0xZzxGEzcKfknsrx7hv+nhRg98CHcwM8P5yza6qWNZfVZjs488HUQ93ymqnaOU5Hoo+
         vEz4IJWKlhMGeol2J+uHtriFyK02VKBeyNi8yGSmO5TAVb/rQL+jTyckAUBt4Cr4LaQN
         RFSoikPCyIV790gPJ7osuuTwe87r3RsCehFjNorTSf/dgo+KaEVK/GzT9w4LQ7f0oIpc
         XSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578390; x=1778183190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sePdHJFH0sEo8KzmXLcQsXcQ13LFg+J1qgOmUd0oKAc=;
        b=Pav97iFJy3R5U2p+WQ31UvQQLR0BL3uClCn1wJAy+BRmVhkgtN61PoR4Xw+9Vi/HlN
         gEHDONI5RjlQ1lsPzgQAxm9RU7mLA/goKheCp66rbuO4C2tTTVRGIm6s3FDj3kGA21O5
         J3j1CfeBI0Xtbk2Fai8IAJYal4uNiXrAlaCpG3zfgH7+SwqTF9URL813EbW5//Q2lB/8
         Y1ROOslEXRLL5RQzrXGVPv4bMRvSjfb5Awy9PH8SJ8ittUywUP2cRNE4bp6fONH+mymF
         O8mzzaVww/NJ9ULWLOjezmpPcMorzTuxGW8HspeR2W6HpXlIMhv+tm9uzGUKV99oOl7B
         UxnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aYM4n4PpBATghPF0Qe9wUlemveANZSBY1/PhltIJo1/icsm50HHouxP8GZIrBtCzU7qTy+q+1@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5Xlg3AN3+l4Pp0vgZJJ2j4spGUKyFfYIQjXZl07EbB7AjgwG
	Z9dKqyM6SO4KuuGKtLnXaxKhqXVoKn/flxXDD29vulR6z8pexFAOMdc7IRkRNlvj61A=
X-Gm-Gg: AeBDietbPEEjm6+vay7axnr+uiBmxTEkclS81atDz5x0n2Fn6eloDzwgt4/jJQYr+sI
	ItRpAmFyMx7j9VmgBrb7g30tHl1aXlJs9WLP683RSM8SQyo/UWPZMjhPLUPs8jtQ/7jJHCXqNdr
	BpOkWuaUxLc2dZM5JXH/tATlnDD8q2RE+BlPlk9SR84ildm9WQQLTsmMijhcZZKC0GUMtJpALd4
	igovmN5HH1CNzdTjBaPjtE2LKJuu36ATit/M1DCGnDT5KawsTF4YWVSX9QYTpIyKBLvhZSovZdx
	EVl9KmO19/DkniznNY1soed/gxdgJYBqGZHU3dC+g5/UMM2BzzpxE6UC+3RM3ZFIp/PPlH1dQ3X
	FpygwrzUxzWqvIuGjzY4MB/HTzhH807Si5L77PTzKEmwszy+d8nL+X6EH/+z7ewjZru3EhANhcP
	xudLNEybG1S5SgXdUJE8pfl+MWCiqfow1KqDcglS5MsKCRR9n8goodyuB0AVvyq1pmtNs0Aw==
X-Received: by 2002:a05:600c:8b04:b0:488:b241:2c5f with SMTP id 5b1f17b1804b1-48a8445fc28mr75462175e9.26.1777578390085;
        Thu, 30 Apr 2026 12:46:30 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba8487sm1864955e9.11.2026.04.30.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:46:29 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:46:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xie Maoyi <maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH v2] cgroup/cpuset: Clarify the delegation rules of
 partition
Message-ID: <h46vz32432zl6xu773hfvnpze5zt7berywvg233esmeiftiruo@aub2kgpwi6zd>
References: <20260428180935.806284-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6nlu4ntkvwulhcbt"
Content-Disposition: inline
In-Reply-To: <20260428180935.806284-1-longman@redhat.com>
X-Rspamd-Queue-Id: DDD0D4A773B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15568-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]


--6nlu4ntkvwulhcbt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup/cpuset: Clarify the delegation rules of
 partition
MIME-Version: 1.0

On Tue, Apr 28, 2026 at 02:09:35PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Creation of remote partition is currently not allowed without privilege.
> On the other hand, creation of local partition is allowed without
> privilege as long as its parent is also a partition root.
>=20
> The current setup allows a delegator to delegate an exclusive set of
> CPUs to the delegatee by making the root of a delegated sub-hierarchy
> a partition root. The delegatee is then allowed to create a local
> sub-partition underneath it if necessary. Creation of a remote
> partition is not currently allowed across delegation boundary without
> privilege. Clarify the partition delegation rules by stating the current
> behavior in cgroup-v2.rst file.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

After Tejun pointed out that other generic paragraph:
| This means that the controller interface files - anything which
| doesn't start with "cgroup." are owned by the parent rather than the
| cgroup itself.

I think the extra words may only increase confusion (and constrain
generic changes). So it was a good exercise but nothing needs to be
necessarily changed regarding this behaivor or its docs.

Michal

--6nlu4ntkvwulhcbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCafOxjxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai4FgD+K3fxQ2FEwOcBqVl9PaT8
KIsL7lXKQnwJxhqqS2tHkgYBAK02TDRypXPeVumVr9bS7i80Ptuo5uT9J97XU14k
DwUH
=iHbg
-----END PGP SIGNATURE-----

--6nlu4ntkvwulhcbt--

