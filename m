Return-Path: <cgroups+bounces-7592-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742B7A8B51A
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 11:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C658167BAC
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796E235361;
	Wed, 16 Apr 2025 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G9LWetKh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iul2gkoj"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3C13AF2;
	Wed, 16 Apr 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795184; cv=fail; b=IEQNMkCm11AlMu6kzs0NU1uu9sBTUNtAuzQVwJstR35wNR5pWHIM1Nr5B2afOdmdgnOq2nnUoh49+/COoLN3sc0eLlWzmvdsXBoz5+GS3l1uahFWbvmQRCzgDIyUvN3pQsILhRNlx1/uSagy5CaZIf+JcgZWW+pnYFwxTmz2uCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795184; c=relaxed/simple;
	bh=YTQCkqtBTjSr5PiF2TYsm8VoycqvjmgQCZuzI4bbPJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sVfRBbr8moj3zUmmwZ6rwFoO4A8iuDA6bewtu8Q/47UqgEQvtc23IqZB2NjARVxIiHKtrATcRIw0l+Iu29lW5nsbag7Cx30iNstx75wnT9cz2YTXnf3WUw2/tZJ4DiLOlgwIIamvO/8Mfk+6rDYCdY+ElhCm/ZIp6piSx5j0XeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G9LWetKh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iul2gkoj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8N3jx012824;
	Wed, 16 Apr 2025 09:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=D/JJqQz16fGVAMbVPhNFYwKBM3oiAaAWFwiRVbU8tRs=; b=
	G9LWetKha6uiLOo26ugxghrYz56uTjWZBcjVVt/N4MXbbAraZewgYMOyTU4EDyK7
	rOQPx+POI7X8/af/EOr0E03YQqjO3WxqTWBt+j8IgZZNWKIVnI6wiV9H7H/GXSa4
	/zMsxYfmJjcUcYu4n/2zP4nZiXr1LQpNADOx2mbY5p/9MDLy1WsnJNCkQ7UcTbeK
	AM+dEJNA5N5IKkNxrapCuoAkRSwAEQ64F6WmY1UU0tCdGTl1zZ0jisI6iugWfHak
	fSYdrT9zGdQJOf8K26kNmA3oGsglDgEf54yHzHGyFNVJjYr6itfXTAHOO0AusLZ3
	V5zWulnpPmyZ88sJZSPw+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd3grp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:19:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8Lq7Q038819;
	Wed, 16 Apr 2025 09:19:31 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d4sm821-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt64WJcXcqauLTyvmAwzTntghV+Kn1u6eQ+s2yzH+03XQzEDExy5AnTv5SZatFPQ47vGhPgOap8mlSXiqOBLFML25QQmh3FFR1JjEkYKbbj74y045e72w2I5HVsBCDiHFw/Zs5byhx/JRz/UhfG79uwKWz6f7Kl0PxpR8jCTXobnZhdc23qtqfIkzqtKI2jXGahkYBH7FNLQqZi5o2vU/g8L6EUkQquSVGu0VmfGtDgaXL6VYyb8/erj9aBLB6y64Y0M1EKLseVNxjOT7Cv0/j8ZkWh23u9f4XTtBUn4NLOt0dNj4se/BknoqDt/N4GKD7bUWalNO/lXcpI/rby08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/JJqQz16fGVAMbVPhNFYwKBM3oiAaAWFwiRVbU8tRs=;
 b=kNQhT3lVc8G9IBQk8FoIx9I42KJdcbYtEsHSl6haleisMZnR+6YJEDowSdpqwa0PWz08wxOSSX/sp1WdDl/48VldD2vG6KrToBhTjgKqbRsCjIMiGygsCtYRQyUWicIkCViQcYfw7Q6Tf6eqKHt2LVln6ey/w36Ds1ArkTbUH9q1q6g7upTYRRZ6iT/Gqbl/EKJjoXjLI3TcyhASixK0UKJHhz7acwbyvQlmuR/mQqmjc1ukrHFbx14HxZozZDAoi6kwx7Km4VDUQgk2O3dw107VId1w/yTn1ji/Wi2zptYu4NepXtdkYcry82tA8sHXw7RKyC69n0jIg2d7JIk2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/JJqQz16fGVAMbVPhNFYwKBM3oiAaAWFwiRVbU8tRs=;
 b=Iul2gkojY5zAko+aGMS8qKpCCEb+7LuYPljvGe1Q6b+uyjmCa7nzSQy3WVWSiuULyNhOecJcg2ZX3uiaUdJ5a5q7C9m+DMG1+XM+Ba/CjeafAmesvbsTBVtdqJeJko1ONSYIy85fuXMx1imRrtaQGuXmc8u0hITuNZTdw3nCVEU=
Received: from PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17)
 by PH0PR10MB5730.namprd10.prod.outlook.com (2603:10b6:510:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 09:19:28 +0000
Received: from PH8PR10MB6387.namprd10.prod.outlook.com
 ([fe80::f218:31a2:a748:3c21]) by PH8PR10MB6387.namprd10.prod.outlook.com
 ([fe80::f218:31a2:a748:3c21%4]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 09:19:28 +0000
Message-ID: <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
Date: Wed, 16 Apr 2025 14:49:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
To: "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250415235308.424643-1-tjmercier@google.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20250415235308.424643-1-tjmercier@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To PH8PR10MB6387.namprd10.prod.outlook.com
 (2603:10b6:510:1c2::17)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6387:EE_|PH0PR10MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f56125-54d7-491a-225d-08dd7cc7c965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1E1NVdyQ3g5eXdFT1M0Z0NZWnZMODUxcGFtWkJQenMwOGdkOVI1clFkekRi?=
 =?utf-8?B?QVRoQnNxRy9iSXFlMDVCbTExY2dQcjE0d2VScUI2dk9hMjdhc1N0bTloZW1i?=
 =?utf-8?B?ZExXUjBWbjdpOVMyRDV3SVRrSjJRWDk5dkF4c3NqanRLMy9zTDFJUEtPcU5l?=
 =?utf-8?B?QzFhYlJURTA4L0JtVytPbmhLb1FZTzZhRFdUempkaCtTcnN6YmtWQVRaM0xJ?=
 =?utf-8?B?ck9tU0NXcnpBNzRZWmQ3bVhJdkxmOXA3d21vMnRXM1NZd1VqQ2I3U2ZuL2Zm?=
 =?utf-8?B?SDZMY0UzYkNtamJwWWZVbUZxRzhYdTlVN3pQeXF0WkZJQ2R2c3pYaHdIaXh0?=
 =?utf-8?B?cWpFdGZPTHZ5b1oyaUVkQ09LeG9yOUkrRlJ2NUhhN0RyUlRpMGhIbXpDRHQw?=
 =?utf-8?B?KzlUZXQwUVovclppajRkR0NVNmNubGRsb01lWlVRSlpTZUlXUVFyMXlyU3gz?=
 =?utf-8?B?NlI0b25JaC9CUXBrbTFUK3htV3I5WjAvUkM3UkVpS0pHZ2JSWFV2eXd6c0pv?=
 =?utf-8?B?bXdRa3hwemdnNDBOZzRiMmVIU2Y0MmhzWlU3QW9GRnNOQ2ZRWmVGSGljQW1t?=
 =?utf-8?B?VkowRG5JK29UWFcvaXJzNG9vaUFYa1hVNmFNZDVwUThiU213ODVwUXo1MEdZ?=
 =?utf-8?B?UFpxR0FCdFRPT1ROaEw0aC9LaURvbVFxc2VKOTd2aFdmdWZJZHY3SGVUb1dj?=
 =?utf-8?B?Q1dmdEVQRFdWU2FSWDRtclVBMys3UUFsRS9zTnlxVGlpNEZJWkRRb3prSk5L?=
 =?utf-8?B?MVhIY25oZzdSV3NaY2VGalVOU09DalpVZmtNYm9tdDRaODNiSHVZZ2d2anVB?=
 =?utf-8?B?NUJTRWlwSWFLeWJDRHg5UzB3aVA3NlVmNlhIc29JSkkzcjhUYlRCUkI3Ym9H?=
 =?utf-8?B?UTJaQnl3RGZvakFPUS9LNVlsSjFmVnBNdDlSS01zOEpwWGZ2aHFMaFZNYW1D?=
 =?utf-8?B?WC9IVis0SjNWY00xSFg3NVgxMWlrRGdLSmgrUGw0akxvRUR3Q0g0SWxCYzRX?=
 =?utf-8?B?MVRCR2cvNEJjTFlHVmVSbFNFdFJpUmpXTFZIazNvb1ZIQ3pDNHY0cjNvK0dm?=
 =?utf-8?B?VEpuZythVC9NOGlVNlpBczhDZUI5NnE2RTJiY0VXcmpvTFRRTkpSK3hrSUtq?=
 =?utf-8?B?c25NRHcrMnUzUWtySnpFVXg5Z0trNkVCWHErU2l2dEVGVDNQNkM0YjIzVWN0?=
 =?utf-8?B?UEpUaFZabDZvNFR0eFgwMUhTSDVIbU9OTW5VVUdlcUlHN0hObEh2ekh3OHJm?=
 =?utf-8?B?aGRZSDJ4dkNRT1pjc3lsaFMvWlNCNDEwV0RtOUZaUXZzdG9PNng0cEY4ajY1?=
 =?utf-8?B?SGZmaVlKYXRJTmJScFN4ckRiS25rYXgzQTJCcng4d0JtQkROYnc0K2cwRTYz?=
 =?utf-8?B?QVlma1l1Qjd4K0FuRXRXZnN3RVBwSUVEcjZRbUIwT25QcVlTb2trSndxdTcx?=
 =?utf-8?B?VVROb2FMUmRYczMzUlBvQlFEVTFXcmJqQmVGSmVYOUpnWjFiSXNQdkxlQ0Zz?=
 =?utf-8?B?L2FPY2xZb2o4YjA1RmFOMURiVjQ1UFkrT2JQQW01QVYwSTdMaysraFNvK1RF?=
 =?utf-8?B?SWpqT3dmak4ydkpSWnRmeDJtRGhuV3JZWERhcDdPYW9BNjhKdmxxeUtlNHFT?=
 =?utf-8?B?VjJjWVZlMHJZN2Vlc1lNUDltS21CVDlrbTRrOGw5OXJrUm4wSjhqN1Raem9X?=
 =?utf-8?B?NDU4NU8zaEdUWTliQmd6QXM5OVo2VlNRRTk1ejQvR21yZlRsYlNtY0R6OGdI?=
 =?utf-8?B?WWRlN2RIUld2VGU2TFRsTi9SbzFJbU9CQlp2RlNMUVpPUDMyMWJJQ2t0TVRi?=
 =?utf-8?B?QzBIN1F1ck9Vejl5YnB3ZDM1ME9hNmY0dC9Nc0JMVitjVU96MXdGb0ppOXhS?=
 =?utf-8?Q?0JJS0l8B6P0nu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6387.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlV3ek5YbVFWRytpVEZSUUluTTVEeUwvd25SMGozN2FDZ2lRUFJCSUFjT1Fm?=
 =?utf-8?B?S202bk9nbWc1U2FtTEJuMjYrY0pBWmllV1M4VWlxb1M1L0lGRVpVWmRHdDgw?=
 =?utf-8?B?TkpPVXV2SjQwUHdwYVdqRnNlNlZ4QVV1ZnhVOTAxb0lTWTJ1R3ZYWjdxQUwx?=
 =?utf-8?B?NXpSS3o1dXFmZU83YWx2QkdNM2o3Wk05aWZ3eThxZ3JSNkxTakZ1RHpIQTZM?=
 =?utf-8?B?cTJDRHFERlFYNjc1UVdGdlhFb1lib2NnY1cySDZHbkIwWE9GdnF4aWl1SE04?=
 =?utf-8?B?YlRHUGRjQU16V3N4V1ZBazhuTlRNcVMrakF3cU5PUGxReFQvOUdlTkdYNW1S?=
 =?utf-8?B?eGlzbnlxWTVCK3NwUUlyWW4vN0NPenNkVGVCVXpYU1dXU1dMTWlGWHkrNGwz?=
 =?utf-8?B?c0k4RG9pV2QxWHRWTmphSnlLSGN4enZKT3NXeHlPTkQvSTJjeWQ3djdIUTV4?=
 =?utf-8?B?QUVhOGtHSG81ZEJiWWdxamYzd3FFSmFrdjJKTVJLbkdnaGdobi9ET3VwUWZE?=
 =?utf-8?B?SHdaeE1xMjlQZWpQVlZTSnhid0FTUU52cTEyZzRaWVFUeUV2M1U2bUowRkF2?=
 =?utf-8?B?MnNoZWMzZ3MxKzNtVTFNUjJxcXBHZFlkbkdsK3RQQytJWlJ5TmgxL3podUY3?=
 =?utf-8?B?QTloK3RyaFNzL3g4ZzJQOWNERU9wRjE5RlRzRytGTFI3YnI5QmJkdWhYT1BM?=
 =?utf-8?B?ZVI3cTdQVldFc3VRUVdjZ2VscS9yeEVVTzV5ZmJoYnhiQTJXUjBWRVl2TXlx?=
 =?utf-8?B?NkNsd25VT1BRdERKZS9RS3A3anZMeitWMDRVazN5T2pKSnRaRnFkd3FLdTJQ?=
 =?utf-8?B?TElreFNTMU9xOTFySEliYkVNemlacSszSDZrdjBqNVBmdHZVd0xDWmRHWFlk?=
 =?utf-8?B?VTc0Z0kxVk05VEdob2xXaE9mVGYvcTZnYjhQVnMzZW44bUZUYmN5OXF5aXYw?=
 =?utf-8?B?UHJiWi9FMmo3UzNmTlVRZ1kyU01wcTVYdmdPUmcvZGh0Wng1bW5CNWQ0bVVV?=
 =?utf-8?B?Y2tqeDUwcGtwOE95Wnd0dlZKL0ZLNFNmTXMxY2sycXNGSWJHaDUyeXN3WGY5?=
 =?utf-8?B?cU9QQzJJQ252MUJEN09hVUhyeGRCNGFrekZXQ28vOWxON0lrb2ZaeDNLRk9O?=
 =?utf-8?B?eXl1SkFjTDczeDF2eHhxeWZoVVBvSXplcHBiTEVlWjJZeTExNnFtSVluUlpr?=
 =?utf-8?B?Q0EwY1B6aE16T3ZhQ2NFK1JxMFMwazlKRVowWDlNY0k2WitUUWpuYlkwbHNs?=
 =?utf-8?B?TjJpVDlSWlhIdUxSV2h3ZDd2SWhKeHJJMWhDYlJFd085UDBVeFJiQzJlWkow?=
 =?utf-8?B?SHdDekpHODJ0bHFwVFgwZDdyTkdRL0ppMmFuSkc5djhMRUtUY0c0SDVOQVJT?=
 =?utf-8?B?dFRSR0pGSnVzalRnUXN6eVpZcFBIb0h5LzhQZ3dDcUJrbW0wTFozQ1pvaXlK?=
 =?utf-8?B?d0Y4SENBU2xiMFZidnpaMmZ4emNXNGNVanNLOVVubnM2TUc3dDFGYkRWMzdh?=
 =?utf-8?B?NGlxaU82dTljeUFYbFFkMDd3WVFGUklXUkUyR0VMT0NHVnkwK2ZRODB2clFY?=
 =?utf-8?B?WVU3ZG8xZVpxZlVZMytlaWIxbVZKWUxMSTFLYmxzMHQ2ZUFRZllJbysvd1Ru?=
 =?utf-8?B?Rjh5WFBnWVVDMlovNjZleThtUmxtM0k2aENFa09sanE3eEx1R3RoUmdZbE9K?=
 =?utf-8?B?QU9SWjFuTkluVkdYWEJjNzB0ZmZrUGhlTWtvUjdCRFk0NnJqb05pMVRLU1pJ?=
 =?utf-8?B?bFFWTWQ4eGxpR3V3L0lWVFA1bkhqSUxDaXB6ZmwxMHBkR016dVd0aGh5RVN6?=
 =?utf-8?B?azZLZkZTdEFMNkcxQWZTUHFoTUM4MllCMWFnSFJXT096RHYyY2FpeGFaa2th?=
 =?utf-8?B?QmF1cjZsR2hncHRwUStPb1NsUzFGYXE0cXY5RUxSMkQxOC9LdExXZ0EySm5h?=
 =?utf-8?B?VG1icmtoblBFckF1UkZVQWJYcUhUVFRleExwK0dTdWRaNWtaSitLNTdsK005?=
 =?utf-8?B?Yy9aTlk3ZUt4QUpUZnVyN1o4UXV0RFJscjBnMjE4dnBQZ0lvZVR0YVh6WUJr?=
 =?utf-8?B?S2YxQk96bXV4S0lxS3hnVzlocmtKdnJ6bFd4RThscFRuRExON25NTGVoMzdP?=
 =?utf-8?B?SFhOUlF6OEVuS2MrV0M5dVNZN09pOU1SNDVPWHR1T2NBK1FTTkV4SmU3TmFX?=
 =?utf-8?B?dThmU1F0ZURRR1dXYXk0MTNpV1RYdktHMU41aWJvWVhoWnJadzNSbEZrZmNm?=
 =?utf-8?B?cUlSOStKNTlob25vZ0oxc2xNU1F3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xGvw0lTu5LvhmQBevIL7XP3NG6lccMibRNLHmj+8TkebkBKt6zE5/G42I6NV1+w0UScPyVQlBlBTrPamjrRNg+prZkduYL1FNzY+x6ZvUHyrn0j1vG2MHB0C+Pa09xsH2jSIaG0QBfjAMtQxfvYEWdcCgU/IBT3rLRKhBR3K97bjH1vljfYIjzzw6Z9LN5VRWqMEtlroem4m6Y6q1ahFI6oNvhR0nLZLx+pJx3ycjCZ7VXMvEshPq6Za8fW+rm0gLBFCyEgoXksE1aLAZZFZo/yWQGA5MWxeRT6Qb8ZO1pj9ZXKSRDwNda0ZUkuo3SJp5FTH58jiDJEI6o9RebhAf7rq+do6QAU736KsHRh7GEZEI/9T+cWwbAQ+Skf1qAFLRFIXOLeSnf/0dduEauVBhu4NteqdfU2QaHMfkQjN2ML3u7Fod2w81cBWDcOjadhgZ9WIEU2LbxeVUEJbcfv5fh3QEOuU+HwyDSx2GQLutRkhJzlb/vzsFT+Bc20VN/0LzCghCxE2GRIS7aF149xD2DEv6x65yQ/pwUy9MrMz9Ts/HbIhWaYjCCCk7/TBmLalmKHMGXqtE5E4kEl5OKIpWTactPsuYFYA5Cw704GyO94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f56125-54d7-491a-225d-08dd7cc7c965
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6387.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 09:19:27.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud7tAd+IJJ/8e0rM1PjJJZE1BKvodmEl1t/NWY8HkS1DAXq96hZgvT8L3YSPYaCANChIOv/1x8b774LxvIBLmzICgPWkbn6uAzwAth8F1qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160076
X-Proofpoint-ORIG-GUID: ygxp56PWKDv4kCzGx33WjLRRZmZFSeWZ
X-Proofpoint-GUID: ygxp56PWKDv4kCzGx33WjLRRZmZFSeWZ

Hi,

On 4/16/25 5:23 AM, T.J. Mercier wrote:
> Android has mounted the v1 cpuset controller using filesystem type
> "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
> behavior where the controller name is not added as a prefix for cgroupfs
> files. [2]
> 
> Later, a problem was discovered where cpu hotplug onlining did not
> affect the cpuset/cpus files, which Android carried an out-of-tree patch
> to address for a while. An attempt was made to upstream this patch, but
> the recommendation was to use the "cpuset_v2_mode" mount option
> instead. [3]
> 
> An effort was made to do so, but this fails with "cgroup: Unknown
> parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
> mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
> update the special cased cpuset_mount(), and only the cgroup (v1)
> filesystem type was updated.
> 
> Add parameter parsing to the cpuset filesystem type so that
> cpuset_v2_mode works like the cgroup filesystem type:
> 
> $ mkdir /dev/cpuset
> $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
> $ mount|grep cpuset
> none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode,release_agent=/sbin/cpuset_release_agent)
> 
> [1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d24fd7be96f8968aa4c80b669525b930d3
> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=2dac5d89a0f024a2d0cc46a80ba4ee13472f1681;l=192
> [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redhat.com/T/
> 
> Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 behavior in v1 cgroup")
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

The patch looks good to me, please feel free to add

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

One nit below:

> ---
>  kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 27f08aa17b56..cf30ff2e7d60 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type = {
>  };
>  
>  #ifdef CONFIG_CPUSETS_V1
> +enum cpuset_param {
> +	Opt_cpuset_v2_mode,
> +};
> +
> +const struct fs_parameter_spec cpuset_fs_parameters[] = {
> +	fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
> +	{}
> +};

A minor optimization you may want to convert the cpuset_fs_parameters into
a static const.

-- 
Cheers,
Kamalesh


