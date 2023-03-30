Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621136CFDB8
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjC3IHH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 04:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjC3IHG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 04:07:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F51986
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 01:07:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w9so73224084edc.3
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680163623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9/OZbBvN+GYY+k6VNhkbPsCuwIDJGgvOD15HQAmaC4=;
        b=Dsrmlf6SQ7dieSEewhGmRqcjAnISmY3AXD9YHFTWUr8d+rNOpPZJaTLj6dySdAJBmS
         2QtMKaqtURSXtYTkG0ZC4UmNj6SQdXGiCRKn4ol9GUN33Z9cvEGcATJXOWKZqMvTfIwf
         QhPCIRe1EuHaGXZkRDNRZSBsvvOSCKbdsMoAnDpHTvNBHEdWh2VFjjbS2q3CAxFG3btu
         9+MI5lzCPRk1D1xVAU7NB+C21NNfqBlxd2VKiRIhMGqXWDHEF52eu7YEHYU0MDOcj+bg
         5qY4+RVkbmlN5SerigkhW3HND52Iysgu6N4mDyqx0XKW8vxxRsMx5p6SzsEYAB9yGwzi
         J4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9/OZbBvN+GYY+k6VNhkbPsCuwIDJGgvOD15HQAmaC4=;
        b=w96BYiZEZ2CU9Jkr9PEMp7V+H8xjDTbMe3jXkKZsNFptzFN/aMTnaE+MT9gPi3l1kz
         ewkssUpl+OFA30aZuWl6ltK5CGrwtV6poJjrdpk3/MdGsAaYvrBpTF9DR7Ej6WiLTkiJ
         0uJuIGbqh0SVRURfQLzCbv/c+cVPGP9ti9i5vKqi/hiG6e8Mc8TqKnRmCDrfqDchi+dW
         h8dgMkas/pf595BvzXX7qDk4en6Mj67L9TqjBxdvuwopOnyeeHpZcsUMJloE9PIp4hIb
         hdkERZoImc7mXjbRz2nZH1XkrmC41dppuSSDMlD808mr8MxiPJubAwEI9UUk7CqBCFbi
         nubA==
X-Gm-Message-State: AAQBX9dgG7COXzdKbpqy6OtUa40eHMaTBA4bRAIm3soRELTN5tnBCWB1
        T9h05HZUorNnN8bfbYyVm0X+rlQhEngQrwl1pjyDbg==
X-Google-Smtp-Source: AKy350bAfMXdd5ybBW9MntO/LYBeu0+13bGoVOKRQbfwOov/1/I9J3qNCI1MgUJs6HRYlq94hLg/UkBhLlt4JxBxOF0=
X-Received: by 2002:a17:907:6a95:b0:947:72cd:9325 with SMTP id
 ri21-20020a1709076a9500b0094772cd9325mr229031ejc.15.1680163623142; Thu, 30
 Mar 2023 01:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-5-yosryahmed@google.com> <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com> <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
 <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com> <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz>
In-Reply-To: <ZCU+8lSi+e4WgT3F@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 01:06:26 -0700
Message-ID: <CAJD7tkaKd9Bcb2-e83Q-kzF7G+crr1U+7uqUPBARXWq-LpyKvw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 30, 2023 at 12:49=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 30-03-23 00:13:16, Yosry Ahmed wrote:
> > On Thu, Mar 30, 2023 at 12:06=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> [...]
> > > So the real question is. Do we really care so deeply? After all someb=
ody
> > > might be calling this from within a spin lock or irq disabled section
> > > resulting in a similar situation without noticing.
> >
> > There are discussions in [1] about making atomic rstat flush not
> > disable irqs throughout the process, so in that case it would only
> > result in a similar situation if the caller has irq disabled. The only
> > caller that might have irq disabled is the same caller that might be
> > in irq context before this series: mem_cgroup_usage().
> >
> > On that note, and while I have your attention, I was wondering if we
> > can eliminate the flush call completely from mem_cgroup_usage(), and
> > read the global stats counters for root memcg instead of the root
> > counters. There might be subtle differences, but the root memcg usage
> > isn't super accurate now anyway (e.g. it doesn't include kernel
> > memory).
>
> root memcg stats are imprecise indeed and I have to admit I do not
> really know why we are adding more work for that case. I have tried to
> dig into git history for that yesterday but couldn't find a satisfying
> answer. It goes all the way down to 2d146aa3aa842 which has done the
> switch to rstat. Maybe Johannes remembers.

I think it goes back even before that. Even before rstat, we used to
get the root usage by iterating over the hierarchy. Maybe we didn't
have the global counters at some point or they weren't in line with
the root memcg (e.g. use_hierarchy =3D 0). It would be great if we can
just use the global counters here. Hopefully Johannes can confirm or
deny this.

>
> Anyway, back to this particular patch. I still do not see strong reasons
> to be verbose about !in_task case so I would just drop this patch.

I will drop this patch in the next iteration. If I implement a patch
that makes rstat flushing not disable irqs all throughout (like [1]),
whether part of this series or not, and we remove flushing from
mem_cgroup_usage(), then at this point:
- No existing flushers will be disabling irqs.
- rstat flushing itself will not be disabling irqs throughout the entire fl=
ush.

If we achieve that, do you think it makes sense to add
WARN_ON_ONCE(irqs_disabled()) instead to prevent future users from
flushing while disabling irqs or in irq context?

All I am trying to achieve here is make sure we don't regress. I don't
want to minimize the current atomic flushers now only to have them
increase later.

[1] https://lore.kernel.org/lkml/CAJD7tkZrp=3D4zWvjE9_010TAG1T_crCbf9P64UzJ=
ABspgcrGPKg@mail.gmail.com/

> --
> Michal Hocko
> SUSE Labs
