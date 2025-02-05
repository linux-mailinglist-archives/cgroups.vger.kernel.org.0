Return-Path: <cgroups+bounces-6441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A0A29CB6
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 23:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856C318844C3
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3B2153C7;
	Wed,  5 Feb 2025 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTdtcuyg"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEC192D83;
	Wed,  5 Feb 2025 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794813; cv=fail; b=HIZawR0DWZE7xzciAi/Iee2j/Gt3iu6WkSnOvZRVPjdR1hmmebIuLIy+RcsqhDDhFgNQ3gLs0YmYXOpIdVcmqzqtIobwUoVkZJsNgc1zkIayjMSjEvW9Mk/4YK0AblUP5DBsoRxbzuwZLv7scXeBl9ixo4K8U2pt7dcTxKDLfss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794813; c=relaxed/simple;
	bh=etUTZfhdjZdSPD4ghAeTccrrK/6YTpY+DY6piuUFjsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rv3ZOgJ01QMx+MU40CvwteV0hbdOZiSVehu3pBfzIpTlxufsOSYgyZdXvxk3obmYnJ81IysVhKEGX0YuelmZCNcbKi39HII3R5AUDmh4lnS7J+UZPsL8DkqA9eaY1bfcV1WxRJ/+aYzOj9h/pRwjCmw7uwFY3Ulw+KC8ft5SPZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HTdtcuyg; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4c77iYd8IjqgCUfp8Yus9hegTV1urSFreIB+n9Ot4fVHPbL7g+IQOUjHiAuCg6UpXhsnIcvUV7oTZC2BTP5K+rtdzhnaWZMdDf4pY2K37UqTVeldIO49E4tfhRFpPblXZheQ/iGIEmwiN+Itq4foRJ2J1TGQxZ2qrmG1SPMaq9uvkXY0VhfF/tvTI3eExJ2ZMAHn7zONCugUAU58kZ7GAdE2s0BvPLK5jVHDUA2bzJUk1tFUca604+kLjtOs+Srm9DCyyJPfk4UOqiYkbXQ2LG0FSuhleAIo9T2DFexG1AsC8124WBiA91AM0I83FpM2Anna2xUiRztXVXKW8Elcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy8uWZdBqGC2At119VwnopHj+ygWcWcoJ9ZHUpNo/gM=;
 b=v0WJ/knriHVLnJpmKdOq6Z11jcT7QijsRFVtmsPbsQhz5JvAo8BD5RiNIgGOw0nGymj4G4lI8l+1NF1im0gZmw8mGqYEDgBv6UalFWPLIPD8wd6mRzH8YSuLjZR52uudOeQZ2BOMeqRUjLFhdY+Oj63W3E+IGMNSTjMemBovqKuZZmo0/gBfXScsdFuoWSytjgRgc02HO5D+aKDDjnWjZ4218RB671igzTZ3cw4gyPSkG9ZjiUCE6NytosFlFmEFprCSLym07F7SEnlK9gDCBPJt5B5LKCcy8F5YopCR72uxk5xg+Cm/V6y/DxjX2Uzw1CB49tFehPlzvtMdzWRA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy8uWZdBqGC2At119VwnopHj+ygWcWcoJ9ZHUpNo/gM=;
 b=HTdtcuygKj0XWYxysZBwoYx3z4k3JmXrvLyv6hEB0yTkxiG5zD7eKP8PlofO393UK+vmeGGmxLGBMfgwiEpThFODH7tcwcVch3PcVLQL6ED7k4O0FNKzDIvtuM1c8JFRP/Tn7bn7j8GmQDQHV1oTLrcZOtRxcFp5F5nYAVX7zbYYJ3v+9PN7MLG6Elkj+E22QZk10VTKG5MhhXNNnDyuHcZ40icUDqqWCWRlJejLXsG+e3iWX5zx2aYEXiqJlusG+LLKd6VWerPvTCkkkNeadL0O+TayCvwtMf0rIqd7zAoOnCNO58UIAbWyvNkmQsydxXvuDvGpDJuXSEJau4Pw7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 22:33:28 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8398.018; Wed, 5 Feb 2025
 22:33:28 +0000
Message-ID: <d51bab17-b3d4-410b-be2a-e1d9150fa57d@nvidia.com>
Date: Thu, 6 Feb 2025 09:33:22 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
To: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250205222029.2979048-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f38158-aed7-4466-db72-08dd46351c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDFqemF0RTlueDBpZ2FGd1BhQ3VoUERtVWlrSWRrUkg2dE05V2d3NTA0eGYv?=
 =?utf-8?B?QzlieGtkYldWNS80aGlEbUcrWE9hL0xRZmxGS2lONVVIc2JQdnpOb1VkcU1w?=
 =?utf-8?B?TzN5T3hCNjZCYnBhb0ZsRlVRczhNNnkwdjRCZzhlOWM0OUluNUxmOTZyZ2pT?=
 =?utf-8?B?dWJ5VVZ1UWZVSDgvQTR4OXVDdFVZVkR0Z0kyZHdNcklnWlhHMmswQ3BBeXJz?=
 =?utf-8?B?QmRhN1RtOWx6bnVzTzRMMFVTZ052T0dzLzNyc3pWemZwREIyU2M4Mms1aU4r?=
 =?utf-8?B?MytGS3pVV0dXNVhvbnZ3R3pLalJ0RG5aVHoySGVXWW83aTNwSTM3SzZWblFW?=
 =?utf-8?B?NmtvTjNrbFhUTURwOFJhbWlyM0dLdnRPRE5mNytSNkJtdGRuQk56dllWaEhW?=
 =?utf-8?B?bXQzVEtlbnd4ZWZWa2JjWGNVcFVFUE9XUkh6b245eVIwMnA0TlVTZnA5bnNC?=
 =?utf-8?B?S1RpR3VaOVVoOVB1d0tJMmpBNEphY3pLcitJMlRyRWJFNGh0dzcwM1ZaZ2RU?=
 =?utf-8?B?SFQ0UTBuN2ppbFdWOTluUXFKZTNHQUcwYWlGWmRFVmpqbHJkWDFFYkR2bkZI?=
 =?utf-8?B?NnF1bGw0VjQwZ0NVc2ZJU3F4ZXovNXJkWFV3NnJvWVovaFpJd3NqcFBtMTZO?=
 =?utf-8?B?dWpObXVRZmZDTmRSUE90a0NVbGJ5Nit3eDFRTUlQY3RlaHMzRnl4Y1lIcnhi?=
 =?utf-8?B?ZWNOcE9JRkN3NWxaTkxXL3d4R0w2TXNSdGYyM0FhTWhmZytscXdOQldVTFE5?=
 =?utf-8?B?WHFqSmt3VzRCSTNGTG4wS1Btbk94YkxMbGZWZ2FnQ0w1bktxTS9Qbm4yNXUr?=
 =?utf-8?B?alJIVW9DaFlXVkFEWHZrcVFRYmlEc2Yxa3pwZVI3Qkk4U1hNeWg1cHd6R256?=
 =?utf-8?B?aDloRkc4ZzczUXF6L0o4N0YxZEcvWHlPWGpzKzErclU5YmNicTlScjNxTUth?=
 =?utf-8?B?KzlTYTN2YksrT2IyUnJWODJFZEI2YkhNZDNseW5yZjE0U3lUZDhJTGJEWmha?=
 =?utf-8?B?UkdXaWxJMUZ6cTBoK3JoNmZWRVp5MkxPMXJ6R1puMXNzSS9aNUU3ZUZFWCtt?=
 =?utf-8?B?Q0NBZXlXUDFHSzFFeXRIaXlDQVozdE1QWjJaQ29xN3NiRFVVc04vTWlrdjBN?=
 =?utf-8?B?UVRKdENidlpaQzFyZW5ZYU1CVHc0azk1Mjl6eklxc2pIZEJ1SnhEVDVEQmdY?=
 =?utf-8?B?UzhLV2J6dEQwNHUrNURjNDcrYkUza3BQemxJamU3UG9UVEhiYy9OS0JFZUhD?=
 =?utf-8?B?Q2Z5K3F4d2dUSGdQOFJ3bWRxS1c5UkhOL0l5ZS9CZTNXaHZDUHFiVTBGZy9I?=
 =?utf-8?B?cUhkTk4rcEwyYUh3V1NsbE9LWlcvenJRejlJWkl2bENLR3JQcFdEeDQ3cnRa?=
 =?utf-8?B?eFh1dG5wS0NJMC81YVFSQkFYVmRVZ0xBSHkzcVJEci9oMWxTUmEyai8rVU1O?=
 =?utf-8?B?SHZDbDNtTkNjWXRjTUpPWlFjL05uNndiSU9veTNaeUtBb1hCVGxWQmZtWlpv?=
 =?utf-8?B?Mk5leVM4M0FLU3Q3RlNaN1hnRWowYk9WVVZFVmtFc2ZLUHJLVDhSN0VsSGw2?=
 =?utf-8?B?cTc3R0EzSDkyU2MxcDI5Q3JzbExENWh3bGVTbGFORmhiUFJ0dG1NNG1iTkE3?=
 =?utf-8?B?ci9zbERnT3YwMEVtNXFXL0kzQnpOWUNDQ2lUbWY5RWg4KzNISVQzTjYybWE3?=
 =?utf-8?B?YTdmelR2VzFBMzFKdTJZbnplUEx4MVdnNmJpWkJvWktoRGNkQUhFajV5U1pV?=
 =?utf-8?B?Z1lScXFOWEtjL2NJWFpaZW0xejh2V25zUEpKakwwVUdLM3hmV0JwbEJSeGhU?=
 =?utf-8?B?bGNpVys2c1R3Vm1UWURKTDJHdlY3T09ZTjNYdE1mR0h0ZmVwL1NwQU1meG1s?=
 =?utf-8?Q?Xf+pUor3QnyKq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTZsL1lFTmdUR09uSmF0ZmFMd2tyYjRlcXE4dXdxamtKNEFBekZEaVpCSmxE?=
 =?utf-8?B?M1BmSFd3R3pFaFdCU1B4aFpXN0E2UWNmd0Z3TGk5RDFFbG9wa0ZuV1RrMFpG?=
 =?utf-8?B?Wjh3alYxK1hGdTV0MDI0cjhlR2NTOFdqbVRPaE96SmkwOEFCVVUyWjZlUDU2?=
 =?utf-8?B?WVgyR3RQTml6NmFxaVBUcFUvQVBiZDMzR1RCSVNYSWNmbFVyd01kRWxUMDNI?=
 =?utf-8?B?djdhaTJ6SitUZkNlVGhiN3VMbXJRYXBCdC85amF6WkdiYUQ2cVh4WEtyUUpx?=
 =?utf-8?B?T1BpYjhGVW9SZG5SVGxnUUhoWG5ldTlpNENTVVNTTUNqYlZkdUVmVS8wbzVp?=
 =?utf-8?B?NGR6eTNMcmZ4ZWNHZGRmTWFrejJOTmg1dVAvZmdtenBJcnVWWG5OdFNya3hU?=
 =?utf-8?B?T3FabWpmSG5jb0hMQjBHVlR6Q3h1RDVGeUNFR0o2clZsUzZ2c2c0eHJDVUlB?=
 =?utf-8?B?cWNzQ05CZFhEVHRQWEdmaDJ3M1hOOEQ3SFBQRUlyc2JVbHYzUWUvNVZ1L1l4?=
 =?utf-8?B?NEErV2FuTXFSSEE5dmdubjFmTk1FZnUvekQ4YUQ5OCtkTVJPRWVSTytkaFpC?=
 =?utf-8?B?M1dnWUpKakFZNWlWRFViZTdBeUxpUEUzQUo4RUk3cktpS3pRNDBabG5UaVlk?=
 =?utf-8?B?MG1qeTNXNlI5MjF4cXhpT1NYWndkYnZhYUVOck5VQnlLbzFnaGNwTlRqdlh2?=
 =?utf-8?B?SzFvYjZGSitxOWgva0YxbEdwZDdXUVdEZXB1MllUR3ZETE4vQmJJNFcrTHNU?=
 =?utf-8?B?Sk9scEVtZEcvbzM2T0l0NmxrS2p3L3oxOUFURnJjVCtlR3RTVkhHTCsxNWJp?=
 =?utf-8?B?KytVQnNRZG1oU1daajlZUEJlTHplWXFmU0FUNXRQYlhlb011UFdLYkpJM3dl?=
 =?utf-8?B?aC9GMFFrMjk2MjA0SEcvVk5oSzU3V3VVYUpLSFNRSjJRMU1xS2UrcWltK1pG?=
 =?utf-8?B?anByci9HZEV4eEhNYS9OM1pFMEsvRlFWTDRMZCtId1lpeXFHdUJ5Sm02aFJE?=
 =?utf-8?B?R2dZRzA5b1kxNlZodkFobE4zVGQ1U24walg3dXhiTzVZeURsV1g4bHVkOFFq?=
 =?utf-8?B?SzlYWkxwR01kYTVESEhZMUVrK2NZZlprSUtDWFJ1dGdaNkEzbzYwVkxSeENY?=
 =?utf-8?B?Smt2Rkx3OVV3Rm9FUkI2RWx0Nzl1Y2RlK1lxKzVab2VDNElxWkJwVzdVbExp?=
 =?utf-8?B?ak9GM2VOcHlGaUY3V2JvbDkraTZXejdFWDBQd3lIWWZlazBrQUtPaVhZRGE4?=
 =?utf-8?B?NlZGQ3lwWm94NWVBcGFIcDQwQzlJV0ZjajdITGcwa0liTTRLVXNub0VCRmEv?=
 =?utf-8?B?M1BrVVBnUmpIT1A2b0lLZjBxSlV2MEZZUVczTDhFRW45QkI3ZnRKdWdwWGt5?=
 =?utf-8?B?UHhRVEg2KytIRFJ1N3hDY0hjVGVwWHhRQ0hVdktkVlhFMTE2TWdMQ3NmRVl2?=
 =?utf-8?B?Y1oyTjhDVXJCQlN3QU9DZFh0dnNKeVl4aitxcmhEbFFLbGMwR01HZEJkc3A2?=
 =?utf-8?B?QWtNRitpZWhPbVZjTFNNbkdERnFuYlR2QmlISDVNQlF4cENqRktheEFtSVB5?=
 =?utf-8?B?cHN2MHF3eHFKYTRFVGtkSVd5amwwaXpIOU9Pd1N0bXRUZVU4Z2JHVUowdmxH?=
 =?utf-8?B?UmVHZ1JpalFHZkhSTU1jenNnSkpNMDhQckk1MWFscys2VlFGRWt5dFpJWlF2?=
 =?utf-8?B?MG41ZGRQU05Hck1ZVDhCR1FqU1FReGdpVUFydk9HTUxQK0tMYytrVFIyWmZ0?=
 =?utf-8?B?RGQvcGFRcEZSWmJPMnc2VjYrcktIZjJnMXdBS2gzVm5UQmJZZ0l4MFlWTjA5?=
 =?utf-8?B?cHlCL0EvbVlYZzN6c3JRWlhwdXlUZzEwRmQvdWw1UlBjbUpLdmxIL2VWWmxx?=
 =?utf-8?B?dzhFTSt3WVJIb3Z4R0FsS0FwTDZqL0pJYUk5MnBlK0xla0pyL2ZtYUhnc0kv?=
 =?utf-8?B?eHB2VzAwWnQyMlR0cmJ3ZDEwOW0yNmZ4RUJzN0gvcnJENy92a3NmcUN4ZU12?=
 =?utf-8?B?T1Uwd1BVbDhYMkg1b3dTT09ZYUxDWkwxSEk5UEtUcE84Ukx5SXlFNHBxRnNx?=
 =?utf-8?B?SWNxVng5VnpUbFJ3T21BYTd2NDNkYS9TUUUraHpMRnV0TVZObGFFQlFhcnd4?=
 =?utf-8?Q?XDTHzr1+0Eb/5AJr/k12nFyh3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f38158-aed7-4466-db72-08dd46351c5a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:33:28.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UL6kz6QRad8s4yw5KsSM8BUexRmW3YNTnkFcfCU5N2SXp/iLlAy7w5xSdcU2A70e+HdHQH4qbRaObteT8o8rIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

On 2/6/25 09:20, Shakeel Butt wrote:
> Memcg-v1 exposes hierarchical_[memory|memsw]_limit counters in its
> memory.stat file which applications can use to get their effective limit
> which is the minimum of limits of itself and all of its ancestors. This
> is pretty useful in environments where cgroup namespace is used and the
> application does not have access to the full view of the cgroup
> hierarchy. Let's expose effective limits for memcg v2 as well.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>


Even without namespaces, in a hierarchy the application might be restricted
in reading the parent cgroup information (read permission removed for example)

Otherwise looks good to me

Reviewed-by: Balbir Singh <balbirs@nvidia.com>

