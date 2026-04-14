Return-Path: <cgroups+bounces-15281-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGHrL4+m3WnchQkAu9opvQ
	(envelope-from <cgroups+bounces-15281-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 04:29:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C78653F50A2
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 04:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72ACC300BE9C
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 02:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9611E3002CF;
	Tue, 14 Apr 2026 02:29:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FC26ED37;
	Tue, 14 Apr 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133768; cv=none; b=Of/jUFZc7STRiiH+AuzAjoJWA5RBjeqzNwXczdjgSJNEhX3vfG7IUexaYafX+9rOQ+Mxi+JzcNogPiR1izpE5KtzepOsVtJ/Q4YMnA6zgyYGuFkdUrTGDiT5xeLWVkTFcKPPSxpWw+imKdyaa2Oh9BgZa30godg+o6ht5V8jA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133768; c=relaxed/simple;
	bh=dAQL1BzfrvROk9KRMrk9tZAXqiuq5cr+VS4Qqak3YCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWFqaD8ex5KlT0Yx2LNOFUueK4Zc5HEbTrO2C85IVoq3zPJ1Y2eTRnbXrUYBbpoTLxAA38FO6sGA3ZeId0AL7DoZxx24VYZgMJfL2+DyPsJDGgheg2JnAdN7Vpnas+C4BoWK2F9wE6rQhGpHGs0Oyqjm2ZaFCikmmHWE+yArpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fvp9g32tSzYQtlH;
	Tue, 14 Apr 2026 10:28:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0A24D40590;
	Tue, 14 Apr 2026 10:29:23 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgD32W6Apt1peClUAQ--.34910S2;
	Tue, 14 Apr 2026 10:29:21 +0800 (CST)
Message-ID: <febf75a0-5fc7-4fad-b43b-3c4bc2543531@huaweicloud.com>
Date: Tue, 14 Apr 2026 10:29:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/psi: fix race between file release and pressure
 write
To: Edward Adam Davis <eadavis@qq.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, mkoutny@suse.com,
 syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <tencent_71D4D2F5C6460999EEE5AEC14C8767C74606@qq.com>
 <tencent_47844C97747762E6DA1374E37BA96283A205@qq.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <tencent_47844C97747762E6DA1374E37BA96283A205@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD32W6Apt1peClUAQ--.34910S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr13Xw1rCr15tr4rtr1UKFg_yoW7Kw4fpF
	90y34ft3s8GryDJr48ta409F1fGw4xXFW3Xws7Jr1fAw1aqr1vgr129r1jq348CFn3AFsF
	qF4YyrWUKw1jvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15281-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_TO(0.00)[qq.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qq.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: C78653F50A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/13 10:44, Edward Adam Davis wrote:
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
> And, if an active kn lock can be successfully acquired while executing
> the pressure write operation, it indicates that the cgroup deletion
> process has not yet reached its final stage; consequently, the priv
> pointer within open_file cannot be NULL. Therefore, the operation to
> retrieve the ctx value must be moved to a point *after* the active kn
> lock has been successfully acquired.
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
> 
>  kernel/cgroup/cgroup.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 4ca3cb993da2..c94a16352c33 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3995,33 +3995,38 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
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
> +	/* of->priv can not be NULL, because cgroup is CSS_ONLINE */
> +	ctx = of->priv;
>  
>  	/* Allow only one trigger per file descriptor */
>  	if (ctx->psi.trigger) {
> -		cgroup_put(cgrp);
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out_unlock;
>  	}
>  

CPU0: write memory.pressure               CPU1: write cgroup.pressure=0
  ==================================       ==================================

  kernfs_fop_write_iter()
    kernfs_get_active_of(of)
    pressure_write()
      cgroup_kn_lock_live(memory.pressure)
        cgroup_tryget(cgrp)
        kernfs_break_active_protection(kn)
        ... blocks on cgroup_mutex

                                        cgroup_pressure_write()
                                        cgroup_kn_lock_live(cgroup.pressure)
                                        cgroup_file_show(memory.pressure, false)
                                          kernfs_show(false)
                                            kernfs_drain_open_files()
                                              cgroup_file_release(of)
                                                kfree(ctx)
                                                  of->priv = NULL
                                        cgroup_kn_unlock()

      ... acquires cgroup_mutex
      ctx = of->priv;        // may now be NULL
      if (ctx->psi.trigger)  // NULL dereference

IIUC, for rmdir, 'of->priv cannot be NULL' may be true, but for the other patch
shown above, it might not be.

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

-- 
Best regards,
Ridong


