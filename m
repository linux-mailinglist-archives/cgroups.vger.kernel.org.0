Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0605F5EA2
	for <lists+cgroups@lfdr.de>; Thu,  6 Oct 2022 04:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJFCOE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 22:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJFCOD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 22:14:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F352CCBC
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 19:14:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8so200110wmi.2
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QDIgC+mJ41actrgXCTNkcAZRdvkb92D80nFmN32xkMY=;
        b=MolortEC0wzeHJawsNOKpE3qaPOkxU08GmWWLNDWfHyDm/aTELESlGfZS8NQo3fCTG
         xSuHidQxKGXplB8XaC30T/WpsDmhzrLmXue95N90MbK4cRg9aecENdsRXMvqHHNFpJwY
         HmJ9H6+h5DU12Flt4zv/z23P7v3zHTbfuX+rl1pXKcu12gw1F1lBg0VGO+PyfHx7F3ep
         Xicq/Wc1j/VUprPgWjNwoHtiDns9LiDWt9oGoPCxkOB6YSkog7CMNsnILnDXaq58O9i2
         fvqz3twfcYSdCZ5XF9XCsMi7piGAU0XcEdSlWCiRjiwgUa2XqwYkRodkA2uDAhj9Ur5G
         jwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QDIgC+mJ41actrgXCTNkcAZRdvkb92D80nFmN32xkMY=;
        b=eJc4v1OdHasOI63qvtF8r+N1nKzYaUK9Mb/OoUhR013fW9bhUoX0C0WfT7bTCwv9Zz
         8ODd+QoyAIdTQ/Isqu7vaeAoTpq1VFNPqUupsktpSglXwUYfWCXLPBMtzlptTjUsp6pl
         ObHfRVXIaDzs/0rZ4+NtUU6+KzOpoPhtQ82I7ZRD6Ft0goe2C4hDjXuRb2Qps3bYw/85
         rfhHLkbLbzcuTUPzl85zOmLOMlgZVS9TZ2iimbQy82NALZi/+3JFm75OXxMgPEW83WYg
         HB/yr29X4zfQrtWgVLhmY9rqpS310Bh3K/51mCEEBRQ8ZqZVC7nixfAnNtX108AhzkEl
         /pFQ==
X-Gm-Message-State: ACrzQf0xdWsLeft6iGh7AQALyoOo/jiDEQZoeVy3YvP2ivKYZO5OkDCy
        4FGauU4J6GcAl5IpHBADtlyXcVsEYndoZiAeotQRbw==
X-Google-Smtp-Source: AMsMyM7g2v817+WfXcJ3VUZSGaeCsYGQ50Zr/LsYqL5aSmzkd8byLt3oZ9TuDdmNBJucGLzQuECecZYCn/DEd4+GOSg=
X-Received: by 2002:a7b:c4c1:0:b0:3bf:e351:4ba with SMTP id
 g1-20020a7bc4c1000000b003bfe35104bamr2939233wmk.152.1665022440837; Wed, 05
 Oct 2022 19:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org> <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
 <Yz3CH7caP7H/C3gL@slm.duckdns.org> <CAJD7tkY8gNNaPneAVFDYcWN9irUvE4ZFW=Hv=5898cWFG1p7rg@mail.gmail.com>
 <Yz3LYoxhvGW/b9yz@slm.duckdns.org> <CAJD7tkZOw9hrc0jKYqYW1ysGZNjSVDgjhCyownBRmpS+UUCP3A@mail.gmail.com>
In-Reply-To: <CAJD7tkZOw9hrc0jKYqYW1ysGZNjSVDgjhCyownBRmpS+UUCP3A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Oct 2022 19:13:24 -0700
Message-ID: <CAJD7tkaovbFoys0vC4xkLdzcAEPpofBkg0OPFWi0wex49EMa8g@mail.gmail.com>
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

A potential problem that I also noticed with propagating percpu
updates up on the update path is that we will need to update
memcg->vmstats_percpu->[state/event/..]_prev. Currently these percpu
prev variables are only updated by rstat flushing code. If they can
also be updated on the update path then we might need some locking
primitive to protect them, which would add more overhead.

> >
> > Thanks.
> >
> > --
> > tejun
