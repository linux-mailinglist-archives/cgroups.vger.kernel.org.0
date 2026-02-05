Return-Path: <cgroups+bounces-13681-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMkCArMuhGkV0gMAu9opvQ
	(envelope-from <cgroups+bounces-13681-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 06:46:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F46EECB6
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 06:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BE593013A79
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 05:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD76821A92F;
	Thu,  5 Feb 2026 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E8Ggm6HQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A3/Hc+oT"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D435975;
	Thu,  5 Feb 2026 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770270379; cv=fail; b=GgY2f6uk3V8kctbyXr7HdU61AZHHsK3GKLSCCQxhJzo3PYbD9hu1j3qazj/6aWMMhSnxkGVHFmloL4itYgJHuS9WbMy7HQ1BDg+65pnoEN2RVni6KTTyfAVQKU0PBZCJrwQbe6wxlmuZvDeV0v1AiihbzUHfAmOu6xSICCB2/eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770270379; c=relaxed/simple;
	bh=xOMRjj0Pmi+n32iLNFQ816e1D9LC9CeUjJ3TzXs1eH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iJ0XR65ieL9dHhQxKJ7KHNUShrpV2CEu1IDUfw8/DK4NHosYrZyGzm1NTqIHqKn5Cs+LXA+nwVYm1+9rYRgfVQgjHO+aEiOYU6JZiryN9Lsgrctz2lkanr5KLjwgv2SqEbtkv+A/P1gHGsTN/WMiGESnIAx6GUw/bWb3ygeKHr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E8Ggm6HQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A3/Hc+oT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614NQftF2399241;
	Thu, 5 Feb 2026 05:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XiQLekNeMJ4gddbysQ
	6/Jap0xf8x4UO/mvbIq+TjzbA=; b=E8Ggm6HQGPgOH+DNT0FqO11aXZGOqAvWVW
	P+ZbPYrv9fpZEmx55TdvS9Qz/Ugc5LFXkOCSO03KT+rru3KjTPb0GOWjbyHamNZL
	Gyunanlzji2eWjwWgzVirn5Eo9wnf4DNdOuWQwqmfmTGQ2zwGjVQdwxytdx9CG4q
	DTxZMRgR5Ckcl9/gVPOHRHLd4VG9Pq7dMTCgfPpJC1M5tOAD6gh2Qh2AyLvfM6Wg
	q1l8mkXKImpzIFtJ4Fd51oHs/tYJ/lavLg8mfB9BDdOEnJfAMlP9VoStVrVZ4YGq
	GHoIriwRJmq4W0u0Y9fqOrByE17YgRBr0Ih3ir/ikoIUidM7okVg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k5g3043-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 05:46:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6154v5WB025830;
	Thu, 5 Feb 2026 05:46:03 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257b6pp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 05:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXZIlzJ6cFpnRJb6r9ILiz8llKdhJzFQeODBKUjEEq9Oj9QXONLbpwWFpRyqxxlcWdB/9VACNX8htLblQgjHPPQWb3GS5b6QNmSjPL6E9IJ31TRkmil11isjEWAGIqaykYKmlT793PV4k9HK/FFjR6jFvSPwQyx5oXlYFMSy+Bg+X5pzm1GTPfUbf2X/feVt/XHNgOFi3n6vBGOEuaixUMAI6hO3JaoF2QDqHX+W2m7mSxpQLtCxOlnJz4N82tmivvyYHDFtlheL6u+gPrHG/RKPHgxzq9BOmNvt3axEjuKJbFOM1yIk5J09a2rEVImdtRU+egvncD5kXJWScWGdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiQLekNeMJ4gddbysQ6/Jap0xf8x4UO/mvbIq+TjzbA=;
 b=mzkOfPGx570XNHf0587qH4bGFmjGlJhqM2MAH7QVLSAvTwrqPWFhKPxIKPDGvGLzzfMLptXsCR6cQRNnivzK9aNp9GReAX1GTczn820I3e6xGJL2o/qrG8nf3bOoRTC1obpXEfwGNQ0oL/wcIqDKFEcc0R9uR9nFLVZW8K6q2ISlFE69H1DrjAvtG1sBiIEkcIkDm7fhffCNN0VsFttkHYaWwh5fbc9xr3kdLyfdrRuYk1O2jy9iq8g3p2a1odSl70H219Ns8EFN56NhRtfqe58SWrjjYuoj2lSbbEK5vkJKR0uBQq9AWRTbBX67KvwDD9BBJuj6uJjQfxxwbie3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiQLekNeMJ4gddbysQ6/Jap0xf8x4UO/mvbIq+TjzbA=;
 b=A3/Hc+oTLFg6hNsi0j64+RXXd0d4ftYrmGYKLlTsSV/7hRwyssaDmLWcizp+lemUaNivdY2AWw7cL/q3syZmiiHP56Z6IBSkbwM7GSCTIO3lyn8bGBLTvg7atXJtndB+il2AFOvfBfLuhzl92OljE7lqH7x4MJxZRUzuiHx66RI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7206.namprd10.prod.outlook.com (2603:10b6:208:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 05:46:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 05:46:00 +0000
Date: Thu, 5 Feb 2026 14:45:51 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aYQuj6Ot-JS4tXvY@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
 <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
 <aYAmGc6lu973jRwu@linux.dev>
 <2638bd96-d8cc-4733-a4ce-efdf8f223183@arm.com>
 <51819ca5a15d8928caac720426cd1ce82e89b429@linux.dev>
 <05aec69b-8e73-49ac-aa89-47b371fb6269@arm.com>
 <aYOuCmjQ5lGm8Mup@linux.dev>
 <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4847c300-c7bb-4259-867c-4bbf4d760576@arm.com>
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
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd543b1-4f22-48e0-a8be-08de6479d757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhmkJ198dGBrRDsigN/BXy+6+IpHcjiFadUsiuUUgZZfSRYVG5u7YlxOJS6U?=
 =?us-ascii?Q?ENepjtOduShb8df6kDFRHFMAUZN+YK/MontA+ut+5r9lwDSZ9EDjAxXOr28/?=
 =?us-ascii?Q?VWVYCN73FFRK1bmN33n1PZMcsXFJe6/RjnlgR4AjAGAYsfFvWsWVkYwoWo1r?=
 =?us-ascii?Q?o41O1grfHqO1IeFTvFm9HN3jZDW+GVYXZOMr4ifgvrJc+/UBKw6tlvZdwKY7?=
 =?us-ascii?Q?dsnkoUXxx355w2iOnRyg42TIcnSryHqm5THVFcKbXOq889gaT92ClfQrlFNc?=
 =?us-ascii?Q?ZkRVkZvaVAfayKmyL6KxZYWrMP+FSESwlGsCYjJKOfA6L8/Uv0X/cV/hZPu6?=
 =?us-ascii?Q?QBzWBRrjKXImB/IW4dnrcx3l8Bw1M5o7YUGZo1Fv3ymWnDQQxmObEr7nu1ss?=
 =?us-ascii?Q?KgpMEKRWIjzxBTKYEVXGzzObMQXAXOS/yZ62UxW+pSZCqqepBOFPT/LN307L?=
 =?us-ascii?Q?FRj9hubg4XVA+YeONXqXJevi13e63qsOnCrSHM2PTzAnTTUSAMpDev4MO+K8?=
 =?us-ascii?Q?vaQF/qvhbwo2cWTZhSghXqOutfncK3zn2HyIfpuD022UP+nLsykExhG9eWrq?=
 =?us-ascii?Q?nV1yAZrHHJODgcmGQOZ3ITJuja+eYYRk2MqkH67QN63IEyq+pQmRqUchtKBM?=
 =?us-ascii?Q?Fy6hDc59HVjWhraTR6+9bhrsyhUB+mUUN/YGJEFh28BfdL/F3w8WGMow2rjN?=
 =?us-ascii?Q?lqS+p74sZ/FvaMcGAXrFSw9xoZyHyNZe/pIY3h6A0Jp8FCzQH3zV9P9tATtU?=
 =?us-ascii?Q?NRsu+zqxoJzVDDiVp7y+8n/lFSZURJO5fKMkOVSYMiFTLcEoYGw4jpzlwdZn?=
 =?us-ascii?Q?0RbMhPSsqaYPbPOvy60FiCXoago9fm4h0UKILkVKo6nnF0jnJuUbBfixpkxd?=
 =?us-ascii?Q?0wdmaKBfxtAbjGAkVIdbQPlUq5uIOtuUalmt2l6Jz87aSuUTpBKzhmCn1ZiU?=
 =?us-ascii?Q?u3+fMjhVaNdzgk5GdyXszhKv0F1T/CN2PhYPk0cNi8nmNfBVTHNJyZEPHkg2?=
 =?us-ascii?Q?Am3FgTNe/pnXMJNzvyZlSzjS/54xxqXx4r8EN5/qniPdCvqKvUIlh4Qmp/PK?=
 =?us-ascii?Q?Jqj7AQG0MC/rpOy7ZlGo3/MLUG7FA46XRGL+o4DoBG+eyGChN4p46BhzUlzc?=
 =?us-ascii?Q?cK7We29Yt/0EdmSr60eNwutnHMISVtVib9gxCNfCyFkcEsKJze8RuILZ3wS6?=
 =?us-ascii?Q?Xd1QFG2vv7mTNqZ+EK/Jjd0m/fZO7MR5a/hdICgGYMApiURp4sjN9Gipv66B?=
 =?us-ascii?Q?wwilpdKF6iVQK8necuP4egdfA6HbGTVDIKITMH2b3kbMIqKALXsuuDPffRn9?=
 =?us-ascii?Q?qhxpMpE/k5NhbmDwvb5YQbgpR0DEjZoL0gbVsTh0S8Bnpv9vLhgSKUBKy8Gm?=
 =?us-ascii?Q?o0fzmkekvdtcy3P0YtgsOZXJxrokYsMNPUpFM8mnO7JfN2EuxwV3XGH8AZ2o?=
 =?us-ascii?Q?hHOtbjCvzEUu5MBlntwaOzQT2rvcJlAWEGmGHJc57wBfGaBwnu/dbqSRiz0t?=
 =?us-ascii?Q?83VtSCqTux2QJDAndGF6HKDbAFS+hl/pnnde4wop5kGB0oBn5HX1ULtYP50l?=
 =?us-ascii?Q?esW719e8zX3ljTI1KkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xN+771EfBAE83LM/NhZnYOXENQ+1cm5WNeclNyG9uj0UbWCBwT2/PGYOPNmk?=
 =?us-ascii?Q?gHw0BRswAA1kayatCS91cjk0+bb8nQ7P1SRpC97oekjbdGncAuqWz4PIGLjV?=
 =?us-ascii?Q?EWOMBP9J03L2OcI7VL2qmiZpKYUTC/tkzk/WJmwQItuSArMVKzG81jT59vx4?=
 =?us-ascii?Q?5IdGh85Q1tyurQbBy7sQRKQccHofuvpWF2kKDudndZjoQrt3I9WcanebQ82X?=
 =?us-ascii?Q?Bd/wWL+kvd/qtZTzLClifybHiXiB3JT17CJBX9wpUqSKuDve7ruF6MXGE2/p?=
 =?us-ascii?Q?pNjX3zpoTNHy4WZbW3XJ1oLnaKZFmfIGNpm4Iw8q8LeyQX+7Lq6vaSCVI1/+?=
 =?us-ascii?Q?dCUBVfM8c6FdeU4tPgq9xRNEwoDs3r7Gvfwwt5RNa+pUErhlAPoEaZbp/8xa?=
 =?us-ascii?Q?lyZRRb14iMkH63BXCKO6JXJcOuofcAgZrR9S91Qc4Bb9LAvcT4EN1J5SzH6N?=
 =?us-ascii?Q?nwQrCxFNWn/fPXPBRj5kxMH6Rqona6eJe+jZH9SYVWDBtdA2HCjV1YcROy/i?=
 =?us-ascii?Q?5fs/9hsZ4gzfXF2o0rUXQeLIAmpqRWfwA5RjE9XntmjSCwOR6tVGq0h3p8co?=
 =?us-ascii?Q?RXPJ36xoPl6hwCl50lkvD4QO8EUs7g81vhNsSKmidH54PyN3adWZyyMAbe8d?=
 =?us-ascii?Q?08iG9xJYKXDc0e1g2zc3omx8Z5v/VtFRZb4hsiXzHAEhCC7eHgLaKeHejLlo?=
 =?us-ascii?Q?rEsUpaGm1SYnlIi+qPhNqCVFPxm/Qaa0Nml5/G1SmB71kx8jkKL5+syIu+R9?=
 =?us-ascii?Q?Oe/8qAsNv5ZLrIcByiUO7HP/zwCTERcFFJL3as0DH0+AJB86+Tw4ypxrCBe1?=
 =?us-ascii?Q?1t5QNtmYpzSKZZV836W2e3ZxQqOUe5UtJ06+7TNAV2J3Oxo+e9H2rVVTo3s1?=
 =?us-ascii?Q?bt0kY7v9nsCifYu9llwPV3wCiJKcn8cuO5aCeNof72OV57XY7c6+qaA3RUpp?=
 =?us-ascii?Q?gLuKTrWGJ4pnosnsQolpRBYfzlPOAvzdwrmMDTCromXGLCpJv/RZxYtX7Iou?=
 =?us-ascii?Q?Gtbc8XaNfOU8ajr+2iThYYFjNjAUqguneVX8fTUdfjDIEI3hKaNufj38kOZ6?=
 =?us-ascii?Q?JW0Vdo1SknNvey3LWqf4HPIWHNOJj1CJgUpNalKWjHs9i7XV6pyEo83qfjt1?=
 =?us-ascii?Q?LX3HfOQw+WnezKTzN11M40rfgw+Nmf9VVJ4Nn2I4CBuzChDnFB/4gzjO9FNm?=
 =?us-ascii?Q?U0P7j+ZQGa8shJRfgIfLn7KfGjA6Y9Wp9RDTH652sILdKP3kZqgdfw4Gr8DK?=
 =?us-ascii?Q?v7Vu7kN8m+K7eqTmdEcicBAK3XGQg4NT4R3TFGUTPTy1W6/ktCMlF6SLMA6v?=
 =?us-ascii?Q?yEQuPSoZVGLyah72iAKRFZDN/QnPLuVIHuCTpL7enypzicNUPWOCn0rLjdUt?=
 =?us-ascii?Q?+EN+FyCM7MEqxKyVGr33D+MuBcgnpw9r9xBk6eNUf6L44w//yzD1VUyBYXkb?=
 =?us-ascii?Q?ZA2gKPg6LbfJo2AEl70Wk3YbxCYyaK6deMoFksdHN/q6oJKA1LI3oomMjor2?=
 =?us-ascii?Q?2Rxhr+KyXoOUVpdPsuheDw77/VjMWHTOuE8dOokknb6JDkrXgQdrhBC3zlYM?=
 =?us-ascii?Q?n4ImdTsahgCHp/j9dc/XZf4OqVE6QnkYDUa1buxQY+reXY+bGcZlo9Z1/hr7?=
 =?us-ascii?Q?MFnyRwlfLCzRLfFn2/Y7zKNGpgfKVctvlbAV/VGtfQVYkR77E4ybu4btAK5Y?=
 =?us-ascii?Q?6gZNCbWbpzKFwcYXgJhy2OXoCxvzX43GS8KQt5FjLdIfKUpj/eZAAV/gziJJ?=
 =?us-ascii?Q?X4F1B7zA9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u8wPwocNfxWh7ySqQrEcZlh8W6/g5kDvhTuiMX5unJVgndgfLPH/wyE4Zv8kuX/WtmOhlTrcd3BLCfCu+DBEm/fVJGVaL/E4b0nGv1QN1OWRDmskZ7Ccgn4Ha8SeJls3shiY93/jTnu+LbQuxVePH/FAh0qlUhvaq8d7u6UiAaCCN3QjgVhvvMtiG0bPnRTBrsDWpBV1jP3+QdR+6BxruHJXzi3KytY9ZZtluv9v5Ee3oapb57EIP+AybL+4nN+RaT3QRivd4K8cXbQQ61HeleJbT33tN3IKISiqo6cy34H3zFcN/M74lokeUU1+bD5/UdTrtZHQhinu7HmAL2xZF9aURjt2kaAFpzepPdfTy0QZSDGn3QoChCFjUpoWnjr0W1Usszn3q5Bd2aEXCcifvhQnHRazKFlVjTI9n767ZGu5wBzVhu4J2rhI3Oh5oD6mBBrCGNBrE9cHFj1jxi0pl0n9coW2+oTPtayUO4QGAfw7Rh6aO+2izmQDG/1UaG3ftHX0rdZGJ9EhnMxf8rUMlC+aDQRJ64MhFony5amzBg2YEbnI41IbX71rNn2RdUDVBhsrNx7aCMd0yhXLJiUtE/Qzgj3rBIY87ggSc7zqfr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd543b1-4f22-48e0-a8be-08de6479d757
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 05:46:00.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4lFE/joCJsOKUDj0mWEpw5WpAMxqnwS0YPZ3ow3A+UpH4Cx978iuYaZMpNdgcj/r8QkVW5C1spVk/j/leCEiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_08,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=983 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050038
X-Authority-Analysis: v=2.4 cv=Jor8bc4C c=1 sm=1 tr=0 ts=69842e9c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7CQSdrXTAAAA:8 a=F5yyXiPcnDNIn9BfyIMA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: Abc6JTecUnwhTNUhazewHqCZOZcBgAAl
X-Proofpoint-GUID: Abc6JTecUnwhTNUhazewHqCZOZcBgAAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDAzOCBTYWx0ZWRfX8a9O0gkBNCiJ
 aq8sMiBynkNWzjKeofrwDcbdHCUM43HOhzN/8eMXrgHKAFcBJsjXKgCGjpNHVUCkAsXFDUiXPGs
 HEx+gIB3L/3hqWQs1YVUXeG2xh3vWAxsq4c6TYpDZ+Y/BRB9RrZlbznv0jD54q3G32lm78IuovQ
 Iz/whvVM3NgGKGRxbm8PAer+d+PurYk6cEFuFYYBf+DMTf2ysDeaHCo+Ao6cA57+9ijgp3UyTng
 dC8gCd31+bukAyWXpX/hV5pqtrMqK0P3dRa5vE9tBVzo5nP3Gt8sSILR6N5qcx3D15UdcGCd7Do
 XTKPo8wWemGnq+u7UxudiuUoZqqNQwp5XWJFPBDxFYnj/Xe3Nw3iVrwmjeRP/TU1jojItzj473t
 5tpZ6NFaE+nSlO+1p2PgIrDw+jkYogYjzGdE8lLq3yHKT3fGhYaq4HkSbdF+zIgysAGpipcG7rX
 EYZEi6AMv0sDF/5khXZHedpGHd9qjFmihhk3HsFg=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13681-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:url,oracle.onmicrosoft.com:dkim,linux.dev:email,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 59F46EECB6
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:50:06AM +0530, Dev Jain wrote:
> 
> On 05/02/26 2:08 am, Shakeel Butt wrote:
> > On Mon, Feb 02, 2026 at 02:23:54PM +0530, Dev Jain wrote:
> >> On 02/02/26 10:24 am, Shakeel Butt wrote:
> >>>>>> Hello Shakeel,
> >>>>>>
> >>>>>>  We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
> >>>>>>  the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
> >>>>>>  to munmap. Please see below if my understanding of this patch is correct.
> >>>>>>
> >>>>>  Thanks for the report. Are you seeing regression in just the benchmark
> >>>>>  or some real workload as well? Also how much regression are you seeing?
> >>>>>  I have a kernel rebot regression report [1] for this patch as well which
> >>>>>  says 2.6% regression and thus it was on the back-burner for now. I will
> >>>>>  take look at this again soon.
> >>>>>
> >>>> The munmap regression is ~24%. Haven't observed a regression in any other
> >>>> benchmark yet.
> >>> Please share the code/benchmark which shows such regression, also if you can
> >>> share the perf profile, that would be awesome.
> >> https://gitlab.arm.com/tooling/fastpath/-/blob/main/containers/microbench/micromm.c
> >> You can run this with
> >> ./micromm 0 munmap 10
> >>
> >> Don't have a perf profile, I measured the time taken by above command, with and
> >> without the patch.
> >>
> > Hi Dev, can you please try the following patch?
> >
> >
> > From 40155feca7e7bc846800ab8449735bdb03164d6d Mon Sep 17 00:00:00 2001
> > From: Shakeel Butt <shakeel.butt@linux.dev>
> > Date: Wed, 4 Feb 2026 08:46:08 -0800
> > Subject: [PATCH] vmstat: use preempt disable instead of try_cmpxchg
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---

[...snip...]

> 
> Thanks for looking into this.
> 
> But this doesn't solve it :( preempt_disable() contains a compiler barrier,
> probably that's why.

I think the reason why it doesn't solve the regression is because of how
arm64 implements this_cpu_add_8() and this_cpu_try_cmpxchg_8().

On arm64, IIUC both this_cpu_try_cmpxchg_8() and this_cpu_add_8() are
implemented using LL/SC instructions or LSE atomics (if supported).

See:
- this_cpu_add_8()
  -> __percpu_add_case_64
     (which is generated from PERCPU_OP)

- this_cpu_try_cmpxchg_8()
  -> __cpu_fallback_try_cmpxchg(..., this_cpu_cmpxchg_8)
  -> this_cpu_cmpxchg_8()
  -> cmpxchg_relaxed()
  -> raw_cmpxchg_relaxed()
  -> arch_cmpxchg_relaxed()
  -> __cmpxchg_wrapper()
  -> __cmpxchg_case_64()
  -> __lse_ll_sc_body(_cmpxchg_case_64, ...)

> Also can you confirm whether my analysis of the regression was correct?
> Because if it was, then this diff looks wrong - AFAIU preempt_disable()
> won't stop an irq handler from interrupting the execution, so this
> will introduce a bug for code paths running in irq context.

I was worried about the correctness too, but this_cpu_add() is safe
against IRQs and so the stat will be _eventually_ consistent?

Ofc it's so confusing! Maybe I'm the one confused.

-- 
Cheers,
Harry / Hyeonggon

