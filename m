Return-Path: <cgroups+bounces-6214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D751BA1486D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 04:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E5D3AA518
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC51F63CF;
	Fri, 17 Jan 2025 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="wvYia7mT"
X-Original-To: cgroups@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952431E2007;
	Fri, 17 Jan 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737083484; cv=fail; b=XAa1/bbieK9c2QxUgrOmPvm4loJ962UwhsjhItUHDbUw5CTDUYledr8yHRdffppDBTRJug2TqLOY0bk7e3x2zYFaquyx9KQmXJ4ubKfE/ypEHY0TG6guDOL09uTp1JUGVMa0nrI8biP4GoObpfgcHtACWxAEMOIBmXQqjBur238=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737083484; c=relaxed/simple;
	bh=Ee0O/1rGrS9YO+hnd2uxa/bY9erPHoARcSeu4j++1m0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U02+k7ysV88KLk8rtxyKztkxZNXf8R7cYC/he6kvmXPk9k9xEeC9OfQfVtfMotZIW1U01wTK9C1WYGm1qpmW32rDPuUgEvowyE9btpklIhh12g+kCSP6UvG4lu/LvdZs6QbytpmA397qT99WYij29PpZZ8FrGi99COv8vemxWm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=wvYia7mT; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737083481; x=1768619481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ee0O/1rGrS9YO+hnd2uxa/bY9erPHoARcSeu4j++1m0=;
  b=wvYia7mThPHf4r4dTQs7b66ENYhabP1Jn/1iIZDuxjf95y1fmwJM3FFd
   V8l3Dpp0vuckSu/sD9M07wxyk4Ombl09IR0OcqYNEy3/cuckDmXR6JHdV
   b6FEp4mctpX/wiHSIycZD43aCI7+ZNy41BLdaEzajdl9LY9xH+Voy4+9r
   3lpPa3/cFipysxuNrZ9+hTOCAGPHQn2jfUNwvg87zcJLh2ds1Cb6FBI46
   O7BC2QkxtRmVNLzlRHcZw7vzX/yb2Z+TMhxJ9wa6LLFPXPzWP29NIHNwe
   woUvT+dw/3u2qMFzmje+S0Z3Gu62UOKMJmX/2nABXnFNA66c84JaMXKpG
   A==;
X-CSE-ConnectionGUID: XWJsXYawSUa+0HaY2gT2mg==
X-CSE-MsgGUID: wxXd9JoNTEaX857AuLb8ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="143658020"
X-IronPort-AV: E=Sophos;i="6.13,211,1732546800"; 
   d="scan'208";a="143658020"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:10:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePjQxUi/pNqsqpRD6e55asI470ZcAHyXzurCM+7EVNPqcln+g74VEdZKrfK+pcEWS53X7+SW0lB+RIdUr5CXi2wUBezxomwXJEDEuLjRrlWfZbJVjaMecVWJa/LB6LknizSfZ/RygAOC8xWPRRlReX//G7GDUIrjUZMA7j/Du37MMnwN3121eF1DCwGL4rWB1n5EqFpsGVOP5VRUmOoKma3MVKi6lovBd81i/2m6XvCGI3EHohmSSs1io/bTg5UX31GaRSqOK75pXTn4pf0zTQNwVTg/DxQCVuZbDBmxbacHilihW9vV79s/MoKOWU9nHzcXKt1HG7TmIiC3rW9yzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee0O/1rGrS9YO+hnd2uxa/bY9erPHoARcSeu4j++1m0=;
 b=A0NtrGe5w/95MGvn8+c4d5iBcrTDG23ZjyF0jRjvs7VH/LkNRr+B3U7lwrxvPWwio/TFk1tUArAB2+2qRj8OljVBsxdyZiUWdu1Gf5yZxXkTu2V6Q/IxsA1COfdk4CHR7GcPyYiCA99H8MthvobDBgW5ExDSS+n51m8Bsgxth4z+nTLdSQkVyMgL7bPR3n8Su9DETIFo3aqGDbFE4h4cWsfnXakFicNmmXHXffCeTckXXwGWpmv89sMeD0qMPB/9wr19T2F4cwYmmPaKNMG+n8R4tNhyHafB5M/rHwOBeIFWf8gs7R2tctJJy9/96PRpOH5r8UEQemvgCB7eRO9qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYRPR01MB13107.jpnprd01.prod.outlook.com (2603:1096:405:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 03:09:59 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 03:09:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Tejun Heo <tj@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
Thread-Topic: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
Thread-Index: AQHbZVca7HnVju8RR0uYmYTVv8vbIrMU/FsAgAPuKYCAAMBTAIAApQ2A
Date: Fri, 17 Jan 2025 03:09:59 +0000
Message-ID: <8d2d3903-aab2-4f38-b3ad-6adf7b0fc9ad@fujitsu.com>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <20250113010530.432396-1-lizhijian@fujitsu.com>
 <871px6bo3v.fsf@trenco.lwn.net>
 <4e96a241-a996-4289-9ac5-dc1ff65cbff8@fujitsu.com>
 <Z4k_kLW_a_D50v1I@slm.duckdns.org>
In-Reply-To: <Z4k_kLW_a_D50v1I@slm.duckdns.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYRPR01MB13107:EE_
x-ms-office365-filtering-correlation-id: a7af8df2-0613-4d7b-b684-08dd36a46d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWJkeHNEZGhQb1NzemVHeHA2ZlBGb09TdzJBc2RLako0UG1ZU2NINlhMN3VN?=
 =?utf-8?B?TnNETEs4djI1OTdOenlQcWpReDFZdnM4blNhaCs2YjRDMG5ydFBJTlhCcTRw?=
 =?utf-8?B?ZVppSUhLT2o1ZW1iTUZqbncvaEIzeU4vWS81Wm9hamRMYkRiM3A4dGV2QTdP?=
 =?utf-8?B?dUVaZG1qT3o2aEo4cXR1M2l3eXZQSnJQblJQZHJwaG5adm5BNFhHSG51QXpU?=
 =?utf-8?B?Y0IrYmIxbGdvb05XU3NmUjlsR01IT3o2bzdjUmN1OEgybVFHWmJtOHZKSkQ1?=
 =?utf-8?B?cGhISHA5enYvUjdhdjNES3RCTHZyM3UzNGRVSFVDdS9lcjkyRzJ0UnJHc1By?=
 =?utf-8?B?TUhVMXJrQ3NPdG9ONHVUYmowS1phZFhEd0dabUE0WmxYRENmaUVYNWZGcnkr?=
 =?utf-8?B?NTBXRWwwdkdEWEZVQlVHQWE1Uzk1ODRIdWlvTVdBK2ZXR2ZpajRBellVMTQw?=
 =?utf-8?B?NnR2UDRLSys0eVNsRUhEcU8waGx3dTJaRkNmbGlUNVViRFJOSlZuWkVZMVdr?=
 =?utf-8?B?MHIrcXVsWUw1WDJZcUR4bnhZajBMNDk0WkNUbkRHUlR3NE1uRFNQaUZYb0xm?=
 =?utf-8?B?c3dLUXVCZk5QaWpCQkhZdW9mSDBST2xoQVVTRG9GeUQyWERKQXlYQzdSTm9B?=
 =?utf-8?B?b3Y3TFNJSjk1cHY0RW85YXR6eG83K2R0Z0RhRytwN1Z0UFhLWUdDMUd5SU1i?=
 =?utf-8?B?OXhKRW5MV3FLelNvT2FWazFLSlN4RSt4aENubVREaVVyZDhQQktBQW9kakFU?=
 =?utf-8?B?Yjh6czFSaEpQUU1wSWpUUFpMdVpqVkRmYitRcWQ3eU51VVVOMGU4WEZaemZC?=
 =?utf-8?B?L2RaVk1NM1BrcVBjdkJiZzhGaWtaVTQxalNUSnhkV0FDOVBvUUVBMlBPcU96?=
 =?utf-8?B?NWVIVldybmp1dkI0KzV4TUxJbjgrTUpXMVFlRWtVcm1GcytrWHJkdkU5WSsr?=
 =?utf-8?B?UW00d1BxaDVCbFE3RkV1Tm42UmlnM1oyS2R1S3lkRkVaUlhJVWhtMm41MGhR?=
 =?utf-8?B?d0N5QSt2ME5nMzdxajJiemtwblp3eWVrWjFTbVllN0UrZGtNL2J6N2dZMEk2?=
 =?utf-8?B?M01RM3hxZUJ1M3FYZVVmb0pxOWk3Z0VNbjA4Qm16amdzS3cwbVh3WHczRzEw?=
 =?utf-8?B?cmJPdGxaZ0w3c0FPSjhub2lMallyeE81ZkYxM2c4eEtITlJNdFVtYkoxT2h3?=
 =?utf-8?B?NHY0dmMxUlZCZHk5dzcwRWY3WHNwYVJOc2V3cC92YWFUTXRWaDNpVWhoVVZl?=
 =?utf-8?B?eFlUOHUrckF5S1ppdkJrSGRkYkFxbG5nUU80b29NWWxuTGdma1M2N2lqQmJO?=
 =?utf-8?B?aVBWSkluVHlKUEZjK0JNU3ZoT3dlMWQvTTVLYXJ0VlNXdUdHNEIvUmtFblZr?=
 =?utf-8?B?bTE4T25iSWZWV0lEUEN3eHNrVGlvUE4xb0p3SmVYaDNXODFCZ3RCSzlZZFhT?=
 =?utf-8?B?bkswRWU3WHBnNGIyZkk3bm8rMCtqRmoxY0FuVmVuVmcxdXB2T1FRY2Q0ZjNt?=
 =?utf-8?B?Sm1GdWZzRWZmSVdOTWFzaXlxbk9XMnZOdXRRTDJjOFNGd29YN0lKMGRwOUVF?=
 =?utf-8?B?LzhJdFBYNmJkeDFZRUtBeEV1OFdsWEFuenVLdkthZnBwYlZWYk9zZ3M5S1Z2?=
 =?utf-8?B?R09tK2hrZHVpZ0lVdkhiekZoRDBCdlR4elJpYTZ3dkJpTWh5K0RuaGFWdEhP?=
 =?utf-8?B?QUdOQlRPNW5MY1pZak94TTltTVdUWkUrOE0rU0JtV0tQaC8xQ3N0bzR1SVpW?=
 =?utf-8?B?SXV1YlpMQXhZWkF6ajVXOEhTVERHVlpZWVdBeTFDZ3EyN09ZNmdoOUhjQmxB?=
 =?utf-8?B?TU1haG5ndnQ5Mmp3M0QyQjFTdDVQQjhEUmp5RStBYlhoZzVzV3pPMU1Tek9H?=
 =?utf-8?B?czYvUWJFN2RuU2V3TGZlSE1aOU1XVFVGZjh1c1R1azNwTUFLWjlSTWNlRm1Y?=
 =?utf-8?B?cFNnb0Iyd2ZtdnRnU1kreEMzeCtCN2pEQzU4eXphYWIyLzlDRW1yOSt3cGtS?=
 =?utf-8?B?QzllMVlzcUlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEdLY2VTRjJPL0RXVHNJdkZTblV0elRkZTFUSDI3U0ZLUGlMRVBJcUtVL0pw?=
 =?utf-8?B?TjQwQXQzU1lDbHVNRDFjQzNqWDEybzkvUUxrdmxrVTBhdnNjRjlMUW5qUURM?=
 =?utf-8?B?dnFPMDJhYis2M01yWjU5SFJvM3pQQmdHWWZ5ajF4OHM5V204VmtXZ2FIVVQ2?=
 =?utf-8?B?bitZc25VbnVmU1lScVhocXZlMGt5c3RVUnF0cnJaYjZYWjE2d0VIQzNWM21a?=
 =?utf-8?B?bzdWLzd5dGlMNVd5OUhLVGRMYjlBOTA2ejZLSlphV25DNGludkJUaFl6eXln?=
 =?utf-8?B?VHJFcWEvaFNpRy9rQ0RaNXR2OTMvRytYU2VRRGdjMEZGWWppT2Z6ZzF2MTND?=
 =?utf-8?B?TWVGWWxpYjBDZC9lWlhGTTVubWFmUjdydlBEQklzMGwvRm1RSlNkUTVTK0Ew?=
 =?utf-8?B?bzZ3a205VHNKYVlCZXJwbzlycDJlWWZvMVhMem5MMTNua21ESFo0Qmt2UGVH?=
 =?utf-8?B?NzhobHYwVzJ2UHRScDJpYmtWWElsTS9OajdRVFQrbnBCbStONDFncUd4WXBr?=
 =?utf-8?B?UC83KytvRFg3RlBPN1FMeVlwWDBQSEY1TTBJR1lXaUJIeUZHL2MyZVByNTFm?=
 =?utf-8?B?WTBQQW5McGNZUktzVjUwSGtkeWl2SkpPMGJCWHRiUzRFNDNMSDZpWU1NZnFC?=
 =?utf-8?B?cjlNcjNrb3cxaXh2c0loYzcvZk1NV2VZUGZRMi94eUFrZ0JMRFBNaTkxVzlK?=
 =?utf-8?B?ZG9HOUlNM3dIN3VjQkZud3FWNDRTR25sM3dJdER4OEZsWHRoVnVSRDVuL0Nu?=
 =?utf-8?B?QTBMQW5oWmpBY29Mc2tHc295WjJON3JOOHJIZkRGMEQ5ZkJkdnhpOGxzQUIx?=
 =?utf-8?B?c2srOWtJYUNZL2lCZ0NjNjArUG1oM0tjS2wyKy9wS3ZQa2pJb0lyMk0rTjZT?=
 =?utf-8?B?djVzWEd0WFFHNDN1TVV4bXlnOFFJT0xBR3Z0WThEYUtCekpCekt1U3hhK0M1?=
 =?utf-8?B?bktCRi9nMytNdTEvZjdkRDVRMjF4RHppdzBEY2FUYWFhQzNxNEN4REpmems4?=
 =?utf-8?B?ZU5aN2NvTEY1ZWhEby9hU212UGJOY2h6ZE5UK01kZ05ZWE10Um1Ibi9CZW54?=
 =?utf-8?B?MUJ0TXcrU0JxazNNQkZscUhKTXN5M2E5NjY5SHZKd1JDd3prUVp4K2VycmVC?=
 =?utf-8?B?T1ZXSUZqWkJabWkySjFadzl6RFdQN0pPa0xjclpLMVVYM2kzc1BabzRpckhT?=
 =?utf-8?B?ZjdJTjdoZStKYlZoN242UmtRWEhCdi9Da1ZISlJSWmpUL0cyNW10VWdFVlNZ?=
 =?utf-8?B?T05uVksxQmpRLzBsWXI2dytpbnBEMTVNWkViREJ5dUdjMmNJVTIzcVZKd01z?=
 =?utf-8?B?OGNqVENuZGZweFFWWmxnbU1MeGY5WDlXVy92bHE4dm5TR1BhdVRVSVI3QXUz?=
 =?utf-8?B?bXRsdzdEdllJVkhuUDZHWStubHVHTkhURGZKRGZ3TFJFbFc2NU0yU0RON3du?=
 =?utf-8?B?bHpOQkZlQVl5Wm8zaEdRTjNWUjFnZFI3WllCMlNsSUFLZUhBdk83bWM3V1Z6?=
 =?utf-8?B?bHNEZzBEblVibDVQZllzYlBpN1Q1by9rMldTZ3pBdXJFNTZiSnRRYkc2bTZN?=
 =?utf-8?B?M1VnTHNZM24zVDVwaTlGVHd5MlRsQ2Z2ZmNKNnd3VjdQa2hzUmhLR1pVZWc0?=
 =?utf-8?B?MElrQ1RXNFFMYXRqeUhkSDA5V0FwQlV2dU9pOUkzWDFwSE5rYTNuRlVZam9s?=
 =?utf-8?B?ZmJtYTZ1MzN3VlVVZjVOVlk3cklOcmdjandQTExLQ3R1TVdNNGd5Um8wZUYz?=
 =?utf-8?B?TFhFOUR4dmVWc2Q3OWduLzVTR3k3YnMxaTdYbjFjWXZFc2J2T21CWVB2T055?=
 =?utf-8?B?V2pObEMvQmlpYVNxV0QvOUppQUh1MDNQNGRxV2pRbHBjSmF0K08vWU1DVTdp?=
 =?utf-8?B?ZkJCQkhHUnNxa2t0dFNpMGhQbW9SZjcrRUwxVmJQVXpBMCtCMWpWSGNnYklH?=
 =?utf-8?B?V0g5bmthZmQrZ1A2SVltZ0FhaDlwbUVCdUJnbTkwelczeDVXS1ZiY1d3Nmw3?=
 =?utf-8?B?ZVdpU2FvekZUelB3MnF1MHBIYXdmT2U3UWFBaWNtdXlHd3E5QUpLeTRQQXEx?=
 =?utf-8?B?WnRoUVhCNjV6TVdYSjVlWDZvRnUxby9ORmg0MHpvaGgwUVl5UkE5V09wMlIr?=
 =?utf-8?B?NStCdEtFajFTUTdQclVMcWdJNnJhc292cjJDcHZ1aFFyQ0ZGSnVUWjBiY2Uv?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2F872B77EEB0C44A22282D7A8FC4F10@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vti1B4hfYURQkSZj3VjsK1R5wR75GtRTS5Zfra7myC3Fbu589An4qRDr8rVbG9OCBAUPXfjOeY7+sUqvI/0CNaNEXudlz+QLTgIhne+HlvC4JyMUBAueNHmXoxngAOjO+9gNnkzjDoH0qcec6MIBaW6eYCTbSZItWM9fhag7YUqDzwlMHwVSd0aY4tAEwmObL24vGzGTpQNIaP61U2fdaLUpOL1L+JEbrk/g3Z2p394neYNq8vusK9yN7U1Yz/9RRoy+V0E/HsXRV/Wd4lTSKB/cM1uTIZPzGAxLdFWubZydLwgdZdKIiKjMUjR1OvmrFWAthZJR343364VQFvY9vRWmKAcRhQki1NqgbjXcCaQZmvWAZZzKspjKp74Yx3uOZAN6dR4jSf+SchrgsLlcwwDwUHkiToVnvaujRhHG/vu12s/tnpyDT0hSjcZGzccRvhAaOsb6bDfZCquGmCixkDj3HgSxwwkpBCTxrpaDoo0jJF9MxktmRhCrTRrFCjiwj8RTgLvE8+Qsb8G5M+R9OX/6rAa5g3g+k7RGJx388+A4S82Q/rG7KG2bfcNBVh1h//FQGgsY60V76QEgnR4ly83XR+LqgUSLNReDrGwV28KPFJloWyexQ/GdQi+YS/Gl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7af8df2-0613-4d7b-b684-08dd36a46d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 03:09:59.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZLJn06SokGrlTG2lpbhBjxFBlF+tpyo/MTyzzzbCYAf/HyCJ8Zzy5o64xQAn/yeONF0zyMfM78pt3nbhoHY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13107

Kw0KDQpPbiAxNy8wMS8yMDI1IDAxOjE5LCBUZWp1biBIZW8gd3JvdGU6DQo+IEhlbGxvLA0KPiAN
Cj4gT24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgMDU6NTA6NTRBTSArMDAwMCwgWmhpamlhbiBMaSAo
RnVqaXRzdSkgd3JvdGU6DQo+IC4uLg0KPj4gTGV0IG1lIHF1b3RlIGEgcGllY2Ugb2YgdGhlIG51
bWEuc3RhdDoNCj4+DQo+PiBJbiBwYWdlczoNCj4+PiAgICAgICAgICAgcGdkZW1vdGVfa2h1Z2Vw
YWdlZA0KPj4+ICAgICAgICAgICAgICAgICBOdW1iZXIgb2YgcGFnZXMgZGVtb3RlZCBieSBraHVn
ZXBhZ2VkLg0KPiANCj4gSWYgdGhpcyBpcyB0aGUgb25seSBlbnRyeSBpbiBwYWdlcywgSSdtIG5v
dCBzdXJlIHRoZSBwcm9wb3NlZCBkb2N1bWVudA0KPiB1cGRhdGUgaXMgdGhlIGJlc3Qgb25lLiAN
Cg0KSSBhc2tlZCB0aGUgQ2hhdEdQVCB3aXRoIHRoZSBjb250ZW50cyBpbiBtZW1vcnkuc3RhdCwg
dGhlIENoYXRHUFQgYW5zd2VyZWQ6DQpJbiBzaG9ydCwgVGhlcmUgYXJlIDI4IGVudHJpZXMgaW4g
Ynl0ZXMgYW5kIDM3IGVudHJpZXMgaW4gcGFnZXMuDQoNCmBgYA0KQmFzZWQgb24gdGhlIGxpc3Qg
cHJvdmlkZWQsIGhlcmUgYXJlIHRoZSBjb3VudHMgZm9yIGVhY2g6DQoNCiMjIyBFbnRyaWVzIGlu
IEJ5dGVzDQoNClRoZXJlIGFyZSAyOCBlbnRyaWVzIGluIGJ5dGVzOg0KDQoxLiBhbm9uDQoyLiBm
aWxlDQozLiBrZXJuZWwNCjQuIGtlcm5lbF9zdGFjaw0KNS4gcGFnZXRhYmxlcw0KNi4gc2VjX3Bh
Z2V0YWJsZXMNCjcuIHBlcmNwdQ0KOC4gc29jaw0KOS4gdm1hbGxvYw0KMTAuIHNobWVtDQoxMS4g
enN3YXANCjEyLiB6c3dhcHBlZA0KMTMuIGZpbGVfbWFwcGVkDQoxNC4gZmlsZV9kaXJ0eQ0KMTUu
IGZpbGVfd3JpdGViYWNrDQoxNi4gc3dhcGNhY2hlZA0KMTcuIGFub25fdGhwDQoxOC4gZmlsZV90
aHANCjE5LiBzaG1lbV90aHANCjIwLiBpbmFjdGl2ZV9hbm9uDQoyMS4gYWN0aXZlX2Fub24NCjIy
LiBpbmFjdGl2ZV9maWxlDQoyMy4gYWN0aXZlX2ZpbGUNCjI0LiB1bmV2aWN0YWJsZQ0KMjUuIHNs
YWJfcmVjbGFpbWFibGUNCjI2LiBzbGFiX3VucmVjbGFpbWFibGUNCjI3LiBzbGFiDQoyOC4gaHVn
ZXRsYg0KDQojIyMgRW50cmllcyBpbiBQYWdlcw0KDQpUaGVyZSBhcmUgMzcgZW50cmllcyBpbiBw
YWdlczoNCg0KMS4gd29ya2luZ3NldF9yZWZhdWx0X2Fub24NCjIuIHdvcmtpbmdzZXRfcmVmYXVs
dF9maWxlDQozLiB3b3JraW5nc2V0X2FjdGl2YXRlX2Fub24NCjQuIHdvcmtpbmdzZXRfYWN0aXZh
dGVfZmlsZQ0KNS4gd29ya2luZ3NldF9yZXN0b3JlX2Fub24NCjYuIHdvcmtpbmdzZXRfcmVzdG9y
ZV9maWxlDQo3LiB3b3JraW5nc2V0X25vZGVyZWNsYWltDQo4LiBwZ3NjYW4NCjkuIHBnc3RlYWwN
CjEwLiBwZ3NjYW5fa3N3YXBkDQoxMS4gcGdzY2FuX2RpcmVjdA0KMTIuIHBnc2Nhbl9raHVnZXBh
Z2VkDQoxMy4gcGdzdGVhbF9rc3dhcGQNCjE0LiBwZ3N0ZWFsX2RpcmVjdA0KMTUuIHBnc3RlYWxf
a2h1Z2VwYWdlZA0KMTYuIHBnZmF1bHQNCjE3LiBwZ21hamZhdWx0DQoxOC4gcGdyZWZpbGwNCjE5
LiBwZ2FjdGl2YXRlDQoyMC4gcGdkZWFjdGl2YXRlDQoyMS4gcGdsYXp5ZnJlZQ0KMjIuIHBnbGF6
eWZyZWVkDQoyMy4gc3dwaW5femVybw0KMjQuIHN3cG91dF96ZXJvDQoyNS4genN3cGluDQoyNi4g
enN3cG91dA0KMjcuIHpzd3B3Yg0KMjguIHRocF9mYXVsdF9hbGxvYw0KMjkuIHRocF9jb2xsYXBz
ZV9hbGxvYw0KMzAuIHRocF9zd3BvdXQNCjMxLiB0aHBfc3dwb3V0X2ZhbGxiYWNrDQozMi4gbnVt
YV9wYWdlc19taWdyYXRlZA0KMzMuIG51bWFfcHRlX3VwZGF0ZXMNCjM0LiBudW1hX2hpbnRfZmF1
bHRzDQozNS4gcGdkZW1vdGVfa3N3YXBkDQozNi4gcGdkZW1vdGVfZGlyZWN0DQozNy4gcGdkZW1v
dGVfa2h1Z2VwYWdlZA0KDQpgYGANCg0KDQpUaGUgYWJvdmUgY2FuIGhhdmUgYW4gZWFzeSBhbHRl
cm5hdGl2ZSBkZXNjcmlwdGlvbg0KPiAidGhlIG51bWJlciBvZiB0aW1lcyBraHVnZXBhZ2VkIGRl
bW90ZWQgYSBodWdlIHBhZ2UiIC0gaWUuIGluZGljYXRlIHRoYXQgaXQNCj4gaXMgYW4gZXZlbnQg
Y291bnRlciBpbnN0ZWFkLCB3aGljaCBpcyBhIHBsYXVzaWJsZSBhbmQgbGlrZWx5IG1vcmUgaW50
dWl0aXZlDQo+IGRlZmluaXRpb24gYW55d2F5IGdpdmVuIHRoYXQgYSAiaHVnZSBwYWdlIiBjYW4g
cGxhdXNpYmx5IGJlIG9mIGRpZmZlcmVudA0KPiBzaXplcy4gV2l0aCB0aGUga2V5IG5hbWUgYW5k
IG1hdGNoaW5nIGRlc2NyaXB0aW9uLCBJJ20gbm90IHN1cmUgaXQncw0KPiB2aW9sYXRpbmcgdGhl
IHJ1bGUgdGhhdCBhbGwgKnNpemVzKiBhcmUgZXhwcmVzc2VkIGluIGJ5dGVzLg0KPiANCj4gVGhh
bmtzLg0KPiA=

