Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7569EB08
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 00:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjBUXNv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 18:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjBUXNv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 18:13:51 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350F2B289
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 15:13:48 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y144so6736082yby.12
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfHPXSxQbyJdMH+KmHlN2/CbpKW3yYJpKPwM72/EQwY=;
        b=aDzKnDOk1eT9PO/941WpCnT+ylarf2E+IHThkN0u9LZ/6SvFPhFvAn1OmjQLWTmfkI
         TGTVoMC1kJzfEzUDfKs3wZCB788OGa0dZknCzSP3wttqrzHuJnRuDFDIEkFEnbTRYOKV
         BdXkL8EpZkpnW0N7OJ2F0les4WHO7NywGpPF3QofNHYmzE16GGO5S9Z0T8lDiA8EpGG9
         9vVvK2lLQgMCGD/8yUYVoAI1n2ehBG8WUVv2D/u/2r614iW3Es6/dhYaiw4aPq9xhV9p
         JYUudS4AuKkKE6f3kFc0doojFqiXHMzzZQMirD4cYx3tQGoLoDg6qTeWIaOIl2AeJ79P
         9iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfHPXSxQbyJdMH+KmHlN2/CbpKW3yYJpKPwM72/EQwY=;
        b=jltvHPsW5r9FIJqfmvK7X+G7CPjjp2qdqLK/MRH4SlBO1ejpgX1wrdvHGZVdm2xXEa
         bEJ9Tq+wVqui8isDIvbAylCRJZZ788Xa8vVUl+tge1M+zet9SjyEZeHyiGP6YIHLemnW
         G8+vsfyrhSAtYhAL3+bZLqQGtJTmyyI+M6gYzYKuHuTBcPN0cNuzsRyJu+XPnypnxmCW
         H+841a7YAcVn3IaqG09b0EmzazmCIMIjdKlp+0J0DPJDQ4pd+/Pr+ru6WucNLklgCl3d
         GKTlFegV1/W6ws0oBphoszLp7oXuVw5sidueob9r5oKP2npKdu/auHtVWS27p7w2FFbj
         +G7g==
X-Gm-Message-State: AO0yUKVTB701+fclZLOpIniv+Sxl/yeNEk4SzHKmH8Dp5m0MDIE+Hlyl
        HNgdO8zb9GgLciTMMHYyXaKSnebdpABoPUDqN0OkVw==
X-Google-Smtp-Source: AK7set9inokGQ4CkOEIuZMB8Kv65an9aOM5l3GGOqp7ZX6/+AyNmDqtbqImUNyK2lcJLHB/D148MrG8xX3Vda8VdG1s=
X-Received: by 2002:a25:f201:0:b0:807:4bf9:f810 with SMTP id
 i1-20020a25f201000000b008074bf9f810mr369836ybe.409.1677021227379; Tue, 21 Feb
 2023 15:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20230220230624.lkobqeagycx7bi7p@google.com> <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org> <CALvZod6UM1E6nGgfdORri90m3ju+yYeSeHBqyqutCP2A94WNKg@mail.gmail.com>
 <20230221182359.GJ2948950@paulmck-ThinkPad-P17-Gen-1> <Y/VEY2myhfWvB64+@P9FQF9L96D.corp.robot.car>
 <20230221223811.GK2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230221223811.GK2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Feb 2023 15:13:36 -0800
Message-ID: <CALvZod7DaFeXFjYpnuP8U3QOjsQmKFHDMruB1-cm3Ly0HOH2FQ@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     paulmck@kernel.org
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>, Yue Zhao <findns94@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 2:38 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Tue, Feb 21, 2023 at 02:23:31PM -0800, Roman Gushchin wrote:
> > On Tue, Feb 21, 2023 at 10:23:59AM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 21, 2023 at 08:56:59AM -0800, Shakeel Butt wrote:
> > > > +Paul & Marco
> > > >
> > > > On Tue, Feb 21, 2023 at 5:51 AM Matthew Wilcox <willy@infradead.org=
> wrote:
> > > > >
> > > > > On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > > > > > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > > > > > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.=
com> wrote:
> > > > > > > >
> > > > > > > > =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gu=
shchin wrote:
> > > > > > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > > > > > >>> The knob for cgroup v2 memory controller: memory.oom.grou=
p
> > > > > > > >>> will be read and written simultaneously by user space
> > > > > > > >>> programs, thus we'd better change memcg->oom_group access
> > > > > > > >>> with atomic operations to avoid concurrency problems.
> > > > > > > >>>
> > > > > > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > > > > > >>
> > > > > > > >> Hi Yue!
> > > > > > > >>
> > > > > > > >> I'm curious, have any seen any real issues which your patc=
h is solving?
> > > > > > > >> Can you, please, provide a bit more details.
> > > > > > > >>
> > > > > > > >
> > > > > > > > IMHO such details are not needed. oom_group is being access=
ed
> > > > > > > > concurrently and one of them can be a write access. At leas=
t
> > > > > > > > READ_ONCE/WRITE_ONCE is needed here.
> > > > > > >
> > > > > > > Needed for what?
> > > > > >
> > > > > > For this particular case, documenting such an access. Though I =
don't
> > > > > > think there are any architectures which may tear a one byte rea=
d/write
> > > > > > and merging/refetching is not an issue for this.
> > > > >
> > > > > Wouldn't a compiler be within its rights to implement a one byte =
store as:
> > > > >
> > > > >         load-word
> > > > >         modify-byte-in-word
> > > > >         store-word
> > > > >
> > > > > and if this is a lockless store to a word which has an adjacent b=
yte also
> > > > > being modified by another CPU, one of those CPUs can lose its sto=
re?
> > > > > And WRITE_ONCE would prevent the compiler from implementing the s=
tore
> > > > > in that way.
> > > >
> > > > Thanks Willy for pointing this out. If the compiler can really do t=
his
> > > > then [READ|WRITE]_ONCE are required here. I always have big bad
> > > > compiler lwn article open in a tab. I couldn't map this transformat=
ion
> > > > to ones mentioned in that article. Do we have name of this one?
> > >
> > > No, recent compilers are absolutely forbidden from doing this sort of
> > > thing except under very special circumstances.
> > >
> > > Before C11, compilers could and in fact did do things like this.  Thi=
s is
> > > after all a great way to keep the CPU's vector unit from getting bore=
d.
> > > Unfortunately for those who prize optimization above all else, doing
> > > this can introduce data races, for example:
> > >
> > >     char a;
> > >     char b;
> > >     spin_lock la;
> > >     spin_lock lb;
> > >
> > >     void change_a(char new_a)
> > >     {
> > >             spin_lock(&la);
> > >             a =3D new_a;
> > >             spin_unlock(&la);
> > >     }
> > >
> > >     void change_b(char new_b)
> > >     {
> > >             spin_lock(&lb);
> > >             b =3D new_b;
> > >             spin_unlock(&lb);
> > >     }
> > >
> > > If the compiler "optimized" that "a =3D new_a" so as to produce a non=
-atomic
> > > read-modify-write sequence, it would be introducing a data race.
> > > And since C11, the compiler is absolutely forbidden from introducing
> > > data races.  So, again, no, the compiler cannot invent writes to
> > > variables.
> > >
> > > What are those very special circumstances?
> > >
> > > 1.  The other variables were going to be written to anyway, and
> > >     none of the writes was non-volatile and there was no ordering
> > >     directive between any of those writes.
> > >
> > > 2.  The other variables are dead, as in there are no subsequent
> > >     reads from them anywhere in the program.  Of course in that case,
> > >     there is no need to read the prior values of those variables.
> > >
> > > 3.  All accesses to all of the variables are visible to the compiler,
> > >     and the compiler can prove that there are no concurrent accesses
> > >     to any of them.  For example, all of the variables are on-stack
> > >     variables whose addresses are never taken.
> > >
> > > Does that help, or am I misunderstanding the question?
> >
> > Thank you, Paul!
> >
> > So it seems like READ_ONCE()/WRITE_ONCE() are totally useless here.
> > Or I still miss something?
>
> Yes, given that the compiler will already avoid inventing data-race-prone
> C-language accesses to shared variables, so if that was the only reason
> that you were using READ_ONCE() or WRITE_ONCE(), then READ_ONCE() and
> WRITE_ONCE() won't be helping you.
>
> Or perhaps better to put it a different way...  The fact that the compile=
r
> is not permitted to invent data-racy reads and writes is exactly why
> you do not normally need READ_ONCE() and WRITE_ONCE() for accesses in
> lock-based critical sections.  Instead, you only need READ_ONCE() and
> WRITE_ONCE() when you have lockless accesses to the same shared variables=
.
>

This is lockless access to memcg->oom_group potentially from multiple
CPUs, so, READ_ONCE() and WRITE_ONCE() are needed, right?
