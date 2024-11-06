Return-Path: <cgroups+bounces-5452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D959BDECE
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 07:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA471F244F4
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2A19258B;
	Wed,  6 Nov 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BKEiC5q7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xiCnT9VV"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3718A92C;
	Wed,  6 Nov 2024 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874290; cv=fail; b=u6+0jSA7grVg2zmIuNSNJ+hcA9wRifnyT0UHSzVleFE3VnbFCSVWtjawcZFIlntUq5Y6x5M/lCP7+k47UFtST3AVI05WA2l5PatqMYo5zrOBE99dcQrfESy50nD3Hq02uBHHCpHliIcSA57qq3NvRfeozRUepF53W2qnWALGjOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874290; c=relaxed/simple;
	bh=W8T9PXIWJu8IIq7TnxbWSUNvdcfdnOtaicPgUjZ4MY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TdvwKcnIG0EgPVCdEAIjwjTorZuI/gUMOctkMU4urefq7hjaWYgFG0yumqIaH6GP8H6gPVZLFRiipJ7wDNW3f9YmtUHYgDD52+788i9ZSypmzpAVmzjYTAh5lyXvuR8O2kHRpoRpnbEy3KXOjsjAfl84YOmafNp6avplY6lgkjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BKEiC5q7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xiCnT9VV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KfYcj019809;
	Wed, 6 Nov 2024 06:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ztc+Q0dJ8UFYi7wt1y
	jyewKBzGbkKDzscxDHuMIucHA=; b=BKEiC5q7ueLyk9dPik6QVQoBhSlcU9+t8J
	Lzo2LE+jWWDZkksdPPMfIlQmTCu3GbzFAxWYRIekP7uPDadQMdQ19qLK81CpJvT3
	UzHOPMiydVcTY+AtvqNq8NbV4HriDKLrJjDCmLL7mIiIxVF7m17wvhCJg70aVW9V
	/98FsvY2xNf0qWPd0ZULtZuYtVfQnvvVyfvtTS6Ig24s84Ei2FnsaCvMkqIifMXd
	NPDIsKstzYS5wgAmmQ+5UBcLvtoh8q70VEJIvgKWQgk/qjDsOoxiOFsWihp5Hm+4
	PbbDYt9O5vVtm+KU25nrXZy8NW1vQ5DGRSa8RQJVaGW7T0UpSjzQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav274hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 06:24:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A64ulGn008595;
	Wed, 6 Nov 2024 06:24:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah84nxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 06:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0LcTGfbkE301xoVJ34AEFjsuN+a22MjqhOp9N38jjDXPBicp6g1f5ErfHDY+XnqMBo0QCB4IwI/1R5qHoGsqtooPBTTfpo5/VUOM8+fKagv1o0xtWCjII1JHGtV1lO6qvUDQeu290+8qOco5VFLDtUDYomKDmcd/K2mJgJCX0NfZfhlPCWYeFYJ/olHz40BvBgprx+ent+hvTZcEhnAU5yOLml27q397I8dRmdYQeJ74tKwlalLktVxpULuzF4L/YgNsmwLgqeomo8nM8pDx4bk86MeiYAAHit8JckJwWX6c71leoqvumwrJkmnn0zXQp4q8iIZGI2Nr7O1oT1YoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ztc+Q0dJ8UFYi7wt1yjyewKBzGbkKDzscxDHuMIucHA=;
 b=cpy+aJfDTeFynDzqmzW8IyTYtLIXQbdrOIWeM4Xf/wYFeOjgFKZeJvT8MNjS3Klt1rZEefmVnEdHGP+XviRzwpMVIq+jsfpZsDgKgVL+MfMk39CcrAFkB4lnA1/bB1YC3utzfr3ckcgi5S3hgNeGL5/E7epTdBvZc4xmfg7jx4lFl3YnwrhXaNlm522xMD4ec0HkNsOv1Kho2ulrUO4BWJI/HsuKuR6UfKUwu/cWTfVgpR0nskpItYfUEAuZ1IVOCnNqlJgFtP7n9TqmH/rD1e/RnZN7opVZTfla2/PIec8ds9Krk3A04D8BpwN5qa7cwSrQd1RRLZwJZoW/NY2n2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ztc+Q0dJ8UFYi7wt1yjyewKBzGbkKDzscxDHuMIucHA=;
 b=xiCnT9VVO8xBysPLKzR3V4YlmKjhgqc2y4VeCNSrhe6v77AVRqN5nsCS8EAmig5ajwvjukbuo15ZMhZG5i4TUHjnSkfhKUku/utiFgHZ6rx+xAGM0VTrqJnu3yzCSKaupa+hyMFxXcL0cTKN8ZsYveIOjCsViEIlJW9wHvoIIHU=
Received: from CO6PR10MB5555.namprd10.prod.outlook.com (2603:10b6:303:142::7)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 06:24:39 +0000
Received: from CO6PR10MB5555.namprd10.prod.outlook.com
 ([fe80::d019:ff2d:3462:a806]) by CO6PR10MB5555.namprd10.prod.outlook.com
 ([fe80::d019:ff2d:3462:a806%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 06:24:39 +0000
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
Thread-Index: AQHbMBSPjZ/BMtcIBESWwQfcBfA9ow==
Date: Wed, 6 Nov 2024 06:24:39 +0000
Message-ID: <6455422802d8334173251dbb96527328e08183cf.camel@oracle.com>
References: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
	 <4f827551507ed31b0a876c6a14cdca3209c432ae.camel@oracle.com>
	 <2024110612-lapping-rebate-ed25@gregkh>
In-Reply-To: <2024110612-lapping-rebate-ed25@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5555:EE_|DM4PR10MB6063:EE_
x-ms-office365-filtering-correlation-id: 487a9e5d-0f6b-4511-68ea-08dcfe2bb18d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUFtK2k2c1grSWFSTGlyUmFwRE8ySUszdkgzNFM2Vm9ZTlFydkQ3bm9sNzRt?=
 =?utf-8?B?L0VJaUE5Mi94SlZEWjR1VUMxRHBSZjMxek0rWFRQbHZZME1MalUxOC9mSTNJ?=
 =?utf-8?B?alArQ2RidXcxZHFPQ2pQemZXN0lWcXh5SC9VdTFUNlZpbVFxeDdvSDNOV2o2?=
 =?utf-8?B?TGpoTE9JazBTTm1SemJRYlhVL1JJUWtmdW5MM1BHazc5eGJxa2ZGUStLRnJr?=
 =?utf-8?B?QjV0ZlBIaXhPOVRFeGVMVy8vekxsQXJzckx3Q2syR2hLVzZTOXR6Vm50OU9U?=
 =?utf-8?B?QlZDNU85aXFieENHVUEyK2JhbEJqTDl0Rk9OWGdPTTVMNkJuMjRySVVDOHBT?=
 =?utf-8?B?bWVMMEc5ZVFLYWZ3WFhGWFNxcmw2VWZtbkVRajQzb0lMTUg3WDhRaGs0UWZu?=
 =?utf-8?B?bDNOejVuV3BTZjh3QTYwSUs3Vndvb2V3VVRIc2FseS85dnkxdzFrNVRMQ0xm?=
 =?utf-8?B?SzNoTEF2YWNqQU0yYnF3R01GVGkwcmdhT1NnMEhRYU9mdlBodWtiVUh1Y1RW?=
 =?utf-8?B?MlRpVlhETk9IR3VoQytoVW0ySmFtMGdVd0dsVGdGd2FteGg1Z1VSdmwwYUtL?=
 =?utf-8?B?NWZBSnRyQThVYkxNb2lvVkJ4bjBhT2dxc0thaGZpbjdUdzNCMVNlMUpGWG5r?=
 =?utf-8?B?VU1PZHRVbjNpelFjTm5vbTkwaG9NVGUxd3RGZEsxT2c0b05ISnlqOGFhQ3hR?=
 =?utf-8?B?ZXVyY05YTnFsdFM0Zk5yR3JqZWlyajBFdElsNysvZlZyRTZzc1hzRGlab1A3?=
 =?utf-8?B?VERkWTNON3RrYldGcTF0LzYxMjVNOW9meko5WHliRmVhTUxyUTJBZHE0QXlF?=
 =?utf-8?B?RUN3aC9xa1Bic2ljMDdkbnl6SHppOVBDQjVzNWFpcSthdkhtaXBzQVBNWVl1?=
 =?utf-8?B?VnBvQmR3V2trNWMxZExyT3B3ODlkYkZTVVJaZ2llK2w4OUM3RE02cXVQU1h2?=
 =?utf-8?B?YXNDbHBxK2Z5MFZjMXM2dHUwMjRtNm1rZTVVNXRaSFNsWXFsaWxkVFk5ZVZo?=
 =?utf-8?B?VmYyQUpHVzRrTW5WVDlJOG1pTm9wSmhCNUVHaTdXUDRlTjREZUZNbmNQYlhT?=
 =?utf-8?B?bkRYVXNXYWJCWUJTa1Vwa2UvNDA2Z0JndFZCdHgvUWRGUFVkcXJqM2IyYU81?=
 =?utf-8?B?ajlDT05EY2paaUl4N1FZZ3BJc29neGZaRHF5RU9MdXd3K0k3YUprWkJjR2Zr?=
 =?utf-8?B?OUNMZFQyZlpMM3hBa2V6SFFNSk0wK2xaRUYweVBOMGNWTkdIaG04SXVnbWZV?=
 =?utf-8?B?S2VEbXl0T1JLRHc2aXg1bnpWaXZiS0NUZ0ZtS1NybEFpKzVGeDdOUm1VYUZu?=
 =?utf-8?B?VWlIS2h5cWd3d2d0Y1dSMGxzSnRIVnc2ZGlZOWxpUlFjQ0s3K2ZEVURPODdT?=
 =?utf-8?B?WUdDZ1BVM3JHMUxCK2NxSW1XUVVPZ1F6YnpKM0p1VSt0TUhYLzk2NmIwTUhk?=
 =?utf-8?B?Y2E4U1lCS1VRVHQrcTRCbGRpblEvMjFid3ZnV290Wk8zMCswcm9wV0xzOWlL?=
 =?utf-8?B?NUdEN21nb2ErRC92NWZ5a1Q0MzNFa2M1WFBuR00rUmt0U3A3WTBhUy8rbyt3?=
 =?utf-8?B?VlpGNEJ2VWxZbEp5emRjSkRodGZsUjhnZ2IvR1l0Um4yOE16bVNOa3BvTmFx?=
 =?utf-8?B?VldlaS9kZzhKRXFodS9MY1dGb2prOXlpUVVIZEN6aW5IZ2JJenhUN01rVjl4?=
 =?utf-8?B?dFltZTNiOFZsc2ZmSkJIR3VNV0NKRXZ1TFFWQW9IL2RqM1lBSStpU0E2K1ZY?=
 =?utf-8?B?TlBNS2VNWGx2cW1aUnZHdDZwNnlnTlJza0FteVVkd1JVbVgrcC9id3JrVEp3?=
 =?utf-8?B?ZGNwdGtvcWtFREZJUnpSQk5JbVZLb2VydSt3VHVZRlRVTXA5dEp1WC9MWEM0?=
 =?utf-8?Q?FgzfhUDmaqwNl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5555.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkFGdVpBTmNkNlJsU3Z4MkRGQUZnWU1sYVE4cHhOcVVFOFk5ZmYrdHVRRzRK?=
 =?utf-8?B?amdyKzFwZ2liQThVdXZBYjR4SnU3MzRtazZybEx4M1lxSkdNUEtIN3AxWVg2?=
 =?utf-8?B?ZU1tR0pHcGt3VTlQQ3VyVUlmdlZIeWg0a2hlc1J2UFZFeHVqangyWVJWNEc0?=
 =?utf-8?B?dk9GQnVFUCtaV3VFU09DSXB1UkxzWjVtbjd0SGIvU1JjL1RCalRuMVBqVEZS?=
 =?utf-8?B?c3NwYVlyMHJ5d2Jub2tUMG9hQTdRWndiVm5LRGVzWTV0MUNvRnZEcG5UYzRz?=
 =?utf-8?B?K0dQQ3c1TFA2cVdHVmlqT1c1UWxIMUdFWmtDSkVMUDVYQzVqNzhOV3NBbVR1?=
 =?utf-8?B?eDhSZ2d3YzdqL3hiZGlmOHhKRXlidlN6WGZMV3VjUk0ybWRpblY3WFllWHFy?=
 =?utf-8?B?NEFMc0dNUDg1c2dTUUZ5eGVXMUM0TVQ4elV4TVFEMEl3ZzdjZGt3MzlTK1I4?=
 =?utf-8?B?K3RsbnRXZXVQUDJOMTc0ODBaS0tWUHZRelY1YkVtYXhrK2I1SHpaWkJ4eUpM?=
 =?utf-8?B?QjJzbEc5VUJrbFppZTZsWC9IOUZHYnl6ODJSM21ld256aDBLcWh3aHYrVi9j?=
 =?utf-8?B?cnJta0VCSWRQbEh5WG5zTEdRNDFnQnpjVndnRXNmVHU2bThGRUtwTnZQSTgz?=
 =?utf-8?B?ZWVtZnlLcnFKVHVNZ0xhR3pUK1JYUm5RMGRHZzkzMU9LWWwzMWF6a1dQUmxV?=
 =?utf-8?B?NjFJaUZYRm50RUx5WTlPL0QzQ1hENTBRcFViajZaTktYYTVLaXJIK0drVkpu?=
 =?utf-8?B?cm5EUjByODNuQVVrOUZZVERoUmlIM01jUi9ra1NyZ2Qyd1J2R0QxM2hHcTJU?=
 =?utf-8?B?M05INFNKWXVIR21vdVNYeHJYQ2kyNGVzbXlSVzEzT3VOZ29XbjVBMVdLdVA2?=
 =?utf-8?B?ZW9iOFlJVVp1RFBzbW5BSVBGem9uVkU2UFFxMFFoblgyS3BnWXMrK3ltTFdx?=
 =?utf-8?B?bFBnNlRsU1BuQ0RySXdEYXYwVE1SUkVCVDNhRWFmSzgwd01Ka3RkUHNkUVl4?=
 =?utf-8?B?SE15S1V6cHFINWRqNW5XcjZSMU9LaXYyTFQ4eEM3cTdzbXZ4NDhTK3JKSWsz?=
 =?utf-8?B?aktDRitWWVBSSTZLcU5WalhkcThlQ0treE84WXNJS3h3S0V1R3lBT29XR2xX?=
 =?utf-8?B?VDVzbkdLakdQTHpTWTR6R29zbm9tOFVDSGVaZk0vMkpRTjVsaGlYYzdMT0FI?=
 =?utf-8?B?Q3l6Kzh2NERrK3pPV2tVbGJiZ1hmNnRjcEx6R05IUEFaamJxczNUN1Y2SmpS?=
 =?utf-8?B?RThvSlJUME5HellRQkh5ZXlOOTJ6SVhCWWc0NFVrSHA0NUlyMmd3cHVEUGxF?=
 =?utf-8?B?dzEzdmtkcGVmbUx1WThZTmF5bEtHMmdmSGJPTmFLekt0NzMwUFJlRXd1S0FU?=
 =?utf-8?B?RHE5d0RETVdTZXVHWXdRUGNYMVNpYnc2MUlnakdnSEh4TkE3SjhuSWxtUVZG?=
 =?utf-8?B?V0g1S2tGWnZoMUdORGt6RHJLaVFDZVV6WjB4aHRXcWx3MTd0U0QyOEtQd1Vz?=
 =?utf-8?B?MnIwZWx4WUUxS2tPRFFML2FSdDA4Tm0wNE0yRi9KamlhakYrOWQ4b1BIM2Zq?=
 =?utf-8?B?MEY4bWI5UTg2eVo1bkhkNDlLYlNockZPNGNUOWk3cXpkQ3RZV2tDVUNnOTFX?=
 =?utf-8?B?WHlCQzNobWhxL1ZWU3d3QXJhL1NsVnduZTFOM3BsdzZCYkI0U1psSlVLQTFZ?=
 =?utf-8?B?V3h5bUI0Q002MkdUM1B6RGRtTXNsenpkNXMrRU5xTDlyVjBhWUlMOXF1cWE5?=
 =?utf-8?B?VjYvOXh0dm4ranpCRlovN0R1anV0clIzNSs3bG5hMnVoN0JwT2RzWlNhWnlt?=
 =?utf-8?B?MjVUMkFPTjNPd3NUV2pubUxSb2RRSWdXa2Y5ajFNdDg2NGlFUHZZQlUyOThm?=
 =?utf-8?B?MWFtREJaUGFSRnc3eHV1dlRveHg4cVJWQTV6bmNmRjlEb2hDMmlVSEVFZVYw?=
 =?utf-8?B?YXpRT2lVa3htUWxGOUgwSklqSHR3TVNIYmp3eFdxTDhZcDEzUzF1TTRVeVFX?=
 =?utf-8?B?YjJVTVgyNFhMSEhxWmQ4K2NDdTZzVG5TMFZ5akVWdTk0WXB1SEhoclpzWVVl?=
 =?utf-8?B?cmlFVHA3VC9NcjVpemdFeWtoaHNMYU5YNTF4VUtJZHJTa0JQQTRkS2lkQkt4?=
 =?utf-8?B?dW8xZFV5U1BkWHRMUnV4djBlOEJpWmJtbE9YVHVVNHlhNkgzZHR5YXd0Rnps?=
 =?utf-8?Q?/5ienpCWIXQEFW+SmiWq0KQHMwSBlJG1p8g3gr36CBCL?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9Z6lcSyHMKkc9b/VNyBt"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rVI1xDqz5ZmBTDKo+PgMMX79lsN36GTPI1UuBnfo6+7BbiI0bxgEYGGBDV0XfKqO5cHq/31GGDUi4ygOYonqt7myyG/xhUZhexCz6mDFGLSBffM3eYLvZ6aVpxXhRzESz4bn3HgD4hpwAVxRUlH5JBMQ99fXOMbV7s3nEJrUOAAI6StH7DXeqneO9zpHgE3XReWAkeRMPFlNGZo+Vn0yKqiQH3vaWpjj29jCiubHXbbwSANbbMMzoPXz9cpcCEJPmJKqEeQCE3+Akdv1urteQprBMGPHH+HlrevqeoWbujYuHhSC6/B4yGeU8k8Gsvygk84jwnvJPNz1A3PpBOrPAk5hAp6EMblyL4vrIEGl7vSVpap0ZOqZaGSC7npoZ79j195uFJn5eDGCsnndI9OunGM483XfgwOAteyP3gYrZjbrBdddDtJQD5f8R+gBk/+FCViJ66CWTw/5qW7HPmHg2cL9sj+Sl5Ur0/FA5vo+lrwxhFKvYbrOqxmGkNgSrblM76EqsulQjwzV/kgc0VK1tY8D7MoGy+7ZFLtJYFGhdPu2tkD8EgDJalZ2Upy4O79Xk8PC0Pk8+R/GRKaVCIZn4vPMAclkFrC5bcy5Xy6Ur0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5555.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487a9e5d-0f6b-4511-68ea-08dcfe2bb18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 06:24:39.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zQwDFc9aRLR6jl1HeWPyMV6am8HPC5rEGuFCnZfdIPS5/03q4gCUtW9O9gjq+fCD5hGLI6gdgX8FD8wdYevRFwXFggA3MkUvl3UoGCwXQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_01,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=864 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060050
X-Proofpoint-GUID: g1NPW95LluIv3pJPQS5oPSETMMj1DB32
X-Proofpoint-ORIG-GUID: g1NPW95LluIv3pJPQS5oPSETMMj1DB32

--=-9Z6lcSyHMKkc9b/VNyBt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06 2024 at 11:40:39 +0530, gregkh@linuxfoundation.org
wrote:
> On Wed, Oct 30, 2024 at 07:29:38AM +0000, Siddh Raman Pant wrote:
> > Hello maintainers,
> >=20
> > On Fri, 20 Sep 2024 02:28:03 -0700, Shivani Agarwal wrote:
> > > Thanks Fedor.
> > >=20
> > > Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4a=
a and
> > > in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 an=
d 4.19
> > > also.
> > >=20
> > > I am sending the backport patch of d23b5c577715 and a7fb0423c201 for =
5.4 and
> > > 4.19 in the next email.
> >=20
> > Please backport these changes to stable.
> >=20
> > "cgroup/cpuset: Prevent UAF in proc_cpuset_show()" has already been
> > backported and bears CVE-2024-43853. As reported, we may already have
> > introduced another problem due to the missing backport.
>=20
> What exact commits are needed here?  Please submit backported and tested
> commits and we will be glad to queue them up.
>=20
> thanks,
>=20
> greg k-h

Please see the following thread where Shivani posted the patches:

https://lore.kernel.org/all/20240920092803.101047-1-shivani.agarwal@broadco=
m.com/

Thanks,
Siddh

--=-9Z6lcSyHMKkc9b/VNyBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmcrC58ACgkQBwq/MEwk
8iqiEg/+JeXC7ktXYuyek+44YxCbfp2xSOgc65yy+jiaTB+62vL3Asrr+fF1FA8x
Q7uyL5F7KNPdHXMsPP2SNKMFd41uSZgAdZ3/ieZT6UtHYnPruuEruzOTKRBoWlwx
C6PbHPndqsDRHjO4GyLcsfJXHd4KsnZT15LnOFOsrnVFtkxArboqLhWA1LRTKnSR
Y6IPt6mrsIMIcKUaQgEURt8FLT3UIUkRv+1UmjIysfP4EG/tEtzNkkSq5QsdcEhq
+CSaXJB8FnDIqqCAI1SbTA4Wh+QHqFTZQGRGbmle+kWpxXAC1i9YrXbJQVYo5yOd
E/y4izkAGrUkVFlqrNWZQO9NNCVT9ampB019VNnzHYpKKBM3lSLQPubcig20jNDP
5hO35ebL3ZedZJw4bjXrI+VNzmEFOuVBO8i6H9oQZP0pdR2bhnGST85XEJ5sYvD2
7uz/yQs+O1VOQgtDxqGVm8sZ4+OO2z5NZL+NT5egR5fKREi+w/+X3aM74tLR2kpG
aMf/igwBc7MDlsVTTiSGtWIBFSoyz6FSoOxtSBSJyZ+xkoARuQ8hr6ADdVm0XcdF
H8yom2ZzBXksr7he9dDEYiXKGrhQZ1E1DcVts3ywim508nnvp8tX9z1TDdhC2l2p
m/Gzm83XG9Hx/BOzvo0K2VsYnzBhzIZekXdGXW0QkI3co4bYI/0=
=gAgG
-----END PGP SIGNATURE-----

--=-9Z6lcSyHMKkc9b/VNyBt--

