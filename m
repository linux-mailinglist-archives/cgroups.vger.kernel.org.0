Return-Path: <cgroups+bounces-6812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78145A4E457
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 16:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C0E19C4D2A
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF327814D;
	Tue,  4 Mar 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYFoUyf1"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CE277013;
	Tue,  4 Mar 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102369; cv=fail; b=qlWQiT5vCGiBtDQwZwvQ36RREWif2xn/1PJ2SARUqUh30Ug+G6OvTfuF1XNrjlAC4o6+7VK2dJO5OS9dcuKvxrmdyo8xJJlOBQ3ILhymNsyBquBsdWEsl9wLyjhC3BXjAGYsRqtRXDA1ZVYGoOZcD5W8kEMnyZ8FoQEDyF4ItWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102369; c=relaxed/simple;
	bh=02hHXrtyz/3FxJIGpusm3exSErcRfW/di6Nwxafo+hw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkE9qeNZC4lH/dOxJxII2BGoA1uL5AcItazZd5IiSZdnRvv0MEkRWNV361yL2GiHJPJ0GQRiwiXmRMDM9Ou2DEXkFTupH4cVLkcPj8mrmpO5ILcyIZbPl5SDWEjOwUgVOy2+EwwnNV2Acc3ZHmJpaSltbxYYDn1QifxMdoZiS+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYFoUyf1; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F36h521dN/2286rDskxfm+yhqNh/tnM/lqVLKFeP1g4vS80mT9qsBgsngTKQivr0VXbnNZj+DeIuW0sdvyQwhuzLs1CHWmgcbPAwogJxUrPwbBh04TXqZCu0W0C3yAFpXdVE7SdTa/kGiQcnfUsAxL8WIbDFwetWiuBJMaK9ZTlOCHjFlO3LhEP2CSW9ngKuhpMKPXtcxJsFYKy+0ekYiFAJgmthDahyXs0GN3neBJifOUPN6L/CWhRg3Gc+c8e7Yr6jfsMyMiAg5g8llj4WYlIRVQ+tD49ce6tTeklSc3W04++j2NhrQucjDe13fRfgmbr759HcASB+FSOgb7DfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8CC4nePBSZ6QXet/SrEOpDx/Pvg4CRIXrxsKxrjJDQ=;
 b=cqyNhsM3nJucXSoDcQd80uipGz9JMrz4XuE3utnidNKB7yoy6q5thUS0Z3cekHEvCyJrQOP6Y4vWN6KeEvdvL/Qtsqtm1DNCNINRbgJsdlU8ViYEkoIWCWHPFgndlHzV0FZwZ1GPx/irMDgu83S6yCE5j6DLI8QaMMD+o+yQVvK1P3iKCN5Mi5GOT1wOqxBXPU4+124YY8YuRb//fG5qvN39SHAe6iD5uQ21qiEmcBXsG30+qsuvH05w5eFHKEawNZ0NWhL76CRaUS9T+moKJq07ySlQEx8EDi76ls3sK3pxBggl163FJv+xzGYkGwXxOSA2i1BOAjabgD7jrgSOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8CC4nePBSZ6QXet/SrEOpDx/Pvg4CRIXrxsKxrjJDQ=;
 b=mYFoUyf1ZqK4jg0pFRM+5lDQC6+1vIOQCIBcUhpABkrFaNY2Fv0Zc0GohVa++x/MgtrF0gtao+8njCbhvPNOny/PxDnrp8A4sFR2BJBvQng2g4Y6sUiE/FWQptdHJ2EiZOT1CRhMXQIcMG4kl4VsrdmRteqL97wdep2AiuxjjAZcq1tKhhgyn80H7PUXDFeMX6HxT/wuheBoE2MhFvhl7xNc7QJdgm0lk4bUVBU/mwgkCuu9Y4GAOsvogk4pKUbN3EyqZP7zvHGzqpTAPYxanIZY/oah+kocfGf9H9WS94J+/+7bFcmtQa6ZqZzaCLFDWSu4lInXCK2V2D7Gc6simA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 15:32:44 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:32:44 +0000
Message-ID: <a04845cf-c70a-4699-8260-27a3502fd01d@nvidia.com>
Date: Tue, 4 Mar 2025 15:32:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: e50caef3-96d1-498d-a602-08dd5b31cee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0w5SkdaU3NUbE9ISGhTN1pVTmxDYVRrNjRaYmFmdHdoakZDNitXaEFrQ1Vn?=
 =?utf-8?B?MUpFanQrZkRmcG5hek10dUlWK0tHWEt6aTcybFp1Q3BvdXlkc2JONTFrL09j?=
 =?utf-8?B?RVgzQjhxT2xQMllscGdhajhmR3d4SnNNeVVLbVViRlRDZHhIejZkNGZBczhq?=
 =?utf-8?B?MUxHYkhGOWJVSmFFZ3JEOGI0NXk5bXM0WllobmRaamdnV2NUbEk1ZUxmSHJP?=
 =?utf-8?B?OThpUXViMmVaZG5uSUFoM3JIcndleVZXckNIS0tybDllSlhrOXRuUStoZmQ4?=
 =?utf-8?B?dHFPUjdmVnpuc2c0TFEwdExhcDg0THUyWDIyOVpUUHpURUVQNU9aU0VPK0Fo?=
 =?utf-8?B?V2J5SUtEdytZbWY5Ukh1ZUpCTWlSbEhyOHBwUlRsbVY5ZjZrNEsxZGpsVEdJ?=
 =?utf-8?B?RkdPUFVmc002UU1MWXhPYms3dmdkL0NFczNZNi91VmZ2TmlMbVp2clgwMys1?=
 =?utf-8?B?NXFOdnlMVGZEMlNNMnV1SHN3bkFybWhsUytEakhYZEQzQ3A3ZHhPcmp0d2dj?=
 =?utf-8?B?UjdNRUxmcVFSVVpzbnp3eVg3Vlo0OXQ2OVhpTnZaN3ZkWCtscTV5Nk1wTmFG?=
 =?utf-8?B?dEhvYmM5VWlRc0JwTk1LR0FYNHVzUjRpcG9Hd3FvS2NyN3Y2YjB5VE1YaUIz?=
 =?utf-8?B?UldvQjhXc3ROakJlYVFqMzg2R0l0OGFQd0FyUWduRk1WelZ1c2pTUWlscFpM?=
 =?utf-8?B?NUpncFJVQUgwSXhUNFlNbWgwNXBBU3RQdG5iaUppT25jeEJ4MVNLVkZMbGl2?=
 =?utf-8?B?NnVLWEVpNENXNldKdWhlOUFiVjFNQktjZVljcG4xTG91SVlKSjBYUVprTTVw?=
 =?utf-8?B?TU9MZXc0RDY1N3l2cG1nVlBESldldGwvdmRyaXY4ajNSL2MvZUJIeDdqN1Z0?=
 =?utf-8?B?NkR4TnU2TCsydHFKa25ydysvLzJjL1pQNkVlS0N4MFJhaUdka1pNR0Q0T1Q3?=
 =?utf-8?B?N0psRVdvS0d4SDNUb3NBYWtRSFdYVVc1Z3ZnR2ZzY2tDN09QakFYWUR6dDVk?=
 =?utf-8?B?Sy84L3JsMm9QQjJqNitGWk4wdlpndVE5bWQ1aHBwUTY3NEd1bysxSjMrSGx1?=
 =?utf-8?B?WE10YzZqK21oSFo2d2dkdTd1NTdrSG40dVJEcFFaVDZaOXcxWFQvL2tZQnUx?=
 =?utf-8?B?SlZLVUhhMC9zK20wVnB2MzZYUS9Rekg4ZUtKelB5RTFFeWREd3pETWNjZm5K?=
 =?utf-8?B?Nk5jdXNaTkd2WmFIYnNPbUkyQlRiUXljL2RkL0FWeHRCd0FFeWJBOFh2SjRu?=
 =?utf-8?B?aGU1Zit3Y3hJVUc5anBUWEpvQm1OcWNsV0RyZHRoSE9xUDMvT04wcVB0eGpJ?=
 =?utf-8?B?QUhMU2FHcjhoL1lsTEcyQWtmS0NvU0NWaHRwOFcyUjVGOVRCWkxObnh3VklF?=
 =?utf-8?B?WEhnNFVwckZQOTlKWllDZzFTUEFGZkpjdm5ndTJXcDdqckZWVWUxL0hnSFNu?=
 =?utf-8?B?djMralkxd08velMzWHlZSnIxclM2bnJyWUtVemJMc1pPNVlCYnFhME43eG9L?=
 =?utf-8?B?QlR0T0JkLzVqZFlTaDQ2eEx2bW1Qc0VudjlZREIzRUZiaTI5TGt2Q2wwRG0y?=
 =?utf-8?B?USsvTXI0RkQrbmlnUmhqYlFlWFk5UzlTUzd6SGNxV1VROVB2MlVZc1NKTko2?=
 =?utf-8?B?OGlIcTBHR251enRnaFNjUjVTS0daak91emQ4aGl5RjBKR3dvR3gxU2I0bFpw?=
 =?utf-8?B?UFViNXZQd1V0NytMSGMwY1RHR3VwQlJlczdGYit4ODFzNjhodEhOaExRQlEz?=
 =?utf-8?B?emRSdnFnek1YM1plRys1STVPcHFUOGJDUHQ1V2xUZ0JPZFdNc29qSVBCT1o2?=
 =?utf-8?B?U3FKSGVIUEhxc0Z5SjNxTmQvM0xOb0pEWDk3cU9KSHhBdEx4TGVyZ3VnMmln?=
 =?utf-8?Q?TY9C5YlHX1GM5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2RDSE91ODR3VCsyQzNwQ2F5NFRyUWM4RFo3T0h0bXdsUVNpbVE3Z0w5TVNk?=
 =?utf-8?B?a3NZTGJheW9SbmgrNzNzYmFFM1pESWgzaXhnK0Q0cC85YkdzY1lXZXZtWjVx?=
 =?utf-8?B?eERoRGZSZFhUR0NXZmFDVnVjRzFnUTJkTXpMNktiNklmclZtNXhvQ3V2clpI?=
 =?utf-8?B?WTUxWGN0N0FNNE9kOU9QRFJYQlNWeUQyZDRhMDkxUlZGWDRwR05MbTlZQjBo?=
 =?utf-8?B?Nm5MMHJ3V2RVV21POGt0WUFySjZwTFFMeFdHTDhxSktERElUMlFHZnRKYklI?=
 =?utf-8?B?RlY5bUJaTTlGTGIzS3lEVUZCdnNrRUN4UEhqZGozSXJla20rMWhURFdPcUkr?=
 =?utf-8?B?bHEwREtMRDM0YVIvcjRsNlBaVGtqelVVUlBZd0ZrL3dQS0U2ZnJzT0hWc0oz?=
 =?utf-8?B?cEF5a1kvazVRL0VjSG4rQXBiQnNKdU5JanRTNitrT045NlFvS1RyeEdMVVJi?=
 =?utf-8?B?aERKQ3hYakQ2c2pudlV5TEpSbkw2ZVRlUEY5bC9EWWpUM0xFNmcvQjRCU1dw?=
 =?utf-8?B?WnZRMjVUVG9rNkVRQjNIQ2h2aEhZcis3cFNIR2R0RUp1elNyRm9ncERBMDQy?=
 =?utf-8?B?K0V3MkhhbmhMdmx1MjR4UXNQdGxoM1VLWXNvUEI2Q09sYVVvWU1ROURqMVhm?=
 =?utf-8?B?MHhwUGZJc0RZcG9SL1N2N2xxY0Y2YnQvODhDUTFwNmhSU29rTW94clFzN05H?=
 =?utf-8?B?LzdhK2VWTGRrNGhGVjNxOW9HdHRjc0U5cDErQm5zMmZuaUIzK0VtUkhGcU44?=
 =?utf-8?B?bFJQRFhMWkNTSXJLaUUxT2c1OWZxWHgydWxGZlJHUlBrVlRSRkxVS3J2VTFL?=
 =?utf-8?B?YjlvMWlsaHd2L045OVNIQVJOVEw4Q1ZybUxBTG9iZ3EwUGk5TDlpMk8vamt3?=
 =?utf-8?B?V2NYa2I4N0p0OW45bi8xRFcvaUV1NDBocjRScGFWbGNFeVQ5b0ZEK3h5d2Yv?=
 =?utf-8?B?a2dKelVCNXg2RnVNMGFrSXNuYTRjSFBZanBaMC8zNVQra1lWNmU5YjBzZ0Zl?=
 =?utf-8?B?eHFyMUgyYURYT1d1Q2RLTEdYVjlRb0RkalNSM3ZGbytSdlQ1U1BoVVFsVXpC?=
 =?utf-8?B?RWM5QXA3bStMQ0pzMTArOXc5eUNaU0tPUm1yUDBuc3FNOGxyV3k3NDUrQzdu?=
 =?utf-8?B?d2hJRG52K2lNZnNRbEprQUJDTzVKUS9CUjRxa3lvSVpXU2J4dzJ4NkZNTmFZ?=
 =?utf-8?B?cUlKLzBmTnJ2bTUvb3lWNVdTa1N1UG9jVzhjb3JmNWM0eWRvdmZSa0E5dGpI?=
 =?utf-8?B?ZjhXY2hXRkZ2OTNydW1QaUtqY1dHdTcvc0tRVEpoY3I4MzM0YUhmaVpCTjU4?=
 =?utf-8?B?a2JGc0RNQWR1Sll0Y3hHdEQ3WlRBUzNZS0NhV1phQWs1ZFhqYm9sbWJKdjRR?=
 =?utf-8?B?SkdURjd5WVptZzJMQ2FBdXZKbUIwVVVNeEZ5TDdWS3lqSklLTkM1aFZqa3Av?=
 =?utf-8?B?bUl5bW9FY2RJbkFRTWdyTkZ3ODhmR0wrM3hZZWpkZGgwVjZ3d0JITzJtcE14?=
 =?utf-8?B?MzN4b0dYVFVkcysvL1VmRTVKNEd4MWR1K05TM3M2QTZCYzYrQXRhMHZqbHpI?=
 =?utf-8?B?VDI0RmFpNlQyVEtWS2M2KzJQTXAvRDFwSklONC9XZ2QyVXFtNVlGM1VjbVVO?=
 =?utf-8?B?YzIxOGhPTytOSmJVTm9DMVg0ckcxNi9RdGtlWlNjWUJhR3M1ZDhEMjZ6RzdT?=
 =?utf-8?B?Qm9jdGJKUUV5aG0vcW9pSS9EelRJelB6dEZWVkJ1RXlSTHNCK3lXd0VyQ0xG?=
 =?utf-8?B?emxrT0xHNldFcVpoL0xTSHVhZmd2RzB3VVhhU3lXNEt5REVtNXhBN1d6WWYz?=
 =?utf-8?B?YlpIbDhNbS9pelJOSmhpenpmeDBzQ3pTSEM2WTVZOGhkV3RiY2huQm9NMGxs?=
 =?utf-8?B?UUdjVEtLZUJEd1YvdnQ0ck1CM2dsanZvTnNvZFArbXlpYU9nS3NXUG9FViti?=
 =?utf-8?B?RTM1Z0lManVmWjN4RkVqVVZHeDJVVGhwSE43aXZZS1ZOTEV4bjVwd2FoU290?=
 =?utf-8?B?UUprSnZBdU9lcHZsVDhLN2w2ZTRoOW9EeGxtLzBTQ1VDa1RqaVpzMkFxamtG?=
 =?utf-8?B?S25sMU1RTGR6NlVCQnJwcElxcHFWQUNnYTQ4V0tBR0daSGg0a2pZSzJ4TXhi?=
 =?utf-8?B?L0pqdytrQXZTcVBPNnBaa21OTDAwdDFGdjNrOGRZanZFcmxvWDlabDJac3pM?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50caef3-96d1-498d-a602-08dd5b31cee4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:32:44.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7CQVZ1C6zrgYmGlGsw1ztWuMLJa7TuVBlXBtKQfHG3wO5yUd6wIRPIZ6Z2wC8ePDiXLQnSxmgLkZI2vvC1dEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

Hi Juri,

On 04/03/2025 08:40, Juri Lelli wrote:
> Hello!
> 
> Jon reported [1] a suspend regression on a Tegra board configured to
> boot with isolcpus and bisected it to commit 53916d5fd3c0
> ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> 
> Root cause analysis pointed out that we are currently failing to
> correctly clear and restore bandwidth accounting on root domains after
> changes that initiate from partition_sched_domains(), as it is the case
> for suspend operations on that board.
> 
> The way we currently make sure that accounting properly follows root
> domain changes is quite convoluted and was indeed missing some corner
> cases. So, instead of adding yet more fragile operations, I thought we
> could simplify things by always clearing and rebuilding bandwidth
> information on all domains after an update is complete. Also, we should
> be ignoring DEADLINE special tasks when doing so (e.g. sugov), since we
> ignore them already for runtime enforcement and admission control
> anyway.
> 
> The following implements the approach by:
> 
> - 01/05: filter out DEADLINE special tasks
> - 02/05: preparatory wrappers to be able to grab sched_domains_mutex on
>           UP
> - 03/05: generalize unique visiting of root domains so that we can
>           re-use the mechanism elsewhere
> - 04/05: the bulk of the approach, clean and rebuild after changes
> - 05/05: clean up a now redundant call
> 
> Please test and review. The set is also available at
> 
> git@github.com:jlelli/linux.git upstream/deadline/domains-suspend


I know that this is still under review, but I have tested on my side and 
it is working for me, so feel free to include my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic


