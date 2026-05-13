Return-Path: <cgroups+bounces-15872-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAZoDGwgBGpyEAIAu9opvQ
	(envelope-from <cgroups+bounces-15872-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 08:55:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277E52E4C1
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 08:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7A343066341
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EDD3D5643;
	Wed, 13 May 2026 06:55:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32A3D34A6;
	Wed, 13 May 2026 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655334; cv=none; b=V3f1CAhtd4zJEaxoIg5UNvNf4JItNt3Ski0ERI8TY6rukoWivNPo74x85+DuzyNOUek0HzTzG8oDr1Ny1l7IVHZDAGqlM3UEyy3pdXf78B2E+C8E0SCAZfOYyhXiK4Qui7VBpV4lIA74HwMkDF58NvvnqAzkQgAmlQrL0AoK+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655334; c=relaxed/simple;
	bh=F+D1G5+pA5Cs14eGcAGHMzAkqd3Wp9MmrVyh14r8T7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEiYSwmgMiZ79zInLNjLyd8Tys+r2pGl8A/TMWWKgouOiuG/c9DZ1/3otbxVJy7H9HdbHCans1J/hOdZJV5aXKPI9Nu+TMX2yWob91LovZLJ3P4WCxbFvz2UyaE1mx4vUkjZKsIFMCZlF/yF4LAQgK1uedqiOAF/hP9WoHU/M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gFkjV4cWKzYQtGN;
	Wed, 13 May 2026 14:54:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AABF04056E;
	Wed, 13 May 2026 14:55:26 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgBHpCxdIARqhipbCA--.5456S2;
	Wed, 13 May 2026 14:55:26 +0800 (CST)
Message-ID: <2bcc3436-b928-4a6d-be73-d22735e972ec@huaweicloud.com>
Date: Wed, 13 May 2026 14:55:25 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Return only actually allocated CPUs during
 partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512090034.183133-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260512090034.183133-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHpCxdIARqhipbCA--.5456S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWDJryxAFW7XF1DCr13twb_yoWrGw4kpF
	y8K343Z3yYqr18C39rKanF9F1Yga1DZ3W7tws8Wr1rAFy7J3WvkF1jqa9Iv3yUW398Gry5
	Za9I9r4aqa4DAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 8277E52E4C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-15872-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 2026/5/12 17:00, Sun Shaojie wrote:
> From: sunshaojie <sunshaojie@kylinos.cn>
> 
> In update_parent_effective_cpumask() with partcmd_invalidate, the CPUs
> to return to the parent are computed as:
> 
>     adding = cpumask_and(tmp->addmask, xcpus, parent->effective_xcpus);
> 
> where xcpus = user_xcpus(cs) which returns cs->exclusive_cpus (if set)
> or cs->cpus_allowed. When exclusive_cpus is not set, user_xcpus(cs) can
> contain CPUs that were never actually granted to the partition due to
> sibling exclusion in compute_excpus(). Consequently, the invalidation
> may return CPUs to the parent that remain in use by sibling partitions,
> causing overlapping effective_cpus and triggering the
> WARN_ON_ONCE(1) in generate_sched_domains().
> 
> Use cs->effective_xcpus instead, which reflects the CPUs actually
> granted to this partition.
> 
> Reproducer (on a 4-CPU machine):
> 
>     cd /sys/fs/cgroup
>     mkdir a1 b1
> 
>     # a1 becomes partition root with CPUs 0-1
>     echo "0-1" > a1/cpuset.cpus
>     echo "root" > a1/cpuset.cpus.partition
> 
>     # b1 becomes partition root with CPUs 1-2, but sibling exclusion
>     # reduces its effective_xcpus to CPU 2 only
>     echo "1-2" > b1/cpuset.cpus
>     echo "root" > b1/cpuset.cpus.partition
> 
>     # b1 changes cpus_allowed to 0-1 -> partition invalidation
>     echo "0-1" > b1/cpuset.cpus
> 
>     # Expected: CPUs 2-3  (only CPU 2 returned from b1)
>     # Actual:   CPUs 1-3  (CPU 0-1 returned, overlapping with a1)
>     cat cpuset.cpus.effective
> 

Thank you for providing the reproducer. I was able to reproduce the issue.

#cd /sys/fs/cgroup
#mkdir a1 b1
#
#echo "0-1" > a1/cpuset.cpus
#echo "root" > a1/cpuset.cpus.partition
#echo "1-2" > b1/cpuset.cpus
#echo "root" > b1/cpuset.cpus.partition
#echo "0-1" > b1/cpuset.cpus
#cat cpuset.cpus.effective
1-3


 WARNING: kernel/cgroup/cpuset.c:867 at
rebuild_sched_domains_locked+0x32c/0x510, CPU#3: bash/540
 Modules linked in:
 CPU: 3 UID: 0 PID: 540 Comm: bash Not tainted 7.1.0-rc2-next-20260508 #1122
PREEMPT(full)
 Call Trace:
  <TASK>
  ? kfree+0x1fb/0x540
  ? update_cpumasks_hier+0x34d/0xa30
  cpuset_update_sd_hk_unlock+0x7b/0x90
  cpuset_write_resmask+0x3f0/0xc70
  kernfs_fop_write_iter+0x14c/0x200
  vfs_write+0x362/0x510
  ksys_write+0x6b/0xe0
  do_syscall_64+0xba/0x5a0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

And this patch can fix this issue.

> dmesg will also show a WARNING from generate_sched_domains() reporting
> overlapping partition root effective_cpus.
> 
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: sunshaojie <sunshaojie@kylinos.cn>

I think the Fixes tag should point to commit 2a3602030d80 ("cgroup/cpuset: Don't
invalidate sibling partitions on cpuset.cpus conflict"). Before this commit, the
issue should not have been reproducible, since a1/b1 would have been invalidated
if they were in conflict. No warning is observed in dmesg when resetting to
commit 7cc1720589d8 ("cpuset: remove v1-specific code from generate_sched_domains").

Other than that, the patch looks good to me.

Test-by: Chen Ridong <chenridong@huaweicloud.com>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

> ---
>  kernel/cgroup/cpuset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..2311470ef077 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1715,7 +1715,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  		 */
>  		if (is_partition_valid(parent))
>  			adding = cpumask_and(tmp->addmask,
> -					     xcpus, parent->effective_xcpus);
> +					     cs->effective_xcpus,
> +					     parent->effective_xcpus);
>  		if (old_prs > 0)
>  			new_prs = -old_prs;
>  

-- 
Best regards,
Ridong


