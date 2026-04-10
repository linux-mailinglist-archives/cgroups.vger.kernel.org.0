Return-Path: <cgroups+bounces-15205-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK0oD1m82GlVhggAu9opvQ
	(envelope-from <cgroups+bounces-15205-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 11:01:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47F3D4721
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3611300FECF
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688A3A3E91;
	Fri, 10 Apr 2026 09:01:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542F312825;
	Fri, 10 Apr 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811663; cv=none; b=DelU3/VNj/X0rGSFCpJU/1+iUZe9C3LjgPOvgBLyc79sZXm5SBvrY0rqOIUsPf6eqsjjeXqCNT+pvaGj8khShzkTaYm06BsPy5RjH7xUkqtONTxf/v9rh827DvLVaEjQIW4x8mTdHJYVMpugzSjxqtinqNMH1wUKIn1sF9g7DOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811663; c=relaxed/simple;
	bh=9mIcLPFdYKzGJwF4zsIY3WaeNUW220YKf8A+RathnRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrB4bSNexgqWWDoWb7h+WJIA+D9M06usnZXlajwx1FUUHO5qezg3pZTsEvca1dAbQb5mKYS+6EAJBfbwXBiN/1+v1DgXRbiTfIsk/iDHXTCbgCG/2PZVwn4WGRZEUpxIhPoQZ5nmrbBa/DOaJHypSJrptY3I0ElLEmdIrusNDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsW4841rfzKHMTW;
	Fri, 10 Apr 2026 17:00:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E8514058C;
	Fri, 10 Apr 2026 17:00:58 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3kEtHvNhpOyhXEA--.45047S2;
	Fri, 10 Apr 2026 17:00:57 +0800 (CST)
Message-ID: <dde2339e-fd2d-448c-9f2c-d852571b67de@huaweicloud.com>
Date: Fri, 10 Apr 2026 17:00:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/psi: fix race between file release and pressure
 write
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, mkoutny@suse.com,
 syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <69d779b0.a00a0220.468cb.0018.GAE@google.com>
 <tencent_304A97FC36264BDE745777E366603C8F3709@qq.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <tencent_304A97FC36264BDE745777E366603C8F3709@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3kEtHvNhpOyhXEA--.45047S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15GrW5Jw4xAw47Aw1kZrb_yoW5Xw4UpF
	90y3y5A345CF1DJrW0v3409F1fKa1fXrWaq397Xr1xAw12qr1jqw129r1UWry0yF93Cw4D
	tFn0vrW5Kw10qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[qq.com:server fail,appspotmail.com:server fail,sea.lore.kernel.org:server fail,syzkaller.appspot.com:server fail,huaweicloud.com:server fail];
	TAGGED_FROM(0.00)[bounces-15205-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[qq.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: ED47F3D4721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/10 12:00, Edward Adam Davis wrote:
> A potential race condition exists between pressure write and cgroup file
> release regarding the priv member of struct kernfs_open_file, which
> triggers the uaf reported in [1].
> 
> The scope of the cgroup_mutex protection in pressure write has been
> expanded to prevent the uaf described in [1].
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
>  kernel/cgroup/cgroup.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Hi Edward,

Thank you for fixing this issue. The patch looks plausible, but the root cause
is not entirely clear from the diff alone. Could you please add more details to
the commit message explaining how the issue occurs and why this change resolves it?

Thanks.

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 4ca3cb993da2..c0cfe91c2991 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4005,11 +4005,11 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
>  		return -ENODEV;
>  
>  	cgroup_get(cgrp);
> -	cgroup_kn_unlock(of->kn);
>  
>  	/* Allow only one trigger per file descriptor */
>  	if (ctx->psi.trigger) {
>  		cgroup_put(cgrp);
> +		cgroup_kn_unlock(of->kn);
>  		return -EBUSY;
>  	}
>  
> @@ -4017,12 +4017,14 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
>  	new = psi_trigger_create(psi, buf, res, of->file, of);
>  	if (IS_ERR(new)) {
>  		cgroup_put(cgrp);
> +		cgroup_kn_unlock(of->kn);
>  		return PTR_ERR(new);
>  	}
>  
>  	smp_store_release(&ctx->psi.trigger, new);
>  	cgroup_put(cgrp);
>  
> +	cgroup_kn_unlock(of->kn);
>  	return nbytes;
>  }
>  

-- 
Best regards,
Ridong


