Return-Path: <cgroups+bounces-4681-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F159C96A354
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E71C23CC1
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2024 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A2188A21;
	Tue,  3 Sep 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cuoUFfXh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864762A1D6
	for <cgroups@vger.kernel.org>; Tue,  3 Sep 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378708; cv=none; b=fRtq0WlBOOY+4vPFHuUkYhj+J5ITS0+fk2a7H9CVsJlUCNePl0Ttxb5Q2UG+WUgTT5Q7DefgtYHoa+uM2nOq6UD4mciW0RocH6fpW0jxkaa6TZyxC/bVomTM2xEueBVe/roUgUVxujGIAZcegTbbbKdA7OWpfYDVTyEhAAQnqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378708; c=relaxed/simple;
	bh=dsBOFhgSQ20VWG9N7TaQ72g5Xti+njXE2CMMbkMUqhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8NmG7sANRQTHHCfWcMhgsPlfHXADMuPlPkbW/5EIf1R0N+4+Xf/KGYTE9nS6j8JISZ1fTQ/g0iXkTzGqaAFnedWX2zTbpseefO6xiM0E+oNp/2OpVBMWc+jnNrEIRLRVLM3cv8zVVEZkNeeQKybXH4IbeBWtpIX83CneO2lewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cuoUFfXh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053a0bd0a6so32726165ad.3
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725378705; x=1725983505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CTJ70oGdDlKxwej4nIFhqzlt6kbdcbSl6hDfUkSTBo=;
        b=cuoUFfXhzoQiaFGPCDhtSDbuKUF9c3ceGsJjLD1nylbp0aV7iDbQRcgJQ0Tw8r2wSU
         oZ6bNKMWCimvLIp4Vlga5cday2rkJ9iB5sy7EwTwSnGBN+xH+B760XzzuQCTmmlEGoYv
         8SUjc59rZ+mJKRKh1nFgXVq4P09945MtbtCUy99yJgbZneblxJOfbhm6QkZi+FdV1l1E
         2ycXAAj0Yj3+7AwvOeGFOjwfWbhbX4Ccbyj8hc15mKy1mPUEXZYag2Tj/bnRsBTIhrDx
         awQ9RI7ITLS8kI01Rp04gxg78rgchBBaPwMGSr54KR84vZWRsV5I/1So5B0gCUjyOMsF
         9p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378705; x=1725983505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CTJ70oGdDlKxwej4nIFhqzlt6kbdcbSl6hDfUkSTBo=;
        b=rKm3Mw0Vo/dTjZOPv1cDYf98zgf1koXFGxtkrpSIo1nbvZs2K2L5WHekMKdlI6Ut5b
         Z2mN/JLk/flLP28jTELhdfrIWE3Mi9VzV9fzIDRmhiOfsby4gGxwN7CV4L8lqX81QVf7
         UC7Tn8XeQy+Pei3sgwgdHDArdV7mHhJ36w79cIp2W2jQX1YwfQB75nTVeBPmbXnskJKL
         rUznC//VneyUx0DjLei4Q2hwhaFnhy/4KVq90ItK/VQJjIpHQAYBKF/9V9RfMel9/8ot
         OvrEKHJEsO5g1c3Pax8PWje8FSl8RRM7z2Yy++JQfZ70tw00rkJMqSU+XFk79hHOnFp2
         /nDg==
X-Gm-Message-State: AOJu0YwHNKZlUww12UdEWKZqhh7uEWGIFuRmhuo2TzD/CvXg0nodHV9N
	OK/VcB8BOmfb3U+jHbf1G7UwWCZZckGvRRimYlvMz1FC7eE7QxJyp1ck3K3AIEw=
X-Google-Smtp-Source: AGHT+IHNCkFTZ+tQgNCw5YR4zc40yXygu4dQL7fmOyGsHVTkN9zbIFM4qpX1e8RQjgG7bMszJHZFJg==
X-Received: by 2002:a17:902:d4cd:b0:205:3e6d:9949 with SMTP id d9443c01a7336-20699b36168mr29065275ad.52.1725378704682;
        Tue, 03 Sep 2024 08:51:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea384e1sm136775ad.145.2024.09.03.08.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 08:51:44 -0700 (PDT)
Message-ID: <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
Date: Tue, 3 Sep 2024 09:51:42 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, paolo.valente@unimore.it, mauro.andreolini@unimore.it,
 avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 7:03 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our syzkaller report a UAF problem(details in patch 1), however it can't
> be reporduced. And this set are some corner cases fix that might be
> related, and they are found by code review.
> 
> Yu Kuai (4):
>   block, bfq: fix possible UAF for bfqq->bic with merge chain
>   block, bfq: choose the last bfqq from merge chain in
>     bfq_setup_cooperator()
>   block, bfq: don't break merge chain in bfq_split_bfqq()
>   block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
> 
>  block/bfq-cgroup.c  |  7 +------
>  block/bfq-iosched.c | 17 +++++++++++------
>  block/bfq-iosched.h |  2 ++
>  3 files changed, 14 insertions(+), 12 deletions(-)

BFQ is effectively unmaintained, and has been for quite a while at
this point. I'll apply these, thanks for looking into it, but I think we
should move BFQ to an unmaintained state at this point.

-- 
Jens Axboe



