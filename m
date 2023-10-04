Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385167B759C
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 02:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjJDACv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjJDACu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 20:02:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF519B;
        Tue,  3 Oct 2023 17:02:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso61502539f.2;
        Tue, 03 Oct 2023 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696377767; x=1696982567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lwvi14RsM0b+xzGuDXKW8wweEZca0TccO+tNNSAvQs=;
        b=Q4COcqp4ZRg9Ob1v8JC630RX9zUQctK1/kHqT+HZ9iPX/UQ0ZQ4VWndB73EPgDTxi0
         w+unVSkqDLj4BafHpu1CGfSLKCm0ixlyTGSbzcyzjSLZhuOWCMJKdi09LALRWeeqjdLy
         TZiAmed8ehnOpv1pZpvpA10LMUHq5BMmJdWtFY0oVim5gxeN7aGhx3NC4oKDVgPwt4xH
         RUsUO8HHDjGJoh6uNf/5uYkPG6f2GKErTWaAW+NL0kAbno+aSr3XFHKdtqU1dJ0XzM0q
         BmFj6dDeKvNQdnCid+ThUBMUxbfBXa7EMehT+KHjNLeA2MhS93Uhrpz/mgopLd2OaNZ1
         0xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377767; x=1696982567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lwvi14RsM0b+xzGuDXKW8wweEZca0TccO+tNNSAvQs=;
        b=tEcgjsywQSpZj5EsglPeUEPwXN23+5z7Gz3lPw29vUBOT5ohJfqyE1NqPnjwqnjyOn
         RsHtc7Qv4nLFCLexg1FluE9Vk3g/Jci2Qd8DFgCyxYLsQx8S4BtvV7TkoY7GVjvxy4wg
         VsvK9sHnYiAlfYFEFyVkHP0bxugYBxg6UR7uCh7CouWPoU2rwkIznaUDQlCEfH9iO/2h
         X6peKru6JNKUIMa+A28Uw2OOK+R/HIn2M4aE4hvwfGzwP5VnQllbvbSB8v5LSHRp0XfE
         K7wUTNIvJoJ2f3eGloCX5eyLM+X82hlBIuW94OtZflujAXBsXVBihwGH+aWQiOFORRp/
         BYNw==
X-Gm-Message-State: AOJu0YyTJDgifwEG/lQ12QLNK9memF3lzCB6H73j31qGPC6QDj4Lt62Z
        E326950rrKXo12ywfwSJcCuSLqQXSlLTC/IJ0Ew=
X-Google-Smtp-Source: AGHT+IHcMIAN4OhnLftpHP2fzQsi/adjXqQ2orkVpNfzXoJ5ibSH0Kn6foJOqL6FgXDTmUE3LdgpnXokJym0q1jdzEc=
X-Received: by 2002:a6b:a12:0:b0:787:1c51:ff99 with SMTP id
 z18-20020a6b0a12000000b007871c51ff99mr1026524ioi.11.1696377767238; Tue, 03
 Oct 2023 17:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231003171329.GB314430@monkey> <20231003231422.4046187-1-nphamcs@gmail.com>
 <CAJD7tkZRH5-y-ux2hDt70JpmL5=YwRwrg_otiTbAei09x-GAJQ@mail.gmail.com>
 <CAKEwX=M24ePo5CtLM6c9_APu9zaEgavDwWEDNTGKDRshkKp1PQ@mail.gmail.com> <CAJD7tkY=_32gFQP0S3me+N_qDPv4MykQ8Tmczsb6ewJSs2hsbg@mail.gmail.com>
In-Reply-To: <CAJD7tkY=_32gFQP0S3me+N_qDPv4MykQ8Tmczsb6ewJSs2hsbg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 3 Oct 2023 17:02:34 -0700
Message-ID: <CAKEwX=P6hRXzsrBHjAseMue=bejGFDDJKcrNV6+Z3hJA8Lb4MQ@mail.gmail.com>
Subject: Re: [PATCH] memcontrol: only transfer the memcg data for migration
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, fvdl@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 4:54=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Oct 3, 2023 at 4:31=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Tue, Oct 3, 2023 at 4:22=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > On Tue, Oct 3, 2023 at 4:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > > >
> > > > For most migration use cases, only transfer the memcg data from the=
 old
> > > > folio to the new folio, and clear the old folio's memcg data. No
> > > > charging and uncharging will be done. These use cases include the n=
ew
> > > > hugetlb memcg accounting behavior (which was not previously handled=
).
> > > >
> > > > This shaves off some work on the migration path, and avoids the
> > > > temporary double charging of a folio during its migration.
> > > >
> > > > The only exception is replace_page_cache_folio(), which will use th=
e old
> > > > mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In =
that
> > > > context, the isolation of the old page isn't quite as thorough as w=
ith
> > > > migration, so we cannot use our new implementation directly.
> > > >
> > > > This patch is the result of the following discussion on the new hug=
etlb
> > > > memcg accounting behavior:
> > > >
> > > > https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> > > >
> > > > Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > > Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey=
/
> > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > >
> > > Does this patch fit before or after your series? In both cases I thin=
k
> > > there might be a problem for bisectability.
> >
> > Hmm my intention for this patch is as a fixlet.
> > (i.e it should be eventually squashed to the second patch of that serie=
s).
> > I just include the extra context on the fixlet for review purposes.
> >
> > My apologies - should have been much clearer.
> > (Perhaps I should just send out v4 at this point?)
> >
>
> It's really up to Andrew, just make it clear what the intention is.

Thanks for reminding me! That was my oversight.

>
> Thanks!
