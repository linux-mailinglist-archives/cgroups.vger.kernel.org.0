Return-Path: <cgroups+bounces-6518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83730A321AA
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02E41889749
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C2205AC7;
	Wed, 12 Feb 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MH/gw/Rm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HP6QlGBd"
X-Original-To: cgroups@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1361E7C07;
	Wed, 12 Feb 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350980; cv=fail; b=rLEQaxGH/qtNFTNeXtHTx9M5YhDWisWGFtEVOQqslfHDYnrT3hvzqja6ORvmGyLbgEbSjN6eF7aMHJxtGtl3W/yZzw5KEcuuasg4vMl49CSmM8U4XP7V2NlU0bSMjwQ2csTQrQ5TcOgmLWIS2dgrud2fZWhzVAXTq1W7HgNhVW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350980; c=relaxed/simple;
	bh=MYHqWHpgh+FlXrPVftwLJgMA2/ZFAxroutjFQTkP4sM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKSUwyuSPOXyXJB3RMEvhWQplv5B3inDrpwKSESTmscF+UpN1Yr/k7w/PjUPK3stBSmVsAq3slCgQ1Pjc2V93zwR7Dn8/iehZ7Gj2lFfZqjTop8RhWXglykjywxEfg7ln2hb5KHY6Yp5AgOl3fi5vAs2WkE1a9/5KGFgGFjWDI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MH/gw/Rm; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HP6QlGBd; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739350978; x=1770886978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MYHqWHpgh+FlXrPVftwLJgMA2/ZFAxroutjFQTkP4sM=;
  b=MH/gw/RmJNL2Y8S3HvSJn6C9uAh7vaQJRQizfQog6Ccb20EVsVipnNT0
   wFRjITQ2O/FvNUhdivcf/To3yrsSs1W8VCMf3FnegSefdg7Kg/vZWTQc8
   IYZe1j2+ROjehwvlUUwW8LrT75AEOByduDuy9lD7rMm8XoMZb5UfGh8WO
   GScIWhaHqqvDnhETE3YHeDJ7a0nx7DOlfldY5+YCb9/jnYPUM2YMyK598
   QvRVShogWrtWjaLtkQ7CAJaUq6ZVIvr+pqG+r84rMzm000bdznIz6nQLJ
   iG3F8hV9et1mTVD617GJgzT56fSE8vSaL3mb9HrRK6Wgfa3LV/koayIMJ
   A==;
X-CSE-ConnectionGUID: YjyVvW62T2mlxrQHGnSKVg==
X-CSE-MsgGUID: gStlwxfqSyGylYOvZPXdeA==
X-IronPort-AV: E=Sophos;i="6.13,279,1732550400"; 
   d="scan'208";a="38032166"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2025 17:02:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfE4/1jjs0SUIbqDcGdWtfNpBQIMcAWRD8hEC60U0YkUkdcFWU89kP0+Z4Ll50JtbaArAVsv3NyeNizmlgLwSOFw9v1kpbit005FnvJxM86Z6LPdSJ69FfHT7LsUbO/XsUSNTqq0vkIWT30DPE3enjoC1ghtRKiVVoo16jks4MwwsgD7jbj8nXEPEQk3O3MmDbQIXIAbEpO+xDW7F8FQ1SEAXkbP36JT5lEONmAjxy7YH6DjgL5UTn2huq8cy7mCVi7r/NWdXSy63XhTiuqq7lCH4WmSj3k1KWKbHRQTA0oNMx/bChuVXpo+o4yesOcDDjGwknSja0u/FNX3uN0O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYHqWHpgh+FlXrPVftwLJgMA2/ZFAxroutjFQTkP4sM=;
 b=AnJotvKcNGQiSW0m2Q1UGEBBIJ/xf8m7nUim5VGj3JBUlewlQRUNzCVXRA2RWNNCjxGMjkeH162GNP9Am2ZbG9+SJPXWHcwp7lKjkNlSgFIvsRuIT+TI5nJbr9cU3njdapgs94qg9TnlJW1XeCBHSTJR0YFPb8OH1a8Lan9iCp6ZPGvH5GNd7Mb5JP3yEW7ozbCsuKOQbhbL9pMgw6V3NnqTIsvBC+x1C7ZfX4fW/+nJsYZLF7ZZViOXgKT14Vz4e2j3d4nQLnI0x6GateP+e1Lkucw/bSaIq/JZaQQL44+PnQOLtPCyoL1PubkIPmYaDd1jgW1u96AYf9yxYPreNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYHqWHpgh+FlXrPVftwLJgMA2/ZFAxroutjFQTkP4sM=;
 b=HP6QlGBd7ZPa8M3T+9XiZdk5GM5/gW+//m/66Y9cNGfbC1VpL0RuCYOzDzYm79up9pWV/MVkhbintrmcWwBMkqkNHin9GRgQ0hqeu09RCmMxO25WohL/vEdGdmx8w5jsQd/qsunOq5Mx8YYNAqPxRqpDLL++N/PPj9feAw2IPwY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 09:02:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8422.021; Wed, 12 Feb 2025
 09:02:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "tj@kernel.org" <tj@kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] block: Check blkg_to_lat return value to avoid NULL
 dereference
Thread-Topic: [PATCH] block: Check blkg_to_lat return value to avoid NULL
 dereference
Thread-Index: AQHbfSiwbGvbk3D8S0mMbQdvXHygA7NDX3OA
Date: Wed, 12 Feb 2025 09:02:48 +0000
Message-ID: <00f8157d-8c73-4aab-874c-77d0f5443365@wdc.com>
References: <20250212083203.1030-1-vulab@iscas.ac.cn>
In-Reply-To: <20250212083203.1030-1-vulab@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7262:EE_
x-ms-office365-filtering-correlation-id: 838386f7-01a6-4ed2-d6bc-08dd4b4405c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTI2K3dkcGFDUStOUXVjeFZ6TnFoRGZCOEhVajJhTUh4c2lLcWM5RUhCOTBq?=
 =?utf-8?B?UllSNGUxVXVpc2wyUktUcnpTMEtMYWdzUWx0bG9Ea2p4RUxwY04veFVNYlNK?=
 =?utf-8?B?djUvZjVSRW55NVhhTU5WQ3VWbXhLc0xCNlVwd3JXMm82NU5HNG1BSWNBcTlt?=
 =?utf-8?B?R0hVRXJBOFVrQkU0Um1hMzlMbmtNN09PSGVhRzViNjFaNlo3eEVsVC92V1lY?=
 =?utf-8?B?VHMvb2tUd1dFaFY1Mk1KYXQ1enF0STNIVHRBRFd0K0MxMzhkRGNYQjRjbnY0?=
 =?utf-8?B?MUtDZmZSdDFTRjZnNzZJY0ZOM3RQR091bjZOYUtuYnVzS0pOZFNSeGh0U2FM?=
 =?utf-8?B?c0hydjVXdGtOZkRZdFhLNHBMQ0hCUHhkUmMzS1FIU1NiM0NYNFh3Njk4UkI3?=
 =?utf-8?B?NXRUR0dRMlNBQWFyclJVNWl4NU5vUHNQRDNrektWRGhBYlB5bi9ndVNhdGlu?=
 =?utf-8?B?bFNMeXlRRUZMS1djYXUxMk5IcUtXNEFyU3FiaVltUUR4UmdZS3JBbWlySEJC?=
 =?utf-8?B?N3dFOUNJbXQvd2NaQkRLeU04Z3ZMNkoxTmFkK1B6U3hyM3FLZmZLVmd1VUsw?=
 =?utf-8?B?WithUXQ4c3p5Q04xNG9vc2lVaFJJdldCNFBWZWJrV2p0VzlCTExuQTBicUZv?=
 =?utf-8?B?YVU4MVhOZHRlM2dlMURLc09YaUtsOWtNU1hxOU8wKzk0enFlQURESHlKRkpq?=
 =?utf-8?B?b2NYektmUGROb3JCcUI0MnJmb3IzUFVmTU9SanZzaUY0RGxHNVV4b1JVYzlh?=
 =?utf-8?B?dUtQc2dSL00ydEFwUm1Ud1RKTndNcXV0WDFJTjNVR2FIUHlRcCt5ZVMzRlNP?=
 =?utf-8?B?SDBNK2hIRmFQU2ZxSEgyT1o4cXpMTUt1cWZvcTZXb0RJbTM3V3JQRTljNUQ2?=
 =?utf-8?B?Z2R4aFQvN0dyaG1NdVZ3VGF4R2NobTBQQnc0ejJZNTVXOUMvL0hvUW5xNFYr?=
 =?utf-8?B?N3BVajJIaVRDbGloRVJ2OTQxLzN6UmFQNlkvT3Y2TVJLZUhIS2s2QWo5QVRa?=
 =?utf-8?B?bFl2UDFET3ZTK3JpV0duY1ZVVzcyZzlBL0YwKzBJSUQyckRsMEsvU1dsMDZI?=
 =?utf-8?B?S1UzcUZwRHg2bkcyWi8xZTRsUXY2c09aeGRLSHNTeElTL2VIb1dEeXdzTURY?=
 =?utf-8?B?R1k1SEdXcGFJVktyNCtrNVFlb3N4T2VjelE4TlVHVE54bUtvOWYwNDNTVFIz?=
 =?utf-8?B?UloyeHF4T1ZBM2xvQjF3QmRML0xVUXkxOUlhTFlhdHZhQkJXMjBYM0VZYUNJ?=
 =?utf-8?B?NytqLy9VQUtJU2w1LytqUkpiRzVpTmNSVVJ0Q0xXcUV3V3l5YkZZMjgyZWlY?=
 =?utf-8?B?Wk8yYUN2b2J4dE00VXNVVGFhRXlOMDFqeDhQMStrbFRNbUhBQmw2UmxvWWY2?=
 =?utf-8?B?SGhlREFmeEJ2MUlIT2REd2NMdjBZOERrUEdmNk04ZUw3c3dqbzhWRXdrdlVo?=
 =?utf-8?B?TDlwTlU5QU1FcHk2dmE2R2pDNGtDSkhqVjFCb01YRzBySlEwS0NTS3NSNS9U?=
 =?utf-8?B?KzZZbWgvRk9ZaDJoY2Rydy93MjdGM21uQklGQWREcmU0dXNXNWd4dUZqTHNm?=
 =?utf-8?B?YXdGK1FTY0ZnSWc4Z0cveFBMb0VLUjZWd0xDbGRJVnNycHJGb3BXM1RtY0ZL?=
 =?utf-8?B?akwwWWxMYnVoMnlUcGFVK0piSmR5WmxpNWtTN28vUzNyT2Nxc3drWkN1OU5M?=
 =?utf-8?B?Q0xqRGVMQWtqa1FpWXdiZWdUdzE5YjN4b1JYcGtpNFlra1l4UmYwNHJxblc4?=
 =?utf-8?B?Q3ZuOW5FZWpKNWplSzc2emtvbXBYdXo3TjFnbmY5QnhoeDBnSEVIUHp4OGhQ?=
 =?utf-8?B?Y0lZTjF2Y29uL1NrdjkwZ05ubXgwRWtrM2ZpcXV4YnpPRnhITzlWRHJoRTd6?=
 =?utf-8?B?UVM2M2NRTDd6QzNSd0RuMmtjQjJMSi9ObCszeWRxcENLcVBHWHIweUFnejdG?=
 =?utf-8?Q?ydMVBSQU8+VcHk+mzvd1ljUw124WOBIs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzhCQnF2OGVqODFDbm5XMjN2UWQ1aDI4Q015cER0WGdlQVNNRWp0aGorb1NT?=
 =?utf-8?B?QUlYOVE5THI1MnZkVVNHTnM3a1g5emdxWkJWMGxtNHJ1b1g1bjhrd2hjNXN4?=
 =?utf-8?B?c2grMWRiUXhkczk5SXJpaXRpUkhYd00yc2lvZGZGeWt3WFc0RFdLc3ZTTnRi?=
 =?utf-8?B?YzhUVG0xUUZQWUlIM3hTd0ZsZlBibk5HRmx1NG5PM0pMMm1PZEZ6S3RKYm12?=
 =?utf-8?B?eVU3cENTYzdobUFnVGF2cXBZVm5mWS80R3NDbEFhUDh6aU40VWNNQUpwdlRp?=
 =?utf-8?B?T1dUSjhNUXcrVG9EZzZleGFVVFFFMTFmaklWV1hpVXkwWmYyUDJUZmpLMG9q?=
 =?utf-8?B?bklUU05tbFMwNHg5bXkrTXRkcVIrR0tzTXNCZ1V2eDhIMlcybHJZYVpyV1hm?=
 =?utf-8?B?YTg2ZTk2U2ZaTHBuN0dFcUVtNVJPdjMvS084SzhwMTgzeEpmcWpmU2h4YVNN?=
 =?utf-8?B?dENhbXhVR1oxTjQwQyt1ZTU1RTZXUjZ6U3BVekxpNGNnRHZUTHA0WmcxWmUx?=
 =?utf-8?B?TWErVks2UzFRSnFMc0VJbUVjQkY5UE80eHQ2WGFudW5rR3ZjZ3o5RnlzT2RZ?=
 =?utf-8?B?WFk1ZUllWmhJRFkyb2VTbmlCOFpCNnErc0dwYXBoUHFZU3l6OGJEVUl4UVoy?=
 =?utf-8?B?YkRBbGpnbGtVT2F2MS8yMzR0MWl0Y2VDZHhua0U1b1dTSjY0c0Q1dWxvQ1NN?=
 =?utf-8?B?WGRaL2JjN2l0elR0NWJUL0xhd29LdkFhdmE5VCtIL2gvamV4a0JlUXppRUdi?=
 =?utf-8?B?d1cxbDFBL2RTM2tkVXFuaC9UbzNYYTFUL2FqNXlxNGZyOE1nRURNZlVseVlG?=
 =?utf-8?B?Wk5JbXJhRFNOL2hISU4yV2ovR1oyUldNbHJLRGFlYVZSaXhNbE1MOENmVklq?=
 =?utf-8?B?SEhhcUdwRUJoTzY4ZVVCTkp5MytUaEFDUis5eHFHeVBuMG83WnZ5Z1dCd01C?=
 =?utf-8?B?czdpOHZwMlVGejIxNFlPMkNoaUtkS0w2MERIYW5zYTVtK3FsZ0p1bmtYUmpC?=
 =?utf-8?B?a01rMnNJcXd4bXV5Yk0zWXhEQktDN2ErcTJZWUtybnlsYndxQldqazNIbHFC?=
 =?utf-8?B?UGthTWZuV2l1dEtJUE1KUkxYM09xS3FOblgzeWVha1hBM005N1c3R2hLenlQ?=
 =?utf-8?B?dHR2TVJIR0FvdnB0Ni9RKzhGelU2Qzh6eFIxVTZidWRVMHY1TE5pelA4cUVn?=
 =?utf-8?B?S3poNWpqMThjeG1jYUNvdHZRek1TY0laeCtQbXhsYnp4RDRYVXZ4VWh3V2xH?=
 =?utf-8?B?LzRuQkJWYXZHa20xbmtTYW5VMGJiWlJzU0tXSU5JTVQ5bWhyVzJaeDRCL2lZ?=
 =?utf-8?B?Q0Y4MjhXbCs0MkRDY2pTVGNESnlBYUlUSW5NbFRGVzRWU3hVTjhJeEJrQkIv?=
 =?utf-8?B?OG9nM3RNMkdmeVFmb0lhSDJwMDlMZnV3cUFZTkZXSVJ2ZW1MWHVzazdOcS9n?=
 =?utf-8?B?ZDVxMm03SlFyQzJYUVJTQkJndUF4dlc2OUpxVjJFVys3RlBSTjlDOHpBeERa?=
 =?utf-8?B?RXhGVHh1MnJnbFZ3RGpXZWJqbkNLYkxXL1FBdG5PUjJsOEtrSzBpNFV1SERv?=
 =?utf-8?B?OStpaXEzTWw2UWxQV0Y4VlFLeUgwQzN6ckVRZitzenJRc0YyUHFvbmVwY2Nm?=
 =?utf-8?B?SlpEUkNTMTBZWnBWK2ZVSnFLa2J0V2F5SHBGUVNIa3FQSDhVcCtEMWkybTdR?=
 =?utf-8?B?ZDFzUzF2TmFSNW9Md2VRdEw1ZlhDcEZqRkVTK0VNWmlQMHhONWxOanRGS2ll?=
 =?utf-8?B?NmRpMnhEUU5QK3NoYUdVTkZGZHQxOHJ4QUt4cnBQV0dtZWdMTGI0TVdlVU9z?=
 =?utf-8?B?aFVoYzJ5ZmVuemVsRXQ0cjBrZTZycmZaU00wdFExRFJKZFVHMEM4ajRnSU9O?=
 =?utf-8?B?bVkwRmVycnVCUDlZL2ZDVVZMMFpua0pkUkxKM3VBME1SdjFTa2owQTVSaWcw?=
 =?utf-8?B?RGQvOTJFc2lGSitXL0crVHV0RW1iTS9kN01nZDhMWE0rOUs1N084eUZFM0w1?=
 =?utf-8?B?MnpzWE1HdlJzYW9sVzNOdVlIeVRqa0pyckF2YXU0bGx2L0hVSnZJMHZJOGlq?=
 =?utf-8?B?ZWpmaFFvRXZLc3hFcWlyeXZRdTE0bCswYWgvWkR5Y0ppa0VLR3ZTY1dtV09V?=
 =?utf-8?B?UnZ5VTVsN3AxQUc3THlpRnUwc3d4TmZocXhpQ3hvRjN6UGMxS2xsekNrM1FC?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE9F2CDEC52796428DFC30352BA07C3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s3K8y0VL+XpLh30Et4kIWXMF+6eUuvWE2+YN/D/JjZjQ3Y/+gtIytjOgR86Z0oThspYL1vyvF2TlqwKhv4XZl05/+qYePiMOrP3mXTEw7s1s7RGkq7kaWNUVyQJg4p7/WDPY+HAvVs/SDQROyJdzHOjQc8ZPY8bqjmLNCa5FUt/nWlirNJNI9jKKdeb1zv12FVsF3j0vbCqTb3AdNNnz1MCVv4Fwa0Vc30b9BIt8Bto7NB6Opwkr7w9MTrju+Hh0Jm3cGGaKXeij4cCF9o68AKDg6Wthg6WoqHAgS31l5+GziuYeXCngI68+VKQ4iV1VhXLan0jUe7NBniRSFv8SMT9zX36wLsnrTYPWQYYhOsZZHh0B5W+3wlVrCTjqZE2oPUzgTxOyaF42jekU642FaT3JgsJz8+BpyTXXFMetYe0fioFbKYq7o7PlxB1ZZfe/UdHQ5gy1dawdQogP2fMK2ZNJC1FFSCO0jWrT9LQAKHbXv8bv3zv/jBsXiKGMqlBL9+Qt//KJhXbxICPzg0wI8nv36omY4CxtEaSKX26x6yob5iLsZlzsGxvt7Pd/jNSv6Y3e36FzWW0yqWEduO+Q8Y7LTp7ligeytU8xp4EjddydWyd91y33glansIZaGJjQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838386f7-01a6-4ed2-d6bc-08dd4b4405c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 09:02:48.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyR8CKLpEs8anL6GMUGZgiJy1A3jqX1gdckkEyFZCvj2jYNk/BI6y40b8nJySzt29jdzp1tfyz71gwJX/mi1Ze6cb79VHtilrUFOB9mzP+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262

T24gMTIuMDIuMjUgMDk6MzIsIFdlbnRhbyBMaWFuZyB3cm90ZToNCj4gVGhlIGZ1bmN0aW9uIGJs
a2dfdG9fbGF0KCkgbWF5IHJldHVybiBOVUxMIGlmIHRoZSBibGtnIGlzIG5vdCBhc3NvY2lhdGVk
DQo+IHdpdGggYW4gaW9sYXRlbmN5IGdyb3VwLiBJbiBpb2xhdGVuY3lfc2V0X21pbl9sYXRfbnNl
YygpIGFuZA0KPiBpb2xhdGVuY3lfcGRfaW5pdCgpLCB0aGUgcmV0dXJuIHZhbHVlcyBhcmUgbm90
IGNoZWNrZWQsIGxlYWRpbmcgdG8NCj4gcG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZXMuDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgY2hlY2tzIGZvciB0aGUgcmV0dXJuIHZhbHVlcyBv
ZiBibGtnX3RvX2xhdCBhbmQgbGV0IGl0DQo+IHJldHVybnMgZWFybHkgaWYgaXQgaXMgTlVMTCwg
cHJldmVudGluZyB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KPiANCj4gRml4ZXM6IGQ3
MDY3NTEyMTU0NiAoImJsb2NrOiBpbnRyb2R1Y2UgYmxrLWlvbGF0ZW5jeSBpbyBjb250cm9sbGVy
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA0LjE5Kw0KPiBTaWduZWQtb2ZmLWJ5
OiBXZW50YW8gTGlhbmcgPHZ1bGFiQGlzY2FzLmFjLmNuPg0KPiAtLS0NCj4gICBibG9jay9ibGst
aW9sYXRlbmN5LmMgfCA0ICsrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWlvbGF0ZW5jeS5jIGIvYmxvY2svYmxrLWlv
bGF0ZW5jeS5jDQo+IGluZGV4IGViYjUyMjc4OGQ5Ny4uMzk4ZjBhMTc0N2M0IDEwMDY0NA0KPiAt
LS0gYS9ibG9jay9ibGstaW9sYXRlbmN5LmMNCj4gKysrIGIvYmxvY2svYmxrLWlvbGF0ZW5jeS5j
DQo+IEBAIC03ODcsNiArNzg3LDggQEAgc3RhdGljIGludCBibGtfaW9sYXRlbmN5X2luaXQoc3Ry
dWN0IGdlbmRpc2sgKmRpc2spDQo+ICAgc3RhdGljIHZvaWQgaW9sYXRlbmN5X3NldF9taW5fbGF0
X25zZWMoc3RydWN0IGJsa2NnX2dxICpibGtnLCB1NjQgdmFsKQ0KPiAgIHsNCj4gICAJc3RydWN0
IGlvbGF0ZW5jeV9ncnAgKmlvbGF0ID0gYmxrZ190b19sYXQoYmxrZyk7DQo+ICsJaWYgKCFpb2xh
dCkNCj4gKwkJcmV0dXJuOw0KPiAgIAlzdHJ1Y3QgYmxrX2lvbGF0ZW5jeSAqYmxraW9sYXQgPSBp
b2xhdC0+YmxraW9sYXQ7DQo+ICAgCXU2NCBvbGR2YWwgPSBpb2xhdC0+bWluX2xhdF9uc2VjOw0K
PiAgIA0KDQpVaCB0aGF0IGxvb2tzIGhvcnJpYmxlLiBJIGhhdmVuJ3QgY2hlY2tlZCB0aGUgc3Vy
cm91bmRpbmcgY29kZSBidXQgDQpwbGVhc2UgcGxlYXNlIGF0IGxlYXN0IG1ha2UgaXQNCg0Kc3Rh
dGljIHZvaWQgaW9sYXRlbmN5X3NldF9taW5fbGF0X25zZWMoc3RydWN0IGJsa2NnX2dxICpibGtn
LCB1NjQgdmFsKQ0Kew0KCXN0cnVjdCBpb2xhdGVuY3lfZ3JwICppb2xhdCA9IGJsa2dfdG9fbGF0
KGJsa2cpOw0KCXN0cnVjdCBibGtfaW9sYXRlbmN5ICpibGtpb2xhdDsNCgl1NjQgb2xkdmFsOw0K
DQoJaWYgKCFpb2xhdCkNCgkJcmV0dXJuOw0KDQoJYmxraW9sYXQgPSBpb2xhdC0+YmxraW9sYXQ7
DQoJb2xkdmFsID0gaW9sYXQtPm1pbl9sYXRfbnNlYzsNCg0KDQoNCj4gQEAgLTEwMTMsNiArMTAx
NSw4IEBAIHN0YXRpYyB2b2lkIGlvbGF0ZW5jeV9wZF9pbml0KHN0cnVjdCBibGtnX3BvbGljeV9k
YXRhICpwZCkNCj4gICAJICovDQo+ICAgCWlmIChibGtnLT5wYXJlbnQgJiYgYmxrZ190b19wZChi
bGtnLT5wYXJlbnQsICZibGtjZ19wb2xpY3lfaW9sYXRlbmN5KSkgew0KPiAgIAkJc3RydWN0IGlv
bGF0ZW5jeV9ncnAgKnBhcmVudCA9IGJsa2dfdG9fbGF0KGJsa2ctPnBhcmVudCk7DQo+ICsJCWlm
ICghcGFyZW50KQ0KPiArCQkJcmV0dXJuOw0KPiAgIAkJYXRvbWljX3NldCgmaW9sYXQtPnNjYWxl
X2Nvb2tpZSwNCj4gICAJCQkgICBhdG9taWNfcmVhZCgmcGFyZW50LT5jaGlsZF9sYXQuc2NhbGVf
Y29va2llKSk7DQo+ICAgCX0gZWxzZSB7DQoNCg==

