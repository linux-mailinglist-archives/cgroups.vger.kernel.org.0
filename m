Return-Path: <cgroups+bounces-6461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F21DA2C525
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 15:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E87A3587
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0B221D8F;
	Fri,  7 Feb 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKkny1iQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FE1624D0
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938288; cv=fail; b=sWXC+JrpgI9xQM55cnyUBRGgfB6CKspLiaV+4xF+zurkOAXMKCzA5e+JX3eNeF56hm9Qry8uiGo79w29vVfQeO8FisNwvkxWo22+tlL124O2wNunNoLFMk1zzBVPirfZ05DaNY6g2JLXk4D0BwLsHonHt5IHhjuJeruG0ji4DAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938288; c=relaxed/simple;
	bh=CcB5GMbTPHFrX5NAUK4lEqUVfSaaL22avEcZHoxz/tM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQCD4ssJBrn8dMsFdVK51TQly218c3SMUr5IT/irJgEvE/AjelIP6rlaN/lOwcZz/gE982jE6DXhB5a2oS7zmLScxAjqusVMqicBgC4uy0Pw0bZgya5m8uMiMNq4BQo7EYuK0bMuZMUBM/RMYBE0YVjgYjHIs8MzcGBC+ewy2dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKkny1iQ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DJ1M4027689;
	Fri, 7 Feb 2025 14:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CcB5GM
	bTPHFrX5NAUK4lEqUVfSaaL22avEcZHoxz/tM=; b=aKkny1iQIdlt7pSV09XXTR
	/McHJj1xcElc2BEV1b/Lf1ds2AvAl6mWAphLLALMlNkpqqbmE/PbVDoIivHZ5CtS
	Z9RGn6C2wGeigte90LUaOegxLKUTaVMIR+1JCTa2Z/q/2IoxzWBV70cJXqB0PdmV
	+5ORrPeMRhXp5hsUqYuGg1Z+z0Gj4+SwuQMxKXzlMRhuGyKFkadeyxP3nAkQOCaO
	A0P3FNtOtRJkqBHLuAdnLpum9e87qYL5tEYvTE7XCACgTxnOF3FmXuQF8sEFTR8v
	dDRvHow0zpVV6YNSpXf+hqTBkQkjRl5TYpP5FpJ+fmVBe4xmP0GEw9F1IzfU6h1Q
	==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910b446-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 14:24:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOKr8jva5GQP18HzsnoHcqy8XvLYujCxoY161hoQnYtlP3bwCfmJ4xyWQ1X+QCve/rUb3Z+p2fOt86g8j7hJiMq5z+YVO7XHS6hStdbnoYQmVo9yWk7lr7Du/lbbkCPJ6FTuh2IKDENvOrDLcli0mJwu6WfiHAwQuGfC9zoN9982FFSwmgOclydmQp1S3hC4ySHX5Ui0CCkQBzKfqwP4zSf2j1plcOdGQpFD2/56azx68ziAYRf84sff9IS5WOphHqizBHuCBw1DOY6vJWQNwqbt3+irombjinto9MP6pDlYolQreeFqKdaeeCi+gEmc52vi4hpCt4IbEQxq8tZKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcB5GMbTPHFrX5NAUK4lEqUVfSaaL22avEcZHoxz/tM=;
 b=AHhQEvfO4tIgJ42kztWy0z4xUD5Baca+wotaXpdRjoSDEtofkkQ1rxrfqBuctSYK4R/qcKlWMPgAz/CpkTfUrTnM53hFah13BMeeg6YOmrRC+BOPLYMu8tCkdyagFHDc9F9SmfRRKjVlpzVHqvDqenw+AgfiCPlMOS5jNY3n/BsHjKh/RFUwjVQtxjcMI1Dr5JBCfrj/r0mkvLdgJCHlvRquq5KQlZEqLvdjLeAw1NtzfRWv4xRs6K0FVxC0V7Ov4yyNN1bLJmdxdJ9cHFuA15duD1waLJfYkqfnX1WVwcsb1TiKrnISfn88iq3kdfNVQvZJ+fMdxwgxeNQK2duKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from CH3PR15MB6047.namprd15.prod.outlook.com (2603:10b6:610:162::5)
 by PH0PR15MB4544.namprd15.prod.outlook.com (2603:10b6:510:89::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Fri, 7 Feb
 2025 14:24:33 +0000
Received: from CH3PR15MB6047.namprd15.prod.outlook.com
 ([fe80::5f69:515f:3a6:4f06]) by CH3PR15MB6047.namprd15.prod.outlook.com
 ([fe80::5f69:515f:3a6:4f06%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:24:32 +0000
From: Muhammad Adeel <Muhammad.Adeel@ibm.com>
To: =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "tj@kernel.org"
	<tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Axel Busch
	<Axel.Busch@ibm.com>, Boris Burkov <boris@bur.io>
Subject: [PATCH v2] cgroups:  Remove steal time from usage_usec
Thread-Topic: [PATCH v2] cgroups:  Remove steal time from usage_usec
Thread-Index: AQHbeWwBFOxkRg/It0qm4xwLCOiFRw==
Date: Fri, 7 Feb 2025 14:24:32 +0000
Message-ID:
 <CH3PR15MB6047F418ABF4B97ABE64B9A080F12@CH3PR15MB6047.namprd15.prod.outlook.com>
References:
 <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>
 <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
In-Reply-To: <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR15MB6047:EE_|PH0PR15MB4544:EE_
x-ms-office365-filtering-correlation-id: 5a496dce-0da3-4abd-f094-08dd4783241a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkZGS2k4ZnU1bDNjb25GYys0bjBVREhpUmFwUkpnaER3TTVHSDBCNGdPMHZK?=
 =?utf-8?B?Rk9jV0JucUgvd2s4RElUSG02MmYvZHg4dzlRUUpjNE43VXVzN2J6dlJXVkRy?=
 =?utf-8?B?ZW5WeUNKV3RCbXdjN0xoN3FBaWtYUDFsUVY2aUNqWHRsaVdrWTczRmhLS1B3?=
 =?utf-8?B?ZlhJR2lUdytVTUppQ1Y0M0RCMHJYWDZOY2xRU0g3ZWRLdFZUZWJpSHpoazlz?=
 =?utf-8?B?K3l6am94R2RyU05pZkxHSG00ODRaWFpYekR6Z3Y4eER4S3pFYi9Ld3BEcjNi?=
 =?utf-8?B?c0ZVNHZoVUdGSUVydFNYVkJGbkNRNTlNM05NYjNrSDkyTDZMUVN2MklHNG1h?=
 =?utf-8?B?emVhbHErOVVubTBEVXFGc1cycHFKcmJhemtxOVZhdytJOXRIVVljVXN3aHdt?=
 =?utf-8?B?SkYzK0JuZm9rU3hZWUNFSVM1NGt2ZW5uVkZuQjFqN09nUlhCTnQrZmRJRlZ1?=
 =?utf-8?B?ajNjZUNpRWhHZEdsY2tzVEdub2dHZHp1cXQ0dzhuWFZQQjJOa1RiZ21iWTg3?=
 =?utf-8?B?L1djY2d2allXL1gwR2lBS2pSTVRvUTROU29WZUoxRHZqZzU5eVZkNEVKcjU5?=
 =?utf-8?B?aXFiQkRETHhPVnk0R3Jza1Fhc0YzdFFrbk8wTzlQRFVVQzdCYTFJN1ZDa3Qy?=
 =?utf-8?B?M256TzFEZ1BVa1R5YzdIcUQyNmh2UlREM21RdTJ1dERtb1ZRTFhJQWliZVFy?=
 =?utf-8?B?WnJ2cVQ2RkhxajNoWTcwdCtxTzE0OE9hSTAzcjIrVjJKRmRSeHR5Rit1SW05?=
 =?utf-8?B?MG5aa1N2U25rejl6WVZJRGR4YVJZVCs2ZHFCQ3FuT1pMTTF2VzJuR1NBeTQ0?=
 =?utf-8?B?d1paY3huMllGc0lkUUxuOGxDbnBpSUF5ZkpCODV4TE1seStvWHNia0pNNGRP?=
 =?utf-8?B?MUNQUFhJTmdrNThJblgvVHgwU2xHc290WUpXaHpSUUlGMlpTUGdEbjFEUUJL?=
 =?utf-8?B?ZEN2TUdRM1d1Y2lORGdkTFVzVkxxWlpCL3dQQzd1ZzVmUHBCYi9jdFAxUmRS?=
 =?utf-8?B?RFRkTlhnU1c3d2xNN0pnSzdCS0w0eUtxNS8xYzBWN3UwcGY3Mld3d0xaQjdK?=
 =?utf-8?B?QkZhVWhkcmJidVoxcGJhanNlS2hja0VtNmFDSG4vcS9WelhkRWY0bFNNdWhD?=
 =?utf-8?B?czRTZGQ2eUo5MUJKTmdHbHNpMGJuY25LNmRZQllmbnBQMmpkcFloTFAySEJk?=
 =?utf-8?B?cklMTHVpVlorbEI0TjZuZmc3czdXR0kyeGx5ejdNT01SZlRSSlE2Smw1dlJN?=
 =?utf-8?B?dmhycVFyeldZbEYzZVJvVjV5blZZTkUzczhHSGdtL0FUVmNEVVJsUXE5SEEv?=
 =?utf-8?B?NSt4WENoVzN0ckJJa0xrYVlIRDNHdTdGd0VPU2ZrSW5hQ3YyNzN1QVNNbVd2?=
 =?utf-8?B?bjRtQkpVdVcrdlBLa3BHUUJDVU4yM1Y2dytnN1cyWGVTakYwSXcxT1BiYzhm?=
 =?utf-8?B?Q0w5RDhETjdKbEROSFhOYXpTdzFDa3EwTlJMYkozN1Fzdk5yYkM4QWJNcjlK?=
 =?utf-8?B?Y3o1ZXIxVS9SSDQ0dDlBckxOS2RlTUpYNENkM2c2NnNjY2FvSkU5U0lWRU9o?=
 =?utf-8?B?bXNKa3VGbWJPTU1WYnlxNnlNWmp5R1BtbHZrcUpaazlUcnVhNWhERnFFNDlz?=
 =?utf-8?B?TklrcmhLaXF2Vkl5bWl3a1I1bG1QTnFwMEtKNmdmS29VS1FlL054UDdnU3hK?=
 =?utf-8?B?NTdkMjBUNjZ4a0xFOGVjWXMwUVFnby9xanVmKzFtZHJ4RGhMWFAwbk11UkhV?=
 =?utf-8?B?T1h5bzlJSDA4Qy9DWlNDbmVLYWlJMXFnbWJpbGJ1Ri9hWFhDSnVwaXBnYjNE?=
 =?utf-8?B?S0FpRWsraU1DK1NrZWVteXRkRUpkUzF6K01MSnM5aWpOd1ZsMjhWVnZoWmVq?=
 =?utf-8?B?aVNPSThEYUpzQXhIMC8wSW1MWmFFM0xpOTR3VVRLb0JqeWhSZHAxVVFOY045?=
 =?utf-8?Q?oQKKfjfg12RoIOvOyjWJkzqDmAt52iu3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR15MB6047.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Skp5RDlLbE9TdzhCSHRSUG56elZDanVoUmNHck1LUVlJNWRGeEVCYUxWbVov?=
 =?utf-8?B?RmVHaHRoc3VFenJBWlluZDVLQ3JkUWtlNk11ampvVFN1c2g0bElpRTV2YTd0?=
 =?utf-8?B?UExOYUxDTzZsZkQrbjJSWmViSmpxNHRMaHJSMlo3NWttQmM0ekNqaHBmMXBX?=
 =?utf-8?B?MkkwbGVpTzJMSWVvVDJGa0xlTloyRTZIWGwxRGZ0dDlYRmhaMXRtZXNUQytR?=
 =?utf-8?B?NmZHZU51L204Z0MwQ0VkaXJlUzBBMC96aU0zUUdrZWxpMXlCUDZaWnFidUsy?=
 =?utf-8?B?ZnJiZU9kWE5sem01TzRtSmtkcExMWE4wZ3E3U1hoTWdHeG9aakRzSGV6Wit4?=
 =?utf-8?B?OG5HRmZBcmJLSDJSQjF3R0tuZ0tZaUZVelJtSjExMUpUNlFmRFg4SjJqM0Z4?=
 =?utf-8?B?cFNBZVF0SFNYWVFqU3BvSXdmVkdIanBFTGRMNThyNElabC9PVGF3dzQ5U2g5?=
 =?utf-8?B?WmdaUVUyS0l4d2VITC9WelZGZmdHOFFObHg0MnNxdVZqTUhVeWIwM3YrTG8v?=
 =?utf-8?B?VTZTUDBmSFR5TWduVXFzU0c1dVd3eFU2OWhMTFB5SVlkZVVyRHJhNndNUk4x?=
 =?utf-8?B?L0VuWUpkbWNBUmhpR3VsK0JqaFp4RmVQb0M0cnRKcjM0MXJEZjdKUDVCaGJX?=
 =?utf-8?B?SkJ4VE5WNHkvUGNGd3JodDA2NkNaa0M4Qndnb1FwcCtIVitySjRKamNiTUVW?=
 =?utf-8?B?VWZNUlk1NTN4L0ZSRVhXQkxDczJOZEh4TkF2U0k3anZ5Q0laWTdteXQ2dFdL?=
 =?utf-8?B?NTVSZEdrRnRjamIrNWoxRi81SDV4TTJ3UFZXTEkrSE1ZNjBQRWtwK1hIRlBr?=
 =?utf-8?B?eHZsN1BqcnRtTU1mRE5TRllOM2NGT2dsUEJxY25BVmQ4VmZWTmIybFFtVG15?=
 =?utf-8?B?cEpKKzRBN1pzOWltT2JlNldtZFJtdGNxM0FxWHNrN1Jlb1FnVlpEOGVwSmtQ?=
 =?utf-8?B?MWhHRFJRNkJuZE11dEFKSkJCSURsODZPV05hWmQyKzdoalR1YVZQdzkyRGFO?=
 =?utf-8?B?TzlmNDk0RnJMcitjLzBKTFJvRTBoWm9wcXlCUXZmVlduSy9CRmdYc1FmQUF3?=
 =?utf-8?B?UkVMeUpxeW1keDlCUy9hdjBRU2ttWUhibXMzbEFzVHpSOVNMNlE5Z0JjN0h1?=
 =?utf-8?B?K2pFOTdtZnhlSjlhdkZjRWtuMHhoWDhIdWZERG5iTGFLeTUwZElqYjhtd0dK?=
 =?utf-8?B?VkEzb0tPU3h3RUxQUGJ4amRvRkRiaHVzQVhyWFZ1MHJDUU9hUktIT2ltYk93?=
 =?utf-8?B?RnQ2WkhuQnJyYXFQRXdSeHdJREhzMnNWSlU4OXlPNzA0VE52YXE1UklVcFpF?=
 =?utf-8?B?VWw0cDIxaGxRZTRtdHVEQmZMeGtMaDBZOWFBTjZNUkhpNWtyUmVZRkg3azVJ?=
 =?utf-8?B?WmtxekRmeUkrNVcrQWJGc254L2pzUWtFNWl4ZkVmKzBkK0tQUHQ4SmE5OFlh?=
 =?utf-8?B?bGFndVRYSVdKOS82LzQzeDlIRnd6NWpDaEpWVWNKZmdFVXMzWnM0T21DMWhu?=
 =?utf-8?B?VW5RUTJVWHVWSi84a3ZaeXAzcytWcFV0NXJaWjluRkRJMHpwWmtudW44WFZ2?=
 =?utf-8?B?OWNtVEttMkt0eW5qTTNhU3NyVXdVZ2IyQldYSjRyMUdtanYwK1hnSHE2TUZB?=
 =?utf-8?B?U3RtdnFvNk5pdEVXSWI5V0xra3FHc2lPcjU4RTdlbGpLY1l0eGpuUFk4cVVr?=
 =?utf-8?B?Y3A5OVE4SVc0UUZocXcybTAvUllkREk5MnA4MGNaNExXcEJVdFE4UWZZZWU3?=
 =?utf-8?B?SXB1UkpNVVU4MzVGYnlVVzc4b09aQTUrYWVvY0dFb3BTaUpKM2JROWdDWEYx?=
 =?utf-8?B?YlJmbVJwN2FpU3BBdVY2clRKZU95QkFFcWdGMDVvSllwQ2pxYVRVM2l1bm9i?=
 =?utf-8?B?WnBXM2ZpZ2QvYkFPNDUxZGlpd05VZS9iZHMwVVVUYXRwWTJoaXo2dHVsSFg3?=
 =?utf-8?B?dmc1NkNHTlByZ1NUNFlkb05iejVqallScUtTTGordUtQUXVvTzZkQ0JuaXh2?=
 =?utf-8?B?VnJPclhBR24zMWx5UmVVRWFWT1JFVXJjK0hJVngvTTdxWTJWZHFHZVBmNSt1?=
 =?utf-8?B?MXp5a3pEa3pmQWZ3U2U4WjJrSHJIOUV0cU9LRTZ0VnM0WlptNnJOeWNSNG9U?=
 =?utf-8?B?ZFVzd2p5K3JScHk0WU9FeGtuTVJJK0RBY0ErUVNOVjVjNElrb1AvRXJHU0FC?=
 =?utf-8?Q?B2lsmbiHpzahBMdVoLeHx2A4aJk9XHG7ztKa0IMC2xB7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a496dce-0da3-4abd-f094-08dd4783241a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 14:24:32.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SK0UDhJTJ8I8uWwzT7K3kPuQWXtV0usVeXvmE0aeRymjVyxJlvRuVo10p8gtFabth5N3EshGaPe8C2pBpspag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4544
X-Proofpoint-ORIG-GUID: mmWtAEKdHLbYrclex-VBl15DSOVEj45U
X-Proofpoint-GUID: mmWtAEKdHLbYrclex-VBl15DSOVEj45U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070107

VGhlIENQVSB1c2FnZSB0aW1lIGlzIHRoZSB0aW1lIHdoZW4gdXNlciwgc3lzdGVtIG9yIGJvdGgg
YXJlIHVzaW5nIHRoZSBDUFUuIA0KU3RlYWwgdGltZSBpcyB0aGUgdGltZSB3aGVuIENQVSBpcyB3
YWl0aW5nIHRvIGJlIHJ1biBieSB0aGUgSHlwZXJ2aXNvci4gSXQgc2hvdWxkIG5vdCBiZSBhZGRl
ZCB0byB0aGUgQ1BVIHVzYWdlIHRpbWUsIGhlbmNlIHJlbW92aW5nIGl0IGZyb20gdGhlIHVzYWdl
X3VzZWMgZW50cnkuIA0KDQpGaXhlczogOTM2ZjJhNzBmMjA3NyAoImNncm91cDogYWRkIGNwdS5z
dGF0IGZpbGUgdG8gcm9vdCBjZ3JvdXAiKQ0KQWNrZWQtYnk6IEF4ZWwgQnVzY2ggPGF4ZWwuYnVz
Y2hAaWJtLmNvbT4NClNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIEFkZWVsIDxtdWhhbW1hZC5hZGVl
bEBpYm0uY29tPg0KLS0tDQoga2VybmVsL2Nncm91cC9yc3RhdC5jIHwgMSAtDQogMSBmaWxlIGNo
YW5nZWQsIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9jZ3JvdXAvcnN0YXQu
YyBiL2tlcm5lbC9jZ3JvdXAvcnN0YXQuYyBpbmRleCA1ODc3OTc0ZWNlOTIuLmFhYzkxNDY2Mjc5
ZiAxMDA2NDQNCi0tLSBhL2tlcm5lbC9jZ3JvdXAvcnN0YXQuYw0KKysrIGIva2VybmVsL2Nncm91
cC9yc3RhdC5jDQpAQCAtNTkwLDcgKzU5MCw2IEBAIHN0YXRpYyB2b2lkIHJvb3RfY2dyb3VwX2Nw
dXRpbWUoc3RydWN0IGNncm91cF9iYXNlX3N0YXQgKmJzdGF0KQ0KDQogICAgICAgICAgICAgICAg
Y3B1dGltZS0+c3VtX2V4ZWNfcnVudGltZSArPSB1c2VyOw0KICAgICAgICAgICAgICAgIGNwdXRp
bWUtPnN1bV9leGVjX3J1bnRpbWUgKz0gc3lzOw0KLSAgICAgICAgICAgICAgIGNwdXRpbWUtPnN1
bV9leGVjX3J1bnRpbWUgKz0gY3B1c3RhdFtDUFVUSU1FX1NURUFMXTsNCg0KICNpZmRlZiBDT05G
SUdfU0NIRURfQ09SRQ0KICAgICAgICAgICAgICAgIGJzdGF0LT5mb3JjZWlkbGVfc3VtICs9IGNw
dXN0YXRbQ1BVVElNRV9GT1JDRUlETEVdOw0KLS0NCg0K

