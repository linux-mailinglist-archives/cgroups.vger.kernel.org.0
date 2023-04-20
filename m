Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891846E9CF9
	for <lists+cgroups@lfdr.de>; Thu, 20 Apr 2023 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDTUU7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Apr 2023 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjDTUU6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Apr 2023 16:20:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC334EE6
        for <cgroups@vger.kernel.org>; Thu, 20 Apr 2023 13:20:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so5949757a12.1
        for <cgroups@vger.kernel.org>; Thu, 20 Apr 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682022023; x=1684614023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG2Ql85L6iDQ8KDJtvyVB1US8rf766mBBw7kP/giR5M=;
        b=QAXp3RObgIJpNM6iA+LUaWs2XmoxP0ETyPn/Hb7hsyUsoITvm+q1rB3PzE6Mw/ofni
         ULxOJ87mYAgAGSCd3rekbSsk8DyQtNXFtFQKX4c/KlTgtFoi+yknLHSR2BFFuZOSunKq
         vBK7hVVH0rH87rWoaKvGR/8SG3U1jq4nukkkvYzR31hv46lsUWafURYe+lWJOzKqHdYR
         ZAcEjfCDqzAYgzB/a6n/luU94tpPH/nhhW4mPeWcH3Mz/nBvuqPerlcHlTs5HgcrAnuP
         vOri0/ZN87/rTD24tM0uo61TQtf23tLNmshMmIQgAi6qQbai3wi9w5y14dyzB74qxq9+
         Oyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022023; x=1684614023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG2Ql85L6iDQ8KDJtvyVB1US8rf766mBBw7kP/giR5M=;
        b=CEYIZicI1Q/Lg2erX8MHWrxh2w+eZm3MY14Bh4KZjDKfkdF8GXwWIUnhcNg0lDs6Ax
         DZ91HvAqWoRbfLZilXYI6u6xmuOfs2JpJkxslrKT9uAbtKC212CnEbKCj597M/Zd08EL
         wweec70fz9dwwecytIjXsIyhjUuU35CHta2Gz5riMyUdutRXgjtfeAup9hY5M5xDiYV+
         ls4nDzgQ1hOJb1a4jHs7mWRIq91PgisqgFsnGHWa4/eSXL8mdWeB/Y5AOGnX/ssBY5gV
         +l27kXwEd525yFPoFDpxDme/01jxgjGNBM/bX4wB9f2yGt7mre3ByWaB1yEdj2DykoHt
         k8ag==
X-Gm-Message-State: AAQBX9eLgfgvlxX/swX0alaXnySMsKZGCC7b3CrG4gW4SvZXvGiYVCZR
        /GU0e2qM3Hgd+DQK3ZvpVD3ogblzOFl5yXDCbQjlxw==
X-Google-Smtp-Source: AKy350Zqqjhf63hrvxZCBfDJ+G0AGIpxZ0fOO09uTH99ETeQpYhmD9A0SBuIcV8kXVY7fmQbcwTq+21dl2Cyg9I05mM=
X-Received: by 2002:a05:6402:4413:b0:4af:7bdc:188e with SMTP id
 y19-20020a056402441300b004af7bdc188emr6254738eda.16.1682022023268; Thu, 20
 Apr 2023 13:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-6-yosryahmed@google.com> <CALvZod79Au=Fw9MTW7fP0P7KwQQ_NUiKgRHsNUFnv9v61pKnZA@mail.gmail.com>
 <ZEGXHvEPsfORq36_@slm.duckdns.org>
In-Reply-To: <ZEGXHvEPsfORq36_@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Apr 2023 13:19:46 -0700
Message-ID: <CAJD7tkZkPsBi2RH2b2WXZn=Q+uQJY5-+-MaPnrrNfZcjXo+xhA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 5/5] cgroup: remove cgroup_rstat_flush_atomic()
To:     Tejun Heo <tj@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 20, 2023 at 12:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Apr 20, 2023 at 12:40:24PM -0700, Shakeel Butt wrote:
> > +Tejun
> >
> >
> > On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > Previous patches removed the only caller of cgroup_rstat_flush_atomic=
().
> > > Remove the function and simplify the code.
> >
> >
> > I would say let cgroup maintainers decide this and this patch can be
> > decoupled from the series.
>
> Looks fine to me but yeah please cc me on the whole series from the next
> round.


Thanks for taking a look, I don't know how I missed CC'ing you on this
RFC. If I have to guess, my initial draft did not have this patch, so
I did not include you or linux-cgroups, then I added this patch. Sorry
for that :)

>
>
> Thanks.
>
> --
> tejun
