Return-Path: <cgroups+bounces-13634-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJKONfTTgWmnKQMAu9opvQ
	(envelope-from <cgroups+bounces-13634-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 11:54:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBDD7FBB
	for <lists+cgroups@lfdr.de>; Tue, 03 Feb 2026 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 119F73043228
	for <lists+cgroups@lfdr.de>; Tue,  3 Feb 2026 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A0327C13;
	Tue,  3 Feb 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T08FQ5CB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979C2BE620
	for <cgroups@vger.kernel.org>; Tue,  3 Feb 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116079; cv=none; b=LFckBUPQcAtkVmozjNvMSO/b312hyErrDeO4HvPBFThVAU5xvFqkgxN8C6u1qZ6YNHXAcvFBH6egpxu281fmUW0CP1QLBlrI4vGlVfqghDj88drsH9Fe8qO0cV0RtXVK9M8Fw3be9+dNWREKcVYyD3jsGYKRM47Z+MLJlHzU3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116079; c=relaxed/simple;
	bh=ZH71Nu88hsHG5/zlGLW9UgyzVfa1zeDXINj5mHKRrmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYcFB5k4D+hL9DxGFLh42vUVWhYh+Qth1tkJEvNaSqh3Vql6pOGD1BWe5xT8p6B+fds+OQvYdrC0atuByQUEdKOhji3aVqOAYywFcfWOFylhjx4kH6XGyqrqmoP7PUHyei6Qdf/URqLLX+M1uhklPkLe12WvU7M3M+qT5w4eMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T08FQ5CB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso41979735e9.1
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 02:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770116076; x=1770720876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XebVXPSNdMrxJAnIqGRVfZUx1GAqbd6tkSOPzi0fCbQ=;
        b=T08FQ5CBYfkbD0iHW5HaKVN11vqTjVQhlR1+fZWHfxWmOEWycVcdFxEi+XU2Cq03d+
         OFKEt7Ic2xC1IJ7exHCHvQ3GeI6pxu7jOSWKx210o84u5CNuAfH5dOU+RoVfLwWoTGwb
         ac2Pz8wSHPij5xp8HqsATikAknqY7ro9LN6oP5Qb5aYW5XorlZ+y61y1IsfUbtGJYJz/
         Q8QE4VyfSDaPpemO19IW+9k0Hz6dDVT8e9TNxNJc70Xa0c1D24QWgxi0J2vMn3ohhJwO
         YG8WHB7IIuP8fbRudUmFF6P8PVWK6frbM75riNNr0lVUDriRhlgVEbgQ25llT70aZoHK
         hopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116076; x=1770720876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XebVXPSNdMrxJAnIqGRVfZUx1GAqbd6tkSOPzi0fCbQ=;
        b=Bi+Fkddp21/iyyX0knVP4lYDqX3vNPahnYU2TWUbKTiHRFK7X+MhZ5Zh6SK9Qmbrj3
         1xrjWVBTmsLcaH8mK+S4eeYixsbQwiTZnUjvgshx6lh2vawJl8Yqmzj5KC0K9HusZ5i4
         MAm5Imw12nwhXU3cG6DOWIjcWB9BE3/IfZ2ZzAsvmG/NyLfNff70vAxyxxV32gSKN6ES
         Dv5NIF1fKpy+0CHWcRWXUndpBXfnoYT1Zfd8easTafm1uqwThQEJKYy68hJxYwIZ1s+t
         Cy6uJZUy7NsqtjOny/QgaFkvoYSM85/mxnDKO/rq5JuWi9XpWiVJ6moMdevrn/NYA1zX
         Jv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9QiohMneXZFvAn4UFSsQ5+T18UO/9S4kbwxPftN4L0lhGU2dqxkT39pcwSl81IWx2RjepZydT@vger.kernel.org
X-Gm-Message-State: AOJu0YzUixQZfiuAWR7NmB+5vBuPkSPLHbgBJNYHIkHbP6YIlrFtuX5O
	DG69DfICLVq9UG3pJZ6LF92WUTiE8eeG4G1gZUsWKTKMOMGEfGfNVfSrEtAIkRhHVKb61LCld4H
	FDI6/
X-Gm-Gg: AZuq6aJfYR+1K0TIH5Xs/qB0rwJ90W4rOwonEDd8MytVmB5XYDwOyk7xULqwE7ae1TA
	FDzG3OXEY+jpRy+hz5Rikmd5772okTkWX1ggLaaWODMM/NAaoOsmp82v2VtCJdyT2NC/pUMZDDb
	eu4fglWmXV+oJxj+an+iIhL54DWUcIaCz5+f2/xJDidMwONv42HQI5O+kgqaxZvk5Yv33jG+77Q
	hPjdI86Ltn+LZci41rQqjVWcnASkHyzwTqQcoIvs/i1PRJmCLJt/x3V05HKSX3Ptm9vqkpykxmI
	EwoAJai4bULPqpHJvtjkXEqv/NHl0ss2lhFUjrLuHV0Gh77HM0Pmc+j87B5C30/EEvpb+rgOWBk
	jOLFjUo1kXcMoG7KHWz6jZep+hqWn6Icrzubs/ZAyDBuLiPCex21tXOgySMTE4fnATb1CDJygWj
	ZGaxEbij1+ccasU4HMRmGl8rvSjB7jlTJ/dJgDYS7AuA==
X-Received: by 2002:a05:600c:8b2f:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-482db48c8a2mr188218615e9.19.1770116076560;
        Tue, 03 Feb 2026 02:54:36 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm49312022f8f.34.2026.02.03.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:54:36 -0800 (PST)
Date: Tue, 3 Feb 2026 11:54:34 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>, 
	syzkaller@googlegroups.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai@fnnas.com
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
Message-ID: <ffzrfu62npwacsl3225qqyjbhd6oue3x3rt46l2wcyp5oq4eli@26gvvst6hrmu>
References: <CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com>
 <aYFlZf9p4cY0rIbc@fedora>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="om5bwzeo4m3sw47s"
Content-Disposition: inline
In-Reply-To: <aYFlZf9p4cY0rIbc@fedora>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13634-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,googlegroups.com,kernel.org,toxicpanda.com,kernel.dk,vger.kernel.org,fnnas.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 57DBDD7FBB
X-Rspamd-Action: no action


--om5bwzeo4m3sw47s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Kernel Bug] KASAN: slab-use-after-free Read in
 __blkcg_rstat_flush
MIME-Version: 1.0

Hello.

On Tue, Feb 03, 2026 at 11:03:01AM +0800, Ming Lei <ming.lei@redhat.com> wr=
ote:
> Can you try the following patch?

I think it'd work thanks to the rcu_read_lock() in
__blkcg_rstat_flush(). However, the chaining of RCU callbacks makes
predictability of the release path less deterministic and may be
unnecessary.

What about this:

index 3cffb68ba5d87..e2f51e3bf04ef 100644
--- a/tmp/b.c
+++ b/tmp/a.c
@@ -1081,6 +1081,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, =
int cpu)
 		smp_mb();
=20
 		WRITE_ONCE(bisc->lqueued, false);
+		blkg_put(blkg);
 		if (bisc =3D=3D &blkg->iostat)
 			goto propagate_up; /* propagate up to parent only */
=20
@@ -2220,8 +2221,10 @@ void blk_cgroup_bio_start(struct bio *bio)
 	if (!READ_ONCE(bis->lqueued)) {
 		struct llist_head *lhead =3D this_cpu_ptr(blkcg->lhead);
=20
+		blkg_get(bio->bi_blkg);
 		llist_add(&bis->lnode, lhead);
 		WRITE_ONCE(bis->lqueued, true);
+
 	}
=20
 	u64_stats_update_end_irqrestore(&bis->sync, flags);



(If only I remembered whether a reference taken from blkcg->lhead causes
reference cycle...)

Michal


--om5bwzeo4m3sw47s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYHT5hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjBlAEA+pA79J0qs+XvKea3uo4M
AQ50Yt4XmSII2ywcpyrrZyoA/11CWP4Nn4BpuWlnQDGzcmWM4UOrIG8XHCGOsJze
+v0K
=YQs9
-----END PGP SIGNATURE-----

--om5bwzeo4m3sw47s--

