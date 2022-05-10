Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60763520ACC
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 03:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiEJBrs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 21:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiEJBrr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 21:47:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93E286FE7;
        Mon,  9 May 2022 18:43:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q76so13426927pgq.10;
        Mon, 09 May 2022 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=HgGTA2L0WTR4KLBkAGFUu4sFQBHJ/DJdCql0JMw+UdA=;
        b=PQtM78l2Szcsfpy4oz0zTJGNYjLHXrbEDGhoEKp+SP/Pa1siwRO+rDz3t0BFl3resm
         dd8tcXGT5i6a82bz80DTxIKuLb3u8lAwq8yUsRIx0GhudcTqTvxtzIEeBaOjbjpCitNq
         q+VyfCneFhYGz4mP2xJ3gYDnKji0GVSkfrT2Oee3fXek4xuIo880FhrxH+lMXsrr5xwx
         Nq1pIdHfa41nMi5miCZmzs4D/xeLesHo5FfIvycHlMyBPbIUJeXhmdjr3j9zvs+wYUH5
         o6+K3hpdHvKaBvRM4E/gsKQoEwDwy4zBLdaqaK3c6sqnny9rfkbdfe6hT5+LSAR8EzcN
         /8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=HgGTA2L0WTR4KLBkAGFUu4sFQBHJ/DJdCql0JMw+UdA=;
        b=j/14owxfGtVHrryeVuZ/DjVSDtKKlajnXYzVrsq+v+BX55QkhlH+SAk/PBoSBmzyb6
         GTu3Q66fHohy4NXxWNnFUTV+4ZSsZDqs2Y+kjcgzn3wx7PfpH+jF/g56aYRuibvbxdZr
         oEJPfOoLBnixg+Z4EQ25WTkjb5339cvaM7iy9FoTz6/T+BgiJws+LKnfPwxpjw9uTtse
         vFqg2hNg3m7MO5ltB24JaTTFmqhul9YuMUf9OweGnkqO/FVCVbLwLI+h5CGDTE90e1IP
         QadT/L4EvBiGu40o/VXY4L7BEbBBNNLvFgyTEqdadmkh5eXPSH4hro5DT93BFuBrLNKx
         iJ7A==
X-Gm-Message-State: AOAM533SWdIf5kPGzWeI51TiwF/9aDxagQKmE+bgiC6dxdiuVmsiMXpH
        vrs9J+h3GMJvHGKFEm6bEM4=
X-Google-Smtp-Source: ABdhPJy2FOePOQ00ab2y0snBDHiAx1OOUXyfOevwooeooZCPtaDvJEiNPq0H1xGkxOIzZYF9ARPTVw==
X-Received: by 2002:a65:6e41:0:b0:39c:c97b:2aef with SMTP id be1-20020a656e41000000b0039cc97b2aefmr15690480pgb.473.1652147030614;
        Mon, 09 May 2022 18:43:50 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090a7d0100b001d93118827asm380903pjl.57.2022.05.09.18.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 18:43:48 -0700 (PDT)
Message-ID: <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
X-Google-Original-Message-ID: <20220510014338.GA1267733@cgel.zte@gmail.com>
Date:   Tue, 10 May 2022 01:43:38 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> On Mon 09-05-22 11:26:43, CGEL wrote:
> > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > [...]
> > > > If there are many containers to run on one host, and some of them have high
> > > > performance requirements, administrator could turn on thp for them:
> > > > # docker run -it --thp-enabled=always
> > > > Then all the processes in those containers will always use thp.
> > > > While other containers turn off thp by:
> > > > # docker run -it --thp-enabled=never
> > > 
> > > I do not know. The THP config space is already too confusing and complex
> > > and this just adds on top. E.g. is the behavior of the knob
> > > hierarchical? What is the policy if parent memcg says madivise while
> > > child says always? How does the per-application configuration aligns
> > > with all that (e.g. memcg policy madivise but application says never via
> > > prctl while still uses some madvised - e.g. via library).
> > >
> > 
> > The cgroup THP behavior is align to host and totally independent just likes
> > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > for thp, it has no matter with host or other cgroup. This make it simple for
> > user to understand or control.
> 
> All controls in cgroup v2 should be hierarchical. This is really
> required for a proper delegation semantic.
>

Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
Some distributions like Ubuntu is still using cgroup v1.

> > If memcg policy madivise but application says never, just like host, the result
> > is no THP for that application.
> > 
> > > > By doing this we could promote important containers's performance with less
> > > > footprint of thp.
> > > 
> > > Do we really want to provide something like THP based QoS? To me it
> > > sounds like a bad idea and if the justification is "it might be useful"
> > > then I would say no. So you really need to come with a very good usecase
> > > to promote this further.
> > 
> > At least on some 5G(communication technology) machine, it's useful to provide
> > THP based QoS. Those 5G machine use micro-service software architecture, in
> > other words one service application runs in one container.
> 
> I am not really sure I understand. If this is one application per
> container (cgroup) then why do you really need per-group setting?
> Does the application is a set of different processes which are only very
> loosely tight?
> 
For micro-service architecture, the application in one container is not a
set of loosely tight processes, it's aim at provide one certain service,
so different containers means different service, and different service
has different QoS demand. 

The reason why we need per-group(per-container) setting is because most
container are managed by compose software, the compose software provide
UI to decide how to run a container(likes setting swappiness value). For
example the docker compose:
https://docs.docker.com/compose/#compose-v2-and-the-new-docker-compose-command

To make it clearer, I try to make a summary for why container needs this patch:
    1.one machine can run different containers;
    2.for some scenario, container runs only one service inside(can be only one
application);
    3.different containers provide different services, different services have
different QoS demands;
    4.THP has big influence on QoS. It's fast for memory access, but eat more
memory;
    5.containers usually managed by compose software, which treats container as
base management unit;
    6.this patch provide cgroup THP controller, which can be a method to adjust
container memory QoS.

> > Container becomes
> > the suitable management unit but not the whole host. And some performance
> > sensitive containers desiderate THP to provide low latency communication.
> > But if we use THP with 'always', it will consume more memory(on our machine
> > that is about 10% of total memory). And unnecessary huge pages will increase
> > memory pressure, add latency for minor pages faults, and add overhead when
> > splitting huge pages or coalescing normal sized pages into huge pages.
> 
> It is still not really clear to me how do you achieve that the whole
> workload in the said container has the same THP requirements.
> -- 
> Michal Hocko
> SUSE Labs
