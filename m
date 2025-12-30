Return-Path: <cgroups+bounces-12821-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26135CEA369
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C08302489C
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E1190664;
	Tue, 30 Dec 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOP289Sg"
X-Original-To: cgroups@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A8B640;
	Tue, 30 Dec 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113173; cv=fail; b=YaXgOGdo6Rm5DVJo+t6ZT+c0XUCDDHYXg35E94ZgoFC8ewPdaKrFDgz05Sp1zfSpcMwIxy2SG+obgfJDOfcQfj+hYdwR2IFg9ONDlr+hURxyd6OxACSXJ03/brHlQna93U6reeR1epW1/Du31xTlA35ALFzureUnMcVDWuKQJnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113173; c=relaxed/simple;
	bh=3N4Iiws8mJndGhuXJyaO9Mx+AHHBJM8F4TnpwkUyLNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IjCbVaZslkC8v6kUNgPRfFVzbioVMD4kdara6togdfTgQnmPKIdV1gmNRKRHqjUSzldJyGGs4tLWikj2d/lUB+ukqYJtzAgnP3E2evnOpOSgVAtxUgQnI6cLRsarJAi8eo2a7avTMfAlF8hd76dgw+zjSTo1XIJw7/4vhB14vlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOP289Sg; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H23TxKxwKjWoMDZxG/1Q3pqRlGAevAUYNRAUXTTyGaE4Vy1O1X1GnCFoh97udWXstDerVtl0tOrRCCgBLPE1USrrvXDTL5rWvqtPSmILG6dPOqLUay4+9jaVBDekmNRFVVenGuyaVFqQda7/UVItofIW2OWZknxS6YC8fR7Dk8EFmEw+xTWILPCWNN30dfqWrznDoJn511c9XkZPwkoOCFE7cysTnO8RD46dUR7uptkH9Y/SWQBygSTUIkfjYI8zLiySwnkb2Wkiro85+9brMSTc7Viw0RC54tpOE19rfz7gVacZaBTNOtDhB8lQkMDd4VpOSEtOWM5eB1rgS6BISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l27L8epoJcmw3kVjYD/G+zggaX6sgnau8mG0PO/jy5U=;
 b=jhic4tsvCZbKHBfqHSfxPRoXLoyDxAI9Bd16IHDtxNrGrJcGgqCHVJHRuIK+KafkSOCzZLEn/A+bk3sLvi+WJqHGo65inocl1rxPhqDQNylkqGvZXf+NAtvK/kQrr4liZIIQBhX2WRMrvb4UfrEly3HFkAHrCLrN+jUExOI+O9viHwDg4nazvsY+Eq2sovTJClLsvLwz7zLCqI+iVGQpOnFzOzt3AOCWgZYBFk8hfxf3VMG9eKVy/QG+lcqTj8DlCxdhGWCTVpzyDxkvF8JD3kTuuztZCDvAvaA0E6QBXhXC6zjjrPmVaXFZLXg610CBjQlkXmHWiNKeVQLXg+sMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l27L8epoJcmw3kVjYD/G+zggaX6sgnau8mG0PO/jy5U=;
 b=eOP289Sg7/pDH696mdfMTxdryRp2tvWRWERH7bSH5zyAunrdBQwPBVu3rOHggU82Ko1ESD12Ex+zd1Pd46BHD8pa7hRWrlZN0TBJYp+s+P4OKB9pnJ2rdZjVBNF6uV2YxuUqB6QB06xE12rsItYVozImGXM2IRzp9TN/DMP10Ejomgo7kKZMM6CaQ10KL/dH6NrdynSNQZLUOfgrc6SYNgQ9Oke270NB0SvBdaP8Y4vxhazM4nMY5C8blLvajbvhHEfaquf6EbcXGLo+2wRT/C3X5OnqtRS6/KNEwfZXsPQ0kES/zoVYP/3HJYcDSd+PeK7G4JkSj/KCmwIOvGtyKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 16:46:05 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 16:46:05 +0000
From: Zi Yan <ziy@nvidia.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, muchun.song@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Date: Tue, 30 Dec 2025 11:46:02 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
In-Reply-To: <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev> <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:208:23c::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 306bbd56-7273-4718-7ff3-08de47c2ecac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UThmVDlnNGN3K2tickR0RlBCWlIzOHhwc0tkcEkrdE5GZG9xSjZkem9jRS94?=
 =?utf-8?B?UTdzL3NKcmt4a0E0T1g5M0paT0czMG1kMzk4TlYwMlhBUCtGK1REMDZ4MVZu?=
 =?utf-8?B?V0hHR1RJaDY4TEQ1K2x0M09Ua0IxMjk2NjI4bzlXKzE1RWtubDZhS2c4V2VE?=
 =?utf-8?B?Y29oSDJYQ1dTUXQzL0hRTkRvMjhGRStlVUpDTmpIMmc3QitDU0UyZ2o0WGUr?=
 =?utf-8?B?Y1YrUHhzK1BsTlA0WHhFa3hqYUxPc1h5TDdqaVNxRC9kclprakJZTWk0VjZC?=
 =?utf-8?B?T1Nxa242Qm80V2hZZWwyZkczYUlNaUZFazZXcGlmSUg0QXZpZDlHODJQTllq?=
 =?utf-8?B?OVBNVXFhSU5CckhHbUpLL1NJTjErSDV5VGwyWm9TNTd1dEFKcDJwSG5VbW0y?=
 =?utf-8?B?R0crbk1MbGwyQ2FSbGZVQ3hKQVQ1R2RRSC9oemZqMDZBU0tIV1IvUDFEUXkz?=
 =?utf-8?B?VXd6eTd5elN4RmRJN2dOTDQzN0tzN0ErKzVzbWtqWUhRUXc5UkZhQW1CQ1V1?=
 =?utf-8?B?WnJlVDNKQVcyMzN2Tm0wYkJHbG1UQWNreHRaeVp4dCtkSm8yYmVGbXhrUkNG?=
 =?utf-8?B?Tm9KS1JibmZ2cFk1NlludXptdUpsa0N0ZGczK29WTXlCd0UxUXdTSFFUc0pF?=
 =?utf-8?B?WkhIeUpPV1FUUHR6dDJoeklwUGNwT29iQU5CVjg4UWQ3TkZKL0tRS0Z4bDRw?=
 =?utf-8?B?TWxmRWgxMDh5dnU3WTJLVDZ0YWtZMjA0V29mSm41QTROQmU3aU9ISzhTaXNs?=
 =?utf-8?B?d3J4eXo3T3pQOGtRQ2NjZFFOaWVONUFUK3M5RXVpbFd2V2lueHloWDVCNHM3?=
 =?utf-8?B?aURRMzNDbUVabTBGVnhYeEk4ODcrMkNWbTk5bXY0ZVh0YzAyYUV5aElQTVB2?=
 =?utf-8?B?R0ozWVlXRzFaeFlMYzNxYUJ4UDlGTDZ2eXMwT1ZGdXdLSW1waGNYcFV0UzRT?=
 =?utf-8?B?SmFzYmZHM2kyYmViZmZuWlhMd0owd2VQRFNlZ04vT09CeTRvZ0ZVZzRQMTNi?=
 =?utf-8?B?OWNRc0hLOXhESjBXK1BQWjlWc3JqTXRKeU0zbGtvbjBsSnRScGl1VC94UjZv?=
 =?utf-8?B?a3NraGVDb3AwbDRtTmhVYVVGN3lNMzlWZFdZNjNCK2FxaWw3WkhjdFZpY2JQ?=
 =?utf-8?B?Q2dXVitidE0wRkliNzJ2c3FHNGpaWTh4cDhsWHVLRVJyODYyMDd6RC91aXo3?=
 =?utf-8?B?aFc5aExoWGwyaE5sMHdmTTRGTnd4TVFrdEx2c3VLRWJUamd3TGY0TVd0WmVj?=
 =?utf-8?B?RktLa1hRT2IvcjE3WG1yeTVrZ2NMQzllK1U2SDJkVDY4VEdab1Q4U2pzZS9v?=
 =?utf-8?B?eWdwSGRyYUcwRXlaMEtLODhDdmozcVV3TzRPZ2ZwYmtNY25GQ3hBa3JrRVZq?=
 =?utf-8?B?TzFJNSttVUlxT1FRbHZJUkJBUHNXc1FyYVMwWFU0eEtCZjEwNWNhY21EZHhy?=
 =?utf-8?B?Njd5aGtUdFc5N0w4TlJOdE9XZzBzTXQzL1k0YVM4NzlNTzlHMW5lWEw3bjJ0?=
 =?utf-8?B?OXNIa21JaHhmV0lMSWNFYkJFVU5mbm9TUnF5clJ3d0oxSTBEb2ltWGpQR05q?=
 =?utf-8?B?K21QcHlXVHBWZ3JNa0tOQjljS3VzQjBZSHdsWHhaYVRZNS9STDZqZ0k0MW1O?=
 =?utf-8?B?eFZoUjFrT0RvM1JQaGtJcWt6UWhrVTA0T1FYTndlaXN6WTRmQ1V2QXo3NWVU?=
 =?utf-8?B?MnF3VmRwUnRVclY0VmM0SUMwQUk0SGk3aUtKOXByVFJ0RXNLVWRuUzRMOUx1?=
 =?utf-8?B?UkpUOFFad0tzSVlDYzArZTBER3JicFZaQUIybGJQTmwzeURuckduT0dNN2dr?=
 =?utf-8?B?MHZkV09vVEh5NXBFMlVtQWpTb3NjSUxOc0VrdEJTNFo1dTFaUUZhQU85dUZY?=
 =?utf-8?B?d3Zvc051ak45WnQyZlV3U0dkQ3dvd0Y5cDFUc0Z5L3Npd0JlT2hjM3N5ZGhw?=
 =?utf-8?B?SXZDN2MzSGl4akgvVjlpckE0V0Qzb0FsU3F1ZWpwbVhQZ09uQ0xnZHlVTldH?=
 =?utf-8?B?SW9ONkYrRHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWJMaW1GWlV4Z1grb2RsRUxsa083ckl3Z01kNzRoRDlFZjJxM3RQQWZVam5X?=
 =?utf-8?B?NURWTjRDejJCV3pRbDFlUXJpb2x2OUlJSEtKV2ZMWnBrdHEzeExYa2o0YS9X?=
 =?utf-8?B?SXJuY2pCV2lHSEFHMUMyTnBlMERIdUZPMVVYU3lab2RyelpzRnpUTjJDUGda?=
 =?utf-8?B?QnpVd3E0REFPcnA0Z3RMWDQyN2ZDV2J2UkRYTWdwMHlVdnlBN3ZtNGJsL3ZH?=
 =?utf-8?B?eUVXMEFQK25IVVVtUGp3RVkrTFNqVFJCVWZYMllyMGpRaTlJM29ZMmhheDlC?=
 =?utf-8?B?WVZOTjJxWEsrc3hEVGhPcHVCL2hoNGlYeHpPWXBJb2h6STdJdXNRb0taTUoz?=
 =?utf-8?B?Qm1PZzc1cEZVTXFFOTVYK3ViMXo2WHpOTjFYQ2k5akxUQjVZa3NwNjU1V3Ny?=
 =?utf-8?B?YlJ3SXUvVkpiYjNuQzhPREJabyszN041U3dJZ1JGWk1vNGJONHVJcDJvRUpT?=
 =?utf-8?B?dmh6MUtTWW1MTHA2QW5Ua01RS0psaU9mTHc2QzdZS2I2YnFUTW9CUUZYSXZo?=
 =?utf-8?B?MkdUQklGd1lnQW9uczBIdFc1eGZldkVvRHJvYXFYM1NjMUUvUkpFeWNTOER3?=
 =?utf-8?B?aWhHTmVyaXZXam10RExOb24vR3FCc0ptcUk3TjVtMHFYbEhIbDFlSWt6STNY?=
 =?utf-8?B?dVZiRVJ0VThpOVJ4YW8xbXkzd0cyWHN4dFh6WDNIb29jMkt3dE9sQjg4VE5j?=
 =?utf-8?B?dlYzdzV3Y1MwRGhYVTNDR2ptUGc2MmlhNTlpNWVHcDBreXFwOWxGTFAxeWls?=
 =?utf-8?B?QjJFOW83Q21ocVQxdzF5eGxyd0JmK2lTNzBPcmpBMmdLRTRXMnlJWCtFUkRt?=
 =?utf-8?B?a0dFR0tRdzc4bU51U0ExbUo3WXZwcnFjbE1BZ0cxdVlZbkxiOVlTQnpFNFln?=
 =?utf-8?B?MmNyNk1Fb2l2R0RoUFlYSmJxS0dKTTlIWGQ4SUNCNFRMbXNYWFZPc09LamVQ?=
 =?utf-8?B?MDFDQmtjVHRucEJ0eGg1T2E3MEl3OFdXNTBEVzJ3dmhzb0E3K0sxRWQ4Nmlk?=
 =?utf-8?B?d2hoTlZ2aTRIaU1Zb0xKc2RXY1hOMFZGL3F0Ky9YSXhaVDFWZm9pVXoxRy8z?=
 =?utf-8?B?OENrU1hsNkFPVVdaaHg2VllvTjgwdHBvWFVjbUdPQ1NuT3Z5OEZYS29mS0pn?=
 =?utf-8?B?R1E0cFdoMWo5UFVHMkRXeHRnbGZsbnB1VlhiS240OG9IcFVTeDVsZXZpT0dM?=
 =?utf-8?B?bTVuZHpNM3BPQnFLajdvRGxQYXVYMWtKYXBvTFY4WElsL2xKNm91aU4yLzlR?=
 =?utf-8?B?b1NjTDgxNk1jbFJzRXFrN1lqNncrWllheVMzTUdFSndPTHlubUc0bXNYVlh0?=
 =?utf-8?B?ZVNxT3FyNDV6Yzlscmxrb2wvZVcxM1ZUMEhQTk80eVNpRjVqQ0tkRjQ1NXRJ?=
 =?utf-8?B?UW5Cb1JoZm8zSmxLa1VYQUE2b2xHK3kxZGd2L3JPYWFZNm9seEV2K3NMZldV?=
 =?utf-8?B?MGdvTGNSM0crNWRqc1hacm1TelB0Z2VyMXRFSldkN0krQytyVldKU2tyL1NX?=
 =?utf-8?B?SGMwRWFIQXVEUXR2TVFZVDc5bjNqV092eXNiL0tlR0hDTGFHMlRXYlJ5R0g4?=
 =?utf-8?B?MFVaa1NDUytYTFgyVldkR3Q1a0NhdDhhbnJDUnFJK0FpU1N2QUZkVi96REYx?=
 =?utf-8?B?ZjRUdlNYdmg1RGs4M213U3NiejkzN2VkdVlTUzI2c1FRdmNsVjBGUDY4bGdu?=
 =?utf-8?B?Rm9MSTFScUNBVEw2NklocUIyaXJPcGhnQ09KcnJCdktKRTUrNDY5dVZ6NWpX?=
 =?utf-8?B?NDd3bGdSNzVHZFI5OEtsWm5sU3FueWdGZzRXclQwcUt2SjRhV1hKZ05yVnQr?=
 =?utf-8?B?OStDaWFhNWdEckhCQlNPaWZ1OXFnN0h1NzE5THdab0wvLyttVm5pZDFQUXND?=
 =?utf-8?B?TWJtcWV6OExKSjBGLzJLZzVJTGQyTmE2Z0N5WlQyNmxjV1pqNnRmeXdhUjJh?=
 =?utf-8?B?WVpkOVN3V09oSWZsdHlLS05ZK0xKTkRPVzVMQzFPaUF2TXd3amN5VzhyM0cz?=
 =?utf-8?B?OW9IaWM0M0pDdDFMYlhlVmNlSDZRd2ZBbEI2dEZqUHE3eU11eWo2UzU5UERU?=
 =?utf-8?B?VXY0b29zYjVIV3k4L2VPZFdkUHNCSnRwaHFVckxXL2JYWGJiME9rd25oUmMy?=
 =?utf-8?B?WXhFYWhTYXZJb2NOY0pUMnJPdnFlbVBFTXcrVnlOYWlHUDBGUnpKME1zUDNN?=
 =?utf-8?B?RG9ZanBYZHFsZ2JmekhJeWRSZDhiWXNrMXFFTmNsVGZhejRERWRtMW91ajdO?=
 =?utf-8?B?VkVubk1UME1Jc1hIdVA3bGtpVnZYVnZvZzBjeDFGT2RVaS9kVUNCM1VGY1RZ?=
 =?utf-8?Q?UUZ+XVupTyS/ZWLOwf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306bbd56-7273-4718-7ff3-08de47c2ecac
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 16:46:05.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQJ9w6wlqJwwQTJBPRQ67/otmYS94AVggkrvKyL7/kyUtP+EdMhx1R0EYNT8ervN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

On 29 Dec 2025, at 23:48, Shakeel Butt wrote:

> On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
>>
>>
> [...]
>>>>
>>>> Thank you for running the AI review for this patchset, but please do n=
ot
>>>> directly send the raw data from the AI review to the community, as thi=
s
>>>> is no different from automated review by a robot.
>>>
>>> Hi Qi,
>>>
>>> I don't know why you're so negative towards it. It's been great at
>>
>> No, I don't object to having a dedicated robot to do this.
>>
>>> finding pretty tricky bugs often missed by human reviewers. In no way
>>> it's a replacement for human reviews, but if a robot can find real
>>> issues and make the kernel more reliable and safe, I'm in.
>>
>> I just think you should do a preliminary review of the AI =E2=80=8B=E2=
=80=8Breview results
>> instead of sending them out directly. Otherwise, if everyone does this,
>> the community will be full of bots.
>>
>> No?
>>
>
> We don't want too many bots but we definitely want at least one AI
> review bot. Now we have precedence of BPF and networking subsystem and
> the results I have seen are really good. I think the MM community needs
> to come together and decide on the formalities of AI review process and
> I see Roman is doing some early experimentation and result looks great.

Do you mind explaining why the result looks great? Does it mean you agree
the regressions pointed out by the AI review?

If we want to do AI reviews, the process should be improved instead of
just pasting the output from AI. In the initial stage, I think some human
intervention is needed, at least adding some comment on AI reviews would
be helpful. Otherwise, it looks like you agree completely with AI reviews.
In addition, =E2=80=9C50% of the reported issues are real=E2=80=9D, is the =
AI tossing
a coin when reporting issues?

When I am looking into the prompt part, I have the following questions:

1. What is =E2=80=9CPrompts SHA: 192922ae6bf4 ("bpf.md: adjust the document=
ation
about bpf kfunc parameter validation=E2=80=9D)=E2=80=9D? I got the actual p=
rompts
from irc: https://github.com/masoncl/review-prompts/tree/main, but it
should be provided along with the review for others to reproduce.

2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/blob=
/main/mm.md, are you sure the patterns are all right?
	a. Page/Folio States, Large folios require per-page state tracking for
		Reference counts. I thought we want to get rid of per page refcount.
    b. Migration Invariants, NUMA balancing expects valid PTE combinations.
		PROTNONE PTEs are hardware invalid to trigger fault.
	c. TLB flushes required after PTE modifications. How about spurious fault
		handling?

3. For a cgroup patchset, I was expecting some cgroup specific prompt rules=
,
	but could not find any. What am I missing?



Best Regards,
Yan, Zi

