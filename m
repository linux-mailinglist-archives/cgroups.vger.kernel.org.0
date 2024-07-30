Return-Path: <cgroups+bounces-3995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861679414F4
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 16:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC586286EF3
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B1E1A255A;
	Tue, 30 Jul 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="itK2xybg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w3Vcogy7"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA218FC75;
	Tue, 30 Jul 2024 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351534; cv=fail; b=VfARRaeFfTawBgBxNJK2ewTdf+0Z4cGqSdt5NWSn2hkc1geoHG6iOG3KNJuBAjv3qNAHFX7OZm53krN31FzmnXsvAhi44pqyp4mY9hkb2N9yMBJ+irdr7vkFaYClVBCSz8i0utmEO7gZ6OjqGNZYjUfL4riJn/8VDTA68Svheak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351534; c=relaxed/simple;
	bh=ZMUxAcwHzClsI0PYo+HY3SG/N7PEBgV1BiOca3QNsS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IF+EQc8xC0BKbZ0z/BXo10M65/iSEH3uxlmZL5JT97wYsTFwK4Pgk5WZcTadPFtYaiUCjjAHt7CzjdwoEcpGleKK5BC7hE0oeOfjkrQ3z2fs1j2wWIDLyOrPoTpoKk6w+McX3DZoEFO8eEGHSVlxaisL/DRsAd4W/l+gntyNgQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=itK2xybg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w3Vcogy7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UCtURn012573;
	Tue, 30 Jul 2024 14:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=0P0hlBjxUUcwRCjgnQTA5Ekovq2e/L2eG/FmTbw32sk=; b=
	itK2xybgnsGwUBBTadnJ4D55YL6MaP2ya7rU8bojzDj4Uf3ZpPpnm0i90nmgimp8
	V2wkL509M/osXUCXWvPSHYHHn6VMfmAN0alwI0lXtZjnMJSpQnM02PZR8M5EIiK6
	utOM+kwY3d7JG8K8je4P+sMFHpEH+4s7PB+WaZMb31QrrxzB1Nox7fBHFCTW3qjV
	TXSYqg04eekLH2RC1/NC+oQKBdTMDyAwZwcUESOaI9NqCe2h++6G5phUTY97ToSf
	L6ERQpNtPEfMdZciawlFQaRRB3JBotqOkkVap8cSJwBS6gjeM3KlVf2h7Urk6JCV
	1v4YlzaAKu2XnxX44LIN5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxbwb1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 14:58:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46UEuGO1037961;
	Tue, 30 Jul 2024 14:58:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm83cfgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 14:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFejZA3cpMIY99RS8x5GmJV/LwsYKilzsPxd602yadVgaZBCtGKdD+Q5OA+BlMeXnuv4eUtyZnyvyFywCVwRIRiYneEj17ZmEW3DE/u2rCnGjBWvWyfMqR2/2q3Xsx9b5ZilSH01KuQMI8UIrVUmnPYBn6EyyiJFyAMPpl4jBybApkFw3QTF1yXvAimNudMr1hLZ9f2DLgw2wkxYuA5pLSBX+Gpf6g7MlqudAg+hWwP/QhKNAKb7h5aLyPWGALaumN6REGXJ9+Vn1qX9a5AGiS5cejGhDpB4JY9DjS1mdhcI0hD+CeNCbsawIXLfvypn00O+oFBexzLqWpPDwJ5m2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P0hlBjxUUcwRCjgnQTA5Ekovq2e/L2eG/FmTbw32sk=;
 b=IyzBVdAwoqCqHPigAkLzpcdU3Kh4G4ysHMF/l3pmL27Jd6p34kgw8AUACdayhZ3ySDLspPvNe561vgXUhimUoBooEK47y0xqWC3XoNnykxSpw5sjw47LAHCnWeuWzcU/R4CLgwXpuHdjvvoJcJ1cI1CHxHP55MlqtaH6GjomwL0/z3EXwKrmhfR16TZYyYo3q1uBaksXiizzA8JkSWnbWQNgC5c0VOqmmtqWhBqyBbfp4x+Cd09CPG/LN5kLB4jWq648LFquAggAIrXx+jRiGALXO0xy/q7jd6ODbUZ2zl1uHaj/q3LK+sZeE+S6nMgUU/u7CFUXY6j4+JxL+YYH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P0hlBjxUUcwRCjgnQTA5Ekovq2e/L2eG/FmTbw32sk=;
 b=w3Vcogy7CKtQ7TzaRdbvTGmfpieGkIhpSxR054hteKGxvGFx0zpsT8FPNDiHGXuvz06ZB4UUodYS864QqzMNliZmezYRn6QKMqtYALqse4sWLMlwlMCOvYAMRIrxzh9icfxXu/7frhFionEacf6ESOgEJ9bYSN82XDPZ8aVNkY0=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by SJ0PR10MB6328.namprd10.prod.outlook.com (2603:10b6:a03:44e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34; Tue, 30 Jul
 2024 14:58:22 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:58:22 +0000
Message-ID: <f480049b-cf65-4a39-a314-b6deecfa3883@oracle.com>
Date: Tue, 30 Jul 2024 20:28:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: fix panic caused by partcmd_update
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
        adityakali@google.com, sergeh@kernel.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730095126.2328303-1-chenridong@huawei.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240730095126.2328303-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|SJ0PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 19774165-4ec9-4439-4dd8-08dcb0a80e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGFkNFNoUHZoU1pOcjE5N0hjQzhYMVU1ZG1HUitBNmh6MEkyMGQ5cjFsOWNx?=
 =?utf-8?B?QVdoU3BUdGkvTFlUd3J4OUNRcGhzUkVUUzF6RWpka2srMDV6cWhFNDdaRWRs?=
 =?utf-8?B?Y2k5Q3psN0Fydm1KdmlrYXlmUVg4OEg5RTRxY0s0QTEvdURHZ1I0WUFLaEhi?=
 =?utf-8?B?QmNpQzQvV3RSaTlHWjRKMXRKS1B5REp5WnBLdWJybUdBOVQya0xIdWlQSWU5?=
 =?utf-8?B?dEhsMXE5Qjd4VFNCeCs1bkNzMXBhMk4rZmp5TVZKV3hHelRXVmRaNUZWYkVo?=
 =?utf-8?B?VFg4dXRONHNVSlUzRHRpUUJZS3Vja1FCeUxRZEpjTmJqQko5MXBGWEtON1JO?=
 =?utf-8?B?QlFWWEtlOXRMOTRZWG5sQTYxeTJ6b2FoblZzaTRvNFJ3TzNFRDEraUlNblZE?=
 =?utf-8?B?SUNXV2l4bWpxcEhmdU1naHhOZENOMTRVbm9RTFB2SWsrSUZNVnlyM0d3R0Z0?=
 =?utf-8?B?aUpuSXBRY3dWRXpxV2ZoV0ErSWVqSTZSbkVrSFl1RVZvRW1FUm5PL09xb2FC?=
 =?utf-8?B?Zi9qUXhFZDJiUlJDQzZqVlVWMTNTazJwY2xmODlnU2hpZ3ZvUVFFRG5ZY2h4?=
 =?utf-8?B?NGtYVTJrZm02MXk2VjFPdWdjUFZNaGNyMUg4Tm0zZVpvWWh5SlREbVhGbWZj?=
 =?utf-8?B?cmpVQmVydVdxZ1kwQzFjWlp0Um1WNCtMTzlUMnRCM29hUzd5OEJaRngwYkF0?=
 =?utf-8?B?ZzF6eWlQamdINm1sU3huRSs1dTllM0swU1BFTlR4djI3RDZXM3RpTjlkV2tl?=
 =?utf-8?B?WmlxMUlIYTBmU09Obm5ZY0VTTFM0Nlpta0F3NFdqdDZQZmc0L29weWtPRTlY?=
 =?utf-8?B?VkRETVZ3MGNXb00wTDkxYjh2bUx5OUZGTk5HczR4V1dDdzFkeGtDdmJsemVZ?=
 =?utf-8?B?eXc5TEh2cGUyS3ltR1B1c1IyK2c1NGlkN1ZWSzFKbU9lMzNoeGdRamFsbUJK?=
 =?utf-8?B?ZGFTbTZXSlFOdUJ6REpMU2d2cldSYTBJcTIvVUJZWExpVXBwekpyTXliWHNo?=
 =?utf-8?B?dEk2dUc3azRkRlZzUlIwamFyelpqaVR4TzdaVUdOV1ViUGwvQXZUWW93a2Jh?=
 =?utf-8?B?dysrQVhvbkc5dVNveTVMZnV2L3VQYTZXYkt5cm9ud1VsVmhYLzdHOW5rV1M5?=
 =?utf-8?B?Ukh1Y3BJZnBzNkxqQUtBeGIvTDVYcXVsZmxidDNrTkd3WFpZZzBML1h4RUVN?=
 =?utf-8?B?ZmpYTURhRW53dEM4eWYwMTlPd0pxVFd1blh2TlU4ZGd0R05WVjJ4TWJobVc2?=
 =?utf-8?B?V1lNMjZlNGNOK2RBUUdueUdDUUlmVXBxZlZLcVZPTVVPZXBJa2NIOHhQY3d5?=
 =?utf-8?B?cllHRkUxM3YzNVVaVHBwQll4U0ZUZEdXdUtYOVN2cXFxY2ZVVWhEazkwTi9X?=
 =?utf-8?B?QUg4YjlNMU5JUmkzWmxSd0RObTFNQUpxYUF0Qm9kOGdmMXc1cUMwcHNsUjlK?=
 =?utf-8?B?VlhoNytiZTdYSzRXeVFxanlDWGtKOUN1dFA2U3VkbjFOSFZXZTlOTlV3eW9D?=
 =?utf-8?B?OUlBSWpjOXJHVjlWZEUvQzk3UWdUdXR0dmptRHRlaHIzeGo4RmhWZlZ3bkZF?=
 =?utf-8?B?Q0dSd1Fsa2tXUUFZcE5DbDRrbk90TGIvZEZqM3prYi9VbTRsVkNyUjBnY1Z6?=
 =?utf-8?B?TGtXQW4wbVlSUlgzdWlGejRtVTFOK1N6enc1UlQ5TnU4MUtTc0FZQUlodW9i?=
 =?utf-8?B?KzJlUUVQSUh5a0hqdkI0TEg4dFJyQkRsVU02bGhTRkVEK2NWNnFyODBRZkJ0?=
 =?utf-8?B?L25kREdDaUtkc0tZV1psN3RRNm1ZVGRPU1ZTMjNuMm8rclg3MC9tQzFsbDY3?=
 =?utf-8?B?OStQNDlldTJBNDJPSkNyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGQ0b2VLTmozMHdTQTBVVXNMbCtxQUY2RHF6dTZGaDVxc3hQZ2kzS0ZoWklk?=
 =?utf-8?B?TldEVnJ0cGRoRjV4Vk0rcitlK0xST2lGeXdzYllRb00vN2Y2VUU4NEhVZUUv?=
 =?utf-8?B?c25MdkRweTdIWmhUYW15L3V4TGxkTzl5aGE1NmY0cUZHRjZzTnpka2Z0anNS?=
 =?utf-8?B?MWZiVy9iZXdzT2ZVRTVmRmhaKy9iZlJXV0ljVUdYTTdVSzcxQlZzZnhqUjJn?=
 =?utf-8?B?dzdSLzN0Tjd6RDkrK053N2c4aW95ZENEdmV3bldnTjFZUzlWQmZXSFllYUs3?=
 =?utf-8?B?aWgvOEt1bkxwdGoxNXJTWFZ2ZEpqNHJuL3dtUDRhZTF1eFgzcEMraGtoWmlw?=
 =?utf-8?B?WG5lbWxuSmY5aVdVUnZISXNtUUd4WGpuWTZWWE0ycGR1VDdkQWNCSFlZa0Ju?=
 =?utf-8?B?ZUlmMXVGTTQ4d2luMkF5MEtBYnFHTnhxdnB2NC9TRWEwcEZLTDFkWWlqcVRS?=
 =?utf-8?B?WkNuV2VzRjBra0NBYVRqUy9KTFBTQUtGM0l1K3VtTkxvcVBuNGw4TmQvTTFO?=
 =?utf-8?B?N1h0REtXUE50TUxoTTlCZi94blREeXB0K2F2YlFZeG8zWnBaK25DOU1LbTlq?=
 =?utf-8?B?RjVKb0Y2QnJkM0Q3MWJnQlU1UXR4bHRiV3ppZG50OEhSNCs0OTJzajFTOHhU?=
 =?utf-8?B?MVdTemdWMkRCNDhoMHgvTVY1R0dHOFRVZjU4T0dJU012WUxJTUpZalV1NnB1?=
 =?utf-8?B?SXBPd0MwVVZlWlNRZTJvTmlmTlRvbHZMMDZXWU9mZXRRSlh6QXNPL3VVeW5T?=
 =?utf-8?B?T2NXcWlCYzFHY2VGVlZWMExBTW1GRUZMTHZuQmpRd09hc1paamw0YWNZZTNJ?=
 =?utf-8?B?SUZ3WEsrK2Z1eVplM1RlUjVYcFF2V2dBcm82MjR5aTlxWFlXVHIyd2VCOEt0?=
 =?utf-8?B?aTIrWENWR2swbCtQZFpQZWxVWDZqM2F6Z1JvVGdVTXQxNy85VlhWVzZLQjZl?=
 =?utf-8?B?Q21MakYvWnNxaHRyeEJLVTk0Q2tnUXdCK2VEUkMxNDgvSmprNFdJUFluTUJS?=
 =?utf-8?B?b0RoVGxndFJNbEdqNEZqYldhZVVvMU1MTStWOUc2Qnpja1NhcUcvVFpuOEFB?=
 =?utf-8?B?YVpZWHh6RUpFaUx0VGJvdkRmQnNYNlU1ajJxOGNwMVVoaW5FMy9MUlB0bzlo?=
 =?utf-8?B?Ym01aEgwMlVaUkVNeHhSeTNjN2R2bjdKM0FyWFJHWERJWkZJWEZ0d2ZpWW84?=
 =?utf-8?B?eWxZTDJMRHZrRER2aktaelFwNDFLOXpTOGlvWHBwQU9SaktmTlZJVkVOZDJG?=
 =?utf-8?B?NFhKc2s3cXRrV1ZKc0pwYzFUd0NIQ0tNSFliYXY3RERpUTR0Sis5WFkzbHNl?=
 =?utf-8?B?TjZldTI3S24wS3BWOHBUSUpPenRYcCtZQmRRTUplY25ZN0VJTDBZaUZIM3h2?=
 =?utf-8?B?ZzhXTDJrZzlMNldBalZudnFTSTdOOU9tTUZ4ZE5OTy9OUWFqTkFBelJtT1RG?=
 =?utf-8?B?NnpFVkFQaGtZNE51QTd1OG5WK2grT1VYMXB4STdzZkZMQ3pjTnVuK1lKTlNt?=
 =?utf-8?B?UmIrOVJLSi9ERnI1STdnaHFNU1E3bjZtMmZ2ZUpEb3IvUzVTYUJSR1J4MGNU?=
 =?utf-8?B?YjFZQVo1SmlXRDBMNUE3ZVZqdGtzSy9XWnBxVHVHbE9vSTVXQ0d5a0puTUVY?=
 =?utf-8?B?djhySnIxeHE0blVlQlIvUU9jenhPMXBDeEJnNDB2TzVvTXZ0MzNvcDRqSExx?=
 =?utf-8?B?eENaZXhSZnJKdTFaRGw2bnNNUnZRT2FYYnZzc3lYblBVL2VLNGR4WHVaTXhE?=
 =?utf-8?B?UTFsaVJjRzh3dEh6YWxZY1R5Sks4RTMvRU9BTnJZZHJPYTZHTFBqTGloV2pK?=
 =?utf-8?B?cUJKNDhWRysraDNiSklIOGM3MTEyaWxpR2pPeWZBYnJsSzB4eG5ONHltek5h?=
 =?utf-8?B?RTE1N0pSSnAzNytiMnd0VnJEL1djcTNLSHNHQ0xrZzBFamVPKzdSMEU3S0RJ?=
 =?utf-8?B?cmd0aVpKU3RGNmxrcHZFb1N6OEV0c2NORWpuQkJTaXBDanFrODNsdk5XbFRG?=
 =?utf-8?B?QVZ5ZnoyMG9qbytjcjVHNENycHdybUNxTENzbTBvcVBGcEcwMS9PYkJjRktp?=
 =?utf-8?B?MFN4S2hGZmc5NHJ2cFlQV0tad3hybmJaUnptUWwrNEJnSlBZRk1LV1ROWWQ4?=
 =?utf-8?B?VHh6T251SS9vMVBXb2pVdmFpMnUxbjdkY2pYcGt0ekluKzV4VlowT2JBS0JN?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EOd0t1GMxSrcGJrzK2gGigiUNfStK454EDYc0Vw7G3jNT0dVjY5wM10m5vhNmtjnjMT+aS79MZQFQYMGGvrF64pedMn6HoGzmU21Z469BUQ0FH4Axq4Sxc6CTLrDCM/27Ct637WwaYVSSVHvFJY/gFCI53hMjdTgIhAT/VulSa90lD5gBly9DvQc30Ud5YemRjL+gzGuVu1IH1maUm6PnIzNXcH4bM+GeV0MDLEeoPQhUPWAve0GPaP9pIhBo3woGBtymfRSGDPjzvvS7+dykLUx6Qbx6qE6BPkU/OLzDvTiI9eYm7G5FV5h9FJ3QiZQjdsCxYbcLhcbfArZy6fkFu94BN5wqUwLGt6tXZWRfCy04lz/bdm8UkmdfVSoxUwWdXcdIEV2KPcDOxRrmD/xx5BqS4ofGxCJ9RZN59xxFwILYk135OOq/b2cOwcdrztkvXy3NzizjxDaVvWyFIDQaIGmxajvUZ1ixCxgP9bQVtwRc9spp/itUWmGxJzzkfnYiDZEsYG8SN3YsR0ZMwqIOArMsMNbSQdRuViWaLbhlLQBRcvxvCjs5V6pNjfSpcqMNBLldoV/GWK9wwh9EJGIV2kT+NKceKhVDvqjEcJvvsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19774165-4ec9-4439-4dd8-08dcb0a80e76
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:58:22.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bsrg4kOugIscU2cJUoVb3kCPd1EqWhSUSNCM0KlegSbpce8RGeYq1ZMOYtkYoCNI+QnPMK6UyGF7TossgR6k1X+QQT3CnwT1iW61xK+LMOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6328
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_12,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407300102
X-Proofpoint-GUID: g-qzTkhoxFTprOUwkUIaP2xm62Jfd8HC
X-Proofpoint-ORIG-GUID: g-qzTkhoxFTprOUwkUIaP2xm62Jfd8HC



On 7/30/24 3:21 PM, Chen Ridong wrote:
> We find a bug as below:
> BUG: unable to handle page fault for address: 00000003
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 3 PID: 358 Comm: bash Tainted: G        W I        6.6.0-10893-g60d6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/4
> RIP: 0010:partition_sched_domains_locked+0x483/0x600
> Code: 01 48 85 d2 74 0d 48 83 05 29 3f f8 03 01 f3 48 0f bc c2 89 c0 48 9
> RSP: 0018:ffffc90000fdbc58 EFLAGS: 00000202
> RAX: 0000000100000003 RBX: ffff888100b3dfa0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000002fe80
> RBP: ffff888100b3dfb0 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc90000fdbcb0 R11: 0000000000000004 R12: 0000000000000002
> R13: ffff888100a92b48 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f44a5425740(0000) GS:ffff888237d80000(0000) knlGS:0000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000100030973 CR3: 000000010722c000 CR4: 00000000000006e0
> Call Trace:
>  <TASK>
>  ? show_regs+0x8c/0xa0
>  ? __die_body+0x23/0xa0
>  ? __die+0x3a/0x50
>  ? page_fault_oops+0x1d2/0x5c0
>  ? partition_sched_domains_locked+0x483/0x600
>  ? search_module_extables+0x2a/0xb0
>  ? search_exception_tables+0x67/0x90
>  ? kernelmode_fixup_or_oops+0x144/0x1b0
>  ? __bad_area_nosemaphore+0x211/0x360
>  ? up_read+0x3b/0x50
>  ? bad_area_nosemaphore+0x1a/0x30
>  ? exc_page_fault+0x890/0xd90
>  ? __lock_acquire.constprop.0+0x24f/0x8d0
>  ? __lock_acquire.constprop.0+0x24f/0x8d0
>  ? asm_exc_page_fault+0x26/0x30
>  ? partition_sched_domains_locked+0x483/0x600
>  ? partition_sched_domains_locked+0xf0/0x600
>  rebuild_sched_domains_locked+0x806/0xdc0
>  update_partition_sd_lb+0x118/0x130
>  cpuset_write_resmask+0xffc/0x1420
>  cgroup_file_write+0xb2/0x290
>  kernfs_fop_write_iter+0x194/0x290
>  new_sync_write+0xeb/0x160
>  vfs_write+0x16f/0x1d0
>  ksys_write+0x81/0x180
>  __x64_sys_write+0x21/0x30
>  x64_sys_call+0x2f25/0x4630
>  do_syscall_64+0x44/0xb0
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> RIP: 0033:0x7f44a553c887
> 
> It can be reproduced with cammands:
> cd /sys/fs/cgroup/
> mkdir test
> cd test/
> echo +cpuset > ../cgroup.subtree_control
> echo root > cpuset.cpus.partition
> cat /sys/fs/cgroup/cpuset.cpus.effective
> 0-3
> echo 0-3 > cpuset.cpus // taking away all cpus from root
> 
> This issue is caused by the incorrect rebuilding of scheduling domains.
> In this scenario, test/cpuset.cpus.partition should be an invalid root
> and should not trigger the rebuilding of scheduling domains. When calling
> update_parent_effective_cpumask with partcmd_update, if newmask is not
> null, it should recheck newmask whether there are cpus is available
> for parect/cs that has tasks.
> 
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

I tested the patch using the reproducer in the commit message and
it fixes the issue, seen with the reproducer.

I think we should Cc: stable 

Tested-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

-- 
Thanks,
Kamalesh

