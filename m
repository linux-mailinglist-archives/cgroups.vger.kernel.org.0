Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B36515AA
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 23:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiLSWm4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 17:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLSWmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 17:42:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE113F36;
        Mon, 19 Dec 2022 14:42:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797E961184;
        Mon, 19 Dec 2022 22:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362ACC433EF;
        Mon, 19 Dec 2022 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671489773;
        bh=BGre2r5SHKHnb8b4Q50Q+a/dxymK6XCdQgeYGSWrbak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lpbVP7fJ/uOaGEd9aeQZ3P2o/kt4VheUXmT+dpCikhKJTLyA5nZhN69lTh+1W5j/d
         qcDyiIudJ3f7/d8OI3zQmbTIiBqFrdiZTeEfCcpiXrHtRWQxjBK5P9AVk4mTHu/NqH
         JSYoHx0maXMcg7CuyoiiZnQARL/sW0ZOGa8qWNEY=
Date:   Mon, 19 Dec 2022 14:42:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"
Message-Id: <20221219144252.f3da256e75e176905346b4d1@linux-foundation.org>
In-Reply-To: <Y52Scge3ynvn/mB4@dhcp22.suse.cz>
References: <20221202223533.1785418-1-almasrymina@google.com>
        <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz>
        <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
        <20221216101820.3f4a370af2c93d3c2e78ed8a@linux-foundation.org>
        <Y52Scge3ynvn/mB4@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 17 Dec 2022 10:57:06 +0100 Michal Hocko <mhocko@suse.com> wrote:

> > I think it's a bit premature to revert at this stage.  Possibly we can
> > get to the desired end state by modifying the existing code.  Possibly
> > we can get to the desired end state by reverting this and by adding
> > something new.
> 
> Sure if we can converge to a proper implementation during the rc phase
> then it would be ok. I cannot speak for others but at least for me
> upcoming 2 weeks would be mostly offline so I cannot really contribute
> much. A revert would be much more easier from the coordination POV IMHO.
> 
> Also I do not think there is any strong reason to rush this in. I do not
> really see any major problems to have this extension in 6.2

I'll queue the revert in mm-unstable with a plan to merge it upstream
around the -rc5 timeframe if there hasn't been resolution.

Please check Mina's issues with this revert's current changelog and
perhaps send along a revised one.

