Return-Path: <cgroups+bounces-15360-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GHSBUyA5WlvkgEAu9opvQ
	(envelope-from <cgroups+bounces-15360-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 03:24:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0142601A
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B07B03003BF5
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DCF31A7E4;
	Mon, 20 Apr 2026 01:24:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D430EF90
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776648258; cv=none; b=ahrE+msezKVhdd57ZC8ollUvQwAWtAFY9iyZm9NVPwMXc2NOCdMKDOK03On1UU+8nYXxlUQuNDZFdb7qu7LC2QOm6H/tuw3opUomh5pSgH7qM/j1UFhFYhKPduYxjoriIvKCsBAMODKwhl8EXsB9oeOeZQy6DFbJvIgp8uZ8VMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776648258; c=relaxed/simple;
	bh=LhIBuAGmzYTR6sbVOvte8BP9ZNRL4bNATKrn2Zp282w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjmH6oguxY3SlnSH4O01TRL870QuDu3vF9rFz0bawVv1fMXzwLTyZmE5twU7zwttUjXxnfKFB7n5XVmYHQYZviMWLXvhdB9QO24ZJe7zSoTM5k7DtwbUjuHO43Do7occYpaM3D2PSDJfA3LktCfbrP/tqiGsCBPAMx3FKaXtoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fzSRM3CNMzYQtH7
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 09:23:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2FD0B405EF
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 09:24:05 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgBH9L0zgOVp6wsfBA--.37441S2;
	Mon, 20 Apr 2026 09:24:05 +0800 (CST)
Message-ID: <7249e345-8218-4232-9fc1-4109039a9aad@huaweicloud.com>
Date: Mon, 20 Apr 2026 09:24:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Skip cpuset_top_mutex for cpuset.mems
 writes
To: Julian Sun <sunjunchao@bytedance.com>, cgroups@vger.kernel.org
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
References: <20260418100220.3717207-1-sunjunchao@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260418100220.3717207-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBH9L0zgOVp6wsfBA--.37441S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWkCr4fXFWkGr4kCF13twb_yoWrGw1rpF
	yjgFW3trWqqrnruwnxuw17uryY9w4kKFy2q3Z3Gw1rury2q3Z29F98W3sxWrW7Crn3Cr15
	XF9rGw4Uu3ykA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15360-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email]
X-Rspamd-Queue-Id: B3C0142601A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/18 18:02, Julian Sun wrote:
> cpuset_top_mutex serializes regular cpuset writes against the
> housekeeping_update() path. That path has to drop cpus_read_lock() and
> cpuset_mutex before calling housekeeping_update(), while keeping the
> housekeeping cpumask update ordered against other cpuset writes.
> 
> cpuset_write_resmask() currently takes cpuset_top_mutex for all
> resource-mask writes. This is broader than needed for cpuset.mems. The
> mems path updates nodemasks, task mems_allowed and mempolicy state, and
> may queue page migration work, but it does not change isolated CPUs,
> scheduler domains or housekeeping cpumasks.
> 

Hello,

Has any regression been observed that prompted you to make this change?

> Add cpuset_mems_lock()/cpuset_mems_unlock() for FILE_MEMLIST. The new
> lock helper still takes cpus_read_lock() and cpuset_mutex because
> update_nodemask() can reach check_insane_mems_config(), which calls
> static_branch_enable_cpuslocked(). CPU mask writes keep using
> cpuset_full_lock().
> 
> Record update_housekeeping and force_sd_rebuild on entry and warn if
> FILE_MEMLIST changes either value. If that warning ever fires, the mems
> path has gained a sched-domain or housekeeping side effect and must stop
> using the lighter lock path.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> ---
>  kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..5e0927ea71a9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -331,6 +331,28 @@ void cpuset_full_unlock(void)
>  	mutex_unlock(&cpuset_top_mutex);
>  }
>  
> +/*
> + * cpuset.mems writes cannot change isolated CPUs or sched domains. Skip
> + * cpuset_top_mutex, but verify that the path leaves finalizer state unchanged.
> + */
> +static void cpuset_mems_lock(bool *hk_update, bool *sd_rebuild)
> +{
> +	cpus_read_lock();
> +	mutex_lock(&cpuset_mutex);
> +
> +	*hk_update = update_housekeeping;
> +	*sd_rebuild = force_sd_rebuild;
> +}
> +
> +static void cpuset_mems_unlock(bool hk_update, bool sd_rebuild)
> +{
> +	WARN_ON_ONCE(update_housekeeping != hk_update);
> +	WARN_ON_ONCE(force_sd_rebuild != sd_rebuild);
> +
> +	mutex_unlock(&cpuset_mutex);
> +	cpus_read_unlock();
> +}
> +
>  #ifdef CONFIG_LOCKDEP
>  bool lockdep_is_cpuset_held(void)
>  {
> @@ -3209,6 +3231,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  {
>  	struct cpuset *cs = css_cs(of_css(of));
>  	struct cpuset *trialcs;
> +	cpuset_filetype_t type = of_cft(of)->private;
> +	bool mems = type == FILE_MEMLIST;
> +	bool hk_update = false;
> +	bool sd_rebuild = false;
>  	int retval = -ENODEV;
>  
>  	/* root is read-only */
> @@ -3216,7 +3242,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  		return -EACCES;
>  
>  	buf = strstrip(buf);
> -	cpuset_full_lock();
> +	if (mems)
> +		cpuset_mems_lock(&hk_update, &sd_rebuild);
> +	else
> +		cpuset_full_lock();
>  	if (!is_cpuset_online(cs))
>  		goto out_unlock;
>  
> @@ -3226,7 +3255,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  		goto out_unlock;
>  	}
>  
> -	switch (of_cft(of)->private) {
> +	switch (type) {
>  	case FILE_CPULIST:
>  		retval = update_cpumask(cs, trialcs, buf);
>  		break;
> @@ -3243,9 +3272,12 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  
>  	free_cpuset(trialcs);
>  out_unlock:
> -	cpuset_update_sd_hk_unlock();
> -	if (of_cft(of)->private == FILE_MEMLIST)
> +	if (mems) {
> +		cpuset_mems_unlock(hk_update, sd_rebuild);
>  		schedule_flush_migrate_mm();
> +	} else {
> +		cpuset_update_sd_hk_unlock();
> +	}
>  	return retval ?: nbytes;
>  }
>  

-- 
Best regards,
Ridong


