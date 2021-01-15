Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47A2F72A6
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 06:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbhAOF7I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 00:59:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10724 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAOF7H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 00:59:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DH9S171rYzl3sR;
        Fri, 15 Jan 2021 13:57:05 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:58:20 +0800
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
To:     Tejun Heo <tj@kernel.org>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
 <YABDWvI2PWQpnv59@blackbook>
 <d4ba14b0-ee06-b793-a840-2c2ff369d890@huawei.com>
 <YAB3Wuu+hFpN698N@blackbook>
 <7804658e-7644-8edb-5ca8-0c97389c8c62@huawei.com>
 <YAEJPs4DJIgAXWul@mtj.duckdns.org>
CC:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <c4e62492-4b12-c516-3c17-77d18f3ddfe2@huawei.com>
Date:   Fri, 15 Jan 2021 13:58:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YAEJPs4DJIgAXWul@mtj.duckdns.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2021/1/15 11:17, Tejun Heo wrote:
> Hello,
>
> On Fri, Jan 15, 2021 at 09:55:43AM +0800, chenzhou wrote:
>> Yeah, this will select all enabled controllers, but which doesn't the behavior we want.
>> I think the case should return error with information "Disabled controller xx" rather than
>> attaching all the other enabled controllers.
>>
>> For example, boot with cgroup_no_v1=cpu, and then mount with
>> "mount -t cgroup -o cpu cpu /sys/fs/cgroup/cpu", then all enabled controllers will
>> be attached expect cpu.
> Okay, that explanation actually makes sense. Can you please update the
> description to include what's broken and how it's being fixed? It really
> isn't clear what the patch is trying to achieve from the current
> description.
Ok, will update the description.
>
> Thanks.
>

