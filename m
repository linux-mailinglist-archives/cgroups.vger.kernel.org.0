Return-Path: <cgroups+bounces-15935-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP+4AAl5BWoaXgIAu9opvQ
	(envelope-from <cgroups+bounces-15935-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 09:26:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B89D53ED87
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1D9301BC12
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171F3D7D99;
	Thu, 14 May 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="grByfLhn"
X-Original-To: cgroups@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023085.outbound.protection.outlook.com [52.101.72.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6211DF748;
	Thu, 14 May 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778743557; cv=fail; b=cnkWxMOGmN98oFFsedOODZqNOVEwFhFsSdjU39yRvQLuq//hVoqeXfkvjUyKH1kyTyXaqHi72mGYeydx6yg/YV+590TZ1MwxQGRWlc6iz3OdshW4KERvZmF9FB5JBi8C0EQmzJrzUl1s4a5kUplCeDHe4sI9FM8npGHo5X8nOV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778743557; c=relaxed/simple;
	bh=mkdr3WANnI8pFQ/lOJS2yZPi/5I7wgVHVvP0wLox1Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQwLEXlwi3aspGoCIkyx1J5eFwZFloKBwTsCZBhEDjMpRcicweuNj2SCEaunx7VbKzVpXtDjVQNFrUw2aFaEnySW7KW0eokJZ2ejdkioomcV2cexxma1+dOMPD5btspwmyJNpMmfdaWjS3g29XMKmXRPkzxfpg16rwSaCE5P5qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=grByfLhn; arc=fail smtp.client-ip=52.101.72.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfsmLQLUJQXYxiNYGKjiTd0X5P1DVGsQFNZnPd56JazZhER5nf/BZ2wX8uerHRBsNnEmo2Bbia66jVXc6K0Myd2Hy9r8u9jzDiyn3F2FH0DYgu8l1Srl2GmuhiOpTx9pfGQqefZw0PJwHNYacWj03gjy7BfAtYDzkjdnZV53uZ8ADwGZ8xXOxPUxpPvZnjrDC7GvBgoTnsaiZGcedvxE/JHmPNw0NJeSXINS+bujv15eKf04IMk6nIQvZm+cYWZOz+c4BUh+feYwmGVzmV6SCC7b/+qoLcpu07Wur2AxUs93ucrhDvaT5vDI0Niqg03d60q4KjMqNH+aEQENQPJ0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egnNFI5eQBHvXMIzwTeDtQbJyRE9lwVLcV5X3Of5p0I=;
 b=tmyAaVCejpIP5msA4iGXPB0TVbPQ5ROn51gGK0kZ9zCxg1nFt+CNaJypJoThdtYsAwTnRD5FVWfFiKtxjavRMDeHC4z+FaSqz0S5zTlz+N9wvANOd7jVzbTPJhTF0uBCeUdoz2ESIpBUsz9Vx1ET5NeqDE2wsHo6s1tzikHO54M2kG4PJomVN73h0pwPCfSf6L0u50+jSpip7NbqK/oP8LoYAvwzG8/SQqQ+g+DCMPnlE0UsMTBPV/hfnMpJbMBCXa+xAsses5WtGx2erIhhm5R49r8LiQkhk7SMaJm40UUCGl1yxphgktSwM1Jq0gBQUqzrzUTbWlbn3xjVU4+O/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egnNFI5eQBHvXMIzwTeDtQbJyRE9lwVLcV5X3Of5p0I=;
 b=grByfLhn4+Q56YTR9P3qu7sdqDCmmFTj9iH79c6WYUVH3KewCd9Os0d2/XR0YJK+X1n5VqsQCJaoCKtkdWVSMVWxrfklWm6qxKYRgiwv6LkYXNbdgZaa2VKq29bRfY14w+mpGPG7WqUArXZpYJY6BWPfoM1tacaQIo/LDWpiGn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by AS8PR03MB6984.eurprd03.prod.outlook.com (2603:10a6:20b:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 07:25:49 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::26c1:111c:f60d:f9b9%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 07:25:49 +0000
Date: Thu, 14 May 2026 09:25:46 +0200
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
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies
 of RT cgroups
Message-ID: <20260514092546.4265d486@luca64>
In-Reply-To: <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
	<20260430213835.62217-21-yurand2000@gmail.com>
	<20260505151523.GF3102624@noisy.programming.kicks-ass.net>
	<afpLir8tD0Ycb3D8@slm.duckdns.org>
	<20260507163058.2c435922@nowhere>
	<agIfvZuvXEtK45em@slm.duckdns.org>
	<c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
	<b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|AS8PR03MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 3481ff81-6476-4f24-7e6e-08deb18a0591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|786006|366016|1800799024|11063799003|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	XMD8lWuba6vS15xobRiwM9z6p7wi7cSIdJ5B1ajM6w3NIZEUoJcDuK+pkwuh/NALxSOPR35bthQkPu3Zufi58pQyFSfr189ssEQT6YXrrRxKqOSzAA9gdPpD1v+7SBN8r6GOLnE62E2zt081ycSbKgu+5hpq/YdbHs0QSyPmR8dJNJ+H0aQ0sXujjLsnIuEN8SUKmZkMzRiJXkyz7v/s3HM0kX/Qt+T1yo+nWSaGg33uvYL0AlmOSVqBtshVumymQBMHNLhlW5qMrm6rIKzZHyQb0zq7xnpEafQgTCP5StBdYg9eTSrQnlv/U1oGMBbWQF+mt4IWKSzNo/05teK1+GEp1OfYkaR/tMmQJtoio3AzL/LkNXTX9snI49ttt/5hGgqagxDHpNDUkwUAwlR7CKdlLFZ+yDnrEje0czT0E5Nq2X3pdqQfOwMhsexkm0COMaBTBTEPU0+hs1+gBLhkcWxLPb3SXSmCHCNIvLjaMFbH23/eB/kW69qkYlKLJJEc5o2S+Xc+Y6QGV/YF1ULOgoIoI2/ZVa4X7RTRqCKKnhEr34J1cr7DhDs54kj1YvgCRCj8Kyjb1b20K2XlcLp80YA6sz8CUmpYMgfBW/K8jLHv+fBIfZLqqn0qlciNrJ465eJ4+DtNPMwgRgtesDPJhgOy2AX08uPSrgxr88AEWodC417nFbH2viHqAq8ybfjG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(786006)(366016)(1800799024)(11063799003)(18002099003)(56012099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBp7SjuhqMVgmVka3bafOHLS5GOF4g05f3IiiPzqngKUzj1SrcOyB3RHGh6/?=
 =?us-ascii?Q?XymwjjqemAJBMvgQRuhBELX4RzxuUNVC6QmGnVkyNtoxKlLCSUHFPL4E1VMC?=
 =?us-ascii?Q?KRu/jTHVgZr1uVrE1UuC7b0yTyTjgva8uiisJJk2jeyfkw9oB3Q6xZBDyr22?=
 =?us-ascii?Q?GY8cjFW2M2yOEmgIQMBzNfWefiLyOqbQM3YSjKYI9znQxqk6Xeu28xV8FLds?=
 =?us-ascii?Q?JQqnjbp873mFCkDW/F31HfSv+51JBTuPGty/DL0CKW46oDJw4b8RmlhL5cG9?=
 =?us-ascii?Q?PNShnH3Z7GuPeOnlgOeJ4uoBUg1w1NfJuxlzytRgo7X3+/Pd0r0cQ6PCGG0H?=
 =?us-ascii?Q?sv9n0Et1TmbKFH5t6V0DENqGX3009hfA6LehE+YmmPx0vAeSafskH/GB9ndH?=
 =?us-ascii?Q?vEXnhNnyEHaYuPbX+0VZ7rtDCb2XgyCtfi58qCAy0KdAOX4aguLa0jzo65Kr?=
 =?us-ascii?Q?IYRUnKe/KR6dUVeZ6wJz+RJVw1im5LnpWORbGxeZTCxJGPEozWsvhpv4rPep?=
 =?us-ascii?Q?/e405IsyPz4ayxILzGMUJMexVHKBdGY2HaEm72SX4d6T8eFaszyBFoBrTmU6?=
 =?us-ascii?Q?ZHUsqJnijpGVWGCK/KUxxqMW//fngi+9+W3qLxWQhd7OPZg3y6QrEO3praR/?=
 =?us-ascii?Q?+pLPmIBZqiaeXz0B/+RcuuzK2udi1bRHJWuXRfyiEOGln1C+57nJlsxMBwFH?=
 =?us-ascii?Q?eR9Uv/6GNTvZIVzB662asSBnzi+Tx/S2JSxndxktxXlqrRCvp/fp0N4MMOUE?=
 =?us-ascii?Q?vyckhNHjah8JqZUMvPTBDgOVFIrs9GPDAf4d+9aIO2i4v6f6YM/CicGEv5Lu?=
 =?us-ascii?Q?7GHzRbqYf0zfuCoEKnzsyrT/eTmy8d38ufoEdxe848UwKUK+doQIrN/kpkNc?=
 =?us-ascii?Q?PGio9BZuoQBIxmYuDMcdpajS41XM3AodTs0tmqzy7TnrM3SF62niID8Yffr3?=
 =?us-ascii?Q?NaWcHRpp4ZwKhAFVvWAHvKKScdVe5WykM4/abFRzvCVFaGkAC7WZNggFaGV4?=
 =?us-ascii?Q?Ra69z2iqnnt9qnAhX+BHWp9fvmAOtTfJhwRlxV65MdXaelRcDKYyIWiQZewt?=
 =?us-ascii?Q?2IbZGRutdskXlCe7X/IwFENKIb8ZzhXOvWXN6MiThLkk8D7zOejk5FRM+SC+?=
 =?us-ascii?Q?p6Qz6zcBmWTqvyYQI6t2RaHxyyQ3aQV1DrDake3pGeaP9AdKVxUbcyyVoY/k?=
 =?us-ascii?Q?zyFFyaiLjSziX6s8e0dozgUQoeZq7ydO6B7Aiz7ezbSscgotbAXW2NXMURnP?=
 =?us-ascii?Q?/XZDUmwZDv7snDJjDrv9CbaU23poPOeuIzTglBdVVawT05cNVZtfmF9OScmg?=
 =?us-ascii?Q?y3101EuS4AHFMO/BEyPv4kgEn4Wzk9a4PATQJiGo4g+zrOUZlfuq47+aDRkA?=
 =?us-ascii?Q?OlCeNF++zcYLapmqKp1yXayWnh+/VLf6ua/Wi4+9O6MeAIL4jp/MqT0fihtl?=
 =?us-ascii?Q?nmxhOK6oSkGUHwP6Ip5Qmetf9aF3a0Us72L499sQHRpEHKP15TzS7vRWHx9y?=
 =?us-ascii?Q?98RBpd/0O/jaN11xt0iVcBdOYUbcx7m+q7vYC5UzCuLutq+K8XaMHXwZp1yd?=
 =?us-ascii?Q?CDkA4XxKUFct1YS+2g8KI72CBD3qTO0K4PLzI1/ZY+QYt234akpg7z8Cy+ZK?=
 =?us-ascii?Q?McMCbOdDW8DK+yRIGo0ZqFRZqjmCEnePhM988tRZ73nnz6GMt2Ce/NpGPFjj?=
 =?us-ascii?Q?xIA8j/vzZkB4Kwx3t3gSJ+P/Zkiw/UC6n5+tDArw0q4erEHmhvOYZRQNNPqg?=
 =?us-ascii?Q?5ICZUFFSmoUkg+4yShs1PKXdMezUt8Q=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 3481ff81-6476-4f24-7e6e-08deb18a0591
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 07:25:49.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNXwhU8jYQ7egyZ7rVX+cTp7ec+OI/QuGllDEOK+TnH1mcoCaXgHFxUops5AM9PcRAQ60nFI6kary5mJKcaz12OVuC+RXlkKIG6hpVVRouI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6984
X-Rspamd-Queue-Id: 5B89D53ED87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15935-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,santannapisa.it:dkim]
X-Rspamd-Action: no action

Hi Tejun,

On Tue, 12 May 2026 08:19:02 -1000
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> How is a delegated subtree prevented from setting cpu.rt.min = 'root'
> and escaping its ancestors' cpu.rt.max budget?

If I understand well (please correct me :), the following strategy
should address this concern (and the ones expressed in successive
emails):
- cpu.rt.max can be "runtime, period" (or "runtime, period, deadline")
  or "root". "root" gives the current behaviour when RT cgroup
  scheduling is not enabled (so, no need to disable it at build time :)
  - if cpu.rt.max is "root", the cgroup's FIFO/RR tasks are scheduled in
    the root cgroup
  - if cpu.rt.max is "root", the children cgroups can only have "root"
    in cpu.rt.max
- if cpu.rt.max is not "root", then cpu.rt.min (or cpu.rt.internal)
  is "runtime, period" and describes the dl server for this cgroup's
  FIFO/RR tasks.
- The default value for cpu.rt.min is copied from cpu.rt.max, so as a
  default all the CPU utilization of the cgroup is dedicated it its RT
  tasks
- the admission test is: cpu.rt.min utilization plus the sum of the
  children's cpu.rt.max utilizations must be <= cpu.rt.max utilization;
  children can have cpu.rt.max="root" only if cpu.rt.max="root"

Can this work? I think it avoids escaping the parents' cpu.rt.max,
allows for a reasonable default (no-one should be forced to disable this
feature), and should respect all the requirements... Or am I missing
something?



			Thanks,
				Luca

