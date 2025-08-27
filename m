Return-Path: <cgroups+bounces-9445-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CDB38868
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D29AA4E3040
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55757283FFB;
	Wed, 27 Aug 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="CXCQDqCT"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9F2BE657
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315003; cv=fail; b=WZo4mZk8AqfzU+27yQ9i4PsjJ2sWgwxrUN4L9eO7Arelh39bbKLtCDebl0cG/xUM7bq7Xqn0bLAo2/BnJm3IMJ9l4vfRTxzpyM6FbZX+r5Fw3aSS6jjF9LgSrsgG8QoEmttp8PDiLSyyyjiy4ROa7sRz4hNkwoynEi4xo/TrECk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315003; c=relaxed/simple;
	bh=S0vFwI9OT1c5x9uT+Bivg3CU3GGKSMh+VQbsvWIOPgg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBu9Sg8O+N+G1xR5Df0sDAexYwcDc7qS6zkN9i5ti3lyUHXhnnxIDnVKVEC5S4dDv6aQDrQMFFPk3Q/hVQWMLdihW8/8XZGkjW/1lCIhF8rWmaEi/NV1MxOT+WqNKt0rRefOgyQk7U04MoF66p2gy2qyjxFQKueHloflflDtyXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=CXCQDqCT; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57RAgiRc4018311;
	Wed, 27 Aug 2025 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Gh8qcMbiMZRrTdmIkLzmuhUnXKloSmQ7J4Bi/0UTCaQ=; b=CXCQDqCTec+l
	wi3IS/DhUlClP4DN2po2GScytKr2wq4AdAQNQ8C/hST3ZphTqQue2VlAQguwtqqF
	3jJGb19Jxm5jJvA/69uyFz3l/aWTZq6VuH9eBq4HhSdnq7309b4MaMAPcPXkmEIH
	VKVAa7Q5V3aqvG3tEIsxy8NomDqTl8crPyDPQdiuAi25+F4CA4BCDZ1dgdmYSihq
	p7f8JIlpTmHjHre270I2gg7F1MNyVs/us5IqT/mEPBXRz4elcXCEwkzoglZXPHr8
	uKrTuXjShEqUiVaLdO/ITxF7yImyZYctLee/KwuQDQ0gdmUwGWD/rLnYJUlDyJpV
	KMVJBEte6A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48q2v1cv5a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 17:16:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYWjW6ocdjQs64Z4Yv75FpHc9zsD2107nK/sllUL92a+fqBDm2/gXTfvyAq0z5ZGI8xxl7WL1/cktu5OGgouu6T/r/Ik/zQFZZVJWISAhBzv2M0r9K0wb6uFS7+R/NYdyqS4ZMFS+N60NVGQyWz4dNuDUveeJu3i3qyUngMCmRnki+GTdcpoPEpbmO6Udue4WuIfInbSqOHKLPZzPA+rGogsZZGc6dS2aL8KjWW/UyZM4JioGeVIa/r7/mUJ+OMpJyX7ZOzL5w8BiF+Defqwna/DtUphcj7XGgQXb8J7YfzTOUJ4VQrRh1LQdpN4MznQFyVPOg0wW64xfd7kKfTWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh8qcMbiMZRrTdmIkLzmuhUnXKloSmQ7J4Bi/0UTCaQ=;
 b=u4E8uZ7XGOzr1FPc1mu94xUGaQtXvkC1CpyWxgK0MCDqqyjPotTcWvBZTlpGKTk3LAoGzHtroeN1ryBY/thRlzlb9zlWDPo6DCeSgWT1RkVUAyk0BoNGwRCTOi4sTRz/qRc3Z4ZE1iQFxFqA1IXFPeotD4X9SDgrDeV9tFXc7HiHRO9+uvzXaUrGH5VH6e3bxUJdJh2a4Rv81JLiFSRAWR0yufjYnvIr4S8FwV+tAOn/pVd8zoALjq1P7RB1qQe4umNjRZvAMEuRfFF+VglC+esQaSpOhGGByqc2rOvKNWeldcYjf7Day5Ai3fTQJjY8gMW7a1/Omf6McVkw58IVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by IA4PR11MB9108.namprd11.prod.outlook.com (2603:10b6:208:567::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 27 Aug
 2025 17:16:09 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 17:16:09 +0000
Message-ID: <94a854bf-84c8-438f-aaf0-90434fdef117@windriver.com>
Date: Wed, 27 Aug 2025 11:16:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: unexpected behaviour of cgroups v1 on 6.12 kernel
To: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org,
        lizefan@huawei.com
References: <f5a182a3-ca68-4917-b232-721445fbc928@windriver.com>
 <c3451e0d-694a-409e-839c-2491181f870f@huaweicloud.com>
Content-Language: en-US
From: Chris Friesen <chris.friesen@windriver.com>
In-Reply-To: <c3451e0d-694a-409e-839c-2491181f870f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0015.namprd15.prod.outlook.com
 (2603:10b6:207:17::28) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|IA4PR11MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: f666c47a-085a-4221-35ff-08dde58d6a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTFaYTlPOVhTVUNQSzVJQXd2b0ZIK1JCV1VWWXkxZHhGLzFwcCtFU29yS2lt?=
 =?utf-8?B?SnZTeSs2eEVsVEtITUZvSGNFRXFIemZweFUxTmFIN2pxZVI4M2N2U3RjT0dC?=
 =?utf-8?B?dGducEc3cmdzRFhhMG5nR2l5b3ZuamNJc1pCb3EzWDFGTk1ENzBLUzNSYUpo?=
 =?utf-8?B?a29FNE1weHdtMlRYdmVsWHB5T2J1TDkrQ2srSjFHQi9tdUovU0dRTUgvUnpD?=
 =?utf-8?B?WlZEaStUeU5NcW5sR2NFcXRadTgrem9vTmZGUlo2TDl2Rkx3THlxMWR2WHpB?=
 =?utf-8?B?NGhZb2FZOFhMb1puZDN4Y2h0YW54MzY5RTNiWDRRd2FnTERIa2JrUVNmdllB?=
 =?utf-8?B?SEw4U3BkdzllQ3RTM2xqVkZFL3R2aWRNSWdjcUs4ck1wa3ZUOU1mRUp0TDQy?=
 =?utf-8?B?TXVSQnJqWFY1ZEZGMFlTakg1K1h5N3h0K3M2NUxoTUdSaWZXVmwwNThET09t?=
 =?utf-8?B?ZnRSTmdaSjdGL1kwd3VHUXd2ajI4UWxyb3ArVTVrbmVXWHAwTzdMdnRoMnJ4?=
 =?utf-8?B?WXkwalJVY0NEemo3U094eHdtZE1CL0M0QXpaSWdnN0hyQ2dHVU9aeWhHYkcv?=
 =?utf-8?B?YjM5dTZRZVNsU3hzK3ZMd1BrMzdBSGxrcGsveGxsTW5KeUlXSzQ3a1Zsd1hO?=
 =?utf-8?B?K0xsNjh5YURVb0xWMnJpdnY0bHROUjNiVWE3eC83K1dVUjZqWGZqYjRMVWg3?=
 =?utf-8?B?ZngvODEzRmY5ZWFnMzVpOGljcjFsUlFNVHhjTjZHU3hRM0RjZ3hoR2txbjQz?=
 =?utf-8?B?OEhTdVFOMFEzRzVDM3pxZ3VmOEJRR2t4K3QvMDlkMDRqbzBGOFZzaXlXRnIw?=
 =?utf-8?B?QWZ2SktwRHAybm5WZ25JdmFWbjE1NFpyMkQ3WCtnV1ovR1g1S0R5allRYU5C?=
 =?utf-8?B?ditqVTUvMm9nY2FTNVFuWGxkMHNRNnFMWjJjRHA0V09nMVYya1FyZlY1SUV1?=
 =?utf-8?B?MlBuWUdnQlRvVUdSR2ZObjRoR3hsczE1Ny9SMXZPNjBQbmpUU2FpVXhGRlVD?=
 =?utf-8?B?bFpUa002RkVqcTA0L0piZmczRmtldEg2RGFVZHhrc2czeUFVMTRxRFQ4dDgz?=
 =?utf-8?B?RStLTHBhUFZuNTF2bnpDOUtmQzYrL3MzbGZuSHhFS0J4YWdpWUR0YnlqK0g3?=
 =?utf-8?B?RmNjNVZNcnN2VE9VMnd6Z1F2ZzdDY20xU091emsxaE93SGdrUkdEdGYrK0tB?=
 =?utf-8?B?VEVuSGVsTTNGSDRFSFRiTStpYmJSWEpJenkzbkI5N2tYcU9EdFJNTkltTWEv?=
 =?utf-8?B?V3dwZm1SNTMvc3BmZUZqQVNRUHVDWlV5aUJnRTFCTGhqTVJNWnErb21UU1pF?=
 =?utf-8?B?YlJJNEtBWWd0VkgyZGpYVFZRejBEMVRPQzdyOVZ6Q1h3OXU3VHJoOVYzY2lP?=
 =?utf-8?B?cDQ2N3BPczRTeHJFNmZuUEFnS2Z3STU5Q2VlWlRtMUNKWnQ0VDJyNmUyR3Qy?=
 =?utf-8?B?VElTQ0Yvb0RRekxESjdyU3paV2lPUmYwRTFtZjM5Qkhaa09XOEV2ck5hRXBN?=
 =?utf-8?B?eldvWDFBdEtPZjJtT1AzdkpTdDdlM0R1RmtQZVZiZ29qUzdESzNXdjBKUkQr?=
 =?utf-8?B?cDhzZ0tsWG5IelVUK3ZYaFNWS2w0bXAvUDhiMTNxS3F1bnVUMWY0dGRoeklr?=
 =?utf-8?B?Y2Z4U3dqbmMvK1J3R0ZBRHpkOHplLzRvZWVsSlYvcDVBWVo5V3VMZVRIclha?=
 =?utf-8?B?bWZQdU8vU25YY2pRdjJ6b3hYb1BrbGMvZWxLQmcvMytQV0QwM0NzUGZFaENI?=
 =?utf-8?B?VHFGRW16bC9FWE1YRjlDVDNGbExvUHJma3MwdXYwR1ZhQlQ1aFNyZndGRWFJ?=
 =?utf-8?B?bWpnb3lJYjQyMVV6eHNIQ0J5b0h0dUxaWkFIZjJLL0lTUWpOM3d2emNyVUVI?=
 =?utf-8?B?SXdpOGJ4UEdzK3NONi9tNXJodU0xY0hLRTlZYkV5ZjlFenR2N24rdEVpcUhM?=
 =?utf-8?Q?k5O9cd8RdF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amQxSjQxc1lGNXR3RWQzNCtVZ3RsMDlGUUM5RzM4KzRwY3VxRVNFMVF1RDVZ?=
 =?utf-8?B?NlRaUWlyZjBmSFE0enA3c3cxbDZZd01rSk9Ka0RmZ2cveldackhmdVpNUDRq?=
 =?utf-8?B?VGZqY0tGaDR1SS9Lc2F1d2FEL0IxQmUxY1lqT1NETGVvUk1jRlJvdHBrdWpt?=
 =?utf-8?B?WkkwWi9adzFHT3VsRStmYXk0OWZmaHJBWnZBcTVLRzBXU0hxR0hZSE92M0NO?=
 =?utf-8?B?UjhTTUhNSU43N2V2NjFGVUJiMi9FN0ZVWDRwWTE1M0xaQ2ZYem5Dd0Y4QUxC?=
 =?utf-8?B?WVJGS3hkeGE0THJxNWRad09iYkNhVXhMdGlvZE5nQmk4L1JtVi9zdWZEOEtM?=
 =?utf-8?B?TCtleGFrVW10RjRCWGFmeTNNdFJ5NmxRUmo3K3hpS0JyN1lySXlvZGtnM21L?=
 =?utf-8?B?czdrVFJsS1oraHk4N2VqbWRsM1BsaTFZendmYTVLWUtQOHJybEVnSmxWWDJS?=
 =?utf-8?B?Y2Z6YzdLMVpKTy9aSGROVGJndXlTalp0dXlTR2hZbkVBR2xTMWRTUDBiYlox?=
 =?utf-8?B?cEpiMlBKOWxjcTEybkFQc0MrV1cyWkpTbmJLLyt2Q2JuQTdOdzhCd2YyS2w2?=
 =?utf-8?B?a0c0cUdaYWFHOUVWdlJDYTZsc3lLNWxOZEpDKzRYTDZJQXh5R21ZR2VwdHNi?=
 =?utf-8?B?bytPSURuUkNySkttUXY0d29rSzk4eFRFaUVzNWpRYmtpdnljZ3I0TTdiUWVx?=
 =?utf-8?B?NWk4cE9COTQvazV1UnhGNnhtS1RGYzRyUlVZWTh6YVF4eUR0eG81Y3lqblZU?=
 =?utf-8?B?c21wOGVUNVlvcVh5VzBDbjhJQUhnNDZ5OXl5Qko2TjdiUnZOSzV5dHk4c09y?=
 =?utf-8?B?V1RqZklIRkpOMmp5b1FpVHU0UWRRdjZLNkpZWThyT3hKWGNGa0RDWDJOL1Jj?=
 =?utf-8?B?ZUNEZXp6RzJGVE1wdE5YWm5kZVRIbjdVZWswS3JDOTFWR29lYUZWRUk1R1c1?=
 =?utf-8?B?ZTU5dXJ3Y0ZUalhYNlhJVlBWTmlSSmVzSHFTemJrck5DVE1sdVpadE5JRXdS?=
 =?utf-8?B?aVhtWTRFd0RiZURBbTk0L0lPK3ZONkJ6N1BIMDZEN0dEbzl0SVdkZEh0anp2?=
 =?utf-8?B?R2ZlUmRjZlJSMmRMNGhucFBQWU1aa3ErNEN2VE5oNk8vaElZTXBQUmdKQ3RZ?=
 =?utf-8?B?Y2ViK3pZSUNxamVXcngyZElzeDl5aEVhR2c1TzExUGVMNW1pZC9Hc0NHRENm?=
 =?utf-8?B?NVdVRjA5dVpNdC9sTC83Y1UzbnNOVHgvQlJKdXYzR0lrb0JxTStYUGV5bWFX?=
 =?utf-8?B?OUlYUDQvMDlpODA0bVpKaGN4MVRQU1VoUThKZm43NVlha3BtRTdpYTlVdjJU?=
 =?utf-8?B?Nmdua0hWY0VidksvUFV0NG0wbm9aZTJsbGJqUVJRRE5JMnpRZk5mZlBpK1lK?=
 =?utf-8?B?NlNZekhFcmRwNEpSOGFEN3pVZDA1dm8rcXQ0eEtqZGdRM2M4Wm5ES204ZC9w?=
 =?utf-8?B?ZjJ6NUFYeU1nTmNhL0w2Ui9HbDc0WjF0bFpyMjZSZnBDV3FTdTlXd0Z3cTB0?=
 =?utf-8?B?ODhWRWVYZzVsL0tXbTJqdC9iaHZGSjZxN0NIS0pOYW5XeXBRVmxCcG9qY2ZN?=
 =?utf-8?B?bFUrUmNRUzBmR1BTUVlpNnp1SjVERTRabm1FNys3Y3ArVndTeW82ZHdoZGNM?=
 =?utf-8?B?dGorTFV6L0pnc240NTBBNWtCaXFDTW15VmZxcjd4VDR4NHJ0V0pRYmdZQ2tr?=
 =?utf-8?B?V2RTVXlWMGlZZmRDU1d5NisyckJqeWFqKzc5K2NUUzZid1g5aVIyZW12cTFk?=
 =?utf-8?B?QVB4YWhHZ3RHM2t5Vi9CNHoxaXRXamdiM2ZCbzhnc2lxWXY5UnBCc1krNzBE?=
 =?utf-8?B?b2hBandxNWFXcmkyYjdFNlEzeXR5cXdKcklkelM1WHRlcHJyMTczeHdWbUFk?=
 =?utf-8?B?eDZlQ1U1N09YU2s2YnRiY1l5RHMxUVU3em9qckprZ1JsZk9aRmh3S1I2aVN0?=
 =?utf-8?B?cUR1bytzTXlPa1JmaHJaL2Vxb1pvQUFsUzNDYW9nZGUrZGI1OHFjeWdVRk9s?=
 =?utf-8?B?L3Y2TDNIc3dlZ3BuU2VTcU1nUUovZ2dIMERzbHJFb0NoWSsvK0lxZEJlelZr?=
 =?utf-8?B?MFhKd2owVGErUVc5MGZIRmlXTFF6cDJkbUczZW1KcXBaWE40dThDdzIrclRl?=
 =?utf-8?B?RWEzZEtQYi9pL004NXhNTEpOa2ZZZlhqdFlMZUs4WFVkVno5cmtHVW1pRll5?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f666c47a-085a-4221-35ff-08dde58d6a09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 17:16:09.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/gBuaoAnUS7ZlKzhJcOA4ood5AI0GMJgsz5MzCgfwZlokNBkGmHwhCpMdYPa37yijyDnfXMayThJs2/FlxLclGaRkUYvipuYf1hUkZmStU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9108
X-Proofpoint-ORIG-GUID: cm8BmZVmssDIw2kFwlbMehuWbPzXu-V3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDE0NyBTYWx0ZWRfX1iux5DOu6Jbm
 m8KTcCzlEs7QewVFXTNgDQO6bo6RACsjAG13VSdBUOukp/IojTUpbHBCEKelEAK/x/qzROK0MdC
 /1V6C2cYeP8Ud4gbl6Qss7aK45A4FNeHmqbgH3wRxJnIzwWzAL+ujwqoUq+vX8gYkqua8SLgI84
 zA67+LZkYqbv1BaRyDsn85s65pWyhAVFTu/A+1uGzCiYY4fRyrRytYpFI/Vqe+VFmJwIHSaBtb8
 Bd/RMN1PJubsDHm2NsY649ilWHuhaW9WKiCGv2vgq54BCT3vaE25z/8Yui9RQ63CUSrf+ixn7ZQ
 BIAw1M1e7BiEFJ4Eepa375GVzHVbrd8OXyCUvIv2fknCrT7Ulo92uZJkkJsVQc=
X-Authority-Analysis: v=2.4 cv=T5GMT+KQ c=1 sm=1 tr=0 ts=68af3d5d cx=c_pps
 a=Qc6thmohgkuMCYQSHWKqlA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=-AHZrNnIj3SwYc2ufwoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cm8BmZVmssDIw2kFwlbMehuWbPzXu-V3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

On 8/22/2025 6:57 PM, Chen Ridong wrote:
> On 2025/8/23 3:31, Chris Friesen wrote:
>> Hi all,
>>
>> I'm not subscribed to the list, so please CC me on replies.
>>
>> I'm seeing some unexpected behaviour with the cpu/cpuset cgroups controllers (with cgroups v1) on
>> 6.12.18 with PREEMPT_RT enabled.
>>
>> I set up the following cgroup hierarchy for both cpu and cpuset cgroups:
>>
>> foo:   cpu 15, shares 1024
>> foo/a: cpu 15, shares 1024
>>
>> bar:   cpu 15-19, shares 1024
>> bar/a: cpu 15, shares 1024
>> bar/b: cpu 16, shares 1024
>> bar/c: cpu 17, shares 1024
>> bar/d: cpu 18, shares 1024
>> bar/e: cpu 19, shares 1024
>>
>> I then ran a single cpu hog in each of the leaf-node cgroups in the default SCHED_OTHER class.
>>
>> As expected, the tasks in bar/b, bar/c, bar/d, and bar/e each got 100% of their CPU.  What I didn't
>> expect was that the task running in foo/a got 83.3%, while the task in bar/a got 16.7%.  Is this
>> expected?
>>
>> I guess what I'm asking here is whether the cgroups CPU share calculation is supposed to be
>> performed separately per CPU, or whether it's global but somehow scaled by the number of CPUs that
>> the cgroup is runnable on, so that the total CPU time of group "bar" is expected to be 5x the total
>> CPU time of group "foo".
>>
> 
> Hello Chris,
> 
> First of all, cpu and cpuset are different control group (cgroup) subsystems. 

Understood.  I created identical cgroup hierarchies in both cpu and 
cpuset, and moved the tasks into the equivalent cgroup in each subsystem.

 > If I understand> correctly, the behavior you're observing is expected.
> 
> Have the CPU shares been configured as follows?
>                  P
>               /     \
>   (1024:50%) foo   bar(1024:50%)
>              |     / \
> (50%*100%)  a   a b c d e(1024:50%*20%)

The cpu.shares is left at the default of 1024 for each cgroup, and your 
tree diagram accurately represents the cgroup hierarchy.

> The cpu subsystem allocates CPU time proportionally based on share weights. In this case, foo and
> bar are each expected to receive 50% of the total CPU time.
> 
> Within foo, subgroup a is configured to get 100% of foo's allocation, meaning it receives the full
> 50% of total CPU.
> 
> Within bar, the bar/a, b, c, d, and e each have a share weight of 20% relative to bar's total
> allocation if they you have tasks in each cgroup. This means each would get approximately 10% of the
> total CPU time (i.e., 50% × 20%).
> 
> This behavior is specific to the cpu subsystem and is independent of cpuset.

The reason I was asking about cpuset is that it matters whether the cpu 
subsystem is evaluating CPU time globally for the system as a whole, or 
separately for each CPU, or something more nuanced.

In the test above, only tasks in foo/a and bar/a can run on CPU 15.   So 
if the cgroup cpu.shares and cpuacct.usage was evaluated per-cpu they 
would be expected to get equal amounts of CPU.   On the other hand, if 
the CPU shares and usage were evaluated globally we'd expect cgroup 
"foo" to get *all* the runtime on CPU 15 since cgroup "bar" was getting 
4 CPUs worth of runtime on other CPUs.

Instead what we see is that foo/a gets 83.3% of CPU 15, while bar/a gets 
16.7%.    So there's something more complicated going on.

It looks like the kernel is saying that "bar" is runnable on 5 CPUs 
while "foo" is runnable on 1 CPU, so "bar" as a whole should get 5x the 
CPU usage of "foo" as a whole.  (100% + 100% + 100% + 100% + 16.7% is 
very close to 5x 83.3%)

Is the actual formula that is being used documented somewhere?

Thanks,
Chris

