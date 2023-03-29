Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC96CF27E
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjC2SxI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjC2SxH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 14:53:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B2559EA;
        Wed, 29 Mar 2023 11:53:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso19531006pjb.3;
        Wed, 29 Mar 2023 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iy+lCmVSfuCqZYe5m364REzCKXPfLlS/vXZ6Sv33Scc=;
        b=mOxPMiQc+w/5rfTRi9mFKJkmmWrWC+fsE86SxcySPbUJ/wuSW6AldTRs3OGXZtwHWv
         n75hgfb8Jx+JCDbIxrNwCNhfHbchPfWDoQgDmRZL3hRgD1A1QjHOFPi/idbqob30n3+o
         RfxqdtblWXtXCCQwP77ubsHpTykfAuRiiY2lmCEIRhp/1xZEWZJAWmKKb366YikERsZy
         b49+3GyAT5iO8CVbUWnbgaKvTSxLC1ZUui2x/A7empu+BSJ09ps4+rHLpazMy4Z/WTbC
         7GovkOPkWDIYzMqS73vSWspbX6vZMVT+mWaCOhZRpJ0uPCggyCfuI4KlNvWHIo+z094h
         3zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy+lCmVSfuCqZYe5m364REzCKXPfLlS/vXZ6Sv33Scc=;
        b=OiCOgpSwKRPXnJdl/k74jw/fxsccj83OVUE6IQJo/PRmjtvM8A1TE/4K+AUeRYTSHP
         bOLXbodQmU6ftTXcBddXOMbvoDOkf4TKvEvfKoTG4UXlku4YuQCxFPKpz3yONGrl51+G
         Y13+4n18kBhl1+Yk8w2GU3bq+rpKoE/46rTRMH+aBkEYG1gxT6YSKofHACELqNt/uKGh
         uE38U8MKg2ykE67rNoaEs7VLznoXXRz6xYQzZEtsvQY8yggOEn3Eq0kCj7K1fJup+4cG
         WTIrD7cP+czk1V/wBz33JQ0oEk0H6TcM49sv868pJmriLLXoTao/JToQyJWSpH9shz1b
         A3tw==
X-Gm-Message-State: AAQBX9fM25QTDwrSu5o12/ZWqihxmP0qMNm8oQP1do76wMhqqgMbR/6W
        6Nea1e/s61SFZsCVY3CtNQ8=
X-Google-Smtp-Source: AKy350YM1IDiFMeIxntBJ5tUubr/59hvq1vaUMPy4AplOEpt3OuDM5rihLjPuie4/yTJFSttNogBlw==
X-Received: by 2002:a17:903:743:b0:1a1:cd69:d301 with SMTP id kl3-20020a170903074300b001a1cd69d301mr17833746plb.68.1680115984286;
        Wed, 29 Mar 2023 11:53:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001a19cf1b37esm23311756plt.40.2023.03.29.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:53:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 08:53:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
Message-ID: <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com>
 <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org>
 <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
 <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
 <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
 <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Yosry.

On Mon, Mar 27, 2023 at 04:23:13PM -0700, Yosry Ahmed wrote:
> Tejun, if having the lock be non-irq is a non-starter for you, I can

This is an actual hazard. We see in prod these unprotected locks causing
very big spikes in tail latencies and they can be tricky to root cause too
and given the way rstat lock is used it's highly likely to be involved in
those scenarios with the proposed change, so it's gonna be a nack from my
end.

> send a patch that instead gives up the lock and reacquires it at every
> CPU boundary unconditionally -- or perhaps every N CPU boundaries to
> avoid excessively releasing and reacquiring the lock.

I'd just do the simple thing and see whether there's any perf penalty before
making it complicated. I'd be pretty surprised if unlocking and relocking
the same spinlock adds any noticeable overhead here.

Thanks.

-- 
tejun
