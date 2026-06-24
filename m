Return-Path: <cgroups+bounces-17224-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9CtCweFO2qbZAgAu9opvQ
	(envelope-from <cgroups+bounces-17224-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:19:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 209886BC195
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 09:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=santannapisa.it header.s=selector1 header.b=cXF82ap0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17224-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17224-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=santannapisa.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C443300531F
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 07:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DB3911D3;
	Wed, 24 Jun 2026 07:19:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023126.outbound.protection.outlook.com [40.107.159.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A03911CD;
	Wed, 24 Jun 2026 07:19:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285567; cv=fail; b=JxOIqAd/EhXOmyao3NPBs/0Kjq6g0+w69hf0EBDPMnG8VyXW1EUrl/SHqUzvBSo6CraO2uGOr+LPgq/ApsyyZUbrSS6u8e2XFgx+h0wlgDupVGvDEbVbQYTonXxfcW4loSOKxShUtdLsaszpNUsKVTNyEmrk573slRVMIw2R8lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285567; c=relaxed/simple;
	bh=mVRVS1DBWnejjEayP5lA4j2UP72wJgzoJeH8XTOBOlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KurWk+aiFJGBKIeQX9LADPc8MgJO+spzsB5JuGHcj0oEfAoMvQjmItv0jXR9octrEsb7zW/8kENwaU+JC8cZh0iDIhxhVgUur4Ln6I06jvz5jfdPaLy165bF5YpZjFOyPtDN7+IaT7iD7mJ7xMHMsj1W645xsxRjIRU4br0RuVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=cXF82ap0; arc=fail smtp.client-ip=40.107.159.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAOMzRg4pXW9AZ2zM6yYxeE4dGStmY7qMcyeyfHkYFk9rhHP7AKQjOEpFeWi86LabOKf7JR6zukKlwjRiyf/VZZatQ6jJWvSj3T3h5EVPKLck96ALyj7HwbEczJeDvz1hX7SziF95dk7nZGIB3a1ebKs0DDkclgp4NJoK7UwmT2L19EfmAgggUAD6AKqoWZTclsWfFsyeBnu2IXRW/st9wYPykLsnRfcT9n52gRaG5Y30X2Y3Ws6cTXlkmR8LCgrXH/DBXclbUQO+6WWnPAJZiuSjJGAvJITdFkj7xeSjBGVHKElG7wq/ONWU3voHQ9DOeZVVq4Zo87b1Ah+ld0ELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMxM+3z3aoULnrq6FB46LN7J7+GA4qXQJCM7VGiQgD0=;
 b=j/LJtndpqLVg63cb9jMU+8dcL+2HilIeB81H4FVsG9hXCdDr5JZ7l4I6G7nCxx6eOGEp8B87Lq/IzafdnQ3KqEZ7sZAh/yNL39Lkq2JAlVuD1NRO2ScKFRYxEsEDLMVeZoeD7Ea9h35TRXpL0MpK5yyspPpp6L4tioMLR1Bc6VXOHoBAz/vUs3qgJv1DnVR+5WVL20cqR/TgxOCMYd6bO/fjPb6P1Qzn8MGLRoMc2PVSXPTZODkpJhPUa20Z8urX7XmKikXPtjzZGDjrww/TO1oixmXAaj7aOJ02iIfPGU9/Jy8kFheqglrkDGMKYPNJr1kjwtVlMF3MbvuQdd+04w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMxM+3z3aoULnrq6FB46LN7J7+GA4qXQJCM7VGiQgD0=;
 b=cXF82ap0eOZrHuUIqslHpvhWynoOyq3rM2kkBJyY+EJHjaUbBsDlTSgqnd6rgXnMdiv9V3/VthXFK4GUF3eOrLC/dhKBQZFIpdvaYcJ8u6893esPUik+ilylsck5DnesSXuF6VKLDZKV3hgzrbmkRNV00lGtFfxY+AV6bpPrQSU=
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by PA6PR03MB10493.eurprd03.prod.outlook.com (2603:10a6:102:3c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:19:16 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 07:19:16 +0000
Date: Wed, 24 Jun 2026 09:19:12 +0200
From: luca abeni <luca.abeni@santannapisa.it>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun
 Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuri Andriaccio
 <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v6 00/25] Hierarchical Constant Bandwidth Server
Message-ID: <20260624091912.4fca8428@nowhere>
In-Reply-To: <ajpcrDn2g2G9mGKp@jlelli-thinkpadt14gen4.remote.csb>
References: <20260608121546.69910-1-yurand2000@gmail.com>
	<ajpcrDn2g2G9mGKp@jlelli-thinkpadt14gen4.remote.csb>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|PA6PR03MB10493:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f536dd9-3bdd-456f-0896-08ded1c0e6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|786006|376014|366016|7416014|23010399003|10070799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	OhJqkXAiGx8LyVBD+p+f0U8Tp0TnfiLSKXdBgn6l4wrK9FkIpa/vegwUGAwAvBFS/QeeE1oL0u4dDOehLDtdUEWbDbg1MroSZB/AR0jAat6i6rkVV8oJI9bgmAa27E2dV+L4SreJXlOje7OE8D2ICu684K+QmyKJ5eyEfwkGBu9xTNyz8EzCKbL850DsTnEJmUpzOQ4Q2j4mAMuBgskNkXcZQcZr4krOJVhXI8aX76hbti0RLwSqlji+o5VjxdHlanZWIUeKCclrElFEhOUOwsxc1Q9NqTTw92nlJjjTVwkGllNEaFR27y9HhhuHFdSnK2W/5sAmk+evC7QnAfo3aJbLx6HrceyYG4ZzEaJ4CKXZCHoxHOk7C19/aNITwQtt4X3DOJwCJcrPC529BG7WaU1qPoNKc+DcqfnABdYbNDy57vdQA+/aRB1ZJCh0/9yWqfpdHjKtt2oo18m6SLlyOvdRKs0+HaftaMrWXdWZ3HDn5aontuU/w8FPckikzZHK0NdKCDy01CqzEZgr18wzaSniqgy1o84FIpYhyfyyGjYpt2jPt/eLz7RBPdWloAdklsjbo1LbAqOYNaQSgNrTgvH7QirvZ5oEC6j/Wv0PrlstwBn+WoJqWhPoATvdvSeWTa5YktTcbW8I2JAmitiIXBvb4LmF/6lFbJGSFVAtzuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(376014)(366016)(7416014)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VrqW/NbsEpq/Zh9cLQ/KdcwcY59S5pjVWJuyIuVEeb7EgdPoKrdr4iW2S6kV?=
 =?us-ascii?Q?UfO99pxfOUt0Y6CmniMnt152zAbCwEPXkbWBMGBw3OkyMUcgh+GhlLaneOkl?=
 =?us-ascii?Q?8oTG/6qx61D1wmflD/pzgJDZru/5ijHd43zsRIjx2kJ7vbwUDtu4W0zy7lps?=
 =?us-ascii?Q?e38h31qgT/L75RxEd1jiC7JSgRXzqvKh5K4idhPHfpveQpYxzO5hY5OzjktK?=
 =?us-ascii?Q?9c+tPMjFBTnZclmS3MpTGBIi7Dn1zl8y8o4jjHqOVb6dkIOycHs9veY/Mg49?=
 =?us-ascii?Q?ngkQHuWX4CJ6qK34dNOgin8OlhM2WFwi7tUhzwc+hCqNuzEQev4Eb1cMtVpR?=
 =?us-ascii?Q?tKfM2GQv2SKUE4apm6BBsXKBOI7xt8N7+5BnV6UWAGRHMrJ6tGimnuuD0WMX?=
 =?us-ascii?Q?AnSfI2X7lEbe8N6dWfTMalswlGE2b41Ewsi6kxeOE8Y2P37D2MXSpVzPReg3?=
 =?us-ascii?Q?O+ZzPCZoQ4/TmNsGrvl0Wmj1Pdmap6qAn1SH+ppL4lB9oJpueq6o0xl6wjQd?=
 =?us-ascii?Q?0T66cUcxta73oVGAj6yTX43E2OEVSjnATQQ2J/QKdhW6GBoytzeZ12ndU/9X?=
 =?us-ascii?Q?PqdnhHindg7jW25g+HA0tFAgYoHvmoAE528k4UDJToElNp0Bdm9e7F9iXni4?=
 =?us-ascii?Q?Fv5RzDLA7CwmzemKQHutKnpOqoTsv8HvedsL0az5Tw8JyffRJXXlR/3lvdeT?=
 =?us-ascii?Q?NFkthXrlZXnzaBtoDjyURGCM+iTrDePVcc8RBd3zNzgxksxWSNuldgjUl50p?=
 =?us-ascii?Q?Y5rrWavmfRB5QMuOkPJrqRY4Dvn/10Ng03tL/zJrpkRGZgMmOITmkfFbTR0S?=
 =?us-ascii?Q?yqCQ7WUfOKk4XULHb9jJCKqN7P2iYDYFWPNL1CCYJbu1bwMLAKmhHMH5Klj3?=
 =?us-ascii?Q?vB6fbtYmiePRjBCTPL9bTxR2WfQt2KsMv0enZIKBp+4IES3YvsywxF05G9eA?=
 =?us-ascii?Q?qLEh8seJb19WeovSr09b97FKEf/A/ojv+3inOujaX50T3q2/ORkPs+XJMy4A?=
 =?us-ascii?Q?ZdOCPecgyR7i+7cDoBlC+HB3mpjrEr3pnAOJol6ItwVj2oLwjusspyxQ3WxG?=
 =?us-ascii?Q?4C/Cpm9ymBO5XQfNXIjUCLfOITTMenPLeGCkk1R0sndfdXB94zR1c2Euwuxu?=
 =?us-ascii?Q?nzOBQWWBHNguTjA7PxP6PpGn7u07EXAbh5PJSn+gjUFfDtpR8pTH7LtpWK3h?=
 =?us-ascii?Q?v43XNd/baC3CRoU1yLqlG+NWF0QI2UTS2UKIS6EPOkZqCEm46Zq2Ylj4sj6M?=
 =?us-ascii?Q?3/FsKNAk8kh2k/KoyNcL14gnRZsyxtWVGWxC3/qLhlh7K0+A1zg73XbUD35V?=
 =?us-ascii?Q?gRBgtLzDMn0QhTY7IukS/ZX19bPZPLoB3CI4hLdnM+Kzoqv4dzZYDOsPNL9V?=
 =?us-ascii?Q?AGsGCaps0ie/8xLjKPymkg+QyJQprKwaWkkLqP6bG2igr24P3ActLNbmFiKu?=
 =?us-ascii?Q?557bX/CDtTxUDuPcxoevX1AvMEnbdYNxIWcV4G7gzQqulXl5sM9nj9b6/d+d?=
 =?us-ascii?Q?ztrPS33oopuy5bYRy98XBI3tfSlbQD9buJB8fdkN65PqDMhVLnZc4YSPU5AL?=
 =?us-ascii?Q?BJEJNfbAUDdtOa4/Kl4bYKywmIj8JYA7ufdI6/5Y4M7nVv0OE/pq8O+1PoQb?=
 =?us-ascii?Q?mvDTyu/fHxzDG26rvHwrSCWK7gRechdoHiEuxDg97ojoMthVNOdIzs39PbPr?=
 =?us-ascii?Q?J3O/4+6b9Ye0elGcmI3ZUdV4dkVNIWX77flDgMuPsFiJzFmyD+QlG4Uj5mEN?=
 =?us-ascii?Q?J6M5bS4GuXJ5QuReIbVBkbmIFQ2D8vh9siY/EoC/vg/aLYtmA9KFGnehJ0q5?=
X-MS-Exchange-AntiSpam-MessageData-1: uYYJanmk9VOhmE6yGp1SNAwoBcZOnIDeTjM=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f536dd9-3bdd-456f-0896-08ded1c0e6a2
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:19:16.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XB5nYKI4tjC/OxiuxAnbY9qMNi6b/cSK5U9Yxj2xH493S4iGgV4GTIWIcTCP68I+rW2cN74WK2PA+F+0iOZ0s9AcRJ/eThRPbNzyezlv+gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10493
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17224-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:juri.lelli@redhat.com,m:yurand2000@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,santannapisa.it];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.abeni@santannapisa.it,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209886BC195

Hi Juri,

very interesting demo, thanks!

On Tue, 23 Jun 2026 12:15:08 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
>  - At 1ms task periods, the dl-server period is the critical tuning
>    parameter, less the bandwidth. A 10ms dl-server with 60% bandwidth
>    caused ~10% miss rates because the worst-case throttle gap (4ms)
>    spanned multiple 1ms deadlines. Switching to a 2ms dl-server period
>    at just 30% bandwidth eliminated all misses.
> 
>  - A simple Rule of thumb might be to set the dl-server period to at
>    most 2x the shortest task period in the cgroup (e.g., 2ms dl-server
>    for 1ms tasks, 10ms for 10ms tasks). Would you (and Luca?) agree or
>    would you suggest something different?

With one single RT task in the cgroup (or with multiple synchronized RT
tasks having the same period), I agree... Technically, the cgroup period
P should be such that P - Q = T - WCET (where "Q" is the cgroup's
runtime and "T" is the period of the task), but to see missed deadlines
you need a relevant competing deadline (or HCBS) workload.

So, yes, I agree with your findings above.

If we consider multi-core analysis, or multiple RT threads with
different, non synchronized, periods, then analysis tool by Yuri
(leveraging CSF analysis from real-time literature) is needed... But
that is pretty pessimistic. The rule you suggest above is a better
starting point in practical situations.



				Luca

