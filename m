Return-Path: <cgroups+bounces-16100-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOtcOrDQDGrImQUAu9opvQ
	(envelope-from <cgroups+bounces-16100-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 23:05:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F522584FCB
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6CFB303EC0D
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 21:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C663E2ACD;
	Tue, 19 May 2026 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="Afql/wNu"
X-Original-To: cgroups@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021121.outbound.protection.outlook.com [40.107.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1513BB130;
	Tue, 19 May 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224595; cv=fail; b=tLDHAWtdIbKf38/6GBRqh8M4r5TpCeMsMrZQIDF20M7TFvaLL5S1j0F7C7D0hr8ZobbM73dGkchYlljjPSRVkxBmUxCfi3MFRdl5PR9kUJPtpGRDOVmdABwITXAMUlx3R9/lbrRB9USyIKJjcpLNpUsu9HVO/Vz0qFSsLUzwGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224595; c=relaxed/simple;
	bh=oI2eT6cuxkP7qHUpByRm1lw0Y5/MtzorsNqTZSvPSLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dGyEX4/UPNo7Iy8yDc7EByVhKC2gwA+YBK6LRLEBwuvOk1Ao6fkesFTPCHyWiKGvhN+PqF9knCm06C/ibwXLeeocPS8bW7yjkHib5MaOfWqMUv6g0aZWOIUeWNtjb43W6JxUihXQujy3KUSULb2jlSibCOG+EwT0iQoEwBMpylo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=Afql/wNu; arc=fail smtp.client-ip=40.107.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR22X4MH8aZ59X5cZy+q6m2hRv9j2ipFgj7z7l+Xaiv67BbZTZLEDIKxzIvEdcd67nYnbw1OThgMohGjYjLKRyOpn6RbvgFybKW2nlY/C710ijIm4/U8rNbFJfxF8dTdvRUtmNZnjotFYsFmbvocftzB67gjQ3TyjVVq2rAUhsGtRi+ePWepG9hidOJsrg/sk7ouDAKg+/mgWfYcDjTy037hRuWh+sOfPbHIm0M7cVkt15QPF2D7C9c1OqTk9w1C02R37f2OYqdVdcS0Xovf7lWUB5lV4jOzeOIC7TZWa1Ire04Y1nr+1Li53snipK57VhGjhO19xR2GsigfjsMryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxU35WOSXGP/znbeCG44oi34HZtv4Qs6HRpJ+A4w4qM=;
 b=F/V9X9qga0as3NToqmT1S3hUBz5zLD1rAA4m8XLGQ30JOiUbWHhN2DQziUcL+4IRkgVH+WHcnE9UEmjJXi597/qyRDUbpMGWIsrwCooWZnbnsHDxb7ebf9IbavOvkDppzojfk616qyycz4xoXwwblS4WqwA5GequnUqakfoERJzWpSxL0y7OcB0D27T3tbWz53niaPzHHPTptxaaZj0OnGKlrwngu6SHybfhW4LnCIKWzMoa2X9SmpQnbCGH3vSqVjp8wjeYzYMr1BBcBClEHiF0RkZKq7EnKqJZwaOcntyVx81y06uT02B/+KxEP0tlLqVS2HTMof1nrADvwBUwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxU35WOSXGP/znbeCG44oi34HZtv4Qs6HRpJ+A4w4qM=;
 b=Afql/wNuZBF1FoLblYFktpZfAg1ETmykPCBbGd+dPrlELpaEuo0cvPMC2+hJQaUfs+WwxqTWy7F4tLkiRjr00gFhe7HwAzepskfCr4Mgm4nBisC4HKLoBYKaYX9cIV/1OIE04ZSU43QBVVmp9vH/huqzWHz9wdDXUJryG3Pm8Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by VI1PR03MB10032.eurprd03.prod.outlook.com (2603:10a6:800:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 21:03:04 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 21:03:04 +0000
Date: Tue, 19 May 2026 23:02:58 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Tejun Heo <tj@kernel.org>
Cc: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>, Peter Zijlstra
 <peterz@infradead.org>, Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org
Subject: Re: [BULK] Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper
 hierarchies of RT cgroups
Message-ID: <20260519230258.0342358c@nowhere>
In-Reply-To: <agteySwOHszMVMp8@slm.duckdns.org>
References: <20260430213835.62217-21-yurand2000@gmail.com>
	<20260505151523.GF3102624@noisy.programming.kicks-ass.net>
	<afpLir8tD0Ycb3D8@slm.duckdns.org>
	<20260507163058.2c435922@nowhere>
	<agIfvZuvXEtK45em@slm.duckdns.org>
	<c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
	<b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
	<20260514092546.4265d486@luca64>
	<8672eb9e7bbd6abde7762feb267799c5@kernel.org>
	<c51eb4b9-143d-495f-a35b-090fb688cca4@santannapisa.it>
	<agteySwOHszMVMp8@slm.duckdns.org>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI3PEPF00004EA3.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::459) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|VI1PR03MB10032:EE_
X-MS-Office365-Filtering-Correlation-Id: 1842a403-f4f9-477e-3893-08deb5ea04c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|1800799024|10070799003|366016|7416014|376014|11063799006|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	4okvAllF1cTFFg2ZjWwVNmm/+ukZ6D4DmyPTUUSu//bnpcVywDn1EUbc6Jcs3yE5MZSe6zj+7aYLlysP17ConmL6kxkxS8fdb8+D5Cp4mXlGvka6hFNwnf6VGs6NplbVl3r0zgZIz2tE9T4eDAxvjJtyeYv7ExA3NgcDLTprcoD2MO8ziVwwizR38bA7IVmF71RKxRrvbAAPEspWNfcOWAF0z9sip4pkUWM1vKADD4JgmCth/tpumza+Tcsj6oA5Ep/PUCuBiF+T3Ly4HGwLborbQz/31XHz2H48lLTc2I9/CZ1x4JECvDiZSemOyYIozcUI9orNvuL3OyA1mn/+gKmVEjGNPqAzh/mITzNnDk0nr4pAsq2HeXUafTrtkB8CgKv1ZEPB/XDyFNkhWR96JXsRjs/g0wj94hl1yfW0BVP8D5NRP6/fTpNBeQAFBmvNnDUUWCt1qz/r/a+8/tlzCTD+KEk+NVPy7IDrJbZmPoJJj+Xqr4V29bhk05SlJXDv3hyiJin5aoyh29fgs+Ao8I2pb8m/iJPfq/V0isyDdCzN3R4A6g7q9wB0Hov3WGwsEK5eHmFyfwEsv5SGVC3SS9iZqStWd67kRzacCs6aI9PcWvF8JLzMttI0tA3BMsDL9/O/KW3jYZu77oyy0JxkX0afNMh96RFmp3DJhyGxii5HfX7DbEwiVy9InKrwlIon
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(1800799024)(10070799003)(366016)(7416014)(376014)(11063799006)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Gx2vxXq+ThUnmi7cYbEGKgo4KwvyLl7tVam0xam4+GsUMiuiYeeeU4X59zB?=
 =?us-ascii?Q?5V2plaqWVyWiR4qguCAfrjvLu9ddqqLR9gYV6gbV5KFVVs+MSTH/0S/4Gg9E?=
 =?us-ascii?Q?BGVKGeK6JCQI9B7nJDfueyzl6mw5n6NSJulnRGphHOXD5uDCjZZA8MuEjXOP?=
 =?us-ascii?Q?gD15fU77Na1T692z+EfwV1CTVNAuLnK/h/fc9SQsRFco7Vhy7dPVzHUZgu9W?=
 =?us-ascii?Q?UNSIA69yPhld5XZIs1cjyVMn5eABJX0qOBSfCT8WbrS5xosFMPpn7/aiJLNK?=
 =?us-ascii?Q?WhlYioZ2T3h6j3WED8+ALj+w+lEHXvGtcdVzfogkOOh0WhSEi+gtwDP3xTwD?=
 =?us-ascii?Q?aV+cvBNu4H1HzQSQKilVxvfCvEvvzpGBReObCtD2L66+SD982rNNo8HRwGB2?=
 =?us-ascii?Q?ZHR8ouRH7xMRbeDaM4pqrKqOjlTNxqozges6NmuIa6IjhhIkTTeHYotjfgzA?=
 =?us-ascii?Q?HFmZ3YrvGQvJJ2XCMyD6NsBwKq2WT4eRQaBbEETxWB/mKi8dtbkKQXgoI7P5?=
 =?us-ascii?Q?BQL07iVsVuAnUlnRClYf6R0vqpBudchsRRwS7InB3Rs59D+Qqcj/wHA/ZtZ3?=
 =?us-ascii?Q?iuo2mSYEQgvDZnE41x45MvOICZEtbSgEf4hvULEsy7ekr9pVzZNsXAfWkeNW?=
 =?us-ascii?Q?OHr+Maf164zIUOGqKHqlO286619mf3jQT+pLNeS8gIOGyYu+uhl6keIBUlTm?=
 =?us-ascii?Q?gGK+Z7ilfr6MitzuWAfBHWkqG5bFVUA875VMWKEmDwwhvKkr0J5KVodwgnMk?=
 =?us-ascii?Q?W1JC7iZZD548QR+84kJDUQIoGPEVdZNp/IYrOPS3JN7k440iWfdYCcOczW+F?=
 =?us-ascii?Q?lZk8wNtcDTK9SvUMACpD0rni1vFL1tyHrvYQTDRmw7NtEge3uHZUxXFOlWCZ?=
 =?us-ascii?Q?DAd1loLBfc7KL3xTuzOTmQ6GRAb+UKKIVV0aF1mtDgUG4kohxxG3OO4xv8Hc?=
 =?us-ascii?Q?mlsP1LiLYCaPV08LOo7QGb/AFM809weMVyDC92nxNqXVx9cazRSJdTPY/E5L?=
 =?us-ascii?Q?KfrPiY86vDtKuH/RXhF5dMq+bNQDJHiW0JdPwyctAwtxvjWwukNoa+7BY+o7?=
 =?us-ascii?Q?UpFSPhpmm8oWczm55v3mEPUsgdiYz26wyYhqo4HCUVQ2+QKPfcwlLdLtuowC?=
 =?us-ascii?Q?3/AvMsWIXwMNza2zvXnM3yZRmRBe3tM1zp8XyAnGZPf41xWmglAKE6YQ8XTU?=
 =?us-ascii?Q?fwuszSd6VuglEm//Yny+vd2Xk0Lbz7usACre24/7hFrRQ4RuXNlCy14LfUls?=
 =?us-ascii?Q?gfQvHREO+iiOwJyJ6QnKIq0S1ZmSDNtfQZMSSFbJYIZ66yi7A9tSpRct6DbO?=
 =?us-ascii?Q?gq/JN7VORsrLOuDMGa6ZO7gq54XMCBFFgo1uY8PsjMRrq3359k2+5UJT0O2e?=
 =?us-ascii?Q?SLCI55zUU1/thqyDMQeJtgskKQfeUiR0VvmrDQrvjDWXHh4ljo8+xP31PsJk?=
 =?us-ascii?Q?CrprReZBePxywtqU4TVLKxL9elxO6AYy3d+vwrYVteFWX/9HDJ8/7HdcaKn5?=
 =?us-ascii?Q?bmEmkq65CyMrUvuDdBuhWnASd+YGoArGgu7six8+R0b1NSkKTEEtVeGJbvnH?=
 =?us-ascii?Q?nJ5Z3KU1wxFXgScNfCqLR4AJhxUORivrT6wUENY0/rL9gA4Nc7rsOcknI32C?=
 =?us-ascii?Q?4OlI15QgoajeRRbCEX5g805J4KrSi+LFCSiHscOFtAr2zWP/9Jp0CIPlN9a7?=
 =?us-ascii?Q?0XC5Q9PfshNv7ti6mIxEpIboUH6THzgRKo5nR9JU6lEZb1fUzkLvBHBM3A/D?=
 =?us-ascii?Q?L8VRnDuKjwBVbM/NdU3MUCf8H4mGJ95WrIvR4CKrVMJGI8mrv8nYKBa9gJ6A?=
X-MS-Exchange-AntiSpam-MessageData-1: DJnqHHNa1Ns4v8+e/fH0JzznRhuDMfFUOW8=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842a403-f4f9-477e-3893-08deb5ea04c1
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 21:03:04.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMVOYyRoYX0jEiWt5Idn87QGzUU80pxmk5W3DNs1Whf8xxMOUmikVoH9ympfYXSoUGg7Mc/VJMr++WnhxnomguxID1WME9CgTKSFoXFm9kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB10032
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16100-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,santannapisa.it:dkim]
X-Rspamd-Queue-Id: 4F522584FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I think we are converging... But I still have some doubts (probably due
to the fact that I do not know the cgroup v2 API well):


On Mon, 18 May 2026 08:47:37 -1000
Tejun Heo <tj@kernel.org> wrote:
[...]
> I wonder whether it can be generalized more. Would something like the
> following work? I'm going to ignore period for the sake of simplicity
> as it doesn't seem to affect admission decisions.
> 
> - There is no root cgroup.rt.max in line with other control knobs.

Well, the reason we had "rt.{runtime,period}_us" (now "rt.max") in the
root cgroup is that RT cgroups are scheduled by dl entities (one dl
entity per cpu), and these dl entities must be accounted for in the
SCHED_DEADLINE admission test... The easiest way to do this is to
reserve a fixed fraction of the CPU time to RT cgroups, leaving the
remaining fraction to SCHED_DEADLINE tasks. And we used rt.max to
configure the fraction of CPU time reserved for RT cgroups; do you have
suggestions about alternative interfaces for this configuration?


> - max means running in the nearest ancestor that has budget
> configuration. Obviously, if no one has budget configured, run in
> root.

Uh... OK; I understand this, now, but I suspect this will increase the
complexity of the admission control... Yuri, what do you think?


> - Setting a budget is subject to admission control in both directions
> - the budget source (the nearest budgeted ancestor, or the root pool
> if none) should have enough to give out and the target budget should
> be big enough to contain the actual usages and !max descendants in
> the subtree. Going to max is always fine - the source previously gave
> the budget out, so it has room to take everything back.

OK... Just to understand: if we consider this situation
	root cgroup -> G1 (50, 100) -> G2 (10, 100)
and G1 switches to "max", what happens to G2? Does it stay (10, 100),
or is it forced to switch to "max", too?


I was thinking about enforcing that a cgroup can have runtime > 0 only
if it is a direct child of the root cgroup, or if its parent has
runtime > 0 and is not "max" (so, in the previous example G1 can switch
to "max" only if G2 sets its runtime to 0). Could this be acceptable?


			Thanks,
				Luca


> 
> It seems like the above would give fairly generic behavior without
> abrupt system-wide switches while staying relatively close to the
> behaviors of other resource knobs. I could be missing something tho.
> Would something like this work?
> 
> Thanks.
> 


