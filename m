Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD80A7B55D0
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjJBOue (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbjJBOud (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 10:50:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B00D9F
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 07:50:29 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77412b91c41so952061985a.1
        for <cgroups@vger.kernel.org>; Mon, 02 Oct 2023 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696258228; x=1696863028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3flX8pvYQpulFjLzINdT1Z6OZiL8rcWR2w9QCAJvARw=;
        b=yZE5GGJ4SlG3U2OihoNsmoYESUEUX5gx8uv32YURfDzbZcRCaiS276djCvfoUU37OM
         RKTBdflQLvVOia8YKXEW1tQbU9PMBN7khACVc2FzAvWomhRZ/+sKHG1bUAU0ojhRhnTt
         BFeth3Zp8JNz7TRbB8Z36+RGwS4ZfP94YfkmbxxFSZrVcIq72+kaBGZFvAohcrfg9NHo
         gYy0xUOjxvZ1WuhEhzj3vR7CGFkyMn2RJHI5rgXCxc8I2M7BdqjsL759mddEFGWx2KbU
         k4mcPFnyhaWBv3VpkBVa6t6qMN5v0pjhC8Rv9S82nXZkjk2z8b0Fok4Y1a4NGRb/Qezp
         z3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696258228; x=1696863028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3flX8pvYQpulFjLzINdT1Z6OZiL8rcWR2w9QCAJvARw=;
        b=bptKEGMRuGwFEaS3k9kA0GrZuQ4ErrqarHDCT/oOzDO5PTkIdEUNGHW+zZjTbQPjte
         DCq2WZqOrUwT+2MvBjMAADOBtflg/kSa3ku8F2dYu4YKD1u31QHTWoW/1vgIFtn92J4R
         SErxhIn1xODxPBkbq+rRyFnnSVmtrPRxfFZhm4HGGoW+ArbMvB9OlNXjsBIJRdabjZTl
         EZ/BcJRjEe6/nGWjonU5zDJTo8FTyqHREcElj0Ucng7uSY3S/TJYHzWmS8Gsaat3Z1K1
         AtKMuDTMj/FRBuTczLeNRtg8bnTzRMHP1RjKMQrW8BBo3iSUIt36C01RwNV79Nd2E9WS
         csyg==
X-Gm-Message-State: AOJu0YxqkMk0dPto8KGkThAp9w17jB8Dw6PrHZjy0494jxot8cuTjD2G
        nsmA/gEbgnUu5RHZWWKyTcUo0g==
X-Google-Smtp-Source: AGHT+IGrhGOcsDvoDEISgACZY/G+y1Ase64mfWV0FDNriKPr/kVTRdJZtPPkZ36hyFu9t+NaOPtfyQ==
X-Received: by 2002:a05:620a:1920:b0:773:ae67:4b96 with SMTP id bj32-20020a05620a192000b00773ae674b96mr13046574qkb.53.1696258228654;
        Mon, 02 Oct 2023 07:50:28 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id ou2-20020a05620a620200b0076768dfe53esm8987922qkn.105.2023.10.02.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:50:28 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:50:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231002145026.GB4414@cmpxchg.org>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 03:43:19PM +0200, Michal Hocko wrote:
> On Wed 27-09-23 17:57:22, Nhat Pham wrote:
> > Currently, hugetlb memory usage is not acounted for in the memory
> > controller, which could lead to memory overprotection for cgroups with
> > hugetlb-backed memory. This has been observed in our production system.
> > 
> > This patch rectifies this issue by charging the memcg when the hugetlb
> > folio is allocated, and uncharging when the folio is freed (analogous to
> > the hugetlb controller).
> 
> This changelog is missing a lot of information. Both about the usecase
> (we do not want to fish that out from archives in the future) and the
> actual implementation and the reasoning behind that.
> 
> AFAICS you have decided to charge on the hugetlb use rather than hugetlb
> allocation to the pool. I suspect the underlying reasoning is that pool
> pages do not belong to anybody. This is a deliberate decision and it
> should be documented as such.
> 
> It is also very important do describe subtle behavior properties that
> might be rather unintuitive to users. Most notably 
> - there is no hugetlb pool management involved in the memcg
>   controller. One has to use hugetlb controller for that purpose.
>   Also the pre allocated pool as such doesn't belong to anybody so the
>   memcg host overcommit management has to consider it when configuring
>   hard limits.

+1

> - memcg limit reclaim doesn't assist hugetlb pages allocation when
>   hugetlb overcommit is configured (i.e. pages are not consumed from the
>   pool) which means that the page allocation might disrupt workloads
>   from other memcgs.
> - failure to charge a hugetlb page results in SIGBUS rather
>   than memcg oom killer. That could be the case even if the
>   hugetlb pool still has pages available and there is
>   reclaimable memory in the memcg.

Are these actually true? AFAICS, regardless of whether the page comes
from the pool or the buddy allocator, the memcg code will go through
the regular charge path, attempt reclaim, and OOM if that fails.
