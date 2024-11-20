Return-Path: <cgroups+bounces-5649-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10289D3DDE
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21F928226C
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78761BC067;
	Wed, 20 Nov 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dVEZXHRo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XecFECqQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE701A9B3B;
	Wed, 20 Nov 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114008; cv=fail; b=aYF6rEtoe9DiTFAKMqa+Y57Wj6MSApwtkIket6qmtW5SDCF1UyOdiLvlYlAax5mFmILZtKAkIIQdLLPapvdgJYv8+T0FbXGCjQtsarbMnOQgq9SqQpXrdH1SZXLjGJXnBBpN89mHkhDiSFRjREdg5nl+uUe9YJhRHuc/JkeLYZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114008; c=relaxed/simple;
	bh=H2277ZsHVLBgW9Kr8ykFb6lx62nE4wq9wNVEQmdnC7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m8eV93wEMBQvLY6p54RWENvSEyCTXsXmpqO3+HOMMpQ9Pq6Z346+cItQ9Vlv4rGME9I3Jx7S8ipMY+fxnQoCX0BuhAtp+zsckML0+zGmtjOaYxoXN3DSplnoBRetFKrmfmqmlUdD6G3CEWu97jwwUjHsO22MWxVZgjchBOFAYkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dVEZXHRo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XecFECqQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKBNZgE025140;
	Wed, 20 Nov 2024 14:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=jisHWII/4PCBwGfVIM
	8iyCyC9cKDdVYvY7xENao1VvM=; b=dVEZXHRou+kLHB9yzYztSZyOKDWzQyUMIv
	XEGbkQzIk5b4cvFAZBVGxFQcj/XKKsGErmJ8GmEmyCqvrPKABzs2X0F51HvBNoFW
	6/pMLcHgv339nahJvDiGVHaVe6bEhVdrp7DJKz3iPdO1dmhvVSIGYPfR6AGKPsVa
	BLbwKipA/tHZ2jbIb8WBYHNI06Tba6AyhEZI+ZdeXdF2dvPRwNE9bBsPyaCd9SsC
	oaGsBLDlTB+eC5QZqUKLqkbz33sVi/6fJq/ixEsLRTtck3abbV5OVFg6hN9gSnyf
	RhoaQGT7uMZyIW56Nd6htzAW0vgW4y/i0mwdqhTOG5x2L6+L9avA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sqgwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:46:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKDnQ1K036993;
	Wed, 20 Nov 2024 14:46:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhua8rtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 14:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAOXF+uVs91F2APKrN+LVdYy0XXps4ipvXh0P6Q+mrQtNWEGXJiYeKnZlNiBPjPJJsKNHBl8G52w/QEM5BfHwnQb5r4PeAexyzMyRpep99ZLzwpGRcysmAyQ7k/Jw/tqnIAcko71sUf9lQ+vkOdw5q19HSqK/3JbxHTRe//fmy1W0kwmkrv7zUwRDcYDVCP3xh7TVf4SvF9s7k68BE1FAU99Rs781fu3tRN+zjABVflbrJJXI1NmZGmlxrCvIrkzCYl2+q2/TvxsvFuegrhtqulMaiqBkG/1SzTKy1VTPXsHqtXZ84EpT4d+oQqsrzCpZgJsZIx33nuCOe+e4/Rs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jisHWII/4PCBwGfVIM8iyCyC9cKDdVYvY7xENao1VvM=;
 b=PRSEGkO4pfW7HwDZNLiRdV2RoO4F5ppXmyiStv/0LecxDKrA1FTGD1Jw2ywzuN1EsB3VJbdCFpnIV/p82iGTRqIzS6W3d3WC7WoIeMpg60yPor05mXCUd2jr+0IfGwpU4pt6At53IPaVBJQvt96d90NRRB1Jq1L8cpGudkB6XFNNonW7XM1JjfMrGnzuOsvgFoJ42c/5VElxLrtIFBcYEWsySgyUpKYTYHocHs2EpQd5CPEHaHlfvxSrgmafaJ7QoLyvT2JiqCxV9y/hQTaEovszFuqhI6eF1Yl0Mmtc49tkpHHUXE0XifKweSCEzoRLj0yUsK7SyxbLPL9GGm8Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jisHWII/4PCBwGfVIM8iyCyC9cKDdVYvY7xENao1VvM=;
 b=XecFECqQ/jBD1NsPsIMMeEwSG5nlOR3kE4xrRDESVYt4N+2gBgOIKW0KR0rTM/6LmABF1EMgT8elo/U2UN6ePP+0Cqe7PD/Q23GK8w+ryV3/9bDc3Izfp6xBtg6tBWVsfiB0WAfbHMenMT3B1/OYqxsdXl1uPhYUvDZ7n2Gx2Gw=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 14:46:32 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::58ed:a3ce:88df:3341]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::58ed:a3ce:88df:3341%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 14:46:32 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>,
        "shivani.agarwal@broadcom.com"
	<shivani.agarwal@broadcom.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Thread-Topic: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Thread-Index: AQHbMBSPXgdxP+DKE0eVjOGNeVeRM7LAVcaA
Date: Wed, 20 Nov 2024 14:46:32 +0000
Message-ID: <c10d6cc49868dd3c471c53fc3c4aba61c33edead.camel@oracle.com>
References: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
		 <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
		 <2024110612-lapping-rebate-ed25@gregkh>
	 <6455422802d8334173251dbb96527328e08183cf.camel@oracle.com>
In-Reply-To: <6455422802d8334173251dbb96527328e08183cf.camel@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR10MB5559:EE_|PH0PR10MB5660:EE_
x-ms-office365-filtering-correlation-id: b6f1a2d8-4515-4f0a-0fc1-08dd09721fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUpGbWtBNHRtRlpiRlFZTUR4WXU1dEhGcitwVVdHVjV3MDkwcjB3c2xJS2Vn?=
 =?utf-8?B?cDNubVNZUnJ2WlhWNVRkUllaSmxINkZZM0NFdXcxMjRJMFBiL2NrVnl5Snlq?=
 =?utf-8?B?OTM3eng2VzJDR2xNSi9TN3dLOE9neWNVV01hWVV3Zmo3bEF0SjlQVnVPK3dz?=
 =?utf-8?B?cjlqbUZpSzFSZGQyS0VLNmZoVFo1NThLVEtXYnlGRWZPckxVSWhTREhWcG9P?=
 =?utf-8?B?cGM2eHMva05iOGxEaWEyTmlwTThsdE5oSVlUMjNIVzhSSlZteTJRaUFjdk1K?=
 =?utf-8?B?ZmNTSFJySUZUcXBBZmZLNUNhMy9jKyt4MjhVTllXeTRDMzhVbXpjNDh1c2lZ?=
 =?utf-8?B?ajRndDU5dk8zL1VPVXBPWEJPV1RhOGU1R1JDUENGbC81K0ZtOVVQSzB4KzAy?=
 =?utf-8?B?Qkxwa2Fwc2ZFQkFxN3kyNCs4TW5TWjNCWVZkSHBIVG1VM2I4Ty9TZ3IzSEd2?=
 =?utf-8?B?SnkwRlY5a3JXdis3a3VPWEo1YlJSTG5iVlptWVhGUHdsUksrMEpvYjRKVHlO?=
 =?utf-8?B?b0J5Nll0STFLODVmRXZIdW5tTWp0VlhaRGdIQ0VubmhINHJsUWRaaGFxcXdp?=
 =?utf-8?B?OThvZlJyMVJKcS9pb0FVbWRUUWYyaTNpWTVkcFArWW9kVk5sV1dnRzAvRDZl?=
 =?utf-8?B?NHIxL2RKL3Q1a1hIZDNKa0RLbE9YdWhMdVBQZGc5cjVUbzRJRkd2K0doVy9t?=
 =?utf-8?B?Q0NZMm02bElrSGdvTDlhUmpoaWRxMzBkU2IrM3E2eUowckEzYVdsYkRhOER6?=
 =?utf-8?B?TlVVdFBWUlFibnBoUi9NTHJpMkdDZXpRc0Jrb3BUVVhzZit1bnJCRnRCdUth?=
 =?utf-8?B?RllGaVJGcTNqZW8ybThzc3oyQXlSbDBFUzN2bDBSeUVWVndkdVJsQTJuZGpw?=
 =?utf-8?B?K1FXdHFUaHlxZE9NdFFDZ2drTEh6R2RHaWRITnQ5NXFJbEQ3SHQ1Z1N0MC9V?=
 =?utf-8?B?WEJHMjdZbjV5MjJZL1hVQ01NejhadGlOOXF3L3NTK3d1NkNBN0YrN2F4YzV0?=
 =?utf-8?B?c2hES0RnZXd4NStQbzJZVzV1czNYYWpLN281NnVRMTgwMmVIMUFvZW5NTExv?=
 =?utf-8?B?VE8vU0VZZWRmMTVaaWJMWDk3OUU5cVRKb0hLNm1QcUozRmlUc0JrMVhmMEpo?=
 =?utf-8?B?TUYyL0trVElqL0N0Q0UyN2ZSMDhEWSszeFZPOWt2ZmtQeHFJQ2k5QVJwYzRv?=
 =?utf-8?B?ZVVBY0hPZHZ2VjNwRlI2YTdRa2haMEFnMnZQZ1YzdTRSN0h3QlgyM2VLdndi?=
 =?utf-8?B?Q0RvOThRVmpTNEhmZ0RidWIwZkxPeVd0TS93MFZ4V2ptSjZsTTZLUXNvNzVh?=
 =?utf-8?B?dmxrc01YMEU0T2VyU3dJZWFudHRmQjBOUkJUN3Bud0V5Z1JzMGZTU21PSjU4?=
 =?utf-8?B?eGFXNUlkTlRtbFJGeDUvU0lQZWJ5Mm1hT3ViMWZONE5kRUxmU01COTF6alps?=
 =?utf-8?B?WjFJQ09YamJNNy9raENnQzdPMldhcXR6UncwZ3N3c2VQOER3bm1ZUU16Tm50?=
 =?utf-8?B?WDJ0bWhEWG0vL1o2U09SU3hnbHcwWHZWR283VWhxNmg2cW0vcmJtemIvQWw3?=
 =?utf-8?B?OGk0VU00V0J3SFVjY2RyY3ZIQ1JqempjcnFUVSt0VUdMQ2o5c1JObHp6QSt6?=
 =?utf-8?B?RlpEd29XMU9jb0hZbnJXcWJmOUZtNnpwOGt4NWtrMHk1bjhZME4rclcxTnMw?=
 =?utf-8?B?TVdLcERGbU5IbmtrWE5odEdjUGVUeXhZK0Frck1wa0RpUDR4S0xZY3ViNTZk?=
 =?utf-8?Q?h9kCVJJGu/qmOYdPHc1/W1aPlh/nPfcBp8AuiqP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGVHclhPTTU0UXVoY29teTlDSlpzWWViNXFuSEhtNVZDZXZweEtOYU5uZmhP?=
 =?utf-8?B?UGdqRW9McG1NaHdHNGJoUlR4dFFRbU5vT0x4UDNIVitQZ2F4c25nNC82MXc0?=
 =?utf-8?B?YzZLdVptRlY5cFNYTEVSUW9VZ1hzMGhNK0l2S3Q3dDY0Q1EwYkJ4RVA2b2sv?=
 =?utf-8?B?VWJpZ05tOGZBVy9yUjB4KzViNlVWbkUzWWYra1RpQW02dEdKMU53bjNrclhU?=
 =?utf-8?B?cm0xd3JweWNSSDdZcEsvanBrLzdVQWZaQXBkVDJocDgzRFFraENDZFNkak1Y?=
 =?utf-8?B?UkRjUGQ0WmFrTHFlUEo5aEpyUEtsa1R3OW1NcEltTXVGZmlybTNDVGlTV2xU?=
 =?utf-8?B?RkRsR0JjaERVL1Rta0pTWlN3dU5OZ1ZnR3E5Q25pQUgzMmx4R1RHaXlwYlF5?=
 =?utf-8?B?QUV6QmNnUUZsWTQ1TDZ5N2p0dWpGVVBJNkhJa0FBaWJzNEVmZG91OVJLeHk3?=
 =?utf-8?B?TlhIdkxza1BjTmRZR2RlUmxESEpJajRrbElRcHFTOGRNempsWjQ1N1h5Wk1u?=
 =?utf-8?B?R3FnT2M5Q2lqQlZmUXgxTG93VzhuaWV1blBuV25iSFJCZ3lYV0U0a2JwNnd0?=
 =?utf-8?B?Y0FxMzdLSFIzaURVNlBXdXhvSGtJR1Q2WHpPQW9jWDJMNkdxYVB6VldobjNE?=
 =?utf-8?B?Y0JmdzFtRkx3d251SVZxT0kwSW9IQ3R5Y1F1NkNUaHphaWdmQWtyUkx2NXdl?=
 =?utf-8?B?aHV2SHBoTmRGZExDcUhMamhBNGJRQnplRzJLaGpNZ1pmSjRlVHE5cG9NemZX?=
 =?utf-8?B?b3IrTWtUSXRYRkI3UEJCc0d0YWZORXRRNTI5K1lCTHpxVjJYc3F0d01IcGgr?=
 =?utf-8?B?RTRoUmZzWXJSZVpFVzErTnZMOEJoWmQ2OXZvNzZiRnJiVEFySWEydHJYVnRs?=
 =?utf-8?B?TTF1bUV6UDk0bnNyR3ZQTnQwMW5HRlUrRDRTbnQvWTVGZ2pXV1YxSDBlVkYv?=
 =?utf-8?B?SWJGSkxZTFplSFNxM3ErYVp0Qk53MzU1bEYrNnN4bmhCeXduMy84dTRhN0hP?=
 =?utf-8?B?VUdEUE9rdTdZRGRRd0JRczdLUVhWRzhpSHhvSFpKdDZuK0tKMGxUeGlNaDZH?=
 =?utf-8?B?R1BudS96S2FaTGtrVnRhQWVrcHBNZm11L3JMQmVXYi9INFpMSUlMVUJsRVdD?=
 =?utf-8?B?eWNEKzRvOHh6enZGWlN4c0daYVZRRlRyNzByd3J6c1NXOHU5eG9pV0JGSnpr?=
 =?utf-8?B?b0E0VUZ5L2pIeVhBVEhwOUpnVU5CaFJuUk1NV1E5OWNjdzFMdzVhYzZ0allH?=
 =?utf-8?B?UmdXNEhGajJhTlN6bnY5MVNiWUhYRGNVekwwMFVHRnpnWDBWRjRUcCtDZWNU?=
 =?utf-8?B?a0N5R3QxUHY5M3RTSDBPMEdNWXVXMHhIZ0JyaFFMc0VYUTlRV1o5YkZRcFVN?=
 =?utf-8?B?TTJ4WlNkOHpzd282L2JlMVBXSFlFUDMwSHEzWHNNN0FQZWJyK2preEl6bis2?=
 =?utf-8?B?eXlQd2Iwb0dkZzlIdENNVDVyM2RNM09kSUI1YXdKY0lvdUQ2cFVOSVl1Y2hh?=
 =?utf-8?B?QjhXckxDSHlOOU9GcmIrZE9YZGpqdXNwRGtTcEZURWdDVmxERC9YVlpzRnlQ?=
 =?utf-8?B?YzA2dDNkTUF4eTJWYUxFTEo2TmcwUFI1cSs3UlNHamRSczg2cU82TXZOcEQw?=
 =?utf-8?B?bThQNlBwMG9ZK1BaaDVieHJ1TW5RT2Vkd1lhUXFNZDJJYVdFZG5FdkVlVERG?=
 =?utf-8?B?eEx3STczV0ZFbFh6aVpJVnVBTG5JMGpvUDJITkpuUWdTSXFhdW81azYrVDln?=
 =?utf-8?B?VmtxWVdTN0pXbTFOblFKY2c2c20vbTF6M0lXRzVzNkRiN2lnQUxIYndnMkVq?=
 =?utf-8?B?NktOYlEraEJnSjhvaDQxTFZNekNXQlIveTJLRWR4QVVUdHF5Tjl1UVFUQnJl?=
 =?utf-8?B?TmhCbzhKVGJZS1RGdk96T1dodm5PdldRZlI2NXpTSmgrbjlyU0VBV2lJRDIr?=
 =?utf-8?B?c0krWHlUUW9lSENVeDB5S1IvVXd6bFpFUnpVaTlNZkdzV2RDMWppZkpGQnhn?=
 =?utf-8?B?YXdvRnNoTVp5cFR4bHFSenNieUd1QmhEYlk5YzE4TG1aQTQxb3U0OC9oNnN0?=
 =?utf-8?B?OTRJTU9nWHZSZGFRODJDUkdhU0JaeStjd2VRdVBhTTc0RitmbHQ3RFB3dGxB?=
 =?utf-8?B?ZGVXclAzbG8vWjRvWmczVk9KaWxTWnhGeTh5a3FIclIwakdaTjU4RXFxTldp?=
 =?utf-8?Q?nIWM5WefAbqlZn/4kr3EWaQMI5sXhGosGY2qFhvU1w+8?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-DNrmXjxYdJfYcAc3dxVw"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lM1vlUbCPa98F34eA1c2qyNpUXnydhMtTmjbYvklNbXl7vMR6D/2NkeOX3iTgiuuSc0Fmhrzcq7cVIh3NI72C1nN7D2uCzilhDLonxFFICr79tshryuEb0wHSo63xkevQVaa9LWzujwdro43t2D41WJ1tD+VXGuM5iYDJsFFWiNp1b53xhHwRYaoOqt7awkPYjv56O+bIfbo62oAsyjPA7JIE4hYaM5lx6jxwVnFel9BXPoCUH2B7Nbk/osvTmabS+skTioERmuHgliiKJfdxYr69mc/YSwd9iI+15m0uKQMtNMz9f4sW6exxhZXrTGBJbsaAQttNyzMrZXPG2NYjDcgk7fXp0BysgNuhvniHd8TE3TCpo/vdLPq2cRKnl+u0njyajvFaW8MZCcQCR3+o7WG74cvhkj8FHafHQhjJd5LEaM178fPnTCvUW1KphiW6tplCOEashdYaQl+4saLX0cPnaykkMfaUZelrlV1cGRW7hJAea/ewphBVeLhINS6xNvYBB6gFUIlSL83h2Z9DJUnwo1Kh1ESAYsaxpjBtqhyQx/N7SR/pzI1T49oa6C6hHboE1TrjFC63R1cbBx66NqzTwxir7FbiQjGM1ScByI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f1a2d8-4515-4f0a-0fc1-08dd09721fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 14:46:32.1686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao6/Jb/o4ANm6Wf66osJbCIU1FC5jw3Rf7Sh8RqdpeDFOWvdwS6qqBzyf7sFZDr9cuvhw2xtqlBmLg015p0hztFr7P6hoArMnQoA3NVzcgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_11,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=954
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200098
X-Proofpoint-ORIG-GUID: K6arB6UkNlONxjL2KbbgPXBqrOu3aRKU
X-Proofpoint-GUID: K6arB6UkNlONxjL2KbbgPXBqrOu3aRKU

--=-DNrmXjxYdJfYcAc3dxVw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06 2024 at 11:54:32 +0530, Siddh Raman Pant wrote:
> On Wed, Nov 06 2024 at 11:40:39 +0530, gregkh@linuxfoundation.org
> wrote:
> > On Wed, Oct 30, 2024 at 07:29:38AM +0000, Siddh Raman Pant wrote:
> > > Hello maintainers,
> > >=20
> > > On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> > > > Thanks Fedor.
> > > >=20
> > > > Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e=
4aa and
> > > > in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 =
and 4.19
> > > > also.
> > > >=20
> > > > I am sending the backport patch of d23b5c577715 and a7fb0423c201 fo=
r 5.4 and
> > > > 4.19 in the next email.
> > >=20
> > > Please backport these changes to stable.
> > >=20
> > > "cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already been
> > > backported and bears CVE-2024-43853. As reported, we may already have
> > > introduced another problem due to the missing backport.
> >=20
> > What exact commits are needed here?  Please submit backported and teste=
d
> > commits and we will be glad to queue them up.
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> Please see the following thread where Shivani posted the patches:
>=20
> https://lore.kernel.org/all/20240920092803.101047-1-shivani.agarwal@broad=
com.com/
>=20
> Thanks,
> Siddh

Ping...

--=-DNrmXjxYdJfYcAc3dxVw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmc99j4ACgkQBwq/MEwk
8ipVOQ/+LCuUfQugWGa9HW+u9kLadh7tEvX3NUHhQ5M4Zonj47G7X3TuI2Xenp5N
hbZubTyMrSEZVHS0t1etf6cWuVZjMly7kCMS9NkazTn4rsEgC+eLtwxajNhc9JqJ
9X9W0iE8ZYDNamerUI6rI+qRfcyfTCkDN18G76jKhhsh0OdKosGhHo4oP3rsY3Ei
5WBAMdQ91SfyYSfOwNg2JMcFV3tCHFPbjTpL9HDDl9BfNHBmUNMjOUCLBikY+X3r
syYAYGaDHK8LdaIVX9U3ZxuI1sa6ZQXytDo03t/1EwB8r778I03fRpVIE9zmS9MO
XlJsOCRUM4K2jpgpWEGKikSefV6P4aF7HTRInqxQqBibcAE9ZD1P8oOmK6YwlBBl
zDxMxlT97PiDeE9M87K4tgX3+xXLq9e+cxMsqI+X3biKC91/bBkf0Hp61p/npsEk
8abMtkTeRXN/58sdoIcwFtJdk2VlwJV+94YmCTdL+NI5XY1YsVOzip6GITFPPusU
KjwAuEyuXFr7akwhJEjXF3x4SwB2o7Il+wzM2lP8MnITNr4Cq//++dZqw3KChY5E
kIa4gpck7STTtmhMAVdai9wFACxI1oC/iFCP8LQ9PRkh67EV2+LG/pcgY2+Qd8ev
cQBKXLwc46bJqJD9ZSoURRdLfZyVSYjk3z5lOjA9pkGSUapsjjs=
=xk7k
-----END PGP SIGNATURE-----

--=-DNrmXjxYdJfYcAc3dxVw--

