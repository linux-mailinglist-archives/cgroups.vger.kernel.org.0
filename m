Return-Path: <cgroups+bounces-13928-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IktIxeHjmlfCwEAu9opvQ
	(envelope-from <cgroups+bounces-13928-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 03:06:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D561325B6
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 03:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2CD93082E36
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836752264A8;
	Fri, 13 Feb 2026 02:06:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87F1BC08F;
	Fri, 13 Feb 2026 02:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770948370; cv=none; b=mtLAIg21gUxnlPz4YwFaw5NQfke9L93p9JKnZgrc5oRnmCkFB9JMZmeVUYpPNknd/Jmsa87fgeWgnA1iuqe1emq2X5khz1FaYZFIk0+2wkoQ0WH0OyEUuX/p6XQoo4Jou5a+x7HONKj32H2rUTx2ngnHGU+1KGFcHeDYb9jHM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770948370; c=relaxed/simple;
	bh=12eeLHIc3DHy19ev2jtTZ1HLGUHVMFbDU7A5ET9P3iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awg0moJlkweWhigEE7K8zB+FenwH59s+s6xtL8X8K1cmCxJsSZshQH7/LxaXTecLDuuoPn1ApvoZstItbZobMA8qNVh0wqmmX/mZuzVH3pQET2YaLspRQ4Z/raDRwi6uBG10YL+3KcnGugV/dWj+fSx1RmUbuet8zWaGyD4XHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fBwWF3G8MzYQv0J;
	Fri, 13 Feb 2026 10:06:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24E624056B;
	Fri, 13 Feb 2026 10:06:04 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBH8vIKh45p2kH4HA--.16745S2;
	Fri, 13 Feb 2026 10:06:03 +0800 (CST)
Message-ID: <38c29e11-4e8a-4c3e-b6fc-7d86d49a4657@huaweicloud.com>
Date: Fri, 13 Feb 2026 10:06:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] cgroup/cpuset: Set isolated_cpus_updating only if
 isolated_cpus is changed
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
References: <20260212164640.2408295-1-longman@redhat.com>
 <20260212164640.2408295-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260212164640.2408295-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBH8vIKh45p2kH4HA--.16745S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4xGry7Ar17Ar4rAF15CFg_yoW8Xr43pr
	18K347CFW5tF43C34aqwn2gr1Sgws5JrW2kay5Kr15ZFnxXa4vqw17W3Z8tr18Kws3Wry8
	Ar9IgFs2ga4Ika7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13928-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 50D561325B6
X-Rspamd-Action: no action



On 2026/2/13 0:46, Waiman Long wrote:
> As cpuset is updating HK_TYPE_DOMAIN housekeeping mask when there is
> a change in the set of isolated CPUs, making this change is now more
> costly than before.  Right now, the isolated_cpus_updating flag can be
> set even if there is no real change in isolated_cpus. Put in additional
> checks to make sure that isolated_cpus_updating is set only if there
> is a real change in isolated_cpus.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e55855269432..c792380f9b60 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1180,11 +1180,15 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>  	WARN_ON_ONCE(old_prs == new_prs);
>  	lockdep_assert_held(&callback_lock);
>  	lockdep_assert_held(&cpuset_mutex);
> -	if (new_prs == PRS_ISOLATED)
> +	if (new_prs == PRS_ISOLATED) {
> +		if (cpumask_subset(xcpus, isolated_cpus))
> +			return;
>  		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
> -	else
> +	} else {
> +		if (!cpumask_intersects(xcpus, isolated_cpus))
> +			return;
>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
> -
> +	}
>  	isolated_cpus_updating = true;
>  }
>  

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


