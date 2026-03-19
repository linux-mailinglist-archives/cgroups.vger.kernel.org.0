Return-Path: <cgroups+bounces-14912-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBc7FMHHu2leoQIAu9opvQ
	(envelope-from <cgroups+bounces-14912-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 10:54:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BA2C919B
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9162327D47C
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677D3BADAD;
	Thu, 19 Mar 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PUzjCv6J"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7303ACF16
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913245; cv=none; b=oui5S2geAFV9JTZtINcZDhclPtN21RcAuTlDxO1FCIzrxzfqT8Gkr+lGh2z9nfPb3+wiwn49hzHHIRF5xHm1w3YAQZlydrc+0OTK290dhLBaTGlRA8BjyR8aTbF4NziWjsqnNeHQmt3b5qrOS4Y99uQceQ2vuL4artILkLGmlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913245; c=relaxed/simple;
	bh=ksv+ktKaC8GevXcLZ+qMKcgkHRuEIu5UtXoIbyr6KGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9n0Fwes957v8TetRZQPCoFxLOEka1BHJbwbQQCk84snApxccHF7yH8pzhvMjgaDKpL4HEeAIyZOk2t9xx1ywHDogZkx8KbCcbjIR36L2JKH3Fh6n6VHvdxbSsO/Pe+slikItI/SFEFSON2HQzi6PTN22promUf6mx3+K9eXlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PUzjCv6J; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c56e822eso740732f8f.2
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773913241; x=1774518041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksv+ktKaC8GevXcLZ+qMKcgkHRuEIu5UtXoIbyr6KGc=;
        b=PUzjCv6JT+0+9TTHndlr5N/kDbyXAew/nYtoXToQh4D0ypwPRqeBcYdLCjMzGUnlDF
         GRD0ZuTiDb8H6byaJKoglAM7tCl6nLbkasX/1vdA6qhGKV3kWul5zwS1VaDqWfEam5RK
         WeWeDtqOhQ7RMOiv/RuqrWHbhdWmC59/6xkX2bIaHzSn065lrDknQ2KY6y++NrYXPQ55
         bb1VEIqNC08W0Wjlrgj9yftHOQ7lJ6X5O0yMCHJI5GzpHOXlGw/THJZKCPMdwSZY5lXl
         3my76TKTfxpyHzt+lg1ZubOQ9VGZgGJVyYqDNmPM1NRQ/qXAHMC+vDRnS2psNJmpBwj1
         hQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773913241; x=1774518041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksv+ktKaC8GevXcLZ+qMKcgkHRuEIu5UtXoIbyr6KGc=;
        b=RD68Hnb90Tq0yVWgjJNgMHLt61NE1LjsqIq6CO08FptKSC8A2/Re2h0Vot2PT1gcQM
         tHGfYPAsXcS1h9MfMCnPYBreJHVfvyAKxoFfv5onC0vXx5d1NgPURBiAbaCCEUIp94ap
         kvIz+iS0/X4Yh/o/sl/Y69NhuuxYPHYv71EWd2TPh8OaQXNkvwgbIZHB6ZvBmMHinpaE
         VeuROYLiakkovZvj3yGOF+mqERpbaPnsnzCOoMTf9+dW2EwyDozkZ+5KEz/clKgn/5Cd
         TncAiPWzvHxVsK4tt8ptj1veZRW/TKQPOKUeHPW4uInmVbn8UbHIWwSaquHZLauEG6rA
         q/xw==
X-Forwarded-Encrypted: i=1; AJvYcCU5p2hH2pLLv2IhyhW/GbIah8FL5jCBcteIlz48PlnsjpQzWUUVqM22neOjWbuQy0Z2R5Cv9zy+@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAFY4JyAyDYSrt+cYioC0yS1ggPoTwEZ2qVZsx/G7VMjFOSLb
	pbwZCDZ7hcKMqHu4xADncaPJ5CHWVKpa6AW0Hx61xs1ybCp8qFMns6gQNxWG3RIP+ew=
X-Gm-Gg: ATEYQzxjtwpLIIjarSTc6GIHGpOls/K4sJp8nZ2ZfweXV8WntOSSLwpvAfkBYWBr0Kk
	XYqpaKRzZQnyXU4iXDOC2vpgCMCD2NGa9jpUelz7KK82yAlHI2xgL/qu7t/IyhJS/WTvaP/7H7w
	HA9VQhk19fxPBRWscpE1lprKbia1g5g04tkpyxDUBF1HyocKkwrawDJ19Y8jK+A2QZ0pMy4Z9+k
	eyP3ZfPyg5gq/nrw1S5EWseB49oVx3rf0xWhJJFFG3dK11Wovk6DBXcmAwwHFR0o0f+cnYmAEPi
	ZCQ+F6XIjf0Nty5XXSlctMKqtJsowMavAi7bywvOPWcRyIMrqdabHZjL0zb3YNKEI6bMVP8aDl2
	1ckd7okOYcn1R8X3vlCGUVMe2wM+KABKjgMWD44YjqnfVu+0gklZxsM3RRB2hHiOSTCKv+F5IOK
	x1F92mL51O0MQ9Dy7HPCxV3Qy/vbIW7EjyF4JhoBI0ypE=
X-Received: by 2002:a05:6000:40df:b0:439:dfae:8083 with SMTP id ffacd0b85a97d-43b527c8185mr11899125f8f.38.1773913240768;
        Thu, 19 Mar 2026 02:40:40 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852aa8sm13291972f8f.15.2026.03.19.02.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:40:40 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:40:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
Message-ID: <2q5heaiptuzya3nkmskzudeorda5segp7t2sf76btmjcgaip3n@unslzqgudcv5>
References: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
 <02c0752a-1a66-4938-9f5e-152c8c98741f@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aikibhpbtycrduju"
Content-Disposition: inline
In-Reply-To: <02c0752a-1a66-4938-9f5e-152c8c98741f@lankhorst.se>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[igalia.com,kernel.org,gmx.de,cmpxchg.org,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14912-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,lankhorst.se:email]
X-Rspamd-Queue-Id: BB7BA2C919B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--aikibhpbtycrduju
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: return error when failing to set dmem.max
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 08:33:12AM +0100, Maarten Lankhorst <dev@lankhorst.=
se> wrote:
> The semantics of dmemcg should not substantially differ from the memory c=
group
> controller. I believe the memory cgroup controller does allow setting a l=
ower
> max, and will evict until below the new max.
>=20
> See mm/memcontrol.c:memory_max_write
>=20
> We should probably do the same in dmemcg instead, although we currently h=
ave no
> mechanism to evict, setting a new lower max at least prevents future allo=
cations
> from failing.

+1

Yes, if the dmem resource is preemptible, the limit decrement should take an
action to fullfill the limit (like with memory.max).
Even as non-preemptible resource, the behavior could be more consistent
with misc controller that allows "storing" any value (with the effect of
preventing further growth).

Thanks,
Michal

--aikibhpbtycrduju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabvEhBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhoFQD/Xj/3hWTWWjgyzyS5VfxQ
PXZGrYFoikR/GSRiLFv6JW8A/jfpwR80FGuMsA73ceRBxHElklIgX47i2XquoClx
W24K
=xuQS
-----END PGP SIGNATURE-----

--aikibhpbtycrduju--

