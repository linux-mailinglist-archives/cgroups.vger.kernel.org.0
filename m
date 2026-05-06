Return-Path: <cgroups+bounces-15647-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGXZCLpa+2kuZwMAu9opvQ
	(envelope-from <cgroups+bounces-15647-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 17:14:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7016B4DCF8E
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 091043012C5F
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02B048B36C;
	Wed,  6 May 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xnatgcey"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719D47DD74
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080170; cv=none; b=MAub4baMKLdqMkALyJ0HIKjcKb3mqGHqJ/HJy+XZ7VF1YeU/95Zj95YmMntsGl/CpRIqnKA/PdKXFxGAUNeAJazZKhgsbTtl9pg/UelMSWd2LNs8nVdhTpnWxASD0gcSEWoR598ArEeazY5gy2Bf4F0NJsNeCVJDT9xizIrhqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080170; c=relaxed/simple;
	bh=PtBGz2x9WQ+HNP+qaMuedUIcyx8fnxzRJan7d8nhIVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QptENxP+Nlz53BMuWYOwlms+nqcEriQIav09k5UB5M3vS1/tD3XcmCnkmixIPv3iK/M/TcyHis+V2SRz37/6K6FI9f2Qxr5KiJMnkUdc9zB6WgI3dFcJE0lkozDDlXNRCvRrFsf1bT1WMTjE7WZy5+KhSu3PR4YzYKTTIIyZFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xnatgcey; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso57707125e9.1
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778080167; x=1778684967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtBGz2x9WQ+HNP+qaMuedUIcyx8fnxzRJan7d8nhIVw=;
        b=Xnatgcey/IP8Zx9HfCzEL2xBhxJhqTmhJP7ZDQbdZ/U5aY0kDaLlcsqYS2QdU/Toz8
         ElqL+dXp1pju7n6WGfAGfxXJTIqJFM0TKRlZV5sQv0E4tYMw05DGASELN6KYy/ithcL6
         2mYoR+7mcFzTvZMhteC2QqzrY1NIRW18G9TtIxQa3RaxbTiCx0CJg4wVKLHYu4vBU3Ez
         XbIfZFucdni8K7jEuTxqYWAlp8NVYOqbU/Dhn7nDXVAjb4Lno7hO6zkkmmrTmVLp1yyu
         V3yuaBDo1TkXp4CfgzDgBmT8P0O8aJ1DcEDB6aEwJsEVJzJu87yz+QUoEdov7fafNjXn
         XUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080167; x=1778684967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtBGz2x9WQ+HNP+qaMuedUIcyx8fnxzRJan7d8nhIVw=;
        b=XOrK3o6TuynJTvdP7rR5Ifgr2rb4V4culHLuCSYqHbIW8u/XhBCMQYVH0QHA7VlwYQ
         E6VVcvTMaWxrNxsvBxpeHzqpF0A3GfmHGC42BCrRk3j3/Vd834Ubjj7TpuwUiwd9XEwO
         Ae3DPxsoWvxIJ7LLg5vYoeCQFtD1hTVD3rq9IvSHkDGk0nNq1o8yrPQD3hDR41pridlI
         avxk1bwUMW/8gCXll+KtnSMsyj3VQmpMn3ivHNSNzc6LrA8ooxaD+cnxK2CftKHau5WO
         +Rr1FmgbmsnD6jzG2+zS4bbOChXpqOdJSNJcjDYV5JokgLzHwW32nUKrY2g88Sh3jpJA
         7pVw==
X-Forwarded-Encrypted: i=1; AFNElJ8hPhlVvWdtyo4H4P73seH5GOa6C8QPNOP8GfKLLvuujW3+pAruJ9kI2mQm72DMGpsERCsgyTF8@vger.kernel.org
X-Gm-Message-State: AOJu0YzI63jd0dIbbiT6Yxa/NuBiRlZH2hcz8URiciiP299OsCtufDJ4
	3/RCuhN4R1Qrx4AwejfAFerv3qPtTOrR2xJ5CAxUUikjORRbqmmf0GSflZyEzdVxuGM=
X-Gm-Gg: AeBDiesZVFjzuutpdpIFfWa25gbGX+vIGyVOKdf+eS+rAgNjqG9/x82V2zdGfZ/LKux
	bqcWdsdDBKGgkRU1N6Nt0j/gmtnLLCXaSfEZi86mLVMqzEzL0/XS0MHrVqzRZPSjPqj0Kd8mUsr
	K0eMj0BwXxcHbog3AAEbm9XAurqjskslm7bEq57gcPExz5xtjaWd9YXiUnAPHpcGHynjvVwrM6U
	TPICxS7GGjzQ8/CnL3yYODfnWgpj0AcP4AepHi8kk3t92U/r3+qrBSQIJn/eaLUpCR2iVoATWP1
	epGy8N0kHP8VD1hZz+IDWhvEOb25+xP17Tvg2i4HjtUqkQ9d27uoCDsKGsqUPIvmzuG3ZfxYqgX
	9GpCNyN7A1p7QH3Tp+Up+RMvy/INWij7GcYN1euNBN47FETkFUPCVRhsXlgxmkS9P0lGAuTclfQ
	jkyeqISbCl1SCEJQnF+wx0kmFpeD71CJNV9KIzRHPGXQ9DMsEwgVQDFwYKZe8=
X-Received: by 2002:a05:600c:8906:b0:488:ffad:6728 with SMTP id 5b1f17b1804b1-48e51f46d7bmr49899505e9.19.1778080167469;
        Wed, 06 May 2026 08:09:27 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5312df8dsm18475835e9.18.2026.05.06.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:09:27 -0700 (PDT)
Date: Wed, 6 May 2026 17:09:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	kernel-dev@igalia.com
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
Message-ID: <aftQijvIHNZo_UyS@localhost.localdomain>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
 <aftB-cc5EhDXxCGA@localhost.localdomain>
 <aftNsqrv2sGPOPHX@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjfnm2wcpgmp3gca"
Content-Disposition: inline
In-Reply-To: <aftNsqrv2sGPOPHX@quatroqueijos.cascardo.eti.br>
X-Rspamd-Queue-Id: 7016B4DCF8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15647-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com,vger.kernel.org,kvack.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,localhost.localdomain:mid,igalia.com:email,suse.com:dkim]


--pjfnm2wcpgmp3gca
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/2] cgroup/dmem: introduce a peak file
MIME-Version: 1.0

On Wed, May 06, 2026 at 11:18:26AM -0300, Thadeu Lima de Souza Cascardo <ca=
scardo@igalia.com> wrote:
> I used void *, at first, but as the only current use is for the pool and =
as
> mixing different uses may lead to misuse, I thought it would be safer to
> use the type directly. This has been pointed out before for other members
> of cgroup_file_ctx. See [1].

That mail reacts to union overlaps and pointer vs embedded struct
allocations. Correct me if I missed your part.

I agree that having properly typed pointer is safer.
cgroup_file_ctx sub-structs are for generic cgroup files. But here
somehow a specific controller needs propagated to the generic member.

What about storing also the `list_head *watchers` inside `struct
cgroup_of_peak` and each subsys would manage it as needed?
(ofp->watchers =3D=3D NULL could also substitute ofp->value =3D=3D
OFP_PEAK_UNSET)


> I started with a non-resettable peak file, but as memory.peak can be rese=
t,
> I added that feature too.=20

At the same time pids.peak has survived without reset option till today.

> If we want to merge a non-resettable support ealier and need to take
> longer to discuss how to work on the resettable support given the
> above, I can resubmit. But I guess we can see if we can reach an
> agreement sonner rather than later.

What kind of users do you envision (i.e. would they need resets at all)?
Anyway, the behavior should be explained in cgroup-v2.rst since that's
where they'll look for it.

HTH,
Michal

--pjfnm2wcpgmp3gca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaftZoBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Agf3gEAnS3SQwtU72d+vybPMvLs
abYBuiDKjsiW+4zy1RFNTAwA/36oWRqQ1pjGEuPTFgTxHnl4+5Ls3E65Byjp41wO
W6cN
=obKI
-----END PGP SIGNATURE-----

--pjfnm2wcpgmp3gca--

