Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEF57BD2F
	for <lists+cgroups@lfdr.de>; Wed, 20 Jul 2022 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGTRuH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jul 2022 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiGTRuG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jul 2022 13:50:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A7CF7
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 10:50:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c139so10820916pfc.2
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPK1xSGNueZDg4ifFUEI8PtrdzUASZ9LzW78x/FVmdA=;
        b=o1lu30MhEHLv+1z/UwxTaic3Ke1o1strn9J68S6fTgqRNYxf94G2Cot76fFiDQbdii
         0se9bQGwJdlYVgwZjOP56cixjvOQRJMwNcggtcG3LIkguFvbfBZmYbT80Jaa6+W6I5Ow
         v+QM9AChW0NqOSSf+3+sisR3WOy7akkF6MbWoBlW9Mx2jqVW5DFmxlzWePrcQwX7s5xG
         AHNkzva6mCpi8uXZTnnRLzLO5FR1vUBytyLiwtw0iJTDerJX5Mgl2XXaNTqet7KzwaRW
         cQ9yxOnkk7OBkoutgMSNYB0dPosQxch8Y4Kq4iNTdQtEW4BTwXMkhRasJSjsGu1InOzr
         Wp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPK1xSGNueZDg4ifFUEI8PtrdzUASZ9LzW78x/FVmdA=;
        b=rGT47GIIWVbpI99+Cj56iuxMBNs0zRo/rn1UAp/FYPUSWnDEKVT9JnupfeNX9Un4Hr
         /8c39uobTuMzOpRtWF6uWFbsW9yr3VxXR2lM/HBhdMqAouxFzJugE+HZ3nomX8THHz7a
         HPYpKHM1ojlQcBitEFW78BON2ixYFrb8BkgPOtKwdQtvMim4/aIHGtQCECXdyomm6TTp
         aBbGLmT7+EzzS0vOZ/KGbDePkvajF7Xp57gsOuv1MxG8Wjr8Kc0gaIjpnVTwD77GKmkr
         r31PQyjTVlLPQkuhOYHb0cMSujH+GxFou2+I2YR3UbKmLDnDbFI9ORw7WqvfYRTV3b5O
         4lSA==
X-Gm-Message-State: AJIora/1pcx3AjhqNnSx7HgOpRiyHSO6gCFTGmYIxzJ79fwiZFz4VOgK
        b36W0Yyy+PX/onjls0zP8hbeLkUoRFfobz5W0URgrQ==
X-Google-Smtp-Source: AGRyM1vn1UfRAhqTF02gy4Fa67sB/TV9LWC+MWq4qk7Ub3qiFTRlQbSTFwOECLKyOfrPgQJTG8a4S3GrI7h0jUnZido=
X-Received: by 2002:a63:c106:0:b0:419:b303:2343 with SMTP id
 w6-20020a63c106000000b00419b3032343mr28798192pgf.166.1658339404600; Wed, 20
 Jul 2022 10:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220714064918.2576464-1-yosryahmed@google.com> <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
In-Reply-To: <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Jul 2022 10:49:53 -0700
Message-ID: <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
>
> I think what we are missing here is
> - explain that this doesn't have any effect on existing users of
>   vmpressure user interface because that is cgroup v1 and memory.reclaim
>   is v2 feature. This is a trivial statement but quite useful for future
>   readers of this commit
> - explain the effect on the networking layer and typical usecases
>   memory.reclaim is used for currently and ideally document that.

I agree with the above two points (Yosry, please address those) but
the following third point is orthogonal and we don't really need to
have an answer for this patch to be accepted.

> - how are we going to deal with users who would really want to use
>   memory.reclaim interface as a replacement for existing hard/high
>   memory reclaim? Is that even something that the interface is intended
>   for?

I do agree that this question is important. Nowadays I am looking at
this from a different perspective and use-case. More concretely how
(and why) to replace vmpressure based network throttling for cgroup
v2. I will start a separate thread for that discussion.
