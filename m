Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54C56412BB
	for <lists+cgroups@lfdr.de>; Sat,  3 Dec 2022 01:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbiLCAo2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 19:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiLCAme (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 19:42:34 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE4FB8BD
        for <cgroups@vger.kernel.org>; Fri,  2 Dec 2022 16:38:49 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id a17so4509091qvt.9
        for <cgroups@vger.kernel.org>; Fri, 02 Dec 2022 16:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kyGFfYS/plbzynwCBVibsB0WfjTo115MTZXFZB/rmqo=;
        b=EMVfb0BFJTjVmNy6vSXLrRsub6ysrPgFop4v+XDzpDWxLBPCkg5EE3qLcF6qHKieFG
         oIA8WIfPsc6WoZL1UoR+/QUz24AkzclUe4HYEbsZlBgI4tlCGU1vEtP/NPAlMxAbAbNT
         uOGVDbrEVG6InqCH/jC71VurH6YLlOL1TNx5HrI2egY7OuPIKdBN0TMmRYm9AXOqlWFF
         tzmjcnvaXCZLixRP9xOexbWcRY2JtNOQRYs3ptdIGUuw9E41szx5cIEgjdZSJaJff0AZ
         azUxffyUWHMhF0XyoCRk1tTKaNf6wglOwoy545S6V/kbwlQG1TjH1Hc4GGsP2lbIb42S
         jRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyGFfYS/plbzynwCBVibsB0WfjTo115MTZXFZB/rmqo=;
        b=V7rqTKwAYjjkZ+adcLBRWyC4EmzZA4HiDm0VDRMGrupz7BGGoJwmvQjCol/XI5xD1X
         Tn0tOYYXKirA2l4KTYUhsv6v8+qSR5f6iK15J1UIY2cpi5nDuwITaczPBV42ROVp+bhe
         FYokGoHY/RIV9/PUlDfUKmvMNc59zp2QbwS4VUBvXJhcIRdjCsPRhsdb59+gozJq8c3W
         oV6YVOijGrSg3xteuiIO5f2tO9KHarbpo8K/4vtTocNEMpOi+1bQjlvGJ4AUTz/r991/
         2MIsIpcaa1pYkGmblWBcrqTFwzf5vthCtpbNLMs2alz+5fFPFfc7g6LcRl9LblPGAsrA
         QRlQ==
X-Gm-Message-State: ANoB5pmBNFIPC9pGJSjTZDczZ6aKCsNPIXwY7ZtWXarIfBgLNCd7ynzT
        Rf2i/cXNbFvQ+Kv2cUyuMwDtbPgkiouNv7g7AgblCgx3+AKNwQ==
X-Google-Smtp-Source: AA0mqf7oMbKwQUSOCRp91znGHivA8GP2wkAnqCrRewLNNTtTLITce/WkFju4STjiydMcTKrgaG7S+g5vEPVBFkXWC8c=
X-Received: by 2002:a05:6214:29e2:b0:4c7:16:f900 with SMTP id
 jv2-20020a05621429e200b004c70016f900mr24042558qvb.15.1670027928698; Fri, 02
 Dec 2022 16:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20221202031512.1365483-1-yosryahmed@google.com>
 <20221202031512.1365483-2-yosryahmed@google.com> <CAJD7tkZouk+r=Qk554AOk1-3eYy-gTC8KC+OJQY13ZkNZ9Qe+Q@mail.gmail.com>
 <20221202163527.a72646c9d42f3678b20dac7b@linux-foundation.org>
In-Reply-To: <20221202163527.a72646c9d42f3678b20dac7b@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 2 Dec 2022 16:38:12 -0800
Message-ID: <CAJD7tkapGALWoqrs+cbE8i1w4eDcdj=naHxqybPu6NLAnCZ0iQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memcg: fix stale protection of reclaim target memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Fri, Dec 2, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 2 Dec 2022 16:26:05 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > Andrew, does this need to be picked up by stable branches?
>
> Does it?  The changelog doesn't have a clear description of the
> user-visible effects of the flaw, which is the guiding light for a
> backport?
>
>

There are 2 example scenarios in the changelog that misbehave without
this fix, cases where the protection of a memcg that is the target of
reclaim is not ignored as it should be.

I would think that it needs to be backported to stable releases,
unless Roman or any of the other memcg maintainers disagrees.
