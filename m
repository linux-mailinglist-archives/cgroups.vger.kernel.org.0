Return-Path: <cgroups+bounces-9681-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0057B42823
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8FE1BC1897
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A4E320A38;
	Wed,  3 Sep 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="m/BCzo0U"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AE1EA7CE;
	Wed,  3 Sep 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921438; cv=none; b=UZrVQWX2lO9aPyTZjpCicskqcC+pVCPU5U9tZBCGrZswBilWQ9wFnGVqxhtbwsxOK2zD3E7Q1cUNUjA9f2IZB7c/0JqUTfScbE5IT6bSmr3bkgGe9DGNT1pWRGmqcefUAVvMqDAkTUNw4oorwDJxuCJOCOPq2DaYTvPCU8FnGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921438; c=relaxed/simple;
	bh=oo2VqPQzOs0awQ2KFkF/ggSz4bK6UP7Rv2dLH8iscF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFB+cFyf6xjONQtVT8mjgNeSsGGnuDb81+W/DysvB1fpqBjoMroIhLStEyW9KPwL53avT6JbX9w8r9uevGWVKfjenj67lg3uoAIrmXgzV0wXb0VzJ2e7O3aiDNsI4RgAl7wmLSBmKM9NlvVu/cAj9bduwFRzY8YezbxhGYEnbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=m/BCzo0U; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cH92Z4Z1Pzlgqy7;
	Wed,  3 Sep 2025 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756921419; x=1759513420; bh=LHje+2lxnKoIG+2sitMfJb8g
	6ka/yJvoKpoARAWj/yM=; b=m/BCzo0Uwi3kBlYHRi80GAynut1hUmHpDxYtVPfQ
	yip9stvY5DwMh6Td7OPbj5NKBYP3jwx6IoSu83JpIhGowdZaRPMtb2jhplsuorBy
	FyIZ2v067LUQtXo9PORjlhr/mWHQz+gmZRQxC7lAVfdh3CLKy+B21Pt7bJeGHKkK
	ojt30h4muDxvhxdpnNYrj0T/jZ+VmK6K1ePySVsuDsrhmT6b9U7GYkGkQJzUqC5d
	xzv8GfhyHej/nZN7yyZNRX6KUMBd/D8eLga4cUtKUR8CakJHA8LiQH4JDryRhIEt
	B9RnsJCaihVoElqBTh+lfQvo6aYurCw83F3B0kVeCAmhvQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aDemjHE0Zyhz; Wed,  3 Sep 2025 17:43:39 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cH9230MWLzlgqTy;
	Wed,  3 Sep 2025 17:43:22 +0000 (UTC)
Message-ID: <238625a0-c9ab-4354-a23e-d8a8bdd869ad@acm.org>
Date: Wed, 3 Sep 2025 10:43:21 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 11/15] md/md-linear: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
 satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-12-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250901033220.42982-12-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/31/25 8:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>=20
> Unify bio split code, prepare to fix disordered split IO.
>=20
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md-linear.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 59d7963c7843..701e3aac0a21 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -256,19 +256,11 @@ static bool linear_make_request(struct mddev *mdd=
ev, struct bio *bio)
>  =20
>   	if (unlikely(bio_end_sector(bio) > end_sector)) {
>   		/* This bio crosses a device boundary, so we have to split it */
> -		struct bio *split =3D bio_split(bio, end_sector - bio_sector,
> +		bio =3D bio_submit_split_bioset(bio, end_sector - bio_sector,
>   					      GFP_NOIO, &mddev->bio_set);

This patch cannot have been tested because it triggers the following
build error:

drivers/md/md-linear.c: In function =E2=80=98linear_make_request=E2=80=99=
:
./include/linux/gfp_types.h:381:25: error: passing argument 3 of=20
=E2=80=98bio_submit_split_bioset=E2=80=99 makes pointer from integer with=
out a cast=20
[-Wint-conversion]
   381 | #define GFP_NOIO        (__GFP_RECLAIM)
       |                         ^~~~~~~~~~~~~~~
       |                         |
       |                         unsigned int

Bart.

