Return-Path: <cgroups+bounces-11784-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF477C4B4B8
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 04:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E93A4F0FE2
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399A343D6C;
	Tue, 11 Nov 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZaETynWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rUoR3RAn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB230FC24;
	Tue, 11 Nov 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831125; cv=fail; b=ZtINOZvDwHH028z0aZrHbTezfGyTCMkzci75UJgzZuyUszJFGo3OtT5puClxIlwiCXwUaGAnX2d6wTbfyeD8pWztvPiBoKv7W/6uOVSaqU5r1dR5iNkt5vKmLLwvGxIsSC59mdptqRXfEs1Y0ko5/FN3dVNEtepjT82eAJvkhKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831125; c=relaxed/simple;
	bh=5Bj8U6kyW3sguZXGn1ROURZtGR2l3aG310hRd2a9TmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BuY9ULYWdLQniIn5UNxpkmyh0IRpcQy9ggh7V2Wm7llIuQu0BBnwB9+lHZqXkv9Ds/NWCWzn2v83qvnsA9IiK0uzHti3o3ISSx8qfyWC4WPepNRVjKb1DftnjR0WmfzxLOvzbriYxHVJGJnQHvSZpT84baYkmesuehkJ5ezQEdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZaETynWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rUoR3RAn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2ot7G013176;
	Tue, 11 Nov 2025 03:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Er2Fu4ueW0uBKFu4D54PCXBWqRvwPPXLqk6phXWhx+A=; b=
	ZaETynWD7Lgi0EPIo7aozReVHhHBTcTwaMIvhu5uXCNnP/xEV39FuTxK9Mt6Anup
	lJw987ipfmCkO19thag10wKbUF8hK5XwTMsF9UgRqr8vRw91Dauw7+/WoMuSiBfo
	Me/8HDfpTIpu8u919bG9GprKEIo003kPct5bkn4jghu+BiQqifxyhTxupwnHNhQU
	hTLNBwtWj9sobS7V6WTbV0gndakahTGa7e4F7a269z3e1uR5rdca2g6HROT28fs6
	XZrPllA5uax06/sRRPIaCLWAP7M29iqdoH62yAVcXEh2YFcqGr9m5XUJaWl++M9Y
	8iWfj4xK+QilyLq8misdnw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aburng31w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 03:18:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB1u1a0007655;
	Tue, 11 Nov 2025 03:18:29 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va9g8dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 03:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUuKsw4ZBRHbS+rdou5KG+isgzvPf+1OM4Ws/h/alEhgCpwGaaettaUDHKScPzhL3yWBZEP4t9TYcbcdHtRnomVMzJZm24qYqKepMmCnifcgU7hDrUGUAlHa5vQKIIiU5+4pylavV1cr+yYSz+CnoBBQUahhTW+jDfPenpgEh8hGos+F4yubR54FBOBJ48om+AGUPtzuE9hvy1BNdeOzJbv83yC242RlUAOXcRAi9NmQS5YGaBvgEfSzGu640Y3+JSmocyrlrZ2a3QWLL+Gezxkln1PKseISPSCbogErZejPqk95cWHjCTVHgUtHsojZdP+myGTn9JE/bTcfZLgBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er2Fu4ueW0uBKFu4D54PCXBWqRvwPPXLqk6phXWhx+A=;
 b=mqkTnyC3+v9rJt5jrKsLN9dDNigdSysrVFpcihaynD6zjKMs6J/fPbsWMecrEtKadjHm5H1czyaU+ZJ+WNr/WElHNEqraiKAEtfiu+jfWnVRxf82fPlzRui8+oSJElyWNDk/7kK9znya+FaRdh+8TJCznjjsCGKftrVVCrPppNL+CkRCZkyCM5VqCHeYKgszMFhhU7MgaZ7Obbk0TIxSnuNN7mqFsUj4c48zBElsdVVxunimGqVuAUC7/7I1GdDirPX46aEhVqR1AYnHbPrIPGDDrrcMx1wNVbW7ONCbyTqFDir3CsEJis4t8MGVNJnHS6YOeC5U3A+hG3ERY46IXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er2Fu4ueW0uBKFu4D54PCXBWqRvwPPXLqk6phXWhx+A=;
 b=rUoR3RAnQNlCsyFnVIoNGguOVeR/JptungjHm2VV8ZQAdRhGHXWu+ujhJKCl58OOP1792uiCntt7dGv0QBUvEoQbIsWaKB4jI9YzU/z3/kzdfqAJ22aekK+Us9WjpVOfBSCaD4iSQTmV4xQv/toiYGgF2y1CbRkJr1NFEkm7ZO0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 03:18:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 03:18:22 +0000
Date: Tue, 11 Nov 2025 12:18:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <aRKq-JOzoCW9kKMz@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
 <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
 <hgf4uciz7rp2mpxalcuingafs5ktmsgvom2pefjv3yogel5dh3@7kkwtrnqotnc>
 <982d6b8c-53e7-46f3-9357-afb85319d0a3@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <982d6b8c-53e7-46f3-9357-afb85319d0a3@linux.dev>
X-ClientProxiedBy: SE2P216CA0003.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 441e8b8d-c017-4ecc-33f4-08de20d0f82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkRBaFBXR0k3RU1sSG9tNWlJclNLeGRkRGF1L2Fpc0tPcXI0Vi9EemQ3V1gr?=
 =?utf-8?B?WHJIS1dyZ1V1WUZlRXYrZjBYQUZ5alFhWEhpTnN1d1RyVUFJaUlrYzlWQ2JF?=
 =?utf-8?B?dVRVbzFIZUxkSktDSFl1Zjk2NDJYUHdaRVNTcjdxZ2E0VkxMZE03RTdEbU9N?=
 =?utf-8?B?MmNXTi9JcVlENWRLTzV5OHpNMkRlQzczSEZPWGpSazVkVDc3dFZDR3dwWUNV?=
 =?utf-8?B?alZlVXB2ejVwTTN0Y0hZcE5SaDN3eW8yVDUvUDdGZEx4ZTNmeGhqRGtqejRu?=
 =?utf-8?B?ZGVzTzFNM09CY2NNdmEwUTNpcVduVmNrSW1RSXZuVDR3dlhKZXhwc284czh2?=
 =?utf-8?B?ZjZxMjdZUnJHWGtNTzZzSjZQVjVRaU1wcTJxOGxPTmtxSEh6aUszVzNON1Ns?=
 =?utf-8?B?UDRWd3QwWE1YdDBXV005UDI5cmJBUUpEOW9JZlpxV0R1SEpsOUpOMHJuNnBz?=
 =?utf-8?B?REduM0VoSWhSdTRzZkJFUk43VENWSmpiREU4cUc3NThuaHFxYTRqNWRuWGJr?=
 =?utf-8?B?ODlucFhpbFZBZFJhWUpmWUNHVWF0dnFVTmdsSWVuS3R1OUs4WW1LMjQ1S2Mx?=
 =?utf-8?B?NXFyS2JzekhiK1RwYURWOFJtYnVIM3NjRHJnSnJoTVRMVE5IZXl4bnNQMFZz?=
 =?utf-8?B?SG1BeEN0ckkyM0ZkY2xRQ3BIeEdtYXFBbHNIY1hpbmVaQ2dNZGZRV20yUTc1?=
 =?utf-8?B?ZnNUSVVMb1c3MU1SVHh5dmQzZ3lXZEp2bUZMUTRCenNlb2pWMDRmUFZXY1kx?=
 =?utf-8?B?UXNuSWhDMHNRUzZlRHpWbXhGV3h2SUJZUkJvMkRKdHNDNTdydHhmN3BqVjE0?=
 =?utf-8?B?Z2JtNndpQ1VjYklGaHptZU9XYzJMQzM3Y2NQS3hkOTBLZVJNS1hCbUVqaFVR?=
 =?utf-8?B?N1B2UFJ1VzBzVmhJSWgxVXc4bkc0eGdSbnpZbEMyUmluMnpzTXF6c1ZYR0hV?=
 =?utf-8?B?b3c5Y29iNldBMDVuUGtHNEFRT21nNHBUOTVUQm1mTFBCWGlKZ0FjeUN0b3RP?=
 =?utf-8?B?VHZuVGk5RVZhSUN3bys1NkJrbkZXa2V1NUdWZ0JYN2RxOGtNc0dySWcwdTlS?=
 =?utf-8?B?MWpnTzFmc0w1aTVUZlVMUWdGN3loMU0xVjh5WThieVhuT1lWRWVhby9qNjlW?=
 =?utf-8?B?alBYNnJuR3pTRXNlc2lOa1U2cFl3ZzJFZjJsaG5idDdwYjc0UnNBM0FtQkxK?=
 =?utf-8?B?SlpFYVBhUlkzUDhTdTR4dmNBaGp1WXptL29oMDVPbksxaWcrVlozZzlBT3VB?=
 =?utf-8?B?N29LTVMvSEh2UDRYdHlYeDhsdEN6SUxVWjVORDY3aFZzL2RoQm1PdklZKzN1?=
 =?utf-8?B?SWtwSXlEZW82R3RSZStTcFhxR1hjRERZUzVRMXJMU2w2OWZ4TUQ0a2ZSTDcw?=
 =?utf-8?B?WUZUa2ZrcEllRXVmWk1VNEpWc0Qwa05CZkpHYUQ5eS9PQUtDQm5MYVV6S2xX?=
 =?utf-8?B?OWFGSnVnMkZuWmE4VkJnTTYwMVZrelBsU1kxWEFSUENoWlpKaFJwenhPVmFo?=
 =?utf-8?B?M3hVTE0wV0VwUFZrTkZHenNUOWsyZTVpTE1QWno1NDNXS3JwQytqZVFBSHB0?=
 =?utf-8?B?M0h6aWZUSHljVWVWSkJVaGQ2b2RnRno3TCtMNUhQQVR6RVJYRTZTV2JkWWhS?=
 =?utf-8?B?QmtkSEhvREZRc3AxdUlLYThmbGdKL3FFU3NFU3VYUmQyTC82eXhtUFVTSDYy?=
 =?utf-8?B?enFXQ1pHUmZ3SGlJb3BhRTJVWlJiWmlGOGpTVFp3K29XNXJGVHBIRVlPWFZZ?=
 =?utf-8?B?blJ1VFpqSk4weU9BR3lLVkxaSHFpUVJGMkdQeUVGYVBNd3praEZHNmZpOXow?=
 =?utf-8?B?SW5kSCs2cFVGbjQ2Qy9LRE4rVzhWQ0t3eTN3QmU2eml4Z1p3bEUra2VGRmgy?=
 =?utf-8?B?cEtqeEFnTWV3UkVBUFpnTGJLWnFwcWF6RHlTLzZpVll6bnJHOUh0cGt5SEF2?=
 =?utf-8?Q?4qmG+fQDQYcOGb/7UB14woaHHn8b/Wrb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVBLdE00V1EwTWxYNENMa0Zac05MUEJnd09NUTFNK1d3R2dzZytpTThWaUp6?=
 =?utf-8?B?WFR4dnNLR1lzaGhjRHg4ZkRnTTRsR2IwWXZzSlcyN1VjSk9xOGFlNGR6UkY4?=
 =?utf-8?B?WmhISnArSDJLcFJXN0o2QXFhVENVRzdpcHNIcWxaU3VGa0t4dkNyTVJPUXdE?=
 =?utf-8?B?ditmMmEwRGR0cUlJcDlvYUNoOW5iWklLQUNsaDhySUtReXp3ckJNemFvM1FH?=
 =?utf-8?B?V2cva1MxTEtVTkRaY0duL0RuVGkyRlVEMC9lYXY1VG1FaVBoZlZJU0ZxYWg0?=
 =?utf-8?B?WVlFRDFweTJKUm1IZ3FhSCtNSFhJUW1TRnhtL2l5Z1NncW11TWF5ekwyUVNE?=
 =?utf-8?B?TEY1Tllzd1RsU284MTUzS1c2bGZTcVhaRGNsaGFOendpUC8xNTFjV0Q0OGZl?=
 =?utf-8?B?d0FjaHN4RGp6dDA2d0Y3dTBjbithVWFMa2pySjh1UnU3ZzdLdTgySklFUWpW?=
 =?utf-8?B?bVBEcGJTeHZEM3dRU3RYN3pLL21Tc3B6d3ZKL1hWZ1ByWFpjbkFOL2VRT0k2?=
 =?utf-8?B?WXdsaVRrdVROaHovTUhnczJjY1ZKbXhucWFsOUppekhhNE4xMGllTE85T3pt?=
 =?utf-8?B?NWdQc0h6b29DM1J3T2h6T2tzRWRXblZLTkt1NWw4SWJSMHp4aXJYRnVma1dm?=
 =?utf-8?B?M0ZtYXpKR21GWW00ZnZnbm1Ib0tMWXVJNnlQSHRNd2xhUmFYdDIrUVN6WGty?=
 =?utf-8?B?RTRiTjJPay9MdFJyTkJMMmdMZnpLellpSUpJdjYzS0hndkVhaHpPdXMxc09C?=
 =?utf-8?B?SWRvYkxRdnExRXpraStyUzduZWJ0a3E2cnB1ejdlSEMvQkYwNWtNK2hKaWFr?=
 =?utf-8?B?Z2EvaGh4SldWMkY0QnI5YUVMZ1k1Tzd2QlhIMHVHakVPcndyV2t2T3IxVDJT?=
 =?utf-8?B?aE1UcUJQVHNqVUNhNURmZlNXQTI4cGRwT05vZmMyc2VFb2tDYUlTL3hvWWJW?=
 =?utf-8?B?NXB0STYyVG1HRDZyWjZ1eFo5c1F5SHVjMkQ0Nkwydk1pbGZ5V3d3S2Nqd0dK?=
 =?utf-8?B?UHcwSGxxSi92Z2lxVVdkTGNaRTA1Q20wSldwaUR5WXFZNU11WGVjV0RIdmNo?=
 =?utf-8?B?L21hUEttZ1ZrUFNxbDZ1OXNYenZwWWREbU5rNEhtdTVieVJhdzk0K3NVdys2?=
 =?utf-8?B?WGwwWkR1SHpXQmprd254YUVTUWkvYkhLZmNFc3VOeGJrd2lPNGhrc2x5blJx?=
 =?utf-8?B?VFM1ejFtMFBCUjNtNk9WQklxc2JqWk91Mzc2ZzU4SXF0ZjAwSnFmWm9WVGdw?=
 =?utf-8?B?bFhVci9PazByallMd2Zpam9VNTMxb0c2eTFOcUNocmZ3Mk9LRVFnbkJCanlS?=
 =?utf-8?B?THAzSXhaemNrQmdxeFE3SFc1WVZ0RWZwbXdmWmhkZnF4SmxxM0pmY3ZwdEY3?=
 =?utf-8?B?eURUZ0FXRmpFTnBwYS91QzlHK3ZNQ0tYWkR0UkJDWWtRNEFBT1NUU29GUkM0?=
 =?utf-8?B?QVZKeC9qTmJPaG5RaXdPVEpmT0h4OS9OQllVUXNLS00zUnVzd3ZDSk9EcFFO?=
 =?utf-8?B?VWtSTlZLSXZGemZNVnZ0MmlYVGVLZklMYUxBd0FWR0d6L1dycGcvc2FkZzlZ?=
 =?utf-8?B?TUNUY0VZend6bTBhc1VUUjY3TU1TRFRTNWY4eDk0RCtYdng2NENXdmIzaU90?=
 =?utf-8?B?eWs3Y2dpWk9tM1dzckNYd3ZnalZwSmE5c2ljVFFzNGtsczI3bXplNUd6MVBO?=
 =?utf-8?B?ZVpuMGRnVW1ibE1PN1VBRWJhZ2w2eEc4aDRPV3YvQjJvU1lydFMzS3diUFV1?=
 =?utf-8?B?Q1pEMytPN3lpa2kzLzI1TjU3Z0ZBbUNCenlNeGdRUUhLM0pHclp1MnQ5VUsx?=
 =?utf-8?B?N3NMVFZYM0ZCS0p0cGs4TDRidXMwZDZvMG5jVjBrYnhLZm1sbE94SHJTdTYy?=
 =?utf-8?B?TE1kN2ZnYmVkU21Ta2x3T3dFRWd2ZURtR0xNWUNFbWJOTWkvbUtqOU5tVUt0?=
 =?utf-8?B?b0Y5c0MyWVMwOWRSOFZKOXU3ZnAxeGt6aDhBd1RUblo3S0xkYkc3MzZWdWIr?=
 =?utf-8?B?M0p5TXBtUWdLdWp6QjZWQVJpTnUvc2dHcEpmWWZZb0lrYkxiU2VvQ0xLMHFn?=
 =?utf-8?B?ODErbGs5eVFCZWx1ZnpveHUvOTlsdE5vN2JGREdtWUkvaDdGODJFV0VxbUJE?=
 =?utf-8?Q?yj74YJ2HA8t4JPedOqhW3E36l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m0oCuhNf7qIvyryR+wMwHf3oCD8Qgne+mIBN0Xlu5VaoMPVIq116Ih9Pkw0l5GjUep7hG7nunIlAC4zOnsYpQxRMAKgs2l72CkV1xlET/q/zMeL204IlVVFaqXE1kaYrKPuW2M97C96zRKN2i+MrnK3SbCnYN7nRdygPHS2UletIDwmzKBLARvar6PhXYlKs7vDUSKn/aYT2/6LW8iJFuRrj2BG9rToe+dSbltPsLxqUCywJsMLwNhTdpS5MAiS/iZa2i0VjswAY1Oj+i60h8ghLfE5/c7xFavhRNBeAJ6h/kofJ/p/XJL6/se4G56kFfjcXQGC6C65LUWNqt5hhWpF9SEmI3i2uYTbA55GXJxk2szX9/he2Bb7+iY6ud0t2rqiCqFdHQc6695RB/fZCUE7mD1nNUwSWZSVYI5RqebgAWAt8DyhgmdeXYUhDYbWVAX5dYuxMTTZHLWSxOp7sJsiUsr0rEv6Eh7rh0+RrI50UKAP0PhpEATH9tmiV3fK3riapKImgQhlaM9/wqoCRFm9byeQDoOsCnJttOeOV663AA1bRexUSGi27TIMwBqJhCJY9uKDFNRWNf7iIZ0vZ2VAbmcYb2Q/9stqndbJyYkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441e8b8d-c017-4ecc-33f4-08de20d0f82a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 03:18:22.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+ibklBlFxcxGqpwpCF5hsnSfOe+bQjwHz003tEQBcHYMlplqoGmIFy1occg7RjhjgY9Uct1L4friuExB/617w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=942 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110023
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAwOSBTYWx0ZWRfXwCMfgHIAKhUB
 W0CH3bB3V7D5LWKI8kX6+D6O3sELd19+brbdfNCOGmK1j7pPxkYu2gB7r6+0p5CE2/hntzL7VQe
 M53Hj8h2rsYb2qBkqkTVGJYpz5PnXNrGlMzhW7y8JCUIJHCN+K6OrQ1BqesbEM+E/m8RAGIdX0s
 +UBws9zY2hnnjN/YdGMLBNPSwrtS7Ny1xSbRX9J/YrczwMUOJ9jNv5Q3KJGWR8qSHIE75YNI+G/
 gAC/r+fpE+/L4xu0SO/UFao+QapKlX79NOBb27WgNL+SNAv1smljIWkFkMxTYIXfYR2RscAjQNI
 kGjrq5VP84mpWceeCZNc5FIlJWydfs7SsZbGuM8i3uqk1uy2bwl6sFPyC+u9l/LQL7l3MVcaF2T
 94uA1zb3QggTkBHBASHMAZQGoGe+Tg==
X-Proofpoint-ORIG-GUID: XUlbuNOGFxRzvmqUfHlyr_J6QfEYJosL
X-Authority-Analysis: v=2.4 cv=Zrvg6t7G c=1 sm=1 tr=0 ts=6912ab06 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M8CffUwgWYe2Yy3gTqUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: XUlbuNOGFxRzvmqUfHlyr_J6QfEYJosL

On Tue, Nov 11, 2025 at 11:07:09AM +0800, Qi Zheng wrote:
> 
> 
> On 11/11/25 11:00 AM, Shakeel Butt wrote:
> > On Tue, Nov 11, 2025 at 10:48:18AM +0800, Qi Zheng wrote:
> > > Hi Shakeel,
> > > 
> > > On 11/11/25 10:39 AM, Shakeel Butt wrote:
> > > > On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
> > > > > Hi,
> > > > > 
> > > > [...]
> > > > > > 
> > > > > > Are you or Qi planning a follow-up that converts spin_lock_irq() to
> > > > > > spin_lock() in places where they disabled IRQs was just to update vmstat?
> > > > > 
> > > > > Perhaps this change could be implemented together in [PATCH 1/4]?
> > > > > 
> > > > > Of course, it's also reasonable to make it a separate patch. If we
> > > > > choose this method, I’m fine with either me or Shakeel doing it.
> > > > > 
> > > > 
> > > > Let's do it separately as I wanted to keep the memcg related changes
> > > > self-contained.
> > > 
> > > OK.
> > > 
> > > > 
> > > > Qi, can you please take a stab at that?
> > > 
> > > Sure, I will do it.
> > > 
> > > > 
> > > > > > 
> > > > > > Qi's zombie memcg series will depends on that work I guess..
> > > > > 
> > > > > Yes, and there are other places that also need to be converted, such as
> > > > > __folio_migrate_mapping().
> > > > 
> > > > I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
> > > > using the same reasoning we can convert it to use mod_zone_page_state().
> > > > Where else do you need to do these conversions (other than
> > > > __folio_migrate_mapping)?
> > > 
> > > I mean converting these places to use spin_lock() instead of
> > > spin_lock_irq().
> > 
> > For only stats, right?
> 
> Right, for thoes places where they disabled IRQs was just to update
> vmstat.

...Or if they disabled IRQs for other reasons as well, we can still move
vmstat update code outside the IRQ disabled region.

-- 
Cheers,
Harry / Hyeonggon

