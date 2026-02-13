Return-Path: <cgroups+bounces-13950-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBccIMFDj2k5OgEAu9opvQ
	(envelope-from <cgroups+bounces-13950-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 16:31:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CB4137935
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 16:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90E02304AD9E
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D5363C43;
	Fri, 13 Feb 2026 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN+nguIF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJT21oC8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1E363C78
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996499; cv=none; b=NWBO2FQhg09SUS6eGZ493YzsyoRc2FZyW+cQKD6d/83pA/O9YFJyWlXAAOyIonac6LVXU1eTIMscTJAqzh3Fa3h8pgTeRsn28K0upx1alRs83a5TBwD34uMea8nuaUA6ege8YaNFFcff8obxztswtVuxUZd+QDN33cQzx/RIzPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996499; c=relaxed/simple;
	bh=3M3E4Pv8nQu84Lj5f737cCeSV/g3fnZSngPVN4h20sE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nYRlljWLH1QX2OLHQdwJ4pwziTVt8gL0VHcDOKspRMI+mJ+28gSnIHNxi/8dlUHK4mHLJkNTKnQeG2m8EP/UAu9tuyovbjbXkYPey+sJXH7MJqtXkT61t5bM3JhkEV6BWxqmmoDCRYrJjIA7eXwM9QKXF6Wd72fEcZ86a8/vRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dN+nguIF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJT21oC8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770996497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfr51n5j+28dMTjZs7Bnjba1XL/y2WrPwNbz10SYRpM=;
	b=dN+nguIFDUC3uYypBvNY/0nh4S8pWswL5pUPhELwWLmJ/6hNFqceRPnqx2AKQ+SN+dFXhp
	7yur91RG6el713M8AmpAOZlGKEtO9ttjStw08XQAOidzFy4GpvJeuHjaHqq8Duw1nEaQ6w
	VB5qUacjvCRn3z+gsnMc5uZ8SGIXbuk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-DPRWEQINNjuidrvMLNRsow-1; Fri, 13 Feb 2026 10:28:13 -0500
X-MC-Unique: DPRWEQINNjuidrvMLNRsow-1
X-Mimecast-MFC-AGG-ID: DPRWEQINNjuidrvMLNRsow_1770996493
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70cff1da5so356376885a.2
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770996493; x=1771601293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rfr51n5j+28dMTjZs7Bnjba1XL/y2WrPwNbz10SYRpM=;
        b=VJT21oC8AdSRHXy1xZFuGjA8NT/3WrfHniTDYj8neMoPAV6340aGwdxgpnfJzB+U/T
         RWQGARw3vKlvAdgMh0dBOt8pJqhKntLnkJ/HQFowBitM1RgJKqvi1aAzsnVo+Yqpmqpj
         qz7cd4jZWDO7k301hStlpw5+l2bUIZlQAzIWa4HAQkMVP/Tf4LWsqIkOipBDfr/jylGz
         y1jhz24Mc2lnNSrCC0+MMAQdxk5Sy16jiUB0uWX9GafMVPwsctrngqvhsWXi1eekaP1u
         mctFd00jJp05/ILghcg9ozBVXOd7MnBNan3LQO/BOFhnTkMugitZeS/2EnILhOagEijR
         wxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996493; x=1771601293;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfr51n5j+28dMTjZs7Bnjba1XL/y2WrPwNbz10SYRpM=;
        b=fFgUvHaJzJXGtnfEOsx8aIjID5FvzbA0HADlCmawYRMNdEqnHtwKCjm0xP1Y5KvklV
         4fM/NYpCf1WuDGHppshQppJ3zHb1CWsxo11UQj4Yy8Ix/0tcxuf3wn/mcXQdg4HFrP4r
         YRGp8Ji7r5fmy/hmgX2cZvgGpV58mARY/sxcsrLfDQVf1+4aKFuahzcgcJG2vvd6iww6
         xLEgbqI8+XNj9etw1BtRYneqE0CqwkND2jP5yUCsMkyQyPH38WYVAv3kFcX2wkmD0MKU
         Bn0R3LWCibmOYmYb7PjGEcyIsZR0IZiXb47TldwDzkrQybj7Ttho/+AjxF8F2HXh1onZ
         21Og==
X-Gm-Message-State: AOJu0YwlvDbXgdxcpvL3XXhyG6hsINCInGvOpcQP56gyzybet4IpXLWr
	5qCJ6aJQePizOCtwonPHnMuA0B3fZZc/u27x0Y0JLnHWrgCL5PsZ+X+pfJx7Na8JD+sW75/m0Kg
	QVWb/4pPc+3t2TIF4df+eCQGMTiMITs6WqtpX3dbI0t3k6s3D03KKWXiyzgM=
X-Gm-Gg: AZuq6aL7e/2G68VZNue/67kKGvOSRqAAZ0MmDjQ+9Th3qlwBIZ36djfkeLisBbqWv6X
	O761+EaZrDy1osHh4vBMVpelAgjcTUz5W8+MmswBl3tQON6Zpf0P4InZ+9XpKQycK8JnEcpr6aE
	Wv+I+dXrJX2vhMYM6CQAAt7tiL9O58mkHdjnCxAS8Cc1HsBAB2Z59D0s9DsDPQB3PJWwwdo90wZ
	lTf+yjwqUI2hi1GFF5/AGa4RaTdRmqbKGGLgkV/YTi11d69E5FHkcu8NN+IFQcmCp+rORIDwwis
	SJNAvOsA5yB5qETfddTz5SlmvIZ8HagCdBeEOGUABCJVZcslKX2cg3lP3nFbJuQPgGi2TGzAwgX
	OPk8gEiJhc6DHaIwTk5Ol3HHKDLs3hHA1SlHT6mNBZceKnkN7O85ZLKo6QPSv7uGZI3rF
X-Received: by 2002:a05:620a:3947:b0:8bb:a960:a6fd with SMTP id af79cd13be357-8cb4081fab2mr354349185a.10.1770996493195;
        Fri, 13 Feb 2026 07:28:13 -0800 (PST)
X-Received: by 2002:a05:620a:3947:b0:8bb:a960:a6fd with SMTP id af79cd13be357-8cb4081fab2mr354345985a.10.1770996492739;
        Fri, 13 Feb 2026 07:28:12 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0be6besm617767885a.5.2026.02.13.07.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 07:28:11 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <dcb4debf-e166-491e-8f7b-5500e5e8a39c@redhat.com>
Date: Fri, 13 Feb 2026 10:28:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] cgroup/cpuset: Don't update isolated_cpus from CPU
 hotplug
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
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
 <20260212164640.2408295-5-longman@redhat.com>
 <de1cf3d0-8922-4740-9e4f-501cc38c70b0@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <de1cf3d0-8922-4740-9e4f-501cc38c70b0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13950-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5CB4137935
X-Rspamd-Action: no action

On 2/12/26 10:28 PM, Chen Ridong wrote:
>
> On 2026/2/13 0:46, Waiman Long wrote:
>> As any change to isolated_cpus is going to be propagated to the
>> HK_TYPE_DOMAIN housekeeping cpumask, it can be problematic if
>> housekeeping cpumasks are directly being modified from the CPU hotplug
>> code path. This is especially the case if we are going to enable dynamic
>> update to the nohz_full housekeeping cpumask (HK_TYPE_KERNEL_NOISE)
>> in the near future with the help of CPU hotplug.
>>
>> Avoid these potential problems by changing the cpuset code to not
>> updating isolated_cpus when calling from CPU hotplug. A new special
>> PRS_INVALID_ISOLCPUS is added to indicate the current cpuset is an
>> invalid partition but its effective_xcpus are still in isolated_cpus.
>> This special state will be set if an isolated partition becomes invalid
>> due to the shutdown of the last active CPU in that partition. We also
>> need to keep the effective_xcpus even if exclusive_cpus isn't set.
>>
>> When changes are made to "cpuset.cpus", "cpuset.cpus.exclusive" or
>> "cpuset.cpus.partition" of a PRS_INVALID_ISOLCPUS cpuset, its state
>> will be reset back to PRS_INVALID_ISOLATED and its effective_xcpus will
>> be removed from isolated_cpus before proceeding.
>>
>> As CPU hotplug will no longer update isolated_cpus, some of the test
>> cases in test_cpuset_prs.h will have to be updated to match the new
>> expected results. Some new test cases are also added to confirm that
>> "cpuset.cpus.isolated" and HK_TYPE_DOMAIN housekeeping cpumask will
>> both be updated.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 85 ++++++++++++++++---
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 21 +++--
>>   2 files changed, 87 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c792380f9b60..48b7f275085b 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -159,6 +159,8 @@ static bool force_sd_rebuild;			/* RWCS */
>>    *   2 - partition root without load balancing (isolated)
>>    *  -1 - invalid partition root
>>    *  -2 - invalid isolated partition root
>> + *  -3 - invalid isolated partition root but with effective xcpus still
>> + *	 in isolated_cpus (set from CPU hotplug side)
>>    *
>>    *  There are 2 types of partitions - local or remote. Local partitions are
>>    *  those whose parents are partition root themselves. Setting of
>> @@ -187,6 +189,7 @@ static bool force_sd_rebuild;			/* RWCS */
>>   #define PRS_ISOLATED		2
>>   #define PRS_INVALID_ROOT	-1
>>   #define PRS_INVALID_ISOLATED	-2
>> +#define PRS_INVALID_ISOLCPUS	-3 /* Effective xcpus still in isolated_cpus */
>>   
>>   /*
>>    * Temporary cpumasks for working with partitions that are passed among
>> @@ -382,6 +385,30 @@ static inline bool is_in_v2_mode(void)
>>   	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>>   }
>>   
>> +/*
>> + * If the given cpuset has a partition state of PRS_INVALID_ISOLCPUS,
>> + * remove its effective_xcpus from isolated_cpus and reset its state to
>> + * PRS_INVALID_ISOLATED. Also clear effective_xcpus if exclusive_cpus is
>> + * empty.
>> + */
>> +static void fix_invalid_isolcpus(struct cpuset *cs, struct cpuset *trialcs)
>> +{
>> +	if (likely(cs->partition_root_state != PRS_INVALID_ISOLCPUS))
>> +		return;
>> +	WARN_ON_ONCE(cpumask_empty(cs->effective_xcpus));
>> +	spin_lock_irq(&callback_lock);
>> +	cpumask_andnot(isolated_cpus, isolated_cpus, cs->effective_xcpus);
>> +	if (cpumask_empty(cs->exclusive_cpus))
>> +		cpumask_clear(cs->effective_xcpus);
>> +	cs->partition_root_state = PRS_INVALID_ISOLATED;
>> +	spin_unlock_irq(&callback_lock);
>> +	isolated_cpus_updating = true;
>> +	if (trialcs) {
>> +		trialcs->partition_root_state = PRS_INVALID_ISOLATED;
>> +		cpumask_copy(trialcs->effective_xcpus, cs->effective_xcpus);
>> +	}
>> +}
> When fix_invalid_isolcpus is called from changing cpus/exclusive cpus, should we
> copy cs->effective_xcpus to trialcs->effective_xcpus?
>
> I tested as follow steps(using the whole series):
>
>   # cd /sys/fs/cgroup/
>   # mkdir test
>   # echo 1 > cpuset.cpus.
>   # cd test/
>   # echo 1 > cpuset.cpus.exclusive
>   # echo $$ > cgroup.procs
>   # echo isolated > cpuset.cpus.partition
>   # cat cpuset.cpus.partition
> isolated
>   # echo 0 > /sys/devices/system/cpu/cpu1/online
>   # cat cpuset.cpus.partition
> isolated invalid
>   # echo 2 > cpuset.cpus.exclusive
>   # cat cpuset.cpus.partition
> isolated invalid (Parent unable to distribute cpu downstream)
>
> After changing cpuset.cpus.exclusive to 2, the test cpuset should
> become valid again, but it remains invalid.

Right, changes to trialcs->effective_xcpus is unnecessary() as 
compute_trialcs_excpus() will be called before fix_invalid_isolcpus() is 
invoked. Will fix that in the next version.

Thanks,
Longman


