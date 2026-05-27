Return-Path: <cgroups+bounces-16361-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCsVA5EyF2rd7wcAu9opvQ
	(envelope-from <cgroups+bounces-16361-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:06:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACB75E8AC4
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79D46300D6B0
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB78384232;
	Wed, 27 May 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwk2tVy+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03441242D89
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904888; cv=none; b=ibKAgeiQogGvluNb5tjSClpP6KwruYhmfb39kEwcH632CJpKNLVZ8YZeHndimjtSTDx5Jp/tEf92J0qDySDi2fr4XMOZMd49TqekrjBwYbLusFH9l30IwnT6aLxQvgPqFLTxv+x0FzIbUPWOqtDbn17TXoKMRxYBIStaWxfbz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904888; c=relaxed/simple;
	bh=j0fg5btQLDtQKnc7ehq+W/ZUgi3vSHMssA0xZxtFPcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9f+7O8sHz3uVLFuIs8ExudinVd1OUPKIr1KMJb6htzlrPeTZbhFTToLHXFCzYLkXM3B+5WmQYxGJQ/yyZA8afKh4+B0SJmoH0ruyqrra4OfemTIKpoD929XtMoj7g4JmeXlLJh6Tz+e7rSexmuxnYjpJ5U7E4ZJ1yxffINvbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rwk2tVy+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779904886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bAXs9F3o08TQmZVsxFuTdEaLrdHrVX3ug1SEsfGRxg=;
	b=Rwk2tVy+uHkY8q8GxJQLO20xJzIvQtviHPligOtBbQpPa50jujKwOv+vm3hT2ajiu9jXXh
	wBDQgax1WQ+ChVZurj6/YcO/DYN+8++VjlCmBPoD+rDBvCThVFyAuYiQBWl4VcaiT1sdfp
	1UttsxcXfXVG2e5OfSJSdCXzv2zq0es=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-XQXP96CLOhG1EjAsNbPuvQ-1; Wed,
 27 May 2026 14:01:20 -0400
X-MC-Unique: XQXP96CLOhG1EjAsNbPuvQ-1
X-Mimecast-MFC-AGG-ID: XQXP96CLOhG1EjAsNbPuvQ_1779904877
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 696DF195608D;
	Wed, 27 May 2026 18:01:17 +0000 (UTC)
Received: from [10.22.81.53] (unknown [10.22.81.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A8681800347;
	Wed, 27 May 2026 18:01:14 +0000 (UTC)
Message-ID: <62837b91-b820-4dc1-9f12-6206b30ab7d2@redhat.com>
Date: Wed, 27 May 2026 14:01:14 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: Use effective_xcpus in
 partcmd_update add/del mask calculation
To: Sun Shaojie <sunshaojie@kylinos.cn>,
 Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangguopeng@kylinos.cn
References: <20260527064329.640060-1-sunshaojie@kylinos.cn>
 <20260527064329.640060-2-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260527064329.640060-2-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16361-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4ACB75E8AC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 2:43 AM, Sun Shaojie wrote:
> When sibling CPU exclusion occurs, a partition's user_xcpus may contain
> CPUs that were never actually granted to it. These CPUs are present in
> user_xcpus(cs) but not in cs->effective_xcpus.
>
> The partcmd_update path in update_parent_effective_cpumask() uses
> user_xcpus(cs) (via the local variable xcpus) to compute the addmask
> (CPUs to return to parent) and delmask (CPUs to request from parent).
> This is incorrect:
>
>   1) When newmask removes a CPU that was previously excluded by a
>      sibling, addmask incorrectly includes that CPU and tries to return
>      it to the parent even though the partition never actually owned it,
>      causing CPU overlap with sibling partitions and triggering warnings
>      in generate_sched_domains().
>
>   2) When newmask adds a previously excluded CPU that is now available,
>      delmask fails to request it from the parent because user_xcpus(cs)
>      already includes it.
>
> Fix this by using cs->effective_xcpus instead of user_xcpus(cs) in all
> partcmd_update paths that calculate addmask or delmask, including the
> PERR_NOCPUS error handling paths.
>
> Reproducers:
>
>    Example 1 - Removing a sibling-excluded CPU incorrectly returns it:
>
>      # cd /sys/fs/cgroup
>      # echo "0-1" > a1/cpuset.cpus
>      # echo "root" > a1/cpuset.cpus.partition
>      # echo "0-2" > b1/cpuset.cpus
>      # echo "root" > b1/cpuset.cpus.partition
>      # echo "2" > b1/cpuset.cpus
>      # cat cpuset.cpus.effective
>      # Actual: 0-1,3    Expected: 3
>
>    Example 2 - Expanding to a previously excluded CPU fails to request it:
>
>      # cd /sys/fs/cgroup
>      # echo "0-1" > a1/cpuset.cpus
>      # echo "root" > a1/cpuset.cpus.partition
>      # echo "0-2" > b1/cpuset.cpus
>      # echo "root" > b1/cpuset.cpus.partition
>      # echo "member" > a1/cpuset.cpus.partition
>      # echo "1-2" > b1/cpuset.cpus
>      # cat cpuset.cpus.effective
>      # Actual: 0-1,3    Expected: 0,3
>
> Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
> Suggested-by: Zhang Guopeng <zhangguopeng@kylinos.cn>
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>   kernel/cgroup/cpuset.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..2395c5aec871 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1807,9 +1807,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		 * Compute add/delete mask to/from effective_cpus
>   		 *
>   		 * For valid partition:
> -		 *   addmask = exclusive_cpus & ~newmask
> +		 *   addmask = effective_xcpus & ~newmask
>   		 *			      & parent->effective_xcpus
> -		 *   delmask = newmask & ~exclusive_cpus
> +		 *   delmask = newmask & ~effective_xcpus
>   		 *		       & parent->effective_xcpus
>   		 *
>   		 * For invalid partition:
> @@ -1821,11 +1821,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			deleting = cpumask_and(tmp->delmask,
>   					newmask, parent->effective_xcpus);
>   		} else {
> -			cpumask_andnot(tmp->addmask, xcpus, newmask);
> +			cpumask_andnot(tmp->addmask, cs->effective_xcpus, newmask);
>   			adding = cpumask_and(tmp->addmask, tmp->addmask,
>   					     parent->effective_xcpus);
>   
> -			cpumask_andnot(tmp->delmask, newmask, xcpus);
> +			cpumask_andnot(tmp->delmask, newmask, cs->effective_xcpus);
>   			deleting = cpumask_and(tmp->delmask, tmp->delmask,
>   					       parent->effective_xcpus);
>   		}
> @@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			part_error = PERR_NOCPUS;
>   			deleting = false;
>   			adding = cpumask_and(tmp->addmask,
> -					     xcpus, parent->effective_xcpus);
> +					     cs->effective_xcpus, parent->effective_xcpus);
>   		}
>   	} else {
>   		/*
> @@ -1886,7 +1886,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   			part_error = PERR_NOCPUS;
>   			if (is_partition_valid(cs))
>   				adding = cpumask_and(tmp->addmask,
> -						xcpus, parent->effective_xcpus);
> +						     cs->effective_xcpus,
> +						     parent->effective_xcpus);
>   		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>   			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>   			struct cgroup_subsys_state *css;
Reviewed-by: Waiman Long <longman@redhat.com>


