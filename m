Return-Path: <cgroups+bounces-8519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAADFAD99B6
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 04:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FFB17AD45
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 02:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43088615A;
	Sat, 14 Jun 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ApIh3zTh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I+tnb6QF"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874A76D17;
	Sat, 14 Jun 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749868988; cv=fail; b=GqLP3V1wuu3LdRRmeHIYd0KNTuRDUsv0P/vopuplK+8K/9e6YnSq0nIJpzX21jZ9DsJIHuACAH/sX7f8glXHfWLnf+hVEuBfAEWv7OYjXqTW48gzgDMKdtn/Ru9fET8MJDqvFkUEWp1KMR5sR1HQ1d5dSZfZqhFwzHsyEk3iyEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749868988; c=relaxed/simple;
	bh=Vs9cNiOHSQ4IhZJ7Eo6UFCk6UJZlabd0XbEhIenuL/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nh3/fefp1HSSYglCT0hww5khLdIS/9/I2RtA2UxQ38FPgZCupjZiXHolG3gkpvOrB+L7QJc8qEzIWrS7hnum4/ZPwUSfk5AouClNr26FeoW/wUGgDvs9QrliqymOQKLH5NVh394O0RoqfV5MrSsV2NOELGKVnwqs+L4RJYH2T5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ApIh3zTh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I+tnb6QF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55E262Ev009585;
	Sat, 14 Jun 2025 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vs9cNiOHSQ4IhZJ7Eo6UFCk6UJZlabd0XbEhIenuL/4=; b=
	ApIh3zTh/dn+JonuhExICH+y+itclKmOHPVinJ8Wi9YFvc4HmREbaMlwLGEDm1K0
	eCtM+t6yKj0DMNLqw+ylkmRyeVZyaAyc/lvtMwjujDo6LoKcOdWV2jl6Em8W2+Jt
	0wqVNh3+kv/U5+0uEfjzXUOm8bxNl4sgU+nb1FomC6nLtAG7BnYTEnRjgAv9+YMw
	79VkKZ19Jsl7uTMpjxz5pIzJGN4R6dfeUP2rZ1aPG92MMkTeNMKik1HkEQJSd0wF
	9jJoQlenGlOnNYPTq+BvvpSS998ljv4/oP4bqtM+sAEpxttUnVf6MEw4sn34+9Sb
	MrYdDvJaOt8VVhW4RDPIEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900er0gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 02:42:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55E1YBWs035138;
	Sat, 14 Jun 2025 02:42:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh60x3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 02:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfbuIPn9VOA/bJJXaO1dWOIftPKjL/DHhNhxLU9Hnweidhw07bI8GaFlW1Tdzgj/gOMob7xDlONQK0eAyeCH5aqsIK72ncUOJb1wguG2j5CamCLH4oJXfmKRfyOWULX1l5K3/r96pYoChme6ZLvIZlbbeKVvz5OJNs6j41z8DNCwXYU4Pq3NgXwgSm8tyqFJAzPEG8yI5N2HhRNVTXGo3kWCGjoosiP3iyYiiWpyttacgVpcUO5afKkGjOM/CjEWgPC8+PX+mYhRUQmWayjKy1wztshlfFcjQALiHOLG8L2QLbdKAUJ1R2JxWihnPIGc3CP/9ZdMGH09BA+VIucAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs9cNiOHSQ4IhZJ7Eo6UFCk6UJZlabd0XbEhIenuL/4=;
 b=Gb5S8OQLL4IOEGPr2N5b/Vkbsh/+D8bA173Tui5vF31Y0NENTUa1pHK9DiAh2GqvbjvOHuj8svexHHkqQ/W5dc4Fr0RfGR+Gr8pSSnVQbicF0zBT1GSrLE2sCBpCtk95oBXewL6TxKoF3uCyxdHJ8X4ugTAglBfnNY8TfglJN7gsyrdI7WDCVaTPaMr89fMcULPwGrA8KqP7hwf1eMS4Ne9iDfdMoc/UhFaKaPaodumubK2e5f2mH34mC1n2Vu5hTUaw7IPEMP/w/GczNN/Q/YheskduTQEqh5XKjreIRBf6Vtxx80gXbrw7tfNrASnICA8n9CaMO8ThXu+j9cSJ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs9cNiOHSQ4IhZJ7Eo6UFCk6UJZlabd0XbEhIenuL/4=;
 b=I+tnb6QF6A8xY+AEb3duSr38AieHqpFK7/43u8b/95JYqXsVqejrp0ta2+D0UfIbIb56Rr7BHdUOtEMZDyv3NWXa1UI61CRPv/nvy16tBe1kFPBZX8DTV6cExNwFK42pJ0qrYKHZW2NJU+pIZKa3bTkZf1/F+jYmzAwc2n/FfZQ=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 LV3PR10MB8059.namprd10.prod.outlook.com (2603:10b6:408:290::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 02:42:47 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%5]) with mapi id 15.20.8835.025; Sat, 14 Jun 2025
 02:42:40 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        Konrad Wilk <konrad.wilk@oracle.com>, "tj@kernel.org" <tj@kernel.org>
CC: "mkoutny@suse.com" <mkoutny@suse.com>,
        "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH v2] rds: Expose feature parameters via sysfs
Thread-Topic: [PATCH v2] rds: Expose feature parameters via sysfs
Thread-Index: AQHb2yHSefv7DpumZ0GNiSt2jy6bm7QB9baA
Date: Sat, 14 Jun 2025 02:42:39 +0000
Message-ID: <533918eb78e39e8be6cd25d0bc1a7531b217ee2c.camel@oracle.com>
References: <20250611224020.318684-1-konrad.wilk@oracle.com>
	 <20250611224020.318684-2-konrad.wilk@oracle.com>
In-Reply-To: <20250611224020.318684-2-konrad.wilk@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|LV3PR10MB8059:EE_
x-ms-office365-filtering-correlation-id: acabd98b-a552-458e-b98e-08ddaaed21a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjdwWnIvK21pVG9wUDJWeUl3dC9TWFdTQ2RKRjhMM2lUdVNVMFJob296Nk9D?=
 =?utf-8?B?UjZoQXhWNE5kMVQ5TVZUb1FocGNQMXlGZGFQY1oxK1JTT1R3NlhIMjFXdEZK?=
 =?utf-8?B?Qi9LdmlmeTgzeFdvSXdGaE42NStrMXFic2dialNrMWV0T2hoSCsrQlpudFU3?=
 =?utf-8?B?V2crZWY4Ykw5ZVc0aWhZR0RMa0Y0T3djYTFxNXdTZFkrbzc0NC96aVFaVmV0?=
 =?utf-8?B?N2NRNEwyOFg0ZHdVQ24zSTQwSjZodEJjdWZHcmZYWnF5RTJ4cDZ0OGROQ0dC?=
 =?utf-8?B?TVJ6R3VMaUJhcjFyL1o3RUYvZjBPOWE2d0NFdjFKaW1DSE1ubExXenQwQUFM?=
 =?utf-8?B?RWMyVEUzVkhuMHV4NnJXL2lGYml6NXU2MkxqTnpCazZrQWp5aW1xWlJyc3FS?=
 =?utf-8?B?NGtpYk9yS1lGRHZ3VFdNSitnR3FaRWZvZHhvWCtycUdQQjB5ZXhlWkhFaVZm?=
 =?utf-8?B?NGxLK1lSQVh0UnhvQUZDaHBZb3VRUmQ2L3pIZENzTlZmYzNpMkVZNnBwVTNl?=
 =?utf-8?B?TXIvQWdiYzZNRllZWjRKU1ZkZnV0dFdPblJZT0VKWVhrSlRnN054QVNrWEVp?=
 =?utf-8?B?RFFWc2FIbHlrWWRIWXpjNStkUnJKenE0QVRaaGYwSjhvQVRsT1ZUWTRrVUR5?=
 =?utf-8?B?SVpxQ2lPc2FsV1JWRldsa0xuaVRoamJ4dWdqL2ZaQkdtWmF6OEpScWFYcXBS?=
 =?utf-8?B?cUsrUEFuVGx1dG9mdjZSOWQ0VGd5b0hCOEgrMTRLamVnYjkxK21VT0pPVC93?=
 =?utf-8?B?QUVzVExZSVFIUWk5OUp3YVJ2bmtDR2t1K1pwTWljdXQzMHVsUDZsc2RjUHNl?=
 =?utf-8?B?NEhSd1hVNWFRWVNlNDBJS2NicWlJQmsrYW9xM2NlTFJSWmFhb3JuVVBsNHJK?=
 =?utf-8?B?azdyaEpRWGxEVEY4NHBZa0F6N245V3U4SlVySUhwZDNseTZCUHlJeDc3MHBu?=
 =?utf-8?B?aW5OUEN1dXg4ZkU3T2RDeHF4WjhicnBDSVd1eXkzM245SENuY1J3aDJXNlAz?=
 =?utf-8?B?SENpMWZIcWtWTE5RS0pXK2R5NEZzbzJvYnFWc1Q0ak5KdEczSlllNzJTSlNu?=
 =?utf-8?B?ams3NjlZMW56VDhjWlQwOXFVQUxONWpUTi8wbUpaM3Y5NTlMNzh2Q0NrM0hk?=
 =?utf-8?B?STV0d215RnpIc1drYXgxcEkxRkFsMGNYNmdZNjQ5c1FqMnN5WVhjZ2xvQXlx?=
 =?utf-8?B?UlRWVUhHbmZucWZhUkxxTFNiMjJXc3JkSVg5Tkl6ZkFuV25GNjJITFcrZGMw?=
 =?utf-8?B?Z3lFeTlxVEQ3WndVTjR1aXV5a0lLNExRL0cyQzlLdU9Yd1dwNTNxQUpLTkd6?=
 =?utf-8?B?eXRidGhGY2VIejVZdklxL0VZaW9YSHlGazgybE5ROVdHcWdSbkFSWUhMQ29W?=
 =?utf-8?B?dEZCUFJTSXh1TENic0hhbkttY3lIS1lESUgySkpFeVFUOGpJQ0VZMTJFSUV6?=
 =?utf-8?B?Sld2ZjE0RG5LMHNlWFQzRGhxNnBiMzduanFKM29QNENBUnVQUEVlZzNqblJP?=
 =?utf-8?B?ODZWUi84YkpMT2tNSEp6eUR2K2ttR1JDUWJsc2Z4YUswUlFvaUZQUURCOWgz?=
 =?utf-8?B?S2xKM1BOeW9RUGNFMTlqaUtmdzZEWUlQeEFTV1c2d3ZWUlpPUTdraHBjcjRh?=
 =?utf-8?B?TkNlWkVNTWg1WExKbUhIVDYzZG80Q09NQWVkZW5WajR2OVFXZXNOSkJublhQ?=
 =?utf-8?B?cWo1dXpob3IyWlNNdzZJUUpacTlTYUdTK2lpVHhqZWF0b21uSmhINXBkRk1u?=
 =?utf-8?B?OWlGMEpNRGxrM0ZFeGZacmVVaURWQ0l4blFITU5RdzBTcXJCOW1GYVpPeEx1?=
 =?utf-8?B?TExZUE1hQlNHbENSUXlHMi9yVnp3MXFnOW1iM1ROZG5CUzlyVjBPRW1sNGJq?=
 =?utf-8?B?aW9XYXRMRFc1N0dtUmx1cXI0MFdMV0g5eEZ1UkV6enVTQWdURFh1K3AzVG05?=
 =?utf-8?B?aHpJWGZQZEFrQjF6RkExSHFId2tka3NDbkdyQWZqZytWK2trZThhKzhYd296?=
 =?utf-8?B?dVgwZi9sNWxRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3JwdjVPc0JnY3VVUjdSK1RlTm5iSVRubWozUnlqK044dDE0cWhqSS8yeXBx?=
 =?utf-8?B?QmJ6akpKV2NsVjZPZUhHaDM3eU9RYllxZFAxOTRscWdQZVJPYjJoV1FWZ2Jo?=
 =?utf-8?B?VUM0bHNUYUFDNjlBQ05pb2tMdm1UWGI5VTBFVlFlMXl2TTJCMU82VytwSzVK?=
 =?utf-8?B?Q3V3M3BGc2QxRnMxeU0xZGh1Q2E5YXhoR3NLdi91K3ZxZFNFZFZQQTJ6bkFl?=
 =?utf-8?B?cnpNQ25qQ1I1TE5rWXNpY2FnU2g2d0J0N2JOcHZWOUFiTVJFRHlPQld1MWdX?=
 =?utf-8?B?YlNNcTk4T3dtVjdScU12c1I0NC9iVUliMGZtY0RrTWE1OXVDaCtJMVdqUkdQ?=
 =?utf-8?B?ZWp0YjBXWlpseGZjdmVNbitRNlF4RXhoVGNqZXhqVkZwUURYRW9ubHhEVEJx?=
 =?utf-8?B?RnlFc3ppbVExK20wNnR6MTY4Z0gxWmx4ZWp2VlNyL2xFY1RJbVVoMGpKeEpa?=
 =?utf-8?B?R0NUZnNlM1NVakNnT1hnQTVFNWtRM0FqSjk5OHoydUFzYUs3RFltNkFveHlW?=
 =?utf-8?B?T0RVSWppcElSVUdhd1hMWDJ4Ny9UWXRJM2NsM1VYc3dvd2dWTGlzVk93ZHhE?=
 =?utf-8?B?V1czdjFKM3RYRVAzaDdvVHFqcWgwMTRJNHd1Ymx4MEc1WktlVkt4WkVPQUhK?=
 =?utf-8?B?b0wrcWYwc3NPTS9NUFZWVXhDdkxNUEEwZEVVNnFXVHJqWFlqTmkyb1FHemtl?=
 =?utf-8?B?eWN6Z1RMcDkzZy9HSkl6Zm5SQm01RXpZMU9KV2xUWldYQTBzWEN3dVpHZGYr?=
 =?utf-8?B?aGhFZjJPcjdnczNpVm1Wc2RwUGxnUXBZUVUyTkdmUmk5NHhFVVFxVUpyRGgv?=
 =?utf-8?B?czRpbVRxM3QvQk0zWlZHRzdMUG13NDJPUDU4OXJUWlBkRUJUd2lSdG5wWlh2?=
 =?utf-8?B?U01FQnFoQ0hjUGtBc0RyWXBWMGhiaVFJOHJpZ09hd1pjeGpVNlFyaEp1SDdo?=
 =?utf-8?B?b3BFVnVhT01haVBzQlFrdVZWM0hrRlU3UDlxZ3YyVkVpZWx6M2x0UGE5RDMv?=
 =?utf-8?B?cG04N3YvS0lMRGNRRjJlR2d3d0kvTGFLVHVROFMrM1g2MWtkV1QwZ1hoZHhj?=
 =?utf-8?B?KzlGMGRFRjVyMWcrYlFBRWhNbUdYbFhrTGFuMDRTbHd5bUV3Ymd5RjJRYkRR?=
 =?utf-8?B?TmcxLzF3V3RudFJLVFcvQ3hJcStNY2daYmlOK0NEaWN6c24vbWNLTHpzTnlL?=
 =?utf-8?B?MTlmSDNnRDBKNmxaVXk4aGZlTVdyVU5JRWIrOGFMekVHckczMmJMSUd5dEZh?=
 =?utf-8?B?QVZZcXNxUDduUUUzVHdwS2U3U1l6Mkxzc0VMUm1FbEZCNFhVQ1NhTnM0dU91?=
 =?utf-8?B?bW5sRDIyTVJYeHNiVTdSR0NTRFN6c2JpY1p2NzRKdlBCSzV3bTc5bzU4V1p0?=
 =?utf-8?B?TXNOWnpTZTdsWnNkVi9sUldwL096M3Q5UU1NVlV3aTFBa2dPeU1BeFI2Qzdj?=
 =?utf-8?B?WkVKRkcwVWhZUnpmdFpFem1lWjAxalh4QnpaL3JvcE4rYTRlc2YwOENxTjMy?=
 =?utf-8?B?SWpQMWZYS3BvUjZsT0hKb0JnMzlxZEZlQ1B2VStvUlowaEVENGE4WHl1anZN?=
 =?utf-8?B?SmhNZnQyR2R0Ty9WaXhxMlBadEd5aUxKWitPeG1DQkxPM1QyME9TdmZHZTMr?=
 =?utf-8?B?R3JTU1NNalVRcy9wclQzT1Z6c1FPaHRtWE11Vmxxak1Rb0lWZWlnbHpZUWpn?=
 =?utf-8?B?QmJwV1FWZXlEd2VPSU04NHMrMzJGakgwOHl6eVNqYXU3SGlYWVhhRjVZaGwv?=
 =?utf-8?B?QXZZQnRzK24zUGs2V2tBb0M3UEJ3dW1JM0dTMXlDK25ySFFEYUdVMkpBSEtr?=
 =?utf-8?B?cW1SYzZJMWNDNGpWNEtyM3VaSTYzalhTd00xT0J2MjUwbnJFQ0gwckNKOEhM?=
 =?utf-8?B?R1JTZENKQ2c4MG0vQ0t0OFhWMDc5ck03S1NBbEV1dlEwUjBpK0FSVjdhelIw?=
 =?utf-8?B?RTRnNGkyOGpBTHFFNjJXandkWUVraUpwc05kUlF2MWJ4QUo0TjZrWi9xRkdj?=
 =?utf-8?B?cGdXZUlsOC9qVkVzTlB4cDJsYk1CT1pxQXo3SjBSMVk5Ynh4ZDEwVVE3Y3V4?=
 =?utf-8?B?OGN3VDE4dHBGNGVkcVdwNWM0eEhmbVU4M1QxSnhqRTJYMTNGSU9maFN2MVB4?=
 =?utf-8?B?MGdTalVQWDhyd0M0S3dYYmg0WW8xMWV1RUpsclZtVGMrZ1hpbUtnRHZzMGYx?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCDD0FA73F5A7D4A91732E766E4DADF8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tRKcMBJrRRtJyz9hrIVqTKvntDzNMkwK6ErT46VoRGDCPb6WyyqykAUU68BfvFu7SdBVldwLl9lZ5xSsqXDHpW7PHrggn6ifn96VslrxANM/h1521WdH3LlwRyYzLsLJHzszzCKx6SnG/DE6P76jMwg4y7pLDVimkIsYgKt92OtnHWxCzx1svKg5Y36tHpQmok+hyPKQubaD/Sc1gWh75MMkvYWXoddfH53TBBH1akJF2i5bgXaS+Dzua9cYpkFKQETgnWa9M6wTc+XZH1iLy/fp5046LthSZybeYRjsiVTQ/bSfugsdxAkodHR+4xRwKC4jtO5IBnpdA5qpJrrkYANw7rOSMivMXktM38sx2AOtK9aVp+bqBef1ZzXOungHVaNomArVQX9xyqaxu1ygGvPklmSgTOira7ct8oyV6wNut1/MXMtA1MiAI0gKik8WzsD0tqxHi9pcy3SSEQKCXWI1QEQV5oS+dAmUsFCyIt2qSKLjVXI7Cl1a/8YtejCpkZoPIR2sHym9KUQ8n+iZ2V3JDddf3KLQw2awlXVgYeDL8P28Hm07ePSh9v2TlYIg0l4wWBHLlq+aM9Mfotv8Ox4wUe0I6IzjNXpHTlH5RAQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acabd98b-a552-458e-b98e-08ddaaed21a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2025 02:42:40.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D96ugl2y4VvqIBALNllNDT4AEq0bq3zzZNWScVO8vE2MzbsuWyXWJ9WnQfgMFMixCRa0F8fK6O9Ww0/oQzxBFs/kO7P1uk/a7XExz0sVhPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506140020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDAxOSBTYWx0ZWRfX6yigv0hnH0KL xC1Q55xCTFaToUOvIMIzISCbyl1KmEjEcNX4jkj4Or4r3nYzXBLMNqGcq5tc+jHiqmtCSK8SooK CUiI6f1n0LuYlFs4FvndKj/Azd6pRYgH0wZUofTxEr7EUvQFceKAYvrtaR5KvuljkE4JW8ilMhJ
 mPu/M0KlCwAieqDbOmfOQw1G3cuOuQa+XeChMTdIKDTZxkSF4ph/aEtaR8BKEHZDeAadNqfy6DM g2hLmcySPP7sBImi9wIv/P1BAhaZfmgqPwD5pw4o2lcq3lDXJ8fW7TAd4hKtdSZdhR04iTT1lQm qX8zRjcpErPOAqBvwzqkuc9XArnV70t9sAXNNI2hTysmlQMExgmJ8yjx0s/qAAeYaEIw5L/INQO
 odmz3PzZsVxTXxwVf3YQI58bEARVUPS/1Asc7Nf/G5IlsYOoq57dnJOlL7DzRFLh2fqrUYGo
X-Proofpoint-ORIG-GUID: l_soDUAWTHbWLY7MXqzD4nuD9_066lpE
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=684ce1ab cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Aho7h3fPHJj9N4grZ_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l_soDUAWTHbWLY7MXqzD4nuD9_066lpE

T24gV2VkLCAyMDI1LTA2LTExIGF0IDE4OjM5IC0wNDAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+IFdlIHdvdWxkIGxpa2UgdG8gaGF2ZSBhIHByb2dyYW1hdGljIHdheSBmb3IgYXBw
bGljYXRpb25zDQo+IHRvIHF1ZXJ5IHdoaWNoIG9mIHRoZSBmZWF0dXJlcyBkZWZpbmVkIGluIGlu
Y2x1ZGUvdWFwaS9saW51eC9yZHMuaA0KPiBhcmUgYWN0dWFsbHkgaW1wbGVtZW50ZWQgYnkgdGhl
IGtlcm5lbC4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgYXBwbGljYXRpb25zIGNhbiBiZSBi
dWlsdCBhZ2FpbnN0IG5ld2VyDQo+IGtlcm5lbCAob3Igb2xkZXIpIGFuZCB0aGV5IG1heSBoYXZl
IHRoZSBmZWF0dXJlIGltcGxlbWVudGVkIG9yIG5vdC4NCj4gDQo+IFRoZSBsYWNrIG9mIGEgY2Vy
dGFpbiBmZWF0dXJlIHdvdWxkIHNpZ25pZnkgdGhhdCB0aGUga2VybmVsDQo+IGRvZXMgbm90IHN1
cHBvcnQgaXQuIFRoZSBwcmVzZW5jZSBvZiBpdCBzaWduaWZpZXMgdGhlIGV4aXN0ZW5jZQ0KPiBv
ZiBpdC4NCj4gDQo+IFRoaXMgd291bGQgcHJvdmlkZSB0aGUgYXBwbGljYXRpb24gdG8gcXVlcnkg
dGhlIHN5c2ZzIGFuZCBmaWd1cmUNCj4gb3V0IHdoYXQgaXMgc3VwcG9ydGVkLg0KPiANCj4gVGhp
cyBwYXRjaCB3b3VsZCBleHBvc2UgdGhpcyBleHRyYSBzeXNmcyBmaWxlOg0KPiANCj4gL3N5cy9r
ZXJuZWwvcmRzL2ZlYXR1cmVzDQo+IA0KPiB3aGljaCB3b3VsZCBjb250YWluIHN0cmluZyB2YWx1
ZXMgb2Ygd2hhdCB0aGUgUkRTIGRyaXZlciBzdXBwb3J0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEtvbnJhZCBSemVzenV0ZWsgV2lsayA8a29ucmFkLndpbGtAb3JhY2xlLmNvbT4NCg0KSGkgS29u
cmFkLA0KDQpUaGFua3MgZm9yIHRoZSB2MiEgIEkgdGhpbmsgdGhlIHNpbXBsaWNpdHkgb2YgdGhl
IC9zeXMva2VybmVsL3Jkcy9mZWF0dXJlcyBpcyB2ZXJ5IGFwcGVhbGluZy4gIEkgYWxzbyBleHBs
b3JlZCB0aGUgaWRlYQ0Kb2YgdXNpbmcgYW4gaW9jdGwgdGhhdCByZXR1cm4gYSBiaXQgbWFzaywg
YnV0IEkgdGhpbmsgSSdkIHByZWZlciB0byBrZWVwIHRoZSBzb2x1dGlvbiBhcyBzaW1wbGUgYXMg
cG9zc2libGUgZ2l2ZW4gdGhlDQp1c2UgY2FzZS4gIElmIHdlIGRvIG1vdmUgZm9yd2FyZCB3aXRo
IHRoaXMgc29sdXRpb24sIHdlIHNob3VsZCBkZWZpbml0ZWx5IGFkZCBzb21lIGRvY3VtZW50YXRp
b24gYXMgQW5kcmV3IHN1Z2dlc3RzLiANCk1heWJlIGEgcXVpY2sgZGVzY3JpcHRpb24gb2YgdGhl
IGZlYXR1cmVzIHVuZGVyIERvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1rZXJuZWwtcmRz
LiAgI2lmZGVmIG5pdHMgYXNpZGUsIHRoaW5rDQp0aGlzIHBhdGNoIGlzIGxvb2tpbmcgcHJldHR5
IGdvb2QuICBUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhpcyENCg0KQWxsaXNvbg0KDQo+IC0tLQ0K
PiAgbmV0L3Jkcy9hZl9yZHMuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbmV0L3Jkcy9hZl9yZHMuYyBiL25ldC9yZHMvYWZfcmRzLmMNCj4gaW5kZXggODQzNWEy
MDk2OGVmLi40NmNiODY1NWRmMjAgMTAwNjQ0DQo+IC0tLSBhL25ldC9yZHMvYWZfcmRzLmMNCj4g
KysrIGIvbmV0L3Jkcy9hZl9yZHMuYw0KPiBAQCAtMzMsNiArMzMsNyBAQA0KPiAgI2luY2x1ZGUg
PGxpbnV4L21vZHVsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQo+ICsjaW5jbHVkZSA8bGludXgva29iamVjdC5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2dmcC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2luLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvaXB2Ni5oPg0KPiBAQCAtODcxLDYgKzg3MiwzMyBAQCBzdGF0aWMgdm9pZCByZHM2
X3NvY2tfaW5mbyhzdHJ1Y3Qgc29ja2V0ICpzb2NrLCB1bnNpZ25lZCBpbnQgbGVuLA0KPiAgfQ0K
PiAgI2VuZGlmDQo+ICANCj4gKyNpZmRlZiBDT05GSUdfU1lTRlMNCj4gK3N0YXRpYyBzc2l6ZV90
IGZlYXR1cmVzX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBrb2JqX2F0dHJpYnV0
ZSAqYXR0ciwNCj4gKwkJCSAgICAgY2hhciAqYnVmKQ0KPiArew0KPiArCXJldHVybiBzbnByaW50
ZihidWYsIFBBR0VfU0laRSwgImdldF90b3NcbiINCj4gKwkJCSJzZXRfdG9zXG4iDQo+ICsJCQki
c29ja2V0X2NhbmNlbF9zZW50X3RvXG4iDQo+ICsJCQkic29ja2V0X2dldF9tclxuIg0KPiArCQkJ
InNvY2tldF9mcmVlX21yXG4iDQo+ICsJCQkic29ja2V0X3JlY3ZlcnJcbiINCj4gKwkJCSJzb2Nr
ZXRfY29uZ19tb25pdG9yXG4iDQo+ICsJCQkic29ja2V0X2dldF9tcl9mb3JfZGVzdFxuIg0KPiAr
CQkJInNvY2tldF9zb190cmFuc3BvcnRcbiINCj4gKwkJCSJzb2NrZXRfc29fcnhwYXRoX2xhdGVu
Y3lcbiIpOw0KPiArfQ0KPiArc3RhdGljIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSByZHNfZmVhdHVy
ZXNfYXR0ciA9IF9fQVRUUl9STyhmZWF0dXJlcyk7DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgYXR0
cmlidXRlICpyZHNfc3lzZnNfYXR0cnNbXSA9IHsNCj4gKwkmcmRzX2ZlYXR1cmVzX2F0dHIuYXR0
ciwNCj4gKwlOVUxMLA0KPiArfTsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dy
b3VwIHJkc19zeXNmc19hdHRyX2dyb3VwID0gew0KPiArCS5hdHRycyA9IHJkc19zeXNmc19hdHRy
cywNCj4gKwkubmFtZSA9ICJyZHMiLA0KPiArfTsNCj4gKyNlbmRpZg0KPiArDQo+ICBzdGF0aWMg
dm9pZCByZHNfZXhpdCh2b2lkKQ0KPiAgew0KPiAgCXNvY2tfdW5yZWdpc3RlcihyZHNfZmFtaWx5
X29wcy5mYW1pbHkpOw0KPiBAQCAtODgyLDYgKzkxMCw5IEBAIHN0YXRpYyB2b2lkIHJkc19leGl0
KHZvaWQpDQo+ICAJcmRzX3N0YXRzX2V4aXQoKTsNCj4gIAlyZHNfcGFnZV9leGl0KCk7DQo+ICAJ
cmRzX2JpbmRfbG9ja19kZXN0cm95KCk7DQo+ICsjaWZkZWYgQ09ORklHX1NZU0ZTDQo+ICsJc3lz
ZnNfcmVtb3ZlX2dyb3VwKGtlcm5lbF9rb2JqLCAmcmRzX3N5c2ZzX2F0dHJfZ3JvdXApOw0KPiAr
I2VuZGlmDQo+ICAJcmRzX2luZm9fZGVyZWdpc3Rlcl9mdW5jKFJEU19JTkZPX1NPQ0tFVFMsIHJk
c19zb2NrX2luZm8pOw0KPiAgCXJkc19pbmZvX2RlcmVnaXN0ZXJfZnVuYyhSRFNfSU5GT19SRUNW
X01FU1NBR0VTLCByZHNfc29ja19pbmNfaW5mbyk7DQo+ICAjaWYgSVNfRU5BQkxFRChDT05GSUdf
SVBWNikNCj4gQEAgLTkyMyw2ICs5NTQsMTIgQEAgc3RhdGljIGludCBfX2luaXQgcmRzX2luaXQo
dm9pZCkNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIG91dF9wcm90bzsNCj4gIA0KPiArI2lmZGVm
IENPTkZJR19TWVNGUw0KPiArCXJldCA9IHN5c2ZzX2NyZWF0ZV9ncm91cChrZXJuZWxfa29iaiwg
JnJkc19zeXNmc19hdHRyX2dyb3VwKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIG91dF9wcm90
bzsNCj4gKyNlbmRpZg0KPiArDQo+ICAJcmRzX2luZm9fcmVnaXN0ZXJfZnVuYyhSRFNfSU5GT19T
T0NLRVRTLCByZHNfc29ja19pbmZvKTsNCj4gIAlyZHNfaW5mb19yZWdpc3Rlcl9mdW5jKFJEU19J
TkZPX1JFQ1ZfTUVTU0FHRVMsIHJkc19zb2NrX2luY19pbmZvKTsNCj4gICNpZiBJU19FTkFCTEVE
KENPTkZJR19JUFY2KQ0K

