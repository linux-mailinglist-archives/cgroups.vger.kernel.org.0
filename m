Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD6B5441AA
	for <lists+cgroups@lfdr.de>; Thu,  9 Jun 2022 04:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiFICyL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 22:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiFICyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 22:54:04 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FC41A7D24;
        Wed,  8 Jun 2022 19:53:50 -0700 (PDT)
Date:   Wed, 8 Jun 2022 19:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654743229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=liHmTBtyJ9J2SmbRAamKC6TDE1854irD6g+yxKU90Rg=;
        b=Zewa/ikGSBOIhVlHKnzCYGIZRO7S1NDsj/t9KqNUA1RDrdSxf5B0jNigzCKcfzgGlz4VHB
        5fXAmKGHvfNVQcJYP9UgReR+ypsq/ZXZJr5Q3jDsVINJO7iIqShxfwgSixK19rEiPfXV7G
        pySvDgNd5zNfe6UqcMm9i2Nf4sj4LnM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YqFgt6nZn78euEb/@carbon>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <CAMZfGtX4hseDnJA9JrsXDG=nu28h+9UMMpKFnBZCL47Re1OvUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX4hseDnJA9JrsXDG=nu28h+9UMMpKFnBZCL47Re1OvUg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 09, 2022 at 10:43:24AM +0800, Muchun Song wrote:
> Hi,
> 
> Friendly ping. Any comments or objections?

I'm sorry, I was recently busy with some other stuff, but it's on my todo list.
I'll try to find some time by the end of the week.

Thanks!

> 
> Thanks.
> 
> On Mon, May 30, 2022 at 3:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > This version is rebased on v5.18.
> >
> > Since the following patchsets applied. All the kernel memory are charged
> > with the new APIs of obj_cgroup.
> >
> >         [v17,00/19] The new cgroup slab memory controller [1]
> >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages [2]

Btw, both these patchsets were merged a long time ago, so you can refer
to upstream commits instead.
