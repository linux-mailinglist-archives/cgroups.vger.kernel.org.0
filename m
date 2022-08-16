Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A259659C
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiHPWqN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHPWqM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 18:46:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437AA8C474
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 15:46:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f8so560069wru.13
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s8pSl43fKh9JnCgmD3zX1WMUhwtcyLQMOInMOIHCWPM=;
        b=thGApBqcLsCEmh3pIRfPPTjA3/bLHUE0lVp6KZuhpZ8/XaxKjSsw2BgdMdYpP7ymnM
         ESvhyZMAMxvD3tRAEHWhsBP4GBQ7bWNSFVOiHm8hVtj7TtWfbSO7esaMlrJdPbZVLxNL
         CYhy1R0vjrjAWOGyIkBU1oDpc7QJ07rRnQEI96teV0fQ7kB206wfqAtWu/n5JTBwin+Y
         gfYvRzKW0pP5oI6tx+cfkf8sbbDsqbDcDAmH/p3uB1UdWO0XuhgPb1atJCwrJPXkl4ZR
         z7vyDT8KVdEDBNzSqmC9WOKYvYldB8VcollbxJa2iys4s4DTw12zi5MwFE7uJjE7PIWS
         1jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s8pSl43fKh9JnCgmD3zX1WMUhwtcyLQMOInMOIHCWPM=;
        b=j0gwCdpMqhNC/Rawo7zYkj0l1mMtWDIRduMJ1EYuaTB1nBp+uSu+RwYqcwKS9lVEd8
         flVMw44UpVtfyN4U3006Dcu5+w+uWTtF1DbH3uxbRspSu3kpCv6wmaA3lbWOls3M1be/
         VMpmoF+w5APqtkOi1zaofHL9Yai64daeHrDLdvV+X8Guj+zd81xjpHXwqNiho3muvPip
         dBN5JnykaRiTqeH9Gm1Uh/dKPPHLena8aOn+XywswUx5Hj//xSrAWrRhZdlHxXhEt7SN
         njAtb98vmJojdIIkjFofTpa3bhgPblWqdOC0YFCN6IzNfery7V+6ZGfuvVmpXQkNJyUA
         DtZw==
X-Gm-Message-State: ACgBeo3G5NpfLnHkve5P3ggaI6TUWWlzZi3NN3i/KYXxgbyQnpUcUzzx
        XCPyzl0VL7zLCFHhPXM2X/+AYb6uqwZYzgI2uQVZtQ==
X-Google-Smtp-Source: AA6agR5YDZNX8BGW0we+ymcE37/vFJkAbxtvIx5oh+8aSvN3oBazJLky1o2ZU3nNXabaqECW4fCIGnOv1/Bxx2ETrTo=
X-Received: by 2002:a05:6000:11d0:b0:225:1c12:65f8 with SMTP id
 i16-20020a05600011d000b002251c1265f8mr2254049wrx.80.1660689969725; Tue, 16
 Aug 2022 15:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220816185801.651091-1-shy828301@gmail.com> <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
In-Reply-To: <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 16 Aug 2022 15:45:33 -0700
Message-ID: <CAJD7tkZrQZ8CR0E0vKnXGWFLPChxFmNaSQUkFAm1icnGnE6Tew@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Aug 16, 2022 at 3:06 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Aug 16, 2022 at 11:58 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > Workingset refault stats are important and usefule metrics to measure
> > how well reclaimer and swapping work and how healthy the services are,
> > but they are just available for cgroup v2.  There are still plenty users
> > with cgroup v1, export the stats for cgroup v1.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> > I do understand the development of cgroup v1 is actually stalled and
> > the community is reluctant to accept new features for v1.  However
> > the workingset refault stats are really quite useful and exporting
> > two new stats, which have been supported by v2, seems ok IMHO.  So
> > hopefully this patch could be considered.  Thanks.
> >
>
> Is just workingset refault good enough for your use-case? What about
> the other workingset stats? I don't have a strong opinion against
> adding these to v1 and I think these specific stats should be fine.
> (There is subtlety in exposing objcg based stats (i.e. reparenting) in
> v1 due to non-hierarchical stats in v1. I remember Yosry and Muchun
> were looking into that.)

I think only kernel memory stats and zswap stats are objcg-based at
this point, right? The workingset refault stats seem to be memcg-based
and should not face the reparenting problem.
