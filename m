Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16CD26D0EA
	for <lists+cgroups@lfdr.de>; Thu, 17 Sep 2020 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgIQB5U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Wed, 16 Sep 2020 21:57:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgIQB5T (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 16 Sep 2020 21:57:19 -0400
X-Greylist: delayed 937 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:57:18 EDT
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 685C42EE129367064534;
        Thu, 17 Sep 2020 09:41:38 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 17 Sep 2020 09:41:38 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 17 Sep 2020 09:41:37 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: correct the comment of
 mem_cgroup_unmark_under_oom()
Thread-Topic: [PATCH] mm: memcontrol: correct the comment of
 mem_cgroup_unmark_under_oom()
Thread-Index: AdaMk2onBuSUvuaupEiH3Zos6miJVQ==
Date:   Thu, 17 Sep 2020 01:41:37 +0000
Message-ID: <e192943774324dc6af20095c0e274dbf@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> wrote:
> On Wed 16-09-20 09:19:27, Miaohe Lin wrote:
>> Since commit fb2a6fc56be6 ("mm: memcg: rework and document OOM waiting 
>> and wakeup"), we have renamed mem_cgroup_oom_lock to 
>> mem_cgroup_oom_trylock. So replace mem_cgroup_oom_lock with mem_cgroup_oom_trylock in comment.
>
>While you are right I find the comment more confusing then helpful.
>What does it try to tell us actually? Is it still valid? Shouldn't we rather remove it or make it more clear?
>> 

It seems this comment no long make sense. Many thanks for your nice advise.

