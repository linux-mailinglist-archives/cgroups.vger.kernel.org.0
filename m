Return-Path: <cgroups+bounces-14673-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEhTDgjAqWnNDQEAu9opvQ
	(envelope-from <cgroups+bounces-14673-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 18:40:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F88F21660C
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C4A3053B00
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0563E3DBA;
	Thu,  5 Mar 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ky+RfXcy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zEDwUc+n"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834833E51CA;
	Thu,  5 Mar 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732247; cv=fail; b=KY4mmBpwwmG6NCPMsobmJCqyazuhmAqhiVa5udhYv593H5Da1mYiQDY9hCBgxt5qALKPEF228HIfCxOEL6Xqc+lCzJ7aUf2XK3DKB/YtWGYSA4e6XNzOuHIEWDLkIG9Iy4vriyIEJUvG+BZ9emc0PCh/COMHt9F1FocJJOk1uUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732247; c=relaxed/simple;
	bh=htxhOAkKaCyxIMj235D70YkvkzB5OdN02KMqkY+AF9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SeFgXmPAZn9XVll5U6X5F6R0rZJ8DaKLmBhjGeX5hzECTStQ4fMYxytmzcUPigkjnLyz52EpTQVYDl1mIl06QyG9qVtMHx7ZA/PN/Pr1A+CKUizuXVwe96ZMyNetWJkrZVK0vC9861eBH8H34PbQk+gnFWvZVvnc6H4bCPsCPdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ky+RfXcy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zEDwUc+n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625H8uO21351245;
	Thu, 5 Mar 2026 17:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JYdTWiJJzJhJMZiMH02tAR4C1E3KBD7aGfi1CkKydEg=; b=
	Ky+RfXcyamOK29/aamNsXl5Yl/4anTYaytrOX8d/nrqIF/aAgSyAccYvKI5RdTdY
	zFEG/Q+gK34pBzexYbLJLRFHqcNOPC6fBDMmbUewIKKWEYNqBRGYs28tPDCSzI9+
	Pm8z0OOPf1u6e5Ub7UmUaGee0QLU9qG+IVs1rHL1yv/r08G+6fDN/i1bs0RPz1ZG
	bQe/y14rGe7tYVOQA0CMe9vStJZA1SVpllI/rhZN4bxYw5vksHYfOIGBOuoaMiVN
	n4tYKMi+9S3eQlSVL6YTCRmPK6Q+Hv16cwSsNe0aa6iCVr7StvxhQkjbUOZrvFqb
	7x/jQmGfqyx9NgrQyuC//w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqdyq01ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 17:37:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625H2OJW037136;
	Thu, 5 Mar 2026 17:37:03 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptd9r15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 17:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3KNgDYmpfAXPTYYEc9/xzokdUK0eDTNhhwgFFKAUmxIaNtmHBwpdW5mAmZ21VXMKYpZrfHcurrqEIo7MqsdvFS56XxfQzaWKyn+0LhUXk63ti5k2sSayH7Y4svBPZec6t32HPlKAjQqtMbWD0ly+ib+1ZE9qUGdXVZVB4FYGlzcyg0EPwLHAdgieyCKTsE7hSM0GWBCR81HtGcjQIRRLNe2IIwgZZW9FvgJWxn3TQnMy9By/uN4l0sGKYwC6oEPLSzlvPUqWGLbeAPfAEuE/zIHsnndAZuRzWlKHD8TtQRfuNYKu+NjDpPFjxmOQeR8/rHrQywW9lSSje2CNNAx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYdTWiJJzJhJMZiMH02tAR4C1E3KBD7aGfi1CkKydEg=;
 b=u+/s91iDpXoi8LmG5aG8gDA84pdxvf0w3rJjaw1BX34aV2X/CJhIOpxWsgSUGF/Hgjf4p6nOlJv0/f/jTSoDkcvkywJA2TKCMJxbVKJumLKDllQmkV70X6SdU08Lnigztb5zwDMMPSLx+V0gBayNLSKDNEqIePQf/Dn/cLJ20g06sshDXrm75x0p5BRSAobKgGtVKrMK9+KMVJTEzIqOWpnWqI1JbFKf3mhWQvoMrdly37QwqAe2AHTO1CYrmgXjGdBBEAarqgISw9yNIeErvFGqamUG8n1QnhCoUyfiHG1r2aQDNvIGfi0WulXmYfpFSoXCALE9VQfvyNEdZIeCEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYdTWiJJzJhJMZiMH02tAR4C1E3KBD7aGfi1CkKydEg=;
 b=zEDwUc+nptPKB6mNYCKgWlpmvkYwUeMPdJvZYeunujlKuDj7mQvLimFDhGia9I74vwxTorVyxyRab2QccD6acoycr6KjrL2nq/veZ4KjQIdi2ivLn4uOqQXudt17b0p7q20YlS0fvToJF1jOprBy9kgMry3pln1TRNZ8tqEBMe8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 17:36:58 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:36:58 +0000
Message-ID: <6eaee25a-ac0f-4fc7-94ab-ad5a3e4252df@oracle.com>
Date: Thu, 5 Mar 2026 17:36:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] selftests/bpf: add ns hook selftest
To: Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-3-866207db7b83@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260220-work-bpf-namespace-v1-3-866207db7b83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 7317f33c-6509-43b9-9dd6-08de7addcd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	TEk62ki15OM9lMYgkaDy5pFWuzL2Q6WqVG0UtBfaDQiolBPxkkEHKwtdX+R9pKMwT1sz6gY1AObCwZ4Ls2E8+yDRE1GnpsMEkiYI7RO60ozGnBAh3Qr4Rva5m7Yn8VaGbl+HWvPuDUY8mP2rsseEG8W0Sex4vqkflQGTeS1Cyb26AlKg3QljmpKy8/FuSXvqDvYDuDEzuROp0LneiAX/4yL4qnoQ4V4mHhTMGAyMmqKBThQCB/v+wD8S1CBCNiOJpN07FVt5Q59BPAyl9sUyG/BgZjrEj5FqmwN7c00BuhqiQYDFvkypOZ+wr4GwK9s8Nw4fGDqgTIJaNcQqdc1H0SxDemj3V3aUlxXNcDDNl1LdmVmZB7VeSYREy0tfiFlzBnebEv/4zr5ZeZceGGNRx1VAcwtwygxCU1u+lHY2cSG16FV61bLXSc/xal6P8AlIBkHr9lv4/3uDVIjNEEgLoOUtLbUyVxZYkPD1ptK299NDJM/6+RSbaSFweLnHlHmDdfViux6IQMKG2mjPBva5KSns2+KzaGAyMsqV7mxcP+GNdsdrKbzoJr7DDLi5VRLDAO3X99/RT7/ZiCGzzDdhUDlWP6xofr7H5zeNKLiPhsKPYgSVJN81ULNct+5Y1YEzG8GQ3PA3wkSMqljvgXPeJ1NtHNPtDEMV0CVg+p9sKz0IFhXY3y8h5tFlWSw3mRKDVxkmfkua/sco+kfCLJSwAXcrSQFutL4DgDvJF1sksXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWhGT0o2TldpTmU1VDZZOTUwS0wwYWx5WldOSjdLeUNFejI1YXlhVVM3MGRu?=
 =?utf-8?B?a2RLNlVTd1BzZEdoWWxVejJERTdWSnpLWWl1aGd6VnJHWDJWTTdrV2s4VHhZ?=
 =?utf-8?B?WDFRcElIZ0w2SGtjbnQ0K0REM1RxQ2lhTE9IQ2JNbUFORU1McTNrTk9Vbm9P?=
 =?utf-8?B?RURnMmhHamluR0pDWGsveEMrcHpvSHhTSkVMeDVrTXA3aENCNHZvMXZKUEF1?=
 =?utf-8?B?eFExL1JqRC90bmFyYWpHdFl4YTAxU1NoNkhkN255akpLTkY2eTlWZTZrbUhB?=
 =?utf-8?B?N1lWUk1uVkNsRE1JNmtXT1lsUU5jekJjSHdiMVlQZ0lrVExIL1oycXlOeXlj?=
 =?utf-8?B?Q2c0ZVJPN1hDWENBSlZCeCtQaDdZZ2UxdVdsQ1QzUDFISEY3Wno5bmplWEZI?=
 =?utf-8?B?UWZ6bXhFVSs5U3hRRXQ3MlE1SG5jMWFyMHIwU3BFYTF6d3d1R3FWa0x4Z2lD?=
 =?utf-8?B?QlBjSG4xMGY5OXE2NVV4aXBGNFdpay94cTVTc1VQY1ZLczg3emRTYkRHYVhi?=
 =?utf-8?B?dDZhTGk2cFVCdDZZRk5EaDRJZWVaUVgweCtVYmF4TG5aamo0c0p4anJ1Vm5T?=
 =?utf-8?B?ZEk1aTM4M28yMDQ0dnNNNS84a1g1aWpnZmhKYmlhdkZ0QjZwMjdtb3I2RVBD?=
 =?utf-8?B?WjlldkJOa09FTmJXcnRQSmNJSFYzRGFleU1DLzRPdmsrUlE0Z294ckRIemlW?=
 =?utf-8?B?ZE95QWtUdytDYUczK0VGZ3VhT1VRNEF3L1pJV1Y0V1pSMjFPMFFEcjJ2LzUx?=
 =?utf-8?B?cWpOVjhITDlLb3RpK0hEMUc4dUI0dlZaMlJtc1hwWFNueEVLenI4SjRaMVE0?=
 =?utf-8?B?VEY5Tk10WHkwRms5L0N0ejZ5TTQxY0MxSHZTNWJRamhiK0x5REd4Z3k4TzBG?=
 =?utf-8?B?WXVxc3piQWllNHFyWUZwNUR1MlovZk1hV2lBY0lxSHB0dFJPOGlud2xzMitk?=
 =?utf-8?B?OFVwYU1tbncxZ25MelZhNllMUHJVSjBuZXhEZUprbitDRktOVjJXbkxZQnov?=
 =?utf-8?B?QVRTLyt3bzhyUEJ0blJKclhJN2xjaGVzUVJuQlFOKzJ6S3ZYcXlMbVdRWkh1?=
 =?utf-8?B?OHJBQlR3dHFGaHBQNU1mdFRyd2pRMktMR2E2aTdDVGNCdnhOcENkMDU4UkRL?=
 =?utf-8?B?Yy8xQVYyRlBVME1oMXhaUjA5WVJoQ2o1RjlzdWpleHVVUUZ4bE1hSWdCMjhC?=
 =?utf-8?B?TUdvK3FDbEU0SUI0WklObEJwUEFSUHRiSTFWeUxiM2t6bGNpQzlqNElnZ1RN?=
 =?utf-8?B?R3ZlaVpCeWd2Vkk0VENNTVNVZkI5Vk9wRE1kWGRENXVacGQ0Y3FDUVpDWWhF?=
 =?utf-8?B?d0dJM0w3UXFRQlhoZW5jLzlYVmJMRWxBZ0JNSkhvQTN1VGpYcVNNcDJSRnBh?=
 =?utf-8?B?TnVIOG5USCt0VU1EUTk2V0ZMTVd2U3dZWGdPSnlPeWt0ZnFiK05qVzV0Y2hp?=
 =?utf-8?B?ZWRpbWlOM2hMaFJaTFYvRzNoNWVKUHVBWjBHWFp2NmZtSVlSUjN5VGovbVJC?=
 =?utf-8?B?Z1RpK092YjZNaUNvS3AyMXdoakhhZVpRMzFENlhWSVc1dU1vYjV6czNaVS9E?=
 =?utf-8?B?UEp3eWd2ckg0SFZjcWlTZWZkU3JhaUYvRzhZUlZTaHZCNXBwVWpSTDdiNHly?=
 =?utf-8?B?OGltbVBYd2VFdzUzbmhTY3Q3ZXN4UG9EUVY2bGJTV05sd3Y2VmFORzJsOElj?=
 =?utf-8?B?SEhJVWVReUVKM1huTHJLU0FzbXlVcFRTUHdHTlZ1Ry8wQ2JjVHFGa05mYnZp?=
 =?utf-8?B?bTBPVjloSnNrUW9uU2gvTlVLRjhMdEFVanpqc2tBTjZQMDBjV2hNQkhlTCtm?=
 =?utf-8?B?aFFwK0dEMmxXd09VbjBpZ2lNVjVkVnhQdVZGaSt1MDlYbTQ4MEVvSmZxSklP?=
 =?utf-8?B?M29SUGJRNFhaS3JiWitIZ3RtMmR2YUZ3RkxvWlRZWjNtSlIzaW5yMk4wdW5J?=
 =?utf-8?B?OTF5cEp1bFdxNVBCYk9oZ05WS3dSVnBwV2l5YzlaTkxRRE1aeDhVVTdiTU1r?=
 =?utf-8?B?TmVmbU9XY1lvenk3WHFtNG9CdlU3N1BhNnNLV0hjTUFaL25TSjVzZ1l6Wmp5?=
 =?utf-8?B?OWRKVUNVQzFVMGx1QUZORzNsUHF6OGhIWElGTlF4WWhzakppdHptVm4vRUdO?=
 =?utf-8?B?bVd1ZFRXc0trbmE2YWE3NHVSQm52SXBoMGQxRnJKMUJiWHdTeEJ3bnpDdXlk?=
 =?utf-8?B?dmsxRzc4NTVadG4wSHNXbzJLcGpialo1RU5BbXRkRUUvNFpZTVFraHpDd01w?=
 =?utf-8?B?c0hWOGZlcDFrNUx2dHhhbXJuWWdncFpWcEpYb3llbHlkM2F3WWxJNVc2cmtq?=
 =?utf-8?B?NE1TOW1nZVl4MUVod3J3cm9GRS8vWEdsTUxTYVYyUUtqcWRKWVl2UT09?=
X-Exchange-RoutingPolicyChecked:
	gLtqwp0YUjWjOhJNyxXguW+gmtBoMrMhB+gDotIMd2q7djZleb5D7WcvxeUei8vMx6bbSdFqFOa0ZTmlDCQ/T1dYYX3rCKLaDWcgfJxauygk30EbeExbNc3nLqr1WXPmi3EqRxO5AzJsjfyso7NwfvutWI3RphfgGL8BwSsLaQXJVq646OxGGr4xmXnaTh9ZUpjvJ0XQzncX9hAOlhjft7Vw32RyAk/i+v0lGISAFB86e61RAdxjIt4y6AmfQ2lCY/Uq5B//fU7MES6OfXcXMX8UdXFicDXuQSj/N5hyYo4VY4dOUDwvAfkgkzr4ndvc9khsA1yVFH0/QFoX8YZzNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZEZb6KFyq/fqQND+mYonSC3j51wFuN25F6ut8Hc7f74Nta/4sZxf4I+H32AyFySzjxvm8F7CaaUeVLWWxfHt8aV87Dk/kyawi3p/kf70vFibceDI7QkWkiI4h79hwAPcd1X/guqlWAX6l9TjeEF/ZvSoA2mcBFRXRfEvs0mguebUZFTG9YjutB1r54gF7Gq7pYwQNkqpd8Lc0O1UwYlClSxReWVhHA/6RqcIUTzoGiinTBbEfaJVvzJPJoPOsZ6GewrV6Nm/PAXI09b4ptRM1lHRwhna1eDtuWUATfs36Dl8Pb89RENjIv3mEd4nWbMXn3JjAhRx71Tyu/KuYIj+S0U+0lx87nIZGpDEyfXG4QUF2Kl/+jw6KkTCpl4RMggS4ya7Pvo1MR+OcFYxH0DdFsgpeImKxGSgKC1gLrZW1EKTvxN/h+jqN341gF0acg6gpSVQ0APS1vOjOdrLncdBr1A/iGJ1jRkx3NaLBcaKKDUK/ShsY+V+oVBsvHPgG4ZAa4aZhH6tgH35ja39lntsuhHj524HC4uP0Mn6KWXv8q0RvVZLykoYFhh20rOwfS0+4swo6Fk4VsHz4hEyqgoEbkWVFt+zS7C295uAirYAJdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7317f33c-6509-43b9-9dd6-08de7addcd32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:36:58.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8yHFdVBGOHgbBLyGT2xiIFEKcFMS9gOgkId5//Up/hmXp6eJypxvVhxJb0WjJCppctO4DvB1DsRStmNexTWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050144
X-Proofpoint-GUID: n-BR5hDFNyKc_---TxRGq86alD-Qhq3J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0MyBTYWx0ZWRfX7aRhjQOYNHhk
 JylVzMDsJ2y8OUfB4nti3fUkwy73IWpKIFKNCNWGID9/XPOaKwiTZMngw4zDZjhi3r6AWXWuv0X
 jBXSXGmWjXqt+xfMWm6bqI393pdQtsSv48MB3Sh1CkG4pmf8kB3NFQc09uOltBURSAkiE2rBOyu
 XyFiDiEYW6+2ehMtCdxJ6Hsw07cxVr4YR2K1r56RJswU+JD1O1vc7RqAdpf3dLiuT7jtxoMdfX/
 s9WEwUQtElsdf3LpjCCkF3+1x176ZBltN0yhcq+eDiXB7jH+azbp9t5fX5VCO8PEhTNAQNn+4Xv
 xe6A92ZfreSD95Ij1c12O0dacKvc2B9Ffj2xaMm6Yrf0aYxJ2n6R+KtTqmYbNAdDZ5b2dcLi67n
 84SMnjTYKxaPb4uwbOrL43a3VISWwUVwEMEnAypQEhDZrItdChiutAJdi1VHK/A5eEBWG8G8eNd
 7XAAmLaTiEZmDqEUQXQ==
X-Authority-Analysis: v=2.4 cv=RJy+3oi+ c=1 sm=1 tr=0 ts=69a9bf40 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=vqEzO3RFjj5WWQVkZIQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n-BR5hDFNyKc_---TxRGq86alD-Qhq3J
X-Rspamd-Queue-Id: 8F88F21660C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14673-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alan.maguire@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 20/02/2026 00:38, Christian Brauner wrote:
> Add a BPF LSM selftest that implements a "lock on entry" namespace
> sandbox policy.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

one small thing below...

> ---
>  .../testing/selftests/bpf/prog_tests/ns_sandbox.c  | 99 ++++++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_ns_sandbox.c  | 91 ++++++++++++++++++++
>  2 files changed, 190 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/ns_sandbox.c b/tools/testing/selftests/bpf/prog_tests/ns_sandbox.c
> new file mode 100644
> index 000000000000..0ac2acfb6365
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ns_sandbox.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> +
> +/*
> + * Test BPF LSM namespace sandbox: once you enter, you stay.
> + *
> + * The parent creates a tracked namespace, then forks a child.
> + * The child enters the tracked namespace (allowed) and is then locked
> + * out of any further setns().
> + */
> +
> +#define _GNU_SOURCE
> +#include <test_progs.h>
> +#include <sched.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/wait.h>
> +#include "test_ns_sandbox.skel.h"
> +
> +void test_ns_sandbox(void)
> +{
> +	int orig_utsns = -1, new_utsns = -1;
> +	struct test_ns_sandbox *skel = NULL;
> +	int err, status;
> +	pid_t child;
> +
> +	/* Save FD to current (host) namespace */
> +	orig_utsns = open("/proc/self/ns/uts", O_RDONLY);
> +	if (!ASSERT_OK_FD(orig_utsns, "open orig utsns"))
> +		goto close_fds;
> +
> +	skel = test_ns_sandbox__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		goto close_fds;
> +
> +	err = test_ns_sandbox__attach(skel);
> +	if (!ASSERT_OK(err, "skel attach"))
> +		goto destroy;
> +
> +	skel->bss->monitor_pid = getpid();
> +
> +	/*
> +	 * Create a sandbox namespace.  The alloc hook records its
> +	 * inum because this task's pid matches monitor_pid.
> +	 */
> +	err = unshare(CLONE_NEWUTS);
> +	if (!ASSERT_OK(err, "unshare sandbox"))
> +		goto destroy;
> +
> +	new_utsns = open("/proc/self/ns/uts", O_RDONLY);
> +	if (!ASSERT_OK_FD(new_utsns, "open sandbox utsns"))
> +		goto restore;
> +
> +	/*
> +	 * Return parent to host namespace.  The host namespace is not
> +	 * in the map so the install hook lets us through.
> +	 */
> +	err = setns(orig_utsns, CLONE_NEWUTS);
> +	if (!ASSERT_OK(err, "parent setns host utsns"))
> +		goto restore;
> +
> +	/*
> +	 * Fork a child that:
> +	 *  1. Enters the sandbox UTS namespace — succeeds and locks it.
> +	 *  2. Tries to switch to host UTS — denied (locked).
> +	 */
> +	child = fork();
> +	if (child == 0) {
> +		/* Enter tracked namespace — allowed, we get locked */
> +		if (setns(new_utsns, CLONE_NEWUTS) != 0)
> +			_exit(1);
> +
> +		/* Locked: switching to host must fail */
> +		if (setns(orig_utsns, CLONE_NEWUTS) != -1 ||
> +		    errno != EPERM)
> +			_exit(2);
> +
> +		_exit(0);
> +	}
> +	if (!ASSERT_GE(child, 0, "fork child"))

should be ASSERT_GT() I think since we deal with the child == 0 path above.

> +		goto restore;
> +
> +	err = waitpid(child, &status, 0);
> +	ASSERT_GT(err, 0, "waitpid child");
> +	ASSERT_TRUE(WIFEXITED(status), "child exited");
> +	ASSERT_EQ(WEXITSTATUS(status), 0, "child locked in");
> +
> +	goto destroy;
> +
> +restore:
> +	setns(orig_utsns, CLONE_NEWUTS);
> +destroy:
> +	test_ns_sandbox__destroy(skel);
> +close_fds:
> +	if (new_utsns >= 0)
> +		close(new_utsns);
> +	if (orig_utsns >= 0)
> +		close(orig_utsns);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_ns_sandbox.c b/tools/testing/selftests/bpf/progs/test_ns_sandbox.c
> new file mode 100644
> index 000000000000..75c3493932a1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ns_sandbox.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> +
> +/*
> + * BPF LSM namespace sandbox: once you enter, you stay.
> + *
> + * A designated process creates namespaces (tracked via alloc).  When
> + * any other process joins one of those namespaces it gets recorded in
> + * locked_tasks.  From that point on that process cannot setns() into
> + * any other namespace — it is locked in.  Task local storage is
> + * automatically freed when the task exits.
> + */
> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +/*
> + * Namespaces created by the monitored process.
> + * Key:   namespace inode number.
> + * Value: namespace type (CLONE_NEW* flag).
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 64);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} known_namespaces SEC(".maps");
> +
> +/* PID of the process whose namespace creations are tracked. */
> +int monitor_pid;
> +
> +/*
> + * Task local storage: marks tasks that have entered a tracked namespace
> + * and are now locked.
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, __u8);
> +} locked_tasks SEC(".maps");
> +
> +char _license[] SEC("license") = "GPL";
> +
> +/* Only the monitored process's namespace creations are tracked. */
> +SEC("lsm.s/namespace_alloc")
> +int BPF_PROG(ns_alloc, struct ns_common *ns)
> +{
> +	__u32 inum, ns_type;
> +
> +	if ((bpf_get_current_pid_tgid() >> 32) != monitor_pid)
> +		return 0;
> +
> +	inum = ns->inum;
> +	ns_type = ns->ns_type;
> +	bpf_map_update_elem(&known_namespaces, &inum, &ns_type, BPF_ANY);
> +
> +	return 0;
> +}
> +
> +/*
> + * Enforce the lock-in policy for all tasks:
> + * - Already locked?  Deny any setns.
> + * - Entering a tracked namespace?  Lock the task and allow.
> + * - Everything else passes through.
> + */
> +SEC("lsm.s/namespace_install")
> +int BPF_PROG(ns_install, struct nsset *nsset, struct ns_common *ns)
> +{
> +	struct task_struct *task = bpf_get_current_task_btf();
> +	__u32 inum = ns->inum;
> +
> +	if (bpf_task_storage_get(&locked_tasks, task, 0, 0))
> +		return -EPERM;
> +
> +	if (bpf_map_lookup_elem(&known_namespaces, &inum))
> +		bpf_task_storage_get(&locked_tasks, task, 0,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +
> +	return 0;
> +}
> +
> +SEC("lsm/namespace_free")
> +void BPF_PROG(ns_free, struct ns_common *ns)
> +{
> +	__u32 inum = ns->inum;
> +
> +	bpf_map_delete_elem(&known_namespaces, &inum);
> +}
> 


