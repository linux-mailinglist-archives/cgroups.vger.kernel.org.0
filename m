Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75046F052C
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbjD0LvN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Apr 2023 07:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbjD0Lu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Apr 2023 07:50:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791B9A8;
        Thu, 27 Apr 2023 04:50:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-38de3338abeso4576313b6e.1;
        Thu, 27 Apr 2023 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682596256; x=1685188256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fonqjuy+bDhRZIhhRO5lqR2a/06nt8nM5D2aI3NyvLA=;
        b=IUIXxrOQMkMXZ0RV9QR1E/6+m8OiZGGeuWSwgCohfOhbgOSMHZ+ZU7NSD8jsjw7nkU
         LlY+9F6bg7XSsPNaY74LBnVP/FxNK4leHiteprPDNK6GxhuUNMRR9dubE8+tRaYU33df
         Lh8OJiGn83lWz9pXAt+K2QfVeXfCzwt5EJ1djxMg1Fld+SL7YpKR7yrkyP/gHAuWD7Ca
         K8uUPaov9RO6zaHO23XaM7W3llp38Ko/nJDjqHrdBsp7BPrTH3yi65xPH61pcGEpVwhf
         Mj5pcp0WnxywbTzmV8c+aE3OE/uA/kegWr0h+ZzTPq3aHzpqL2EwXhvEQdDzZE64NwFR
         vjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682596256; x=1685188256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fonqjuy+bDhRZIhhRO5lqR2a/06nt8nM5D2aI3NyvLA=;
        b=OAqe7voEM042nCeFxEIaq41N83AAZpPzncHh9puq3/ovX/xxq6ngPSGg4j65n0Sr1f
         kpCGkaq3iDXpwyYGjVy+43rROPy+9l76J1Kii70xkI7zQX7EDbHL8Ppoza+FpaLqGBJs
         hycmmqdcd66rfq3Bhg/0TMpY4HpuxxtUYYRWBy/6UUYTLAAsyElzt6dLw6mnEaF8ih4q
         pe+B5MtAgaZPlZGCKVludu+mOymskuy4/ajdplWQ+MJT6SYQM57h525WtJYmM/tu+c1C
         Q4rxj7QG2GscFt7w4V2GegLBlNXKk1ae99G0dT3bMPSCK2FuBNrZTASS18ARU8ycUmkP
         dvCg==
X-Gm-Message-State: AC+VfDzKIopZKqY4nuAsgTBghKN94xncATjHazHZzSCIdTKwZ/SsYx4W
        rEj0MVLbSGjpZMVgg//LQx80OE+z+AoG2gfniHU=
X-Google-Smtp-Source: ACHHUZ6NsrwKumzPbGDsALIY9iyUkB6qBveDS1bCmxjFm4Y626Wya8HKUV5q8QtwdbhTaBu/FWSt0YZ2AlgjnDhRCQk=
X-Received: by 2002:a05:6808:152:b0:38c:c177:a6bb with SMTP id
 h18-20020a056808015200b0038cc177a6bbmr447023oie.23.1682596255672; Thu, 27 Apr
 2023 04:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com> <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain> <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
 <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com> <ZEoN1wq47uhE201p@localhost.localdomain>
In-Reply-To: <ZEoN1wq47uhE201p@localhost.localdomain>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 27 Apr 2023 19:50:44 +0800
Message-ID: <CAB8ipk9rFjgkyXu50a5CSkfNMuRi7GU_Tq8j++kxNLoy3pminA@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        zhiguo.niu@uniissoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 27, 2023 at 1:53=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hi,
>
> On 27/04/23 10:58, Xuewen Yan wrote:
> > HI Juri,
> >
> > Would this patch be merged tobe stable-rc? In kernel5.15, we also find
> > that the rwsem would be blocked for a long  time, when we change the
> > task's cpuset cgroup.
> > And when we revert to the mutex, the delay would disappear.
>
> Honestly, I'm not sure. This change is mostly improving performance, but
> it is also true that it's fixing some priority inheritance corner cases.
> So, I'm not sure it qualifies for stable, but it would be probably good t=
o
> have it there.
>
Dear Juri,

Thanks for the reply! We will test more in kernel5.15.

Thanks!
BR

> Thanks,
> Juri
>
