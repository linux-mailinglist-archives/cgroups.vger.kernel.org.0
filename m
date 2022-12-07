Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA4645295
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 04:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLGDfn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 6 Dec 2022 22:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLGDfl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 22:35:41 -0500
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 19:35:39 PST
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 494F655A88
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 19:35:38 -0800 (PST)
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH] mm: memcontrol: speedup memory cgroup resize
Thread-Topic: [PATCH] mm: memcontrol: speedup memory cgroup resize
Thread-Index: AQHZCMc63PDt6qwURkexXYPH0DmLLa5gJJ0AgAGMc2A=
Date:   Wed, 7 Dec 2022 02:31:13 +0000
Message-ID: <cf7f485c3e7f4238b509d9dbbd084a2f@baidu.com>
References: <1670240992-28563-1-git-send-email-lirongqing@baidu.com>
 <CALvZod7_1oq1D73EKJHG1zQpeUp+QTPHmMRsL3Ka0f6XUfO4Eg@mail.gmail.com>
 <Y48aaCkgonOlMwNu@dhcp22.suse.cz>
In-Reply-To: <Y48aaCkgonOlMwNu@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.206.14]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2022-12-07 10:31:13:416
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.38
X-FE-Last-Public-Client-IP: 100.100.100.38
X-FE-Policy-ID: 15:10:21:SYSTEM
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> -----Original Message-----
> From: Michal Hocko <mhocko@suse.com>
> Sent: Tuesday, December 6, 2022 6:33 PM
> To: Shakeel Butt <shakeelb@google.com>
> Cc: Li,Rongqing <lirongqing@baidu.com>; linux-mm@kvack.org;
> cgroups@vger.kernel.org; hannes@cmpxchg.org; roman.gushchin@linux.dev;
> songmuchun@bytedance.com; akpm@linux-foundation.org
> Subject: Re: [PATCH] mm: memcontrol: speedup memory cgroup resize
> 
> On Mon 05-12-22 08:32:41, Shakeel Butt wrote:
> > On Mon, Dec 5, 2022 at 3:49 AM <lirongqing@baidu.com> wrote:
> > >
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > when resize memory cgroup, avoid to free memory cgroup page one by
> > > one, and try to free needed number pages once
> > >
> >
> > It's not really one by one but SWAP_CLUSTER_MAX. Also can you share
> > some experiment results on how much this patch is improving setting
> > limits?
> 

If try to resize a cgroup to reclaim 50 Gb memory, and this cgroup has lots of children cgroups who are reading files and alloc memory,  this patch can speed 2 or more times.


> Besides a clear performance gain you should also think about a potential over
> reclaim when the limit is reduced by a lot (there might be parallel reclaimers
> competing with the limit resize).
> 

to avoid over claim,  how about to try to free half memory once?

@@ -3498,7 +3499,11 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
                        continue;
                }

-               if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+               nr_pages = page_counter_read(counter);
+
+               nr_pages = nr_pages > (max + 1) ? (nr_pages - max) / 2 : 1;
+
+               if (!try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
                                        memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
                        ret = -EBUSY;
                        break; thanks

thanks

-Li

