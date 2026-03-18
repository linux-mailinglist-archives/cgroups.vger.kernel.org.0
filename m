Return-Path: <cgroups+bounces-14865-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI39NHByumkeWwIAu9opvQ
	(envelope-from <cgroups+bounces-14865-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:37:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A1A2B9324
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C70300FED8
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D03B52E2;
	Wed, 18 Mar 2026 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ypP9VK+e"
X-Original-To: cgroups@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27753393DF3;
	Wed, 18 Mar 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826369; cv=fail; b=J3CfkYYEsfUFVQrgEoImGxVyZfUWtSTM9xkSDk9fChRHMcvu/cg15HaranJtxSFu80qzgnHArrPvbX27SVi9nYsURHRLP/BucfaNGbuFEOkEiEMFEMnES95Ahn4VJttxxeHCpGj4aQe7nNgeQSUSpcvzxJjW6zl12BrvXye9nEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826369; c=relaxed/simple;
	bh=cvagSIo2UpOIuFFzeao8ypwje/jVTsZpGLNrYMI7Qs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X2+0oiQYTUOYQ/Q3gS7hwMo2M1hlmGCPLChuZMVyIDbrRE+sm+Y8TVFs051XApCpZq7SdJWTNUm8C7TkDAwRHKDZ/kwPpqaHWXMSF6hyZQz+rFMTqi1s5VyVRjtlXvXn7j76lxIZqrVNhC0J2+f4+GpBxzC0dBd7swTpecZOj6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ypP9VK+e; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aooSmtPyvVR2/767cEXh963KOUC74L6CSERDmimhbW1H9XaZWsj5Et+17tbXUuc3I+KIlrBFgQJzfVn4Jsrg3eXnr3pIkequv154tvEW+hUCJuNZ8EGKMlax0hI49BgG27UY92IWg57VN0LBA8QhMf5XxXox7rMiBietlTCIr9NF6f7PROSP1FpGWf0hLRXNofPBknoAQMJe+Y/5VwHH8rVohxIRMfWIhdQCcjQ3jJ+/hd+ujF3IrdvN2TmXHzF6aXLNwCQSrpB+ji7b7v5pPPduzHk6GXRObus2o+u9PzEs5jQsAYfGlcJ+vY0rs50Q1TFYUOfANUfJY/nGaFS6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v14JJt8qBRmheluL8WhscTlnxVjTxqLotd2a4DQe3L8=;
 b=S71Cb59QtHC4B8zyo/y/cN3cddhn+cpvwId4Rbd1gymwzGprrnOAC7GuZSkp2DfG6j/lm26KRG6vjC2FDydLg3eWLL8KX3ZWtD0DDN2HfL6qLc0ipq+TQdSUBIt3HPOh3QXn9/Iq0ZBnvYretzTIHVNK4CvxckX8RY3DvpAPUgQ4OoWHfyzazmPs48Ooa7sra+H9rz4mYNe7EpQlzTtbCQxCfFdRj90+lVDxvfASbXLKb8BukvougD/BCo6hrk1TMW5/JXXiqPzdWmfavWN4xE/cDGkcZjrjI70kDTBrlGQ1Dn0PtJoCBFm2bghIm60pm8ZynHBICucqoLqORmVSLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v14JJt8qBRmheluL8WhscTlnxVjTxqLotd2a4DQe3L8=;
 b=ypP9VK+eSx//IqnyAxNQx+HRr0KWR3D4fvKKETcoCdr44dP8yf85g4m21uT0A3Uye0GsmRfLXuHNkYrdky8P0tgGbUDkHY8Ege2jCId6S4Uql4CI+NHQ7ziDcws9MR1VViqPvtc9MRf9FnU27B64gD1URjYfTRxL3MXgG+rq/xs=
Received: from CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::35)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 09:32:39 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::a8) by CH0P223CA0009.outlook.office365.com
 (2603:10b6:610:116::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend
 Transport; Wed, 18 Mar 2026 09:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 09:32:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 04:32:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 02:32:38 -0700
Received: from [10.136.37.230] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 04:32:33 -0500
Message-ID: <b161c993-6f6c-44ca-b836-1b286059bad8@amd.com>
Date: Wed, 18 Mar 2026 15:02:27 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 8/8] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>
References: <20260317095113.387450089@infradead.org>
 <20260317104343.338573840@infradead.org>
 <dc1a390f-16de-49b2-af85-a9df3f62eb8e@amd.com>
 <20260318090255.GG3738010@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260318090255.GG3738010@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: e522778d-9d92-4221-0adb-08de84d14bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HTAzXrZ9CnTFmOJd317NFOyR3T9L5zsan2rH2beXIUWW29S+JXuX/M/1swrW0vjBq+9PhJdb6g2ryWpPuG+OZiYAZ9tn9k6W+8UZoVNoBW34dF+M3+rSVhuXUBV5QOzTkm2n9sr4Gg37B/leysmk0umGo2R28IIWsJ9WRaJBnsuIukuiP2ESoIb2djDBMQAwI2WHM+XBTnTDtashidFAKCry82J8fpNaJd1uGjQjc/Lv8D37tuX+esrca9/mnKkI6xrGTYwMMpUwtf6DrgvcWQTwAhb4HsLmhxxcUU2jMONTIW31WenxQ674vHWmYoJfBXvOgH3V1TjbB7k/aAJs4epHG5VWjKc0wq1S5v8wywZIiTVYzhUF3Reu37PDYCJ62UqTbeu43a4tyNb54NC7F1CBmt8xJupSTEiwyq2T5BJRESvQalzvVUkqWGJX5wYKICDS8o1U7sl7fCShhgxvbMZvlw12rYQkxpVJXtH4bmZW9bWiRpsq9bJyaqJkfCBeUQdC8Gm31/rTQzkI2wvk/KYKD9kgE399dqZL74jxUhHmX107ViWWYceOWaYWb1IqANX0M/cVMdNHCQTuttls1SdARP/WeEoPi1zST14QbAMg+zBlPFyCnFAIPng5tye0sGU+V7rKpYRxQwUMDjkFqrLoqAstl7+Dld8U2bffNxkiNYCHYhwg39M8C7QwwkFNoBTksWHnT5S58pohnCwKYnB152DYG2SFdRmye0fa6B8JCXRsO3SVrSd73i1JMn1/eetTBBDj1DEesLHjrj1FQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xCX7pLC48vj8mApCrHbrjBS4OqE+vx+8KnwFja5qQdCQA81D0qclIRQ/QeDcCRpnoCUSLueRUmOZh97ycHvsP5WwoGkIWHCIVN6R5eae+uxatRtmaJWsIxFll8esaG6Zyp9VEE8l9lK5b0o6O93x3vz3TY+6UWgKri4/41XH4MOboMcr4kL2t4xtRfaFQxJ1y0a1G5wMcO5EC9TiWzPAdQd/7Wqv7QrA7hCgDnw6JsFoMbZtCzHDCn4OQpv9t6oR8nJ3SfPvO3c2gK9+LDEkFRhcBDDYPWvfxOuENLSwpxAQbgL3z9+MU9F/M+35DA2dflH1F98l+4QYb2Rvvx+1Bq8UDSJiFnzkK07nVbj3EkJiB+gAb8rjGGfCoe+3G79BrEmptr6fJbAekROSE1OssMQTkoIM7p1pCFFuFM1xpLSeBYLF2TiBnFX7wnFF3BLM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:32:38.7346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e522778d-9d92-4221-0adb-08de84d14bca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14865-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 62A1A2B9324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Peter,

On 3/18/2026 2:32 PM, Peter Zijlstra wrote:
> On Tue, Mar 17, 2026 at 11:16:52PM +0530, K Prateek Nayak wrote:
> 
>>> +	/*
>>> +	 * XXX comment on the curr thing
>>> +	 */
>>> +	curr = (cfs_rq->curr == se);
>>> +	if (curr)
>>> +		place_entity(cfs_rq, se, flags);
>>>  
>>> +	if (se->on_rq && se->sched_delayed)
>>> +		requeue_delayed_entity(cfs_rq, se);
>>>  
>>> +	weight = enqueue_hierarchy(p, flags);
>>
>> Here is question I had when I first saw this on sched/flat and I've
>> only looked at the series briefly:
>>
>> enqueue_hierarchy() would end up updating the averages, and reweighing
>> the hierarchical load of the entities in the new task's hierarchy ...
>>
>>>  
>>> +	if (!curr) {
>>> +		reweight_eevdf(cfs_rq, se, weight, false);
>>> +		place_entity(cfs_rq, se, flags | ENQUEUE_QUEUED);
>>
>> ... and the hierarchical weight of the newly enqueued task would be
>> based on this updated hierarchical proportion.
>>
>> However, the tasks that are already queued have their deadlines
>> calculated based on the old hierarchical proportions at the time they
>> were enqueued / during the last task_tick_fair() for an entity that
>> was put back.
>>
>> Consider two tasks of equal weight on cgroups with equal weights:
>>
>>     root    (weight: 1024)
>>    /    \
>>   CG0   CG1 (wight(CG0,CG1) = 512)
>>    |     |
>>    T0    T1 (h_weight(T0,T1) = 256)
>>
>>
>> and a third task of equal weight arrives (for the sake of simplicity
>> also consider both cgroups have saturated their respective global
>> shares on this CPU - similar to UP mode):
>>
>>
>>                             root        (weight: 1024)
>>                            /    \
>>          (weight: 512)   CG0    CG1     (weight: 512)
>>                          /     /   \
>>   (h_weight(T0) = 256)  T0    T1    T2  (h_weight(T2) = 128)
>>                        
>>                            (h_weight(T1) = 256)
>>
>>
>> Logically, once T2 arrives, T1 should also be reweighed, it's
>> hierarchical proportions be adjusted, and its vruntime and deadline
>> be also adjusted accordingly based on the lag but that doesn't
>> happen.
> 
> You are absolutely right.
> 
>> Instead, we continue with an approximation of h_load as seen
>> sometime during the past. Is that alright with EEVDF or am I missing
>> something?
> 
> Strictly speaking it is dodgy as heck ;-) I was hoping that on average
> it would all work out. Esp. since PELT is a fairly slow and smooth
> function, the reweights will mostly be minor adjustments.

For a stable system, that is correct, but with a bunch of migration
in the mix, even the averages tend to move quite rapidly which is
why we already ratelimit the tg->shares calculation to once per
millisecond :-)

> 
>> Can it so happen that on SMP, future enqueues, and SMP conditions
>> always lead to larger h_load for the newly enqueued tasks and as a
>> result the older tasks become less favorable for the pick leading
>> to starvation? (Am I being paranoid?)
> 
> So typically the most recent enqueue will always have the smaller
> fraction of the group weight. This would lead to a slight favour to the
> older enqueue. So I think this would lead to a FIFO like bias.
> 
> But there is definitely some fun to be had here.
> 
> One definite fix is setting cgroup_mode to 'up' :-)

A definite fix indeed but I'm pretty sure people will start complaining
about more preemptions, etc. now that their cgroups have lost the
nice -20 equivalent privilege on these large systems and people have to
go and change these shares to painfully small values for performance.

> 
>>> +		__enqueue_entity(cfs_rq, se);
>>>  	}
>>>  
>>>  	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
>>
>> Anyhow, me goes and sees if any of this makes a difference to the
>> benchmarks - I'll throw the biggest one at it first and see how
>> that goes.
> 
> Thanks, fingers crossed. :-)

Last time I ran sched/flat, it held up surprisingly well actually.
Performance was not terribly bad (and evne better in some cases) but
that was before we flushed out the whole increased weight bits for
EEVDF calculations so maybe it is all better now.

We'll know soon enough ;-)

-- 
Thanks and Regards,
Prateek


