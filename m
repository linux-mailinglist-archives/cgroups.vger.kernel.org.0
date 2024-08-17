Return-Path: <cgroups+bounces-4335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628BF9555AF
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 08:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B2E1C21761
	for <lists+cgroups@lfdr.de>; Sat, 17 Aug 2024 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23115824AF;
	Sat, 17 Aug 2024 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b="NDpZxpSB"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2121.outbound.protection.outlook.com [40.107.95.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31573A23;
	Sat, 17 Aug 2024 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723874429; cv=fail; b=URT8dLOw6ybBrnuRv2mtfgQYQI27tF4IW7RFXJ1jmYrZa4bbOC44jDUc+HeaxWO+R9MdKjHCDR7VTT8X9O/k/+nWJBr4a6MF91gLG8BM3o0djUxu2HqO2GfASvC57LtY7p+KTOd/dNqyOxrHmn30YscaKX/jGiv3bQtFX+FmOug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723874429; c=relaxed/simple;
	bh=qNtHJ0wV8ljR4F/QaQASPrWc1NKCnBqpQOXTOGscmb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eodVaQM9jQrP5RqZMpI1OcvrYuxEFJihLhJyd5zWbzKNBWHHHQ8SjqubSu23dzJXI9uAMuy4lbviuXKAwHxoXhxd+c0ODoKGOgw1ILp6VUJKJ34fq+YlrZpX7HeMemsg5peo3txQ7XoYvNiL+JbgDSpS+ASAEp5deYkfm7hZifk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com; spf=pass smtp.mailfrom=azul.com; dkim=pass (2048-bit key) header.d=azul.com header.i=@azul.com header.b=NDpZxpSB; arc=fail smtp.client-ip=40.107.95.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azul.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azul.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCF3qVJuF2iQrJUOmwLxFR/CdAB1BasTxmB3/X09MRMpEOf8oOgJWn/ydze1Xm3E37iF6nuCV3g+xsheRJMjUxlL7T7cJ2maAGk2y+Kaok3+t19nZ0fiGr+UojaARiTkw9U7GOZW3BLFeQV37u4y08vhpA5x+sg8HRAJyQFEcQRfaNTxKvmg/j0x1s40dsJ3SfBjPywxQoZMV9DeL9bHCMtBW5sgfwnVKpvRJzXvl8PSity24VbbeHzYEGjmDrkwDHNw5jnoycmjqZVyy/qWsDAVagR9qd/nDf3bz1lmXIYEMBM6CqcmTHw0gghAVuLKo8u8W6BYLzsFPADhvoE/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/43rgoNmvz0lRaJgiAhMjG7+NgNKANmXI1UCZUkRq5s=;
 b=Xd5cwydiNeXeVYpww/7Oo6Fb45tzbtMXoV9S1Cb5/s9Y5oS7R4wHZQD8qU/0G2SG51DkfEXTLLTvT0Z8GS5o2TR/lEpBmbAhWiZeycKEVpwsu+oZ5f75HLdtkPQFwNqtZy5O0KY8pSqEcp/iPmCSgOknLQKPoL0b4rQOTmMaRkra7wuftZwA6MA7eo0gwAMOtuNN8JCjgW3+ZEiZwTyxSXDs+MrOcvYyRTSHLsVAotgILkXOgfwGpDo+/oIQalVgHvQfr46AiNyx+S76EsVqCcN5ZcxkzvORE7UU6I/aAZNrSCViIAeLMMcJ0Ufz8B2+mzLLSf3/KP9sKfILFwBr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=azul.com; dmarc=pass action=none header.from=azul.com;
 dkim=pass header.d=azul.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azul.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/43rgoNmvz0lRaJgiAhMjG7+NgNKANmXI1UCZUkRq5s=;
 b=NDpZxpSBHaD9f8DL3Ga3LETCFzK781LU3l5gVwjg7JVWsi3EEfFw6RJR9hbqIpDEZp0rDM5RG41/kybTKbqZyOB2CG0KgyRX4AAtAzbycbcd7Nru0OHVBM5r6fPONV1B7h0BgkekrUqxcFjjuaYIq0XuInZvmTw2+fU02qJJbWEG0mNBlDEDD/+sW4QAwH+prwp84cY3JwFFRC0uJNy6EuRx58DszAEWYlqtRemTOgQJ5xl4R/Zn3a0YxA6NhVNxK+AIp09N31PCLjC58d0SNt4PK86aMwUSD32rCoflJR6pG3lPuno3kWWBij0399t4gSZNweZ9bk6ofdWUpSH0sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=azul.com;
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (2603:10b6:5:5b::32) by
 CH0PR11MB5233.namprd11.prod.outlook.com (2603:10b6:610:e0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Sat, 17 Aug 2024 06:00:25 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::b3d7:390d:73a1:6170]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::b3d7:390d:73a1:6170%3]) with mapi id 15.20.7875.016; Sat, 17 Aug 2024
 06:00:25 +0000
Date: Sat, 17 Aug 2024 14:00:15 +0800
From: Jan Kratochvil <jkratochvil@azul.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v5 0/3] Add memory.max.effective for application's
 allocators
Message-ID: <ZsA8b9806Xl8AxLZ@host2.jankratochvil.net>
References: <20240606152232.20253-1-mkoutny@suse.com>
 <ZmH8pNkk2MHvvCzb@P9FQF9L96D>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmH8pNkk2MHvvCzb@P9FQF9L96D>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3225:EE_|CH0PR11MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9dbcc0-0d03-4995-1096-08dcbe81e358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MdYf9cG25Lw1EERrWcv6ybdplZfHVavlA+ZT0Ay5GXn8ZcN7w7p1WQiMd3tA?=
 =?us-ascii?Q?mHUG7cXNY9F6ov4kOPgm46MjSw0L6jHIfVYaRHq3vJUl0XPc/lIvrfF4wHj0?=
 =?us-ascii?Q?1T26qw+jOx9DTsXgV030tcGqWkbq9HlJ4DZq5lzoPLNkJ6A721fVY924Q8kJ?=
 =?us-ascii?Q?Eb1SSgn2rYXItILcd/gmO88JZBrJETvF03s+DAQ0v7G3vQ8qXBOMlUHit4pK?=
 =?us-ascii?Q?sfGWpcDpY11kkq/t/Pd0zj76U5nWkdoHM9K2AOOe3XbiHm3q58AHnv3hQqf7?=
 =?us-ascii?Q?MY8vo7O5OMvI1/nVJlvO4/kVUnRdukxttyLr5+BfRWHjOIaBgcE8CmxASxxl?=
 =?us-ascii?Q?QktJOH9QSfIyIKbAaMH+K0rbOD3DwxdD7tP8XldoFlw1w3XR9Lv1Jm9O24+G?=
 =?us-ascii?Q?/AEHqu9aPnuz23F/qz8qlxeT2lOsxVqnO6IVzEiJ+Si8U7FjCemRfHw43Oq1?=
 =?us-ascii?Q?G3+5TrPmLuSdOPOL8hkmFN8sh6ttgEMbVi1Z5MKz1yAG3hZj7Ags9wkIotjv?=
 =?us-ascii?Q?HsIBS250h7LUZskvLiMChcJUYwoaB3ICEbmA8+UVSKbunF5clHrtdJlxrDAn?=
 =?us-ascii?Q?V2CdDCQYX9djthnSUOIkYgc1IUUA4fl9gDcFBDX/SiMHaBI/FgqSEUJ1cn4P?=
 =?us-ascii?Q?FiDPW2k/H2vJFyj+gmuF8YkMc0tjxdAIVmVTIh7pO2n1H2T+SYaT5cFhkh39?=
 =?us-ascii?Q?h3QyHVBz2H4E2EygrBpQedHoYpVMz/V2CFZaiSwXRzfXBDGN5r1CMmwBGB0p?=
 =?us-ascii?Q?IF/QFoHfe178yDjs2+7vIynxw2M1GcK9HFom3RXwNNyo+ZfZyaJWz3gUnKbI?=
 =?us-ascii?Q?j9dblb6uNcOJgAFydKKM1Pzw0tOz7M8XgIP44BZrdKyOUGOTfm47cCICqude?=
 =?us-ascii?Q?BynPjwo8EawuBMvmOZiel/JAWjAHSNlDB9vkDnGflcVqwEMFuGFw37rxNEIv?=
 =?us-ascii?Q?ZACmCfhUq7JN89Cua7tWJVFOYbxbWpr9vbzto/Aw9V2s/rOrpIhFagUFlaTc?=
 =?us-ascii?Q?1pmnhjK7X7g56zC6xAUJn37ZLdp9KCcMj420B4SwtJOW5vr5ea93tlJc+Iun?=
 =?us-ascii?Q?xxd+3t68clRiU7zIQ8obyMyiAeIRVb/I1gjtvNxkAKztDEk1el3gRZDF/wDU?=
 =?us-ascii?Q?AIZe0T9+nqA5Koxm3U7BhsglpbasZnPrqkiz/hmhcCWGliYGtNkju+Fazpd6?=
 =?us-ascii?Q?fbeAd3mGbcIbbq1isjuk08PWX0cVxRn/RDMiv8l3lUsE6BVyLowvILj+KMU7?=
 =?us-ascii?Q?x+27eotUG006DFiO8fWK9MPuxcNeGREtrAzHYoK9aqU1KebIUwk52tQEogLR?=
 =?us-ascii?Q?RgNiOeGUxGfty+BDQb8YGOR/U2ZfcXvIX+hIHiWzyJh8Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3225.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Lb3L8M30RmbBlA9Iwg5XdbWCZH1Bzh9sqf7cbY9PSn73spYx4T/nWg2IgMc?=
 =?us-ascii?Q?DSNgen9PxvOyU7PgbB06EbdYl3HHBfsBorIwnl2OTT1lA4XrVFBkewOWxKCn?=
 =?us-ascii?Q?4notlwzzgyJKXFADRLHe8FP2uJ9EnQNSDGceoIikXg8l2j6T3Cx8YDZFr0Wo?=
 =?us-ascii?Q?qMSzsh4dnCSoGAAxVvdzcbWUFU+xk8jpOurLo9YzjEUraQhRSFHHI4W0cCk9?=
 =?us-ascii?Q?zJ+hv6MkzRjIwbBNN4FzqY9JJHldcLlLzWWtGJUPcK0RB7NxINL9ro0DKoYN?=
 =?us-ascii?Q?w+v+QAWudij9XadEnFqkPj4ASAYTVn1kzl7hT6Q+NF37lChn4+pDzSDY4C54?=
 =?us-ascii?Q?PMZlwY8LaNH7qHc63hutEAqXDCwpuBCoE7/PrJhqxip787QNN7eBUZ1bDGyf?=
 =?us-ascii?Q?jYvTmwUM/QdLf/hBirviJOrheRYdVVbHNPX8jmFVQrirm+wF10x5i2Ac4gvx?=
 =?us-ascii?Q?J4yL8lMEr1sQvT3YK8rj34Qgo4eEiujQyP4sKU5UnLsGyzBueAZ8KUWHMQ0g?=
 =?us-ascii?Q?AcH1RN3H+pz5lPWmYD8irt0Fvv//o+vyWbUJtK8L6O+A4fJ3hel0Z+IHF4at?=
 =?us-ascii?Q?cJNjBcYVJcipOPJOi7htg6xFkRJxhie5Rd0DpTI4xRg88e6dBkoCT3W1o1vW?=
 =?us-ascii?Q?H2lDNgPlOKru4UABf9RgEVt3Bm5XCR138LkSwvRKX19V3e31GDVflZnXxeeI?=
 =?us-ascii?Q?cigwLiu6Z1P6hhBPY+dou7wPmrYqVPbGmPBWujqPNF6pqDWwL4uBcSlcQmpN?=
 =?us-ascii?Q?QglRj5RNKcT75mgNVhRO5AXdcQEbG/rV9BiE9PSwwb5neJA5d9dTxQi2GGxb?=
 =?us-ascii?Q?WYOJ5xRiITP1nnkmNrvlZuUqXfwvsRxij61ecYR12yYoOsxP5U4ar+iiXWVd?=
 =?us-ascii?Q?1ViCjn5TNEyKVv8W4NabVuk0EqVI23zA4p86ebvJKnA/qz8ToZ6vo5vmqaLg?=
 =?us-ascii?Q?iX/bR0BqZPQEVIKjERufwio+y8qY/LgRcHZC0gEio8r165jPuLkSMtOMCoc7?=
 =?us-ascii?Q?HvUDmXHHPBRKLfw2jqSybEJCrRg4BBpqhd9KOI/ExIrN4YVyqetVhkuY9Qbg?=
 =?us-ascii?Q?Am7Wey0DwnRxFVtpz5zligc/SzyAC7SO5/Ottl4VwlOkhARKLMXUMJLAtILA?=
 =?us-ascii?Q?vRCWYZUS0/gfGeiM9Fj6662vXFFmpdjr1je20OcXWI15V+5NyffIidgnfDyD?=
 =?us-ascii?Q?wZzkBpiPr5ceARVqzAIN8VRO+yoxD2E3BHcoz1HdAug5LfVfHyAyqatqkAvI?=
 =?us-ascii?Q?XSNKqbaj4+YB2TGMp9xnITlwrZKlZ+8POr91FPliVQJsI1zJ8y9vdgxXFCBk?=
 =?us-ascii?Q?Aur1oXEK5SmsSXmWXBuR49ZVLDvP7ZC3tQXFELLsHYzwzWEd8dA4+HkvyWj/?=
 =?us-ascii?Q?wcH59qUefOv3G9moVy9xJf1LF60to6KxnC1AaJrWlvfIxpCLV+gN3XDPnN0F?=
 =?us-ascii?Q?7w02vzcrqjnXIiCQSWYVy+4lXSAx4p09mEFWsXPBX+n9/3FeeBdHUoj9Gy81?=
 =?us-ascii?Q?Lp9YSQ+9O4Mne2EOGpINLgCOWsw5b982y0My2Nv1SE/fyOlf238uZHKJasEz?=
 =?us-ascii?Q?Nm6PWclHAZB6EPJXsYK8zrPMnI2l0QSLc33f4q07kUht6O2RIJr1RxubsvqL?=
 =?us-ascii?Q?yRtJxBmZMQvqENXMGGMVJRo=3D?=
X-OriginatorOrg: azul.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9dbcc0-0d03-4995-1096-08dcbe81e358
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3225.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 06:00:25.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c480eb31-2b17-43d7-b4c7-9bcb20cc4bf2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV9G44nCRNx7TX5md2CcXvjT2vcpzYBxFbzW8L3Ow19UxqddqIdOVuYI1YGx5/6rZ8hpP786iYcLgDZcZu8zRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5233

On Fri, 07 Jun 2024 02:15:00 +0800, Roman Gushchin wrote:
> If the goal is to detect how much memory would it be possible to allocate,
> I'm not sure that knowing all memory.max limits upper in the hierarchy
> really buys anything without knowing actual usages and a potential
> for memory reclaim across the entire tree.
> 
> E.g.:
> 
> A (max = 100G)
> | \
> B  C
> 
> C's effective max will come out as 100G, but if B.anon_usage = 100G and
> there is no swap, the actual number is 0.

Yes, it would be better to subtract the used memory from ancestor (and thus
even current) cgroups. The original use case of this feature is for cloud
nodes running a single Java JVM where the sibling cgroups are not an issue.


Jan Kratochvil

