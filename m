Return-Path: <cgroups+bounces-16553-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD5OLxGOHmodlAkAu9opvQ
	(envelope-from <cgroups+bounces-16553-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:02:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D7062A0BA
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 265AC3036BD8
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D31DF261;
	Tue,  2 Jun 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bLmcq5eT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F43B6359
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386682; cv=none; b=mXVLM8W6yMj74huX/KyY82lt0EF/soywFgsksmhxQqFfIFa67Uqmbtc3BHUgLlFvvwhpw9aGy1K6N8tdKORtE5gUCZR/+tDeALeQtU7LlVK2xI1Da1SMixd5EiD9MEXRHj6SbUpUm7g3ypr1/mXmAmacXEKP+IbZxIMN2vWTZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386682; c=relaxed/simple;
	bh=bLfgtpmyk7H4tM28NBdJZWspfVacy0rgl7JXoHdfSVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3IdQA6MKh7ukWEkQGDNMmgogmxsYQuHHsQuJSzNRlVY43TyYhtuPL0qsoF/fUCwp65/X7hReyZhfrm/Vlxw3+ytZ3va4WzICocNQmKbItrhLywQ5juGANhjCG2d/i/TngTEsEGQsHyFd8FPkjiKTEQwj+A4/rO0hlftD/Z3HOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bLmcq5eT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so1766035e9.3
        for <cgroups@vger.kernel.org>; Tue, 02 Jun 2026 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780386679; x=1780991479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W00V7S3fS4F3AUKyzQJto2Nj7nkpcT8dXMMgU8f3hkI=;
        b=bLmcq5eTVee31HNfJq13BXHAfO49s05WdbgNcoz98n4NVmCHB8GM+VSmzDJk1WxZR/
         E24kdmSGWi6SBlE4AcC+FiDATnQqazEgPw48ccXxpvFfcQJkbNsSEzQKjKEYcTln/+fQ
         +f6HyI8OwttuQbEMwBV4+nf7z2PzEIYB0c+b9qdQOpPQuunUCJ8G64Bik/60NyfIG0NI
         KlVklC5rnBMqCaU48b2Yoj8DsPguYaphEUrbitEa7oZets9HvsAWeUw2BY1q12gdePML
         nMRp6VAn0C9/bM66wLV+aJht15P9O+tEdnN3NWS6d5kQrKl6/YOHoftDHmWuvRSYAXVQ
         vJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780386679; x=1780991479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W00V7S3fS4F3AUKyzQJto2Nj7nkpcT8dXMMgU8f3hkI=;
        b=nh6hQke4djqs25bVP4KC4pmVYLkTDvTvsnDpQCSTwXMDbr37ixw8Q1vfCj3aoIzEMD
         MRNU6mmZbxdSEecWejTeUl8w7kZfkwDIuDy/01Ztu8kgNdAooWOijhSHnGyOlNFqTmoS
         T9UYuHPtGulTthK4j6eqQwN5CZBH13AnZW4XGYcqSjv9qqngvKKiey5xrBo1S4sPFeOl
         D8kbVz+5bl+ffAsyjPqchnY+/FGliTRHOmqUGxbI7QtrlIKt86aa7P/bpsWtunOp3fLy
         1I29p9gjgj/FYBG11b5XF+C0gSB4/QaSjpKMgP/bGnW80ocXLi14vt+xT/QmGxXKL3pk
         nEkA==
X-Forwarded-Encrypted: i=1; AFNElJ/kzR7Qay/XSpcjRfTUvCc7Tdd3ap4TxFt2VoedjodHMY5qsqmf3viNtALOLVAtxxbSXyqw2HEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YydT982Td+EvnuyvGlmYZKjQzow2nU7CDI8Qt3TueUDEUV/KDP1
	K7Q3lPiFbXTmFvQ4R0+X1L8xFPoSEM9CDMfuhOEEesSOwacVWr7DSnQaYy8HWK9VJQE=
X-Gm-Gg: Acq92OFy2IH8TQb5jor7IKGpz5E7BrSYWeZM+cRBzwgVupb9mWgChQdg16k+9XDeC10
	e27Ro0EakngQaiqN9jNnE29QW23XMPWP947G7CiFzgvBb3P+9j98k/7XzaldwLQ4aA2hm7MEyax
	xHleWNI7Psm1pTO0TACcPcv0IDYCEGuj+fGoUG5T1hl5AP32vcbCU6sshsfGaerEB3o5S+sOAz9
	rlV7DUOfJU/u4HC224rYksSFrVrbM5gQ0WCx7/nHmypKqT1gJhpMf1Aq2TQA9Q+zNkeDBCix6ej
	5RzkzMIKJmus4SnYwTFyhhScoj2wBS1Ig5NfDWa5gaxwQTiiV838scVfI0/kfQM5+xJwYevMuJb
	T5lYdhPpBu3Keb7FpPlnJIVWkeGKeuk4epwcPkUU3x72TBr/p5SRkJZIRfposOY9FCG2RW1VVRp
	qkxIrMdcHyNRmICDe/O/h7RBKPprbWhVXqtXVHAuk=
X-Received: by 2002:a05:600c:4755:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-490a2932eeemr241830795e9.17.1780386679010;
        Tue, 02 Jun 2026 00:51:19 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm74205175e9.7.2026.06.02.00.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:51:18 -0700 (PDT)
Date: Tue, 2 Jun 2026 09:51:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Remove Chen Ridong as a cpust reviewer
 for now
Message-ID: <ah6LAfpMsdPLun2_@localhost.localdomain>
References: <20260602024422.249458-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mywz6rf3bvwvqbq"
Content-Disposition: inline
In-Reply-To: <20260602024422.249458-1-longman@redhat.com>
X-Spamd-Result: default: False [1.24 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SIGNED_PGP(-2.00)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16553-lists,cgroups=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.com:s=google];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.074];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:dkim,huaweicloud.com:email]
X-Rspamd-Queue-Id: C4D7062A0BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5mywz6rf3bvwvqbq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: Remove Chen Ridong as a cpust reviewer
 for now
MIME-Version: 1.0

+Cc: ridong.chen@linux.dev

(This looks like their new address.)

On Mon, Jun 01, 2026 at 10:44:22PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Chen Ridong has contributed quite a lot of fixes and cleanups to the
> cpuset code. Unfortunately, his email address is now no longer valid. So
> remove him as a cpuset reviewer until he shows up again or someone else
> volunteers to take his place.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74c86cf9bc65..c7a7126ea406 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6526,7 +6526,6 @@ F:	include/linux/blk-cgroup.h
> =20
>  CONTROL GROUP - CPUSET
>  M:	Waiman Long <longman@redhat.com>
> -R:	Chen Ridong <chenridong@huaweicloud.com>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> --=20
> 2.54.0
>=20

--5mywz6rf3bvwvqbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCah6LcBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgWqAEAnDBEsVWh1LVj4ytHLipk
1qdlqhjpw5eeBrcW4msFFl4BAI9yHBhXWA0n8f3Q/QY18+dkP8gwLizPK7gBheSY
RRcL
=bNM5
-----END PGP SIGNATURE-----

--5mywz6rf3bvwvqbq--

