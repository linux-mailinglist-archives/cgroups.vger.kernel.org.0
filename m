Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B187B758D
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbjJCXzG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 19:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbjJCXy7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 19:54:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA7AD
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 16:54:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b29186e20aso263182366b.2
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696377294; x=1696982094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k54IfXN35LcUb/U9aVzVxuRpliN0wT/CBLBw3Ki+e6g=;
        b=m9T+zXfGr5dR/vSrzaM0LmiMPzrk8hBnJ4d8EOoObVEq1KleFfXF8oBbyOQUFRKw2P
         +zrUvFO637Fn7Kvk/GJC6vS4XVVLTPtUpqerc55yQbwwgMzZpq3Ef5g8EgCZzfVLOEdG
         /qq/loWlBqOpab8olKJSESSy9S4FiwzuZeg0OBC32vIRIMLh5iVyWwr6hGqDiEM5tLBD
         n3otc8WaK3e6nBI1Fv6i6f4bl+EQvSnXl5+ROeXihRo04QiT1VL63GEjLTcGcqaa4Gvi
         sVSa0i0ouh+jE4o8z2buMnKnyiyxOweerSizUNo2l5zjE9hd7CCL/subtlx+9bFXzAEQ
         M5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696377294; x=1696982094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k54IfXN35LcUb/U9aVzVxuRpliN0wT/CBLBw3Ki+e6g=;
        b=UKoW15rhBiAFPxIAWCLG4Bo168QfOCv4nmJGoqdmwKXduu/CruztIYGBFAGb80+EhS
         gTUB28cHrDXQJ7oIhubpYA0EL7RHKQj5s2b9pewyE3/r1wiwCBpFrV6/xP4gAZwdh8gA
         gCMWFlwFDxo0iwr0FI9VRp7pK3gvc48klWlMCPz0iZQRcTtYktt+KigqImhVQjOB4KEM
         6zk3dKUt9rbCtRK39EAPneragOwzYRP75igyRxCKYmg+lImu0rW1Rq9U5bJM1KeaYHbF
         B5YYevdVOpiO+mLBSPMOOWLcPznM0ogI0RUYbiASDUcqjI4MYk2jt4PX20hWScmVszqo
         MHng==
X-Gm-Message-State: AOJu0YzYy1ufrCEUL23J3+KYcdCghPTfNvHCLH8EAj4knoAg6+E+D9Wm
        G0sPuha83zT0YvdCUcys4VuZpuw0oYlKS92pNjmhBg==
X-Google-Smtp-Source: AGHT+IHmQjFNjfE4KL0F3yD6xfaY0FGO07TXSsUtsgVYU7mnvWYnWoqjBjIa9c7vbuKv8yTPBRBoymK2iIyTF9qIovE=
X-Received: by 2002:a17:906:9c1:b0:9b2:89ec:d701 with SMTP id
 r1-20020a17090609c100b009b289ecd701mr654707eje.27.1696377294256; Tue, 03 Oct
 2023 16:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231003171329.GB314430@monkey> <20231003231422.4046187-1-nphamcs@gmail.com>
 <CAJD7tkZRH5-y-ux2hDt70JpmL5=YwRwrg_otiTbAei09x-GAJQ@mail.gmail.com> <CAKEwX=M24ePo5CtLM6c9_APu9zaEgavDwWEDNTGKDRshkKp1PQ@mail.gmail.com>
In-Reply-To: <CAKEwX=M24ePo5CtLM6c9_APu9zaEgavDwWEDNTGKDRshkKp1PQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 16:54:14 -0700
Message-ID: <CAJD7tkY=_32gFQP0S3me+N_qDPv4MykQ8Tmczsb6ewJSs2hsbg@mail.gmail.com>
Subject: Re: [PATCH] memcontrol: only transfer the memcg data for migration
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, fvdl@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 4:31=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Oct 3, 2023 at 4:22=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Oct 3, 2023 at 4:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > For most migration use cases, only transfer the memcg data from the o=
ld
> > > folio to the new folio, and clear the old folio's memcg data. No
> > > charging and uncharging will be done. These use cases include the new
> > > hugetlb memcg accounting behavior (which was not previously handled).
> > >
> > > This shaves off some work on the migration path, and avoids the
> > > temporary double charging of a folio during its migration.
> > >
> > > The only exception is replace_page_cache_folio(), which will use the =
old
> > > mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In th=
at
> > > context, the isolation of the old page isn't quite as thorough as wit=
h
> > > migration, so we cannot use our new implementation directly.
> > >
> > > This patch is the result of the following discussion on the new huget=
lb
> > > memcg accounting behavior:
> > >
> > > https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> > >
> > > Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> >
> > Does this patch fit before or after your series? In both cases I think
> > there might be a problem for bisectability.
>
> Hmm my intention for this patch is as a fixlet.
> (i.e it should be eventually squashed to the second patch of that series)=
.
> I just include the extra context on the fixlet for review purposes.
>
> My apologies - should have been much clearer.
> (Perhaps I should just send out v4 at this point?)
>

It's really up to Andrew, just make it clear what the intention is.

Thanks!
