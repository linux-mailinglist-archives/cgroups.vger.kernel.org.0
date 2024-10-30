Return-Path: <cgroups+bounces-5324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B309B5CEE
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 08:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832492841EF
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624A1DF271;
	Wed, 30 Oct 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hHrqTspf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FRghFE0N"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06633192D7C;
	Wed, 30 Oct 2024 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273410; cv=fail; b=F8sDQBD4aaouPHv1ILgKjkQM7unTSoSrOnthosLpv+9xQYoIBnFfT423fn9fq6ZdOwLUospAMEgEKh8XfqdVX2PvHp6ELZkz91XusBVKLFvEGf8hNbNc+AtBQ/YB1L7UlxqBFL4f0zo5G4iKRhdnAlq7AHZ0/3AhybYgRhtmdQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273410; c=relaxed/simple;
	bh=OcR4kAqppsHRRDdSzBVgS/LyAUi0EWaEE8K4syMpgZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=P1hTpKDA37OdCTT+L8pFZoCDvjC7MQ6MuyHP1xoId0cAceC2R4BrQmh9ctiVq+udAkwhWgzmkvpRF8GETHCLGyai5H+jHhFgeKICP4OkbW/S6MlyJ3kbLLqUIiNMXiBNDWUhNce7YT4p/urqoq3kmAe88px9V6C2cSrGYxmSWws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hHrqTspf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FRghFE0N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49U1fchM021239;
	Wed, 30 Oct 2024 07:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=OcR4kAqppsHRRDdSzBVgS/LyAUi0E
	WaEE8K4syMpgZc=; b=hHrqTspf4ZEnL0R5G6/Ly0uqZjOfoL7D7RNDBN/VcDczi
	g1VUVNSkD9mShososWJrQSVmjvi3GhhA/QgEXN1hfsRRJjoO0ggYXd4ew4o0rEL8
	jqniL8BMV95K4iUYJ22P75vOuBephcz6QuC8/HMGftSFmzNA+VdQjlyLi+dnDNbz
	9nImLxn2hUXKzOULLnSsFWN0OgC2Y83+ydsJf/p/k010lrqxkpB1gxScHVHxypPK
	G/AAvGs8CTGDrgIgU8FxFj2bIkYisxytTrw9xiqoQ1jJ6GjjMf58h+0WH8qTX6ta
	3I2h2YLkOK87a0mVVBn0QN8QKDKTtX8JAg/5Tk+cQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8y9tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:30:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49U6oHkb040239;
	Wed, 30 Oct 2024 07:29:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaq7d1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 07:29:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkdNwbRCB4Ml2eK+7CrtrgRU7VS40GFdJNTGA863VamQRa2MvLKR/UxndVuFXE/M3UyAo1Jk0G6hPGYpbqHBC8jUdkQn5IGLlqHyQbcXXfHYDrS7SMEheiYmH1zNRPP+0FKL2wHxTjCF4YyXQfqZ2gfuUyS9wqKjSq0KULA4tPadMXJYpt+7dPQYlD8fKLesSwTVVyfuEpeOfo0JrJLtUmeEbM5w+96HOEk908KSy6y4v2DTSjUtXuvbgj+gsHabYlQ14TrtqFAe0/cUCTLwznIeCb5jr8D80+GvqfrFiH9Y/r65JzSUHN9UWXppadKwLxWmaoBLBRProFDxmnuyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcR4kAqppsHRRDdSzBVgS/LyAUi0EWaEE8K4syMpgZc=;
 b=iue+Tg0BlWBEtRKezWZlFkRGw04T1f9pwFPNAOgO6NJoyUfhntiXviSSSS9xzKk6PK9ctIYZ4ohJD9WPqCiu3rXyGfAX/eq+gvZ6S1oac5BTmcsyH90n0bmUu5JM16XvbLDDft6VMbAKrh8H3UsztrHB8QgCNzno/3MutSByPvSYvVPJwk9nq7e2ZlfQUFjgMdrQqVGCfbkcYZ1SM3StqJmSIXUYEwCbqBpHaTbvGjWvXVesD6hP2XC/8u1F2Jx5tWu3q8wV2roXmDsdcqBDsootp7OoXk9tgrq4sBcIhzcYJLOFSWesieXNVjvTUbry4QLSBlX9xmI7Yz8+FHeGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcR4kAqppsHRRDdSzBVgS/LyAUi0EWaEE8K4syMpgZc=;
 b=FRghFE0Ne9I9p9dBk2I9bk3d2A60lUvhjEs4rktiKx9Lg5dpKR0tYmVwfEEysT0nmnv9rMotBdjaowJg+06ni8M9NgEszxf0+tcUuHUfGSk+0eMsqThNYIwBYXx634yPsMLimkSQza7QHvxkqTBszNkg89r+7Flc2QzZx7Cv0MQ=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by PH7PR10MB6336.namprd10.prod.outlook.com (2603:10b6:510:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 07:29:38 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 07:29:38 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "shivani.agarwal@broadcom.com" <shivani.agarwal@broadcom.com>
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Thread-Topic: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Thread-Index: AQHbKp15zux5CG8yXUikVIDDQ2AERg==
Date: Wed, 30 Oct 2024 07:29:38 +0000
Message-ID: <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
In-Reply-To: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|PH7PR10MB6336:EE_
x-ms-office365-filtering-correlation-id: b10c05ce-1ba8-4c27-d42f-08dcf8b49c60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0JoMm9KYXBDV0ZMZ3pjYXhrdWxIT1k3RzNHeUxXcEtQVk9IMXZyNkZYVGlX?=
 =?utf-8?B?UWRDWGhIVzZNNTJwRXdLNUlHckUzU3ZITVpDUHMzamU3ejcvczFscEN1U2Fk?=
 =?utf-8?B?a2tTQ1RtL2g3WmZhNVhQS0Z6bWpiN0VuSUpTbzRCcG4wU05CVGpXTjd6c0o0?=
 =?utf-8?B?RVJ4cFhCazNBZ05DeVc2WDJrNldyTDVWMG16dXBqd0lXNnpVdWh2bzJHVHJ6?=
 =?utf-8?B?TURFY05FcnhEa3ZXQW9nSGd6YW92WHlLL3cydW1nWDhPY0Yxb2pwaXFDWVQy?=
 =?utf-8?B?d1kxWXgvL0x0dmM0SytLL2ZrL2FyQlpQdVBxRHpkVzg0cjg4WHB4OTQxUk9j?=
 =?utf-8?B?RlhZeGVYSEEybWFyRExIWHlIV3hkOWY3eG9SYko5Zk9tOCtRcHU3QlByN09G?=
 =?utf-8?B?ZWxoT2w1Z25zWjB1OTVQdGdJejhoNnM5QlM4dXFERXlNZjQ2SWNValJVMXA0?=
 =?utf-8?B?V0V2NXZrdVd0L2xBZjRRRzlhRmxnU2VmclZQSmM3ZU1HUGNiejlHOUpiMjI1?=
 =?utf-8?B?YVJBTVhpUTNheGwwUjNHdGNPU210UThjMmdRYnV5dXRHeFRHaVIvS1ZsK2o0?=
 =?utf-8?B?UkN6ZlRPa3puSzdKZUhneS9KeFdFL1l1ZFByeDNDSDgxYjgxSks3VU80Y2xq?=
 =?utf-8?B?MVh0UHFKaXVmdDZ0NzNXTG5Ta1IzR3Y5ZjhMRUxSQ3oxS0dQMmlIUS9wSTNN?=
 =?utf-8?B?cnErQ2FxR204cU42Mi9nQlFmVTloM3QzbEJnR2R5RzMyd3hUMS8rcTZObWRi?=
 =?utf-8?B?dEUzSy9vYWFvTWlhbzlIb0dyZXBiR2JNeWF1cUVJQ21laFZHYVdRYXQwbHlR?=
 =?utf-8?B?Ymp1WlZRSVRqU1ZVWHhla3ZydmRyVjFsUXZ4bWtaMDBkMEo1UkZMTW01SzRv?=
 =?utf-8?B?Zm11eVdqRjd5WlFSTHJhR0xFcjlvYlRJbGxCQ1YzeFZCWG9JalJETTZORXU3?=
 =?utf-8?B?bEFiOGppOTRiMGJXRlZnOGRQaGRER3RSSFhrYmpSMlVlRlVDUnJuV3hqSXF2?=
 =?utf-8?B?cmttN2JYV1BJNVRtaTExRmZBeVB0alA0eXdnTlE1MFlqSmZDREJsZWdINWcx?=
 =?utf-8?B?WGpaWVlnY25wU0RoOWIrRnJCcEI5VHo5K2JMMEZQMGc1VGUyRXhlVTVWREFo?=
 =?utf-8?B?Y3FudHd2K1lNdDlPNVc5UXVydHcvTmg0UnVsMmRwZmM0NlloSjR0MldIQUd5?=
 =?utf-8?B?bURQZTdrRENpaEU0QllEQTFIYlhjUXJtVkUrQkxDWmhaVk1KYVZudHVjNmx4?=
 =?utf-8?B?cm0rMGFEalkvOEl0RmdPYXN3VjNJKytRdEVmUC9FUmhqRDl1dWlMTGx0UVh6?=
 =?utf-8?B?cDAwS1c4UHpCTmlrSjNHL3FjSkpZazJBbnZtdnNBZndjNFk2enR0eUV5UXRK?=
 =?utf-8?B?b2tKZG1zU3FpMHh6Z0orYUtWMlVDVXFYeHREVGc0UUVOek5sMWcwTmNQZmhZ?=
 =?utf-8?B?MnBpQ0VRUTlGZXpjNG82VWNNTGNHT205UGsxOXpUSy9oeVNiRlA3cVZDdFNi?=
 =?utf-8?B?WG1PT2toZGxRVkF5ZFI5cG9tTFRoS21FZ0RRR255SmRMd1NIeHd0UnhYbk15?=
 =?utf-8?B?N0lBVEt5L1JFK2JKR1Q4MUVJb3pBWDhBRU82NXprNys3bklIaXRzZDlIY1V1?=
 =?utf-8?B?WGRIcHZXZUY5OE5UaUR1MlllS2hud2xCS1N2MG5CaGZjelpKczRCL3RxN1d0?=
 =?utf-8?B?RG9EWGhkeEltdm1LdXhHMjNKVng1ZUdRU2EvWURpTkRTaUhKSmI1dzVsSHlZ?=
 =?utf-8?B?emNxQ3hCbmVEQS9FUFNrV3h2S1ZYSER0ZlM5U0FxN0Y5bVg5SDBreHpTdGpW?=
 =?utf-8?B?ZFFOQi8zeXUwbXNpRG13bFRTcEI2UzBwbU5CdWUxaGJpRHRJWGR4bXpxTWx1?=
 =?utf-8?Q?7nztggJ2xK9a3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGhnRmZzMnRwcTJEQVc3ODVwbnB6ek1MTzl6dXltTEZveGpRcHc4eVozNmxn?=
 =?utf-8?B?Q0tsZzd1ZU5qSXR1NEdKUXdYalUyR0RPeHdtVVN5QWJvM3ZjN2lSUnU5QmE4?=
 =?utf-8?B?OGZCQkZMU2xQUk9PcE1xajRwTzVuV2RiZWZIN0FmU0k3SDRldVh2WU1pdWow?=
 =?utf-8?B?TUlzTHFTNkFlUVQxOVNpcEJXdmxmaHNVN0JaUkVmekJWaGdtWjZnUFB4TGpM?=
 =?utf-8?B?dnVvQmRXeWphVTFJVitSejRBckxHblZWakpYOWRnNWRNamE4SFBUYkJPWjhT?=
 =?utf-8?B?TG5vckpULzRoTEZOVThzMit0Q2FBTFk2cWw4RHdvaWtUeERYQzg5N1FCVmxE?=
 =?utf-8?B?OVJXVFBBRi9IbGw5UUFMVkRmbzZLTzV4OUxReU4reWZpdm45Sk40MzNVTnlD?=
 =?utf-8?B?K2xCN1hGcXBpejc4UTVMMlJHMU1KYmNjVVR3NU1RMm5qL3RUOVB0ZER3Wmlz?=
 =?utf-8?B?WnlTdEh3WTZIc2VjY1djb25Wb2FTcmJvV0tkOTZYOUgxMGEvdGFZZWdPSXJp?=
 =?utf-8?B?b0tRMEVPekR3b3VLOE1KUjlYMUhzOW1mbmJZTS9PQ2hOdTBCY1pTNWlxcE9w?=
 =?utf-8?B?NXdPazNwOFJzOUtpbFRqL1RmMHIwZVJ1bmg2TGYxZUFwNEFkMHpSc2RPVTZF?=
 =?utf-8?B?VFRDUEZPUnZacUZXOVliVndCYmNLZVpqUW9GK2VWL29JM2tHSEpaekxDS3Uw?=
 =?utf-8?B?Z0IxblVQYUNMbUlyeTFncXY5RDJaSisrSUNKaXM0dWFuSFg2b1hNa1pzcjZq?=
 =?utf-8?B?N3hGbXRLVmUwK3hwbGlvbXdDMW5uYmNKTlBndWFNOHpMNHZQTXRLNjhtbUhz?=
 =?utf-8?B?dUNrR2tRVk9VSUNzbnhlRjZ2a1oxRHJKM0xnYU43bWZBeUxHcFQrZnV1Mnl0?=
 =?utf-8?B?YUsxanFsRGtZV0o5TjkxaHFKcExXSjN1MXQ2Yk45SzBGZHIzcDBEZTh1aVhE?=
 =?utf-8?B?RjhJTE13UktiazNaTlBZWHdUdmdpL2pUcUJneFUxeDVHUURhWGRML1orTTZW?=
 =?utf-8?B?aVVuSDJMRTlOdSt1Z3lGNUNNRnVmR0I1dmdLQUpwcjRxUXoxNEdHNFFiZW9H?=
 =?utf-8?B?bGR0RG1kQnpOY255a21OVXJtQmc4Z2RDbE9wZkp2YkFNQThRZU12b1AxaGFk?=
 =?utf-8?B?TlpNODVSQnp6VVMwbDlHbGlnckk1eHBiQ3AyMGZtQ0pPUlpPZHR5TWhzKzNJ?=
 =?utf-8?B?RklqNXFKaDdSeGxEMjVidkJNY2hKdzEzQjI0cXIvelExZ29SdXE0UXdIMVN5?=
 =?utf-8?B?VklRemFHVUN5d2FjaTE3alJWbnEyZlg3UGc5QSt3WWYrZ1o1Y3p0RUl6bjls?=
 =?utf-8?B?RVNwOWdaelNjMzFuZ3JVTk1wN0xDRGhTczloSUIxV0pVOFRyQWdibllQRmEx?=
 =?utf-8?B?S3FmdDRQRjdKS1dDN0o4enYxMC9MMlhmdFpha3ZGSEZrMEpHVmxCU1lqamhV?=
 =?utf-8?B?NVdXSDFzMkxPMDZkeFQ0QXR4NDBFemhrV2twRnBMWG1vSVJkZmlhbzFCTEhl?=
 =?utf-8?B?RUNiazIvSlFLaExub29pQUhIWmdLSmYwL2tJcGd5MW9iYUU1M2ExQVFuUERN?=
 =?utf-8?B?d1A3eHlDRmxPU0hDZElYalArUXcyVEo2WStwTTJiTTdZTlhFa2VKc2NpNjRt?=
 =?utf-8?B?cGxWUWlHQXFBenlwdWtPc1hxN0pPMnFKMThrZk1EREJuUlZueWNRa3NGRkZB?=
 =?utf-8?B?a2pjRjdnNDBDaWNBTys4QnQzbWZHNkRPL2QxK0RIeEEyeHh0Rkc3clRLZG5C?=
 =?utf-8?B?eEZPTDlaZ05GY2g1cm56eHhEdWdsSHFCaFdrMDZ0bTZCek4rcTBvQTZCSFQ3?=
 =?utf-8?B?VWdsb2d2QVNVODNucWlEQ0dNcU1nc21Vak9oa2h1amtmRkd5YllKL09IVUU4?=
 =?utf-8?B?STVzbWFUT3NqNVVMZDJLUnpPSWIvWGxTV1BHaHNHQ3FqTXZkMjYvRmMyZnpL?=
 =?utf-8?B?QVlCN3kzOUk5Mkd2U2dnUnp0Yi8wS2xITnhSVXNVZ1duZWRtbk5zOGNrSEhm?=
 =?utf-8?B?cWlWYSt4YTErZWEvSzBoSHVlcldQMUtBQy83ZmlPa1FCcjk2NGltT01TQ3Ba?=
 =?utf-8?B?eUkvWEw2Y2ZYOHZrbzdWYkhSTnBxakIxem1mbGx5YUFrUzc2cC9rajkwdEhD?=
 =?utf-8?B?Y0MvVDFOZ3pJeU1tdmUyckhLdHh6dW1lS1RSdmlKdVBMb3Uwa2h5UHQvOXdp?=
 =?utf-8?Q?vAikV2nhfCy4r1xyXOUqM7tH70aV7UTguiqIaRr2ykHS?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4Q+1uLPntVfAUVGvzGWX"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FnYq6wjCdxd0puF7VBoY1Fm2Id6bI58ga5HVDw/1VXCjp//I8fjDbtWgOz9O/slFJdC5MDe5FqVaQYSJFlOAIxZSnBaUBmgGMk7ukI1dTpVC93uJS6qFyEfKL6kEOLIrPlZ3KyvepuazehOFcmyFnZMkHbHoE3CH6GULMvO3JC+VlleHBPEwBSER46H+ohcyd/9PXUQORoHYHBjjCJw4OTygIRtN9kq9l6ub0LgvIXHoqz6DTvB8gGj1U+eetbp6Hkg8O612i+bNMnA9cmy2ZbQ/yOqvrNg9Glkk2TwMHxZ219tJKT9ag94GFhZzOfBQq/Ld0lgPshy1Ksx9hhIsRiAC2CBpIYUp1WUwRpW3KsygHZjiPAXZYk95wMEPUaiBmT8wGQ2lSgOBEV3bSJpWqF0fMeylqLQ1XmNnrO4Tz+s8qmZ9+AakNBQgotGpzZi2g38gt81f+FFe5qK50hjtiaGIe4QWVkdzr3xRgNuVNF1anhmq1mbj5Z5tQM0A4gIHUKJhIxPVW4IMy27dMnhY++fdu4EFBRifvz3WeQL764QN7HLyQLKVdZ1uYZdmzXABCOuUmMNL8yzyUo6srD/vViUu29mkFHirn2x6mtma6Qg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10c05ce-1ba8-4c27-d42f-08dcf8b49c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 07:29:38.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmtGA6LapuIwsbEbuM7Y1bzvx9u6VKGDpwv03H7GGg/q2+cwqlV9KAr7mAmHNQCDWChMyS7V60IWSFaWhcKiDIxREDs2Wxnn5QFyhr0DEQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_03,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=882 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300057
X-Proofpoint-GUID: EHCPm3aNwHP-cRLqvd0ckj06cX_0doZ5
X-Proofpoint-ORIG-GUID: EHCPm3aNwHP-cRLqvd0ckj06cX_0doZ5

--=-4Q+1uLPntVfAUVGvzGWX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello maintainers,

On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> Thanks Fedor.
>=20
> Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4aa an=
d
> in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 and 4.=
19
> also.
>=20
> I am sending the backport patch of d23b5c577715 and a7fb0423c201 for 5.4 =
and
> 4.19 in the next email.

Please backport these changes to stable.

"cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already been
backported and bears CVE-2024-43853. As reported, we may already have
introduced another problem due to the missing backport.

Thanks,
Siddh

--=-4Q+1uLPntVfAUVGvzGWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmch4FcACgkQBwq/MEwk
8iolBxAAtLRomlMQLgIA9dDs/3qFtKeqAebd7LMjwjuU2dPb1KPOc9wYz5vCaY8E
0WRgHlsAKvNHc9vbwX91XCONIkd6nzRvWAH73CeQJEUmIaRCEE5ucY3b1qQ4geah
M887/j/qvjEEnnI7ssZncVidYAAd3njsaxsQaHtMuk/icdf4FGEVF6K+57NnXuW7
oPouLbEc++M2dipQzQ4V+aw7lq6Q+2rxdORCQ36COnay40VLtjSQ5ykcU+gw3BXx
VW2MqD2gBsPgx2ppcfFdWhEgGE5xSstxS6eRGdlawTGidqtcdoP41TmnymiglV/U
tTDkxzLAaSgexel4XCmCp53RsaWV99AUNXCQC72eS6T/WfFrv41sxpYF4vp+N0Zr
6NhKapFw8AzwDbw4jC87iPLr2UI857JWhGL+ebkML1yGhj+2UzGjyCk7RyiBSLTt
a8r6HpG+cTowA5nWkyNbi4hzhxZOVoPvfq1IugqieTQ9qmnly+vyTozPni7oMxWk
mPBLO6f/Go4v8FaTM0m5v2+JER717N7R7VQMWk7aRUlamfWDUSlTDN3zX/OYu/nA
R96zMqshI9kLb+BPnEWbdkAXl+iD7SCpvy3ZPAccAKRKazBvmQqRXMTWXI0sNyjt
Qfed4QhyjWOcG90arcmAqrbBnPi9aVsvXm31uW0izydHa78JU/k=
=qP1j
-----END PGP SIGNATURE-----

--=-4Q+1uLPntVfAUVGvzGWX--

