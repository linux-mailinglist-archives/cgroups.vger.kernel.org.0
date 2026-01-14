Return-Path: <cgroups+bounces-13208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C308D1F4EC
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14CDE3021E67
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917DC274B43;
	Wed, 14 Jan 2026 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="zaFcfAGo"
X-Original-To: cgroups@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021140.outbound.protection.outlook.com [52.101.70.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7B29E109;
	Wed, 14 Jan 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399483; cv=fail; b=fr9RCX9AUKS1zfACPFXimBFADaZ2UCYrnWpnZuTB3EKP+lttbx4GX/376WwLZieC5InuwpuxThefL1oo2sz5Y7xMZdAebn2cFXVooEkIf+pjq4336mBXJrq/115Fcl31bmuryte16LNWlZ4OxmoVKxPGdv/5HXgX0qfdYOuq85g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399483; c=relaxed/simple;
	bh=uZC3GCcEPbWZ3O96HarI1ij2xGGTuKS4J24kXCEbYiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6GkRv2d0KeQvKsh+iHzAQmapxGD5FrrmAHBiY44A8nVEv3/WxBIcZ5DlMcQHcrCahPZ+E7O/RLSTQ8FCLtFzY6+hHMENPw3KULrOlTve3p0kIBXV9rJ40bLgbzz0WPxam131Vf4K7yQ4cOXY68VJKFA/fg7o82+2p5HvaRXePc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=zaFcfAGo; arc=fail smtp.client-ip=52.101.70.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5g+ckBucPFLqS5UoyI9ihryzwqx/izfCrE5v/2Bn6uGljmW4q4VPEs71g2njzbR6ftDBPS+OTixkcgKBTA/aAehuAp0s2goevJyG0uRIMUHLYkMUJEKyi1T46uPaQ+F0SsQ22s3XkOw8l6Ih05mfz8174buIZU2FLd1tIh+1D5AKgER0QFyqAqNkLlA4KVQyFgJ2z1zWGtOMgxuy/Ep88l4c4SKBAy0iCibsX6rRaZVer8O299TJq4tVg5NOevl9JuRVB533Z2fLzGbLNjb/J7TqFj2zyxAO61UEbttNSc3xmzUWC+BAjMFeaPtufe475g3TVNoYYKub2JfI+yrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83m1qaPGNRpm67E5GSWUHo0dNo/hyDDPWFE4MctJvnA=;
 b=GXRD2Dk837Nr2v1z69lf9zvahcMghIlGEqSdmg9T3ssJzs34zd9uYWFoslDJWpb3OGx271sqDekO3deSM9CY5cHklDaShbHCIXUDVVXy99b2MK8Ktz7+xeiFZUFI/5ipH4NEB82oCCHzoiG64pYnuU2gYxQkt/Ihpyoa9agSQLOp8A+WsVyVhR7WXbbBqlq4+H0UlHN/zcFTIWEFVEXoRLh9wqybJPb+KEbAm2Kqz1SnUeRygK5fX1twj4i8C6GTgncW1FRx6+jztDFh8jLXb67m66sTaePC9uE0CIIvDa231dVy98gqQR1tDUr0R6ycmrMhPGKF7oHOsDPFW+Q8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83m1qaPGNRpm67E5GSWUHo0dNo/hyDDPWFE4MctJvnA=;
 b=zaFcfAGosCRp8gXlBlL1EwyTzaFioOumCz4a6J2trPE5EFe/UywVuftZm809g/PEyz18rg0D20R5xf851oqHnrr4yir2SsrbqgebhP0XOGxcVN+QKnbZcIq2MNjPjmgw7u4WPsm7t51xuucKC5AFj5CKsuQOuyp3m/jHVpdSXDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by PA4PR03MB6800.eurprd03.prod.outlook.com (2603:10a6:102:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 14:04:36 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 14:04:36 +0000
Date: Wed, 14 Jan 2026 15:04:30 +0100
From: luca abeni <luca.abeni@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Pierre Gondois
 <pierre.gondois@arm.com>, tj@kernel.org, linux-kernel@vger.kernel.org,
 mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
 hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
 Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260114150430.36cb2b4a@nowhere>
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
	<20251006104527.083607521@infradead.org>
	<ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
	<caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
	<717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
	<20260113114718.GA831050@noisy.programming.kicks-ass.net>
	<f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
	<20260114102336.GZ830755@noisy.programming.kicks-ass.net>
	<20260114130528.GB831285@noisy.programming.kicks-ass.net>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|PA4PR03MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 97220a64-1efe-4bd8-f301-08de5375d9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024|786006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfYgRSCrP00KtQlRSJUJlZVGRbiCmZ+CCkdNO34U3Rltv5brmzqzvh83FrrX?=
 =?us-ascii?Q?f9pCA7XcjSdaIJTbgEStJQvrCsc1it15pnz3wwdYJA8mLa74RaAM7azXTEex?=
 =?us-ascii?Q?BDG4yDsw11++g6qh0uSzOz+A134RXwEDJet0iuE7BeNwno+esT7U96UqPjCg?=
 =?us-ascii?Q?2Oo45GrKmrmKhH8ALgAKCJaUnzo+9ZOONDoTkcv7kS15cRP7WRePftE12OOC?=
 =?us-ascii?Q?ykThKaJwfa5DKsKNSnLZXrPKXCIiL7jojqVpNWTPPlNN3Mnt30YoluAlGZvT?=
 =?us-ascii?Q?y+9hDTA5lV9gTkxceM9X0xC/jRb/jiW0NcTjmzhkzmIp8jSacMFF2YeKesNM?=
 =?us-ascii?Q?tEuE0bHNF4VvVVCKVw/z1S+L3Ysd4oUfdIygVjAb5DFJJuAq9ISXJf6hZzTo?=
 =?us-ascii?Q?2qlOreMz8iLqj9AXys/rQj2ZNDukp65sl5cdtbQXpdrDgE81ZJ0YPIMdhssS?=
 =?us-ascii?Q?NtN77tdfHkJrtoE0HxiNqAMKvZqBCUuhhl8oHIHJi4FRjvPRcDtmWr7+cjkS?=
 =?us-ascii?Q?EWwlZtLwqEfu+K4dEqLNn8IZK7oxI5oPoKUcMqzJDHpfEzG5L1JW39+AoO2E?=
 =?us-ascii?Q?CH7z+eYz6CSe5BCapjmYb0xYV5NQ2FSVa4GaEY4LXwSVZqIqkU7Us6yRqLs9?=
 =?us-ascii?Q?qL/0vT2YSyD7q7n2LpZVblydLxUMtUIuQqrL82xG2/D+KHWFfBfTrK3lybLO?=
 =?us-ascii?Q?yJhwy66WIC0fSMr8hBRm8xwpo/c2F1+Iw4eKV4tN5i8gpAo7WVJ9WtHE3AWv?=
 =?us-ascii?Q?vHlvEniWD+XNWexW0MIzTZzW6t0OL0o6uP1xNKPu4cVQnLt11T0NTUhl3C9g?=
 =?us-ascii?Q?sTmMcUEjZRZi0R7DPrSjHX2DGPIvZlQvPi8DzRG4ttxh05tA+dPpoQaCyFVo?=
 =?us-ascii?Q?H6C/zaK9hyy6Wg2EloQrQzD+av1DdWn5O9ZzBkOsBVzPPscDrj5n8S+y+R1o?=
 =?us-ascii?Q?rkKZ8vR5Hyhdk0l3aMoxD9TsEOSUQAvPIRIJHpdw+5ZFEYjxYJ9f1kb1oL8q?=
 =?us-ascii?Q?V93pXxbvFQItZwBq/GRs9CKcpNqdWwBxQisazYnasNAzR2ggZi+sD0GhqjC+?=
 =?us-ascii?Q?HgVm7gF7vpVguZvBDiGqjp4lmRzv166BdM5ggZBLRuEW8n5SnHK15t9xg5wZ?=
 =?us-ascii?Q?OmBUj7keThVO2riYL03yC28jewOWnoHXxwEgqQh/QUGPRkBzHmaEjcFmGitH?=
 =?us-ascii?Q?JgC6qI6l76vXEWg1BS8PAJx3o2EOYuRCICGDZ9wwYV5q6F5mX7+oH6GxaeIA?=
 =?us-ascii?Q?+pXMp8VhpoejGCbhh4AfxIGVLflpAIlwySs5ASLdtFatOIwwS5rG5idzCz+G?=
 =?us-ascii?Q?Zf+CQuYlH06XrDYWAPLCD6u5UvTDmfmKhWNtw/zAN5tshApjikOXLXDY+zrm?=
 =?us-ascii?Q?wkDHd5xN7GVwfps7HwFHmXnXxEhtpOMdVDfcAh09q5aGeF4f5tfN7hTwyBqE?=
 =?us-ascii?Q?TFQdEg02Jf2qIzvZQ3VwmjC3ZcimywHFAcz3aoL/p6FBrKxBH9wm27J9Mhqq?=
 =?us-ascii?Q?5v66YAKVEsKIKGEm9tl4PNLbLMh3xV/x86qh0WXy3F1aq+VXXFfB0866Kjta?=
 =?us-ascii?Q?XWv4MHnLqIv9tDDrTD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(786006)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Rq7QZiBbrXUuyKH9Qoc7jvmMZ50mkyA29Jl4uvDUJDzbpcWRpaAWI+xVtf1?=
 =?us-ascii?Q?ATiX4AFIEDnTYv0uPLUI6FBj+5QX9pF3MwNyNe1H23h92Rc4M4/GZiw5T0Yd?=
 =?us-ascii?Q?bAfg82xx6cElIDlbbs3jNYbf+RG0S/btw4nW822ufQMvp0/7ArPabx1vYCQ7?=
 =?us-ascii?Q?VnZvw9SZ+rK7tgVTPaOFPMTF3/MVO/qbE5auQpO4ExjF5PFiDwmfuAl1OePV?=
 =?us-ascii?Q?NICqrwJ3CPvQ0tkwLUlexlDu104i8Zu3akO854k5a5X7A/rqHkoTHnSxHDm3?=
 =?us-ascii?Q?ttkE3mL4JuQmlY68E324CNQztHL1Da5xCLF7iefg1fIDw+P9De9oQUU3mf8r?=
 =?us-ascii?Q?MypUdmwG1v3f9R5+7sTYS7DjY3+Oz9NAargYJN5mZsKgweuJ+DAo73dkgI57?=
 =?us-ascii?Q?wf+TFmkWVRi7A4gG1SwKIksb0/ZsUw+hsKTKbxVKeOEJ6t88C3IvWprvHT74?=
 =?us-ascii?Q?rTL7JR8rH+EJA+r1DCqnCFbF2mxQLloqFoEnmyKP6+KBPdFQ+i7lv4kvIlUK?=
 =?us-ascii?Q?cPuXl/r3v96r+IZmm3QPF07rgmjbqecFWRwPcKMYG/Ub+od1+n1+a4il7Elw?=
 =?us-ascii?Q?FvQta8U+ywfMd9h/InYgTDLqRE0M+rstN2lMYETRlqUV3QZ/ChwrZtl82D6k?=
 =?us-ascii?Q?HxkSzfH7OhksjHLFRYJ1WOSil2yS1o3oETY02L4GGIzZbNgiray/wXzArBmv?=
 =?us-ascii?Q?91A3rs1hdLHu7UcbHnpbWagobwOW8ZIu4w/e1yKAo5gBRTQ6dpSpZaBPbj6s?=
 =?us-ascii?Q?tmA4oyTEgW0LcrypWAZkg8boGmyq4XS7EKWgzH6FRpe4Uh3LZfQ4AVAziAta?=
 =?us-ascii?Q?CFTw5wygSZnttuvBnPsZY0rlUZCrO0JujAw0JeZcysRtNjVKiekigBPauzd0?=
 =?us-ascii?Q?QDmqz2dOs7mUZdBfYqJKPR392vu9kYL8k7n9mgqeE4gBi4PbU/WE9B4pELU6?=
 =?us-ascii?Q?JT/jwjmD9OwdQ2l73TUmSEc4UIMj6OW3QyxlUbLHEghwLg4fui7E5GWwrlt+?=
 =?us-ascii?Q?sfid1erIcyEWGdjfD1q4MOT+PkG0hZpyVgGEg3/cvbh2OhhMcwZ3AYuQWpKV?=
 =?us-ascii?Q?2Kwr4XeXhAYEelPV1J0K6oPl3BAMzecwxbrELAgpk3V3HMCOwjH93V4ARhYW?=
 =?us-ascii?Q?FusufBobyzsY6vp7x5BmdebyFvhQnlMD30gsaPrNSeM46EjVD1d+qolgLBF4?=
 =?us-ascii?Q?8aYrsdGw0uHiRISM+Jjzq29zFSWCFNjhwizPCMPcaIuuTPV/Kz/bvj+JH6Wi?=
 =?us-ascii?Q?/8GA+SjEJjgL8AZCMKyWvpIEyYqKVMCgQO6hbVW9TJtWFfXLgNqimPQDtIBf?=
 =?us-ascii?Q?UQlnnuZxKMeZbF8XdXvb/ot6WbbBWuENQ0R8GlporOfHX+qqycX2P99YbTv1?=
 =?us-ascii?Q?j4dLdXHO9chqUGh6YTEW0ywj1weBbk3jEastbxIYAZIMEvk94W/yoGULdgL8?=
 =?us-ascii?Q?oBre+dYbwSrz/wtfMqBTCRvdaO5MRVbx7zHIHCwrBjvbSEV9eJGFIQ15OEAN?=
 =?us-ascii?Q?2Iuf1kM8J739OR3GOOG/DyO5FLezdMHH54LAMfMLVF5TijuF0879YsLiQ7mh?=
 =?us-ascii?Q?D8XyWqMDyEhXkTD4IcpfrsBCNm/XZSBhT21MPh95oP0AphMS1bm51+qrZ0JH?=
 =?us-ascii?Q?ruGibmt+VKKFftAWsMd9knOrM3ASmmrE3V31mJh8KPGenh485t+LW57TZucD?=
 =?us-ascii?Q?aFp0LR0VmUJEZtqUNoXSOyVwvvikFyjGFemTQZwBo97t9yPjdHJaPC2Y1wGE?=
 =?us-ascii?Q?jLB24lRF/t45xNeg0ymLHP5VbPWo3hc5u0ntu88xuM5D0yOQofotLaYE11kv?=
X-MS-Exchange-AntiSpam-MessageData-1: JsCMioRb9pHR9w2o5/jJ7d+ApfNnZ4yxqhI=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 97220a64-1efe-4bd8-f301-08de5375d9a6
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 14:04:36.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRb+34RUurCPPCRb4O46CsY5z8o9rXKTe2JoR8DiqyrhueVrYpzTVJbUXXbDzIrWJG3jjrjJXBQ0/7Q9eQ12hyZGGIAVq8XjEUEAOxHdPuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6800

Hi Peter,

On Wed, 14 Jan 2026 14:05:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jan 14, 2026 at 11:23:36AM +0100, Peter Zijlstra wrote:
> 
> > Juri, Luca, I'm tempted to suggest to simply remove the replenish on
> > RESTORE entirely -- that would allow the task to continue as it had
> > been, irrespective of it being 'late'.
> > 
> > Something like so -- what would this break?
> > 
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2214,10 +2214,6 @@ enqueue_dl_entity(struct sched_dl_entity
> >  		update_dl_entity(dl_se);
> >  	} else if (flags & ENQUEUE_REPLENISH) {
> >  		replenish_dl_entity(dl_se);
> > -	} else if ((flags & ENQUEUE_RESTORE) &&
> > -		   !is_dl_boosted(dl_se) &&
> > -		   dl_time_before(dl_se->deadline,
> > rq_clock(rq_of_dl_se(dl_se)))) {
> > -		setup_new_dl_entity(dl_se);
> >  	}
> >  
> >  	/*  
> 
> Ah, this is de-boost, right? Boosting allows one to break the CBS
> rules and then we have to rein in the excesses.

Sorry, I am missing a little bit of context (I am trying to catch up
reading the mailing list archives)... But I agree that the call to
setup_new_dl_entity() mentioned above does not make too much sense.

I suspect the hunk above could be directly removed, as you originally
suggested (on de-boosting(), the task returns to its original deadline,
which is larger than the inherited one, so I am not sure whether we
should generate a new deadline or just leave it as it is, even if it
has been missed).



				Luca
> 
> But we have {DE,EN}QUEUE_MOVE for this, that explicitly allows
> priority to change and is set for rt_mutex_setprio() (among others).
> 
> So doing s/RESTORE/MOVE/ above.
> 
> The corollary to all this is that everybody that sets MOVE must be
> able to deal with balance callbacks, so audit that too.
> 
> This then gives something like so.. which builds and boots for me, but
> clearly I haven't been able to trigger these funny cases.
> 
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4969,9 +4969,13 @@ struct balance_callback *splice_balance_
>  	return __splice_balance_callbacks(rq, true);
>  }
>  
> -static void __balance_callbacks(struct rq *rq)
> +void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
>  {
> +	if (rf)
> +		rq_unpin_lock(rq, rf);
>  	do_balance_callbacks(rq, __splice_balance_callbacks(rq,
> false));
> +	if (rf)
> +		rq_repin_lock(rq, rf);
>  }
>  
>  void balance_callbacks(struct rq *rq, struct balance_callback *head)
> @@ -5018,7 +5022,7 @@ static inline void finish_lock_switch(st
>  	 * prev into current:
>  	 */
>  	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
> -	__balance_callbacks(rq);
> +	__balance_callbacks(rq, NULL);
>  	raw_spin_rq_unlock_irq(rq);
>  }
>  
> @@ -6901,7 +6905,7 @@ static void __sched notrace __schedule(i
>  			proxy_tag_curr(rq, next);
>  
>  		rq_unpin_lock(rq, &rf);
> -		__balance_callbacks(rq);
> +		__balance_callbacks(rq, NULL);
>  		raw_spin_rq_unlock_irq(rq);
>  	}
>  	trace_sched_exit_tp(is_switch);
> @@ -7350,7 +7354,7 @@ void rt_mutex_setprio(struct task_struct
>  	trace_sched_pi_setprio(p, pi_task);
>  	oldprio = p->prio;
>  
> -	if (oldprio == prio)
> +	if (oldprio == prio && !dl_prio(prio))
>  		queue_flag &= ~DEQUEUE_MOVE;
>  
>  	prev_class = p->sched_class;
> @@ -7396,9 +7400,7 @@ void rt_mutex_setprio(struct task_struct
>  out_unlock:
>  	/* Caller holds task_struct::pi_lock, IRQs are still
> disabled */ 
> -	rq_unpin_lock(rq, &rf);
> -	__balance_callbacks(rq);
> -	rq_repin_lock(rq, &rf);
> +	__balance_callbacks(rq, &rf);
>  	__task_rq_unlock(rq, p, &rf);
>  }
>  #endif /* CONFIG_RT_MUTEXES */
> @@ -9167,6 +9169,8 @@ void sched_move_task(struct task_struct
>  
>  	if (resched)
>  		resched_curr(rq);
> +
> +	__balance_callbacks(rq, &rq_guard.rf);
>  }
>  
>  static struct cgroup_subsys_state *
> @@ -10891,6 +10895,9 @@ void sched_change_end(struct sched_chang
>  				resched_curr(rq);
>  		}
>  	} else {
> +		/*
> +		 * XXX validate prio only really changed when
> ENQUEUE_MOVE is set.
> +		 */
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2214,9 +2214,14 @@ enqueue_dl_entity(struct sched_dl_entity
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_RESTORE) &&
> +	} else if ((flags & ENQUEUE_MOVE) &&
>  		   !is_dl_boosted(dl_se) &&
>  		   dl_time_before(dl_se->deadline,
> rq_clock(rq_of_dl_se(dl_se)))) {
> +		/*
> +		 * Deals with the de-boost case, and ENQUEUE_MOVE
> explicitly
> +		 * allows us to change priority. Callers are
> expected to deal
> +		 * with balance_callbacks.
> +		 */
>  		setup_new_dl_entity(dl_se);
>  	}
>  
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -545,6 +545,7 @@ static void scx_task_iter_start(struct s
>  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
>  {
>  	if (iter->locked_task) {
> +		__balance_callbacks(iter->rq, &iter->rf);
>  		task_rq_unlock(iter->rq, iter->locked_task,
> &iter->rf); iter->locked_task = NULL;
>  	}
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2430,7 +2430,8 @@ extern const u32
> sched_prio_to_wmult[40
>   *                should preserve as much state as possible.
>   *
>   * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the
> location
> - *        in the runqueue.
> + *        in the runqueue. IOW the priority is allowed to change.
> Callers
> + *        must expect to deal with balance callbacks.
>   *
>   * NOCLOCK - skip the update_rq_clock() (avoids double updates)
>   *
> @@ -4019,6 +4020,8 @@ extern void enqueue_task(struct rq *rq,
>  extern bool dequeue_task(struct rq *rq, struct task_struct *p, int
> flags); 
>  extern struct balance_callback *splice_balance_callbacks(struct rq
> *rq); +
> +extern void __balance_callbacks(struct rq *rq, struct rq_flags *rf);
>  extern void balance_callbacks(struct rq *rq, struct balance_callback
> *head); 
>  /*
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
>  		 * itself.
>  		 */
>  		newprio = rt_effective_prio(p, newprio);
> -		if (newprio == oldprio)
> +		if (newprio == oldprio && !dl_prio(newprio))
>  			queue_flags &= ~DEQUEUE_MOVE;
>  	}
>  


