Return-Path: <cgroups+bounces-6189-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1BBA13AA3
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA757188975B
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BA1F3D22;
	Thu, 16 Jan 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvilsgO3"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB61F37D8;
	Thu, 16 Jan 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033285; cv=fail; b=mbaUpKY8a6PwbN8QOAC/7xYf4wlVPM6xrhSxnIrTmLGlD/0nvYHqpQWpl0NvZW52rWFX0D1CftNuhPOwPnb6KYwcBXNl8oiWrcOSnas60uBNZA16dn6yBaCBZj107FROQN34lFfnoXxb9RD1/Jp5PkB9KKGNqCzjg70Yz5qQyNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033285; c=relaxed/simple;
	bh=nS2V3Wi2qvbprcdLdm5yW1eCsrogqc2x97dk01Q6NXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ka63MvK57WJcNSwtYKqu5/Hd6QMb0pxW8QZpbwFOWkrlxBd/BU9dEFsWTjjgwLrYM/ufTJ7On4UZUWBX6CwItyv7tjlfVWn40I0urp6DKR50fdigqXrEXX2OQzkF02/5QL4dDyBy/vlTuJ1SKVrRX0IeCgV6V6NuKS2jzgBh0mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvilsgO3; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEwPRbjW7bnSecNokknooP3U6l6hhHFxcZcscshUshb3f1Roub1kns1EDtu/fPAw2SGQc09GzfM0kKlBXLFe1zXL7qhmx79/MCqASRuIoui83q+OgtuOZpCSP9od0YCTwPWL8cZzakgz6v2dBs2+TBa5M6ROKlA7NpM+s8hqADVgJIMu2OftGSZXdpG2bL/YS82FtJgYmEBUf+sDoAn5W4TOMTjtgfGwxXam/yZDZRV9hEH0D/clbDr19oELnfFi2PtmAHoU33gsKulWLKjtMXolflVcNFFV3OEDHA5rvsSCUvINsuFFQxB+PDiVSB22lDO8yxVpH5IUtV7/G1Skxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYWeiPbjzBLjuOq6IPkz65SGNAYFyh2IvCpURFA5s/k=;
 b=GxTcISSsm4n4g6I5AC1aDM9OVBrPnwK6YcpH+UzalZ8rK7BLkdFTiyx3czASbvw519UkljPDkUXB4zOfKr8ukvhdgg3tPp3MFGEuEWRcGxsVkroiMRtXv3dmp/Dar67NJ+8Vym8ewIdx9zxLO2DLiFqlJ4iYwDlg4cNMmTsmD5IRqi7aSpEWQr6AmduRAs4D76QU8M+UNCeqKw4Vj8jAowvM0Lbatbxhwu/nLsT9JvV0l+AgGSqcNArBxnWI8nBN7ukFXzKGksVpW02CNYUc2aIzrmcfpNd+P9bQNosEYBEObTwtmoFHK3wXAk8lo5JfxabxZAFvog8SXOn68EP8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYWeiPbjzBLjuOq6IPkz65SGNAYFyh2IvCpURFA5s/k=;
 b=IvilsgO3+9lI3b+D4fjfc4asEJ1/Ua9QQk9KnIzgnRCyf4UYQhwOOi9poMH6jlxADfyq/uty3nNIOUdd2IYYRH0oAJedjStb2PaLwZwxVFe+EFTNGYhif5TPj1cei6qGaEeHzzNkrXgrv9Lk9vvdpT0wJPYx53K6UVRKOm1PAKQvOskOw4uAo+UggMLK2ggTcFfUAtVsJlIPPwda2REFbKdSB4+naQ9GjqbNjb3TUIo51d0i6mrOI0RPaRgXLcSB8wiE/d/LGo3rAgcXMnoZ6Z3uhAgeEZ6qbqaStmDTiBNRJFCKwxpM0C5ssGJY5kIKspY5gnDReK+m2plZPQVjuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 13:14:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 13:14:41 +0000
Message-ID: <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
Date: Thu, 16 Jan 2025 13:14:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fd1320-23fc-4cf0-8d7e-08dd362fbcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXkvdlJKUmlJQllWYUt0WGxpYW5GRExmdk5UNkdQWXB3WG5aUUo2eGJkeGYz?=
 =?utf-8?B?bGViM3pPK2FTN3BaYUFhd3lZNG5hZlZheUFTUXdMS2R0Nm51aDVUd3dYVDAw?=
 =?utf-8?B?aWtMRFdkd1hnbVhRODNGWmZ4MXY4ZkFnNGxhRytiOFkwVHR1MS9RSkdoT1BP?=
 =?utf-8?B?R2VrQlR1UWZIWTdnY1RjYjFRVlVpbHpkbDZlcktKQXVST2VJb0dHL05XcXZv?=
 =?utf-8?B?SVBOalJLaHh5N0IvZEZTOUxPbjhpVUp6eVVYdFJSZm5xT3V6djRLRjR0SHI0?=
 =?utf-8?B?TnlzN2xlZ3BwQjNEV1pCbytzNEtJR1d1b0lrckhLbHR2NlJ1Q2VJcW01NnhN?=
 =?utf-8?B?Vy95aFpTTkRRY0x0bHV0ZFdXSWVoZStDbUR6Wm9pK25OdS9FOUhFUHFLYllY?=
 =?utf-8?B?enROVHZOQnBHSUx2NnIyY1FUd1c5V0trVVg2TzFCVnpIaTYrVVNPbUR6Vmk1?=
 =?utf-8?B?U3ppaUpJOUdUWnJWRlV0QmxPU25mT3dTcFJvM0hQN3c5eFVKME40OS96TFR5?=
 =?utf-8?B?TDVHanowR0hONno3U0RBSUZ1Z2h4SjBzQ1dWcVdiZUxyWkUyOFhmQmx4MlBp?=
 =?utf-8?B?bXlJMnIzM2hjYjFFd3Ivb2xKKzRPREFyU2krRlFEdkRacUdDREhEb2ZXS2lk?=
 =?utf-8?B?eHlBNXBiaDJYNzU3VlRSZm42cFJvcENkTmkrUmdTaXNBYTRzeHg2Rmp2OExY?=
 =?utf-8?B?NGQyVUVEWk5XMHB1OUhhVGhvR3lPejUzNUJxT3VlNGU3N2cwQVF4cDgwUmZ4?=
 =?utf-8?B?eHliQmh2N3VtdUJDa1ljVy9tamRFdC9Ga0VJOUVuSDRxem04R0JDUnpORTFh?=
 =?utf-8?B?MnZlTlBvRVNFVFVDVTF4UG1TRGRLZHFqbVhQdXVuSzNWYkJXaGZMblRMbVRi?=
 =?utf-8?B?bGNlbndmSHcwUHBrUkluRFFUQVZ3MWNVQ1pOV1FTRWtiSVJXZUIwUDBrUG9W?=
 =?utf-8?B?RHNBR3Bqc1Q3YVc5VHMrUTRRbnZtRG9XYUxVUlJjUDUwalNzdy9nSzd1c1VF?=
 =?utf-8?B?eVNRa1JMOTR1M2haT0FzUTN2NnB3bElWZGpSdFdQSS8vR002djh6VTZHU3FC?=
 =?utf-8?B?bUZESmlSdVQ1d2FweGNCbFRUckZIREVTanJVQ2hCc0ptZ2NQbWc2Um5DNWZ4?=
 =?utf-8?B?VU9QZHE4c2d6VytVQmxYTmNwVUEyYlRzSzBBM2tua3UzWWc1NWVkN2NJSjVl?=
 =?utf-8?B?eTVTRzNoTnd0NXJ0aHYzSXdUTHhpREdTRnRHRFFlRVl4ZXQ2MzlxMUdncE1Q?=
 =?utf-8?B?TlhWV3BqYVhUNWNwOHdmUTBQbStQTnYzRkJOTzJYOGpjcFVRUUx6OWxzUEdF?=
 =?utf-8?B?SmdWMUZjQVdlVW1HR2lxOENqVWs2bzErL3M0S1h6OUh2UDJldDA2a0ZEVnA5?=
 =?utf-8?B?NmFvUENwRXNhRHlkaEVGbENCUkVHQXc0eVEwcFBiUmN1L0Q3bGI4NFdtOG9i?=
 =?utf-8?B?U0RMS0JjNDIyYnptSGtCVDE1M2kyWFpMKzJOZ2JQMzdYWmVwK1NVZFhES1dL?=
 =?utf-8?B?TFlMSXFzT3ZxOWw4Q3ROYmFIMmZKUWJzcFJoV3JmTktHRFF1Z1ZST2dwQzRt?=
 =?utf-8?B?bEZwcERNM0dmTG1XU1dwRXh4S2g2ZmJMSjlDRkd3bjk2cThKSG85VjVrTHFF?=
 =?utf-8?B?ZjA2QURXWEQwV3p0eU94Z1N1K0lheVdLNWRFTGZmeFFGZWljZ1QrWDNzcU01?=
 =?utf-8?B?VW9SRXZvbTltUlRmSFFJcXhrL0VSblFRSGliUGFROVhmSlJ1RnpXZnp4MTdY?=
 =?utf-8?B?S3pjNU9FUER4RkVtNy9GS2tDSCtGeDV2dHZ6Nk9yTWtmTTNRbktURFZkV0Vm?=
 =?utf-8?B?bWoveG1IZU1yMEZPc3FUNERSMi9mYmV6MWxGbFlEZk93d1RLZm5SYVdHeTli?=
 =?utf-8?Q?/O6rlScKJTSYK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzY0WmVObTB2bEsyR0MxMUt1aWc3dWJQQVUyYTVNUk9OdUNnV2p4ZmNsNmxL?=
 =?utf-8?B?N1JOeFRYcUd2NHhyZzZPR2hUMTdHYjlwa1IweUErVHZIdCtBeUdwd09JbnI5?=
 =?utf-8?B?NTBtNGtUUWNKMDdlOW5tUUFHRGFLMnR2Z1R5QjNoQ1FtdEphbjNCbE42NFZu?=
 =?utf-8?B?Wld4L216TEg0Skp0dkluNUNiTFF0NkVnNFlWMkFkUzQvdVFnczltWDhWblEz?=
 =?utf-8?B?MGVIZjZRZnNkQVE5NXZZR1FGellkcEowc3lRT3F2TURDYXREV3lWQkdGWGY4?=
 =?utf-8?B?UUdjNVFiRWM5dGNlU2YrRU1ySjJkcjdoeExTeGFmTHVtYTRRTXZnYWVKVzc5?=
 =?utf-8?B?b2F4L1JLbzE4QlRHa0Y2QTdhR3NzZHRobVBZVUtoTHduemNjSGkwTTdLK3hX?=
 =?utf-8?B?LzV0aUtkd0ZKNk9CbjdTbktoeGJZc3lleVZkOXVRSHJpWE5VelpiWUxNR2Z3?=
 =?utf-8?B?RkhjVzVtZXQ2Z0dFNmd3WVpHZ0t6Y0F5aU54b295WmZTOUwrRjg4bmVBcm9n?=
 =?utf-8?B?YTlBR2c0dGZwOS9vaEJ1dXM2dEQ0YXZmTGxTR3hIZWdKTXR5QVd5Um9xNjdU?=
 =?utf-8?B?U2Q2QnNrUHNzUGt2TXRWaWx5b2o3YWNhekJzeFZuRVF0STNwbUIyeGFDU3ha?=
 =?utf-8?B?VEx2b2I0YTgzbGswYmU2RkRCclVCMWtJdXRNWkVnSFJwQ3NiSmFPVTRRMlEz?=
 =?utf-8?B?aGIwVUNVNU1WcXh0N01uSFBQdExQUXpFK0tRaWMzSnNpUWJaTkNjazFxd1p1?=
 =?utf-8?B?Z1p5bmdoZzZCemIvL2lacERwbkpRVEFlbGl1RHF5cC93Mi9XY3VscVBMV3hC?=
 =?utf-8?B?WGJxT1NWQWlwMVF6bFZJR3hPUXRoeHdZZHlhdnQ4TGNSSitzMkFBV1F2WlVm?=
 =?utf-8?B?UXU5c1dNWWc2M3NaQ01pVncrNk9RQ20rWndzUlpzMDRpTzhZZG5OVWNac0ZC?=
 =?utf-8?B?M2FsVm1mVXFxbGpsUFNzUGNTSlN5N0hKOGxsME9SbHM4dU14dUozck1ENlhu?=
 =?utf-8?B?bnlmR2p3VWZBS2RPRjZMODF1Q0RjbFcrTTlJbEhaeWdUZ0NZR2tBRUVsa204?=
 =?utf-8?B?L01YWTVIcUJKTVRYWlBTWmpHY3Z5Qm9aUnYyWHR0OHc4NU9BUG1QaWxLU2d3?=
 =?utf-8?B?V1JPdzBvQVlpeW83QkhBN0VaV0YzQVhLVXdiNGR4TmgrcWVFb3cwYzZUeFdN?=
 =?utf-8?B?UDNBbHIzd1lSdllxeUp3RzhKK1hrMUozTVBYRno0WVFNQzY3bDIvbjFGZ0Z6?=
 =?utf-8?B?VWdqQmdiY1NuaXVOSG84TnlLeXdLZmI4aUdES21pN25Id1V0bnRUamk0VjJv?=
 =?utf-8?B?dVE0NVphc3lxdW9zNStkTFFyTnJIeVhwaTJ4M09jaVZiazlYTUVBdTk2WnlL?=
 =?utf-8?B?aWFuQmZVYjdzTUhVdCtEK2RyZmlCYloyRW41SGtkbFY4UDlZaHBiS29pVnZ2?=
 =?utf-8?B?UFIvR3NjbU9EZFdrdkJQKzhDdFhVOVN5Zm1ET0V4YmZ5WnlYVkp5d0M4R2tj?=
 =?utf-8?B?RzR4bnVRMkNoKzh5UjRkb3RvcThsMEdIZmMxcVZLOFRLWWRQLzJOUEZZWE5Z?=
 =?utf-8?B?U0srSVZ6SW11d0FKYjRtUGx4aHYyZTJ1R3BZSnFIaExuRTBrelVwRG5UTzRl?=
 =?utf-8?B?U1NaVDBSZTdTd1B5K05vVnJiRDNMR2Z2K3pCcmRXR0NjQmJpb1BMVFQ1WndF?=
 =?utf-8?B?TlgvVVI0N09oK3RNbkNIMThlcVQrRHFvWU11K3czeXB1cHdYbXVBL21IeHoz?=
 =?utf-8?B?ei94SkE3K2hpSTh1OVp4VTJKOWt0TjlpVXVOVE12bDhrVGpGT3ZERGpoaHI1?=
 =?utf-8?B?dUJvMnJmOFhWb0M3RnN6Sk9GK2hMQmRzdkRDOUZldUdTZ0FoTm1GYTNMRlJw?=
 =?utf-8?B?ZklBM1dWclRVNEVuSXNraGkzeHNLbVV5cjYrRGNEWE8rcnR2R0ZFY3A4VG56?=
 =?utf-8?B?ZFl3Rjg0UFVGWFJubFZpYXkwVnl0bkdldm9odTFIbEU5Y2EydXBDQjRJMEtJ?=
 =?utf-8?B?bVZxK2lMNG1QaU4rTHptalZGMVNpTkV5Rk9GS2Zzc2xGVkNsNlJneWtOOWQv?=
 =?utf-8?B?cVdXd1Y0cStQcFN5eUtLb3JKNkpiNTA5VlNic1hKNjl1YmUxM3RHVHlRM1ls?=
 =?utf-8?B?WllFblJGMldSN2RmOGFsZFNqTlArbGR6V3hBNFZOalJ2MkUrbWkxRC9jNG9i?=
 =?utf-8?B?dEo3dHVsbHAxWittN3dwc3ZpUWplWWRTTHlka3F6QVdXcTU5bmJpUmlmVXo4?=
 =?utf-8?B?Tk1xcXRFaUV1b2JpNnVwdEcwdFFBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fd1320-23fc-4cf0-8d7e-08dd362fbcb4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 13:14:41.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGXeIo7FFcpDmJoP2GRaS0jAXVmzdq4KZZqKKUubTfTTtmxicd49JEwjedw9hSSd0WDAt8LEe9FwCroKllcXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276


On 15/01/2025 16:10, Juri Lelli wrote:
> On 14/01/25 15:02, Juri Lelli wrote:
>> On 14/01/25 13:52, Jon Hunter wrote:
>>>
>>> On 13/01/2025 09:32, Juri Lelli wrote:
>>>> On 10/01/25 18:40, Jon Hunter wrote:
>>>>
>>>> ...
>>>>
>>>>> With the above I see the following ...
>>>>>
>>>>> [   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
>>>>> [   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
>>>>> [   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
>>>>
>>>> So far so good.
>>>>
>>>>> [   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
>>>>
>>>> But, this above doesn't sound right.
>>>>
>>>>> [   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
>>>>> [   53.971068] Error taking CPU1 down: -16
>>>>> [   53.974912] Non-boot CPUs are not disabled
>>>>
>>>> What is the topology of your board?
>>>>
>>>> Are you using any cpuset configuration for partitioning CPUs?
>>>
>>>
>>> I just noticed that by default we do boot this board with 'isolcpus=1-2'. I
>>> see that this is a deprecated cmdline argument now and I must admit I don't
>>> know the history of this for this specific board. It is quite old now.
>>>
>>> Thierry, I am curious if you have this set for Tegra186 or not? Looks like
>>> our BSP (r35 based) sets this by default.
>>>
>>> I did try removing this and that does appear to fix it.
>>
>> OK, good.
>>
>>> Juri, let me know your thoughts.
>>
>> Thanks for the additional info. I guess I could now try to repro using
>> isolcpus at boot on systems I have access to (to possibly understand
>> what the underlying problem is).
> 
> I think the problem lies in the def_root_domain accounting of dl_servers
> (which isolated cpus remains attached to).
> 
> Came up with the following, of which I'm not yet fully convinced, but
> could you please try it out on top of the debug patch and see how it
> does with the original failing setup using isolcpus?


Thanks I added the change, but suspend is still failing with this ...

[  210.595431] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
[  210.606269] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
[  210.617281] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
[  210.627205] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2
[  210.637752] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1
[  210.645858] Error taking CPU1 down: -16
[  210.649713] Non-boot CPUs are not disabled

Jon

-- 
nvpublic


