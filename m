Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCFC5366AD
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiE0Rr7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiE0Rr6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 13:47:58 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21717A88;
        Fri, 27 May 2022 10:47:56 -0700 (PDT)
Date:   Fri, 27 May 2022 10:47:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653673673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyZxhrFIbciyaIa9/uGSSo/bdh7XAme4AdSjV5SMRRg=;
        b=ZqRzG1adM/lY8etIuMIydjIQZ2VDwDQ5EbKSiqF0cCHyjgI7PSsx0GyLAGXqymvqrQRzFy
        m6d0oBpA7fhs0ygGeSr6RnfWTd1tWH9vTAM0+lt4j3iZs9fDLjDmE6+9DdMx46FFB12loF
        fpzD0JKuyQ8nOhyDo8hiz7eW4QtIg5s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH] XArray: handle XA_FLAGS_ACCOUNT in xas_split_alloc
Message-ID: <YpEOwrBe2UzJZr9E@carbon>
References: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org>
 <YpAnqqY/c3Y5ZkPG@casper.infradead.org>
 <CALvZod7iyO5Ti5xhzq36UjDFNAmfEyPk1MQv_t4kUHKuPCeNng@mail.gmail.com>
 <d4e81087-d057-4edb-5df0-47d99a1c72d9@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4e81087-d057-4edb-5df0-47d99a1c72d9@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 27, 2022 at 02:22:19PM +0300, Vasily Averin wrote:
> On 5/27/22 04:40, Shakeel Butt wrote:
> > On Thu, May 26, 2022 at 6:21 PM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Wed, May 25, 2022 at 11:26:37AM +0300, Vasily Averin wrote:
> >>> Commit 7b785645e8f1 ("mm: fix page cache convergence regression")
> >>> added support of new XA_FLAGS_ACCOUNT flag into all Xarray allocation
> >>> functions. Later commit 8fc75643c5e1 ("XArray: add xas_split")
> >>> introduced xas_split_alloc() but missed about XA_FLAGS_ACCOUNT
> >>> processing.
> >>
> >> Thanks, Vasily.
> >>
> >> Johannes, Shakeel, is this right?  I don't fully understand the accounting
> >> stuff.
> >>
> > 
> > If called from __filemap_add_folio() then this is correct.
> > 
> > However from split_huge_page_to_list(), we can not use the memcg from
> > current as that codepath is called from reclaim which can be triggered
> > by processes of other memcgs.
> Btw, Shakeel, Johannes,
> I would like to understand, when Xarray should use XA_FLAGS_ACCOUNT ?
> 
> From my point of view, this should be useless:
> a) if Xarray stores some index (idr?) - his memory is quite small,
> and his accounting can be ignored.
> b) if Xarray stores some accounted - the size of the corresponding Xarray
> infrastructure is usually significantly smaller than the size of the stored object,
> sо his accounting can be skipped too.
> c) if Xarray stores some non-accounted objects - it makes no sense to account 
> corresponding Xarray infrastructure. In case of necessary it makes much more sense
> to enable accounting for stored objects (and return to case b).
> 
> Am I missed something important perhaps?
> 
> I looked for the description of 7b785645e8f1, but o be honest I'm still not sure
> that I understand correctly why XA_FLAGS_ACCOUNT flag solved the described problem.
> 
> Could you please explain this in more details?
> 
> Was it because the non-accounted Xarray kept a reference to the stored object
> and thus prevents it from being reclaimed?
> 
> If so, was it some special case, or should it affect all such cases,
> and my b) statement above is not correct?


It's all about shadow entries, which are small, so b) is not true for them.
There is a good description on how it works on top of mm/workingset.c
