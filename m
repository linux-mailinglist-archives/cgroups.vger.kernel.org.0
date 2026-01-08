Return-Path: <cgroups+bounces-12968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DDD019A4
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 09:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 005B7312212F
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B7397AA1;
	Thu,  8 Jan 2026 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6Ss5G5F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rckbCHde"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112F399000;
	Thu,  8 Jan 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859511; cv=fail; b=RiGDxT8CrODuvVEBIe3hqmvGpoNzmxnNGeSNyi4VclG02uMuSFQAd/gVGW7zlN/XCHh/fWbmjE1Ws9HRzsAq3Vb2SacJcD9gPy2ryfES31Hyz9YvJeW67u/7FozNSbygDW55dj11a/f/SzN2LP6iXGH8SEDmZLHzOZwyWIop9AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859511; c=relaxed/simple;
	bh=8Jxihrw9eNnhnhClDQc1ICbzSGlr7mHNxUYl3w94ksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OQ+XoUBmwx5boN8OZ8pQCOTo2EnX0pifz4FkPdpNeic6UaCIQiY/jy3px/6A8Lqov/5sdjGXyDRObMDjJ14G6XoadyWnuJiM5Hzn8hmTD3AV6+x6FNV9UqhgYs/PqhsLVMOQ3W5P0E1j9sTvHT4PfBidDaLbDRxTfxroVoV4dq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M6Ss5G5F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rckbCHde; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6084ZlQS3710602;
	Thu, 8 Jan 2026 08:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dEGXw+//mvwNjcY9TJ
	wcvO9LIryiJJTYsLSs4J5v2uM=; b=M6Ss5G5FCMLLvbKQXkdq1GuQ9E3IzGU2S7
	OJUa9ybZKA6Kuq8b+HnafNhkxm8pYtgVf74f56uSXjWj9z8TVBLrXSmIvhv4V+Li
	Aeun4YPk2wtv33h9QjHGTryCjUMAeSzhffZAVwRVPaa6iDAgOAIGLUgJ/B69Rmf6
	di8b0Y8Jnh0P7ZVOCa08iVBIMEV8R/PefzeHCUOTyHokaRApRwuSSTA8BGPN19bE
	qnaRldTWmVZy3Fp0qHTCNwccrACNQsvTAK8w1mBVRnJxqe/67seCyKTxnRbbF8ro
	li6b4f0r5tMnCI66VY7iyoFCi4EihgimkbhXIVlYx5HjRY8Gdjug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj5pnr5pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 08:04:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6086fu3g033891;
	Thu, 8 Jan 2026 08:04:00 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjasxw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 08:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suD38d/fOqeS02oA8YD9ArVLSPHS2WUPIv2P7/WJGe3gxSRFGiA4d8s+A+eanQpn+DV0dAqYfIldvIC9JXpQ1b44r7tgsmEe++2tKE9amE6VxClVnwgDyvQNXKSqbOM1GmY+JTurcjhjNJOWJO5+QBwMR6PhwJIiv9atrsTvMz5337YuOTQglNzc/dVyZuqBZ2S8ybOdAsjonJvbP8jz+nDQ8paPpwQVe7f4vo6vypU2b3nZeK3UcrdigOFutpoq1lhUYaBflXtLG7MbUgh1tBCNYehhmUKK/jwaqHNxBmbOo/3UHEagtMHFgcQ74RFbnpWHpuzh8IZ81vo3FHcQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEGXw+//mvwNjcY9TJwcvO9LIryiJJTYsLSs4J5v2uM=;
 b=BaJxjuIgvtYECfIHWZOqc4IG8u7BPPp7Iy+AXs+hJlHG//ZwcO66ZekIqTXW1vq7RVev5JoERQkiR6OSgKIlXtd80w0kmjrT4GJ871WwuYBkTP/FidS/w/Dt3RE7i5eKIC9TwRv+jclBlnnEnk3K8Im5ALPadJwx2lCTxaf8tzdms8hXNPhQe2iqq262qmN5NH4LI37X5Rgmkmza3uTWaXhSkkckwAVtcQsVQGGHcOnNQVduF931P1S1nZg/tUcSrwYZJC8aZCJfgJGou9UE9V0F5FZJqpaGkkI6fAesSaEDjQh9U6Q+xabROA4/9lhSppGlHlmrlSDr2TLKTYNvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEGXw+//mvwNjcY9TJwcvO9LIryiJJTYsLSs4J5v2uM=;
 b=rckbCHde5howQYy703BKFEIvKHKGA21sDTiD/9SUoMRN2bal9Z+GYIw4xkcmI+yWIlH2QBQHLkmHFlBiUhrqifzsQV+Rz1bYblo/smLS/bUypMRewn2C6BMSiYjVk013Vkevjuq4X9HL92gj+5kkJcezohM4qmaX7KG4eMqO8vY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB8030.namprd10.prod.outlook.com (2603:10b6:8:1f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 08:03:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 08:03:56 +0000
Date: Thu, 8 Jan 2026 17:03:44 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V5 4/8] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
Message-ID: <aV9k4Ez22j9ht_vk@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-5-harry.yoo@oracle.com>
 <473d479c-4eae-4589-b8c2-e2a29e8e6bc1@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473d479c-4eae-4589-b8c2-e2a29e8e6bc1@suse.cz>
X-ClientProxiedBy: SE2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e52b92-4c12-43a5-5ff4-08de4e8c78f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGzMDmyHgSWQFW/VE9LUnIHcw8wOmdBEydX0mfb+nZ8DYAUDtUmQRGC5mgEw?=
 =?us-ascii?Q?htMGfDByW9cLNVjD9Vw21hARx0+c2PqhuEBO/V3xCfeBEvemn2089IdkJy/r?=
 =?us-ascii?Q?hEnvgjk9Lugo25iX5oxqNl+84KVJYWcHPHRDOo8H4lCqHRUpfI+wqsXpHur3?=
 =?us-ascii?Q?12gHSjobwU8Z6qUiKddoTFjJdst+ySz1jLgzHpQKy2PTbRMCS41cIyixfEq+?=
 =?us-ascii?Q?m//VzaYcjsGevIYCruRXjZLLFzw2W5BsKOuzKIVj237s5br5VfoGnD8GdJms?=
 =?us-ascii?Q?dnpt9mczB7ttxPSfE3yVkrLe6+qr4Qo0o65A+zEWOu+26UjGNMpRoTWIY1t4?=
 =?us-ascii?Q?KGSiUeq3Qv/LSQUF1usg2reqV9rhNz4ur4uvGv2t0Lrnxok/W+CMM8qNLESq?=
 =?us-ascii?Q?Mxi/aWB3accN3WgBH5SEThitvC4GPzILu3CpMXpioGMh4NEsSo9CYf8qj7gv?=
 =?us-ascii?Q?8iAYCOcVxwHUE8Dv8IF+IeButNY+KeHqpz7PrYVhoHlFO6Q6Z1v40pms0LTU?=
 =?us-ascii?Q?pXRa7vh3pzetXT/oBLMVO99ehkxM9L+nQVKNrpwrvbwBCK0TViZ5eAAmbRDy?=
 =?us-ascii?Q?vxDCgNbJVckvVmt1ILkLufjt68hBTToPxoiJ2osFyKBGZtjKC8IApH4K6eL8?=
 =?us-ascii?Q?nuipGhHGdaPSNXzgNX58o4qfPcbUUXLJ1if31v04UMdX/yTYmnFhFotFkRQF?=
 =?us-ascii?Q?CQDQqx1UW4h2B+pBUoKvK4dq5M4CWVaHd3B/ui9fqjZKeclPG1l6yS8X+gjS?=
 =?us-ascii?Q?mW8lBt7yUGTJqFdcHNbaZWmq0L2fVAgI0K3UOvVRmobHjuiBh4ryRiOllXJX?=
 =?us-ascii?Q?NDmEcVLtBVKZ4hG0I4vkYixug0SDQ1TMuk7+3FKUFKKXh234/gV5Y+f8yROP?=
 =?us-ascii?Q?YQ5bPlUKLxeH9DpITMknISkcUOFZxUokRUuQVZR+x7kyuKMss3UvgW/RMp8M?=
 =?us-ascii?Q?odNWhrq6pCn8/bfBnasz9QOyzuR6ACH7TyYP97aTnvzhy7A03kr6wgHnC/A/?=
 =?us-ascii?Q?lwOoQY3ZD8LR3YHabUm1khtaN/AUJQd+KWwsvuDozvH/z0vDtf1DVPXASclD?=
 =?us-ascii?Q?7Qj7hRPrpR71WqxeVkdNclpQcBsRd7Td+ooxxTUJ3kWSaHRl3LvH1TxylePc?=
 =?us-ascii?Q?iELEolfe2aKbIO61yzkwtda3zpn6NCKvGu1Os/7Xy3VCxf2GHWUloCDvIHKz?=
 =?us-ascii?Q?UW4Iusuhf/Z4rXedKxRUg5Jy1t4lC3Uz2MTyT5mtTsAM8t+J+zDWX3HElAh/?=
 =?us-ascii?Q?PfpQv/nMsp/yV3CaGO1Tts5bqB3MVtP1zgZAZrd1XSgIllWwOVd3ms++JZ03?=
 =?us-ascii?Q?sg42KuEMqwmT5rT/UqhkmsskiM8xoOkOgsFVayWsm6GStWGJDJhdYI53mMEI?=
 =?us-ascii?Q?JjgcVgpTqpTfugAGXIFQck3tRhtMMmOVxBJmKbs9nguvDtrb9PYR/MpnWAmD?=
 =?us-ascii?Q?MH+HSJYQ5OygIvhmTQ49QzQgQKkJHAxq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFpzIXifFZB/F1HWH8gBqHyfmCR1VoV1uRo9YF2XnVacZesfONu5qdavQMtC?=
 =?us-ascii?Q?Ud6Um/ahd7neVYtpeNShtObrV1sCrVZvRTccwgp8X5No7kTUS/Y4g1uM1sjS?=
 =?us-ascii?Q?PwNu2vWvkgl9PFcWZbPBufbWN7dldf3su2s0BjPnpuxnaPv9chDFoW5XCdg1?=
 =?us-ascii?Q?7T1Rg0bJLbn2PIXG3E0c6NEqQDlWnRFBCdPgiCuFtMnRTHPJinV6/Nne6EVJ?=
 =?us-ascii?Q?lLBLSGvt7G4oMu/CrN6+3W86JF0LS2yT1xX2hjFXA0msxafetJrxbjcF+qWe?=
 =?us-ascii?Q?q+lKiD9XeMjDIUUC9aD2GCHWpelnjii88kw9Nx95kUn/fYbEUKNTdXzAi//N?=
 =?us-ascii?Q?BjURE1mJykBxZtr006XA46UnE9tqzEBk1TbQzIxkZPq8hdVI55ZnZNCvuRKO?=
 =?us-ascii?Q?Irfitz45zAzTQPeUM48Ahf9Jd04zpLIp1BQ18WeyQEKfEUldRJD4hoCdQ3mV?=
 =?us-ascii?Q?nME0/AAu5Ik7KW7o8E25QTpdW0JCJR86S/C4fKs9YUfgmZre4vQ55JAMLIVV?=
 =?us-ascii?Q?WAMSFzLs4pHL+FQyu3Znp0xzeVAG6sADTu9RbgxSJCVh+cT0ywErzagmBgxs?=
 =?us-ascii?Q?PUhSAbmSAXYDZRq1nl14hf2pAXmwMUBRy+8718J7O0FWO7FveJcgTgEEnN6l?=
 =?us-ascii?Q?Ha+xLQVQbXosxLdsENDeVpuFbYjJJ196pLuoFB61walznTbb8CFOEj3PhSvT?=
 =?us-ascii?Q?Z/h2ILIUKL4qFyt21Y9Uh6A4oWrRtKjgzRmU5VOg1P+/IMYHdEmKT8HKdOx1?=
 =?us-ascii?Q?iuCnJrraKVahSkWvF1H9elkcmMWV6bW24ey1cYFwxyKt1cv37VBf5R8BgXTj?=
 =?us-ascii?Q?noSkCqKBpUZOja4H+aIrXrikKdf+aWP9f47+w1Jg81R+519N/grrN0vpfKeB?=
 =?us-ascii?Q?dMQaOpTt633itok5zSXouKakMCRpuX2/GOLEbi++JYiSUlMomgg7YsvvCgyo?=
 =?us-ascii?Q?MGo/HgbcbOUb/s6M/ZCIvhs+HhVqRRe4350GsJvK820N+UcEdicNATe7hjzb?=
 =?us-ascii?Q?XOpSEfgCQg62KPNNx9RXpVuh7i6suMfqEo0miEDofowJS3Y9n/MGxdRF4t4a?=
 =?us-ascii?Q?C0V+k+D1Mluy0nME7zSlnuPdP9RPsZqBuPF7cgWR+I1uCIQVyCEBNm0xzG5m?=
 =?us-ascii?Q?Uz6NyqpC0V5PP8gyFbReXpFartydCxJ1CswG0QkEYq1UZUPbh7jOFTwuCfCI?=
 =?us-ascii?Q?ocIuPDYmGP0r6FOsUiqcp9anBQqs5fvvqKI0lLKgkwg22dRF7KBT2pMNUD98?=
 =?us-ascii?Q?Wqca292JyhQRwr7CG7RhTyL+dF6LFxi54jENCwdeWEuhPUFlxky0M4gqGXe0?=
 =?us-ascii?Q?vaht7DL6FzaEwwuhDy4i+1iTQJWCpJuoq+ve8bbNiGmdiD2rR1YhbYo5mYeM?=
 =?us-ascii?Q?Q9WrdlGaKEDK2E7qnBppIxJ3PoNHF7OEGMGDgh7JApMcTg7KmFq82jZA3cct?=
 =?us-ascii?Q?AuZyCFQ86N/W4IjY3pj6M/2SdpSIHRLt2hXMCzUNJ3jd0F626EzwMvybAfmN?=
 =?us-ascii?Q?BIot6prZlLbBQcSXuMKvm3AYPRoZaJ7ysLNTIGC8/mXTFdhTdIxFoQNaqCCY?=
 =?us-ascii?Q?A2fleW8ay5T79nHKFdR3tBviSLCEiKBe7LcMRfSvKExNVjkAO0x/lCNdfuVp?=
 =?us-ascii?Q?fxd00emGRX52UgPgHDkzG2BMgkZY5o2NFUzejiiN1bdaQLHGxstIROSGbbGg?=
 =?us-ascii?Q?zUoNljrnK+j8Caa6OEvDB18Q7nI2GXndMsCY3GiiKrfbc1vj00jeNMQWbCwQ?=
 =?us-ascii?Q?TpsVvQbJkA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zUaoqDulj5GTIE6+Om4ZM1oTU4Af7JbTOKq15IFR5At/a7SkKgzWN3raC8JUtZcBZr5MD+xTMIeWmc/7RUphdmtyFFFaYsH5FlcJGosraL6M2foudfLw9Gg+Uvub9XTVJypTXrKp/YNDEPuLeUytkJdfsMBUhaVOPm8p5dwDMVjW6uB1GGd5+1zz6TvobRlV/M1kB9Otb3m2P7e+37NxfaCQRaGx9Udj1YqecISzY6FIYLN1gtlxAlc4SOzRnPdlnG11nrx3VlIj3xVHxblEKkWBG5gl7NX4G4k3cuBmmTnWF2zXYYzDToT7Nl/oOIAmJUnch9kvVYQJ3NzUclH7s7cCZVHFTnEPuWuULyClEJDPMayaFalNS+Fd7qm4xIPLGv0sbXYTLoW3lJvKXwLj6f8/IPISxbs8pbsX6lyUkhIDQpoXMKc1Tx7Wps3nL4dFOEZ6BnEtZH+SzNAvjYtb4j88xwWxthNjeVjaw/XrFM4LyoLF3haEXvzvHVIrCKpG+an1t1rk2jq70MWhJMNFjdXNf/ZMCd4munh9MsTqWRaOjWU69/2zSi1cRETqOO7nGkyQ4y5FDjLFNDyEzm/6FoJc98W1RdmaGtWfmK8HXUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e52b92-4c12-43a5-5ff4-08de4e8c78f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:03:56.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A+pZwI3KztnJDbOZ9TPFauHcTcpD4FIIANfqQnB6za9WA5sY2+1HO73Oing7gpEuCR8UDhJdGaYYNM0Y8fA3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080054
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1NCBTYWx0ZWRfX9PbjG4tDikK1
 mtTKlaXqIaOcWl6Xd0uykqgQLfHRmc00SG9MPdfYWfqvfNbrOFMs401yn/u7HWmwPPwkF3jq2Ae
 ZZL5jcWVjNB0Yw3WiIcqYCPhm2GMpgPz8M4MqBWya9zcSMWVO/a6IRZAymR0HtKhAROeh0GehMM
 YKmkc9F8K7U3uRVpOvoHCGpWfS1eHM6SuflB+SUtaOOG3SizpXVmhkyFSNNFCxosvqu4Vxq6LFC
 Pw46uf7aA3gXCFWE7z9F5go0nrq7iUbizw0Wv0Mlze4bvVjcxVzKr93nQdql8H83BX6Ha9DF1qo
 q40kY220Bg8IRo0iJBpas9EnTLvmSu+kbCq8NQ9lZrbKlDugGNxmeWwLPlg39ayihHzVZno6xR0
 v9CdMMpsPdwtV3cHg0/XZKKE4nZOVYQfIv0yrPxZhVRx35JL+x7YvMWzFH84TtR3AARUpI9ECez
 GTLn2n+djJTd4sSLjQw==
X-Proofpoint-GUID: pMUZmFSFgEjG7WcCdUcj3cQU9TSOGKdM
X-Proofpoint-ORIG-GUID: pMUZmFSFgEjG7WcCdUcj3cQU9TSOGKdM
X-Authority-Analysis: v=2.4 cv=dOerWeZb c=1 sm=1 tr=0 ts=695f64f1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nTT2fSWjuIrH7fIiLn0A:9 a=CjuIK1q_8ugA:10

On Wed, Jan 07, 2026 at 03:56:41PM +0100, Vlastimil Babka wrote:
> On 1/5/26 09:02, Harry Yoo wrote:
> > Currently, the slab allocator assumes that slab->obj_exts is a pointer
> > to an array of struct slabobj_ext objects. However, to support storage
> > methods where struct slabobj_ext is embedded within objects, the slab
> > allocator should not make this assumption. Instead of directly
> > dereferencing the slabobj_exts array, abstract access to
> > struct slabobj_ext via helper functions.
> > 
> > Introduce a new API slabobj_ext metadata access:
> > 
> >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> >   struct slabobj_ext element at the given index.
> > 
> > Directly dereferencing the return value of slab_obj_exts() is no longer
> > allowed. Instead, slab_obj_ext() must always be used to access
> > individual struct slabobj_ext objects.
> > 
> > Convert all users to use these APIs.
> > No functional changes intended.
> > 
> > +/*
> > + * slab_obj_ext - get the pointer to the slab object extension metadata
> > + * associated with an object in a slab.
> > + * @slab: a pointer to the slab struct
> > + * @obj_exts: a pointer to the object extension vector
> > + * @index: an index of the object
> > + *
> > + * Returns a pointer to the object extension associated with the object.
> > + */
> > +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> > +					       unsigned long obj_exts,
> > +					       unsigned int index)
> > +{
> > +	struct slabobj_ext *obj_ext;
> > +
> > +	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
> > +	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
> 
> The first check seems redundant given we have the second one?
> If we get passed obj_ext 0 and slab_obj_exts() is also 0, it will blow up quickly anyway.

Right, will do.

> > +
> > +	obj_ext = (struct slabobj_ext *)obj_exts;
> > +	return &obj_ext[index];
> >  }
> >  
> >  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> > @@ -533,7 +558,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >  
> >  #else /* CONFIG_SLAB_OBJ_EXT */
> >  
> > -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> > +static inline unsigned long slab_obj_exts(struct slab *slab)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> > +					       unsigned int index)
> 
> Hmm this is missing the obj_exts parameter? Either will not compile
> !CONFIG_SLAB_OBJ_EXT or isn't reachable in that config anyway?

It seems it's not reachable as it didn't break !CONFIG_SLAB_OBJ_EXT
builds and I'll fix the prototype anyway.

> >  {
> >  	return NULL;
> >  }
> > @@ -550,7 +581,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
> >  bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> >  				  gfp_t flags, size_t size, void **p);
> >  void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> > -			    void **p, int objects, struct slabobj_ext *obj_exts);
> > +			    void **p, int objects, unsigned long obj_exts);
> >  #endif
> >  
> >  void kvfree_rcu_cb(struct rcu_head *head);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 0e32f6420a8a..84bd4f23dc4a 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> 
> <snip>
> 
> > @@ -2176,7 +2178,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >  
> >  static inline void free_slab_obj_exts(struct slab *slab)
> >  {
> > -	struct slabobj_ext *obj_exts;
> > +	unsigned long obj_exts;
> 
> I think in this function we could leave it as pointer.
> 
> >  	obj_exts = slab_obj_exts(slab);
> 
> And do a single cast here.
> 
> >  	if (!obj_exts) {
> > @@ -2196,11 +2198,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
> >  	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
> >  	 * the extension for obj_exts is expected to be NULL.
> >  	 */
> > -	mark_objexts_empty(obj_exts);
> > +	mark_objexts_empty((struct slabobj_ext *)obj_exts);
> >  	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
> > -		kfree_nolock(obj_exts);
> > +		kfree_nolock((void *)obj_exts);
> >  	else
> > -		kfree(obj_exts);
> > +		kfree((void *)obj_exts);
> >  	slab->obj_exts = 0;
> >  }
> 
> And avoid those 3 above.

That works for me, will do.

-- 
Cheers,
Harry / Hyeonggon

