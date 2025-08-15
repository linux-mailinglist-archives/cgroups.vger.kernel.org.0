Return-Path: <cgroups+bounces-9212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF31B27E44
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 12:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA9DA018CE
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAC92FF16D;
	Fri, 15 Aug 2025 10:30:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BF2FE577;
	Fri, 15 Aug 2025 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253800; cv=none; b=G+7uRNyT3vfjrBh9w/GI3lxQvtgB+NKnYg3y5yfKLK0OukGJPBYS0QNCmI/4Yf5g8G8GqhH56eOcnnUT5u48rpC2uoidCSb80Do3Zd3ZQ7o7rJsFYmX2IcK4zUdrhJhawT9xp4sG4GFxc7vQusZjjS8IfSpmk9jL9LZaw6/fal0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253800; c=relaxed/simple;
	bh=iZKENQb+gMHfzeS9WgLCwnds0KbekdZhoEqJ4dQ7GTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CpYWuLwlZsUfXk0nLONrZETQ0NG8cOZM3TD0JUhzCLTYjS84pZawhBSrzYD36zx1m89cpZFTvD0sUjaH7luUAtXTUn8RdesQxF9ARGjYsk4ClkqDffbwraRkPlOXqQNu6I9L/eKYY/KpFKGAWCUxmV5k4lvThWR56iDTETK1/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c3JJk26PbzYQv2c;
	Fri, 15 Aug 2025 18:29:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D4AEC1A0B61;
	Fri, 15 Aug 2025 18:29:56 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCnbg8kDJ9objoKDw--.39452S2;
	Fri, 15 Aug 2025 18:29:56 +0800 (CST)
Message-ID: <05689bcc-6cfb-4acb-9611-bfbf5e128502@huaweicloud.com>
Date: Fri, 15 Aug 2025 18:29:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Remove redundant rcu_read_lock() in
 spin_lock_irq() section
To: lirongqing <lirongqing@baidu.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815091430.8694-1-lirongqing@baidu.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250815091430.8694-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnbg8kDJ9objoKDw--.39452S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr18AF47tr48CFWDtF47Arb_yoWkJrX_Aw
	17Zryqkry2ywnayayvqws3ZrZYg39Yk3Wvq3y7tr47JFy5WF98Jry3tFy5Ar9xZFnaga45
	Z3sxKas2kr1qgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UtR6wUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/15 17:14, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Since spin_lock_irq() already disables preemption and task_css_set()
> is protected by css_set_lock, the rcu_read_lock() calls are unnecessary
> within the critical section. Remove them to simplify the code.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  kernel/cgroup/cgroup.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8..db9e00a 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>  
>  	/* look up all src csets */
>  	spin_lock_irq(&css_set_lock);
> -	rcu_read_lock();
>  	task = leader;
>  	do {
>  		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
>  		if (!threadgroup)
>  			break;
>  	} while_each_thread(leader, task);
> -	rcu_read_unlock();
>  	spin_unlock_irq(&css_set_lock);
>  
>  	/* prepare dst csets and commit */

LGTM

-- 
Best regards,
Ridong


