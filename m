Return-Path: <cgroups+bounces-16442-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKqKNceuGWpyyQgAu9opvQ
	(envelope-from <cgroups+bounces-16442-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:20:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359C6048B2
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 478C830CDA97
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD83A3F0ABA;
	Fri, 29 May 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M15wgI/w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546473F0777
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066576; cv=none; b=ErOumKGYu1FqksalShy0u4pUDwAGeqUbz2MlQu7XhgSFpoe7KsgnUevwr9S2hQDYQfIOQ38CrI/Dqtpw8seuUbSfVsoLeV2SGGJReSxO0u6+n/3dKVxLak75B7uDYOvaraMKdi8iNpwJC6XEsl7XmVcVApCXFaUeFYOwvxgI5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066576; c=relaxed/simple;
	bh=TGSbtZ81+gJhs54t7hRBEcQBUzBN4z2l/ycleOU4/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot4+mzsZoCh4+UjLtZbXAk0wv6BedypcxE/hHDlUQKyVkhsOd/8snpYmadyWvbLn3FtLfSeJMSAZzbqEH9ppfB2MZUBTtSdx4E/V0x46gWd4hPP+A1Rw7CZExT+k9nrvf6JUjCqGnogeN2Zy4hcl6QyeTorVDRS5LpgkzFbWtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M15wgI/w; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso63147765e9.2
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780066574; x=1780671374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sxBURKEIs5vdCG6YL1mHOm0YuBgobmnmOVB3aNVSj0=;
        b=M15wgI/wsi+JAnMW01hc8DJy/2xg3Hbb7qimMrIu3Zw1qmYv6jWVI/NYZdjzrJJ42l
         aPewwr9Yevu3TMcvyUspVWOy3ji/eqz61NxGQYOVd73gvxptJTIXyhTdEbKXc0ATNn60
         L+eE/YYV8J0ZcLfwrlo7xwJl5DBIBfYfUvBnGkdbFW9v9bOwBHTg4fU1VJU3GHRO6Odq
         mx8N5hhWfI3RbQAnLoeYYBnG4hOK11eKBnip4xcyauxQO9R24Kdb25UF85BIxzN4AgWo
         21x/PVEx6Flw2wR3CnUDGtOOtDol0I2/dEEcTpiQmpGehuMuKTvsjXyUOsgPKMLoEwkl
         6bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066574; x=1780671374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sxBURKEIs5vdCG6YL1mHOm0YuBgobmnmOVB3aNVSj0=;
        b=FfG8V7a2+ZMaDrqiTpatzLgDO8oW8jbPCF1S1I0e2+YoqpWnnFMIWAELa/Lmj9TECj
         mxo/DiHSYeA5ouiGis1sOni3T2lbjMoYMXCogZ9Samdc0g5GKa6O1DBj+bXKW0XGwjZu
         F2ooYZlt+0Qg0dT+MSR0HTYkvyVh4KtoWYMSkpHRtqoGrADMLIIqUKzHPtiM3s0kjZjy
         W+WwWEYFRIh9hp7yzysHY41ImCE5pqEjDTcz4DzpLpO5H+5QZUMLRg0exkvAOhAHXhO9
         3/RX86f3ysKPaQlI45cX+UEiLEbf++uVCaeEWPsbsOy+lhpFwCzRaSXrEk2hfy7mdihS
         N8/g==
X-Forwarded-Encrypted: i=1; AFNElJ/pEWM6Yi3TDb2ZvScq3SIGqFL+PXixn7rROM2mskIpQzzvbOdHAopZxFLI7uz7Npm4okDC99Ht@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbs1i2XIEUY7h6iTttturNI7xAZa1eEZtitR1r5sLRtKivf3l1
	Nhlr4vWQyWT4F0mquZ4AugVb7hCw/Fnju1vz8SwfsBI3CqR0MHD/cE6VOSn3fZB4b/g=
X-Gm-Gg: Acq92OGGzSxdJbflwoLnGq1gLreUjR8Z+D4nDM6o+gvYgtEMZtDunuRpaU4U545R/pB
	XNQsi9QxSP9F5nDHrEZal/wO9XcQz6/mUMxHPibZWmlB0WmznvCod6Ct/KkHahRfX81AhnR01u7
	k1k5z1xAlfOMKbm/9Tht4JO5V/xxBdnevSU1KJTSZ4z+coOyhFdVcunxw6fC/TIcNmSLytjcT2D
	uwZWEvS8K2h1arHfKjbSNlXI8y5EZaJlfldBFdciG1W834jgkoO783SifH5uUlSs2ik7obZQygL
	RqoOX1tS1hkB7c6ZlXnB1Hj6/yal/xbKdMeHYQbYqwvujF5JaFOku2ju0eexlqBCEa+bF1OOrWV
	in6rEksTl+xHZ4pyfAO+qTy5BCIvHOs8Z3xgkmKSt/9dApIAUFkSmf9zodrsNngtQyDKjApNey6
	MUwKZ+XBQanIUnZgYvcwYbxYFSUNxCLHdJ/yy/BDw+VtU/FqJVcXzJ2O0zfL8=
X-Received: by 2002:a05:600c:4e55:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-4909c0a7eeemr64821725e9.16.1780066573715;
        Fri, 29 May 2026 07:56:13 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm51054325e9.3.2026.05.29.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:56:13 -0700 (PDT)
Date: Fri, 29 May 2026 16:56:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
Message-ID: <ahmoDiQ8Q11xUgtV@localhost.localdomain>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwilhpywdsxyo6sd"
Content-Disposition: inline
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16442-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,localhost.localdomain:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 8359C6048B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--rwilhpywdsxyo6sd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
MIME-Version: 1.0

On Tue, May 19, 2026 at 11:59:01AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
> +/**
> + * mem_cgroup_dmem_uncharge - uncharge memcg from a dmem pool allocation
> + * @cgrp: cgroup of the dmem pool
> + * @nr_pages: number of pages to uncharge
> + */
> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages)
> +{
> +	struct cgroup_subsys_state *mem_css;
> +	struct mem_cgroup *memcg;
> +
> +	/* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
> +	mem_css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +
> +	memcg = mem_cgroup_from_css(mem_css);
> +	if (!memcg || mem_cgroup_is_root(memcg)) {
> +		css_put(mem_css);
> +		return;
> +	}
> +
> +	mod_memcg_state(memcg, MEMCG_DMEM, -nr_pages);
> +	refill_stock(memcg, nr_pages);

This doesn't look right.
Here should be memcg_uncharge().

Regards,
Michal

--rwilhpywdsxyo6sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahmpBxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjhCQEAr+BVWEm8zFPKmbprS/Y0
DGDmEkJvmxq53yv7/M98beIA/RFe/RMHQUNUp4via8ejOQCz9uiKLY1q3PFlk5c+
ByIA
=eOXW
-----END PGP SIGNATURE-----

--rwilhpywdsxyo6sd--

