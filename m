Return-Path: <cgroups+bounces-6528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1037DA3330E
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 00:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2972188A481
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09488204582;
	Wed, 12 Feb 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p2gOOLDV"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189D1E3DED;
	Wed, 12 Feb 2025 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401276; cv=fail; b=kRf0LLTKdavT1PAS6uMs52vR2kAEn984jJy44NdB7xEAUIlWx1Lr+Ewg3N9PG2aSJ3rRSep/qdvGvA3o+p5u1qKroOJ3uPnra/5Qe8ORQWhqoo0uVSL36fQgEDfokQ1jnK9o+qxy6hT8ScGceQBpJtdF+MWGSrGgin09wZ2WmJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401276; c=relaxed/simple;
	bh=O4JBcBkPOy701pi2z+dii47gy1Hy/GJ2BRWkIQ1O/EQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ccL9+TwodgOZOGRDhkibHoihFPMzK6QBVu2s0nNuL/J4jVLQA/1PRu1T/hWxmsU8Ljk1T/YHMrVtZrHbj/ulp9TY10a4aRwWzXPnApL6fBFwmC6zIQQh6wI7SyGuQRIL1mLmkrzo82nisvba1gAkfwpKFl7YRe/3i1jaeEe2Bm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p2gOOLDV; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPKjpY+1cmGsOApipc+2RISWEp+IDyEm5zW2mCrF8HByDqTbx+BVHGnL5wTQkhJMxembSljSwUt66hQ2tX8DZJaqzNSox//r/s16rglAS1JIDmaezvcSooDV4NqVEXuyNJ91uzP93JOi+V4aWxxGr7azuomGZq5tzGW7BHgYNmiBC2SKc2Abz4I1S1ThGjuwZq+lOJuC4dM69P9pq/18odnDOWNHt8Y8gb9fDx6KjU/BlkNAoOoWAqhrUCNmzxiHo6ODjZ6A7E/G7DEGPo+ze+ynnBEGq/lcdt4N3NgVcUL+ZmdGq0CzgTYjRAKR6ThuSSKMhF2A/4XRM6C/mb3LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G14sjBA8PqQP+Q8OqPMwpt8mh3m/wJxGygVhBOj6a2s=;
 b=tPXzSysZafXE+aTg/LpoXUADp/dvOElv8AwrUmKJZDx9Mm+u2owr5sGUX4aWFo/xll1DlZHJpaczAXW1IEJS0K3qQ5hsEX0DO37hbCyNLyrQ8mugaqA72904hnA/rK3JrBLMBhn4XhoD+mP0eAPTsxmFgHJHYSG13vwu+Nd/h+OGmdAxa/yBpDHdtNaUYlRMAXcXVVHGMitTSzBqDIcO2PKQgCnZ2uI78+VdIruLi5E8FMegnl8TgW4TjsfCKGDMY+wDLYgZBKf23SYY5uEkJOO/0Oxp2ushAQrx3Sn6yE6Zg1LBQpmWjhcFsojMZV9u/HvLTTPH+7zxpE4tb/QOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G14sjBA8PqQP+Q8OqPMwpt8mh3m/wJxGygVhBOj6a2s=;
 b=p2gOOLDVH/+O+RM6qbHbh+9r+mOu01pN3Oqo6VOEtiRP/SY+sNF+XYCmCNRPyYFbJi8ymtOUSuRMTFrCLTeGkg6R/mYjZvr6mWteZ95nl67rkTHZ8AdpbLsLDRFr01b+RhVWMdPrUDeMzdgJ37iEwQnWik2VStneqSe+erJ3OiRxkrIhdXFqh7D8dlDqZhFhc05wOIUqXuXthYzyj9yfHRzV1teXTPswdfgtgJdAqHJmIbRQTx/9Bvu4idhd6ubtB3ZiLbum2DP5fU7rLdEkbSwRSvt3cKdiXgVaU+lbTD11cAtbvxeDWOMKxjWGdYS7saHLEjP2dAOt401It2205w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 23:01:11 +0000
Received: from SA3PR12MB8761.namprd12.prod.outlook.com
 ([fe80::f72e:615c:e83f:b78d]) by SA3PR12MB8761.namprd12.prod.outlook.com
 ([fe80::f72e:615c:e83f:b78d%6]) with mapi id 15.20.8422.021; Wed, 12 Feb 2025
 23:01:11 +0000
Message-ID: <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
Date: Wed, 12 Feb 2025 23:01:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0245.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::16) To SA3PR12MB8761.namprd12.prod.outlook.com
 (2603:10b6:806:312::15)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8761:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd9024c-56cd-4698-08c9-08dd4bb92470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFVXRFExMEFFYWQyWERWMHBNZWZ2ckZwUWZvUU0xdm4yUG1qcjlFMElqaml5?=
 =?utf-8?B?a3NjcEs4MWlvTGYvWXoxU0lYUldDdEIrUHRJZU0zWUd4SW81SktWa3JFdnBr?=
 =?utf-8?B?N3hXUVN1RWNWSGFBNC9pQ1UwSitESTVzWGFnZ25xMHNCWVROYjhpSXF1cCtQ?=
 =?utf-8?B?dGh3dzVrRldLd3Y3SFJEbHg4WnpTMUhMeG5GVXFIQUQ5eVc4V3AxM00yYjNS?=
 =?utf-8?B?cFEwTlVlRnVUNmdPenI3YUhTZ3BCUFZXbjRWaWR0ZGZJOXRESGg3cklaM2Mx?=
 =?utf-8?B?RVR1Z2VKRHp2NlBMRXh1RFRzM3R3dXlmTnJLZ2ExMWRXOUVlaTdrYysxY1JY?=
 =?utf-8?B?RC9kVXZZYU1Cb1lUUkFJVXk5K01zcGVsSi93YUZvTnY2U3J3SWJKSWw0elV2?=
 =?utf-8?B?d1BNZEQ3UWZPZXBYaVlLK0FJQWV2Zk54RkpjN2piUTEyZ3VidGNiRGF3elRa?=
 =?utf-8?B?dDYvb2R5Y05zTlpVK3VVTTRnZ1ZUL1ZlZDU5TTFNRlhvNkpYMjZycytjdHIr?=
 =?utf-8?B?djA5eFdSUE90QW0vR3JuM3VHWm8yNlV5cHV3bVRMdzh3Mmw5eFZVb0xTcWlB?=
 =?utf-8?B?VXFIRTZKMGtOVFRqMW1GWkZCWWdyV3p4U2tzTGZ2anhnVVd0dnZ5UU1SdG52?=
 =?utf-8?B?R2Yrcy9wQ21BdXBLV0xtWVpTNVBTZVFSUXNQOHc3VG5EMWhTTXJkV0lVcmpa?=
 =?utf-8?B?OTZKWjN4azlvajRWOExPQlhFVVI3cUhNcExIRDVxY1I3bGtyK1JSdHFvaUZ4?=
 =?utf-8?B?RUdGSDdmS0EwcUJyRFBnNUg4MUV3ZDZZNWhxOWdEaFBLRmZ1SkRLc3BJdDl4?=
 =?utf-8?B?cXhsQzN5aWZkZW83T1FkRDRKVlNyaktYTEFVR2hDZUtkaDBpekxkVXpRMDla?=
 =?utf-8?B?K3NVd29vWFBKOUFvS1hOUHp2S3JjT2l5dUFTUi9DUVBWRXRudHNvV3VsSmJL?=
 =?utf-8?B?eWNFcUgwdmNMUE15NGlnVzRJQVRhaW1HR0k0RUpqMElpWGtUenFiemNjRWRN?=
 =?utf-8?B?ZTZ3LzZwNkhuS0tyNU5vQ1RBSE94bExoQjJPZmxjdUdjL0hJek9CcUFTd0RW?=
 =?utf-8?B?KyttVzVuaWl5ZStHK0owZllLZlAxZDF1aFNiYnU1RjRGZmNYc3Z5TFlWVFV4?=
 =?utf-8?B?K0hkeTg1bVVFRUljeTgycXBDaDcvOHdZMGUreFdrdWdteVQ1b05RV0pzbW5V?=
 =?utf-8?B?emFOM216cDcxdzU1T2NsSm1SdjYxRHpHT3h6SDY5S1lobExxV0REQ25lMUVm?=
 =?utf-8?B?Q3h4OWFHWmM2TWpwVHhzR0dCVFEybHJLNko0czVpYjd6bUh5TkZZazlTTVFM?=
 =?utf-8?B?SFo0Z0NwY0oyWnM4YzQ5NHMweWhBY0hoc1JnOXdPZDMyVHk5UnpGeFo0Wm9C?=
 =?utf-8?B?dy9IeGZ3cmQrYnY0ZmZDcUtneXhmSU9rSndnMHQrcHhLdWoyMDBjN2tYRCtP?=
 =?utf-8?B?aGpZSW0vODlMK1BZWGZRZEdOZUNmZmg0Uys3dndKVUJMUHRjSzR0bGZDQnRx?=
 =?utf-8?B?OWlCQkpRUFZqUzVOWlBQeDZhZDBuU051UzlVUnEwUVR0YTVTWll0YWxLU3Ny?=
 =?utf-8?B?d2t3SWZGNllPOWhDRkwyQko1K0RyaENtbEdsZkVlaVFORjdwWVBwVTczVzUr?=
 =?utf-8?B?cEtXb1RtQW5VcGlqNnkwS204V3h2MFg1VmRENEQwWUlqVkhMK1Z0dDl0c2VR?=
 =?utf-8?B?ZHdnMEFEV1Ywa3k2ZE0yZWRmZm0rRUQ1aWU3UU1WVExlSzZNUDc5OFNJaXdy?=
 =?utf-8?B?RXdpeXNsck9jaERIQ3E4anR3SGV1WmFKY0gvK0h3c0lmY2lMMTVQOU9nUWln?=
 =?utf-8?B?UmhiK2ladk9OOHhwY3I5TURSZ3RwU2VhalVGaEtSZE1rMG1lY25pZjJPNVpJ?=
 =?utf-8?Q?okDPhlF2KywN/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmpFMlI1aXM3MnU5bCtZUzMzVE8wdCthMlM5azMrQlhKVEg0RVpTbHVtY3RH?=
 =?utf-8?B?aVp5dHBJOURCbnJGZzBZWWR3MGNYQ003Y3oyb1FtcFVnY2tPcVlodjd5TDZo?=
 =?utf-8?B?UGVtY3hRZUJaVmZsRzlFU3pCSlY1Q0JYeG5XTEJRUDdDSEJPTVN0dkFVZ2dj?=
 =?utf-8?B?cHZsb3BHZHIwSThPeXl3NEMvWGhxNVFWVGJ3cUpaeG5neUozZmdjWU5xbUw3?=
 =?utf-8?B?VVdyUlNqTEp5UHpjT1JnRVVlNDBPelQzNWYvSW41WWo3Qjc2d1FNY1FZdGoz?=
 =?utf-8?B?dXhvdVFSZUFhcjVaRUovbUYwMURyWjdrSm8xQVhOS1kzV0EzMDlxUDZ5QkFh?=
 =?utf-8?B?NS9wVGhEamZ6NVNtam9pWU00YlAyN3k0dUZQQUdGL2JFVUZKSjlZSGlaSFVG?=
 =?utf-8?B?VEhYdVR1Tm9hakJmRm9kOGV1ZTZvOHl2UzdwaERucGt1eFd0dlFaZUd5NTkz?=
 =?utf-8?B?Zmh4S0pKRHJLRXVzbFYwRk85cGtZd3JrN3RFOG5UT0lCWW1hOU1RMjJ3T3VM?=
 =?utf-8?B?enVrbzdlUDJ6SmlUWVdnbzUrQ0RFY3JSV3Rjd1dhWndJZEhpQitmWkx6cmo5?=
 =?utf-8?B?QTdBZUNPeTgzdi9RMWp5Y3FkOXR3RHZtYVdheWM1bUZESHJ3RXVScEN1U2RW?=
 =?utf-8?B?MW8wbXk1RGsvbU0zVlV0dkgyL0Eva3l4WHJqRHlMUWpaNEM5dlFxa0hBcTBz?=
 =?utf-8?B?c1Q2eWdoOWVzb21qTldsaUR5eEg2L1ZWbEtscTd3K042U3BITGNTekYya0dt?=
 =?utf-8?B?RjZDaWVOOWUxbVJmQ1N5dE0xa0tOV3hPYWkyM2NCRzdOQzc4MmI2ZFB0dGJK?=
 =?utf-8?B?QnRURXVmS24vL2tlM05oQ2dXQy9pb0F4QW5PbWxLbG5QSXR0NFMwZVd1Kzcr?=
 =?utf-8?B?RGdndGd5bjJPZkVRUVZoclh3RVJaTVBHcCtCdmgrNWpGVEhGU3hwdmdQTGRX?=
 =?utf-8?B?VWhlSTdibWlCUjltZXplSCtJTHJUTTlwOFplS0pLUGMvemVIU0gxaVk3KzlZ?=
 =?utf-8?B?NmdrT2lnQ3dUckZoYzlUV3pPZTZVaDJscW45VUdBSVZkM2VRWEtuak4wMHZu?=
 =?utf-8?B?aEtYejVSSmhieC9QbGI4eEp0T1dvNWJyU1V0RGZMYUxQOFMvUU5ZR0lzZjQ3?=
 =?utf-8?B?ekRHcTZweEcxV21xNWRaK1VxL0llUDR4S2lPZ0FPL3A4a015aE9QM3gxMjBD?=
 =?utf-8?B?WjMzVmI5cC9TTE4wQUN1M3RWbDZlRllpQ2Nab2ZKTkVFVk5KSjRpVjFPSkk4?=
 =?utf-8?B?bFVvQklJRGlscGdjZFRqWUR6Q1FUM091blVkQ2ZZbFBtdElTeXF1SWZJTUFn?=
 =?utf-8?B?ZFlWbjcrMjRzNDBKRG1vY1QxUnJBKzhYdXdPamU4YXJFaW1RNXVlS2FUMnpE?=
 =?utf-8?B?QTBlaTZZNDN3K3cyL2s4dk1ob1plcFdxc1Y0c2pVQ3cxcExjNVdydjRVMW1L?=
 =?utf-8?B?eVhJOC9rUEg4RmRla25ZWTNvOS9nUG5NY2tFMHhOYVMzeUNWc1VHck96bVdn?=
 =?utf-8?B?QzdrZWp6TUgrTlduL3RhRS8zWk8yTjg3elVTSGNSOU9lU3ZDZ3pwZ1lNaDZQ?=
 =?utf-8?B?dVIxdjVXL1JkSjVaM3UxNWJjZDJtZEVIZDF5dnZsRTQ0aXRNb0ZSUmx2MTdG?=
 =?utf-8?B?YzBFbUp3b3dISXNZZjM5YnJTOG1wYVlGWHNGN29BalA5RmtNMjdHTW0yZHY5?=
 =?utf-8?B?eExJT0tqWFM4aTcxb3BOeVdrcmhpSkU0Q21OUmZ4U3Q4Ykxsb29xWGRVaklo?=
 =?utf-8?B?SnhJbWgzNW8xdmdOZXJhZ2d3dUYyZm1JYVcxdEVuWFVOeTNmRkNlTW1TS1Nm?=
 =?utf-8?B?UUxxaTB2ZGdYUXFZcnNuWHdqazZMSWZBNW5wdHUwb09na0dmakZucTIyQlVw?=
 =?utf-8?B?T0ZtckxyR2Q5SDNwNzYyOHlXMWxOYVhwUmt4L3V1a0hoZm9EKzRNY1JET25v?=
 =?utf-8?B?SUtBdVVWWHNHQkFIdU1uUk1zWEtEa2xGTEhHSlplRXFZL0dtVFQrNXFrc0Ux?=
 =?utf-8?B?eFlNdG9VaXJ2UlRvaURVbUI3MkRMNnNreCtnY0FqSzIzSnJzeHhkWVh5Z0pY?=
 =?utf-8?B?alJQNWFQMS90QjlIeWxqcUVXc3VKRTg3Q3RkdThLdUVURTd3RndVVk5MSGc5?=
 =?utf-8?B?Ui9HTXllZFc2SktmRHFoWEJmYkdEaFRzWENacklvdFhlZThUMmZiNEZIYkhT?=
 =?utf-8?Q?e7sAFsqPb8B8DvGvujPhQkcGbDdRTqYdYCYNpy0XzG+G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd9024c-56cd-4698-08c9-08dd4bb92470
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:01:11.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SsgnX2pm2PNHe3FJWZYUtkMotbbAlvxQBJklY89asTBOeC0+MMP/lejTUFNvK2t//VD46InfPb7hc2Camn5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251


On 11/02/2025 10:42, Juri Lelli wrote:
> On 11/02/25 10:15, Christian Loehle wrote:
>> On 2/10/25 17:09, Juri Lelli wrote:
>>> Hi Christian,
>>>
>>> Thanks for taking a look as well.
>>>
>>> On 07/02/25 15:55, Christian Loehle wrote:
>>>> On 2/7/25 14:04, Jon Hunter wrote:
>>>>>
>>>>>
>>>>> On 07/02/2025 13:38, Dietmar Eggemann wrote:
>>>>>> On 07/02/2025 11:38, Jon Hunter wrote:
>>>>>>>
>>>>>>> On 06/02/2025 09:29, Juri Lelli wrote:
>>>>>>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>> Thanks! That did make it easier :-)
>>>>>>>>>
>>>>>>>>> Here is what I see ...
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>> Still different from what I can repro over here, so, unfortunately, I
>>>>>>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>>>>>>
>>>>>>>> Could I ask for another run with it? Please also share the complete
>>>>>>>> dmesg from boot, as I would need to check debug output when CPUs are
>>>>>>>> first onlined.
>>>>>>
>>>>>> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
>>>>>> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
>>>>>> isol CPUs?
>>>>>
>>>>> I believe that 1-2 are the denvers (even thought they are listed as 0-1 in device-tree).
>>>>
>>>> Interesting, I have yet to reproduce this with equal capacities in isolcpus.
>>>> Maybe I didn't try hard enough yet.
>>>>
>>>>>
>>>>>> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]
>>>>>
>>>>> Yes I think it is similar to this.
>>>>>
>>>>> Thanks!
>>>>> Jon
>>>>>
>>>>
>>>> I could reproduce that on a different LLLLbb with isolcpus=3,4 (Lb) and
>>>> the offlining order:
>>>> echo 0 > /sys/devices/system/cpu/cpu5/online
>>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>>>
>>>> while the following offlining order succeeds:
>>>> echo 0 > /sys/devices/system/cpu/cpu5/online
>>>> echo 0 > /sys/devices/system/cpu/cpu4/online
>>>> echo 0 > /sys/devices/system/cpu/cpu1/online
>>>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>>> echo 0 > /sys/devices/system/cpu/cpu3/online
>>>> (Both offline an isolcpus last, both have CPU0 online)
>>>>
>>>> The issue only triggers with sugov DL threads (I guess that's obvious, but
>>>> just to mention it).
>>>
>>> It wasn't obvious to me at first :). So thanks for confirming.
>>>
>>>> I'll investigate some more later but wanted to share for now.
>>>
>>> So, problem actually is that I am not yet sure what we should do with
>>> sugovs' bandwidth wrt root domain accounting. W/o isolation it's all
>>> good, as it gets accounted for correctly on the dynamic domains sugov
>>> tasks can run on. But with isolation and sugov affected_cpus that cross
>>> isolation domains (e.g., one BIG one little), we can get into troubles
>>> not knowing if sugov contribution should fall on the DEF or DYN domain.
>>>
>>> Hummm, need to think more about it.
>>
>> That is indeed tricky.
>> I would've found it super appealing to always just have sugov DL tasks activate
>> on this_cpu and not have to worry about all this, but then you have contention
>> amongst CPUs of a cluster and there are energy improvements from always
>> having little cores handle all sugov DL tasks, even for the big CPUs,
>> that's why I introduced
>> commit 93940fbdc468 ("cpufreq/schedutil: Only bind threads if needed")
>> but that really doesn't make this any easier.
> 
> What about we actually ignore them consistently? We already do that for
> admission control, so maybe we can do that when rebuilding domains as
> well (until we find maybe a better way to deal with them).
> 
> Does the following make any difference?
> 
> ---
>   kernel/sched/deadline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b254d878789d..8f7420e0c9d6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2995,7 +2995,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>   	struct dl_bw *dl_b;
>   
>   	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> -	if (!dl_task(p)) {
> +	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
>   		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>   		return;
>   	}
> 

I have tested this on top of v6.14-rc2, but this is still not resolving 
the issue for me :-(

Jon

-- 
nvpublic


