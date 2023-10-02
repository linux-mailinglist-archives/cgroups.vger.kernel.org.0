Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72897B5960
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjJBRcW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJBRcV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 13:32:21 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C5D9;
        Mon,  2 Oct 2023 10:32:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3528bc102adso4010885ab.2;
        Mon, 02 Oct 2023 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696267938; x=1696872738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOcvNtoCPG98RS11q56sK5rtazXlCaKT/ov5ePtmTYw=;
        b=HQhw7KfciLByyvGcx8T9S0xInHY44XhYRXIMKhCNKqD6MqWMAvaD6hSTuGKvRLvoy/
         lwZpfybjwljszcfcMHeLMK68Fdy/GqrthE9BK5sRndb3zUVsnacBF/X3q1vTzQ41Cpbc
         t73Eyf1471396yHdOEgdo9QcveYtwKqZ2FYD6cQYubiWb1Ru8EIWQowJ5+TW9yh3+edm
         cp/NCwn6FlWdyzWceGjZTZebfNPEf6QY3r7Ap+JDQT73rTULHg0Rc+lx6DF7kI1S/zUu
         kIynetfc5dqVKYZ96JOwmX018VXx/xax0MMyQ7p1U+QL3IF6dOEy+NSnx/mvzHaLTUei
         kqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267938; x=1696872738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOcvNtoCPG98RS11q56sK5rtazXlCaKT/ov5ePtmTYw=;
        b=f7TC6vXy/D3p/OR2X4/HcGPpXlxXYkyOQmpc6RTDMranJ+JRwv4y55xtkV6JmJv5Fj
         SnlYLag8hfXhTgb5i2SckfjXYiZpnmAAfn5SKevr/niRkBjdH+gZijXd5566mtGceLcZ
         vqnPwNjvKqFVlJRYvSt+owK/XU/ehkMb1APD/M/JGf4HK6ynY/82GL07c+Ujy7tpK1z3
         eHOQ3VrWls/vWNRMVpLw7XBx31303yXT/drVnfNnKMJCjXBkQPb0xxdC87O5/u4joSVe
         awSXadkQuB79MkJ8W9cCvE6Nm3HXnbi/FLa643ncw6/KXaNeqLG5WZl1AF6skFrNJ2v7
         MxYA==
X-Gm-Message-State: AOJu0YzCqUaOXKSWKf4ulNrsQMAfxWxfkslMyNs2uChP31SuJJR9Ot0z
        +R5Z1w4L+sjKgvXqe4u962Ch5arzbr36jANnDLI=
X-Google-Smtp-Source: AGHT+IEngd3huTiNWRKhSAhYvvfitjNpvnUhpR7tSZ7IfW+0b6vK/Dtf2oCc8q9C6d4q6yVwFCOESBbY5foNkYh0IXY=
X-Received: by 2002:a05:6e02:1c0f:b0:351:56de:515c with SMTP id
 l15-20020a056e021c0f00b0035156de515cmr15191810ilh.6.1696267937801; Mon, 02
 Oct 2023 10:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz> <20231002145026.GB4414@cmpxchg.org>
 <ZRrc8hv4t740MZar@dhcp22.suse.cz> <20231002152555.GA5054@cmpxchg.org>
In-Reply-To: <20231002152555.GA5054@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 2 Oct 2023 10:32:06 -0700
Message-ID: <CAKEwX=NLBs=Oi8VDUyawWvKKhwU08kbgq8RKrY8CqrcG9G2QWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
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

On Mon, Oct 2, 2023 at 8:25=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Oct 02, 2023 at 05:08:34PM +0200, Michal Hocko wrote:
> > On Mon 02-10-23 10:50:26, Johannes Weiner wrote:
> > > On Mon, Oct 02, 2023 at 03:43:19PM +0200, Michal Hocko wrote:
> > > > On Wed 27-09-23 17:57:22, Nhat Pham wrote:
> > [...]
> > > > - memcg limit reclaim doesn't assist hugetlb pages allocation when
> > > >   hugetlb overcommit is configured (i.e. pages are not consumed fro=
m the
> > > >   pool) which means that the page allocation might disrupt workload=
s
> > > >   from other memcgs.
> > > > - failure to charge a hugetlb page results in SIGBUS rather
> > > >   than memcg oom killer. That could be the case even if the
> > > >   hugetlb pool still has pages available and there is
> > > >   reclaimable memory in the memcg.
> > >
> > > Are these actually true? AFAICS, regardless of whether the page comes
> > > from the pool or the buddy allocator, the memcg code will go through
> > > the regular charge path, attempt reclaim, and OOM if that fails.
> >
> > OK, I should have been more explicit. Let me expand. Charges are
> > accounted only _after_ the actual allocation is done. So the actual
> > allocation is not constrained by the memcg context. It might reclaim
> > from the memcg at that time but the disruption could have already
> > happened. Not really any different from regular memory allocation
> > attempt but much more visible with GB pages and one could reasonably
> > expect that memcg should stop such a GB allocation if the local reclaim
> > would be hopeless to free up enough from its own consumption.
> >
> > Makes more sense?
>
> Yes, that makes sense.
>
> This should be fairly easy to address by having hugetlb do the split
> transaction that charge_memcg() does in one go, similar to what we do
> for the hugetlb controller as well. IOW,
>
> alloc_hugetlb_folio()
> {
>         if (mem_cgroup_hugetlb_try_charge())
>                 return ERR_PTR(-ENOMEM);
>
>         folio =3D dequeue();
>         if (!folio) {
>                 folio =3D alloc_buddy();
>                 if (!folio)
>                         goto uncharge;
>         }
>
>         mem_cgroup_hugetlb_commit_charge();
> }

Ah actually, I like this better.
If I do this I can circumvent all the redo_reserve bogus as well!
