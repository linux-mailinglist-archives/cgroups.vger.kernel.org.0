Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EE875B2E8
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGTPfq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGTPfb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 11:35:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE442D73
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 08:35:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403f65a3f8cso8574791cf.2
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689867318; x=1690472118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n+rFJmpt3qB6JDh31e2VoNgqrjqEMhcmnlZeysYmYE=;
        b=4k9D+J7Kpdc0v2PabFm8Hmk1Rg0EfWw4RPCEG+efTc4WtuWKXjt/fnBhLoqCeZE2tu
         ZJZgFzOafPl7KmThIItTT/LAYNvIuj4QKYPs3Y/WUaerPCDvtD8AbSYxdJBV6gq7erZ0
         QkSqfy+6llSiQFqdoU+Kj0piE8M5QnD+2ORQ6bx9iEqn54wsDOFBvtj9QYGtnMZTZ8U7
         KfVsmYYL0Ey+U08VcwemcoYSxU65LDlXnWhRO97b+vEfwHygN164fwsiag0Q4Bu72//P
         +QQgOU1mJjt87DcTNtsI3PcXd+3/ZgW182eFDepQugrD6/ju3NE4lu6THcTcE7LkVK6j
         uHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689867318; x=1690472118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n+rFJmpt3qB6JDh31e2VoNgqrjqEMhcmnlZeysYmYE=;
        b=N5rjpOdeSSAQ6jv/fDMJoPw1LXcBLmyId45uaYRhJr+QsDc2HmAC6gTtvM4wiWaJbo
         GPBC1hXjn+MG2liVFBgTYrE/Wl7eU5c+iE6UfMgsSpuHpMBkGaGvzFQgfXlvn47RLpgE
         /T61IgrQZqxWX2Sq3DhGnh2Dna87o9reb/RTP7nhDCytyS218oVrHolflgnUAXeb1Yfc
         ZtWyx61Jy4UmcaLrpPL5/5+AaaRAG6TWvlSSfkccXSZoxbMMD25MWa4YbhHqnkOgylgv
         +dkSVqj0GTwqiMXgmzjUpJXbVJm/k9kHtf/t6e2LiO3p5CrCDZpjq/6faGx8xOvnxKsf
         vP/Q==
X-Gm-Message-State: ABy/qLZZW0EC3nkki+JtVUFVsVhfR59z64ykTKk76T2MBTlbN5Wp+wqZ
        ee4Dumt4ucNskHoOxGp0xYagQQ==
X-Google-Smtp-Source: APBJJlHmfBUgJQ9Se08lJnq+G/rIdvG63OoRA/rvVvwg/oR7kPGHTKFIctM5V0m+lPCob+QaJys7Ow==
X-Received: by 2002:a05:622a:15c7:b0:405:42e9:8a8e with SMTP id d7-20020a05622a15c700b0040542e98a8emr2557869qty.57.1689867317844;
        Thu, 20 Jul 2023 08:35:17 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id fg14-20020a05622a580e00b0040399fb5ef3sm443668qtb.0.2023.07.20.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 08:35:17 -0700 (PDT)
Date:   Thu, 20 Jul 2023 11:35:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <20230720153515.GA1003248@cmpxchg.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> This patch series implements the proposal in LSF/MM/BPF 2023 conference
> for reducing offline/zombie memcgs by memory recharging [1]. The main
> difference is that this series focuses on recharging and does not
> include eviction of any memory charged to offline memcgs.
> 
> Two methods of recharging are proposed:
> 
> (a) Recharging of mapped folios.
> 
> When a memcg is offlined, queue an asynchronous worker that will walk
> the lruvec of the offline memcg and try to recharge any mapped folios to
> the memcg of one of the processes mapping the folio. The main assumption
> is that a process mapping the folio is the "rightful" owner of the
> memory.
> 
> Currently, this is only supported for evictable folios, as the
> unevictable lru is imaginary and we cannot iterate the folios on it. A
> separate proposal [2] was made to revive the unevictable lru, which
> would allow recharging of unevictable folios.
> 
> (b) Deferred recharging of folios.
> 
> For folios that are unmapped, or mapped but we fail to recharge them
> with (a), we rely on deferred recharging. Simply put, any time a folio
> is accessed or dirtied by a userspace process, and that folio is charged
> to an offline memcg, we will try to recharge it to the memcg of the
> process accessing the folio. Again, we assume this process should be the
> "rightful" owner of the memory. This is also done asynchronously to avoid
> slowing down the data access path.

I'm super skeptical of this proposal.

Recharging *might* be the most desirable semantics from a user pov,
but only if it applies consistently to the whole memory footprint.
There is no mention of slab allocations such as inodes, dentries,
network buffers etc. which can be a significant part of a cgroup's
footprint. These are currently reparented. I don't think doing one
thing with half of the memory, and a totally different thing with the
other half upon cgroup deletion is going to be acceptable semantics.

It appears this also brings back the reliability issue that caused us
to deprecate charge moving. The recharge path has trylocks, LRU
isolation attempts, GFP_ATOMIC allocations. These introduce a variable
error rate into the relocation process, which causes pages that should
belong to the same domain to be scattered around all over the place.
It also means that zombie pinning still exists, but it's now even more
influenced by timing and race conditions, and so less predictable.

There are two issues being conflated here:

a) the problem of zombie cgroups, and

b) who controls resources that outlive the control domain.

For a), reparenting is still the most reasonable proposal. It's
reliable for one, but it also fixes the problem fully within the
established, user-facing semantics: resources that belong to a cgroup
also hierarchically belong to all ancestral groups; if those resources
outlive the last-level control domain, they continue to belong to the
parents. This is how it works today, and this is how it continues to
work with reparenting. The only difference is that those resources no
longer pin a dead cgroup anymore, but instead are physically linked to
the next online ancestor. Since dead cgroups have no effective control
parameters anymore, this is semantically equivalent - it's just a more
memory efficient implementation of the same exact thing.

b) is a discussion totally separate from this. We can argue what we
want this behavior to be, but I'd argue strongly that whatever we do
here should apply to all resources managed by the controller equally.

It could also be argued that if you don't want to lose control over a
set of resources, then maybe don't delete their control domain while
they are still alive and in use. For example, when restarting a
workload, and the new instance is expected to have largely the same
workingset, consider reusing the cgroup instead of making a new one.

For the zombie problem, I think we should merge Muchun's patches
ASAP. They've been proposed several times, they have Roman's reviews
and acks, and they do not change user-facing semantics. There is no
good reason not to merge them.
