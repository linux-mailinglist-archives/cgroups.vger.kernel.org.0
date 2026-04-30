Return-Path: <cgroups+bounces-15567-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGPfF5+Y82nO5AEAu9opvQ
	(envelope-from <cgroups+bounces-15567-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 19:59:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A04A6AE8
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43EE430098A8
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2026 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0F4477E23;
	Thu, 30 Apr 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VS7zm29X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42F40F8D6
	for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571994; cv=none; b=Tx10ucRkt7SG7la6Gdii6mtpLXlu9LuRy1iMi/V+RGACOPH0UuAkulNEfHnbs5YM/ka9nKgOn2V/i0XWMC2x9hJrz4rI93y/BryAnU+m+Q0z+ojJmN2MkYRRbPdsgU8Uzn4i6VuCr4uYcZrQ5LZB1Nq8hLfDey8NuxZ5n72w1q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571994; c=relaxed/simple;
	bh=iJOM29Y3v/mqVyn6b+RjjmEbUV6FdEzhO3a7fq/1pDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIjHhtti0iqTqCj/pdLofU6hzt0EHQ7NIusyD4ufYrYUweoThYEntNhqY3B8xeKHv12HTxeH7nexRV4vTF6drv+BjDg1CDSPx6Djnhi1oWm2lqC4rrrKG3PMM0C5VpMS4qck/HR3UKG2sIUWOGmB9zwgAtwhgTNSfvZzIxAyVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VS7zm29X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891b0786beso8482115e9.1
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2026 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777571991; x=1778176791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTUiJt9xwi8Y0w//psVBgHDt0GT8hv1X0ipJMWwls1Y=;
        b=VS7zm29XO11vd/fRYSKftgqXjnapA1XRuqRxPpkV0vKsOyaVQrfq36SqM57zLbzYsY
         W3p7QgBobg/yWMBJFNlAMDdEgOgmq5u8+rOQHSZdQNlSlNWJOmUK4Oafj1a0NVG4Uvby
         5z0yO6NbG+uwzj/+vfzul6euQ6o8qQXtYA1vJUX2eJ7B5BB5UjTwPPsR87I4WafodD6d
         +wij84RwW6OcfEGmxHgw7Wn2XLyscThqMjrJzGM/BWfVvjJNGg4c5hQ/wGRtQ5vg2CaS
         R8mQLYUgZL0ZQAF03UBvvLfEqS9a6frnCO3QBdyKK5quT5MNNVoyjA9wkKPSMHhiyFwA
         qMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777571991; x=1778176791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTUiJt9xwi8Y0w//psVBgHDt0GT8hv1X0ipJMWwls1Y=;
        b=hajyTMI4hSkWGTHCqFoXT/FL2iaKH1GCPKbWeVDw0XqW/P0pXlp2T9CC6mSAnZ4t16
         jUHpVzvXhWplUrT2oNl1N83qX/+gaqZl4pRpQX7HSc+fOK4GHIxb3VXQRp3E+WztbEWF
         ZmyNC5EexuZEqpZEamOO32kbEyW7vM529h7gXngMrAZW6IRDJCjYcIVPj/Qk198YM2Ml
         mSuI2ksyfKvhgR4yY4M7HLok7rcrM0f3f4rsusv/zKVIov8DJ47Q1Q8l+T+rxo2ALBhS
         J6KhhUGcjLCIA6m4uRotymSkr5DvU+BNiOSeuxCFOGDrTqd8rJdALrLDap4H2Zs+gGkQ
         HqUw==
X-Forwarded-Encrypted: i=1; AFNElJ8zOMeOBAqdGgaJrpqe5d/dBuT873hOq/qHk7qhYx1KXAuRtRllILkRHvKpdP5Ig0Hy9TdBSdMP@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzTV8Eo5s61QVVp9trh2kTZlBhyHlTNTB7Q3DOQ+D4DVOKw62
	XGcw3rzGDZB7fDHT0l86opf74LkovHTDbcgIHRaAl9l18zoDJwuZd2nFrp9HNV6M+wA=
X-Gm-Gg: AeBDiesJUP6tIzK+rWbLW1bj95e0NJbAANx1rY0JNesQbFyabuBPC2nR+wPm4mQ/pRs
	s9soJ8MzbfBSra4N6VCYlAOehsftQt33G0U2Kz8NgD2FT5+CKRmUR7OVkDFfKv75fnUCmok2qVS
	LOzsZE3HebUQSOvOCetLfhqjxb204ta/LDDynYJR14PjhSsviDDdONOXb1gt1ZFubOhjY6vYu+/
	OFbDoM6494mHcHBziWuLWPizMw9UWkzWf6SD8EdLFjsnhGiw3gwb0d2mMsndykzZ4csOyRFr/rA
	tjLKvfli5IewTpPn+duqyM78HTSd1ecJHtH4dU0Kxg/48NM0D3rQYGI5ChKnPorBIeRcr1TCbUs
	5JO02MKnkueY2Alwfx1ADfIylBpWeOjY/a4jAUtF+Yg8Y/VVmaExcuH7bonZGiKDYArd7msAef3
	VcBN0+ZFYa+TQV1SIibPK0z/IYFWMbdwbks6QqIXYaOg92NjPo4dXKKw0e4jw=
X-Received: by 2002:a05:600c:c4b7:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-48a8447b30bmr65195185e9.20.1777571991221;
        Thu, 30 Apr 2026 10:59:51 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8d17242dsm1335145e9.16.2026.04.30.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:59:50 -0700 (PDT)
Date: Thu, 30 Apr 2026 19:59:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: Add basic tests for rdma controller
Message-ID: <afOT2cX2WOs0U05S@localhost.localdomain>
References: <20260430084310.80662-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2usmbbltw4yxq4h"
Content-Disposition: inline
In-Reply-To: <20260430084310.80662-1-cuitao@kylinos.cn>
X-Rspamd-Queue-Id: E53A04A6AE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15567-lists,cgroups=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,kylinos.cn:email,localhost.localdomain:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


--n2usmbbltw4yxq4h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] selftests: cgroup: Add basic tests for rdma controller
MIME-Version: 1.0

Hello.

On Thu, Apr 30, 2026 at 04:43:10PM +0800, Tao Cui <cuitao@kylinos.cn> wrote:
> +struct rdmacg_test {
> +	int (*fn)(const char *root);
> +	const char *name;
> +} tests[] = {
> +	T(test_rdmacg_max_read),
> +	T(test_rdmacg_max_write_nonexistent),
> +	T(test_rdmacg_max_write_invalid),
> +	T(test_rdmacg_max_device_limits),
> +	T(test_rdmacg_max_hierarchy),

IIUC, these are tests for proper parsing of the limits but not so useful
wrt RDMA controller (test_rdmacg_max_read has apparently little use).

I see that you try to work with a first found device -- if that's
available, it'd be good to have a test that checks whether respective
rdma.current-s respond to object allocations.


As I am looking at test_hugetlb_memcg.c that does only simple
testing of the .current would be sufficient, not sure how difficult
would be to implement a test for actual limit enforcement (but would be
nice too).

I.e. -- these would be good test to validate basic behavior of the
controller.

Thanks,
Michal

--n2usmbbltw4yxq4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCafOYkRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjA5wEA+JG+u+n2XS7C0UKhyrcP
2eACsYIHrkujOHn32EA3w+EA/04EXBUdN5S5BJoHRADhLIgOKUEFIbR6MeowJiCK
cqwG
=CBmN
-----END PGP SIGNATURE-----

--n2usmbbltw4yxq4h--

