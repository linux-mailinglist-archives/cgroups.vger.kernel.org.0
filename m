Return-Path: <cgroups+bounces-16203-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OqPqIccWEGrhTQYAu9opvQ
	(envelope-from <cgroups+bounces-16203-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 10:41:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED195B0B0B
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 10:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEFE5300F517
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7985639D6E8;
	Fri, 22 May 2026 08:41:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338A34A3BF;
	Fri, 22 May 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439282; cv=none; b=iAbXxu75Or/J+AHDD43bVqKCyzGRvMRfDuz7vjg+KxfiGja0c4SFcq7cJd19emvoN+SsHFP7BkdCHEjbS+KoHW+rKuibf3qnHn4T3vxtvfzEaMt5V/ll6ljt5dd5uS2Ma/cfMY0/JnlmJ4qn/WjMuQgkgLeddsw5KhbxGiv50wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439282; c=relaxed/simple;
	bh=/0V+4WQzXZxlsyPK3HvTMDJq19NW3KGOptkTbeo69B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WG9WZB4QH7gMgdGyFrJk7UvGsGd0gauAcyQ2Gh6ZFLOYCFRPHzeHQfCBJ3DwrcBZnlgp8mqq4xk5tbAdEpMO1PxiSC6dJ1LRCp/3Q0Lmbx95JVtAa3jsIN7XmJBuhebWyaDBL1Q2EQqI5Ep58wX5aNHenZOrDrE2WQrf81cNL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fcd27c0255b911f1aa26b74ffac11d73-20260522
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM
	HR_CTE_8B, HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_NAME, HR_MAILER_MTBG, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS
	HR_TO_CHARSET, HR_TO_CHARSET_NUM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a6065f4f-e90e-43cc-98f5-f03e6355bad3,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a6065f4f-e90e-43cc-98f5-f03e6355bad3,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:430ecefd91999bd9c929f9f07505ada6,BulkI
	D:260522162846TGOCX5I5,BulkQuantity:1,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:
	nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:
	0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fcd27c0255b911f1aa26b74ffac11d73-20260522
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.109.140] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 459852020; Fri, 22 May 2026 16:41:12 +0800
Message-ID: <a1a89205-4e4b-4bb9-86fe-e106997ab1d5@kylinos.cn>
Date: Fri, 22 May 2026 16:41:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Use effective_xcpus in partcmd_update
 add/del mask calculation
To: Sun Shaojie <sunshaojie@kylinos.cn>, Waiman Long <longman@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260522075357.127075-1-sunshaojie@kylinos.cn>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <20260522075357.127075-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16203-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DED195B0B0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/5/22 15:53, Sun Shaojie 写道:
> When sibling CPU exclusion occurs, a partition's user_xcpus may contain
> CPUs that were never actually granted to it. These CPUs are present in
> user_xcpus(cs) but not in cs->effective_xcpus.
> 
> The partcmd_update path in update_parent_effective_cpumask() uses
> user_xcpus(cs) (via the local variable xcpus) to compute the addmask
> (CPUs to return to parent) and delmask (CPUs to request from parent).
> This is incorrect:
> 
>  1) When newmask removes a CPU that was previously excluded by a
>     sibling, addmask incorrectly includes that CPU and tries to return
>     it to the parent even though the partition never actually owned it,
>     causing CPU overlap with sibling partitions and triggering warnings
>     in generate_sched_domains().
> 
>  2) When newmask adds a previously excluded CPU that is now available,
>     delmask fails to request it from the parent because user_xcpus(cs)
>     already includes it.
> 
> Fix this by using cs->effective_xcpus instead of user_xcpus(cs) in all
> partcmd_update paths that calculate addmask or delmask, including the
> PERR_NOCPUS error handling paths.
> 
> Reproducers:
> 
>   Example 1 - Removing a sibling-excluded CPU incorrectly returns it:
> 
>     # cd /sys/fs/cgroup
>     # echo "0-1" > a1/cpuset.cpus
>     # echo "root" > a1/cpuset.cpus.partition
>     # echo "0-2" > b1/cpuset.cpus
>     # echo "root" > b1/cpuset.cpus.partition
>     # echo "2" > b1/cpuset.cpus
>     # cat cpuset.cpus.effective
>     # Actual: 0-1,3    Expected: 3
> 
>   Example 2 - Expanding to a previously excluded CPU fails to request it:
> 
>     # cd /sys/fs/cgroup
>     # echo "0-1" > a1/cpuset.cpus
>     # echo "root" > a1/cpuset.cpus.partition
>     # echo "0-2" > b1/cpuset.cpus
>     # echo "root" > b1/cpuset.cpus.partition
>     # echo "member" > a1/cpuset.cpus.partition
>     # echo "1-2" > b1/cpuset.cpus
>     # cat cpuset.cpus.effective
>     # Actual: 0-1,3    Expected: 0,3
> 
> Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
> ---
>  kernel/cgroup/cpuset.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..5a5fa2481467 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1821,11 +1821,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			deleting = cpumask_and(tmp->delmask,
>  					newmask, parent->effective_xcpus);
>  		} else {
> -			cpumask_andnot(tmp->addmask, xcpus, newmask);
> +			cpumask_andnot(tmp->addmask, cs->effective_xcpus, newmask);
>  			adding = cpumask_and(tmp->addmask, tmp->addmask,
>  					     parent->effective_xcpus);
>  
> -			cpumask_andnot(tmp->delmask, newmask, xcpus);
> +			cpumask_andnot(tmp->delmask, newmask, cs->effective_xcpus);
>  			deleting = cpumask_and(tmp->delmask, tmp->delmask,
>  					       parent->effective_xcpus);
>  		}
> @@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			part_error = PERR_NOCPUS;
>  			deleting = false;
>  			adding = cpumask_and(tmp->addmask,
> -					     xcpus, parent->effective_xcpus);
> +					     cs->effective_xcpus, parent->effective_xcpus);
>  		}
>  	} else {
>  		/*
> @@ -1886,7 +1886,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			part_error = PERR_NOCPUS;
>  			if (is_partition_valid(cs))
>  				adding = cpumask_and(tmp->addmask,
> -						xcpus, parent->effective_xcpus);
> +						     cs->effective_xcpus,
> +						     parent->effective_xcpus);
>  		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>  			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>  			struct cgroup_subsys_state *css;
Hi, Shaojie

The code change looks reasonable to me, but I think the comment above
the partcmd_update calculation should be updated as well.

Maybe it can be updated like this:

		 * Compute add/delete mask to/from effective_cpus
		 *
		 * For valid partition:
-		 *   addmask = exclusive_cpus & ~newmask
+		 *   addmask = cs->effective_xcpus & ~newmask
		 *			      & parent->effective_xcpus
-		 *   delmask = newmask & ~exclusive_cpus
+		 *   delmask = newmask & ~cs->effective_xcpus
		 *		       & parent->effective_xcpus
		 *
		 * For invalid partition:

Does this look reasonable to you?

Tested-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Thanks.

