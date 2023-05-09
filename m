Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75B6FCC88
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 19:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEIRTQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjEIRTP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 13:19:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84F26AD
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 10:19:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b99ef860a40so11299104276.3
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 10:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683652753; x=1686244753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBTSBftt1PJZ947KTT5HuLmK9Q4JRp1ckp/xOLvbM2Y=;
        b=uKEfNpdw9WWrPRRTrj9h9foiBlNLT3WJq9pqOpE0YJHCEjNNaI4D5e5x8ELW8Q/bMI
         Pj0vnF9eTPxfw/ebSZ11JjYWE6hK6804ytp1NBPJ/uTC1i/wNay4e6osrUIIo2Jb3Gfa
         eMCArBpj9e7crAws57r8k4yEyjUKPMs9qC6D2/WBe6/cxlSlJhHjNmlhiPFyioeGPwDu
         vSaJRd+eDJr87t1zT9uXO6tSHdm2cp/o5kVEohG9qH650W9DB23S11Tmw34ykZHcR1Se
         8Mymhg2d5yjvkXuVPohyN752Sz1nP5nRx8keUCCYOe+WhCANlSO6+5t/svXtH2MdvlGE
         a3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683652753; x=1686244753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBTSBftt1PJZ947KTT5HuLmK9Q4JRp1ckp/xOLvbM2Y=;
        b=mAlL5Yo2hHVPqRc25hTQaFjSd322vZ1fK1ubRW4vHtydAYgSsIueMFbZGbJH4STA2V
         kndn3lSdm2h80ssEaSIxlFQAo2ys7U3ibfXJtTSwyQ5r8EYJDHYZhnR8mS+UH9g0ooo0
         +KrqafkSvrY6iXEpE/kzQVlAI4vhY1FJWPJMtFpJP+t7rqGiDmqiATbsVyFhRE1WTTtu
         1t0RsvceQQDDwFi6EkAFTn+4VnpIna8Oj3lDi8VGehGkmmpn9+b4Dq47BJ63jNiswOZP
         C1H+1g8KrgUwG1u2w9VjCYA3HKPbZrr7UVyiWLdt5diSH7CskMVUL6ygKGgPJGNOVB42
         hisQ==
X-Gm-Message-State: AC+VfDxjwHTmjSZXCj4eCw/PYXVPhS2mvLB+vFyznr4H0Hlik/QGsX73
        eP+UTgrg/s3AbG683AjnZYTQSxljf8mopQ==
X-Google-Smtp-Source: ACHHUZ4qq+O4yGw2rL/VJ5eM47IH1JbWFnhn4TU5LOG2QI4Lwps+bE/wvyYGRSdzui38NPnxXQIfxPUPBQGkdA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:8010:0:b0:b9e:7d81:4b91 with SMTP id
 m16-20020a258010000000b00b9e7d814b91mr6606417ybk.9.1683652753298; Tue, 09 May
 2023 10:19:13 -0700 (PDT)
Date:   Tue, 9 May 2023 17:19:10 +0000
In-Reply-To: <20230508020801.10702-2-cathy.zhang@intel.com>
Mime-Version: 1.0
References: <20230508020801.10702-1-cathy.zhang@intel.com> <20230508020801.10702-2-cathy.zhang@intel.com>
Message-ID: <20230509171910.yka3hucbwfnnq5fq@google.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
From:   Shakeel Butt <shakeelb@google.com>
To:     Cathy Zhang <cathy.zhang@intel.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com,
        suresh.srinivas@intel.com, tim.c.chen@intel.com,
        lizhen.you@intel.com, eric.dumazet@gmail.com,
        netdev@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, May 07, 2023 at 07:08:00PM -0700, Cathy Zhang wrote:
> Before commit 4890b686f408 ("net: keep sk->sk_forward_alloc as small as
> possible"), each TCP can forward allocate up to 2 MB of memory and
> tcp_memory_allocated might hit tcp memory limitation quite soon.

Not just the system level tcp memory limit but we have actually seen in
production unneeded and unexpected memcg OOMs and the commit 4890b686f408
fixes those OOMs as well.

> To
> reduce the memory pressure, that commit keeps sk->sk_forward_alloc as
> small as possible, which will be less than 1 page size if SO_RESERVE_MEM
> is not specified.
> 
> However, with commit 4890b686f408 ("net: keep sk->sk_forward_alloc as
> small as possible"), memcg charge hot paths are observed while system is
> stressed with a large amount of connections. That is because
> sk->sk_forward_alloc is too small and it's always less than
> sk->truesize, network handlers like tcp_rcv_established() should jump to
> slow path more frequently to increase sk->sk_forward_alloc. Each memory
> allocation will trigger memcg charge, then perf top shows the following
> contention paths on the busy system.
> 
>     16.77%  [kernel]            [k] page_counter_try_charge
>     16.56%  [kernel]            [k] page_counter_cancel
>     15.65%  [kernel]            [k] try_charge_memcg
> 
> In order to avoid the memcg overhead and performance penalty,

IMO this is not the right place to fix memcg performance overhead,
specifically because it will re-introduce the memcg OOMs issue. Please
fix the memcg overhead in the memcg code.

Please share the detail profile of the memcg code. I can help in
brainstorming and reviewing the fix.

> sk->sk_forward_alloc should be kept with a proper size instead of as
> small as possible. Keep memory up to 64KB from reclaims when uncharging
> sk_buff memory, which is closer to the maximum size of sk_buff. It will
> help reduce the frequency of allocating memory during TCP connection.
> The original reclaim threshold for reserved memory per-socket is 2MB, so
> the extraneous memory reserved now is about 32 times less than before
> commit 4890b686f408 ("net: keep sk->sk_forward_alloc as small as
> possible").
> 
> Run memcached with memtier_benchamrk to verify the optimization fix. 8
> server-client pairs are created with bridge network on localhost, server
> and client of the same pair share 28 logical CPUs.
> 
> Results (Average for 5 run)
> RPS (with/without patch)	+2.07x
> 

Do you have regression data from any production workload? Please keep in
mind that many times we (MM subsystem) accepts the regressions of
microbenchmarks over complicated optimizations. So, if there is a real
production regression, please be very explicit about it.
