Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C860C2DDECE
	for <lists+cgroups@lfdr.de>; Fri, 18 Dec 2020 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgLRHDo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 18 Dec 2020 02:03:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9629 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgLRHDn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 18 Dec 2020 02:03:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cy0DF6MKCz15flB;
        Fri, 18 Dec 2020 15:02:21 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by smtp.huawei.com (10.3.19.202)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 18 Dec 2020 15:02:54
 +0800
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
To:     Chen Zhou <chenzhou10@huawei.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <2d76fdf3-7f53-49c7-aa9d-13fa58081193@huawei.com>
Date:   Fri, 18 Dec 2020 15:02:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201218061755.121205-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/12/18 14:17, Chen Zhou wrote:
> When mounting a cgroup hierarchy with disabled controller in cgroup v1,
> all available controllers will be attached.
> 
> Add disabled controller check in cgroup1_parse_param() and return directly
> if the specified controller is disabled.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
> Changes in v2:
> - Fix line over 80 characters warning.
> ---
>  kernel/cgroup/cgroup-v1.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 191c329e482a..5190c42fea8b 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -915,6 +915,9 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		for_each_subsys(ss, i) {
>  			if (strcmp(param->key, ss->legacy_name))
>  				continue;
> +			if (!cgroup_ssid_enabled(i) || cgroup1_ssid_disabled(i))
> +				return invalfc(fc, "Disabled controller '%s'",
> +					       param->key);
>  			ctx->subsys_mask |= (1 << i);
>  			return 0;
>  		}

Reviewed-by: Zefan Li <lizefan@huawei.com>
