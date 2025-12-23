Return-Path: <cgroups+bounces-12605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30ACCD8C91
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487C6302CBA6
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 10:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE01361DAD;
	Tue, 23 Dec 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k+N4QUFr"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F13612EB;
	Tue, 23 Dec 2025 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485488; cv=fail; b=iXeB7Vy/UXmDCH7WILK9FBtPrh29ON8qhT0aWM5KcYvRntx15Kd8tfc5hrq8XMkdyPgcvIkG/jhNYg+zMAD2USdx1h8qryeUvEeGPmuq3HXGKad0gEOQ5xF0mjQZt/qViSUgO1/AU08qGbomHVGaGoatErBSUQbNAmPxHfrG+ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485488; c=relaxed/simple;
	bh=fW2izc1WqI8yrFXNjejxFBdgSa6Hh9OSibOln8k2okA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nigTY+vWU5rZLhHPR3HmqQOzrzwJeudKtP1xDpbqS/6Jfasu/m5y1FZGhvH4pozJsyu3JS2nbZHLtfvt6AcJe7wDpnrpLFxyzkWgqnYsCn8GNh6SLRZTVnTCxvMXUi6tII9PM0ZH7DSdHv/H5sMMFhfD3x7bY1lo06L22sMNoVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=k+N4QUFr; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8tTVwB16k8uef/WJllhrbMzu0id6IBSosBAfWCHYzbQkHcdFb0uLIc+Xhs75UuURzOKGCpaje6q/ZabyiMuPEOyhFliNfpQCTW7JN2q2/SUIzj3/O101T/qMmpbdBrmETqCKNPPIebfqkmSv5gOUVjMGRy3dDzCkYFb13szIs+ULF37ZMo0gAv1VNsZ6IOf7yjbKqzVG+1Q76wweEnpN+qG/l1AWtiogHok7aoJLBUD6JIvg/Npi4xhe+DkNGtDKeHT9KvMN/duSbhL8OqqSQc7pvskNsLGa1Lw1iygihjQg7XiHgsrXIhodJIjIAEqxROV45KZFa22yWrXXZN6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYT5Iqo5w2nCs4ef+5F9gboJTcoaIfuQXdIOgdYRWfY=;
 b=e2xYrtnOK41TKac57tTr+LgakbYqVCwn80LDOevD02rX8W/rr88NPyMRYKmISdTY+ktWsrv4ubqmfLZTstrmLPi98GWycdFWn+CaBLmUZWLk8cwIq2sjyq4KDV1j/uUrLD+xqwxBh0VbrOY7PIDjrpvgPWiv27mXHcGKj6+dIUf4dpp9EuCwb8adhvpCqrdB1aj1n3AzUpOjtzk3ej/4yIWjIEm9SFMqRcNJtvtt5x5Kd5UFSmm0E3HB6PTZd6Rw3EcPLd477bHtqoU4dNeO4cDJxEny6hi4QF7MXXE1FeAJOZVs66saenjQkd2xxawuGcANGUlkZ6aJhzJqSdzRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYT5Iqo5w2nCs4ef+5F9gboJTcoaIfuQXdIOgdYRWfY=;
 b=k+N4QUFrNVUmhboHXNADLX4x8Ijjf2hgFjBTVovGVKcC+nBxzukLPJj85TUKIpIjsL598ByyP9oFwbuZjaFNMqp6u83TRbesJuZKZeRUxIgr4vMxJynm0MS0tA7dgxKeZ2mxGQFtJ4YXURa6b0N5ZsIQlWzICBeWlzuPQx5OiixlAqTZds/1r2DcO7o5apUs1YmkGwuqcE4hUrkTUqJPp+eoz1DwyXA0BOTLZ8aOYgOPX9vbIs29btNvY1fOPtqYl+SRUxirbRgJdUBjMopNsiCfQTS7uEaSK/4j7F9a0qQx25hNk49bFo0urbRqvH7we14cv/DAlrq9vFKTqjzpXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU4PR08MB10910.eurprd08.prod.outlook.com (2603:10a6:10:575::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 10:23:30 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 10:23:30 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 2/2] cgroup-v2/freezer: Print information about unfreezable process
Date: Tue, 23 Dec 2025 18:20:09 +0800
Message-ID: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0028.apcprd04.prod.outlook.com
 (2603:1096:d10:25::12) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU4PR08MB10910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd0d6de-44d8-486d-d281-08de420d5179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEGS2ReqNoW3ypyRdU9WhR3IjLQdq/ZmZbUxANKK/1jGv5vapdu3Q8yozts1?=
 =?us-ascii?Q?+vPzmKi/EXnyMbq2giQKJF9hHVMfPALCUc62gZiNeQVwHPnlLFasbup3T5gX?=
 =?us-ascii?Q?gsKd3YZIXdfGbDaMfEONSxfOAJfDwk01IeDHlU2dJ65CXFZVHebY90P+KaJr?=
 =?us-ascii?Q?rEmRaTqI1bQlLmbyYbmvXoT5jHsSUt3/wfnles6zaAm/xL19eT2zg8lyjsm1?=
 =?us-ascii?Q?Smx2X4tDct1sV2hQLAKqTpDbV5Y5xoLD4GHp42jUNsZP1xGGpdQBW08n9eAA?=
 =?us-ascii?Q?lRR82bjQv5YZ9hcpataHxTj8i+HDgxtZNE8HCOW7OQkZ3eDcBnPZ+cZIO/nH?=
 =?us-ascii?Q?Kxtefkd1txhLKf0cdHNc5iGRv7p02dIOyDKIMYuJrrGfHByZIpgdp+JjWDXQ?=
 =?us-ascii?Q?BmPCL3MBY1MMTBEFjr8PXOmKO9E9ip1rX7SaXPlBKMI67o9ainfe0KWBsMfd?=
 =?us-ascii?Q?gR3uaeQBqTYWFfVzb9eb9pNm7YFeNT2sDC7tHqYaAsaK768P7YxJHJYhBs7F?=
 =?us-ascii?Q?SBMOx2e/16OrTV40dLlFxyNDBjLvsjZSq2nvPS7B4FW/0bcGd53Py4G4oB9R?=
 =?us-ascii?Q?YsY5xJJywSCitzJzR71SiToiZvweB/nldBqfGUTSz5TDgPMNhqZ2Ni+da/rN?=
 =?us-ascii?Q?ayugzkqHvge26vIC/6K+54nHLNlTkDlq5LJ/S6P6MWmi03zmnjzequaUdouw?=
 =?us-ascii?Q?44Fy4Nl3gETk9EAXhS/IX5ykkESx8rMTayuy9kqCOwkrMW0X9BIyvV7Txb7y?=
 =?us-ascii?Q?PfRcXFOlhWa/DvOElMTDs7r467JKQIIM/DFDaBNFHetUoQWofYhMGrs9Q+7A?=
 =?us-ascii?Q?APwW0vzzPqu5SAW34154ZgB6Ss+1+ce6no0yeFnzV3QIdHfdpz3tpO0++IuM?=
 =?us-ascii?Q?gOvDwhmWK11ZRe6Ide8kab/FLbHjokfbi9lQe2G9j4LSiG3zqI1ug8yh0RQe?=
 =?us-ascii?Q?4y/x2a8+QKbTaW2W+M9EqVAICd9aKWyBBPyqdUnAsi+t60efgjMOJjGoWffr?=
 =?us-ascii?Q?IZLiKcuyeKMJQGqVOp75e/pPRat8mc7j+kaeuOdgxHt7hGr4+kciI9fHWkNi?=
 =?us-ascii?Q?fiHyDMREu06YkeqOD4YmG6GC0QzMGbVEpgy6uzwuZ3do/qfXkFEn8OlMn4bi?=
 =?us-ascii?Q?Klb1FAamJCAinm/OMDP6qlCQlMtZZ3nCWnd3p1Hzm+UBkmCLgsYi3jKBPgxs?=
 =?us-ascii?Q?cHHToD3Jp7WcvG4OVqew1vwxEoo9X4M6omu3FauIG32p742fzkLHBTtNWZYs?=
 =?us-ascii?Q?Yoxdok2f1WZOAvBHvWN/t2SaJS7cVK0zEUF7prOfdMUyr4p0KOSA6c+hzOu3?=
 =?us-ascii?Q?1G2ArSQuUIBxao/eC2zElRh0mccwzP1x/wEAUisq7i1ycoX2/eh8HP4uGDjz?=
 =?us-ascii?Q?a0i/incKVZwF1hDg7Y6GlOzHimIeuQzC5ePoLrWkduM3waZJ8abLCGzvD36n?=
 =?us-ascii?Q?EGfxZmNtdZq10tchm9khaGS7Xf8KQIWq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZER2tmFwtW7o8YGlfrBBYC+87qPlKWr4YHOonzt2YmUax8bCjhSkhBf15E6v?=
 =?us-ascii?Q?XB8RyStMhp+Dpc0WFFgSqVjCNDSileVI+I44SFneLPh2QbPPFkeplUvUp45J?=
 =?us-ascii?Q?xNXvphPqxYtxm0Vcr64N9aPsfM/OsgLjCWh719FJLzm2npZ1uY26IGHneGOi?=
 =?us-ascii?Q?71W8ZHJZpRioEjrK7nplbwcvBkjq+Mo9O9KbHlaRBbHXlwPi/sgpLnjv+VPk?=
 =?us-ascii?Q?YI+kZMCmSTbjAsiiffstmmLzxQiiOQCZp6ARt7cf7IyYD+nVuU56Z1T38Hau?=
 =?us-ascii?Q?lWeWwS0iZCVQ6UFAVH+gsOD+XkfDtviKiFRUhFA4Z7EcA0fCPEgUugFZ/6bB?=
 =?us-ascii?Q?FcveSEyEwov/lJUbLjvpD917fysIoe7w3xnQOHXuGLaCHii2X12gH/EezNjw?=
 =?us-ascii?Q?aW3ClKAuspoljtpNrB3RCrvxmPUizW1gUHaAbFugT4TpwV1SO+PhQqEgdJYp?=
 =?us-ascii?Q?//ySWiCjaS9r4kSLivWWx9EgQF4zEq3T9aDSrpz8h76RPk20dyHozckcul/l?=
 =?us-ascii?Q?X88w5GYlPxNulibC51m7vRHyF31bxXaRgJjPrURXexqQTXV0PVrtWBHmHFAm?=
 =?us-ascii?Q?Q82RDXOvPfunIxE+ZX7hGCWPtbMd75v4i7FdHlnPBSCqZWJY/6fXirEtd438?=
 =?us-ascii?Q?N8Jv0Gku/UBn4ptgXS0cSvrk3RwqYDVcb3DHUWxLPEHl0x/tAirR7dDbjWbO?=
 =?us-ascii?Q?M36d8yQeqTAvCkEcrVRPAtm5Z3M+CH5ISPhuBrKBp+uZARgHDr60sfQS6nbS?=
 =?us-ascii?Q?32wolbginCu5Qlxwp49CXZHbhmGKH8ePWhp6IDhJxOAO/Abw/8Ht1T8sPaqL?=
 =?us-ascii?Q?9bMwUxCOpgNiUwxCMBogbhMZlFM0eKKM4DomH4ALnFnkWX5gGK+wJJAc86iq?=
 =?us-ascii?Q?GTLZjRprifhecH4kIMwFpnJVaMsumGBpC6GkPlHL5wkf5q6/kgl8Nt/gwk8g?=
 =?us-ascii?Q?8OBJVmAU04Sobxs3rnV2TK9ZJfo5tdAsClXN2L5PtUenZIyYTdhaxEL9YT1T?=
 =?us-ascii?Q?awh5HASSmd7xzXNR3nem9rAnZUR3hIhtTZbvDyZTkRbxch1c4YK3HE1mpaKw?=
 =?us-ascii?Q?73tBY9gYKGeMXe4XLOBrB0m7M02Xtm/xOQzWdfsaqftdCbMvzVkqu7dOHo+9?=
 =?us-ascii?Q?FlqBoUqAV71aqoX64AWpFb034tYvSPCWuNtXJcpJKj+1GMRhxa8dOMSokbcX?=
 =?us-ascii?Q?ciZRZ2T/m1suguIavrAli9NeXI+j3WZM2E7ye0RwTpca8dUoDmdRIndVF+Hf?=
 =?us-ascii?Q?kMVWqbr8TsmjRQ1JGiOC/teyKqwr/K6hcmSaJ4yQMnvNskyvqaoWUFfn0iOr?=
 =?us-ascii?Q?u7uMD9GQ6B4RXUzqNjkPwuhT1t23hhfLBx4auoq58nom5STFe7Ynj9tny4ND?=
 =?us-ascii?Q?Atdg9jCrncf1BuKhjTMmija+Lk7B2oCzilkgvABrN6tyUe6JQp20kOsGvhUA?=
 =?us-ascii?Q?bgZTW0MHuB/dAtUfQgx5KxmbDTf+dz1oH8z7P8vzfI67AwG6h8R5x7kyqExs?=
 =?us-ascii?Q?FZUDX6bEC08lWp7cVL1qwDtu53HMm00XWzPdpjn2mabZphflj4NcfrRgKFgq?=
 =?us-ascii?Q?BtynRmwUYbZWFccGTYUzQ2g8g9WosaoSObinqdBBgH5jDM5C1wjKqqME38gS?=
 =?us-ascii?Q?fUYG9HxQYSRXJhxq8IuC7JYk2o/H44UuGLjjbYZVlBtdIbOurEbJKf2jkfh0?=
 =?us-ascii?Q?1nsVBoMzbWrdb59ZP1Ij0zM/2yUuivivni2veGEkh6iFZkY5LvPZ6woVZcK9?=
 =?us-ascii?Q?GfhjSi/39nKiChQ3Maix6wMWnszfRQavDtCv1EKBmVE7V0ihXIHfcCMLWbnz?=
X-MS-Exchange-AntiSpam-MessageData-1: gwaj3+AJZN9O+dxwP7G/9wIpLzpimQj7/XU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd0d6de-44d8-486d-d281-08de420d5179
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 10:23:30.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQoTNYu5UgIxv9tBfghqHsYuKu02fSlWlutxgtcucjWHzTYwf7C2k65hhFhNaaNddPkpazbgBXLh6ZeBiR9Cgn8eeHWxYxGGwkkNr26cxFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10910

There can be a situation when freezer cgroup can not freeze for a long
time, e.g. we saw some nfs related hangs (due to lost connection) when
stop and suspend (CRIU) of containers (we use freezer cgroup in both)
were failing with timeout (waiting for frozen status of cgroup).

So we came up with this debugging infrastructure for freezer cgroup
which points to the stack of the unfreezable task, so that later one can
identify the problem location in dmesg.

When one reads from cgroup.events cgroup file, and freeze is in progress
and time since freeze start is over the timeout we trigger the warning.
It walks over all the tasks in the cgroup sub-tree which is freezing and
report the first task which is not frozen.

This patch also adds kernel.freeze_timeout_us sysctl to control the
timeout for reporting unfreezable tasks. Default is 0, which means
it is disabled.

Example output:

I used the (https://github.com/Snorch/proc-hang-module) test module
which introduces proc file, reading from which hangs in kernel, to
emulate unfreezable process and it produces this stack:

[  220.994136] Freeze of /test took 10 sec, due to unfreezable process 6192:cat.
[  220.994326] Call Trace:
[  220.994418]  <TASK>
[  220.994507]  ? proc_hang_read+0x35/0x60 [proc_hang]
[  220.994680]  ? proc_hang_read+0x3a/0x60 [proc_hang]
[  220.994861]  ? proc_reg_read+0x5a/0xa0
[  220.995021]  ? vfs_read+0xc1/0x370
[  220.995176]  ? auditd_test_task+0x3d/0x50
[  220.995344]  ? __audit_syscall_entry+0xf1/0x140
[  220.995514]  ? ksys_read+0x6b/0xe0
[  220.995667]  ? do_syscall_64+0x7f/0x6d0
...
[  220.998999]  </TASK>

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 kernel/cgroup/cgroup-internal.h |   5 ++
 kernel/cgroup/cgroup.c          |   2 +
 kernel/cgroup/freezer.c         | 118 ++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 22051b4f1ccb..7e2f729996c8 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -283,6 +283,11 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq);
  */
 extern const struct proc_ns_operations cgroupns_operations;
 
+/*
+ * freezer.c
+ */
+void check_freeze_timeout(struct cgroup *cgrp);
+
 /*
  * cgroup-v1.c
  */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e717208cfb18..097cebbeed1b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3822,6 +3822,8 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "populated %d\n", cgroup_is_populated(cgrp));
 	seq_printf(seq, "frozen %d\n", test_bit(CGRP_FROZEN, &cgrp->flags));
 
+	check_freeze_timeout(cgrp);
+
 	return 0;
 }
 
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 02a1db180b70..3880ed400879 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/cgroup.h>
+#include <linux/ratelimit.h>
+#include <linux/sysctl.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/debug.h>
 
 #include "cgroup-internal.h"
 
@@ -349,3 +352,118 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 		cgroup_file_notify(&cgrp->events_file);
 	}
 }
+
+#define MAX_STACK_TRACE_DEPTH 64
+
+static void warn_freeze_timeout_task(struct cgroup *cgrp, int timeout,
+				     struct task_struct *task)
+{
+	char *buf __free(kfree) = NULL;
+	pid_t tgid;
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
+		return;
+
+	tgid = task_pid_nr_ns(task, &init_pid_ns);
+	pr_warn("Freeze of %s took %ld sec, due to unfreezable process %d:%s.\n",
+		buf, timeout / USEC_PER_SEC, tgid, task->comm);
+	if (!try_get_task_stack(task))
+		return;
+	show_stack(task, NULL, KERN_WARNING);
+	put_task_stack(task);
+}
+
+static void warn_freeze_timeout(struct cgroup *cgrp, int timeout)
+{
+	char *buf __free(kfree) = NULL;
+	struct cgroup_subsys_state *css;
+
+	guard(rcu)();
+	css_for_each_descendant_post(css, &cgrp->self) {
+		struct task_struct *task;
+		struct css_task_iter it;
+
+		css_task_iter_start(css, 0, &it);
+		while ((task = css_task_iter_next(&it))) {
+			if (task->flags & PF_KTHREAD)
+				continue;
+			if (task->frozen)
+				continue;
+
+			warn_freeze_timeout_task(cgrp, timeout, task);
+			css_task_iter_end(&it);
+			return;
+		}
+		css_task_iter_end(&it);
+	}
+
+	buf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
+		return;
+
+	pr_warn("Freeze of %s took %ld sec, but no unfreezable process detected.\n",
+		buf, timeout / USEC_PER_SEC);
+}
+
+#define DEFAULT_FREEZE_RATELIMIT (30 * HZ)
+int sysctl_freeze_timeout_us;
+
+void check_freeze_timeout(struct cgroup *cgrp)
+{
+	static DEFINE_RATELIMIT_STATE(freeze_timeout_rs,
+				      DEFAULT_FREEZE_RATELIMIT, 1);
+	unsigned int sequence;
+	u64 last_freeze_start = 0;
+	u64 last_freeze_time;
+	int timeout;
+
+	timeout = READ_ONCE(sysctl_freeze_timeout_us);
+	if (!timeout)
+		return;
+
+	do {
+		sequence = read_seqcount_begin(&cgrp->freezer.freeze_seq);
+		if (test_bit(CGRP_FREEZE, &cgrp->flags) &&
+		    !test_bit(CGRP_FROZEN, &cgrp->flags))
+			last_freeze_start = cgrp->freezer.freeze_start_nsec;
+	} while (read_seqcount_retry(&cgrp->freezer.freeze_seq, sequence));
+
+	if (!last_freeze_start)
+		return;
+
+	last_freeze_time = ktime_get_ns() - last_freeze_start;
+	do_div(last_freeze_time, NSEC_PER_USEC);
+
+	if (last_freeze_time < timeout)
+		return;
+
+	if (!__ratelimit(&freeze_timeout_rs))
+		return;
+
+	warn_freeze_timeout(cgrp, timeout);
+}
+
+static const struct ctl_table freezer_sysctls[] = {
+	{
+		.procname	= "freeze_timeout_us",
+		.data		= &sysctl_freeze_timeout_us,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+};
+
+static int __init freezer_sysctls_init(void)
+{
+	register_sysctl_init("kernel", freezer_sysctls);
+	return 0;
+}
+late_initcall(freezer_sysctls_init);
-- 
2.52.0


