Return-Path: <cgroups+bounces-17033-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JSu2GK2SMmo12QUAu9opvQ
	(envelope-from <cgroups+bounces-17033-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:27:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD19699B39
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:27:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=SbUyNTX1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17033-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17033-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6752C3011343
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5893FB074;
	Wed, 17 Jun 2026 12:26:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49243ED125
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699169; cv=none; b=PLe0XH62XnMcnjhTJzE6BqUyB9hctbBL7ZFMs2d469iSTDuJEydX9rRdVWE/zoGBaRn67mi/9tieBT1Fdh8zc5bF1PxervsiMN6TreLZnn/LYayaHYOsC48Wjcj7BXO+S2Ioa9+Z9gbkR3wVqPt7VGw9O0RyE8D+8U0Ru2iQG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699169; c=relaxed/simple;
	bh=jXv3Lp1VAkZliGQZVvjo9P0HvOkaYz9n//YoA1Z/TW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0H4vuRRCS/aUepJ81mL1nk7vfd+BGXLeesHfwlnrQb/H5Vz1w6pyCoUk2fC9MRf7GlQxwmjzRZnb5Npx2Thvf5gB7F7uJ//VojPS3afrwtqNyWYPhT837V6atQ9bjgK8t0v6JNRxai6VEimI6MvU966Tcg9yf9zWhxTnpnvJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SbUyNTX1; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4631679f204so219086f8f.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699164; x=1782303964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPt25DcGCAYbTcLBdAYH1YOTb8QxGJA5VYhPTuLTerQ=;
        b=SbUyNTX1MZBASicJ68JQ/I9QN8XY1IZkGhvUKf8al6VPdI+pPol9XrpZIduVTClmmO
         qsQwdW71wAL/UazVDTm/hvcEflzQrsRBct9zgv3OLn8JAocOORddIi0k0+kOfdPsnZ7R
         db8KpzLvoM2t0lCS9J8rS8SLo44fMak7eo/kgtRAdfvs4Ay8kaYtkbYEh+CSL6hYHNB1
         f4BKBfRmb7oMtmbBd2tR4VD0BERtnhtSBs7SwVraM194iiv2tJWX5Cg6qzV3RvTib06x
         X3tU52UveN506IxYsMO9GMDOrgTWq87j6B4eHx9dE103iwER7VsnMi8yYlDWG+QBU8AK
         Ozbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699164; x=1782303964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPt25DcGCAYbTcLBdAYH1YOTb8QxGJA5VYhPTuLTerQ=;
        b=dNAhbb2s9AcX0QvaDSGgtHsY3jLR2OapyYG6p0ZPba5KtSQjo/6wSn7OV01DIQI/dB
         mc7znzpeyHvhgSaZDmxDte533Ij07kPTdr9eMisc60xrByAC9tFyXJ1EQQSiKcqdMcPC
         sy/MRBSyD704YvEgTt+m1ONTi16o011YjaNwiUD/jZJZAfcwRlyQ34IykCSynd3d4sqz
         Yz874W1RDW5ugHdE6TbVisubmurF8H1OIp//5l5xJVl7T9EgDuPzAgmKcODExHhH3URg
         5ENr2Ha/rdpQ2a9qcwDVAJ1a8xDbY6GVexZVsg6+SYUxv8wnmas0HCfTag7Llh2ZDRHM
         VEWg==
X-Forwarded-Encrypted: i=1; AFNElJ/MlusGHPpJDEdzLufdqom+AiEcyGFx5p4WVs0450GfSLcSwqFMz9a7IvWTXacxI2FRUTcf4e93@vger.kernel.org
X-Gm-Message-State: AOJu0YydG+LzmBiGVewzhcSJBpWythAkV5cuqNgOg0DTohQA/aOxE3Hf
	52IeBrzlJC2VcdmsyKblM4TkJuIPf+YU6tj55WeIP1IlnsrB1zKwEp4Ip/zh5zjmdpU=
X-Gm-Gg: AfdE7cnOErZh94EB2ssCZQqzgzdam6qrbIWVaj0Geo7X6iGdSk0uTbdgRaGN7Z6HbIX
	4zQorjJNw724JvIixeGoCbjggim/IYX5skI6oVF8ptKV8BFoRXZei6UqiMupOYazhcpEVMLTZVc
	6Yibx+EXWdu7D/tZK+/EHoBogth65gPht5YEmDn5awLXS9/LrICAoqKwRUpl+rSJTYcEj1Hr9YG
	2wodpxIfkDOzWAHpY7hrmQkOy0UKXwarbHQkEvxeFFCzvgZgZbTbZt6+K0wE5MQerZAdrFp1AIB
	xADsljYGBB9PFDmzYzr7Ne3gtILlwbn02lvz1xTpmB+a8wKbqtxInzTLxuDr/tMFwl4I5JV03c6
	VVQPCkbNI4Z6Fr+YSshFJZG7HGhSrRIwyx2WL7JXQGCSRxKWea10Ha1Bd4eyNFfzS7n4ckbyOGk
	c9T3VAahptiC5h0B0yLOEekcDzgZEv
X-Received: by 2002:a05:6000:603:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-4631d06ab96mr1913666f8f.27.1781699163597;
        Wed, 17 Jun 2026 05:26:03 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-462e7fc53fasm3497433f8f.33.2026.06.17.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:26:03 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:26:01 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 2/8] selftests/cgroup: avoid OOM in test_swapin_nozswap
Message-ID: <ajKRLmEoR3P2QTNW@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-3-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7t6jkbdigw2ibo4"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-3-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17033-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,localhost.localdomain:mid,linux.dev:email,suse.com:dkim,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFD19699B39


--n7t6jkbdigw2ibo4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/8] selftests/cgroup: avoid OOM in test_swapin_nozswap
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:53PM +0800, Li Wang <li.wang@linux.dev> wrote:
> test_swapin_nozswap can hit OOM before reaching its assertions on some
> setups.

Is it because of differences in available IO or what does it depend on?

> The test currently sets memory.max=3D8M and then allocates/reads
> 32M with memory.zswap.max=3D0, which may over-constrain reclaim and kill
> the workload process.
>=20
> Replace hardcoded sizes with PAGE_SIZE-based values:
>   - control_allocation_size =3D PAGE_SIZE * 512
>   - memory.max =3D control_allocation_size * 3 / 4
>   - minimum expected swap =3D control_allocation_size / 4
>=20
> This keeps the test pressure model intact (allocate/read beyond memory.ma=
x to
> force swap-in/out) while making it more robust across different environme=
nts.

I see you used allocation value that is preserve absolute values from 64k s=
ystems
test is differnt on 4k ones. Any specific reason for that?


Thanks,
Michal

--n7t6jkbdigw2ibo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSVRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhqQQEAhKvnU2uXdtmJBVHmhU0h
vihGBStgNmEeFai/1TzvfbMA/jfIjPkmuNEjQrWZRoxCNCCn746++JvMF9TKwDBC
VKQL
=xbR8
-----END PGP SIGNATURE-----

--n7t6jkbdigw2ibo4--

