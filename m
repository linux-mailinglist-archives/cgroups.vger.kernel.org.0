Return-Path: <cgroups+bounces-15661-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGovFaWi/Gn2SAAAu9opvQ
	(envelope-from <cgroups+bounces-15661-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 16:33:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A54EA409
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB94D3045B26
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877A402450;
	Thu,  7 May 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vxf5pZE5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65663128B6
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164279; cv=none; b=A2/9z3fh/zvd5UlIPCSSrud9o7yht6ccbX8YH3g8vLlLye6WB10fRg7r6dKaV+dJV+EB/h5va2XV+d4XV2KtBolDrkCb02394YQz6CLV83sPevH8dhIIAh5ugdzBU2Su3QrwUa0mcuRH1JJlAe9PcNvavteMpTcEagp041NAIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164279; c=relaxed/simple;
	bh=xdxmQytP/UzokOhHCLRQJRAGp72jp0MEug8OKlI0hKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAis9tQ8647mvx1ys7ZIHsLeTL8mq3fLik6UBcLqsL7GKMEXQH+sJoRyalsElecHf/tUQG9MWAH9Yf9IIeyx3YHjtdYKBosFDSpgUMhuBX9KiFuSgSc95WAngC/R4gd3s3EQjYPQF5J4CCOOPYZsPxTAScoH+AhirTSrKM74s7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vxf5pZE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778164276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNaiWR+eqSu7WO4M7F1ji4bzG7ml343gIkmWsIUgsNs=;
	b=Vxf5pZE5CnjkQ0G3lKeCfOZGiFx8qBdRE6jKxHcoEK2EWGLuLNbFkch6n421A/h3NqZj8D
	w5FtnmWVYrsC1qvTy1xf4R/x5rn6OHYAlA3NgZo+6IxPuyG7EGWosVoZsuh5JHUSXs1R/b
	XRv/YwRWTNNFGGv+KcVPaPVSJEuV6xM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-Ix9Co-CvOh-DT0l8et_Qww-1; Thu,
 07 May 2026 10:31:11 -0400
X-MC-Unique: Ix9Co-CvOh-DT0l8et_Qww-1
X-Mimecast-MFC-AGG-ID: Ix9Co-CvOh-DT0l8et_Qww_1778164269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E91F519560A7;
	Thu,  7 May 2026 14:31:07 +0000 (UTC)
Received: from [10.2.16.64] (unknown [10.2.16.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F17981801A63;
	Thu,  7 May 2026 14:31:01 +0000 (UTC)
Message-ID: <6410d11c-1d8a-4e72-ac22-43058027b304@redhat.com>
Date: Thu, 7 May 2026 10:31:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260507103310.35849-1-zhangguopeng@kylinos.cn>
 <20260507103310.35849-2-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260507103310.35849-2-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 0B0A54EA409
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-15661-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 6:33 AM, Guopeng Zhang wrote:
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
> Reset the pending DL migration state before returning from those
> per-task failure paths.
>
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   kernel/cgroup/cpuset.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e3a081a07c6d..ae41736399a1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3029,12 +3029,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	cgroup_taskset_for_each(task, css, tset) {
>   		ret = task_can_attach(task);
>   		if (ret)
> -			goto out_unlock;
> +			goto out_reset_dl_data;
>   
>   		if (setsched_check) {
>   			ret = security_task_setscheduler(task);
>   			if (ret)
> -				goto out_unlock;
> +				goto out_reset_dl_data;
>   		}
>   
>   		if (dl_task(task)) {
> @@ -3070,6 +3070,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	 * changes which zero cpus/mems_allowed.
>   	 */
>   	cs->attach_in_progress++;
> +	goto out_unlock;
> +
> +out_reset_dl_data:
> +	reset_migrate_dl_data(cs);
>   out_unlock:
>   	mutex_unlock(&cpuset_mutex);
>   	return ret;

I would prefer the likely success path be a straight line instead of 
doing a goto. IOW, move out_reset_dl_data below return. Other than that, 
this patch looks good to me.

Cheers,
Longman


