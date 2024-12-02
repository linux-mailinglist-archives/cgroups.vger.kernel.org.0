Return-Path: <cgroups+bounces-5728-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEE69DFE01
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9F2280F5B
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F51FA147;
	Mon,  2 Dec 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O6TmIBis";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d/Z331sj"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8715A8;
	Mon,  2 Dec 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133729; cv=fail; b=Wue/1NLm7V7CRTufOo/TjkJDQm1vG2+4oNs/Juj2/rkitMd6zQRHBpUCUMvIDmzopaa/MOrBS5HnESRVwtNyzOt+/5zf11hisv0P9JACPrrdIEc4VH+kAuDdfbRCwHgB0/y5bsqq0nIPG5X2AAa3DJRB2k7hCrdO+zTrKkNurdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133729; c=relaxed/simple;
	bh=gLabnVAyacSFNbqeZiyCxePV+V5Cae/Fk+aN1YS2Fac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dykgxlM8YIkaww/2eGs7YKmMIEiVUP6q+kKZOCkVwmFArZK8/QESg8TytggWiCKtZDqlOK8HolP/OR90bCy40moUTWvnGVcFLQr84JJfngNGp5pbgaMQTlwPHtyNzE9cqQc+aEU7F0lMSIvrKdOziAg/rBxVc4C6ha4Zv2Bz4IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O6TmIBis; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d/Z331sj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26Wx6P015031;
	Mon, 2 Dec 2024 10:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gLabnVAyacSFNbqeZi
	yCxePV+V5Cae/Fk+aN1YS2Fac=; b=O6TmIBisFiAMBizL4iBvSV6ahrhnJEs9N6
	NvVbkaga/0lGYaQMnA4ND6hi3p9RwjbJ2R3m3BxG/W7Ue2TdaJQ7BKAizTrLB0P5
	JGyO2stLvSiSR2SFLDzGPdSjZZq2bk05mMUeFjnCaOBexvcN6siUlc2ygPiLSvj7
	sSg+34OghkBDLZNWXGHKSCKARIdgjGuOrvQ1+IPqZOv9c6V6TQr1pg00w06shDmr
	GeI+PE57B4C286tRxB+PNNAy94uCuABMl24L6ek6toA1tY4TZ2JehlZ4npdgitOg
	F03jfdDBFR4UaBIykxe6Z5PFkHVJmfS/gFWUaAdlmj0cbk1bAiQg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smaagcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:01:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28IIqv031298;
	Mon, 2 Dec 2024 10:01:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836sa2c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV/O1bdTh853LqDwfkqDgYkVIGDt+kNyhHROyxFPZwoURxGU3fREECEiYFFDYez6xGjZCz/vR0JY2/9fUnLpJUciTgTy7SL675lNR+pFf+ZVuQN8bvwVu1dsEpg2nN7VUIum7gjsAnGIfkRjX+iPWssxyO0BYX2MsvE9smDRhFNm5mV/W4xvBKpwaqeUEYavWmKcb7Y8KhCtSZ6uhXXVs6irSvKvARPM85DowTpctJgNJvQB3im5bBL3nuoK6Suwsz1dM2bUjeKIl46mh1a62LYxseFa5t4oG64lEWphxPmxGWtb/52mJuqzUlR9ci96AQS750gU0rwjcWRYWnGErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLabnVAyacSFNbqeZiyCxePV+V5Cae/Fk+aN1YS2Fac=;
 b=k73puq5KL7QuzY5VyVgsvW6/JhIImSrrV5coeIvyY94CFA9JjWR63PGUZL796kJLUWil7Eioq3WkWPEsAAU2q4PB37S95bSn/ek/J3jQ7CCOGinolXr4Lb9zarKMXmNvKcCyPj8M2Y2tW7WIVcCj/u0wYnlKoHphOBR5gGULupQ9v35YJFOaVEOAXIdpd4+c4CZd3BTSbUrSaO8cTZoidhkWGQb8IiiGZ87PQya+Bn1WzOpsUxFSZN6J8bwn6KoFqrCAFNBmF8/6y86EeC3G2ViHOHX2vK7/mDLFa7kyVlCvT3FXcrD3dQfbzAhFmpp0kEK3yTjvYpvn73qAEyr5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLabnVAyacSFNbqeZiyCxePV+V5Cae/Fk+aN1YS2Fac=;
 b=d/Z331sj42ybDetqaPJMh2wh1nkrH5OYl/zmGJW9oNXoScZlRh9N7Nea+dCq+GMfpPLu1Tmi+PDQbSQkINFMMCO0Jw1p0IFxBoGrCG/EoNH8cvQ/2tHm2qTirmd7A8QZd1+za0MI1GGIfGhg/V1NReGfzfwxYwthbLa3onnCF9E=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 10:01:54 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:01:54 +0000
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
Subject: Re: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU
 safe
Thread-Topic: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU
 safe
Thread-Index: AQHbRKDoqIrQa2L35k2sbe/75II8RbLSuSOA
Date: Mon, 2 Dec 2024 10:01:54 +0000
Message-ID: <86954cae7edc065a9ec6465c38c0eaa22ce74575.camel@oracle.com>
References: <2024120252-abdominal-reimburse-d670@gregkh>
	 <20241202095926.89111-1-siddh.raman.pant@oracle.com>
In-Reply-To: <20241202095926.89111-1-siddh.raman.pant@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|CH2PR10MB4277:EE_
x-ms-office365-filtering-correlation-id: 7d36d8b3-5e22-41a7-d4b1-08dd12b859ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bG43NTg3ZUFZT1NHSDNUb0ZUeElwTzVSVzdJZ3doc0lOeFNiRnJLRk8zeWFU?=
 =?utf-8?B?bDBaQjVyUWMwcnEvQ211MEZHZzgzNnRZR2N6Y2JLc000ZUdJTWNuVkoxc2kx?=
 =?utf-8?B?NjU0Sy94bWQvdmdFVTZwZ3dueCtYT3hMQVRFVkZ6YWtNUnB5NjZDNGZuR0VE?=
 =?utf-8?B?VFdzbTBmaTZteDBMMzRrWmdUNHdCbmJjVjJPY0h6ZEw4MUwzMVc3bm1yT2Mz?=
 =?utf-8?B?SUxkdWZGNlRPMEFNTWtXcE0zWHB4c2s5SlhUWmxpK09Eck1XdE9lZ0tDNXhi?=
 =?utf-8?B?S0hCUnh2dHZVaXZnVk1NQmxWQWUrMFh3OWlMTGxRNkpsRktCZDVWTG90SWpR?=
 =?utf-8?B?bDNST0xwb2RyK2F1cHYrU2JkNnBkMXRyMGNTYW9BSituQzg1V1Q3VmE0enpG?=
 =?utf-8?B?SktnVncyb1JtaG10eUdLaU45ZmROSWdhMmZVVDBUZ1g2UjJsVXN1YkYzM1VV?=
 =?utf-8?B?V2lNaWk1K21xanBBaWdmSXJvMzkrY29SaGhGdDUrMW40ek5oOE9vM1ptY1Vv?=
 =?utf-8?B?dUd2Z0RTbURKMU82U0VpeU5pVERoRnBXVjVsTzBxeHVoRkRoYTlMeXVtN3M2?=
 =?utf-8?B?SnV3ajRLR2VmK3VvcU9BUEpsRThzWklFVmlINjhwcjg0OWlYUW00TEhJd1k2?=
 =?utf-8?B?UDlYVU84Q1Z5OG9sclE0V08wSEdBcXFxcVpXeU1vZUg2NTJZSGNoTjA1ME9V?=
 =?utf-8?B?eDhOc0trZ3dGMXJlb3NNbTExbVhzY1dUMkJnOFlsTS85WkhYcW84eTJ1K1lI?=
 =?utf-8?B?aUxxcEJVcjlqRkMvbVZQUUU4Y1VLQXFrZ2pETVh1S3h5ditnOE9OOVljb1Zk?=
 =?utf-8?B?V2lTaWFBZmFHbUs0UHoybUxvUERINUJPRENsZzEyN2pNMzlTdy9GaDV1WWxQ?=
 =?utf-8?B?MWZmRG5Cb3lyK0wwbGZrdVc0RHVWc3V6SnlZREZGMENwSjkxaFo1QnZuc0xN?=
 =?utf-8?B?MnNyK2hXMHlNRW9OcncwWEFZeU5xV2ZzUjhqTVdMVUM0M3hqM3d6MnhUQ0RV?=
 =?utf-8?B?Sm8wUEtOTTgvMlMrVk1oMXZXVHhicUN6NlJaNFFWdEZKSXFrdG5hTVVJdnFs?=
 =?utf-8?B?V3ZVaHZmRjFKNDVDeVltNVJWcm5GUFFrR05GTk5NOHY4RHduY01zanJJUkNS?=
 =?utf-8?B?MjdUMmVFWVJoMEdhU0lGcm9NQkoyZDNTMUZqSGxLYklHSlcyRTkvU0xucFRk?=
 =?utf-8?B?SmlxSFhMZ0Jvc0lvQVlKcmg0dWcwcThUQU13RVZDaFdibDN5eE50bFRLQUhw?=
 =?utf-8?B?ZGpySE9scEt5NGhDR0ZhZmgyWUttRDlwV0ZDZ1lIL1gyQjZpNXJjVnlrQVdI?=
 =?utf-8?B?LzhidGs4c2YxNyt3ZnZYekNkYWFqOXRlZFNCM0V4WnBPQ05ta0IwVWlGbEl6?=
 =?utf-8?B?eXk3cHVMK0V1ZStueEMyOVhqOWQyYXZxM1ZJYUsrSnJ4MUNlK3lKZHpRRWdv?=
 =?utf-8?B?OENTTU1VL0hQZ2gyRmhFRjlDbVVnZDlwVlBCbEpaNlJFVThZa3ljTlR4REh0?=
 =?utf-8?B?WmpFVXZDV3BiN2JVRGtrNC9OSmpIYUNXcWpKNmwxL3d6cVFrdFRMa1RWb25O?=
 =?utf-8?B?UEl1cElZbHo2dmpjeU1QVEsydjFUNHp6QUFGQVAvRGxFZ3h3Qy95bVVvcWZt?=
 =?utf-8?B?TlMzSVNob1U1dFhRWDNxV0FaK0J2KzVZNG9rOHFrWFA3dXZFRUV0QjZyRVRm?=
 =?utf-8?B?SjF3S2tDdUE5amhPNmZGZjFCOFF2bTVHRXJRdWlhWmIzOVJCVW4xVWV0MnRD?=
 =?utf-8?B?elUvbjYyTkt4K240QnNnWlFkdVpvWGhEa0xNL0lvOGRKR0VRekU1Z0JSMWtB?=
 =?utf-8?B?eGd2QjJJOUpLSlgrOTU3UmttSmFBSGh4QVl1UWc2a2ZkK2J6cnI1dkVoM0Jq?=
 =?utf-8?B?VlovQjJwNVo1T1N1Q1NXZjMrMjBaeGk2S1FrdlhuT3JZUlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWdQYmhIVmhwcHVFdUpBZlZhc1NBZDhoY2JDNXBDNUJLdmlYYTRZZXA5Zzlu?=
 =?utf-8?B?azFDdWRTSFM3ek9zY2J4M25aOGJLRTZab3orRDFSYW4wKzI0T2tMY2drekRm?=
 =?utf-8?B?N0dNL1RvQ1NZOFhDRURIeFgwM2o4dnNGWHR0SDRjY29qNCttOEtLZWg2TXdL?=
 =?utf-8?B?NXRjb1RUQW5BQTRBdElnODdVSFlITk1ycjB3UkVRQUIxZXRuNHBYT2RCaFdx?=
 =?utf-8?B?anA3dXl0T1cxY2J3ejJFeDJISmVDa0NGMFUyRDlVN3c4L0lPa0RIZlg5eFhI?=
 =?utf-8?B?bGpLR2tYZjQ0ckkzR3BQeWhmZ0puek1FazlOYUN5VlN0T3Bta2xsM2tRWFFy?=
 =?utf-8?B?ZkRhS2YvQkdhUW5WZ0NZWTliVzlPWGVIZDY1RGhJWm5PTE0ydk1PT1dnUEM4?=
 =?utf-8?B?OEtVYVRERTZMNDRUUDlONnV0L0hpVTV3NzRJSmE2ejV5OEJnYjlCOEhPeGRj?=
 =?utf-8?B?ODJjRmRxeEJZak9ZMEU3QmEzcGNzQ2YwVzBOaGlZMjFlcUFrcllwUDY1di9N?=
 =?utf-8?B?MmhvNTFxQUsvR3NoQjQzYXdMKzdtc0JnWHJmT2NtakRrVVNVS2xUbGhET0Zr?=
 =?utf-8?B?QXFiWUFDa25rRy9tazBTSDFGNmxZalJCbzZWcHBuNTNESHJrYng0U1IrMWEr?=
 =?utf-8?B?a09kMWl5Zi9CeTAxUUpFdzRudldZbFRBeExIWEIxbXcya0VVeUllcDNlWW01?=
 =?utf-8?B?aU12T1lLUUY5bEcvSDhZN2hTM0tYVVBvbWMzdk9WVWY1c3RFUndCVU5NQ1Ar?=
 =?utf-8?B?OVlYTjhCSEtJRC9QeVQyMzlITUlRQVBFUjVzTnNHYzlkemdwclJiWGE2eUwr?=
 =?utf-8?B?WTZ1bzVJbXA2R0NRNEl3S1lXcmhrSEE5bWhNYlZKMkJ4WnVZRGZzSlh0Unhx?=
 =?utf-8?B?ekhxbGFncERtRmJnWU4zK1hCZkhqc2M5RzhmVjRvaWtpWTlZbXBwaWdTdFJY?=
 =?utf-8?B?c0kzZ0poVFRuajVsK3BPZEU0cTBvZDl5OHFWeE5pMWZnNE90VE4xaWJrd0hP?=
 =?utf-8?B?RGlNU1RmRU5oamY3alVFNXlIWm5GVDVjWWdBWWE3dTlRck5TZldJRXRnUDNz?=
 =?utf-8?B?Yyt1amNoK1JmK2NScUFJeGowNnBwdlVIbDBIMm1nNEZvejRuWDB5d0NXWkhy?=
 =?utf-8?B?N0kyR04wdU9ibFkxdzBoY0FaNW41ZWxRWU15ZlR2T21mZjNqK3ZMQXBmVVk1?=
 =?utf-8?B?eG9JY3ZCTFRzbzBySWdGUkVWT1BPRGhKbjBSYnRwVDd1OGNIbHFvMlM4SUFC?=
 =?utf-8?B?RzBveTc1a2Q5WmYxL3ZrRk85VTZ2SmVkM3RLdFg5cTUrcGErSHVEWERHV05z?=
 =?utf-8?B?UGNJb0tKaXRRdDY4QnFKYVhLZnJRcTY5SFhSK3huUXc4Zy82b2JlOGM0dG1q?=
 =?utf-8?B?RE5IbmVvSnMrTGE5bzBkOW5FMGZPbTdZZVVLamJxdWRlalRhV2Y0a0gzVC9I?=
 =?utf-8?B?YTZ5NzRGZ0hCWTFhcXo4aDZKbXRZL3hQV3RCTm05emJHWlFjc3RIZSt5Yzdh?=
 =?utf-8?B?d1FEUDZZL0xnVkNZaUI1QUw3WWRXdXpDeEU2N2ZmYjdxL2RQWnhmWHZlREFM?=
 =?utf-8?B?WVRaV2ViNXBPSHpnSWFiVVg4SEtqUVV4L3RrQ09BeEkzKzBnVkR5azdFUjNK?=
 =?utf-8?B?eHFER2tPS21jNER1R0xoM3pEL3hmWGdVUUFRVEtMWGNmcENuWHlIWjhBTk13?=
 =?utf-8?B?QnNEYks4dERzS2ViTW5KTWxxaGlNalBUL0l0cEtzMTZMMVRHUmZWczdNRnVV?=
 =?utf-8?B?KzFBZTRwM2Zra1YxTVdVWXVNZE4rMlAwTnp2bURnSzQrZmZQdk85V282S3ht?=
 =?utf-8?B?bitPTWJyWlB0dFBRNFlPRzJ6b2Q0Tnk1N202R1RIWGxpbmR6U2xaZXk5VTJz?=
 =?utf-8?B?cDZMSnl4blc2RWtGb0kyTHR1a0x5em8yUlJWNE91d3dvS3VjQTY0d1FLZGFV?=
 =?utf-8?B?SUtVWjEwcTZyRUswaHprOTVESVRGbVloSVFqTDBoR1FBL3pzd3F5U1VPK2NX?=
 =?utf-8?B?cnhVazQxRHlxUjVoK2FxSG9Pc1hIWEtPN0VjbDNsYWpsUnRVMnBnZ0dFYUxH?=
 =?utf-8?B?aDluYU5RRTBuN251cDBJZTdZelMydjFJYWtKd3IzODBHNFEySXFNZVpBdG5W?=
 =?utf-8?B?d3hOMk8vY1lqVmkxL1kwSHdZL1c5cGVZeUdhb0c1d1RWSTR1cTduUTlvNVFK?=
 =?utf-8?B?VFcwTnVSR1Y5bEdML3p0Q2orTU9qeVRMVVowbGgxWGlIYUhyMmk5bEdJRGI4?=
 =?utf-8?B?MWRXSUcwVzNJNmdJNVpGZlNiNUtnPT0=?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-PY8cJ3yqhzalwmTjBAad"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aoC9t0z9D1UOL5T/DGpnPBRV9yhZzKYpPNyRF1RsfXb1LvK5O+igxPhGeBsQXCOSXAouL0vzyCvWvLfPVuZVUCLwES5Ume+55moVl7f60KpqQ8g0U+JsN7sBFjwXfXQMlVVwwYJes4wp++qJedtLgOPNiMyPpgAuaveH1+5ZgtBR6E1jwSZ4C7MRNz7BX8GPC9wehR/GLQZ6xfKsDeL+RMTx4dB4LqoqSsB9AxxrbofGa1d1yvch+yozVR8dia8TiTjSALRm4fy8KpzQrjSZUhEKZiXcrde01YCaUeGLVhB5hoibHtVKwAQB40FNxIc1vwOuRC3GDBDgQ0Vq1+buxs1jDK+i2yyYhD2CHHjOW00kQPosrK//qbCrGRd+vPx1Sip5iW/mCivgGnTRuEBeUKiI/LDezFhGnzrajK8OHsis1GYUFKkROOVanVrPMMsuFZo4oAq8DR+r2/E3sp1AhCE0ghipWcMfndAEZbhV/5bbIve96E0cj2tVc9qyjTUjhbGXqj3bRsJTU1Ptve4cwP/1oYQdFI9W0TZsxM8JTZQWeOUxrZUMYAI0/gjeNy/ujS/ITThraCTZo3B2S2cvsK4r/g67TSYjhxGthQTldwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d36d8b3-5e22-41a7-d4b1-08dd12b859ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 10:01:54.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/oMja/i5IThgkWPp45wrIWU/L1TR32mo2qRze7La8tgWVeD29KlbpUtWv1EOWzmhfYH8/1x1plUX84rSDqvGwOyrD7mevKkVokPYYVG3oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020088
X-Proofpoint-ORIG-GUID: rneVFxLwgEqf0rYl1fFvgSy1Ndfqy81t
X-Proofpoint-GUID: rneVFxLwgEqf0rYl1fFvgSy1Ndfqy81t

--=-PY8cJ3yqhzalwmTjBAad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02 2024 at 15:29:25 +0530, Siddh Raman Pant wrote:
> Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>

Oops, please remove signed-off-by it was added by git format-patch
automatically.

Thanks,
Siddh

--=-PY8cJ3yqhzalwmTjBAad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmdNhYkACgkQBwq/MEwk
8irsug/+KxWzPDBxCwYfw77v0tNHLl8fNie8fFfFyM19l8wpZI8ZZVQxumUyrNtC
zCSeubYfKtTp9BhpYTs1BQaxgJ7+RPvo2GyLn/qgXr7gz50VWmsJoMROwuxXN8+o
x+CncJYV1pUs8SUN635mmF6zYH2nCAEQWw64CB/lIWH6pDb8otT6nqs1SF8L6OVh
1hDHFSkA6qdjEvUZFV6kDbig2lQ0e+pJgs24FtLmuyZXtmZAhX44h3vlyfl6nt1W
OQRjVC+py6Z9fZ3Ngdz2F/dVvroD0Kwwmi6EsKc1Iijw9TlUtqA0XdldkDkDB19N
ElerOIsPu5FdQnMOU8L6hOXpjLFhLZu/fLl3Ex4uhM0CUqxKzzLYr0aZjVv8t9E9
DF5FLt1y+RYXs1iBHzWEayvgQhCei2E+8Zz10Ik2+NFJPL5Jn68UYPHzqj3pjQyy
kwIGQYemQ9OePacyI2DWdGB4Q9cd8nSoS4n/PC7ppUsAJUrj4wxxMG3dH7qSwYpj
TeHFtwugvn8i7Qr0ti0zOywZGTqfXvno0xkjzlPxJoJ0W5n7+wiDksWqP9An87og
MkD0HeN9G30xBuEz17oMg6x5VrLuciB9g+bOiNz5UyjsdaVOZvN0eS/EzOA5TBG3
hrn79GA4hwqChnRyhF5fUiELljv9KQ6Ao3lsIsvCNfip3y+nmIs=
=z9w9
-----END PGP SIGNATURE-----

--=-PY8cJ3yqhzalwmTjBAad--

