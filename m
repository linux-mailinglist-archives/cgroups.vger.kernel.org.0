Return-Path: <cgroups+bounces-13210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 646BBD1FCC3
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 16:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 841353003FFD
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA584395275;
	Wed, 14 Jan 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="vThBwWe3"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023085.outbound.protection.outlook.com [40.107.162.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B962E0914;
	Wed, 14 Jan 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404362; cv=fail; b=myZjGCdMHCsCKKFymZgTYBqtC+yHlBRIiXSnvXyvzcaXtNQwFeCt96lOqkKYK6Wz4QfAElnuOg55gKLCnwzuJR6Tx+OB+C9wJZ56dzA8u9xLIyvzHb5Poo5SvgRjEa5bZgK+KDQ6gZDygxxQCMMXnMtfy6m8QN2Ak6tFrZt+cE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404362; c=relaxed/simple;
	bh=fpBFqjQ+YR1RRhrFhWA4ugeLYroyT54u++Gtzb+GOIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HQIutHsJwKlmdmfGm7uT/nQJzGLZqLQh/1qPnZ2WJrQmOIOMFXTw/P9NO6PIbVCZYPM7R1gYc3ADdtkzBF8puLPI6The0Z6Ej8tXvF+DoQYs32iUHhna/KeNrGiasUqxd17h8DrzDaLfpti6xWTB7ApU1yU8+KlstqAnwSi+sE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=vThBwWe3; arc=fail smtp.client-ip=40.107.162.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPZANKloX9aXcDfxWPzj40YARvVMQPa5NQnv5r4Scft1kluMKC++mkmz7+5oQw90EnJohPW5eKby8nEJOfc+RO6KPqdFoIP1XFHVWyeXOWO7pcvVvoekjVhpOQgEUDhfXF5irR9OIiQPpWB/w2SrEMBXan4LDyf4W5xRNYK6KqJdEppXTllCIdDNyyt98HWscFbGb5KGumlQ63lxtYwSvI2uXwvCgWiTLIsOLarIqI0KIHy0pc8dRU1ECesOQibChCEhgyE1vyAxvwuXXKMrjuFODk7zId55gACTQB6to+e4oUJ3dNfAJ3xwNVY5A+5krHZPbQDK3ZUBqECn3kO0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGZ4u46cf+KWbWBxHktdWLCeNC5DOetqWnOtf4fdkXk=;
 b=H42uUyOWCZjJaat4VXHWLSfi9+c2F7Ji2YtptyXA2rrR7lDN4VqrDh2HV9IEvZMyD0Q6NDoWTYv6xrMoTIetNErsicmNzRt+nEgQOxJkQC4YD7QByn62SKED/Aiyfg0ZpDfmeh/5y+RRFpZmbDoprtwxlCF8JfezBNyVUfAW1dBrvTWtLzWPyhqNdbYsjtDDw7rRih/TTVY2dL+rfK5PnKFhHzLnbtp2lxPJjWor70LCRE1CNM46iuTmt+SMixV7D292f9MW7cxCruHiEKm25lFw+E4rx0OXvtzG9245jjAh/vPmEFKNwPalUfZ7g90EdKcsQLPwlt6fm6li6WkTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGZ4u46cf+KWbWBxHktdWLCeNC5DOetqWnOtf4fdkXk=;
 b=vThBwWe3GMMI5XtCDr8xX/DdBur1mYf9Yf7STMXSW9WbEeIlXiqJJXu/ROZYMBwVJTj/1J1gvv4+FJPpQl6XINR8ByvhFWj/hCtghEwKAH1qt954VO6ghaq6rvwbxZr5y0pID+yB4zZk6UA3o6dDl7dKSJq1Sbq3fmiCA6eGrgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com (2603:10a6:102:32e::7)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:25:55 +0000
Received: from PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235]) by PAVPR03MB8969.eurprd03.prod.outlook.com
 ([fe80::6bbe:2e22:5b77:7235%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:25:55 +0000
Date: Wed, 14 Jan 2026 16:25:49 +0100
From: luca abeni <luca.abeni@santannapisa.it>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Pierre Gondois <pierre.gondois@arm.com>,
 tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de, Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260114162549.613551f2@nowhere>
In-Reply-To: <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
	<20251006104527.083607521@infradead.org>
	<ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
	<caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
	<717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
	<20260113114718.GA831050@noisy.programming.kicks-ass.net>
	<f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
	<20260114102336.GZ830755@noisy.programming.kicks-ass.net>
	<20260114130528.GB831285@noisy.programming.kicks-ass.net>
	<aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To PAVPR03MB8969.eurprd03.prod.outlook.com
 (2603:10a6:102:32e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR03MB8969:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: ef88cf1d-a449-4f07-dadb-08de53813602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|786006|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SXBy+kd5T7jY4eKffXmjG57VavlVDiY1hj8WTOpEUmUPDwdhJxk1B+1PuEzE?=
 =?us-ascii?Q?3mJZChGYcJJPfx6XQwEEQd1yQ9+uK62ILmX8OvP5o/usyXVb1AF8zfIZBovQ?=
 =?us-ascii?Q?cc92WFjayv64vOJ05fNoJq/duoQzdZMA7RAdI53EHcMQuNuoVimGvgxfvhvn?=
 =?us-ascii?Q?QG7q4MSndUQgg09hzrPN50nuoOL5I8csiLZWlJmSg3CUOc53QYEt9kZySN9Y?=
 =?us-ascii?Q?5VKKsCCAC3GZOeZInjpEFekPFxYh/xCZR0ESU/CK6V8BuFqPHJvEkoEpdxTT?=
 =?us-ascii?Q?UUHUkEX0FPPP91xzZxI7HZRGUBZGf3pUp1if58p5cSqW2oe8aQ4DSfpdXSQ8?=
 =?us-ascii?Q?+2dk+44Di1smARYtDAqF6uLwqsgHsPYGsnP1zKetCPG/pCnLU4fRpLHAQ+0q?=
 =?us-ascii?Q?IQ4lbMvFTfP2rT6WgnyG2vduQBzWdGl2wtKVWmNDdn9pu5X95thvefwl7VSR?=
 =?us-ascii?Q?d5AfLJ/ljIJC+sRz0MPMkHZjFURIdn5IWKb4HmVWWcUvlIzM8sQKaAJ/RJQj?=
 =?us-ascii?Q?ChlNRDvXQyXxkhTBzF9XwLXpPbdGXH8pqEjUc5NJW2R/ubgzkgfjHDFZUv4t?=
 =?us-ascii?Q?1DbtWO7fYhxVVXLhPFLmtALmKpfeF2ciLWZrMqmvrh4uBXbU3FCwC0OgbZeo?=
 =?us-ascii?Q?p2ZrSYuPWYvZ1k5hO77v3Uz+Bzf0twq19jPY2R9fD92vzOxSQP9sbGRUVqJU?=
 =?us-ascii?Q?P2klx65Ad+tB1UJ44YW7my3F0jXh+3DA/y4NSxRORX2RHKmnuPVTlhnH7Dim?=
 =?us-ascii?Q?vPf9RIq+tSSd73ZiYT7o92UrwUqwy78sCTdI0pGv2NzGD5b/vJjamjwhFo3Y?=
 =?us-ascii?Q?L4Hdj4fF6s+Ul33R4Dn3O7FegfX7L/IA7282Op+40AfhPSZbyvYRUeInaTKP?=
 =?us-ascii?Q?5ZsXsEoKUERDs6rh5v+mE20Y2fZqc7gdRy+zkZoPFGSC38cOD8lYQIIcXcZb?=
 =?us-ascii?Q?GCEpROa4/5LhqK6X4Mg+WggwV87EB6t7EdNDtFhiTY7rzK71B8WHeNuCH+VL?=
 =?us-ascii?Q?WuIR1h7TPx1YC9eqZvcO5iflsUhYLmJWKNZLFqpzKsZgGcG2b81M8ddgc5Gx?=
 =?us-ascii?Q?EScfYHedAe36rrv0fNoSWVyFtqlKIIPBSbreXT8eH821aR/gEl6mrAY1AfLN?=
 =?us-ascii?Q?Ordz+51tI/UOUpEo7QduzR22LYVMnDn765XAvYFloxCg0KcVEfYVrOcPOs/b?=
 =?us-ascii?Q?EzFObex4q6UMGAxDhwZypS9iiOdFYNfPz+6NMetyKW9GICcJDbB1UW959rDk?=
 =?us-ascii?Q?D+xspipLzBYl5NoFgmDDMmnacaVgxOLMcC18pmsYf16+tHPsCLQs9sqhFEns?=
 =?us-ascii?Q?c1MwpG2+pj6/jJWtPuzQMYUl95nEUSAowkJDw5V+o0Yds24gg1xttkOZBJZX?=
 =?us-ascii?Q?RYmVxCcgbaNNhyR2pg2TG06ZGU6CnxUQOqdoQ0M5una3/LzpmxmrMehzd4eN?=
 =?us-ascii?Q?Ome8C4uSELMHHqE3NENE3HbC6cRpasj6MOuGPRrqY7yjuv9GAHRXYhyxbSca?=
 =?us-ascii?Q?PNK3Ie/ZUlcEhgOuSuFnzt05hoQmeAImIYCzASICwREY66IuJ5qypWpBYSWE?=
 =?us-ascii?Q?BqPiMXlFlWVg4WGspKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB8969.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(786006)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wJ7/B2LFRPqvzAuDM1V8fBCUjlS7igoY3PcWOF979ntpBP2meZW8ZO5PpQS?=
 =?us-ascii?Q?lmhxRdXg/3wKyPtRJ8z1grBI51jRn6uPmkyJ2EdROkEygJeuAr2NLgpXtOUQ?=
 =?us-ascii?Q?Ppg1tD9cceap/dJU9VHMCJ9qQuoXtmIzEBPf3qGXn3DhzINF2Am3dJ2W4qkB?=
 =?us-ascii?Q?LKeTowoS0p6yGgu+Q+HlH+AXBO7Mbx8xkO5hHO7i+ve81HUMu8FmnHMg2Yjs?=
 =?us-ascii?Q?lVPJE2P1zN1ltu6Cg15GH50o5wfT6QYVvDpmFpnCL/4evppvXUbiCKqJhkhJ?=
 =?us-ascii?Q?27rxecl1W8kxP0bEIDpMrjgRaqFcK6gcn4qT6W+0sEc8swKepNnL+LQMhHGz?=
 =?us-ascii?Q?BrSP+6fQKyPNiyrk3Ak42jzN/fAVM7hfk7JEiaI5Uphvfvl5XAF+CIqWrQ8X?=
 =?us-ascii?Q?tkPgKxLyBrOH/M4a/x1b38ixoWNQFjpMq6tp9rla9IeoaYwM7u+Y+YtGSfTV?=
 =?us-ascii?Q?3q2KC28pqC+/wHArNpjZ0fJ1BZO3G8Z49xHGFxxLNCD+Wj1yMqH/Rp5U5POI?=
 =?us-ascii?Q?sNfvuCC8dDMx3sH9k+WQ4Gnzabnlzg/lhflpwcQE/sKFKVc+lv4rYkTeTVvk?=
 =?us-ascii?Q?WQhY+iGx/4pSZRF+C0B6sGCeUmwTsTg0BezsMfpCYSSgkWCHmeqxshTcBer8?=
 =?us-ascii?Q?jLEFrfIO6UM+ohy7TfwSrhUhtzfLRkZRI1cGzeJwqc3m3kQT4mvsOpsBdk+v?=
 =?us-ascii?Q?euHK/F2mto8G4sRZSol/ja0PWAhzaKvc+dF1A0bVA3QFR6hwotGH+3egzie5?=
 =?us-ascii?Q?Qsk//Akr9mXnL83U57nMAHPY2+GdOEKxxuJpMAAXs2TNgM/8imWFK7NNFkkU?=
 =?us-ascii?Q?ICGLdWrZnoQi3s9DIISHsFHeTaCzyyn30tJHULl4mdQ1DZe//RN82AhO3O/7?=
 =?us-ascii?Q?RHWGhoqu6fJM4cg7TRUfDzqf7jhit8vpYNzXelYo7SjyaWSQ5g/Yb5RJetcx?=
 =?us-ascii?Q?Es7RMoK/tbfqyw+MiYY70/exNGOTX8uOhFvU32xmZSaut9AF3f2whZokQQN5?=
 =?us-ascii?Q?FNH7wxDCrjwQVo6g3DbxK1Nsv9RhVg51/musGC3V3MHpHWp7lHHAgAGyCUWu?=
 =?us-ascii?Q?8RaaKb91geVo++4ph0MEIloemUJxzsD+m931eF0hvRjhfP7sRxco922qTrWz?=
 =?us-ascii?Q?Wc6w8k+RTrF+761hZ6h7E3OVJ/QjqCmjUrnzUK7vF1AKrhWBqmBsqG48vhYK?=
 =?us-ascii?Q?1Rn4Byj1AhfYgZrId79W+yrrOtvbuyu4jSE8KaoaxE88jibpoW6+9eCtsLFM?=
 =?us-ascii?Q?CSxYbQS4jMkfC85ZW6XuUlDg4adVafYGxLZjnDhUmol88x5aUIuyQv4wmpPw?=
 =?us-ascii?Q?kDXXDusLp6pSe9k0uMC1qbVlnRQ/ts17rhNz6WeJFxr/NCdmraAJAQoRT+Mn?=
 =?us-ascii?Q?cN7uzEvPCUxLBECILPyatiq0KtZfrU08YjqFfnWG/YRBnHQ4yUFpTmofxwzC?=
 =?us-ascii?Q?Vgjn58AorSbO1Dl1A4c6RfxoFOyNPbHM5Dt9GED27t1htkjScjJlNKE89GZG?=
 =?us-ascii?Q?thCT+mJDkjRH52pNC3NtkKK6AhCc3ge3DPCZdElVX0MtGGrXTU5c+lzd+8qR?=
 =?us-ascii?Q?QQyBTTHsMXwdXmgQmSCZFDmizQPfEciwvijET7eeeOyJgGDW1a3Q0EHrlJ/a?=
 =?us-ascii?Q?332WCvxd9Betc4PliN6Ic00vdzITyjepIIqirDCN82X7ud95Ha3sUIBsQsGS?=
 =?us-ascii?Q?8pkcUO8pk56pRpfD9JPVJaSCMaXDWeIsfj1rIEhOFhdCiQ6zDDgpsRL4nZTw?=
 =?us-ascii?Q?QrRbQbd1/DSUgVWMNI4QmqxyeTOU75OpBlAhpgVlh/F2bHhNGMwP22msJYoN?=
X-MS-Exchange-AntiSpam-MessageData-1: 2Hr6oV4JW0A9fB3+j8iu1P7v6SK0gsbxSaM=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ef88cf1d-a449-4f07-dadb-08de53813602
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8969.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:25:55.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkBpDoM/Vwz70alMGNQeXYMj4Lq8uMtB+0czNl4NHzTZwoFl/X1ZtLv+0GNfF4wOHuwz5wIg8q7k2haxKiIYhhiPECqVAkusCJw6S81ziOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462

Hi Juri,

On Wed, 14 Jan 2026 15:20:48 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -2214,10 +2214,6 @@ enqueue_dl_entity(struct sched_dl_entity
> > >  		update_dl_entity(dl_se);
> > >  	} else if (flags & ENQUEUE_REPLENISH) {
> > >  		replenish_dl_entity(dl_se);
> > > -	} else if ((flags & ENQUEUE_RESTORE) &&
> > > -		   !is_dl_boosted(dl_se) &&
> > > -		   dl_time_before(dl_se->deadline,
> > > rq_clock(rq_of_dl_se(dl_se)))) {
> > > -		setup_new_dl_entity(dl_se);
> > >  	}
> > >  
> > >  	/*  
[...]
> > --- a/kernel/sched/syscalls.c
> > +++ b/kernel/sched/syscalls.c
> > @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
> >  		 * itself.
> >  		 */
> >  		newprio = rt_effective_prio(p, newprio);
> > -		if (newprio == oldprio)
> > +		if (newprio == oldprio && !dl_prio(newprio))
> >  			queue_flags &= ~DEQUEUE_MOVE;
> >  	}  
> 
> We have been using (improperly?) ENQUEUE_SAVE also to know when a new
> entity gets setscheduled to DEADLINE (or its parameters are changed)
> and it looks like this keeps that happening with DEQUEUE_MOVE.

You are right: double thinking about it, I seem to remember that the
"flags & ENQUEUE_RESTORE" check above was introduced to fix tasks
switching to SCHED_DEADLINE...

So, I agree that changing "ENQUEUE_RESTORE" to "ENQUEUE_MOVE" should be
the right thing to do


			Luca

