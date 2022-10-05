Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C35F5907
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJERVg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 13:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJERVe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 13:21:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C17D1DD
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 10:21:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t4so11186514wmj.5
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pSbHEWZPAlqGXv5FT+k2l6EJrddPS9d76u3iLY1UjMg=;
        b=nVP2RDD+po/mEoQ18TDe3da6XMJYLJ3G/86Z+g1/BnYSydgCF/IHS5V3aRKLcx2zOf
         hLdheL7NOkvibYxUvkWeMSiIoQorEvAvFsWt63HM3oqIt4LA3rE0H5PCoQuT0UgvESMm
         ioMWWD0Pct6I5vhv/ENxTQdKMQHa6ebYj2f5cJcT9fi8WYkN6y4yWxZ5h8qTEAH36yJ4
         46wV6mmCl3CN/1ysRRGXW/rOwntLOlIRHeLcKem8rd5Ht8i0Wwa/HCqI+y411/l7w+BQ
         HVq3sEMXw1rkQPsNM7cGFjapzN8ABJeCJtjnDscNQlb1k1Pz2YENhe27h+LDmvXwgzk3
         Rvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pSbHEWZPAlqGXv5FT+k2l6EJrddPS9d76u3iLY1UjMg=;
        b=Vohao0t7CnOf8Zcn6i+hiKBYW1kR/nMmMOD+p3A5cYdcnpoCQ/WpWLv1tmSjNNDXzS
         yxrQ2+4j9m3KAxaKrMVXYcEo0KboZC91sqYO0owhHR7wgawKouO6cm6c1ViYbegw63F5
         qR01luoV4SgoY+PjMPZ4zEsjoI2fJk6DA9wsCZe4n425aBPr0zIFZU/sPsR2qij1XB+1
         VfI38NnVyJIKp2urTd6FzR6b9+aPS9c3hVsS5hciAl6SqETsgZsKCHxywr+2Ahu7EA8U
         b3B6VCfhrSTGsO3jrmztf/aFSkg2oLYEkkDpQotb5vcG3/pF8VgddYLjIGFD+VJcsUV5
         On6g==
X-Gm-Message-State: ACrzQf3C8umCPxpLiyK1rrbArC0ctKemonvcpfdNVBaqrO1vllfiSC3E
        LMiHKn+fK+CBQvyjqWEDWS9h+znVNLDdXDNPwwmUXQ==
X-Google-Smtp-Source: AMsMyM7d5Q6HXtvYQXOQCWKXNWcOkPLeUbNu4V+CWuArKWw3GbYpNtMngeViG+yii7tyPdtH/pbyFDHozlyFiItUajo=
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id
 l17-20020a1ced11000000b003b4d3e10becmr403307wmh.196.1664990491570; Wed, 05
 Oct 2022 10:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org>
In-Reply-To: <Yz2xDq0jo1WZNblz@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Oct 2022 10:20:54 -0700
Message-ID: <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
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

On Wed, Oct 5, 2022 at 9:30 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Oct 04, 2022 at 06:17:40PM -0700, Yosry Ahmed wrote:
> > We have recently ran into a hard lockup on a machine with hundreds of
> > CPUs and thousands of memcgs during an rstat flush. There have also
> > been some discussions during LPC between myself, Michal Koutn=C3=BD, an=
d
> > Shakeel about memcg rstat flushing optimization. This email is a
> > follow up on that, discussing possible ideas to optimize memcg rstat
> > flushing.
> >
> > Currently, mem_cgroup_flush_stats() is the main interface to flush
> > memcg stats. It has some internal optimizations that can skip a flush
> > if there hasn't been significant updates in general. It always flushes
> > the entire memcg hierarchy, and always invokes flushing using
> > cgroup_rstat_flush_irqsafe(), which has interrupts disabled and does
> > not sleep. As you can imagine, with a sufficiently large number of
> > memcgs and cpus, a call to mem_cgroup_flush_stats() might be slow, or
> > in an extreme case like the one we ran into, cause a hard lockup
> > (despite periodically flushing every 4 seconds).
>
> How long were the stalls? Given that rstats are usually flushed by its

I think 10 seconds while interrupts are disabled is what we need for a
hard lockup, right?

> consumers, flushing taking some time might be acceptable but what's reall=
y
> problematic is that the whole thing is done with irq disabled. We can thi=
nk
> about other optimizations later too but I think the first thing to do is
> making the flush code able to pause and resume. ie. flush in batches and
> re-enable irq / resched between batches. We'd have to pay attention to
> guaranteeing forward progress. It'd be ideal if we can structure iteratio=
n
> in such a way that resuming doesn't end up nodes which got added after it
> started flushing.

IIUC you mean that the caller of cgroup_rstat_flush() can call a
different variant that only flushes a part of the rstat tree then
returns, and the caller makes several calls interleaved by re-enabling
irq, right? Because the flushing code seems to already do this
internally if the non irqsafe version is used.

I think this might be tricky. In this case the path that caused the
lockup was memcg_check_events()->mem_cgroup_threshold()->__mem_cgroup_thres=
hold()->mem_cgroup_usage()->mem_cgroup_flush_stats().
Interrupts are disabled by callers of memcg_check_events(), but the
rstat flush call is made much deeper in the call stack. Whoever is
disabling interrupts doesn't have access to pause/resume flushing.

There are also other code paths that used to use
cgroup_rstat_flush_irqsafe() directly before mem_cgroup_flush_stats()
was introduced like mem_cgroup_wb_stats() [1].

This is why I suggested a selective flushing variant of
cgroup_rstat_flush_irqsafe(), so that flushers that need irq disabled
have the ability to only flush a subset of the stats to avoid long
stalls if possible.

[1] https://lore.kernel.org/lkml/20211001190040.48086-2-shakeelb@google.com=
/

>
> Thanks.
>
> --
> tejun
