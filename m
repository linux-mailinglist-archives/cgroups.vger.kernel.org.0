Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14867B74D4
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 01:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjJCX0c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 19:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbjJCX02 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 19:26:28 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028190;
        Tue,  3 Oct 2023 16:26:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso60613939f.2;
        Tue, 03 Oct 2023 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696375584; x=1696980384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ny5iyIo3c29FhVEcNOS9Ddt74DJ5wZg8ueoeeWyydk=;
        b=kcqrmZdRZK9aP/XHIB1s4ejBTooThbcaIoPxzapwmAFBvv6WHYKcyjKmwvPpHhFsQx
         EMlfcnrACcRhkhuD0PfM/uMuBIE0WWk2kOPIN1/KqlXseQUKDts4BIPGlvw2SjAeGXyc
         8+6SsGd9H+HZSpE7sh+TOSM4GBbNUaMj2Stwkq7bqA2W0KIoEBlnaP4h3rTJjsU/gUS7
         WD5T1F7vhHSyN3IqnM4bK9BMBPXHU/GjTkRI9jNA8m4hWpBeM0K45YJiDGUhlUp10o4d
         /jGSPXfI6t+RSPHv4rHJZnwl7oSmyAAeKZUjQf2alWrS0NZ8nYttRGRQ+iVXg+9vhg1M
         O7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375584; x=1696980384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ny5iyIo3c29FhVEcNOS9Ddt74DJ5wZg8ueoeeWyydk=;
        b=nQUY03bOQGzKBvpZ36ti8eJoQ2rKrkXOkDmcVost/fKQFfetijTuCTUfabSzl1eZhP
         OQw50bIcfyanWmChF6yqBZJn35UxffNNuJtSd2K97jSW4XJAlWFhr6a+zUxgSXswkbd5
         58dAQjthTxr/B6ICEym4wJNSqQDYn6EbxY8+KS36wzJqDySAisSVm7gg93/wx8jLu++Y
         /KEPRv+IoaUwiZb0fYeWyuv6xsGaci4mbVVvcXi/hV3aPH5ZpQuWrpEyqRcQXwgQrCGq
         /CbDOl6IGwzUMLRuEMQOw2FZR7X3sq0gwG2zinRHhhMtvQ0SeXEc0Zg+0rdxBCPDphCf
         p7mg==
X-Gm-Message-State: AOJu0Yw7Pp1K2QmApFyJQyTkG+wxZIdPQawMH+yWcpbyePcOIedtcHlq
        IqCDBngh5M3z+9QVbPX/4f/t6uPkCOMOpfxLCXU=
X-Google-Smtp-Source: AGHT+IFIfHB1/JD1gmiRZKngRz/4e5Chk2T8BrzRwvNrmCYseeO/v2iFv+ET8tm+jBP4rg99nzpSdoR615FyoHKPLd0=
X-Received: by 2002:a5e:8345:0:b0:78b:d0a9:34fb with SMTP id
 y5-20020a5e8345000000b0078bd0a934fbmr783370iom.20.1696375583948; Tue, 03 Oct
 2023 16:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231003001828.2554080-1-nphamcs@gmail.com> <20231003001828.2554080-3-nphamcs@gmail.com>
 <20231003171329.GB314430@monkey> <CAKEwX=POd1DZc2K5ym14R2DpU74DqV30_A6QGfsCAaOTMK2WJA@mail.gmail.com>
 <20231003183928.GC20979@cmpxchg.org> <CAKEwX=O8X+ZRNEzzs+NYBAh9QJLObxKPOpmFo-ci4Aw=MR=0+Q@mail.gmail.com>
 <20231003224214.GE314430@monkey>
In-Reply-To: <20231003224214.GE314430@monkey>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 3 Oct 2023 16:26:10 -0700
Message-ID: <CAKEwX=MqV5CThRxTXs3DKqGNw04w2j=4hmE+Wi7x4Gu_ykATmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 3:42=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.co=
m> wrote:
>
> On 10/03/23 15:09, Nhat Pham wrote:
> > On Tue, Oct 3, 2023 at 11:39=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > > On Tue, Oct 03, 2023 at 11:01:24AM -0700, Nhat Pham wrote:
> > > > On Tue, Oct 3, 2023 at 10:13=E2=80=AFAM Mike Kravetz <mike.kravetz@=
oracle.com> wrote:
> > > > > On 10/02/23 17:18, Nhat Pham wrote:
> > > > >
> > > > > IIUC, huge page usage is charged in alloc_hugetlb_folio and uncha=
rged in
> > > > > free_huge_folio.  During migration, huge pages are allocated via
> > > > > alloc_migrate_hugetlb_folio, not alloc_hugetlb_folio.  So, there =
is no
> > > > > charging for the migration target page and we uncharge the source=
 page.
> > > > > It looks like there will be no charge for the huge page after mig=
ration?
> > > > >
> > > >
> > > > Ah I see! This is a bit subtle indeed.
> > > >
> > > > For the hugetlb controller, it looks like they update the cgroup in=
fo
> > > > inside move_hugetlb_state(), which calls hugetlb_cgroup_migrate()
> > > > to transfer the hugetlb cgroup info to the destination folio.
> > > >
> > > > Perhaps we can do something analogous here.
> > > >
> > > > > If my analysis above is correct, then we may need to be careful a=
bout
> > > > > this accounting.  We may not want both source and target pages to=
 be
> > > > > charged at the same time.
> > > >
> > > > We can create a variant of mem_cgroup_migrate that does not double
> > > > charge, but instead just copy the mem_cgroup information to the new
> > > > folio, and then clear that info from the old folio. That way the me=
mory
> > > > usage counters are untouched.
> > > >
> > > > Somebody with more expertise on migration should fact check me
> > > > of course :)
> > >
> > > The only reason mem_cgroup_migrate() double charges right now is
> > > because it's used by replace_page_cache_folio(). In that context, the
> > > isolation of the old page isn't quite as thorough as with migration,
> > > so it cannot transfer and uncharge directly. This goes back a long
> > > time: 0a31bc97c80c3fa87b32c091d9a930ac19cd0c40
> > >
> > > If you rename the current implementation to mem_cgroup_replace_page()
> > > for that one caller, you can add a mem_cgroup_migrate() variant which
> > > is charge neutral and clears old->memcg_data. This can be used for
> > > regular and hugetlb page migration. Something like this (totally
> > > untested):
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index a4d3282493b6..17ec45bf3653 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -7226,29 +7226,14 @@ void mem_cgroup_migrate(struct folio *old, st=
ruct folio *new)
> > >         if (mem_cgroup_disabled())
> > >                 return;
> > >
> > > -       /* Page cache replacement: new folio already charged? */
> > > -       if (folio_memcg(new))
> > > -               return;
> > > -
> > >         memcg =3D folio_memcg(old);
> > >         VM_WARN_ON_ONCE_FOLIO(!memcg, old);
> > >         if (!memcg)
> > >                 return;
> > >
> > > -       /* Force-charge the new page. The old one will be freed soon =
*/
> > > -       if (!mem_cgroup_is_root(memcg)) {
> > > -               page_counter_charge(&memcg->memory, nr_pages);
> > > -               if (do_memsw_account())
> > > -                       page_counter_charge(&memcg->memsw, nr_pages);
> > > -       }
> > > -
> > > -       css_get(&memcg->css);
> > > +       /* Transfer the charge and the css ref */
> > >         commit_charge(new, memcg);
> > > -
> > > -       local_irq_save(flags);
> > > -       mem_cgroup_charge_statistics(memcg, nr_pages);
> > > -       memcg_check_events(memcg, folio_nid(new));
> > > -       local_irq_restore(flags);
> > > +       old->memcg_data =3D 0;
> > >  }
> > >
> > >  DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
> > >
> >
> > Ah, I like this. Will send a fixlet based on this :)
> > I was scratching my head trying to figure out why we were
> > doing the double charging in the first place. Thanks for the context,
> > Johannes!
>
> Be sure to check for code similar to this in folio_migrate_flags:
>
> void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
> {
> ...
>         if (!folio_test_hugetlb(folio))
>                 mem_cgroup_migrate(folio, newfolio);
> }
>
> There are many places where hugetlb is special cased.

Yeah makes sense. I'm actually gonna take advantage of this,
and remove the test hugetlb check here, so that it will also
migrate the memcg metadata in this case too.  See the new patch
I just sent out.

> --
> Mike Kravetz
