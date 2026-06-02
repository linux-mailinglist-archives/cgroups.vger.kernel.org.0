Return-Path: <cgroups+bounces-16575-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XfdtNJ4HH2rudgAAu9opvQ
	(envelope-from <cgroups+bounces-16575-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 18:41:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C508F6304BA
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 18:41:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UnGIjF+2;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16575-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16575-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04A4E3056BD8
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C536997A;
	Tue,  2 Jun 2026 16:29:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1DE368D68;
	Tue,  2 Jun 2026 16:29:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417742; cv=none; b=Hk0hO/PpTx9mCkB6Hsc8AcHDYAjXbt5n/9Fd3XY/N7ERSGxZxS1IRlnW0WUigTNLxOVPZiaUJueMrRbnToJwDRwqG3K/tRjYJOdMo/Dzk22mFyDbNwB+NpKjS+qx0DcBtWiOxDaZkZdS5L+AcpGgKZlOFaUfnCdCtNH5o8l/OaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417742; c=relaxed/simple;
	bh=wk6f1RNMZGFpHBLLaT2U9WXGrUJsj1HYdvrLHTC9yhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzZAorv6JAxnKXPtqEbtpcgvvwdbIYnZ7GGbyADEQBq2d6560ccufClJra0i34PVhJzESdylKS1Sustu8Vo9Xb4PoT6VNMIGHdjf//9cUbgWy5DDnOdUIND27XGIW/Zhp6LHTLLKEvRzLFwW3ThXy17Z59acFWt6AaQ/c0xIXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnGIjF+2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671521F00898;
	Tue,  2 Jun 2026 16:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417741;
	bh=wk6f1RNMZGFpHBLLaT2U9WXGrUJsj1HYdvrLHTC9yhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UnGIjF+2HxMgNMO34Ds47v+8hld+Ae35d7Z2UfDW2LlNEyewsrxPaQXB8TYTSyEzp
	 Ulx9/AUNvDiy9ZzL5Y9TKDnyNJLLEpCnYrnh9RyYuZeHk4lvlooeFNpGsighQrj4cj
	 6uynfDPfn1lADcYmw+idm0ICXIfMywl/ZS+9hhmrTTjF+2ph/DBxzz0n/FOEw42jZw
	 Y1CurnBqhRKOpgUkAkGHmCgYSm2UeRhi3NR1Z1TJEuVyU6Qesi364wJUerSyQP/Y5F
	 Xfk9xuK0oPQNsxTiPey2+fWHXIwn0ertVqXpqIhOse56Xho7Ui0rYTOE3W1iGvTKek
	 NfWOn0ZndTQuA==
Date: Tue, 2 Jun 2026 17:28:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH] cgroup: Migrate tasks to the root css when a controller
 is rebound
Message-ID: <67814774-0047-4800-bf83-dacd1aabbf48@sirena.org.uk>
References: <a9f6c0bcd262e764453b95eb7397871825e11559.camel@web.de>
 <20260601190256.1815778-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QJuGK6nEyPZOqIrU"
Content-Disposition: inline
In-Reply-To: <20260601190256.1815778-1-tj@kernel.org>
X-Cookie: The wages of sin are unreported.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,cmpxchg.org,suse.com,linutronix.de,malat.biz,intel.com,piware.de,arm.com];
	TAGGED_FROM(0.00)[bounces-16575-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[broonie@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:spasswolf@web.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:bigeasy@linutronix.de,m:oss@malat.biz,m:oliver.sang@intel.com,m:martin@piware.de,m:Aishwarya.TCV@arm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sirena.org.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C508F6304BA


--QJuGK6nEyPZOqIrU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2026 at 09:02:56AM -1000, Tejun Heo wrote:
> cgroup_apply_control_disable() defers kill_css_finish() while a css is
> still populated, relying on css_update_populated() to fire the deferred
> kill once the populated count reaches zero.

This seems to fix things for me, thanks both!

Tested-by: Mark Brown <broonie@kernel.org>

--QJuGK6nEyPZOqIrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmofBMgACgkQJNaLcl1U
h9C/3Qf/U6vSoBdg/oBAW6QotbrNc+mcWoUPG5cF8zUT9gwATTLVB+/HxWz7fv8h
6njeOaxQcuaEhOu18G14Je1Z40fYv7xdAYhP5tqKnvzpNLIF3BQ+VobRJfkaFY6l
C/rsIBCZ6Sgqo8GGj3JWzAyDNNfBj08naASnFgWYmdjiYfWgwM/yyz4Y8RfArAcp
d9t3MJbxMJA7JwDNp/E7fD0Z7tt2cdT7RN2cL4PDvGykXNKQKg+dmJLgDXmwmBgw
OLjxcFwINUyM2hP5g/vH/FpcPszb7Lhhhyt0V8N2W5ibBtGLlivL6+B3s2C/33Ph
ciOWix3bmvo0cicv9zreQdPC0pD9Iw==
=9TCH
-----END PGP SIGNATURE-----

--QJuGK6nEyPZOqIrU--

