Return-Path: <cgroups+bounces-17035-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iODlIHqUMmqW2QUAu9opvQ
	(envelope-from <cgroups+bounces-17035-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:35:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6ED699C02
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=S8kdNCLy;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17035-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17035-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982EE303642C
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100883F0ABC;
	Wed, 17 Jun 2026 12:26:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C64071E6
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:26:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699186; cv=none; b=Fa4cpVm03bz53i6bPgPz1r+SRol81raCp9P7zxTztpUmwJ9ui1JUbE9dU9hfdw+ug68La826DHFZplOb6JDNKIM3tFhBeshKE55EZ+tMpI0C9Mr1amKB/BF2i1hBZc+UGQfOcNFHZHFPJIqykXkDr8o5bPiH2awQinJb0eZIK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699186; c=relaxed/simple;
	bh=vb2jXE+X/Hf1iYoX+ZnlPTpxTVJexi7Tdbw9iGRH/60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDHSSU1a9cIRyxQ49eHhTW3eBbJvd/tOPyuudpb2xqdr6vrG6sZcPSGluGREVRpSLBEJxNX7dNsMdume6ZB5qbFBVv60vCZHt+wLcPlueuvPUE16em3MDbLTbTXY0h2hEUqhaHqNEO4xbxYxOnZmEB6pRbcZAB+UmWbtaaUCaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8kdNCLy; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso3098747f8f.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699180; x=1782303980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iim+7rfRj3+oRPn4MTff3Qg6MkJBVhCqBNuI2UP5kD8=;
        b=S8kdNCLyPKn+s/C3yKe+99tHMG1wxK3W0CExPbnzFNhctLvSxSxZIkz3E+Q19leuID
         LKowGszPlt7vhaSax2ZClyIxKUYNQS39nEWsZo3mhyLky3Oieg7wncOmM4CBMMNCmUPG
         BLv7lFCp6BcIdYhQtptxBP2Wpy2S9P58dfirMFyinbb9dbM7kz1TVpWU3kxm/O1/zM6C
         jP4GARok3jgF5OXRZrE7xRQitVwvbA+5eZLoAXzvfpIoHL1BxerJODs6z9tAEjXanQC3
         97oWrBRrPNxxBDwLHKR1DxIVzSqHW5+tL3zs0UYg/5T4n/fa7JjQivb0s5iIvs3xgs3C
         A2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699180; x=1782303980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iim+7rfRj3+oRPn4MTff3Qg6MkJBVhCqBNuI2UP5kD8=;
        b=m6uAP5i7meaoCiUHnIxhpYQFbUGyqpzIbzA5/kRC6EbOqdnQLP3KP7fNpHyIHLsqla
         VvZZBzJ6wYx3os5+LpzryGL9Wu2ZbpnATl8CPZn9oOqHGg6rSTFeZM5LNd6NktxZzhHo
         /sr8oJmKb8xRTF+4cKia+Grsj92ixgapemda9423d/lmv9+1l5WuJdhJDHm76B49D4aA
         SH8O5I35qZiCeKaHQ/qeVaZCHRjki8tD3Co0GT5pgCyBYJdZMyH2plO+YVBSoWcNgKAM
         ty8J4senskfNSp2gl3asPO1tPPWpnkNt+BK17mj6Tg8MQfUJMK6qTnCyud8k/YVNjmDK
         a5Sg==
X-Forwarded-Encrypted: i=1; AFNElJ+KZF6G+HnPO3IJGAUrUb8pAKKYG3+ugXpaVKkMWUYj+rWL+Fr3B+b6uiiBXiMh320uLtBIbkeg@vger.kernel.org
X-Gm-Message-State: AOJu0YweuMsUthDb9VDbtvyx54YJoXJ3lAJB5DQGyPD+OADigY7UgLbH
	jvzDwNjLNE0fhl077QWKnNa3j1RIm93iitDjuh0148wIkRBxSxtS5gcFr1YvhaoqMUY=
X-Gm-Gg: AfdE7cmhsYLx8T/q1I5erefFyaPbpakRRGDrdi66/XfjG2zHQLVR62TY68LMRqGln/P
	lIKwm2srKINhgGQsI4i2h+ocuvDTJ4O6JBDmi/TYtEZvtDZNPlERqVzxhyevirQVg1++In7G2i7
	sBZ/svkY290lMs9+izSckBwt0oY4Mc4hDCjpylVxrfJshrTok3h6ncMskU+80DQ28shRu+L9FKC
	phjBLy0ExUW5izx2NnbcWtJfNdxgWtTdjLTQ3Jr/nlFu2SdU9bDA7GbbxMeX7Zi636qLjcb5s5n
	I849xbnM5a0pi2TXkCgHzMT7D0DqkyRunCgiW8YDB8VOIJbKmzL72B4kvDwi/ufY2VaybTV3mfg
	utyq0ouZZN6V1Y8IuGGa4XF0x1wjocXf+FkuvLZW1qAblqCgdqzzfVT2q17b6t7rlf8Y9Lee9rY
	kLL/FKMSLiGX8ScXhKfw==
X-Received: by 2002:a05:6000:46da:b0:461:a5a3:692e with SMTP id ffacd0b85a97d-4623f2e7e00mr4513543f8f.5.1781699179970;
        Wed, 17 Jun 2026 05:26:19 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm53060827f8f.21.2026.06.17.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:26:19 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:26:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 7/8] selftest/cgroup: fix zswap attempt_writeback() on
 64K pagesize system
Message-ID: <ajKKABt0ZKO9UJTI@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-8-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4tngv5chqbx2jyz"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-8-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17035-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,linux.dev:email,cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC6ED699C02


--t4tngv5chqbx2jyz
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 7/8] selftest/cgroup: fix zswap attempt_writeback() on
 64K pagesize system
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:58PM +0800, Li Wang <li.wang@linux.dev> wrote:
> In attempt_writeback(), a memsize of 4M only covers 64 pages on 64K
> page size systems. When memory.reclaim is called, the kernel prefers
> reclaiming clean file pages (binary, libc, linker, etc.) over swapping
> anonymous pages. With only 64 pages of anonymous memory, the reclaim
> target can be largely or entirely satisfied by dropping file pages,
> resulting in very few or zero anonymous pages being pushed into zswap.
>=20
> This causes zswap_usage to be extremely small or zero, making
> zswap_usage/4 insufficient to create meaningful writeback pressure.
> The test then fails because no writeback is triggered.
>=20
> On 4K page size systems this is not an issue because 4M covers 1024
> pages, and file pages are a small fraction of the reclaim target.
>=20
> Fix this by:
> - Always allocating 1024 pages regardless of page size. This ensures
>   enough anonymous pages to reliably populate zswap and trigger
>   writeback, while keeping the original 4M allocation on 4K systems.
> - Setting zswap.max to zswap_usage/4 instead of zswap_usage/2 to
>   create stronger writeback pressure, ensuring reclaim reliably
>   triggers writeback even on large page size systems.
>=20
> =3D=3D=3D Error Log =3D=3D=3D
>   # uname -rm
>   6.12.0-211.el10.ppc64le ppc64le
>=20
>   # getconf PAGESIZE
>   65536
>=20
>   # ./test_zswap
>   TAP version 13
>   1..7
>   ok 1 test_zswap_usage
>   ok 2 test_swapin_nozswap
>   ok 3 test_zswapin
>   not ok 4 test_zswap_writeback_enabled
>   ...
>=20
> Signed-off-by: Li Wang <li.wang@linux.dev>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michal Koutn=FD <mkoutny@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--t4tngv5chqbx2jyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSZRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Aho+AD/XAL/DakRMJXz9yk1Zazg
v5ZtizO1OMSuDPj/gKs2+1sA/iTg96YzL1efNS85Rz0XMUIW3UE34U/bKW2+nSp8
/SII
=BiG6
-----END PGP SIGNATURE-----

--t4tngv5chqbx2jyz--

