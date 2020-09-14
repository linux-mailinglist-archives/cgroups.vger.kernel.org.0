Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35B26899E
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 12:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgINKwU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Mon, 14 Sep 2020 06:52:20 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgINKwS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Sep 2020 06:52:18 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id E3541B09D03FB53F19A6;
        Mon, 14 Sep 2020 18:52:08 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Sep 2020 18:52:08 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 14 Sep 2020 18:52:08 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: Correct the comment of mem_cgroup_iter()
Thread-Topic: [PATCH] mm: memcontrol: Correct the comment of mem_cgroup_iter()
Thread-Index: AdaKhMdsNXkljfsnS0iGZsDMVBs4Kw==
Date:   Mon, 14 Sep 2020 10:52:08 +0000
Message-ID: <2bcb502990ae44a19ff8b047117758fc@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> wrote:
> On Sun 13-09-20 05:41:29, Miaohe Lin wrote:
>> Since commit bbec2e15170a ("mm: rename page_counter's count/limit into 
>> usage/max"), the arg @reclaim has no priority field anymore.
>
>The priority field has been removed by 9da83f3fc74b ("mm, memcg: clean up reclaim iter array")
>> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
>Other than that
>Acked-by: Michal Hocko <mhocko@suse.com>
>
Many thanks for your ack. I have resend the one yesterday:
https://lkml.org/lkml/2020/9/13/69

>
>> ---
>>  mm/memcontrol.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
