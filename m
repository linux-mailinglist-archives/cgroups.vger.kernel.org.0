Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4449D81C
	for <lists+cgroups@lfdr.de>; Thu, 27 Jan 2022 03:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiA0Cgm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 21:36:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35875 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiA0Cgl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 21:36:41 -0500
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jkl7n11TGzccmW;
        Thu, 27 Jan 2022 10:35:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 10:36:39 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 10:36:38 +0800
Subject: Re: [PATCH -next] blk-throttle: enable io throttle for root in cgroup
 v2
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220114093000.3323470-1-yukuai3@huawei.com>
 <YfGE9L4i7DtNTo08@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <235b0757-d322-2b6e-3ab6-ecc8c82f8f1e@huawei.com>
Date:   Thu, 27 Jan 2022 10:36:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YfGE9L4i7DtNTo08@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/01/27 1:29, Tejun Heo Ð´µÀ:
> On Fri, Jan 14, 2022 at 05:30:00PM +0800, Yu Kuai wrote:
>> RFC patch: https://lkml.org/lkml/2021/9/9/1432
>>
>> There is a proformance problem in our environment:
>>
>> A host can provide a remote device to difierent client. If one client is
>> under high io pressure, other clients might be affected.
>>
>> Limit the overall iops/bps(io.max) from the client can fix the problem,
>> however, config files do not exist in root cgroup currently, which makes
>> it impossible.
>>
>> This patch enables io throttle for root cgroup:
>>   - enable "io.max" and "io.low" in root
>>   - don't skip root group in tg_iops_limit() and tg_bps_limit()
>>   - don't skip root group in tg_conf_updated()
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Yeah, I'm kinda split. It's a simple change with some utility, but it's also
> something which doesn't fit with the cgroup feature or interface. It's
> regulating the whole system behavior. There's no reason for any of the
> control "groups" to be involved here and semantically the interface would
> fit a lot better under /proc, /sys or some other system-wide location. Here
> are some points to consider:
> 
> * As a comparison, it'd be rather absurd to enable memory.max at system root
>    in terms of interface and most likely break whole lot of mm operations.
> 
> * Resource control knobs of a cgroup belong to the parent as the parent is
>    responsible for divvying up the available resources to its children. Here
>    too, the knobs are making sense because there's a higher level parent
>    (whether that's hypervisor or some network server).
> 
> Is your use case VMs or network attached storage?
> 
Hi,

In our case, the disk is provided by server, and such disk can be shared
by multipul clients. Thus for the client side, the server is a higher
level parent.

Theoretically, limit the io from server for each client is feasible,
however, the main reason we don't want to do this is the following
shortcoming:

client can still send io to server unlimited, we can just limit the
amount of io that can complete from server, which might cause too much
pressure on the server side.

Thanks,
Kuai
