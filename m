Return-Path: <cgroups+bounces-15762-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB8jAY0JAmqznQEAu9opvQ
	(envelope-from <cgroups+bounces-15762-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 18:53:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A324512B73
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 18:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2729F3199943
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4CE426EB3;
	Mon, 11 May 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iJ7UDUjD"
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B3425CEA;
	Mon, 11 May 2026 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516534; cv=fail; b=Bz2aBvk0VJNV9UxgEjxTKS/wKCEx0ENvDu43jTh9u1z9yzL/bzVX+0iRAHQAvCiBqzJDVnA1MVRGNG/0NJ8uju8Gze714x6s/BaCSUqkjKtMzjSms2tuhw4aVM00xFKTAisbAIwZs6vIUJAmLXqIzAOEyQuf64L1EjasqRZkOBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516534; c=relaxed/simple;
	bh=b6L6AKu2Q4RWN+BfCI/k3ye+nwtNcTcLsDPogE0rymk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nOmQBi++Rhxvxz5ijxuiv7m0fk13oStcVUmWo/Tp+62FeV+EO88OAOdauCn8VVC0llWYqz+bZEBGLT2wixBuuTP00TuPpe65G1sytlFHnwqAW4Hhszgp+2qg9hRDrSaXn5wtugrfbmvXcKD0hIZYqDeYINf9ofmusQ3S3nrDm20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iJ7UDUjD; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STuOrGwFWI0Ve42N9eAMlssyMa8ArkB0c9wnEAw/pM/pJIliaAs3hagoGFIO1MAJwMYMF1UUCeuenYUosDB/w7jKeAOvRe1A24Z4qI1fep/wq58UJY6o4sP1Pblt3SCIFynHNRyle0/6KSpM08APkUPDWcB3mo5gGptdhslBFrlgJH/bDjonpB10MAnS345dZRUHV/S4Z+ZB/de7vECsHzd/9LsnD8Cz2D9xt77VBK3rTXC6taojnQrg3QWTLVkHDS4RRu/6jHA/2STHEpwCuUETMTwxTSwaeFJx3Qii6D1bhuc3ocobvKIytBSWVn5/fzaWdypW/h6a05HG/Egbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMu0W6yUKLu8Q+F8n8ScXXufGmJRaB6RBQMMaVk3xGU=;
 b=liA7/YmGzLwu80Qoc92ecB88U6V16vKgZJL9ykWeGrC6JQPtA6JiA/FwjOGiS/kq29LlWNqfbcaiU+HGHNWhwPMjwYdEdjyxloQUhwLScGUiyt2t9gHRIy9/4386dHxl4sJ4/JOgapoS9mgV72eHUYa7qZfJifjKfE09tsw0pHixhuMquvie/yjOFPMCNPXuXvxP09M4fgQ4zxRlspEUspESbtjXRbW1lf6NDbtonfozlzqyXSOhHgi0lQDZghlv7V8H1OPuKOlFMsYxFCGspIe+wf35nQda1V+0xkMB2I/m2cO4kKkOAaEiRT9GCgJciV6DmmsnHIkJ4dlu97Rr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMu0W6yUKLu8Q+F8n8ScXXufGmJRaB6RBQMMaVk3xGU=;
 b=iJ7UDUjD5xMrPdn+GnNuH0CG3xdmxBU9PWHadU5KEPhdRVo7Rx1VJgYt3YrnCptDFhgPuW9TohuWzx3ei4/tBvQpGiTxoHOU5LPYK0XQjyLenX2QABk6mPRB22c6ELto5BsQnfYrinPNJFBhUsWl9YWBXTqsM4zB3pybzTcmeLU=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 16:22:08 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:59d:cafe::ff) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 16:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 16:22:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 11:22:05 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 11:21:58 -0500
Message-ID: <133c4d08-5dfb-4f4f-83cb-f9652d4212ef@amd.com>
Date: Mon, 11 May 2026 21:51:57 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260511120628.206700041@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ce0d59-4466-4536-1c04-08deaf797241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kmCpHKq7vRleLtL7ZIM/teUhJ4wAMLV+m1eey3ot86YUFWZ+e6aWcLRdC1sH/vAnkwgFM1koMrrih8/muknr5XnI4izQMvArLtaXyDwiypJUPCle/qFvbArlBxgjRPJy1kc2hQZU+b6gCQOarrAOIv/h2KaDW7dlPq4gau/4m1Kjc6HjwUUCivcDTCSnrUDyqQj8WiCRXU10O2fsFajx2jmeHgGdcySMRn6LGQs8Hu+2h6zui92N9QTjM+ybmqR9Hu3JgTtC0r9eedO/uS3ImWBil+sVkEtKVnI96PNmyXL81Ru+fTfFgJkwtrWA2QQjZc8Oif0tApD61gYfG3OooZqyNhm6v1mMKAsJes43OPm156VeeXkKNDwm7+1jG0Xucc1vduqj5NV40B+xSl5lhZs3z3IRf1Ur3kptk4JIYsVioXkZwX1MK6kJ9TxcybVUd/vedMPdDRAxDIqhb3GtQIOZqieSW1VbWjU20Sn0JtZKJtmw/8fB3+HTZ5GJEnjaPCjLYiB92iKCp4Jc96zRZZcGyS9Z/2Bh16oK1C4y6E1H7Gg/uBAYHGFUVUuYLrtNs8mec8BB+fximQT/5TJ2CqNuv+V7zD/5ytRNyKnTlV2Qdr5/KE9OCfrmFPwVJ7hFaf9H9U4QP/kngviENS2lvvER9qiJHchMKvzCkEaZsUTHfRh2fP40+WnvkkoXduD2dMQjZTq9MroBgRbr3BKM+i1MCQAhTQEM30yF+wFA/kI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AwNEKdb3ANAzyoL6anIJmmm/LGLzCwoKC2d5Q8Db3z7m/dqrmjaBCD5ggI9beo0PzLti8a2q8ko8lBK7RCtaaLgsXu3v2Sg3UI8lmpUPc80jMGKCqI3jIDtPFZnIc4qes9m+72ed9LYSeIgfWEVXFOSW0xkN7oEPIZ7PjwMU4Kd2u0eJFyXzuzZkw32w5hOo4/q4QFWzGsXbrAEyYsFO9DZlElqUmwYkUMt9K70wiI5IYOcLfWW40xKpabFJCsV6nzM03VbCa17gDXWqamuKt0foI8YhBoDp7uFwgQcmHDtqiz7NH5LhICKjuEL4APCopshoujzjT7/QvoEkz8sNqqkIB96fpK8sd/rtX+Zr1yQHxFzLNf1g7EgODOY66SkWw5/qImgR58trsGO9DBtUcVpnkH4PJeap+GORiEmEE69c39h8KXkowNVZLLv5buzw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 16:22:07.5233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ce0d59-4466-4536-1c04-08deaf797241
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745
X-Rspamd-Queue-Id: 7A324512B73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15762-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
> @@ -9291,34 +9206,25 @@ static void wakeup_preempt_fair(struct r
> +	se = pick_next_entity(rq, true);
> +	if (!se)
> +		goto again;
>  
>  	p = task_of(se);
> -	if (unlikely(throttled))
> +	if (unlikely(check_cfs_rq_runtime(cfs_rq_of(se))))
>  		task_throttle_setup_work(p);

I think this bit should also be replicated in set_next_task() after
account_cfs_rq_runtime() since any part of the hierarchy may get
throttled as a result of failing to grab runtime.

Also check_cfs_rq_runtime() only sees if the cfs_rq is throttled
but the task can fail to run if it is on a throttled_hierarchy() too
so that should be the correct check here.

Something like below (only build tested on queue/sched/flat):

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e54da4c6c945..950c072244b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9224,7 +9224,19 @@ struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 		goto again;
 
 	p = task_of(se);
-	if (unlikely(check_cfs_rq_runtime(cfs_rq_of(se))))
+	/*
+	 * For cases where prev is picked again after
+	 * being throttled, entity_tick() would have
+	 * already marked its hierarchy as throttled.
+	 *
+	 * Add throttle work here since
+	 * put_prev_set_next_task() is skipped on
+	 * same task's selection.
+	 *
+	 * For other case, set_next_task_fair() will
+	 * handle adding the throttle work.
+	 */
+	if (throttled_hierarchy(cfs_rq_of(se)))
 		task_throttle_setup_work(p);
 	return p;
 
@@ -13819,6 +13831,12 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		if (on_rq)
 			weight = __calc_prop_weight(cfs_rq, se, weight);
 	}
+	/*
+	 * Add throttle work if the bandwidth allocation above failed
+	 * to grab any runtime and throttled the task's hierarchy.
+	 */
+	if (throttled_hierarchy(task_cfs_rq(p)))
+		task_throttle_setup_work(p);
 
 	se = &p->se;
 	cfs_rq->curr = se;
---


>  	return p;
>  

-- 
Thanks and Regards,
Prateek


