Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B656A0F4D
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 19:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBWSPW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 13:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBWSPW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 13:15:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587F311EB;
        Thu, 23 Feb 2023 10:15:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h14so14157791plf.10;
        Thu, 23 Feb 2023 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d7vX3E+ECjlUByBWqhgNH3zgRhrlRHARhFD6gKgnHo=;
        b=YsUR1lwIJ38Ov5JOW2ShHLFcBQ/c0Vk2KqH2W0Jbc/vG+sGRZc6BBQOQvLelLNYW9p
         HlXLF2BaPoW97W+6oRtYzKixKIWsdLn1O4atcHCtUkFSZkrW/ywq4NrVSiYjzr5O0oSP
         yeLzDepp1Ce0bM0ax7IUdduGgc7iSL9s+A/Wqr7H45ViOiAKPZqB5YQRXPcfcH4wVMb1
         1LtR3S9wkcNzbCNjHi3fGXtM673CohikPkEs62vny/l91HxSYv96VsXIXV8EIzcXpjj6
         SrJU6gdUPUwmLQbG9k3TwoZ9mF0ghAK2EUTzLiuT2Uao4ILwH/F9Ca4ud03lzsZVNJdr
         Rtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d7vX3E+ECjlUByBWqhgNH3zgRhrlRHARhFD6gKgnHo=;
        b=u2Q2nqb/A6bPxx5fjz6MS0ZIQCxqtZfQdIKlZmm5wG+o2YPanljvFBValurSPrGHEB
         +wOw+GKg3fzEWFwCY3KV5A7tqDSV9UnK1KMlvClUA35258Uvx2arHRA1k9j6zNY/7JiR
         XVnT+v3mvR0biqnzpYOhXB+2nKBDjZi93VKKArYPoH0L76bdNRj1Ete0+NNw/wsWT5eb
         XBDQOuVaKOxK1bBdPN8HMaw4uhtfvS4tO7KKdeQAki7kypaQLXqtgmiKUIDcbg/2f1Rn
         +9dgVsEUfAvthCM1qWnEpkasGv0MEzE1CLRsnn7wkEVyStx7ix53R7BpzIz+BzvAD3xh
         ZFOw==
X-Gm-Message-State: AO0yUKUqLozxqttqQFMPmcGt/XkRa+hvEpRdQgSUsz9ukm+5LQHVn1/s
        DwC92Gxx2X70ZEzPNrwBLdY=
X-Google-Smtp-Source: AK7set828WW2VZJrKJqxcYHH7mRvhdS/p2ou/zMJ1zI+FJVS4CMBjR17NqxVH2NjppS0+ryRflfHnA==
X-Received: by 2002:a17:902:f552:b0:19a:a822:f670 with SMTP id h18-20020a170902f55200b0019aa822f670mr13890907plf.6.1677176120621;
        Thu, 23 Feb 2023 10:15:20 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:e5b4])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c10400b001978e84753asm125966pli.65.2023.02.23.10.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:15:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 23 Feb 2023 08:15:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/etNfwxHv8XO3iC@slm.duckdns.org>
References: <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
 <Y/UiQmuVwh2eqrfA@nvidia.com>
 <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
 <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
 <Y/eiLBo88pgr2IUm@nvidia.com>
 <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
 <Y/esMBOyTaJnv5CW@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/esMBOyTaJnv5CW@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 02:10:56PM -0400, Jason Gunthorpe wrote:
> > I am not familiar with memfd, but based on
> > mem_cgroup_swapin_charge_folio() it seems like if cgroup B swapped in
> > the pages they will remain charged to cgroup A, unless cgroup A is
> > removed/offlined. Am I missing something?
> 
> Ah, I don't know, Tejun said:
> 
> "but it can converge when page usage transfers across cgroups
> if needed."
> 
> Which I assumed was swap related but I don't know how convergence
> works.

That'd work for pagecache. For swap-backed, I think Yosry is right. Is
MAP_SHARED | MAP_ANONYMOUS a concern? Such mappings can only be shared
through forking, so it's not a common thing to be shared across different
resource domains.

Thanks.

-- 
tejun
