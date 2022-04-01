Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36004EEA55
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbiDAJ0E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiDAJ0A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 05:26:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22E5BD09
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 02:24:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d30so1957166pjk.0
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 02:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqHcENevlipVpLwJzXjFe9d3oZf1LHDk3dciHpBysEs=;
        b=SE0wj13yNQUKOLM7y5D13X3QyLAcWrPwhqQndeixZUJj6q9pgA456c8KR80+WD0J4T
         0B29QRq5HhGLr5tyU1zOJD/4zhyujrn1COBvQHyQG0IkF+B7lhHruTepHwDZ6y0Dyqdf
         udoZQegWVZWcu+U+gY66/nsmhnOOOqWbZ3bsB0CLnxC+FTaiugBCHOBpEr/IvU87nfid
         ng87Quwf+lM88JUvep0VBVmphTmD6/NdezPovc4WuobQb42jRkZ7P9qMVe+O9TuFF3RL
         geu+SYCVcB0i0i/mVYgCqw80holeY6GYkG2zo8XI2CVyJ8+ZRn2wD0Aa1RbFQmuCT/gO
         npFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqHcENevlipVpLwJzXjFe9d3oZf1LHDk3dciHpBysEs=;
        b=2dKWM+gw3gb1tcTwxi2qt3T/RC6w+m5Nbob76kLA9xr+Vfwm1fYjq5clB4UN8QQ9fH
         N5gZnX7MratQrDabU0BX1I1CGCLGGDC2Un6G/fSW2oNNzIbJRFKdOO7T9QA78qQ3qamE
         vKIZMGDlX1AiqDc/Mn7BJFl6H48eZ9x77qAfXALCVL+QJBKE8wc8bOWrBELQOO2cP2qT
         X7v3LIkqRhc7+mu08mietQtT1wD5+BGr+a8/rnBzjM1F++TQIVNP6/tHVdOryD0ayZhU
         YVt5nV/p4bZ4d0HE029tcgREjzdRS0/guZRfmvrcfm+a+2uuRIVUVwgi6iiTANJjqlxJ
         q2NQ==
X-Gm-Message-State: AOAM533b4VESS96fX4He5rVmUFtjh/+URn5O7+IQWyu+A0zR469uiZAL
        b19CO0ECYKGRxK/gcKMXVfrqXgdHDfLKXO0U56cqhQ==
X-Google-Smtp-Source: ABdhPJyH95f+uF5qt0Sg+nXhMwNGNDRbUvVYUqz2vCJG9jFsEU4WrvTARHYgoWhnQP5k0RrMO50potZ/qEls6eMvXl8=
X-Received: by 2002:a17:902:f24b:b0:154:de5:a24c with SMTP id
 j11-20020a170902f24b00b001540de5a24cmr9550361plc.162.1648805049999; Fri, 01
 Apr 2022 02:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <874k3d6vuq.fsf@vajain21.in.ibm.com>
In-Reply-To: <874k3d6vuq.fsf@vajain21.in.ibm.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 1 Apr 2022 02:23:33 -0700
Message-ID: <CAJD7tka1UstKYBVrie-_1CgvtaLtVD1uwgzfk5SifxW4FQbOVw@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
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

On Fri, Apr 1, 2022 at 1:39 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>
> Yosry Ahmed <yosryahmed@google.com> writes:
> > From: Shakeel Butt <shakeelb@google.com>
> >
> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> <snip>
>
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     break;
> > +
> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                             nr_to_reclaim - nr_reclaimed,
> > +                                             GFP_KERNEL, true);
> > +
> > +             if (!reclaimed && !nr_retries--)
> > +                     break;
> > +
> > +             nr_reclaimed += reclaimed;
>
> I think there should be a cond_resched() in this loop before
> try_to_free_mem_cgroup_pages() to have better chances of reclaim
> succeding early.
>
Thanks for taking the time to look at this!

I believe this loop is modeled after the loop in memory_high_write()
for the memory.high interface. Is there a reason why it should be
needed here but not there?

> <snip>
>
> --
> Cheers
> ~ Vaibhav
