Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1BE59671D
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiHQCB0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 22:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiHQCBZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 22:01:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115747CB55;
        Tue, 16 Aug 2022 19:01:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d10so10795763plr.6;
        Tue, 16 Aug 2022 19:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T2ryg0NvBsySTqlIKv0j1Rn9xWbe0EBoTZaBsyrpPQk=;
        b=fkzQolUzAnY5hgZafY8CAOMAGcTJQnGvyMyLIFF1z3Xo2xxxUJuriGFc8UjEdg+BL2
         AFcbfmvorQNxMfYo4o9tnxjUuTsOMdv7qr7e/cQ+wfDhTuMWn6MwHVmYVQ3hHda6zBlj
         WDpfPmhDmD/yRJvHcrbNr+RWJH0W78oZ9Y6o5NqBIkCLcy8u7op/fAQxs1CkdlpkVNdc
         Sr79Nb8kvT7YkFYBzO0fLT3gZ/YsfYvw9tKwRj+R+FuZUExgTdZ0bVWsEh9yqxmyzbqM
         DXZvI3z2ajuIdycmi5DDSQDOA3kJRoPwYNIeTQJXExyYxtfR9r3fw3wQ605hgWmU7MpE
         vatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T2ryg0NvBsySTqlIKv0j1Rn9xWbe0EBoTZaBsyrpPQk=;
        b=4suV7b5Wd+badOCfUTBawPW6g7i+SOR9YRwS4BkyxRj+BB15sBHppYbLzx7Gxd1c1E
         NgK0z3riovjCXX1UiE3Uu+VVrzj5KNLdtL85FtaJPV9nJntfelarDc0GAYBHgW8hht23
         FW3ImHR1u5ur393zX8kJvU/H+sULit5hfNruQ4uLDzHVHi0ii93uZozZhof44tOdSRF9
         xVZDYdSejx3RMt0lTQvGu7FZ48Ate8qAhX3QL6jKWimVztj8wLLXjY9EJKGYXHRb8mEG
         lTb+LSPaFj673RIeK7tK8+KJJuL671fbqWb3hwo4yBiliFd25btJFdbDNwX90taHVIwv
         +r/w==
X-Gm-Message-State: ACgBeo0OSA/5hBPrx29qCw+Vyf/rTphe5ErCQfUrLUmIXj05L/V2FGiH
        BeZer8fRBFQRL9Vo2lqHcrcD5PlHY8zscLMNxPQ=
X-Google-Smtp-Source: AA6agR5t25H5wDg2upmmIB++dF11M8APhafDGzQfESqj4hDt5g67WIpGUgLl6JJdDd5YBUEAZk9bHawnNtWULZmJjGA=
X-Received: by 2002:a17:90a:73cc:b0:1f5:353d:7374 with SMTP id
 n12-20020a17090a73cc00b001f5353d7374mr1398826pjk.21.1660701684557; Tue, 16
 Aug 2022 19:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220816185801.651091-1-shy828301@gmail.com> <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
In-Reply-To: <CALvZod5t7Qo1NQ040pRyWco+nJGn3hSrxZyuFQ0UBi31Ni6=_g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 16 Aug 2022 19:01:11 -0700
Message-ID: <CAHbLzkrSU3ZHRiZAxy9Jju3-3ZFpDmE4uMx81c+yPWN28_j+tw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The workingset refault is good enough for our usercase, but I don't
mind adding all the workingset_* stats if nobody has objection.

> (There is subtlety in exposing objcg based stats (i.e. reparenting) in
> v1 due to non-hierarchical stats in v1. I remember Yosry and Muchun
> were looking into that.)

The workingset_* stats should have nothing to do with obj based stats IIUC.
