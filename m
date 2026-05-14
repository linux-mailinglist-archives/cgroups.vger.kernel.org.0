Return-Path: <cgroups+bounces-15925-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C3qGzE5BWrVTQIAu9opvQ
	(envelope-from <cgroups+bounces-15925-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 04:53:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA553D2EF
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 04:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AED9F3035A96
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689562E7185;
	Thu, 14 May 2026 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3DBjM3yc"
X-Original-To: cgroups@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C9219A8A;
	Thu, 14 May 2026 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778727212; cv=fail; b=q96HndGZ8z72RCWIL07vNCtNPtd34zr0Bbv/S5ImvTAyERjPVVqCNU6remDXZdylSX91KiqMsy6QubJ2y31C/z8YPeGshlSL2dNnYJnVJbJFelTwFfaWuyXxYzGs8cQmZCR0tLbFMR/17E/07G3kO5mwRo45hI+VXeJii5u573M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778727212; c=relaxed/simple;
	bh=CIT3dDV9pNrdgQwBzbYJUzRW7uMwB4nzkVuwO58LzJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X27qG4O/K+NhW/24kC9l6CjjRWOA+WGryqYsnVouIWvd+b/PW3AXs9g1M/eHnceQvAkQp5ITi5ZDfx2+bVjXZJ2HWeWufY98vk2THInCbUQtQCpI77usiVgwpfwOrowoah7HzN51YfQoPCBfq62/BIbAcm70W1I3OSoPRlPvoks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3DBjM3yc; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cm588rWovRmmpeaRbrOhLLaKSx8PK5e+1/aMloi1BxW41bqyDrIM4nw2Gym3HLzprP50OPl76k7pOE5nH7Hc+Hwvqkf0JOoCg/JAGyFdhplVHz310+CuPIpgYU3Sk8ss+d4MRHHjqJMgrZN6EneO+tTjgEU7rLTRglHwKs4q38293l+jbkamNZUpQ0LH6I7VxZu3M6pVVVYReESt9oEL6gX3yXCUUKPhmFLv2AQNHSkeQxeuZNL7zNVfxq2B1N4wWGdbo4EoXORKaC2mDAppWyvHtZ+8cVvFbfhc/2FCUr9u2/yxXrf7fIj251/Fe1L7ddi0YkzMdHYycYsGH1TEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWvB9sOmPe6xIAz8izSSqL6r4CJDh2BJLPR+NsMrQic=;
 b=c8sDyns8K2Q+xf+0pn8pFytjKTed5ZVORZdlH+CgJOyyWKyf6xZAmn2pFuULenBP/LubCyO57fNBa+MOX1pCOo5owj6bISnsRv/oMkxiZ0UDbxqOtD7RBuaAzmcY+2tQP4eXaFxo6ni8LawtTsU9xMX1kl5VCACkrgQAw9L6u4tKa7xche0+f28Q6X2/c6JXHyIDjMRc3FMlAfNcEdKz+PeT1T2aAgQKjDcYQnn4ZGYC8lzLU6/GS0NW3jOQor6IHaUWb+PqQ91oxuL/AtHwW2cl4EHQsedDtAfXh+AxFim1+J59l/6ZDvdxX5fkN3x58ia9gwViySWHFpDD1T5BFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWvB9sOmPe6xIAz8izSSqL6r4CJDh2BJLPR+NsMrQic=;
 b=3DBjM3ycsFktxvtlh2OzaCQ1FrEuUaG4+w0d3rlksO9O1DNm0l21hNfrQggeBhGxWecoww/XZaZhbMynHTPGNCFt1WnlOSpzGWMGTcl4sK0Ji3Ds7MR8P3I2HSkjU74GNrWv2EDHWNLMzAULot4+6dv2bt/CZqZuSclyC2MS/lM=
Received: from DS1PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:458::18)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 02:53:23 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:458:cafe::44) by DS1PR06CA0005.outlook.office365.com
 (2603:10b6:8:458::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Thu, 14
 May 2026 02:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 02:53:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 21:53:22 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 21:53:22 -0500
Received: from [10.136.44.57] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 21:53:18 -0500
Message-ID: <f28220a8-955f-4bf2-9981-855816519ea6@amd.com>
Date: Thu, 14 May 2026 08:23:17 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>
CC: <mingo@kernel.org>, <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qyousef@layalina.io>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <CANDhNCp1rcNYg29Fe66G6cuqHhDyXQ0oqccheSwfMuiNV-7Bgw@mail.gmail.com>
 <CANDhNCqWJ=Q3LxazK_ioo_39aFfR+yVbPEV+MQHC8_QvadhuTg@mail.gmail.com>
 <CANDhNCqsZVsWygBA7m2F_w2r3DnQkFDXfd95Lc4ny-zjQQE7Qg@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCqsZVsWygBA7m2F_w2r3DnQkFDXfd95Lc4ny-zjQQE7Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ce0a02-92c0-40d7-138d-08deb163f6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	k3wgjbJSehCJdo/ecyr3MndaePtPXIC6noA4qgSnhghcyp4FhNX9FNHMtjlOrHZmII8jgRcNH+V4x/STWhrURUqmwvQUv6JZAevUc5UJ8QEW43EpO7pq/HRiPehqBlpzNLC0LnA2vmCQeh6ACK9liQijeY+Qfo/Wl08TgutajEOPIUugSvtLDh16H8DzoK6S8njnSCKWHOPP6QJCShCXUPl1p66dWRukuplV8gVb/nlbUEEu128R2k3uiYojggLA/YHr3Xf/V/L4gXGK0vBh10SXWIEel+k3qS8/REZ5qF08hN6dqpWodqdRasQEuEHFKkEZPl/s9QfonbSzTtIT8bPod3ieMD286sCiuviamlfS/KlEC8XJhP0e1Adda1EibH4RbKZNEA5DJ/voprTH1XGMizeWVczZvNgjaRPyFOY1m+C3nON4KnfqxOBmy14wz7KXxwytBtuCp55MC283BleC2ZSrFy0y9SBjlb22/cwO3BnfEpMzdeF2pEQY5lt2QoTVGZULlcvRHWBX+NDmHuDP2EHyWiw4wQS/5EV78FJW9vvsIkFCnjtFFVFGGFXcht+PfHqNXwpI+SQVy/OJ7/cRtJ6xwjIGJMjSTy9Qn1NGKXJ6lwDnFgXQ0LrgZ77R4cmqwCP7XMI4nQ64YDDjBRWilifObH9JK35/DVrhk+yg40+iW8ZTXqMH5orn29XWZs6eOiu2ZMymCiNemvWzzIha0XSpFjnDb/ciyPfRyW4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	38Qf/y+kasLvE0mjJ0EZZOvR0qdFb5oOUbpzTEq+KspMXlLEmUYiTqhX4SGqYjXyXaQ0BiHoH89IP9f0UN7aVhpgGHmrkpbV2eKBWnA44IQL8IZrHcUhKIYVYXkMNN9O4CeliG9RIRUQ7g75ZsDWo1ex+j0Eup/m15osnBt0yH9M7I9lTELop9KyFTTltRORc6TVxnp2ZbaBUtwS2hleF0mDJUv8ufqwMohH/69liXvehXfsPUvlo2oM5n4+Hjq+8B8+r/1X+9wJBg6+ywiyc5Fsz5eNMGItY652rloXtt87xEVqzbaz+GT5GmdWShG817ybaoyrjDyfCTkB8dzQrFIaw4hMK3FSog/yTPrLzvd0F7Can8C1y65oBsK09xhfV5NO0lYp+W94nx/hswmxTuNoYbGpdTXTrrjV6LSN9brgFDd0LgOUj2sqblwAY7IC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:53:23.2432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ce0a02-92c0-40d7-138d-08deb163f6c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Rspamd-Queue-Id: D4EA553D2EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15925-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hello John,

On 5/14/2026 7:06 AM, John Stultz wrote:
> So looking at the callstack when I see the failure:
> proxy_find_task()
>   proxy_force_return()
>     proxy_resched_idle()  <- sets rq->donor to idle
>     attach_one_task()
>       wakeup_preempt()
>         wakeup_preempt_fair()

After this point, I would have expected we called idle class's
wakeup_preempt() since that is the donor context ...

>           update_protect_slice() <- called with the donor's se
>             calc_delta_fair()
>               __calc_delta() <- div by zero
> 
> Basically we end up in wakeup_preempt_fair() with rq->donor ==
> rq->idle because we earlier called proxy_resched_idle().

Could you check if following makes things better:

  (Only build tested)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ae5f19c1b7e..77f4ebe8f5c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6653,6 +6653,7 @@ static inline void proxy_set_task_cpu(struct task_struct *p, int cpu)
 static inline struct task_struct *proxy_resched_idle(struct rq *rq)
 {
 	put_prev_set_next_task(rq, rq->donor, rq->idle);
+	rq->next_class = &idle_sched_class;
 	rq_set_donor(rq, rq->idle);
 	set_tsk_need_resched(rq->idle);
 	return rq->idle;
---

I'm just getting started for the day so it'll be a while before I
actually get to test this on top of flat cgroup bits which I haven't yet
run with SCHED_PROXY_EXEC enabled.

-- 
Thanks and Regards,
Prateek


