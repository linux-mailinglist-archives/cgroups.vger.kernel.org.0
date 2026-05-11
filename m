Return-Path: <cgroups+bounces-15733-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ/pHeimAWpDhQEAu9opvQ
	(envelope-from <cgroups+bounces-15733-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:52:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F650B5E2
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 564673017327
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE32D3BED32;
	Mon, 11 May 2026 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="gDnlJg21"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023098.outbound.protection.outlook.com [40.107.162.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9848309EFF;
	Mon, 11 May 2026 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492418; cv=fail; b=KeQ0eBJ0ToRRY1vPX30mJ5L/dfsqi//5Cl7MHkLaJ5MYrZmYKlBEHv224E8soeW0Ef9wnnAK/7ntNp+vE+hrZaKAJzPtQo6lW6NZJjx3K9cXd7vG0SiIn4HqRb+nayGv5MyTH/U5KAYOxnheVg0MVj7bH1AtOci8fNSIBLnnDPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492418; c=relaxed/simple;
	bh=rmEJUkJPls/zBIQCbOl9QclNj5hpPq0G8l3b/HPfAAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ms9BsWm1cUQ93qOot94GzfCz+CKuL8XicV5MpzwJhNAOsHeSnXbKGs8gutlPWu6O58ozk6mECCPS9g86tur9EwyPTvfosjnLdtIVTWadfpK5Iu5oXWusf+BlxZTGYb1GDHjVystOWMNY1S24je0a/RIaEqtQU9QmHB1bCrEcNrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=gDnlJg21; arc=fail smtp.client-ip=40.107.162.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp0aG2dzc8+d3YQqPPmtM+E1j1o7halIj+v1JajsUk6QGweOI2FEzbrSsoVsmr+BhicLgrPQzPyYMuhYmtzGCondC1Q8WBMbVjwEYAz9N8FB70cWRAkgib3ItOeu098IEcr/4GJtu6O90JjVQrNVwEkzNLK4QUsZzcfihijqIkEX9/aoIrcnclgMWBeoLPEwIZVE3fcnbi/PspSuIE09W8qRraJ7asTeC8/KNJqBmfN/5W7wyks12raYF5BNxcFwD1r4Gho4zGtpUAvYbuKSWuDlOmP2eWXCslgh38a/+OHIhX8NcEbh2UNTUvRnJ16Cxwnts5BFOz7d2GY9kE50jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSAuJ6jcCXndY+k6nhLoKAAGj1Thp4S8KtktA464xE8=;
 b=LVb9aANkk/Qr7/LHJXf63a8N48isrisFplorA49NksrZBdo8pzH0roQ9gsdDr21ATo/yuC38jCHlFoG9EQ2qidbIaPaFSJPKup2TPS7XzJLzGoaWjBOIkxetht25n1vwNRjPxR3iuosqAfpsYO/KeOdPFkW61mG68m9gDcfQ3zGK8sceWXLsyKhqVY4DkVzaO3O1763BmFQNegFjCI8OeeJEzaS3ekMfw4P3y6lhElwuWH2qW/Mizz5WJvp+cL7g2UgG+kWqPE4nOsm7mAi9eTx+nFLuAXye7PLPlzskjjg1tWSoPnw/w6fsmriMrOWQH78bVRqd4v3eNOw5e/CnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSAuJ6jcCXndY+k6nhLoKAAGj1Thp4S8KtktA464xE8=;
 b=gDnlJg21zlurF7ko7xDjxu/OzamwsKZ5Mdaby2TOIj6qQ0fi7TzOY8huTBV3pbiIDTkgATNG4srDFTvXPWIMORW2kPuh08yZqfQd6FpMPnqLo/R2nExKR2TbjHmfsjVMBaBjFvX+h74daqBRU34fePr30d+7hwNOktSZY2WPgIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by DB9PR03MB7260.eurprd03.prod.outlook.com (2603:10a6:10:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:40:09 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:40:08 +0000
Date: Mon, 11 May 2026 11:40:04 +0200
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
Message-ID: <20260511114004.0fd8d54c@luca64>
In-Reply-To: <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
References: <20260430213835.62217-1-yurand2000@gmail.com>
	<20260430213835.62217-21-yurand2000@gmail.com>
	<20260505151523.GF3102624@noisy.programming.kicks-ass.net>
	<afpLir8tD0Ycb3D8@slm.duckdns.org>
	<20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|DB9PR03MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 16dcb79e-295f-4bc9-941d-08deaf414994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aIzM1Uo1Pf7NVE6gQPoKVGxNew8rawuWJvoutpZRbwWWQBoyxMNLCTVE23ljIXLXPoAO5SjYIYXJopkeYGS/plvLytHTmteMVFlGGfslURIzz4kWGwtd6yEvWmQBIZkqvfHEAJq3dioALuNt/LbHn9l6QFvWGhDxSp+W9TtqLSfg4F3Q2ECcVenfLdqSVNYsuqjtQokLBRDUGHVdzA0IgleZtinBcbbA1SbYVNyCj1YXg/0VwQq05tJo3NXdR7Q2sx62l/MALw+MATqmfE8ZJ+rpYpv93GcRwdoxynNNxk74VA3usxrYljfb4tvLiAZ+i2cUo5bbdVR1xwlpqwVPl9wFxkcf6RybrbIsloErMgI2RYzCsLtb2fE45EXG7vDNdUIXb1wIAF+SoVSILUnwLTPnvzi5FGnvRgf+9AqMgNa3KLamOmULtvpp3QvApckbS99gdMF336+6WUFRfgCqvrJzRiq0oxaFQKVc79J/FvpXJahCKu/Dq4h0uJJIulVVJvX+cP4OsgBeWdYit34z0tMxjnbJqRape4l9lZBYiCjGxoELlV3hTjcNIBxAKIi027buUUiyAN1vQhubLruZcQkd+19bHSxW/8hcUWMGgMRhK/bNQ6hP1knf2CTvEyaFDdj2n7V4gtG8AOcRHNzNXca+MgivjuLRtR8S06Ia6KA7M97Y9hcX8CETwAC7crBh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jupny+855fGhers1LgpA2GHaHexu7BNbnXKNUdI3e+dIPWsewUKeGJgq5uOY?=
 =?us-ascii?Q?BLsOFnW9zrsYRKd5V95ZQwRdpzXsj9sUdMl1I35utmcWm4yUco68d3HTRv7V?=
 =?us-ascii?Q?gD0PXeR6VBESsP+Iu58M45R7JAbpzgiGX5ustXM/ij3O7yKzPbX9YtpS0Fdk?=
 =?us-ascii?Q?DQbC4m0zLpKWLx9x2mkKfa4GR41p4Zu5L849mQ+bTHEKggAof07TMY5Absm4?=
 =?us-ascii?Q?xj1T3QEfleBMZpvcb3hLxVTME3FWCHYRVwrvhIKcPTlV6qV27CtGsjIap1Zi?=
 =?us-ascii?Q?6p2mD43IYBuu8kIgca9f1tfrV3xnZxwA8RcbMb9PdVOEnaay3nHJt6hNxZd+?=
 =?us-ascii?Q?i05y+1Y6NNNKNEFCv74WXCjduDj0ElmrqJZbc77pKOUNvzabngg8CC9M/GBl?=
 =?us-ascii?Q?CwBP9scFdqhrg4liVVxamWvpb37erwmywB8EPThgAnO2STwi8i5lfbzI7doA?=
 =?us-ascii?Q?tlFaq1WUi9ZH/QTJxc6lVWfWhV93PYntJuj7SfC+jXAvVw2SQpoXjTxSZMDg?=
 =?us-ascii?Q?uRTXoqNAMIIffgSDWEQaJDQE3Ft/AuchwH2LWYiP4sunZc4cgG8xmDR0EcFT?=
 =?us-ascii?Q?200lR4QCaeibFd+I0dQaNa5i85iqroC57kA9jVHbK0KPCg+nspr2TDZtgHR4?=
 =?us-ascii?Q?Wv4GY60nMtmCxxBpOklHoVykYhEOFJEO7LVvBRxZ+xESP9GsXRIBhOBd9sPN?=
 =?us-ascii?Q?M/WWylUI0yh+zryMGg8zUBL2qAguev5tWKn30zSYY4yAIyuHwlZSUpeApdk8?=
 =?us-ascii?Q?xDV02ZkbhCrb5pJLC5z8fGm5GapFaQ8Rh3yIDeY0Qbyn5Hg20srk/xa1D+97?=
 =?us-ascii?Q?fUpbX5AbOz3pOabW6xGZFhE4y6raYJ6C72DfCBDgdM4yx2lQtzAXvaAjX/x/?=
 =?us-ascii?Q?jeh7BTby0n162ZS9qRC8jrkPdL4xN3W41X8hD4mhEXcxTE94yrzA6dJ0yEGh?=
 =?us-ascii?Q?BK9OuPX2bbGFZt41O1w6E71G9VYa1QFPO1jc6L2M24k7p6W1ZVSEl3hDKX4j?=
 =?us-ascii?Q?XlNWniDXFycUutX1WHBNZro/xeKIiJa7mHjulTsDsH//UiVMvvCCjZFuEY+c?=
 =?us-ascii?Q?izncZOoU/H7hOPfoOGkGvU1kcAUxYJlNKnMNWDBpPrX3M+/eg1LHsZdy9S5/?=
 =?us-ascii?Q?BdbLxK6y/U0ZdXb/RK0ouo+oyN+zQ82Dm7FiX1atsVMtaek/8PHAoXcAO4je?=
 =?us-ascii?Q?vxy5i6iGzw94ZSU0sFtQVEn/giU7pFUbBEAkcRSgzZx4XeUG5mw1YmC4NcxO?=
 =?us-ascii?Q?RyPElcUDZ7P+9eZDxfaVi5BLN+dXk9joLIK46GNyqQbxwlvBo47c/7QTJ2mh?=
 =?us-ascii?Q?C0zZmkyRe5vkx9NITNhq3JsKSTcZdBH6F5O7qAkAcgL3SvJMm1lZGU9aiCmD?=
 =?us-ascii?Q?5Ooy+33/qECJEUcYaukHC+xyqOi8b0zNFCXlTvQT8sLHlaB1/dI69QZuFKGJ?=
 =?us-ascii?Q?Fwzx0oRg+mrDQRi+w6V8hb6S7ikb+bdJsKijLcd2a5woNLGhoXSIEIXgB7mD?=
 =?us-ascii?Q?bHN3D+p3gilP3ipGXvfDhEIDzjApQfvDA09TPhckqh1cGH22LpyGDMxGxi52?=
 =?us-ascii?Q?VSG/YjzZB8XorTY1RuwzgiFM7mZcqCYHhGPuD5aAjlm3Nb79CGNfvvgV/Xdn?=
 =?us-ascii?Q?T2aTPuiSmLhpsGUd/SXa2egLYN3nOLuGKJIkKxvQM5kjvq0HshqgogsNB2Sk?=
 =?us-ascii?Q?2454Vwn7nOmG+czgXz86CNHNS+PhgWw1rfos5Q26lec/mfIMQ1Or4xqe6CE2?=
 =?us-ascii?Q?+ZgH+H9b2Il7zaxmCJlafqS07cZkPc4=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dcb79e-295f-4bc9-941d-08deaf414994
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:40:08.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUcIdr7J/j618y5hFNRcUczHGobcreZscecDUnSAxpzUo1mbU+WannaltdAhSv2E+pjDVmrIwZ8lr3YZoP3mTEYhjxo8RT39OKsg6sNUPeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7260
X-Rspamd-Queue-Id: 7B8F650B5E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15733-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Action: no action

Hi all,

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

We are discussing this issue with Yuri, and we have a doubt: if we
disable the RT-CPU controller for a cgroup, would it be possible to
enable it for its children?
(In other words: if we want the RT-CPU controller to be enabled for
some "leaf" cgroups, we need to enable it for their parents, right?)



			Thanks,
				Luca

