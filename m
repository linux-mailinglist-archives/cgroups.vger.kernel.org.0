Return-Path: <cgroups+bounces-7750-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B949A9947A
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 18:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AE91BA3290
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02A283684;
	Wed, 23 Apr 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfac9kwx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JSaYhMKf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4E1A08A4;
	Wed, 23 Apr 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424401; cv=fail; b=avxsHlG1WJVcIKPwPZpkIl4XhSDgnooF7CwRZlSjNy7oICWsnHRmH0R8SLUYW5PsjNhbPam6Iav/ALZLa0Im5wCYaSkdP+y262/FWZv7T7wxFMo6Gg3nQGvzOY/z7nY/g7OeOPClEbAm7BTteTS2Gq0/RofUe7Xl+GkTPth+5Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424401; c=relaxed/simple;
	bh=JiM7S0rpiF9Qb3P1CqX/u4aGEnY/OdGLIYyWcdUcZPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhjuVGZ4W6OpKA2BvEYb5MCtU4vjVEeQ8uttIY31v1Z2OExgbJqVPTAgFOeWozWCwy1QdXTMbcJuRFyCkZAryXjn3OvgYYgUl4dC2zdSjyi5ofjrq6zyU12XLH9ega15opiIzjBOkC+B9K2THhL0+X7sajNuC16uXSHzvlHf0XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bfac9kwx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JSaYhMKf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEg2uZ013203;
	Wed, 23 Apr 2025 16:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JiM7S0rpiF9Qb3P1CqX/u4aGEnY/OdGLIYyWcdUcZPc=; b=
	bfac9kwxhciKOtngd4Wpyfxkk18Oibp/iIvX5pc9EsW4NI8yd9DLn1NTKIXbg4xM
	680kSonBsn8Vlc92z33so/oN3L6O7HKOQFFh7wCkaw5mVGtbublUjN5QMLSrcwku
	q9q9CceeKP8VaK6h+WepjHK7RgF6ORvunUM1NmsgfCG1togm836LE/4N2GbNm3yc
	4LIbug1u0wZ/dHfVOEBBiuJYkVY/u9KUXYXz10RcrLU/zhjFmv6VbN69k0nD4cB0
	AXfipn8I+hYaW+ZjOlwiF2Ir4zysQFRDkF1LK3qrR0p4MKGPH58Zn/TAhlhwsCpD
	4D1NW1g7p2wm4tnCYh/0EQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jkjhm5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 16:05:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NF46YX028516;
	Wed, 23 Apr 2025 16:05:47 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6afa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 16:05:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMSYpW7zyi7/ef8TTMzyF1WIbLieESxI5jVfEMGDtYSFDMea3xFWzfKroIn5DyFznRSOYMHzWhwdpj0KXxWtS+c3N7KasKQupV+vo9Zq2mud3n+POI0XjCwWbbkPczhaixJEu8YZCiL0zI4fLXdadAyXqv3ANoxCAVNFKSfFW1GS5ZC+8C1m37qVs0tTE41EEtw3zUm+du2LqfSKG8HVDHENCTEZhimH/Enay1tf7PCYVxPNvIH2ySTa/yG0OQvcIBgWQ41YUKdXzj4QoJpP+oeNQ5iiF0EYFGpaFL7ye0msz3Vzp+iK8X3Zeupt86jjNWe/2jMtx7lwiazpCBQQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiM7S0rpiF9Qb3P1CqX/u4aGEnY/OdGLIYyWcdUcZPc=;
 b=TNyZE7R+ec973QKejr5DwhucOUCXEu1ymfrmnn0qKSCpAePjZ4f97kP77IziTF0Xfiv/ibSogcUDgSgNVdgORnLFfOEGqg8STsT1XOVTQTNTM4z9S0DjL65gnFglMioAIh6nWN805LsznhJz4g08Sa9Xv5UWBODEp+dWQKg8edakLzCl8Uy7rAb2n6l8dUMtKIdg81NtMb8MFxZp1SylbdHx4m2vrRXoI2X9pF8Gf9HHPhUoeeKzBXlOqVtfjn3mhWN/TwoCwjU5hymHAqhu1BgbEJobY+vizHwzwNqezos/DCUfXV0T2zAC3AuxJQDVub2UHE4FyTTVy5ImSEcWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiM7S0rpiF9Qb3P1CqX/u4aGEnY/OdGLIYyWcdUcZPc=;
 b=JSaYhMKfgSAt/wjWNYPCyUR5BKdDJ3059L5sX+b2t45QVZDyskeysgW1Giswsg8MvxbuxXSex0U0X+To9s76N0GiOJO3MWLVpOs973ygKA/EeUGJpwizHY0x6WDF4TvMXzUCrgE2w8jB7oYwrOL9CdZFLYV6beKm4+djhXvG3t8=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 16:05:44 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 16:05:44 +0000
From: Libo Chen <libo.chen@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "peterz@infradead.org" <peterz@infradead.org>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "llong@redhat.com"
	<llong@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "yu.c.chen@intel.com"
	<yu.c.chen@intel.com>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>,
        Chris Hyser
	<chris.hyser@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        Dhaval Giani <Dhaval.Giani@amd.com>,
        "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Thread-Topic: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Thread-Index: AQHbr80+uV+2NEya/km11I7Mcyg80bOxavCAgAAIi4A=
Date: Wed, 23 Apr 2025 16:05:44 +0000
Message-ID: <104BC9F8-AECA-470D-9A9D-C4AFA3D4184C@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417191543.1781862-3-libo.chen@oracle.com>
 <20250423113459.0e53be50@gandalf.local.home>
In-Reply-To: <20250423113459.0e53be50@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR10MB5749:EE_|CYYPR10MB7652:EE_
x-ms-office365-filtering-correlation-id: 829764e2-f739-40f7-f55c-08dd8280b435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RURZK1c3RjFZR1hPMkgrRHkvK3ZLSG9tSkRzaittaTVpeVBadzJaeHNWSGhu?=
 =?utf-8?B?Y1VMbU1VTDRCK1BadlNFYTZLaWhjU3Fqb2ptckRSYkNLYklUaXgzMkpNak41?=
 =?utf-8?B?bEh4MUJpcTQrR2l6QTNQclJWcmozN3Z0aGhLR0pleHRmbnMxTlNoSjFrd2x2?=
 =?utf-8?B?ejhJNjRSOU9BY2JWemVTQW1wOGUwMkpGMGhnWDc5dXFTL0RpS3dqcEpGRWFy?=
 =?utf-8?B?ZnNLQUNuV2JlWmpLbm5zTi9TQmxGbnM1NVNQU1pQTlAwUEh4MTlDb1h4eDJY?=
 =?utf-8?B?ejQya0dOM1o3M1V3ZFNyNDZBMlplZzdFdGpJamsrd1dUa2VMRHBSMmx1M25N?=
 =?utf-8?B?Nk4vTmovVUZBRlNtREJQNndMd1pKYVRMcHh4TEpSdmZSeUFoUFZhZXBCSmQ3?=
 =?utf-8?B?YTFsbi9EaTVVSnVWQjJVdjFyQUs4Qkk2ZUQzVjVFbWpnSW92UG9hT0VtTlhZ?=
 =?utf-8?B?bmdXQWhlWjJIMWJaODR6TEJwSHJVS0IvTXltazBVS090SWhqY0pTTS9qbjVF?=
 =?utf-8?B?MXJhbC9hNlR0YzA2d1lYTTRpVjB2RWg3Q3JjQ3I1c1BROE5nVEMvcFdjZTB4?=
 =?utf-8?B?ZHpDbk9OTWozQkx0d29PcXFYeUF0V1pSR1phS2ExWHk3bENmbnlaRjFMZEJZ?=
 =?utf-8?B?b3ljb01PY1JVckRqcE9HejBXaWl3ZGdoeHVzLzhBbngyWUEyVFhJV2NnWFV0?=
 =?utf-8?B?bi9EV3JmeWs3Z1orUkM5OExncjRMeFZRWVZOLzBwdkwrSzhEQWhmRGZycFM3?=
 =?utf-8?B?ZjVtTjhFS1F5MFBESWQ2L2UxcnRwMGUzZDFpZDZxL0ZBV05mSzhZc2VpdmdQ?=
 =?utf-8?B?cCtSRWkrQ3ZBcWxQcHBac0pZQXJlNHd0NlFDckcycGFUK2podGgvcXVab05F?=
 =?utf-8?B?THhtRGxWb1dGb09rS1pVSjFXUTdPTnNrZmI0eWoyb096YVJTMzhCN1ZQV3kz?=
 =?utf-8?B?elU4djVodnR2cHBPU2lrZ2xyVFdub0FmUnhSK082aHBOR2kzeXNqWnRCaEJJ?=
 =?utf-8?B?Q2UwTWFzN3FPTER1Y3ZNMWRVaEk5UC9yR1lOTTUweTdJTFEzNmpwaXdLZzM0?=
 =?utf-8?B?YkhRK2Z2bGE4ckFUa2ZWRW1DbXFjeEx4WVpqcHo0dTQ5WDdMQXYycWpOVk1K?=
 =?utf-8?B?Y29MN3hEMFFNcWpDVm0vdjRXMnhaTDR5ZSt6cWFXQ0hDS3h2VWxzZVNrUVJZ?=
 =?utf-8?B?TUdOTVVlV0xFbVhoTmFVdXduU1ZKSzN2Rks3dHZSZ1ZWN2pDNDRMMmNwaVVt?=
 =?utf-8?B?S2FPMkwyRFFaaTVONXR4Zm82c1pXZTFtNUVsQXVrRUhtL0hzazd3ZXo0cEhp?=
 =?utf-8?B?ZUpWOTZrdThDNXNWSGp6RlJETm03TXhrUXVjSzk2Uk1yNFdWaXlFQkZYRmly?=
 =?utf-8?B?d05Kdm5jR0RHbHB3UGdNMWFqbjlKb0FUTDZaQ09UTFpVcTJ5cWNQZHZyOEdn?=
 =?utf-8?B?TGp3Y2JwUll4Vmh6ckg5QTRYMmExUHlJdmtjLzh2QU4rZWdCbWxqK0dJRmJx?=
 =?utf-8?B?YVppOG5VeXRMbDV4UVQ2cHdXVTllK0owK0tUOXNlNmp1dEVqbVE3WTE3bHh0?=
 =?utf-8?B?cXAxak5GZGhxMk4yOWJLd2Z1Vm9xandEK2RUbnRBMS9Icy9DNXpveTZ4SDlN?=
 =?utf-8?B?azVpS1FxVDNneDM5OE0vb3hhTHNFdlIvNVlPVnJPV2djejZaNkpGYzgzK0py?=
 =?utf-8?B?TTFYUFM5REdNay9GQm12cFFmSWNpemUyMHdhMzg1RXNrcDZCRjJ6L01MYyta?=
 =?utf-8?B?M0NlN21RTENLeXlKOUhKVFEwUlVZa1Q3QVZpS3ViWnNqS0wzYmNJMjNQVTZH?=
 =?utf-8?B?ZU5xaUV1V0VOZE1qVFpwYWE4aDRQMGZXWkJDekxibHNRb21pc3JaSzcrQTJN?=
 =?utf-8?B?VHJ4RDJaUHNWM0JSNXQ1V05laHdrT0F3MmdtUmREa00vRGVoV1oyR0VqeFph?=
 =?utf-8?B?VVkvN0VnUlZIUGdIS2QzZUEzWjRRQmloQXB6RGtPS1hpUnBKbUFFNkxvSlhB?=
 =?utf-8?B?dGNScG1zRkhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MC9ZYS8xR0s4RzhsL2x1L25TaFJFRU9uaXNVZkZhWkF0NTJDS2ZpM2xGRmw2?=
 =?utf-8?B?cU5FTkhhV2tTNUJMaWFEWDdzeVVNZFFIMWJ4bTNMWTNzUHlUYVFYV2F2dDFo?=
 =?utf-8?B?dC9SU2Nsd1JhaUVIMUowUzMwS29NcHpaKzNQM0xlQ0VBR1RrZ013eFVEZG13?=
 =?utf-8?B?OHhEYnUweVcvKzd5NDhDWjIxMHNJVzBSbzlKTCt4SjNXYU9Bb1UwaWRuMmEw?=
 =?utf-8?B?dFpLT1d1TFFqU0xYcmNvcFBNcmk4UnN5Z3ozbFdFRnhjbXM2Vkt0cWtYN1Nv?=
 =?utf-8?B?SHJjQlgxSDBMVzByamxEak5xMUFIOHNYanZXRy80c0xsQm1tbkl6NTgxM3VP?=
 =?utf-8?B?eHZVSU5JY1NROUQzWTVmMlpEODRRd1dFUDVjeEpZckpLd0Jwb3VNVlhVVFVX?=
 =?utf-8?B?TFFBdDhHNlVlSm8rZEpuaFZoRnQwczJ4S25vaXgrWWVyQURFaks5N0FNbUk0?=
 =?utf-8?B?aktDMVQ5RVBxWmdsbUNMclRiZ1p5QXF3cDZZMEFJa1dvMSt1UC82MmdpS09y?=
 =?utf-8?B?K01aaitmMEF3NVFDeWRPVW5rcVVBdkJhcWVUb284enh1bjcxaUFHVFhXeVQw?=
 =?utf-8?B?dHUvZ05iK1NEQVpyWVllN3NFV1JVcW9neGNIWDBwMVpTOXl1by91dGV6Vmh4?=
 =?utf-8?B?T24xYWVhY254WnV6MGtRdHd0MnVrQ2FYbThUVXBnQkgxRk9rOVN0MWhQK0Zv?=
 =?utf-8?B?WStQbmFIM3VzRlFjVVpKL0VnZ1MzUHBwbENCWVJoVkVnRnRWSmUyMjdCYnd0?=
 =?utf-8?B?aFJCd0N4YnpyY2hhZFBUQWw1SzF2ZUt2VTJ4bGhvVU9INnFBZStsNElEVnhp?=
 =?utf-8?B?RlVnNlhYeFlwS3hyRi91cmtLdHJ1dXBHV2F6QTVaQmlYbzNGOGszdCs2K1lW?=
 =?utf-8?B?d2hGR2phRjdNclRHKy9obUMzS3dTSnhYRU9iSXhoaURtM01xTzd5OHdVQXhZ?=
 =?utf-8?B?bUpUUUNSK3RhZVFsczN6cG03bEN6bFRtVllxVVJ5Skw5RzVsSGJlZTJXVGFn?=
 =?utf-8?B?SmtPQllLS1NaOFRTYWEyaldaOENNM0NMRlVNWktZVnJlTW1lQzJadTIrbGMv?=
 =?utf-8?B?d2xBSE9OVG9UK0ZjdTdvS1hvWHhTQnVWSHE0bnI5c1NNQmN4K2hUbGltUlZV?=
 =?utf-8?B?cXB1amQzVGRVWHcyNFNxN2pscHZrdnB2aFlFZFNudzBEZC9GVk1TRDgzVVlB?=
 =?utf-8?B?NmMrcWpLVWoycGVDZUJwRjlma1JRektQNTR3K3NuVnNHYnhRZnNPcy9KWDJs?=
 =?utf-8?B?bVZQcC9Kc1I1SG1jS0F0eE9UVkxzQ1BZdFR3ZXhieFRwcjA0MjJTVzJobENR?=
 =?utf-8?B?VGdqa0krT1lZaTZVWDdGTHQxU2dtT01NZzUrQytGaC9PWURnVW04WVg4NGZE?=
 =?utf-8?B?djJQYzZGQnc4T2ZSUVAvMGRRZ3IwT3lLMG0xMzFuRVJIOW94K1FNcHZCbm1W?=
 =?utf-8?B?dUd4RHF4U1NYNEpPZHlHWjFaK243UDVaNXErRkREaVR5MmFwMTdVeTlqc1NZ?=
 =?utf-8?B?ZmQ1cytSWHNBSXhpbzJzcGo4R0wxMXB4OUNtUmFBRXJCTmZyeWFaZmhjYzh0?=
 =?utf-8?B?T2s1MEEwbWt3RTV1RnhxeUMvbFc1ZGdBMXd3SkRYZElvQjlQSGljNnN5UUpO?=
 =?utf-8?B?WkN6R2tpS1kxc3NCem9VL0s0ZExZck9zTVBLY3REQW96WkpqTy9GeE9DUFBj?=
 =?utf-8?B?YXNQN1d1L2ljTDg5M0pmZFhHNEFsZTR4SnFsbnB3QnlpLytsSy9aNllFcVN1?=
 =?utf-8?B?dm9lRTJOcnpjK0QwRnhmdGlMMEpGcHVFZC9UaWswT1lhaG9TK3k2cmpFbzVH?=
 =?utf-8?B?d1pEL3A0YTBkMDR4NkF5d29sT29UYlZiajhOQmpIeHBiZDAzQU9SVHdXcmEz?=
 =?utf-8?B?U0hwdUhYRzhyV01YZ1pGaThsblJWeGNMK2Y0MHBMSTVobXd4UTFkbVVqMC9k?=
 =?utf-8?B?ODVoWm9YR0FkRjNUby9FV2tvc0FqTSt3bXo2Wnk3NElHR3V1bUtvWGhDNzJH?=
 =?utf-8?B?Q0YvMzU5NUlNWktYbVFaUVZpR1d4Y05sRE5lWkZNUXlqWHg4OFlZdkI1RnlU?=
 =?utf-8?B?T3hKUXlTaTJ5WUIvQ3NqdjlsMjNHcEtKbFkwMWI0S0xlbGxTM2w2MHRaSDc3?=
 =?utf-8?B?MWI5a2dxZi9LMmtlQnpBUyt4aFhwclFZdkp2WkF6TDRGMUtoOXFmWkN6aDlG?=
 =?utf-8?B?Y2dhNWZZWnlRR0NGdWRyY3pEdk0xY0VhVnkrT3B5bFJ5MUk5KzVkU2dTSER4?=
 =?utf-8?B?eWNoZm1XVVZQVC9NZFEzZE0wVTRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BDD1EDEFE11CB4786BB9FA350D54752@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qPWrG6uwI/c6vYD636fCxUAovtQjOjHw45Eus21n2K7kk/re1GxNIiPZQto6NzxyAgCAL+NW9GcsqbpLCRZZbuPumlyQdqXoXzsqfk00jWwjZ4uOtnEtmIGsrhz6wfInoRR5hxbP5s6M7HnxdYQAdggIp2d2XLPqJR1M7qw3f00TmnFx02IO3crGFgxx9bpNl3lWoz2QIYZHXCXAEcz4O6+dwnizNDaT2rdWKBdVyMCkWJFjvk+0CsqWahTyyfrUoFF7bDMyudBbKAz5XKtMxGh01Ffg4Z0KAs8U3PQrQTcWvz9uWyXlgUpI+GTSpMH0NfvA34mPhN7iD+oMrL2Ea4p8VmtgAbJxMMYoz9fI94mofKte3GnwSlCRMmwn+LTtJcrDCOkCfUPcBWz2CSbeZkbpRyO//uhichgtL/bQydhrDPPZMCy6SEahHA6DSIjKTy8IDki/cthAbUFrcRtkI/DTqH4teZTagL8sSIkdvntF8Go+fkgR5xOCHZBEcsSHeRScQL6/+iExydd89+EbIqPOKo0qkgh7IvKaPLzqBCnf0JHFUEu7MnOAtpNZl5QZKS7YPSZnY2gPVLX3l2wehRZTPFy+a2GTtEZpZGZt3hE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829764e2-f739-40f7-f55c-08dd8280b435
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 16:05:44.6783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mHAUruqSN10bT4zltS1jCfZSVX2t3ukHO5lUmN9OG0BLTsT/SGsRuH8H2sy9z212jyBKg06p7VEpIMwWQ9HFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_09,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230112
X-Proofpoint-GUID: rWIt03OGzMpz2MFE9XQj8Zed0LVC3eWW
X-Proofpoint-ORIG-GUID: rWIt03OGzMpz2MFE9XQj8Zed0LVC3eWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDExMiBTYWx0ZWRfXzlIIzwkPlfFR dWTXnKGlN/+ySmTqC1CE+c/73Qyi3446E5dp3O4Yud6YXzN+ibsNLCzJVzSYl0SMb1VVOgJbjUX BlD5/fOKsVyViN6O+Mk5vWkD6imE/5BVdOIG50pIOiJmeS3L6G8hTDHMpJy+KCaZo1oqwhDafWc
 QTi3x2F6DV6FzVbIU9HWEzIKOCSGXWm1ZY5PqCqe0Zy3EYqJdRYwekA3lEju1L9FHYSi6LM0L1h Z5++T7GaoumgEa/LxRXrYJwUnXcI+5Sl+8M7Ty22A312pqTMwhzhxv+ODCcS6GfrPzEPsOzD0N7 6qHbB8cNk7nBpfyY0Dp8bzb1I1GrCh7ec+RiNcpXKDBjU1VDs82BiDp5wDssuCA0uTRcVURp5Zx XzfV3ZGZ

DQoNCj4gT24gQXByIDIzLCAyMDI1LCBhdCA4OjM04oCvQU0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMTcgQXByIDIwMjUgMTI6MTU6
NDMgLTA3MDANCj4gTGlibyBDaGVuIDxsaWJvLmNoZW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0K
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3NjaGVkLmggYi9pbmNsdWRlL3Ry
YWNlL2V2ZW50cy9zY2hlZC5oDQo+PiBpbmRleCA4OTk0ZTk3ZDg2YzEzLi4yNWVlNTQyZmEwMDYz
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS90cmFjZS9ldmVudHMvc2NoZWQuaA0KPj4gKysrIGIv
aW5jbHVkZS90cmFjZS9ldmVudHMvc2NoZWQuaA0KPj4gQEAgLTc0NSw2ICs3NDUsMzYgQEAgVFJB
Q0VfRVZFTlQoc2NoZWRfc2tpcF92bWFfbnVtYSwNCj4+ICBfX2VudHJ5LT52bV9lbmQsDQo+PiAg
X19wcmludF9zeW1ib2xpYyhfX2VudHJ5LT5yZWFzb24sIE5VTUFCX1NLSVBfUkVBU09OKSkNCj4+
ICk7DQo+PiArDQo+PiArVFJBQ0VfRVZFTlQoc2NoZWRfc2tpcF9jcHVzZXRfbnVtYSwNCj4+ICsN
Cj4+ICsgVFBfUFJPVE8oc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIG5vZGVtYXNrX3QgKm1lbV9h
bGxvd2VkX3B0ciksDQo+PiArDQo+PiArIFRQX0FSR1ModHNrLCBtZW1fYWxsb3dlZF9wdHIpLA0K
Pj4gKw0KPj4gKyBUUF9TVFJVQ1RfX2VudHJ5KA0KPj4gKyBfX2FycmF5KCBjaGFyLCBjb21tLCBU
QVNLX0NPTU1fTEVOICkNCj4+ICsgX19maWVsZCggcGlkX3QsIHBpZCApDQo+PiArIF9fZmllbGQo
IHBpZF90LCB0Z2lkICkNCj4+ICsgX19maWVsZCggcGlkX3QsIG5naWQgKQ0KPj4gKyBfX2ZpZWxk
KCBub2RlbWFza190ICosIG1lbV9hbGxvd2VkX3B0ciApDQo+PiArICksDQo+PiArDQo+PiArIFRQ
X2Zhc3RfYXNzaWduKA0KPj4gKyBtZW1jcHkoX19lbnRyeS0+Y29tbSwgdHNrLT5jb21tLCBUQVNL
X0NPTU1fTEVOKTsNCj4+ICsgX19lbnRyeS0+cGlkID0gdGFza19waWRfbnIodHNrKTsNCj4+ICsg
X19lbnRyeS0+dGdpZCA9IHRhc2tfdGdpZF9ucih0c2spOw0KPj4gKyBfX2VudHJ5LT5uZ2lkID0g
dGFza19udW1hX2dyb3VwX2lkKHRzayk7DQo+PiArIF9fZW50cnktPm1lbV9hbGxvd2VkX3B0ciA9
IG1lbV9hbGxvd2VkX3B0cjsNCj4gDQo+IFRoaXMgaXMgYSBidWcuIFlvdSBjYW4ndCBzYXZlIHJh
bmRvbSBwb2ludGVycyBpbiB0aGUgVFBfZmFzdF9hc3NpZ24oKSBhbmQNCj4gcmVmZXJlbmNlIGl0
IGxhdGVyIGluIHRoZSBUUF9wcmludGsoKS4NCj4gDQoNCkFkbWl0dGVkbHkgSSB3YXMgYSBiaXQg
bmVydm91cyBhYm91dCBkZXJlZmVyZW5jaW5nIHRoaXMgcG9pbnRlciBhdCBUUF9wcmludGsoKQ0K
dGltZS4gV2lsbCBmaXggaXQhDQoNCkFsc28gd29uZGVyaW5nIGlmIHdlIGNhbiBmYWlsIHRoZSBi
dWlsZCBpbiB0aGlzIHNjZW5hcmlvIHNvIGl0IHdpbGwgYmUgZWFzaWVyIHRvDQpjYXRjaCB0aGlz
IGJ1ZyBhdCB0aGUgYnVpbGQgdGltZS4NCg0KVGhhbmtzDQpMaWJvDQogDQo+IFRoZSBUUF9mYXN0
X2Fzc2lnbigpIGlzIGV4ZWN1dGVkIGR1cmluZyB0aGUgbm9ybWFsIGtlcm5lbCB3b3JrZmxvdyB3
aGVuIHRoZQ0KPiB0cmFjZXBvaW50IGlzIHRyaWdnZXJlZC4gVGhlIHBvaW50ZXIgaXMgc2F2ZWQg
aW50byB0aGUgcmluZyBidWZmZXIuDQo+IA0KPj4gKyApLA0KPj4gKw0KPj4gKyBUUF9wcmludGso
ImNvbW09JXMgcGlkPSVkIHRnaWQ9JWQgbmdpZD0lZCBtZW1fbm9kZXNfYWxsb3dlZD0lKnBibCIs
DQo+PiArICBfX2VudHJ5LT5jb21tLA0KPj4gKyAgX19lbnRyeS0+cGlkLA0KPj4gKyAgX19lbnRy
eS0+dGdpZCwNCj4+ICsgIF9fZW50cnktPm5naWQsDQo+PiArICBub2RlbWFza19wcl9hcmdzKF9f
ZW50cnktPm1lbV9hbGxvd2VkX3B0cikpDQo+IA0KPiBUaGUgVFBfcHJpbnRrKCkgaXMgZXhlY3V0
ZWQgd2hlbiBhIHVzZXIgcmVhZHMgdGhlIC9zeXMva2VybmVsL3RyYWNpbmcvdHJhY2UNCj4gZmls
ZS4gV2hpY2ggY291bGQgYmUgbGl0ZXJhbGx5IG1vbnRocyBsYXRlci4NCj4gDQo+IFRoZSBub2Rl
bWFza19wcl9hcmdzKCkgd2lsbCBkZXJlZmVyZW5jZSB0aGUgX19lbnRyeS0+bWVtX2FsbG93ZWRf
cHRyIGZyb20NCj4gd2hhdCB3YXMgc2F2ZWQgaW4gdGhlIHJpbmcgYnVmZmVyLCB3aGljaCB0aGUg
Y29udGVudCBpdCBwb2ludHMgdG8gY291bGQNCj4gaGF2ZSBiZWVuIGZyZWVkIGRheXMgYWdvLg0K
PiANCj4gSWYgdGhhdCBoYXBwZW5zLCB0aGVuIEJPT00hIEtlcm5lbCBnb2VzIGJ5ZS1ieWUhDQo+
IA0KPiBUaGUgdHJhY2UgZXZlbnQgdmVyaWZpZXIgaXMgbWFkZSB0byBmaW5kIGJ1Z3MgbGlrZSBo
aXMuIEFuZCB3aXRoIHRoZSByZWNlbnQNCj4gdXBkYXRlIHRvIGhhbmRsZSAiJSpwIiBpdCBmb3Vu
ZCB0aGlzIGJ1Zy4gOy0pDQo+IA0KPiAtLSBTdGV2ZQ0KPiANCj4gDQo+PiArKTsNCj4+ICNlbmRp
ZiAvKiBDT05GSUdfTlVNQV9CQUxBTkNJTkcgKi8NCg0K

