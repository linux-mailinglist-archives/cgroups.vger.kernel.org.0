Return-Path: <cgroups+bounces-16323-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPGQM1rwFWp7fQcAu9opvQ
	(envelope-from <cgroups+bounces-16323-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 21:11:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8435DBCF8
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 21:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9A2E304623F
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 19:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FBD3C0A11;
	Tue, 26 May 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivLe6tSs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A83C09EE
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822573; cv=none; b=KnaJ+JR58szlbryOpICZVFwTkA9ONg3HXJJ/VGh52Uf4LLX5TteBb39DpsGD1X6J+bVQ40deAiUycugIbH1qZtTuznQrPyq1FFR0ONkq2wKbaorS7sEOIId0Ge4YxIZiGZCxM7ijUROmYGrgPQWAS/j9/NS17y5SvUheLnTgyRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822573; c=relaxed/simple;
	bh=TTuLhNwRTfTLxZeJ+SuAgj27dQeErLAdR5dNCF27vtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw4J3SMAidUMeFqCLyPkbcxQ4Dg0VaNcjw+0NJ6kCB5+lSxCkSdv891Epyy36NlVvcLQLaAsmt/zeQ9hw2ihHfj/5weWgjr2umqc+JoTBH8kUFZFTOYVQ3TyjpIepbAgEczO7QRuLlek0zxjfry6G+ZgPZjG7Er/B1eDRaLKDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivLe6tSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779822571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfSdtXF2WOriI1uDkmCMHGwzpoCJM5Y7nO9dwQTIrxE=;
	b=ivLe6tSsLQEzpIJC5DSsjjKSk1oi3TuuzvPvNrLfyaY8vWPnZG78yl4Md6ZYlqT5pcHmMg
	Jqn68zY6IuLDBqZOdiSDlVPosPlMQG8ZSkpUDTrstvDI2Hm23GNKpRzyHFOZyu4bzD3GBD
	7H/4DqeEZVrzhWJ4R84xkCNXAdulcAM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Y4fB0hNYNFOWg0IRFAgrHA-1; Tue,
 26 May 2026 15:09:27 -0400
X-MC-Unique: Y4fB0hNYNFOWg0IRFAgrHA-1
X-Mimecast-MFC-AGG-ID: Y4fB0hNYNFOWg0IRFAgrHA_1779822566
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C34A618005B6;
	Tue, 26 May 2026 19:09:25 +0000 (UTC)
Received: from [10.22.65.22] (unknown [10.22.65.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B176D1956056;
	Tue, 26 May 2026 19:09:23 +0000 (UTC)
Message-ID: <6a439b99-d4e5-4686-b957-baf3b7843b49@redhat.com>
Date: Tue, 26 May 2026 15:09:22 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Use effective_xcpus in partcmd_update
 add/del mask calculation
To: Guopeng Zhang <zhangguopeng@kylinos.cn>,
 Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260522075357.127075-1-sunshaojie@kylinos.cn>
 <a1a89205-4e4b-4bb9-86fe-e106997ab1d5@kylinos.cn>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a1a89205-4e4b-4bb9-86fe-e106997ab1d5@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16323-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: 6F8435DBCF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 4:41 AM, Guopeng Zhang wrote:
>
> 在 2026/5/22 15:53, Sun Shaojie 写道:
>> When sibling CPU exclusion occurs, a partition's user_xcpus may contain
>> CPUs that were never actually granted to it. These CPUs are present in
>> user_xcpus(cs) but not in cs->effective_xcpus.
>>
>> The partcmd_update path in update_parent_effective_cpumask() uses
>> user_xcpus(cs) (via the local variable xcpus) to compute the addmask
>> (CPUs to return to parent) and delmask (CPUs to request from parent).
>> This is incorrect:
>>
>>   1) When newmask removes a CPU that was previously excluded by a
>>      sibling, addmask incorrectly includes that CPU and tries to return
>>      it to the parent even though the partition never actually owned it,
>>      causing CPU overlap with sibling partitions and triggering warnings
>>      in generate_sched_domains().
>>
>>   2) When newmask adds a previously excluded CPU that is now available,
>>      delmask fails to request it from the parent because user_xcpus(cs)
>>      already includes it.
>>
>> Fix this by using cs->effective_xcpus instead of user_xcpus(cs) in all
>> partcmd_update paths that calculate addmask or delmask, including the
>> PERR_NOCPUS error handling paths.
>>
>> Reproducers:
>>
>>    Example 1 - Removing a sibling-excluded CPU incorrectly returns it:
>>
>>      # cd /sys/fs/cgroup
>>      # echo "0-1" > a1/cpuset.cpus
>>      # echo "root" > a1/cpuset.cpus.partition
>>      # echo "0-2" > b1/cpuset.cpus
>>      # echo "root" > b1/cpuset.cpus.partition
>>      # echo "2" > b1/cpuset.cpus
>>      # cat cpuset.cpus.effective
>>      # Actual: 0-1,3    Expected: 3
>>
>>    Example 2 - Expanding to a previously excluded CPU fails to request it:
>>
>>      # cd /sys/fs/cgroup
>>      # echo "0-1" > a1/cpuset.cpus
>>      # echo "root" > a1/cpuset.cpus.partition
>>      # echo "0-2" > b1/cpuset.cpus
>>      # echo "root" > b1/cpuset.cpus.partition
>>      # echo "member" > a1/cpuset.cpus.partition
>>      # echo "1-2" > b1/cpuset.cpus
>>      # cat cpuset.cpus.effective
>>      # Actual: 0-1,3    Expected: 0,3
>>
>> Fixes: 2a3602030d80 ("cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict")
>> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
>> ---
>>   kernel/cgroup/cpuset.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 1335e437098e..5a5fa2481467 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1821,11 +1821,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   			deleting = cpumask_and(tmp->delmask,
>>   					newmask, parent->effective_xcpus);
>>   		} else {
>> -			cpumask_andnot(tmp->addmask, xcpus, newmask);
>> +			cpumask_andnot(tmp->addmask, cs->effective_xcpus, newmask);
>>   			adding = cpumask_and(tmp->addmask, tmp->addmask,
>>   					     parent->effective_xcpus);
>>   
>> -			cpumask_andnot(tmp->delmask, newmask, xcpus);
>> +			cpumask_andnot(tmp->delmask, newmask, cs->effective_xcpus);
>>   			deleting = cpumask_and(tmp->delmask, tmp->delmask,
>>   					       parent->effective_xcpus);
>>   		}
>> @@ -1864,7 +1864,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   			part_error = PERR_NOCPUS;
>>   			deleting = false;
>>   			adding = cpumask_and(tmp->addmask,
>> -					     xcpus, parent->effective_xcpus);
>> +					     cs->effective_xcpus, parent->effective_xcpus);
>>   		}
>>   	} else {
>>   		/*
>> @@ -1886,7 +1886,8 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   			part_error = PERR_NOCPUS;
>>   			if (is_partition_valid(cs))
>>   				adding = cpumask_and(tmp->addmask,
>> -						xcpus, parent->effective_xcpus);
>> +						     cs->effective_xcpus,
>> +						     parent->effective_xcpus);
>>   		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>>   			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>>   			struct cgroup_subsys_state *css;
> Hi, Shaojie
>
> The code change looks reasonable to me, but I think the comment above
> the partcmd_update calculation should be updated as well.
>
> Maybe it can be updated like this:
>
> 		 * Compute add/delete mask to/from effective_cpus
> 		 *
> 		 * For valid partition:
> -		 *   addmask = exclusive_cpus & ~newmask
> +		 *   addmask = cs->effective_xcpus & ~newmask
> 		 *			      & parent->effective_xcpus
> -		 *   delmask = newmask & ~exclusive_cpus
> +		 *   delmask = newmask & ~cs->effective_xcpus
> 		 *		       & parent->effective_xcpus
> 		 *
> 		 * For invalid partition:
>
> Does this look reasonable to you?
>
> Tested-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Shaojie, thanks for the fix. The changes look good to me. I also like 
the suggested changes in the comment as suggested by Guopeng. Would you 
mind sending a v2 with this additional change as well?

Thanks,
Longman


