Return-Path: <cgroups+bounces-13807-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIf4EL2SiWlz+wQAu9opvQ
	(envelope-from <cgroups+bounces-13807-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 08:54:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA96810CA5C
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 08:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD4A300822D
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF40339856;
	Mon,  9 Feb 2026 07:53:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101372FE593;
	Mon,  9 Feb 2026 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770623634; cv=none; b=LIuKv8nc0azt6q5OlEuZOWRuJkZmRp0V0o3dLbrJrRs5wVEYlF3GIRlWUHe1HuUaXWrA7J9b5xveMB/B9cKgk3LSjDPxgomPvD8ya0q33ITXGQZPWcSUxiglFkTO95BGHpRff/aw74srB3VEEZLyM7u3T7tSpAeiOqgAMLfFkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770623634; c=relaxed/simple;
	bh=5BBJZGihFw/ixhju3jAEENjNmLn/OkKpgKEbDqci1Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iq0WXhZM/OKkL8+RC/+TupKGDvVHO2NouT+UAX7qY7x2RG/n9o68Yx0hLynRrkP+WHag01y6t/wqGdGzcb2AGGRmh/R/apdSWFSQsz8ihZRqqdk3oI4QAoOYEGHL9ytUJPB9KGBkzGptCweXR0kFBgBd2unaxs24j9yzVYvvZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f8cPJ5BFwzYQv2T;
	Mon,  9 Feb 2026 15:52:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB6E34058C;
	Mon,  9 Feb 2026 15:53:49 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA35vaMkolpqsYzGw--.15410S2;
	Mon, 09 Feb 2026 15:53:49 +0800 (CST)
Message-ID: <da363ddb-c006-4ff8-a327-5ef75045d3fd@huaweicloud.com>
Date: Mon, 9 Feb 2026 15:53:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 4/4] cgroup/cpuset: Eliminate some duplicated
 rebuild_sched_domains() calls
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-5-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260206203712.1989610-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vaMkolpqsYzGw--.15410S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4DXF4DCr48Aw45tF1rCrg_yoW5tr1fpF
	yDGF47urWYqw1Uua17Zay7Zr1Svw4kt3yaga45GryfAF1ag3Z7Z3WYqF13JFZ3u3s7CrWU
	CFZrKa17Wr1qyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.945];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13807-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: BA96810CA5C
X-Rspamd-Action: no action



On 2026/2/7 4:37, Waiman Long wrote:
> Now that we are going to defer any changes to the HK_TYPE_DOMAIN
> housekeeping cpumasks to either task_work or workqueue
> where rebuild_sched_domains() call will be issued. The current
> rebuild_sched_domains_locked() call near the end of the cpuset critical
> section can be removed in such cases.
> 
> Currently, a boolean force_sd_rebuild flag is used to decide if
> rebuild_sched_domains_locked() call needs to be invoked. To allow
> deferral that like, we change it to a tri-state sd_rebuild enumaration
> type.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d26c77a726b2..e224df321e34 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -173,7 +173,11 @@ static bool		isolcpus_twork_queued;	/* T */
>   * Note that update_relax_domain_level() in cpuset-v1.c can still call
>   * rebuild_sched_domains_locked() directly without using this flag.
>   */
> -static bool force_sd_rebuild;			/* RWCS */
> +static enum {
> +	SD_NO_REBUILD = 0,
> +	SD_REBUILD,
> +	SD_DEFER_REBUILD,
> +} sd_rebuild;					/* RWCS */
>  
>  /*
>   * Partition root states:
> @@ -990,7 +994,7 @@ void rebuild_sched_domains_locked(void)
>  
>  	lockdep_assert_cpus_held();
>  	lockdep_assert_cpuset_lock_held();
> -	force_sd_rebuild = false;
> +	sd_rebuild = SD_NO_REBUILD;
>  
>  	/* Generate domain masks and attrs */
>  	ndoms = generate_sched_domains(&doms, &attr);
> @@ -1377,6 +1381,9 @@ static void update_isolation_cpumasks(void)
>  	else
>  		isolated_cpus_updating = false;
>  

If isolated_hk_cpus is defined, I believe isolated_cpus_updating becomes redundant.

> +	/* Defer rebuild_sched_domains() to task_work or wq */
> +	sd_rebuild = SD_DEFER_REBUILD;
> +

There is a potential issue: we defer all domain rebuilds here, including those
triggered by hotplug events which may change the isolation state.

The problem is that functions like cpuset_cpu_active, which rely on the
scheduler domains being up-to-date—will, also be delayed. Is that okay?

>  	/*
>  	 * This function can be reached either directly from regular cpuset
>  	 * control file write or via CPU hotplug. In the latter case, it is
> @@ -3011,7 +3018,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	update_partition_sd_lb(cs, old_prs);
>  
>  	notify_partition_change(cs, old_prs);
> -	if (force_sd_rebuild)
> +	if (sd_rebuild == SD_REBUILD)
>  		rebuild_sched_domains_locked();
>  	free_tmpmasks(&tmpmask);
>  	return 0;
> @@ -3288,7 +3295,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>  	}
>  
>  	free_cpuset(trialcs);
> -	if (force_sd_rebuild)
> +	if (sd_rebuild == SD_REBUILD)
>  		rebuild_sched_domains_locked();
>  out_unlock:
>  	cpuset_full_unlock();
> @@ -3771,7 +3778,8 @@ hotplug_update_tasks(struct cpuset *cs,
>  
>  void cpuset_force_rebuild(void)
>  {
> -	force_sd_rebuild = true;
> +	if (!sd_rebuild)
> +		sd_rebuild = SD_REBUILD;
>  }
>  
>  /**
> @@ -3981,7 +3989,7 @@ static void cpuset_handle_hotplug(void)
>  	}
>  
>  	/* rebuild sched domains if necessary */
> -	if (force_sd_rebuild)
> +	if (sd_rebuild == SD_REBUILD)
>  		rebuild_sched_domains_cpuslocked();
>  
>  	free_tmpmasks(ptmp);

-- 
Best regards,
Ridong


