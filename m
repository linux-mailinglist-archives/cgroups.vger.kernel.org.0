Return-Path: <cgroups+bounces-12182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A697C82F4E
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 01:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE283A3949
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 00:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82761DB54C;
	Tue, 25 Nov 2025 00:50:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F572631;
	Tue, 25 Nov 2025 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031818; cv=none; b=FJQqR53oEC8EYwyDqD0APEyolGDdmcBZIDMvQoleuGyhMb4T7Qez4r8SBcD1Pnuxv+OwV+K0nSiLL6m2xsS2RM3eu9bBz9VUW7chPfCCh1rNXvOpiEl6g5FVZCWTDh+Td+ooz/0z85Kcpp3zqZjbnqiUq4wWXpDetQfrvBwsWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031818; c=relaxed/simple;
	bh=Gljfu2M+nxI7lRXNC09U1YtjnkntKqF8eZ1HhHNAZWQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qb6Nm0qkb+++ODLl6A4u5ofA+/tmjdBtRs/aw9Ri6nV8wFN3anpeSrB3VRU0OZNgre5rFhMZRBy1tKRlz4DDW0iJ6pa8oHNA/WOJj21Hqyth50qQCnHXXwIZtZ0SAz5sEvazsMXkLI9f5MAPNIIs50AMswm8FfnsuZMB+B8wP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dFkbl2PftzYQtLr;
	Tue, 25 Nov 2025 08:49:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B41CA1A018D;
	Tue, 25 Nov 2025 08:50:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3YV5E_SRpLryqBw--.29731S2;
	Tue, 25 Nov 2025 08:50:12 +0800 (CST)
Message-ID: <cf773eb0-bba4-4865-a562-3c5d13d1dfc3@huaweicloud.com>
Date: Tue, 25 Nov 2025 08:50:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.m.jordan@oracle.com, lujialin4@huawei.com, chenridong@huawei.com
References: <20251118083643.1363020-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251118083643.1363020-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3YV5E_SRpLryqBw--.29731S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUtw4kWr4rZrW5WF4Uurg_yoW5XFWkpF
	Z5Gay7Z3y5Kr1UC39xta9rZryF9a1DJanrt3ZxWr18AFy7A3Wvkryjk3W3XryUur9xCw1U
	AFn09wsxWFnFyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/18 16:36, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Commit 406100f3da08 ("cpuset: fix race between hotplug work and later CPU
> offline")added a check for empty effective_cpus in partitions for cgroup
> v2. However, thischeck did not account for remote partitions, which were
> introduced later.
> 
> After commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug processing
> synchronous"),cgroup v2's cpuset hotplug handling is now synchronous. This
> eliminates the race condition with subsequent CPU offline operations that
> the original check aimed to fix.
> 
> Instead of extending the check to support remote partitions, this patch
> removes the redundant partition effective_cpus check. Additionally, it adds
> a check and warningto verify that all generated sched domains consist of
> active CPUs, preventing partition_sched_domains from being invoked with
> offline CPUs.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index daf813386260..1ac58e3f26b4 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
>   */
>  void rebuild_sched_domains_locked(void)
>  {
> -	struct cgroup_subsys_state *pos_css;
>  	struct sched_domain_attr *attr;
>  	cpumask_var_t *doms;
> -	struct cpuset *cs;
>  	int ndoms;
> +	int i;
>  
>  	lockdep_assert_cpus_held();
>  	lockdep_assert_held(&cpuset_mutex);
> @@ -1107,30 +1106,14 @@ void rebuild_sched_domains_locked(void)
>  	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>  		return;
>  
> -	/*
> -	 * With subpartition CPUs, however, the effective CPUs of a partition
> -	 * root should be only a subset of the active CPUs.  Since a CPU in any
> -	 * partition root could be offlined, all must be checked.
> -	 */
> -	if (!cpumask_empty(subpartitions_cpus)) {
> -		rcu_read_lock();
> -		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> -			if (!is_partition_valid(cs)) {
> -				pos_css = css_rightmost_descendant(pos_css);
> -				continue;
> -			}
> -			if (!cpumask_subset(cs->effective_cpus,
> -					    cpu_active_mask)) {
> -				rcu_read_unlock();
> -				return;
> -			}
> -		}
> -		rcu_read_unlock();
> -	}
> -
>  	/* Generate domain masks and attrs */
>  	ndoms = generate_sched_domains(&doms, &attr);
>  
> +	for (i = 0; i < ndoms; ++i) {
> +		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
> +			return;
> +	}
> +
>  	/* Have scheduler rebuild the domains */
>  	partition_sched_domains(ndoms, doms, attr);
>  }

Friendly ping.

-- 
Best regards,
Ridong


