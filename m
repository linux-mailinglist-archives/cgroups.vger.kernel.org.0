Return-Path: <cgroups+bounces-16463-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bbpbMV4BGmqQ0ggAu9opvQ
	(envelope-from <cgroups+bounces-16463-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:13:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B8608CC0
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321D73035A8C
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9042EEA1;
	Fri, 29 May 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWTQgkW7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFDC428472;
	Fri, 29 May 2026 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088917; cv=none; b=eVB8B4q3q0La6pJa4FTUp1ZdSOAR1HaT+942a1FC3Qcxy6g2TtbMvKKMbBTSgGiqnds+v2xbX9jARWqfuRuGJGvu/+O3ACFeHRGLXibb77EteVvKWwOc3H2MszfWJnODhohxz1bk8E54DbFbYzQRl98Ueo3HCTLhczGhfumRpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088917; c=relaxed/simple;
	bh=J87q3rQeI0jr5y0o0srKBS8JvgOztJeG40jCLPOqkUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNS+SWxOsqWZ1p2bWdWXTJiwwNbOdlVIumpT2CTC8rY2ad2aUxWMZ5qvJbIL4kqD7Vh1Ph7Jw4AoQJvIPb1gE7QGxJss3vakUdouSdV0Y0+PmHvff/5I5JYyoSyehgogvr0KObRtdRPMxATKGryw/qBcJEbaWWvm5LftiNjX6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWTQgkW7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF501F00893;
	Fri, 29 May 2026 21:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780088916;
	bh=oXRQFhMUdUjDktCpMqtDUPR43iyuZzvdvzSf4NQyNLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KWTQgkW7NOj5UOxnT/VdzhaMufdawoVZMxKxjwJRQX26SnqF7mAUulryrT1nvihDz
	 +RO7ovvYDb7VjK0Ukd232Tl0xzMQ+jZ0d8/XvirvAJ2LOa50KbwcElFIW92P9gU9E0
	 i8jZLat6D0aGUsHJXLT/34Rfnnd3qZWvLhaUnxifXs0f3ABpm0WanxTU57IE4IoxnR
	 4rD1lcRcAxqtDELaJxMFNx1XzU3ohqjYGpk3Fd/tLkUXWppyRXEdWJib9mBMenClIt
	 GkJf+p7eB+m1CJIEM6C3NJtvgSgVgb1MY1Hj9FxED4L4d62UyCL5SVKIODvQ7fdgLh
	 T/fWFyF0UnJUg==
Date: Fri, 29 May 2026 22:08:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>, Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 5/5] cgroup: Defer kill_css_finish() in
 cgroup_apply_control_disable()
Message-ID: <fd72aa26-4fed-4fcb-b4b1-d7ce9d891fe4@sirena.org.uk>
References: <20260505005121.1230198-1-tj@kernel.org>
 <20260505005121.1230198-6-tj@kernel.org>
 <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
 <ahnMCQuw2K6zA3Hs@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UIuDOOq5as0cju9d"
Content-Disposition: inline
In-Reply-To: <ahnMCQuw2K6zA3Hs@slm.duckdns.org>
X-Cookie: Equal bytes for women.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16463-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,arm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 1D9B8608CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--UIuDOOq5as0cju9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2026 at 07:25:29AM -1000, Tejun Heo wrote:
> On Wed, May 27, 2026 at 11:45:54AM +0100, Mark Brown wrote:
> > On Mon, May 04, 2026 at 02:51:21PM -1000, Tejun Heo wrote:

> > with no further output and given that this is a cgroup locking change
> > this does seem like a plausible commmit, though I didn't look into it in
> > detail.  Bisect log and the list of LTP tests we're running in our test
> > job below.  We are running multuple tests in parallel.

> Unfortunately, I can't reproduce this in my environment. Any chance you can
> try testing on x86 tooa nd see whether it produces there?

Not readily sadly, I'll see if I can figure something out.  Our rootfs
images are based on Debian Trixie if that's relevant?

--UIuDOOq5as0cju9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoaAE4ACgkQJNaLcl1U
h9Amlwf+J+MqoEoCvHT2GaEK4Pv45h2WTkU8lCea4P0U8LloM+a0TmHj70ToYuFH
fW7TOYWGQr0NiRLc90j0uEGyGZrH59YayXXDlBUiC5FzmHWUrTq70EF+aUzmmSgS
w2EvyKJNwyEnlivalNEvYouo7hzGOa+NztPy8BwRDesJ/FloEA4QYmupQp3zBMmy
vRGqF9tUG4+SLFhXM0FzEIinE7RknUUQ++TmXvDXa38Ci5m9vf9C76zpAErHxP1u
0sbLUfvnP7c2hyVzs2h6R++A/t93/uTJ3kk7Z3g7c+/ikHZ0fWH6UOnDCzk4+QY1
gYpBoxTuv0U6eXGi5CBGLrCA34Kl3w==
=M71S
-----END PGP SIGNATURE-----

--UIuDOOq5as0cju9d--

