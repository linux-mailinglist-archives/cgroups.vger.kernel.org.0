Return-Path: <cgroups+bounces-13166-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BBD1C980
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 06:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 184773007526
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 05:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B623557E2;
	Wed, 14 Jan 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZkXgrPs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="frUvTYwZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1414B1AC44D;
	Wed, 14 Jan 2026 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369102; cv=fail; b=XucpnlueiTo7CtfIkG3YqxNdnNSkebRI5T3zRykcTVv7Y3YpC3mJisTwieuj7+7cFbp/j75AMW7iy+pAiw0bQWzRpHdXT1MMqvVCP8PzqM47BP1OywNlcZB8aRPGBaXomleOrHvmdU646gAaYvu7Mj0x84NIXWUZ5ud1YLfwyBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369102; c=relaxed/simple;
	bh=0DTiXZeZYmpHZXVWZCxbI1ofPBogUw2iZxscI7qXxTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odBeGwtbK8rovqr5341sed2sMN/5q2BcjkaD5DzH2Tp6PQvaAcv0/mPx3UzIuPWg4JRqFvpZBvop/eskdQ8WGxkYFolozq4pmJKPsIgRte5Al/FknQLZfcwgRou4rqSDE5u5OYuy3qeOVl3Gk4jkMIkP/XgaAZiAvd6c7BzCC/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZkXgrPs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=frUvTYwZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DGAp942420224;
	Wed, 14 Jan 2026 05:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z0T0IV5yfB1O6MMSJt
	4t7AjW90MJ8vpYp9ORRbt4qkw=; b=NZkXgrPsVsckgBk7L1yXPc5NUyBNmXh+Ew
	Gzq7J4wj2SfJJpJh7bpy3PEW/qShGDa6pT1e9SKHECFAROpFyYu7YYAvprcFL9/M
	UClCI8/hDdCdOqOKmMvwAXMgT+yLrz6aZqagmHYvSqeDIYAUaE0U89c7y6lEtnjo
	SOP1Sj00Tegz+jEt8w/OsvaW/ftNuNvqa+SMqDZ/E+ZQrIK95tnQtUm8i5yeC49r
	AjOHwb5PtavKwppEdtwqc87Wtfils6JhXieIJzz/N13n75Zr2NmzTMisUSgfFeLd
	tgjEGzcVyNXlwFUlNifq9oO/V1yIfqSWy/ULC70ExeHnMYPAGBoA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3vne3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 05:36:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60E40HwN034693;
	Wed, 14 Jan 2026 05:36:36 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd79m947-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 05:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RptI/GI/gdbsOLFckfW4NWAmCVqgwVGerGvzGYT1AeKxgMSNQS8SQyrNuFH+QXCYuWS1krKievStNEaaPXGGyc0FwT/mcXDBO3zjqio2EatxSaX8L8bXFo8SexhoVkey0drhTs/AEAvT8gU0YoA/2dv9gx0412ss5GR48kEE26DPBbjFtmKgzfzS6cAJ5BBrfRweWdJSCidzX1A4u3RRNgZIcejncDNTL+8L6GMV3fxSd8mHPz5r5ri93vMLv4kVQGrDSu+N5pMPntYWtGJYXBR9AnGctDXtbbviB1fTCrEvE0ZD2t3Lg/aU4TdlCYOLGNBN9iIGFMJ1K+PR7WtfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0T0IV5yfB1O6MMSJt4t7AjW90MJ8vpYp9ORRbt4qkw=;
 b=lyNxH8kvdt8h8gMJAJB4TqWEe1HxkgQWQMA9SHvV7GwzDre58UsgMyPrL/dXggKOlyt14EsOogCvFMIPEm9/v3kBaTVE/higILMGyWhWOk8q8B+O3cDdEhrHFkDzRTJ76qI3xF5N50iqk5H2RjAGoEJan4DtkMYYxIMQEdJW7C3jNDulyX1PclVrVzDne9/U9GfEw0ZNagoTqDX93JBJiDeKRCdfqBtqc0j075uXr71/KdAFDPPUc48oJYP/wQNpO4yfNR0JLupAiTQTbzjIO+HU/6rcJs33R9gn48tHMDDwN5ZCGnL3WsDPV5KwQACD2BrS2FNNrdrZTe/IPmo3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0T0IV5yfB1O6MMSJt4t7AjW90MJ8vpYp9ORRbt4qkw=;
 b=frUvTYwZqfRDuwr1CsZFFAnCPNVtw6MMhSCqDtz9SO8WvVY6NCmwg3/Kmk+mkNdM2Iwgg2n7gRV8NpIUPI++4QaZa3rOiJyUSn2vYyLE/Y6tdlCJTc+kNqZsLzt6EFMs2e6kbuRYsEjO7ldqUJlyhMIm/JMcfKIeO1A8Ir1PWRY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB6341.namprd10.prod.outlook.com (2603:10b6:806:254::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 05:36:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 05:36:31 +0000
Date: Wed, 14 Jan 2026 14:36:21 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
        mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <aWcrVRT_RjxdjoN7@hyeyoo>
References: <8703f907c4d1f7e8a2ef2bfed3036a84fa53028b.1762762324.git.zhengqi.arch@bytedance.com>
 <20260113220046.2274684-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113220046.2274684-1-clm@meta.com>
X-ClientProxiedBy: SEWP216CA0145.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: e69cbbd9-3c56-4b26-3d58-08de532edf42
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?uA7KbGdUwNLAIbJVn5MA/NFgkz1oKNsKKXxGGGuv/lo92u53+U1HZZiOPBVG?=
 =?us-ascii?Q?eGMLyA1O9XaKMsr0/6PfHzSD0CFJ+9F44wBwXloSIbgCVx0A+KgEHNNwIgXP?=
 =?us-ascii?Q?OAu69E5uPV7nCJluBXcD76nzalT+wIL90LRNTE0PBf3Pm4jclDVhQbT0eaGd?=
 =?us-ascii?Q?GaikSV7FVTgGxzUK0HK1pOqeZ3iuAmKXozFW8fDdW8aBKwgkSYBxW9TBAA1j?=
 =?us-ascii?Q?+e2jxnZ5crcPQl0ujYRAdWgLhKvPx8Iw4nW+wb82P9tQn7e0q1q1LWFMJNxv?=
 =?us-ascii?Q?qTei0BX2eiFabNkZhb8K9mZsNqKL3cKSJdMhk8MANdpa/T45dltQtoqwNSEi?=
 =?us-ascii?Q?cQyZKl4rzhXhytGalacIBOZbmPMveMgRCIfSQ6/hrSzd6z/BWhzHghjO9A4m?=
 =?us-ascii?Q?5vNfskUjL5fScFUfZ215CXfS7n+5dVxhFtL4zVurBuHxzjjW13lmqMi8OQIX?=
 =?us-ascii?Q?+a7rtFz9QuPhcO75g9BS4lLVySfKWRNB2zDUkwC5/FbI+Ok+oiHZuhEd8Cwx?=
 =?us-ascii?Q?WynVbi2pNCbzb+Cn2tWUIAt/4ubA1KYDydDlQLd/mph4SX5XLcB4UjRo0W84?=
 =?us-ascii?Q?tqeVEHprtKpgA/X8vzN8muuWWSipUw3Zzvu6dMB1lQaS4KP+SVQdIR6SWTAu?=
 =?us-ascii?Q?lgmoW6KkNJKY0FDvI2D5ijkKv2WrO0XVK1woxXtCewpdUSWIYYegpmeUjM4T?=
 =?us-ascii?Q?4rFp2iQbB9IPbr2D42ZGel3nAufbt44rnm30n82WP9bztuhlaf26QFsUPqzm?=
 =?us-ascii?Q?/wcRFVBWhGk4dwgHoxF7l4OGN/M5DoALQGN8+oAkY6hQblLZ9NxDso2w2hOF?=
 =?us-ascii?Q?NsDSPaQsgySVVkb5YPOGGvcDZnd14s5iyfPtSgYvCZ724wtQNu3n9wGM452t?=
 =?us-ascii?Q?6F0GBOwiZrXXrqO1uoQ9FDfgQJ8R9LfC15OmNgpnN4pB8dXK6FYBweayry+j?=
 =?us-ascii?Q?X/si/kQ+3jfpPGR6J07eJyvDF8z8Cnnlrv/3ZmLzuK2FwUuCc1/RdAK3neay?=
 =?us-ascii?Q?Mse1L6xdAgkIGi/knVjsFGHEzai9ZG0YMkoF5XjuAvbvGCwNjff4Q62oWqI2?=
 =?us-ascii?Q?lBUQkb63yFcvEyIwHDblO6Zhu9xQuIRsccNi6DPnF7fynx/BL41TLHAJInbN?=
 =?us-ascii?Q?nI/I42SnjZtXr+sRZR3PWrtbpl1Fyt8KMvOKPxUJuO1tvNUEfE3UJwdhg3Fy?=
 =?us-ascii?Q?PFQ93JWmVi1A1TelDKZPnkZkAVvu4EgWw6hQYo7E/yciQOaEYgzO1p+EjA5N?=
 =?us-ascii?Q?9t+PWqxXqAhx54v6znvrtC5IAjWdA62AWosUixWvc9fZb6BSe191CB6tsjjM?=
 =?us-ascii?Q?XrzjHCXkRrdZkqehuJuAfrjTBI/jbHpO+NjCpABttmw6wNcaxFzEhW61358a?=
 =?us-ascii?Q?UX18NBvQE+qHR5DllnvsXpUiIFpyLMk8BSK/OTJDOBwahYcNqQqSNPbAH+6c?=
 =?us-ascii?Q?Itrv7mYGHs+3uz4yNyzfr2hGYUr3JvfCqT5z83fuI/twKDlGd0mT8w=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?EElGLpVsQ8KL/8Dw2pDgVc2EubUwZb4G6s1SbI6kZ0vOOMUWm3J/KQHleiX0?=
 =?us-ascii?Q?UbUwZNr549m0x5lrjWqwb2h4uiw7t0Bqxclv1rTD8FubuXf0RmJ3zfqvgo9p?=
 =?us-ascii?Q?kMLqhXI4DVh5xzoFfAMpspo9yEIFVXfScMH5JtzwPp7k5on09/PligGJ2xyS?=
 =?us-ascii?Q?g9C0/ZMxq++FcM7KwIJSJPey9uy1DeT2DXduqpPMGxbOlZ/tVchMOaiCRxZ3?=
 =?us-ascii?Q?Ubfp3Cnoq7mBgND6ssa6tWHV5CbCvdVVggqAN+llD8fKrGGL0MlpaiLfoyev?=
 =?us-ascii?Q?+BQv5EMTnzI5zq9UYma6/EqSp9ZXVuQqm2ObLB9kwWlPDJkSFpev+B3TUWHF?=
 =?us-ascii?Q?Z6P3vN/axpy5LLvAmkcutLWxvc0Ekn7c4Bd6Em22Osk6so1TrrS/ZfXefwWx?=
 =?us-ascii?Q?BqF4RUBWtclZAR/DzTpPxcS312DyadmK7nPotcAG975G4gVmhSA/3MRfZpKv?=
 =?us-ascii?Q?ZITaUrErkXPNomiO5wka8Rr5HHS4T5GQrLUUw79JhWZnfSnQtQq6eVz3KsJ6?=
 =?us-ascii?Q?dFF1lhW467z2jXDS9VR/tvA6JOq9Fd21iJUiR4xDplZZE3Qt4kBZyhWecpbm?=
 =?us-ascii?Q?29ApHOyNyU43LhsaxwsyDdJSFul4DDZh1kV4KeSJteCNKkygKLWhCSIeK1Fs?=
 =?us-ascii?Q?DuxNakEhFIH7B5H6jdsFVpn16onCaLC1axEhVWtqPQF5y3JTyq09ZJKduMAb?=
 =?us-ascii?Q?+DRZWJbPTquzzFFwYCZQhZ9xkTNoA+NMRkZ3MnI3M4N4mDRSziC7xYFjH7f+?=
 =?us-ascii?Q?Dfb9lRQldMGZa/XrSqDxHwpo0J4ZsyGKNIR9UdvGxwZnBdfpMkwEGT3D4ZSj?=
 =?us-ascii?Q?0XoyiZA8Et0VsOyR1yOUbAzSMPGNIyKgfur0uDmpOAC4BP1teNQFYqDGso9a?=
 =?us-ascii?Q?eAjX39tUUiS1LRCyLTwaRRLJkniJrb1DhCPZBkktc4B2xUlcIpfOcyeUxutG?=
 =?us-ascii?Q?j5nGSIag0pqvMCqBS9rSOV6uhk/cs2jLd5etf9C5IHzshUYg+f/NkQ/8cjNN?=
 =?us-ascii?Q?qMbvKJUmj3TJyTQFhjp6Fr4jV1vnfdaVxZxmTGkv8BMHt4XJ3MVVup52ENBk?=
 =?us-ascii?Q?ohMBfpDsDAA/2uN4C7RDa60QaYe48UbzRhl9xYUmcqcvHvQhWjKozO6j91gQ?=
 =?us-ascii?Q?HXp99yrRSaD3S25qEaMfYkKUDMNKiCS/hen6IJZQZzZu18bHmZ/R3WkwLwgX?=
 =?us-ascii?Q?NhOUqzD/Vwph9wBnGSAGwfN/8TWI0uou8PT53pJatJKwqZgKpuLZHOGHVh9R?=
 =?us-ascii?Q?4A4rSzqBItwz/powAYjWxL/zkFYHTkvwMlYMVOkvBQiQIxpFCqL/SGNft8G6?=
 =?us-ascii?Q?a0KUcGHY1K2DYW/8QnYcAQmQizG5XL+dtNJM0gOMxSXcF7fmqUvBqGa9q2Ab?=
 =?us-ascii?Q?7Bb+qaucFTixQt2+gb5iiwusuV6Y3pcAeAmtMwc2Z4gYJ/+cDA4HDs8WyxO4?=
 =?us-ascii?Q?UBRjA6tc5rMuCGOZx3wMJoQv/97MAWrJECJOMKyerI7TzRq7KugFr5I053Fk?=
 =?us-ascii?Q?1phWr921S7xKy5rdF6WyaNQC7OH6ANiWPl51ToAJOHK36RBmNfhQelx8Hz3K?=
 =?us-ascii?Q?886HhcHMT6i65eWLFyNNEIEj1Vb6RXKaee7IEgEWDdNwu8Wo7e7q/PcU/d8J?=
 =?us-ascii?Q?l0UA1lviOw67VJp002Z03/6zc6LXa7cZvvPodH6+z7stLWovtTAAXgluvR/j?=
 =?us-ascii?Q?utiGPG0wTpRu1g6p5AyPZ6nIBg8w356qEOAW8pmjEV5xJMKWzSa00Ho1hY/c?=
 =?us-ascii?Q?CIAJMS52NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o4E+KNZYPjuGGLCvQgH6eySr+BNcj01KNXrZzXznPCkYU8HXzRn9EAy75HFQFfhFEFNerwXQpFiOca3hgOZW0G3yFh0xiJKmTVp8kFaUAZpyOZup5vRc6GeVEwpzHpsIniSnmQABT66Rj6AtUdmT/vUdrfEHQsJoHpTVTOx1NeHz2d4lcmfhbUtE6lDQ7eLBYD7OZNX90pfuD3eo0JGDaLlBkM2tSNtnlV+vj6nLvVNzFB34nKfkZ4TEE5voAKUUEVIthqeHDlmgyOsbxZOuyPUFd0rkJ1jltJttKHsp7zXLbf9w0lOTJhYrObEs1dSUcNoIcEQio5dkMfxgi2xhor7JHfKiDKt0ZyAD86ltasEumKfJGMDO/YUalrkFnDnm1VBJFTQ4xUumkzdNUZiUkcPYYX8i3RIgRjFjj5R3IqEBiXlEviiO0FdV6FmKib5SGo4AeUAV83z1hRMWJx7OmyqZehSsrVxhy/llRqLQ0jBUHAXUBbz3v79RrQMmR1xEYR0umnuG9YS7Gs9mlaHqMY4T0oktoZgnVvrejAY1Wvn2/p8RgJXku0xU3MyVD/IPSuZT6qTe/e9DCbO+eUNiWf0xVTXdhQ0QlN+WSrKB4oA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69cbbd9-3c56-4b26-3d58-08de532edf42
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 05:36:31.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF4z5sDKng5q6mcCbfGmYmdQfbkdZnTrWBPPj2e+UWWSF6NqaNbMfTyT3kFzMnX3TRKuc4zNMKDWo1uMC1Ltag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601140040
X-Proofpoint-ORIG-GUID: sGTdeQdedlGFwlewMabDplrErJv5O_l9
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=69672b65 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=htikSlhTfqeFgeDzT8EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA0MSBTYWx0ZWRfX5hnGSrz3tdn3
 BTvtyPhwh50TSxMSyl3n07rZ5c6r9VAgQFrvo39xZS2MZyMZvgth1tzID6buAGheL7xZ8k8nvzR
 y1up6n4ElAjzqVbys89qSouMs4EIRPxqoVMY2Cu01j9N4I04i2eEgPpZLU9JYL980NKCI5HUQ+W
 Czv0yfwIX0941VJGLvYoSpVDxZxr6irAPOnqzaqVPTADEuS5PWRSnGghsPvpqH35MoQ9rKESfl5
 e9ovyB40uaUt5/UxeVj+ZC1XMahwDjocS/Bg7mOpHsmgVuXPNe/z6z7xTlq9CTvoIMFlVJ+PwSS
 qAMIJ9MLjcrcJqWNY1Y9qa+bu4A//H3OlTVB0mPxq6OtSkOlt+T7pyJ/5XEhwAt6xNRJpcaAbX/
 6w0SsKbLoKdWNbU2abys+W9CaibvBmba94qyjsdBBuVlmPP0cIPCD5004P7cR4SeoQY3xDyGEYs
 JT0NccfL+UBO9hp1LGw==
X-Proofpoint-GUID: sGTdeQdedlGFwlewMabDplrErJv5O_l9

On Tue, Jan 13, 2026 at 02:00:43PM -0800, Chris Mason wrote:
> On Mon, 10 Nov 2025 16:17:58 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> > From: Qi Zheng <zhengqi.arch@bytedance.com>
> > 
> > Similar to list_lru, the split queue is relatively independent and does
> > not need to be reparented along with objcg and LRU folios (holding
> > objcg lock and lru lock). So let's apply the similar mechanism as list_lru
> > to reparent the split queue separately when memcg is offine.
> > 
> 
> Hi everyone,
> 
> I'm running all of the MM commits since v6.18 through the AI patch review
> tools, and this one was flagged.  I'm much less confident in this report,
> AI tends to get these races wrong:
> 
> [AI review output]
> 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index b0c6a4635c67b..cc6db20d7dca0 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1775,6 +1775,12 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
> >  bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> >
> >  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
> > +
> > +static inline bool memcg_is_dying(struct mem_cgroup *memcg)
> > +{
> > +	return memcg ? css_is_dying(&memcg->css) : false;
> > +}
> 
> [ ... ]
> 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 13684e5376e82..d17d3810a882c 100644
> 
> [ ... ]
> 
> > @@ -1129,8 +1140,14 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
> >  {
> >  	struct deferred_split *queue;
> >
> > +retry:
> >  	queue = memcg_split_queue(nid, memcg);
> >  	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> > +	if (unlikely(memcg_is_dying(memcg))) {
> > +		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
> > +		memcg = parent_mem_cgroup(memcg);
> > +		goto retry;
> > +	}
> >
> >  	return queue;
> >  }
> 
> There appears to be a race window that can cause split_queue_len counter
> mismatch. Between the time CSS_DYING is set (in kill_css()) and when
> reparent_deferred_split_queue() actually runs (asynchronously in
> css_offline), folios can be unqueued via __folio_unqueue_deferred_split().
> 
> In this scenario:
>   __folio_unqueue_deferred_split()
>     -> folio_split_queue_lock_irqsave()
>        -> split_queue_lock_irqsave() sees memcg_is_dying() == true
>        -> returns parent's queue (locked)
>     -> ds_queue->split_queue_len-- decrements parent's counter
>     -> list_del_init() removes folio from child's list
> 
> The folio is correctly removed from the child's list (list_del_init is
> self-referential), but the wrong queue's counter is decremented.

Good point. Sounds pretty possible to me?

I don't think there's anything that prevents it from unqueued
before it's reparented.

> If the parent queue was empty (split_queue_len == 0), this would cause an
> unsigned long underflow to ULONG_MAX.

Although the accounting mismatch will only persist until
reparent_deferred_split_queue() reparents the deferred split queue.

Ideally this should be fixed by checking if the folio has been
reparented after acquiring the split queue lock, but since we don't reparent
LRU pages yet ... do we need a band-aid before then?

Do we want to have is_dying property in the split queue as it was in v2? [1]
[1] https://lore.kernel.org/linux-mm/55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com

> Could this be addressed by checking that the folio is actually in the
> queue being unlocked, perhaps by verifying the list head matches before
> decrementing split_queue_len?

> [ ... ]
> 
> > @@ -3920,6 +3920,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
> >  	zswap_memcg_offline_cleanup(memcg);
> >
> >  	memcg_offline_kmem(memcg);
> > +	reparent_deferred_split_queue(memcg);
> 
> The race window exists because CSS_DYING is set in kill_css() before
> css_offline() callbacks run asynchronously. The comment in split_queue_lock
> mentions that THPs will be "hidden from the shrinker side" during this
> period, but does not address the counter accounting issue when folios
> are unqueued.

-- 
Cheers,
Harry / Hyeonggon

