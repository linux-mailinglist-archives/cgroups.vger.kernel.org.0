Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992B0561EB0
	for <lists+cgroups@lfdr.de>; Thu, 30 Jun 2022 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiF3PCX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiF3PCW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 11:02:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A11FCC4
        for <cgroups@vger.kernel.org>; Thu, 30 Jun 2022 08:02:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3363041pjl.5
        for <cgroups@vger.kernel.org>; Thu, 30 Jun 2022 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sVpG9rw+5yvfJDEn00fP0oAwAgYQhlkWm1yb+6MkVQ=;
        b=NiW6mwj9iUsBV+W7Ai/+PWhAw39Y9q6S++ER4iQXFo1lO5ubXIPgQGODZnubh4TpZ9
         0N2XCniSpn8Y8y6CCkYJty8KQ9Iot6ipgDn8K1kbsIRsp5bm2Y3+1OpgSLWu3VhYSIam
         NPFLUooLt7L7siRALdEECBO9DTHlbHS4Vq131X17ZqvvLP4ozqDximEx5OzBtbGuGzkZ
         zPXeaESFKYAtphPdPOeq5RUameMhlbkH6tuWpqq6yLpzFQxr6hWYPN/0VxiWJshDRhKC
         +rMkNz+405Ymt7j75iU6v0ugXDphKKBxrFsJ5Kz24upvEQLX1rK0J/ygvYxNaepQ5HNq
         gI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sVpG9rw+5yvfJDEn00fP0oAwAgYQhlkWm1yb+6MkVQ=;
        b=k8YbV/+OYeTOoG+twGuW+w/C166rHpNGcXw33+O4sad4cU9TsgM7yPbXE2jHmaqxCC
         d+pymxjLz/tGoXVc8sqC9GhdZJWsQPq4RDkWoxpzSHIvPNNmKvnNUAy0nwNMO3whCmwu
         Mxnfh0GbuE9yFtGsHa3WHfgGvaMRuV3+9z7mB+0i/vH2zXuqFDvwBNuQLQEV5TwjNpyx
         fHOnyMUp9zBfv8/fCQ1SWdeY7jlU3Utd2EStTxRYNXOuLRv0wmzX17pq+WherIaVFARE
         iyNpuaLuLg1KZq5Kf5E+/ltGRCHNLMF1ETp+cMpkceek7FNCxiGGeZTkVnD0Qyo5uC0n
         7OlQ==
X-Gm-Message-State: AJIora86p9kf0dqWVkLeSE/n86yPFfjWyu9gdK2WypO5yAXdSvGCd82F
        Ko+tpiDVGrtxVD0EocIDVN+PwvKaypS7+aWTvsF56Q==
X-Google-Smtp-Source: AGRyM1u27TEN+VQNqG5ylin9u0PllIdI94eXfKZEQCbN5w4n9kKS+0BOVyUk+UR7emocZGKred4OE4zPUfo90QF4eYc=
X-Received: by 2002:a17:90b:1d8c:b0:1ed:54c3:dcca with SMTP id
 pf12-20020a17090b1d8c00b001ed54c3dccamr12512122pjb.126.1656601340985; Thu, 30
 Jun 2022 08:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220630083044.997474-1-yosryahmed@google.com>
In-Reply-To: <20220630083044.997474-1-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Jun 2022 08:02:10 -0700
Message-ID: <CALvZod4n1GqdNU49YVDxC1Ek_6Ob-HKUSm+48GJ_Y_gZw24pCQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 30, 2022 at 1:30 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> vmpressure is used in cgroup v1 to notify userspace of reclaim
> efficiency events, and is also used in both cgroup v1 and v2 as a signal
> for memory pressure for networking, see
> mem_cgroup_under_socket_pressure().
>
> Proactive reclaim intends to probe memcgs for cold memory, without
> affecting their performance. Hence, reclaim caused by writing to
> memory.reclaim should not trigger vmpressure.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
