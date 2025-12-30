Return-Path: <cgroups+bounces-12816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A2CE8B42
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 06:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFDA8301338A
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 05:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD807277017;
	Tue, 30 Dec 2025 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDb78grd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yCRnkutZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8271A55;
	Tue, 30 Dec 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767071512; cv=fail; b=fv3m6uLahD9vMLpGx16eJzP14yKv5XZXkKXRplP90R2MAqQnDPXmeE2d7xL6Re0liYptql4Fk3/Kwg+K/opRrOgSlwWk5P6EhKMuTpjdxrimcNtrrEld4CW95kFlai1EJ5l677QzBQwyCO8TXFvwkxu2cIbCTQguAKHcsViOB28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767071512; c=relaxed/simple;
	bh=ypr3ajUrs8DoscCs0D81RSR0GZJcVJ9GIbsiFIsAO8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WFwg6TTw496Zios5XV8733lRzPTpPdRBMXd6PQli4uBRJw441mtfsS8kiuO7i3HeKDbT+UrwZnfW39jPaCK6GVWnAzmF1aI8sRqLGd9rH096KLLKkQrK91fX3MJaCX5RfYs0JedScX7EkO/OcZFpRl+M8CbKpfFS7duUGmxOBao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UDb78grd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yCRnkutZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU3U1o03711379;
	Tue, 30 Dec 2025 05:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pYjmbECiLNNHh63Zq5I1PGUBFasP2gks4+Fn681DSBA=; b=
	UDb78grdy4G2YmC6LMaE53nTHXNzskPaABjfGUMT2YnkrYpXFgIWbMpV5uyU6JVQ
	UkRC2e+TEA4x1Rh20HJVnUkgDPHIywn0Z/QlPKeMmCLhs88/kyFXjukzymwUqL+W
	GE7H05GoJAWozs0uG1RXSoNH84fvINPIbu9C3JF6zqcvYY96BOwf9QXRgtb8soDL
	PuOMPBEYAVMJmN5kjrTEsxTEp+jazzDa1PvKguLIWtiMCVeiYBAqZkfT1Ui+reqD
	c6XLTY7unV4U/h/0TAMKP4Yd0HIrv1Lg5+lqhh6KFI1YQeBkEnrrMlX65ZVS2B5q
	CGWFJURkmv1nzQRRn9GPXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7gaa83e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:00:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU4RdOw022820;
	Tue, 30 Dec 2025 05:00:52 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w7k0g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Dec 2025 05:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgLfoeEcdJdIi80nYwp27PPVS4E3JW+ee3GREq/NBxrAlRR07zvygaY96/iyTCM1ZtPt/p9X0zHhMj8X1Hlcg0oYTLSQs9vjdtefnYhiMdEtbtK0XHylSnZGbigLgUWqLHbNBmAGM6ZLVoN0UYxn6iKuZdWfPDothpcxkIuYxpJed7T3i1WMxHL514Td6QLXPh9n8ldK+eOGq1pB7hQ6m5ZEFxgMWYxxyZ6uNy8vfwN4LBBE6u80Z8ov7B7lEqu+wsKBTG+v9jN0r8PWeKekpTHtbY4CiMgl/YXXN/wtqPjZuKcgQIEXveCCqXF1otjBZ4lqkrZNMt8bgMGkjHiJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYjmbECiLNNHh63Zq5I1PGUBFasP2gks4+Fn681DSBA=;
 b=uODFQTYxC/22ZyLM2SYLe3l/8B9aON67MBElrt3hUVeHYfNbNt++2eQ8sD4qb9TLWHD0EB1jhzr1DiCX8gtG+yYL9Z1SNJYpaahYvi9nETDJCRc92I++2zN/5v5kL/W83c5NY5y7W09tAmcWwIyQfQ6sWvznw0voekEzdZ4+qU5prSc0RJjQ+xrFYK1OY3IHFJ+hADjok0i/lujlyo7Pe+sGJRU9UTc683SHld2YkSlm9jibvzfR7brSCs1SlUtCkussplRhJynO3Uhys9WMSA5/R5RI+5s4eG8NPEySAJwat8tUwq2V8K690xRZOJQKAP39BsOZw5VCXAm8wTF4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYjmbECiLNNHh63Zq5I1PGUBFasP2gks4+Fn681DSBA=;
 b=yCRnkutZhXRyjnKNWTmgbqxNu96H0Jyvx1K8dkWFj3a27E2F3FIVDNO/eLmWYixBSySJVb062lY2sZYnzfVZYlFqP8L2CGLGG0ixfi0dljmMJQEFpL3YUcSA7Ft25PEpxN45iTNb6URpymDDFfTj7D2JFwPIQs8mcB08igneX9k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CHAPR10MB997744.namprd10.prod.outlook.com (2603:10b6:610:2f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 05:00:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 05:00:46 +0000
Date: Tue, 30 Dec 2025 13:59:57 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH V4 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aVNcTVKmz9N6bOfF@hyeyoo>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-9-harry.yoo@oracle.com>
 <l2xww4mysued3fjc2jzzy6cjrq5guygsxesmfqrhv2laxigpaq@ghj7xitfq7fh>
 <aUuKgRlI60Hw3-Et@hyeyoo>
 <hofqvftaj7ofgdvzb56hvjgk7chxkb5gfsj3324e7wal72mjll@7m4s7adnk35j>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hofqvftaj7ofgdvzb56hvjgk7chxkb5gfsj3324e7wal72mjll@7m4s7adnk35j>
X-ClientProxiedBy: SEWP216CA0018.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CHAPR10MB997744:EE_
X-MS-Office365-Filtering-Correlation-Id: c48c0eda-4c93-4771-1883-08de47606425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFNzZ0VGZHo0cEhoMEJmZjRnZXI0NnlaL251cXFPVjM2WGUrcTc3RE93VGhz?=
 =?utf-8?B?K3ZvcWk0TjA0ZEk2N3MzUHljUTNsd0t5ZFJEdVBJWFE5aDgwTWVvMkY4L3N1?=
 =?utf-8?B?MzU0eENxRWRMeU85RlZqWFpaYXI4UDJTSjNOT3piRTBSK09UbjJvNVhKQkpZ?=
 =?utf-8?B?dGtLbHdwZzFBVi93SDFWZDFSVTYzR1JteDFSS1pZaDd2aWJSQ2NTVHJFKytF?=
 =?utf-8?B?RmN1L0NLb3ViMmh2Q25CSUUwdGY4VGZySmRIK1hhZWY2V3BsWXJUZGFTcnBI?=
 =?utf-8?B?RGZJNDZxazd4MWo4N0Z3SWtyQnZXYzRmRnN3dVRxYU1ENHIyNlZaWWxBaGVK?=
 =?utf-8?B?aVpVc2ZHNHlWNGtBbVRHR0lwUGJ6WFNxQ2x4MnRRK2F0OEcrak50Mk5OM2lB?=
 =?utf-8?B?eFRHeWg1Yk1KRFZ5K3dHTGJNOUtrRG40YUQxU2Q1c1EzZTRibXdOamltRGFr?=
 =?utf-8?B?T2QxeXBVTlhuRlNCZ1NtcWZFY01TaWwrWUNJT2x2ZDlLRElDNitnb1NDUHhF?=
 =?utf-8?B?WHVadWZqbzlxQi9XYWFxTnFnNWQ1M1NBVlFFR2FPd242SFlBNzVpY2EzVkpQ?=
 =?utf-8?B?RzdrNHBpVkVZYTRsRnV0akJremd3bUpUNWowRGxyQWxZaU83SzdROEo2NHNO?=
 =?utf-8?B?RG9iNENnVjFvM1MvZG5DNkVNeENXWER2eDRzbGE2a0wzZmtBMWgrdENrU04w?=
 =?utf-8?B?YzBIUTZacW9YN25CeTZpZExlYko1Rk9QWDlBSVRHVWlEbHU0ODZURWQ1YlM3?=
 =?utf-8?B?a1lhQlFPVWdydmZkZ1JlZWRQWmhJREgwV1JORjVFTHFrMjZ4Y1RkZXJaWVN5?=
 =?utf-8?B?c2lGRjVPZkpIbCtkREw5V3RrcG1rR21SU29iRjc2NDZEVm9BVlQzZTZCdGp0?=
 =?utf-8?B?NW9BOEdESzNhaUFzVUZqQkh2NmZMVnJ2Rk1TdlhUTlhVaTl5Vk1CYjJQNDRs?=
 =?utf-8?B?dGJ3VUtpMTM3V2d5UTdSNS9aVi9NUXp1MTBkc2E0ajl6RGtXK1BFaWxldzcr?=
 =?utf-8?B?R01ZMkorRjVjcXBVMVN6UVJCSHA0Y0xsN2NmRFo2Umk2U25ta0J4UlZlanF4?=
 =?utf-8?B?SE5VRXA5U3ZWbWwyOVdwcE5SempGTlpjZ1QveFkxM3ErTXJLTnczYzhLblZV?=
 =?utf-8?B?ZzNVa0FxSjI1SG5MWFNoQlZyQzN3RS9Ld3VuclQ5WFdpcmRGVElWME1pcVd2?=
 =?utf-8?B?dnlzRUFzclFqT25rMkM5ZEhEZlVPQVc2Q3FlZG5Jc0tnYWFlVlF1cDJIRm9F?=
 =?utf-8?B?YW9jQ1VrYURLNXl1UGh6REZMVTBHK3Q4Rk50RkwzTHZ2S1d2QU1WTXErSjVN?=
 =?utf-8?B?L2xMb1FmQlJFUVVrWjFRcnlxUTJ6aENINU01TVROS3RXQzZTZnJHM282cjBj?=
 =?utf-8?B?Qkp3aHRMRDlyaVFtakhDcGIwNEZOaGoxQ1REekdsQUdmck82ZUpEeUtTOXVq?=
 =?utf-8?B?UWNzQ1Q0TlVyck51NE1CVTNSa3ZjMHdwK21JbE92OEwrWVl2a09DVUpCOGRr?=
 =?utf-8?B?MXMycW1qZWJTd2JuVndnazFXL3A2L2czWEt2YU1yR2tZc3Vab0ZiNHRwUENF?=
 =?utf-8?B?TmhFcTBEWFVDUHpWVTFoR3pRK2ZYMHdvR1VGUmg5b2dCeVdrV2pqcGozMmdl?=
 =?utf-8?B?aXdNd04zNDRIRGkwZm9pWTQrNzRKcUR5QnZoWFFVUzJWQTFzYURGL0xkQk5j?=
 =?utf-8?B?Q2s3OThQMERiSUtDVS9IUmx3eUx4OUhHQmxIRVlsRG1Lc29zWVlOb0o1OUZv?=
 =?utf-8?B?NXNOblVIdnNXN1RlWE9VZFRNNW1lU25pL0x2YUx6S0xPL2I2TmxRQ2Q0ejBs?=
 =?utf-8?B?NExrWmQvWEdjeitnMmFtMGxjNm9wUFlaQ3VkVmRObHRGQWkvckhMcnpRa0R2?=
 =?utf-8?B?MWYvSzdyZ0x5SHk5RVdOTHJmUXcyYk1DTWVhMUVDSE5zYTVxR3l0MnJkZDdS?=
 =?utf-8?Q?yo/XqHaJg3cjreq7D7MiIEA+5VBIrgfv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhGQjFmT0Y2b3o3RG4xZzByNUUxZ2VBVDBqSHpGTDZmZGZXWWJEUkVSNFFw?=
 =?utf-8?B?Yll1elRyY01RL09CVm1XZzA3N3pCenU0dmpSdVpDTnZaUW9EUi9zTFdDZi9T?=
 =?utf-8?B?VCtndlRBZCtDYWVkTHcvdlFyYitEaXdFZ3BWaW5MakdoNi9oNzBGYWIzV015?=
 =?utf-8?B?NW1jdFlycVlrb24vbG1tSzFrcncxa21lcitEbUt6a0cyWUY5SnhQQzU2Rldp?=
 =?utf-8?B?QkNlNy85UTFDUWNleHpRUm1Ncm0xSVowaWQ2R2VTTCtNZW1RYk56QjNTT3VW?=
 =?utf-8?B?czBXUUV0alduZVNVT3d0NzVxaDZxdHRVOVMzVWl5NnhTRzJjbW9GNHUwUzhV?=
 =?utf-8?B?L1l1NnlZY2M5djJIUkFNdDFPR3YramtvN01seWFYWFpzS0ZIbFhCTTR0Q3lC?=
 =?utf-8?B?a2c3QUdRMWdPMjhEd29xZkd5bGhNejcrS3lGaXltTCtxR2Q1NC9uMUtOZDRO?=
 =?utf-8?B?bUpUcy8zMEZONFpUdEh5cVJWZkxDWW4xWDB0Um45ZFZkLzRhc1RHeW1Kdk83?=
 =?utf-8?B?WXJaTSthc1k3UVdRTWZpbWtFanlyYk5MOEhPMWlwMkowQVJLTTArZndwa3Nj?=
 =?utf-8?B?dFNVeEpJZDhxOG5GU3VpdXZUcnF2U1Vjb2R5T2VpZmtZY1RxMmg2Z3JscTY4?=
 =?utf-8?B?U29QU0tBQk83cWlmdVJyYVlrSlo4MHZ4aE5aRWQwK0VEcXBJc0pMcjhtZ0FI?=
 =?utf-8?B?SzloZVVhS2FpdzFUZng5UUlpNDdrTTNCSHlHZ2dmZUdNTENKcllaTXJJcHUz?=
 =?utf-8?B?dGtNQUhtTnNhS3ArZ3g1TkhScU03M09KZ3JJcHYyeWYzMFJSc2VTV2ZiYkg4?=
 =?utf-8?B?aXdCdG5PQUF2WFZ4S0xESlpMMzdIbnpCRWF5d2dZK3J6aVBTc1ZmUnFwcmZK?=
 =?utf-8?B?bHcyZTd3MWV6OUlKUTYwek1ONmtNVnpPTDROTEROMEtoWGhkaVNXRlN2U0dT?=
 =?utf-8?B?NDNqQ1ZEY2htdjhyZmpxeFE2STlOS08rSUY1ZUcvUFliTzdES01zNmlMMWpR?=
 =?utf-8?B?d1o4VVJjeURadkdFNUNaZm1vY21rTWRyNytFSVM3aFVQZ0ZKTGpLeldRODlW?=
 =?utf-8?B?bTk2bzc1MDc4SCtQUTl3VzVwZy9vazlZSEpjeGpVd0tPaVkyR21Kalgvejhq?=
 =?utf-8?B?R1gvbi90MWZTRld1MnRiTlBvUlJ3L1R3Z3hnTmNkTDcwVkh2dDdHdVdIVE5z?=
 =?utf-8?B?b25mK2VKaVY4ZkozbFFnanZZeit0STFjZEZuRVY4U2FDSUtSNmMrd2ZSVloy?=
 =?utf-8?B?NFdmOUFhaU5DRlBoWmdWdWhqblNEZ1BHSExjdFRPSzdNRm51dHBJSkx5MXFZ?=
 =?utf-8?B?UlpidFdJMURMNzJ2alhBa1lEampEWDJBVE1FUXJab0VoUWNYUnFXQzczZTNq?=
 =?utf-8?B?UXdycXNBUkVSZFl4WGk4QUgyaFUrQit2dGMxTTNVZ0lSSXk3anZzelRPTU1H?=
 =?utf-8?B?Y3ZtbjB0bVpPQmFNbkZoZXBsemppOGFEVjl3Wnljck5IdkZWZjRpaXB3dTF2?=
 =?utf-8?B?UEhBK1lLSCsrTGsxY01LVlVWMUd5UFlDRFZRWEFHNXVVR3RnRzBXTVhpU1RO?=
 =?utf-8?B?aE13NDZWbjJWQTJyc09pLzAzY2ZRb3ExMlNLRFJWZDlFN01xcDU1dzNRc0Jq?=
 =?utf-8?B?VXYwS1RWeldiTGl4RnpBbE5wT2U0b1JzSlRYdTFPRU1GTUJOY1ZTMS9QckZi?=
 =?utf-8?B?a0ZUa2hQK3F4WDgvT1kwaWFFK21kbzZPVmkwSTRHWThzK3hEZzI2djc4OE5J?=
 =?utf-8?B?N3RmSjVXV3grNG9majBCWllFM3hhTjFrSFpkTkdLNkZtN2R3NmhXU2dkOVIv?=
 =?utf-8?B?VlVpSTNVQVQyQitBVi9va2xpZk1DekR2WC9hdVZ5SHNEQzJHcTFDbkRnQlN6?=
 =?utf-8?B?SXU5bTdVT0tnYlRnSjc3ckk3NmxlQ2E4ZTRuWE11NmpjUkRMdVJwU0NNSk9a?=
 =?utf-8?B?L21DNFJ0VzN0KzZrdGFkZlUxR081N1ArRStWN1VacFRKWCsxSHZzMEdCckdl?=
 =?utf-8?B?dzJucmZNNlVoQTkxOE90T3dBY2Fpb2hMdUxuOHdwOU9qS24yYUNJUk5XOXQr?=
 =?utf-8?B?WkQzeGJUQXBlRU1qV0RpZHFPQ3lnakJFd00yNWJYK24vUllGVzJJNUxvbGxt?=
 =?utf-8?B?YVUrZE5TNGVzZnJQcFNXbzhFd2xwSjhxVko2aUpVM1poL2xwSU9jVFZXN0tN?=
 =?utf-8?B?VUE5SklJbmQyMFA5Nk9GdjhMQ0hoN3U3ZHlrT1VkR3dPSFprNmt1Z0dNNmI3?=
 =?utf-8?B?SEwxTXY0Q1VtQUYwcm15UllsY21vdURKMVdtb0tpOStPaHc4TDhHeVdScisr?=
 =?utf-8?B?ZWcrY0NJSE1hNUJRUUF4bm1xa0k0YSs5dWtpQksvOWUyenlqb01YUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vvg0aYpi7yi+Ng4bfwwNhlNMzf/qiEpO2NGzA0eDyA4INqCHHjjABM9LHbQXeRaNJtaYt22ftNB6pMDMuVAAjfcwov9e5qkFqpzuhjj/h5fNpa2zl+mC6nRvz+KYPYZ+WIte/eDKKCmAfyiIb4FwbXPEUcwpQSqZ9ojiobLdQfzIo65osxqqTN1Mg7U24eGbS9ubkuBkn9xVZN8tQCSwUtXzqkNBXlbdu10tihvg08NAh0NlAoqhLRQn4RQXSrJuFPzqGSHXAITictsAvktfcgFlrxtKkXBspSL6nR9sb72928ZaUy/vlyRd6W9RhWN59vZzAXuJO6wUlVoa1Wtet4QXpYuJcZdt+vdCIT9HvyGC0ddVq38ky4o36MXw5FUS2smrB9ii6w9aS5YY7tQtnOPvMWUSH/JOkH6Y2WeptPHs+J6Qesg6NgkaMfFlU3n2/TX8dntmYlOZyYK2qaQj9bFciOwsX6Bv4G/ZJ/Dt7GXGC4+y/p1lEcsA3bqSsF5Idn1P9jeKJCuOluQ7rVlgxTFFB7acgShl3kBE7k0KLewZH1x8qjHViUl+vE+8LoAS7NkpuIq3BX/KtL/8tgryD8ULBsQ7DQ2wXMgJPVNOwRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48c0eda-4c93-4771-1883-08de47606425
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 05:00:45.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TWrMqgQM/2FUeLpEEFdeLtTWQMWJLm+MkhRi3ag7yA6Mp3puirrt20Kt709e6h2HkJFqjE6LWF+Rta7iOA5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512300043
X-Proofpoint-ORIG-GUID: hM-4YqH1IhRoxsLjU29aJ7MdNagRpRMX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA0NCBTYWx0ZWRfXwQmsf91d11bV
 YVezuRbybMLz8qd0V+0IH7oJuv/dllMdgw7Q09w2g0i2eVRDoaeL2BMJMGBTFAtM9aQXE4zLKL0
 M5BKDDrReEXOIiq/P+YbkVmy2MLWxBCU4XQpRM+PuOuJ7G3TPOxnf7ZJVMLXdLbdthRSYolS8lZ
 rLa57RBa6Yd/9zAfP+lo4O1iwJ3oVHprDPPgzR23thH4v/7D9PfLXffrgNT9ENMgqLCqT85JgHe
 42e6cre+BZtCuMUYREQxnFlMoQIHLaTWEkSPTKDx3MJilCkA7CKs9ms8eqOpNL065pHV52pJDgJ
 NDioQ4666v+1Nfqz4ZAiEAGHEnvbH3xcS8LFjE9d39KRDsqF5U+N9he7uamQI4pYFPTMzvTFQs5
 +2Q7WcjQX9QokAWYBw2tGehb8G/sIOzuxNKz4pFd4PGt1Jn58ivvziP9FYHS1RCQOzU5K16IPi0
 REt4O7B7QungbGRjf4A==
X-Authority-Analysis: v=2.4 cv=T9eBjvKQ c=1 sm=1 tr=0 ts=69535c85 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20atYnUvAV8noYTfkoIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hM-4YqH1IhRoxsLjU29aJ7MdNagRpRMX

On Wed, Dec 24, 2025 at 08:43:17PM +0800, Hao Li wrote:
> On Wed, Dec 24, 2025 at 03:38:57PM +0900, Harry Yoo wrote:
> > On Wed, Dec 24, 2025 at 01:33:59PM +0800, Hao Li wrote:
> > > One more thought: in calculate_sizes() we add some extra padding when
> > > SLAB_RED_ZONE is enabled:
> > > 
> > > if (flags & SLAB_RED_ZONE) {
> > > 	/*
> > > 	 * Add some empty padding so that we can catch
> > > 	 * overwrites from earlier objects rather than let
> > > 	 * tracking information or the free pointer be
> > > 	 * corrupted if a user writes before the start
> > > 	 * of the object.
> > > 	 */
> > > 	size += sizeof(void *);
> > > 	...
> > > }
> > > 
> > > 
> > > From what I understand, this additional padding ends up being placed
> > > after the KASAN allocation metadata.
> > 
> > Right.
> > 
> > > Since it’s only "extra" padding (i.e., it doesn’t seem strictly required
> > > for the layout), and your patch would reuse this area — together with
> > > the final padding introduced by `size = ALIGN(size, s->align);`
> > 
> > Very good point!
> > Nah, it wasn't intentional to reuse the extra padding.

Waaaait, now I'm looking into it again to write V5...

It may reduce (or remove) the space for the final padding but not the
mandatory padding because the mandatory padding is already included
in the size before `aligned_size = ALIGN(size, s->align)`

> > > for objext, it seems like this padding may no longer provide much benefit.
> > > Do you think it would make sense to remove this extra padding
> > > altogether?
> > 
> > I think when debugging flags are enabled it'd still be useful to have,
> 
> Absolutely — I’m with you on this.
> 
> After thinking about it again, I agree it’s better to keep it.
> 
> Without that mandatory extra word, we could end up with "no trailing
> padding at all" in cases where ALIGN(size, s->align) doesn’t actually
> add any bytes.
> 
> > I'll try to keep the padding area after obj_ext (so that overwrites from
> > the previous object won't overwrite the metadata).
> 
> Agree — we should make sure there is at least sizeof(void *) of extra
> space after obj_exts when SLAB_RED_ZONE is enabled, so POISON_INUSE has
> somewhere to go.

I think V4 of the patchset is already doing that, no?

The mandatory padding exists after obj_ext if SLAB_RED_ZONE is enabled
and the final padding may or may not exist. check_pad_bytes() already knows
that the padding(s) exist after obj_ext.

By the way, thanks for fixing the comment once again,
it's easier to think about the layout now.

-- 
Cheers,
Harry / Hyeonggon

