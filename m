Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65559F65F
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 11:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiHXJfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 05:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiHXJfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 05:35:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6CB43338;
        Wed, 24 Aug 2022 02:35:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u24so10293316lji.0;
        Wed, 24 Aug 2022 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GCl8dHqPSzKvC1qvvjcvE0b120LUuRhLO2pWkva8f+U=;
        b=GstEXS+VfViwMMFI9HBPPaVshMA7v+fU6E0LQ2UW84b7h0tAoknsXgpbrvStzEf8p6
         aHTgEit/8mjbIJRRSRjqQkyTybpZ9qjHpci+7CAA2JFANBa9HpMekvB3o+4Ebcl5nwIM
         nF2pdYIK6LxUdCW+Q8djZYUjpkrYCkZbafYjdD9U2N8TBmEG/r+Gr+UEW27jzJyRozif
         +rAcIQSy5Uw8kJlnIuswEMcxNWjKkl9gGBnw+Aan0zqqY/1MYB0YYJBOdWAN5hisBrDF
         NXOsjql7wKVQ+X5UqkHjyRsg2FwE1r2BPa6GXfl8ePOee01L0QVZfoqfNqLxCG8KsoXg
         qn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GCl8dHqPSzKvC1qvvjcvE0b120LUuRhLO2pWkva8f+U=;
        b=mJ+P/gDjiy7m9BSTMCg1eA91RadmkKFzhuOeofvO1qxTiwmvegxWCsgmweSOvLkzpa
         4npxe1BhzTmDta0mIcAzjwOPsqfj5fCuTnitsYyImcwwQBcbyXRa1fJd0AdDMV4Esavv
         mfv0TR1XmU/OctDT4FQhse1JBwFq666PlxmPR+Wj2Zy2bK6kyWnjH5Wa9zxTbJL3DOvz
         d2Jdz8tN6qK3ApRHqfcSXpzX/A7Z7ceL6AKyC0AM3lOX06eO1mbubZjIdj1MAoL3OLxz
         jg+hlnL7fGyrXRariT++P1JdZaabamtWWQuOtRcB37FsuiqjtrxgDknAlZgzyPsiO/dI
         qdXA==
X-Gm-Message-State: ACgBeo3iET1x0ZnVO/6MRHR4B5aWLbaany3ASSwvwZ2xZNIaK4mdGY8+
        MQVv/bxj6JR4J6NlvLOrurgISUx4kaRHvyoRrq8=
X-Google-Smtp-Source: AA6agR4kNB8iDWAsESnEdzdfkRFZhXH8xbseiOV/TuKM2jj0O2Om/84Aa7+cv8ErMcnwUyyopAL+Tb1683zvVamx0HQ=
X-Received: by 2002:a2e:a80b:0:b0:261:c107:8823 with SMTP id
 l11-20020a2ea80b000000b00261c1078823mr6263213ljq.323.1661333710483; Wed, 24
 Aug 2022 02:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7QdLSMdBoD2WztL72qS8kJe7F79JuCH6t19rRcw6Pn1w@mail.gmail.com>
 <Yv/EArPDTcCrGqJh@slm.duckdns.org> <YwNpI1ydy0yDnBH0@dhcp22.suse.cz>
 <CAGWkznEB+R0YBaBFBL7dPqs8R=qKC6+ixTWEGCYy2PaczXkaPA@mail.gmail.com>
 <YwRjyx6wFLk8WTDe@dhcp22.suse.cz> <CAGWkznGaYTv4u4kOo-rupfyWzDNJXNKTchwP6dbUK-=UXWm47w@mail.gmail.com>
 <YwSQ4APOu/H7lYGL@dhcp22.suse.cz> <CAGWkznGd6mgareABseMKY5p0f1=5dkfVkj=NS7_B6OkXBYSwyw@mail.gmail.com>
 <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz> <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
In-Reply-To: <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 24 Aug 2022 17:34:42 +0800
Message-ID: <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 24, 2022 at 3:50 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 24-08-22 10:23:14, Zhaoyang Huang wrote:
> > On Tue, Aug 23, 2022 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > One way to achieve that would be shaping the hierarchy the following way
> > >             root
> > >         /         \
> > > no_memcg[1]      memcg[2]
> > > ||||||||         |||||
> > > app_cgroups     app_cgroups
> > >
> > > with
> > > no_memcg.subtree_control = ""
> > > memcg.subtree_control = memory
> > >
> > > no?
> > According to my understanding, No as there will be no no_memcg. All
> > children groups under root would have its cgroup.controllers = memory
> > as long as root has memory enabled.
>
> Correct
>
> > Under this circumstance, all
> > descendants group under 'no_memcg' will charge memory to its parent
> > group.
>
> Correct. And why is that a problem? I thought you main concern was a per
> application LRUs. With the above configuration all app_cgroups which do
> not require an explicit memory control will share the same (no_memcg)
> LRU and they will be aged together.
I can't agree since this indicates the processes want memory free
depending on a specific hierarchy which could have been determined by
other subsys. IMHO, charging the pages which out of explicitly memory
enabled group to root could solve all of the above constraints with no
harm.
> --
> Michal Hocko
> SUSE Labs
