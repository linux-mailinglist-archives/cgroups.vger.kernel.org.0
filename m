Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7872F7040
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 02:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbhAOB4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 20:56:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10723 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbhAOB43 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 20:56:29 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DH4444R7pzl5Kw;
        Fri, 15 Jan 2021 09:54:28 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 09:55:44 +0800
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
 <YABDWvI2PWQpnv59@blackbook>
 <d4ba14b0-ee06-b793-a840-2c2ff369d890@huawei.com>
 <YAB3Wuu+hFpN698N@blackbook>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <7804658e-7644-8edb-5ca8-0c97389c8c62@huawei.com>
Date:   Fri, 15 Jan 2021 09:55:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YAB3Wuu+hFpN698N@blackbook>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2021/1/15 0:54, Michal Koutný wrote:
> On Thu, Jan 14, 2021 at 10:08:19PM +0800, chenzhou <chenzhou10@huawei.com> wrote:
>> In this case, at the beginning of function check_cgroupfs_options(), the mask
>> ctx->subsys_mask will be 0. And if we mount without 'none' and 'name=' options,
>> then in check_cgroupfs_options(), the flag ctx->all_ss will be set, that is, select all the subsystems.
> But even then, the line
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/cgroup/cgroup-v1.c?h=v5.11-rc3#n1012
> would select only 'enabled' controllers, wouldn't it?
Yeah, this will select all enabled controllers, but which doesn't the behavior we want.
I think the case should return error with information "Disabled controller xx" rather than
attaching all the other enabled controllers.

For example, boot with cgroup_no_v1=cpu, and then mount with
"mount -t cgroup -o cpu cpu /sys/fs/cgroup/cpu", then all enabled controllers will
be attached expect cpu.
>
> It's possible I missed something but if this means that cgroup_no_v1=
> doesn't hold to its expectations, I'd suggest adding proper Fixes: tag
> to the patch.
See above. Just the mount behavior isn't what we what.
The behavior was changed since commit f5dfb5315d34 ("cgroup: take options parsing into ->parse_monolithic()"),
will add this as Fixes.

Thanks,
Chen Zhou
>
> Thanks,
> Michal

