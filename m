Return-Path: <cgroups+bounces-6378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C65A2251D
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878BA3A5D8F
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A3F1E2607;
	Wed, 29 Jan 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Emth7Wwa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NG3CJyhk"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4F199EBB;
	Wed, 29 Jan 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182380; cv=none; b=DH1ydflS84z5Ku8ynTerq4+93xJxF5nq/mRFtHMhcUVy3Fm3GuFjO3nkny7/hHp/cnGfq/GKs+TZO6moabN1RhOgwBwEm26cwCqnUiX8u4aaied+qxxviGW/9K83r/R+PUuR46+xLvx76fCrMuv0mLkbKKL3kB0yNX7qMgYng2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182380; c=relaxed/simple;
	bh=ZzTBJ4S8NH2JBrApvRfRDdJa2iXxQQn2OgC4RtZpal0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRcAcB532iiUTca9zukiasuqxUyMK7NLDNdBqk2H3HzmSDL7o9Tn+cQg5fCALGvFBX5bOF1mpyCbGAmWgBXnjmB16PQzNYfpEJv5QsxtnvOBVIjjYF37Dqt73eDmzLx7BKpduQhe8juc63hKy5GtpkIk2KDLTiQokrR+UOizyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Emth7Wwa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NG3CJyhk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Jan 2025 21:26:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738182376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxrufylIHVmiLcxoFZ4rxmZd52PUmvBZMWXYwV1ajKw=;
	b=Emth7Wwa6E5butQJe8mb+JhmtqAjB0uLD+bEfssGHSFJtVCtXM1VpKIuKA0RTEyq45PvIF
	n7EHdzBXwK+gKRDITJhkvHNQTgPtua6Fvg0xGLTCZls4vVkrAsrA0QtJJLgHYMI1KsYW/N
	vSFnVKa4cQtzutw+g04aBMgW0+dGcolI5loeb0+TXTfd4kphlwC7za/QhfMLywffublP7c
	FFAyjG4B0CIgiaMRnCToDnDJ8O8+nNG2QYva9GcouEvC0y5PXTDArMo1bbBfdfCT7BVcjt
	pr1Acx6oPdiGzNmUDMfiajyl+efPpqVVRKbKG/GzkFUTuvsS9yV0AvR3gwhPEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738182376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxrufylIHVmiLcxoFZ4rxmZd52PUmvBZMWXYwV1ajKw=;
	b=NG3CJyhk/0nxv0SvDEURUpxR8BvhNGcgJlM5P+BPKEcEGQvCQikX2u0hx7gJ1c2BtRheFD
	FmklU+7GjWZyS4Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>, tglx@linutronix.de
Subject: Re: [PATCH v5 5/6] kernfs: Use RCU to access kernfs_node::parent.
Message-ID: <20250129202614.eK7sf6Jt@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
 <20250128084226.1499291-6-bigeasy@linutronix.de>
 <Z5k-sxSKT7G2KF_Q@slm.duckdns.org>
 <20250129132311.rQM6LtB2@linutronix.de>
 <Z5pdSZ6akuLnfGMI@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z5pdSZ6akuLnfGMI@slm.duckdns.org>

On 2025-01-29 06:54:33 [-1000], Tejun Heo wrote:
> Hello,
>=20
> On Wed, Jan 29, 2025 at 02:23:11PM +0100, Sebastian Andrzej Siewior wrote:
> > > > @@ -64,9 +64,9 @@ static size_t kernfs_depth(struct kernfs_node *fr=
om, struct kernfs_node *to)
> > > >  {
> > > >  	size_t depth =3D 0;
> > > > =20
> > > > -	while (to->parent && to !=3D from) {
> > > > +	while (rcu_dereference(to->__parent) && to !=3D from) {
> > >=20
> > > Why not use kernfs_parent() here and other places?
> >=20
> > Because it is from within RCU section and the other checks are not
> > required. If you prefer this instead, I sure can update it.
>=20
> Hmm... I would have gone with using the same accessor everywhere but am n=
ot
> sure how strongly I feel about it. I don't think it's useful to worry abo=
ut
> the overhead of the extra lockdep annotations in debug builds. Ignoring t=
hat
> and just considering code readability, what would you do?

It is your call. I would prefer to open code that part that we do only
rely on RCU here but sure understand that you don't care about the
details and want to have only one accessor.

> > > > @@ -226,6 +227,7 @@ int kernfs_path_from_node(struct kernfs_node *t=
o, struct kernfs_node *from,
> > > >  	unsigned long flags;
> > > >  	int ret;
> > > > =20
> > > > +	guard(rcu)();
> > >=20
> > > Doesn't irqsave imply rcu?
=E2=80=A6
> > Also, rcu_dereference() will complain about missing RCU annotation. On
> > PREEMPT_RT rcu_dereference_sched() will complain because irqsave (in
> > this case) will not disable interrupts.
>=20
> You know this a lot better than I do. If it's necessary for RT builds, it=
's
> not redundant.

Good.

> Thanks.

Sebastian

