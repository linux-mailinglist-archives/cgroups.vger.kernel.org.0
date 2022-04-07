Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0F4F7F30
	for <lists+cgroups@lfdr.de>; Thu,  7 Apr 2022 14:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiDGMjE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Apr 2022 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243989AbiDGMjD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Apr 2022 08:39:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB31FDFEE;
        Thu,  7 Apr 2022 05:37:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v13so2003162qkv.3;
        Thu, 07 Apr 2022 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqCQYphQwwg0rtGAZWw99jUbVGx79hxU7jjCsADQw+A=;
        b=aGbfgoA3tkur8brwef7kNg7t1ICec7XOSo1+xO3axQPqmqJMR4SwQDy9Ro8HMErUIw
         EZbH6DzmcCOFb8F3X/ooGfjNIjvTEoV9Idv/rym45HJvHuXWDJ/27yYnbmkNdo5fY0up
         kwxWkmaTAm8lkFyiITVQGl9aqg4Bwbj7QmsIgihMOWOZ5IP3Uv/Wv1ymFGr7htmaDWOr
         jv4VkZwKyY7weM1wt9Mr1kO6azVn1GBfjJP1v2eHObkxUWfZNieBrrMDvsgoUivaw+8A
         OIn/XsaBiCgWfNmJwrdi76Rm5irA1oZ87NVq3rl205OAtMdKAzj7Vp+1u5jmzo8Wp5rp
         SyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqCQYphQwwg0rtGAZWw99jUbVGx79hxU7jjCsADQw+A=;
        b=pZs3cPstU4kJeolD2fzLS1rBcmCsQmxGOep6IS90N94x8Pb4wzvNCntTUGVh55GaMi
         ymzIoX+I0AjySh42anryN/37TzzmT+zCjZWGsIYeWM7FH+8MYbSYnEbLjqsSWi32KC6N
         Wg/Xt7hD0bIxJ5h1YMIWsBa/jrntr2nxy2Cuy13x1zXLhjM85M5bLCSnVlZaDkaMswG6
         jFTFysJ7eiy+5ebDmEoI8JszwI3T/ErCZVexqhCcr444Ou8Ysjf9C76QD2/xkKo1oCt9
         aJMbj8ibsf2e6ujAc1nVi+I9Zc2DrTyrHMTjoHhvtw703LEMINKTu8vEhehsTbD3xCb5
         RcOg==
X-Gm-Message-State: AOAM5311tRDyGjse0Q/uBS3Ahfyfh2DPuD754lMypCVh7mPgrU2WKjwG
        mCU9EJJq0C+Yj/+ez42rZMgsHFj4QTMAJrp3BQ4=
X-Google-Smtp-Source: ABdhPJw0qd8D9C6tmj7Cp/PFc7wTcv1WiDGzwESl9F2XASgK1yJsL++x37ZL/w7P0FMjkK/xV8hIwvH2jEqpCKtUykE=
X-Received: by 2002:a37:9b91:0:b0:69a:48d:54f2 with SMTP id
 d139-20020a379b91000000b0069a048d54f2mr1352402qke.476.1649335022765; Thu, 07
 Apr 2022 05:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz> <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
 <Ykrkx4JML4c81gBV@dhcp22.suse.cz> <CAGWkznEaEavCz9GeiYuTqsox2qZK43iQKevt8njkzaHv6KiW-A@mail.gmail.com>
 <YkwxNaJIg6ptJOYT@dhcp22.suse.cz> <CAGWkznG=QH3HRSzgum0sQBkyQAahqgiWf8nXCv1qXstxrn7e8w@mail.gmail.com>
 <Yk6VZlGnB48RqnYW@dhcp22.suse.cz> <CAGWkznG+V88f_DjtJAe4_Nr=32Q7Z4b1CaBCB0FVqhAAsuNsWA@mail.gmail.com>
 <Yk6ya5Ks0H6rHPx4@dhcp22.suse.cz>
In-Reply-To: <Yk6ya5Ks0H6rHPx4@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 7 Apr 2022 20:36:51 +0800
Message-ID: <CAGWkznH1NhfDXy94cOs0YWnw_uOOVbcbrygT5X6CAZ44CTf78Q@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
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

On Thu, Apr 7, 2022 at 5:44 PM Michal Hocko <mhocko@suse.com> wrote:
>
> [...]
> On Thu 07-04-22 16:59:50, Zhaoyang Huang wrote:
> > > This means that limits are altered even if there is memory to be
> > > reclaimed from other memcgs. Why? How does this line up with the
> > > basic property of the low limit to act as a protection from the reclaim?
> > ok, partially understand. I would like to say that low's original
> > definition under this patch has changed, says the calculated low just
> > provide protection when the psi value is lower than the setting and
> > will introduce reclaiming if it exceed.
>
> OK, I guess I finally get to understand what you are trying to say. So
> effectivelly your new semantic defines the low limit as an initial
> protection that is very soft and only preserved under a light global
> memory pressure[1]. If the reclaim pressure is higher the user provided
> protection is decreased. The new semantic is planned to be a global
> opt-in.
>
> Correct?
right. But I don't think the original protection is soft which could
be proved by the test result that the memcg is protected in a certain
range of pressure and could also help to release the system by
breaking low limit.
>
> Now, that I (believe) to have a slightly better understanding I have to
> say I really dislike the idea.
> First of all the new semantic would have to be memcg reclaim aware. That
> means that the scaling logic would need to be aware where the memory
> pressure comes from.
I don't follow. Does it mean that the protected should distinguish the
pressure from global and other memcgs? I don't know why.
> More importantnly I really dislike the idea that the user provided input
> is updated by the kernel without userspace knowledge about that. How is
> the userspace supposed to know that the value has been changed?
Actually, the purpose of this patch is to free the userspace during
runtime which require proper setup of parameter and then let the
scheme decide rest things.
> I can see how the effective values could be scaled down but this still
> sounds dubious as the userspace would have hard time to understand what
> is going on under the cover or even worse tune the value based on the
> specific observed behavior for a specific kernel which would make this a
> maintenance burden going forward.
This kind of memcg is supposed to be used by the user who is aware of
the scheme and would like the scheme to perform as it is.
>
> All that being said I have hard time to make sense of a protection which
> is unpredictably decreasing based on a global metrics without any
> userspace view into why and how this is done. So I am afraid I have to
> NACK this and I really do recommend you to start a discussion about your
> specific usecase and try to find a different solution.
As I have mentioned before, EAS scheduler is also a self-motivating
scheme which is based on load tracking and energy calculation. The
user could also be hard to know when the schedule entity could be
scheduled to big core. The admin could turn it off if dislike.
I would like to push this patch forward and get more feedback from
real scenarios.
>
> Best regards
>
>
> [1] this is based on the global PSI metric.
> --
> Michal Hocko
> SUSE Labs
