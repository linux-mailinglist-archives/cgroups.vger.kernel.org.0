Return-Path: <cgroups+bounces-3683-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209C0931ABB
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19B81F2297D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF308136658;
	Mon, 15 Jul 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1+eF4zl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3B6E61B
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071084; cv=none; b=i9uHKmBwVhyqPnZdChzLav42lwCpD/9/3kuSQS7+eYHgOrC721aaBbuJT0loR2NjIUd0PkrC95OvcbeW/5/HiyCexYpp+F0/o9m9Qpe0BGGvvN1G90ofykxwt5s1HhV8DBHD6rghFeNr+QP3ROkJzSbS3zMemUeDHemjEpRogts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071084; c=relaxed/simple;
	bh=FlJP6cQ93Ht9xaenF/ZPVLXhGWE9+r0LZIr/jJpJbKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqTqKUBmT8RYn2urXRNzFf/ZbxXP45ooSRdTOy8C82W8kDV+jitGjxOKQrdfkWHMDJD/wQuhrqSzA38hHXKpRfqv3GN0Sh0jWU0p8SCelstFicw2vMA5F3qLSs5jCRKuVfMU0yW+RTNcIT7VJZoHa3udVPSbj0PyQe95Dn16z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1+eF4zl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+7wzqu/n+rBhls7jS0HpDNowfWD9bZEGhHazVfPs+A=;
	b=c1+eF4zlbwZbK7GfFrljffldrGepCOxa9GcKkWXIC3k0JXJCRZQnE+TLxdzEyga4wMW1NS
	lrU6YOwgkkI2np3C6HySRawKI0eL9Z8e4xWe8Y1qBZ/kpVNFYRCUsY8yf/Cri1EwDcmhNT
	6gRpyDpsZbtK6MPbQPSPNZlaKhkP+Mg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-CAJcaEkYPWuXQXt0JtVqsQ-1; Mon,
 15 Jul 2024 15:17:57 -0400
X-MC-Unique: CAJcaEkYPWuXQXt0JtVqsQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 601431955D4F;
	Mon, 15 Jul 2024 19:17:55 +0000 (UTC)
Received: from [10.22.9.29] (unknown [10.22.9.29])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 877591955D44;
	Mon, 15 Jul 2024 19:17:52 +0000 (UTC)
Message-ID: <e41a9286-8103-4897-83fc-f9185f4488e3@redhat.com>
Date: Mon, 15 Jul 2024 15:17:51 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2 4/5] cgroup/cpuset: Make cpuset.cpus.exclusive
 independent of cpuset.cpus
To: Petr Malat <oss@malat.biz>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xavier <ghostxavier@sina.com>,
 Peter Hunt <pehunt@redhat.com>
References: <20240617143945.454888-1-longman@redhat.com>
 <20240617143945.454888-5-longman@redhat.com>
 <CANMuvJkDjuPpcqMBM+zzNL3wA-1zVrshrMuy22kQKmLDxbsB7Q@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CANMuvJkDjuPpcqMBM+zzNL3wA-1zVrshrMuy22kQKmLDxbsB7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 7/15/24 11:56, Petr Malat wrote:
> Hi,
> I finally got some time to test this and it works exactly as we needed it to.
> Thanks a lot,
>    Petr

Thanks for the verification.

Cheers,
Longman

> On Mon, Jun 17, 2024 at 10:39:44AM -0400, Waiman Long wrote:
>> The "cpuset.cpus.exclusive.effective" value is currently limited to a
>> subset of its "cpuset.cpus". This makes the exclusive CPUs distribution
>> hierarchy subsumed within the larger "cpuset.cpus" hierarchy. We have to
>> decide on what CPUs are used locally and what CPUs can be passed down as
>> exclusive CPUs down the hierarchy and combine them into "cpuset.cpus".
>>
>> The advantage of the current scheme is to have only one hierarchy to
>> worry about. However, it make it harder to use as all the "cpuset.cpus"
>> values have to be properly set along the way down to the designated remote
>> partition root. It also makes it more cumbersome to find out what CPUs
>> can be used locally.
>>
>> Make creation of remote partition simpler by breaking the
>> dependency of "cpuset.cpus.exclusive" on "cpuset.cpus" and make
>> them independent entities. Now we have two separate hierarchies -
>> one for setting "cpuset.cpus.effective" and the other one for setting
>> "cpuset.cpus.exclusive.effective". We may not need to set "cpuset.cpus"
>> when we activate a partition root anymore.
>>
>> Also update Documentation/admin-guide/cgroup-v2.rst and cpuset.c comment
>> to document this change.
>>
>> Suggested-by: Petr Malat <oss@malat.biz>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |  4 +-
>>   kernel/cgroup/cpuset.c                  | 67 +++++++++++++++++--------
>>   2 files changed, 49 insertions(+), 22 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 722e4762c4e0..2e4e74bea6ef 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2380,8 +2380,8 @@ Cpuset Interface Files
>>   	cpuset-enabled cgroups.
>>
>>   	This file shows the effective set of exclusive CPUs that
>> -	can be used to create a partition root.  The content of this
>> -	file will always be a subset of "cpuset.cpus" and its parent's
>> +	can be used to create a partition root.  The content
>> +	of this file will always be a subset of its parent's
>>   	"cpuset.cpus.exclusive.effective" if its parent is not the root
>>   	cgroup.  It will also be a subset of "cpuset.cpus.exclusive"
>>   	if it is set.  If "cpuset.cpus.exclusive" is not set, it is
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 144bfc319809..fe76045aa528 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -87,7 +87,7 @@ static const char * const perr_strings[] = {
>>   	[PERR_NOTEXCL]   = "Cpu list in cpuset.cpus not exclusive",
>>   	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
>>   	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
>> -	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
>> +	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
>>   	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
>>   };
>>
>> @@ -127,19 +127,28 @@ struct cpuset {
>>   	/*
>>   	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
>>   	 *
>> -	 * This exclusive CPUs must be a subset of cpus_allowed. A parent
>> -	 * cgroup can only grant exclusive CPUs to one of its children.
>> +	 * The effective_cpus of a valid partition root comes solely from its
>> +	 * effective_xcpus and some of the effective_xcpus may be distributed
>> +	 * to sub-partitions below & hence excluded from its effective_cpus.
>> +	 * For a valid partition root, its effective_cpus have no relationship
>> +	 * with cpus_allowed unless its exclusive_cpus isn't set.
>>   	 *
>> -	 * When the cgroup becomes a valid partition root, effective_xcpus
>> -	 * defaults to cpus_allowed if not set. The effective_cpus of a valid
>> -	 * partition root comes solely from its effective_xcpus and some of the
>> -	 * effective_xcpus may be distributed to sub-partitions below & hence
>> -	 * excluded from its effective_cpus.
>> +	 * This value will only be set if either exclusive_cpus is set or
>> +	 * when this cpuset becomes a local partition root.
>>   	 */
>>   	cpumask_var_t effective_xcpus;
>>
>>   	/*
>>   	 * Exclusive CPUs as requested by the user (default hierarchy only)
>> +	 *
>> +	 * Its value is independent of cpus_allowed and designates the set of
>> +	 * CPUs that can be granted to the current cpuset or its children when
>> +	 * it becomes a valid partition root. The effective set of exclusive
>> +	 * CPUs granted (effective_xcpus) depends on whether those exclusive
>> +	 * CPUs are passed down by its ancestors and not yet taken up by
>> +	 * another sibling partition root along the way.
>> +	 *
>> +	 * If its value isn't set, it defaults to cpus_allowed.
>>   	 */
>>   	cpumask_var_t exclusive_cpus;
>>
>> @@ -230,6 +239,17 @@ static struct list_head remote_children;
>>    *   2 - partition root without load balancing (isolated)
>>    *  -1 - invalid partition root
>>    *  -2 - invalid isolated partition root
>> + *
>> + *  There are 2 types of partitions - local or remote. Local partitions are
>> + *  those whose parents are partition root themselves. Setting of
>> + *  cpuset.cpus.exclusive are optional in setting up local partitions.
>> + *  Remote partitions are those whose parents are not partition roots. Passing
>> + *  down exclusive CPUs by setting cpuset.cpus.exclusive along its ancestor
>> + *  nodes are mandatory in creating a remote partition.
>> + *
>> + *  For simplicity, a local partition can be created under a local or remote
>> + *  partition but a remote partition cannot have any partition root in its
>> + *  ancestor chain except the cgroup root.
>>    */
>>   #define PRS_MEMBER		0
>>   #define PRS_ROOT		1
>> @@ -709,6 +729,19 @@ static inline void free_cpuset(struct cpuset *cs)
>>   	kfree(cs);
>>   }
>>
>> +/* Return user specified exclusive CPUs */
>> +static inline struct cpumask *user_xcpus(struct cpuset *cs)
>> +{
>> +	return cpumask_empty(cs->exclusive_cpus) ? cs->cpus_allowed
>> +						 : cs->exclusive_cpus;
>> +}
>> +
>> +static inline bool xcpus_empty(struct cpuset *cs)
>> +{
>> +	return cpumask_empty(cs->cpus_allowed) &&
>> +	       cpumask_empty(cs->exclusive_cpus);
>> +}
>> +
>>   static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
>>   {
>>   	return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
>> @@ -1593,7 +1626,7 @@ EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
>>    * Return: true if xcpus is not empty, false otherwise.
>>    *
>>    * Starting with exclusive_cpus (cpus_allowed if exclusive_cpus is not set),
>> - * it must be a subset of cpus_allowed and parent's effective_xcpus.
>> + * it must be a subset of parent's effective_xcpus.
>>    */
>>   static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
>>   						struct cpumask *xcpus)
>> @@ -1603,12 +1636,7 @@ static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
>>   	if (!xcpus)
>>   		xcpus = cs->effective_xcpus;
>>
>> -	if (!cpumask_empty(cs->exclusive_cpus))
>> -		cpumask_and(xcpus, cs->exclusive_cpus, cs->cpus_allowed);
>> -	else
>> -		cpumask_copy(xcpus, cs->cpus_allowed);
>> -
>> -	return cpumask_and(xcpus, xcpus, parent->effective_xcpus);
>> +	return cpumask_and(xcpus, user_xcpus(cs), parent->effective_xcpus);
>>   }
>>
>>   static inline bool is_remote_partition(struct cpuset *cs)
>> @@ -1887,8 +1915,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   	 */
>>   	adding = deleting = false;
>>   	old_prs = new_prs = cs->partition_root_state;
>> -	xcpus = !cpumask_empty(cs->exclusive_cpus)
>> -		? cs->effective_xcpus : cs->cpus_allowed;
>> +	xcpus = user_xcpus(cs);
>>
>>   	if (cmd == partcmd_invalidate) {
>>   		if (is_prs_invalid(old_prs))
>> @@ -1916,7 +1943,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>   		return is_partition_invalid(parent)
>>   		       ? PERR_INVPARENT : PERR_NOTPART;
>>   	}
>> -	if (!newmask && cpumask_empty(cs->cpus_allowed))
>> +	if (!newmask && xcpus_empty(cs))
>>   		return PERR_CPUSEMPTY;
>>
>>   	nocpu = tasks_nocpu_error(parent, cs, xcpus);
>> @@ -3130,9 +3157,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>   				       ? partcmd_enable : partcmd_enablei;
>>
>>   		/*
>> -		 * cpus_allowed cannot be empty.
>> +		 * cpus_allowed and exclusive_cpus cannot be both empty.
>>   		 */
>> -		if (cpumask_empty(cs->cpus_allowed)) {
>> +		if (xcpus_empty(cs)) {
>>   			err = PERR_CPUSEMPTY;
>>   			goto out;
>>   		}
>> --
>> 2.39.3
>>


