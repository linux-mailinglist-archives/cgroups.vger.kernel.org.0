Return-Path: <cgroups+bounces-9996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9BB5363A
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E792316496C
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A23341663;
	Thu, 11 Sep 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8IbUfVk"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627623168E3;
	Thu, 11 Sep 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602142; cv=fail; b=Htd6xYpKqiHWx8dWGJt6a783C+lxUiy6y62r02gyq8b8g2oZsDH3yGJD0YHHG3mmPRip4OgnvgcnnO/2OylcPhJC/AZxpmqSnBO0OjfZfMl6XMJpVnGoQ0J9MTCjZWKpKxH/SBm+d0PJQosqGSHgsXxBwVI3UtMG6WrhoNJINi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602142; c=relaxed/simple;
	bh=9LdLRu0ExOBh+//xgppKS33NL/VWRqgBuzrPl92s2RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xi4DGnjqc+jTAZJh3D0s7MXab4kF0ROEVaL2NSXzUH2EpwVbsag6NE0/M3WII+JaMvvDVssNsDZbv9Lbmd5uSPp9rxZ+yNZbsugxDwvWO0wUyKA72mL/NgrmB0WMIw+HvaUjbzzpiSVmfKYG3T/1jwPX3zPnmjoTxKGy+AZsFUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8IbUfVk; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLHqs3s5quxU6TEiYW6tpiJsgxdnqjhDeFn5Dv6qNM9MhRZZc0QvN1SkOzHAgMUK/DcWY0g89Wd4mttD4evvWauWDIYVppJoscEs4ua/uGhN93qiM4edgJCOGz6Hi4Xt4QT8maAgztuWiwPq3pKljv78QULlRsn3DTT1qKXwuao3+jVgKuYi8/4fHIBerXSdaFmGcq554FjWQlPP7Fgy1fFwcoHCfSccqBYH91OgS4cIK+xtvemOM5qLNjgaycCSADF921Kz3SovHHy001FV3EjA7q956zUJEk+3FnGT/hUfxb4YfporI97RcXrSvoKjq5WIKKzSCxjVsnzyWAjrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpBcAKRKdZ32TG+VJr4r+dcnAQ53mugP8Nk1Z3ECSC4=;
 b=StCJOZMLTUBgcKWPvMK4yIUxGTGH5EY3Ny59699AojTuF3fmOtDyGMSkokrJefk7nXiUCZPrhTu5EuHZGF7Bc6h5e6H8SD31wH+pnTPnU6SpRpfPqLmwrOBGUtg04V3yomLxQhWnyk5ANftq/dx7nQrJSGotqo3/rq1UccVbQ9u0Q6OV38jC75wGnyym3R0yzexadqFnPzK/92pbr0bVNR5p+LfJY3JMUo+sEFI9ytt0ukQcvRC6wjTY2AZz7g9Uek/uun2/YPpSetKDH5kquAZabPxCJ3FDJf6Uc06S5NMqqfC6SqJALVJujCIDtqrOktSElikCdp+gHROwi8Wgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpBcAKRKdZ32TG+VJr4r+dcnAQ53mugP8Nk1Z3ECSC4=;
 b=M8IbUfVkAUpodPYBTmHrHsXuM4/LLvMRXUP/JMB9ne26QANQu6Pe51imULTD8r52KSbfrcytJ7Aq345RdEJ5DyjL2oXGxSwOtarAzr44fEgC4dcI9u9i+ya8FE3nEr74sSdyNPrcO0kQGMazBLuyEMQSc+jbrGKUL6DFXDaHG4lM9IlGCWWIacA41VnWAyu9Zj66A9Y8ueObV9TUTcRwOx4YWQNVqx8inxjvVLqOV2BBetb7rKGNUC4/iiv5fEBCzCkXAvBTEfM4m/OBHPKIK9DNGXbF8BQYAQz/ViLVTWFzw8GokRjKAgLAAYxC9ehWmXU8TZ6y1LxIpiUD8Oop/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:48:58 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:48:58 +0000
Date: Thu, 11 Sep 2025 16:48:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <aMLhUJ9w7R-4HGny@gpd4>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
 <20250911140022.GP4067720@noisy.programming.kicks-ass.net>
 <20250911143000.GT4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911143000.GT4068168@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR0P278CA0187.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: dd66dfd1-81e6-4c96-1b7a-08ddf1425685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2re4a7wnBw055xceeqwvV1gl9Ptx8lNwgBUi+h46By9AW5IkSXOgHC1UGXJ?=
 =?us-ascii?Q?kFq3ZULCiFca6AO1GghdNSZDwkP4eoG+aTEavM4XQlPwxiesejRmZPXXwzTV?=
 =?us-ascii?Q?YCroH7uyG+munFBQ3unQ/1jqiDAsbamztrQTyYefhoGaL6z+FPtYg2L2ZFzW?=
 =?us-ascii?Q?TceVeUCx8P1MJVPC3SN4P71RTZ5fn4otfKSK63Po6DF89YNlNOjCmH4z7fYU?=
 =?us-ascii?Q?83OGTdvGwlb1Zq9W0oxEkDzM4NzSLACfvPvbBPF6dBBOOp3C3ryUlrFnqW4p?=
 =?us-ascii?Q?hJnuMfVuOic8bh2Dd2UC/6Hopdo7KC/XwTtvljE7cyKof3tnzZGySE1U98qm?=
 =?us-ascii?Q?QAJln+k1yELVJwvd4L41CJ3wofacV+JkMTFwR+WRomyBGadzgWE+KoDPiVBX?=
 =?us-ascii?Q?8pxX3alLsdoTvlsH3xMOMcfMTEvTJZlXBpMQqUe1flUNoEJH1wU0EEUmhYbG?=
 =?us-ascii?Q?jbPe90UlhBfFaTW8GimkxkOnUOXu/n8mktOgdEnl0MvTG1EuzNKmGFonTsDV?=
 =?us-ascii?Q?xK6D3y575s33ooqGw2wmkq1UrdBynjMvxl1g5MgFqKKRfL+bi04h0GuCUiQy?=
 =?us-ascii?Q?J6XtnSOxwvSGs7Y2ita7aPVv9Q2pNScejWt/XdwMvK0Wmjno+14r6uqf0Htw?=
 =?us-ascii?Q?4q/62lhjoLhB0/GPapVbkEW5PMJ92gMxiJt5SX3IZagLraS8QZA/LnNWYVUd?=
 =?us-ascii?Q?ZVaPl/zgGcJt+K1ZyTcoWhnzi5FbG1LDXWOpCdQ85eiKK3qumb+mrzdT+8Ey?=
 =?us-ascii?Q?9Me7JcFsvA2Toe52I6RcLOaF3rA84/+W5IJc6/pivutzXygGgW2HGmTHNNLJ?=
 =?us-ascii?Q?/mZtJ4HreF8j8nuX8eeIvMz3zksiTWdT08zmCjRr7vYB5Go6iWxP2KOSEmoB?=
 =?us-ascii?Q?oibRQ0hoi39cEWIVFHz4M+hKGa5QPvtQFLv1DFZL+P7Ghb8jOGR34vA4cPxz?=
 =?us-ascii?Q?lX4gXviwvQiRvd6ZgJClH4FeLrWuU8GgwPiEGozHVijWwctk3e3RhS1Jh3DL?=
 =?us-ascii?Q?1VDqPll88S2GLrPhoLIb1c1BUMBakqDt9PqO0S2HQFtMO1Cg0f6QX/UyLYX6?=
 =?us-ascii?Q?F9JjmtRvuYBuhXpB5hB6ps7WE3lLWcvsMTMGq0xWqJSr8abwPcBOJLQE8BcD?=
 =?us-ascii?Q?8IOAzzTxkFJTNLw9Q5R9rI4+YntJnQwHAX6lvNsmoLxcqNyvkEYOtEqHu0tz?=
 =?us-ascii?Q?UJpti57QGr0TlL2l4gn9yCr9/1XBpg+tmI+i5kFK8FAaYlRBM0rw4ijMjt1C?=
 =?us-ascii?Q?DCQ+bviIz9UwRCfyRQVHXfrLNJ9mDNVy2flhG5IfGixwayqiIT2Zsm5AzHFP?=
 =?us-ascii?Q?9utGlYzD3oN+rB/ymU4qtdzHJq5OS8Jx/aw8itQS7cwCfAYefXn1bQZLmaeW?=
 =?us-ascii?Q?X73CA31SnXGlHwnoAbA5FDrwdScoRwKnHKuNkBSePtICh3W1PEaoVxdGXC7y?=
 =?us-ascii?Q?6uycp4sgruM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BxO7hpOZD9i/yfVJWsWfPW9pAfZ/0tpYqGT2uMJ/ZCZQwogRzYVw/0BtECJA?=
 =?us-ascii?Q?c/HlRq78SnjB6IbsgNtZvOnD2Emp9jIxlBgSV5uF2Ybi7rQ364vj9QAKsp2z?=
 =?us-ascii?Q?6WEeRjNpRGunHE/odHnDQmlej6PtYxz3s2Z3Rba1LHWOOWP79ea5cVTP8o1U?=
 =?us-ascii?Q?PxlgZ+JKCEp5+CXiOu/siHHdZa77bYB3kH9ekL2UITNTFO5QUMmONEEhoxMj?=
 =?us-ascii?Q?kiKYx1WKpWhFnMbyX12jRFo91fWQYSp0dL54jYebrARruAPepI7Y4TKOIjoC?=
 =?us-ascii?Q?/zIItuxqwjIhDTs+p/PVx7TWMuhHGCSPEfw53hKbO43mrx95KjVAVn4jXpru?=
 =?us-ascii?Q?5NLEReKUlkL+iyQ6Qkvb7Jfi9Jx7gWJXwHJOy3KApcsz4VlAKIqvs5CRnIux?=
 =?us-ascii?Q?nxCNMz9dOo98PgHvjyESX1Cnh/7InVe4qk0uPvq5tqZvcFaa/twb/TLpDyUS?=
 =?us-ascii?Q?R6IQ//ufwVZwRFDLIkGlTdXRrrsaNC67uLV/fUvamXYfqVf9cWkyTadPG4SP?=
 =?us-ascii?Q?WILpZDyOZOHzCv+a54YBKP+b0twJB7CaHpePTkC2ekhKjBdiW1+UoXB25aEk?=
 =?us-ascii?Q?UukMS+93VFjNUc9R34CdA99C79MlrU3I+9xAVhys6nCxnb8ePLz61WXMpF0H?=
 =?us-ascii?Q?Y2eDjUXbTtND3m5uuvH3jQ7hZIHqvAwqRdhQWP6LpYHfCw7uOwMnAxUm1yFz?=
 =?us-ascii?Q?iJ1sF06V0oOmU7O+93rKgzem3V4HlRQsMpFBcifuXJp81Zmxl3vw/j+NS7JV?=
 =?us-ascii?Q?4VcMB82iDqoOfA3H7YzHLcLAHYS0hpv5tADs8ntkJPYGCYi0BRWRIBPzuz/N?=
 =?us-ascii?Q?/PDiemTrqi5TaC5+/K/hzpuJP1qtaJwQSKIRfLYyC5WPELK4LTYPQJVp/6pD?=
 =?us-ascii?Q?hLqqwXyL2fa82p9KthwAQq4ZOQ6qicfbzOjGJ+fQf2P79ZnD3VqKU1qtNh/j?=
 =?us-ascii?Q?Y2wDvquqyOmMLTeT30IE+SLCgBf11Vkhy1xrpXnkjlocrJrNKftBA1H5S/Hs?=
 =?us-ascii?Q?wAYl+zMH6iOhYfRMw5CrHlbPauFIFlFLz26IfgrQ+ZTw+6+gPwHNOMI+LYT/?=
 =?us-ascii?Q?OsSPgRDPif3Xoa1Y4dAw6VlQpGuRdU0vbSZRxjObp27KaLqxHVwVd8VQO7OI?=
 =?us-ascii?Q?J4fqSQRi7z3LsNOlFQk6NCn0tPo8WuH60lJqYH/gr1mmZUF/7EEKgwofDBdF?=
 =?us-ascii?Q?RyHs5IYpAghs1z1bpKVVUlCyRvitSHlthKEbHVjzsX5p2N9IX0uCoDJu8Xde?=
 =?us-ascii?Q?yclffWj0RDvym52DEyPU0g1HGLNnZv7bOlh+V0ilpIdp4C3wpun9mFWLOt7E?=
 =?us-ascii?Q?N00iJR0VuWAqp52V4Dd7n8c86A3415ciDgQLAG9WlQB5Nk4ObjE1HrTSIfAZ?=
 =?us-ascii?Q?AEDBPPiIiEplPIbYGxEzm6Uyn9VLH2OvrXe6UmWyk7gNXBJQt1sg0OfhfUv8?=
 =?us-ascii?Q?Plz5pDdQzKBlscVV8hxODX0XqSMEAssDPs1vtyS7Ql5fNWeGrWWYZedX2S3E?=
 =?us-ascii?Q?kkoD+59q672QA5fXoPVviSm7w3W1X7r/gKYwp64qWutm7UG3IFDjt/J4QXPh?=
 =?us-ascii?Q?SZ/RSq+FG74AyWNJJgAtqd8IebGJQnlQSeKvUyMq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd66dfd1-81e6-4c96-1b7a-08ddf1425685
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:48:58.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFxvpjDoUq8kK45/DzAmQ7q0OBdNrYhyLZj6R8ACidIWtgbB3J1wTj8wFJomWPnpfnaQF6d1JzaEbBUTGXsf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197

On Thu, Sep 11, 2025 at 04:30:00PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 11, 2025 at 04:00:22PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 10, 2025 at 07:32:12PM +0200, Andrea Righi wrote:
> > 
> > > Reproducer:
> > > 
> > >  $ cd tools/sched_ext
> > >  $ make scx_simple
> > 
> > FWIW, I only have one machine where this works. Most of my machines this
> > results in an endless stream of build fail; same for the selftest stuff.
> > 
> > No clues given, just endless build fail :-(
> 
> Ah, I need to do: make O=/build-path/. The one machine it worked on had
> an actual test kernel installed and booted.

Maybe you need this?
https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/commit/?h=for-6.18&id=de68c05189cc4508c3ac4e1e44da1ddb16b1bceb

In case you're getting build failures with the likely() macro.

-Andrea

