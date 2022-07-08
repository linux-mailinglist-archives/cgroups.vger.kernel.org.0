Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12F56B0E4
	for <lists+cgroups@lfdr.de>; Fri,  8 Jul 2022 05:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiGHDTE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Jul 2022 23:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiGHDTE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Jul 2022 23:19:04 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785D747AD;
        Thu,  7 Jul 2022 20:19:00 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657250338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZzXf77ZnSEJIjuevx+EB4GpaxQjdHtz9/POLfph/nBE=;
        b=Qy4O0B3TXJnXaPohoJlWl3VViPm/HiAjQYjCu92SV5MLaTSvFAV+asc6HCYkyU8p29uqsK
        PkUyYZY6tI8B3J1zEbsMAdtKcYG8wSnd5IjAKW9MMeB6HBjelCfaH6lEOd/IoUOOQGqtdu
        qmer4OS87yqwZODPooty6DN/RPX+W9E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for
 enforced allocations
Message-ID: <YseiHOgqLapJPiyC@castle>
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle>
 <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsSj6rZmUkR8amT2@castle>
 <CALOAHbAb9DT6ihyxTm-4FCUiqiAzRSUHJw9erc+JTKVT9p8tow@mail.gmail.com>
 <YsUBQsTjVuXvt1Wr@castle>
 <CALOAHbDjRzySCHeMVHtVDe=Ji+qh=n0pT4CwiAM5Pahi2-QNCQ@mail.gmail.com>
 <YsUH7pgBVnWSkC1q@castle>
 <CAADnVQ+qqeAVvtDYox4xj85Qxt79EV1Hn+HDEMuzHrwZv14X4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+qqeAVvtDYox4xj85Qxt79EV1Hn+HDEMuzHrwZv14X4Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 07, 2022 at 03:41:11PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 5, 2022 at 9:24 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > Anyway, here is the patch for reparenting bpf maps:
> > https://github.com/rgushchin/linux/commit/f57df8bb35770507a4624fe52216b6c14f39c50c
> >
> > I gonna post it to bpf@ after some testing.
> 
> Please do. It looks good.
> It needs #ifdef CONFIG_MEMCG_KMEM
> because get_obj_cgroup_from_current() is undefined otherwise.
> Ideally just adding a static inline to a .h ?

Actually all call sites are already under CONFIG_MEMCG_KMEM.

> 
> and
> if (map->objcg)
>    memcg = get_mem_cgroup_from_objcg(map->objcg);
> 
> or !NULL check inside get_mem_cgroup_from_objcg()
> which would be better.

Yes, you're right, as now we need to handle it specially.

In the near future it won't be necessary. There are patches in
mm-unstable which make objcg API useful outside of CONFIG_MEMCG_KMEM.
In particular it means that objcg will be created for the root_mem_cgroup.
So map->objcg can always point at a valid objcg and we will be able
to drop this check.

Will post an updated version shortly.

Thanks!
