Return-Path: <cgroups+bounces-16435-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AItuEFSOGWpTxggAu9opvQ
	(envelope-from <cgroups+bounces-16435-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 15:02:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021C6029B4
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 15:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3BD303CE9D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190D2D3A7C;
	Fri, 29 May 2026 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NkT0LDab"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606A1E32D6
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059694; cv=none; b=CM8U6BroCFW+LVRR4wsxLYvA2mhbR9ALj23sdqjsd2nug4WIueVcTKPy2JxnMYZaICQXlTFbCn22A4PSX8uU5Sdje9/X+fACaZ8LO/gvygkxp0uNkns6yb23lnr6Rlf+KSh2ynxnOrg2W1v1Qz3fr0jD1gH8/0TkWvf/G+mj4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059694; c=relaxed/simple;
	bh=TKlBWJ3ijSz9GFQ8lE7XQuNEddJ05fSbljPGAX3zb4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqYj+AotGjGqQjG9OJnpGLhUOSYN6FQgsuRnP23sFsCEDH6h6QpUJNYpmwT2JTI/u9a6jGvaQj5lJn68V2Cgl8Gz3afR20PvF7FjQrvEDICxAVJeotCT9wGIXqOjhQRpf7nOtZR+ctHhJ+pLq8ABs2pGaOXYL+NeqAC38wk22xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NkT0LDab; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so93724775e9.1
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780059691; x=1780664491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKlBWJ3ijSz9GFQ8lE7XQuNEddJ05fSbljPGAX3zb4M=;
        b=NkT0LDabAIFtPWo9hVTwhgsqk0hG+2VqdJ/gKD00bz9obSX/pNrkS7TKQ4NDetk1aw
         zwyIFqfvHYX9tUuanFns67wSgJOF8Q0pxlH/F9OSnFX6fg6o4WDRHVi/CMix4iSZO7eg
         MC3W49HD/YMOS7UnVWcysg+0NF71VVC052N5bnJeOLdqMRi3wd6A58QFYSYSJu7I7ODH
         bAkwIs+5Auc/BqLeZ4sWCy6wgBtBDocf46fUboukgqHM2A+HObJOGPfoJFsF46/jZGE0
         Pol4ymQF48YwhOQgsmS6Nlj/SG/FbtRvE+1Fkl5BmQofrKpoSxy3NtuOhmezSzny+Dtu
         E6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780059691; x=1780664491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKlBWJ3ijSz9GFQ8lE7XQuNEddJ05fSbljPGAX3zb4M=;
        b=JwA3lKs47z5GEmZi3BYe7M9ARvAD4tJr2fvD0Q2XzK4UrZPpC3miaiaBXdIQh3xIif
         NJYniKNVAn3lIOmr1USjjkFLZLHSvLY+1LHVuZRLrEsvXR12I21+1tQUuHA/ESGpLrtE
         yXEyxrFIl+GRc2/ozXgoRAdHOEGhPAwLWg/FquOrL3GaMkxuFLCR18hSHEd7OVYLdQSh
         rVRqLSvQaeicQ6YHdmwEsFepY/Psfhjd4Ndhn1lOhi2BLxTjDKQ0sklGIZ2stKKbnJs8
         CekldYLEYt6mTua6ZwwlpPdwLADobQo13AjSg6IfjGtnKL3BcS7NAwaM1Aywb6Mt2oVy
         7hyQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6HGzbQEs/HPpamSmtKaow3OckxBhr4kIE9ydYpJDt/q0biqI1NewMfxC6n62wwe/MWYwjjZuT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp2Ona9pYgcNVppvxHo5XRJEKiHy8xh+V9y5oAsfBBXwVJDEy+
	vN/GM0uog36SGuPNEiMjw3XCp1TzcvyJKwT+qUM4M2zvYPDuFyDoc1ajBttw4R9UbboQVZ2DD6H
	Lujfo
X-Gm-Gg: Acq92OFtD7F21MD2T90XUO7BD/q6IxOkfxXCJvXcUpbrHTp431yc/+fMiIfiGDwYYdX
	FZ150KnSGVs6xlXj5ah4FDj8J4K+t0MLtztG38jpUGyCBsHfF5+8W371L79sx7gYCRw6KamIWkr
	iW3n4HXLfEBRwDUBRWDfi2U1fg1fnfQTCm0QMbPD5BFxr+kcUW+ci/gBuTlCI+uIwrF4aPSpesC
	+JCK6UOOjGJIAuiu8MIY6Q+8ZxDoQ6m/3W10Wrbr04sLBtI7YJOTlBGSUWWd0gUlV+AS6Qp5iOV
	sdsFQy7oXX51YOGGzpaZ6wKa9Z+T3z/shRyq8PkLpRGKPu8H7gAXFB9GXQ+h2Ag5S8/AUUwEe+I
	gr36RkZDpMvthykte0mXZTj4Fx4+ISCsxINUjl5hqytJxjf09LpOCbldZndVkZYCN2d7OK6sXeO
	qXbnSuvri5V6XBUUuc9tOMNZM6XNWqTicXp7hlNj7oq90tNQNVvyHJfSmjIO4=
X-Received: by 2002:a05:600c:560d:b0:490:4ee0:82f9 with SMTP id 5b1f17b1804b1-4909c0920c0mr38130535e9.7.1780059690792;
        Fri, 29 May 2026 06:01:30 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6575csm70478955e9.4.2026.05.29.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:01:30 -0700 (PDT)
Date: Fri, 29 May 2026 15:01:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
Message-ID: <ahmOBo02TA8u8RW2@localhost.localdomain>
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
 <ahCISfTlN10gD8e6@localhost.localdomain>
 <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2z43jkempbrnq7gp"
Content-Disposition: inline
In-Reply-To: <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16435-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[igalia.com,kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,gmx.de,vger.kernel.org,kvack.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,localhost.localdomain:mid,lankhorst.se:email,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 9021C6029B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2z43jkempbrnq7gp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

On Fri, May 29, 2026 at 09:34:28AM +0200, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> > Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>
> Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>
>=20
> With your r-b it's ok to push it to the dmemcg tree?

Please go for it.

Michal

--2z43jkempbrnq7gp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmOJBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah7GAEAt/V3wEPGggC+JULstS3y
dmXXZPqpxAaQogu6yCs89g4BAMQxskRRFxPIHcGypjWfGqkYS3FsM2hfhSaRrkTr
5X8P
=a4Ed
-----END PGP SIGNATURE-----

--2z43jkempbrnq7gp--

