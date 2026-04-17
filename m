Return-Path: <cgroups+bounces-15345-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KTVKPsE4mna0QAAu9opvQ
	(envelope-from <cgroups+bounces-15345-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 12:01:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F20419D6A
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 12:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDD48313776E
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16EA35F607;
	Fri, 17 Apr 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TBy8Pmq+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774473AEF28
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419612; cv=none; b=h+YE8jru1TQIXzjQsMliGaZJlRalX1ykqKqZfGCpG6IHh3+AohEs8bXHoNjiGioeZX03OK2cKjPWyeBh4BExfcW8rhr3TtIOrJ6hnqkXtdFtZEE93RyhI1w3ASqPA7ejlRbVc07M4/uTMBkI5uFaOhxPuU2pCgbzsblR3Sy+YK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419612; c=relaxed/simple;
	bh=Izu0ShJNuhcNKPdj0CI0f2OfPev/Xe5C95AzimQVBh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgmoOUfcGhQ2AzdbSVi9RxM40u4dU/TKK/Wd8ZhplyGM9p58bHQAjmxyBJfsGGQIBQzZdvpNglAPw9gmPR5K1yQJGroVF7NJqOMVr8sb7/LmyPYKkRs9ADGBIRcaja39aNwwaD/h/9XadTBLjIxgbOFTxO6vwxfC2SDMp4lbWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TBy8Pmq+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so6551075e9.2
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776419610; x=1777024410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu+3Fm+T2nq7/pCotYbNx98BIVCNlgDj53RW+htBcL0=;
        b=TBy8Pmq+VX856gvJxxZZaQJ4VKbDmAfTnJPndxfpfCRpz95IE8PrBU8+UA8+ip/UHu
         MF8UNiug/yiG8MS/uAhLcsG2PDnJ//WDN9pMQvzGdNhgZSDYNYAuBDir9YIAhpZjYzlG
         qnBnn1RqlSOu35mqL/vHV9nLZMK9ZZcZiF1nj2Tr3eGyPuIlaxAT7yU7em3GawOI39pZ
         K9tOWqOej9bcGbCd8NJquPulrlCrtTl6DUYB0wJVi2jHHzbMDgXSy5fh16puQAk4icuq
         LnksRPZhZdtgxhvA7sJS5xT9jAv5cDzrvDtL6dPSI7Umkqu4Nz2oTN4EK75uocN93uw8
         40zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776419610; x=1777024410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cu+3Fm+T2nq7/pCotYbNx98BIVCNlgDj53RW+htBcL0=;
        b=iHWEWR5fzLeN3njnukSxYm9A14W2QYQwV8oN941MUTXf2AtGR3LLbzb2BWUlF2GwSQ
         I1/U7H5A6N/vI412D+rW8CaQ4cEPMLcFmfYe2HMMu2xee27ZxwPdAWr/+rPtpbnGduZx
         CFn9rFekCmU0O8JoywAwgV/aXWhcHKDS6XLf+6DvoK3Ktv7TczN6JzG8B974V9ZGrOjg
         zt41HioeIyWt3i2Zhd95mF8lgczSXbaS4ODco6VEajLvU6sZLUvF2A+ex0dWO7Lz411d
         pYNAS1SS5IGmK3595qGxEqHqW9fAlvSAMjPai8jKzMOlfRfLGP/6y1v2dnOD4tGXVhiu
         zNIA==
X-Forwarded-Encrypted: i=1; AFNElJ96Q/P4SFPYliOfbgmzVVAXGXJa9j1bcUh1NpJ3G5eWLm5l+XtDspzH07NUyl8dLnVByjuWpp4q@vger.kernel.org
X-Gm-Message-State: AOJu0YwMH9NK/Z2Aj+/8Q1HRFoArv1HDGNBf0BWCowAA+cs/EGR/kkeD
	AX5gXfLa5gVeibMCBcZ+HXn7nXp85AwJFq3IRTWUt6+2u7j+SRNQ5F7Jd8tSS1v9HQzzKpSnpJp
	EkJjZ3IY=
X-Gm-Gg: AeBDiesn7f+KlKI8NM2naLAM6HEIytF5y+I6E+jM4NST82ptG1/VvBMJnzrDn/v7lwV
	2aXoff7e1bA5dNuf+uGkS1A+xn4eEgt99ih2xJiEfQQaiRUAb3rSnX5j0Qjzkdq60URyRW5XuG1
	hVCdtyUk7nUiydSAdPuCMKyyEALBxq4hjxdHt/+SdLFiGAMpe5O9Zl8d/gyksCQLPjy09GhakcT
	5neuD8IACXtcA0uJo3uNIaDl51Q1iJShr2urn7D8s5G8Uzsc0s0+FiFUvC/ZDi1ATrsX7LItPN+
	U2PQYFYsT746JIf4ucCZhCD5gLD763w+Zg8+v1qhN1U1UvcwVH98Zg13VZuqiUbY6ZNBQwWchTX
	SRSvH6WXp2y1/j1dCDrOPc0g8XKfBz0EFXpM5P9qJ7t1wN/Kcg1VO189oLbxfJcE3i/NVHkNCd/
	OT2aWIZaauTA851HCLn+sI9ZlmMOSPmLdASpXyK/bKUm0i/dx7x72S1S2+HY8klVS4
X-Received: by 2002:a05:600c:c108:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488fb78e576mr19921275e9.27.1776419609781;
        Fri, 17 Apr 2026 02:53:29 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc17f642sm28325475e9.5.2026.04.17.02.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:53:29 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:53:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: =?utf-8?B?5bSU5rab?= <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/rdma: fix strncmp prefix match in parse_resource()
Message-ID: <t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci>
References: <20260414020936.306853-1-cuitao@kylinos.cn>
 <hh55ocozzvg6uyfjmwu2hldksmrq33kdqo5hpxi2q4nszztj2s@nmacfk64ks65>
 <7f938823-6b9d-4d40-aedf-d5e9e20e522b@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tyczoocb7l7uw7sc"
Content-Disposition: inline
In-Reply-To: <7f938823-6b9d-4d40-aedf-d5e9e20e522b@kylinos.cn>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15345-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,suse.com:dkim]
X-Rspamd-Queue-Id: 30F20419D6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tyczoocb7l7uw7sc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/rdma: fix strncmp prefix match in parse_resource()
MIME-Version: 1.0

On Fri, Apr 17, 2026 at 02:43:43PM +0800, =E5=B4=94=E6=B6=9B <cuitao@kylino=
s.cn> wrote:
> Test 3: strncmp(value, RDMACG_MAX_STR, strlen(RDMACG_MAX_STR)) =E2=80=94 =
your suggestion
>=20
> echo "... hca_handle=3Dma hca_object=3D20" 	=E2=86=92 rejected
> echo "... hca_handle=3Dmaxaa hca_object=3D20" =E2=86=92 accepted (BUG: "m=
axaa" matches "max")
> echo "... hca_handle=3Dmax     hca_object=3D20" =E2=86=92 rejected
>=20
> The suggested strncmp approach actually introduces a new bug: it would
> accept "maxaa" as "max" because it only compares the first
> strlen("max") =3D 3 characters.

True, I missed this.

> The extra spaces create empty sub-tokens that fail earlier in
> validation, regardless of which comparison method is used.

Yes, this is suckage too (also in your Test 2 third result).

As I look around (tg_set_limit, user_proactive_reclaim,
ioc_cost_model_write), this would be most cleanly tackled with a
match_table_t and match_token().

WDYT?

Thanks,
Michal

--tyczoocb7l7uw7sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeIDExsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ahs/QD+Pe1/mTkytrrf0MfLGdXn
h4W7cF5F2qlZMM6yVVQ8BPMA/0WxndhEY/3EpJlZG0X8ykfjodYOL1U5VWBpa+TN
pL4H
=Hc+Z
-----END PGP SIGNATURE-----

--tyczoocb7l7uw7sc--

