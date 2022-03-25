Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F24E6CC8
	for <lists+cgroups@lfdr.de>; Fri, 25 Mar 2022 04:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358160AbiCYDMW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Mar 2022 23:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCYDMU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Mar 2022 23:12:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E729157F;
        Thu, 24 Mar 2022 20:10:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id i4so5553358qti.7;
        Thu, 24 Mar 2022 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZkrO50N8MIM5fdKHsVpbm2U8iuVkvk0CAUhdGmqqWM=;
        b=LEzCQ1BWpC5mhJuQigVniD6FG8W+FawIPFRfZn+Kc8wgPtrkzAdxNxjdF2z4sGF77R
         vx2tdr04eu9K+qltad/QTWCS+aJIjicWUybB4qRGdUGf2MFLsUJ26Wt2s/Yd3g/69drO
         nfmJa7B2HNNRWw5dUCx6PEQbxGEKpJEBmTZ+oYi4Mk4h7XqPLyFV36M4lrktps1MDGIM
         7416CjhidMppBvW1QZARuGBCy9CPxN2gcZDERMFLwvRVPuByqnQ60bhEsGDqoBoYMpzf
         oYJTqoXCa3jnCaLnvzBLSEQ3zz+UytX3asngvJyWKFknxSwXSATB4MWAIynVxZeEhPvl
         u90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZkrO50N8MIM5fdKHsVpbm2U8iuVkvk0CAUhdGmqqWM=;
        b=HMZk6yKo7SfaW+hNOuxX3fnQZ/WAaoY2yfANRWNi77vZGW/jKdwKQodGT7ThuA94uv
         aGQZAv01cNGv3q1vUdYCeE3P2gb4tkOyzH02pOIJr+6im5xcmmGSghGmlbbKOc1X7nxF
         uJhIZMTnrmV6nsy16nS1BcjsxPIdz6pO1usAkogs7XDXJbgFmGW2nBCNmgOBxVLvXel/
         QDJHXNa+Ba3pYINA4lMnRfHeqb6OtnqVEIRJ7hxI7qQYr07GUdIGYFGBxnOFBW17Xm3g
         GUITl8s97jvqySKeZKcRHpzar9LgvTPlh42JnA/hETlZqfLKhkCKcqhxs9lQFMcyfShI
         kPjw==
X-Gm-Message-State: AOAM5310hRbeE4d+vEXTYtvCaEwt6o/+GGElVBjPCF5eg9RaDt+kzZbW
        ySalkya2SNJ+0mkWYn6sWNoLFgoaQSMA2p4KpiU=
X-Google-Smtp-Source: ABdhPJzUejlrpTWbMbBFR3zw+m+FP9gNyj6Y72ty2YJAvfbhqETu1h/9BmrZCmXPz9/vloJ369+PEExnQzGdOMkkQPk=
X-Received: by 2002:ac8:4e50:0:b0:2e2:17a8:2ab0 with SMTP id
 e16-20020ac84e50000000b002e217a82ab0mr7367671qtw.68.1648177847048; Thu, 24
 Mar 2022 20:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <Yjx/3yi7BfH7wLPz@chrisdown.name> <FE4CCCF9-CF08-424B-85D0-B5C1BA63329D@linux.dev>
In-Reply-To: <FE4CCCF9-CF08-424B-85D0-B5C1BA63329D@linux.dev>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 25 Mar 2022 11:10:19 +0800
Message-ID: <CAGWkznGnDUvAqX3KCP+HZCyn49XU9=2bV9vfiFbutsQw8mK=hw@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce proportional protection on memcg
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Chris Down <chris@chrisdown.name>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        ke wang <ke.wang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 25, 2022 at 12:23 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> It seems like what=E2=80=99s being proposed is an ability to express the =
protection in % of the current usage rather than an absolute number.
> It=E2=80=99s an equivalent for something like a memory (reclaim) priority=
: e.g. a cgroup with 80% protection is _always_ reclaimed less aggressively=
 than one with a 20% protection.
>
> That said, I=E2=80=99m not a fan of this idea.
> It might make sense in some reasonable range of usages, but if your workl=
oad is simply leaking memory and growing indefinitely, protecting it seems =
like a bad idea. And the first part can be easily achieved using an userspa=
ce tool.
>
> Thanks!
>
> > On Mar 24, 2022, at 7:33 AM, Chris Down <chris@chrisdown.name> wrote:
> >
> > =EF=BB=BFI'm confused by the aims of this patch. We already have propor=
tional reclaim for memory.min and memory.low, and memory.high is already "p=
roportional" by its nature to drive memory back down behind the configured =
threshold.
> >
> > Could you please be more clear about what you're trying to achieve and =
in what way the existing proportional reclaim mechanisms are insufficient f=
or you?
ok, I think it could be fixable for memory leak issues. Please refer
to my reply on Chris's comment for more explanation.
