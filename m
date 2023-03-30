Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17B76CFC79
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjC3HOY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjC3HOX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:14:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100C72A6
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 00:13:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ew6so72659469edb.7
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680160433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIO+xjpPvxFE7p3Fg529YdgqYE0es+Za65fM8K1qjgQ=;
        b=UvXOXvaKg5W3pOiKg4eDH9lHl4Zdbajrfr9yCdPGB59p3EbanzUW5AbZ60M0Fo1jLj
         xgrtU13pG+2HRUXSZV1YHQUF6aAPx8bmMFTsyT+tMN4I6uSd3iTp4e0p5o0dlpChmR1N
         kgpM/rCb2oFLWV87Mo4Q+i3t95OakU3lMRj4YQ1nysYmA+Tpl5yBca0fvDqMPohFxbDB
         Y7+D8BKyWgRNceAUWpnfWnDi7HIUgkBAG3eDp8W+4bCHX6Cc8wGgEGVLJTMMQ7fZWTfd
         8/Oa9xlswq0vuQl+sJims+8vhoieSnu1v+Z91iZH9bXW/MlL8LF9mWWEI22UEcU5KFZ+
         xqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680160433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIO+xjpPvxFE7p3Fg529YdgqYE0es+Za65fM8K1qjgQ=;
        b=QlHRusYF0Rrb2GaWabeShv1+6/PF51v6KUntnEr8SDKlRk3aXf0fqU8n3iPbqNRyUw
         nkG4yCrurfz66C9q3TZI7V/U9ghwi4eIMENbfqbUgTJslSrBsEoK8hVxsiRt1N7JzWkw
         pr/zEUS8xuZ/PkUl4jmMQnbyYnoUqnlmWOFKYmmN3CfogNVMv9ASMifOqkgnev7nsWx1
         201KkvekMkMGJORnK5+rOnv2GOT6Q2ZyrY0O34bWlSgGHd8IZE9RDt7asn/f1Irz41+0
         N9MFSYrsSXOizcBnly+6SWLRfpigYvVzDdbuu7ctOMJCsoEWe6KHONCd7wu7a/63nJom
         TXIQ==
X-Gm-Message-State: AAQBX9cTCkJLdDN1f6Bmf4bsIUFJEq+OW0Tz1Xk9gaEwfC6O0wHJZGgW
        B0RPnMi8GEk86tjzllFPuNucP77c3uWPZXGkiV0Wmas6YhWf+X20mqApezvY
X-Google-Smtp-Source: AKy350YivWZ/HKPgZxm5eZxF7+2qcjmArqrs51gN4d7jnY/jgrQdpgyHe6R7cHRBBvkOSSb0g8UX51iLn7ZYwWx1eHQ=
X-Received: by 2002:a17:906:7846:b0:933:1967:a984 with SMTP id
 p6-20020a170906784600b009331967a984mr10847576ejm.15.1680160433435; Thu, 30
 Mar 2023 00:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-5-yosryahmed@google.com> <ZCQfZJFufkJ10o01@dhcp22.suse.cz>
 <CAJD7tkb-UpKm2QbjYzB=B=oGk6Hyj9cbUviZUPC+7VsvBecH7g@mail.gmail.com>
 <20230329192059.2nlme5ubshzdbpg6@google.com> <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
In-Reply-To: <ZCU1Bp+5bKNJzWIu@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:13:16 -0700
Message-ID: <CAJD7tka0CmRvcvB0k8DZuid1vC9OK_mFriHHbXNTUkVE7OjaTA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing
 outside task context
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

On Thu, Mar 30, 2023 at 12:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 29-03-23 19:20:59, Shakeel Butt wrote:
> > On Wed, Mar 29, 2023 at 11:41:39AM -0700, Yosry Ahmed wrote:
> > > On Wed, Mar 29, 2023 at 4:22=E2=80=AFAM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Tue 28-03-23 22:16:39, Yosry Ahmed wrote:
> > > > > rstat flushing is too expensive to perform in irq context.
> > > > > The previous patch removed the only context that may invoke an rs=
tat
> > > > > flush from irq context, add a WARN_ON_ONCE() to detect future
> > > > > violations, or those that we are not aware of.
> > > > >
> > > > > Ideally, we wouldn't flush with irqs disabled either, but we have=
 one
> > > > > context today that does so in mem_cgroup_usage(). Forbid callers =
from
> > > > > irq context for now, and hopefully we can also forbid callers wit=
h irqs
> > > > > disabled in the future when we can get rid of this callsite.
> > > >
> > > > I am sorry to be late to the discussion. I wanted to follow up on
> > > > Johannes reply in the previous version but you are too fast ;)
> > > >
> > > > I do agree that this looks rather arbitrary. You do not explain how=
 the
> > > > warning actually helps. Is the intention to be really verbose to th=
e
> > > > kernel log when somebody uses this interface from the IRQ context a=
nd
> > > > get bug reports? What about configurations with panic on warn? Do w=
e
> > > > really want to crash their systems for something like that?
> > >
> > > Thanks for taking a look, Michal!
> > >
> > > The ultimate goal is not to flush in irq context or with irqs
> > > disabled, as in some cases it causes irqs to be disabled for a long
> > > time, as flushing is an expensive operation. The previous patch in th=
e
> > > series should have removed the only context that flushes in irq
> > > context, and the purpose of the WARN_ON_ONCE() is to catch future use=
s
> > > or uses that we might have missed.
> > >
> > > There is still one code path that flushes with irqs disabled (also
> > > mem_cgroup_usage()), and we cannot remove this just yet; we need to
> > > deprecate usage threshold events for root to do that. So we cannot
> > > enforce not flushing with irqs disabled yet.
> > >
> > > So basically the patch is trying to enforce what we have now, not
> > > flushing in irq context, and hopefully at some point we will also be
> > > able to enforce not flushing with irqs disabled.
> > >
> > > If WARN_ON_ONCE() is the wrong tool for this, please let me know.
> > >
> >
> > If I understand Michal's concern, the question is should be start with
> > pr_warn_once() instead of WARN_ON_ONCE() and I think yes we should star=
t
> > with pr_warn_once().
>
> Yes, I do not really like the WARN_ON here. It is an overkill. pr_warn
> would much less intrusive but potentially incomplete because you won't
> know who that offender is. So if you really care about those then you
> would need to call dump_stack as well.
>
> So the real question is. Do we really care so deeply? After all somebody
> might be calling this from within a spin lock or irq disabled section
> resulting in a similar situation without noticing.

There are discussions in [1] about making atomic rstat flush not
disable irqs throughout the process, so in that case it would only
result in a similar situation if the caller has irq disabled. The only
caller that might have irq disabled is the same caller that might be
in irq context before this series: mem_cgroup_usage().

On that note, and while I have your attention, I was wondering if we
can eliminate the flush call completely from mem_cgroup_usage(), and
read the global stats counters for root memcg instead of the root
counters. There might be subtle differences, but the root memcg usage
isn't super accurate now anyway (e.g. it doesn't include kernel
memory).

With that removed, no callers to rstat flushing would be from irq
context or have irqs disabled. There will only be one atomic flusher
(mem_cgroup_wb_stats()), and we can proceed with [1] if it causes a
problem.

What do you think?

[1] https://lore.kernel.org/lkml/CAJD7tkZrp=3D4zWvjE9_010TAG1T_crCbf9P64UzJ=
ABspgcrGPKg@mail.gmail.com/

> --
> Michal Hocko
> SUSE Labs
