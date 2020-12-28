Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E482E3484
	for <lists+cgroups@lfdr.de>; Mon, 28 Dec 2020 07:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgL1Gcj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Dec 2020 01:32:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10000 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgL1Gcj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Dec 2020 01:32:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D473c51vpzj0HC;
        Mon, 28 Dec 2020 14:31:08 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by smtp.huawei.com (10.3.19.212)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 28 Dec 2020 14:31:52
 +0800
Subject: Re: [PATCH] cpuset: Remove stale URLs in the MAINTAINERS entry
To:     Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>
References: <42668f2c-5ea1-da38-918e-ac4c86e3f03d@huawei.com>
 <2822d565280536f36ea6ddd521a7716813ef85a2.camel@perches.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <39449cc4-15bf-4570-2bbd-dd47ea73b86c@huawei.com>
Date:   Mon, 28 Dec 2020 14:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2822d565280536f36ea6ddd521a7716813ef85a2.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/12/28 14:01, Joe Perches wrote:
> On Mon, 2020-12-28 at 11:17 +0800, Zefan Li wrote:
>> Those URLs are no longer accessable.
>>
>> Reported-by: Steve Wahl <steve.wahl@hpe.com>
>> Signed-off-by: Zefan Li <lizefan@huawei.com>
>> ---
>>  MAINTAINERS | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ae9b1dd748c4..2fe8eb54639e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4477,8 +4477,6 @@ CONTROL GROUP - CPUSET
>>  M:	Li Zefan <lizefan@huawei.com>
>>  L:	cgroups@vger.kernel.org
>>  S:	Maintained
>> -W:	http://www.bullopensource.org/cpuset/
>> -W:	http://oss.sgi.com/projects/cpusets/
> 
> The general argument to avoid removal of these no longer valid links
> is that they may still be available from archive.org.
> 
> For instance:
> 
> https://web.archive.org/web/20170512010721/http://oss.sgi.com/projects/cpusets/
> 
> It may be appropriate to copy the content into a local Documentation
> file somewhere to avoid the need to lookup old reference links.
> 

I don't think the contents in those links provide valuable information about cpusets.
We have documents in Documentation/admin-guide/cgroup/ and man cpuset(7). So I think
we can just remove them.
