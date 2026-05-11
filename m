Return-Path: <cgroups+bounces-15758-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI56NDHVAWryjwEAu9opvQ
	(envelope-from <cgroups+bounces-15758-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 15:10:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7696C50E9CC
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 15:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C745430090A1
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71653D5244;
	Mon, 11 May 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YzgPXJno"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176C3A1CE6
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505004; cv=none; b=iW0btAsHdDHX3Foo2tHz2tP5TVED9F6TKOw4ZnhUhWXGkIimBwYkIU6MPkaZNULhTaH6jdOO8MS01m+kKPXJw44WbIMhX/3YBer69CmRlxkCldakyQ1R3jAWc3kC2VcfmOcZyFLw6w9Q4gRWcfhIJRAGSheDTDb6Pp+YMs1HUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505004; c=relaxed/simple;
	bh=GWm6vm9L+1+CWy8XH5q+06J71wv4EZlJTePk3pg2T8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0cmEBhoVqMwFKSroxo/UDSb6KUBDRYimlbaE95rekVeS090npFD2hC39h460YCkwgGHbvU/J/fO89uoQCH/nK7eAP4d6GuVsKf4ldVPyfprpn/YAXN/Y4SMi0vG19TRz9mfMoSDJjoegBSA/iva7d4PxDbbPUfwMtVkO64BXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YzgPXJno; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso51169555e9.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778505002; x=1779109802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWm6vm9L+1+CWy8XH5q+06J71wv4EZlJTePk3pg2T8E=;
        b=YzgPXJnoEDgAmdgViI2QYx4RKMSjlXffWneTfQuz8f6jT6DmEtE6+DoA5YzkhkmeSw
         reIMCGs3rorv6FBXCIn2joN4o6g9LNyab/Z4EuUcrd2qatLR+ECmewBColNw/x3RU+4p
         LdVP2bQfHpJZEHd7XM7zHIUyoxbN9SMYZwVbR6g2JA26Le018aB12wxNTbXTNnkkFtzv
         NAxOjlU+hh1+QPQX0foh+LtFBXKOmcFLejS2B3rCBnZ5+vjW+7POVCHxsO+D3QeBaDaa
         D81v4MpaE3Y1V97eGefVxltrEkwEwdUZIUE1IxLCFRZobdxAhK2y8EsitElU69k8Amx1
         2+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505002; x=1779109802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWm6vm9L+1+CWy8XH5q+06J71wv4EZlJTePk3pg2T8E=;
        b=E1lIgKiGU+JWRd8Mjxlq9iuBRj6RVAa1gsvAHWRFsqKblS1KlGMHD0XONQbJb0+Qx6
         OzqrCELkS2101wtDDjS/jb++h1FRKTb6/6axYCznG/9FaCTdbCzrRT6Vl4apComLIEz2
         kGygsYRMSN8mhfrTFDelDhvYCQwvPpLwGxlzWEZaLFMyNKUKgG2bEFR5o/h5YREptixK
         gTv6BClvHRkhjYCWZLeK6TNEl4mthTk+kNnvScN7uGGD4gHQLsM7FgeONSl46ccjAyIq
         mFKVMnDM2NC3dLQewa2wOADNZVMWQJt3Mnlss8TLCrTEqpdF/bFvQR8Tw9BqSRJtD3SP
         NIsw==
X-Forwarded-Encrypted: i=1; AFNElJ/NDo4KdPr+vTRg/OgYG5ced9LO3LXgU74ay7Od0ko5y6lN2HjUTyyrq8WUY7YVA7Y4Nql+g60r@vger.kernel.org
X-Gm-Message-State: AOJu0YzJoPxC0JrGAxAg2aCKv6XFxNoUPOxc6Bw+F7O9cye00QLYvGeG
	AvJP1iLgxoXOAzBfdAxaAxkImvCZIbsnG0wBTd+eFgkPGKIwLNYL8lsU7El0oiojDQ4=
X-Gm-Gg: Acq92OFAI7zXIf5GJAeZilEomldU0SE7PW4fm1+fa/MrLHxo4MPxmX5jTv7+zOXBsGU
	sWUOSCMQr9rpcK7C6G8NUilYJIp4b+ttRVDtCSeg/Viup/6oqDtggcrSIlXGWKev+vbB25mi3S8
	RrPHKIIaW4rGI5qYgPz1VnZi1OXmIINhg7I0zUGxnbGe4lnclLinSmODvi/MgeLDYwCqN0gz4Dt
	TAgguPK3HdJRFRHBGzCwtSntZnzvgvcbr2dOqh8UuM7sdfd7ccTyTIxqvHl1cEGfys46pYZIFZP
	npTPlEpLbSAuZu6fiV/FpVVESqYN9ErPfwEAKRAQuXAgas9+J8Xfmd8vWU2c9kZfduiFCBwG9ZL
	/RFbAdX4+vb39hhxPq78FXXdVGv5AYRWJ58JTaJN1K/9wb8KHmXpmR8hlBDdFs50JUR7sE1emz/
	wVuBNvnhP5WpbHODJc3SUY496A9dloNVVKpgJpK0j+pvkHv/eC
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr280400975e9.6.1778505001601;
        Mon, 11 May 2026 06:10:01 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1742asm64148915e9.31.2026.05.11.06.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:10:01 -0700 (PDT)
Date: Mon, 11 May 2026 15:09:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Wandun <chenwandun1@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, longman@redhat.com, 
	chenridong@huaweicloud.com, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: skip hardwall ancestor scan in v2 mode in
 cpuset_current_node_allowed()
Message-ID: <agHU1t2o2EMkj_Oz@localhost.localdomain>
References: <20260508062940.4094652-1-chenwandun@lixiang.com>
 <202d0aa0f8da75986a895ffbd564b78d@kernel.org>
 <92eebc24-9612-4ea3-9bd3-da4d437b4d81@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="us6xqj4hph2s6uaa"
Content-Disposition: inline
In-Reply-To: <92eebc24-9612-4ea3-9bd3-da4d437b4d81@gmail.com>
X-Rspamd-Queue-Id: 7696C50E9CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15758-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Action: no action


--us6xqj4hph2s6uaa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/cpuset: skip hardwall ancestor scan in v2 mode in
 cpuset_current_node_allowed()
MIME-Version: 1.0

On Sat, May 09, 2026 at 05:36:39PM +0800, Wandun <chenwandun1@gmail.com> wr=
ote:
> > is_in_v2_mode() is also true for v1 mounted with cpuset_v2_mode, where
> > cpuset.mem_exclusive / cpuset.mem_hardwall are still settable. Would
> > that be a problem here? cpuset_v2() looks like a tighter fit.
> You're right, it is a problem.
>=20
> Under v1 + cpuset_v2_mode, CS_MEM_HARDWALL/CS_MEM_EXCLUSIVE can be set
> on non-root cpuset cgroup, so can't directly return true;

Ah, sorry missd that.

> I will fix it in v2.

Thx.

--us6xqj4hph2s6uaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCagHVIxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjcVAD+Lisuh01JV5aKUXAdIKEB
5pnDtvIxOuzUkZUEryoJZ3wA/AhD7s5c46iQhZ6yAvx95t9JURrPVFn477mrvkBh
0UAE
=AmYt
-----END PGP SIGNATURE-----

--us6xqj4hph2s6uaa--

