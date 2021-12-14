Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC2473D0D
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 07:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhLNGPZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 01:15:25 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:17932 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229630AbhLNGPZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 01:15:25 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.141])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id B8367D80B9E0B;
        Tue, 14 Dec 2021 14:13:19 +0800 (CST)
Received: from [172.24.140.37] (172.24.140.37) by BJSGEXMBX11.didichuxing.com
 (172.20.15.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 14:13:19 +0800
Message-ID: <21e7bb02-1d02-21f2-159d-71ca6529bb66@didichuxing.com>
Date:   Tue, 14 Dec 2021 14:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RESEND PATCH RFC] cgroup: support numabalancing disable in
 cgroup level
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>, <tj@kernel.org>
CC:     <bristot@redhat.com>, <bsegall@google.com>,
        <cgroups@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <hannes@cmpxchg.org>, <jameshongleiwang@126.com>,
        <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <lizefan.x@bytedance.com>, <mgorman@suse.de>, <mingo@redhat.com>,
        <peterz@infradead.org>, <rostedt@goodmis.org>,
        <vincent.guittot@linaro.org>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.141
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <a6aa93b2-cb28-6d79-10ef-7b18bae11231@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.140.37]
X-ClientProxiedBy: BJEXCAS04.didichuxing.com (172.20.36.192) To
 BJSGEXMBX11.didichuxing.com (172.20.15.141)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2021/12/14 10:50, Gang Li wrote:
> Hi,
> How about my per-process numa balancning patch;)
> 
> https://lore.kernel.org/all/20211206024530.11336-1-ligang.bdlg@bytedance.com/ 
>
Thanks, I believe both patches are base on the same reason. I did a 
quick search after reading tejun's message. Seems numactl with 
interleave option helps on the case, you can have a test to see if it's 
what you want.

Thanks,
Honglei
