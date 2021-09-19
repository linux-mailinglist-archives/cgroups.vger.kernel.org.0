Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974D8410B25
	for <lists+cgroups@lfdr.de>; Sun, 19 Sep 2021 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhISKdI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Sep 2021 06:33:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9895 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhISKdI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Sep 2021 06:33:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HC3ld73fSz8yRT;
        Sun, 19 Sep 2021 18:27:09 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Sun, 19 Sep 2021 18:31:39 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sun, 19 Sep 2021 18:31:39 +0800
Subject: Re: [RFC PATCH] blk-throttle: enable io throttle for root in cgroup
 v2
To:     Khazhy Kumykov <khazhy@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210909140815.2600858-1-yukuai3@huawei.com>
 <20210917174103.GC13346@blackbody.suse.cz>
 <CACGdZYJiLuh6kED_tdWkYqbHDXc_18m-XJbevp-ri5ansvbtYg@mail.gmail.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <37f8c687-8549-104a-2501-532a0cfc9a48@huawei.com>
Date:   Sun, 19 Sep 2021 18:31:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYJiLuh6kED_tdWkYqbHDXc_18m-XJbevp-ri5ansvbtYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/09/18 3:58, Khazhy Kumykov wrote:
> On Fri, Sep 17, 2021 at 10:41 AM Michal Koutný <mkoutny@suse.com> wrote:
>>
>> Hello Yu.
>>
>> On Thu, Sep 09, 2021 at 10:08:15PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>>> I'm not sure why this feature is disabled in the first place, is
>>> there any problem or design constraint?
>>
>> The idea for v2 is that in the root cgroup remain only kernel threads that
>> provide "global" services and any user workload that should be
>> constrained is put into non-root cgroups. Additionally, if kernel
>> threads carry out work associated with a cgroup they can charge it to
>> the respective cgroup.
>>
>> [snip]
>>> We want to limit the overall iops/bps of the device in cgroup v2,
>>
>> Cui bono? (I mean what is the reason for throttling on the global level
>> when there's no other entity utiliting the residual?
>> <joke>Your drives are too fast?</joke>)
> 
> We'd be interested in something like this as well. (at least for
> io.max). Our use case is providing remote devices which are a shared
> resource. A "global" throttle like this (which is set by a local

Our use case is similair to this, a host can provide several remote
devices to difierent client. If one client is under high io pressure,
other client might be affected. Thus we want to limit the overall
iops/bps from the client.

Thanks,
Kuai

> management daemon) allows for throttling before sending network
> traffic. It's also useful since we can put this throttle on a dm, so
> we can enforce an aggregate throttle without needing backchannels to
> coordinate multiple targets.
> (This does also bring up: if this is a useful thing, would it make
> sense to tie to the device, vs. requiring cgroup. We happen to use
> cgroups so that requirement doesn't affect us).
> 
> Khazhy
>>
>> Michal
