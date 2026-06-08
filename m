Return-Path: <cgroups+bounces-16733-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZUTiI1fOJmp5kwIAu9opvQ
	(envelope-from <cgroups+bounces-16733-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 16:14:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9B657070
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 16:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EwCsxTGn;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16733-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16733-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB2AF305F56C
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04B3C3C02;
	Mon,  8 Jun 2026 14:04:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DF3C345C;
	Mon,  8 Jun 2026 14:04:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927482; cv=none; b=tNINVepVe8X25u3+3Z5GgUOvzXE8Gq1IYjBRDCzVO++JPkG+yoEaqdJ887ph4KeHyadgajtlP2IdPrD0rYkbJBQAUFFYOPiIf4B0KnubLcAn39Na0N8vWgA48vp0hXxS0Qh1qZbNvX+vVBW0X07RGlAAvEqWtDYaslgYFB7sXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927482; c=relaxed/simple;
	bh=YzXEY+QME7Drg3ANHA5+1O70COZoy6++FTXF2gCXf2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz2+1zMqvc8mPELGYZQsvEPYw7G7RJRo8bL+11zHg/NaAadTFD2/7x+5l68j2Ndtkho6h9XiaxZgihhBo7cxneV7uGynOmyMfi9gCPZwU4f6RX0exd07nfFqYNQyx5SWrTnrnW3EYXrOQl2qa8ijFZkK+mp3TULbwuR7OIkRFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwCsxTGn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582121F00898;
	Mon,  8 Jun 2026 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780927480;
	bh=YzXEY+QME7Drg3ANHA5+1O70COZoy6++FTXF2gCXf2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EwCsxTGni2jw4w6ZxN2s4lk+aJCdkUs3h567ZxrelQLG1u4OJVeSqEsuBVo/Fr4Ba
	 rkdps6zz9CTD9Zeaz2F2XmJy9uBfg+90Eicyl0tskMCV3Be5w/+H5puhF2Anpdlr2j
	 /ae4dJ6Qgn3asGFH7Hp5wcgrTYuMKNEnCy29wr6Lo64PZXSr34LZAbBhN7Pf9vUtZZ
	 jeCEEyzac/bofh/Tzu8NDd4eAydKANDVNiOD6ICMIuoSvi23OWJKhprOLZ9b48IhtY
	 edx8ze2oUvpREKe7SBnfnm5i3ID2KJ1pTRwynJm1GHh7RkOvcJ8NV5ZTwPw/euUEWH
	 UgPJzLeNjtneA==
Date: Mon, 8 Jun 2026 16:04:38 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Natalie Vock <natalie.vock@gmx.de>, 
	Eric Chanudet <echanude@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
Message-ID: <20260608-rational-cuscus-of-enhancement-eecbfa@houat>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
 <20260608-glorious-fluorescent-salamander-93daec@houat>
 <15bab7c9-0857-40b9-963b-9923c0e7392c@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="44pqtk3cwl47v2we"
Content-Disposition: inline
In-Reply-To: <15bab7c9-0857-40b9-963b-9923c0e7392c@lankhorst.se>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16733-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,patchwork.freedesktop.org:url,houat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EC9B657070


--44pqtk3cwl47v2we
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 03:13:56PM +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> On 6/8/26 14:42, Maxime Ripard wrote:
> > On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
> >> Hey,
> >>
> >> On 6/6/26 18:31, Natalie Vock wrote:
> >>> On 6/6/26 00:44, Eric Chanudet wrote:
> >>>> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> >>>> dmem.low files.>
> >>>> This changes the UAPI that otherwise accepted multiple lines for set=
ting
> >>>> multiple entries in one write. No existing user is known to rely on
> >>>> writing multiple regions in a single write.
> >>>
> >>> Ugh, shoot.
> >>>
> >>> For dmem.low specifically, there already are some userspace thingies =
floating around that may write more than one region/value pairs.
> >>>
> >>> These thingies all depend on that one patchset for dmemcg protection =
that I should really get around to merging[1]. Since the userspace utilitie=
s depend on not-yet-merged patches, they sort of have to expect stuff chang=
ing under their belts, so I wouldn't really consider those users a blocker =
by necessity.
> >>>
> >>> As I see it, we could go down one of two paths:
> >>> 1. We go ahead with the patch as proposed, and I make sure that the u=
sers I know of adapt. Could be a bit icky wrt. "do not break userspace" rul=
es, but since the already use non-merged UAPIs in one place, you can argue =
that these users kind of have to expect breakage.
> >>> 2. We use the old handling allowing multiple lines for dmem.min and d=
mem.low only. This preserves compatibility but uglifies the code by quite a=
 bit.
> >>>
> >>> All things considered, I think I personally would prefer going with 1=
=2E and taking the patch as proposed and just having one codepath handling =
every limit file. Just highlighting this so we don't do it on accident.
> >>>
> >>> [1] https://patchwork.freedesktop.org/series/163183/
> >>>
> >>
> >> I prefer option 1 as well, but would like an ack from one of the core =
cgroup maintainers too,
> >> and what Maxime's opinion on this as well.
> >=20
> > Option 1 works for me too if doable
> >=20
> > Maxime
>=20
>=20
> I see this as an acked-by?
>=20
> I'll commit this patch to drm-misc-next if so.
>=20
> Fortunately it may not even break those scripts in the typical case
> where only 1 region is registered, eg the most common laptop/desktop
> case.

Natalie had a bunch of comments afaik, so I was expecting a v2, but if
you intend to merge it as is, you can add it if you want.

Maxime

--44pqtk3cwl47v2we
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaibL7QAKCRAnX84Zoj2+
dheeAYCNOYNwu6vtvfr6+oGxHjIg7iVjIzEMEOlZFZlUZkQxiFXytzEiVsuMvKWd
IGFxwf8Bf0I1+MUeg5BHtyLRGmUKCFTkxAOovbpUDc8nsISIUCX1R5lXD2do1N8I
V3vO/k+zdA==
=RxhS
-----END PGP SIGNATURE-----

--44pqtk3cwl47v2we--

