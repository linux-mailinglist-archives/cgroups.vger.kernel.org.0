Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14F5F5B33
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJEUsZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJEUsY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 16:48:24 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28F7F11D
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 13:48:23 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id y20so6803054uao.8
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pH0zOlds4k1pn2k9y2zQLXOdbFwcJ2yiRKb/htjH3Uk=;
        b=FErrZMzivjR/A5E21MQn1/2DXduzHVWRROGe6Ud2gjscvz10sql8a5gaj4ZD9xSVNA
         dRXymD67ilwrVSpkDTL1H7ylxFC9pYd5v8NEYKLasINuw1TmiBeEN/mvHu7qICAYTImQ
         ka5uL0ncuFTlmRm+6hHIQ8Ma/zzn9dBJr29jm8qai3w/UZv82Q4CFeUMwzTJRTQlnO5Z
         pbo78ytl4764MoBLJZ7Pk9DqkeS6bGKMYc8z9/drFxdZH9SxPDuk4dvvmVE0jUQWs8ws
         W9iL7p9O4vr/dX+J9EL1DxXuM4hP/Vfq6OsFjBGOh6oSf52rB8x/J8TujBSrtukQ954H
         w2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pH0zOlds4k1pn2k9y2zQLXOdbFwcJ2yiRKb/htjH3Uk=;
        b=GpoWDPtjjXFphM/HAGM82YaPCt3a5TqlOKmQ/NCJyA5+3OuHMu6m0UhcX7Y8YtKx3u
         UNBFRffHh62FcJMArFdlBH3p9BgdkTB47mvE+/LEi+W7USWoTmw/8FYFCKOS0lLY4FKC
         NQK7NxSeEfiK4LMAu2KMV7FhJi2biPpOVZ6LcjPx7KiThVv/5NtBDnfmCUEFD+5CmPyL
         jbnBLJp3Z5W/Cl8YR+JpeGgA68EIqnF30202zF2dFNK4USEP/bPF3YgfK32pI8mBO4Ek
         eSnVOh7bqv12Dy0A2GmyXEYOj0ht19jU+Lx333R3Q6Yz7DgiVnwyQF0Bi9oLr2QkXt/S
         wR5w==
X-Gm-Message-State: ACrzQf0ovs9u+iHGu6sAWuZbOJXVNgrSQNKmN9AvKPEmUsQaNzjkfABM
        rPm92BvLORx5qwH/qyrG0Ro66Fizmh5/y3DgWQORlQ==
X-Google-Smtp-Source: AMsMyM6aTCliTCNY0L3OfUC8MMYfTb5EC3wVMouU8hxv59dCZ3tOJB0Dj+k0ZL1fw1l6+vgk5PoBTP30v9tv23NkiUg=
X-Received: by 2002:ab0:6f94:0:b0:3d1:d6e5:5de6 with SMTP id
 f20-20020ab06f94000000b003d1d6e55de6mr837772uav.51.1665002902081; Wed, 05 Oct
 2022 13:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221005173713.1308832-1-yosryahmed@google.com>
In-Reply-To: <20221005173713.1308832-1-yosryahmed@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Oct 2022 14:47:46 -0600
Message-ID: <CAOUHufaDhmHwY_qd2z26k6vK=eCHudJL1Pp4xALP25iZfbSJWA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 5, 2022 at 11:37 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> During page/folio reclaim, we check if a folio is referenced using
> folio_referenced() to avoid reclaiming folios that have been recently
> accessed (hot memory). The rationale is that this memory is likely to be
> accessed soon, and hence reclaiming it will cause a refault.
>
> For memcg reclaim, we currently only check accesses to the folio from
> processes in the subtree of the target memcg. This behavior was
> originally introduced by commit bed7161a519a ("Memory controller: make
> page_referenced() cgroup aware") a long time ago. Back then, refaulted
> pages would get charged to the memcg of the process that was faulting them
> in. It made sense to only consider accesses coming from processes in the
> subtree of target_mem_cgroup. If a page was charged to memcg A but only
> being accessed by a sibling memcg B, we would reclaim it if memcg A is
> is the reclaim target. memcg B can then fault it back in and get charged
> for it appropriately.
>
> Today, this behavior still makes sense for file pages. However, unlike
> file pages, when swapbacked pages are refaulted they are charged to the
> memcg that was originally charged for them during swapping out. Which
> means that if a swapbacked page is charged to memcg A but only used by
> memcg B, and we reclaim it from memcg A, it would simply be faulted back
> in and charged again to memcg A once memcg B accesses it. In that sense,
> accesses from all memcgs matter equally when considering if a swapbacked
> page/folio is a viable reclaim target.
>
> Modify folio_referenced() to always consider accesses from all memcgs if
> the folio is swapbacked.

It seems to me this change can potentially increase the number of
zombie memcgs. Any risk assessment done on this?
