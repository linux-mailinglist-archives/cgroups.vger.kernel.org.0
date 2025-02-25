Return-Path: <cgroups+bounces-6707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E9A43C46
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A2A16EA3A
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543B266F15;
	Tue, 25 Feb 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fB6zkoia"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19C266B61
	for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480708; cv=none; b=TvY+YqE4c+0q+rXoKFbUEPyYift8WKImZo6yM1Cdsq1eEC6E1XXQOkWeKf/b3lC79Je/8mYSFANxI5cGdF1C32x3pjRqgjZN9ONarWGa9F04uZqzngtxQ1tECNpGUzggpgfRKSoRAllZojbHO32k4VShKb2tlfGmS7aBkZW3QzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480708; c=relaxed/simple;
	bh=U2Fxrw+ZWnZroV2gtVWjbt2Q37s+7jT2hIUi1TH42vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8Wy9YV3rEVMczBX0aSVn5oW3N6sRhmoyfUWYg77uwyIYo/bBIzT+wECuJAUK3289VSGQpjBpdV54edG/ilfTSEO5A1W+PVcd6VN211Gv2pz8sccttKawNqNvUK2EaUVcn1SZnlTL3Tuzf1WyH++/AgStJQ/2twwZ5ui+ovoa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fB6zkoia; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso11127926a12.0
        for <cgroups@vger.kernel.org>; Tue, 25 Feb 2025 02:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740480704; x=1741085504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mv1GjtLH9p6AAgaKLJdaYv1valnjqWPg00vkxZOmddk=;
        b=fB6zkoiaIdMgbfeIGodOK3Bc5hooKM6K1xm0XsoLN2PzPWLcJ0JpZ1FGbt9tU+fZj1
         cbH+/LkcoTXyyH7sdIjr+yizafF491qtIPOiJBtHMj6O7v5KdfCiPEpkgq4VYaUEdFbR
         RCzrlNVkOSokkiFb5dyCsTLf4Wo10/c4HE0cI+EvhHLduwLr1oATaVQlrIRvp8QZAnxx
         ZYVlsRJQlJkn8IL5m2vQ8ikz8w7Oy7eKBfSaYewdZL7UUZ0c7QntQTruTzMxqFlCnQg3
         ZOUBl6Rho1SsPEjNqrZKLsDD7Y19DsUiV3DC17C2pjx9XmasY/krW9B41OJFhoW6wpH4
         IyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480704; x=1741085504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv1GjtLH9p6AAgaKLJdaYv1valnjqWPg00vkxZOmddk=;
        b=KDOTCksGN0PzQWuL2A0ut+kY466Jc43mISFH7X2Q7hpgQDnetYagZMmISv4kY4U15V
         uB/sIjg74nj/fQGthlDylPDbLYTH8MmnsyKCkrKOsrboYbb9Dt3LL3UhOzn0Pe6ebLe7
         IRfYnDymGW35YkVRfpsSeDQSCz/tEAd0GbzH7oBS4CwETStt9p0cy2bLagQupAgcLJob
         f8IHrxHaa4Tzrll2kFATpGAuIDH0UVUIipCQ3fE4Wl0nWQ2+Tf4Ao6cpHy7Um1y+U9Xd
         2pptFT0ewE6XOtuL/qHck7+AJBWXMpatKGfRrO3tiEMyDlcE8P5EvOpcgc9ickj6pJDR
         NtQg==
X-Forwarded-Encrypted: i=1; AJvYcCVEKTIXzmIotoXJIrhnDbPUlvwQpQuIibopRALL+Z+OjTBwHcXUdxaJlW5NwWwTYDKDY7LAVPp+@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2fTl8dLkvp+0Y8UZiidAQWPNzBHmiWEgOZwUJEIR4M7FPLCZ
	Tz4UT3lB0ekqg/nCiksFkhSMvqj9+usegVcjpJyTJt1dzIZMKQBk26eNsY+JA1c=
X-Gm-Gg: ASbGncuMs3E194NiBtaU7eHYTS9dqu5m5ShgLJaX2kNirx5hk9vKdxaKbfeig3EbCKV
	HyKPjNwS+3f3X+H3rZHqQUWEZV11auFv+4kZD1Nm2gGSGicgugPyJv2Oqv3gLRuHI1K9iDaianz
	k7qfVTzDqEbFQRa9vnbhfWH+kxV2jIFVhdWKAJ61q5rCln963MUeMfiWsdAipjIkW+zpE8vPjCY
	RK9R8s6tk2vZa0w4wJsECxLjhUaM1AqI1e4Fu3AyIHZ1vmCv10U/8oJIPNHJ+S1d0Oeh0W7GTfc
	YrZD8DKDX64E7HYnjAedfm70UUbA
X-Google-Smtp-Source: AGHT+IHUS8m9al3aYpp9dTro/BoJsAzrTMGGeZSSdFhetcpWcy+SNbbUKcmiFFvP72TdtmWFR4s3Zg==
X-Received: by 2002:a17:907:3e0b:b0:aba:620a:acf7 with SMTP id a640c23a62f3a-abc0ae5728bmr1777898866b.10.1740480704381;
        Tue, 25 Feb 2025 02:51:44 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da1c2dsm121396366b.77.2025.02.25.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:51:43 -0800 (PST)
Date: Tue, 25 Feb 2025 11:51:41 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com, 
	axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 0/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <igzfzkwbbdywdvkbjzi624fgrc2jopnb6c4dpcrac644lazgbp@k63ht5r5ue4x>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="teg6osmgnl3qwlc4"
Content-Disposition: inline
In-Reply-To: <20250222092823.210318-1-yukuai1@huaweicloud.com>


--teg6osmgnl3qwlc4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/2] blk-throttle: fix off-by-one jiffies wait_time
MIME-Version: 1.0

On Sat, Feb 22, 2025 at 05:28:21PM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> Yu Kuai (2):
>   blk-throttle: cleanup throtl_extend_slice()
>   blk-throttle: fix off-by-one jiffies wait_time

(I haven't read through all of the 2/2 discussion but) if the 1/2 patch
is only a cleanup, it's more backport friendly to put it after the fix.

Thanks,
Michal

--teg6osmgnl3qwlc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ72guwAKCRAt3Wney77B
SXOwAP9fngBMH4Xn+ahF0Zv0RzYoYnjox8PuSgoFd8VeVVyVIgD9EMg0p69jzpqn
RGSQPrygGqTm1vbVYBMl+rzVsdR5Sgo=
=bd7s
-----END PGP SIGNATURE-----

--teg6osmgnl3qwlc4--

