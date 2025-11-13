Return-Path: <cgroups+bounces-11923-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3BC56F97
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 11:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8631B4E71EB
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E9332EDE;
	Thu, 13 Nov 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CxVTpbVX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BC3346B1
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030726; cv=none; b=h+j1y2nbTVbfOwu/3zt1ArSno9hpsiqIQHkYuS4GFMKYxbg7RyM6QBE41/EoE9q19XtN+aubLNZUU+VhMwyKGnopUMa0fbnJVJ++Ses7jrX4l5JjMbljoUroznAZpL5D5P9Jfj9pknjzxBbK9TenUF8DTNR+QmfIorIBWHN+ZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030726; c=relaxed/simple;
	bh=ncaOv8MzKaMpRo7yk3kmtFeKkc2V9ODYrJKEBcAlO8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnHU6sqoQ19/zOPUO//YxZnTH1Ub1r9wmCse5H+MDI90V15a4DsmVfJ0i0nYGBxfwMFcYpj7QRz42Exnmia0yczR5g3sh+LK/sqKYSZPcukGEecr1eT10eg54/+6TjrF9Qby7dITPDcYvitlfuua1KDQlg4z3lRIQzg7oh42flw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CxVTpbVX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47789cd2083so4586105e9.2
        for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763030723; x=1763635523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XupxkMVhJzCmHKi3TycOZh0SLqIfeWtCzXp2GzyeoR8=;
        b=CxVTpbVXZ8wKv6bdz5HndrHgHLMu3RsxudR3JiafeNf52GtwxG2NAuyzxM1H2uMiWc
         DlK2dl7iyiTpBD6zq4QUoTnVdMYYlb6xngG4XFeWgrDl95Y1Y5nOoYtP8bkvj/Xf2f1V
         jfQuWlbSKiExihybNCu5RgcUPPwPgtn/g3cTxNSMLGRMVkNs//xxdqsCu+KzeTS1NW5i
         bqnZZ15ZAEc8CO/ssEp8sHmDkLWFlwZhYbkTMguZ7TVYDBiHcCY8pNrER92IzcwOslsw
         xSVz4vCmyXV3jq6O6aOpPqNTrKgR1j3y8Q3efl5/trnWVyQ89f6RVqL4W5B/bjvoHCN8
         YPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030723; x=1763635523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XupxkMVhJzCmHKi3TycOZh0SLqIfeWtCzXp2GzyeoR8=;
        b=Jv+NkW61i6/PUsBYImmJzIA7nkL5UeBpONg3Gr9N2dKZd2n8kf24S5/jyx7XX8iOf/
         3W9rjVc0OITO/VZVEbcX8ka4i46DoAJ5RVwzrb2LlVR3FJEsUSc7x0remQCgVe2PaCBm
         JTPfDOwtUTiHF01MGvqgRSjo79K3y0tZEDz/qXDFRRvWpWrKUb4JXLwXh3wdlkBW1gjq
         4MILOn0hVjAXk/BUNUSeWrarR7dyN1g3oemExPhuodXdj1EvLcTrdsWyROok+AhNLDrr
         5IwudeWAG3l1P3C6YV/Zt0VhYcdlGwJf2BhpdaWsD6uQYPERoEQLeNa6F1gBC3YX0rNb
         +hJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj0tmupffHIzL9w/CJVGCQtp2xMyejwcLEfSZvPjuJ22ON2ziIlaGrhO5u6jLzBYxMlU85r06b@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6YsBVW7adjcx/Gxk9/mLkkWe6/iJg3IfpZ+ukuGEfFpNwnyk
	ZiLQbAkoQq2Yrchrqcjg5+smqJvra79TYRc4y0+lyymeLuGm2P+gUE2n4IuoV3z3bG4=
X-Gm-Gg: ASbGncsJ+Uy47bI+bppbDoHOuCPRAovxq77ahoz+dUbyv17fKaYR3DZp1pu60Yd64yE
	KMYi1iVL82pPuifF58VkHlvxzXj24Lc6R4/8cxZFQXgRiWpajVClUi8i4nijqZm+/QpKEmuBZxE
	A39veG9/IktTAvfY2lRMmaDmYzI0xnNLPfRydpvDMyZqqGRYz76Mcc3tOigYTK9iC7tL9hPiWBP
	GC05mXkC4JK3zuIkhN+8RwSqbPFwfmLt32M5ZJRe2GQWBXgj5IHrHtUBgrFta4nHYbLIC3piLsi
	uEx5MHwTgwgnC0Te1RawHzFJb3ER1OPlBOn6fnd0TqlCQdgaJksFf0vRtRt6gzULOrgVkRJC2ig
	Vidgo3jYspaAZD8gE+1XjKqSZeggicFjOw3/miingDMyQrAJBn1XPAzbjOL6tKrcYXEN9ddLPO2
	WjbI5LOU6rSZ40+fx0GMv7
X-Google-Smtp-Source: AGHT+IH5Ri8mJ/OLQa/2PlpPQAc2QP6Xlq29FlxULF7JNXRxiVvOKESy7Uus1gQMlIUWbYz2acAJkg==
X-Received: by 2002:a05:600c:3587:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-477870857f9mr50413565e9.16.1763030722534;
        Thu, 13 Nov 2025 02:45:22 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c897c3csm27893605e9.14.2025.11.13.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:45:22 -0800 (PST)
Date: Thu, 13 Nov 2025 11:45:20 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
Message-ID: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
References: <20251113095025.2811205-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3rqswcvswh4xq2b"
Content-Disposition: inline
In-Reply-To: <20251113095025.2811205-1-zhangguopeng@kylinos.cn>


--t3rqswcvswh4xq2b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
MIME-Version: 1.0

Hi.
Thanks for coming up with this.  I've brought up something similar just
yesterday [1].

On Thu, Nov 13, 2025 at 05:50:25PM +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
> Conform the layout, informational and status messages to TAP.  No

Could you please explain more why is the TAP layout beneficial?
(I understand selftest are for oneself, i.e. human readable only by default.)

Or is this part of some tree-wide effort?

I'm asking to better asses whether also the scripts listed in
Makefile:TEST_PROGS should be converted too.

Thanks,
Michal

[1] https://lore.kernel.org/all/rua6ubri67gh3b7atarbm5mggqgjyh6646mzkry2n2547jne4s@wvvpr3esi5es/

--t3rqswcvswh4xq2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRW2vRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhG2gD9EtnJzhyp5tB+MfoR06g6
QRHywZakcYP+V5BRS/MX/iQBAO7qgJH/sTH+CxzaT5tELVVVC6XAsVNg9ec1G/WR
zngJ
=Bid3
-----END PGP SIGNATURE-----

--t3rqswcvswh4xq2b--

