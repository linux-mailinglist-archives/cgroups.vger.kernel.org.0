Return-Path: <cgroups+bounces-8036-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F73AABBED
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B351C27668
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2757233701;
	Tue,  6 May 2025 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oiHvq9CX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jf/LL1Z5"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F40230BC8;
	Tue,  6 May 2025 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746515083; cv=fail; b=UzjNkIj3VhL7S1ZTWKADiXi9XGuS6t/lQtTrVPP2nQ6dpAa2rqCYZ3Gs+9EhHhbY0etRssMSoeWmnWcs8o8WIzirYhWF2Bk46YKhvl0XKYM7uwjHpSkZ76Ind0kcIRnsufpmRO5kj/u7XPveU8v5capM4bjPPujNPAqqjeWso+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746515083; c=relaxed/simple;
	bh=I/HWYGoRmnEKMWxHf80LpvIPR1zUDt7CwCBtL65QiPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbSVaxtVijpzVpB3DemQquUD0aV/2ElX9zK3VT1z4kuUnR6jQGkNpn/nrNnPSY9X/BTwyQWQTRVQyKj/kxe1AE9Jb8Y3PG6IHEFSsc8abXtypmEuAc9lsIfycO637mJE3Pj63GLYPpZIFv/5BVN3mbk6CCwhvJU+OiyMEtTHTqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oiHvq9CX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jf/LL1Z5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5466c6e5016639;
	Tue, 6 May 2025 07:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ptz4Fcqlzm8NsgVqecGqAdo/8IM9/3CEwtWiESrV9KU=; b=
	oiHvq9CXL7EaG0dYZ6DJuLsK8qFi3mPFWN6fLfexLml6NVwbOUYkIccQ9hhXp1z/
	SwXd+NHeKYP4zSpD8EbR55ZFiUO8PI20F5RhH1uDLmyFpwP3g7YoPz57wLyVggXX
	uA561Y3J8dyiUpQMu6kGpqOn9kWxUyjqVMlbwynL8859yGx0ToCQa5+4Qj0a7KEr
	omZjGLYjt7PslGKX6lxy8vxnamePLOmp4HMA+1YR80AJ1PCo0ZnqKbR4/LyY//7Z
	TjJ1ir19OEyrA84QTZ47EHhEX9D1ximIax29vAo9ec50bPKOM1uYOMtpWtCnhsec
	M6MgDEecC+o4GMLGK8PUTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fdajr11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 07:04:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5465kKdE037750;
	Tue, 6 May 2025 07:04:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8cfhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 07:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrYPYMP6oIpshgYQDtRQGgiFvk0IEMUX4/5D4qSgvpGNlTQfsPKzWD5Y0apwyv1EV9uYfYpz7yutNWLOEwAmyYxsixrfHJJiop1gbK6qADlw8U+KupQw6LsrCnQL5Jcsb3QXhJbgpKAWFaZYbFkXCJMNXwjhiFY84FoRggLxoAaCkfj15Bj4xAZLV6mVqzHkplGss3W2vNxKvOkAxsXspUGj2Ju61TrLCLjwbj2Afm68Ak1FLzQ4Ed/Of64ky08M8MW13no0Ora3TuG1NZVJV1NzdB26U23/oeJSU37za5fNQjfB1lEHvcsbFFH5ckeFz2RbEkCa6p+4zPxl34bJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptz4Fcqlzm8NsgVqecGqAdo/8IM9/3CEwtWiESrV9KU=;
 b=fgcFJ3cWk1AeqBgs8KaKkdJj2lEoa2YJv8Qvcs45HX36zfAVlKr/xhqOeNfnaddsD0VhPJcoiRCvG8F7shA4fIZqKrUxhMm0omD+eBdJPgyyu1Sy0YCfyWG3Lc3dH3miexTHgQZIUJulEFPNeQEw8OBKKqrlWMCswUNZD2Oo47A5C7umD/UZH4yfZ2AQWlHDCBXO194fflW838lTmdQGpClVyufzyVBpr3N5eNcxCgWrjn8mbT4pt6j642TiWnCaLN8omo7nxhTWVrYxslyOVC3aPCy766g75BO4zh1x+z2ZHHeW0mUZEp2sS+XWlhMofl7KFnzyAGOnph3b+UFbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptz4Fcqlzm8NsgVqecGqAdo/8IM9/3CEwtWiESrV9KU=;
 b=Jf/LL1Z5QNNvQkUwm5CnesH1HSybidCskMxE6N36OiipsgMvJWwbp7cWIPyTDIDQMA+jNP9YLMlEsCicfM/QllEuIvEWd4T9VrNS0K1z1PLJy3peNOL+nBRuYMYMfLyyeLNWKNAi2DO5MinHAL3kbcGbOIdipqQB0rJiiJ8DXK4=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by CY8PR10MB6516.namprd10.prod.outlook.com
 (2603:10b6:930:5c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 07:04:02 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::2072:7ae5:a89:c52a%7]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 07:04:02 +0000
Message-ID: <c1ec0cc1-8a1e-4db6-927e-5a1422f2c191@oracle.com>
Date: Tue, 6 May 2025 00:03:59 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v3] sched/numa: add statistics of numa balance task
 migration
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Jain, Ayush" <ayushjai@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Chen, Tim C" <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Neeraj.Upadhyay@amd.com,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250430103623.3349842-1-yu.c.chen@intel.com>
 <8b248ff3-43ae-4e40-9fa4-ba4a04f3c18b@amd.com>
 <bd936eba-e536-4825-ae64-d1bd23c6eb4c@intel.com>
 <tkfh4h5ntl42jc2tnwyj6dhiqouf6mowin7euvrnbs2tyiqlay@bpzdptv3plsf>
 <0bdc72c0-8f4a-4d91-8e67-f8d56dc26788@intel.com>
 <5735cb9d-86ae-4c8d-b0b0-5b0365843707@oracle.com>
 <c7444174-fa5e-44c1-bd16-c8971d118b1b@oracle.com>
 <c20fbc3b-5adf-488c-b6f3-0d4e3c9da5c3@oracle.com>
 <bc93c650-ba55-4434-98f6-3b7f556ae44b@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <bc93c650-ba55-4434-98f6-3b7f556ae44b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|CY8PR10MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 5250df8d-eb32-4f83-3dcb-08dd8c6c2eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0Q2K1h1MjNha3lxNmg5eFlvNzIydFNvYzlkRE56a1N0TGtXMWRWWDY3MTlJ?=
 =?utf-8?B?eWYyNGpmaWhsRXJyRWVGUTY2ZVhFS2NSa3YrYzRoUk9US0FTaDdsUlZXZ0Zs?=
 =?utf-8?B?d2xQSEc5R0FJZHFqVk9YL243NkZ4Ykx2bk9IcFhJdkVSaVJ4T1BDaDg1Vzhm?=
 =?utf-8?B?VXRMRU5VeUtYcXcwMnBzRU5pYThiQjROdVdPbWdFZjhTN0pJaXBwWG9tV1Z2?=
 =?utf-8?B?RnZoem1hWXFUYkJRakFQcWRsZWYxbGl5Y3ZoejZvb0R4dXFCSkdYRy9sbTJa?=
 =?utf-8?B?MG1JSjV6UmRFby9yTWdWYXRuOE1DLzloZXJYRU1LaXpKaHBlcXRKLzR5V0sz?=
 =?utf-8?B?ditLeXBHajZnd1lUcFF2d2VGMUxwUXZzbXNJUGp3b1JURDhKQkZMa3RTZUJZ?=
 =?utf-8?B?WGkzWk9XVHlkV0tRdHFoYTVUVzlvRkVOYzhidUlvbHhnTkFHZkk4Z2daL2Fx?=
 =?utf-8?B?NVlTOENvTktRMXlSaENNRFNCT096RjBDTS9FaS9pcEJBY2s5Y0o3aEZxaHRF?=
 =?utf-8?B?VVZDU1BzSVNpUlVuaGxoeFF4azJuWEt4dFp3L1ZFQk94RUlDLzN2aFEyQmR6?=
 =?utf-8?B?RzFkVjJ0dXc2RTV2cHZ4YmV1VVBOMGNXTkVxT28wcC9TK0NiVU42Q3NKWStZ?=
 =?utf-8?B?Z0tRZ3I4R0N6KzdZaUN5Q0wvckZHTzk1WDdXclhHYTVhajhJSDl6b1Y3RmVz?=
 =?utf-8?B?RFV5WFdaNjh3WUdGMVU2Ly9IVlVvNHdIRnp4L051QmNOb205VHJlZy9kL2VH?=
 =?utf-8?B?dmVvaUtPOGRNbFFrTStaUnJWRlMyTk5EQ29wbDg2Nkw4dHZpdnNPZGY3Mkph?=
 =?utf-8?B?cHRPR1M0VytJd2F3M21ZWnNJNkk5Qk1GWG5YVUlVcVNJcGlueDFJVW52WnVQ?=
 =?utf-8?B?M25lTmtSZkEvNTNLRFBML1FudnZ1TVBlT1dONEhIVzJueXptNWlGTVVOR2Zs?=
 =?utf-8?B?azJHdW1tbGhPSzNhWHhhRXdWOUZFTGZrOXBWQy9HSDQwWFd3ZDQzS2p3aDVu?=
 =?utf-8?B?VGdzZDB2cmRJeDc4eHhkWEVwSkIvK0t1SEl4TmttRTM5TStkcGwzRmQzYlcw?=
 =?utf-8?B?MUczcVhKeURyL05MNnEwcWJSbFpOTEo3SzRQZWNPOGJnR01qNU1RWUtHVFlB?=
 =?utf-8?B?S2FXVWtOQXlyOHpsazk1QnlxM1B4Qk9IVnQ2MkJFMGtCK2xhN204VU5hdkVD?=
 =?utf-8?B?OEF4UU1BV0FUR1hPYkdoc1ZsdGJHODhGZTdFSEd3aUlCTGNnVnk4dnlUSkhU?=
 =?utf-8?B?SldYSHZoQXVJSGhPMXBqUGo1bW43NmRLdVovNUNXcXlTZjJZS3VIakIvTHgw?=
 =?utf-8?B?bHg2NVZDRmh2Tjd6VXpPOEFaRXpSTXhOMzJsSjJMQWo5V2FiYVZGT1lrVFh2?=
 =?utf-8?B?VWVMZ0JweU5mT0lCTUlvWGxhaXNyUUF1UDdUT2w2dGRSc2NTQWV5bnJ6a3dD?=
 =?utf-8?B?VjJmQUsveFp5ViswSHBDR2xLQmVWcDh5eDNhc3R6dDFhWTN0Um84ZzIrT2lv?=
 =?utf-8?B?b08rcFJ3SGo4d2VtVFVHai9WWStnU0hwRDhXNzAwUm9pZzNXVkFYbFk2NmxG?=
 =?utf-8?B?bTltbEk4RjQ3NkVkYkJ2NkdVMWxFcjh3ZC9Hd2IzenRtSlB5bnJpc1h3QVFu?=
 =?utf-8?B?Uk5hWmZod1RYcFM5ekRYZFV3T3ZlemtGWllxQlY4Wk9mQUtSTTVtQ2hsejM3?=
 =?utf-8?B?SmdIbHFUckR0Y0FkQXRSVEM5NTJwVG5HZXNlTU1mR0dqc2tSaFF1Z2V2ZW42?=
 =?utf-8?B?SG9uTzdQUkd1azY5eXVNM3A5NUh2ckN5blhYVjFTSGJ0VDEyZGxPUllFSGdP?=
 =?utf-8?B?Q0tBSGZUekFoWjdZUHA4T1NwNUoycFY5TnFNczY1SEFGYjdpNXk1THdJSnJX?=
 =?utf-8?B?ZFBjQUNVQmM3TEtzZUxnTFd1dDN5QUxpY3BXalVqSlNnNXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC80UGpZVEJvSVpRRGdScmFGYUZ4WUhXdXRDUmorZGNpaTJaeWhGWVZsM0xo?=
 =?utf-8?B?SjUxRkcwbENiNGRwMFhnSnJZTWlQZjBrZnduSjJVbkxUOW51NC9hVnlXK1h5?=
 =?utf-8?B?YStXbGt1a1FYY2ZsUWFDdElGMzhsWnhSb0dOWU9WemdPQlRIVmt2cFg3bTQ2?=
 =?utf-8?B?c3dSZ1BQcGlxVSswY1c4V2U4amNaNTAxbTdDam5GUVJmaWxzcVZ1Z1JMWjNV?=
 =?utf-8?B?U3J3VjZNUHE1WjNNK3ljUys2aWxxb2c0WnRwU04yVmtkRCtTK0gwaVBnRk1i?=
 =?utf-8?B?NlNxZGI4cVVNWWYvVFRFZlN0VGRJQ2FONnFMN2tpdGZNaU5oaldHQ01IVm14?=
 =?utf-8?B?NEJEc08vNzN1V3ZqT3dvcEZCZG43Zmc4SGdDS2ZQVk50UXRNbWVSUnltdGhI?=
 =?utf-8?B?enhtZ2dOZFBnMWRUMXp5Q3E1ZmgwUWI1QU1LVjVnTkpuNm9xNHJnOGl0TVhY?=
 =?utf-8?B?VHhFV2swS2ljL2w3STZWUExOSEdDb256b1NKUzhnZjdGdHJ4TzNDdmgvQnJS?=
 =?utf-8?B?amU2MkhpWC9MWEJycjNDT0hqeElvV3VCM0VtekhlWXJuQ0QwbnNoc1l5dlB4?=
 =?utf-8?B?a214RmFqQlNkY3ZFMEJkOTF1V1cwVkZjdWhLbFpKNHpjVnZIbWozVnV2djF4?=
 =?utf-8?B?anRsWm50VWdKTWFOQzJoT3JtK1JCQUMwMHVlMnNYY1h2Slp4U1JhcXBSN3VS?=
 =?utf-8?B?ZXVoZjNJbTNUeTBDeHNjZ1hZbDVEV1Z4aDh3YzlaVml0RjRGTm1tNUc5MGNK?=
 =?utf-8?B?Um9mMitUb0dLSVhtaUdyV3c4NzRBRzlBcWlmeDByNHYrSTZKYk9PMmdSNEhq?=
 =?utf-8?B?MlVnRkJaZGMxVDFEL25xQkNibjlHekNhMmQ5ODhUMlZncWpSc2hLcFNMSDEy?=
 =?utf-8?B?UldYRE5yeUU2cjBhUWN3SE51VGdIQnN1KzRkZGtWN1U0c2lsc05aT1EreXA3?=
 =?utf-8?B?WDgrdGFDOEpLOTExT2ZaMWFtblQwTlhFZUhRLzNHWFd0bS84cVEwemN6Y3Nq?=
 =?utf-8?B?MHVXNEo1UjZIQm02ckh5S2t5LzE3WXhqY1lkOWpPTjJzekQ2Sy9ZU2h0cHU2?=
 =?utf-8?B?d1pTK1dhL0RKUWNNTzd1RzNVVjIwNjU3TnJjajlxUUxOQlN5UXRlNXEyVU04?=
 =?utf-8?B?VHZkNW5ZNUttL1phb1lHbklYYTlGeE5oL3dnbHRDay9oUlBEK05jNk9sK3hF?=
 =?utf-8?B?MUgvRW1KZXJrYWMrYm8xWmh5VkUwdzR3cWtOUU4xUjZnVStlZU1WMnNuS3M0?=
 =?utf-8?B?ekpsRnFSR0JlQXZUY2o5RENtaGxZcG1nampTVTFLUDRwejlIOExENEUvTlRW?=
 =?utf-8?B?WUcveDFjQU5FU29PNjZadDRhNEFlRTVYQ2puS3U1S21PVU11bTJMZ0xSUWhp?=
 =?utf-8?B?dVlWb2NweVFzVGU2UlZwOVlZdWRQand4T054cVdGWVZ5eVpJak5XNU1QcTFX?=
 =?utf-8?B?eWdPU1JDQys0UjBUN24vQUJZYXlWZHZaSEltTndDSmdDbktYaDFvc3h3OG1B?=
 =?utf-8?B?TmxPV0MrWXJKc0htSHRhdWNPS0xFTVhzVUhXeHJTVVFNWEYrR0ZVWXFkWTlt?=
 =?utf-8?B?UVQ0bU1jdUZtRVhHN0JWNEtHMXc3ZExMZUpraHh5SGdyYWFiR1RGRHh6dG1i?=
 =?utf-8?B?ektLc3VZMFVCZEVJeE56aWJzNnc2MUthaVh5bG5uK1k4SCtPSWVPa3Z0TnZQ?=
 =?utf-8?B?L1ZoQmE5OEhZbjlteFlLejJvYm95TXVpV3d1MnpZZnJTZnFpbGdQQWE4Ymdk?=
 =?utf-8?B?R3lFMXA3R1FLcGRpcDNMWHRSR3hyeHNBS1lsdGR6cWxObmlxSWVicWNLcU9H?=
 =?utf-8?B?R0RiVzZ4NXpScU42MytEOWpkT3V0QlNyMDVydWk3b2RVM2UreWk3MVlHRXFa?=
 =?utf-8?B?Zit0S29tN0FWanpmalNrNlUxSUR0eHJ5bmpTQmpqZFRkRG9QaXFGNk5EZ2M0?=
 =?utf-8?B?S1N6VVJkY01hdnhnTUY0ZTFKL0FSbzR2VmwxeVV0NzhkRmhsMGdMY2pHVElF?=
 =?utf-8?B?d1FiN2lSak11Y3d3TEMvaTVtcVFtdHRNMllZS3BQMGM2dTRuMjVMa21RNDR0?=
 =?utf-8?B?aVRhU3VwR2h2ZkZ6RkdyU2pveCtuaTBFK1NSWDBFL3BxYzdnOW1MN0hnL0Ra?=
 =?utf-8?Q?w3Erp7A5MuHOy1folb/YjNqLN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NyGPWyCRjMW5LRvMaJBpmr2NPwZpWl5VOGZlwjBAirSaKhuYPyrWhP9mDbTu/ZMmyah9wYbGOnz9AXrDijF4AW7NO01zdmKIdG5cXjp/tQJx+clDhlgphjljwuA79lLIKDUfPzQhbMJswAvNK+JCrzjJNeIOa61/kmCUkrnj5acYBZdmUcI6W9LqQ0MQfKlGWx0hCJ3ygNfBNo832QMwNTyRSq9muMTfWTL42ZUyLMh/NU2Ipa71RrvDq8CgIqS6QtHTez/TRCQ65+84gXqzwWLvneqPvnsmhhKxilFqEpXPnEozFS4+6g3EcSxrVgcTVhDvs14dFODb2aooEj3/MJGBjCbnt0Ro6q4xdyAkPr+h3H92KM2o9FMQfdcs0UQCssR8N/P7/Em1SyPHwJMclo2po/7KVH+Pd1ElaAbMXa4K7h859u/bPX8md+COpz46kfFQ2RRmGCNGHfw/mROUVhx+SxIFX6oGQ9q/Cm5/xYpm0WAqvBZAsKYn0xd7lRbF+Xy2LBbiec9BuJnCZ9DyFsLhtMRqmxqQKCYTvtW2ZdpWLe57Gi+i54Ag/1BRFak2tnhTeC/yGQOAJmfAUajX9NwMDhQBpg4JvLUGnivSP2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5250df8d-eb32-4f83-3dcb-08dd8c6c2eab
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 07:04:02.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQLwcTTMn0yL/gbTcCuH/67wM3hKpDnGD0tzwv27zQC9z6nzY4ZFsBTFNnGARq/yE0fUNkb+Va7X6PzZ/Mr+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060066
X-Proofpoint-ORIG-GUID: iwvV8_nlqZFtze09ytrMzNUBGXoQxIUv
X-Authority-Analysis: v=2.4 cv=VNXdn8PX c=1 sm=1 tr=0 ts=6819b46f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=uaCXx02_R1iN-FRl1XAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iwvV8_nlqZFtze09ytrMzNUBGXoQxIUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2NCBTYWx0ZWRfX9BdrY2aNZbNf kpxTCU1xCvct0nTJQHwg6VpF/8ExQy7sVp7riwMchW8DiF0VnTkzhkWQW/yS9vTdMezVTMxYXt4 RVgI57kZ1hNJonNpKeReZ3U45MxkB0BdgxJjdDwy+SU40UXX8c3KhR8RLe1S8mH1cn7StyOS5F4
 hydwUquji349z/1p4iZnLcyosOsQtEU1FJqfq7pP5Wex7l0VHZ0wB/ZSiFgevOok5EGB9U7mc6e S8UELzzIAsC95gxTNiuYi8gHXKIMkYraoy6C/ztE+Am+Xg8bUVpPqH7gjOqRQK1kgqBbBgWmv/q I57y/zXjTj4vWR7/p0l96QtI5mqD7Cijmgnn3VOzVkN0d/iVku9PV0afEUgyN3zBortrLRMpYSy
 SXb7gt303kmpZd37AW7c0uSerih0d7GklMBdrqXX/NzUmHYZ5uRg6k2YJieK/ZSnGDQVKvts



On 5/5/25 22:36, Chen, Yu C wrote:
> On 5/6/2025 5:57 AM, Libo Chen wrote:
>>
>>
>> On 5/5/25 14:32, Libo Chen wrote:
>>>
>>>
>>> On 5/5/25 11:49, Libo Chen wrote:
>>>>
>>>>
>>>> On 5/5/25 11:27, Chen, Yu C wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On 5/6/2025 1:46 AM, Michal Koutný wrote:
>>>>>> On Mon, May 05, 2025 at 11:03:10PM +0800, "Chen, Yu C" <yu.c.chen@intel.com> wrote:
>>>>>>> According to this address,
>>>>>>>      4c 8b af 50 09 00 00    mov    0x950(%rdi),%r13  <--- r13 = p->mm;
>>>>>>>      49 8b bd 98 04 00 00    mov    0x498(%r13),%rdi  <--- p->mm->owner
>>>>>>> It seems that this task to be swapped has NULL mm_struct.
>>>>>>
>>>>>> So it's likely a kernel thread. Does it make sense to NUMA balance
>>>>>> those? (I naïvely think it doesn't, please correct me.) ...
>>>>>>
>>>>>
>>>>> I agree kernel threads are not supposed to be covered by
>>>>> NUMA balance, because currently NUMA balance only considers
>>>>> user pages via VMAs, and one question below:
>>>>>
>>>>>>>    static void __migrate_swap_task(struct task_struct *p, int cpu)
>>>>>>>    {
>>>>>>>           __schedstat_inc(p->stats.numa_task_swapped);
>>>>>>> -       count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>>>> +       if (p->mm)
>>>>>>> +               count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
>>>>>>
>>>>>> ... proper fix should likely guard this earlier, like the guard in
>>>>>> task_numa_fault() but for the other swapped task.
>>>>> I see. For task swapping in task_numa_compare(),
>>>>> it is triggered when there are no idle CPUs in task A's
>>>>> preferred node.
>>>>> In this case, we choose a task B on A's preferred node,
>>>>> and swap B with A. This helps improve A's Numa locality
>>>>> without introducing the load imbalance between Nodes.
>>>>>
>>> Hi Chenyu
>>>
>>> There are two problems here:
>>> 1. Many kthreads are pinned, with all the efforts in task_numa_compare()
>>> and task_numa_find_cpu(), the swapping may not end up happening. I only see a
>>> check on source task: cpumask_test_cpu(cpu, env->p->cpus_ptr) but not dst task.
>>
>> NVM I was blind. There is a check on dst task in task_numa_compare()
>>
>>> 2. Assuming B is migratable, that can potentially make B worse, right? I think
>>> some kthreads are quite cache-sensitive, and we swap like their locality doesn't
>>> matter.
> 
> This makes sense. I wonder if it could be extended beyond kthreads.
> We don't want to swap task B that has no explicit NUMA preference,
> do we?
> 

I agree, at least that should be the default behavior.

>>>
>>> Ideally we probably just want to stay off kthreads, if we cannot find any others
>>> p->mm tasks, just don't swap (?). That sounds like a brand new patch though.
>>>
>>
>> A change as simple as that should work:
>>
>> @@ -2492,7 +2492,7 @@ static bool task_numa_compare(struct task_numa_env *env,
>>
>>          rcu_read_lock();
>>          cur = rcu_dereference(dst_rq->curr);
>> -       if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
>> +       if (cur && ((cur->flags & PF_EXITING) || !cur->mm || is_idle_task(cur)))
> 
> something like
> if (cur && ((cur->flags & PF_EXITING) ||
>     cur->numa_preferred_nid == NUMA_NO_NODE ||
>    !cur->numa_faults || is_idle_task(cur)))
> 

This implicitly skips kthreads, probably need some comment. Otherwise LGTM

> But overall it looks good to me, would you like to post this as a
> formal patch, or do you want me to fold your change into a patch set?
> 

You can fold it into one set.

Thanks,
Libo

> thanks,
> Chenyu
> 
>>                  cur = NULL;
>>
> 
> 
>  
> 
>>>
>>>
>>> Libo
>>>>> But B's Numa node preference is not mandatory in
>>>>> current implementation IIUC, because B's load is mainly
>>>>
>>>> hmm, that's doesn't seem to be right, can we choose B that
>>>> is not a kthread from A's preferred node?
>>>>
>>>>> considered. That is to say, is it legit to swap a
>>>>> Numa sensitive task A with a non-Numa sensitive kernel
>>>>> thread B? If not, I think we can add kernel thread
>>>>> check in task swap like the guard in
>>>>> task_tick_numa()/task_numa_fault().
>>>>>
>>>>
>>>>
>>>>> thanks,
>>>>> Chenyu
>>>>>
>>>>>>
>>>>>> Michal
>>>>>
>>>>
>>>
>>


