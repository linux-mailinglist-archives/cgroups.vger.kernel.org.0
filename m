Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8026E107
	for <lists+cgroups@lfdr.de>; Thu, 17 Sep 2020 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgIQQpJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 12:45:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56160 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgIQQoq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 12:44:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HGZ1pH019065;
        Thu, 17 Sep 2020 16:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=IbwTUuS7WDD96m5NCI9svM+4U/lOcHyrB4uP9uxzxr8=;
 b=GGE9vmsGoRqBb0l8dT/2oKizlmK1s/LXNokj3OyhnXeKCCgUxCSt/DKaTmIL+b60WOHJ
 TFl6JP4IqBWWyHkHzkNk33pJkoBO8o/lWuYxk8Vk7sV2iGmCj+0dKqKfthcLGLzSgv/C
 CDLU4rXyDplrzeoZwGkLtV6crE5BpX55fepx6NDcq/SBc/UKxYlu6SoTrI02I2HvOsCG
 UwQucFJ4w/7hO4NUg7bWKj2pcoUE+7RHwKetgC2NV4U9YqFx7HlQwg5SGIz7+NYi9S1Z
 wvPLxyBZ6gr/Vqa0nn921uvtENU8uZZ8vxtLxh4sa/n7XKir6DIoDN4YPqx7nVeN9cuf mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9mje1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 16:39:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HGZvNl067229;
        Thu, 17 Sep 2020 16:39:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm355hng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 16:39:15 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08HGd9K6008649;
        Thu, 17 Sep 2020 16:39:10 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 16:39:09 +0000
Date:   Thu, 17 Sep 2020 12:48:12 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
Message-ID: <20200917164812.y6bstuo6zvxklcjc@ca-dmjordan1.us.oracle.com>
References: <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009091524260.10087@eggly.anvils>
 <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com>
 <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
 <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
 <alpine.LSU.2.11.2009150112130.1550@eggly.anvils>
 <20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com>
 <c3362c0a-3707-3a3d-9955-960d95f3ad8c@linux.alibaba.com>
 <20200917143519.lhdfnoc47qrmbhaz@ca-dmjordan1.us.oracle.com>
 <CAKgT0Ud8sYidvxtyrN3AFLs+-DiW7cuPGrKknaRicQsC8PLRtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Ud8sYidvxtyrN3AFLs+-DiW7cuPGrKknaRicQsC8PLRtg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170126
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 17, 2020 at 08:39:34AM -0700, Alexander Duyck wrote:
> On Thu, Sep 17, 2020 at 7:26 AM Daniel Jordan
> <daniel.m.jordan@oracle.com> wrote:
> >
> > On Thu, Sep 17, 2020 at 10:37:45AM +0800, Alex Shi wrote:
> > > 在 2020/9/16 上午12:58, Daniel Jordan 写道:
> > > > On Tue, Sep 15, 2020 at 01:21:56AM -0700, Hugh Dickins wrote:
> > > >> On Sun, 13 Sep 2020, Alex Shi wrote:
> > > >>> Uh, I updated the testing with some new results here:
> > > >>> https://lkml.org/lkml/2020/8/26/212
> > > >> Right, I missed that, that's better, thanks.  Any other test results?
> > > > Alex, you were doing some will-it-scale runs earlier.  Are you planning to do
> > > > more of those?  Otherwise I can add them in.
> > >
> > > Hi Daniel,
> > >
> > > Does compaction perf scalable, like thpscale, I except they could get some benefit.
> >
> > Yep, I plan to stress compaction.  Reclaim as well.
> >
> > I should have said which Alex I meant.  I was asking Alex Duyck since he'd done
> > some will-it-scale runs.
> 
> I probably won't be able to do any will-it-scale runs any time soon.
> If I recall I ran them for this latest v18 patch set and didn't see
> any regressions like I did with the previous set. However the system I
> was using is tied up for other purposes and it may be awhile before I
> can free it up to look into this again.

Ok, sure.  I hadn't seen the regressions were taken case of, that's good to
hear.  Might still add them to my testing for v19 and beyond, we'll see.
