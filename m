Return-Path: <cgroups+bounces-15714-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fzruH2FjAWpvXgEAu9opvQ
	(envelope-from <cgroups+bounces-15714-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 07:04:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF5507F37
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 07:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 065D63006526
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 05:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A7255F52;
	Mon, 11 May 2026 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ3bPk7z"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698E2E63C
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475869; cv=none; b=Fzqna0DmAvWbHnQjrbq4HAuWXNiHF2sfaK9fzewxEu4ZLzYEmtffRW7SPOd3n6BmOSgtvp9lwnESEYRW0QjZv677A2Vz5iVXlhk1UEr6sAsl1ItHMQ7gmXOen0vF7LeAFZOFCSINs1PLu+1JNautkGLn8ox4lxyV4yn1xs3wECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475869; c=relaxed/simple;
	bh=FDULX+ROJTB2/AnhAoXXSkZU8IKdCuWJ2KsSz7TEfQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IL10rlmV5qHNhoDclFziDD0F+aDSJd+p6kna9JaOTuUMnazvMsJ1h1XMhDme5/9t4YNXoW+VB1Kuvf8bbLaf7rUK4zU/I6HOqG83j0fTDaF8ksl+gmOWoNzrZdpIvf0JPhQLZne4BOVDhkTTOUeW04jKMxqPdmlYStb0zWqcSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ3bPk7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778475867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvO/yJQAzOBO4sFF4zc8geVO7INxvfy7fLG6CVNQWDU=;
	b=IQ3bPk7zaY9JbfXKwbS8AtFqkoIDFKSYCc4Sws059V9GKS/q2lYJJB6xCp6AGfwB8RLbAk
	o8/2NBpEB5ND4izF+zv8DxeK5mfiw1tilYVSSC9WGq8Rton4H9BuBYePbXT9H+tjULKu1h
	moqm6DPRP8bTiSS06N0/cXwFjypHsnI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-7wZ9QTA6ODyyx1jCMY_qxg-1; Mon,
 11 May 2026 01:04:23 -0400
X-MC-Unique: 7wZ9QTA6ODyyx1jCMY_qxg-1
X-Mimecast-MFC-AGG-ID: 7wZ9QTA6ODyyx1jCMY_qxg_1778475861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F6901956061;
	Mon, 11 May 2026 05:04:20 +0000 (UTC)
Received: from [10.2.16.21] (unknown [10.2.16.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FB9A19560A6;
	Mon, 11 May 2026 05:04:14 +0000 (UTC)
Message-ID: <9d6953bf-7726-45eb-91d0-63e24691bdc6@redhat.com>
Date: Mon, 11 May 2026 01:04:13 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
 <20260509102031.97608-2-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260509102031.97608-2-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 9BBF5507F37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-15714-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email]
X-Rspamd-Action: no action

On 5/9/26 6:20 AM, Guopeng Zhang wrote:
> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
> state in the destination cpuset while walking the taskset.
>
> If a later task_can_attach() or security_task_setscheduler() check
> fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
> and does not call cpuset_cancel_attach() for it. The partially
> accumulated state is then left behind and can be consumed by a later
> attach, corrupting cpuset DL task accounting and pending DL bandwidth
> accounting.
>
> Reset the pending DL migration state from the common error exit when
> ret is non-zero. Successful can_attach() keeps the state for
> cpuset_attach() or cpuset_cancel_attach().
>
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   kernel/cgroup/cpuset.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e3a081a07c6d..b9c839538900 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3050,16 +3050,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
>   
>   		if (unlikely(cpu >= nr_cpu_ids)) {
> -			reset_migrate_dl_data(cs);
>   			ret = -EINVAL;
>   			goto out_unlock;
>   		}
>   
>   		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -		if (ret) {
> -			reset_migrate_dl_data(cs);
> +		if (ret)
>   			goto out_unlock;
> -		}
>   
>   		cs->dl_bw_cpu = cpu;
>   	}
> @@ -3070,7 +3067,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	 * changes which zero cpus/mems_allowed.
>   	 */
>   	cs->attach_in_progress++;
> +
>   out_unlock:
> +	if (ret)
> +		reset_migrate_dl_data(cs);
>   	mutex_unlock(&cpuset_mutex);
>   	return ret;
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


