Return-Path: <cgroups+bounces-3597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF792D7E6
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027671C2143D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979D195804;
	Wed, 10 Jul 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CbYZH1Gl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E121957E8
	for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634393; cv=none; b=pz9Pe9B6lL4yAZntKKT3CfGRLjxkRCXsy+0M6nDhzJ/HSyYOhAjIUrClnOjYArkgR97ufS52NB2bcdI1xw4sBMWlwqEPEG7Tvif8X17XHdrbrMxX7xaRHa6k206SsLK2ZO6GK+aki9U1DJesahrONzbNat5Fj+ZAFohPafqHxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634393; c=relaxed/simple;
	bh=GAPNZcvser605hEu4iiSAliRidVEuPdS1XtY2MqVrAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKwCNjzyTUqzXVL9u8duCsrSrEILG6foXRfEJBuI4l9abCRLZMELZ3TtQdjZweAMKTFMUvorFysnCP9q2efRsV3ZUifKvjISWG74UUbpT5373WM1yx8YD4e8JKyyrjsLZCdWlNjFdxSwUj00cqE8sd1HsqWVcYw7QD8G3o+r/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CbYZH1Gl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447df43324fso25201cf.1
        for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720634391; x=1721239191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF3CnZV7DMRprpGI4b2ruu391JiaLKZraUtA5FT1zY0=;
        b=CbYZH1GlTCNaWQB0ahc8iHfcCt+3P3MDXCRP82n14F5kkJJMReAdDHX4bdfP7QgmVS
         UqeExnPbn2RgSoWqJL8OA/UnJDqC2RtMpcYtwVw1H6gYJrJknye6eMnkAHDuD7ZUWuKl
         jscTZQHRKtPW1NNo035do4C5pxSfLr0nHofQnR42X7l275lTYyvQPvsId4Gdf7CzYYbV
         RPYKn0Au8cg3WU6E0w1cuiBlFL+3WVVdB5A5f8bSfqpu+MnpnspiLEh2A+9cT5FLm0e4
         QdFwUpSYsxOJ4DFaYaQ2/0h+Ly1wr5zIGiN/KRrSkzX+6W/JGtPIqssnH49SS1BkhA2/
         Yh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720634391; x=1721239191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF3CnZV7DMRprpGI4b2ruu391JiaLKZraUtA5FT1zY0=;
        b=N7JYxF6VS5us9MjYIDsX0qXjAIY/J3xYjQgAgjYClM1e/N8Bqbwg2RIUx+9b98SPET
         AiBmJy7OZc33fHim0zuFMoEwZUGEhyo8BRAndUgOxXMTNuEJpjxGvrksm0ysFlLQ30vp
         63pqKjL2TfrdS8SLzC/5iaj6gnpxAg0A5hzi+pusmnNke+I64FcaeIu5cBMHBVX1mf0r
         vR+hufxHdh1OlbRKLVxKuYaf7KAZ1UAYrPm86+ag8vt0DNYbPzoBUET3t5y12efmGCnh
         V18AaLeefFtZzn8OjHaTgJRU0dRvJD2dNNRCXltIMHIt8PKVk2KXKmG7kiMtiO56+L36
         omgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/OcX5lNV2qJqBYD4RtgBhfm5Pp0iJospxI2jhB7bCSBhmvs1pBygZZaQKFjvN6UbMPQXyMxlhMtG4jLrqONqPtlqB6MkI2g==
X-Gm-Message-State: AOJu0YxzobLmPUmcrb3FYupme/R4I5o0zTl7CH+MN3yrALf0bq38rPy2
	IUeRqqk/+YgKZbO79OuJ3MtlKUM+Y/2MYXY54p9mnNbeYkZ9GsHhbLA+sZLLnAupMKeFOhhXTWS
	t1UGjJMKERZrItviNmEW2LMKA1g37hBagHfrX
X-Google-Smtp-Source: AGHT+IFUgm6+kfvtUIojSaSP1JNb9q6BBsgws+EhCtSdyUEJErn22fh9KctlnFuqFkqK/lTFoiBrWOKvvJfQy5snASE=
X-Received: by 2002:ac8:6887:0:b0:447:d7ff:961d with SMTP id
 d75a77b69052e-44d11893b0dmr61151cf.9.1720634391141; Wed, 10 Jul 2024 10:59:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com> <20240604020549.1017540-2-yuanchu@google.com>
In-Reply-To: <20240604020549.1017540-2-yuanchu@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 10 Jul 2024 11:59:13 -0600
Message-ID: <CAOUHufb_2kRGV50FyV6Wf4eCdeOUaXvV2-hdznH1bFP4XzYp+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:06=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wro=
te:
>
> When non-leaf pmd accessed bits are available, MGLRU page table walks
> can clear the non-leaf pmd accessed bit and ignore the accessed bit on
> the pte if it's on a different node, skipping a generation update as
> well. If another scan occurrs on the same node as said skipped pte.
> the non-leaf pmd accessed bit might remain cleared and the pte accessed
> bits won't be checked. While this is sufficient for reclaim-driven
> aging, where the goal is to select a reasonably cold page, the access
> can be missed when aging proactively for workingset estimation of a of a
> node/memcg.
>
> In more detail, get_pfn_folio returns NULL if the folio's nid !=3D node
> under scanning, so the page table walk skips processing of said pte. Now
> the pmd_young flag on this pmd is cleared, and if none of the pte's are
> accessed before another scan occurrs on the folio's node, the pmd_young
> check fails and the pte accessed bit is skipped.
>
> Since force_scan disables various other optimizations, we check
> force_scan to ignore the non-leaf pmd accessed bit.
>
> Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d55e8d07ffc4..73f3718b33f7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3548,7 +3548,7 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
>
>                 walk->mm_stats[MM_NONLEAF_TOTAL]++;
>
> -               if (should_clear_pmd_young()) {
> +               if (!walk->force_scan && should_clear_pmd_young()) {
>                         if (!pmd_young(val))
>                                 continue;

What about the other should_clear_pmd_young() in walk_pmd_range_locked()?

With that and the typos fixed, we should probably split this patch
out, since it can get reviewed and merged independently.

