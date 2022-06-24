Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161855A43D
	for <lists+cgroups@lfdr.de>; Sat, 25 Jun 2022 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFXWOf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jun 2022 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiFXWOe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jun 2022 18:14:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FAC88585
        for <cgroups@vger.kernel.org>; Fri, 24 Jun 2022 15:14:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so4843200wrg.7
        for <cgroups@vger.kernel.org>; Fri, 24 Jun 2022 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06tbzvuWnDn/ojvXnYPhb8CvvsnPZweg8Ptkv04ne9A=;
        b=PezAL6Z4bntjGvU+BMZLwRyhf28/GmBbIJBsejRH4AXcHj0tEMTzn0npOOKoQycFMd
         MV5n8Vq7cziNpbAUtr4QJNY39+kZjKT8t1BehD2UIH+1L0axymRzGaiDpEv9IvJTVw+I
         t8UXmTIpQqtGkE2KJZE2kR3ShlyayRxfpdoB2VkfA03l8nnH4vglTRo9xQhV1hkJRA+L
         fIc4vv119yqNnytJ2q0ixppfhnFNd+uQkDSHguz8oTdBnwdNWfqQcRtg7LzWYL+NNvCa
         bIRxgK7gpbSOeS0134bGmanM74Wv4BmqsLMWULmsZxPc0k0NVLTUhIYHf9Z1eowOK1xG
         6c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06tbzvuWnDn/ojvXnYPhb8CvvsnPZweg8Ptkv04ne9A=;
        b=nHb6rfv6LbsCf18hpWaE3vPxVdCCDwPovknYi8ss0Pv5DuBQwLsOxlLmb8D7TpVZHr
         smpmlqilDJNTnUOAixKmzGwS3K/ohiy1hRQQIJBkw/+a/rH+r5Ml3n3W8mfWfOhPtbkr
         45Tb0Q85OxhqGAWZeGPWlY7s6rci5C4kquEHfA39yhw8KQhgk/dXhOWJzl9ivK6HohGy
         aMmdv9jtDVjgzaoqhZdO52TBxUxyt6R5WnXPkLuMA2goCuzCJtu6eOQEu3ZY3/+XsjQ+
         i2htH0E8rsurQicah1pN15x1JyNirUdxyetL38hD1GLbUo2+bHWE1Pvy8lb62NY6GOq1
         qdTw==
X-Gm-Message-State: AJIora/UjrmArMC4EzoMRstLaCRmba5LQz9drmpeiWdioKZAftcNOqiH
        Z0zI3A5teQvFovY1Cv1jtTdaKEr3bKGlRFWDkEJuoQ==
X-Google-Smtp-Source: AGRyM1sarZuBwUn1KFngbXMFDQ2bFNAHV4wVHQMYAe95mqZf6gYFG9NKduLzGFHQNbVi8OvNTHmL6M6mjJrd9b7iMHk=
X-Received: by 2002:a5d:6ac4:0:b0:21b:a724:1711 with SMTP id
 u4-20020a5d6ac4000000b0021ba7241711mr1129245wrw.80.1656108871698; Fri, 24 Jun
 2022 15:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz> <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz> <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <CAJuCfpG6D1fhc4c_-0cL=rmXUbhdROSWsObYrZ7Mp4=+sBkT7Q@mail.gmail.com>
In-Reply-To: <CAJuCfpG6D1fhc4c_-0cL=rmXUbhdROSWsObYrZ7Mp4=+sBkT7Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Jun 2022 15:13:55 -0700
Message-ID: <CAJD7tkY6Jg3+Pb95B0YAvHdgYKvKv_D8Tbc62hX5wzCmWUF6xQ@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 24, 2022 at 3:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Jun 23, 2022 at 10:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Thu, Jun 23, 2022 at 10:04 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 23-06-22 09:42:43, Shakeel Butt wrote:
> > > > On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > > > > > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > > > > [...]
> > > > > > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > > > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > > > > > psi is handled upstream). We want to make sure this behavior also
> > > > > > > > exists in the upstream version so that consolidating them does not
> > > > > > > > break our users who rely on vmpressure and will start seeing increased
> > > > > > > > pressure due to proactive reclaim.
> > > > > > >
> > > > > > > These are good reasons to have this patch in your tree. But why is this
> > > > > > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > > > > > some special casing which will add a maintenance overhead.
> > > > > >
> > > > > > It is not just Google, any existing vmpressure users will start seeing
> > > > > > false pressure notifications with memory.reclaim. The main goal of the
> > > > > > patch is to make sure memory.reclaim does not break pre-existing users
> > > > > > of vmpressure, and doing it in a way that is consistent with psi makes
> > > > > > sense.
> > > > >
> > > > > memory.reclaim is v2 only feature which doesn't have vmpressure
> > > > > interface. So I do not see how pre-existing users of the upstream kernel
> > > > > can see any breakage.
> > > > >
> > > >
> > > > Please note that vmpressure is still being used in v2 by the
> > > > networking layer (see mem_cgroup_under_socket_pressure()) for
> > > > detecting memory pressure.
> > >
> > > I have missed this. It is hidden quite good. I thought that v2 is
> > > completely vmpressure free. I have to admit that the effect of
> > > mem_cgroup_under_socket_pressure is not really clear to me. Not to
> > > mention whether it should or shouldn't be triggered for the user
> > > triggered memory reclaim. So this would really need some explanation.
> >
> > vmpressure was tied into socket pressure by 8e8ae645249b ("mm:
> > memcontrol: hook up vmpressure to socket pressure"). A quick look at
> > the commit log and the code suggests that this is used all over the
> > socket and tcp code to throttles the memory consumption of the
> > networking layer if we are under pressure.
> >
> > However, for proactive reclaim like memory.reclaim, the target is to
> > probe the memcg for cold memory. Reclaiming such memory should not
> > have a visible effect on the workload performance. I don't think that
> > any network throttling side effects are correct here.
>
> IIUC, this change is fixing two mechanisms during userspace-induced
> memory pressure:
> 1. psi accounting, which I think is not controversial and makes sense to me;
> 2. vmpressure signal, which is a "kinda" obsolete interface and might
> be viewed as controversial.
> I would suggest splitting the patch into two, first to fix psi
> accounting and second to fix vmpressure signal. This way the first one
> (probably the bigger of the two) can be reviewed and accepted easily
> while debates continue on the second one.

This change should be NOP for psi. psi was already fixed by
e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
as memory pressure") by Johannes a while ago. This patch does the same
for vmpressure, but in a different way, as the same approach of
e22c6ed90aa9 cannot be used.

The changes you are seeing in this patch for psi are basically
reverting e22c6ed90aa9 and using the newly introduced flag that
handles vmpressure to handle psi as well, to avoid having two separate
ways to address accounting memory pressure during userspace-induced
reclaim.

>
> >
> > >
> > > > Though IMO we should deprecate vmpressure altogether.
> > >
> > > Yes it should be really limited to v1. But as I've said the effect on
> > > mem_cgroup_under_socket_pressure is not really clear to me. It really
> > > seems the v2 support has been introduced deliberately.
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
