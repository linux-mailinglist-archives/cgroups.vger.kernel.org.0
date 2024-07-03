Return-Path: <cgroups+bounces-3511-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A71924ED4
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 05:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C01F219F4
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 03:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290EE1384B1;
	Wed,  3 Jul 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eo/+LqZl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35F13792A
	for <cgroups@vger.kernel.org>; Wed,  3 Jul 2024 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975951; cv=none; b=cQconuJ6t5WkZT2uQ9hBsO++CNuSmuTRc3QStdK08TvAtmqkxGHd56VAgW0dsE7X3KjJAtOUp3j4YXblpn9rI8Lk/bwRJxXpo8J87Zs0T+Q3t7BRmNF/Kp+M61gLQfH2/pikwI5WPfYz75LtyNWgLUF5QPAzt+WICEgm7dhW0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975951; c=relaxed/simple;
	bh=LJk9pr2g8g8FrWYXtES2jZLsiV269z5KjBsGWcEhqjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU72sd+pMbbhd/xQooAIKHOz3H42JSvYXacDJ745kA4esZBw+16hTU3OHHvFbypLTxXEW04gVppoDW1kLRT/moMcPLN1fnP8XX/coj+DWBa7lpXuLEWOhAd+34v08X9KWlrXdkTr8GLLNX67VLqqsHlu+CCtBuVLRwvaxQ0Zxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eo/+LqZl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719975949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hbpsMIfwo1VWDCEr89nfCNVNZVG9S11BYTZpdTNzjko=;
	b=eo/+LqZlXN6OnN+WrAeu57rIaTZ3tgzphaHWw1WcGIW6qcWwnh9pZp0QscAIiopjLQt6Cv
	iX9qlIpCvAs/NJOMemvYEXoxacTSnp2eELo+uXnMtGb/r6aYXH/0RLJvGFACH3TMdYabjj
	lCIhMuMQtwbxLnEoiuHifeTPdIZIty0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-izNr66g_P9KT77dw1uSCow-1; Tue,
 02 Jul 2024 23:05:44 -0400
X-MC-Unique: izNr66g_P9KT77dw1uSCow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CEE619560AB;
	Wed,  3 Jul 2024 03:05:42 +0000 (UTC)
Received: from [10.22.32.29] (unknown [10.22.32.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 055381955E74;
	Wed,  3 Jul 2024 03:05:39 +0000 (UTC)
Message-ID: <22061c0a-d60d-4a04-9192-3e58f892deab@redhat.com>
Date: Tue, 2 Jul 2024 23:05:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cpuset v9 2/2] cpuset: use Union-Find to optimize the
 merging of cpumasks
To: Xavier <xavier_qy@163.com>, tj@kernel.org
Cc: mkoutny@suse.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
 <20240702105010.253933-1-xavier_qy@163.com>
 <20240702105010.253933-3-xavier_qy@163.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240702105010.253933-3-xavier_qy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/2/24 06:50, Xavier wrote:
> The process of constructing scheduling domains
>   involves multiple loops and repeated evaluations, leading to numerous
>   redundant and ineffective assessments that impact code efficiency.
>
> Here, we use Union-Find to optimize the merging of cpumasks. By employing
> path compression and union by rank, we effectively reduce the number of
> lookups and merge comparisons.
>
> Signed-off-by: Xavier <xavier_qy@163.com>
> ---
>   kernel/cgroup/cpuset.c | 95 ++++++++++++++++--------------------------
>   1 file changed, 36 insertions(+), 59 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fe76045aa5..4d32cd1407 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -45,6 +45,7 @@
>   #include <linux/cgroup.h>
>   #include <linux/wait.h>
>   #include <linux/workqueue.h>
> +#include <linux/union_find.h>
>   
>   DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
>   DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
> @@ -172,9 +173,6 @@ struct cpuset {
>   	 */
>   	int attach_in_progress;
>   
> -	/* partition number for rebuild_sched_domains() */
> -	int pn;
> -
>   	/* for custom sched domain */
>   	int relax_domain_level;
>   
> @@ -208,6 +206,9 @@ struct cpuset {
>   
>   	/* Remote partition silbling list anchored at remote_children */
>   	struct list_head remote_sibling;
> +
> +	/* Used to merge intersecting subsets for generate_sched_domains*/
> +	struct uf_node node;
>   };
>   
>   /*
> @@ -1007,7 +1008,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	struct cpuset *cp;	/* top-down scan of cpusets */
>   	struct cpuset **csa;	/* array of all cpuset ptrs */
>   	int csn;		/* how many cpuset ptrs in csa so far */
> -	int i, j, k;		/* indices for partition finding loops */
> +	int i, j;		/* indices for partition finding loops */
>   	cpumask_var_t *doms;	/* resulting partition; i.e. sched domains */
>   	struct sched_domain_attr *dattr;  /* attributes for custom domains */
>   	int ndoms = 0;		/* number of sched domains in result */
> @@ -1015,6 +1016,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	struct cgroup_subsys_state *pos_css;
>   	bool root_load_balance = is_sched_load_balance(&top_cpuset);
>   	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
> +	int nslot_update;
>   
>   	doms = NULL;
>   	dattr = NULL;
> @@ -1102,31 +1104,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	if (root_load_balance && (csn == 1))
>   		goto single_root_domain;
>   
> -	for (i = 0; i < csn; i++)
> -		csa[i]->pn = i;
> -	ndoms = csn;
> -
> -restart:
> -	/* Find the best partition (set of sched domains) */
> -	for (i = 0; i < csn; i++) {
> -		struct cpuset *a = csa[i];
> -		int apn = a->pn;
> +	if (!cgrpv2) {
> +		for (i = 0; i < csn; i++)
> +			uf_node_init(&csa[i]->node);
>   
> -		for (j = 0; j < csn; j++) {
> -			struct cpuset *b = csa[j];
> -			int bpn = b->pn;
> -
> -			if (apn != bpn && cpusets_overlap(a, b)) {
> -				for (k = 0; k < csn; k++) {
> -					struct cpuset *c = csa[k];
> -
> -					if (c->pn == bpn)
> -						c->pn = apn;
> -				}
> -				ndoms--;	/* one less element */
> -				goto restart;
> +		/* Merge overlapping cpusets */
> +		for (i = 0; i < csn; i++) {
> +			for (j = i + 1; j < csn; j++) {
> +				if (cpusets_overlap(csa[i], csa[j]))
> +					uf_union(&csa[i]->node, &csa[j]->node);
>   			}
>   		}
> +
> +		/* Count the total number of domains */
> +		for (i = 0; i < csn; i++) {
> +			if (csa[i]->node.parent == &csa[i]->node)
> +				ndoms++;
> +		}
> +	} else {
> +		ndoms = csn;
>   	}
>   
>   	/*
> @@ -1159,44 +1155,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	}
>   
>   	for (nslot = 0, i = 0; i < csn; i++) {
> -		struct cpuset *a = csa[i];
> -		struct cpumask *dp;
> -		int apn = a->pn;
> -
> -		if (apn < 0) {
> -			/* Skip completed partitions */
> -			continue;
> -		}
> -
> -		dp = doms[nslot];
> -
> -		if (nslot == ndoms) {
> -			static int warnings = 10;
> -			if (warnings) {
> -				pr_warn("rebuild_sched_domains confused: nslot %d, ndoms %d, csn %d, i %d, apn %d\n",
> -					nslot, ndoms, csn, i, apn);
> -				warnings--;
> -			}
> -			continue;
> -		}
> -
> -		cpumask_clear(dp);
> -		if (dattr)
> -			*(dattr + nslot) = SD_ATTR_INIT;
> +		nslot_update = 0;
>   		for (j = i; j < csn; j++) {
> -			struct cpuset *b = csa[j];
> -
> -			if (apn == b->pn) {
> -				cpumask_or(dp, dp, b->effective_cpus);
> +			if (uf_find(&csa[j]->node) == &csa[i]->node) {
> +				struct cpumask *dp = doms[nslot];
> +
> +				if (i == j) {
> +					nslot_update = 1;
> +					cpumask_clear(dp);
> +					if (dattr)
> +						*(dattr + nslot) = SD_ATTR_INIT;
> +				}
> +				cpumask_or(dp, dp, csa[j]->effective_cpus);
>   				cpumask_and(dp, dp, housekeeping_cpumask(HK_TYPE_DOMAIN));
>   				if (dattr)
> -					update_domain_attr_tree(dattr + nslot, b);
> -
> -				/* Done with this partition */
> -				b->pn = -1;
> +					update_domain_attr_tree(dattr + nslot, csa[j]);
>   			}
>   		}
> -		nslot++;
> +		if (nslot_update)
> +			nslot++;
>   	}
>   	BUG_ON(nslot != ndoms);
>   

The code change looks OK to me. However, the following comment above 
generate_sched_domains() describes the generation process.

  * Finding the best partition (set of domains):
  *      The triple nested loops below over i, j, k scan over the
  *      load balanced cpusets (using the array of cpuset pointers in
  *      csa[]) looking for pairs of cpusets that have overlapping
  *      cpus_allowed, but which don't have the same 'pn' partition
  *      number and gives them in the same partition number.  It keeps
  *      looping on the 'restart' label until it can no longer find
  *      any such pairs.
  *
  *      The union of the cpus_allowed masks from the set of
  *      all cpusets having the same 'pn' value then form the one
  *      element of the partition (one sched domain) to be passed to
  *      partition_sched_domains().

This part is no longer correct with your patch. Would you mind updating 
it to match what your new patch is doing?

BTW, please also incorporate the Andrew's suggestion about the kernel 
convention of writing comments.

Thanks,
Longman


