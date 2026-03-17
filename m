Return-Path: <cgroups+bounces-14849-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDk5O1mYuWkJKwIAu9opvQ
	(envelope-from <cgroups+bounces-14849-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 19:07:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 704002B0A00
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09EAC31F9D11
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD2C37CD51;
	Tue, 17 Mar 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MqwSCR7Z"
X-Original-To: cgroups@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3A337B81;
	Tue, 17 Mar 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769639; cv=fail; b=Rj+iKld69zKiTkzjxSmlzBPLX457MNy5wPTxOjihiM3xKkWGld1MZOaeUZIhC/RFDYEc+wpWCzuCVPnSkjU1hrQqUYDtfdYZYxOs/o6/SZZWIcweDMmSi7mwGr71hKtks0gw/mK/9LXG5+x8V1ycpc6tRGPTRyCVsekAQ1r3ejA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769639; c=relaxed/simple;
	bh=rnUReQZX8KYlzTZXA1IrgytbmhzkIxTLf9nLsbOmExs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4Ffkgg45lacHNAvxa0pcpmPW981JYYNzpA/i8NQbORzfJqcMGNseqXlJjXiPPMZjXcO9tOcgg8d882zqSLcyuypoyCgn/zyO8F2AIpAX2KXBUVB+aMgCw6c8wo5d7GGcVMZgtvvCB0VM/85/E83hTts9S0AvxzLpnlbpzjqFA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MqwSCR7Z; arc=fail smtp.client-ip=52.101.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpqg+MD7KvQAoxf5/zEK4+hdN1mLTBPeST8OQ7391ZKy1OvARelVX3ued9LpHlFtIQ6w/p0wS+HSIi+/O1R1dSWT2KffhslFRpPL8bImbytxCcYkqAgllm8UDAuq9MjWxjHTlms7UqH0XwqvOiEjwWIrVDzjTb3RjXpSgiHLPPD6v3gQCMuOXs+VcW7ESOJPI//KTCeuln0A9+XA8T7rHxoBAOAcci9z08UqqAQKn1ooEbqsxkSLQllq0xO9ZmvNYA4F4drXvpjfIp+rDE/E+zPqtP3Xp4Je1iVHzkb9STeXneRdSwTxESNfcPtxtjRSsVYhy4kKmQjS69/0dCXzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb7NPeVkxmWnfTDql0rzypgE8bE4vyi9jJyUbbzsnJU=;
 b=AkqcD7+yoc3TeF0hSc5reLascY1BiqYTpxSqY4XSqELepCkobIPThFYeuQFW5r5bPy098oaFBUr73cXYhgZyXvuBEe+OQSQnGTKBh5fcCX7m1rH05lU+cGVpSHtjdZ+0bR0xPsvZAePhwXc+iZic2yJqWOdEYyVrP1Rgw+00001LnwpLTjE0qFiWm+FFlnf3xyQVAebUmUj3FyC/AqPZ7AzVnCmDW1OAVLty0T1f6ScOaTorzi3nBQsbpMAGzKTvlotz1Xj2Wml+Jqf09meRLUVvgH7CI/0iHJmvd1CnsrXtpLQwYLaj9RAiMiygiNKCvCxQETMnUj7O2KE1DBGweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb7NPeVkxmWnfTDql0rzypgE8bE4vyi9jJyUbbzsnJU=;
 b=MqwSCR7ZLokYvGMbrOFErPKyEF3TWrlgcd0ylRLyBem+uu5dMmFY9qe7/ltyh7LxU2Gw/6rnvXd0ojhPQTaiHVHt2xp77QdtHcOhySzjiyGcVR5Z37i1Ank/bDK3HR2EqY5oUleg4HzQIgXI5yNmDLm6Ka4nrqilPZgWyBKeLZo=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 17:47:08 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::2c) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Tue,
 17 Mar 2026 17:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 17:47:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 12:46:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 12:46:59 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 12:46:53 -0500
Message-ID: <dc1a390f-16de-49b2-af85-a9df3f62eb8e@amd.com>
Date: Tue, 17 Mar 2026 23:16:52 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 8/8] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>
References: <20260317095113.387450089@infradead.org>
 <20260317104343.338573840@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260317104343.338573840@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: a57e4a79-1179-499d-ac44-08de844d34a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DaY/VJSi95sWJukUtpd1HD+Uq0nRsfZaxNR5YHS4ITd4qq8QeKwfhdC3GS8n+buZpTWV90dMbK5vBB723+E1d0YHr6eDc7KkgCzjX0vINtiPY+ptokCx3JJhRd6KnKd86Cvu5rpBSl/YpXZSARwWs5OlU+Z1sW9rF8o//h6xxzLCjEW/DqkgewpfqS4G2RedIOZ74WwzLIwe6ZNFa1K5WsLZ0rG1oC9u4n3YtFdFWh+lLC70Zdby7rnAQoh3mOk7L4PeCN+eUsMLMHmsNtKZwYPjOfWb1e+XYizvrvHjfJnD4jEAYKvGAmLcgutmK+EXeJWkIwQYsBSOjrXzfvHOOB18gW79bXrqftZUVnTlskdocPqgDrNXBeMHoI7OPB5YBmnZPv6oyT1VgkmQ+pkZR1VrMYlNMNn5B1NRgdZUIly9omTTkGBJLCvUOrHHteAuqg4p11VoiCVkW7MVMtqSmpFFwfLezwQsDnuEq85aR/wuJyfcB+S+9NOt7CaLsRpWR3jEUP3JQnoECuCau5oprY9wfpri50nP8pCkvz0oh8HUZkj7TXvZ3f6YuRLm7e2zbgbiXtRopanwNwPz/SFcGurGaZJzUJ4DcU0wPMvxc4bVj44jBqxdXJ/CC+eo5jhW/zKQVWk7D93FO4xY9MS3ovUsRR3Ci5OdxIgUwIscUz+XyzuNMYAfPpPrT16XxbyQ9rwh3u4s0E0QeurFdjPTnogknfuEeUoYIWpaAXSXgRFO41tT+kZtdGtCyNnq6+yCPFTSxCT4vyECdVG5r9y4WA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EvG45MNwogiUbafi5/JW6MEKJALTkbxuax/2KWZDfhLvpCmQglHEDKRHsOJxSR1hBQQWQDn+oNqXvrw3X8kmiBgwfyqUyAXnTgVxUnIZNtA+mZpBIIjE+ftQlqXMC4+7uuub9AJmtF+YNJ4jekBwwQAYBbo+IhdXUj55arzw2z9hTM/dvgUGoUHUKrmgDhF6vPaxMO4FS2RIesbPYMW4eIZB+d0hA0rHvIZXbIkbh4PWcSG17jrkT22sgCIMKlxGbGqoMI80GB7O4njF/6q0vLnG7HQQvM/82P2LUcc8ocdjlm0KBApxhFtPsrO0VHDXh7fS5uvX8QgrYzJ5iCmJ0WZZCm2hLR/NQ1BWJZqAkdLH6U50jXo5uqAHUnojhGZpEsYDpCrx8yehhEk+/tuauRqIvVqtBTEjto5BY8n7hn6x1EvoNRhugTmf4dwiNuVX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 17:47:06.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a57e4a79-1179-499d-ac44-08de844d34a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14849-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 704002B0A00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Peter,

On 3/17/2026 3:21 PM, Peter Zijlstra wrote:
> Change fair/cgroup to a single runqueue.

Looks like Christmas arrived early :-)

[..snip..]

> +	/*
> +	 * XXX comment on the curr thing
> +	 */
> +	curr = (cfs_rq->curr == se);
> +	if (curr)
> +		place_entity(cfs_rq, se, flags);
>  
> -		se->slice = slice;
> -		if (se != cfs_rq->curr)
> -			min_vruntime_cb_propagate(&se->run_node, NULL);
> -		slice = cfs_rq_min_slice(cfs_rq);
> +	if (se->on_rq && se->sched_delayed)
> +		requeue_delayed_entity(cfs_rq, se);
>  
> -		cfs_rq->h_nr_runnable += h_nr_runnable;
> -		cfs_rq->h_nr_queued++;
> -		cfs_rq->h_nr_idle += h_nr_idle;
> +	weight = enqueue_hierarchy(p, flags);

Here is question I had when I first saw this on sched/flat and I've
only looked at the series briefly:

enqueue_hierarchy() would end up updating the averages, and reweighing
the hierarchical load of the entities in the new task's hierarchy ...

>  
> -		if (cfs_rq_is_idle(cfs_rq))
> -			h_nr_idle = 1;
> +	if (!curr) {
> +		reweight_eevdf(cfs_rq, se, weight, false);
> +		place_entity(cfs_rq, se, flags | ENQUEUE_QUEUED);

... and the hierarchical weight of the newly enqueued task would be
based on this updated hierarchical proportion.

However, the tasks that are already queued have their deadlines
calculated based on the old hierarchical proportions at the time they
were enqueued / during the last task_tick_fair() for an entity that
was put back.

Consider two tasks of equal weight on cgroups with equal weights:

    root    (weight: 1024)
   /    \
  CG0   CG1 (wight(CG0,CG1) = 512)
   |     |
   T0    T1 (h_weight(T0,T1) = 256)


and a third task of equal weight arrives (for the sake of simplicity
also consider both cgroups have saturated their respective global
shares on this CPU - similar to UP mode):


                            root        (weight: 1024)
                           /    \
         (weight: 512)   CG0    CG1     (weight: 512)
                         /     /   \
  (h_weight(T0) = 256)  T0    T1    T2  (h_weight(T2) = 128)
                       
                           (h_weight(T1) = 256)


Logically, once T2 arrives, T1 should also be reweighed, it's
hierarchical proportions be adjusted, and its vruntime and deadline
be also adjusted accordingly based on the lag but that doesn't
happen.

Instead, we continue with an approximation of h_load as seen
sometime during the past. Is that alright with EEVDF or am I missing
something?

Can it so happen that on SMP, future enqueues, and SMP conditions
always lead to larger h_load for the newly enqueued tasks and as a
result the older tasks become less favorable for the pick leading
to starvation? (Am I being paranoid?)

> +		__enqueue_entity(cfs_rq, se);
>  	}
>  
>  	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)

Anyhow, me goes and sees if any of this makes a difference to the
benchmarks - I'll throw the biggest one at it first and see how
that goes.

-- 
Thanks and Regards,
Prateek


