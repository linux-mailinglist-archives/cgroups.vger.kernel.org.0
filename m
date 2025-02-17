Return-Path: <cgroups+bounces-6568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D4A388E9
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D01636B0
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 16:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B55223705;
	Mon, 17 Feb 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sy7w/Rmq"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B721CA10;
	Mon, 17 Feb 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808660; cv=fail; b=HKggfIZ6Xj+nJA+4j7BGCW2Kkz5wYHTU5UVEg3x79nxPUdRWjLRy3Q+kDyWu8VgMaGgqS26xCCc04RA3ibPqd9QfWpeQg4JO95DAvDg5C0/1HKvy7UJWsS1XoectchDxgxdzTltDaKnTSbr0Sv1zUDXi8tHzVfxetTgpokMjtpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808660; c=relaxed/simple;
	bh=mylSF3SxDVFmGDPqnDKHE3fNxl3TlHr9v6ryxgzpous=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tRum2JpeKF4dOiljo+Ako9QS7MBJowODiFSVDETyQNoypU6vfuuD3VWIRmf86yeHvTI5h3mffPPDzrKTtTnNmYyDjkfDT4He/BbYRhZX78ix9GIsyBmqaumg1VQNS/+NhVH7sBOPqKUBTvSTG9EX0REsifYQQjshciU0mJ60nWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sy7w/Rmq; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q78ZQm3vTf69mEZz+uLKDrLDJef8b+MvVZyw60AqhB27exPWOI8tfVC9onVkZqFyIdiLZeIjqGAUvvS+vZkUPWEuCalCzoTBv9+clH+R8w6VQ44U7YCQOX96DnqJIKlx0dXuRh57E0IUCeIwBOXf9gmFVE95e0jz4y9Nd3YABJ2uh2iQexkT3d6YmaozqrN+QiQU7HYpmmbzW0hT/mqT55pz1WeOTBU4g5bpPNF78OI7YlDjZ7yqOhVwViW+GTcLmihknXOmmEM/WM05lOq/zJG6TxiXhQo8GGWi5zeq93mZysEhRo8rgqhW/vuLAY2BBh6gs47af2QfbM9JzvkEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JLrBOQVKYB19A3llco/dDXkpqWJ0WUgKuepo22BR4E=;
 b=rJMDyg2U5vlYgD0uzOCZFexrmiGZZOtnhoNKmt9Zg2c9V2XWhLOfqqMHYaXFvAQVrQY50jnSCE4isks1hhGtAAXpoSAiMX/IXZPEBWgYlTSKfHUuqKU0zXwcG6BJ4QP8bAU1EjeQ2H6teYb/6mB15OA4zosDfxflFLt8uPzDogzEXQOG5/dOvCvypV7954t5AclRfrK+NP2GhbAUZaHNmcjeR5sJ8ElZw0nHNTrbssW8cJ1X0/dRgQulGQpJhUXbXhbUk/F0V6K/0RLcu6M/+OxO/is8Wk9/EDA7iaNGcTeJU6FMoTtul3teDl5XUJ517XQDMNOCVbftPSbMNmTquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JLrBOQVKYB19A3llco/dDXkpqWJ0WUgKuepo22BR4E=;
 b=Sy7w/Rmqu6uB7Ion+fEGp2NftA4FInig4+T2wy+KD+UN5eXi+SsGVP/8nW1XFK7z5CzBSmLSR9HhQAWT/0lseBWEEdfWFk4KXTsEeyIEPjGxU5qKEZsTIFvyL6Az8N4sysiPRGBS1B2CXyfKEPLiWctJWTqErColvUSUOJbGRmHDK/bHq1o/1XHRby5RwJE2WjK6K8t0bM97Gb4flQmii7ngn7NoHWPRuBewqCO2nDtzq8nR537FF2kqKis7KGSu1nueLnn0kEnitj5GkmEydBAPT9yqUC4xa702XZX6WxVgYazJ9AUbSiYPOZtrV3HxrJ/lgSZZo7rB1t+ygfGdew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 16:10:56 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 16:10:55 +0000
Message-ID: <371e6b88-e7d5-4e78-9468-33e29f7fdb53@nvidia.com>
Date: Mon, 17 Feb 2025 16:10:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
References: <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::12) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6981da-f814-41ec-e596-08dd4f6da8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlQ2cWRRYlIvNmI0VGJxVzM0WWh5eEhVZlJ6dXRBN1NBWUVPaDlxaXNaNkdH?=
 =?utf-8?B?bG54ZUttRW10am1ySUdQWDFKV3ZERWF2dk4wVDlTbGtFOWxyTllTdk5OcUV1?=
 =?utf-8?B?dk1xV3ZESW5NcFpJN0FLYzBvQmd0Y2pNWWJVSTNBdmdQNm5nRDYrSGR2bnlu?=
 =?utf-8?B?K2JRZ0EySHBiZVVtTTFyOXFraGFZSlhHQXViNUNYaHZZOWN0azZOZm1aeXFy?=
 =?utf-8?B?YVQ4Q3loVkhyckNwN2pyL1JzWHhkVzdVL2IrTktYVS92T2FqZVV0WUZQNEI1?=
 =?utf-8?B?OVJrRXBqbGlmUkFDZGxkWElrNmFGQVVUeUZWQkUxWDV2cjd5N2Z6WHpOUlpY?=
 =?utf-8?B?bS9VTFo5UlR5dVJqZVcwQ3VkaE5GcXdzTFFVTStKendmaktUUlNxOFExaGVs?=
 =?utf-8?B?YkFJV0N3OEdRaVgvOHE0eUtITHM3amVtejVtTk1mQVBTR1BWejk5VzhTREdZ?=
 =?utf-8?B?UWVDU3ppUnlpV25NdUZiOVVxeFNXSWpHRkh1ODB1L2dkb2tmSU5CdG11VG9x?=
 =?utf-8?B?MHFMQ0FKY1VYWHVXZ0ZPRjl2eCt2aUl0WENvWGJWTnJ1ZEFTSUhnME5SZEZv?=
 =?utf-8?B?NERvWnlKOHpMamdWMndBWnpvRHJVZnc0dFNTL3dTR1A0ZVpUdlE3eVZ0eGho?=
 =?utf-8?B?VVo2cjlDcHRScVhpaFFhaHpITVIrOEZRNUtiNEhIRnFCNytONlFhUUh5bmZq?=
 =?utf-8?B?WG8xaW95aFR5NVcwTXhGV0I2RXJrNmxNaE5KSnA4YzV1VjVzM2lhTkpxbjZU?=
 =?utf-8?B?c0d3bFdJNTBLb0o0Q1F1c2RzWUo0OFZZS2dxYS9wZFVlb0QwNVVZVmtySkti?=
 =?utf-8?B?cHJ3OWZNUVkwb2JGQVkxdjY0aXYvUUhGQk1tK1ZiL2Y5clFCR3MyWDhFUXE4?=
 =?utf-8?B?MWVHeG9tVSsxQ0cvQTVyK2Y0TUdYZEt4bmVNSmNnY3NQWVh5MW5FNFB3RTYr?=
 =?utf-8?B?WmptcTFNUjdNZnhyczJLc2RFNHJPa2JoUWZ6NnptOHB3Y1JweHN2SEpBTkJz?=
 =?utf-8?B?aWc2d3k2dHJQSS9STjRBK3crTDF2dGN5VVZDWktRRGYvdzM5akxPaUV1azAv?=
 =?utf-8?B?eTk3QVVzeDRHcHp6VmtFZVd2MDUzVU11dzlrVjB2Qm5iV3NqaklNRm1mTzk4?=
 =?utf-8?B?U3NYR0RBM1VjL0VZSEQ3cmNpb2RacCtYazNReHZBL3N1cWpLN3dsWnNoTnBu?=
 =?utf-8?B?ajNHY1Q2SjRLQ3NONWZLWFRaVlhrc2ErZVlWYVcweUJPazEvZy9DZmlvTElQ?=
 =?utf-8?B?M0U0QUNvbFhiMzV5alg3RWEvOVJveXA0d0lRUG82U1ZCZEw3bGtENm8xQmt2?=
 =?utf-8?B?eEdOTVhWRlN3dTB4NkJDYjJ6TkhkbllxWG4ycmkzSjlveFdYT090NHNQWVZm?=
 =?utf-8?B?WE1wWVF5R292OHpibGFUZDNocFhZcWNFY3pwU0pJZ0k2eEgwaHVKWGk0QmlR?=
 =?utf-8?B?anBPOWhtZGI4LzVOR3BWZEdzYzVFZU8zRWVmemlKWUp5Tmw2NU40czRnb3ZF?=
 =?utf-8?B?UGQycjJBUXkwY0JtcTNzMGNULzk1NDNjSmdhN0QzSDIzMXpneTl1bkw4aTJj?=
 =?utf-8?B?Y2loNzYzZks2cHBGNnlFTXdPUFJWVTFBdXF0bG1oN2c5bnhHVlkvUGVncm80?=
 =?utf-8?B?Yi8rak9MMUNQaVpMNzA3ejhQT0lVS0NGOEdKNjVPa25sZDcrazhhRGFKWDBE?=
 =?utf-8?B?cmZRWGk2a1Zra3g3VW10WlNicE9sYlNNRS9GVGpCeUllQjZsVFV4L3dpdmJF?=
 =?utf-8?B?M0Y2NW9zVXFqR0UxYm9nQmQ5RWhTdmMwTkhIM0RiUzFrdEczT0pab2dXTW4r?=
 =?utf-8?B?UTFTMHUzb2Z5WTNZVEJmSk9kMlNCa3cwa1RSWUxyYlhDZUd0dk5LOHpoT1pT?=
 =?utf-8?Q?14TRBdvgztPcg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2krNmVIak1VTncyL3o2WDBMWlBaYmJCMkNrUDJLSFh0YTU5UnpXbXo0MkFN?=
 =?utf-8?B?UXlIK0UrblJ1c1I1QzRzZ2ZOWXFLSUF2MUk1TDFFcXRsNkFXRzA2TVYweEly?=
 =?utf-8?B?ZVNac3Q2dkZObkNOT08zU3pzclAzejFrQVdFMVU1K0VLTE9tSnhidEZIdE1s?=
 =?utf-8?B?eWlUYnh3eFlXamN1eVcvejRrMTFFbmRJQlhURTVFRVpLbnJxL1p5WERpSTFP?=
 =?utf-8?B?MkhsUy8vTW9MNzhJNHd2TiswWGxiMjlqTk4vOXkzcWtzZEFKb3BtbkRLQVVa?=
 =?utf-8?B?UlNMNDJaQzA4WXIxeFVXeU1yZ3dMd1lFMVpNNmNRQ0Ixc2MxZ3F6a3pTbU0z?=
 =?utf-8?B?WEh4U0JGajh0NXVtd3kzc3NSN0g1Nm9VbGVtcXNNTjAxRXpEWDlod01Ea1Fl?=
 =?utf-8?B?NUFaeXRKVUoyTWxCMnJzMlhzVTgrYlRXSW16Wm1OMDZ0aXJQakV1Uzk1aFR4?=
 =?utf-8?B?RkFLODBrWCtEQTN0MTVOVTdGdHZnQ3NnNTFTaHh0R3JBU2QvM1VmWDVuaGJu?=
 =?utf-8?B?QWQxU0FvK1hPK2Z2b1JwWVRHeS9ZR3JpaW9yM0N5Zkt6amRuc1VaUEgzdzlJ?=
 =?utf-8?B?NUlQaUtnRU8wU2I1SEZHcWRoaVQyaVo1aGxIMEovV1RvVm1oeHJXZHdYNG5n?=
 =?utf-8?B?YTNDQ2t5VmxKY0VCYXFPWDBFb3Ria3RNOHBtMTVrS1lXOUJYc053WkpWa20z?=
 =?utf-8?B?Z0RZbm5McmF6RFhGUEd1VnRScjZ3akp6M1dOSk53TVpZZWMxQ21QWkNTZ0Qv?=
 =?utf-8?B?bHBjc0dXSUQ2L0lQcmNLZTMxYjBkZ0tLL0IrZXlXYllrV3RMS1NLalFWUCtP?=
 =?utf-8?B?TzNiSEtDWC9nTVZlVFlIT09qRnhISW90TlJpcHFVcmFiT3E4MitHK05YSE9Z?=
 =?utf-8?B?a2pEYVFWcWRvQWhRTjBFS1FyanRxTjlwUzFYejdpUFJObjQ1d2FoVDhFWVoy?=
 =?utf-8?B?WTRiWWlpa0o0c3NDVGFjZHJJbmpiOW5HLzhCQXNNNkJBTDgwZDFsUEcybWtW?=
 =?utf-8?B?NndjYnFkR2lxdGMyNi9yMVdaUHh1YjhIYW1JaHNYaTBBM294RS9mMk4zZUdQ?=
 =?utf-8?B?MXFrT3lwTTRXcmhDWjFZZ1VMTG04b0FLbVp6MDUrM0Z2QXBIUjdKVUFmWFdS?=
 =?utf-8?B?aXlYeUFJbldValk0bkVzZEdRdWZ6U2JkVlc3RWdyQjZUdEtrNUc1dVgzRm1E?=
 =?utf-8?B?MnQzOUNxcHAxcUtLaGZxcFE0aVI2dGFRV1RxZGNIcHRhYVFDSDNRT1MzQ0da?=
 =?utf-8?B?ZDFOVHViUXJ2aEg5bVBvb3pPVS9WSXE1VWpIQjRncXhXQ05RV2VTTDJpREFH?=
 =?utf-8?B?MzM5bVRQQ2pRYlY2NC9LcnBSZjRFMCs2TzNUU3BWUzFnVEs2T2FoTlY2RXRq?=
 =?utf-8?B?UGhiMXZ3SlB6Y2gweWs3WklZZmMwQmEvQTF4OFlLVGZBS1dBd3JXY3pRSHRO?=
 =?utf-8?B?YWJyc2dRbUlVT0YrNWU1U2dwdEp3TlpKbFNDVm9MM3IvaEtXTHZKUS85Nko4?=
 =?utf-8?B?em5OV0Y2VXZZaUJZYzJWdlFSZWpSQjArYnFsWWZITzA5WHM1T1R3eERxWWM1?=
 =?utf-8?B?WW5wU3d3cDVGRHRpanJDSlZOR1FXRHhrcDJYeXFUc2RWU05keGRwVEp3OGFm?=
 =?utf-8?B?VVl2OUw2QUlBRi9RRnZRVU04Z1FhcHhSdDVrNGI2Vys0WEtoNmhSOE45ZG5w?=
 =?utf-8?B?L1R6OEtKSDZrajVrRHg3OXlYWGVsK0lmWXNmYkNwcExCS0U1a3JxcGdGSlpa?=
 =?utf-8?B?MDFJMW9mYzZWbFZIaldQeHlVMzdSdld5WDg0L094QzBwUEVUcVMzQ0U4Kzdl?=
 =?utf-8?B?SFlIMGRpVE5WMFVrUURWd1UvdW1pVmpzYjlMNG5ObkNSdXEzL2pzcXpHZ280?=
 =?utf-8?B?aUpuSTFFUGR6YTl5MVVwSW5NaWd1ODBBV0lqeGxLdTFDb09UUnROUU9TbVR2?=
 =?utf-8?B?NzlJRlBSWisrUExmQWVERlNERlViTXJWTkdCS0trYlI5L1VMZXNDZXhubEhO?=
 =?utf-8?B?azBCVjc5NHZqSkNBTjBEdmFwN1BIZEtRRlZSQ1ROOGtRNk93cUlleU1xVTdL?=
 =?utf-8?B?NW5PcityN3hQY29TQnE1QnRvUzh0ZUl2MkFOY0dYTTQvWEMwbmN4czlkbjJ5?=
 =?utf-8?Q?h7hlufyFHIxF8SVjSz0nVOvaO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6981da-f814-41ec-e596-08dd4f6da8ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:10:55.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0Ga8X1gi8WPRM9Oq7GBcqf3k+vN4SO1BYmjztYtdHa9TEmuKZqkECFXG4lJTlP4v9phse19ymxkcEJ8GQrmiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527


On 17/02/2025 16:08, Juri Lelli wrote:
> On 14/02/25 10:05, Jon Hunter wrote:
> 
> ...
> 
>> Sorry for the delay, the day got away from me. However, it is still not
>> working :-(
> 
> Ouch.
> 
>> Console log is attached.
> 
> Thanks. Did you happen to also collect a corresponding trace?

Sorry, but I am not sure exactly what trace do you want?

Thanks
Jon

--
nvpublic

