Return-Path: <cgroups+bounces-15302-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC3oLuXi3mklMAAAu9opvQ
	(envelope-from <cgroups+bounces-15302-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 02:59:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D873FF69C
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 02:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFEEE305C8FA
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2E23EAB4;
	Wed, 15 Apr 2026 00:48:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459087080D;
	Wed, 15 Apr 2026 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214096; cv=none; b=IDEYEtRpSYMnh904fYh7FAALvcV2aFMWzYu1/s/TGXdWu4nRqkPc/5ZJVXqHGzo0EtzDJ8Zbszx/FiTbT8aovG4lb13JsqM/LapJAMs1/be4bZSNI/JiWUU+7Cc+WkIjkIC2BmUOEq/ZPRIS15SP6gfr96fJqsqkSORTXYS3HS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214096; c=relaxed/simple;
	bh=U07JHgEMr46+58Phc9mmtHw8ZNgNaV07zILe7RI1nOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXsX+fCFJvA+wyqb3TYwkZJ+MVpmpC2jFcvtNJDrNKnh3JuX3Ksk/gQzONT6Gk8p+bx+BFOY1PTfe6Zw7z1YXFHrbt0n5/pDg84DBcVFAI3dFjHmDtYbPM4COXaIbwqTojzsOTGSxY/6M56x3YjMTVInWxOe5QlcdjZXQuwfelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fwMtN4Z0yzYQtlN;
	Wed, 15 Apr 2026 08:47:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CA5C84058D;
	Wed, 15 Apr 2026 08:48:09 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDnlL5G4N5p19DBAQ--.21997S2;
	Wed, 15 Apr 2026 08:48:07 +0800 (CST)
Message-ID: <a0bf7a4d-19f8-4b7c-835d-6d8fd0db3d3c@huaweicloud.com>
Date: Wed, 15 Apr 2026 08:48:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sched/psi: fix race between file release and pressure
 write
To: Edward Adam Davis <eadavis@qq.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, mkoutny@suse.com,
 syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <tencent_4ED99363237E896983BEC4571777B767C605@qq.com>
 <tencent_FBCECE887BCA6C3C2CE96E5896C8E9AEEE0A@qq.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <tencent_FBCECE887BCA6C3C2CE96E5896C8E9AEEE0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDnlL5G4N5p19DBAQ--.21997S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr13Xw1rCr15tr4rtr1UKFg_yoWxXry7pF
	90y34ft3s5GryDJw40qa409F1fC3ySqrW5Xws7Jr1fAw1aqr1vgr129r1jq348CFn3ArsI
	qFs0yrWUKw1jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15302-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[qq.com];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid,huaweicloud.com:email,qq.com:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 12D873FF69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/14 14:15, Edward Adam Davis wrote:
> A potential race condition exists between pressure write and cgroup file
> release regarding the priv member of struct kernfs_open_file, which
> triggers the uaf reported in [1].
> 
> Consider the following scenario involving execution on two separate CPUs:
> 
>    CPU0					CPU1
>    ====					====
> 					vfs_rmdir()
> 					kernfs_iop_rmdir()
> 					cgroup_rmdir()
> 					cgroup_kn_lock_live()
> 					cgroup_destroy_locked()
> 					cgroup_addrm_files()
> 					cgroup_rm_file()
> 					kernfs_remove_by_name()
> 					kernfs_remove_by_name_ns()
>  vfs_write()				__kernfs_remove()
>  new_sync_write()			kernfs_drain()
>  kernfs_fop_write_iter()		kernfs_drain_open_files()
>  cgroup_file_write()			kernfs_release_file()
>  pressure_write()			cgroup_file_release()
>  ctx = of->priv;
> 					kfree(ctx);
>  					of->priv = NULL;
> 					cgroup_kn_unlock()
>  cgroup_kn_lock_live()
>  cgroup_get(cgrp)
>  cgroup_kn_unlock()
>  if (ctx->psi.trigger)  // here, trigger uaf for ctx, that is of->priv
> 
> The cgroup_rmdir() is protected by the cgroup_mutex, it also safeguards
> the memory deallocation of of->priv performed within cgroup_file_release().
> However, the operations involving of->priv executed within pressure_write()
> are not entirely covered by the protection of cgroup_mutex. Consequently,
> if the code in pressure_write(), specifically the section handling the
> ctx variable executes after cgroup_file_release() has completed, a uaf
> vulnerability involving of->priv is triggered.
> 
> Therefore, the issue can be resolved by extending the scope of the
> cgroup_mutex lock within pressure_write() to encompass all code paths
> involving of->priv, thereby properly synchronizing the race condition
> occurring between cgroup_file_release() and pressure_write().
> 
> And, if an live kn lock can be successfully acquired while executing
> the pressure write operation, it indicates that the cgroup deletion
> process has not yet reached its final stage; consequently, the priv
> pointer within open_file cannot be NULL. Therefore, the operation to
> retrieve the ctx value must be moved to a point *after* the live kn
> lock has been successfully acquired.
> 
> In another situation, specifically after entering cgroup_kn_lock_live()
> but before acquiring cgroup_mutex, there exists a different class of
> race condition:
> 
> CPU0: write memory.pressure               CPU1: write cgroup.pressure=0
> ===========================		  =============================
> 
> kernfs_fop_write_iter()
>  kernfs_get_active_of(of)
>  pressure_write()
>    cgroup_kn_lock_live(memory.pressure)
>      cgroup_tryget(cgrp)
>      kernfs_break_active_protection(kn)
>      ... blocks on cgroup_mutex
> 
>                                      	  cgroup_pressure_write()
>                                      	  cgroup_kn_lock_live(cgroup.pressure)
>                                      	  cgroup_file_show(memory.pressure, false)
>                                      	    kernfs_show(false)
>                                      	      kernfs_drain_open_files()
>                                      	        cgroup_file_release(of)
>                                      	          kfree(ctx)
>                                      	            of->priv = NULL
>                                      	  cgroup_kn_unlock()
> 
>    ... acquires cgroup_mutex
>    ctx = of->priv;        // may now be NULL
>    if (ctx->psi.trigger)  // NULL dereference
> 
> Consequently, there is a possibility that of->priv is NULL, the pressure
> write needs to check for this.
> 
> Now that the scope of the cgroup_mutex has been expanded, the original
> explicit cgroup_get/put operations are no longer necessary, this is
> because acquiring/releasing the live kn lock inherently executes a
> cgroup get/put operation. 
> 
> [1]
> BUG: KASAN: slab-use-after-free in pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
> Call Trace:
>  pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
>  cgroup_file_write+0x36f/0x790 kernel/cgroup/cgroup.c:4311
>  kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
> 
> Allocated by task 9352:
>  cgroup_file_open+0x90/0x3a0 kernel/cgroup/cgroup.c:4256
>  kernfs_fop_open+0x9eb/0xcb0 fs/kernfs/file.c:724
>  do_dentry_open+0x83d/0x13e0 fs/open.c:949
> 
> Freed by task 9353:
>  cgroup_file_release+0xd6/0x100 kernel/cgroup/cgroup.c:4283
>  kernfs_release_file fs/kernfs/file.c:764 [inline]
>  kernfs_drain_open_files+0x392/0x720 fs/kernfs/file.c:834
>  kernfs_drain+0x470/0x600 fs/kernfs/dir.c:525
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Reported-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=33e571025d88efd1312c
> Tested-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> v1 -> v2: refactor unlock and update comments
> v2 -> v3: remove check for !ctx and update comments
> v3 -> v4: remove orig get/put for get cgroup refcnt and update comments
> v4 -> v5: check !ctx
> 
>  kernel/cgroup/cgroup.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 4ca3cb993da2..4366fd62eb3d 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3995,33 +3995,41 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
>  static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
>  			      size_t nbytes, enum psi_res res)
>  {
> -	struct cgroup_file_ctx *ctx = of->priv;
> +	struct cgroup_file_ctx *ctx;
>  	struct psi_trigger *new;
>  	struct cgroup *cgrp;
>  	struct psi_group *psi;
> +	ssize_t ret = 0;
>  
>  	cgrp = cgroup_kn_lock_live(of->kn, false);
>  	if (!cgrp)
>  		return -ENODEV;
>  
> -	cgroup_get(cgrp);
> -	cgroup_kn_unlock(of->kn);
> +	ctx = of->priv;
> +	if (!ctx) {
> +		ret = -ENODEV;
> +		goto out_unlock;
> +	}
>  
>  	/* Allow only one trigger per file descriptor */
>  	if (ctx->psi.trigger) {
> -		cgroup_put(cgrp);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out_unlock;
>  	}
>  
>  	psi = cgroup_psi(cgrp);
>  	new = psi_trigger_create(psi, buf, res, of->file, of);
>  	if (IS_ERR(new)) {
> -		cgroup_put(cgrp);
> -		return PTR_ERR(new);
> +		ret = PTR_ERR(new);
> +		goto out_unlock;
>  	}
>  
>  	smp_store_release(&ctx->psi.trigger, new);
> -	cgroup_put(cgrp);
> +
> +out_unlock:
> +	cgroup_kn_unlock(of->kn);
> +	if (ret)
> +		return ret;
>  
>  	return nbytes;
>  }

LGTM.

Thanks.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


