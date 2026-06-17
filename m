Return-Path: <cgroups+bounces-17032-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOAwIOWTMmpi2QUAu9opvQ
	(envelope-from <cgroups+bounces-17032-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:32:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15228699BBF
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=PL5Zse+k;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17032-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17032-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27B7F3158801
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6A3ED126;
	Wed, 17 Jun 2026 12:25:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831773BED76
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:25:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699143; cv=none; b=nhTcUnky9Ozte89dOerIy8l3wf5CuIF9QjXKHCN42OwtRpnfNhk4ELx3mDqIOYIzfUnmCUGeMRsXhsweiRtxKhZBZ+NHGqy0AGlQOPDUCBQVgETEbzDWzg0t8+tGJMEhuTwv+4+Dw1zQ54OY9cjq6Z6+H8PAvp+J9cReQiOWx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699143; c=relaxed/simple;
	bh=55oehVVJrmbgSWpqFQjMcXle7kXrC4IU8zhtK3UJFn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJoSdLN3Vj+k5CpVGCCAyQh6/WOdeIwbe/Ep3dG1G2ITn/QY9OcOx9jHNHQE2qUvYvDycBpWySRGtjQd74z084Tyc562ILUhIwUjLZJpH8/iHvoXoS0e4wReSXzeiNGronJ5rwNNVpu+fT9Oy2A6aYuskQBGU2p86bxXgyTpokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PL5Zse+k; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4626fdc829aso625532f8f.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699139; x=1782303939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GtI51H7Zd74M1RsBhYXt9g8xAv+Fn70VlHsGIGT064=;
        b=PL5Zse+kBTa3E2DF8RlgL+llKyk9XrWurGnrRud3SssnE9D9BXFbCI/DazFsFYfapo
         zNZQU19WfyxIIUF3ftuWyF2dCmq4AH7hrxDdWznVzpYYxzDeGVFExJIujjmIZ/eefJYX
         ZJ9Wd66ZODnJy8cY7bQ8CCfZnioAG6mWYjRyERtqYkYlpMJdeNg4Rb3kTJ/cubdRKgl8
         PNv+/p2utPSqaC99enUM+FHWX6mMfsoJccwrA/1t8XATC9j3B4hAjIBqPlszfV1H5/hy
         etqUVf3ssG8fr4zINGWfGRh53HqJBrOrahuLCW7GDARod7HExCeOSChbQQut2uc1fPfa
         EcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699139; x=1782303939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GtI51H7Zd74M1RsBhYXt9g8xAv+Fn70VlHsGIGT064=;
        b=oeBNAyrxHUXPPjCHRdcb/tDY436KC+FgmIPh82xUuCDglMV2l3euJPN6+IbJp3LcJD
         kQsVgA4RYaQ4AWjfQjudtckpffEJhbxTyaohAzUv+Hlje5u1g6104AOXjJahzYYbIDtt
         5rQCR+y3rZ5jQn7dTYwAp2PiGXZE0iyLYMF+6cyoOg0BBtg64IM/DZ4o5TnyyoVepqwA
         WiLJyy2UtpF8OfnwWeQ4Uv0BE9pfUhNVmamit0Xw+eEVaqNrbJk0pn6NSv6k9lulS7LZ
         txeliR+Yv0IcUsRn7FzWbdqeXSdpToWjbg/c1BN2lQPiXsPPDnU6oJgRAPamdSAd2Oj0
         Rj0w==
X-Forwarded-Encrypted: i=1; AFNElJ+vx7iYtnQuWAjgvmlofjP/V738TnKzz56r17f8XWhS7FRk8QI1Kjk4i4zZBaFfrAX7aBiYn6SS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XZ0r2qRG1nH5XgtEzvWymcpKmcswcDn5hC+dYLgDRpZyNxxj
	tm9p1/DSM8519ru/uL60fDTgi9rAPF83M7EUNBqK4BY4F7zr285xYjelW0P6r3mBDFI=
X-Gm-Gg: AfdE7ck4YecbCV4IveT7QzEAl01siiQ/5oM4zo4OGJGd2l+TySbapYGplMrfcBpT7qo
	dqupzUkY9dc1QCrCaoGiRChMCH0NZc9B40zeQs2ygMQ4vCDoE36Dogm9D5Nan+hasKLSFAkgsFE
	vJMeE+UdtpWhUNEal4AVymUxWt+AuMpioNmYd9ulbBtEa0TpY+EwR/S4tx4G7g1NYj9oINyEBGh
	oRTsQqhzpndhCLkX6UJ0HLz3D1fCUfY7YdEajE35SJwOmAxzY/HLuppkVFLGrpfU4UrfwyiJBIg
	b3nuJF4ynppMpOLwZV96FdlqnWMrMQotUZ/6aKt3+RqUXjYsmuVzvjAFp65MEULJsVblOOG9xDB
	v5d/Ip0Y+Qifcti+6/C8phNTqTz/qDMRl99egmwMBsRFfFo7deW4Epoqy7KaHiJUde1WWBsvrWn
	3DM5DJ0vZe4/GFzNeJyA==
X-Received: by 2002:a5d:588d:0:b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-462410d3c5bmr5999253f8f.27.1781699138624;
        Wed, 17 Jun 2026 05:25:38 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f726sm51008107f8f.15.2026.06.17.05.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:25:38 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:25:36 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v7 1/8] selftests/cgroup: skip test_zswap if zswap is
 globally disabled
Message-ID: <ajJu85Kq26jWeiCy@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-2-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xz3b5522yngbc7la"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-2-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-17032-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,m:yosryahmed@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,localhost.localdomain:mid,cmpxchg.org:email,suse.com:dkim,suse.com:email,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15228699BBF


--xz3b5522yngbc7la
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/8] selftests/cgroup: skip test_zswap if zswap is
 globally disabled
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:52PM +0800, Li Wang <li.wang@linux.dev> wrote:
> test_zswap currently only checks whether zswap is present by testing
> /sys/module/zswap. This misses the runtime global state exposed in
> /sys/module/zswap/parameters/enabled.
>=20
> When zswap is built/loaded but globally disabled, the zswap cgroup
> selftests run in an invalid environment and may fail spuriously.
>=20
> Check the runtime enabled state before running the tests:
>   - skip if zswap is not configured,
>   - fail if the enabled knob cannot be read,
>   - skip if zswap is globally disabled.
>=20
> Also print a hint in the skip message on how to enable zswap.
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
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--xz3b5522yngbc7la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSOxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ag2DAEA2nNoiQ15OgJR5VxoVnSf
lqGp2dpx3cwAQ5ux10qjH68A/1bVmadDbo1mKFNPpy/OmWnyJnAthaTKN3GT+oTM
BcoO
=cwDP
-----END PGP SIGNATURE-----

--xz3b5522yngbc7la--

