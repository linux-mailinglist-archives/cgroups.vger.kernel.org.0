Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D059A3DB0CE
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 03:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhG3BuV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 21:50:21 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13213 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhG3BuU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 21:50:20 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GbVYr64VTz1CPJN;
        Fri, 30 Jul 2021 09:44:16 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 09:50:14 +0800
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <guro@fb.com>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com>
 <YQKyn8bKRblCDuND@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d174dcca-aad4-0534-4d6a-767e01dafd8b@huawei.com>
Date:   Fri, 30 Jul 2021 09:50:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YQKyn8bKRblCDuND@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/7/29 21:52, Matthew Wilcox wrote:
> On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
>> rtpn might be NULL in very rare case. We have better to check it before
>> dereferencing it. Since memcg can live with NULL rb_tree_per_node in
>> soft_limit_tree, warn this case and continue.
> 
> Why would we need to warn?  the GFP flags don't contain NOWARN, so
> we already know an allocation failed.

I see. Will remove it. Many thanks!

> .
> 

