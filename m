Return-Path: <cgroups+bounces-15351-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KONoE2yB4mnk6gAAu9opvQ
	(envelope-from <cgroups+bounces-15351-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 20:52:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A69641E137
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8456300BC63
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87CA3976BE;
	Fri, 17 Apr 2026 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJeCXddq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD983382CB
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451935; cv=none; b=nt3F2+zHJeiX4ynVTVmiIklzOjDtv7i3SGu7oTPDg23/UgU3qG84MmOj/8VtHa9FcopnOe44N57vHcFB6yH3sQ/M8ts4S62e9CCNUjto/jTa6KvSlSBOZjpcTbcs2JDZP74kPei90nfvkh5wzvmCi3nReM91bie7fKawmx+Qjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451935; c=relaxed/simple;
	bh=rsUS+utW3f/2ZuQ0BnY5p+GMQTkXA04rVUTwB66KHrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwiY0jIdK90FyS6Gib5xc7eAoez+FsQRlJnHCtE55KQnRjpbTATBQm80FLV1vYTjPr2iIh9WMSb4rYxNOQXO8uX0+h0IIMAqPHXjfB6oVbZAQOlKLo1i5/X86JzVA+zu7vlbNUkVhnKXtt+8M3AjPt9iTZgGAbFf6BEaSOo8suE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJeCXddq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776451933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mApCTEkHaw2nunpwDopWIwCdkBTK3Xqkfnut5+6MZQY=;
	b=VJeCXddq/t9D1pdpfNS59UQcCV2bs6EAPqvAZRvUf5FHY2Oqk2ZfWA6p/+eGcr4VqEodoC
	5s6TJAftc+tMF9xX+m23k4qaPAzWeNAF9FYSnF28IY3suUixHkPSWmFOIh2uRwarxi9MzP
	7BpHVz6JRxyYzuut2glOtnjSVZMihgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-BcuikIyZNLOHgFsylPJrug-1; Fri,
 17 Apr 2026 14:52:07 -0400
X-MC-Unique: BcuikIyZNLOHgFsylPJrug-1
X-Mimecast-MFC-AGG-ID: BcuikIyZNLOHgFsylPJrug_1776451921
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 449B419560B2;
	Fri, 17 Apr 2026 18:52:00 +0000 (UTC)
Received: from [10.22.88.98] (unknown [10.22.88.98])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C41D91800660;
	Fri, 17 Apr 2026 18:51:56 +0000 (UTC)
Message-ID: <fd28bea7-83bd-48b7-8c3c-ad44474b8b5b@redhat.com>
Date: Fri, 17 Apr 2026 14:51:55 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: record DL BW alloc CPU for attach
 rollback
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, shuah@kernel.org, chenridong@huaweicloud.com,
 Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-2-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260417033742.40793-2-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-15351-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A69641E137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 11:37 PM, Guopeng Zhang wrote:
> cpuset_can_attach() allocates DL bandwidth only when migrating
> deadline tasks to a disjoint CPU mask, but cpuset_cancel_attach()
> rolls back based only on nr_migrate_dl_tasks. This makes the DL
> bandwidth alloc/free paths asymmetric: rollback can call dl_bw_free()
> even when no dl_bw_alloc() was done.
>
> Rollback also needs to undo the reservation against the same CPU/root
> domain that was charged. Record the CPU used by dl_bw_alloc() and use
> that state in cpuset_cancel_attach(). If no allocation happened,
> dl_bw_cpu stays at -1 and rollback skips dl_bw_free(). If allocation
> did happen, bandwidth is returned to the same CPU/root domain.
>
> Successful attach paths are unchanged. This only fixes failed attach
> rollback accounting.
>
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>   kernel/cgroup/cpuset-internal.h |  5 +++++
>   kernel/cgroup/cpuset.c          | 13 +++++++++----
>   2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index fd7d19842ded..bb4e692bea30 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -168,6 +168,11 @@ struct cpuset {
>   	int nr_deadline_tasks;
>   	int nr_migrate_dl_tasks;
>   	u64 sum_migrate_dl_bw;
> +	/*
> +	 * CPU used for temporary DL bandwidth allocation during attach;
> +	 * -1 if no DL bandwidth was allocated in the current attach.
> +	 */
> +	int dl_bw_cpu;
>   
>   	/* Invalid partition error code, not lock protected */
>   	enum prs_errcode prs_err;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..e3a081a07c6d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -288,6 +288,7 @@ struct cpuset top_cpuset = {
>   	.flags = BIT(CS_CPU_EXCLUSIVE) |
>   		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
> +	.dl_bw_cpu = -1,
>   };
>   
>   /**
> @@ -579,6 +580,8 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>   	if (!trial)
>   		return NULL;
>   
> +	trial->dl_bw_cpu = -1;
> +
>   	/* Setup cpumask pointer array */
>   	cpumask_var_t *pmask[4] = {
>   		&trial->cpus_allowed,
> @@ -2980,6 +2983,7 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>   {
>   	cs->nr_migrate_dl_tasks = 0;
>   	cs->sum_migrate_dl_bw = 0;
> +	cs->dl_bw_cpu = -1;
>   }
>   
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
> @@ -3056,6 +3060,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   			reset_migrate_dl_data(cs);
>   			goto out_unlock;
>   		}
> +
> +		cs->dl_bw_cpu = cpu;
>   	}
>   
>   out_success:
> @@ -3080,12 +3086,11 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   	mutex_lock(&cpuset_mutex);
>   	dec_attach_in_progress_locked(cs);
>   
> -	if (cs->nr_migrate_dl_tasks) {
> -		int cpu = cpumask_any(cs->effective_cpus);
> +	if (cs->dl_bw_cpu >= 0)
> +		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
>   
> -		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
> +	if (cs->nr_migrate_dl_tasks)
>   		reset_migrate_dl_data(cs);
> -	}
>   
>   	mutex_unlock(&cpuset_mutex);
>   }

The patch looks correct to me.

Reviewed-by: Waiman Long <longman@redhat.com>

However, I have a DL bandwidth accounting question unrelated to this 
patch that I would like the scheduler people to clarify. The allocation 
of additional DL BW is based on the condition

         if (!cpumask_intersects(oldcs->effective_cpus, 
cs->effective_cpus)) {

IOW, additional DL BW will need to be allocated when the old and new 
cpuset doesn't overlap. However, they could still be in the same root 
domain. Does that mean we will be double counting it?

Looking from the other side, the root domain may have enough DL BW for 
the task migration, but the subset of CPUs in the cpuset itself may not 
have enough total DL BW to host all the DL tasks to be migrated, is that 
a problem?

Cheers,
Longman


