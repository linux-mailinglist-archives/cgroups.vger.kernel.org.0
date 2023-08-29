Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3B78C950
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjH2QFX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 12:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbjH2QFS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 12:05:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A912F
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 09:05:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99df431d4bfso603865066b.1
        for <cgroups@vger.kernel.org>; Tue, 29 Aug 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693325114; x=1693929914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z79jhU7o/NUfJHuqLql7WhGDUVVNML8fOs/maDU7iyc=;
        b=HU/WionO7dHsradhblbEvF6SjWyz4OqPBhbtHC38sImO18QxSafcV5WjAP1HOaS88J
         rilbruX+yteYYkDBba6T/dOAbY5kVTXRyrLxtGcWAGkk47x8gDLQ6AJ1EQn9badyKsj9
         4Pj9lLwH6jStEmJipnLzXkgT9BdZUA7ob0Zy5yu6uXq85H26G+ggQS8FZhbieVjA0cHV
         50n570Yo0XzxwoYhkim7ah5t+gCGhoLXmfYrILMAeYyDdhAKpEKjc3mZsRbw1YoWWEml
         DzRd7bpK8CWPfob+UoExg1LMpr+yo8Yya+uJh3V+vhWVBxtOFdggG+lOB1291kz9XgW2
         xpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693325114; x=1693929914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z79jhU7o/NUfJHuqLql7WhGDUVVNML8fOs/maDU7iyc=;
        b=MiJhAPiM1wKoiKvSW7XK6mSh6sFUqvCFDrxJz1TWXva9/NDJW6Aa2qWgtrvvyRONA/
         CeK/QnL1QuqGHhdG4oyxUYFuJbF5EauVxilnRtVR2Uk8iOpHcxG8h/bFV2eTNlrZledZ
         KX0N2p0fMeoxXCjEumhEHeAI90nUhebK6Ae32HqwFDrgXBenO8QMhbX+jPuUKpxnZFx3
         qXB0T29lN9tIsZc7zV7l8lehyxcEfELU4OmnoI7Q3+bz+6P1aVdBy4cxSeI5JRK0EZa7
         xMqT7A5ipRLJKQmN87jQEyb2SGPNdImagXul6kXT1lEVpwULfcseMh3lrqpO/jfLmtFR
         1QfQ==
X-Gm-Message-State: AOJu0Yy28CLIYmgrd5Uq21vX9/FFLeu8ZtCsN3e1Zbot03wTfdHwq/x2
        vtHA7p3ZCLtTjuBiWbmOTet/LXG2xMd6xzlKP8IrWw==
X-Google-Smtp-Source: AGHT+IHGQRIOKu7zBaSTeFzg76p4v7MjLmRkp9Ao8ZeIgBqT7UU9YdCYpUTL+MGJQBpw3GRpN6MDJkYwGONdW4nPwUo=
X-Received: by 2002:a17:906:32db:b0:9a1:914e:490e with SMTP id
 k27-20020a17090632db00b009a1914e490emr20864309ejk.53.1693325113936; Tue, 29
 Aug 2023 09:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz> <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
 <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com>
 <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com> <ZO2d7dT8gulMyb8g@dhcp22.suse.cz>
 <5906501e-4dff-4c66-7ab3-e9193d312270@redhat.com> <ZO4MBNzsbhsi7adb@dhcp22.suse.cz>
In-Reply-To: <ZO4MBNzsbhsi7adb@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 29 Aug 2023 09:04:37 -0700
Message-ID: <CAJD7tkZ45VDjYyorgZ38unRkMeoy44OcCpPq_kdnMWEam3vssA@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 29, 2023 at 8:17=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Tue 29-08-23 11:05:28, Waiman Long wrote:
> > On 8/29/23 03:27, Michal Hocko wrote:
> > > On Mon 28-08-23 13:27:23, Waiman Long wrote:
> > > > On 8/28/23 13:07, Yosry Ahmed wrote:
> > > > > > Here I agree with you. Let's go with the approach which is easy=
 to
> > > > > > undo for now. Though I prefer the new explicit interface for fl=
ushing,
> > > > > > that step would be very hard to undo. Let's reevaluate if the p=
roposed
> > > > > > approach shows negative impact on production traffic and I thin=
k
> > > > > > Cloudflare folks can give us the results soon.
> > > > > Do you prefer we also switch to using a mutex (with preemption
> > > > > disabled) to avoid the scenario Michal described where flushers g=
ive
> > > > > up the lock and sleep resulting in an unbounded wait time in the =
worst
> > > > > case?
> > > > Locking with mutex with preemption disabled is an oxymoron.
> > > I believe Yosry wanted to disable preemption _after_ the lock is take=
n
> > > to reduce the time spent while it is held. The idea to use the mutex =
is
> > > to reduce spinning and more importantly to get rid of lock dropping
> > > part. It is not really clear (but unlikely) we can drop it while
> > > preserving the spinlock as the thing scales with O(#cgroups x #cpus)
> > > in the worst case.
> >
> > As I have said later in my email, I am not against disabling preemption
> > selectively on some parts of the lock critical section where preemption=
 is
> > undesirable. However, I am against disabling preemption for the whole
> > duration of the code where the mutex lock is held as it defeats the pur=
pose
> > of using mutex in the first place.
>
> I certainly agree this is an antipattern.

So I guess the verdict is to avoid using a mutex here for now. I sent
a v2 which includes an additional small patch suggested by Michal
Koutny and an updated changelog for this patch to document this
discussion and possible alternatives we can do if things go wrong with
this approach:

https://lore.kernel.org/lkml/20230828233319.340712-1-yosryahmed@google.com/
