Return-Path: <cgroups+bounces-8974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E43B1A2D8
	for <lists+cgroups@lfdr.de>; Mon,  4 Aug 2025 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C6172575
	for <lists+cgroups@lfdr.de>; Mon,  4 Aug 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C9325A631;
	Mon,  4 Aug 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="vXC5d++G"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013050.outbound.protection.outlook.com [52.101.127.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5F259C83;
	Mon,  4 Aug 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312780; cv=fail; b=HwwqAJDL9ZrRlqhT3e9JhHsaWahPjNe81Eh4+ua0Egm4W4vtGr4Cma4gRQ3R082PHyB5jAU6oBwxjLzDxGSCjK3YU2yzTlEWx4jaGb3wXtlKgG4UBcoD3ttjizMaDoS4PQx+zc1KQyuRsHXWdLUVN+mvRxqZfuLCp14f9btPKJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312780; c=relaxed/simple;
	bh=ZKkceWj3dhoojMeWl3wpSzjzKSQ4fzT5gOuibom/GzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nA3RKa9gRqPOwf/npnqyGQja8zo09ozRVDLmYZJBtyjCFEnrJO9dEMeE9/zmjOE14F2u4uAiMLAEnMH/dnwaCcQEFElG/CfEcH9vD/phS1WGmkGMSHVCjKQwadZ+R1gVN0hUopzgUapt/M695TXY11xe7nxzo83eqtPfuT4T0/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=vXC5d++G; arc=fail smtp.client-ip=52.101.127.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGo+9r5ZcLwrKjnJfsXoPNQtLe4Hmaasyy2CciMgJrqD1kK9QGOpZYfGmHg+rk0Iavj8EqQTdmj0Yq/mOGUhd77KAUuT/MurUmoKqw9cW4E5O24u+GwKBm51QX80KJNstgLgqhy9/5VMzPkD8DVDq0mjJ2/o7HVh/OgMrLLbmY+gmKHFFF/zPnjlRzNc9Lsa8T9Jx96JtdcdwY7amzWXv0b/rODmhB++E45y1LQBtvYHhwPPY+jzLNXtcBF7GviEfChwJyhNajk9tZeuNv3ZzYDOJoLr+EQgRmrv5fUu7rxNNW6il4ie+H8NUheIv6aOUcf2bnI2ABmCjXAyUwC2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVAIQjFnRWbV9Wg+d/YyzrnQaAEDB/64ryUa/c3I3J4=;
 b=qBPDoBtz/SLGtc0r8ruTzRWEzlkhRQJgABT1nQJ/JTWn+umoV3dgM3aKFWnTa2fsuCOPZQ8B1svntwJbcIutOv5u3Ljbdm/nyRUFtCKe9h2UUFEHDbEcYL0Na4EZDhfZT/Naa5G4/rcQrRz5OnDfGZk4Z9ZI/pRNtnFCf6w1ogTQC9qMjXjDVRA2HrYSqem+06d+m/nwKTocu69UYMS3gT4TGoAQrzTVO8yunwV37QNB/DEXNO70KobPKMGAAYdUO01QfSNUxnj8DYMcptq2I9urxg+Omw/AYjr8xObpnh3ZCQpzTyqDK0+0kLk2huyw/bTUnztmDLFv67945KmjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=redhat.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVAIQjFnRWbV9Wg+d/YyzrnQaAEDB/64ryUa/c3I3J4=;
 b=vXC5d++G3o11s0dxScFfn9V+RDVdQZqykAYwky31hkOEjSU7cGMuB1G3hwo6lfrKKHozOH0VGGWGp+/UB4o4Qca3PQ6zQoBvp2ul1ISr4kTV5+mncjzL+7Ct3a8yndWJR0J8+ROLW7qZn9dpJNlfrw1zqUA9aaNHqpoeKqR/l/4=
Received: from SG2PR03CA0102.apcprd03.prod.outlook.com (2603:1096:4:7c::30) by
 SEZPR02MB5591.apcprd02.prod.outlook.com (2603:1096:101:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 4 Aug 2025 13:06:09 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:7c:cafe::f0) by SG2PR03CA0102.outlook.office365.com
 (2603:1096:4:7c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.12 via Frontend Transport; Mon,
 4 Aug 2025 13:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 13:06:09 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 21:06:08 +0800
From: xupengbo <xupengbo@oppo.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: <xupengbo@oppo.com>, <cgroups@vger.kernel.org>
Subject: [PATCH] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Date: Mon, 4 Aug 2025 21:03:26 +0800
Message-ID: <20250804130326.57523-1-xupengbo@oppo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SEZPR02MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 955a02ef-8767-471e-ef03-08ddd357ae49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J5Fl+G2s0JPd+qIAX3QNilNl+RQAZmz5ygVnaWJpwbITZXXJJxUpEOxpKZZF?=
 =?us-ascii?Q?P7ZA9ej2pxBGA+7cU3Wj+t5jg22Tk94/5R/EX1YzoR/llu9//lgJ0YroGpLy?=
 =?us-ascii?Q?1SclURWYqCDrqL3+4/6JELI+djZBGB9TUcD4FRdomouY8rM6v+tRuC4qOvSU?=
 =?us-ascii?Q?Ww8BPpq5ecuCv0gRVsywGr6Hhu059ygL/R96kdf0FoTOhcBYu8m8jSs8+5C+?=
 =?us-ascii?Q?YzhuPB6gYz+UsuhbKqntn6KL3EFUCj+o8+f1sXAWmg8ClpI9wFwCKz6qopS8?=
 =?us-ascii?Q?CmhA+I7IGxkk6ieMrkzps2PCxemPNUGrg3p8lh6o2by+PszgdqarD8zCyO+M?=
 =?us-ascii?Q?BVUevmoOdPErUjh+Xl23jzcUhOTpssVlLtubRZhhmKRvGBxWBlCDUGEW6HJz?=
 =?us-ascii?Q?jll4Npf6ZcCeten7AG+X6Aa1LluFzTkwrFdFHHeGfnkYMGOmS4U13EQkvY0+?=
 =?us-ascii?Q?ELmVLNoKlpVX+OiA6Bbj9g6FN1QHXQfhlMBlfGhgtfeI6HxF9+wjowgSUQrH?=
 =?us-ascii?Q?CFbhHgx5ZzLitGlxoGxUi65OvGlxisNtLwFVjp1nJqlsyIiZKK3SY19iyTrf?=
 =?us-ascii?Q?xOQubC5KqEwegIhR6esiSINzGa/IwDiezZdnQAi0XP7HI9LtgjW33ZulWqcf?=
 =?us-ascii?Q?xF4Q7v4IfAPSIq8xsCLb1WXejU5kabBhgon08Gg7+PI0Jzdi1ZPp9wjcKC21?=
 =?us-ascii?Q?73oVOL54O2oY3QvjRRz8S4yG2wASmS4OZSr7kBsRtesUjGpDR+0Zm+cGw6NA?=
 =?us-ascii?Q?bha+SaB4e3sQZcUpDQm3C5+qfx9U6YgUuCDDr434rhDp0+Sz5LOMmufHi7ql?=
 =?us-ascii?Q?5oebtcH8RUa2yCNXrQoPwP7yJK/1arqxhLGaxUqJbTV/C4XhVokQ6F7Qzhpr?=
 =?us-ascii?Q?NnA+LCjFcXdoxI+67COUq1sJmVlmG+jzEdxABQl6IUU6LkOB4t3qaxtoSsIy?=
 =?us-ascii?Q?Rn6r5XmFzEP36y2+BNhyhB+pdpO6oCkLW4D4qfPfQIskpAfO5IZGsr48mnUA?=
 =?us-ascii?Q?t0DEVJxQ4h3x9kmmewrcgMQ1bTYYk4/+G4UcHgsID1KI2z5kisGGvgnkOeh7?=
 =?us-ascii?Q?RMaIiIpx7TCTbUU5QJB/toFBODACm4iAhPtK2bAIIA62mQ+58fxkJph/YmXv?=
 =?us-ascii?Q?Jls9ZUNP57P4mXhMLlFZXuf2pQ6nATezF/9CT1nKts/N8lesPH+8awkGegt7?=
 =?us-ascii?Q?D1+fCtCDGpticIlwXriVodOj3BdVwlLHTNy1d4ietDmPxErpBu+IoylALidx?=
 =?us-ascii?Q?0oxWeseJ7i+Fo28Ev7T4hgVy6h1oqzCycHy9LX6MIH+/EF8Xxdxk5lBVlogH?=
 =?us-ascii?Q?zWQZSBJDf8e8JNcCRnytBV1/RzkuUvKrDXUmVtZiTMbtB8cOFgYXaZ8804IW?=
 =?us-ascii?Q?coNzrFqzdhsmIyskECYf+O/fPdPZlnhO9zB8Cze1HvqSMK60ttWo3SRKDtOW?=
 =?us-ascii?Q?MCCJyfcqMy3ewp4tZh9ANDJDr2crhj0dGR+fvZWpVXqMWX0EMBYvVfGCweGU?=
 =?us-ascii?Q?ZNn6BHh7jJfVzwm3nJt71Zz80XySXku8SE6ziTMRvUgPX14vuXuP+nAXTA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:06:09.5113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 955a02ef-8767-471e-ef03-08ddd357ae49
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5591

We added a function named update_tg_load_avg_immediately() that mimics
update_tg_load_avg(). In this function we remove the update interval
restriction from update_tg_load_avg() in order to update tg->load
immediately when the function is called. This function is only called in
update_load_avg(). In update_load_avg(), we should call
update_tg_load_avg_immediately() if flag & DO_DETACH == true and the task
is the last task in cfs_rq, otherwise we call update_tg_load_avg(). The
reason is as follows.

1. Due to the 1ms update period limitation in update_tg_load_avg(), there
is a possibility that the reduced load_avg is not updated to tg->load_avg
when a task migrates out.
2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
function cfs_rq_is_decayed() does not check whether
cfs->tg_load_avg_contrib is null. Consequently, in some cases,
__update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
updated to tg->load_avg.

When these two events occur within the 1ms window (defined by
NSEC_PER_MSEC in update_tg_load_avg()) and no other tasks can migrate to
the CPU due to the cpumask constraints, the corresponding portion of
load_avg will never be subtracted from tg->load_avg. This results in an
inflated tg->load_avg and reduced scheduling entity (se) weight for the
task group. If the migrating task had a large weight, the task group's
share may deviate significantly from its expected value. This issue is
easily reproducible in task migration scenarios.

Initially, I discovered this bug on Android 16 (running kernel v6.12), and
was subsequently able to reproduce it on an 8-core Ubuntu 24.04 VM with
kernel versions v6.14 and v6.16-rc7. I believe it exists in any kernel
version that defines both CONFIG_FAIR_GROUP_SCHED and CONFIG_SMP.
I wrote a short C program which just does 3 things:
  1. call sched_setaffinity() to bound itself to cpu 1.
  2. call sched_setaffinity() to bound itself to cpu 2.
  3. endless loop.

Here is the source code.
```
\#define _GNU_SOURCE
\#include <sched.h>
\#include <unistd.h>
int main() {
  cpu_set_t cpuset;
  CPU_ZERO(&cpuset);
  CPU_SET(1, &cpuset);
  pid_t pid = gettid();

  if (sched_setaffinity(pid, sizeof(cpu_set_t), &cpuset) == -1) {
    return 1;
  }

  CPU_ZERO(&cpuset);
  CPU_SET(2, &cpuset);

  if (sched_setaffinity(pid, sizeof(cpu_set_t), &cpuset) == -1) {
    return 1;
  }
  while (1)
    ;
  return 0;
}
```

Then I made a test script to add tasks into groups.
(Forgive me for just copying and pasting those lines but not using
a for-loop)

```
\#!/usr/bin/bash

shares=100
pkill 'bug_test'
sleep 2
rmdir /sys/fs/cgroup/cpu/bug_test_{1..4}
mkdir /sys/fs/cgroup/cpu/bug_test_{1..4}

echo $shares >/sys/fs/cgroup/cpu/bug_test_1/cpu.shares
echo $shares >/sys/fs/cgroup/cpu/bug_test_2/cpu.shares
echo $shares >/sys/fs/cgroup/cpu/bug_test_3/cpu.shares
echo $shares >/sys/fs/cgroup/cpu/bug_test_4/cpu.shares

nohup ./bug_test &
proc1=$!
echo "$proc1" >/sys/fs/cgroup/cpu/bug_test_1/cgroup.procs
nohup ./bug_test &
proc2=$!
echo "$proc2" >/sys/fs/cgroup/cpu/bug_test_2/cgroup.procs
nohup ./bug_test &
proc3=$!
echo "$proc3" >/sys/fs/cgroup/cpu/bug_test_3/cgroup.procs
nohup ./bug_test &
proc4=$!
echo "$proc4" >/sys/fs/cgroup/cpu/bug_test_4/cgroup.procs

```

After several repetitions of the script, we can find that some
processes have a smaller share of the cpu, while others have twice
that. This state is stable until the end of the process.

$ ps u -C bug_test
USER    PID   %CPU %MEM    VSZ   RSS TTY    STAT START   TIME COMMAND
root    13924 33.3  0.0   2556  1196 ?     R    18:55   0:56 ./bug_test
root    13925 16.6  0.0   2556  1196 ?     R    18:55   0:28 ./bug_test
root    13926 33.2  0.0   2556  1196 ?     R    18:55   0:56 ./bug_test
root    13927 16.6  0.0   2556  1200 ?     R    18:55   0:28 ./bug_test

Link: https://lore.kernel.org/all/20210501141950.23622-2-odin@uged.al/
This phenomenon is very much like the one mentioned in the above bug fix
patch.

Link: https://lore.kernel.org/cgroups/CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com/
Link: https://lore.kernel.org/cgroups/CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com/
And there are also hints of this in the above responses. Maybe there's
nothing wrong with this patch, except that it doesn't take into account
the case that cfs_rq->tg_load_avg_contrib != 0 but
cfs_rq_is_decayed() == true when the last cfs task is migrated from this
CPU.

It is also easy to reproduce when autogroup is turned on. We just need to
repeat the following command over and over again.

$ sudo nohup ./bug_test 2>&1 &

PS: You must use sudo or the new process will be added to the same
autogroup.

$ ps u -C bug_test

USER      PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root    14444 18.8  0.0   2556  1196 pts/5    RN   19:30   0:16 ./bug_test
root    14458 17.9  0.0   2556  1196 pts/6    RN   19:30   0:15 ./bug_test
root    14472 17.0  0.0   2556  1196 pts/7    RN   19:30   0:14 ./bug_test
root    14486 16.7  0.0   2556  1196 pts/8    RN   19:30   0:13 ./bug_test
root    14500 33.2  0.0   2556  1196 pts/9    RN   19:30   0:27 ./bug_test

As we can see, each process was supposed to get a share of 20, but 4 out
of 5 encountered the bug.

Same environment but another experiment:
In /sys/kernel/debug/sched/
$ cat debug | grep 'bug_test'|  awk '{print $2, $3, $4, $16}'
bug_test 20245 21805.633289 /autogroup-891
bug_test 20256 10453.702263 /autogroup-892
bug_test 20270 20333.813653 /autogroup-893
bug_test 20284 19965.294506 /autogroup-894
bug_test 20298 9781.445557 /autogroup-895
rker:bug_test.c 13189 10.359087 /autogroup-515
rker:bug_test.c 13190 11.425550 /autogroup-515

$ cat debug | grep -A 28 'cfs_rq\[2\]:/autogroup' | \
egrep "(tg_load_avg|cfs_rq)"
cfs_rq[2]:/autogroup-891
  .tg_load_avg_contrib           : 335
  .tg_load_avg                   : 335
cfs_rq[2]:/autogroup-892
  .tg_load_avg_contrib           : 335
  .tg_load_avg                   : 670
cfs_rq[2]:/autogroup-893
  .tg_load_avg_contrib           : 335
  .tg_load_avg                   : 335
cfs_rq[2]:/autogroup-894
  .tg_load_avg_contrib           : 335
  .tg_load_avg                   : 335
cfs_rq[2]:/autogroup-895
  .tg_load_avg_contrib           : 335
  .tg_load_avg                   : 670

$ cat debug | grep -A 28 '\]:/autogroup-892' | \
egrep '(tg_load_avg|cfs_rq|\.nr_queued|\.load)'
cfs_rq[2]:/autogroup-892
  .nr_queued                     : 1
  .load                          : 343040
  .load_avg                      : 335
  .removed.load_avg              : 0
  .tg_load_avg_contrib           : 335
  .tg_load_avg                   : 670
  .se->avg.load_avg              : 511

There is only one task in autogroup-892, even though it has doubled
tg_load_avg. As far as I know, this should not be a feature of autogroup.

The above experiments were all done on ubuntu24.04 with kernel v6.16-RC7.
On Android, I instrumented trace points at these two code locations for
the update_tg_load_avg() and __update_blocked_fair() functions.
```
static bool __update_blocked_fair(struct rq *rq, bool *done)
{
  ......
    if (cfs_rq_is_decayed(cfs_rq)) {
      //trace here
      list_del_leaf_cfs_rq(cfs_rq);
    }
  ......
}

static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
{
  ......
  now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
  if (now - cfs_rq->last_update_tg_load_avg < NSEC_PER_MSEC) {
    //trace here
    return;
  }
  ......
}
```
I'm sorry I can't provide these traces. But It's easy to see with
perfetto, that the abnormal cfs_rq hitting both if-branches within 1ms.
At first, the only task in the cgroup was moved into cpu 1, called
update_tg_load_avg and updated its timestamp. It was then migrated out
within 1ms, but when it was migrated out, the update failed due to the
update interval limit. At this point cfs_rq is still in the
leaf_cfs_rq_list, but in some cases cfs_rq_is_decay() returns true within
1ms, and the value of cfs_rq->tg_load_avg_contrib approximates the task's
load_avg which is not null.

When a task is migrated from cfs_rq, dequeue_load_avg() will subtract its
avg.load_sum and avg.load_avg. Sometimes its load_sum is reduced to null
sometimes not. If load_sum is reduced to null, then this cfs_rq will be
removed from the leaf_cfs_rq_list soon. So __update_blocked_fair() can not
update it anymore.

Link: https://lore.kernel.org/cgroups/20210518125202.78658-2-odin@uged.al/
In this patch, Odin proposed adding a check in cfs_rq_is_decayed() to
determine whether cfs_rq->tg_load_avg_contrib is null. However, it appears
that this patch was not merged. In fact, if there were a check in
cfs_rq_is_decayed() similar to the one in update_tg_load_avg() regarding
the size of the _delta_ value (see update_tg_load_avg()), this issue
could also be effectively resolved. This solution would block (2.),
because if delta is too large, cfs_rq_is_decayed() returns false, and the
cfs_rq remains in leaf_cfs_rq_list, ultimately causing
__update_blocked_fair() to update it outside the 1ms limit. The only
consideration is whether to add a check for cfs_rq->tg_load_avg_contrib in
cfs_rq_is_decayed(), which may increase coupling.

Signed-off-by: xupengbo <xupengbo@oppo.com>
---
 kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..97feba367be9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4065,6 +4065,45 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
+/* only called in update_load_avg() */
+static inline void update_tg_load_avg_immediately(struct cfs_rq *cfs_rq)
+{
+	long delta;
+	u64 now;
+
+	/*
+	 * No need to update load_avg for root_task_group as it is not used.
+	 */
+	if (cfs_rq->tg == &root_task_group)
+		return;
+
+	/* rq has been offline and doesn't contribute to the share anymore: */
+	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
+		return;
+
+	/*
+	 * Under normal circumstances, for migration heavy workloads, access
+	 * to tg->load_avg can be unbound. Limit the update rate to at most
+	 * once per ms.
+	 * However when the last task is migrating from this cpu, we must
+	 * update tg->load_avg immediately. Otherwise, if this cfs_rq becomes
+	 * idle forever due to cpumask and is removed from leaf_cfs_rq_list,
+	 * the huge mismatch between cfs_rq->avg.load_avg(which may be zero)
+	 * and cfs_rq->tg_load_avg_contrib(stalled load_avg of last task)
+	 * can never be corrected, which will lead to a significant value
+	 * error in se.weight for this group.
+	 * We retain this value filter below because it is not the main cause
+	 * of this bug, so we are being conservative.
+	 */
+	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
+	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
+	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
+		atomic_long_add(delta, &cfs_rq->tg->load_avg);
+		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
+		cfs_rq->last_update_tg_load_avg = now;
+	}
+}
+
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
@@ -4449,6 +4488,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
+static inline void update_tg_load_avg_immediately(struct cfs_rq *cfs_rq) {}
+
 static inline void clear_tg_offline_cfs_rqs(struct rq *rq) {}
 
 static inline int propagate_entity_load_avg(struct sched_entity *se)
@@ -4747,9 +4788,16 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		/*
 		 * DO_DETACH means we're here from dequeue_entity()
 		 * and we are migrating task out of the CPU.
+		 *
+		 * At this point, we have not subtracted nr_queued.
+		 * If cfs_rq->nr_queued ==1, the last cfs task is being
+		 * migrated from this cfs_rq.
 		 */
 		detach_entity_load_avg(cfs_rq, se);
-		update_tg_load_avg(cfs_rq);
+		if (cfs_rq->nr_queued == 1)
+			update_tg_load_avg_immediately(cfs_rq);
+		else
+			update_tg_load_avg(cfs_rq);
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
-- 
2.43.0


