Return-Path: <cgroups+bounces-12606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E0ACD8C8E
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8A1A301D9F6
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DA361DAD;
	Tue, 23 Dec 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b4pwpGuh"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023107.outbound.protection.outlook.com [40.107.162.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0B361DB4;
	Tue, 23 Dec 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485490; cv=fail; b=WUrodH6T7odtESy+jrdL3nFtXPT9sBhRqedyhRVv8YUR+SLQleFUNP4vlLReW5XvHoxU+oF4pXrDo6NwnuGjRqCXT63fa1oGsXd4woL1sDgUnTI8YteqTVLJMyUY4hgqK/ozKbxEGwBxL7m4G4pfOrVq500y1N0rdUC+FnVHfnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485490; c=relaxed/simple;
	bh=tDhFDg7lVi+RDbm6OkDIPMmof9aZ8zefMPvzmnJi+e4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kWoLE7FQBP4Bcl93NpvO9AMfrB1F0xL7R9Ee/DGoOkCoN8e5lI3fW1SvSNzbI1PKJyf34hP8c4ARU4Bg8GkfTjQbPMGZxOQMYwdL4sfmapseiPCqsE6VmqROiG/FgSAeBpoM9kUD3y7wvA59OFw8/ar5IcwVY4+Dml5Xv9bnVwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=b4pwpGuh; arc=fail smtp.client-ip=40.107.162.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgW/ZzwVRCbamxeeKZF73+cJGBkD36ppftCVvr806GRlXh8duVk4w9+y02MmxjCR1gkmTvQj6SGtsGgYDoCrilFvZmf0clBC2TkrwjIpLd54Mvk/IoVKzLEv6tQ0Uz/gL77xb0MYEn4gg5OybvtEqhOl1U2gaRxNCtGtrn1odSz/oWyrR68BvptCae1IRYaqRhaAeiPwilZPqy4QS/V2j0TrN+yCa8LgoRuWv6l6HrMJ8zwbJ1TO7NfnZelWu6HoaLtoZoxBgBP22LechKrptObYR2hCVKNlr2FQT+QFQ0wu4ID3rCjv3MvVTgWaJ2Hw5/t9f+w0rxLzD2lsOzIOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5V8Td4uAFR0s9RFwzx4IP83svuhE6z2Vv7vEj1vpHw=;
 b=tV/Tq0mMxiS/XUWcmrT80Qcdcu2GH8dYc3noUEm6Ofg1z23ZJb5/xN3+mpNcFSER77y1R9MFbMgBrG5R1psA7KFAIQHg4ZjCKgR9/c78Y4GpSmasPo0cW8jrHTuaST1x+8lfhn01N5tQHpk9EwMrzvKaf8N3ZWqcZMWNNCWb3t8x9F5XMWL5diLUEtvJOVsouNdFerfrr/zI6CYO5lIKjU+nvDrVqAAG33JRnHV+jFjuD27E6ipI+MFg7mmiIXT74dGEL2x3OAD4Lgqgk1M5ztn6FfqZqmYkFuApLNP8peupU8Q9LdxV8YsyQjaC5V+D8dLfIdIy7M22/4ShY+btwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5V8Td4uAFR0s9RFwzx4IP83svuhE6z2Vv7vEj1vpHw=;
 b=b4pwpGuhONhsCHdcZPQqFf/a2jqnkZw6kLDh1k5VuACxuPVLrouT6L7VOQ8UghR3l/NplFIhNy4A4wjw4GgqhwCCLMHjcMGXv7EA6XNLHdpHJKnvHd3zwTtUJAmqZi66RdgWNxCn66N37C1gmGurN2dA7lON999gMdRiRnDiQEvX+TFvuV+orEyNAB/ZWB+nWfp+xe61k1lG6fzuXEaXGhKiL8DLhS56CJVKlPl02SFW3GN08gFLFvB5sJpveYPnTomIENacDJwfj/50rDLzsm2QDXwUYOGT23gLncyK95RJfBRe7vNL1epkGqkTUaN7rnuYuo2zoz2pstyBULsM1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU4PR08MB10910.eurprd08.prod.outlook.com (2603:10a6:10:575::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 10:23:25 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 10:23:24 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH 0/2] cgroup-v2/freezer: small improvements
Date: Tue, 23 Dec 2025 18:20:06 +0800
Message-ID: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-Office365-Filtering-Correlation-Id: eb97c282-00bb-4aba-3e97-08de420d4e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|52116014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AvbTtnO0dw0RLGjAfPkLTgkHToyHySB1wFifV+Jvb1VfCTT50ZJ2XzuVCL3?=
 =?us-ascii?Q?oSYLbEKtPt6coKQMGXZZre9yOvYZ/lDLzKC7FADTLxP3l/ZF69RFAqVZamUU?=
 =?us-ascii?Q?d+Zv4RqrXeymtr6d7gGSj+9SmcJGH5iz41Ar653k3ohT3jkkNaOug/yiE8ZL?=
 =?us-ascii?Q?492YHsTy8QtdJ43bZU1naDAkJ2O49vsGlh6HXaHu2BW6thDn3MgRNJ2XMhSw?=
 =?us-ascii?Q?iYUEZftsUU+ocYVRhhzID0PKZvZQBJnOm8VijDzLkB+W7HLT3BSVDDPom422?=
 =?us-ascii?Q?nkpO9fVmgGDldJqGT7DsHKeB/wN/b4xZxpSXB6c+1MMJNj1M9zExUZVnZZa1?=
 =?us-ascii?Q?Pr5rlCMCSUxTPhQ62unHSr+97QJLW0oiNsIbC9R9TeP+4eYoCFfhqlJu7sbM?=
 =?us-ascii?Q?Dge1HEpx27WtqKTZnLZXMtCpmo6c1fKJqs4SyQp9Kp5/cuBqFQ3mQsAHeBOO?=
 =?us-ascii?Q?Q4CYHYIaY7wPTNL9Z+mVnnP73nihPckqCjI54Wc5YlwXGa/jPnJtWbR697uh?=
 =?us-ascii?Q?ki25Cc6TnRJo2DnEuYeFHsmVzfZqwDLnFHqCY3uDqhN7XHlJJ9GCxckt7KV9?=
 =?us-ascii?Q?lNX9UUNvZVqwU7crbdXCW1b4OLuRle/tMtm7yKqhp0Nt/oQhx91zIpzyQdb9?=
 =?us-ascii?Q?/Nol0Pmr7f6VNn4m+jaIqBVTu2j/SJA2V9z8r9DK236Cbo8C3S3RWs7Bl/UA?=
 =?us-ascii?Q?VIht8r4npY3fM3hrUf6sQtW1EtlbeGx4v6E5RJTc7CSvK0ElLMBTsPcIBwkd?=
 =?us-ascii?Q?5oD5vIiKldCs2y3FKvU7KC3NCt0Rs4HFsaG1h9/Ro6FOt4xiqURn9ZK0v1mY?=
 =?us-ascii?Q?3+b0BMStBmUcZgrodpOJbdeL9NLJYNpZMMXvmvLJedWHYhQfi2RiXw7z51we?=
 =?us-ascii?Q?1H/eUa5hSLvvLx88PN+vz6wBeMECIkI/Y0LvUmAdgOq/znD8RNze3V7G/7Jx?=
 =?us-ascii?Q?JreMqqV1VmckHZsrEBazSELs9kiTZN841rFRtt1eYPZ4EI+IJ2ErsT23S+IN?=
 =?us-ascii?Q?0E/cH9BEf5ZL2+jbXLSuMaMJTP0swrQwIH/7hPU/zuMx2S5KnJTFNVeFbvSe?=
 =?us-ascii?Q?nUgJdOApv/PnAG8iXOEAsh/+MLLEIjMbwUsu1Y4r2MEWKoNTesz3anotlucE?=
 =?us-ascii?Q?suvC0QWGOtjt8NmS8B1ycJ5+g3dtjsAmI0hGiOFpjwBGs/addLdoAFygdtqw?=
 =?us-ascii?Q?CCDP65vrAm2PYoXXsepxyjYvPI71OqV64SQ4tr4eUaARv0N15s24V7ZowNAx?=
 =?us-ascii?Q?EmAqOQHEVrqQj3BUhoQnugbXskLLhC2sH7ud1vRBGSfA/UgLrREB08z5+wdj?=
 =?us-ascii?Q?OWUiuYH1vjHfxCJvVdYu2vZlHM4RZwoF8cUTsn13M/Hr1Vlx8sOL5f9lR4wg?=
 =?us-ascii?Q?C8uTNNZlZ+Qe4KUHCIw2onMxohByLoqDFUnZ7xamBYTKv90IjppDKnIQbQ5s?=
 =?us-ascii?Q?dXWyhd9YXwULAzzqbBUl1TuYewR3E256?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(52116014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9TDqvhB5PZfkNgHFR9DAszksB4GMlvm2m1T1igU7M1D2i5q1usmhI0reE1w?=
 =?us-ascii?Q?e2c7CSPpriPWsM03sqApAzZVrv7b3UK4AkiJgBFAVmYo2ghgC+UnwE34DRmC?=
 =?us-ascii?Q?eQM+Mr/VI/h7LTy278Iw+WFPlPeW2kdLhH4GbO68jxuCiaxm1ayfzA3SE0pE?=
 =?us-ascii?Q?T1iRoUgi2bpEjC7XhvZvR6Her9jd2/7GgybYCtCS9XKdbTWKRz8kG837O3Ee?=
 =?us-ascii?Q?l4V7GfGPfqV4Fuqz9JmXNPzKUbA2eqTt0O2ai6RSbMh0Gy3pIS5Doj04VOmX?=
 =?us-ascii?Q?rQS0wvwSnXoyF9YU0gnFq91IayX5HI+ABNrWPknSrg+/fxdYaLhQLl8tAdcA?=
 =?us-ascii?Q?2IRnRrsWIgDXTut2v1eU+MUdkQK+oCecLYx58AI99DlLqzW/2yIz4TLvpmlC?=
 =?us-ascii?Q?Ytp+C72h49MAoHCFiEzZ9fg8devAoheXuVB+jpFk0cQxblteWlbjLhia1aPO?=
 =?us-ascii?Q?4DdmFQNaliPejl/JjNty9MWJU/Q4ZKl+NIgYjmnDMpNOaO7sAQW7T8AQWLrn?=
 =?us-ascii?Q?3Ega/EikInEQhe828Ttdaclj/Xe5j9xJnONKrgdfK7n0QqJ7vWLMKeSSwcK7?=
 =?us-ascii?Q?aYQPMWjc3BXpp48NSq1PgWwXCDe3XYNQq4SxzMH9pgHNeMx2It+K6MIKp6J5?=
 =?us-ascii?Q?fVevFm7b55+Wy/Hj4DC+2G5EAxZKw9totDzjxjOiXUeRuNgQvd4QPLjjD+Zu?=
 =?us-ascii?Q?vG/NYIqeCPhWXM2/Z/FcWVHyThkWYxWNc4WExFf8ehRXupvS4DeyaMMHdHTk?=
 =?us-ascii?Q?WqZ/OOZ2ND/nNoezMYgKXr6eVqmgi4Avs4jgt+4gp54qZcsS765p3nGyuYQQ?=
 =?us-ascii?Q?JfJUeGGz6b8zkQnMxrSuqB4DYXQf+WH3c3oiUNmAoGOFDspHhqi77+Er2UJ1?=
 =?us-ascii?Q?2NrnFYAUim7pFJXb/lKerHZHLbahZCUJXqd46lEqYDiMlLACjo183Cykpi2b?=
 =?us-ascii?Q?DHd99pNEahVzyYI14dpEn7FvCr1uHlPnZCxvRUPSfJ4bCFc88Nn7Lha3B0bN?=
 =?us-ascii?Q?mg3dS8LcrMvCvGWeX8xpW+uZh4iJeedqVBagrKD3poxTQmUwG9zIlqpdjP0P?=
 =?us-ascii?Q?lybLF/OfjY+zpzo1+xhQ+scdrOftGOB/V2uTxmirunDeH6rmPMzT3pKUqus6?=
 =?us-ascii?Q?Jv0WrFWl/j1idXNfW6A6i2NFHwyY21UjuJ4YMSkex+vN/OAs2+ohrOTtYEFH?=
 =?us-ascii?Q?Y+qsfjc3+NBO0anH92pBSfm77DHJpIetGnNONeyCNlaJJg4neo3yx68QwsUk?=
 =?us-ascii?Q?6YZ3roqgU6AfmT9Qc7pXu1hxmu9iV7Ud3RlwXnLz1ypIzw8f5Fbbz7QJrvwh?=
 =?us-ascii?Q?lzZoyg+5DzL9vMq4X5/HN0jkASy/X8BIbjQLkCfhJpar8AgReB5BclowqlmD?=
 =?us-ascii?Q?kWZOxjtmnj+ah2DO7bewaGnL3dzzFL6rm/8R0DrXlUm0Za9yDMLxQ1ROLczC?=
 =?us-ascii?Q?VGandjOsHDiaspaC60wu93SQpt8XZqHZFWJfb4Fd/NwZfuWOC8/s1e7Fl9yX?=
 =?us-ascii?Q?5wMdO0cs+TrZT+MHaW2WGed5GHU9VdfP8AS7SKbl/KKEo81yjFCtTntVIq7s?=
 =?us-ascii?Q?b7bjD9enHEU9TgiPCLjrCr89Bzn6T607MBtvTJRhUODbfNPw9meZU5Gg1NHK?=
 =?us-ascii?Q?q2uicWa2XNazmsgjbmzac+2CgvHe1iY8/Wu17ClY7iwadU0/+lICHuzuleXD?=
 =?us-ascii?Q?hP5g7GXex1dt6DKplwUcIkazuVRTFGa1nQOjc+Ymz7PIx0JCTymYvUPz5a2q?=
 =?us-ascii?Q?jyRmk7Zywc77Ieb5ONZ21fQMuTUY6nxcjXx9aV3tNjEDAMU3icObSSroQNX7?=
X-MS-Exchange-AntiSpam-MessageData-1: +aCJfkx4lDNqeelOt4Txlcfmd4FqOU2QGg0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97c282-00bb-4aba-3e97-08de420d4e16
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 10:23:24.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFehpez531MFnBtPxcC6h0kz1wj3zerMt0NaAwzDLvTiH+qcU3tHylnVM47m/M+FXLnRE1sJCtZJddJWFBpT+pcyPH7LEnYeLg4Yr0qAglk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB10910

This patch series contains two small improvements for cgroup-v2 freezer
controller.

First allows freezing cgroups with kthreads inside, we still won't
freeze kthreads, we still ignore them, but at the same time we allow
cgroup to report frozen when all other non-kthread tasks are frozen.

Second patch adds information into dmesg to identify processes which
prevent cgroup from being frozen or just don't allow it to freeze fast
enough.

I hope these changes will be generally useful for the users of freezer
cgroup controller.

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Pavel Tikhomirov (2):
  cgroup-v2/freezer: Allow freezing with kthreads
  cgroup-v2/freezer: Print information about unfreezable process

 include/linux/cgroup-defs.h     |   5 ++
 kernel/cgroup/cgroup-internal.h |   5 ++
 kernel/cgroup/cgroup.c          |   2 +
 kernel/cgroup/freezer.c         | 155 ++++++++++++++++++++++++++++++--
 4 files changed, 161 insertions(+), 6 deletions(-)

-- 
2.52.0


