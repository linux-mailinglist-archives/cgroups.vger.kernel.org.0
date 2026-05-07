Return-Path: <cgroups+bounces-15667-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHeLM5LB/GnSTAAAu9opvQ
	(envelope-from <cgroups+bounces-15667-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 18:45:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E84EC60D
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 18:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 266AA3017030
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B25406262;
	Thu,  7 May 2026 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="dSuMBH9u"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023085.outbound.protection.outlook.com [40.107.162.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56D36C9C1;
	Thu,  7 May 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172301; cv=fail; b=A1oA+JuDh6OrKHybeIlG1ifkuZm1J8mF20I6MnU8JAaW/Pf0iuwW6xKmTsQgpIWKiVEnKtEBKnu6ha4Ybaaxd1jwuLLdd1gaSimwujutu2Ip/rxG6T+RyZU2ACbUDe1TmlEhrkRlRYCafH9F5byrNL5ApXTJorPRYJXyzWtpoY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172301; c=relaxed/simple;
	bh=6Jvb6muBP7OnWFgYU4G3i0kl66Zm8MQtq1otm0zSPCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsQr7mqkwqHDh6GZ6MrYXnpCWUtYRqp6r4tK8WDiXCg8HLiyImA9HuFgdrWpLdBK3ogOp0eRW9ZQfMfq3jnppGIhG43xWEpUeJ1H1JreIxreePaHGqpCFfjvYmYo5aWF6vItnyfNST2Q0riJdUa0ORp1XChdWmC7Jwf4BjTuoeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=dSuMBH9u; arc=fail smtp.client-ip=40.107.162.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVNvV8rSAl8OTqT5+UN3Efn3y6HifsXElt/q3CbotqobFdhjuSWACZae/1/FQG8s1C/KKXbIfsLAF9juCRqbGzVjOqRXF7KtjMBmIFkE9PgbexeH5p1pjwVusIWeZ8NXihvj95J6uuGuFrHkmbScSHDBCMTMbPXjAkLLq5w8yNq85ZgFBb483KVKyP6hH8V8bJdIeADrSuezSzrVibCq9sbIK/dxw94lWtPQPCZ+Q0LBhWhWjOgdJfDjRhGU/DCajtY+0wPeChQUUEX4IU9FihuRdH9k9nQ12zGPXSVdMbFgd9dwsHFzffcm2lzTB4d6RAL/m+Xv8Cn9hERuHkKqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMjaVFZNcWEe2S+CmyoCyusIkXPuOlDodBKTLjLOb9o=;
 b=SdmxafCvfGpTLA4H1utp0wJZv1DsG9SsTfXEKh94lDKmKTUY2Vryg45xziXQubbp8Riaumn5GpztmbJwZ2kbzz2zzSdqFna26CWHe87lifbLVShp+yT76pfO2URRghAoZlUdjgELhyop2+8hXeX/X7gg+ICSKA/LHhb4dFJEeyhKHk5f/JnMq5j270N4+4J/FC7QCPtvBeuA7riB78SDDJLmru8lADcmcHKj4gfngiOwTIr8NgKEXblUA4gT1BRMe0l2gSFJSc2kRxLDR4A6VpRAAfrpAO0O4z1DIPj1Eq04yTK20KlsJ635UGSSH/dxExCkP/jVbTW7A5KT/FCTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMjaVFZNcWEe2S+CmyoCyusIkXPuOlDodBKTLjLOb9o=;
 b=dSuMBH9ukFUzqWTI/grILmu+2kqlewj+orAKw9zJIGZBbDsgZvPK3TYAaDBdaX9LYfgefmM/kDYhYL04v9rupktmyS2wue1za/KJfpi5/lLLmzGC+cYeGmFYAlOVRB7i1qGu2ltArvVogX+FruoatPuUtLj6LJ4W3H6QYUoNvwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by AM9PR03MB7140.eurprd03.prod.outlook.com (2603:10a6:20b:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 16:44:55 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 16:44:55 +0000
Date: Thu, 7 May 2026 18:44:50 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Yuri Andriaccio <yurand2000@gmail.com>, Ingo
 Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Yuri
 Andriaccio <yuri.andriaccio@santannapisa.it>, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies
 of RT cgroups
Message-ID: <20260507184450.07ce0638@nowhere>
In-Reply-To: <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
References: <20260430213835.62217-1-yurand2000@gmail.com>
	<20260430213835.62217-21-yurand2000@gmail.com>
	<20260505151523.GF3102624@noisy.programming.kicks-ass.net>
	<afpLir8tD0Ycb3D8@slm.duckdns.org>
	<20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|AM9PR03MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8b8a79-8773-4457-e0f4-08deac57f79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|786006|10070799003|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4y9UuyJG1t7PinIZp/vnI0r8sCX5riyU5ALU/NGoZziPNNkjJtFT3ghAFSgtVZ5OhomKX9lLvA9W6PAFF4SUDhl519nylucX3cetTXZZ/9Gdn+kpob1iUhVQIVkGYsbwzeQo3ENofdVFwuG7W41OXp+hoDknQnjMRdbIyJ/NQsxKtKtCMdjVNvgJwLp5LtFlpDG0XAtXKMLlcJi4BtMtdFga1qFZohg9GmKBbAHm09poGGbfceVRQMTQW4nOoVb8vlyficYA1322S4PcPr4H4DpBEItQlVse3yE/9qs9FzwybA6a+sGDAYAG5VkibMp4/skvRSQi4L3e82Sgls0WatcBXtuoroS6wqBEXcmJKDpFuT2ahpalBjZn0CyNFuiN/CUeiod2jdyhFj7W9hM4L1f0814vqgwnubTd7pIrmbBGhl0vRefPk+hcrV7VpqGfDvMwnlHofohAEnCeFPSY2DmIhrNLlCOb7x0iKhAn7O3h0xT8QRmyTT7aMSss6vFZZSGoX4hyPOLDYYPUxKI8EwXOQfwWNzFLl3DusBoTwXvpl6yftg4NyxnBU9ZxV84BrVi9fKXX7tppt/LtWHUFq6wCpT4IMzZNgVO64Qn5v4B75QLywnoQg4VNEMCZvlO8mBSLtetV/YFxjld/Bi3OvmNt5I/2+wRgEG8l4AD5WrwFJqZm+hkM88e5oQbJQUeW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0joS9PH/juLF89ccta0tl7OJJFIoQJh+YcH/uX7RCLeRrmG5zrY81ZFPDxJP?=
 =?us-ascii?Q?0QT6Y+8b+YTJJ7n3PuLIBeon76xdp0fyHJq9WfkHUZPRVx3s5KIBWqy2xNjh?=
 =?us-ascii?Q?MOIDLOGrSNXjIOSyFYLpxgxwM5+AVIK7QwFPiSodT7D+b1vXugGsoFATQxUj?=
 =?us-ascii?Q?1EQ16xV8ikE7OgNCCnbMfyUoxIRki7LHfKuKNII8gmLRw2vIKKtNIy3JaYC6?=
 =?us-ascii?Q?oJHw84E7lWP13ynzIfOU+NYQn6PehIWY2+6r0GmDJBmD6jyAyPywIB4e2wsR?=
 =?us-ascii?Q?GJr0kn6dMrzj4IJk1ChknMKuv0WBMbLpIpmFGAcNqlNkHaVzaGNj6fJx/QdZ?=
 =?us-ascii?Q?fJRcYCw5T/W+FYZ6kk9Uayqh4vzyLG5jLcumyzqWshgEuxuqPpkHESzzerNw?=
 =?us-ascii?Q?F2jI3Y6oL4y1g47iRQsGo9TZmxGpxBVKT5iUDUh5o+hZqYO4SunYKzZaYpPK?=
 =?us-ascii?Q?Fxy4LnK6EECXvO+42KrPJg+TR+2k34pCPu8TqpZh7sXoJFqJOdMuVeXRhSGw?=
 =?us-ascii?Q?zxoW1cR7KqlHEvGnNMvBuR53qsGRHE2kLIxlvXkDzcOiljYDfYM7A2GdVhAF?=
 =?us-ascii?Q?Bw5WL6hVQlQS3e1RQICqnGwtR8eABz3cYccsHOLYnwK53WzI/QxL28YWZLfR?=
 =?us-ascii?Q?5UPtBtySKvbX1/Zvzy9Hge1bUq1lAKl4S5fowE0vuYNToat0gX86m0eLlBsI?=
 =?us-ascii?Q?0FHyBkTHg4kDYsIBCchS1tq7xSrXKVYMgw3kraWlpUFdB0nPS3HZKJfdKDe3?=
 =?us-ascii?Q?yfJbUclamYg3QepOxFAF+DEYGOI3zZkGoiLZhKqcvIYwQZ0L4omwqsuZC+BB?=
 =?us-ascii?Q?BuCHwXNiVervsyf+O6YOW44QKaT3Q+QiDw2Iv3hP3fSLyVLbYYVd5ai2J54l?=
 =?us-ascii?Q?OFrsLNbih9Hlk6oneS8jRn+FrltVFtE8HsyajQlttUqkpBm0k68ie6IGi1o7?=
 =?us-ascii?Q?c2iQ9VgYbsI99K+JFg5K1o9F/J56ep4k0f5pZuR5nzZ4cLeeiXe2CWSS2tFz?=
 =?us-ascii?Q?huHXTYA+niLUOQ+qZ2M1PvBMUSmVcnnEPdYT+C/2CB8+upkg4hL01WrM6a76?=
 =?us-ascii?Q?KyzTSWrKAqS7VioQ5j35tnyUs0KSLtWSyZUMknjWJdduOqIvD2wRwb4MXPv7?=
 =?us-ascii?Q?tVlA8g8YLF3vLSM58oOUqtaXmqnGarvYKL7PUqph2Lk/S8yr0j19Mc+DTj/u?=
 =?us-ascii?Q?GVvwpO9yTvc7ZiiJXcy4tkuN1U0YH/cD4oGvwZZviJQdXOdxUtD6xmvgrm1g?=
 =?us-ascii?Q?QjHa66gw8jHBTjmtx7uvtKNt8xRsMBPs6JSvE7bVFsiRE5Eb2KK9Llnngbd0?=
 =?us-ascii?Q?c6dRv463ihmymF50Gcpe84q7AfP2YZEcA+BOi+49Vutri/jslYI9kEaKJgF4?=
 =?us-ascii?Q?NFutkxADa8IBoYszHJFje38c+QNiOQI8icHMhTao8GFicBCztZ1v+4d1pKUQ?=
 =?us-ascii?Q?+U5gA8qKkfN+GsBF4DX6Qt7117uwh0qJ724WDvzjJ+659VILboD4dAIKBWSO?=
 =?us-ascii?Q?3lTNcBzlEPDeKQN29+DO+G/bISVc04sgBPjITs6D2ihcTmuhYYIjMHNRd9XO?=
 =?us-ascii?Q?bALHB6kP+viiPiqxcIbUJgKSZ6MZTW2qN7c7DkfGHPI2UPhwp5ScwTo026PD?=
 =?us-ascii?Q?/y7mKU4+qczn7vObKrU6uZHettdDHzos5g1F8ovwK+rUB9dG/DdZ+hsl8LGa?=
 =?us-ascii?Q?0VuOTvvz/taKsLm8SwRp5ac0pMU4qbFcNPYFzs2Gu3QN17j7iM1+mM8xoj7n?=
 =?us-ascii?Q?s7+W3dsKrELyoLr6TNuESax0PMfMLyQ0KNSXJP8Yg6H4bGyTc4PUk5uB44Yq?=
X-MS-Exchange-AntiSpam-MessageData-1: k6jta/a31ohA4/V170xYZG/29c3A6BomuH0=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8b8a79-8773-4457-e0f4-08deac57f79d
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 16:44:55.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rCLC1CKAUo5Rw/vOvF9l4uNwgp5x82ckvwmqORmsfKriUrC6Ft3IAO6166uCRfR6S0vhnKP7B17wnrxe6D6yhwKq+sREnh/QXOickLBmvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7140
X-Rspamd-Queue-Id: 202E84EC60D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15667-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi,

On Thu, 7 May 2026 12:53:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > - This has the same problem with cgroup1's rt cgroup sched support
> > where there is no way to have a permissive default configuration,
> > which means that users who don't really care about distributing rt
> > shares hierarchically would get blocked from running rt processes
> > by default, which basically forces distros to disable rt cgroup
> > sched support. This is not new but it'd be a shame to put in all
> > the work and the end result is that most people don't even have
> > access to the feature.  
> 
> Right, but cgroup-v2 allows enabling/disabling specific controllers
> for a (sub)-hierarchy, right? So if the controller is not enabled (by
> default), it will fall back to putting the tasks in whatever parent
> does have it on, and by default the root group would have and would
> accept tasks.

If I understand well, this is similar to what I was thinking about:
having a default that allows creating FIFO/RR tasks (and execute them
without runtime control - so, without being served by a dl server)


> Additionally, I think we want a flag to allow non-priv tasks to use RT
> inside the controller -- after all, these tasks would be subject to
> strict bandwidth controls and cannot burn the system like
> unbounded/root FIFO tasks can.

This is something Yuri and I wanted to propose as a follow-up patch,
once there is an agreement on the patchset (should be a pretty simple
change :)



				Luca

