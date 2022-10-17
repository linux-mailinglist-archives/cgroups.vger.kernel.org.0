Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88A8601B4E
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 23:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJQVb0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 17:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJQVbS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 17:31:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DF7B294
        for <cgroups@vger.kernel.org>; Mon, 17 Oct 2022 14:31:17 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n73so10223765iod.13
        for <cgroups@vger.kernel.org>; Mon, 17 Oct 2022 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc3li/tzR/oCCHp/uAgdn1p2dDfcQKGULLcU+GBdb+c=;
        b=RAhZtWKR/m4APOcLNaQu/IyieOIGeudNyluby/pCrVi2sFz2u1A0FSefKBAtiPDBf8
         seUBQVFcmsN0KKROH6v2fX9rYKR9yV3RxQEUg5HZJmPE4otB/k/wdZ3cXQnqp4gI2cfX
         +BsbrZ/E+jyA19LGwo0Xfj/sPwij+yDUr5znU9FgwCBQuY3ECDYxZIXkooVOZstOU5DW
         8kEpIXyAYuDCwvYA3IqHwv88jmBPBdiiuinwjffl8ccf0BCAMvS0uxjEmpOz576Fgi4u
         VQFx9bUPD3QtIf2eqt48BCliwgEEmZuBd7vQ9EcuUw28y1AQ5QNHJKrLI+9GcbuH4aKz
         KJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc3li/tzR/oCCHp/uAgdn1p2dDfcQKGULLcU+GBdb+c=;
        b=f6CnFNVo8NtS1IKtRdHVcI5OFhW7vCdHzqFlyD8HNNcersDd5EKPPuKgJZNiuyhn4m
         fEiUNZkV+6rOyKkNGElsSN1n9rmQLawflKw/WAjj5iiG7ApRAx0/xcwreTZSLJg1PhBw
         6fz6Fnr8L/IDr1CrLuC4kPAs3WbqG+LA73CjXYVr7uza7ghuxcvSFQCq861xwX7RbHq/
         T3u5qCPousKj+4MEKrWh2Pt/+pZpekkILRgII3sMwj4vUd4qEpSEJAHi9aOM9MfM+js8
         npwHCSanN79TNjgC5nqIUJKj0a9ZRfJLnDmPTVooCeJ/yGWBD65EMH6Dd4sR97TcDpcy
         Vysg==
X-Gm-Message-State: ACrzQf3U4VX4dySXh1JGJOaCDn02CyVJjJwmp2XRQD4WE1eyiOAjmJja
        DnVzKbtAuKcWZ2T8Tg2/pSZjKOe/OMxT+R24ecPoeQ==
X-Google-Smtp-Source: AMsMyM4aKKAWsgREP04N0/OdfQ9Pbgp/J6t+WdZ4ViGaN//UH/MMywdFAMTg/PJ/x7SLE2VVL46RT9dMSVX0Qp0eM1w=
X-Received: by 2002:a05:6638:480c:b0:363:aed5:ed3c with SMTP id
 cp12-20020a056638480c00b00363aed5ed3cmr6464575jab.207.1666042277152; Mon, 17
 Oct 2022 14:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <20221017185238.GA7699@blackbody.suse.cz>
In-Reply-To: <20221017185238.GA7699@blackbody.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Oct 2022 14:30:41 -0700
Message-ID: <CAJD7tkYkX7hetynuTYbpV50e1+dKgqWuGJ8d_VFSJPoF=k61NA@mail.gmail.com>
Subject: Re: [RFC] memcg rstat flushing optimization
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 17, 2022 at 11:52 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hello.
>
> On Tue, Oct 04, 2022 at 06:17:40PM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > Sorry for the long email :)
>
> (I'll get to other parts sometime in the future. Sorry for my latency :)
>
> > We have recently ran into a hard lockup on a machine with hundreds of
> > CPUs and thousands of memcgs during an rstat flush.
> > [...]
>
> I only respond with some remarks to this particular case.
>
>
> > As you can imagine, with a sufficiently large number of
> > memcgs and cpus, a call to mem_cgroup_flush_stats() might be slow, or
> > in an extreme case like the one we ran into, cause a hard lockup
> > (despite periodically flushing every 4 seconds).
>
> Is this your modification from the upstream value of FLUSH_TIME (that's
> every 2 s)?

It's actually once every 4s like upstream, I got confused by
flush_next_time multiplying the flush interval by 2.

>
> In the mailthread, you also mention >10s for hard-lockups. That sounds
> scary (even with the once per 4 seconds) since with large enough update
> tree (and update activity) periodic flush couldn't keep up.
> Also, it seems to be kind of bad feedback, the longer a (periodic) flush
> takes, the lower is the frequency of them and the more updates may
> accumulate. I.e. one spike in update activity can get the system into
> a spiral of long flushes that won't recover once the activity doesn't
> drop much more.

Yeah it is scary and shouldn't be likely to happen, but it did :(

We can keep coming up with mitigations to try and make it less likely,
but I was hoping we can find something more fundamental like keeping
track of what we really need to flush or avoiding all flushing in
non-sleepable contexts if possible.

>
> (2nd point should have been about some memcg_check_events() optimization
> or THRESHOLDS_EVENTS_TARGET justifying delayed flush but I've found none =
to be applicable.
> Just noting that v2 fortunetly doesn't have the threshold
> notifications.)

I think even without that, we can still run into the same problem in
other non-sleepable flushing contexts.

>
> Regards,
> Michal
