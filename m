Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A162DA97B
	for <lists+cgroups@lfdr.de>; Tue, 15 Dec 2020 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLOIvA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Dec 2020 03:51:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9530 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgLOIvA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Dec 2020 03:51:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CwBlS1TywzhshF;
        Tue, 15 Dec 2020 16:49:40 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by smtp.huawei.com (10.3.19.202)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 15 Dec 2020 16:50:07
 +0800
Subject: Re: [PATCH v2] cgroup: Fix memory leak when parsing multiple source
 parameters
To:     Qinglang Miao <miaoqinglang@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201209121322.77665-1-miaoqinglang@huawei.com>
 <20201210012943.92845-1-miaoqinglang@huawei.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <eb369eb1-5e2a-9f19-019f-c101adb8f4f5@huawei.com>
Date:   Tue, 15 Dec 2020 16:50:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201210012943.92845-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(didn't notice you've sent v2 with the printk msg fixed)

On 2020/12/10 9:29, Qinglang Miao wrote:
> A memory leak is found in cgroup1_parse_param() when multiple source
> parameters overwrite fc->source in the fs_context struct without free.
> 
> unreferenced object 0xffff888100d930e0 (size 16):
>   comm "mount", pid 520, jiffies 4303326831 (age 152.783s)
>   hex dump (first 16 bytes):
>     74 65 73 74 6c 65 61 6b 00 00 00 00 00 00 00 00  testleak........
>   backtrace:
>     [<000000003e5023ec>] kmemdup_nul+0x2d/0xa0
>     [<00000000377dbdaa>] vfs_parse_fs_string+0xc0/0x150
>     [<00000000cb2b4882>] generic_parse_monolithic+0x15a/0x1d0
>     [<000000000f750198>] path_mount+0xee1/0x1820
>     [<0000000004756de2>] do_mount+0xea/0x100
>     [<0000000094cafb0a>] __x64_sys_mount+0x14b/0x1f0
> 
> Fix this bug by permitting a single source parameter and rejecting with
> an error all subsequent ones.
> 
> Fixes: 8d2451f4994f ("cgroup1: switch to option-by-option parsing")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  v1->v2: fix compile problems caused by superfluous LF in err message.
>  kernel/cgroup/cgroup-v1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 191c329e4..32596fdbc 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -908,6 +908,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	opt = fs_parse(fc, cgroup1_fs_parameters, param, &result);
>  	if (opt == -ENOPARAM) {
>  		if (strcmp(param->key, "source") == 0) {
> +			if (fc->source)
> +				return invalf(fc, "Multiple sources not supported");

Reviewed-by: Zefan Li <lizefan@huawei.com>
