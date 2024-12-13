Return-Path: <cgroups+bounces-5881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 561019F02CE
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 03:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B92016ABAF
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA15103F;
	Fri, 13 Dec 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="knxKdHFv"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8522071;
	Fri, 13 Dec 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058464; cv=fail; b=CKhpAUEXMfW5LRvCUBZmzELc0TCqF/rlxa7pFdaMpb6RS+pVJBwGSuXdISK7PrOpRQee3m+fc5zMTePBLeU2aqqw/Mqhl1Om69C3J7QIapC9yl5ByrB5IABu1n6mdRtn7qjGoOXb4dAvMHJiE2A8cE0I9DMab7vzhLcCo8xBqVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058464; c=relaxed/simple;
	bh=k9glIfXyxVM+90mwOxjLiic1fRu30pDkr0NTQFE7paY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePOHcAJEasaDzuxFS+uJElfoLLajwraRFeR0tlqTvC6/bDPtiDUtDAFWf3aUBSJXWHxT37l2Ec/dnNPZ7Wi7TT73xZy4NZFlaEF+QVt1u+BAH8XF4RpG30yodnN4zUm1052f8tq3hB4DRAqRS+m7mDbMJKiTh4rogmC7jaUcuAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=knxKdHFv; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L05/sDuEZR1gB8NjBPbsoYDbx87qpgscg09l9kBAaaWHy4QDnRDHlXUkdgqREQbH9iQPUXle3wkx3lVZcxqQ6XIplh+5L6OAGiZbDuacwBy/WOiedcpp/i92z+sI1dOi+WYLxB7lhW05klXRQmITqqF6lrOt3AbCKRj6RwYwZcHL5j9AF9bLb/J2MQ3Nq+07+5mYDQG7LO3BkiUq0xPueMKH0QVLv+nOZI3nrjhL32EtZI7zdM9u7rlGhHWDxUlDxWKP8MWHaYAydHCYHpGulV2ADTs+tHT9imlM7MHIu0LbRcKy6IT0lbQFkLWsJVF3FJdi10RAOTFfclukUz7x5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA6qeheyCCFh9PxZ2GTQKDvTw6xFLC8kscXV4Hl8GZ8=;
 b=v25qh26ABEd11ENT5lBsJjVOnfXb/mmcUZV1IFupJSnCHWzarTDNVh4xbs6G4PhcdxGGVoG3zZCgNOKXy1U4ty5nJsSJ7qxUIwdZ5f/ery2/J2rdKvaNGfOV6hunTnQ34e1RCs2tvWz6e1FiejGMyPkG90uY6lDssc2nnOsym/fPSAoD7GZsAv9VktHGId6d4T0sfPGZn8LfOhhqGzVyB0yVJ8KH12MGxPsG8z0uazoaCoivDCd8lPMN3piSQVFQ4agB6C85QoQ2cFOL/6uPY96oAcHGw0VLVHNELY96hlhCBCpPR6u9Ns0UplaGslqfP0tG/A+Zag4/mXXa8wSYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA6qeheyCCFh9PxZ2GTQKDvTw6xFLC8kscXV4Hl8GZ8=;
 b=knxKdHFv7uA9/aBKmiPU7L2OGJTluEwT8oVhwD/CUKH97DIE+GjfFiMNFGF8hJT/1yVx8qK5kwO/CQrQwzc1QeEi4aCAbq/vJ5iu9BwrBY9SNPwzuYHOQOZQiV1jP1nJokBlcTsRYbQDl6xnIyjFKWNScTqouomb1ziZDVE4rGpMx2T1fOyPkdUMnxtnZ1fg/dbGvTH0ZN1EY+rzu7ra/b40hXMvcVZ5P0zDcdUbqvIADsedo8aHkQfhae5DjZ7UrLPErW/ctCEY2GnfmZ77biYUVSlOuy6p+bzxXI0aoMdcrL7DM5LbinE/GVeYWH6BDHZhmGna24CxfPBS8v0YKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 02:54:16 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 02:54:15 +0000
Message-ID: <28af480e-b99a-447d-999e-1dcb961d2709@nvidia.com>
Date: Fri, 13 Dec 2024 13:54:10 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Content-Language: en-GB
To: Rik van Riel <riel@surriel.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 hakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
References: <20241212115754.38f798b3@fangorn> <Z1ssHQYI-Wyc1adP@google.com>
 <20241212150003.1a0ed845@fangorn>
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20241212150003.1a0ed845@fangorn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:806:126::26) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 175ade8b-1d25-43a1-7941-08dd1b216e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1RZeDFiUXVtNEwzWnYvQnVldDdyRllTQVh2RExPcWk4MU5RSzVtWU15R1N4?=
 =?utf-8?B?ODdWNGpDd2RRM1hTb2lSMzNaSWZYamNnVVFwL0Z1QlBJaElJTUx2TkVvUGdS?=
 =?utf-8?B?OGhZMzdsSzlKVElUK1VKemNCeDhJd3FVUnhQS2JhQWNSTUlhbTdkcFQrcG41?=
 =?utf-8?B?NHdvSUUxNlcxL1JDZjZCZFV3WWFmOVlIeWI5MWdwd01YcjhZdzkvdUQxWWh0?=
 =?utf-8?B?RDFkanR4cmtNT3lnQjUycjJ6czlJZVMxWG9tRkswYUM5QWF5T0d5dlpkQTFV?=
 =?utf-8?B?YlBtbWxrSW10bFNTeXZCdHBQZXJTaHpxQ3ZkSHpaR3IyTUMxSHZRVGhsR29G?=
 =?utf-8?B?VW91ZjVvQytGZGphM2t5ZHYrcHM5eTdsYmo3bS9zdThGeFdadHZnd20rVnE0?=
 =?utf-8?B?S0luc0NZZVdaSVh1TW1sc0J5TE54Z09PZlNzaXBUZ2dHUi9wbC95NVQ2M0Jo?=
 =?utf-8?B?ZkZHd1J0eXdMaXFidmwweXVZakpmQ0x2RjdSOUI4eHgxSjM1ei9VeHdSWkht?=
 =?utf-8?B?N2NzVEg2bTlpUGpFSldXM1FHRlZkNEczVTF3Ym9CS0xGVkw1MEdlbDVnaU5W?=
 =?utf-8?B?RHJneDZZK21KUEhoZzVTTnp4VVh5ZzZ6YWtIblZjT0FNRkhlZG5tUVJsMFRy?=
 =?utf-8?B?RDhxSk11bGZUeThiRDhkTEpwaE5CNHlVQWtkSkNlN0xQT3JkV203UUdqdDdC?=
 =?utf-8?B?NW1TSnNvOGl3ZndWdXRrS0NvRUlucG1Mais5QkNTU3BLOEI2YWlQUkY1amxD?=
 =?utf-8?B?V3dWR3lVRHl4THduOEN1TFF5RFdCTGVjQXI0Z0xWQXNic0JwUm5VSlpLYTRy?=
 =?utf-8?B?TzhWWVNFUkJSSHhLbDlXdng0QXM3REhLOFQvWEpGdmpyVkN4ZXNvNHlqejRI?=
 =?utf-8?B?S2NNQ1Q3MWxVaWN4NWdDK2RodEN3RWhZWWpENHRldllHR2VtaDVwVlllb2Zv?=
 =?utf-8?B?NWhwSVFIcE14Ym43NnhNbndaNk5iNjhYeWsvbStWMXNlRkFqU2s1Ym1jcHBQ?=
 =?utf-8?B?S3R3dHZyQ0lxZG1kTWxXQlVKdzVYekdZRHdiMDRpWEcxM1RBQmNjR1E3TUJJ?=
 =?utf-8?B?b0lqNnZMYXVNNHlCRDBSTU8rOVVYRHEySUhrUWNhektYb0VQMGwyK1lDWkNY?=
 =?utf-8?B?cFNjVFZwRUJJQS9aczQ0d3pDYUlMdEtoOWxrV2toRnByeHNwck1RRE0rV21C?=
 =?utf-8?B?MUtvblpTT1VMSzFGZVdMYUkrVHZxMndkek1FeHgyQytnWUNtNE5ZUWJzK0hv?=
 =?utf-8?B?TWpBSlBiMWM0N0RITWlXblVqRXQ1UkZuSGNaRXp1NDdXYS9Fc29ua3o4TWV6?=
 =?utf-8?B?S2VxR2E5NHJRUmI0S3E0NitFRkZJb1VpUmMzNGEyM0tlOXpQM1RJSmpzZFFm?=
 =?utf-8?B?UWtIbWRiUFZvNnVNZStLQWxKbktzMFB6d2lRL0J0a3BLSEl2b21wbGQ2NkZo?=
 =?utf-8?B?d2diVUxMTU9OV01COFg4RlVVekNsa0Z0bHR5STVkRE5zZWczR3hmLy9hK1Np?=
 =?utf-8?B?ekdJSGFHUmZORFhuY1JtVm9sQ3dycWZUa0V0MFR3SlJYUHAwYlBoUGJLMXQr?=
 =?utf-8?B?MTU3bko5dHB4VG8rdVR2UCtnZmEvWTMvWjJ5QWNlaUJNY2o0OUZvOGFBUnRC?=
 =?utf-8?B?UW5NbmN4R294TzB6ODZSWTZxbm1PdDNTSFprZ1NTQXV2clBTUXJBb0pDd0dv?=
 =?utf-8?B?elpyM0lMbXBHYzZXc0NrZHBzVWw3SUdVa3Z1TGkvRG9wTUZCTGFaVTdpTzNs?=
 =?utf-8?B?eWRJeDk1UzlMeEwvN2FxelVkdEdvWjc2Q2tVbU9DcW5OZ1ErYy83N3BNY3RN?=
 =?utf-8?B?SmM2ZHVTdWZTWmNEOVhxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmU5bzVOaCszclhkYVdYUnFBcitwWEF4VzREMWhpZzMxSEtYWnRrYndTYlVu?=
 =?utf-8?B?L094Yi8yMnVIU2EzYjI0NE1razVnUXJvbU5lUjBaL2ZDSzA2TUw3KzlTemtR?=
 =?utf-8?B?REhxYitJM0tXWlpuc01hcW9GMkFwRjVYNnIwYlFHWGd1bFJ3czlPSkR3aThE?=
 =?utf-8?B?a2N0Y1BQU3F2Q1dORjNUT3dkR2M2L1NiajZaMmNsY1E2c2pZWkd5eTZrcXow?=
 =?utf-8?B?YjVPL2tUbWFIY1phZFpkaW1nWHFjWjlhV0NuRThLRlgyQ3VCOUVFc2FiOUZK?=
 =?utf-8?B?VmQvZ042SExQUWQ0MnhjWHZHRzljSGFvNGhETmpac1NzSTFUWkFOaHpzQzVK?=
 =?utf-8?B?bEpJeEJwTjJJWmJEdk1Vb1FkSXpwV1hVb1VMQUgvSEs5UU5hS0JFRFVlMzNr?=
 =?utf-8?B?ZnpWcWE0c0hhdGZzS1gzZUtnemlTd1phdkxjdDkzakVDZHl6cldNbVRubXhr?=
 =?utf-8?B?YmRUQ3RxTjM2dGM5VkNJNnVDeW9HbTQrclB3eG5TOXpaSEcza1VNZkhVNWpH?=
 =?utf-8?B?RFhuQ2EwbExuT1ZHQ2tmQnd3NDB2UXpTVnJieXN5ZGtTSXh3V2VmRFhCbDNz?=
 =?utf-8?B?dnZMQUkrTStqdmJNMXlFRElLZVlrZ0RDL3RmMHFUaGQvQmRzTmUrNjdnMW9U?=
 =?utf-8?B?Y1UrM3ZiNGRFRVVyR0wwaldLUnpES3J1bkRVdTdqWnlnNzVURjRZZmU1Vmdp?=
 =?utf-8?B?aXh1MkVZcDFYZEtCMjhTWUkrU3hCRCs3VUdCaDd1WFRsRUkzVkhZczAwaW01?=
 =?utf-8?B?KzNHdGMzS1dvdWNSTWF6VU9hcUpCZlZHc1NoT0VvNXFwTVNMTUtYYXBNMXR5?=
 =?utf-8?B?TGdsOW9SSEdMUmJVN0JtY3FnZzREUFJWOHVKTWp4WFMrOHpVdTdSZllRamJ6?=
 =?utf-8?B?anNNZStWRGsrZllmMG8xM2dEbUo0M1J0dDc0NTVaSHg3clIvek40WUxldk5Q?=
 =?utf-8?B?bm1rMytQN3hxbnFHbGM0eXRVQ0lJU2JxSXM4bVJSQ2REdEtYMEdyZHJmYm9q?=
 =?utf-8?B?Z1I0aitjSHI4MUY0NDl1cG9LaEhFZnhaV0VXRHozRlVUUHFXSFJtQ0hhSmt5?=
 =?utf-8?B?ZmFXc3JpMi9VUEdEUnArbFBFcW5ydWtRU2EyY2g3QWhxTUNUTWF5RWVtM0xL?=
 =?utf-8?B?dTcxYXpySG1WbGpNUEdHTUU2RnRRVUd6WjNMRER5NSsyN042c28zczVZWm9L?=
 =?utf-8?B?QUJ4ZmFpUFRuaHp1c2o5K2kzSE53OW96RXVFUTlYSkdkSFBsVlZLMzF3Lzl6?=
 =?utf-8?B?Q0s1MXlJbjF3LzRGWEJlS201WXJLWjJuK1laTXRLNnV2S2M2V0xwRFBnbW1l?=
 =?utf-8?B?dFhqaGR0bXdPL0xRaGVOOUZYUGRFeTdXU1dtaVJtWTN6ZHB2Um9KUldYdFNQ?=
 =?utf-8?B?NTZWdTg4TUJoUTR0cWNNRXVEZmNzYXA1RUtIR2lTTEpqakJ6WkNBWUthZE4v?=
 =?utf-8?B?dUZ1WTJ0Wkd3ZDEzRloxTGVSQ1RWMW8zSUJKS2d3WTJqdGNtN1ZNUW42c3ox?=
 =?utf-8?B?NUJYMTQ3WlErS0ZmS2VobkNWNFVFV28ycVRmMXMyeWZvVWJIc0hYRVRPYUFR?=
 =?utf-8?B?akM5TnVqYS85anJkNkFYRlNpSmtlNlBXc0R4NGpDOFVwZ25SZFUveHdCeDhh?=
 =?utf-8?B?enpnb2xRTjlKVGtaRVBaU0syMmJtbWVWcWRRNjJ3TEJYNjh4WDVwbGhLTjV6?=
 =?utf-8?B?Z1JVVGMraFNURWVzQklQbU45MlhGcDVmYjZBTzlOSktrZVVuZUlUWFVZMkRW?=
 =?utf-8?B?T1NpRFJESlZGZHFLTUdKNEtJWmVDQzFuelRXYmxMeTZQL2gxNGwzL2dONGZG?=
 =?utf-8?B?SHJuM3Z3RzZDaitqV0JEK0lac3BNaHU0dGFaYzZXNnZyVEZXdVZhdGJCOVBT?=
 =?utf-8?B?THVYd3lvM05CWjRYZHhKMzgzYUtxeTJ6MlpFTGtwK29NUTVpazBCSWtQYjRn?=
 =?utf-8?B?dnhjTndjM2kxQVM5aDVHWURYdFVFNGoyeHg0eHFWZnhrZkkrRTB2UFJySjNo?=
 =?utf-8?B?Q21paEx5YWF3dzhJeXNwL0lMdzRJbXZmYlRKM0l5VjVTeW10M2J4OHAyUSs2?=
 =?utf-8?B?TkRqT1l0cXRpMWNxSlZXaVYxTW04S1FUMzEwcnltTG1XaWJuV3NLQU0vSjFE?=
 =?utf-8?Q?y3s+CWVBMNpiHJR58UTvHEu5B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175ade8b-1d25-43a1-7941-08dd1b216e72
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 02:54:15.8829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiNF60tzwLksiQvl2SQm+3ppBuhkukOV58VS8RYi2E1tm0iB/T3n/dkQZ2atTcldkk8A84J34buGpb2S6Fl8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

On 12/13/24 07:00, Rik van Riel wrote:
> On Thu, 12 Dec 2024 18:31:57 +0000
> Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
>> Is it about a single task or groups of tasks or the entire cgroup?
>> If former, why it's a problem? A tight memcg limit can slow things down
>> in general and I don't see why we should treat the exit() path differently.
>>
> I think the exit path does need to be treated a little differently,
> since this exit may be the only way such a cgroup can free up memory.
> 
>> If it's about the entire cgroup and we have essentially a deadlock,
>> I feel like we need to look into the oom reaper side.
> 
> You mean something like the below?
> 
> I have not tested it yet, because we don't have any stuck
> cgroups right now among the workloads that I'm monitoring.
> 
> ---8<---
> 
> From c0e545fd45bd3ee24cd79b3d3e9b375e968ef460 Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@surriel.com>
> Date: Thu, 12 Dec 2024 14:50:49 -0500
> Subject: [PATCH] memcg,oom: speed up reclaim for exiting tasks
> 
> When a memcg reaches its memory limit, and reclaim becomes unavailable
> or slow for some reason, for example only zswap is available, but zswap
> writeback is disabled, it can take a long time for tasks to exit, and
> for the cgroup to get back to normal (or cleaned up).
> 
> Speed up memcg reclaim for exiting tasks by limiting how much work
> reclaim does, and by invoking the OOM reaper if reclaim does not
> free up enough memory to allow the task to make progress.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/oom.h |  8 ++++++++
>  mm/memcontrol.c     | 11 +++++++++++
>  mm/oom_kill.c       |  6 +-----
>  3 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 1e0fc6931ce9..b2d9cf936664 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -111,4 +111,12 @@ extern void oom_killer_enable(void);
>  
>  extern struct task_struct *find_lock_task_mm(struct task_struct *p);
>  
> +#ifdef CONFIG_MMU
> +extern void queue_oom_reaper(struct task_struct *tsk);
> +#else
> +static intern void queue_oom_reaper(struct task_struct *tsk)
> +{
> +}
> +#endif
> +
>  #endif /* _INCLUDE_LINUX_OOM_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..21f42758d430 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2231,6 +2231,9 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (!gfpflags_allow_blocking(gfp_mask))
>  		goto nomem;
>  
> +	if (unlikely(current->flags & PF_EXITING))
> +		gfp_mask |= __GFP_NORETRY;
> +

if (task_is_dying())
	gfp_mask |= __GFP_NORETRY


>  	memcg_memory_event(mem_over_limit, MEMCG_MAX);
>  	raised_max_event = true;
>  
> @@ -2284,6 +2287,14 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		goto retry;
>  	}
>  nomem:
> +	/*
> +	 * We ran out of memory while inside exit. Maybe the OOM
> +	 * reaper can help reduce cgroup memory use and get things
> +	 * moving again?
> +	 */
> +	if (unlikely(current->flags & PF_EXITING))
> +		queue_oom_reaper(current);
> +

I am not sure this is helpful without task_will_free_mem(), the dying
task shouldn't get sent to the OOM killer when we run out of memory.

I did notice that we have heuristics around task_is_dying() and
passed_oom, sounds like the end result of your changes would be to
ignore the heuristics of passed_oom


Balbir Singh.

