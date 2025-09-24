Return-Path: <cgroups+bounces-10426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C8EB99A58
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 13:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913567A25B4
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA02FF140;
	Wed, 24 Sep 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="20M06Zfq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F1275B05
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714524; cv=none; b=MOc7Sma4iwSpzXMmI4Bhrvuk4ny6v8C7qdV+7AauA/0Q2Pf6vblUg4JVlqW+Qc3b4njIFWnee9UXtEJlNeSRBziXPF2h5WjSIQu4JhyS6gQHnoeoCDZhPIzxdL9y7zRbqWPFYzYecFeHp1UZOUlS7H5aRI7hmG0F5gDEAkf9wLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714524; c=relaxed/simple;
	bh=8wa1ZLHn+cg8S8nHQAlXq2ZdFV4bDju8o007GcFQZ8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OH+abDwj5ciVohLMs3OR7BnD5EDG1/mGfQnryB0nIu1Q0I99kLSzjF48dY+ewl5j5NYHPkSf1boBK/OzIjFWlmbMdE8aLT60w40YNQLIcjNDCE72NejGZN9laG+WkwMy5WEv7VYAPLJpyaRT7RaG/PD6hoqVLrHK6U+7WQwHBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=20M06Zfq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2562e8cbso10961465e9.1
        for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758714516; x=1759319316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL3pj95EhDFRWDVYUB7ZgnLiAqsYtgD7zX9Xu/MZ1Ag=;
        b=20M06ZfqgyBotXhZ6peh6krIclXZM+lwqOSZMMIqse4Z+jGqxOmURdUf23+vuHYSF6
         FHIF6GMXOrktUf1oRDC+fC4B54o2NQnn/CJ6az1n7SuyurgM3N82xv4a1qnTQF1H6QrE
         D0YfRnC0AmAanJXSK/jHnlHaRRpTUynaWlSfGi89PTEENzdnBsZSYicQlrSW65jdra8u
         g13MF1Ol5yWHPAeHZuQp+tE5LBSW3A5Rf6EzNVg7CwOMKnaiaB11BVOSW26bniS3J4fv
         XeEqLc4y0iRGs/V1o3JlEcZ9x4py8PgcZoFQ/yJoM1ms1qgX47cja4a4JV2hk5J7U+5G
         +QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714516; x=1759319316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL3pj95EhDFRWDVYUB7ZgnLiAqsYtgD7zX9Xu/MZ1Ag=;
        b=Sk3BRqtbHVr8elDJpLUtRi8CVaPhjNKNyCmGrFeN5VEfN1gu+QQ+LHSQwpF3xPqab7
         nlnDm5sS8gpnSZYLxUF76mQjzZJHd9vITSI/ceAtGxWNcN9jqpCCPuuSD9yAoxk6ytxe
         8C1Oz//XLakhC8q/JuWMn1XqRob4aJv4L/MAZJwIpmMi2Lm63P3Sabw4i4g4hMI9zMCs
         kZuLK5dUjxoa0jesX4n1K8DBETIbPqFmd3bkjKtlYmpIbMoL6UCxR0GZiFWf51x2gVYC
         XrCyvKCIfrW+06wOu/+D23BFeRoD9Qd0Z+Pl68+RZ0gN50NNReOaMxtpevjBA+9U/Ag0
         xZeg==
X-Gm-Message-State: AOJu0YzlgzIDKuKB8txfxGxsID8137zRPy1XIBE1Kzf7Rp14ZQCK7Tgw
	4AEXxXPXPkNTnmoG3ungZR9eO83ppYBbq1Pm8vAgDH2ISeb3pwSViFd4NSOQEOVI2F8=
X-Gm-Gg: ASbGncuURDmH4gB90LzG/3onv8ndk6GRupI2iGt73qSJLyaEN01lJ34PTwofbjNP4vl
	3Pe2rnHktQF9wi9D2aIW7uyJxJwdY3sh9yHvufSENpien8GeiF24+VL5yNjhyhInBRPJzG5Vnz9
	zYc8OcEBQ29KXNruCJa4jWexHzW4BZijRW0jAsBYXjcU/d/WFzpzA+xJhKNInIf4wboTlgzOiyv
	Kte9jzYwVwqR03Lpsj7LwJlVHpt0ZarV/9jm91B5IdftMY8z/sindd79yyn+OjrzG45r7niWdvA
	lFOibwF7C7txZsJkDORFhzfCAQU/EeUBU8grfn4O2UGMhTvXO9ImLpzu6pSSTBd/wpS1y8ENX5y
	0BeqqJim+yr5vnrc15Q==
X-Google-Smtp-Source: AGHT+IEltzN+Phzm/vgIDV/CDKiL0LHpsqh9NTpeatvcZoFTuaa8yQ5OZWw1bFDTJZAr7bLrkq2aNA==
X-Received: by 2002:a05:600c:4454:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-46e1dabfdb7mr67404585e9.31.1758714516165;
        Wed, 24 Sep 2025 04:48:36 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm28162185e9.11.2025.09.24.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:48:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, 
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
Subject: Re: (subset) [PATCH for-6.18/block 0/2] blk-cgroup: fix possible
 deadlock
Message-Id: <175871451525.316144.5136709409891330252.b4-ty@kernel.dk>
Date: Wed, 24 Sep 2025 05:48:35 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 15:55:18 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   blk-cgroup: allocate policy data with GFP_NOIO in
>     blkcg_activate_policy()
>   blk-cgroup: fix possible deadlock while configuring policy
> 
> block/blk-cgroup.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> [...]

Applied, thanks!

[2/2] blk-cgroup: fix possible deadlock while configuring policy
      commit: 5d726c4dbeeddef612e6bed27edd29733f4d13af

Best regards,
-- 
Jens Axboe




