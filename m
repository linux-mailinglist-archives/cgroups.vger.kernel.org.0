Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3655EAEE3
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 19:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIZR6a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIZR56 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 13:57:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594F9114E;
        Mon, 26 Sep 2022 10:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E42EFCE1188;
        Mon, 26 Sep 2022 17:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25971C433D7;
        Mon, 26 Sep 2022 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664213795;
        bh=d8R/sf+/F1E5Bfqo0FLK1XydgttpS5flZpUHlwRHdYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sq2/cFT6vMw7tZBcj6VZqz7Qxjm497e4Rfi0bSbjdsEpmM/a7gJQRHzuOsBjEPAkO
         q7nDzwvBxRYhQQm4B57MbY8PHjVI7RTULXUEEJDyw+kraeZ88Vi/+zrdU4knn3NjbI
         bffaPRaZmNma6nbfMDj1PMjC28BOYFqKynVRkWgs=
Date:   Mon, 26 Sep 2022 10:36:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Vasily Averin <vvs@openvz.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        kernel@openvz.org,
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
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
Message-Id: <20220926103631.8cb144a6d0b683915b0ecb10@linux-foundation.org>
In-Reply-To: <CALvZod5QProaWZgT9ykb-vrrRHBpLfqVGgW2jd-Td8aX5MBZFw@mail.gmail.com>
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
        <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
        <20220918092849.GA10314@u164.east.ru>
        <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
        <20220921170259.GI8331@blackbody.suse.cz>
        <CADxRZqyAG5Co9hLEp6p8vPC9WyGERR6un-3Rqapyv14G4vPXJw@mail.gmail.com>
        <20220926102812.2b0696a7@kernel.org>
        <CALvZod5QProaWZgT9ykb-vrrRHBpLfqVGgW2jd-Td8aX5MBZFw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 26 Sep 2022 10:32:49 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> > Forgive my uniformed chime-in but Linus seemed happy with the size of
> > -rc7 and now I'm worried there won't be an -rc8. AFAICT this is a 6.0
> > regression. Vasily, Shakeel, do we have a plan to fix this?
> 
> I was actually waiting for Vasily to respond. Anyways, I think the
> easiest way to proceed is to revert the commit 1d0403d20f6c ("net: set
> proper memcg for net_init hooks allocations"). We can debug the issue
> in the next cycle.

If agreeable, could someone please send along a tested and changelogged
patch to do this?

