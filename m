Return-Path: <cgroups+bounces-15873-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBjfCm0iBGoZEwIAu9opvQ
	(envelope-from <cgroups+bounces-15873-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:04:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AAE52E634
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B97C301828B
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671D3C8182;
	Wed, 13 May 2026 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yVQVhr0o"
X-Original-To: cgroups@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76492D12ED;
	Wed, 13 May 2026 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655706; cv=fail; b=kT3u0XWrw7BjUrdWmNzgoLk6SgIariCUpahAliS9tw/aRqeLmu7eBt8YRA3yc74Tdl2ZHso1l5eQNNMBVSV2SOb7pD45JaLiUKQUqrCcKnuISJ+vg2TrfHbFvRDomTWSBAiFp6G9KOuV8sRV0+LrFeGv18zEIN6q13m9pwjtHfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655706; c=relaxed/simple;
	bh=fM3R0ogToVXFS+7PzILL3WEkTQLJeUsXb4mhzSzZFLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJoghK4PJhOE4BTjMEFNp5BW/8S+RM/II6xQicm1t94vOYi2PrU1Qn4+63LD9Uex6Jw/MM8i8xPcjE5y0Z/ApCu3hLdXoHj8h4gmV/N/f3aV8YITeyCwTxoJtbLPZ0EMHwxUxNRKZIXt8QP5oESe9soYm3es+hxk3FqUZ83Hl9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yVQVhr0o; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5Tx2xi3mlG4WeUlioaZ1ndUkA6dGr+ZVUXxIyYzrScDLhWBGHXDAAXzJbhJbSfDxBoyafdEP8mxNcKGQgpcVqT88zSDaSR+xQF6gHSOq3UvMryy/ndeuOqtU5CbWUg//HHGc8qJqdSOhlDQ4DwWP+nj70zdi8JnAPiVed5NeZ0EW7Azj4nYBZ3/Mz0Opi/ur6YD+fff6Y1amu8+8LnZqXW/UwSBi5FxHrF9h3SzkiykvNZOc6MvETX0w4qxbuIiqf3Qs8zebzjli72Ckm810eLJ67S03scwDlH/vaUpp1nAO2F4Wu6cMmF9nk2RLbhowBEQPerZ86bdoYi4XbaBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGdQ6w0zL6xFRJ/7Xo/Zp2wIZSQtJBFMUIEOhW/yTno=;
 b=m8fL4pXOc7N66IPj/sxtHXaRmUFHkzUZEWqWY0mZFXE2zXSS+jqfFafIgknNeLBH9gXgjvWIl9ZnPC7bzZWO1S0RyHQW2Dg1liAAwlwSYiWCk6KsyyBNPYQt5w0Xy6hcb4NF8yFc/w1mMwjsJzXDv3Al7QFzkTHmtm+Ezk0nl9lTNVxttCGJAsVnQTMmEoIOgzKJP2C8ENppEs37oQpBfMqZCFNrzybYpAnzPVE23aR6MJgLjDAQUhyCbV99yBNdd1Pt1OErtiFo0kDGbipVuvkztsEjWxWubhQSqtGb10l9BlYhszSA8KRR6svyl6lWGSITzpdCOpBy2oZQFFkXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGdQ6w0zL6xFRJ/7Xo/Zp2wIZSQtJBFMUIEOhW/yTno=;
 b=yVQVhr0oNAUqoS/4b9sC5JkgnXAS9knxWeDDsI3kN7RcWV27ZCWPcH4D0k6m1be8HmCLbhsQx0o1HkARuBwMd60kG5VZVbCrLXIDJB9XG4KnjvoqR/kWEv5TgBpU7xzM7bELFbfncompBKQrCOXAhhJa6Zw+qp+6yUGuGUHnaBM=
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 07:01:40 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::6d) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 07:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:01:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 02:01:12 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 02:01:07 -0500
Message-ID: <dc4df15c-2f21-4141-ba7c-b2d8afbcd0c3@amd.com>
Date: Wed, 13 May 2026 12:31:05 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <133c4d08-5dfb-4f4f-83cb-f9652d4212ef@amd.com>
 <20260512110932.GB1889694@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260512110932.GB1889694@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 218c646c-7910-4524-d560-08deb0bd7bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	ED9J0jlra1hwznBOW1EnZdn10mVnWDO+s60/ezjGVgUE90qyF9y9/EOFN9ivAIV6MnerXUKmd4APFMb+WSqhEN6eF+DN3X0ay4mgeI0jVvqk8ix4OimffmhPzD5QFlo4524M4zZqfJojGRVwm2dN9yNGyMP1iECr0vqQrl0mcMc9jfXfG0Ch5HTIjyxUvpXjvp7URA/dl8c8JChiDn3jRKrSBwYcEFhY2dmacoiruwPzB2xVnjBO+a/alXHBMPPdfyVGHkDLZ+kNo9pplaCcLcGgXcHhojIVZZO7eRcob7vltvtwPUrr5r+9wC+Llhd3Fkv9nfiL+qu8UIXqKNGeak0GDgBcLZnSa7eQvdNHM6/UJ2HtklmFBkAqrREJEgQOHFBpF7X3RPW8avXOKlqbQw2czNyeWjBheYoLxIBoGp55c6kOOHixkUWqX5fgr/SYhUoUBsyPC4r9NaUsK//4o3PRU4GPb0R1PZR0RAmD/RB33fTOBnvwo3oUmnVzMDcQd9JxuGz8th2AFckJND1zGTGsVXhtuv1DIl6MQijcnRy8yf3q2wpj6leIjmU5aSRlAX0t/NlQORfXjfS1VZlMan4JI/LmBrXb6ITJOPRGZoVzXd0w3wcjkYtJghiRZtKXVFGO7FZcU7s7CBHRsN+lhppFroU0UDBWWMuc1j2XdDJabk0JCaCyfNWDgT/+dOs69zI7oeimas4G+UKLIQ0+TsjMcgGmpaXQpJKtwU8AEjY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DpaPb5IyaOUGtuZL3usd/qTULdGknwM2kNBbAhTOvC0lhKmpMtn/a/JzpTv3tJVVNle/UOFYDn+k6WBkOUj5jRVY1HlGFrdJ+XD+P0+k6o3d9LEKVgDKWNodVU9B1yYNLDxy52D3ghdRKY17vuvherMCmFzAJAriGOMHFCrVI17JzHdRx8gaa4Z3olfP0eTmGnm8lfZWDkx8JVlq8PhS78qshIz4cqDIemlBxaUKzz3pcJlUXnLx6FcRJN4zRkRJf7neDlZA9dyr4heBiurgaPRdWt+UZKOlFDaBcmqBQM64v7/57b7F4U3J9WSPwlNRgU9ASDM8nHLy1HBYwVunBCH4gpz0niHwhCt6NTVQFkAjQnrODYmUwWktx5An5lz+3zXYv52whYnfvZeyfuD3OEbfK5xeJrE+P+xIp/wWXQ/P0W8ogby26lGlmy3CLJG4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:01:40.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218c646c-7910-4524-d560-08deb0bd7bc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-Rspamd-Queue-Id: 59AAE52E634
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15873-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Hello Peter,

On 5/12/2026 4:39 PM, Peter Zijlstra wrote:
>> @@ -13819,6 +13831,12 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>>  		if (on_rq)
>>  			weight = __calc_prop_weight(cfs_rq, se, weight);
>>  	}
>> +	/*
>> +	 * Add throttle work if the bandwidth allocation above failed
>> +	 * to grab any runtime and throttled the task's hierarchy.
>> +	 */
>> +	if (throttled_hierarchy(task_cfs_rq(p)))
>> +		task_throttle_setup_work(p);
> 
> We already call into account_cfs_rq_runtime(); which basically does all
> we need.
> 
> I think the distinction between account_cfs_rq_runtime() and
> check_cfs_rq_runtime() no longer makes sense. We can throttle a cfs_rq
> at any point now, since we no longer remove the cfs_rq, but rather we
> make the tasks suspend themselves until the cfs_rq naturally dequeues
> for being empty.
> 
> Something like so perhaps?

That makes sense! The task should naturally execute the task work when
exiting out of the kernel / IRQ handler into the userspace so we should
be good.

I'll rebase the below diff on tip, test it a bit, add a commit log, and
send it your way if you don't mind or would you like to keep it with the
flat_cg bits?

-- 
Thanks and Regards,
Prateek


