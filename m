Return-Path: <cgroups+bounces-8832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359BFB0D7F9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 13:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132FA1AA5225
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F1288C33;
	Tue, 22 Jul 2025 11:14:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68FDDC3;
	Tue, 22 Jul 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182850; cv=none; b=blK2lKBxTHE/DkGK5GR2Sp/ufeupldaP5E+ZRLG8WQb3f1pZVa42ZrSZYo49YcmsDR+dUuEIXMouXxQh5EMzxZnuqJmKs10Ieb7OQX6HfHAJ8nqZxD6Zo6gw8ryOgXbk2iNtztMEbPjuaP+72c/ju168Q12xZ6bpWt39i93ZK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182850; c=relaxed/simple;
	bh=cj2sZHrXw6UcTDsmYxotfixJ9xFcJBEAMHb+X6xmpPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tRYzOrvAh6LBugjWiw/Wla0c9O2VbPcHhhvKtGnJMgUtgnre/I0hbF910zXZkqcjGNyN7o3cR934VA6qA9KJEFYVQB/o7i/OWC8w07sy8JK9lCpZWoDxZ8n9HQaPgarac3WPBaqDcNLGtPKRF482R1FW0PcBYTC4rWLzQac0WN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmZQh5bGCzKHMdl;
	Tue, 22 Jul 2025 19:14:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7D5481A1905;
	Tue, 22 Jul 2025 19:14:03 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBXyLN6cn9otuxaBA--.37742S2;
	Tue, 22 Jul 2025 19:14:03 +0800 (CST)
Message-ID: <be35ab6e-6670-414c-ab3b-c86a690c6cef@huaweicloud.com>
Date: Tue, 22 Jul 2025 19:14:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: remove offline draining in root destruction
 to avoid hung_tasks
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, lizefan@huawei.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, gaoyingjie@uniontech.com
References: <20250722092444.4108989-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250722092444.4108989-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXyLN6cn9otuxaBA--.37742S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZryrJFyUXFyrtFWxWFyrtFb_yoW5CFykpF
	s5Cw1jya1rGF90g3yvya4vga4F9a10q3yUt342qw48Ar17G342q3W0yr1jqF1UAFsrC3y2
	yFZ0vrn7C34jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/22 17:24, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A hung task can occur during LTP cgroup testing when repeatedly
> mounting/unmounting perf_event and net_prio controllers with
> systemd.unified_cgroup_hierarchy=1. The hang manifests in
> cgroup_lock_and_drain_offline() during root destruction.
> 
> Call Trace:
> 	cgroup_lock_and_drain_offline+0x14c/0x1e8
> 	cgroup_destroy_root+0x3c/0x2c0
> 	css_free_rwork_fn+0x248/0x338
> 	process_one_work+0x16c/0x3b8
> 	worker_thread+0x22c/0x3b0
> 	kthread+0xec/0x100
> 	ret_from_fork+0x10/0x20
> 
> Root Cause:
> 
> CPU0                            CPU1
> mount perf_event                umount net_prio
> cgroup1_get_tree                cgroup_kill_sb
> rebind_subsystems               // root destruction enqueues
> 				// cgroup_destroy_wq
> // kill all perf_event css
>                                 // one perf_event css A is dying
>                                 // css A offline enqueues cgroup_destroy_wq
>                                 // root destruction will be executed first
>                                 css_free_rwork_fn
>                                 cgroup_destroy_root
>                                 cgroup_lock_and_drain_offline
>                                 // some perf descendants are dying
>                                 // cgroup_destroy_wq max_active = 1
>                                 // waiting for css A to die
> 
> Problem scenario:
> 1. CPU0 mounts perf_event (rebind_subsystems)
> 2. CPU1 unmounts net_prio (cgroup_kill_sb), queuing root destruction work
> 3. A dying perf_event CSS gets queued for offline after root destruction
> 4. Root destruction waits for offline completion, but offline work is
>    blocked behind root destruction in cgroup_destroy_wq (max_active=1)
> 
> Solution:
> Move cgroup_lock_and_drain_offline() to the start of unmount operations.
> This ensures:
> 1. cgroup_lock_and_drain_offline() will not be called within
>    cgroup_destroy_wq context.
> 2. No new dying csses for the subsystem being unmounted can appear in
>    cgrp_dfl_root between unmount start and subsystem rebinding.
> 
> Fixes: 334c3679ec4b ("cgroup: reimplement rebind_subsystems() using cgroup_apply_control() and friends")
> Reported-by: Gao Yingjie <gaoyingjie@uniontech.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..7a71410b350e 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1346,8 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
>  
>  	trace_cgroup_destroy_root(root);
>  
> -	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
> -
> +	cgroup_lock();
>  	BUG_ON(atomic_read(&root->nr_cgrps));
>  	BUG_ON(!list_empty(&cgrp->self.children));
>  
> @@ -2336,6 +2335,7 @@ static void cgroup_kill_sb(struct super_block *sb)
>  	 *
>  	 * And don't kill the default root.
>  	 */
> +	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
>  	if (list_empty(&root->cgrp.self.children) && root != &cgrp_dfl_root &&
>  	    !percpu_ref_is_dying(&root->cgrp.self.refcnt))
>  		percpu_ref_kill(&root->cgrp.self.refcnt);

Sorry, this is a mistake, I will send the new one.

Best regards,
Ridong


