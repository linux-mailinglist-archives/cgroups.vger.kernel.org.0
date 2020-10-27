Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9074829A247
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 02:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503997AbgJ0BmS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 21:42:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4573 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503996AbgJ0BmR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 21:42:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKvb00DGXzhc5D;
        Tue, 27 Oct 2020 09:42:20 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 09:42:09 +0800
Subject: Re: [PATCH] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
To:     Tejun Heo <tj@kernel.org>
References: <20201012102757.83192-1-chenzhou10@huawei.com>
 <20201026134711.GB73258@mtj.duckdns.org>
CC:     <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <yangyingliang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <eb5092f1-1f88-5ca3-360e-da0816a42407@huawei.com>
Date:   Tue, 27 Oct 2020 09:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201026134711.GB73258@mtj.duckdns.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2020/10/26 21:47, Tejun Heo wrote:
> On Mon, Oct 12, 2020 at 06:27:57PM +0800, Chen Zhou wrote:
>> When mounting a cgroup hierarchy with disabled controller in cgroup v1,
>> all available controllers will be attached.
>>
>> Add disabled controller check in cgroup1_parse_param() and return directly
>> if the specified controller is disabled.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> check_cgroupfs_options() is already checking the condition. How does also
> checking in parse_param() help?

Hi Tejun,

Function check_cgroupfs_options() don't check if the mounted controller is disabled.
It just gets the enabled controllers firstly, and then do & opteration with the mounted
controller. If the result is NULL, just select all the enabled controllers.

This patch check if the specified controller of mount is disabled, and return
"Disabled controller xx" error if true.

Thanks,
Chen Zhou
>
> Thanks.
>

