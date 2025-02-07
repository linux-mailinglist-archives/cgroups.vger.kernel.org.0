Return-Path: <cgroups+bounces-6454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D1A2C083
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 11:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D5716ACEB
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754881B3940;
	Fri,  7 Feb 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ciT6ZYCW"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3DC80BFF
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923830; cv=fail; b=bAUA37M8Gr2UIElRAKqkVvqaRAmTydr2NA6T9iO7lsxlcWiE1OOPxx1oV3XA29MA0BXv3GM+++EIfkKYK2I/u97fXVCOlYs7RQoBZsiqG9aP8OLvfSzGXSadG+uJ8BnixmVQSHr8ViFP6FdEZA5hIXU4pGvTsmbr2vBq6t15qx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923830; c=relaxed/simple;
	bh=vqt1pYug/DZzxn2Qk5skhu5LSg0CYvZn8sDSBHG9V/Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nxpqseCixcA5D7avr/oCuq6LHM/SrC0459x8XFefD4vQ1gUpd/mbqC1kxx5nTuXS2pGnuB1kDm7HHBKPE5g/3RjZ5d/GRZrMcY3gc4jcmUvRmkctMSeYgxweOs0tDhzGFTD6xutW0ydYyoCYl7f35kWiiY3j98lppaQ6Rwu3pfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ciT6ZYCW; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5170QKIF010440;
	Fri, 7 Feb 2025 10:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=vqt1pYug/DZzxn2Qk5skhu5LSg0C
	YvZn8sDSBHG9V/Y=; b=ciT6ZYCWUFO8eN6lABsJSGDKoJiQhW+lYB+ZsoS12iZc
	pKLEKSChSeAdJMxbbkDdxpWeJHljIjkiPUUUs0pSt/U4UHYifNQIdNwTFFOd1te2
	YJlkl/mgpOO2lWnVKzLuvj9SlegfTX0PcoOzlZkx2oK8MDdkm1FICE7dkPzMnAjQ
	allWOsdqY5lELHXm6P6jspCaYHenCk6EnYrb6CeoSEeGv18cDlgrpyv+YfwD//03
	cdNRTw92yc9XfnteHLFzMNkMFNHE8dulGLCiTBxjA96c9iMNQbzi6l/11IZiHbyS
	5CuVHCyATpIODqcH3OzWhtndrR/smj1xnN5G9HOdpg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mywtvr1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 10:23:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrgTe/zQMGyRLU7Z4n4vEb9yzIgNhe2xUzYhesz7ZrmQPKexvfMg41mfBztIQoJ2aeQJyEfhiV4VMJOngIfk/ogkJm5vKqbrVZaw+LF25gFD+h6kpnAA5PIapV+lknUA7o/Zc0aqQchGjnsh3DbGmNb9ldEXgIcBoXWtrdZQ71IrSdgmYWpMc2U6OS1OqETpNCAIhsvTvDrH4UP8NU/xb2nucSrhh3unTkrYZO85GUex9TdU/QDHD8XgQXqRb+LV6n1HMptbRb3/IvMfz/zWUx9Fspxt99+q0AlWw2ni9kUN+rm7IUl6SFkqVyicDxu9I1JsaKI8PbXeUPFPS0Vq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqt1pYug/DZzxn2Qk5skhu5LSg0CYvZn8sDSBHG9V/Y=;
 b=N1ovU+WfnNOrTZ0cuxQ+t8p58GlheOUEJYJXUlZkt0qLo5h3WN1C4yWK+CFEhEx95DzCFrImXj0DanF2n3sAY8ByOf02tAVuggZzY71E9WUV3KPBoAKVYmsBnyco6u6u9U4X6vtcoUVDGywCzE56bkPb16Dz6lH8zQbpDy+DzeOlxAicPGPCnSt4UbIpSnom7mDzWfrHU7+98LjCYvrpOGpK6t9KbsgD/tIBUmAE+j22lavs435PywnFb4FwuicdrRynM5tZEX8XqJ46zENeKf52Kcp5u8m2x+UCqCwUfCS0OFi7ikxY7jdD7PNgVsHYeTLI+Qne27BDhJJFaIOqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from CH3PR15MB6047.namprd15.prod.outlook.com (2603:10b6:610:162::5)
 by SJ0PR15MB4710.namprd15.prod.outlook.com (2603:10b6:a03:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 10:23:42 +0000
Received: from CH3PR15MB6047.namprd15.prod.outlook.com
 ([fe80::5f69:515f:3a6:4f06]) by CH3PR15MB6047.namprd15.prod.outlook.com
 ([fe80::5f69:515f:3a6:4f06%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 10:23:41 +0000
From: Muhammad Adeel <Muhammad.Adeel@ibm.com>
To: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
CC: "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        Axel Busch
	<Axel.Busch@ibm.com>
Subject: Remove steal time from usage_usec
Thread-Topic: Remove steal time from usage_usec
Thread-Index: Adt5SlqCaMaEauuyQhSxLrDnYXxdgQ==
Date: Fri, 7 Feb 2025 10:23:41 +0000
Message-ID:
 <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR15MB6047:EE_|SJ0PR15MB4710:EE_
x-ms-office365-filtering-correlation-id: 15da88f3-b6e5-477b-4226-08dd47617e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zng5V2Yrd0VLNEl1eTdVNjNNKzU5KzBVN1kvUVJOR21RUGo2ZUZuY0JCaEY5?=
 =?utf-8?B?Z0RDQ3RSUER2MEdXa29GZmNSMnBGYnR2NTBySGhkbHZuTlJiMFNZb2QrTGNB?=
 =?utf-8?B?VVJrblc2dm03akZ2Sm1nZUZRMWpueTBkZWRheUs1REcvMHM0T0pNOXFtRUU2?=
 =?utf-8?B?dmVSMlFFL1NyamtqejFkdDh2SFZnUW8rVVNaSy9nWUhBMzUycUxZNVc2d0M1?=
 =?utf-8?B?WTlhWFFrcVNwOG5kRUxWMTg2dzFpMzVhcjNtaUZGa29XamJIaGV5UGE5NzEw?=
 =?utf-8?B?dUgxeXQ0UGl2dkFKMndKOGRRMzFEYkdkTzVnVUExWm5GYUZyL1JXZitDODVO?=
 =?utf-8?B?aHdlL1M2aW5kVmNOdDBJc3VERTVhTjRLRVpkc3c4TitCR05TWFFPc29KaHRh?=
 =?utf-8?B?V3doMVZFOXo5MHR3ejdnUXNMSW5pK3UwdkJuWktCUmZ4YlVnWnV6Mm55ZVlF?=
 =?utf-8?B?Z2MrNlJRRDliTzlCQUtZK2IrY1RHaTJkZzUyZW81SlZnU29nSlU3MnB0Smpw?=
 =?utf-8?B?RklzWjErYnBPR2g0eHNocjlmM1Z1RTV3clJDSFFCU1VRU3Z4cFBweUNuSlVa?=
 =?utf-8?B?NUxjdTB0QzZFVTNZYWptN3ZDcUNydytjNCtQYWVFM0Q4OWFHOXlrdVBVS3pR?=
 =?utf-8?B?Um56RWdVblp4azF5ZXdndTZta2l1aytuZlBUb1djM1hGQnFIUkxiNXFSODZN?=
 =?utf-8?B?eWFvLzczWEdIYW5ON0Y3ajlUemlaTzZKekZycWVOcHFIMit6UjlqS2VhL2tU?=
 =?utf-8?B?M2h6MnpwVWlxSnFyR2ozWkNiclNmdDlsU0dsYU9BRG1JWVZwRnFndjhhS2xR?=
 =?utf-8?B?VEpkMkkrNXZjRHAyRzFUU29JV3hvWElsYUtGK3MrS2EyOHAzWGdISmFEaEY0?=
 =?utf-8?B?c2J6T3VYVDJnY2RDci9zenJhcEJ3NURLakhESHRuQ0V3QXBUR2l4OCtIWVU2?=
 =?utf-8?B?emlwODVXcWxBM2wwb1g5SUlWUlUyc1hhamg1SWYxQVVvVTJNYlN5M28rSEJV?=
 =?utf-8?B?anNzenh2ajdBbUtpV3RReWdWaXRIVVkrelppMENHaFZiRmlrNlNnK1V6NGFJ?=
 =?utf-8?B?NTYxMkZseGpQVE5tNDduNllpVG5WK0FPR2ZBUm1HQVFVZWlWc1VGWFVGcUZ5?=
 =?utf-8?B?bDYxcXhib1RhbVJJQ3o0ajl5OTExWFpETmFvcm1iaDYvTTNqeE5kNldXUWhZ?=
 =?utf-8?B?L212U0Z2ZDdxWHVzNUZHNXlKci9xRTRjZHVtbjVFZlJMS25hSzBuSDl4ZFI0?=
 =?utf-8?B?blRJMHFlY0R0ejFROVlIOE53eXU5SmkycWtYNlJZTkVDL3NkWlBtQmJJWkRp?=
 =?utf-8?B?RWNqSWNreCtFS2ZVTzF0NmZZdFkvclYzV3crVEllMXlOZFp2eEpKWmd6TVhJ?=
 =?utf-8?B?N1J5aWFja0VzRGRITlJ1Qlc1Q0JoWEZ0a3NWYTkwcGxOT25JL0tLd1l0V21O?=
 =?utf-8?B?b2VYMThySVBsN2hObEVaVFR5NGJ2eUR1RXJURisxVUhoZmZNQXlUenkyU2pp?=
 =?utf-8?B?SVo5SGhnWk1hY3NXYzBoNy9tdmp4Q3QrTkNaclZCUnl1MFU1S0lGMmpjd2pH?=
 =?utf-8?B?S1RyY1NZcHV1c0szVFp6VVZab3RoYkEvWkVGUDRKL1NuNnRER2ZUZkJ5b3RD?=
 =?utf-8?B?dU1aUG9YdlhOSUZDbTdIN3p0YVFXZmFaT2VBRm9WdWJLT1QyRTc4SkVEU0hq?=
 =?utf-8?B?aFdzc1c5dE1aVTNwNXp1alFkSEVTQVB3OGtmOEo0dVE0enlpVE1lRUVDUHRH?=
 =?utf-8?B?TnhzUHVoZEhBK01pRjJiTm1OWi9ZbDRNN29EWldKL1pyLzBnTDJZbXlMTVdh?=
 =?utf-8?B?VE13bXlFWUl0b2pweU1Oc3M0ODR2bkU4RUtoMWZUekxIb1RlZm13MGc1bUVo?=
 =?utf-8?B?UDhzdG9kdVlvajFMeStPejJWMWF2aUNINDNKS1JnQUJmSWpiaE9Rb1ZCMmVN?=
 =?utf-8?Q?vYspFcBAb/jsmbxnyFhG58r+EQ1Wmx4u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR15MB6047.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmY5UGN3R0tIRFhKd0FsTHZwUnNzVWFTb1lTSnpVckZnZHA2SWpuY3Q5UlNU?=
 =?utf-8?B?NHA2Y0E3ZHQyRzNSTWRRcHB3VGVXZFNoOTBPWWFjQmdabHpucVAzdHVMeXBh?=
 =?utf-8?B?TVh5Tm8vMUNBYTd2SWtjVVdLa1ZUUFZDcU0zSVlwTXFGY3ZBbW82aVZMYUdz?=
 =?utf-8?B?dXhjRmVjaWhSVXk3Q1k2c1ZPT2l5VEFYVW9iWldHbXNpRnhtRytaZURDRUF5?=
 =?utf-8?B?dUlIaDBqNkt1bTBURktqaHNCNWdVSEJCTWd5SysxNDlXZVkxRkREcStDN2JW?=
 =?utf-8?B?RUxrMkdqeXZQY1ZSdmtEbDN6VmIzM0ErU2tXVW9LbGpudjcvL1RRSkNZS2Ju?=
 =?utf-8?B?a3ZidXZYUGRjQ21HaXgrcDhvTEN0MUNYMGZzM2xPNXpvQ2E2dnhtYUY5YVJU?=
 =?utf-8?B?L3FEUU0wRWo0TFR2N0VRQzdCL216T2tWM3BTd1lCUTRQVlNCMkhHWHNrUUN1?=
 =?utf-8?B?TlY4UEd6SGpDcm96MkFCUmdrM3B6VitsdUllVzk2dzgvSzNCa2hwSkwveGd0?=
 =?utf-8?B?Znkrbm52elNGRnpjSDZ3eEsxM1VsN2hyNjR4QXp0NU5HUHVRWjk5NWltdkZm?=
 =?utf-8?B?eXJpMnQ5Zis2M0xxSU11aUpWRzdXd2tKek1XdmVqS2NWa0RGZzFrOHNBMzNV?=
 =?utf-8?B?bXZmaTI4SFdjall4Y3Y1M1RUekYwZ0doNklWTmpja3Y4K2J0YlZ2SlZ4endp?=
 =?utf-8?B?U0swKzBrdFBaU0lFMWJLY2Y4TUozSFF6RTdqU09jU3F2Y1RxNDExeXZFWUly?=
 =?utf-8?B?WWt4UGxVMnVnQzFteHNGeWo1WVBqNmNxSWFBS0x6NzRIbFM0UXI5WWRwSTlX?=
 =?utf-8?B?UG9LMU5kV3VtaFkrSjZZQWZzN25JNnEwU2ZyQ0NUK2dHNTVMcGxWV3hYUDdO?=
 =?utf-8?B?YmxzcjBTSk1HMGViQXpoVHllWm1jT2NPdkVYSzBsbjJGVThWMGNFMXVDQ0Y4?=
 =?utf-8?B?R25yZkEvREUreXlKTUV5RVpHLy80S1RmK3dhNWRDbkhsTnZiYUNUbzUrZExK?=
 =?utf-8?B?MU5PRTFyMWl0d0pOREVrTTZXQXM5bWM5aXRBS0hSbDE1VWo4Z3dmZmZoUTBr?=
 =?utf-8?B?TkpyK1ZoMUIvY21najZVUTlyZkVQek9TQW1hVkdBcjRGM0ZuMlVwRGtoM0wv?=
 =?utf-8?B?WFhGNDlFandZalN3UjR3YmgyWENzYnpsWnZ3VEtVeUpRMGY4RHdGRGFvVjdZ?=
 =?utf-8?B?YnpnZCtQNEdQWHB1dVhHOFBOeFVtQ3kwMThOV2tiMFVqUFNkQ3JDZG1VRUVl?=
 =?utf-8?B?UVpOdExiSEVkVlZpZExwSmh1Q0toNjB6TmZRVEtvOUphdHhJUVdxQUg5UDEy?=
 =?utf-8?B?UFJmNFo0YnMwVC9Oa2k3ZlZmT0dDZGtsRjZWdG1GajM5NGc3QkZmMTJrZG5u?=
 =?utf-8?B?bzlXait2L2JLUVBzQnkwc3VQSTN4aDhvUTUreHgwRS9CTzhpS2tNRXhxMG15?=
 =?utf-8?B?bTlUUEI5OXJKT3dPTTJ6Q1FYa1hzUXU0OE5XODdFWWxmVVhMcTk3NUFMc3pP?=
 =?utf-8?B?cFdkQXZBdllNaWpxU3g1S25iakxUWnl2d1h6U2c5L2JjUUpIOUdZS1MwSm5W?=
 =?utf-8?B?RFIvRlNGNGNMQ2tRMTJhZ1BHeDRKSGl6alBPU2YzT0N0bHZ0SHZIR2Y1QkpS?=
 =?utf-8?B?Vzl5aTVvS0VpckpmbzliMXpEV2QzVXBZc0ZHTy9pazVEbWhsYVFtbkx3eWsw?=
 =?utf-8?B?TTBEblpNQUFXWHNBZWR1QTRrQTlyZ3ZDbzdpMU9icjNiZWtvSW45SEs1Ym1S?=
 =?utf-8?B?anNXZitxZWZBNHphc3l3RmxBUkw1M0ZibVczamdVNlk2T2xvVFBLTE5CSzJp?=
 =?utf-8?B?MXBhVjgxaG1BeHREdG5sMFFMMWVwM1I4ZFNqVXhTLzB2SEo4a0QvSVhvdWtL?=
 =?utf-8?B?b3hHcXdrdUxRVnBid2dKb2UrWWxOOGtDM2tmZnM2RzkzUGFGTmszL2dPUkEz?=
 =?utf-8?B?Q1dmNmhGTWxISEgrY3k5SnoxQjdKc3g0VWR3UFJ6T21xUCttMFpaamkrQWFM?=
 =?utf-8?B?UXVJVXBtUTh4K0t5OWVhd081QTJ5UGhFQmgzNkNxTU1xQzBrZFFLL3pOdjlB?=
 =?utf-8?B?Q0w1QlBkZmVxL3R0VzU2ODlNdWhGZnltRm9oTjUxbW9IRUtHSXJoZWdIc2to?=
 =?utf-8?B?ZUNhZlpNL01yREZIOHVvQUEwTW1YbEU0WjJVc3lYMVpSWDNWblFsaUxKRFZp?=
 =?utf-8?Q?TcgEjyoZ0wF2r7eYkf+KCktSAuS/INggj3szVT2+Bi6n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR15MB6047.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15da88f3-b6e5-477b-4226-08dd47617e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 10:23:41.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQbC+BxkCuKPA1LzjhMAxsADKr+DrcKHL1hJwEmcfH3V1zsaxImCqZtps39sFEVZSo6gt919l7Sw1YyIXLHdrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4710
X-Proofpoint-GUID: OHG2k-zvhW8uSBWBj8HKb34eiGHxY1gs
X-Proofpoint-ORIG-GUID: OHG2k-zvhW8uSBWBj8HKb34eiGHxY1gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_04,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070077

RnJvbTogIE11aGFtbWFkIEFkZWVsIDxtdWhhbW1hZC5hZGVlbEAuaWJtLmNvbT4NCg0KY2dyb3Vw
OiBSZW1vdmUgc3RlYWwgdGltZSBmcm9tIHVzYWdlX3VzZWMNCg0KVGhlIENQVSB1c2FnZSB0aW1l
IGlzIHRoZSB0aW1lIHdoZW4gdXNlciwgc3lzdGVtIG9yIGJvdGggYXJlIHVzaW5nIHRoZSBDUFUu
IA0KU3RlYWwgdGltZSBpcyB0aGUgdGltZSB3aGVuIENQVSBpcyB3YWl0aW5nIHRvIGJlIHJ1biBi
eSB0aGUgSHlwZXJ2aXNvci4gSXQgc2hvdWxkIG5vdCBiZQ0KYWRkZWQgdG8gdGhlIENQVSB1c2Fn
ZSB0aW1lLCBoZW5jZSByZW1vdmluZyBpdCBmcm9tIHRoZSB1c2FnZV91c2VjIGVudHJ5LiANCg0K
QWNrZWQtYnk6IEF4ZWwgQnVzY2ggPGF4ZWwuYnVzY2hALmlibS5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBNdWhhbW1hZCBBZGVlbCA8bXVoYW1tYWQuYWRlZWxAaWJtLmNvbT4NCi0tLQ0KIGtlcm5lbC9j
Z3JvdXAvcnN0YXQuYyB8IDEgLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9rZXJuZWwvY2dyb3VwL3JzdGF0LmMgYi9rZXJuZWwvY2dyb3VwL3JzdGF0LmMN
CmluZGV4IDU4Nzc5NzRlY2U5Mi4uYWFjOTE0NjYyNzlmIDEwMDY0NA0KLS0tIGEva2VybmVsL2Nn
cm91cC9yc3RhdC5jDQorKysgYi9rZXJuZWwvY2dyb3VwL3JzdGF0LmMNCkBAIC01OTAsNyArNTkw
LDYgQEAgc3RhdGljIHZvaWQgcm9vdF9jZ3JvdXBfY3B1dGltZShzdHJ1Y3QgY2dyb3VwX2Jhc2Vf
c3RhdCAqYnN0YXQpDQoNCiAgICAgICAgICAgICAgICBjcHV0aW1lLT5zdW1fZXhlY19ydW50aW1l
ICs9IHVzZXI7DQogICAgICAgICAgICAgICAgY3B1dGltZS0+c3VtX2V4ZWNfcnVudGltZSArPSBz
eXM7DQotICAgICAgICAgICAgICAgY3B1dGltZS0+c3VtX2V4ZWNfcnVudGltZSArPSBjcHVzdGF0
W0NQVVRJTUVfU1RFQUxdOw0KDQogI2lmZGVmIENPTkZJR19TQ0hFRF9DT1JFDQogICAgICAgICAg
ICAgICAgYnN0YXQtPmZvcmNlaWRsZV9zdW0gKz0gY3B1c3RhdFtDUFVUSU1FX0ZPUkNFSURMRV07
DQotLQ0KDQoNCg==

