Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E0461751
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhK2ODx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 09:03:53 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27314 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhK2OBp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 09:01:45 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J2n4W1fdRzbjD0;
        Mon, 29 Nov 2021 21:58:19 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 21:58:25 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 21:58:24 +0800
Subject: Re: [PATCH 3/4] blk-throtl: introduce blk_throtl_cancel_bios()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20211127101059.477405-1-yukuai3@huawei.com>
 <20211127101059.477405-4-yukuai3@huawei.com> <YaS9v+x2ofp+9jQn@infradead.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6085a86d-ddc8-8d06-e6d6-cee15fb962bc@huawei.com>
Date:   Mon, 29 Nov 2021 21:58:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YaS9v+x2ofp+9jQn@infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/11/29 19:47, Christoph Hellwig wrote:
> On Sat, Nov 27, 2021 at 06:10:58PM +0800, Yu Kuai wrote:
>> This function is used to cancel all throttled bios. Noted this
>> modification is mainly from revertion of commit b77412372b68
>> ("blk-throttle: remove blk_throtl_drain").
> 
> This should also go into the last patch.
> .
> 

I'll merge patch 1,3,4 into one patch,

Thanks,
Kuai
