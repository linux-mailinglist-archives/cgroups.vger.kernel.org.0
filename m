Return-Path: <cgroups+bounces-17031-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OxsrGmSTMmpS2QUAu9opvQ
	(envelope-from <cgroups+bounces-17031-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:30:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF6699B83
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:30:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=al3ub1Aa;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17031-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17031-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA0530D2604
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D03F54C6;
	Wed, 17 Jun 2026 12:25:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994303F65FB
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:25:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699122; cv=none; b=HqF7HBXwNdCakDBBN2Fcd6IEWYf+Rl3FE4cJzmhsG4VArTZ6a4ZZujQVlb6X0IgGKr26luBVHgwJ5zWfMQI946U8OIv41XCX9gLfQY7YlWy+1pS+lSbajwVyY656HNWqvNl3owXF/rEvQPnEY1nRJbU474l7XYQfRhFsodqtbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699122; c=relaxed/simple;
	bh=1yJxZq3tkF0bDvOTRpsnisysrPdGXlXB3E4O1ntJTHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfRQt1QWnx9g8MT9WMmO5VYuK1f5dwuLZKJ+AJEFQigfXE/FISG63YN7e1OHcgUnvLgg9AXV/wl0ZkSaNLvIKhcKcmM+1bfrRQwTkeM4bg4nQMUBzlpjGySAvUezPmsV1F5k0IFDCJkD4KHUR22wgln9h8LxJuq8Pffio+IsFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=al3ub1Aa; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ac357c55so53856925e9.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699118; x=1782303918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yJxZq3tkF0bDvOTRpsnisysrPdGXlXB3E4O1ntJTHg=;
        b=al3ub1Aa+DrvVM6gEt0RcABwn0dqsOPQ81H94gI0H3nh9GyialPhTFd5qEOsHPTU74
         JZmfLGrLJId7/F6PaUqLQsYMvvDNOAFxc1WEsHIgjSebRtKiTN0Scfw0Sn+9EM6WIB0E
         LQkQt5nVWCa5gPYxoC/ydL597UQHpBGfB138pdRMJZpPKh3l4zwaqprm3n9aXRxYkH+T
         4toaU5y3NsvTO8nte6GpVestg4GkoVJOvxrFGQ+Ymwshgx7euPt1pIez3OShMK0r+kto
         j8zFGVxW986Vd43ctXl7JdQ+TPrTg7LGkpVXEPwMGKJ18Nb4bE61GZNqPjlKP8IkWlGz
         o/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699118; x=1782303918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yJxZq3tkF0bDvOTRpsnisysrPdGXlXB3E4O1ntJTHg=;
        b=mVUy4tvWXGFuR08yvUKfGUKhD3sUZuoKSbEtZ49CjHVt63zI6mRlJBMep8oc5wjzQK
         mXqRoJLE0X/rXGAZnxurA4llHZXo61nQsj3zqv2g/ZSt2SRReQjLUAp1SLKpuNaXqERz
         biVg1qlIHWnOBFgcC+O4vqzvZeY5ZJ/WSLJNndsnRRfObTUvqYMBwooJlMOmFuXugjVl
         +0H7aWFpY6TwfJ6U2XLMYENRC+iPrUB2876EcTsP03OKAM4+MMZFOXfVIPt5dSw9lqN+
         R/NRREYX2QtW46W8xkAMMnZOyE2ZILGUu1NXutQ7NlzTH9pjgrjgD+BnZAW0dErSLs2s
         hj1g==
X-Forwarded-Encrypted: i=1; AFNElJ/RkcMdsiBdg/oTgzL66hZaN0bFjA9XbXmAhftqbdpn7dYH4M2u2WEOqyvjFxzRbEWtBgcecKRk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vZZHghWx7LMrK8FtdQq0//NAAd+udhMdEXaJhmIW2xjFCkgQ
	UpZSeSuXehJoj8kikzCcZ7gQauc7NNWGoDbodC2xefUBYv9mBEK6hDl71LE2V2vOpxE=
X-Gm-Gg: Acq92OFaSrOCfD1TZZZ61lslR4o/AsEd+u4K8L9JSgUxO8rSq7zOfxnR2/1QHx1nR8P
	W65L70O3yYEd6+uy3nZny8jagnD2oTD4ZRijicLNVWMsP+uKxBK6Xz/YO0FOUPI1LFUGHoax2gP
	kAQqfNFdbqAfRHswblV2jjChKPAgHS1W3e1f3vp5zjpvRk4TRzM64cAXAsabe9XYpgMQLytB4QB
	OBdEEBiNfeupfFW3yUis43kuN7lq2lRLGLBOieEcmN4bWI8LzKQS5zPB0jeQo9vkxIJoAtBhlk7
	rKncRJrTc8PoHzGOgUugOc6sZV/DabdD1kmu41Kv7zuwQaaZxsWiCv5Zhx9k/Dy/jObeNzWOGns
	goVuInBflgfXnOZDo6wae8h2W7E38lSA4gp3aK2c/5raI/Y4U/MyMrGenKdlw5lBUrrgIVuRTQs
	Ik9cnLYKPb1XX4X2BIWg==
X-Received: by 2002:a05:600c:c0d2:10b0:490:e5c1:b8c6 with SMTP id 5b1f17b1804b1-492333a16c3mr51513355e9.8.1781699117684;
        Wed, 17 Jun 2026 05:25:17 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a9a399sm140088385e9.14.2026.06.17.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:25:16 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:25:14 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 3/8] selftests/cgroup: use runtime page size for
 zswpin check
Message-ID: <ajJwNecLWRvX_7Tw@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-4-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fw3psxfcciuimhrk"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-4-li.wang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-17031-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.com:dkim,suse.com:email,suse.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9AF6699B83


--fw3psxfcciuimhrk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 3/8] selftests/cgroup: use runtime page size for
 zswpin check
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:54PM +0800, Li Wang <li.wang@linux.dev> wrote:
> test_zswapin compares memory.stat:zswpin (counted in pages) against a
> byte threshold converted with PAGE_SIZE. In cgroup selftests, PAGE_SIZE
> is hardcoded to 4096, which makes the conversion wrong on systems with
> non-4K base pages (e.g. 64K).
>=20
> As a result, the test requires too many pages to pass and fails
> spuriously even when zswap is working.
>=20
> Use sysconf(_SC_PAGESIZE) for the zswpin threshold conversion so the
> check matches the actual system page size.
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
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
>
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--fw3psxfcciuimhrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSJBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AifigEAsoKP16b+0Ymtb3KGVhyI
va7ay0/8bjusHJQkcZqNicIA/1Wml5S9Nn0nE+3XPCz+4d6nCaUqIpGdRKFGT56w
XSAD
=y8NZ
-----END PGP SIGNATURE-----

--fw3psxfcciuimhrk--

