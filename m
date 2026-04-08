Return-Path: <cgroups+bounces-15194-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGXfMf5L1ml8DQgAu9opvQ
	(envelope-from <cgroups+bounces-15194-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 14:37:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0903BC3AA
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11C9D3102C74
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2026 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411313CD8A8;
	Wed,  8 Apr 2026 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O5qKRmz6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F43CC9E8
	for <cgroups@vger.kernel.org>; Wed,  8 Apr 2026 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651417; cv=none; b=dUH4Z0tb8wcRO24mF2jLWyzBogMvkJPM0EHT3khn//wRjSBa6O10TsqmVd10ye/whXKNOreB8kEbApFWUW6N0mv9rkXIUhOU7lTe4NSsSkXTddr6T50B+IPlX+TOl8jho5liXTON4MGgUr1qsa5R0av0k+GQyjvcLCMxp45hNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651417; c=relaxed/simple;
	bh=ZOFiW2F3+zxXjIMCJ7RD6esDVVuj+1jZjLWdTaaGI/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvKZmDHk6JVTtW9cX98tXILmQKDlwJc6UcYWtCiIir8nazVwDtpQe4FVDfcnGcgch9xtq0YmPNHUz4RH82HvGEziHv/BpONSx9roZpzHNeTTZnEYJ4l5T2SoRsNhKwZGuccWpDwDZ8yLPAzC4WjjalrcnsPBioasgmkjhRW65eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O5qKRmz6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so63850985e9.2
        for <cgroups@vger.kernel.org>; Wed, 08 Apr 2026 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775651414; x=1776256214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOFiW2F3+zxXjIMCJ7RD6esDVVuj+1jZjLWdTaaGI/k=;
        b=O5qKRmz64922gId6Yeg7eeJ+RUVQpe2zXj540xUgwJmD3iIWJ3MF+QeocNrtLWlcHw
         428+PdBoyrDCxSeE0ZVeaAigzHZ+NdFsdT29v1sawOgWNaGl6owjDdrtWNtdGwr5bSyy
         qq335LEN1y2jPiTBNmWIuvxFgqs8tG/yaZl8/B0FHldbjzX8FD6JJjs3+/pjTrFHhp7v
         Pl6NglXWglc3VP5v3DiI+kRJwSstWjh+IdcZVuPzssqZOFU1TdjxMrcLcn+MQ4OlHJ/4
         3ANu/y+hzZ09npajKYlqIgZE6hbPW28Y90AF/fvcNe8uZZnsM/nRaLHa7Vg2IKAMgJ+P
         BFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775651414; x=1776256214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOFiW2F3+zxXjIMCJ7RD6esDVVuj+1jZjLWdTaaGI/k=;
        b=FvDmepyGm+ov2ltwSe2rbMJhwVcJQ93X4F+UewohH42iN7UqXE+rvQ1rbu0LhQf9gV
         pOcmuuXkiu4HNLIOS0QMFZxbujrkPvUU18zjKNMYx25BDnUH6wyPbO6V0Nvl1iuNwujw
         s24sccCH8bVt1PCEwBUn6KxvqOygo9MbVV2DtaU34PeuFuApUYHovMGzqAY0QbMcNbPm
         X+FBOCDfae0w/VoiBLbPs0LkRg83HJ49DWvQ4Wl0QRwPvbEsVfWHtcMUgb1CPRW1ACGM
         oH9K+VL+iscfc+OqyAYJAJyxFcSHrj1s6Q4t8nJpRUjNxTUcs7KnqkyTsyVgvwejNZWT
         rGdg==
X-Forwarded-Encrypted: i=1; AJvYcCVcbVHewdrphuSVizhtBNn2IlQkHO9nyRZIPcLWbHNMVj+kyd8phIZkxW6U5Ey/6GNUlI6gI0zz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjs7SetlHwfNC9bNgZGom9imqeKfNBCGj9KuUwPXAQ1G4EB16E
	CVGyXemnNha/GbgbExFr3xgCKVL3w7pHdEJOXkWCFDi80SCW7mlFj8KsDL5EZRC1iS0=
X-Gm-Gg: AeBDietEMUoVg+rb3+oHMGL34UqeesyoQoROlF07l2TYndDBOHozLs70rpAjY4R++lI
	aFy65PUhSAUr7lDw+62RANQNm4olVeaRyb94ZSexbCCaJvDQKMzQzgXEwrzMmbuFA4Mk0JBvZp/
	VV68ZywqVt6A95sCdt9xYsahZpl3/ZrJXA/UGOSzkrQdKc5kJNb6tSUFtF68OXKkkFH0CfI1zUN
	L0XY0bIMFJGm1dnjtU7nfyHm2MTzdfjM8mDcQBkqXdHSXF9UA9jNbphV8RoYQ84kI9O58h9phX/
	PZaEFBdSxyEHs/yYVTlboGWC9otmhN3t650+7CjF9WmRBP+LtpfkBxIAxtjMcEHCw8K//p8xyKv
	ZuUjWDuDqAtrmhn/HHmxka4tNmpoV0ZUpBjxEZhjsCN8fcd728cQOqciVOXSWy9NaihLqwJ3SoM
	XPQfmO9N98hRby7d6b3j/ocrjyxBeCOynNMusY/Aafryo=
X-Received: by 2002:a05:600c:1396:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-488997d10ffmr290975305e9.20.1775651414011;
        Wed, 08 Apr 2026 05:30:14 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b739e00bsm234375055e9.10.2026.04.08.05.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 05:30:13 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:30:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Barro Raffel, Willy" <willybar@amazon.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Bouron, Justinien" <jbouron@amazon.com>, "Kudrjavets, Gunnar" <gunnarku@amazon.com>
Subject: Re: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Message-ID: <tqtihhcvq26p22eeisy5z3odtnflukoi6lh272gwr66tdj34te@s57ny333owxe>
References: <20260407010642.3249-2-willybar@amazon.com>
 <adVMne0wsVCvc2hH@slm.duckdns.org>
 <adVoAK8ekj61qykD@6c7e67b75e78>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="csbk4ahf5irifes3"
Content-Disposition: inline
In-Reply-To: <adVoAK8ekj61qykD@6c7e67b75e78>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15194-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F0903BC3AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--csbk4ahf5irifes3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
MIME-Version: 1.0

On Tue, Apr 07, 2026 at 08:24:33PM +0000, "Barro Raffel, Willy" <willybar@amazon.com> wrote:
> On Tue, Apr 07, 2026 at 08:27:41AM -1000, Tejun Heo wrote:
> ...
> >Given how quickly cpu count is increasing with 1k CPUs on common prod
> >machines not too far off, I'm not sure naively formatting output for every
> >possible CPU is desirable.

Fair point. OTOH, /proc/schedstat also outputs a line for each CPU (that
is admittedly in a simpler format, also online CPUs instead of possible).

> Good point. I can skip CPUs with zero stats in the output, i.e.: a
> cgroup running on 4 of 1024 CPUs would only produce 4 lines. Would
> that address your concern?

The argument "to complete the interface" explains the actual need for
such a new attribute not convincingly.

Willy, what is the expected use of these per-cgroup per-cpu stats?
(Given there's: global per-cpu stat, per-cgroup total stat, cpusets for
binding and the mentioned bpf/drgn availability for precise
control/debugging.)

Thanks,
Michal

--csbk4ahf5irifes3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCadZKTxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjQzAD9HvQ07/apPF/ejAc940q1
K0OBhe/1t5MIv4ASjbygEisA/1XCiIX0rEGc0GXiHB+KShRoVupzCuE6CW44GUOv
Ji8M
=PMQS
-----END PGP SIGNATURE-----

--csbk4ahf5irifes3--

