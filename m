Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F795BD681
	for <lists+cgroups@lfdr.de>; Mon, 19 Sep 2022 23:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiISVh2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 17:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiISVhI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 17:37:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8332A26D
        for <cgroups@vger.kernel.org>; Mon, 19 Sep 2022 14:36:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id fa8-20020a17090af0c800b00202dd39c035so409299pjb.7
        for <cgroups@vger.kernel.org>; Mon, 19 Sep 2022 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=gBPDRnXdyvF4xAXr245jZgfFcKRBxlvo8nsBRpPChFM=;
        b=pBQdFlYTW5SMJZLEMS2PIeY/jXnxQHmBdVPB0G13hsQ/jjd473V1RsISyxaNwQYjyP
         yH1LP0v5pq5LDRQLhpdkRO31sgmsuTaBoWRWpfl3oJObc2DyxrjOIJQRM78202UbhSDs
         I3YXeiX+4M9mVmC/jNaFEUhrogAJuDu88LJDMqkZifaAjpi+hYvR1xpnjM+HACqJ94bB
         LajxRGIq9aCsw8DTPeTOjXxhSvXNlH3t+YvGLSTEWAQ4/W3reGAiQWXWsg7YBT9/1i1f
         x7kIHKYQ/xdvouPjm2aKVRXkjRJtsiVBtIUblxJ9idoqr+i9hG1fedynPAQfkv10QNB9
         TPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=gBPDRnXdyvF4xAXr245jZgfFcKRBxlvo8nsBRpPChFM=;
        b=ndHB41hTuzC9eAjlFBQ8VezNQ6mP/Tv8dhLGLPEwnTq+NCncxfCGbLiMR/Gl6HOAZD
         +APwiCZ13hPzCzDb1t5lpFvgVZ+Je6/06XieRgehLPCu/nzWSI7OPwpfZ3CzcNM6bF07
         7O9J6dRWZzkNQx0usV8s+5JEJwrELHPxBBj5x84X1dWmRb9qKnvUFIO7/41+RUdYRzTw
         zXZXLwYULpzLYy1ONqJcjJAVkZD4VJ9gybJLOV1f03yM7QukNsG75d+HFOBH/kvs6kAN
         AvdlEwtZ/y1DUPVcjXC+uqmKoys0TzBnxUNO38DfcHXp8yPK5MamGVSDO83bX0Q5uM4Z
         aU0w==
X-Gm-Message-State: ACrzQf2Gg3G/qXrW0xbB3Pl8tbKf9rZXRCo+iQ5SV2NrD5CDwwfavK6e
        +La35CcSGaIIBqypa3H433NetjqoGsRcfQ==
X-Google-Smtp-Source: AMsMyM5N8FWtYCLqNF0zfkdeNsEsbGZbL/ZlbqHTPultDwLR5KPcpZgvQuO9hx4F8/FG9yKpgr9DjPIcxlzz6A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:254a:b0:200:53f:891d with SMTP id
 nw10-20020a17090b254a00b00200053f891dmr246179pjb.168.1663623385293; Mon, 19
 Sep 2022 14:36:25 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:36:22 +0000
In-Reply-To: <20220919180634.45958-2-ryncsn@gmail.com>
Mime-Version: 1.0
References: <20220919180634.45958-1-ryncsn@gmail.com> <20220919180634.45958-2-ryncsn@gmail.com>
Message-ID: <20220919213622.s3w2v2q7ktvbrpha@google.com>
Subject: Re: [PATCH v2 1/2] mm: memcontrol: use memcg_kmem_enabled in count_objcg_event
From:   Shakeel Butt <shakeelb@google.com>
To:     Kairui Song <kasong@tencent.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 20, 2022 at 02:06:33AM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently two helpers for checking if cgroup kmem
> accounting is enabled:
> 
> - mem_cgroup_kmem_disabled
> - memcg_kmem_enabled
> 
> mem_cgroup_kmem_disabled is a simple helper that returns true
> if cgroup.memory=nokmem is specified, otherwise returns false.
> 
> memcg_kmem_enabled is a bit different, it returns true if
> cgroup.memory=nokmem is not specified and there was at least one
> non-root memory control enabled cgroup ever created. This help improve
> performance when kmem accounting was not actually activated. And it's
> optimized with static branch.
> 
> The usage of mem_cgroup_kmem_disabled is for sub-systems that need to
> preallocate data for kmem accounting since they could be initialized
> before kmem accounting is activated. But count_objcg_event doesn't
> need that, so using memcg_kmem_enabled is better here.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
