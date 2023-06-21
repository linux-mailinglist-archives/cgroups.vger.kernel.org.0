Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B7738F1E
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 20:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjFUStD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjFUStB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 14:49:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D71E42
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:48:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ff25ca795eso28011cf.1
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687373339; x=1689965339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktaN2gfy2UoFzSis8IakrvfByDQPNIqA2OzFHTKqH6g=;
        b=6g8bjgJ05d+rXqPxYemA4IWXC+J1Ela6mFMkncMRIuq1/qtJbHccQZq5eNnK8I5qe0
         hHNtT089lxLYIpUCWKimJ7OvTnk3AqftjEne3x/QKdPrTQj7whhf9V7QXpmEIjhdikxt
         3RUxgdzBP7JyIEHwuW1EfLOcXwuB5TITZDI0M9cW8LfCeT6p8VPkPbdIAj+Bz1xOsg4h
         wX9LbCEVcoDUhWSHLG5Y939Eqa61h2yFQYFGh0vJ5vX9YJMSwF0ASQbl++WFw3qZiFK/
         UWDxKAbJQKcXA5CFkGIQw1AxgIxNjJ0wsXMZhvPgK37ovf8LI3YrUUA00uM18dZNvF5J
         3yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687373339; x=1689965339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktaN2gfy2UoFzSis8IakrvfByDQPNIqA2OzFHTKqH6g=;
        b=aW3/hrXKj+4qFBlnx5Oj97PxanicJjuF8EPQz+rrpjVmI3hpTw6FaYxKgvgy+Ryb2t
         AAtI6rsbTfrMwJ7I/4hWU2KL+2OCGQlttfS5QEpRiBE15OIzWM6WP4J8M+weID0WP9wN
         iM+1hvSv/WunLVnHiiGGsV3+2EjIA1yHzIyEb5FsbmOM1E9o1OqQbhHYuYNW4hSmdutY
         oSKgEghxRMu8GWaBuX1LvKc5elf7JbkxVCt5p8LHFXZmUs7pEk1YRLSjLuzagPVHceOA
         5a4qU0I/unlnAqNrtlsL+aM49cdQdjWZKEbctYOMv1jx0tzGKgHte41UY6Xb/bcBOSq4
         OUGQ==
X-Gm-Message-State: AC+VfDzrLaoRRJWD+ppeRuH40V6DT/qfntHLT9Dbe/LV3rSNOBhYgyjm
        hgOaVN2iTpGUIf0QEjpsezMJ/TVuy9KBLJM92HAQNQ==
X-Google-Smtp-Source: ACHHUZ6wyaGZhoIo4tRyOV5BV1WFj8xWmG+hpZ4QuVswZetsBCPxzzNXwssbZELyoFmUobNTTkI7G9Dgv5b6Tpp1DrY=
X-Received: by 2002:ac8:5954:0:b0:3ef:3083:a437 with SMTP id
 20-20020ac85954000000b003ef3083a437mr284103qtz.18.1687373338729; Wed, 21 Jun
 2023 11:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230621180454.973862-1-yuanchu@google.com>
In-Reply-To: <20230621180454.973862-1-yuanchu@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 21 Jun 2023 12:48:22 -0600
Message-ID: <CAOUHufbb9_Cah6tT61+WKfM0T9CDmkZ5zym=MuHj2YVsgh-hiw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] mm: working set reporting
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kairui Song <kasong@tencent.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        "T . J . Alumbaugh" <talumbau@google.com>,
        Wei Xu <weixugc@google.com>, SeongJae Park <sj@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 21, 2023 at 12:16=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> w=
rote:
>
> RFC v1: https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu=
@google.com/
> For background and interfaces, see the RFC v1 posting.

v1 only mentioned one use case (ballooning), but we both know there
are at least two solid use cases (the other being job
scheduling/binpacking, e.g., for kubernetes [1]).

Please do a survey, as thoroughly as possible, of use cases.
* What's the significance of WSR to the landscape, in terms of server
and client use cases?
* How would userspace tools, e.g., a PMU-based memory profiler,
leverage the infra provided by WSR?
* Would those who register slab shrinkers, e.g., DMA buffs [2], want
to report their working sets?
* Does this effort intersect with memory placement with NUMA and CXL.mem?

[1] https://kubernetes.io/docs/concepts/configuration/manage-resources-cont=
ainers/
[2] https://lore.kernel.org/linux-mm/20230123191728.2928839-1-tjmercier@goo=
gle.com/
