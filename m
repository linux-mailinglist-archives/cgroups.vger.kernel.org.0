Return-Path: <cgroups+bounces-5733-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC59DFED8
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19D0161692
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB561FC10E;
	Mon,  2 Dec 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VURg9/vY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RI/MqU8f"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DD1FC10A;
	Mon,  2 Dec 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135225; cv=fail; b=pEO6d8VSB2JjlXnBRVLtVmSgZe039EwTtzfkKoDzK+01ZTpL+Q/am0sxn0Wb3X2rS755/+qeJJKumpNpWLskToDdn0f7rH7NNtDB7yYh/jTlT7zEziilTO7L2of7ypa6eHGpySUF7fyD2fRgczfPeHxgeQfQ/Z1uTgiZJrYJx2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135225; c=relaxed/simple;
	bh=NFaB13FKrfdqeS6DLbOmFYYGjB07OEBsmCmQt2YwTgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ty/7Xm9muEZ9YS0QTjIBQgUCRLT5/amXh1Z5Bx+byron2dDkF7yBuRwq2sd4RZLbD2lC/zUSYgCOuuzi5ckCX5KCyi7sLg3eNo4+zyvqtrsCARhSah+sUyZeZ82iJYH+loQnD9vN3/C6PK1cojmZh0XKT3aqUkzJkor6tE5UBFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VURg9/vY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RI/MqU8f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26X0VD015045;
	Mon, 2 Dec 2024 10:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OFh69IG+iHDBAAGAXD
	Q433nSc+FEBUdfaObEFeRWfo8=; b=VURg9/vYbXQDo5TeG1uF2yCXZY0OIrlwAZ
	HfbLhPa2FBxKuumM8E1zApbjV1dUhzCYIFK/JiKpwZhKqQfZJ+S+LvnPGAPIL8/y
	t1+N/wxbFIVFJh233KBm0+65TG1h7sWoDfcfk5qZ1B1/3FEIx6IHteVqiDXieoRd
	ye9KMh9esN2kEOv12EFJGXJ+mPGiPx9qOXrMJgUKvnfR0qy+2KhFp0rMusVt1nL+
	leSzn2NUWdZCJPozGorVv0SPFejtT/qQGiDDiEOKwTG1Mp2d9UCutOsIhrFKO0F0
	N6Pf4iIOM1FlXwdlfw5Q1h4TEs1w9gcFB3l5GzHs9A2TPS3Q5x/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smaaj0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:26:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28YVEn037167;
	Mon, 2 Dec 2024 10:26:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s56pqf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khIPC3MadWQcRZgVJH4Nqoz5TjDhWtX/erkcgP7Ukse8pySrjgcJBLENQXLcK7riyEmtLUm/yK21Mn6+fFjQIe1+so80/AjsLmHzE9hnTr1v8l/vtzVTNe7WKbqXanMxVkHqsjn4S565aN0px3cg+zm60dE4xInq6gq02cXhqC9Hd9piisw56UQaEfU+wDhgSTn34WpBU++UjwFtSQZO37cVI91yvfmpOAtDGo0or2xi2bQNSb6phg2tcN9DFqWHcKOi0WMaizQfoKaLAiq2x2wb3WG1vL3XROmx5Xo4AVeDl61acV1HzxBuNxY509sct/HkT+NSzrQLyeXZZ2rqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFh69IG+iHDBAAGAXDQ433nSc+FEBUdfaObEFeRWfo8=;
 b=D5xrdJasnVwqiN/d3nGWYSOe5E4u5TS7NMerlZUA0rbPW/XwVwaVL75Fj3s9wakv6cqwOkIhi0ydoDKPjKgo/lkb6TNnaqZa6G9eE9nNOJdLxKwsU7PBcWm974Dcez4RJdstBLWymV1jPPy5xo3nyNkf8Mv3A6T0Vjn7H+Z0V5kyTPqV4UDGYvp6tMUtEu7zJYiyL5gv3QNl9UmBaxVxSLbk5vreKaPY5j4gINYJswCy8Wz4gYkY0I50U5PD0KxkfTqGXer5kEF9TVYvtKv7Taa36F/bwCLZA7u8BGglXCQng17sGg72hMAm6hytMU8gnA9RnWzi6P5URZEAaOxxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFh69IG+iHDBAAGAXDQ433nSc+FEBUdfaObEFeRWfo8=;
 b=RI/MqU8fs26RYIFFzRv1PQn4zDMVBlPqS0oFM5b+urwxdzyeFeO/htCI5Ozm0nHYEgxZTUl8FKumywsSYt5XGcmmPUuDrM9/fp5f+7LYC2+oImcw/r8VZ5fEyNVwoZJRVDrx1g7b6UGX4zLh3187k34dIGRm6eNDqHhAJ2Au7LQ=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by BN0PR10MB4872.namprd10.prod.outlook.com (2603:10b6:408:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 10:26:55 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:26:55 +0000
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
Thread-Index: AQHbRKS15T4HRONl8EGHQEYTD7LhXQ==
Date: Mon, 2 Dec 2024 10:26:54 +0000
Message-ID: <9953011d972d0ec2f38792e985aac55f2e4fda2e.camel@oracle.com>
References: <2024120235-path-hangover-4717@gregkh>
		 <20241202101102.91106-1-siddh.raman.pant@oracle.com>
		 <2024120257-icky-audio-cf30@gregkh>
In-Reply-To: <2024120257-icky-audio-cf30@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|BN0PR10MB4872:EE_
x-ms-office365-filtering-correlation-id: 1e3c5dca-7011-4d49-d8b7-08dd12bbd813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0V3dXlPbmpINjVBOTduSHBWNDNVMlFtbm9ocnIvR0V6bExIN1poREtBUm8y?=
 =?utf-8?B?UzZFUnNHTk9MV05SbE8vc3VLd0RXbEhDeTZZdWVlZzdYRXRVNzJYYW9aUlh4?=
 =?utf-8?B?SzRPY3NWa0ZDNVdKR3NBUHpKNGRUbVkzMjFYUXNydkw1dVNrYTFsUWY4RXY3?=
 =?utf-8?B?S3dzOFVYd0huYndpd2c2REN3TFRVSGVNOFd6dmM2TmdOYnIrakNicENFZ0k5?=
 =?utf-8?B?eXBlenFkY3AyczQyanFpMFg4Tmx0d25zV05tT3cwUVB4OGRLem9ZOWhyNVNQ?=
 =?utf-8?B?NCt0eFZnQ0NFY0dsZk5LUndjMjRieHVJL0JPc2VRSmEweHZQTDR2MUdtS093?=
 =?utf-8?B?WkhIU2FscHVWa0ZaVjBoSCtpa3Q4SDUreFZUdERIVklNeGlKaVZOK3dGUElt?=
 =?utf-8?B?NG5EMi95SXA5Ri9yU3JxZzhoQ0pjL2NCd3NSdllrWVg2VGpUOU1IODAwMUh0?=
 =?utf-8?B?ckkwZFRLVUhjOGdDWGp2VlhiWWlPdlNTWnZJUWNIMnVrNTFJeWJOY0NzSzVo?=
 =?utf-8?B?K3VJOXl2a1lKdk52Z2E2a1ltc0kxbHhibUh1V3YxeTlZcmV5aUh5dkpZZi9U?=
 =?utf-8?B?R1RDU24vQlZUVTJaWmYrTVFHVTBEV0JPV3Q2cVNncFpjMTVxMHVCWWlaaDht?=
 =?utf-8?B?bGl1QnZSMjZjaUZSejV4RmR2cXgzVGlyT0QySWNld2hLOXRXZjFNamp3ajMv?=
 =?utf-8?B?UmNURWxwZjc1MmlQQU9QSEdSeGhUdHc2c1AwWUdlSUJjQUJSWCtHcmJFTmsr?=
 =?utf-8?B?SmVKT3QvdjZaMTcwZzFqSGYzOTYrQVplNkl3R012KzY3blQ0SytsTlVGTERn?=
 =?utf-8?B?Tllpb09oM0N6TTRtZFUySWJvZ2JEUE01Q2ZjdVFiOExTaFVqVzhPdjZ4MUFC?=
 =?utf-8?B?a1NBZU0zazdNS000VDQvbmp0U3o1RjMzR2Nnd1JHc2lVS3hSbnpMT3A5OWtZ?=
 =?utf-8?B?UWF4TmJMUHkrR0Mxek1YRFRVZlZEMVBlaW1pOWp3NmNralk3cC8zSHJ1TUt0?=
 =?utf-8?B?a1NocUFabmZSVDUrc2F0THZrRW1mL3hQcTB6MFgxcFFpc2NVUnBiazZoNXBN?=
 =?utf-8?B?UkhUT3pWR0piZVRLdXBiNnFSVzVCU0g1MnpiOWdNOXlDYzdJWWNReGhnRVph?=
 =?utf-8?B?NW5mUkdvc1Z6dGx1RDh6bnFDdEUvUjZGSGlkTVBTcFRuNmt1UXdLK3IxZUlX?=
 =?utf-8?B?aWt1K09wOFM3YUdycDJxVjBSUHVoeTBUckZtT3FDaWpPdTVvbFZITVAvaHlk?=
 =?utf-8?B?NUZ1YVljRkF1eU43VDR1eHJzcDlaWlhNYlhyZ09OSm9sNDM4T2p6WkZZRS9V?=
 =?utf-8?B?T3FPcDBWSVE0QmtuemdaVVRpVHRqbldWemxvYWNNNlBrV0JLcmNHaDhndWYz?=
 =?utf-8?B?NGhzT1k3YzM0ZFQzcGduNm13UkpZMDllcGNCc0R4VFc5Nlo4cE9DK3ViSFVO?=
 =?utf-8?B?MEtxdXBOTFYrald5V2pvYzVTZWN1VjR6MU1YNVpQeXc2bjVBamxjdFlReWtZ?=
 =?utf-8?B?bFMzOFV0N3Z4RU16SG9YSExCcXA2d2NwZGozUkowa3hJWlBRQXJzQVh6L1pN?=
 =?utf-8?B?UXk4aTgwaWNUelE0TkNhelZjUlExSzUyTWZRZXJ0dk43TEw4eGNxWUo0RzBk?=
 =?utf-8?B?NFA5WDNFSmcvKzNtTkhwS013QkZ4VmdWU2dOODJjcWxXUVB2S1VqL00xSFlk?=
 =?utf-8?B?dnMwY3M3ejBoS1lmNG8vQzNENndWM3l0d2psOERaSkpZS29rZWFORnl6Umlj?=
 =?utf-8?B?Z0dNMUhmbXVxOWZRaUFCVWhZTE4zUDJod3BmTFc5MDcyUzFSTFUrVDZIcXdG?=
 =?utf-8?B?LzZuaDdtQ2MrM2RnMStCMzAwQk5vNVdqU053V0g2cjFKRnpQN0VQSlVqeVMv?=
 =?utf-8?B?R3h2cXYrQ3FlMDNraGVzcURvUnVHNXpYOGE2MmJDMEQyVnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUhrb2hoZ285aEd0bnBkZUx6MXUvSFBJRDg1V0h3UkRqb1BhMitrVllTMjh2?=
 =?utf-8?B?anpYbDQ1Q2d1NDd0U1BOaG96bzZkcWM2T3NlcTludUdkdElXNEczRklXbDdu?=
 =?utf-8?B?MDFoMHRMdGJyN3JmK0k2Uk1jNHFSaUdBR29DYzhxMlAxc29VejNEUTU1UHIw?=
 =?utf-8?B?REhWcXpUdkhxdi82OXQ5a1ZUcncyVHJIQUlhaStZcWUyQ1d0WTh0SU5RQ256?=
 =?utf-8?B?UUxGSjFncC9uNGs3cWt3RmRCcFloaHBwd1lhSDhNU0dibVEzTUc0VTFSNVlU?=
 =?utf-8?B?aEZTZHkzVjViNkZ0WnFKeExVN3VzcncxVkM5Tm5SdVZUdGNrcCtYRzJWQXQ4?=
 =?utf-8?B?YW1BQWJLbXE3djFBTWxOdXNLcEtGSlE1ZUdwL1c2YmFuWkVGUlkvTXF4VnZx?=
 =?utf-8?B?L3hYS0M0djhBTHVndFFvTEg0VkhaOHBDR3NMcTQxV1ZaanhwMVhpWVJ6VzBW?=
 =?utf-8?B?MktGOVlDVXIvQStSQTVma01Sd041OWdFUHVUQTNBbU5pWEZBV2E4T0t0c1lr?=
 =?utf-8?B?elhvY0ljYUhLeWl3Q0cwa3BJcFZQbkNvOXRLVjhSL1FiR2h0L3MxbHIyNFFs?=
 =?utf-8?B?NDNwZVVobStSZERHUWh3VWdEek0xeGViTUJaTDE1M2JHbDF6N3RXU0JaK3B4?=
 =?utf-8?B?WDYvYUtBeWdPTmN0ckFVbkc0dWp4YThnS2pBeWQ4WHA1OW5IcE9SMlVLU01X?=
 =?utf-8?B?TW9yRVRLYk9mZFlGYnVLTmtCYmszNmxQWUVqeGRRMHcxTWJSQU9YWjQ5b21W?=
 =?utf-8?B?M2tESW00dzFHb0FaTEV1ejlZNHF6WmhqcWl6R0pRRi9OSlVDU3N0ZXlTQUlw?=
 =?utf-8?B?WUdPdE91c0xVNEVwSGtvYTBTQWo4dTFLZVVQeE40MGpaNEd3ZDRCeFJEcHF4?=
 =?utf-8?B?aXMyeTQ1WFpoS2xvUW9JU3pLV2NwbXRVM0ZvL1gzRS9FaHdXcGkzOVpVNGx2?=
 =?utf-8?B?Q1FlSjZ3Zi9IanFMUHdIaXJlMG5jK3FjN242azUyUVRhZy85MnpQR0R3VEhU?=
 =?utf-8?B?VmVSUUZoZUJ3QlNGVStsWjVac3VlR0QzNmZRbzFJNFdoQkRUcG5vRGFmd1Js?=
 =?utf-8?B?YnJqWk1uMkw0MUpXTytaemo0VnVwdDVyZHhMUm42NW9udUVybk9TQ1czVGxL?=
 =?utf-8?B?V1p0NTdMUjM5SjVRaDhTeHk3NXZvUHdWdHU1WThIeXFyTm9hZlB6TFdOR1hi?=
 =?utf-8?B?WUZ4UTRDRHlOSUJla0dzTlhxNkdPSUtVS29FWmg2SmxQbG9UYXF6MkcvZksv?=
 =?utf-8?B?YzlZbzJVZExIK1NhaEpiWFJORWJSWHEwUi9FNWpnb0hJVmMyUzJGVFZ1RXVU?=
 =?utf-8?B?WCtZTHk2WlIwQUd0dkcxalpkQ0szU1F3d1AxYWhPVk9VaU4yTkwwcUlMcWN4?=
 =?utf-8?B?RnQ5TVNEYjd5cXlmdTYyRUxickp5RWpZZnZoTGhCZWVORzM3OGtYMGJsZUtp?=
 =?utf-8?B?SVJ4cHlaYzBpYi9JR05CS3pKTHAycTN3aGE3N1hoaU9mWXlvMzZvUmxqNmhS?=
 =?utf-8?B?WThuaSs5R3NFTFAwRC9wcWxDU0NYMGVNYURIK044WnAzdUtmT1VUZDdmMC94?=
 =?utf-8?B?OGFoc0RqcGk3N0NiNlZlYWNYdXlqMU9NZ3VBSzlEai9vU2pxZXkwZ1owbERp?=
 =?utf-8?B?RzIwcGc5cUo5WCtsU2E1a0VJTElXRHdlQVI1amt6dFBzWUlZRFpqYnRIajR4?=
 =?utf-8?B?c2dDNmZ5NVM0TnovRnZwZnBIRVYzb3NKUHBvVHJiOGxPOU5pRU9NOSttQUJD?=
 =?utf-8?B?dWw3OGlvWUVhWm1lRHM3YTFITk9tTVVhbXRsZVp4SDNtZ1ZPSm5GRk9rb0N0?=
 =?utf-8?B?SXJlY1FMcmxnZ0pCdmh1cUdSMmQ2UkRFRjAzZzBOY1o1elRSTE1pMWk5K2VV?=
 =?utf-8?B?VmpsdTBRR24vRmNGWGw4anNreHlSSVR0MVhIazU4bVdUNG9zVmFaMU9Xbk5m?=
 =?utf-8?B?clJVN0NyNFR2VHBhYjlPOG5mSi9kTzNYMUFnMk53emdWUnZBTDFHZnJvcWdE?=
 =?utf-8?B?N05SOUFGcTVqM3ZkOThhWjFyaHo5aFkrb2oxZ3BmN29xRC9YUVRBZ2RscSs3?=
 =?utf-8?B?VjllUktBTENNRGlENlU4SlRpWHliQWExTkRseXFpa3czTnJ4aDByVXdJd3dD?=
 =?utf-8?B?cnVBZWNIN2dOa3NwMWcyN3hHTzQvMHJHbmZ3VERPYnpwY0JQU1dsMnErQjdY?=
 =?utf-8?Q?aqLQQ6H7FoAjb1k7VOMHHic=3D?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Bp4pj7CWrr84fVnkU7dy"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V8VaVybOUZpwiBRF5xZXidsg6MmTV+haQQNG6tkb94BlBdoz9yfrZHR1WKeyfFECYkYqGzHkny2QhJH8+9GmCdmP7tnYW7n4HaDeEFBpmJppK/W1VVa1dbjzvhS+lzy4u7SJMa8E083tVvILjVUAqD+50Ai8P7Exeaa5+2G/DwopSgfA2sSmsAc/O5iFrXT5vs1JWnLeI2vp7OIyCm7/afsncwpJ5YDCI06bX5haAvV1krFaX4z/Neb4ZIBoRW0R2DZW2GyLXjf3cLvoictz+hqS1GqydlaeLpf4I++pUQWFB9OB8CtyfkVv9TiYfbSUEa0kDlMndjeWIoWjMa6Bh3XbBxSAASvCwsX/JG3hanLxRgpVd1eorqRPZU1afRIxfgNE7xsPsxuqfAm4YDr9BqRX+ClOTfcUbinXt4X0mOpW+sWUXTbtj0FTex88vqEHzS8WPZqoN51z3z+mmDDjlKyGJeqY/8/anZgE4YbSpkWcxL/kPyRkRs9JS7/tnApv26ppIt2AViXWghBEKPN481WCCUEEiGNxSWDa1GsEE1BsGh6ckXbSlyZC0Npq1GuloaEFrsyJuyUQpyzloHdsN9Mv4HVs8hXKeyBaLqWTUU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3c5dca-7011-4d49-d8b7-08dd12bbd813
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 10:26:54.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0x1N8f59H74pjGaVwGKzfOFetW2LyaP25aOfVUi4ZuYG+YrV/4Ygw5I3bblXmviFLV+5BhwEIL3vRjppgUYvj2oTn0GTvPgxaDSALkDIjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020092
X-Proofpoint-ORIG-GUID: WOhhWkrG0FHX5mnPBhQh6jyneePWDS9T
X-Proofpoint-GUID: WOhhWkrG0FHX5mnPBhQh6jyneePWDS9T

--=-Bp4pj7CWrr84fVnkU7dy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02 2024 at 15:47:00 +0530, Greg Kroah-Hartman wrote:
> On Mon, Dec 02, 2024 at 03:41:01PM +0530, Siddh Raman Pant wrote:
> > From: Yafang Shao <laoar.shao@gmail.com>
> >=20
> > commit d23b5c577715892c87533b13923306acc6243f93 upstream.
> >=20
> > At present, when we perform operations on the cgroup root_list, we must
> > hold the cgroup_mutex, which is a relatively heavyweight lock. In reali=
ty,
> > we can make operations on this list RCU-safe, eliminating the need to h=
old
> > the cgroup_mutex during traversal. Modifications to the list only occur=
 in
> > the cgroup root setup and destroy paths, which should be infrequent in =
a
> > production environment. In contrast, traversal may occur frequently.
> > Therefore, making it RCU-safe would be beneficial.
> >=20
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > [fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
> >  ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
> >  codes")]
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > [Shivani: Modified to apply on v5.4.y]
> > Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
> > Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
>=20
> I'm confused.  You do know what signed-off-by means, right?  When
> sending a patch on, you MUST sign off on it.

Even if I'm just *forwarding* the patch already posted on the mailing
list? I just added an r-b for the patch because I reviewed it, and did
no changes.

I'm sorry if I mistook the convention. In that case, the previous
patche emails I had sent has the signoff. I had thought that was
incorrect.

Thanks,
Siddh



--=-Bp4pj7CWrr84fVnkU7dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmdNi2gACgkQBwq/MEwk
8iooOhAAhonS0MQxXJoF4jifa3vwtpX1fMazGN1c8eMAIBU3BqIty84ivhZ162fn
RAL1S2igl4K52SZj+R8IgOvfNSWR0gtUAhqZwo6ZWMheoUdsoJ0Kn093y3xlxIH5
1yV9cjuaVjymwe3P6OcEZB9OZTX/Apf0Yn8tNzl6QWsc39E/WcRo2RxaOBtmGhy7
ShrWeShcQDcHh1vU9nOvytv69klgjJjEnMAuMniqCjWbuBqtMuUwX8blo5ba9BYC
9E6cD3d4MzVXZogxnSU0lSMB+qWZj7Ix9NjjF8uoeiX8SayDthdxahVkVkuvpeHV
JxKwP9zW2lan/ha8rIFFkF8OKhV6CJ+8jyly9a8fCWHwaKieBlshkJUZjHecsFx1
6y6pPN4nGtIp7BB19OMbbuQrwfSBH1MfAUzqD0iiJahWjgE3eZIfoTCN/tAeGtGd
SIY5rK4JwZrQXPfPWA7g492poHA6jtJ3ZUumH31hVuH22uW8zWj3TAuXl8gKjIib
LK3CITjT6ZiFdMLeKb6hGTdgVrTqSS01tjM3xcGIrP4TQ5n+wQDBQL1V3+RAsJOv
MQMecnyVwBUS9m1oqLM2zC93iFM0c/LrgKogVeTKz5fahCzffWZdsuAytuaiuGqU
4PDAN+MRmfrLz9jUk3dKjH5vfbA3jVqD5CRy0h8pWFyMtE7H92Q=
=qxO7
-----END PGP SIGNATURE-----

--=-Bp4pj7CWrr84fVnkU7dy--

