Return-Path: <cgroups+bounces-15306-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DDKNDti32lhSQAAu9opvQ
	(envelope-from <cgroups+bounces-15306-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:02:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCEF403117
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F02D319C73A
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C703346AF;
	Wed, 15 Apr 2026 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HexxN16u"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB92C21D9
	for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246798; cv=none; b=M1vyoKY1CFb6JwESLUMAHCry/OgGdbC1Aaj+aCFyUom4Vin9JrAiS04VMZS2egzAkoBPvVQZ54ih2s1Ze7ev3/nm+9qTVDkmdIdpG93tn7OL5EPhYY2rniAvflIkoFNdJRM15IIAQySLPyPGPH8iCh2dM0oJw5voDn7+nwuIbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246798; c=relaxed/simple;
	bh=jl2opwE1RDHcRGVmWLd07hWifPyRG0CM/7HsKxadKT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfnLlvQqfCGp2fNEuIUiaOuSy1hYUStiBbNt+sGagw2fQcfPVJ+QhxgynxAxe2hMHXTULYSDJhHcqTrF6D8VkwKcIkJmorZRGWDe8GK32eS0gK8bY73JPVwKP4YVd81MPy8XyP0MdYATb+WFjcg32ssDlU+SNAy6YMcg9DryCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HexxN16u; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d77f60944so2150656f8f.3
        for <cgroups@vger.kernel.org>; Wed, 15 Apr 2026 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776246795; x=1776851595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jl2opwE1RDHcRGVmWLd07hWifPyRG0CM/7HsKxadKT4=;
        b=HexxN16uJzerrXVZn/UT5Vy/WanNqoe5X3yuVo4nk5bK6vn6qLGyekstClLVumKpOQ
         NFcSiDG3AEJIfWwyCa0ayE+ZaaBtkUgLg+Qvvmge8c1sacX+OYmVYhswCLKW7nA7NrNP
         nf64DqzR1IQJL/klp5pEWLHxnNKJ2EeVqfgHtpTlIF7p73EkN9Ez46RmKey0+DPt5SfG
         w1fmYtZVpELDNoSQfUSKZHB9vguo+2ZLxjSBsgeqyIbB+o3/mEkddGuMOdrqwGD7SGi/
         E82U4OTjiYtG5v2YqoZk2OWHfJBXEwO4Y3EyVbaEftgUpZvSO6sh+LSIrU7Nq71dDi50
         g8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246795; x=1776851595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl2opwE1RDHcRGVmWLd07hWifPyRG0CM/7HsKxadKT4=;
        b=mF8waOTRvYnE08igdOIvo4NsYM9gBUZ8rkizY8VW84PDqPNAEQDHSHUybAer8caQ7H
         yUbwGLtLyLA3m1mTAlhgEVZP1iKlVZq+bzqtlH/Uy+wH8+z9RBXL2JUovZLcV7LQtzZW
         42LwMidLT0iYcUyY9LB8JotUqGFLS3gOEkUHw4iLedR51N2GX3smtimXN/31LYXf0gJu
         xYJBqg/Qd5j0z1t5Mk/tk17mIp7vf2NB3+MgsvCm+tt57f10xTdM8zR2APkrI4Hr/9Pi
         C6mFTBbZx8Ndur+hvsocG2SngkpxXdDU68QpTclwexEQAskWHhTIDTsKFAEFRiU/k2Np
         4iLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+o59iUCsaJmpcCBkP46rFXebk8p9gCUeQqEArW8H3XL5cR8eCYui1nfbNQY1Oi/R3+7eD78LH1@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDyfayIMWiFnVJBkDu6vwamV1pxHYwsnWMyPSwMaRVGOeSPvU
	PrpXh4n6Z7bb5sMqlXXOrcXk0KbPGbPa164C1KqVZPA8cJNm5MFS34V3WKQItP38T/s=
X-Gm-Gg: AeBDietYlcsJTC2aYZ3zNYEZYiJw2+m7DZ1ZARmewbWoI9UGCTsDip/r4uGlTPcZOAF
	BnDgPfdOUosKyPDxMcV8UXoW1ThrDT7ElyJ8LLAXyRN80UrkF6GJ88ZUnbr6Nmq2G4qD8WLmLVS
	kzBFdkNSst3SLQxZJ4pz8MdwlelXBYxoYF3gnost3YjVymsiHf5++kDTYiG4mcxPLWTs91Osup9
	45gvoI0N9HDpkkNayLU5Lk47lPI/hB1MHDyLaL8CTOMP8cKw61rn5LdfSLDZ3XhCJjjke4LyULI
	YWdUJEidRYn58dXCsGVK2E1mWgCfMtiJUN4BKrwlPsTtw4+kZT7zP5tAituSckoMPKe3FBqckpP
	lN2TpYiFIW7S4EtuiXjEYZGJsQ2ND43qB6UBp2QMEeSMWn9uYWyZnrTfx+Pxw4TU600FvP4bcGE
	3tFw39ni/5RCR/uyHeTwaRg+EFLADeYf0GvU1z2gFfQtCv1vsAGg8FOg==
X-Received: by 2002:a05:6000:2010:b0:437:711c:8754 with SMTP id ffacd0b85a97d-43d642978e4mr31875774f8f.7.1776246795396;
        Wed, 15 Apr 2026 02:53:15 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d6409sm3838343f8f.23.2026.04.15.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:53:14 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:53:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: ranxiaokai627@163.com
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org, shuah@kernel.org, 
	kuba@kernel.org, hughd@google.com, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH 1/2] kselftests: cgroup: update kmem test tolerance for
 multi-memcg stock
Message-ID: <vjhou23d62pvtdqsan2nrlldkwf27qchpfmzf4yoetqn2gdhbj@cfiuqzzotbxf>
References: <20260414110524.2414-1-ranxiaokai627@163.com>
 <20260414110524.2414-2-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3iorpsupp5gfcn2"
Content-Disposition: inline
In-Reply-To: <20260414110524.2414-2-ranxiaokai627@163.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-15306-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CCEF403117
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--k3iorpsupp5gfcn2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] kselftests: cgroup: update kmem test tolerance for
 multi-memcg stock
MIME-Version: 1.0

Hello Xiaokai.

On Tue, Apr 14, 2026 at 11:05:23AM +0000, ranxiaokai627@163.com wrote:
> Fixes: f735eebe55f8 ("memcg: multi-memcg percpu charge cache")

An interesting catch.

> -#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
> +#define NR_MEMCG_STOCK 7
> +#define MAX_VMSTAT_ERROR (4096 * 64 * NR_MEMCG_STOCK * get_nprocs())

When you touch this, I think this could be factored into it too:

+#define MAX_VMSTAT_ERROR (sysconf(_SC_PAGESIZE) * 64 * NR_MEMCG_STOCK * ge=
t_nprocs())

And given how much the selftest depends in this implementation
detail(?), I see that there are other selftests that include directly
=66rom the tree, I'd suggest also
#include "../../../../include/linux/memcontrol.h"

and use the constant from there (i.e. move NR_MEMCG_STOCK to there too).

That should make the selftest more flexible, resilient to future changes
and it'd document ramification of these constants too.

Thanks,
Michal

--k3iorpsupp5gfcn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCad9f8hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ah09wEA3WEcFRBjif8H4jLqnOLn
ZwnKif6bna2CGogxl/N556kBAND7SAIiWdZTXcOAME4PmEgfWjWiWRDi1KSjBeeX
qmQK
=LmmD
-----END PGP SIGNATURE-----

--k3iorpsupp5gfcn2--

