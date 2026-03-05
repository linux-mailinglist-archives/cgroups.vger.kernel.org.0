Return-Path: <cgroups+bounces-14628-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLmwGIcmqWkL2gAAu9opvQ
	(envelope-from <cgroups+bounces-14628-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 07:45:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA1D20BCF1
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 07:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5B830305DF
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD3296BDB;
	Thu,  5 Mar 2026 06:45:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42A3594A;
	Thu,  5 Mar 2026 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693123; cv=none; b=ZzsKt4WcjGE3sDgP/jJSZknXWOdKdj5i4zhueszxLqpNw0eXRWboqB9nZvgGpX8UYiVqOTJVpCz+Gg9RMuhKt1VQfc1sB/z41nERsMBYZ/rkO8mOVZe3cFU+MlZNAtNT589dsjA0rwZDHEQmV4NgtwViNexYU80H1pBelfkBA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693123; c=relaxed/simple;
	bh=/4ahz4U1A918kwpjUw3PYq3L9CNXq1hFPGBD2iJp0v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9AmhjvmkVDZxsjlpxElLb4fLf2Jka7qdf70bz8xDjOkNjKIomNRObdoCouWbMA190VV9DM3gaYqlPsjWxqFFOCDCtDLILHUhduzPCCBdNCmJv77dSzbeXR/xTBATLH12RZgmt4CsLK0psPiSdD0j8lYrPdVT7wwbB8Jo4tTwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fRKlX4Tg2zYQtmR;
	Thu,  5 Mar 2026 14:44:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 786E44056B;
	Thu,  5 Mar 2026 14:45:17 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAHIoF8JqlprMQMJg--.59639S2;
	Thu, 05 Mar 2026 14:45:17 +0800 (CST)
Message-ID: <f7fe97bb-05ca-4187-99a3-537ddad718ee@huaweicloud.com>
Date: Thu, 5 Mar 2026 14:45:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Call rebuild_sched_domains() directly in
 hotplug
To: Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huawei.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>
References: <20260304184100.71015-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260304184100.71015-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHIoF8JqlprMQMJg--.59639S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1rGr1xZw1rCF4rJF18Krg_yoW3ArW5pF
	Wj9rW7t3yUtr4Du3s8Zw1xWryF9wsFyFyUt3Z3Gw1rGry2g3Z2vF109asxGrZ7u3s3Cr17
	ZasrKanruF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: ADA1D20BCF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,huaweicloud.com:mid,huaweicloud.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-14628-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action



On 2026/3/5 2:41, Waiman Long wrote:
> Besides deferring the call to housekeeping_update(), commit 6df415aa46ec
> ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug
> to workqueue") also defers the rebuild_sched_domains() call to
> the workqueue. So a new offline CPU may still be in a sched domain
> or new online CPU not showing up in the sched domains for a short
> transition period. That could be a problem in some corner cases and
> can be the cause of a reported test failure[1]. Fix it by calling

Miss Link [1]?

> rebuild_sched_domains_cpuslocked() directly in hotplug as before. If
> isolated partition invalidation or recreation is being done, the
> housekeeping_update() call to update the housekeeping cpumasks will
> still be deferred to a workqueue.
> 
> In commit 3bfe47967191 ("cgroup/cpuset: Move
> housekeeping_update()/rebuild_sched_domains() together"),
> housekeeping_update() is called before rebuild_sched_domains() because
> it needs to access the HK_TYPE_DOMAIN housekeeping cpumask. That is now
> changed to use the static HK_TYPE_DOMAIN_BOOT cpumask as HK_TYPE_DOMAIN
> cpumask is now changeable at run time.  As a result, we can move the
> rebuild_sched_domains() call before housekeeping_update() with
> the slight advantage that it will be done in the same cpus_read_lock
> critical section without the possibility of interference by a concurrent
> cpu hot add/remove operation.
> 

Nice.

> As it doesn't make sense to acquire cpuset_mutex/cpuset_top_mutex after
> calling housekeeping_update() and immediately release them again, move
> the cpuset_full_unlock() operation inside update_hk_sched_domains()
> and rename it to cpuset_update_sd_hk_unlock() to signify that it will
> release the full set of locks.
> 
> Fixes: 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 271bb99b1b9d..f7657b325490 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -881,7 +881,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  	/*
>  	 * Cgroup v2 doesn't support domain attributes, just set all of them
>  	 * to SD_ATTR_INIT. Also non-isolating partition root CPUs are a
> -	 * subset of HK_TYPE_DOMAIN housekeeping CPUs.
> +	 * subset of HK_TYPE_DOMAIN_BOOT housekeeping CPUs.
>  	 */
>  	for (i = 0; i < ndoms; i++) {
>  		/*
> @@ -890,7 +890,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		 */
>  		if (!csa || csa[i] == &top_cpuset)
>  			cpumask_and(doms[i], top_cpuset.effective_cpus,
> -				    housekeeping_cpumask(HK_TYPE_DOMAIN));
> +				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>  		else
>  			cpumask_copy(doms[i], csa[i]->effective_cpus);
>  		if (dattr)
> @@ -1331,17 +1331,22 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  }
>  
>  /*
> - * update_hk_sched_domains - Update HK cpumasks & rebuild sched domains
> + * cpuset_update_sd_hk_unlock - Rebuild sched domains, update HK & unlock
>   *
> - * Update housekeeping cpumasks and rebuild sched domains if necessary.
> - * This should be called at the end of cpuset or hotplug actions.
> + * Update housekeeping cpumasks and rebuild sched domains if necessary and
> + * then do a cpuset_full_unlock().
> + * This should be called at the end of cpuset operation.
>   */
> -static void update_hk_sched_domains(void)
> +static void cpuset_update_sd_hk_unlock(void)
> +	__releases(&cpuset_mutex)
> +	__releases(&cpuset_top_mutex)
>  {
> +	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
> +	if (force_sd_rebuild)
> +		rebuild_sched_domains_locked();
> +
>  	if (update_housekeeping) {
> -		/* Updating HK cpumasks implies rebuild sched domains */
>  		update_housekeeping = false;
> -		force_sd_rebuild = true;
>  		cpumask_copy(isolated_hk_cpus, isolated_cpus);
>  
>  		/*
> @@ -1352,22 +1357,19 @@ static void update_hk_sched_domains(void)
>  		mutex_unlock(&cpuset_mutex);
>  		cpus_read_unlock();
>  		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
> -		cpus_read_lock();
> -		mutex_lock(&cpuset_mutex);
> +		mutex_unlock(&cpuset_top_mutex);
> +	} else {
> +		cpuset_full_unlock();
>  	}
> -	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
> -	if (force_sd_rebuild)
> -		rebuild_sched_domains_locked();
>  }
>  
>  /*
> - * Work function to invoke update_hk_sched_domains()
> + * Work function to invoke cpuset_update_sd_hk_unlock()
>   */
>  static void hk_sd_workfn(struct work_struct *work)
>  {
>  	cpuset_full_lock();
> -	update_hk_sched_domains();
> -	cpuset_full_unlock();
> +	cpuset_update_sd_hk_unlock();
>  }
>  
>  /**
> @@ -3232,8 +3234,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  
>  	free_cpuset(trialcs);
>  out_unlock:
> -	update_hk_sched_domains();
> -	cpuset_full_unlock();
> +	cpuset_update_sd_hk_unlock();
>  	if (of_cft(of)->private == FILE_MEMLIST)
>  		schedule_flush_migrate_mm();
>  	return retval ?: nbytes;
> @@ -3340,8 +3341,7 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
>  	cpuset_full_lock();
>  	if (is_cpuset_online(cs))
>  		retval = update_prstate(cs, val);
> -	update_hk_sched_domains();
> -	cpuset_full_unlock();
> +	cpuset_update_sd_hk_unlock();
>  	return retval ?: nbytes;
>  }
>  
> @@ -3515,8 +3515,7 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
>  	/* Reset valid partition back to member */
>  	if (is_partition_valid(cs))
>  		update_prstate(cs, PRS_MEMBER);
> -	update_hk_sched_domains();
> -	cpuset_full_unlock();
> +	cpuset_update_sd_hk_unlock();
>  }
>  
>  static void cpuset_css_free(struct cgroup_subsys_state *css)
> @@ -3925,11 +3924,13 @@ static void cpuset_handle_hotplug(void)
>  		rcu_read_unlock();
>  	}
>  
> -
>  	/*
> -	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
> -	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
> -	 * cpumask can correctly reflect what is in isolated_cpus.
> +	 * rebuild_sched_domains() will always be called directly if needed
> +	 * to make sure that newly added or removed CPU will be reflected in
> +	 * the sched domains. However, if isolated partition invalidation
> +	 * or recreation is being done (update_housekeeping set), a work item
> +	 * will be queued to call housekeeping_update() to update the
> +	 * corresponding housekeeping cpumasks after some slight delay.
>  	 *
>  	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
>  	 * is still pending. Before the pending bit is cleared, the work data
> @@ -3938,8 +3939,10 @@ static void cpuset_handle_hotplug(void)
>  	 * previously queued work. Since hk_sd_workfn() doesn't use the work
>  	 * item at all, this is not a problem.
>  	 */
> -	if (update_housekeeping || force_sd_rebuild)
> -		queue_work(system_unbound_wq, &hk_sd_work);
> +	if (force_sd_rebuild)
> +		rebuild_sched_domains_cpuslocked();
> +	if (update_housekeeping)
> +		queue_work(system_dfl_wq, &hk_sd_work);
>  
>  	free_tmpmasks(ptmp);
>  }

This means that rebuild schedule domains are decoupled from HK updates, right?

I'm wondering again whether we can do the same for changes to
cpus/partition/cpus.exclusive. If we can defer the HK update, then the
cpuset_top_mutex might no longer be necessary.

This patch looks good to me.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


