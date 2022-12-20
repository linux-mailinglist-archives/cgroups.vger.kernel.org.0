Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48F65283F
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 22:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiLTVP3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 16:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiLTVP0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 16:15:26 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFE11EAEB;
        Tue, 20 Dec 2022 13:15:23 -0800 (PST)
Date:   Tue, 20 Dec 2022 13:15:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671570922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YR2G1tfnt1QeRb9BvoQh2xZ0Hit39TayrVYxM23Ti5o=;
        b=cBJO2EIe6oiGh2ENr1dP4PUWluxLFCOQnl1rnqFwsqvzqef+3Rd/UJmBPLbq5IL4/dcQEn
        gN4B8V37nJGryYOHvpTd23Gf5nrA6ZTRW9dEdQKd/He/k9s9kK8CV0Agq/XwjtfIEVbjoQ
        ujr36SB+a8Yw8C6daF2iwukLgcHSDDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 1/2] mm: kmem: optimize get_obj_cgroup_from_current()
Message-ID: <Y6Il5L00NIviTIe4@P9FQF9L96D.corp.robot.car>
References: <20221220182745.1903540-1-roman.gushchin@linux.dev>
 <20221220182745.1903540-2-roman.gushchin@linux.dev>
 <CALvZod5q0koAckpTr4VBq-_KiQpsmC86bE4eP9gzX71PzRdicA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5q0koAckpTr4VBq-_KiQpsmC86bE4eP9gzX71PzRdicA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 20, 2022 at 11:55:34AM -0800, Shakeel Butt wrote:
> On Tue, Dec 20, 2022 at 10:28 AM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> > Manually inline memcg_kmem_bypass() and active_memcg() to speed up
> > get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
> > and active_memcg() readings.
> >
> > Also add a likely() macro to __get_obj_cgroup_from_memcg():
> > obj_cgroup_tryget() should succeed at almost all times except
> > a very unlikely race with the memcg deletion path.
> >
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Can you please add your performance experiment setup and result of
> this patch in the commit description of this patch as well?

Sure. I used a small hack to just do a bunch of allocations in a raw
and measured the time. Will include it into the commit message.

Also will fix the #ifdef thing from the second patch, thanks for spotting
it.

> 
> Acked-by: Shakeel Butt <shakeelb@google.com>

Thank you for taking a look!
