Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD259321B
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiHOPkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiHOPkD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 11:40:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281E916583
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:40:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l4so9462922wrm.13
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VP31WSY65QEYHmGKkheHdJtit2IxlAC3C/GTNPT6J3M=;
        b=KDR20vjhDq0om+BbSpgVjbjIEfKyM9hzqellnZMBbjPYhKfqx8ikJsySttFwFlY2Hw
         oiDxEt4RpXxN6hUaJW8OuaENfYZOafXkSDkX1vb9dg7V/aG4QsRJ6TYY0F9WUlTLn6Vf
         NHF+LgUaJFpui1g9qC+Rv3LypInoC1lE1hsrJ8BiNxbEAPP6tn3XdJyY/w0KbBw7PpJD
         oH77RjEzfa5ost8upGE9k1u6DJriI0mcBtWbmFcq9KC94GZZe4EqzVQ4aUBaXW6zABOk
         ZIGRqcpIb5HIHOLH2gv1bH3WqUBDiCE5BvLQ/x7yySs3uf1w5ktkzspTtUNcCnzYJQEj
         8w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VP31WSY65QEYHmGKkheHdJtit2IxlAC3C/GTNPT6J3M=;
        b=cAVArMoPeYO+TPTTb9Dm6yJto/bZ7QVy0QIk8bahw+fQP0+zjTL+oDLse4E/kuNkoR
         F0C7g0Q3EKqs2CQ8TrpHBWs7ZgjeztwWg6ePc+oJ+RTMn8uxqKxg9hV/PQkRLRXL6POZ
         OMIORaNpk5ACe46T7+GHk+x4fdB+ahIn1X3uLxBVEXKu/5M58TUIq/C0sAG5wVVLt1tZ
         jeWOYyOy824Zdf2mZX+YUlpRE5Lp1Tk8u+WMi4dxW9M/tPe2xaLaQAO9NP2Wn/QLXIX9
         g3D58FNShxSsDKZf+rX8Yk5iEN0n2cPOOxF0ZnrbNxtcLeWFE5/SaNMYqqKw4xKlkJ7b
         /34A==
X-Gm-Message-State: ACgBeo2xAtpfVbLd92rC263L7eqP5od5ZCUwScC519biayNWJbK4ocIE
        QD+YlSdZOCYZS62el45d+n6WsJprCKQqzw88BNMgbg==
X-Google-Smtp-Source: AA6agR7zuuSgDdcz2wd92uz0ytguGNdoZjdF2d8ZPVqoybSSwNN8/GwgwCl+M3WDqdInbEa6zFZJ4DJNkrQDuxI0MHA=
X-Received: by 2002:a5d:5a82:0:b0:224:f744:1799 with SMTP id
 bp2-20020a5d5a82000000b00224f7441799mr1748341wrb.582.1660577999491; Mon, 15
 Aug 2022 08:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220628220938.3657876-1-yosryahmed@google.com>
 <20220628220938.3657876-2-yosryahmed@google.com> <YsdJPeVOqlj4cf2a@google.com>
 <CAJD7tkYE+pZdk=-psEP_Rq_1CmDjY7Go+s1LXm-ctryWvUdgLA@mail.gmail.com>
 <Ys3+UTTC4Qgbm7pQ@google.com> <CAJD7tkY91oiDWTj5FY2Upc5vabsjLk+CBMNzAepXLUdF_GS11w@mail.gmail.com>
 <CAJD7tkbc+E7f+ENRazf0SO7C3gR2bHiN4B0F1oPn8Pa6juAVfg@mail.gmail.com> <Yvpir0nWuTsXz322@cmpxchg.org>
In-Reply-To: <Yvpir0nWuTsXz322@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 15 Aug 2022 08:39:23 -0700
Message-ID: <CAJD7tkYJcsSvCUCkNgcWvi2Xoa3GDZk81p5GUptZzkOkrhrTWQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sean Christopherson <seanjc@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, Huang@google.com,
        Shaoqin <shaoqin.huang@intel.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 15, 2022 at 8:13 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Aug 08, 2022 at 01:06:15PM -0700, Yosry Ahmed wrote:
> > On Mon, Jul 18, 2022 at 11:26 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 4:06 PM Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > On Tue, Jul 12, 2022, Yosry Ahmed wrote:
> > > > > Thanks for taking another look at this!
> > > > >
> > > > > On Thu, Jul 7, 2022 at 1:59 PM Sean Christopherson <seanjc@google.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 28, 2022, Yosry Ahmed wrote:
> > > > > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > > > > index aab70355d64f3..13190d298c986 100644
> > > > > > > --- a/include/linux/mmzone.h
> > > > > > > +++ b/include/linux/mmzone.h
> > > > > > > @@ -216,6 +216,7 @@ enum node_stat_item {
> > > > > > >       NR_KERNEL_SCS_KB,       /* measured in KiB */
> > > > > > >  #endif
> > > > > > >       NR_PAGETABLE,           /* used for pagetables */
> > > > > > > +     NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. kvm shadow pagetables */
> > > > > >
> > > > > > Nit, s/kvm/KVM, and drop the "shadow", which might be misinterpreted as saying KVM
> > > > > > pagetables are only accounted when KVM is using shadow paging.  KVM's usage of "shadow"
> > > > > > is messy, so I totally understand why you included it, but in this case it's unnecessary
> > > > > > and potentially confusing.
> > > > > >
> > > > > > And finally, something that's not a nit.  Should this be wrapped with CONFIG_KVM
> > > > > > (using IS_ENABLED() because KVM can be built as a module)?  That could be removed
> > > > > > if another non-KVM secondary MMU user comes along, but until then, #ifdeffery for
> > > > > > stats the depend on a single feature seems to be the status quo for this code.
> > > > > >
> > > > >
> > > > > I will #ifdef the stat, but I will emphasize in the docs that is
> > > > > currently *only* used for KVM so that it makes sense if users without
> > > > > KVM don't see the stat at all. I will also remove the stat from
> > > > > show_free_areas() in mm/page_alloc.c as it seems like none of the
> > > > > #ifdefed stats show up there.
> > > >
> > > > It's might be worth getting someone from mm/ to weigh in before going through the
> > > > trouble, my suggestion/question is based purely on the existing code.
> > >
> > > Any mm folks with an opinion about this?
> > >
> > > Any preference on whether we should wrap NR_SECONDARY_PAGETABLE stats
> > > with #ifdef CONFIG_KVM for now as it is currently the only source for
> > > this stat?
> >
> > Any input here?
> >
> > Johannes, you have been involved in discussions in earlier versions of
> > this series, any thoughts here?
>
> No super strong feelings here. Most major distros have CONFIG_KVM=y/n,
> so it'll be a common fixture anyway, and the ifdef is proooobably not
> worth it for hiding it from people. OTOH, the ifdef is useful for
> documenting the code.
>
> If you've already ifdeffed it now, I'd say go ahead with
> it. Otherwise, don't :) My 2c.

Thanks a lot, Johannes! I haven't ifdeffed it yet so I'll send a v7
with a few nits and collect ACKs. Andrew, would you prefer me to
rebase on top of mm-unstable? Or will this go in through the kvm tree?
(currently it's based on an old-ish kvm/queue).
