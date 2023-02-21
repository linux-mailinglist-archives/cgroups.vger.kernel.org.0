Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8212169E567
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjBURBh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjBURBZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:01:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482743A98;
        Tue, 21 Feb 2023 09:01:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso1647850pjn.4;
        Tue, 21 Feb 2023 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676998871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRQwKwj8b0XKFHecLezQ5DNfFD4GoTefbmEJjJYT/FE=;
        b=ABXQQSlSlcD3PY+8NQlv8y2MBo2ClB335AEhs+OTZHjLnQl/o4G2B7C4jxBfADZGXj
         z0oxUj78k1BjtCfktO89Yr/n4aNh0mpG7XMMUwUl+HfBnWxyPxolmRERbX0kkl0ta+XQ
         C8r9fXF6DnNTNfkh6KwdEVnOJiMwswlFrzF6cpnLS4hRAsX0Mzkw+4kyboIMpl5VDUIM
         Z7FqUNY6266OhC97ZEK4gmrj4+L/nqYhrKdWxJFcS43V17DZDWIYHCEZpB1w2UG5uK6g
         LFQ2UhX1Nh7ga9LO9t35TOByzPoyt1C5L43/pt7jk5QtLc1ddtHjsTbf4EfLFQQERUML
         YiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676998871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRQwKwj8b0XKFHecLezQ5DNfFD4GoTefbmEJjJYT/FE=;
        b=ud65nawhF9mnwRHEPJASnM7d7R8C1Q2GNcV5vdYEHmHjCjPqfqUBkAlh+y9G+CaEMG
         NpqpKQQ+9y6T455da0jMIT4Ppg4JQOAmeX6/SpjSCP9T4/5c2KL533n2X/fEFvf9QDb2
         CLXsSK7IXZqK7TtbAT0iGtdAVP/JRUK8qClwnpN/PFIUe4EmNu/IMuxyhO73IhOwOF8J
         7/wmrfxofCd/2txtdYWXOO+Q3NxBG1Lbz5yHj07keNbt4i7p58dWIef6+/7hrNNJvO9A
         VxbmPBXdyNvenSr7PDRUwIEocnCQotHiAcSFeIfObwujimz/xwvJQGZUPwnMtFA5htYk
         Qqow==
X-Gm-Message-State: AO0yUKWRjtQMJXEYxyq4I8h6I11WLa3uxm0Dmgkh/wqabbdVDlTMSefB
        18gW5PciHpXI3hoXSc+fJjsVBKr+nkYFuUP36aI=
X-Google-Smtp-Source: AK7set+eOeLZDUhYjuWGrJC3QrO+Bvt/NSvjO3ckFtBEPvydLfoBB+sOIvH0Y/NjSuYV21It3AVhw+E2TYfI+Ho3EN8=
X-Received: by 2002:a17:903:25c2:b0:19c:9999:e8f1 with SMTP id
 jc2-20020a17090325c200b0019c9999e8f1mr300052plb.12.1676998870890; Tue, 21 Feb
 2023 09:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20230220230624.lkobqeagycx7bi7p@google.com> <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
In-Reply-To: <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
From:   Martin Zhao <findns94@gmail.com>
Date:   Wed, 22 Feb 2023 01:00:00 +0800
Message-ID: <CADfL_jCtXEju4QsSig1-CBE_3ai_NgJOorVc1mk3+W=metkPJg@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
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

On Tue, Feb 21, 2023 at 2:52 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev>=
 wrote:
> >
> > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote=
:
> > >
> > > =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wro=
te:
> > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > >>> will be read and written simultaneously by user space
> > >>> programs, thus we'd better change memcg->oom_group access
> > >>> with atomic operations to avoid concurrency problems.
> > >>>
> > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > >>
> > >> Hi Yue!
> > >>
> > >> I'm curious, have any seen any real issues which your patch is solvi=
ng?
> > >> Can you, please, provide a bit more details.
> > >>
> > >
> > > IMHO such details are not needed. oom_group is being accessed
> > > concurrently and one of them can be a write access. At least
> > > READ_ONCE/WRITE_ONCE is needed here.
> >
> > Needed for what?
>
> For this particular case, documenting such an access. Though I don't
> think there are any architectures which may tear a one byte read/write
> and merging/refetching is not an issue for this.
>
> >
> > I mean it=E2=80=99s obviously not a big deal to put READ_ONCE()/WRITE_O=
NCE() here, but I struggle to imagine a scenario when it will make any diff=
erence. IMHO it=E2=80=99s easier to justify a proper atomic operation here,=
 even if it=E2=80=99s most likely an overkill.
> >
> > My question is very simple: the commit log mentions =E2=80=9C=E2=80=A6 =
to avoid concurrency problems=E2=80=9D, so I wonder what problems are these=
.
> >
> > Also there are other similar cgroup interfaces without READ_ONCE()/WRIT=
E_ONCE()
>
> Yeah and those are v1 interfaces e.g. oom_kill_disable, swappiness,
> soft_limit. These definitely need [READ|WRITE]_ONCE primitive.
>
> Yue, can you update your patch and convert all accesses to these
> fields through [READ|WRITE]_ONCE ?

Sure, it will take some time to update my patch later. I think most of
the accesses use [READ|WRITE]_ONCE already, only few interfaces need to
update.
