Return-Path: <cgroups+bounces-4214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A194FB23
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 03:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C080F1C210F3
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4B7494;
	Tue, 13 Aug 2024 01:35:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B66FC5;
	Tue, 13 Aug 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512913; cv=none; b=Pj29Z6YHLy8L0VKisEWQebnWs9LkNYIzOOce7Enw+YfxqNnIqRTjdpklMZ2A9q5Wh/oSPXaCL/h4414V120n7u9pWXi65qvrfbRlzehE6uJMl6RawA8qf4RiWxauw1b4uS9MpDqR3Suoeuw708ED/1Z633cuy2jcMLrCCYtvgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512913; c=relaxed/simple;
	bh=vq5JGnkPBY+PGy9/5tulWVSiltIbGn5LlSF/PLadaD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgYMVWtO6mf48VIT3BugwZ/YVelVy3ZKKFqCz4aCfszdpMODqX0DGDGe7envCQn+9vAvH0d6AyrwLK8Bv+f5hbDoWKPNOZJXhWT7KNB4nN907Rv69M5yWJYBnw7zgpLPkLVTP9sQ63jHbpuWokCzDR8yiCRM0dYX8ANxDv/TTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjYpg4MRmz4f3kv7;
	Tue, 13 Aug 2024 09:34:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 41C041A1795;
	Tue, 13 Aug 2024 09:35:06 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP2 (Coremail) with SMTP id Syh0CgCHvr1IuLpmn38gBg--.32573S2;
	Tue, 13 Aug 2024 09:35:06 +0800 (CST)
Message-ID: <557dea21-c119-4fbf-90f7-fe755b56f6ef@huaweicloud.com>
Date: Tue, 13 Aug 2024 09:35:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 2/2] cgroup: Disallow delegatee to write all
 interfaces outsize of cgroup ns
Content-Language: en-US
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812073746.3070616-1-chenridong@huawei.com>
 <20240812073746.3070616-3-chenridong@huawei.com>
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <20240812073746.3070616-3-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHvr1IuLpmn38gBg--.32573S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyxZFyrKw4rWr43ArWrKrg_yoW8Kw1DpF
	WvyryxJ398Xrn8AF4Yqay0gw4fWFs3XF1UtayDW3yxJr1agr18Kryjk343Xa1UZF4xCryj
	vFZ0yrWjkr1UtwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/



On 2024/8/12 15:37, Chen Ridong wrote:
> The delegatee shouldn't be allowed to write to the resource control
> interface files. The kernel rejects writes to all files other than
> "cgroup.procs", "cgroup.threads" and "cgroup.subtree_control" on a
> namespace root from inside the namespace. However, delegatee can write
> "cgroup.subtree_control" outsize of the namespace, this can be reproduced
> by as follows:
> 
> cd /sys/fs/cgroup
> echo '+pids' > cgroup.subtree_control
> mkdir dlgt_grp_ns
> echo '+pids' > dlgt_grp_ns/cgroup.subtree_control
> mkdir dlgt_grp_ns/dlgt_grp_ns1
> echo $$ > dlgt_grp_ns/dlgt_grp_ns1/cgroup.procs
> echo 200 > dlgt_grp_ns/dlgt_grp_ns1/pids.max
> unshare -Cm /bin/bash
> echo max > dlgt_grp_ns/dlgt_grp_ns1/pids.max // Permission denied
> echo -pids > dlgt_grp_ns/cgroup.subtree_control // pids was unlimited now
> 
> We set pids.max to 200 in the cgroup dlgt_grp_ns1, and we created a new
> cgroup namespace. The delegatee can't write to
> dlgt_grp_ns/dlgt_grp_ns1/pids.max. However, delegatee can write to
> dlgt_grp_ns/cgroup.subtree_control, which is outside of the cgroup
> namespace, and this invalided the pids limitation.
> 
> Cgroup namespaces, as delegation boundaries, should disallow the delegatee
> to write all interfaces outside of the cgroup namespace.
> 
> Fixes: 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 8dbe00000fd4..1ef9413c02e3 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4134,8 +4134,10 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
>  	 * cgroup.procs, cgroup.threads and cgroup.subtree_control.
>  	 */
>  	if ((cgrp->root->flags & CGRP_ROOT_NS_DELEGATE) &&
> -	    !(cft->flags & CFTYPE_NS_DELEGATABLE) &&
> -	    ctx->ns != &init_cgroup_ns && ctx->ns->root_cset->dfl_cgrp == cgrp)
> +		ctx->ns != &init_cgroup_ns &&
> +		(!cgroup_is_descendant(cgrp, ctx->ns->root_cset->dfl_cgrp) ||
> +			(!(cft->flags & CFTYPE_NS_DELEGATABLE) &&
> +			ctx->ns->root_cset->dfl_cgrp == cgrp)))

Can you please match the indentation?
Thanks.

>  		return -EPERM;
>  
>  	if (cft->write)


