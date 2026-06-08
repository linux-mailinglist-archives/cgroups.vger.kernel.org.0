Return-Path: <cgroups+bounces-16728-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O3VfFbq4Jmo5bwIAu9opvQ
	(envelope-from <cgroups+bounces-16728-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:42:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD9656486
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RxCqkpfD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16728-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16728-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D5C330131F4
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0DD372071;
	Mon,  8 Jun 2026 12:42:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A86372EDD;
	Mon,  8 Jun 2026 12:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922542; cv=none; b=OelDSlyDXDGosZDkwGo7p8vft9hUELMVU0TBTYf/0OAYYqT0x5MsAARSFiwusqJTa0geHyYgo1s3tv7AkT/3F9R/0mvJuGScDL3Tmj7MjFpVN0F6KFraR9fWSsCKtEsYe8J6qLDx+QSYXJYZ8U9f4bKcP+QDv7l4ecG+9+zkLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922542; c=relaxed/simple;
	bh=vLaVLICk2oe4ISqtVdPrHK0C9aAoO37wlzmXljjTcj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auts2FJLVQZJ7rgkNlZu1G0v5Ldx8fv8PP1TZm7AokTS+9sAxTjkxD1/2kAQLIHAnP7GUugC/mJN9AQ0lUlgH010TPb53afDGgdjD8FN+BzCNzLU+/nO5bvU4QFYFb7T0Dozqre6BjMSzkCENo/UZA3QsZGrlV7n0qM+TzsW0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxCqkpfD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A9F1F00893;
	Mon,  8 Jun 2026 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780922540;
	bh=vLaVLICk2oe4ISqtVdPrHK0C9aAoO37wlzmXljjTcj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxCqkpfDbtZTmk/0sYjPbrwF/SlaRm/qRYvBpg7H0oHhCack+QaVRI+puOmv3YAxz
	 FcAWmyoJRRyHlzp6rhpXpc+puLtL01HKZF9Ogv0Un9tfUHoWK+bkMTQrKLbr+k1nKR
	 ezptbklHPxfXeqoTp50RpkmwSnypd/DUiJGkH7RIzbDUXmk/oLnsKoFOU3xHd2K3Ke
	 LtDhEbhXaFbN4dzPJHSyLhCT9yti39m2KBXStxAB4H+T/Djq4mLfKzGOOmUOs+6wVP
	 8l+uYl4FGhKkMNJARfp0h4tz+weRpPHOOZ/ltRinrAql+Tw9Qq/mI5lN04ChLa9+Ye
	 1O++vPssIJiMA==
Date: Mon, 8 Jun 2026 14:42:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Natalie Vock <natalie.vock@gmx.de>, 
	Eric Chanudet <echanude@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <20260608-glorious-fluorescent-salamander-93daec@houat>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yiowilux2t2cndhw"
Content-Disposition: inline
In-Reply-To: <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16728-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,redhat.com,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:dev@lankhorst.se,m:natalie.vock@gmx.de,m:echanude@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mripard@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,houat:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7FD9656486


--yiowilux2t2cndhw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
MIME-Version: 1.0

On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> On 6/6/26 18:31, Natalie Vock wrote:
> > On 6/6/26 00:44, Eric Chanudet wrote:
> >> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> >> dmem.low files.>
> >> This changes the UAPI that otherwise accepted multiple lines for setti=
ng
> >> multiple entries in one write. No existing user is known to rely on
> >> writing multiple regions in a single write.
> >=20
> > Ugh, shoot.
> >=20
> > For dmem.low specifically, there already are some userspace thingies fl=
oating around that may write more than one region/value pairs.
> >=20
> > These thingies all depend on that one patchset for dmemcg protection th=
at I should really get around to merging[1]. Since the userspace utilities =
depend on not-yet-merged patches, they sort of have to expect stuff changin=
g under their belts, so I wouldn't really consider those users a blocker by=
 necessity.
> >=20
> > As I see it, we could go down one of two paths:
> > 1. We go ahead with the patch as proposed, and I make sure that the use=
rs I know of adapt. Could be a bit icky wrt. "do not break userspace" rules=
, but since the already use non-merged UAPIs in one place, you can argue th=
at these users kind of have to expect breakage.
> > 2. We use the old handling allowing multiple lines for dmem.min and dme=
m.low only. This preserves compatibility but uglifies the code by quite a b=
it.
> >=20
> > All things considered, I think I personally would prefer going with 1. =
and taking the patch as proposed and just having one codepath handling ever=
y limit file. Just highlighting this so we don't do it on accident.
> >=20
> > [1] https://patchwork.freedesktop.org/series/163183/
> >=20
>=20
> I prefer option 1 as well, but would like an ack from one of the core cgr=
oup maintainers too,
> and what Maxime's opinion on this as well.

Option 1 works for me too if doable

Maxime

--yiowilux2t2cndhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaia4qQAKCRAnX84Zoj2+
din2AYCvqKvH/o7VpqQLqfHK9E3iomJjqu4qZHf9t4cZBA2j3r33qyhweWWRiqFh
ZSIh91cBgJmqTLmBkpwO0jzWVfoU4+3DYvBPepU6Qh/cFc65rF7hZPAcicvpRpDO
cWm6LjUb1g==
=OpIe
-----END PGP SIGNATURE-----

--yiowilux2t2cndhw--

