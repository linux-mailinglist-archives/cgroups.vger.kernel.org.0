Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560012F62BC
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 15:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbhANOKR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 09:10:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10968 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbhANOKR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 09:10:17 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DGmNP1M54zhwcc;
        Thu, 14 Jan 2021 22:07:33 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 22:08:20 +0800
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
 <YABDWvI2PWQpnv59@blackbook>
CC:     <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <d4ba14b0-ee06-b793-a840-2c2ff369d890@huawei.com>
Date:   Thu, 14 Jan 2021 22:08:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YABDWvI2PWQpnv59@blackbook>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On 2021/1/14 21:12, Michal Koutný wrote:
> Hello Chen.
>
> On Fri, Dec 18, 2020 at 02:17:55PM +0800, Chen Zhou <chenzhou10@huawei.com> wrote:
>> When mounting a cgroup hierarchy with disabled controller in cgroup v1,
>> all available controllers will be attached.
> Not sure if I understand the situation -- have you observed a v1
> controller attached to a hierarchy while specifying cgroup_no_v1= kernel
> cmdline arg?
Yeah, this is the situation.
In this case, at the beginning of function check_cgroupfs_options(), the mask
ctx->subsys_mask will be 0. And if we mount without 'none' and 'name=' options,
then in check_cgroupfs_options(), the flag ctx->all_ss will be set, that is, select all the subsystems.

Thanks,
Chen Zhou
>
> AFAICS, the disabled controllers are honored thanks to
> check_cgroupfs_options().
>
> Michal

