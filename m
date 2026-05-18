Return-Path: <cgroups+bounces-16037-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN8WHNYwC2plEQUAu9opvQ
	(envelope-from <cgroups+bounces-16037-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 17:31:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1157001E
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACBE8305616F
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438163D3321;
	Mon, 18 May 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b="iG+SFEkM"
X-Original-To: cgroups@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023109.outbound.protection.outlook.com [40.107.162.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97837C904;
	Mon, 18 May 2026 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118055; cv=fail; b=pk73l9kynHR64EZ1KGXOXeie0Mwpx9OsN3A8e+j9DtuEqE+XT6/f3Gc1kToQzlCwNuIpq2oG1q1dB3As6q9MUBV40AHhFKc6qI25p2cDvFY5rnbUDK8V8wM4mKFIA6hgxcXwZfyYBoBcvnA6zrg4Pnzdkp6K3GEdM55H4OH+/jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118055; c=relaxed/simple;
	bh=GCzWgSJ1ezCVfMw4/UMiGmrW23iVsdD/2YxlUECtTF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lSVDG1iowp3obRnlJlnKAy/ejKf66fyW/NS6o+CGSIpQYTkbcZSNNGm92YZxaOy7zdiD2t+v1qs86vpw7x2pUtEXfqCuCjosjUF41Qm8+mpXlZ5dUP0HvzR+mm4AmRca1DNDfA+ka1sfFhnFMOf9e3mZZgDmNzwIg7YvSId90+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it; spf=pass smtp.mailfrom=santannapisa.it; dkim=pass (1024-bit key) header.d=santannapisa.it header.i=@santannapisa.it header.b=iG+SFEkM; arc=fail smtp.client-ip=40.107.162.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=santannapisa.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=santannapisa.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR5GLqnxa1Sx1MG5YbRgO7xeolBCiRwa7Jbeynm9sCc/x+ziNtGW0DpvB7JB1dgWhSDIMe7306tp1UouuHOw9BgMo9CmZwc9zejozoHbYIXDFouYmd5BGIpVqBYXtr566nb/IJaq+nIlUqBovjiG1U9Oj1Nirqt/G+Rn+6IQhj8CLf0tVMMJR4/WvvAm3ZJiUV52zpcY+FT+L5C5A/oBM6E7Vl0TuheAwqLcZhROPPujaCbzWHvwswSZ17LX6bpQ51iW3cj4k83LqTwnRscJp7MtsCsZdljkOWL3+m4hfo53lhEHFbc19zc0aZBL2HVotveqbSTnTISyMtZZL8xQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECoRcQ6NWi5wNAbERkK43HjMXz8BgQkHP/SHBtL7hcs=;
 b=smPc7jFmzl5aPNZHC4OZPedjdMpsUVRLUwTDg9MPfX1i7D5Wrjkygyj/cFS2xkmogFCUmFBwhInIrwnrR/p5A7wZeBw/h4W0+M3nt/QEwg5a6yYMk4Xs8ObvOvBlSwSSAgzAtCdEJ2hS9cVvlK9tQcHF81iELW0h4AS2rWVUcTeY/Xqvqq0bVug2VdfMgSaGtvLymFHQLQ1oG9V/puW7nxN7HdDDsBL9U3UmpIrT1V07nDNXJenWG4/5on5tvr2wOHgurr3UrVtiteE/5XN/hwpxXYSWeE/AuECzDiNF+TAemEIs1PDyvz2jvMo+0oq/48Ri81QzO6frPtdDdUks6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECoRcQ6NWi5wNAbERkK43HjMXz8BgQkHP/SHBtL7hcs=;
 b=iG+SFEkMzRJcbTm17vH90+fz35p0m/XeI/6js0BwAkTVSzlXxCmijmt2QNKuAzOaHcztPVBSpG3cfUoKdhmz/yFTJdUy+xTqLbqtgywXrydZ8YIufrDvqg6/PL8Goq18W+iKl0G13d07B5fu8qrlmct5/0ihL382u4VvrUpdV4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com (2603:10a6:10:52b::6)
 by AS8PR03MB9510.eurprd03.prod.outlook.com (2603:10a6:20b:5a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:27:21 +0000
Received: from DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9]) by DBBPR03MB10258.eurprd03.prod.outlook.com
 ([fe80::b7a6:58ae:c374:12d9%2]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 15:27:21 +0000
Message-ID: <c51eb4b9-143d-495f-a35b-090fb688cca4@santannapisa.it>
Date: Mon, 18 May 2026 17:27:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
To: Tejun Heo <tj@kernel.org>
Cc: luca abeni <luca.abeni@santannapisa.it>,
 Peter Zijlstra <peterz@infradead.org>, Yuri Andriaccio
 <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org> <20260507163058.2c435922@nowhere>
 <agIfvZuvXEtK45em@slm.duckdns.org>
 <c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
 <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
 <20260514092546.4265d486@luca64>
 <8672eb9e7bbd6abde7762feb267799c5@kernel.org>
Content-Language: en-US
From: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
In-Reply-To: <8672eb9e7bbd6abde7762feb267799c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DBBPR03MB10258.eurprd03.prod.outlook.com (2603:10a6:10:52b::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB10258:EE_|AS8PR03MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd3686b-d97f-4011-a9a2-08deb4f1f467
X-LD-Processed: d97360e3-138d-4b5f-956f-a646c364a01e,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|7416014|376014|1800799024|56012099003|18002099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	1FqnAKPWXFJDWBypMjePlwl2RD9bNV5YFycU+aGG7Z2HqPnU/RWXCVcxQWrv/c592n4W4Uwz0v9TEhPySzSDtuJtt/A8klEItKa2I5ItUi4HgqaXx5ytiv+zhJYAlXeriHJX73Zzx2/Gree7yZQS2wM475CAnhvV7aSTjAqwMps10Ri44CCgp42dDI7K1tyt+TxVJugi9oklfrO1UgDezHdyHHIb7wxne8irD9yJSYTiUFA4ZxH6FfgPeFLc78mfWZ5WYNDCXkeX/S2GjnUAO8OJ440YwFFVDBNKL/CNkCxZyoj+n4Fdm3C3drFhpgx6l3mcp9XwtRaXMy1bx5ylr74XNgfJm+NKl/v0SSXbzzTi9rYpAol1pMvl3E/CT2Knk94ofqm4KDJsj4d5qOh+qpA0B12NIlq4vXTwz8ObmyrXZqaq64t744nSiK/T8mnyQcohWOr0AA/roGEWI1hR3MiWrzVf2LVu5JIAHvq4MMIgNnnduuULB3Dnh+0SszDhhxMU4U89703C3FyJ7k6IlPZf2t+V2Mn/zacGbrdLrGdBrJQKqmDO33J6G7Wj5DTBEr9Kc4M9ekVqSRX3TiB6Ouf8HvdtFoB+ZX9XLdF3ep7E38ChJFJJgseUG2/TvA/h6qh2gztjZnIlrmJgwGQHR8o3+ydroVXpYMRi1192g/fpMOylToBgRqa/f+d4kdNu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR03MB10258.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS84OEw5cGxCWGIvU1F4MXhla2NMV2ZCTXphVHRtSnRsZnRSS3dPd3k1bFFy?=
 =?utf-8?B?Q05yRUlUYVBMVWQ3WHVoZkZNa3RKU0toekVYbHBlRGpFcDJ3QmF1TnNNWnhi?=
 =?utf-8?B?NW54ckFzSlNmTXlyVXVNMWVGTlJOR3U3aUlMc3BTWldpTnIraWJxWGVUZXVS?=
 =?utf-8?B?bkYxSFQ4a2RFdnM5Z2srTnJmelJQVG9YTkxYYnhPbzlDNXg4NG13eUtjVUh1?=
 =?utf-8?B?SDVXQTE0U1huMW9wUWpFSDVtbzVhckJhYVgzdFdpK3Urd2Y0MjJBT1hjaVRG?=
 =?utf-8?B?ZFdWeTUzZW8yRE5pRTErZHpjb3VUOWN6QXl3Mms0bEpmbndXaEZIZXBLTTRQ?=
 =?utf-8?B?aXpnbmRCK0tYK095V0R1UE1VVFFRd3Ura3Vad2NyTUR0OENnYlowVWpUeEYx?=
 =?utf-8?B?bXRuRCtmNFhMMWxLblBmK0NMSG1IeGJObGplY09idVFCdHZBRUluUDR1NkNv?=
 =?utf-8?B?SkFuK1lRL1l2cUR1MXdyVUNsZnVoOTVXWGJ0M3FPMkY2RWUvU0pQaGtoS3B4?=
 =?utf-8?B?YktvQXlsMzIzSU8vTFo4OVdPV3BjRWZ6SWoxdVZhMmhBbTU1MDBSMlMwTzY3?=
 =?utf-8?B?YmhHOU9leE1RaFl5aW1ubFgwQnVVTUxYYXJ4d29najZBb1FnV2pUdkxSdXFH?=
 =?utf-8?B?dEhjc2owU3hZTzZDUzBFWGdrbFFRUERuQ3NIOEtrODVUTml1ZVBaQ1BTb0dn?=
 =?utf-8?B?S0tQZ1FKbldYRzdwSWRzV1FDUHh4MVU0ZGFva0xIVmtYSUdkU1VqWGEweG9w?=
 =?utf-8?B?UzduUXdyY3pTaWw1a2tjcy9qWTNIdVl4R1hoQ21VS2RhcHh4Z09VbmZoMjFW?=
 =?utf-8?B?dVY0OXYrQ05pblBZZVcwajV4aVdUc1Z5ZitrTEdlT3FrcDRkcGZQTk93SlZB?=
 =?utf-8?B?MnRjbEtGdDdVa25pS0FCTnlmVHhwUlFCTkhRM0dHZVU2ckhkbGhBV0luNG90?=
 =?utf-8?B?bldnY2p4c0Y1Q2tCVGlEOWowbWVySldNaEVPSlh3MkxjUFJsNUFmZ2xMbTBZ?=
 =?utf-8?B?Ri8xek5nVGJ3SHpKOFhtcW1kcFN5OWVBSDROUkJHb0dtWlBaZVdNWUZzVVMw?=
 =?utf-8?B?ZmcwcmZzcEpoWHBtaEdHUEJQYWR6WGN4R1hwWGQ5bnFYZkU1QnlBRG9XQXBU?=
 =?utf-8?B?RW43V1c1bzJlN0E5RzlvZGJ4Uk9FUUx4WDY2bFY5SUgveGhQR0xTSTBFWHZi?=
 =?utf-8?B?UmhTeW9YeXFpNjJXbkhyRGd2bWl5L25MSDFIaDd4NTdNN2lqZHZtdm1iMEdk?=
 =?utf-8?B?cm16L3dMQWxpTUQ4Ulh2VFNJYTBZdVlPVUxkRlRVbTNRS1Rob1F0czVGSllW?=
 =?utf-8?B?Z01kcm9Bd043b0pyYlRVeXc5RGZaYmdseGpkQUFjRlM5Ri9vWTB5Sitkd2kx?=
 =?utf-8?B?bVJNRUVySk9Idko4ZGNWRENyVVl0aG1ES0sxRFlkMGcwaGFzcWdIYXFiem5B?=
 =?utf-8?B?UU9DcWw1dHluRkNsb2duNzdzMi8xR3Z5cWRKaTJzdXJpa2VDeWgyNE5POHBi?=
 =?utf-8?B?emh1UHhCUGpYZ09OQytaQlNQMzJSaFNYUGhwZDlNSXUxdkFHamVLVlBkSFpu?=
 =?utf-8?B?VE84bFZRVGlLTEpiSVpYdzNLRnFGc1VzNlI4RzZ6WUhqZzFlWlhuTjlMQnlX?=
 =?utf-8?B?SDBNcVo2S29YVmdrQjgzOG9OaEdERWtLWVZJaWpLREhxb1FtMDkyNDJpb1Rm?=
 =?utf-8?B?ZDVhK2VZSGUvZXZYRGdzRXpRNzY0V3daTHliMzN1Q2xIcUduNlFMaUVHQVIz?=
 =?utf-8?B?dHhYVXIwVWVRalIrVzJKMUdoZW5iL0dyajlHTktROVYzUzFBaUV0dS9STTJq?=
 =?utf-8?B?OFJZOEtid1R0T0N3OUwvbEc3dXdQSG10SkFqR2JtbkkzckpUVUpyNW1aS3Fa?=
 =?utf-8?B?M2hxTmZGNGg3Q2pqYUZyQjVYZlRndXRVbHpnOUQ3NDJLMW5Ua2NYVW1qZHVF?=
 =?utf-8?B?dEpOZGwxSGN1SmordGI2UnVDTkswNW1Ya2Fzb3Q0NnYzdXBFQWRaVFZBNDZD?=
 =?utf-8?B?UzFFOXlxaEhDOUpLTVREZmtCNytWOWZBclhKZGhaTnkwRDcwRnk1bWFZdnpx?=
 =?utf-8?B?S1pwSXM0MlVReWNORGJXZ20zZldJUGxlenhIRWVHWVBPZldiT25uTFdhbEI2?=
 =?utf-8?B?b0VGa20vQXJyRnhneW55d3Q2VWZWRllXSTdEbzllcGEwamQ1OXZCR01LZG5t?=
 =?utf-8?B?MU95dTUwQXBBNEo1VTFpRURaWnlQdXZEamJFWHVjd0pvYU0vVWZ5Z3NwRmJr?=
 =?utf-8?B?L0JveWpMbkNBQjBYRjRYdDJHQ1YxdktMQ0ozOVdNdlhSRXAwMEFrRVJ3cXNr?=
 =?utf-8?B?bm9jc1RJY21MYzNVREN6S0I1VDM0ZFpCYXo5WVZGV3Frb3FMTWpPeTJuQ0VE?=
 =?utf-8?Q?rW0ZFSx8PJVdvpvA=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd3686b-d97f-4011-a9a2-08deb4f1f467
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB10258.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:27:21.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFiLiuo/pJ+qP1IQ89iXXkd1P7EO3F3BVq71AYPIy2KitF/swHm6B3kXZJOsSXpI2pmNzhof4l5KQur5hsEeDOnxO6rI49wgPvw/RRFJPFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9510
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[santannapisa.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[santannapisa.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16037-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuri.andriaccio@santannapisa.it,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[santannapisa.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 02B1157001E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tejun,

me and Luca were discussing further the interface for HCBS and agreed 
that from the whole discussion we seem to be converging to something 
stable. To clarify things, I'm writing a recap here and I'll also add 
some visual examples to make sure every "corner case" we might encounter 
can be managed.

Interface:
- File: cpu.rt.max
- Format: <runtime>|"max" <period>
- Default value:
     "max" <parent period> - if the parent schedules on the root runqueue.
     0 <parent period> - if the parent is instead using HCBS.
- Meaning (incomplete/dubious):
     The bandwidth allocated to the specific cgroup and all of its children.
     Since sum(children bw) <= own bw, a cgroup's servers will be configured
     with (own bw - sum(children bw)) bandwidth.
     A cgroup set to "max" whose parents are all set to "max" (root 
cgroup excluded)
     will run their tasks in the root runqueue.
     A cgroup set to "max" whose parent has a non-zero reservation will
     inherit the parent's configuration.
     The root cgroup's cpu.rt.max file reserves the maximum HCBS 
bandwidth for
     the whole hierarchy. Root set to "max" disable HCBS (as if set with 
a zero runtime).


Corner Cases with Examples:
                 Root (70 100)
                       |
                   G2(50 100)
                 /     |      \
    G3("max" 100)  G4(20 100)  ---G6---
                       |
                    ---G5---

In this example, only the root cgroup may run tasks in the root 
runqueue, groups G2, G3 and G4 use HCBS instead. G5 and G6 are freshly 
allocated.
- Is this a valid configuration?
- What bandwidth does G3 take?
     - Do tasks in G3 share the same runqueue of G2?
- Are the defaults mentioned above suitable?
   Otherwise, what default settings do G5 and G6 take?

           Root (70 100)
          /             \
     G0 ("max" 0)    G2(50 100)
        /           /          \
G1 ("max" 0)  G3(10 100)   G4(20 100)

Groups Root, G0 and G1 may run tasks in the root runqueue, groups G2, G3 
and G4 use HCBS instead.
- Is this a valid configuration?
- Is it possible to set G0 to (20 100)?
- Is it possible to set G2 to ("max" 0)?


            Root (70 100)
                 |
            G0 ("max" 0)
          /             \
     G1 ("max" 0)    G2(50 100)
                    /          \
               G3(10 100)   G4(20 100)

Groups Root, G0 and G1 may run tasks in the root runqueue, groups G2, G3 
and G4 use HCBS instead.
- Is this a valid configuration?
- Is it possible to set G1 to (20 100)?
- What happens when we set G2 to "max"?
     - Shall this be disallowed, as G2's children have a reservation?
     - Are they silently reverted to "max"?
     - Or G3 and G4 are kept with their reservations?
- What happens when we set G0 to (70 100)?
     - If allowed, what if we set G0 to (40 100)?


I think here we have most of the corner cases that are still of doubt 
for us for the final implementation.

Thanks in advance,
Yuri

