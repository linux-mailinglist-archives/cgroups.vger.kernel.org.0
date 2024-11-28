Return-Path: <cgroups+bounces-5707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF909DB5D9
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 11:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFF1B2129A
	for <lists+cgroups@lfdr.de>; Thu, 28 Nov 2024 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C71917E7;
	Thu, 28 Nov 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R82qbTOz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C4B+TPrG"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF821428E7;
	Thu, 28 Nov 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790423; cv=fail; b=IRKukBS0+MZmPYwibVEuW8rSXoBqoFRbQYD0jpT+si32Y99bVNMjGYHYg4UAYlFV6Dq+h5EEiVYOzWjOL7TnCy0/KcbcaGfcX3/PYp/jkFzTu60QkDTlqxcOC4iunbwZTP4KsZvw61qblnMZYUHGVJIoSTJLp3Idn5Bf4FeUDj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790423; c=relaxed/simple;
	bh=MAgRW4fGcZpfM++vntCy7KONtPd3vw5J9PEP7AMjmrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crlys/ZeQuadUUMYvXw2rjOuToAt9oXLxVXayvtdbuIQ0Ql6202Nusklqz0vgzLAJP+nzI5MndIRLNyyDSCwvgIOxl49Ct5khh1I1lxxOmReIQBtf/6Hbv8vPvsp8A6vpLpOMYKh1ZapnnQxFulhsvmPAvhcuD9ldUwQF9DbAVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R82qbTOz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C4B+TPrG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS3th6Y027535;
	Thu, 28 Nov 2024 10:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SR9u2hm2eCWY8O/r9L
	o3SoJAj/hW6kT+200huYj4f54=; b=R82qbTOzKowROy6Ok0Ybkhiu7LxSOdBzC/
	ycvqnxsRcQDamGn+04lc3qDvW5DnTQ0a3bc02WtFaJ0XIHmt7JR6THxaLwAh9gcW
	5OrmmWyUddgph/Hbi2ojdqoLEzR038NhGpMH1mVFBfNtecplr4hsIOZFmgah84Fo
	Ns+wC4IH2Hk/yP3cyAu+0zRqz44KL/eYOrMWcP2etYZYFEdJaEcgHc/tXNc3XirQ
	ZHeRg4LUaVAQpkJo6f95ISng2h0uYtO/Bl8TJNNDAjjit8zQ3ip9aKLtWiGgJqsA
	iMYCP02F54VVLRBS0sgiYaulcoDuquoqrV50rX5aaZG/8JE0VfAQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xw9n8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 10:40:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASA0iWj018036;
	Thu, 28 Nov 2024 10:40:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 436705fke5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 10:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAEIP1JN42YJOMXfI0T+mWvjYzQwmqM/1QI/yEfOkE51uPzoxNuvz6zaXSZhev0tUkh2hKYu850hkSZB3gDgo5eR9WekaLBIxsT8tfKGHyd/kvWT//50p3Hiy+joF2WwcQ6WiK2Yl9EqRuMO9inLXPOBv8mBHkrudnGPZXsRldH7MgIcRUP1NLKkGFPuvEmUbOH1QQuSu2Fz6iFRtRlfwOnh6AHdTCuboPkQe/2IgD2RXR7bnCM+8b0fDRVo9XdBu8wLWpy7nhhEvx/QryOhTRkclLXtSIH/JOy+Tj0BCP6do7QnBs0jDUOR6AWw+dTNWP9J8uasrj46cQQ+O5UBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR9u2hm2eCWY8O/r9Lo3SoJAj/hW6kT+200huYj4f54=;
 b=DYS5WVc9Fc+LrbkbCaukmS1z5JUBDd4Soti6Qt5IcC0jgjj6YUVx8ZaX6ef4st+8csyy9QS0ex0/tsiAzaIgh0X9l1ym+FvmV9dNgMQfouUkhIrpwO+efUm5/AzEL2CO8ovvYdyfizb0fmB01lyZyuYuqibZcLy4xmXxqkXlRdLbyvGIiCgaz4EkCD3Vh5p+HkpkVezi5JsLlD4Gpy3pVKW5C4bzsoAiLFuwU/1/rv0FZU0K3k9MQcyL5JFO+Z9K5u8Yq3QlpfNaun/5kq7xUrE2PWRg4fccsi4WtHCOgf79TkxdGlRhmghoq/4o/OXsJbA4eAWUZNmv4XEgmOR3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR9u2hm2eCWY8O/r9Lo3SoJAj/hW6kT+200huYj4f54=;
 b=C4B+TPrGkouw8Q5fZMbAqhQXd8AO+OGYn72l8NhidE134zY23QsKDxmFyaVSgI85GSyS5Tks671evXck4fEuzpmIMn3BGN4AJhTisq32PwbqJLF/u7oyL0H8wSMl6ByW/U6qURl2Nk2gILW2cjPrdpk5kjGvP4XVHJNx3lp69Vw=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 10:40:07 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 10:40:07 +0000
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
Thread-Index: AQHbO3RJTnEZKa3/rE2kyyDqje327bLMjNcA
Date: Thu, 28 Nov 2024 10:40:07 +0000
Message-ID: <12665061977e5583134b19bf471fa02e12bacf3f.camel@oracle.com>
References: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
		 <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
		 <2024110612-lapping-rebate-ed25@gregkh>
		 <6455422802d8334173251dbb96527328e08183cf.camel@oracle.com>
		 <c10d6cc49868dd3c471c53fc3c4aba61c33edead.camel@oracle.com>
		 <2024112022-staleness-caregiver-0707@gregkh>
	 <2bb366f53aa7650e551dc2a5f5ec3b3bec832512.camel@oracle.com>
In-Reply-To: <2bb366f53aa7650e551dc2a5f5ec3b3bec832512.camel@oracle.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|SA1PR10MB6592:EE_
x-ms-office365-filtering-correlation-id: f33e1ed2-4292-4d83-559a-08dd0f990707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXRiN3N1NlZmai9HU1Nyb1pvb0VSbVVQQXJRbldxem5jakRpTndFVmFKdXNw?=
 =?utf-8?B?M1J2djhGZlo5QUtoNFk3RkJvVFRJTElrQUJSTklUUWlyRnZ3WDRzdk1VSldz?=
 =?utf-8?B?dG9ab3BKaERMdjdqN3NmSERLQWRQc0hEMzE4Z1hKWEp3TmR5bUZFc3B4R0t2?=
 =?utf-8?B?V3J6VWJhS0tIUkNyT0tGUEQxUDlqZGM4bklZVjRTS0JnalRwRnF0QzB6c25y?=
 =?utf-8?B?Kzh4UVVVSXIrcEV4VU95U0lPVDVzNFNqYmpBNXdBaTd3QXdCMWxMVlM3ZjRU?=
 =?utf-8?B?UjhqQlNFMlNraVcrWVNQVjdyN1pHTzd2cDF0SUpOZWFXT3RQcnM4eGN5Z1cy?=
 =?utf-8?B?Z2tsZWZOQStnWU1RWW00bGJTMlZETTUwQXhJUDZWQ3UwR2Z2TndrYVNIWito?=
 =?utf-8?B?elB6blJ4bGpmcFY3Szlac1V0NTVzTk9FR2s3QUR0REJTNlVpNnZzZlQzdkZ1?=
 =?utf-8?B?Qm5JcHZmTmhRb3NIYlZaM2JKem1PTE5HQmNNSE5obEZickZNdUFNYW5VbWNr?=
 =?utf-8?B?dExzNDVpYVViTEZ5QVBTZ2tiajlpWE1wd1htRGJ2WGhsTHdXQjhheEM3VmtY?=
 =?utf-8?B?eENRMXFFS1k3N0tZVHdHN09tRjNxVHZZbWc1bUNvOXpPQmlHWUtZaHZnYnA0?=
 =?utf-8?B?YVA1dTFQM3pXQzVMQ1ZVMEF6WHJBN05aeGJZZmd6T2hSOVUwOTBuZFE2UEVt?=
 =?utf-8?B?TncvZitBdklvemd2Z0RQZURDWlBNM25pcmZYRU5uYWF5NWQ4Yi9Yek10Wk9h?=
 =?utf-8?B?RndvT2U2emFZK3R0TTRzVmxvWWVtZGVxMEVuU2ZUVjBmblppRVY5RDZJZWRv?=
 =?utf-8?B?MjhQTVYzNkp6WjFNcE4xaG13RU0xejlKaGIyM2xIZ1B4RnFsUStaWnBVb3Fj?=
 =?utf-8?B?SHZaekc4SW9yb0pqYlNLc2p4STQrdDZST2hReW5jbEM5TCtzN2FZdGMzbVlw?=
 =?utf-8?B?ZjVxaEx1b3FuY01IRFArTjNPd3luRE1zT2RZQ0Q5eHo5TGdvQStiVGRZenZa?=
 =?utf-8?B?TzJTWDR0OFV1WkRzUnF0MjNmN2s3bUNUMDdtTFlvbFB4aCtZVnMzNEI5Rkpn?=
 =?utf-8?B?SjN0bTY4aW16aU9tNUZrdlRSWnlINUhrMmlUTjB0OGVya3BDbUJzNHk4L1RD?=
 =?utf-8?B?aVh5d2p3d2VrMVdQaW8wU2w4d3lzWGdSYnE2MWhoenNCc1VmK1E5dHVOUHlw?=
 =?utf-8?B?MHA0ZUU4R1pEWS9tWHptdDR0eVJaQVVJR1lzWlh3bloyODlNM1lBZm1rZHFu?=
 =?utf-8?B?RWlEaURVRnFRek1HdDI0bHVxaE5UNHJZYnNabFI1bGY1LzZ3QW1aYVU4QURh?=
 =?utf-8?B?azBueFJyUm5zc0tSOExESVYxQncwWHZHNEhUQ0tmSGd6MmhVeGNoTHBpa1Zs?=
 =?utf-8?B?TkVMcVdxTGM3cWtYa25zSGRSS2hxdHlZK0JPeHI2cmJhSk5Uc0Vub2V1TTdu?=
 =?utf-8?B?MXRNU1NTZk00Z25IQ0hsajc3NFRnUlV6aVphMDVROURscFhtekpRK1oyYkJq?=
 =?utf-8?B?TXlwVFRmdFI2SU9mdkN5Zm81Zk5nZ3E1K254SUJvSkU0dENkR08vRURVUS9n?=
 =?utf-8?B?WmZMYW43TVJxa2tMN2RaUnpEelJPSjY2NVBaZGtkQmt3SDUzM1hWVm1CZlhy?=
 =?utf-8?B?cWhycVJMdXoySzBOM3hOaWRrZzJIRlhiVno2L1hxNENCR1l4TnA4Q0loUW5P?=
 =?utf-8?B?dTZHTzFkRjMwbWpWcVIwNUNuU1FjYnBTMTdhb1dJYmIrdjhNOVRFcEt2WHQ0?=
 =?utf-8?B?c2prOHNTYmIxeStGaERkemk3WWlIU1N1S1YySlk0Vk5rRGZsK0prdG9iMSs5?=
 =?utf-8?B?QU9tcURlUmdsa0lGdWk3dUpiaEE2NlJmZXhqQjhzejRVb2ZsbjU3VFFKaWZH?=
 =?utf-8?B?cWxQbmJSdDNNRjlaUnF2WFRsN3RuOUd4aFpDTTR4RW5BUlFOa0phT1BPSVZK?=
 =?utf-8?Q?qhhJUUpaPww=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE9GTkd1Z1RzVlMvZlBpcXpoaThWVWZzSFpTRTRWeGYySlBJODJjaCtMSGhh?=
 =?utf-8?B?Ny92UzN6SmJQNGRxdy91QUF3R1l4SG82bm4yWExRdCtkeVdEYVlYaU9sL21K?=
 =?utf-8?B?dWJmY2xkRVZ1NTFES2lobTRBWHBzQ1Y5ZG9CQzVBL2Y5U0xjYnhUaUNiUk50?=
 =?utf-8?B?VmE2d0dNaUM2NStjQXp4bFA4c3dNNFFWOTNwMmd4ODNiYXBOR25EZm5DN2k3?=
 =?utf-8?B?ZmpVVkxDRWNtQm9UN2R5Q21ENGVTeFVONkUzMGZtUWNMWks0V01nNUZIOThx?=
 =?utf-8?B?WkRLblk2dzBMdTZqWlFXelFvbnBkWWprRy9nNDBEMnBjTnRydml4b0F4aUY5?=
 =?utf-8?B?amhXeU5QOTRrUFZRNmwyQ1BPUXZsQnZ5K2FRUDQzTXl0QzQxdXBQL0RyVWZU?=
 =?utf-8?B?dERGTDBNckZsT1V6MVU4SkZiMlVuZWFsNGZVeEpZTElyQzZxdmFzTVcvSk9z?=
 =?utf-8?B?SnJDY0xzcGtJV0RGRXlXc1dnbDJNZHBTV1h2bjVpQkxSTjg1MFhzN3pPT1dR?=
 =?utf-8?B?YkFEZEptWlg2ZnErVUNrUXFVVDhHWnl5V0FZbHF5NGk0eDE4RExsUEcrczJV?=
 =?utf-8?B?RUNGMWN4S3lFMDZhNm5YQUt5UkIxSzExY0Rla2E4YzA3NmxBK0VSa2hwVjNI?=
 =?utf-8?B?bnFhdmJEcEtiNWw2QlJhRWkxQVZzdER1WmpKMUpRWTVuSml5MnNSS2dUaW5E?=
 =?utf-8?B?T2J4cklUQVNjNlBLU1JzTGdWQ014enlBV3ZoQk8vOU5ZT2tnNG9WNTE0ZmJh?=
 =?utf-8?B?dnlkbVJMa1NFTjAvVzVsUHhXeEtwWnAwS1hsd0kwU3ZBaFAyREtqMUE0eTFj?=
 =?utf-8?B?VEk4UnpaNEorQXZyb3NYMGtadVpBbXVOTlFHUkloU1I4R21BMzgwNm9qWXFP?=
 =?utf-8?B?UitBVTBlbVNxTFJRdFIvKzczOVUzR0FpcmJ6ektQSUxFcHBvOHk0Nzd3a3M3?=
 =?utf-8?B?aFMrWG01OThDSXI0aVErRWxZT1RHMFJ3ek43MDNOS2ttRW96UnlFS2xSVXFk?=
 =?utf-8?B?MjN3VHRpNHRlYytkT0kvM0lDWDRRQWNQNlAvY2tDTmxDblAvNWNrRzA0SmpG?=
 =?utf-8?B?aEVUVWNJeDVLSjZRUXl6RUFkVmszMVI3Q1E5T0k5ZDJ0RDdzTnJqRW9pY05w?=
 =?utf-8?B?RURQM3dRV3ZkZlBOci80dUhNSEVLSXptTXpOQmFiRGxhdEtvZGZLTjUvc1lC?=
 =?utf-8?B?YTFGVkFvMUhwNzdzM1hoSjlUbWxGMjdRcTViYnFVTGt5VEQrYzdmc2dFRnli?=
 =?utf-8?B?Z0RCNEUrcmdpSWlmTHl1bVliK0F5Q2svLzQ1ZUp6U2VTbUZkTDVVZlpJUElR?=
 =?utf-8?B?ZlozSXBveThFSll2TXZUT3VVeE5mYUxTMkluV0t0cXdTdGxOM3pyUzl2L25J?=
 =?utf-8?B?bEJBbFBUQkFydHVmVUpJMm16WGI0ZG1GaGg1ZVhtQzRmVDE3b2dUUWVyc2t2?=
 =?utf-8?B?TVhscXlDNE40OEFTUU82aE94TlBNbUxId3hIODIxQjM3WEkvVTYxVFpzYUlF?=
 =?utf-8?B?bzhjcE43L0dOaUgzUW5BWXIvQnZ5RzE3V2pmalhzR0xHbTRnSnp0ME1BTkdF?=
 =?utf-8?B?Wnk1TFlrd2F3R1o2Si9Kcno3WEU0bzNlYmV1MFNyTnR1RHZ2TUpRTHBHVEFK?=
 =?utf-8?B?NWs5V2lYK1RWU1l3VVVueEdOcFdBZzVTMTZBUHhTZWNLQjhFVVVLbXdhYW9k?=
 =?utf-8?B?VWRNdDhXbnpUSis2RzF5ZjJIYkxpWlBxQWlyZEp1VmVncUpMQVlXdGVPNysy?=
 =?utf-8?B?TEZnbmlSc0pQU2dKenYrcVVISHdjTENoL0ZwSTRWNFlUcVFzWVlSdVhhenR4?=
 =?utf-8?B?REQvbCtuY3F4U1ZFQ1pTNmRvUXlrMDZpL2FqdDhJOWZOaWRwUjBFMmRhMmFk?=
 =?utf-8?B?WEtyeVdTR3RXSWdjaE8rWnYyY25SS1dKVnpMUjMyRmZhVXRlQmxid1BOYm5P?=
 =?utf-8?B?R3FPZEhXR09XN1c5elYva2V3ck1abCtzeUl4eTFhQU1IaEFOK1RlQnU2Mm5G?=
 =?utf-8?B?MFp2K0JJM3k4V1JuMUY3WUxpeUNWSEhxWGNvNnp2L0ROazhINGRrbXhOR2dm?=
 =?utf-8?B?c3hzR3JmN3FIQjljTDRtZmZaSUQrTHVyd045emI3Y1VZeXhyUkdQeWRHa0RW?=
 =?utf-8?B?SEVVZ3o0eHhDSWo5ZGZnSTdrNW5JTFA4Y01nYlFsWktTb0s4aUQySEFOOFI5?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+5AHTkYloDdWaS3P6BSb"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q6i70guMkQ6AtdL78Db6G3uSCPtcyCUCc91UBNk6QXGITIzIYRKGAmdVpdXZCfeIUmG5mrEeRPpB7aRigq38GSv90wifxLFwzMrJetd75hVOrN96gRgDN2BtOHhUlEyxrv7gCDQJ572+dFLJCl9Yxmio41xSuw/15mtaVnxRwnNHsbLG0x67KCBz6Lp4RZNYjHLZ9qsGW6k44cgQ801O8j/zf4jgw2CmfgAFxPe+D2c80D3VZ4KIwSFp/5LnXERnKaOFAmzoWoPzpat0dWQHd/uWhM2MdgPKuu1AxGpu0h19VU8q+AWnYTrRdmzIgSZTSy2LFlTVMfh/nqnlKl4zBWHB2vtCl15OS0fkQBfsFOukFrH/EGTMfbBjacLA4sHm3PvF1ynJlQOLnlqT2tY6lVMst3UrV2eE5cAhksDU2KJ+lW+uvQHkF8tDDwGrfdWLUgxkFtmXfmzhcKcA1FJbQiwTOZpiFUtpR5iSE8F46/sUTJret7m3jmVl8k2ZU7njFgT/e0nc2Ft/xXHhjyeR3t6VUNuQfQUOnZfq7jdzueg+gn6zG0oEecYIaW6A6zCComL/1GFNSfDBE6gSjf3Czu4NsUcl+s/1r3KiVaPKY8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33e1ed2-4292-4d83-559a-08dd0f990707
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 10:40:07.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UhEEpDHu222x3dm/ICyjk7ThNXiGsbEhw+LqeMwvBc/SMyCgPc2UAVprBhRBChyl48tutoV00IBhNX/Kv/cDhMvZ3Nh1Nw3nPH2Y8fFMdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_09,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=927 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280084
X-Proofpoint-GUID: XGBGB-Fru_m-v5BaH5vqfoBFsVFaEGGu
X-Proofpoint-ORIG-GUID: XGBGB-Fru_m-v5BaH5vqfoBFsVFaEGGu

--=-+5AHTkYloDdWaS3P6BSb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20 2024 at 23:17:28 +0530, Siddh Raman Pant wrote:
> On Wed, Nov 20 2024 at 20:28:36 +0530, gregkh@linuxfoundation.org
> wrote:
> > On Wed, Nov 20, 2024 at 02:46:32PM +0000, Siddh Raman Pant wrote:
> > > On Wed, Nov 06 2024 at 11:54:32 +0530, Siddh Raman Pant wrote:
> > > > On Wed, Nov 06 2024 at 11:40:39 +0530, gregkh@linuxfoundation.org
> > > > wrote:
> > > > > On Wed, Oct 30, 2024 at 07:29:38AM +0000, Siddh Raman Pant wrote:
> > > > > > Hello maintainers,
> > > > > >=20
> > > > > > On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> > > > > > > Thanks Fedor.
> > > > > > >=20
> > > > > > > Upstream commit 1be59c97c83c is merged in 5.4 with commit 10a=
eaa47e4aa and
> > > > > > > in 4.19 with commit 27d6dbdc6485. The issue is reproducible i=
n 5.4 and 4.19
> > > > > > > also.
> > > > > > >=20
> > > > > > > I am sending the backport patch of d23b5c577715 and a7fb0423c=
201 for 5.4 and
> > > > > > > 4.19 in the next email.
> > > > > >=20
> > > > > > Please backport these changes to stable.
> > > > > >=20
> > > > > > "cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already =
been
> > > > > > backported and bears CVE-2024-43853. As reported, we may alread=
y have
> > > > > > introduced another problem due to the missing backport.
> > > > >=20
> > > > > What exact commits are needed here?  Please submit backported and=
 tested
> > > > > commits and we will be glad to queue them up.
> > > > >=20
> > > > > thanks,
> > > > >=20
> > > > > greg k-h
> > > >=20
> > > > Please see the following thread where Shivani posted the patches:
> > > >=20
> > > > https://lore.kernel.org/all/20240920092803.101047-1-shivani.agarwal=
@broadcom.com/=20
> > > >=20
> > > > Thanks,
> > > > Siddh
> > >=20
> > > Ping...
> >=20
> > I don't understand what you want here, sorry.
>=20
> Please find attached the patch emails for 5.4 with this email. They
> apply cleanly to the linux-5.4.y branch.

Ping?

To be clear again - I want the patches I had posted in the previous
email to be applied to 5.4.y branch.

Thanks,
Siddh

--=-+5AHTkYloDdWaS3P6BSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmdISH8ACgkQBwq/MEwk
8irA2hAAn7pH6gngqMFX3JNnIachQNW3BMJl17ExjiSG7XlgvQabm3sKQRR0EG0T
V/oDinP6OugSOWdh8A2g/pjDS+gUAjI4R1Sy4+2vjyLx/G5NngdXaPHVucgPA+yr
Ysx0tC/oI4axT52Z+D1gkxvabtwXpojBX75Xdmxz8U6rpx5C0vCj+FGcD2Dm50Vd
MFrMOzYzoovtCdA8DfovU4UiMUEzFsCraL3WVCyX3x2vhqavKY1BOYcfJHTmavIS
Z42MF4eYDKzFaSfiEe3sza+E5Kd3RkA9QgX54C9M/yPaXMYTKZUUs7NJKZ1McrOV
U+utfmyUTMZGLq7+NFa13oTRtQMkpRgwmFZMepdmguJC9DVuNNFLDB5Gi/+9zW9C
d+Gn+iNVghv/U7dagvJWhTHdq+wexDlyrSroe0bIBZGon1VvHY6asrJESSWvDqST
8vNN+DY6lxE6cWix9y+NOipIiwt/3HWlZTLcaTp5N3eScUz1/o+ViaO946Ik15us
LzACyaT2qrv6kCdif0u9A6ooJF8V5LU4oAa60EmmBVKuhuQWaJjEx03TmtiNDsXd
1JHu+Y/3oqZFwg7GOzNHYmkV/7Oa/tIcl/o9xkaxwtzpCzDi1CH0V7hyAsYV8WTh
h5P7/U3qvldZs+76ZfJCxJbRcwVNKsVl2SkFb7OLBeRDKyGJJSM=
=Vmhz
-----END PGP SIGNATURE-----

--=-+5AHTkYloDdWaS3P6BSb--

