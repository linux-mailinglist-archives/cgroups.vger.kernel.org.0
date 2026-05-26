Return-Path: <cgroups+bounces-16298-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKqABNxkFWqCUwcAu9opvQ
	(envelope-from <cgroups+bounces-16298-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:16:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D235D31DB
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 141FD300C309
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F13D1A9A;
	Tue, 26 May 2026 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2k1GmvIK"
X-Original-To: cgroups@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F53195FB;
	Tue, 26 May 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786968; cv=fail; b=ILx40yLGv7HNFfhIBafOKo+7GlLF9vfpZiOTuOjZR+l/PYazbd4OP2IN7/WQecz3Jdbqinxd+Gb5iDHr4rdDZzuFnk1ZirJzduPPeOGzWFaylvq8RZhsjAZi8pWoGVWKuUSZuBx/g5XRC9ji+ubcJsNGFfvR695wiz3G9uUTI5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786968; c=relaxed/simple;
	bh=BKDUjvmSkMjYSNSuUxUp/VaJNe/6LG9u4ddNTkoKByk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BjDZ0l3TKM8QamaBZMEmtq0ZHouRpxxXIwrsrlPGWfBCU8/v8DN6GjsPklkv1iyRP7qAz4mo9UF+janLMv1xzNQAbdn+rG+MzMqor/4fnJp9zuCI7+FUtwpUaC+Ca5m/60AJR5KQXCUGVuN1kVS0xjwbhG2z0Jxz7Ic56i7WAYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2k1GmvIK; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jteAflgb1ooZv4NOEC7CX0NHI9a88ufr5Arxaoct2VXHGjkH2kpBvxPMlsvKosiEBOcgPgCrQt4vYEZ2/m9Sq66cBuSBdJ+urBeGQVx+f/t+tZZ9vBp48YDIbXYZ2LHv7GT1NUOVfRSAOnLZWAzSB+DJ4MC4SB/l/4OnkI2TYuZUgE7e3waUmVDZQQLuLSYTb6RAWwYNqUKst3skxnP3Sx4vHBmWxkP9UlGoCb7sVPPjVJmBjQMsTsHKi6iRpKblFTHcfd3dIyxbQERjrdLf2SVzzfFAiQJ7vZK4BNcrH6XPh9UgA2tBXQAvqE2qY4SyH/w7qalKO2sbEeqJcgj3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzJeg14yxTw/FSHMNmQmqLFK6TA6vpVdCuBLLn3RjCg=;
 b=GHN+3MyJbC7tnxz1iRdGX/mlDlVc/1gZ6jI/fTTndFKKunW/FkiKFv/thh2ox6MA2SfPykZg5zUPF+3KCgz0JnH2MPXRgNhxfy/i1k2Y+d7XOQCWaFIZ3oVKdKSu36htt8EYRH6mMI+8yc4NpCSVZGPjfVx1SGVFk+ptlYwrH4bVM7MhicRcetHRyNlg7IslZBzlwtOY2XjKcgZXSDYoGdgZ6RxxUQvFPLfJ/llbqyuvndliz1zi8qhEOawowB4+UXxJFTcuTPRXbyRv4HqG9uc4goD+gEL2+3ix/kkQCO23Rh/3FjXR7LlKVfZ/xlIgEIfwjMjIveGuHXptk10klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzJeg14yxTw/FSHMNmQmqLFK6TA6vpVdCuBLLn3RjCg=;
 b=2k1GmvIKkSvoHVAbUC3EEFRGvHMFMOWUJm5Hvg8akYtnjR1iLioHdA6lhfzxNHmLOkvvFcCF5CV8pgcu8GuzRwn7hAcYZ2+dyCFEtaxrn1dQY+vtCM1WlQjaQQYhcvx0cd0OzEwMLKAUejiOO2IdKvytgA00de1ZV0SRavWevw4=
Received: from MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:15:58 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::1e) by MN2PR03CA0027.outlook.office365.com
 (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 09:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 09:15:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 04:15:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 04:15:56 -0500
Received: from [10.136.47.136] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 04:15:51 -0500
Message-ID: <85116808-8643-47d7-b4e7-2a11c3999b20@amd.com>
Date: Tue, 26 May 2026 14:45:45 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Zhang Qiao <zhangqiao22@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, <mingo@kernel.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>, <qyousef@layalina.io>,
	Hui Tang <tanghui20@huawei.com>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <a06e4744-2393-724c-14ff-154f1caa22a6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: a486a53a-27b0-40bc-6b5c-08debb0765bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	B6VO//cJSaX6GUSsukvQsiMR1xHAPomZmQSvVAPQhMd5++8LQfnWXZ6NS8Liwn7V0H+YP2+fbr7aBVqSvmWp3GMRhafgWSgNARs1NhwTck6RUs9fAkYjANuaZh1jF4tQ6OjM9GB1QAqhJUWgjL984/haZL0OjLq8ITZOpo2nuC4K/1LH+cGmtYRoimUQ+aQM9osMqbt+jFHrQ0hA7zDf/kZvq8NJw5uSU1RFDHsUWlU5BUqBQzw453MZGa6Nz2vT/0fbHjCM3570Lc2rDJ3jyq98+kh5amMHa+5ALyZkgjxL4EDMF/4msfJC9+zPJUGhE0M8l9u+Y3/7oq8AZLoNvClJEP1o8hzHKROIl3aTV67eal1+IfPRuc5heYEkA1GXuQtoRzM+QIjmH/EoXvBRu2Z9f1jnJeR8RahS/Bw+uGhAiKKC9aFpdyuWS+wLMkbpB3vUC9bYxL1naJ09lbJksVs0rLdQFt8Zb7ljWD7e/5wujUtJxO9U+Eokc7Wel9QXNJMVMMM9kZY51hOlA7GO91DVxzXro4XTRJmyJo015Gg9cn2HMAbx4DSPrfJ5TriPn2DTIbRv218ePSOJ5XA8FpTm60ML9Kuj9RalbHT9fHB1lpj1ywv5jVPcCp4U2wubenCtgsc9OmagdF4IqVj5XkZSV/E/92K1IGJoUVlK/Do4AoyGV5Ns//eU7lECpvidGYmmf6NWhBnh8OrXyxnOrAUmOakz8RURcYu04TB//rg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i1Jd9CXq2YxkGT+FZ9pNA0q8BAIT8AairIbUxQXsNgkMXqxeAGUpwE54U1qsH0o2HLmDyw3RkmeGBEFuAAFMBFnAeYridFnMQEWqctk4/dCd/An2K8TFk/BDyuKaKla9lDXYFO8uQCtbNsnL6jeD9vOiHL/n/myMYBKj7q3S2NsFUbOwHBIf7OeLl+QmxpdALBpyh92n+S6mW0zr/ty1LWxIUaYJlcrNhcbs4PGauXz/WtRAOsNRogRjgNoNMc1NtW7MElpTVNfouvjtSv0pKuGHJUk/pw0Q9PakOfk05kDmJhUbllzbZ/Z2n5R7/1NMb6Zr2+Aq48FkYi9m7lwc1M5JjXuwDGCtEM0CQPPNnoLNPHHQWqcoSYXMh724r78Fge0LwBjLLnEN4ech8gfeHjD/ha4Pp0lUthMFUW4lwxn1ToWBag8BjkBPibqzlxhU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:15:57.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a486a53a-27b0-40bc-6b5c-08debb0765bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[amd.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16298-lists,cgroups=lfdr.de];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A1D235D31DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Zhang,

On 5/26/2026 1:23 PM, Zhang Qiao wrote:
> Testing sched/flat branch on AMD EPYC 9654 (384 CPUs, 8 NUMA nodes)
> with a 2-level cgroup hierarchy and cfs_bandwidth quota enabled,
> hackbench triggers a divide-by-zero oops:
> 
>   [  142.308571] divide error: 0000 [#1] SMP NOPTI
>   [  142.308582] RIP: 0010:task_tick_fair+0x19e/0x410
>   [  142.308601] Call Trace:
>   [  142.308604]  <IRQ>
>   [  142.308607]  scheduler_tick+0x6a/0x110
>   [  142.308609]  update_process_times+0x6b/0x90
>   [  142.308611]  tick_sched_handle+0x2a/0x70
>   [  142.308613]  tick_sched_timer+0x57/0xb0

More of this trace would have been helpful.

> 
> faddr2line confirms:
> 
>   task_tick_fair+0x19e/0x410:
>   __calc_prop_weight at kernel/sched/fair.c:4085
>   (inlined by) task_tick_fair at kernel/sched/fair.c:13576

Those line numbers don't match on the latest sched/flat but since you
mention this happens with throttling, I believe it is tick hitting
somewhere in between the task being dequeued by throttle_cfs_rq_work()
and the CPU rescheduling and taking the task off the runqueue.

Dequeue from throttle is slightly special since it keeps the task on
runqueue but the sched entity goes off the cfs_rq changing the
hierarchical weights.

Can you check if this helps:

  (Lightly tested with your reproducer)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b8bae794f063..d96e5915fb3e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -14815,18 +14815,21 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct sched_entity *se = &curr->se;
-	unsigned long weight = NICE_0_LOAD;
-	struct cfs_rq *cfs_rq;
 
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-		entity_tick(cfs_rq, se, queued);
+	if (se->on_rq) {
+		unsigned long weight = NICE_0_LOAD;
+		struct cfs_rq *cfs_rq;
 
-		weight = __calc_prop_weight(cfs_rq, se, weight);
-	}
+		for_each_sched_entity(se) {
+			cfs_rq = cfs_rq_of(se);
+			entity_tick(cfs_rq, se, queued);
+
+			weight = __calc_prop_weight(cfs_rq, se, weight);
+		}
 
-	se = &curr->se;
-	reweight_eevdf(cfs_rq, se, weight, se->on_rq);
+		se = &curr->se;
+		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
+	}
 
 	if (queued)
 		return;
---

I don't think it makes too much sense to reweight an entity that
has been dequeued. The enqueue at unthrottle will do it anyways.

> 
> ===========================================================
> Reproduction
> ===========================================================
> 
> Kernel: sched/flat branch (54d493980e00 and later)
> Hardware: AMD EPYC 9654, 2S 384 logical CPUs
> 
>   # 2-level cgroup, quota = 50% of one period
>   cgcreate -g cpu:/bw/l1/l2
>   cgset -r cpu.cfs_quota_us=50000  /bw/l1/l2
>   cgset -r cpu.cfs_period_us=100000 /bw/l1/l2
> 
>   # high task count amplifies the throttle→tick race window
>   cgexec -g cpu:/bw/l1/l2 hackbench -g 48 -l 1000 -s 512 -T
> 
> Typically crashes within 30 seconds on this machine.  A single-CPU
> kernel or a very loose quota (e.g. 90%) is unlikely to trigger it
> because the race window is narrow.

This was helpful! I see:

[  209.935597] Oops: divide error: 0000 [#1] SMP NOPTI
[  209.941061] CPU: 329 UID: 0 PID: 8247 Comm: sched-messaging Not tainted 7.1.0-rc2-test+ #73 PREEMPT(full)
[  209.951841] Hardware name: AMD Corporation Titanite_4G/Titanite_4G, BIOS RTI100CC 03/28/2024
[  209.961254] RIP: 0010:task_tick_fair+0x10d/0x850
[  209.966420] Code: dc 00 00 00 4c 89 f7 e8 f1 52 ff ff 45 85 e4 0f 85 ba 00 00 00 49 8b 06 4d 8b b6 b8 00 00 00 48 0f af c3 4d 85 f6 74 19 31 d2 <49> f7 37 ba 02 00 00 00 48 89 d3 48 39 d0 48 0f 43 d8 e9 20 ff ff
[  209.987382] RSP: 0018:ff581fd71e1fce58 EFLAGS: 00010046
[  209.993216] RAX: 0000010000000000 RBX: 0000000000100000 RCX: ff295dbfa9ad8080
[  210.001179] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff295dbfa9ad8080
[  210.009141] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000063eb
[  210.017104] R10: 0000000000000000 R11: ff581fd71e1fcff8 R12: 0000000000000000
[  210.025061] R13: ff295dbfa9ad8000 R14: ff295dc06c6eac00 R15: ff295dbfd9bc8600
[  210.033027] FS:  00007faef8c8b640(0000) GS:ff295e7c4acca000(0000) knlGS:0000000000000000
[  210.042060] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  210.048474] CR2: 00007f9884292d30 CR3: 000000011aa26001 CR4: 0000000000f71ef0
[  210.056430] PKRU: 55555554
[  210.059448] Call Trace:
[  210.062177]  <IRQ>
[  210.064426]  sched_tick+0x94/0x250
[  210.068229]  update_process_times+0x99/0xc0
[  210.072903]  tick_nohz_handler+0x95/0x1a0
[  210.077380]  ? __pfx_tick_nohz_handler+0x10/0x10
[  210.082534]  __hrtimer_run_queues+0xfe/0x260
[  210.087304]  hrtimer_interrupt+0x122/0x1f0
[  210.091880]  __sysvec_apic_timer_interrupt+0x55/0x130
[  210.097525]  sysvec_apic_timer_interrupt+0x7a/0xb0
[  210.102873]  </IRQ>
[  210.105203]  <TASK>
[  210.107542]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  210.113284] RIP: 0010:_raw_spin_unlock_irqrestore+0x1d/0x40
[  210.119511] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 06 fb 0f 1f 44 00 00 <65> ff 0d ec 20 fd 01 74 05 e9 c0 81 d4 fe e8 00 93 ec fe e9 b6 81
[  210.140469] RSP: 0018:ff581fd74032fe88 EFLAGS: 00000206
[  210.146308] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[  210.154271] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ff295dbfa9ad8d64
[  210.162235] RBP: ff295dbfa9ad8000 R08: 0000000000000000 R09: 0000000000000000
[  210.170196] R10: 0000000000000000 R11: 0000000000000000 R12: ff295dbfa9ad8d64
[  210.178159] R13: ff581fd74032ff48 R14: ff295dbfa9ad8000 R15: 00fffffffffff000
[  210.186139]  task_work_run+0x5c/0x90
[  210.190137]  exit_to_user_mode_loop+0x16e/0x550
[  210.195198]  ? srso_alias_return_thunk+0x5/0xfbef5
[  210.200552]  ? ksys_read+0xc5/0xe0
[  210.204352]  do_syscall_64+0x26e/0x750
[  210.208540]  ? do_syscall_64+0xaa/0x750
[  210.212823]  ? srso_alias_return_thunk+0x5/0xfbef5
[  210.218174]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
---

So the theory of throttle work causing this checks out.

The suggested diff above solves the crash in my case but your
mileage may vary. Peter can comment if this is the right thing
to do or not :-)

-- 
Thanks and Regards,
Prateek


