Return-Path: <cgroups+bounces-10769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A07BDE027
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 12:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DEE3ABE0E
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301431D729;
	Wed, 15 Oct 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZwzM40cy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pI3vr/Wq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550E31BCBC;
	Wed, 15 Oct 2025 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524098; cv=fail; b=FCkDf+leOev9SgFLSh6sjjm7sSW2v2SqkKuwUyb2nsGdJXOH93pPhcoj5xSIzWei4pt62g8UE2YPNJdHr2JRXpzx720uAV8z9Z14IlV8iZ1rAmOTX54YT7kdS330rc1tnyWImB3PY7kLHR7hIAK1CP1YvMqIyI1pQ13qRy1xq34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524098; c=relaxed/simple;
	bh=z0saHqwfaUJK+NYQzDcAS0StIXIV8wm6DJwe+WaI4as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z72/CeOAyCiBVYSFG3NAOJDcBpFvXhhS+iZrmT2bjA54v+i/xTR9vXOnx9XaydNXOyCMQkFC6k7o7Sq/zluqYEWviDEoeXA0EAXL7FV+9DYe0dmAWj7eCGra7Icsf9+7FfXMJ/fhfijG4Wcg3Wo7MpcK5N76dJvMUDDmXhZ7XG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZwzM40cy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pI3vr/Wq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F9nbEf026274;
	Wed, 15 Oct 2025 10:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1ccmkSpTBnjmyYXhIkqaW+CBOWqxxuRF7xCBPSR5EzY=; b=
	ZwzM40cyd87VpWFW/Qw0PogNKy+0GduqG2e4ttfZNLNhRfkWQ4KuvxMQcvBmc2AY
	827sVPoVha3GE3wMoSLTXW4TLzv7tjKasgLMKcs8Hmgrf5wFhR5LXtZcAF6xfNlQ
	7Sf8v1I7VzxZtufULWQPBA04ZsPIk4nAsS8XpcgdrbPcttJyKxPfXTOyX+SNiTuy
	2dl/OjM90QZMfaUz/cLtNEstuDvEpRw5IA9EzRsDPj/Zs2utMmShT2wzmQFlW4Xi
	Hq8gnexiP8QobE7K9Hp/9OV/L44bsoiMmqxEETqCt883hnkv02NFXnZNRG2xyZQO
	uKZYJO0mwHi1Ak2M3IopxA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bxd81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 10:27:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59FA3oAX017446;
	Wed, 15 Oct 2025 10:27:48 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9x5kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 10:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xqr4Ns4itVGLaDfOHprCZz7ufvC2xbfxJvNMIhVF4uCSwJbOKTuF/XfZ50YGNL/gniSCeAi18uK11haxO4S6uknORtwRE1WaEQghG9hA/IwdugIeulhfIXGwirZvOJxljDcK7acuxw+Qe+uRpBCNCEAMoY43TJOFKA0TQQusIDJPJGHxS6A6CNPQmEWVEW4NfeDYkU2I3AbmiYx+muJxksBUaGaK/DZShx/SRHpxveiiU0etCmZNpkztMEDp9AYzmqLcVf7uLrDfDjIS8Gd//rtTTSnpE0oYIHEHm4CeMzEzbRhQWTxBK7bDs4ZWvpOC5QrM19dXAxDPQcEDzw/zKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ccmkSpTBnjmyYXhIkqaW+CBOWqxxuRF7xCBPSR5EzY=;
 b=Qt9qKTNx9jWlqmyxAWsnorvL6Ex0UypYEa3mwaOvDZuMwUhP6ZB4utLKgSu0THbwB0p1bTk3imLa9w+a8bkrwOh+NY6JtwswzF+kbVEw7jVwM1LJZrO61HRXST4/XudGIze03g3xz5wVVF+cteBZCBTZK9XQUQDSodxFSub5cxc1SIMVmUJGKpgDcnCTmsBsrkq9K4vFxD2WtKc8AU3ilBuxxakJBoXZX/NOMP8M4TtjDd/jP9113Vsxh5gPOoziD1n0SWX26KjVL3ywRb/bu58dGwIMVDjaknNLF3YwjRwPXqmQSd5ivBVUMhcyhiKgeTWZnTSE+2d4nhxAyZ0waA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ccmkSpTBnjmyYXhIkqaW+CBOWqxxuRF7xCBPSR5EzY=;
 b=pI3vr/WquJIgFBge453N5SD4T+8N5bLrqGGLfiJiFCfs630W9qdRNJLoW/pzM8NECTRlAcX+8/TYvCZSqFf5xPptheSx9ItQ5p66NaiU1cRZEA79zLQwMxYqSJbC4a5N2K75kpSy5Hdx+k7yhsr+rcVjKLGLoqTOEQSEeHIvLno=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA3PR10MB8017.namprd10.prod.outlook.com (2603:10b6:208:512::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 10:27:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 10:27:45 +0000
Date: Wed, 15 Oct 2025 19:27:36 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Message-ID: <aO93GHNR_32-Pmom@hyeyoo>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <aO9okBEZiA4pCNku@hyeyoo>
 <c07838ca-4e6e-4837-b99f-09fd44c7801c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c07838ca-4e6e-4837-b99f-09fd44c7801c@suse.cz>
X-ClientProxiedBy: SL2P216CA0117.KORP216.PROD.OUTLOOK.COM (2603:1096:101::14)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA3PR10MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f43a860-1d9f-4d5b-1922-08de0bd57adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGV1SVpXLzZxKzBGVVJsaWNHYkZmM3hEcFdiejlmNjU2U0ptSk82bEZvYU43?=
 =?utf-8?B?Rnk5d0dOdVBDL1J4SFV6OEtwWDJKWGpnYXlIS2RPZ3JoNzlYR1JwMUNTTkQv?=
 =?utf-8?B?cHpkdW40SmJ6aVVDV3Ftc005RG9YbTlReGZYb3lQbmtmbmo4R3V0bS9XUzNx?=
 =?utf-8?B?Vi9DSkJ3S0FLeW5wU1FEYU9mU2RBcTQwNG80K2NWUURMTWpyc3BBUldvajNQ?=
 =?utf-8?B?ZVRqVzR2MXYrR1hQMGprNEh4YVhQTzIyaTVxUEJGTlBRbTlxZ3FoSlY0U2NR?=
 =?utf-8?B?U092M1BKb2R5bHd2LzFsVE1yTkZHaEJOVkNPZE1HVGVjNU52SlZZOEVDYmEr?=
 =?utf-8?B?aVRJa2prQ3Q4bjBabExRbTdUQlRsUElYdEhVVGIzUC9LNWlSc25wb25BaFBB?=
 =?utf-8?B?TVR6ZEhKVGIzdjdZaytoa3NvWTlJd0ZOb2FzT2sxMGN2MXhtL0pySGpObEx3?=
 =?utf-8?B?U083dmdsT01QeXNnRzJmZW05V3c0aVFwcWFCcVRTbnRIQVBSTzIzTDhmRFhH?=
 =?utf-8?B?eUt6c0hhS0l0OTVhNlFrTXBUM3hNeGpPanlsU1R0MmNGWGYyRitLdi9WMzB6?=
 =?utf-8?B?Rm41dm43WSs1c3NGZlUxU0RBZmtPWjRQUTNOWVcxU3paTDlCQVY1Q1JpRjNM?=
 =?utf-8?B?TlF0UTlHUUZPd21nNkVYWjkyRzZBa2JxVGUwUW0vUUdLbWM5cFRwMWZhVTdu?=
 =?utf-8?B?aVI4UTlJNGZ5MEo5YUxzcW9GVTBrMUp1Y2NOR2VGMGI5bkd3dndVeitodGov?=
 =?utf-8?B?aXpHK0JZWG50MlIxRlFNQVpZb3FOUjMyQ0RIK0N4TkFqTEFHYjg2Z1BrRGp3?=
 =?utf-8?B?WGpNWEZiS212N3Aya00rdFJQU0w3U0czTFh5aFcvVmhKQ2JSN1A1eVRxV0ls?=
 =?utf-8?B?RkZyVXFFSmZBU2J4Y0hTUFhibkV6OVNlWHk1dUd6emljQTJOdm04RHB5cjlK?=
 =?utf-8?B?dE5XbTRXNGVXemZ4RTJibUJNTkZFRFJoRTFjVXhmREt6TEdSb21zSFBGUVpY?=
 =?utf-8?B?TTNvK2pScVZtWXRHY0w5UU5aYUVOaHpWVHM3cDg3Mm44OFVrMmM5SHdTUER1?=
 =?utf-8?B?OTNwS2tJV09MYSttVmp6VU84WURQMXlWaE0zS2tIYThsNE1lMEt5T3Vjc1Rj?=
 =?utf-8?B?T01XNFlqZE9mbGNhaVpLcHlXSmMyZkF4TUNSMVBYUEtaMnh3QmovaXljRnBp?=
 =?utf-8?B?MXpURWQzLytGMjAvc1NkNUFpZ1l5R3RLUmNxaVdRc3o5S28rOUNCYWN1WGdS?=
 =?utf-8?B?R2oydnB2emxIZ1pwcldIWUxTRmdTM3p5Z2RPOWR6d2c2ZDNrbTZscmxqZksx?=
 =?utf-8?B?d1BPQmhYUDJFdUFXSmZ3WXpqVXZGRVNVQmFNVHJ2YUkwSGFUNjRtQk92ZGg0?=
 =?utf-8?B?ZlhZS0pqSzdnRVNIdVRXRjVCTy9DVDAvWUJIMmFsMk01ZmJ2Z1E4ZzgwM1Ji?=
 =?utf-8?B?ZzNEQXZLdEV2WGNzRExHZW5Rcnp3dEpJM05xZ2xQbkJPcE1tTHdldTI0Qm1Q?=
 =?utf-8?B?S2tUN2hINWhVTEl0OCtMczhyaWZOL0NOZ2o2aEYxYmVIclAzQnN6cGFReWwv?=
 =?utf-8?B?THNmSFhQSEM2Z2lJMzFXQnF5cVUxS2w0Z1dEeGxDaXZqYWVBSUlRdTRBTkdE?=
 =?utf-8?B?bmhCdUN5T2JmS2hIbEJVR3NoQTVDYW5WZEs3NERhQ29qcnpsUDFrNWdTK2c0?=
 =?utf-8?B?UXl0K3RWc1JCMXhOK2luMmZkRnl0RWlMdlN2bmZkanlWeENhcUlMQU1vdjlW?=
 =?utf-8?B?SDNRWnB0US8zV2YwVk5TTmQvQm1Yc0t5TVdkTUplWGc0OXBhS1lSdWQ4a2wr?=
 =?utf-8?B?MlFqSXdhMEV6d25PQ1NTZUs2eXVBM0JFUEFsd1NSNEE1UWZCK3RNa21PbHFR?=
 =?utf-8?B?SXMxR2JFWjU4Smc2OE1OSWQ5ZEdteFlMbFIxN2lteXMycGtiZDBYdWlkNGlX?=
 =?utf-8?Q?gKlomQjg8c44nyQo22XkqpeMP3SbTO37?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhjRXc4Y3dubUQ5akwwbGV1QU9MQndyNko0SURod2RvSnBkUzV3T2o1NnJ6?=
 =?utf-8?B?VEd2VndLNnRnWXE1UjZmdTZzNVZlRm1Rc2hrb2NiODNoMlhpc3VaektwWEcw?=
 =?utf-8?B?djRmQllPWUxSY3hVTTArOHNnRElzUzMxMnUzZldSYVdQTU1yUFQzL2QwQUVi?=
 =?utf-8?B?NU9oUkVodExNUkh6d2FQVk9SRjVtL3BJcnpzMm9ra3Z5SGl1K3FsOVZLRXND?=
 =?utf-8?B?S2Evc3U1RHdsZk5jSWk1ZzRkMHdtcHVucXdIQWFzRWdFQ0x0MmlqdG5RMlJv?=
 =?utf-8?B?NnFDdkZvUVhxRlZwVTVuWHFnY040WnNCY1FHc1hjS0xTVHAyT3ZMM0JKYjM1?=
 =?utf-8?B?bzc1U3VXRkRKdHZXZ2NIR3NwblJRTXo0U2REaC9lZklveUEzSzZtdzI2VWtF?=
 =?utf-8?B?L2h2bEdHM1NLaGtyOU9sUnNyZDlrZldOMkJybFVBNWlTT1M0TnlyYzRMNWhK?=
 =?utf-8?B?a3JpbitXbUZIR2JFVDNMOEVKSHUvRHkwc0RncjIyOGJzZFpxQTlZK2RmTWdz?=
 =?utf-8?B?alFHV2w0YnA5dkpkZE0wR3pGK0JBQ1BleEpmL24xenhmQ056VlBpY3hmNWpT?=
 =?utf-8?B?Rm94bTBQUkoyNU9sRzA2dlhUV2JCQXhyUlhGcVd1ZTNvVlYrcHhnQWE2SDkr?=
 =?utf-8?B?TGdUWDM5c2wrMHZFMEFHK2E2Tmt4dkt1SUhrUjBpTm5sak5jVyttNjY3WWhx?=
 =?utf-8?B?dWZtRXkzNGxPRDBEY3liUjlrRHJub05PWFZlRGFsMjFFeEV1Sm9CblY3UTNj?=
 =?utf-8?B?STk4dFNxYXVzeFhCdDB1dmRhUllGaWV5S0VVQ2Z3UXFIN1F4T2VxUUtsVWx6?=
 =?utf-8?B?WCt3dXBVRkp4TitEVFByd0M5UkE0UkdzY3NKa1g1VUJqV1VvNVprOW5uVlcw?=
 =?utf-8?B?R1A0ZTdiNmczb3UrVXgrQkNFZDJxMHRMdlE1WkFuaWpHSGIzQmZzYzRZQ3Ji?=
 =?utf-8?B?ekZiL3cxSnMwWXAyaTdnZ1FQaE1IUkx2M09DbUFxUWZ6V3Q5UVhhazNWM2Q5?=
 =?utf-8?B?ZlM1dC9YRlIybmp0d1ZreFdVVmFCazhFSEtYNnFBVGJyaUhkV2hyTFY1VVVn?=
 =?utf-8?B?WlV0UmViR3BCaE8weFNlNlc2cnZNT0RpeFoxN3M5L0lYUTc5MGJNdVg3d1dJ?=
 =?utf-8?B?TnpXclBVc1NGcVlPenJCSWlEaWxvN002b0hKamlFYkRSdmtvRGR1WHo2OGFz?=
 =?utf-8?B?S2lWQXpCZmxWRVdtODJFV0xaNzhaNUtOb0RJbWJBMzdlL1hhRzhOaFVpYmFq?=
 =?utf-8?B?WGFsY1JFTFdWaWkvU2ZtbHp3RXN4ZkUyYWl5RnRUWUM2NzFHMXIwaVdvSWlU?=
 =?utf-8?B?bWxQYzNvbUlobi9yMkp5enVGdXBmc1dhb3lQc2V1WC90SnRlSTBuNGQ2NE9H?=
 =?utf-8?B?STRiUi9hUjV5M0ZVaVp5c3llempFaG9OKzR4dGNiUEpya3c3L2IxWXd3NUZZ?=
 =?utf-8?B?Myt1TXhmVmlJbmh3ODNaRWJqREJpdWtCNWZoOERTODgrcHc5MmFYYVU2R0xP?=
 =?utf-8?B?UFh5bi91NTBZTHJCWUdyQkVJckhQdDZTNWhIT0RtN3Y2djBvWTRLQnM3QVNR?=
 =?utf-8?B?Z2lYWWg2UWVZNEE0anZqWkRHQWJNUzFZNnFiOUZJcmQ5b1ZPZmROb0t0Q3VT?=
 =?utf-8?B?Lzlwd3FvQ0hWSXNyYllKK2lWV3JPNWorcEJJd0VtakJrMHpNUWhta0dxeFNY?=
 =?utf-8?B?UVozSVIzc2ZVaWNRbkJXSU1QNU4rZ21wK3hxNW14Y1FSck9qa0lGZyt5U3U5?=
 =?utf-8?B?MzhRM2xUcDJVS3lMQ2hWQTBqVVlkOUhGbnl3UmxVdHQ4M04wWUprY2wwZDVk?=
 =?utf-8?B?ek1xT2FEZTV4SmFjUnppYjAxK05jVkpoa0dQYXNEbkFCU2pxNDJYeU9aRVBB?=
 =?utf-8?B?UGh0dzBoZVNnS082Uko5KzFmSG5ITVc2MVlrOGRMQjd0SlJaODFRS2sycVFX?=
 =?utf-8?B?VTJ1ZzNqcjJpZjZUQUZoV3hkaUw0ckhsWHd0K1JjZlUwWXJqZVRsMEx3SGJy?=
 =?utf-8?B?KytOaGdPRy9makhXWUxRcERHUkpVT0Z1Y2NpdVc1cDdoMUV0L1RvMzhSRHFV?=
 =?utf-8?B?cVh0bTlZazFXQmp2VGdYazd3SnZ6VE1KQW9waU9LNlhPUkFDdVk3blpEQ0dj?=
 =?utf-8?Q?ivb8n2bDeWroUmG+0T4BpA5Or?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0i+JK+IUVM1kpBF4uPOemUZKD7ERomhxtrgk8vE4v9m/DwYBLwI/yJ/UHBrO6PB+7S/CJKqbHUqV4IsYbozblNRx+2v1yQbtzBM1evquhA2DYskZefrDgxa0B0RJegpgEJbmSNSiGVjZzy7obp5HSL7j/HF6cqG3lb/b+XM2b24dZxpp7Q6OvLn0DzlUu9wl/uGeR2jJn+/G/o+yTe+rHSYcKFtIi9hkBSxX7tAs/JZgBL5yVVq+7QcHxfXQnbTbj4qJ4XOOCXa7a3l3jNwniOc0ki9U4KaASzV44o0dKvct0wYUa/Xc29+jrfiXR1JUjvi22o3cR1J/rkHmiX9CTKlY5z+lWibRwiBzkV2KOnh+/XtnXlJF5BYarQ+NPT7nXBJFxMfPyiphXy7wACS7+dL/R6gfKuzZAh424Y6AvaxHUis31l9jBRs0zsgS6Yq8b1VVAqbfO1on8tm2EG4Mq0BFWm1zomc/9li6TNBcCpaBxie57TJWTEneBxBWchCSOnWaz+bKBShY3PbqXTCu6HR6s9KfS78UoV+DpKuzNbEyvFOvCCO9LBmqtGvwQoMg6+sl3m6O0TLi+UVszrVcCPxAxMY4at6fdSJqG7o14vQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f43a860-1d9f-4d5b-1922-08de0bd57adb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:27:45.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UspWRoDLaLKAbxlQyFcUTW/RpKO1hJGUwOsqyIKxroFnwTw7NsOmDIfg9+ScMtTyel8LACu3xlYAt+2Of7YzpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150080
X-Proofpoint-GUID: _PuQSJUm6APYCrHHE9uqGQ4cwGbBAnfF
X-Proofpoint-ORIG-GUID: _PuQSJUm6APYCrHHE9uqGQ4cwGbBAnfF
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ef7725 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=MQ1gMiTpSGTMWmlmXPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX305B0BqYyYCq
 G+P8H/hC7m+KfOk76R99IKW/Qm8EbA+wMcRDnvrH3oSoVtsWpXUI1P1G9ef1v8kdICWNed9mDQM
 NnqH85GC9wSvJhPF5kW4wlI2hWg3N0qjwa7Wa85FsK9kBOqh9vWhVHVgSXM6cPDkSu46HspGHnG
 qvszQqK7wPvkTS7AiqarEk5cGirCWAd0fZbElZ8shz/JUveZyB74MyjzUc/AOoMEjX3u8/4RGHx
 QO3Wbx+iATjkcvjnTmpB9pxqVzJZnZcsjHZifDxFChTMTzeTbMB4MCxi0Imai1vVnTdhcag9zZF
 uGvL9OODwm50Ucy8X0HDb8aapsXPkm1HC/ZlI/NbnUpBjYOJa9OphcxnxNlP1HWMJ00rI374yYj
 Yhf7KMOo9eQp+0Eu2uYIqY7HleklWg==

On Wed, Oct 15, 2025 at 11:54:18AM +0200, Vlastimil Babka wrote:
> On 10/15/25 11:25, Harry Yoo wrote:
> > On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
> >> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
> >> >
> >> > From: Hao Ge <gehao@kylinos.cn>
> >> >
> >> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> >> > the same bit position, we cannot determine whether memcg_data still
> >> > points to the slabobj_ext vector simply by checking
> >> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
> >> >
> >> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
> >> > and during the release of the associated folio, the BUG check is triggered
> >> > because it was mistakenly assumed that a valid folio->memcg_data
> >> > was not cleared before freeing the folio.
> > 
> > nit: yesterday I was confused that this is sanity checks in buddy complaining
> > folio->memcg_data not being cleared, but it's actually folio_memcg_kmem()
> > complaining that MEMCG_OBJEXTS_DATA flag is set on non-slab folios (in
> > free_pages_prepare(), if PageMemcgKmem(page) -> __memcg_kmem_uncharge_page()))
> > So the paragraph above should be updated?
> > 
> > And as a side question, we clear slab->obj_exts when freeing obj_ext array,
> > but don't clear OBJEXTS_ALLOC_FAIL when freeing a slab? That's not good.
> 
> Hm great point. We should rather make sure it's cleared always, instead of
> adjusting the debugging check, which shouldn't be then necessary, right?

Yeah folio_memcg_kmem() isn't supposed to be called on slabs anyway
(it's not a slab at the time we free it to buddy), so we don't have to
adjust the debug check.

> >> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
> >> >
> >> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> >> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> >> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> 
> >> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >>
> >> nit: I think it would be helpful if the changelog explained why we
> >> need the additional check. We can have the same bit set in two
> >> different situations:
> >> 1. object extension vector allocation failure;
> >> 2. memcg_data pointing to a valid mem_cgroup.
> >> To distinguish between them, we need to check not only the bit itself
> >> but also the rest of this field. If the rest is NULL, we have case 1,
> >> otherwise case 2.
> > 
> > Agreed.
> > 
> > In general LGTM,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > By the way, maybe it'd be nice to introduce a new helper function that
> > properly checks MEMCG_DATA_OBJEXTS flag.
> 
> I thought so too at first...
> 
> >> ~/slab (slab/for-next-fixes)> git grep -n MEMCG_DATA_OBJEXTS
> >> include/linux/memcontrol.h:337:	MEMCG_DATA_OBJEXTS = (1UL << 0),
> >> include/linux/memcontrol.h:344:#define __OBJEXTS_ALLOC_FAIL	MEMCG_DATA_OBJEXTS
> >> include/linux/memcontrol.h:358:	 * MEMCG_DATA_OBJEXTS.
> > 
> >> include/linux/memcontrol.h:400:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
> >> include/linux/memcontrol.h:421:	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
> > 
> > these two,
> > 
> >> include/linux/memcontrol.h:492:	if (memcg_data & MEMCG_DATA_OBJEXTS)
> > 
> > this,
> > 
> >> include/linux/memcontrol.h:538:			(folio->memcg_data & MEMCG_DATA_OBJEXTS),
> >> include/linux/memcontrol.h:1491: * if MEMCG_DATA_OBJEXTS is set.
> >> mm/kfence/core.c:624:				 MEMCG_DATA_OBJEXTS;
> > 
> >> mm/page_owner.c:513:	if (memcg_data & MEMCG_DATA_OBJEXTS)
> > 
> > this,
> > 
> >> mm/slab.h:541:	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
> >> mm/slab.h:543:	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
> >> mm/slub.c:2137:	new_exts |= MEMCG_DATA_OBJEXTS;
> >> tools/mm/show_page_info.py:55:        MEMCG_DATA_OBJEXTS = prog.constant("MEMCG_DATA_OBJEXTS").value_()
> > 
> >> tools/mm/show_page_info.py:59:        if memcg_data & MEMCG_DATA_OBJEXTS:
> > 
> > and this do not look good.
> > 
> > I mean technically they are fine since OBJEXTS_ALLOC_FAIL is set on
> > slabs only, but that's just a coincidence.
> 
> And checked the the other debugging checks too. But then thought it's better
> that if these are not expected to see slabs, then they should not be
> adjusted. I don't see it as a coincidence but as intention to keep it slab
> specific. It will be also more future proof for the upcoming separation of
> struct slab from struct page.

Then we're intentionally using (folio->memcg_data & MEMCG_DATA_OBJEXTS) check
as a way to determine whether the folio is a slab (either slabobj_ext array
allocation succeeded or failed).

That makes sense to me!

> >> > ---
> >> > v3: Simplify the solution, per Harry's suggestion in the v1 comments
> >> >     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> >> > ---
> >> >  include/linux/memcontrol.h | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> >> > index 873e510d6f8d..7ed15f858dc4 100644
> >> > --- a/include/linux/memcontrol.h
> >> > +++ b/include/linux/memcontrol.h
> >> > @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
> >> >  static inline bool folio_memcg_kmem(struct folio *folio)
> >> >  {
> >> >         VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
> >> > -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
> >> > +       VM_BUG_ON_FOLIO((folio->memcg_data != OBJEXTS_ALLOC_FAIL) &&
> >> > +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
> >> > +                       folio);
> >> >         return folio->memcg_data & MEMCG_DATA_KMEM;
> >> >  }
> >> >
> >> > --
> >> > 2.25.1
> > 
> 

-- 
Cheers,
Harry / Hyeonggon

