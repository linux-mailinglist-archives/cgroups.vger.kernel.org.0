Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3442369E562
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjBURBQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjBURBN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:01:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017E199D9;
        Tue, 21 Feb 2023 09:00:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u10so5705532pjc.5;
        Tue, 21 Feb 2023 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676998853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bzbHZtMVTbCokAydXsy5m0utnYmreRbdGfN2F9U7y6M=;
        b=QzL49iKVV0NXrLXOI5t613DcnDYuBlQessXmxJP1FHor/KKL06T6K+7pamcGPiPvdk
         jTOq5b6Skaz5NR4hmdR8cAIK4lxfvrD+PpynxhvhWugv9jZ6gjQdDSNqUe4r40WbI1CR
         gybjHq52mP/3r122fbF+exWScCx3lGh1pJplnRnsQ/2ySBZ50qRGQlB2eIo4hYB/Loui
         vLRm653Vww0sbcX56Xvt/KmMhWWD6GwyAJoOvmB/mYV5NtTecohDHu7okcPKyBtKrWv+
         4CaUnNZNvl/3t8wb+xqXiUmfVVv39CFp7YcCq02AQghG9WCkViwrI+WuYQyYDMRbA/Lv
         k5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676998853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzbHZtMVTbCokAydXsy5m0utnYmreRbdGfN2F9U7y6M=;
        b=P4lphgfZWDAOYDal2Eb65BDDodZEncpaMLU/88s4pFakcjSIs3OZUxB/cdm07KV+Xo
         tOcIz1fZBlhOnjbYrC4IjxMosMSR/kdoYr4QPPUkHOqyUkvZOZKON74mHeVljnv31VRe
         REr5Rt58DEPZY3Ipjd1NbZiE976iAhqTXy/PXkCv9XI6J4JBN9UXTVj1F7fgnM8Ja3vG
         WdLhmFw8sAiVNj94wbaa9qkCzQuq1+ljInOKrnoiueogvkYRB+Es+VDKjlkOdX8Cbk7P
         wOkjjFgwO5EQTjqp01jhRRA9DOe53mV0rVzEpjAcmle5CGEhTdVzsF9DLzIKkNq9wszE
         o7wA==
X-Gm-Message-State: AO0yUKWzuy2EHfJz4tmBVgjqj6KgYzjvjcWxo7nDMEtSTT/8I5hUn3+4
        KLXHp8MjHUsL7lACUcAd+C/JmyWM5cCl+wuaoQ0=
X-Google-Smtp-Source: AK7set9KcVfJUmaN3Uny4EJdzFdT2c5C6toIxjeOV5D15HKMFi5KMpUSjvZCUKbFvkRNHRjGR3sTQf2RaJxdDjTOQNk=
X-Received: by 2002:a17:903:25c2:b0:19c:9999:e8f1 with SMTP id
 jc2-20020a17090325c200b0019c9999e8f1mr299850plb.12.1676998852828; Tue, 21 Feb
 2023 09:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20230220151638.1371-1-findns94@gmail.com> <Y/PhmEPc/qYeZ52T@P9FQF9L96D>
 <20230220230624.lkobqeagycx7bi7p@google.com> <Y/SAHfHsljuIRBJm@dhcp22.suse.cz>
In-Reply-To: <Y/SAHfHsljuIRBJm@dhcp22.suse.cz>
From:   Martin Zhao <findns94@gmail.com>
Date:   Wed, 22 Feb 2023 01:00:00 +0800
Message-ID: <CADfL_jBSMyi_19qHHuai910L0eu+gq7aV9YEDV5fqB8XfBZ7HA@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 4:26 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 20-02-23 23:06:24, Shakeel Butt wrote:
> > On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> > > On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > > The knob for cgroup v2 memory controller: memory.oom.group
> > > > will be read and written simultaneously by user space
> > > > programs, thus we'd better change memcg->oom_group access
> > > > with atomic operations to avoid concurrency problems.
> > > >
> > > > Signed-off-by: Yue Zhao <findns94@gmail.com>
> > >
> > > Hi Yue!
> > >
> > > I'm curious, have any seen any real issues which your patch is solving?
> > > Can you, please, provide a bit more details.
> > >
> >
> > IMHO such details are not needed. oom_group is being accessed
> > concurrently and one of them can be a write access. At least
> > READ_ONCE/WRITE_ONCE is needed here. Most probably syzbot didn't
> > catch this race because it does not know about the memory.oom.group
> > interface.
>
> I do agree with Roman here. It is _always_ good to mention whether this
> is a tool/review or actual bug triggered fix. Also {READ,WRITE}_ONCE doesn't
> guarantee atomicity so it would be good to rephrase the changelog.
> Something like:
> The knob for cgroup v2 memory controller: memory.oom.group
> is not protected by any locking so it can be modified while it is used.
> This is not an actual problem because races are unlikely (the knob is
> usually configured long before any workloads hits actual memcg oom)
> but it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
> doing anything funky.

Thanks a lot, I will rephrase and update my patch later.

>
> This patch is not fixing any actual user visible bug but it is in line
> of a standard practice.
> --
> Michal Hocko
> SUSE Labs
