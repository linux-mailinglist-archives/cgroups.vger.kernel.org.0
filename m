Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95CF3E3DD4
	for <lists+cgroups@lfdr.de>; Mon,  9 Aug 2021 03:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhHIB4h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Aug 2021 21:56:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16996 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhHIB4g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Aug 2021 21:56:36 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GjfGt3WBJzZyvg;
        Mon,  9 Aug 2021 09:52:38 +0800 (CST)
Received: from [10.174.179.25] (10.174.179.25) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 09:56:15 +0800
Subject: Re: [PATCH v2 3/3] mm, memcg: get rid of percpu_charge_mutex lock
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <shakeelb@google.com>, <guro@fb.com>,
        <songmuchun@bytedance.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
References: <20210807082835.61281-1-linmiaohe@huawei.com>
 <20210807082835.61281-4-linmiaohe@huawei.com>
 <20210807115625.b09fdf35b0251206b252e19a@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4eb3fd44-a662-7593-d493-e18ce83dead2@huawei.com>
Date:   Mon, 9 Aug 2021 09:56:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210807115625.b09fdf35b0251206b252e19a@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/8/8 2:56, Andrew Morton wrote:
> On Sat, 7 Aug 2021 16:28:35 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> We should get rid of percpu_charge_mutex lock as Johannes Weiner said,
> 
> I'll skip this one for now - it all seems rather uncertain.

Sure, many thanks for doing this.

> .
> 

