Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15B6B0BE0
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCHOwT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCHOwM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 09:52:12 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B5CA23;
        Wed,  8 Mar 2023 06:52:11 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s18so9783676pgq.1;
        Wed, 08 Mar 2023 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678287131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8ujCnIiLc25U33obQkBP96azILctHn33HsXwDllrlM=;
        b=jGq4oQeB034ih7zR9Oq4NHEbQaUS4y3CrcWO9b1gcnXV4g0VesuI0xctNraDdUHl2E
         3tOJwJZvOGSztbaLqfmESuiFNIUikm8Vcsx0ethzNmjJUPVJ2OrFpEGWqURGdeEKDRTo
         rb+/aTGVAMdg0ZDEtw1UWFTtHK/rKctFpEPO9bozyv3PfJDJqaPgbqPjqrEvtxx/kHOU
         GFrJrmE9hvUfkIoMDEJCYNRmOXbzo79Q+VBXToKup1ZrWc498ZVxAhiCe6X5lFIQhLsj
         EKRBwbSBtH6D/R4xZOBdsbJ+UUFJeK23QizXKofEJ4rxBeNUF5QKyDeXTf0McMFTTb/T
         ZJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8ujCnIiLc25U33obQkBP96azILctHn33HsXwDllrlM=;
        b=NtADJSRFU0PeAzdu192E+CrzeuTplVUCgKdgHHchh6K5fPYl6Hcl1qMuU9SBevH1qD
         hgXU8o3oxDtVK7Smn0EsO4DS8OUdAfJEf64EjlQ7LrL+FaTXt+HJBYFrkUjv6t9vFOQ6
         a58b++TLEVBzsX4WjkCFEQpjfUXbIu1fWgPwER09wbcQbfO/SrhNSHcrEHJXdOE4XxUM
         p4VqZJfbFcRr/os0S9f63MiJ+9a/By0katuuhins/Uf7DrSHReVqbeZDYoT3U4k03Fna
         bJSIVBhYb95bNkCr89fB7RNNNdXxXe9oWcB0gJrRMoSDPY9HAyjka/07pBT+NT0qIR6W
         mC0g==
X-Gm-Message-State: AO0yUKXAT2WKM2JnsbyFQj/JnRv3P9VLid1lnrHv4kR0D/aw25If+nxa
        KSzg3eoN/vTqJGZvtWXmeHo/Ak5lHRhkQueiFbE=
X-Google-Smtp-Source: AK7set/2zcPRMk297Tw2+bXG27vpei/sMRJkU/Okt4O/umS6oAGs4ZHQc59IPGu2GYm1SadbWqh/p/QQnmCH7wy3yqk=
X-Received: by 2002:a63:5904:0:b0:503:a26a:2e7a with SMTP id
 n4-20020a635904000000b00503a26a2e7amr6359409pgb.6.1678287130569; Wed, 08 Mar
 2023 06:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20230306154138.3775-1-findns94@gmail.com> <20230306154138.3775-4-findns94@gmail.com>
 <ZAYoi8ZwwbXT9j7f@dhcp22.suse.cz>
In-Reply-To: <ZAYoi8ZwwbXT9j7f@dhcp22.suse.cz>
From:   Martin Zhao <findns94@gmail.com>
Date:   Wed, 8 Mar 2023 22:51:54 +0800
Message-ID: <CADfL_jA3fa6HrGLRp25avQm+yamxqUZhK6BLjnjANbaJF7tsBw@mail.gmail.com>
Subject: Re: [PATCH v2, 3/4] mm, memcg: Prevent memory.oom_control load/store tearing
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 7, 2023 at 1:53=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Mon 06-03-23 23:41:37, Yue Zhao wrote:
> > The knob for cgroup v1 memory controller: memory.oom_control
> > is not protected by any locking so it can be modified while it is used.
> > This is not an actual problem because races are unlikely.
> > But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
> > doing anything funky.
> >
> > The access of memcg->oom_kill_disable is lockless,
> > so it can be concurrently set at the same time as we are
> > trying to read it.
> >
> > Signed-off-by: Yue Zhao <findns94@gmail.com>
> > ---
> >  mm/memcontrol.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index dca895c66a9b..26605b2f51b1 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4515,7 +4515,7 @@ static int mem_cgroup_oom_control_read(struct seq=
_file *sf, void *v)
> >  {
> >       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(sf);
> >
> > -     seq_printf(sf, "oom_kill_disable %d\n", memcg->oom_kill_disable);
> > +     seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill=
_disable));
> >       seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
> >       seq_printf(sf, "oom_kill %lu\n",
> >                  atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]=
));
> > @@ -4531,7 +4531,7 @@ static int mem_cgroup_oom_control_write(struct cg=
roup_subsys_state *css,
> >       if (mem_cgroup_is_root(memcg) || !((val =3D=3D 0) || (val =3D=3D =
1)))
> >               return -EINVAL;
> >
> > -     memcg->oom_kill_disable =3D val;
> > +     WRITE_ONCE(memcg->oom_kill_disable, val);
> >       if (!val)
> >               memcg_oom_recover(memcg);
>
> Any specific reasons you haven't covered other accesses
> (mem_cgroup_css_alloc, mem_cgroup_oom, mem_cgroup_oom_synchronize)?

Thanks for point this out, you are right, we should add
[READ|WRITE]_ONCE for all used places.
Let me create PATCH v3 later.
Also for the memcg->soft_limit, I will update as well.

> >
> > --
> > 2.17.1
>
> --
> Michal Hocko
> SUSE Labs
