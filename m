Return-Path: <cgroups+bounces-10766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE4ABDDC44
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 11:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87EF3500D14
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA231A068;
	Wed, 15 Oct 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZNYreFR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hsZQ2sXZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F14302CA2;
	Wed, 15 Oct 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520387; cv=fail; b=hkfZQMFgWK1lXjb5frnljI05e6DNxYKCt2H+nbZ5qmuLFyBtCHSFRM/npV9LDrrWF9vJ3RoycWWKEkm9Exlj5dqUS7b3iGZQdKGRT0v/r0fc5YPa0CiSJKXcO6IVDtHV5+m28Ghekq3iKnDPOEcJ5d9m8RdRnL1oP/Yf1n47OF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520387; c=relaxed/simple;
	bh=4oxf2O6cED6DGBdss+Lc0fvDuPo60bb8Eya/F8I744A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQsyWLfZSDMeZOCYGrCo88LIMnoV2FB+e1ntfDrA+Df2bo1Na/NxiiF8TWOLNwOWit/tpJvTogl1EVKKaUSgAWZ/SWNXJRd7yKocxJBlFb6BOH9KfE5JDdVS/Ij8GNiNBUiHfCrpXXEqHjhXkg3qSZbyoBimteLsITKwOEiMInU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZNYreFR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hsZQ2sXZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F4uGGO025733;
	Wed, 15 Oct 2025 09:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ysKiRlVXrdRtoNwT8KjASOMtef5N7MDAJbXZf4nnZto=; b=
	BZNYreFRfr6Oj1Ov8pyVAFa28mdutx/f26zObstGGBWPEiqeDW7yS1j9/p+vbJh5
	2BdF+OhdYXb8ELyFH0NCyB+iWTNa3ud7zlXZltg0z1MMuVx8oVkuT4g6tP3vm8qf
	TKCz+9z7GG+grDGX909yPLSpv5x635mTzZ/cnLWU8lKFmPYYYuWVNty/04vKiS2s
	nU3YfOmDGbGIatyaF/bU0/o6PFFlhtr+BHD7XRoQuO/XQgB0sv1oUOuVKm6sN5aE
	4l/KIIKu1bldD0UvSP0/Pf/vcnOp8LmTKOkfiVt3DMQhdrpWO/ZthRhn/RjL9PqD
	7zjLpY7qXpCbY5xQBl2hoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc6867-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:26:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F7Xo1d037964;
	Wed, 15 Oct 2025 09:26:02 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpg4h4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnUWWVwQLZzCuegrz14U4tVeXh9IVh2r51G3FyofQBxAhEFffaNd7XVYx4XmjGFVTgFmWC3eZYLptL1zBoWEiUGqfUS4H8Wt8NT8AptIIf5GGJ8uQrk9dOLbaT/OI0EqqyO4SRpr4miPDC2/HsbXS5rLeCZ6/31WoKNQ9okM3NIXLVc70oMmYWCoVa99Oor9Fz5I6QLSM7hAqxg/GqPGlhxCOkZ0Jmfj2hnTru7wHxsgv4sKeoIZBe3bvpykGEXHFcUexw85/ijhQL+mrG0YoBirSlb+McWcv4++yCpm52TsdDlqkZyskpt2UIePg2EYzeyEIeKu4jTyOyXMD8VcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysKiRlVXrdRtoNwT8KjASOMtef5N7MDAJbXZf4nnZto=;
 b=Oq9eqarTecweGEfofpxdaCyrPsderOr+qNssaT7wGr3xElnpFRHDOMW7e6lWNTyX4yVHCNqpmJq9uf0xFIJwqg5xcUKIjlz3lLYhqHfKtuQaW5a0PMtChrU2jJPbCIVz5vIyuoC9rgHbEn3wNHtBoTRAA9XDEIJHCu80qhi88LvZSEuO3v1BgHs971J1Apo4EgmcTaleHIsG2zVPeVbfoK5neC7/lKtF0R9Cyud8xYRDKceiuDfZLGb2tKYpEZjsDo9h1DwSbyKHyJokrVRZHpr7DkPfmKfQFSXEOZ9JXexIf3VTXESnnLfL1Eajl0xx1Fr5mcnfCh1JylNAN05OaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysKiRlVXrdRtoNwT8KjASOMtef5N7MDAJbXZf4nnZto=;
 b=hsZQ2sXZ2s3oMfoEwiZhoNXgdmOPEWqEB/un61EDkPAkk/qNRpLfwSijmrAomQRaOED3lkkeeTBtTDVfWgv6gOl/9RkANCC0OCa5jJcoso8cvMBOdPFvoYuQ6ZHrlhs6m0Iyq2fIgQKvvU2xUFzP/83z56pluGdUAn1YD7Hkkeg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Wed, 15 Oct
 2025 09:25:47 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:25:47 +0000
Date: Wed, 15 Oct 2025 18:25:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Message-ID: <aO9okBEZiA4pCNku@hyeyoo>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::6)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab8508c-02c7-4cff-1ab4-08de0bccd2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHJKeUowMGx3cWNtc0NTZmtCOWJzVHkxOXFINTVOYkxTZVNEM3FPS1JHSEg4?=
 =?utf-8?B?OGpvYllSZmJIcVdxMGplZXJXTURDbmwzUTBaWXlRSGloYTkyWGtUME9rVGRM?=
 =?utf-8?B?WElqcXN1RUpGSlRzOU5wVFdiSzd0OWJPbm8ram1Tayt3ck1LL21tVHJYMWpN?=
 =?utf-8?B?VCtQZjdiOUxOd2N0UXlHRzc4ZEdKbW55eUJXZ0dmdTNGcUdtS3ZSV3ZrcmZ0?=
 =?utf-8?B?NVZlaHljTklXQWtqY2JqM1Rlc3Q1L2MvYnJkNFA3VGN6T3BJY0dWYzZFR1dX?=
 =?utf-8?B?WnRza040WWhIVXRlVEdGMTVLbnJ2czdMMlBUbDZ1SWREM0JpclZjOTU2Mk5P?=
 =?utf-8?B?ZmFZM2cvdlFaN0d6WEc0YWpLL1hkbTUyYjlUditSbnpKekRVNjB5dTNPMjdZ?=
 =?utf-8?B?Q1ZOSGpCbHU0MkVlSDVYL0ZUcTNDVE8rTTRGSmZlQklnWXhNZGdsdFRiV1JP?=
 =?utf-8?B?VjkwQXpJZTdIQVRVY1RvQ2hWVTN4M2dwdXgveG0vQWc3bk1WNEpjMVgzUUsx?=
 =?utf-8?B?SGdmSEpmN2lwZi9zeHlRcjd1aytOYUl0aVJQRTBXSVg5VzZROW5vY2RSa29H?=
 =?utf-8?B?YURZcHk3TUc5VEJ5RGRLcUdFZU03U25XaHVSSi9tN1d0emwwMXFoSzZnSTJL?=
 =?utf-8?B?OGhnVVVBdkQxUmh2N1RiaVRLSW5kSnh3TTZNR2JWM3RWRUQ5cVBtZ0c3cTY4?=
 =?utf-8?B?TndTTTVBRmN4NjVxeGVqWUZNUUZ4aThsdFIyZ0xCWnk1Z0RTTnpxVHI3cTRw?=
 =?utf-8?B?ZkVULzV4RGVjK1dXRkNwK2hvejRXZlQyK1F6REFaSGZvMllGWW9SSWxCT0pX?=
 =?utf-8?B?Tlk2b3JBYlVvblgrc0IyU09ZUUU5cnA0R2VYVDNjVmxxZjZmZDBySjh1Szd2?=
 =?utf-8?B?MkRhUjBBRmhNU3U3dlBKdGpYb2ptWEpkQjcrWE56VWhpVVJFcU81RE9Nc3pk?=
 =?utf-8?B?K0VYdzlqYzFGYmlhSngvZzBRMjlmbGU0K3FTaXh6YS9KbnRzZlNqNkxsL3ZO?=
 =?utf-8?B?andWV0NZUkQyaTJudVlkYWNSTWRwZ2g4cEluQXpyNHQ1bG1EMmdLcEh6a2xn?=
 =?utf-8?B?QVpUeDQycklkd3l5VG5Pd080aFgyWThYRFVkMHZtVkJ4bGhqUnBVY3BqNjVm?=
 =?utf-8?B?YkQwY05tclRVcE5MMUp5alQzTlM3SW44MnlrYjVvNGNWZzExMGNkMUdwMndB?=
 =?utf-8?B?THpOY2JVekdRNHhnWjFmU3l5UUVNRTh2RFhWVkYxY2tVOTNnK2d1U1Q3K2Ft?=
 =?utf-8?B?NERMYjZvZmE3dk9aQ05meHZEa3MzZzlMcHFvL2h5di9zMmdsR0ZOUW9qd3Vz?=
 =?utf-8?B?ZkNUNGVZdFArb085SmhnRHdycTFDNDlrQmFlcEZYdVBzdjhiQ0dxL3RHU1JP?=
 =?utf-8?B?UEErWUVoQlRGWHpKWS9hUlRBc01HRzQ1YzdQTGQ3S09OSHhISitDa3dMeURv?=
 =?utf-8?B?VFRkcXBqb1ZJeDVvbzQyK2ZlTFpzc3BCK01ENDNBVjBaU3htdEpadHE0c2g4?=
 =?utf-8?B?bUQyd3ZxRktXWWs5VlBUWjJ0dFZPdUVZTVYzdFB4bmtqaGt1b0lZTUtXT2c0?=
 =?utf-8?B?d2U0dEI1QUZzc1gwcmZYS0pEV0gwWWEzd282UTRndmprbUQ3ekxyazdnUnJE?=
 =?utf-8?B?NXJ0R21MMXYwQjcxRy9KOFdGWFFKaklPN0NCU0RwTVM2WmhZYWlrWVhLeU9s?=
 =?utf-8?B?R2tLUzVML1BmOVdnd3VBUmxwZWZYTENiNkREU24yQXJzUTlSeC9ZeFFFU1RU?=
 =?utf-8?B?dFFhVThkSVlqV0ZvaldLY3QxZjJKYXA3Z0lCNTVBY1hLNDhEQUlMNnN5eGdE?=
 =?utf-8?B?TU52UGIra3FOSkxtNmU4bndUbEFkZEtvTVR0OGNVODhTZWNaL2tVY2ZSY1FD?=
 =?utf-8?B?WU5lMi9mT0Q0SmNhL01lV0tVVm0vZE1OUjIva1l3SmhVRnVNOWZMTzhXOXF5?=
 =?utf-8?Q?E2999QNbpDNg71jy5Um2lF/OA/+raBMV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU5ZRktGY1I1TG9zc3VwYU9aWnlYSEdmWXl5NkFjQVNEdzVtQi92U3pBT2xY?=
 =?utf-8?B?ME1yaG1xcVZZQTRmK0VUdEoydTFsNnlWdktIbVBPaFJaUDlweUxudWJIeEtr?=
 =?utf-8?B?WjJjMkR0dWkxeXVJeGQzZUQ1MXRqKzliRG52RXgvdHJNTGY5WlhoS3VJWmJU?=
 =?utf-8?B?d1paYTZpd1plWHdFVy84dVE5WWc0ZDRiSVIralB6alNjWmlleWNmNkhoUHA4?=
 =?utf-8?B?SlIyMmloUURIU3hKNDhBM0NNMEl5cVozVTl1eXlLc1A3QUd0cUVqOFdXWmZZ?=
 =?utf-8?B?SGNxeDlPS2RpUU1QTUpXUUNCanRJRkpBSXR6b1QrejZEbXBFWVVIanM5aUFV?=
 =?utf-8?B?YXJROTE5czBVRzE2YklLWVhCZVFjR21uV01Kc1VWS3lpeWpkNnI5MCt4dVlD?=
 =?utf-8?B?bXZtMFcvRmQxSmpEVWN4UTE5bGhjVllLbzFWYUYwZnVxbmN1MUx6SmxxK1V0?=
 =?utf-8?B?S2VSTWRwUGtIbEdFQ0JORGUyZVRISXNoWlJqakR2TW9qRmdKWDl1U1hVM2ZL?=
 =?utf-8?B?Y3E0UTRubGhmdXVFck9nU1Q0aWR3Q0t1dVVFb3NGOWNOaU5waHdMM3NDeGto?=
 =?utf-8?B?RFNweitncks5UnlTKy81dkM1YWNMSlMyYzNNOWszT2tqZ1ZTRjdiK0hKK3Y3?=
 =?utf-8?B?eXYwMGdUdEU1Z0o5U3JnNFc2WEs3eVNzTUR6U3ZPZU16UENqc0NWYWtqUFNI?=
 =?utf-8?B?Z3VFUFhlS3FDMXlJUnFEWVU3bDdWRGdZc1I4VG8zMndDajZDektIQnE5Zjlw?=
 =?utf-8?B?UVZhZW43bDlBQUU0Vm4yTllYa2MzUmZCcHM3MkJzd0IrQUtGTXdhM2w0RFUy?=
 =?utf-8?B?dFZOajJPaVRaZm5kSXA2bnNwUkQyWWpLaVFXWHFrL0hiamRQbUxMR29FZG9U?=
 =?utf-8?B?Ym1aR3hmeVZhNUhKSFFtRkNUT1pkWVpRTE0vVVkvT0wrbXZ5SUFTQzh3T2Jv?=
 =?utf-8?B?S3k4MlR0eVV6cWlBYjZqNXZPN2cxUk9sSUVIZHFTMjZRcndJRGVRNUVZN2to?=
 =?utf-8?B?cFdCcGhXTndwT3dqN2pWUHRsODhWNS9JMzNMUTFPbllWUnd5dTlza2Q5UmdJ?=
 =?utf-8?B?dzJnc2ZqbUZDNklwbE9uR3Q0V3N2eFJCblVXWU5OK0hpU3NablQwaTNwUFVa?=
 =?utf-8?B?aDdNaW5JMlpoTnRkZy9wZGoxV0M4aE9iZ2lsM2xyOEgxa2xEOGkvbkE1K2Ni?=
 =?utf-8?B?UEhuTHhaK0FjbFhQL2tyL0lKZ1FOSkQ2cUhrY0VFWkQ0M01lK21qbGpQeUdr?=
 =?utf-8?B?d2MvK2ltT3lTTCttZlBDNGRhRmFWczM4Y3YyNnl1aENyQXlVKzJvVWhPcVhZ?=
 =?utf-8?B?Z0poWG9FZDJhYkVxdHBtQjhmVC9RcGtaRnYyV1l1U1ErUXNTVE80R2srS0s3?=
 =?utf-8?B?d01CZjlKVEdDUjMrbVU0Vi9KTERBOVZlR2R0SGtsSWVoMW4rbG1jYUY3SS9x?=
 =?utf-8?B?bURsV0w2SkZrd3YvSzJYRHVsYVpEeXQ0eVovTXpncG9pZG00cG1GWWp3VGNV?=
 =?utf-8?B?QTFZdGNkTTJXcmR5dUFQQ0t3ZU5keDhLYnRpNDVFT0VmUFp3d1ZhRDNUSDVZ?=
 =?utf-8?B?MzNkY1RtMkRldlZ3cEpGc1BKNEgwTnZ2QTBRV2FOaXBBNjYxZjgrYTNSeExH?=
 =?utf-8?B?SkVub2R4L1U5bTA4NC9DMEZVRGIwSnlDWGw3NytKUHlRQXBnUGg0b1M0dmhm?=
 =?utf-8?B?eHhDWE5QMDg1WnFRV1ZXcy9hQiszV2pRcjFTNUYxNXNuMVJML3ZoRzZqaGQ4?=
 =?utf-8?B?UkNRZnNoVWFDSkpYVmlEb200U1ltcCsyRjZJSzF1S2szVE1tbzBvNWREY1Fa?=
 =?utf-8?B?VFcvaTJEa1djaHRhV0hPY3BQajBzRkNnSVRBcEJLa015cGc2d0l3NVVIRHpY?=
 =?utf-8?B?Rk5aak5McENkczlNNFRkc2JoS1NMblJhSU5kK3R3bm5VeHNIV2ozaUVsOXdV?=
 =?utf-8?B?Z1hqUGxUZjQ0bSt1S3VQR2xjMEpGSDc2enRpRU10TThMZFB2MFlpVlVodElu?=
 =?utf-8?B?Qnk0TWV6L2h6QzdxS0xhaitxOE9CeFVRQ3pOQUZsRHRMWGJsaTNCQjQ5R1Z4?=
 =?utf-8?B?a3FhTVI5Wjk4WjdPMnRSd1hPMFBsMHk1VGhsOG9jaU1PU2NCekJRTVVSQjVY?=
 =?utf-8?Q?EAYbHchQq1x3VQTk4yzr6VIo9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cUuzm+LcVzPzEJgnv3ToHwgbXI9OdFzmBEX3bDosYEXeQ3R6vi6pzESSXupbX2WdCsXEfT3nn2S8u85OkLoSz7wMBvNQ0nNPn4y3onUzmZrr8DiTZjJ+CeOPGPbBu4dcEWxNHMK70Q+ErSQfgqa3SgIYP/Xxz3lJVdsp/ATaJv3ICzB0Up5mqbTaWDFJpN2K5gSOXIA00zQBV/8GSX0oBxkULg1gszLzWMhjkMWYI898jfxNOtxwsR13EyGHp8VnUlptVK591PtoEEnI+Y7V4ooLWg27mtb0+TCLTNtHuRyGVO9PUlT2F7kKLvTowciXbHWejp2+mbjS8Fqsr0TDkoygIWZyvdws4vfW1R8LAvavuuc/ge00eMbLPGNkQy3ftowM9Wc3LGx2jeTndNXlxKbyfbQs5rh56fZFoIFkhUyLU5MLe63UMqRovLM8LmbixcK2jXAPujQCC4DFRTDZLwM0NrlO01DQKyGtMR/sUfjMM3U5UzuQ3XV+wkgw1RLf/09AdakB8Rwj3DzDEqCQMaF/VqyHR5n2Js9xN/BFS9rssCflTZigYbSGndfW1j7ZIo0h2kv9YmdYZTUWnHcbH11c4zu2qTAbwpQy36xhhOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab8508c-02c7-4cff-1ab4-08de0bccd2c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:25:47.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoBwp+ZgY3aww7bUBfCgwtCZV8iYD8T/lEhvOTpUrCZi8oemJOhjAerOwOLbnk6GuQ9RMMx1io7v2lFnRF0lyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150072
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX8rH3lYpjsaDs
 TOycr+ZuEX+C3HDR1O7DcUrr0YmC1UJ+7h6RNgpja6nNjqhzYncInE5jNHgfSXhhBgeio2Xz8hw
 f9T4lxrTAtSOsZYeKgnuQWxQjTt0wILtdDaGYhNkOJGY+mqgI+PYjF3nOGVAM4nAVcXDI8xwyQA
 Wj5pZgskLt9DkL/e2n+Jjnc6U0e4CEe+uuWXQS7d2NuVtUUJsF2N//xXWX+28UhohBrn5hdmqAw
 gQZ+3iKDEOIzLsemGTtnXSM5ovbEdIfGWy0o+kFRpsgSVxBAwR5xEmpf1+C3b0KQYxpygURcUQO
 MHSv2FgmU85dJii94zy32ZWQoFyIbZgXIXbxSd980UK0vNyu8fvmA8xPs4+TNU8LhbO4xehkjhX
 uC8tfQACNlWePtDS07BMzQ3+OzRQGK0qxs0ts3SGGtYK9oyTv1A=
X-Proofpoint-GUID: 7mLuRsw_O6v_OHkl87ClFIpj2sPl4H3f
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ef68ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=6VGv8EMQlH95l0uu6vUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: 7mLuRsw_O6v_OHkl87ClFIpj2sPl4H3f

On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> > the same bit position, we cannot determine whether memcg_data still
> > points to the slabobj_ext vector simply by checking
> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
> >
> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> > and during the release of the associated folio, the BUG check is triggered
> > because it was mistakenly assumed that a valid folio->memcg_data
> > was not cleared before freeing the folio.

nit: yesterday I was confused that this is sanity checks in buddy complaining
folio->memcg_data not being cleared, but it's actually folio_memcg_kmem()
complaining that MEMCG_OBJEXTS_DATA flag is set on non-slab folios (in
free_pages_prepare(), if PageMemcgKmem(page) -> __memcg_kmem_uncharge_page()))
So the paragraph above should be updated?

And as a side question, we clear slab->obj_exts when freeing obj_ext array,
but don't clear OBJEXTS_ALLOC_FAIL when freeing a slab? That's not good.

> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
> >
> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> nit: I think it would be helpful if the changelog explained why we
> need the additional check. We can have the same bit set in two
> different situations:
> 1. object extension vector allocation failure;
> 2. memcg_data pointing to a valid mem_cgroup.
> To distinguish between them, we need to check not only the bit itself
> but also the rest of this field. If the rest is NULL, we have case 1,
> otherwise case 2.

Agreed.

In general LGTM,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

By the way, maybe it'd be nice to introduce a new helper function that
properly checks MEMCG_DATA_OBJEXTS flag.

> ~/slab (slab/for-next-fixes)> git grep -n MEMCG_DATA_OBJEXTS
> include/linux/memcontrol.h:337:	MEMCG_DATA_OBJEXTS = (1UL << 0),
> include/linux/memcontrol.h:344:#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
> include/linux/memcontrol.h:358:	 * MEMCG_DATA_OBJEXTS.

> include/linux/memcontrol.h:400:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
> include/linux/memcontrol.h:421:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);

these two,

> include/linux/memcontrol.h:492:	if (memcg_data & MEMCG_DATA_OBJEXTS)

this,

> include/linux/memcontrol.h:538:			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
> include/linux/memcontrol.h:1491: * if MEMCG_DATA_OBJEXTS is set.
> mm/kfence/core.c:624:				 MEMCG_DATA_OBJEXTS;

> mm/page_owner.c:513:	if (memcg_data & MEMCG_DATA_OBJEXTS)

this,

> mm/slab.h:541:	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
> mm/slab.h:543:	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
> mm/slub.c:2137:	new_exts |= MEMCG_DATA_OBJEXTS;
> tools/mm/show_page_info.py:55:        MEMCG_DATA_OBJEXTS = prog.constant("MEMCG_DATA_OBJEXTS").value_()

> tools/mm/show_page_info.py:59:        if memcg_data & MEMCG_DATA_OBJEXTS:

and this do not look good.

I mean technically they are fine since OBJEXTS_ALLOC_FAIL is set on
slabs only, but that's just a coincidence.

> > ---
> > v3: Simplify the solution, per Harry's suggestion in the v1 comments
> >     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/memcontrol.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 873e510d6f8d..7ed15f858dc4 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
> >  static inline bool folio_memcg_kmem(struct folio *folio)
> >  {
> >         VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
> > -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
> > +       VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
> > +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
> > +                       folio);
> >         return folio->memcg_data & MEMCG_DATA_KMEM;
> >  }
> >
> > --
> > 2.25.1

-- 
Cheers,
Harry / Hyeonggon

