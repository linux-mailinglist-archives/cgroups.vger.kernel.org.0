Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E827B6988
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJCMyu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjJCMyu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 08:54:50 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F49B
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 05:54:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-419787a43ebso6111111cf.1
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696337686; x=1696942486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSjIWFluF7K4ottX8oDikBL846wHdq5PEeEcvlyqteQ=;
        b=IxFMC2NNkQu10Nxr1g6V3G21TwhjXCCuyBdS9DtckCzhWW4SiZ+sEeNJGInKjVyeyN
         SEpCheFUd4eVTRlaLrUuE6Afdc6kGDzh3ryq4UWU6ePzz9LipJgfWwt9BYb1yxHeroW1
         QhQIKFB34WoBaqSuHSL3w3xLNqqoMwGAMtrkwiFSiQ8uufDsU9dZwzDY1uhoFLdk01rj
         cwShMmrPN3zuTFOYwNPP3bbMoInCkLNJEGcIaCL6Owvj23Ut64iaXSxo/U7XLBQN9nIK
         R7vx2DpfjBSNOeyBSlvwRUbITNFK8Mh6Uiu8Z7G+O5TDJhkl/jevdJmK1nWEB71p/zWh
         H9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696337686; x=1696942486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSjIWFluF7K4ottX8oDikBL846wHdq5PEeEcvlyqteQ=;
        b=Ucanmka7y67GpanWn5fapiUyfCZ7gEEw1MoqC3DwbP9gpFU14mCQc0RJTR/Ug+6Vnd
         jHazW94GWZLcepJe/KSrjC6nWP9VsE5Xi+nUHYBnRvZh4MVt7VpQSG6qdHHhilM+FBr4
         f15wf1ombyPQ1fRmKkNRihNNs9psM/noWPmI8izU41q/n3wNRk+5dHY1cWDLUXwpIXto
         k8c74rry/O9H2gVkKAhbx5pHRWcNP1/gmoMD+/Swfn6wp6EANIeqdxXgAJHdDVGxRLMv
         u/IOR4DXVIxONkcpelpyN+E4FZ7kuTH+2cCgQRLJVfR9IrT5yGw1659ThT1pWHSLvRkL
         HiFA==
X-Gm-Message-State: AOJu0YyxT0grMywADwtChLJ2L+QEzEZlfEkxRTqXiDk9DowsQP+qt5TU
        0Kn7njk4IHkXTX71XIRK0NYHQ6sInjj4n8m5Beg=
X-Google-Smtp-Source: AGHT+IHZv887dDUOgB7qFhNHpGvRSai6kezmkPAVt9oX0LeFnqHRYx2EA/hBrOuFjSW/JLXeSpXpmg==
X-Received: by 2002:a05:622a:1a92:b0:416:5e11:f7ec with SMTP id s18-20020a05622a1a9200b004165e11f7ecmr18798717qtc.52.1696337685795;
        Tue, 03 Oct 2023 05:54:45 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id c15-20020ac84e0f000000b004197d6d97c4sm413230qtw.24.2023.10.03.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 05:54:45 -0700 (PDT)
Date:   Tue, 3 Oct 2023 08:54:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231003125444.GB17012@cmpxchg.org>
References: <20231003001828.2554080-1-nphamcs@gmail.com>
 <20231003001828.2554080-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003001828.2554080-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 05:18:27PM -0700, Nhat Pham wrote:
> Currently, hugetlb memory usage is not acounted for in the memory
> controller, which could lead to memory overprotection for cgroups with
> hugetlb-backed memory. This has been observed in our production system.
> 
> For instance, here is one of our usecases: suppose there are two 32G
> containers. The machine is booted with hugetlb_cma=6G, and each
> container may or may not use up to 3 gigantic page, depending on the
> workload within it. The rest is anon, cache, slab, etc. We can set the
> hugetlb cgroup limit of each cgroup to 3G to enforce hugetlb fairness.
> But it is very difficult to configure memory.max to keep overall
> consumption, including anon, cache, slab etc. fair.
> 
> What we have had to resort to is to constantly poll hugetlb usage and
> readjust memory.max. Similar procedure is done to other memory limits
> (memory.low for e.g). However, this is rather cumbersome and buggy.
> Furthermore, when there is a delay in memory limits correction, (for e.g
> when hugetlb usage changes within consecutive runs of the userspace
> agent), the system could be in an over/underprotected state.
> 
> This patch rectifies this issue by charging the memcg when the hugetlb
> folio is utilized, and uncharging when the folio is freed (analogous to
> the hugetlb controller). Note that we do not charge when the folio is
> allocated to the hugetlb pool, because at this point it is not owned by
> any memcg.
> 
> Some caveats to consider:
>   * This feature is only available on cgroup v2.
>   * There is no hugetlb pool management involved in the memory
>     controller. As stated above, hugetlb folios are only charged towards
>     the memory controller when it is used. Host overcommit management
>     has to consider it when configuring hard limits.
>   * Failure to charge towards the memcg results in SIGBUS. This could
>     happen even if the hugetlb pool still has pages (but the cgroup
>     limit is hit and reclaim attempt fails).
>   * When this feature is enabled, hugetlb pages contribute to memory
>     reclaim protection. low, min limits tuning must take into account
>     hugetlb memory.
>   * Hugetlb pages utilized while this option is not selected will not
>     be tracked by the memory controller (even if cgroup v2 is remounted
>     later on).
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
