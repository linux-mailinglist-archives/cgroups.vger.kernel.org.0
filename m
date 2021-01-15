Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41702F773C
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbhAOLKK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 06:10:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11545 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbhAOLKK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 06:10:10 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHJLw1C7KzMK1l;
        Fri, 15 Jan 2021 19:08:08 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 19:09:23 +0800
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
 <YABDWvI2PWQpnv59@blackbook>
 <d4ba14b0-ee06-b793-a840-2c2ff369d890@huawei.com>
 <YAB3Wuu+hFpN698N@blackbook>
 <7804658e-7644-8edb-5ca8-0c97389c8c62@huawei.com>
 <YAFpt6aYW4nVQoZf@blackbook>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <4abe04f8-e7a9-ab2e-f5d1-bb569e2dc157@huawei.com>
Date:   Fri, 15 Jan 2021 19:09:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YAFpt6aYW4nVQoZf@blackbook>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On 2021/1/15 18:08, Michal Koutný wrote:
> On Fri, Jan 15, 2021 at 09:55:43AM +0800, chenzhou <chenzhou10@huawei.com> wrote:
>> Yeah, this will select all enabled controllers, but which doesn't the behavior we want.
> I see what the issue is now.
>
>> See above. Just the mount behavior isn't what we what.
> I agree this a bug and your I find your approach correct
>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
I have sent the v3, which updates the description and add Fixes. 
[v3]: https://lore.kernel.org/patchwork/patch/1365535/
If it is ok for you to add Reviewed-by there.

Thanks,
Chen Zhou
>
>> The behavior was changed since commit f5dfb5315d34 ("cgroup: take
>> options parsing into ->parse_monolithic()"), will add this as Fixes.
> Thanks.
>
> Michal

