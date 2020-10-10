Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272CB289D63
	for <lists+cgroups@lfdr.de>; Sat, 10 Oct 2020 04:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgJJCMK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 9 Oct 2020 22:12:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729749AbgJJB65 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 9 Oct 2020 21:58:57 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id DE0C23B8B24E2CB482DA;
        Sat, 10 Oct 2020 09:58:23 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 10 Oct 2020 09:58:23 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Sat, 10 Oct 2020 09:58:23 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: eliminate redundant check in
 __mem_cgroup_insert_exceeded()
Thread-Topic: [PATCH] mm: memcontrol: eliminate redundant check in
 __mem_cgroup_insert_exceeded()
Thread-Index: AdaeqIsdp2waPEHTskKLt/T+m78yvw==
Date:   Sat, 10 Oct 2020 01:58:23 +0000
Message-ID: <176a5eb5a80d40fdb3fe6e4f460fee08@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> wrote:
> On Fri 09-10-20 09:51:04, Miaohe Lin wrote:
>> The mz->usage_in_excess >= mz_node->usage_in_excess check is exactly 
>> the else case of mz->usage_in_excess < mz_node->usage_in_excess. So we 
>> could replace else if (mz->usage_in_excess >= 
>> mz_node->usage_in_excess) with else equally.
>> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
>Acked-by: Michal Hocko <mhocko@suse.com>
>
>I believe this is a result of a very unreadable code. Resp. the comment makes it hard to follow. It would be slightly better to simply drop the comment which doesn't really explain much IMHO.
>

Agree. Will do it in v2. Many thanks.

