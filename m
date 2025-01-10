Return-Path: <cgroups+bounces-6085-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C858A08FC7
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40657A1017
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178320B7E0;
	Fri, 10 Jan 2025 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnfZ1XTj"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020091AAA1F;
	Fri, 10 Jan 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509971; cv=fail; b=fbHe/wIy7Xna2ZFiczH+ITWYe/DyyVepdoqfNN23BTcQbcaBLPRvNBIaShyJOp0n+JcyWmS8CgW3bPls4cgy2qczBdiRvZyaCgclCEDiA8+ORZKfXU3D6sDBUWDnXqkIyWIv3oP6OxWZxdcSdzMGKqQIdrSKKoSqyZutp/IiKXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509971; c=relaxed/simple;
	bh=pUHIDew9Sxq9v/DBIw/MXOaV9eknDdv7xbL1eD/i3WI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jrYLyQghJgX6DCCSNBgGIfazQuqisPEUjPwGmFa60gW30h+T/8eMpBNxyuWl8GAabPMIvOnBlMp7gnsJyaCcqvguA4Xodsv692KGpCBS6YaZgddOska2kzoD/94uxXB29XW3X/UwSwp0SLMC7NTxSUNPscUzqdVl/B6HePHURJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnfZ1XTj; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ+txlV9pfGNt7QGWl0gQkmRuF3X8SEZItng/uPPntLRmTjSFnEg0jCOB/g0mwQI1VdhFyrc+Tz4JSr/OX37u94FfR5RZGUMe+vLFvsBTjRohgXQt+6BWfDHSX5eER9dm+hUPwp6uFzuGmKJa9Aw3h4vxmq7spuBnbolDYbLCJCMz1HT99fR94EhHIw0tY4zXmdNm3ZfTBR8/u8juKyspn+To8j+kiDy+QrGOtl0XjLzZPeyGSsp4EBfqBsPeSEygcG8t5KqPCi7xZPRvbVSdAVYuCLDo5kAAaCzFr6Iik9Nt89f4vuBLVhhebgDwf1PzxJJNGNAvgBxVvzlTuxeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUaqlVytT6/vAzo+dqLqqr2fg2Z9pxMKfL7mTWTRnxQ=;
 b=H0mQZz1XYSh5BHh2tzNBa/ZPIwQ5GKevluzMyPC02bxB5m1MztIoYuxZE78pDP1U8ImKaT6RQlA61C7yAlpL+mFrBZUbBlTgq+zlAdBZaNwsYRS9aOLalsVrD13TYfN0FxEEwM/7m0hReVakHKJqcx9LH20w17wQLZhQvzIOQpNJk2kYBo9Cpc8RTym2Cr5T8lHZTTZ8ptQP1XeYvO5SkdI+nq7LpJ/rwJbJRDM5HHffzE1Kn6OQ8vxbSHTH2U4Xp88ZWG8HcRZPWtzCxuZNwU+prC3gG0rKDgMJfqaR+Swk0c/f+DGyE34L4NocMft/bScbKMwDPQhDV4yu3aCKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUaqlVytT6/vAzo+dqLqqr2fg2Z9pxMKfL7mTWTRnxQ=;
 b=EnfZ1XTjLyYYQks3fc7hXAvQxtiWpfeQMwIIxmZKEGUXKESL+rh75ZaJE1IOsOKen5Tq+dBt5NnM0uhoF0A5VIri4CGOhveo3oMoD59SOkAObmIciSM+GeTCMm/v3DpwKmEidETHRsZadLBrAfMy1bIyAnrv52adkE86HalnIWhy2NKrTt4AW79eZd/2CeVBZ6ei4/fqbnS/ur9TrwmZ3Jh4MKXPJ7OMdMgPFv6yDe1q7lymhf1CZmZvNojINCrO5eVa9Cqy7FaC16hoghLMASyogxarxJWTNO0AVyMYKhBUH8IjlNDTQudqQ1Gtq3qG3fvtcDdOtuL2eY4xInWI8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 11:52:47 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 11:52:47 +0000
Message-ID: <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
Date: Fri, 10 Jan 2025 11:52:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 95521609-676b-4d57-56c3-08dd316d4d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|10070799003|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?by9mODNPNkd1ZXBkcTc3S1FmWEwvTUZoNWJHOENMR09JRDl2Q2x0R0picWJv?=
 =?utf-8?B?eUZWTWtGdmt2NTFpbU9WYTRUblFUQUx5ZHcyaHNrTGhwb1JCNGN6eS8xYVcz?=
 =?utf-8?B?VUN4cTFyenhBVlJIbUorUzhWK3F1b1dHSWRVUE9KZWNXbFJaK05LYUg0akRk?=
 =?utf-8?B?N1VNTEVOa3l1eGdYMlJWcWttaW85ZFliSno3anlJN2syWG9KdGhsUHorT1Jp?=
 =?utf-8?B?K3dxbVpCdHNPTUI1RjFIemZqaUt1T3N5aDdlZW91ZkpFYmh0ZXltUjIvSnVP?=
 =?utf-8?B?dHZVbUlnK0loV1BENmRETU45ZGJiRnhocG9sRHg3dlJqb2h6d0F6RjkycGFk?=
 =?utf-8?B?Z1JQdm5HbnpKVDBTNUIveUE5NUw4Q3c4Yi8yWEZPZncvWGwrZkJRUGhmK0Fz?=
 =?utf-8?B?K2I4WlVzWndTbnFEZFY4bkxucWRtWkNjOU83Q2VyL0M1RnNKd0xodGpBSktp?=
 =?utf-8?B?bklBcG5DTERGOEpIZ01FaHNFb0VWb1BaaW4vTzNQazRmVzVqazdBdmEwZXM3?=
 =?utf-8?B?dU9ISFlsWGR2QllwcEx5VTZCTTJBRStrV3JvWEFsN05xQ0ZzbzR3NnQzdFdJ?=
 =?utf-8?B?L2t5N3RvTURHODVwR0NXbmcwN2cvczZHYitLaWZXSGRkUGMzY2pHcnJ3eEhv?=
 =?utf-8?B?SVAvbW1aN2FZeENzcTNyVlNFTUpucXRacGx0RnNuUjAvczB1UkUxaEVZelFU?=
 =?utf-8?B?aUpaKzROUEVCU0xQdWJINEtmYlRDZ01LcTYwaUVxTkcvUXpVdDBXSWJSVzVX?=
 =?utf-8?B?anpja09pV21hRG92L1FzSlN3ZXRrTnhQSmF4azdRSlpiVUIrbWJRcHRMYXY1?=
 =?utf-8?B?aHM1Y1I3RXdYb2hFU2p6ZVh4eG12d1Y3bGFEbGZSR1Q1a3VudXlLbFZ6dUFL?=
 =?utf-8?B?RzRPMlhFbFB6NDI4d0VTUkhmZG9FamdkaHdlRUFNS3pKZEhHNzBKV2tmV2da?=
 =?utf-8?B?NFBocFJJZkpHYlkvRjVvRm0vODdXcGxRRXlub2pYQlcweWNCYU1lbTlFNTFL?=
 =?utf-8?B?bkkzVHVza2Nzb3hRNHhwTWlWQWoyK0JYNy9EQVNnZWtuVUdCc0dTelI5VDcv?=
 =?utf-8?B?K2FIc0VuQUVrZFpjNWY1N3VMZWdoUVVzNnVEbnZtUmVZWTJLSkNWK3hoWmJv?=
 =?utf-8?B?aUFPK2tPT3JqNHpwM1hZcXEzUmE3d1hpbjZ3TjFLQkpqdis1NU9KcmsyOWNI?=
 =?utf-8?B?V0o5cGNzdm5mMUJRNkFwaWk4Y0lOdEZzeDJLWGN4Q2FodkJzSnNZQlVZMjBj?=
 =?utf-8?B?R3VjbkFzbk1RQU90WXpqd3dUQkFMbDY5QVRjQ2QxU0NyR2hZMjk1N2hQaHI2?=
 =?utf-8?B?OE4rZlBsTU9XclVtV0EyOHhDalVIdEJUZEZ0bnhURkw0c3p2ZWowUUFSN2Ro?=
 =?utf-8?B?R2x6VjlOSjA5STd0NVJ4RVlDZVJIUm94bnFlOW90Q0xrYWRuVmd4aFkzV3I3?=
 =?utf-8?B?cFhROTA0Z0Q0VU9lVVdlVHBZdHhJR3BxNFkzQk9YeThoTURTU2RWeUlmdzg1?=
 =?utf-8?B?SEpDUEhMZXJHbVJ5dUVlMHJ1OUwrMXZyS1prYUV0eVVVeUF1b1laWVorSUww?=
 =?utf-8?B?SHowL09jTnZWRFlKeHphQTdPc2F1QTlIT3djb2FrZXlZVjNBT2pNcFRVdnYz?=
 =?utf-8?B?cGRZMktBSWFCR21DTUM2ZUxScVBlMW1qNk92SVl5NXg0ZFEzRVY1Y1EzbTlN?=
 =?utf-8?B?RUhTaW1iMHZTajdWaUN2UWc5V016VXQwYlFIZVlQdTM4YWd5cXpNMXA0eGY3?=
 =?utf-8?B?aHhIVG5Tb1FQVEZnUmRhYXcrOFlMVEpnR1pYa0UrSTNFL3I1bzEybGtSVURi?=
 =?utf-8?B?NkZjUXIxMTJaT01kVGVrcEtBRGZJQWhvbXMyMUFMNlJXYXR6VkE3NUVDM3k0?=
 =?utf-8?B?ZGIxNTFKdWpuaEJKMUo1Q2hLSjE0emc2L1lIOGhSWUlSd0xuOEVSSWxGaC9T?=
 =?utf-8?Q?eb+JSc6Aq00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(10070799003)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnpKSm9QMDNkb3JFcGI5VkRldEZnM05SL1ovYVkzN2VGaVBWYXE0NThkcUVV?=
 =?utf-8?B?TWVsNDYvZU5Mb1lnYnF1Nk1xbE16b1V4R3hJZ3N6SUx0eG9RYzlwekhBSXlG?=
 =?utf-8?B?SjdlcHZHZ2l1T3dxUTgzNHlRVGtvbXF4K3FESlpES3BLSnE5OVovSi8xNGpi?=
 =?utf-8?B?dC94ZTBNRzBYY0Q5eFErL2ErS2hraWxMMUlJNjhpSlIzQ09TSFZxTnNkQjZo?=
 =?utf-8?B?dzNzSFhpZmcwS2xtNXppM3ZSZEVRY0FDSDNSSHJWUFA4MDZMdDg1K2c0Rk80?=
 =?utf-8?B?STY1NnZXbk8vcXBzaXIzM0w1aEthWEU0MGVjcG1FbTVEOWJNUzN0eEhDN1Y0?=
 =?utf-8?B?R0VQSW10U2VRWnBhdjlYQkdqdVRSbHdrd2k1eEp6VTZzUW5CZ09DQTRnVHFp?=
 =?utf-8?B?ckQ2ZmVKNzhWYXpxUGtnMUFtN28zekc2Z08yaWJ1N3VjdjRydFVnV3pDMTBC?=
 =?utf-8?B?UUpDYXZTam4xZTZsalZHbUJ0L2FDTDJTRWQvQmNFcEV4c3kwZ3ViSlYxUHBS?=
 =?utf-8?B?cEdSdnk3QTJrL2o2UEhPU1Bjd1Z1T2hkcjVhVFJBc2MxeXF3akttb2dkdjZ4?=
 =?utf-8?B?eGdhYzNLdzJOZVhIYmt5Y0RrOThDTWdqM2xiTXRDYkdSZDFhNytHcnF1d1ha?=
 =?utf-8?B?U0tuRlZrSHRxVjZvUFBMblh5K2l1TzZzeWgyektIUW9mTlRzemRWVmovOFpZ?=
 =?utf-8?B?dmRmZVVub2hFbDNTNXd0WUl0MkFhV3hYa2wzOHRPWWZpL1p0OVRDU1ljQXg5?=
 =?utf-8?B?Y2J3WlNDRkkvaEFTc25nSXA4VFFPT0N2OFRLMURTQ0RyaExYcFFsSjg2d0o1?=
 =?utf-8?B?ZjBzMXlMd01pNHlrQ3RieloyanVhVWZpN2YzcDNHTmkzSG1wRDNLNGxVV2xw?=
 =?utf-8?B?QnVoSUs3Z2xNVmpqNWFGc05qUDNnZGMvSlora1BObVowWnN5eGxDQ2FpZVFJ?=
 =?utf-8?B?ZmdQNjNxd3lhT1JiOXlCVHpQRmhuQk1JZ3c3ZUFsR2d1QnlkWTJvMktnK055?=
 =?utf-8?B?Q1RTY2prZmF5NXlldmEvaEFHdTF3NHhzZWc2ZjkzRnQyQTBIZnRyZCtLOXFk?=
 =?utf-8?B?bllETzVYbzVCdDVNQ21ZLzk5ZE9VWUxGNEFweS8rKzZlaW9sU3V4S0FYUG5o?=
 =?utf-8?B?VVNsdGlLV2xneEZzRFJDcnFUc1JreFZBL0FFK1dBWWM4Zk42WDJzRW9RdHE3?=
 =?utf-8?B?bkxUWU5IWmFHM3o1cDgxYnlQRFpRR3djcmVlVk40NUFORjZpM0ZUTWtPcjJX?=
 =?utf-8?B?cFM0UFJ6TUpSMVZkcXVqSlFTWDRRck90QmtPS2xZUjBQOFo1ZHlLSXZ0K1B5?=
 =?utf-8?B?dHdqYnJmVXB6YTlXNmpwQVlocVpmWDloNjYwRE5JaTczUjFQNGZxSFBTd3JJ?=
 =?utf-8?B?VWViMmNwNktQSEdWUVd3ZkR6azJTdlVMak02V2VGODN1QXFobEIwcUcrd0V4?=
 =?utf-8?B?dGs5MkIyTXZXWDNwc0hDZlQrMy9HZWNZTWkzcjFCRkxyeTlVcUlRYW1zSSs3?=
 =?utf-8?B?WGZlWk1sVE1KTFpVVnRzNlFiaWJaeE1md01KZVg4U1FvUUQ3S2NPRG5rYTVB?=
 =?utf-8?B?WEJxOUppVTdHUG1KcC9Cc3gyU1BqNFQ4RENpekFjWjh3UStlcEZ0elZCVCtL?=
 =?utf-8?B?bG5QcUdaOG8vUEhtTnlGKzFMd1c2aVQwRjdmenI3ZE41WlhqckVHYkpCSDBW?=
 =?utf-8?B?K3FYcExXMnVwclRtc3pBTm1tTTJsUU1ldXFoVGJNeDVxbEpPbEl5VEZ0L0NF?=
 =?utf-8?B?cVo2MXMxSUkrODdHdzVYMHgwaFdhNGxvZXBXdDgwTUYzcXBzcXdLSVVWb080?=
 =?utf-8?B?a3FUeGJtYVk3WlBnUVFOcS92TjM0Q3VQZWxDVExNekRsU2ljbEV6dDFSZWIz?=
 =?utf-8?B?eVBkR1FqL2ltQklFMjc1VWZZbVhPdjZxZ3crK3FPcG5JaG1CQi9BYnVDSFFh?=
 =?utf-8?B?SnZ4MXZqWmx2aExQK1A1TC9tdkw0NGJhYzlzT2NmV1pOeFIzcGMrTExWN0NB?=
 =?utf-8?B?UXNERzEzMXJza05jN3RPdXNHMW9qRHRleHB1dFMxU3FXVkhiREUyaHlCMjhF?=
 =?utf-8?B?MVRqYmxQRnRzTWJFbkI2c1hrQmVOdlFxR1JicVkvVlhndm1WelF1RXZ0YTlN?=
 =?utf-8?B?VGNRMG1RYmQwUkVsY1ZabUtSbXAyNThSZlN0dVhUQnd3OFBTeThBaDdSSU5I?=
 =?utf-8?Q?ckmlPesLoV/y2c8dDfCtqwYtHdVD+FNiqTwhmZzoKeFB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95521609-676b-4d57-56c3-08dd316d4d23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 11:52:47.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/+N9c1ca/89HB3/w3v+V2QvK9Ukc4J9oQZHGpjqK8fb+thrumqpK8an+QrwqFvwBccMuD+W/GDS/XBtdNIYRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

Hi Juri,

On 15/11/2024 11:48, Juri Lelli wrote:
> Currently we check for bandwidth overflow potentially due to hotplug
> operations at the end of sched_cpu_deactivate(), after the cpu going
> offline has already been removed from scheduling, active_mask, etc.
> This can create issues for DEADLINE tasks, as there is a substantial
> race window between the start of sched_cpu_deactivate() and the moment
> we possibly decide to roll-back the operation if dl_bw_deactivate()
> returns failure in cpuset_cpu_inactive(). An example is a throttled
> task that sees its replenishment timer firing while the cpu it was
> previously running on is considered offline, but before
> dl_bw_deactivate() had a chance to say no and roll-back happened.
> 
> Fix this by directly calling dl_bw_deactivate() first thing in
> sched_cpu_deactivate() and do the required calculation in the former
> function considering the cpu passed as an argument as offline already.
> 
> By doing so we also simplify sched_cpu_deactivate(), as there is no need
> anymore for any kind of roll-back if we fail early.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> Thanks Waiman and Phil for testing and reviewing the scratch version of
> this change. I think the below might be better, as we end up with a
> clean-up as well.
> 
> Please take another look when you/others have time.
> ---
>   kernel/sched/core.c     | 22 +++++++---------------
>   kernel/sched/deadline.c | 12 ++++++++++--
>   2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d1049e784510..e2c6eacf793e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8054,19 +8054,14 @@ static void cpuset_cpu_active(void)
>   	cpuset_update_active_cpus();
>   }
>   
> -static int cpuset_cpu_inactive(unsigned int cpu)
> +static void cpuset_cpu_inactive(unsigned int cpu)
>   {
>   	if (!cpuhp_tasks_frozen) {
> -		int ret = dl_bw_deactivate(cpu);
> -
> -		if (ret)
> -			return ret;
>   		cpuset_update_active_cpus();
>   	} else {
>   		num_cpus_frozen++;
>   		partition_sched_domains(1, NULL, NULL);
>   	}
> -	return 0;
>   }
>   
>   static inline void sched_smt_present_inc(int cpu)
> @@ -8128,6 +8123,11 @@ int sched_cpu_deactivate(unsigned int cpu)
>   	struct rq *rq = cpu_rq(cpu);
>   	int ret;
>   
> +	ret = dl_bw_deactivate(cpu);
> +
> +	if (ret)
> +		return ret;
> +
>   	/*
>   	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
>   	 * load balancing when not active
> @@ -8173,15 +8173,7 @@ int sched_cpu_deactivate(unsigned int cpu)
>   		return 0;
>   
>   	sched_update_numa(cpu, false);
> -	ret = cpuset_cpu_inactive(cpu);
> -	if (ret) {
> -		sched_smt_present_inc(cpu);
> -		sched_set_rq_online(rq, cpu);
> -		balance_push_set(cpu, false);
> -		set_cpu_active(cpu, true);
> -		sched_update_numa(cpu, true);
> -		return ret;
> -	}
> +	cpuset_cpu_inactive(cpu);
>   	sched_domains_numa_masks_clear(cpu);
>   	return 0;
>   }
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 267ea8bacaf6..6e988d4cd787 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3505,6 +3505,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   		}
>   		break;
>   	case dl_bw_req_deactivate:
> +		/*
> +		 * cpu is not off yet, but we need to do the math by
> +		 * considering it off already (i.e., what would happen if we
> +		 * turn cpu off?).
> +		 */
> +		cap -= arch_scale_cpu_capacity(cpu);
> +
>   		/*
>   		 * cpu is going offline and NORMAL tasks will be moved away
>   		 * from it. We can thus discount dl_server bandwidth
> @@ -3522,9 +3529,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   		if (dl_b->total_bw - fair_server_bw > 0) {
>   			/*
>   			 * Leaving at least one CPU for DEADLINE tasks seems a
> -			 * wise thing to do.
> +			 * wise thing to do. As said above, cpu is not offline
> +			 * yet, so account for that.
>   			 */
> -			if (dl_bw_cpus(cpu))
> +			if (dl_bw_cpus(cpu) - 1)
>   				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
>   			else
>   				overflow = 1;


I have noticed a suspend regression on one of our Tegra boards and 
bisect is pointing to this commit. If I revert this on top of -next then 
I don't see the issue.

The only messages I see when suspend fails are ...

[   53.905976] Error taking CPU1 down: -16
[   53.909887] Non-boot CPUs are not disabled

So far this is only happening on Tegra186 (ARM64). Let me know if you 
have any thoughts.

Thanks
Jon

-- 
nvpublic


