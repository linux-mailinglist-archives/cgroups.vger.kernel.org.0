Return-Path: <cgroups+bounces-14811-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA3pGl8dtGlLhQAAu9opvQ
	(envelope-from <cgroups+bounces-14811-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:21:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FB284D41
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFC003076210
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1739DBDF;
	Fri, 13 Mar 2026 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JabMiBFL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78C373C01
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411399; cv=none; b=ECZkm3juRwMFaxR5GLo0AKa1zEmPNQNAyqQ6JrWaxeNRt0IzH2AWry2jBrYPgSQ9blxgXzv9lk71QqrmLNYpbWgvpwMNxWJ2KwBqFEwAP6PbD61Nv4fL1qWVRVzv75QI4ydM/kzS1oL+nhtv/r9GxZX8Ojl9nuYRSOwN1IAv1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411399; c=relaxed/simple;
	bh=bM8ApRjUxfvPM8fXE0vgDrEcgrRxSQrvOTW6j8/cc3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egfAPbZEEZqtaLsl6DvEJOuFYuvIJ+jQWrOm7CmZqsOrETJdMqwFB9Jr7peuUhzPpgkdaojfRuUugpnC12eqddITx7sDJe0voOj9hKi44koEqaBNZiMaNJU8HMzAat1TQIkW04ehBAqdqG/i9cl7jhZryb9aEuptsJl//Mq8tjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JabMiBFL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso14117005e9.2
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773411396; x=1774016196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mnpDHzgOe74WRGFTIk3h6ic8yUsqzDKHhMjCVfJQlWo=;
        b=JabMiBFLrFRYS1x966iReSLEluzMINNrPG5FB57+M2B5ZWr5NNpY3XxsA8lQdnE27T
         akepKqiv/EGQ9wTDv5Fca+5tpc3Nnpsm/S5ILSbyxthyOZZURQHyEF/NCYgOLpv7KFiz
         YLnA7OHGiAE1tq+O1YA53hf3lqgKSNeUuTqLYvAV0TLREhT6wym1kyN8rEfp2JTDt2+E
         jo5RCqmC9jgdkNaU854FmD4l1F5ogm+lPyeYjaGCdhF5d7k5EEby5yHA18Far/LT5NCn
         XDWfNnKO9yLiPyxArPwTiORMgYeXbAv0q9UPDaGjJc+JFswlYAlHeErlAE1ipd+6GL2c
         Njhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411396; x=1774016196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnpDHzgOe74WRGFTIk3h6ic8yUsqzDKHhMjCVfJQlWo=;
        b=hZdC21y5tugwg+XeMyp7Zz3j0zHoDIknDvhwNU5kPqnubOjTiHYjI+7xcYirLLJ3Lc
         xfzBlCo/mDxjgWBNeGIPf02ikXpYA3VpQfK57S1LMEAU7vFdCy+F3yVhPLXENobV3DaK
         AjO+rYjn9XqROwoktX+nrthd5vlkhGygXT9FRIPLYDzKIU5KjhCgyG9rRoLuk8acvvlL
         D8KYd8Ut+6arBGYNFQBv+SKnnqU/8sD2Bwilmjc/XwPO5abhElbNL+51/+PlERfcR6D1
         2oSFeDfm//VJA67RgvEwC5W6wdzGR/nSSJWhbT1yCTmw8AnrXfOHQ2TU/BCqYc3Fv9Sd
         dpNA==
X-Forwarded-Encrypted: i=1; AJvYcCWayv/9PaZiv5q0fSnnYO4TlQeszwcjp00bBxPtfLkass3+qERQtL/WlKUwzYUBqeT3OmvNy3x2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+t/9ZW1EvPFV9MXmUae3SHQBgevhPfU+Tf67hwQsA1tW8N7ny
	Y2NMlmgqWi2iaEt6SVrnCCeeigDUojn4rS4G0dIKnbzFTUOnpxnOz+u5uZCOvuR8Sq0=
X-Gm-Gg: ATEYQzyczHwvfZIBnA2HlLvASOMugKRJ7miskeQn7X8XXnv03qU1EULkc5zxX6/sMHJ
	XRxCo+1cLAOCKYbP4ZS9ZN/w+LrZEGupj2/ydPe/CWcdgA2qvlZYPgZ+fc2COVuw1T2ZZQuwf9a
	qFseFPGQiuUyHaDmGl1VmUHMj4d77zYwaxq8jUVqzCkBPQhJNaTPAroziHIoua7/59OR1sziKX3
	yUjx1227KV8pagyVGNT480edCVnZcU625JTddBzsrlMyfCE9u9JhGRbZcwtb1c5TfuQsESyExTe
	LxyuTtFZ8tocgIPKsVdYuaWMW9heFh9sdIYS5x/2zbsIm30bt3ecxhmftOpGNV6/gVOFQbKDg9k
	YSWgrMB4TdbXv+5KKI6tv1esd95NINyidXTjBsAh/rgckovzlfWsiQKKgP+sR1e7nf+FdDcQeeD
	D8nxrq4fSjtANErav2UKUjy5gnllB8uDFME2bisW7z0TM=
X-Received: by 2002:a05:600c:c8f:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-485567102dbmr54306245e9.31.1773411395841;
        Fri, 13 Mar 2026 07:16:35 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a7473fsm20378915e9.14.2026.03.13.07.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:16:35 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:16:33 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
Message-ID: <i2n5xfy5fmb2vwbh7xvyjmrz5vn35i7m7yw6uom3vmgb2l6xzm@rpgdwahd2lt4>
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qk7fhcgdatjkm2b3"
Content-Disposition: inline
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14811-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,cmpxchg.org,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 2C7FB284D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--qk7fhcgdatjkm2b3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
MIME-Version: 1.0

Hi.

On Fri, Mar 13, 2026 at 12:40:05PM +0100, Natalie Vock <natalie.vock@gmx.de> wrote:
> However, if we always calculate protection from the root cgroup, this
> breaks prioritization of sibling cgroups: If one cgroup was explicitly
> protected and its siblings were not, the protected cgroup should get
> higher priority, i.e. the protected cgroup should be able to steal from
> unprotected siblings. This only works if we restrict the protection
> calculation to the subtree shared by evictor and evictee.

When there are thee siblings A, B, C where A has protection and C is
doing a new allocation (evictor) but hits a limit on L, what effective
values to A would be applied in the respective cases below?

Case 1)

  L    dmem.max
  `- A dmem.low
  `- B
  `- C (alloc)

Case 2)

  L       dmem.max
  `- M    // dmem.low=0
     `- A dmem.low
     `- B
     `- C (alloc)

I think it should be the configured A:dmem.low in the first case but
zero in the latter case because M has no protection configured. -- Is
that correct?

Thanks,
Michal

--qk7fhcgdatjkm2b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabQcPRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AihigEA7S5/eGi7CUo6G5Djg4xg
9dznGGlnhpGROtGoQKrUZ4IBALiR7cNoDRQmN9UVosOVh7epArBPYmPoYaZ9MjNw
ZBgI
=polY
-----END PGP SIGNATURE-----

--qk7fhcgdatjkm2b3--

