Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923A55EAEC5
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 19:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiIZR4G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 13:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIZRzj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 13:55:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5922642FE
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 10:33:01 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id j7so9277793ybb.8
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TOL7/M5VC7IyaSB3mrG/Ev31pWD9V/lWqppYMcTBfKM=;
        b=p6wexZ/Y0XqAhWAhWQ77q6u0CZ18nCzFEAe4bvVo7S0nEW6WuU84QbuIrXyLDHCaTI
         3KVY8/kPjnuU77CzmlnP2RX4B3VTuD+DX8rWAEp9ezkmsub624war7PTzocq0HhayQIP
         GMxA2Fj0qaw1SQGShM7S0FWzngjRfNeVBrilh6JsDYrekTU3j+x+9dO9Jg8FhujrX5gZ
         /TgpCO0SU+Id76XQMhc88uxX0Gxua10lmdNBqa+I4rCCzSzqO6kIbK1MKmXUlUBcdR1P
         LOKdsKRMbjEv0YfhCObzK+sUJ9DWdA8R5U5Pli/Q77cTZRdgCOChdjHXdIV50NkngFID
         P8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TOL7/M5VC7IyaSB3mrG/Ev31pWD9V/lWqppYMcTBfKM=;
        b=rKts0RAeeBtZLNS6pEZ5Xj8+SUk8JRKHztSMAVPAUP67uXC70j7xgC/BidTtlu8AP2
         AbozXRtKtmLQU4ye2fjMVNJrr5NKjKTblMJyeC4iAZBjOhFkHRaLVSJZLWWuRU/P8TKz
         KA2YMjFboOFRrK+zVs5iTrmWBuiA++ml0XZjFlw0YOnfZuhNBonmrLEpvKl61WI9XHma
         NoHDyLIZPl5f9t+tmZ+ugS6e0FBpE/Ygdct4xNaEXsI8grQGXUGW68IaX/q5pgWKEgXe
         FWQYastjjq5qczJAnv/eU4g47ugBP36kQnFYZEedjrq3BcXej9a17PxWBM9wOAVaXfFL
         wEug==
X-Gm-Message-State: ACrzQf1IZkfW4y7MefQHcVnW8UrmnLOUGM9li58WsVazFLbYeaF5ORV8
        6gkLAhTDErOvitrIJLwNhowhFugN6zWqigbtHKgpbA==
X-Google-Smtp-Source: AMsMyM72814D3Zid3Z4+5u+XXaRlAxLN2FtAB0S1kLY4fcWKgXglodA5Dypmeb7prlduUu0gUuE2/e2P2QvoFQP/RfA=
X-Received: by 2002:a05:6902:102c:b0:6b4:86ac:1436 with SMTP id
 x12-20020a056902102c00b006b486ac1436mr21059512ybt.368.1664213580392; Mon, 26
 Sep 2022 10:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <20220918092849.GA10314@u164.east.ru>
 <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
 <20220921170259.GI8331@blackbody.suse.cz> <CADxRZqyAG5Co9hLEp6p8vPC9WyGERR6un-3Rqapyv14G4vPXJw@mail.gmail.com>
 <20220926102812.2b0696a7@kernel.org>
In-Reply-To: <20220926102812.2b0696a7@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Sep 2022 10:32:49 -0700
Message-ID: <CALvZod5QProaWZgT9ykb-vrrRHBpLfqVGgW2jd-Td8aX5MBZFw@mail.gmail.com>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, Sep 26, 2022 at 10:28 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 26 Sep 2022 16:06:08 +0300 Anatoly Pugachev wrote:
> > On Wed, Sep 21, 2022 at 8:03 PM Michal Koutn=C3=BD <mkoutny@suse.com> w=
rote:
> > > On Wed, Sep 21, 2022 at 05:44:56PM +0300, Anatoly Pugachev <matorola@=
gmail.com> wrote:
> > > > reverting this patch makes my sparc64 box boot successfully.
> > >
> > > The failed address falls into vmmemmap region (per your boot log
> > > output). It looks like the respective page/folio (of init_net struct)=
 is
> > > unbacked there (and likely folio_test_slab fails dereferencing ->flag=
s).
> > >
> > > Would you mind sharing your kernel's config?
> > > (I'm most curious about CONFIG_SPARSMEM_VMEMMAP, I'm not familiar wit=
h
> > > your arch at all though.)
> >
> > mator@ttip:~/dmesg$ zcat config-6.0.0-rc6-00010-gb7f0f527dc3c.gz | grep=
 VMEMMAP
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> > CONFIG_SPARSEMEM_VMEMMAP=3Dy
> >
> > I do upload config and boot logs to
> > https://github.com/mator/sparc64-dmesg
> >
> > building a new kernel version/releases as 'make olddefconfig && make -j=
'
> > current version of booted 6.0.0-rc6 is available as
> > https://github.com/mator/sparc64-dmesg/blob/master/config-6.0.0-rc6-000=
10-gb7f0f527dc3c.gz
>
> Forgive my uniformed chime-in but Linus seemed happy with the size of
> -rc7 and now I'm worried there won't be an -rc8. AFAICT this is a 6.0
> regression. Vasily, Shakeel, do we have a plan to fix this?

I was actually waiting for Vasily to respond. Anyways, I think the
easiest way to proceed is to revert the commit 1d0403d20f6c ("net: set
proper memcg for net_init hooks allocations"). We can debug the issue
in the next cycle.
