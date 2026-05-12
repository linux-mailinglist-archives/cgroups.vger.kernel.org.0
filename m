Return-Path: <cgroups+bounces-15811-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GoMJoS+Amr3wAEAu9opvQ
	(envelope-from <cgroups+bounces-15811-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 07:45:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7051A5FB
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 07:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65461302531D
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F383FBEB8;
	Tue, 12 May 2026 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iq5oUQsF"
X-Original-To: cgroups@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EF3CAE9E;
	Tue, 12 May 2026 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564253; cv=fail; b=S3AlcTiTTKDC2SpVmStgafCGtVOYrMlnp2m/ugq0aUoJgGLvDMFNyNYl5yqifwco87bk6i4MHpdfZqHOmfuuQIMJicETPVg4APXrqCh3zdWbluIZMvM4v7f2H6tl+jkqkr8PFUAqFRO/IXeCekQPuwh1dR6ALWiJq021XUmG+2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564253; c=relaxed/simple;
	bh=rExX0I/dNewspDFrx7iYhlgbKvwnY0DSLaE+4Q6yrD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AnUagRaGS6tCifKgfY6y1Q2cQfpX07hXEv9VTUqlf3ff1EzGjw53trHovNltAsVz09Ob06u6p3u6clOEHDEc222uSK+gayOnTGiSvOt2yLNHpNARa8cvKzyw2H0FUB2ubVpEzazMHyOC6KyoGOvTFAPUyiRBHLwMhG2qvRHjGsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iq5oUQsF; arc=fail smtp.client-ip=40.107.200.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhS1ppORGy24LgtqwMikyAaoYMCTn2mJmZ65Sp+f7Xei9Rr4YVqaGI2XnbcaMcU0a4cIrDfjCTsH8nTfJ2AYN0+qbELhiFs8yXg5LUwax/XLcQScaHKhuoTbnB3hUy0F5wFomcJbcBT5ye6qyfJuVgBlnTVJYu+vw10buTUMm9QkRI67UsY9AxqPEAJUjIbSSt0LQiM+KD2/YCACOWJXu4g4vNwWh/HbSawCZhAKuwkFpwxXNWdDZE4LZQgZUY/lyzLHSC/5aIbwecJjbq7t7D4P6XQ4x7UIfTiF7RCXRxje9T6afgg2hTUnCLB5RU1uZXmkh2t1HdF4XubK2870Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJpqw1DNcKvPYVlfumzobn2YFyM3UNZ3snFd/nqjrIs=;
 b=CTWGjU+LXqAm8qEqHSSxc/TWsU6LQ+I1vVYpgcWDmNPd8uxRO07oJIThIw4HTzjzkbG2PYNrXSY1oH32h+ZJEJFEe17huxY0LsykrMOfACDfRV+CNGuyOD1VXd4dJHtdVTS5sVJkyp3kyJiqnBGh0SUa8AC33A8F4OYm+KQgHKFEyeueu8QsyCOM9wEqtaoiX0aHFF1m01PZl1711SKZz5Yhuo7aQsi10gMlK5YXko45OAQ829vjeQtwaJomXj2ub1aN1uE2ab4T8UN3L1doyDxXJ5V34jk/GIXYO4ecjCSxUsASYbm8e9V61WYD4/0TijlFhqkw+7mKnY6dlOGNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJpqw1DNcKvPYVlfumzobn2YFyM3UNZ3snFd/nqjrIs=;
 b=Iq5oUQsF1qMRT/HD0yL3oazQwz710lSQBqcYBORAWQ/nnKZaEUbTOlANXUr6PCHw34gwjb+PvzVynfUL2ZMTO4Y0Uhalf/gxZYVAmoFQlU2xAETenOsQgwBdZkkXSdssvWMJYG4VOPl2Y8OsLKGJ4u9PprIio3c6I84UhG8n0qs=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.16; Tue, 12 May 2026 05:37:26 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::d7) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 05:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 05:37:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 00:37:24 -0500
Received: from [10.136.36.106] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 00:37:15 -0500
Message-ID: <8c4d8466-eefc-45a8-a93c-bb66d5e9db83@amd.com>
Date: Tue, 12 May 2026 11:07:13 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] sched/fair: Add newidle balance to
 pick_task_fair()
To: Peter Zijlstra <peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>
References: <20260511113104.563854162@infradead.org>
 <20260511120627.944705718@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260511120627.944705718@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d78127a-8440-4d65-d4f7-08deafe88c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	B0TOW4rhqira51Pi/74tWWaKGoeifq5PiFkXk1omQPcF/X0pi7EihB+3CruzZbqmhtaMUoPKBr8fmQRCbhltRxJs9hPuDkwP9Q/x8ncSbuMrn82fKWlE1rvR8lKRJa1/+RJ1Mim/y45JTUEqdzGHXOlUCmCeXXXMHQ2cE/Or0ZcwkyrB8X2KfDuv5s7Y3Xvdtejgjwc6Gi5tLRnvvOmeFhCHNVo9fANtPaef2w1nTwd+Px8Cfet83DHDR+KoepZjQCSEAec3i2XB+r3PJVbSwnKJFTip1ZDjZDqiKGoslMemMaKZO66D+BDD4SqZ470SuolURUk3/UsRJohr6T1W9tJtDuVw6ey8AoDtf+UG9tp41M4ql1/BSZn1Q598i/MWq3ZsRFofLj0pxB9UFUk+dUl+Dodsqjntx20f7sbrQZTjakn2DaoaSaRD0py9Smpfne26eZqdU1fxvF15T+rvieuyckM0dzerAADG/vJ/wqhqKc5uZUX8AZg8hDxM865fUC8sfVXYsu7TDmZb/am2kWo+spEpgvzzI5HvuEEhpkBzWxpRMT1LY9xpJEuMQ1pqv2HbLLZ6wvmQg16hPDVuNQi6/osBamD6708NhYmEBj7I4aVO0uO8T9CANWNaQw1YVxPR2wpEPPnW9koG5/nKsxWiXFlL5eCnZ0x30yB+AHaOmkRHfma3tfjN9not6q+Go/Mn0kAUtSqBI2SazjwYyqjHnkXNNGp3jxHZmVH0tfk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pcRfXcGwSfTnr3S9h0S5wDF8siTlXttjJpIiN8bjNY2vonK83cXBq3bDq7lzPvnjYVd/ugN+1+RwreyhUCbKVPX1QBcYk1KyO3L56HTLcc+DGAba34WQ8oSMfJ0hLbcouTweS8PowBHpTbpbaSlfVsnr9X1M3ifxvbCqgG4DRJiWgfSqIPIjRriEXbAb7LzfS6VG4XhKd3Z6ZpLp6jT8ssKftnxQrnFN0MDPHIVlcY+iVtJUPWXpKFZBZYqEtKb+Bcd7jdN4c1o57qtXsJqdvM+n8ICTBrzfSE2PydNdDZC+5z5dhCHsGCOjM7uIzMXeTPdEHUUAx56X7plwguRJyYSbstANnWEOXnzCtcNqvq9eXAuPpMOxRaDRkz0xOipNKtDmoCMrFm5Wlz6tSCGCFBHAhYQGVgBea7UXWd8xJkGd4vDK5Lr1GNEb9x87EhaZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:37:25.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d78127a-8440-4d65-d4f7-08deafe88c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
X-Rspamd-Queue-Id: 4CD7051A5FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15811-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Hello Peter,

On 5/11/2026 5:01 PM, Peter Zijlstra wrote:
> @@ -9245,6 +9247,14 @@ static struct task_struct *pick_task_fai
>  	if (unlikely(throttled))
>  		task_throttle_setup_work(p);
>  	return p;
> +
> +idle:
> +	new_tasks = sched_balance_newidle(rq, rf);
> +	if (new_tasks < 0)
> +		return RETRY_TASK;
> +	if (new_tasks > 0)
> +		goto again;
> +	return NULL;
>  }

For core scheduling will now trigger a newidle balance during the pick
when core_cookie is reset to 0 which can cause tasks to migrate only
for them to find they cannot run on the CPU since core-wide selection
leads to a cookie mismatch and it is kept hanging there.

Can we return early if sched_core_enabled() here or are the additional
newidle balance okay?

-- 
Thanks and Regards,
Prateek


