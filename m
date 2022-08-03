Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212C5892E2
	for <lists+cgroups@lfdr.de>; Wed,  3 Aug 2022 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiHCTsX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Aug 2022 15:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiHCTsW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Aug 2022 15:48:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C37A20BD9;
        Wed,  3 Aug 2022 12:48:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso3198166pjd.3;
        Wed, 03 Aug 2022 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=/TnexTjdFrc/Gu2edl42Moooc6kFX3TgYFD+N6FTpm4=;
        b=QDt3cfQte/Zl4k0s/nJQy5IJo4lGn44+dOrM6ddgvuwo9jKvKLbbnFoL0T8cgQYOoj
         uyUgupOxmCC9zuOi67Jlg1e05mjmaBm5vyCdVxr8VZ+3I3kbNaPxUxd5pndHkzsGdXVR
         n6bZmfKul/vPUIzryzxQ2Ft1gRS7bSyHNWqwz9AgtmOVYtR25fuSYtUDLA+QVH8PZ2Pk
         7HRvQUPlLZBaBFjljW4kobGO084v6+zwuGGUoLlSx6QX8wCQBzBMrxxbP81PFCwFzTvl
         8wxBz+pFiD2rTjn1YZJw3IIgfYhVurD3fyzwJJ324pEp5BArGPhMHE4/0WcYjnYCgi7v
         gV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=/TnexTjdFrc/Gu2edl42Moooc6kFX3TgYFD+N6FTpm4=;
        b=vCyfse7aBBn9wj0bj6Z9cTDuFsMtu0KvaoSzoPtFOS6Laxy00VDBy2LKPOUTuYgHM8
         UB2EL2gy+ROZfh3IGu0JXYFsWg4ubtiXU19GdsLrk1CeIpxbBqhsIFrO0ujbbL2+l6bk
         bakFQTCoQfJrgjP7tx8hCiLyIwVCOP1ZB9CZ+O2Qf5xHX4rgXSRe1wlSzNxMqMq/Y8J7
         AcZxG7NR8CkHv697eyFy/2lfdCRPIrZ5HwHPXRmzffrhNZuxZD29lfvYkxHfnwMdNx//
         LLlBqN9/RJMbSwltDHRLSgWMCJPCijfRv/YZDX4Y+xZ7SWk2uUY2A1F9E5qyLvVKg+Pm
         SmZA==
X-Gm-Message-State: ACgBeo0R1HakEI0SbXDCHRZOlNWVCiOzWwPUIiJHEaVJ836mK49hmfd8
        9sWXL8/NMYTE/qFPTI0Fzro=
X-Google-Smtp-Source: AA6agR4MAA7iZXP0Vp6HgNcIKaEx75jEF2GI4Q5XeVva0iVZGej1zllK3JXKe+IVCW9uLC3y4JNyJQ==
X-Received: by 2002:a17:902:d4c2:b0:16d:c317:ee9d with SMTP id o2-20020a170902d4c200b0016dc317ee9dmr26053515plg.25.1659556100608;
        Wed, 03 Aug 2022 12:48:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7c3a])
        by smtp.gmail.com with ESMTPSA id w1-20020a656941000000b0041a919ed63dsm11347439pgq.3.2022.08.03.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 12:48:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 Aug 2022 09:48:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Message-ID: <YurRAnUEloaYMx0W@slm.duckdns.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org>
 <YuAqWprKd6NsWs7C@slm.duckdns.org>
 <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
 <Yuq3Q6Y9dRnjjcPt@slm.duckdns.org>
 <YurK6MXdJPrV2VYS@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YurK6MXdJPrV2VYS@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Aug 03, 2022 at 03:22:16PM -0400, Johannes Weiner wrote:
> Where it gets trickier is also stopping the tracking of task counts in
> a cgroup. For re-enabling afterwards, we'd have to freeze scheduler
> and cgroup state and find all tasks of interest across all CPUs for
> the given cgroup to recreate the counts. I'm not quite sure whether
> that's feasible, and if so, whether it's worth the savings.

If this turns out to be necessary, I wonder whether we can just be
opportunistic. ie. don't bother with walking all the tasks but only remember
whether a task is accounted at a given level or not (this can be a bitmap
which is allocated at cgroup attach type and in most caess will be pretty
small). Then, maybe we can just start accounting them as they cycle through
state transitions - we ignore the ones leaving states that they weren't
accounted for and start remembering the new states they enter.

Thanks.

-- 
tejun
