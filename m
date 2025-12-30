Return-Path: <cgroups+bounces-12829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A8CEAA5A
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB45A302EA17
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E52288CB;
	Tue, 30 Dec 2025 21:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9rieosQ"
X-Original-To: cgroups@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93B20C488;
	Tue, 30 Dec 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767128843; cv=fail; b=pMp6VmgR3SR7Yb7Rt5pu6MLYq3pC2MkuXVlwFpp27NmnYfdSf0Xpyh8FH2pPY/is3smRHL3wm1oPIMceukdPdycB9ZBbLxyU4XGiXbKuzULw9MxeYR/Rp8YvGsj1G1k48jdkduz5R04DTcDkNSIGSax14NFd9cVLYTJNA82TOKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767128843; c=relaxed/simple;
	bh=Gb86lsAKUEiv13c9rQgUfigLiqI2rizXysHUJaEQTqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJ4NAK+kAPOhooOUltuY5LEGXygvPc+hlLydnehcHAkjSmKG6CYJed63hXyDhqFTFsvU27hdg9SvyYxNSB0H85MgYcuk8jxrIP4dVBJ236SRSMgGIhZCPYae/ZFRUzLTOosdIGjuM6gP4HItz/6kHDzABTYXjoOTrkAImG3Wl9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9rieosQ; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnc7oK+IlQ4mjJact/T26fDwNx3p8g9i2Lhzbt7WX5sgFrNuAvAZL+PmR5/rLVB9Rp8RAnxd2sKKy2z0Rz6iNPRIGjxJqEYzdFuG4+WfHqOwvhh3B/85pkO6SWcXLdKwtrmW5mR+rZVk9m0hnCOnc2tTPUNY0Jjqtx1eKI8RItnCpXlriqDE+oa7C5f1l+NiDq8zvf/UpwlQ6KWFBo8QH+etum5cqq59zBItcUQroFVbuTwUBH87aCE1yHn0R6qD6jXql7GdQlJC3etMnMat3Zo99ucEuwtlUQCPorHc+OK1CRXL03fcjvyap7bpseIowvnJRi6JekWgX+Lk47pqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFbOaQVdVK9UeYMQp7lt4oT//F1dVK1lxMWZv5VfggA=;
 b=Z/B4X7YsLxPtKHY/PerAE4l1joYpGbSafAH010ccnmMsxuPDJ8nkuruOlP/rkqRCUVig6rPon9jgPGh+n93F7rsnIRVD1BKMIF5E5L/rJCkWgF8+M2J7WxUvwSFWOJZEHONPCbDhpLvn6xFMJfNbA9UmUhVdYpgVNENnvJE4jw7Mfu5ejbzIov4CV3oxM5t6zufCQidvzerYHDai/nkSlCAtBHxSDOAN7q82LTPkq9/7AH16e8ibmFVXQXvdHK5a+mX+F7igVerDSlGaZ69He7909N2aCnglujhjT8kib+Yhgr9LF+kExqL7nO5ocVwVHot1l4J7jadtavOCx+usog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFbOaQVdVK9UeYMQp7lt4oT//F1dVK1lxMWZv5VfggA=;
 b=R9rieosQ3oFphnJbo3jcCwgmBWXyDoslBNnZDVkzMTHr0AZyiatgvafbexVefs1+XwOMUwPZsBRtFjGcLkcNXP+j0tM6kc01mScQDUQzOiwlC910bG+vfd64iy/AIxTsMMF49lVSU9Fq5ciKz5jKgxUGmxZ7s/CWcLnhxorNxe+FFRgOfLKzsOJsScSrEfc+GBuwpgm/0S9pKxcpYJtimbKPzC+aFydw2w1oLmS9SiNl0vixGMIZpLf/+EfSIQ+BtQQdTbKVoK2xojaPwv/PPjQUq1LC8Ws51q0G1oHBvWgZCiAzvOqjBj0O1pah+ko8Egr2KtrzmN7Hq+6hjwY52w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 21:07:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 21:07:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Chris Mason <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Date: Tue, 30 Dec 2025 16:07:15 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <94A9CFB6-458B-4EE5-8C52-C27C99EF19E5@nvidia.com>
In-Reply-To: <59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev> <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
 <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
 <slvvzxjhawqb5kkgfe2tll3owxjwtq2qkwd7m3lmpdslss73lo@hkewnkbik3qr>
 <59098b4f-c3bf-4b6c-80fb-604e6e1c755e@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 095e2c4c-038b-40eb-be37-08de47e76a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUNtUkZBUXNTS0lOR3o4c3VDNTZBZGF5NjR3WnVydW8rdU1Xa0FadjkxYWZL?=
 =?utf-8?B?SzUwanpOR2IvTXBNOWRudktDcXVjUVBVeU5JSUR6c1NrWUYrNFpQb0Z6Mmpo?=
 =?utf-8?B?WmR1cDJDZytMaWhiUmxobHNkajNYb3ZaQ21YOGo5ZGovZy9KOG0xd3E4OTI2?=
 =?utf-8?B?T1lLR3h4R3BNWG5CTHVBU1ZSTWV0NnBrS2pOcmxPU3RtQngvVXNnSFl6NlNn?=
 =?utf-8?B?eXk0V1N0K3RIOHpaZksvbWlFd0E4YXFaNG1hWjk3aFMremZCTTdzYlFsdkhR?=
 =?utf-8?B?cE9FVkpvSUpSRTFqd1NHdUhVcFJFYU8vSjdqU2pLUXd4TG1peDNmekpYdnYv?=
 =?utf-8?B?d21zR1NudG00UGtpb3J5YzFzNWNMLzA1NEYzUG1YeDBVVWU1SkNyQk03bkxF?=
 =?utf-8?B?Nm9maXVubE9mWXdJVUtGYmJlMFZUQ1doOGxKWnpuSzJWcEF0OFJ4OTBjeDBr?=
 =?utf-8?B?VTZJemdjaGltd0FDZ0M5ZmtUY3llRE5LUnBMYW9JTmdsaEFvV1VPRHRKa3pJ?=
 =?utf-8?B?ZWVyWHFpZHU3MlVlYXh6TVUxa2NBUXg0MlVUak9pa3ZzdHFLRXdUOUtYQUEx?=
 =?utf-8?B?MjVYZytrcFlKN1dpaWZMZHlpd3RXT05iTVdubldXYnN3NXNaNXdLNGswRmtL?=
 =?utf-8?B?dWxpcldBQmNpUHdwWngrVmw2NXE0K1J2bTZIQk9mNGowcThQT3EvR3JqR3l3?=
 =?utf-8?B?aXY2SlRmOCtIUTdDMDhmUlgzcXpkQm12SW9BenB2bFlCKzVPeWRSaVdNcXpp?=
 =?utf-8?B?Q2JVSjVkSXVGb1Jwakwzb1dHN3JxTnZaaVVzY0JCSDZmNWVtYVg3S2NOTFVt?=
 =?utf-8?B?ZGliakZKUVA2dW9JbHhadmQ5VTRVS3pUNjNham9ZQitBV1Q3Vzc2UGVxbEFj?=
 =?utf-8?B?SUE5UnJRUTZuV29ITmlQN1VxdERZeFYycHNjamZEdHp3WUJtT2tnZXQ3MU9v?=
 =?utf-8?B?VHlGbUhibVNZSWV6WCtocWpSRU0veHgxYWJ2VVFOb0cxVFFMZWpaSERsZThT?=
 =?utf-8?B?RGZGNXorc1pBcXA3L1RlbUJhOXRVVGtiOG9vQjhMektHV0p2dkhReEpacFB1?=
 =?utf-8?B?VFg5eFBJb1VmSFk0NW9pdzNJM2lqemd4LzdKVjQ3TzNUenhzSWg4Rnc5bjMr?=
 =?utf-8?B?N1lJaEZ4SDc4M3hGQ1FjRGpsTzdSc21zUXRnektsQzdFM2F4MnBNR2pNaWhZ?=
 =?utf-8?B?VklSMDhlaDNYQTk3cUxvSk9xcmF4MEJFOWovN005akxBQ2JmSm9qUlVmLzN4?=
 =?utf-8?B?NTdiUUVGTUdDTWc3clpndlZqL05NWERyU25QNWs1TFA1WWxoUEVFR1E5QzNF?=
 =?utf-8?B?WjFzWnRocUxVN3ZFNXFDQkJURGlJMXVWMjE0RGVnbnV5VHg0QWc4dGt5eUdJ?=
 =?utf-8?B?WXpQUVpjM1pzZXVVcXJHcUZ4VUVHVCtuVTNYQlRYYXBOSStVc2pCSUdsYlNk?=
 =?utf-8?B?VUJKd0dJblVFbDAvUHBDT0xwTnprekdUMENzb01sR0hvN3V6RlNSUk1SN1RY?=
 =?utf-8?B?RXdZUzEvT0ppNU1DM0lFZnB4cGJnOVNKR25pNFVGTXJVZ0VRMC9IeFFtWFhT?=
 =?utf-8?B?MmNyYjJtRGJxT2g4U2FQTy83Mk1VelBZcWl6aDN3cXBDdGFEVlpUbEtnVENI?=
 =?utf-8?B?VnRIbXZDYkwrQ0cvTmtCVGFlUDhZMmhlQWJwenNGT3E4c3FBL3ZpNXR1Z2hL?=
 =?utf-8?B?ZmJNcmJjZ2pIQ3FPOGp3OE1tajZUdnhxV0I2QjI0N3Y3UEhLUTFMV01XZCtD?=
 =?utf-8?B?SUd5bVlOSDJrajl2MTBPWCtvbDUyQ0tuQkJFR1lzY3lrb1NuNDBXZ1JYYzRM?=
 =?utf-8?B?cGhSOEl5L3MwSU1SVzViWEpUc2VGOUpFb0dheGxSN2tMZjk0eWdicTlFbm91?=
 =?utf-8?B?aDdUcjBhRVMzQ05kTEhEazhsZm0zbWpFcjVFNVRPVW9XVFlRRGxvcURjbXFj?=
 =?utf-8?B?bUlOaGFMeVNPMkNZVlp2b3NzM0J0SGZWdjBoTG90VUxGN3BjRnQ5UnlnVVE5?=
 =?utf-8?B?c0lKaUEwTFdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1MzZGRnUXcvdnRQdFk5b3lic0JkdDBKMmxkSUp0cnFMV0drRWtubU5aKzhF?=
 =?utf-8?B?ZnIwRVc1aytFMzJTVEQ5ZmZKTkZGdjZjdkRJR3RjZXFRRXJ5cExrWUV3cm5Y?=
 =?utf-8?B?bjZyblpBelNucDBrYUdmdkdSTXBnQkozUjIxWk1sQ3NqbEdyQXN0MWxuaGVv?=
 =?utf-8?B?RW13aTJ5UE1GZGd5WnN2bnVOTVYyZTM5M3dQUG9OVHFiT3dpaWd4QTd5QWhp?=
 =?utf-8?B?bjA1SHR6aU5rNGpVMjhYTGk0ZHpVQzdPWG9OaElkZGswQzF0a2k4RHFKV1VJ?=
 =?utf-8?B?aDlDZ0ZaWm00MjNNTWlIdnJOQlZmY2U1V29SWEZRTFRUOFA1VmhiV212Mm1F?=
 =?utf-8?B?T09rOEFIVnF0MFhpeEEzd2pYbThVeitLWGg4aURJYlZOcit0b2hGbUM0eFhs?=
 =?utf-8?B?d1Y0Tnc2bmx6NHpaQ2tKSXNOT3JWQzYrTnFyTWsrbnIxQk1YZUZ2VGNvbjVB?=
 =?utf-8?B?aHNFcDFqOUZTcWFlakUrYjJCejZIRjJwQzdtdjRaZ1lOYUNlUXIyR25McXE1?=
 =?utf-8?B?SWlPTkZtTTFLUkhjZm9NMk1idFN3cFpCb25mall4WHZlMnNnVXNkVmEwOGw5?=
 =?utf-8?B?T1BRMktadkltYytqbEt2VDA0THFVSFN2ZjZhMUowZ08welN3N3lmcUp5Z21I?=
 =?utf-8?B?OE5ldmVKdUVXOFpTekFWRkxvL0Y2RXV1dTNrOEJ1Vm83bHpmalFXVmRYOXZi?=
 =?utf-8?B?Ym0xckhDT3pFSW0vdTUwRitjWEJNZnhuZjdyU2dsMUgyQ042Vm1IdmYzK1BM?=
 =?utf-8?B?c0MvUk9hWWxibE1SWjQ1Q3J2UXdibUZab1FYblZqL2p5SVFidW5lTGNHclJX?=
 =?utf-8?B?K01OVDRzc0xJNi9MdlVmd2dWbGlJSnNaL21mc0ZkZTFVdUw2cU00M05HdU5h?=
 =?utf-8?B?MFQyTllzUGFob0pCS3Z6ZFFpLy9lT2RicEtKbFlRTTR2V1ZkY1NiaTZSNmxt?=
 =?utf-8?B?eFd2Vk91TXNyQ3I1Qk5DblFsekd3NWFKeFUwTWVvTmxsTDE5Tkk1YWh4K0FD?=
 =?utf-8?B?N1RpQW83VVo1bnB4RWh0U2JEUGc4ODBWYXZVRjJYM3cwMnE0N1VjeTZ3ekFZ?=
 =?utf-8?B?N2dDZG9ReU9QTDhUMG9mUzd5c0RZRlc5STdRdUhFaloyTmNwZjVtZTJvcm1K?=
 =?utf-8?B?MHhjS3psbjJUQVI5TVljNW5oNWwzYW5OU1VlaWJpOGtSbG9YM3c4OS9CS0JW?=
 =?utf-8?B?elEyRk9IUHBVWk5BVDhJSGtDZkJCV3BYTjEzRlh3Q1ltc05JbEJhWDVRc056?=
 =?utf-8?B?T0ZqRnVoazF5V3RaMkIyTUp2K241QXBWWXl0bXJvamtZR2pEVXVyQmZCM1BE?=
 =?utf-8?B?Vkc0bXdRMEc1cGxNdU80YXlwTldpQ1hDeGd0bVlEQ0puVXRnRS9LeXVadGlI?=
 =?utf-8?B?b3RDVm14VSt0YXVjcW5NVTltQ3RQSlJ5THp3OWtGRURWRXFtRkRUeWYzSG9l?=
 =?utf-8?B?RDI4aHVaUm9IOFVYNCszZUVveG5MWHorVlYxN25XcW1NMS85UmFKMFZQVTlV?=
 =?utf-8?B?M2tIb1VwSUk4bDhTUVlEdUdVaWJSNTBzL3Vrc2RXNXVKSUJLZ2M1ZklmMHFN?=
 =?utf-8?B?OFhQYUtkckhka3ZrVWppek1XU1BGZmplSDhpcEw3VEp3NXgyOFZJMU5qbWNi?=
 =?utf-8?B?WHMrVTJ5S01wM1FWazFjVUR1MUJpRlM5T2o4M2pkaXZnUDVIUFdpV1RwekFt?=
 =?utf-8?B?ZnRCcThNM0M2TERGN0N4QkpWYkRsbXp4UFF6a0lYUzZvQXhEaDhtbC9LUkhW?=
 =?utf-8?B?eFBUTjA0dEZGTWNTZjh3OXlUTUJsMlFyYnp6NCt1Y21sZjRjWXpOalBEYUJn?=
 =?utf-8?B?cWkrMFJEOEpkZy9QZFBra2NWeTB2WG5xczJnMU13TW95MjI5WjlHZ1RSTUk1?=
 =?utf-8?B?b3JjVFd4U21YZjZUaE56MlpDTW9McHFKWnNtNkxHdndvTUZzWjZ3dmJRdXZi?=
 =?utf-8?B?MWJaS2ZjM2t1bU44T3gyZDU2SzlDcGVPYU9kdC9vM3ErWUhHN0lOM2FRL3Br?=
 =?utf-8?B?SmZHSnRQV0g3VXMrcTFDaitBUmdNa0VSRGk0ZVJkM3BKZXhYRnpNWWRMU2lt?=
 =?utf-8?B?WFNsY3NRWDJxbGhoTDRKRjErQlpDMktUNVk2VHFkYXN6R3hrWTZhNEtiY0Zx?=
 =?utf-8?B?T09BWVRBOWY5cXl1bHhVNjh4RXEvZ2VFK0FPZmVQVzl3MXZ3NUVJMUt0dEM5?=
 =?utf-8?B?Um5oNmM5cHhCVlBkeGg0dEN6eTVJZzRvVFdOWGZoUmhGVE9MRk5jN1ZyakEz?=
 =?utf-8?B?bEJWSEEvcFRYajBrY0RyaWFRLzM5N24vRDU5UFp6L1hiMll5eEM5c2U0Tzdq?=
 =?utf-8?Q?+1sJKggjHYrsB4tJrD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095e2c4c-038b-40eb-be37-08de47e76a46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 21:07:18.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVpNWJ7prwZQvFFnD93H4sIx/io8kAejn++EBn0yy0dQkDqIlsCk4XoaK5q8riBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394

On 30 Dec 2025, at 14:18, Chris Mason wrote:

> On 12/30/25 1:13 PM, Shakeel Butt wrote:
>> On Tue, Dec 30, 2025 at 11:46:02AM -0500, Zi Yan wrote:
>>> On 29 Dec 2025, at 23:48, Shakeel Butt wrote:
>>>
>>>> On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
>>>>>
>>>>>
>>>> [...]
>>>>>>>
>>>>>>> Thank you for running the AI review for this patchset, but please d=
o not
>>>>>>> directly send the raw data from the AI review to the community, as =
this
>>>>>>> is no different from automated review by a robot.
>>>>>>
>>>>>> Hi Qi,
>>>>>>
>>>>>> I don't know why you're so negative towards it. It's been great at
>>>>>
>>>>> No, I don't object to having a dedicated robot to do this.
>>>>>
>>>>>> finding pretty tricky bugs often missed by human reviewers. In no wa=
y
>>>>>> it's a replacement for human reviews, but if a robot can find real
>>>>>> issues and make the kernel more reliable and safe, I'm in.
>>>>>
>>>>> I just think you should do a preliminary review of the AI =E2=80=8B=
=E2=80=8Breview results
>>>>> instead of sending them out directly. Otherwise, if everyone does thi=
s,
>>>>> the community will be full of bots.
>
> I do think it's awkward to dump the whole review output for the patch
> series in a single message.  It looks like there's a sudden jump to XML?
> It's better to reply to the individual patches with the comments
> inline, which I think is where Roman is trying to go long term.
>
> With BPF, it looks more like this:
> https://lore.kernel.org/bpf/?q=3DAI+reviewed+your+patch

These look really good. At least the patch author can easily see the
feedback.

>
>>>>>
>>>>> No?
>>>>>
>>>>
>>>> We don't want too many bots but we definitely want at least one AI
>>>> review bot. Now we have precedence of BPF and networking subsystem and
>>>> the results I have seen are really good. I think the MM community need=
s
>>>> to come together and decide on the formalities of AI review process an=
d
>>>> I see Roman is doing some early experimentation and result looks great=
.
>>>
>>> Do you mind explaining why the result looks great? Does it mean you agr=
ee
>>> the regressions pointed out by the AI review?
>>
>> The result looks great because the points raised are really thought
>> provoking and things I have not thought about when I reviewed the
>> series. The lru lock without irq or the possible infinite retry loop in
>> get_mem_cgroup_from_folio() are two such examples. Are these real
>> regressions? I am not sure.
>>
>>>
>>> If we want to do AI reviews, the process should be improved instead of
>>> just pasting the output from AI. In the initial stage, I think some hum=
an
>>> intervention is needed, at least adding some comment on AI reviews woul=
d
>>> be helpful.
>>
>> Yes I agree and therefore I mentioned we should discuss how should we
>> (MM community) should adopt the AI reviews.
>
> What tends to happen with BPF is the patch author or bpf maintainers
> point out problems with the reviews and I fix up the prompts over time.
> The false positive rate is ~20% today (measured since late October), and
> it's generally declining.

Yeah, I can see bpf.md contains more detailed rules compared to mm.md.

>
>>
>>> Otherwise, it looks like you agree completely with AI reviews.
>>> In addition, =E2=80=9C50% of the reported issues are real=E2=80=9D, is =
the AI tossing
>>> a coin when reporting issues?
>>>
>>> When I am looking into the prompt part, I have the following questions:
>>>
>>> 1. What is =E2=80=9CPrompts SHA: 192922ae6bf4 ("bpf.md: adjust the docu=
mentation
>>> about bpf kfunc parameter validation=E2=80=9D)=E2=80=9D? I got the actu=
al prompts
>>> from irc: https://github.com/masoncl/review-prompts/tree/main , but it
>>> should be provided along with the review for others to reproduce.
>>
>> I agree and I didn't know that Chris's review prompts are used here.
>>
>> Ccing Chris for your following questions.
>>
>>>>> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompt=
s/blob/main/mm.md , are you sure the patterns are all right?
>>> 	a. Page/Folio States, Large folios require per-page state tracking for
>>> 		Reference counts. I thought we want to get rid of per page refcount.
>
> Early in prompt development I hand picked a few hundred patches from
> 6.16 fixing bugs, and I iterated on these adding subsystem knowledge to
> catch the known bugs.  That's where that rule came from, but as you say
> there's a risk this information gets old.  Do we want to get rid of per
> page refcounts or have we done it?  (more on that at the bottom of the
> email).

willy has covered this part in another email.

>
>>>     b. Migration Invariants, NUMA balancing expects valid PTE combinati=
ons.
>>> 		PROTNONE PTEs are hardware invalid to trigger fault.
>>> 	c. TLB flushes required after PTE modifications. How about spurious fa=
ult
>>> 		handling?
>>>
>
> AI generally uses them as a starting point and fills in details, but
> I agree the MM bits are pretty minimal.
>
>>> 3. For a cgroup patchset, I was expecting some cgroup specific prompt r=
ules,
>>> 	but could not find any. What am I missing?
>
> I think the only cgroup specific information I've needed so far is
> explaining css_get() and the section on __GFP_ACCOUNT.  I actively try
> to avoid adding details unless we're missing bugs or generating false
> positives.

I assume your review prompts are mainly used for BPF code, so it is underst=
andable
that there are not many MM rules. My above concerns are mainly on the promp=
ts
are directly used on MM patches without adding more MM specific rules.

Ideally, each subsystem could maintain its own rules in the corresponding
file to get a better outcome. :)

Best Regards,
Yan, Zi

