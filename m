Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F172D27DDCC
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 03:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgI3Be2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 29 Sep 2020 21:34:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3535 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgI3Be2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 29 Sep 2020 21:34:28 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 6C77C6E78A2F08F9E911;
        Wed, 30 Sep 2020 09:34:26 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 30 Sep 2020 09:34:25 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 30 Sep 2020 09:34:26 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memcontrol: remove obsolete comment of
 mem_cgroup_unmark_under_oom()
Thread-Topic: [PATCH v2] mm: memcontrol: remove obsolete comment of
 mem_cgroup_unmark_under_oom()
Thread-Index: AdaWyYPX/CSq6v+NO0CRyyk8/6/gYg==
Date:   Wed, 30 Sep 2020 01:34:25 +0000
Message-ID: <7d1ea112d8a740cab555eaf7be530286@huawei.com>
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
> On Thu 17-09-20 06:59:00, Miaohe Lin wrote:
>> Since commit 79dfdaccd1d5 ("memcg: make oom_lock 0 and 1 based rather 
>> than counter"), the mem_cgroup_unmark_under_oom() is added and the 
>> comment of the mem_cgroup_oom_unlock() is moved here. But this comment 
>> make no sense here because mem_cgroup_oom_lock() does not operate on under_oom field.
>
>OK, so I've looked into this more deeply and I finally remember why we have this comment here. The point is that under_oom shouldn't underflow and that we have to explicitly check for > 0 because a new child memcg could have been added between mem_cgroup_mark_under_oom and mem_cgroup_unmark_under_oom.
>
>So the comment makes sense although it is not as helpful as it could be.
>I think that changing it to the following will be more usefule
>
>	/*
>	 * Be careful about under_oom underflows becase a child memcg
>	 * could have neem added after mem_cgroup_mark_under_oom

Should it be s/neem/been/ ?

>	 */

Many thanks for detailed explanation. Will fix it in v2. Thanks again.

