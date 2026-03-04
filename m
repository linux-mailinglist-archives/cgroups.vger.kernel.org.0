Return-Path: <cgroups+bounces-14601-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IOLFqU0qGm+pQAAu9opvQ
	(envelope-from <cgroups+bounces-14601-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:33:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6920079E
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 14:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A8F307C4BC
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEBB36826E;
	Wed,  4 Mar 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CVp1Ume7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF4366DCE
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630890; cv=none; b=rVF2yd81EGGstLoqEgHXAYsyXPTG69HS8Jrrh0Yy43ac0jFXNOgsGpNiEdpULFMFZVCRknVCYa3lf52PJUm5sqIydVq9QLP09nRx4goIKLJ2Mh7wB7+HNCtmYnmZO1foWEPitnO+FwISC9XlVS9kUEpQ3Cb83Hj35ORuQZKhcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630890; c=relaxed/simple;
	bh=aMv6Q7rF8rylp8U3RhhMMnUS3IIsKzvQISUOfqqw+6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUwN+YerjJBcrVEvlYSBIUD2jfn6ng2KacwBWgSMtUm5wdZs/W5qgsC2pobUqqtZOwhL2MGmcveNp6kS2WKppSt05IhvUBXmPqFC52FJfUECFZm8fxjiENZaH8Y+rXCZ4gJAptf3PlsrzqX3XUMdcoLdP3hap5udFX4gFzeRG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CVp1Ume7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so78032575e9.1
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772630886; x=1773235686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Bi/L/oEGmHblpGPXlfivThzSUKKZWyOv3lvM0x15gg=;
        b=CVp1Ume7LYZjC4dmWgiGQS8LgRNlH2Mk05vggUZuJnsHDpibCK0rVr1+ixVsjJ5wrz
         rIDNBDRFAq0hUgO0du9BjDefpqg9yE2FHEQ+svTDO7cJwuxBn90mmuIom8y9Msr/kCXY
         /okYGnnJVV3oV38/6vihqKC6Rp4o0bwW2zDfIM2ANv+LmN8fTwbcKvBhHXde6FjQGlbS
         +/oYksObO54CBCgOQIvtdE0egq8RzSNsRz33IFKro/3KKNdd8X02/xAr/FNzV/kpKt3i
         MYYUrf+dZOA+5FxByDAtr0zORdmBUMFC2ktDjCEorzDLiClY9jReRPSE8PFcBnQM9EYg
         myMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772630886; x=1773235686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi/L/oEGmHblpGPXlfivThzSUKKZWyOv3lvM0x15gg=;
        b=mwK1ZTZEFiC//HkZw2AHa8ZRo6vlQvQ7xL+6lhELIrE/hqi6bAqKtwhN8tbRtuKCzj
         cAJYYd2pPWffvdgAslYgwf3+A56kjxA/I312bdwBWsdWM/7A/YD6FOz9bRsvQ6I8RbBj
         zSrxuicW1FpXqVtfVMv80oiQ5dvZPHdmuWC5ypeveUxXjB8ih15cHu+Pdvz+Pxwu5mkC
         rTQr8BoAeESArrtVj+/fTxsJkPtRmiv8Cxl9BOOu0o82zorxPFQv8NcBxORNC6ijnjRx
         GJ5o3kHsq7q0JToHnvIMVME5z7/Y8Bni9tm1LS4i8HS7bPm6LRXGaqu1QBr9AG5Nisa1
         a4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVq+rznBkFq1QMaglMkCkYVpIcZ07x4z/gfkMtgpEnQRrOFPmO9CYvhN1kXVFptGWN0Ca5fBhGT@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSFCMwDdAvnQ486Y8UGugZMobJORK4gCv0QIk+UQUNQTALp4k
	x0Zu/TKa+MM3e//nMRDjrHOe/o/z6iUg6MwwMhN/F6YyDIXPox3eI1JqinXTHeeI/3I=
X-Gm-Gg: ATEYQzxIkJqXpLjvdUoeo7MEfEOrgflvsB0e9ucu9BV1PHUTMzmR7avSgrlT1iEyqYS
	gwSBngo/1vnVIHDMVKs3VK5FytEjQS2ZQa0JVqqEXcT1ukm7JwOPkGYOI0o4lPMGwi8dgC+e9Fl
	7MXmh843R6q1qlfVV5oFpBP75kWhkPnQ1868wfPTrFDSxB9EJPzqBCFiGk5dTxNj7AE9H4lXD7u
	04Eu9qhwUE1j0N+767LMNH0u0HdUWQRrt+6PcbKNo61PiUJ2IKZatde9Lil8hpFm9ijXzcmcjXU
	jtABYRpMKP0DdveiD6HjxGwJXeUyxGbx1NI7QH82Y6nlxhi0dnLw0Fm2kFgAENdMYLNRd1h2nEO
	xBLKQiWviZwUIUinQPs1D+PfYwkQlgAWi9JeV3u3Dh2V7AMqe/ZDJFsVM2g6CJuDQLc+y/3y6LG
	YeWXjmcUrfw6EM94HMqFrl/G1CCx9916FS9hGXfrM1Wx0=
X-Received: by 2002:a05:600c:19cb:b0:483:361b:deff with SMTP id 5b1f17b1804b1-4851986395cmr34923645e9.14.1772630886363;
        Wed, 04 Mar 2026 05:28:06 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884a7absm61338975e9.8.2026.03.04.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:28:05 -0800 (PST)
Date: Wed, 4 Mar 2026 14:28:03 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <poawwl44nvy4ru4mmjqi3kxfq7xqcpdeq6ghixphcrwhpv3bnz@xsltjt52rbqm>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nxh74vomtnyu4pvg"
Content-Disposition: inline
In-Reply-To: <aacehv3rpO9irhEG@slm.duckdns.org>
X-Rspamd-Queue-Id: B0B6920079E
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
	TAGGED_FROM(0.00)[bounces-14601-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim]
X-Rspamd-Action: no action


--nxh74vomtnyu4pvg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
MIME-Version: 1.0

On Tue, Mar 03, 2026 at 07:46:46AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > has not been modularized since commit 32e380aedc3de ("blkcg: make
> > CONFIG_BLK_CGROUP bool"), making the module parameter a historical
> > artifact. Readers of the nested-keys format should be able to handle
> > additional fields.
>=20
> I'm not sure what the above para means. Module param works just fine for
> built-in modules on both boot command line and through sysfs.

Yeah, it works but BLK_CGROUP is not a module/built-in it's config
option affecting builds. I find the module_param() in blk-cgroup.c to be
a residual, I admit it's convenient way how to expose a tunable to
userspace.

(Contemporary way of implementing the option could also be a cgroupfs
mount option/feature or maybe sysctl for which tooling is available.)

Thus I was mainly motivated by bundling this change with cleanup of the
module_param().
I may have misjudged importance/usefulness of the data (not using them
myself).

On Wed, Mar 04, 2026 at 01:56:43AM -0800, Breno Leitao <leitao@debian.org> =
wrote:
> My goal is to ship a kernel that exposes these detailed io stats by   =20
> default, without requiring any runtime configuration. The stats should=20
> simply be available out of the box.

Does it mean the information is useful to you since early boot and
adjusting the param with a userspace tool in boot sequence is too late?

Michal

--nxh74vomtnyu4pvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaagzXxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjOjAEAhTokV74oTWGcohq05aqm
lfH2g5jgBuFtolA560P/M7QA/j8Q1OrUyty8NX9aYpaRVG4ly9bp4yIu6YqWFHTc
d5kO
=YCCN
-----END PGP SIGNATURE-----

--nxh74vomtnyu4pvg--

