Return-Path: <cgroups+bounces-16294-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PB2E8pRFWqmUQcAu9opvQ
	(envelope-from <cgroups+bounces-16294-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:54:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF05D21CA
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4957E3037BD3
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD03CC7F5;
	Tue, 26 May 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oDYLzYnJ"
X-Original-To: cgroups@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC073CC337;
	Tue, 26 May 2026 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782043; cv=none; b=WGTZM4OfQQfaCJw/2B1PopDpIcQ6Qsyzzvdb9v8gWXuGpuIRWMY1Ws+e0r3cmbo6XbgVzzBPOQTgW4PCP+etbGe5aJF7S+zkUvoT+4PPokxMtX/UfW4J4yV4fh3hCXg7oRxrbJd+HaZHnqS6zggnb7k//OdiMiJe4s0FVrNNrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782043; c=relaxed/simple;
	bh=6THac/b1a3B5t8n8V2zIGHg9Kq4LO4mA1LZTG8Nk2Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JfiUwbmB3mU09QQmThkSvCVdPCwoFxmLMB0S65AHFBNvN5D0v2sFpgB/oAwxETJdl60r3ShamXwwXRfZtCrswhnd7b94GzNnw93ynax+Rl+nZNZdIWaxUJj/6wGWSnKn0Iq7vfZ04BpsRzRnQisjex6mi0OpMCU+b2SaBwCMlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oDYLzYnJ; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cknwSOkiDP12JEUp19D8FAdl+EtDIrWNelLh5S+MNDs=;
	b=oDYLzYnJCJs+2Js5UMxlzpyzh1rg7uuxPRvSmEDvB/y5T3Ik3kn/CH4Tlp+MafW8K52HLapHq
	r/pSWsRCd1PXTjcB3AScus07sgRqPTYyeCOnoILpzUXPU+zv1FDL96oNqtHg6pxsEA5WWJgs4+s
	kROkoIhadgqXL69cjIIpcIQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gPlDc5hk4zLlSS;
	Tue, 26 May 2026 15:46:08 +0800 (CST)
Received: from dggpemf100017.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A5694055B;
	Tue, 26 May 2026 15:53:53 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 dggpemf100017.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 15:53:52 +0800
Message-ID: <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
Date: Tue, 26 May 2026 15:53:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>,
	<kprateek.nayak@amd.com>, <qyousef@layalina.io>, Hui Tang
	<tanghui20@huawei.com>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20260511120628.206700041@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100017.china.huawei.com (7.185.36.74)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-16294-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangqiao22@huawei.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 1ABF05D21CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Peter,

在 2026/5/11 19:31, Peter Zijlstra 写道:

> @@ -13729,14 +13616,20 @@ static inline void task_tick_core(struct
>   */
>  static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  {
> -	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &curr->se;
> +	unsigned long weight = NICE_0_LOAD;
> +	struct cfs_rq *cfs_rq;
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  		entity_tick(cfs_rq, se, queued);
> +
> +		weight = __calc_prop_weight(cfs_rq, se, weight);

Testing sched/flat branch on AMD EPYC 9654 (384 CPUs, 8 NUMA nodes)
with a 2-level cgroup hierarchy and cfs_bandwidth quota enabled,
hackbench triggers a divide-by-zero oops:

  [  142.308571] divide error: 0000 [#1] SMP NOPTI
  [  142.308582] RIP: 0010:task_tick_fair+0x19e/0x410
  [  142.308601] Call Trace:
  [  142.308604]  <IRQ>
  [  142.308607]  scheduler_tick+0x6a/0x110
  [  142.308609]  update_process_times+0x6b/0x90
  [  142.308611]  tick_sched_handle+0x2a/0x70
  [  142.308613]  tick_sched_timer+0x57/0xb0

faddr2line confirms:

  task_tick_fair+0x19e/0x410:
  __calc_prop_weight at kernel/sched/fair.c:4085
  (inlined by) task_tick_fair at kernel/sched/fair.c:13576

===========================================================
Reproduction
===========================================================

Kernel: sched/flat branch (54d493980e00 and later)
Hardware: AMD EPYC 9654, 2S 384 logical CPUs

  # 2-level cgroup, quota = 50% of one period
  cgcreate -g cpu:/bw/l1/l2
  cgset -r cpu.cfs_quota_us=50000  /bw/l1/l2
  cgset -r cpu.cfs_period_us=100000 /bw/l1/l2

  # high task count amplifies the throttle→tick race window
  cgexec -g cpu:/bw/l1/l2 hackbench -g 48 -l 1000 -s 512 -T

Typically crashes within 30 seconds on this machine.  A single-CPU
kernel or a very loose quota (e.g. 90%) is unlikely to trigger it
because the race window is narrow.

Thanks,
Zhang Qiao

>  	}
>  
> +	se = &curr->se;
> +	reweight_eevdf(cfs_rq, se, weight, se->on_rq);
> +
>  	if (queued)
>  		return;
>  
> @@ -13772,7 +13665,7 @@ prio_changed_fair(struct rq *rq, struct
>  	if (p->prio == oldprio)
>  		return;
>  
> -	if (rq->cfs.nr_queued == 1)
> +	if (rq->cfs.h_nr_queued == 1)
>  		return;
>  
>  	/*
> @@ -13901,29 +13794,40 @@ static void switched_to_fair(struct rq *
>  	}
>  }
>  

>  
> 
> 
> 
> 
> .
> 

