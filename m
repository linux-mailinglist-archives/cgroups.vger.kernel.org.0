Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFD75FA92F
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 02:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJKAQO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 20:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJKAQM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 20:16:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFE35C95D
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 17:16:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu30so19157987wrb.8
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 17:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5b3uWEYh8D1bGFVBUtx/YHS7tr5OOv/UiC1a+kLQhA=;
        b=D+BVHNWtd51crdcezYUpYST5y49fBdPovHWh29578VE8YlXqAHn4H7iCM8O9FJb6cn
         bq0C2o1Yr1X2CJnuzn7wkqdcCO1cLQQUeYOAP4JlaCkkzuBsx/yCDifdN2himGrBo28F
         DZgaJ0Ddey7ejOeWTf05dM9xe3Gdo357UUmkeVaT0X+vy2rkXhXFV75Irvm6xlEWUpb1
         tFbcKOTKzZrxO/6MRNLSnro+I2/7GJw5Y+wyF+1RLHRTjVUeugjUGANyaot1CpN7Ml/I
         4Teg6/eg1jmbM1yn+UCp/Ko81+NAwD1hKvxyFOzCqUTNAh5PIYj0Us/MxMyZcAjEsULg
         ggZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5b3uWEYh8D1bGFVBUtx/YHS7tr5OOv/UiC1a+kLQhA=;
        b=Tud6syhYs7iD0DR3a4c4m6yMB1go6a6h82gXAIrdNOuI/tDVdb9l8KZ7LetZWpFHZr
         StYFpj5KnIlnwsQcl7UHHAUvI4jLt2OktPOud+LkgmYc5bqTe2YdUxHJQsCRt7A+J0pT
         +lkmNcE1Y5X83jN4gQuRrDMPExZBh0nUGfCVbRvQrj2G+khnHfrPBq3ALDpWoytAOqOQ
         nCF6e0Pl2pHMpD2Qo6F/QMgtRfR8iX4VvltQjMXJgQCn3/gAfbzfCud/FBj8/JdPbzfE
         uuWuM1dMWHNs7g346u2Qz2NoQ2rD+fWa6SL3+wyZMc3Hj9ySNJvzuaSFGAoXFfsg+ECm
         h5KA==
X-Gm-Message-State: ACrzQf3RSlCVUL+f1S8iWGwn26puruerylbeTEVBrObOGOibJ/eOKNFx
        wMmWnhjwleGL0+iHWZfZ74CspJ8dSAy9vIhJCgRIFg==
X-Google-Smtp-Source: AMsMyM5PAmYKT2DOGjYcVqpqnfDwoCVR9NwE3AadA6Y4g24b1KBcmyhwO8kJYui97n97HDwxWYTnblw5KMtki2OUUu8=
X-Received: by 2002:a5d:4909:0:b0:22e:7bbf:c8d with SMTP id
 x9-20020a5d4909000000b0022e7bbf0c8dmr12198466wrq.80.1665447369460; Mon, 10
 Oct 2022 17:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org> <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
 <Yz3CH7caP7H/C3gL@slm.duckdns.org> <CAJD7tkY8gNNaPneAVFDYcWN9irUvE4ZFW=Hv=5898cWFG1p7rg@mail.gmail.com>
 <Yz3LYoxhvGW/b9yz@slm.duckdns.org> <CAJD7tkZOw9hrc0jKYqYW1ysGZNjSVDgjhCyownBRmpS+UUCP3A@mail.gmail.com>
In-Reply-To: <CAJD7tkZOw9hrc0jKYqYW1ysGZNjSVDgjhCyownBRmpS+UUCP3A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 10 Oct 2022 17:15:33 -0700
Message-ID: <CAJD7tkZZuDwGHDjAsOde0VjDm9YcKWnWUGHg43q79hcffZH5Xw@mail.gmail.com>
Subject: Re: [RFC] memcg rstat flushing optimization
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
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

On Wed, Oct 5, 2022 at 11:38 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 11:22 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Wed, Oct 05, 2022 at 11:02:23AM -0700, Yosry Ahmed wrote:
> > > > I was thinking more that being done inside the flush function.
> > >
> > > I think the flush function already does that in some sense if
> > > might_sleep is true, right? The problem here is that we are using
> >
> > Oh I forgot about that. Right.
> >
> > ...
> > > I took a couple of crashed machines kdumps and ran a script to
> > > traverse updated memcgs and check how many cpus have updates and how
> > > many updates are there on each cpu. I found that on average only a
> > > couple of stats are updated per-cpu per-cgroup, and less than 25% of
> > > cpus (but this is on a large machine, I expect the number to go higher
> > > on smaller machines). Which is why I suggested a bitmask. I understand
> > > though that this depends on whatever workloads were running on those
> > > machines, and that in case where most stats are updated the bitmask
> > > will actually make things slightly worse.
> >
> > One worry I have about selective flushing is that it's only gonna improve
> > things by some multiples while we can reasonably increase the problem size
> > by orders of magnitude.
>
> I think we would usually want to flush a few stats (< 5?) in irqsafe
> contexts out of over 100, so I would say the improvement would be
> good, but yeah, the problem size can reasonably increase more than
> that. It also depends on which stats we selectively flush. If they are
> not in the same cache line we might end up bringing in a lot of stats
> anyway into the cpu cache.
>
> >
> > The only real ways out I can think of are:
> >
> > * Implement a periodic flusher which keeps the stats needed in irqsafe path
> >   acceptably uptodate to avoid flushing with irq disabled. We can make this
> >   adaptive too - no reason to do all this if the number to flush isn't huge.
>
> We do have a periodic flusher today for memcg stats (see
> flush_memcg_stats_dwork). It calls __mem_cgroup_flush_stas() which
> only flushes if the total number of updates is over a certain
> threshold.
> mem_cgroup_flush_stas_delayed(), which is called in the page fault
> path, only does a flush if the last flush was a certain while ago. We
> don't use the delayed version in all irqsafe contexts though, and I am
> not the right person to tell if we can.
>
> But I think this is not what you meant. I think you meant only
> flushing the specific stats needed in irqsafe contexts more frequently
> and not invoking a flush at all in irqsafe contexts (or using
> mem_cgroup_flush_stas_delayed()..?). Right?
>
> I am not the right person to judge what is acceptably up-to-date to be
> honest, so I would wait for other memcgs folks to chime in on this.
>
> >
> > * Shift some work to the updaters. e.g. in many cases, propagating per-cpu
> >   updates a couple levels up from update path will significantly reduce the
> >   fanouts and thus the number of entries which need to be flushed later. It
> >   does add on-going overhead, so it prolly should adaptive or configurable,
> >   hopefully the former.
>
> If we are adding overhead to the updaters, would it be better to
> maintain a bitmask of updated stats, or do you think it would be more
> effective to propagate updates a couple of levels up? I think to
> propagate updates up in updaters context we would need percpu versions
> of the "pending" stats, which would also add memory consumption.
>

Any thoughts here, Tejun or anyone?

> >
> > Thanks.
> >
> > --
> > tejun
