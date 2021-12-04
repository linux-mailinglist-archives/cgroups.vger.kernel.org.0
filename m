Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9479F46834C
	for <lists+cgroups@lfdr.de>; Sat,  4 Dec 2021 09:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbhLDIHW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Dec 2021 03:07:22 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29087 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354766AbhLDIHW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Dec 2021 03:07:22 -0500
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J5hw54n6Rz1DJl2;
        Sat,  4 Dec 2021 16:01:09 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 16:03:54 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 16:03:54 +0800
Subject: Re: [PATCH v4 2/2] block: cancel all throttled bios in del_gendisk()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <hch@infradead.org>, <tj@kernel.org>, <axboe@kernel.dk>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20211202130440.1943847-1-yukuai3@huawei.com>
 <20211202130440.1943847-3-yukuai3@huawei.com>
 <20211202144818.GB16798@blackbody.suse.cz>
 <95825098-a532-a0e4-9ed0-0b5f2a0e5f04@huawei.com>
 <20211203102739.GB64349@blackbody.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c8a16fe9-4ad2-682d-0d34-1049dc217d62@huawei.com>
Date:   Sat, 4 Dec 2021 16:03:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211203102739.GB64349@blackbody.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2021/12/03 18:27, Michal Koutný 写道:
> On Fri, Dec 03, 2021 at 03:50:01PM +0800, "yukuai (C)" <yukuai3@huawei.com> wrote:
>> blkg_destroy() is protected by the queue_lock，so I think queue_lock can
>> protect such concurrent scenario.
> 
> blkg_destroy() is not as destroying :-) as actual free, you should
> synchronize against (the queue_lock ensures this for
> pd_free_fn=throtl_pd_free but you may still trip on blkcg after
> blkcg_css_free()).

Hi, Michal

I was thinking that if there are active blkgs, holding queue_lock will 
ensure blkcg won't be freed. However, if there are no active blkgs in
the first place, it seems right rcu_read_lock() can prevent this
iteration concurrent with css_release->css_release_work_fn->
css_free_rwork_fn.

By the way, does spin_lock can guarantee this since it disables preempt
like what rcu_read_lock() does?

Thanks,
Kuai

> 
> [Actually, I think you should see a warning in your situation if you
> enable CONFIG_PROVE_RCU.]
> 
> HTH,
> Michal
> 
