Return-Path: <cgroups+bounces-9606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66957B3F611
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 09:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A198048604A
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837CD2E5B05;
	Tue,  2 Sep 2025 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lN/u8kPb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B22MF5Pn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE13469D;
	Tue,  2 Sep 2025 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796383; cv=fail; b=ox8q9lK83a7Ugcy8gBaboDLDRhkVuqw/MdjCM9cbmKeXpue4oWpZolsSa50u+eRMCn4pdRMxHMb36RlzM80vtsW9D+XrPtls7pAQiixbnLDW3Hgf1GLcJTWmoUvUuVoguNgO5TfWmpn8zTKPnFdd47prg0AnrhnvX0vDMBzz8WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796383; c=relaxed/simple;
	bh=dN3k37UN+8Dy5UuttB/OANjiHhtSlIST4naBdw1Q15M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kjVmGkr3sefSaWImOv0IrchoMJ+VvN5zAO/P3sfmnpT+mfj0YvK9SUYQ91itK/RuFdhpgMEGRNpno0OizuXoTkGzouOdJNMO5PJaReI3yHE3Ortpog5uP3gqYTAD3S3LzbYepMycoZyBH8Q/SGG0iykYwc2XT0G0XcdCLRKBwiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lN/u8kPb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B22MF5Pn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826ftEZ026897;
	Tue, 2 Sep 2025 06:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O0xf52IhtHYrf31ygm2ShUgi8sbmZre7lMsjKSEDQjM=; b=
	lN/u8kPbJBiO0PJ3mxSHsCexPnnqX9EDHUXFlrOpVPXtsOLKK1f6Ma6iVads3wAi
	9JvYeaU2ieyrItd61c1Qd323q043dph0Sww5Gsh7Q2vUM1/00OJ4PzZHh+B3w8EQ
	5mgOF8+J3ep8vbgqz+MUh1/9K91sc1oHEJFQ9eOu8svh2YqWB4xxpcAzb1Cr09u6
	RiIDjog9CZHmfGi3woUdMzYE9HtiSbpjJY4+E5m0LViLuRZ1dqqdFWn5H6PGl5h/
	ABR/IxsyUXTmh0EiEabh/O34TvzhLoblO0OELJHqIb6eE7HlMpWpAsCCWP42bsXP
	rOyqBDyB/ihK+TeqBsykvw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgubk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:59:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58251DPt028664;
	Tue, 2 Sep 2025 06:59:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8sm40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj49WUUlRoCD3e2EUObizXXdaehYLO1/O5AP585KN39M66DFv7dyzfI3W0nwvjswgo8CUrQuNNA4Am1KczA8U50QQkC+QcCsTsvlx+WZMGP0xzvPbfHTo5UJ0+VIRUceo7bQZwI67bWWmDPMKCKhfYyJP7cztFvMZ128QrM/gXMkfgYv4kBmT/gu7vZGVfIZfarUMEUQIP7mV/BI0AatsCJAVnnK+kaBefYUmft7C9pDrZ/gGlcGQtexF/u82cdgF+Pod0KfMiHtusvXwZJZU7+m7Fa44QVsk7aeGLRIIrVFrbNdiWlCXVhCsG3Nf1GakcKZFic7ZBUOujFg/8GPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0xf52IhtHYrf31ygm2ShUgi8sbmZre7lMsjKSEDQjM=;
 b=c0eFt06LxSymRepfyoVk/kANyfyegaf8CbjyxND+6yVS89TrSsJQRVQGvl/oKYYT5qZGAFl0cmAG2xa86RFKWvaQPH04UfbbPf6QrDUJquQ6IPVQFoJ/r/YEL8aD3imqd/yp0gZHgLud25nP7bxMOKsYQMTWi166iLrdGXLiWpp466r57sLBDq5o6KnwPbEHc853lh0lVCqRlY/E6qLSc6Nvsfh6XrkIkYtMkFnQztJQsT5VRIRJR43B/Amriep1xslrYXw0HjSKj/J8ttSFqhuSYE4aDeWW2RWSZKuohoGSj7ZkoddCqgPAeORjiIGshVxVnYwX/KfX/qzyaHe0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xf52IhtHYrf31ygm2ShUgi8sbmZre7lMsjKSEDQjM=;
 b=B22MF5PnLNtln94nQo6AS+L4spiM5F8oBQp8pOpel90FZlnx0zfYbWab+/soqGx+kzRdqE1MQg+fkE2Nmleeu9vS0CqYNTCRwsbxdZZAg/OaccQ+L7SznZb/cgn1GK9cDXL+CKpFdgzYE8t29W4OVYvQ6j8N4jqk68lLDxli/JE=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM3PPF01BF54C53.namprd10.prod.outlook.com (2603:10b6:f:fc00::c05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:59:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:59:02 +0000
Message-ID: <bcdb3af6-44b4-44f8-b03f-a89f98d8a71b@oracle.com>
Date: Tue, 2 Sep 2025 07:58:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: anthony <antmbox@youngman.org.uk>, colyli@kernel.org, hare@suse.de,
        tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        song@kernel.org, akpm@linux-foundation.org, neil@brown.name,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
 <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
 <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
 <aK60bmotWLT50qt5@infradead.org>
 <def0970e-0bf7-4a6d-9b68-692b40aeecae@oracle.com>
 <aLaPHctB8IgtD_Sg@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aLaPHctB8IgtD_Sg@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0221.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM3PPF01BF54C53:EE_
X-MS-Office365-Filtering-Correlation-Id: c24da822-7417-42e4-7f4c-08dde9ee32ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEdlNHQ4TEw1M25YbFZhL0VQbHRYRUUvTVg1LzJQS1Vaa2FIUUYzd3dRYVdQ?=
 =?utf-8?B?QU9CQkZ2SkhTSDN4RHIweHAramoyZVRXM2Y4QUdUSVNUd1VHaXRDR0NKZXRp?=
 =?utf-8?B?dmFuRmxrUEhia0dQM3ZDNmFuUzArMzBOempoSEJJK2doTnNSak5lVlhRZHFS?=
 =?utf-8?B?ZjNsTHRaUE1zVGwycmJRblk1TzlaUmVWYm85TlRYeTliRThaRG5wMjM5ZzlN?=
 =?utf-8?B?SlhTWHdLcWJCelZ0MlBHWUFNMlJxU04zMXUvZ0I2aUJ6c21NUml1MHZSU1JR?=
 =?utf-8?B?WXphYTRwUDIzUE0zMG9HQzRNN2JlQlBLeDQrcnlpWUN6MVFkS3V6UXl3dm5y?=
 =?utf-8?B?SGpsRGgxcnlSaitENzBmOWpjM1NZRzdNQTdGVlRrUkNXNzhRQWVGbkt1Z0c3?=
 =?utf-8?B?NzNyYjlFbDBnRVBTbFJQWDNyZWVQU0pSNjlOZDJQdE1Vd3J1c1l2cVB6N015?=
 =?utf-8?B?eTdIQUVGejBEd0xnTDR5MlFtRHRWMGgzZW5NOTRqb3VyZjg1V25Yc09MaTFy?=
 =?utf-8?B?RVZrb1hiM2llYWw1N2xkbWQ5U01wdXZyYmVDR3M0aVo0TDhSTHN1cHVvMjJj?=
 =?utf-8?B?NVRDMExvZVpmQmFVczBjZ1IrSjF0LzExMjFEa3N3WFJmWUJHWS9qZU1NRmhM?=
 =?utf-8?B?TmRDTkhwb3J0cU1uRk0yY2dTb3VpKzUzUlVjT1BHNXdEa2VFQU9zNFUwYnlG?=
 =?utf-8?B?aVFqcDRFYmVmMzRKdVVkcEdFSUZFSE5pTVhCQXI0dDVTdWpVUVd2Y0dISUtD?=
 =?utf-8?B?bkJyT01kSDczRmVMWG9OSjNTbE81Vk5sUmZpcmFqbm5aUktnckd0TE9OdVly?=
 =?utf-8?B?RWZpdE90c01KVE9NcEQ5Sjh6VGdaZ0ozYmxUTVB5bG1JZWgzK2ZWWER6ZzZv?=
 =?utf-8?B?Sjh1cDl4Q1AxMzBJV05KOTNMbW9iNDR6NllSbFhSV0NvZE1IMFVMSW5lblU0?=
 =?utf-8?B?T3VxQWMzQ21JWGtDVzlUR0tNZUNXS20wa0tySFNYN0ZTUTlzZFZINVZoaU9v?=
 =?utf-8?B?anRaZ3FNR2REOFpTN0FVV1lIVFc1U1diSkVrN0hiSnFyckl6WUFyNVV1REE4?=
 =?utf-8?B?QUVtTUFLTGdud3c1LzhpQ1p4dElON2xWUUZpVmxSMkNsZXpCdDlMVGZ1enVi?=
 =?utf-8?B?RkJQVmU5Uk92djdaOGNpcmJlRXJ4ZzNmUHJmaGVwN2pndldZWkN5V0RmbnYz?=
 =?utf-8?B?V3JNVUc4TmVqbVA5WGYwSmZVUmt3Z0RqVmluWUVFVENibzRlY090SG5aMmtr?=
 =?utf-8?B?RFJvTHRURUQrOEdwUlZyVUJXZzZ6dG9nTDFHeXZTQUI4MDNKaTMzV2k1R3Rk?=
 =?utf-8?B?L2tmSXZKQlJEeGliR2FqRmMvSWFPRE02Q3V0bG44elRCS2tWNzREbTRxb0hP?=
 =?utf-8?B?eGNVMGdzOTFZd1RzdFRyMDR3SEpMNm40cVZCMjF3b21Ld0JtOVZhVEphS2dt?=
 =?utf-8?B?TWhpVVdoMGg3SXBnTGZhUUxweGN3a2FBcEwvRUpjS2IyT0llOUh3aFZaTitx?=
 =?utf-8?B?a3BtMzRkanBOKzdnaDM3K1gwTkFrbm8rcklJRVQvVDErbzNJMUVWMHFPU3Y3?=
 =?utf-8?B?UkRmMHdGNUg0RlVIcE41aVpmc3JYTWpXME1MdTZ6NTBwZjEzN2MyZkszNW1n?=
 =?utf-8?B?dms1aG5zUzNyNEs3em1ITk1sR2N6YTMvQm1FUkJQZ3RoOHp5VHYwVE55ekxh?=
 =?utf-8?B?bTVUMG1qVStHWHVkbHhBbmpyT2RoN09SRFhqZTROcnlLekJ0aTZrdys5SXhP?=
 =?utf-8?B?ejQ3SkNiWTlhZXJxV2VKRnBDMklURWJTYTJUKy9vc2hwb3cyYi9EejVpemJR?=
 =?utf-8?B?MjZlTGl0QXFOeUtQa3lkSXIwQzBUYVBEOEZHTmpiMlhXVHpKSGdOSDMvUENu?=
 =?utf-8?B?RG9CY1BJa3ltKzJmVGdrZVNuRzY2NFFIYkw5OE5yK0tLQ1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1zOWRrdFRqaGd3MWdSNkExRU5EVVZDZnUyekJwb0J4WTJpZ0Q5RkY3eStP?=
 =?utf-8?B?SUErVFRtYTR0S2MyMGpZdlpDTFJhbEsycjcwdzZGZkErWkZSNVpmZHpuUTF5?=
 =?utf-8?B?a2htMGQrbFI4OXpGRmprUWFHMjllU2JuK0tpZFhnSzRVSmtFOVBKbDBuTHp5?=
 =?utf-8?B?dW43Z29odGtvVmZRNEVyYWFZYU9YazN2V0JkRG1NVy9uVXNqeWhVdTQwUGsy?=
 =?utf-8?B?ZE1kanpRMktXcnRvUmlWUDJFV3EvOCtrOXg5TGtzSDZqWW5uZC9qWXoxbE9y?=
 =?utf-8?B?MVRDRDFOa3FnTWRKUFV0ZUY1UW9zTkRQNGc2YWlrRlMreEc1Tyt2SUptd1Rn?=
 =?utf-8?B?aElQVFo2NnUxakl6WDl3dGdzSjZQUVdaT0JHdVpkMTNLemFybGszb1Z6T1k4?=
 =?utf-8?B?d3Q1eWJrUlVtaVdyRmVaQzY5NDR4V3dnQjdWUjBYT3hkWEloSUkyeG9NQlFZ?=
 =?utf-8?B?VlpVUW1IaG5UbVZ4ZGxZcG1LbU8xZmpNQlhHTHRTVnJreTlqeHMvTGZDWktM?=
 =?utf-8?B?R1Q1c0szK1NiejFEeXRubGhrcmhXc2R5TFZWamw2aWs4UEZIVzljdjd3TXVj?=
 =?utf-8?B?UTFrZjI3aHBQNkszYWkrUnA4RjVhRVNOTmk1Zy9TQ3VORTFHVTZ4bUdOSXJa?=
 =?utf-8?B?Y3ZGTHY1TnIzUWppQkg5UkFpY1hEVWJVUnpxZy81TThiZW9MamZMaTdOVy8w?=
 =?utf-8?B?Wm9nTzAza1ZubDJTMFR4MFBpdGNrbzhldGxicWE1MmFCcUpwNldLbjJ3VEky?=
 =?utf-8?B?djNSZXluWEFpekNpWExFdTZ6S3hCZ3RMR1NobTdlbHVxenBKMHZSRGNuVzJs?=
 =?utf-8?B?cUNMc01tRzRKNnhzd2l4NXlGdS9jRDBvU2p1WlBHZHVBL1N0OUQvaUtINVdX?=
 =?utf-8?B?bHhmUmhRaC9SN2tXTWlUNUJlQmhVZUNxbDFVdGZRSiszdU8wSEhXdnpydEc3?=
 =?utf-8?B?SWNDdVZEdk5HZU11eFFNWjlxYUk1Zk4yT3NOd1Vxblp5THc4cExaVjViQkVN?=
 =?utf-8?B?VW1iSkQvbFdLdmc5WnlZTVVDUnQ2a2J6NVpoRHdyMEtaTCtiWXlTamIreGIw?=
 =?utf-8?B?WllqVldLWS9Mb3VNT0RqL2lNMlVPeXlISnAxK25PdXFJYmpCbWNPMnVzTHhC?=
 =?utf-8?B?ak9acU5nWUF3eHBpSE83b0Q5SUdRcE5SbE1Cd2x1RW9JcE82NEFlTS9VS0Na?=
 =?utf-8?B?N2cxTHFSd3h3dmw3amRmT0IwalJzSWh1ajdBeW5YY0drTmtXQzhMblpTNFY1?=
 =?utf-8?B?ZXFaaDM1SU9LWGFIa1puaytvdzdaTEVFT3VMdXpLZzZaYXVEMGZEeXNvZkt4?=
 =?utf-8?B?aGpOaWRyN1lGSmo0MFp0c0tDOEJTUTI4NmRINkI5VloyZngzbU9adnBadUJs?=
 =?utf-8?B?SGordjFEZ2E5Z2M1dUtESTJKNnA2bW9TYlc0ekJNMWVzYXlMN2FqMW5CTVBs?=
 =?utf-8?B?aHBSRUJkVlQ2bFB1VCtTZ1h2dWQ1emR3ZjhONjVLVEd0bWdKYWRFWTJzNXQ0?=
 =?utf-8?B?ZVJHQUdCd0NqR2czUm85RjNmaWwvazNodjlkYWJ2Y3UxL3A2YmdXWFFwNUJC?=
 =?utf-8?B?RGpaVUZIZEsvRHc1cDFmQ3JsRTlvM00vcXYrTXdqOXhPb24xdEcyL0oxcGYz?=
 =?utf-8?B?RkRnazYzOWFPeC9OWWtJdmluTkJKdjYvRzd2eE5XVGM4WC9rRm5wcVdmQ0Vw?=
 =?utf-8?B?enVGVmFaeDd3WmhJT2kyMElyRkY2L2NSVUhyRnE1WDFkVzFiSWVLdGM2eXhr?=
 =?utf-8?B?TU1YcERIM1pDV3N5UlltT2VQRnFTamRZWkdYYlVWQUt0TUpmVUdTbkVPQ0NT?=
 =?utf-8?B?MzVrQU5xRCtPTzJoNmhHSG5aSmhOQUFLSUNEaXVKSUl2VWQrZnV1d21IQ21L?=
 =?utf-8?B?MUtKQlBOMExGM0ZwaGR6ZklBTGh6TUNvTmI4cGUzOTlHeENiRm9IYjVsYU1r?=
 =?utf-8?B?UnI1bHZjQi93Qmc5K0ZqRWs5V0xkeWdiM3FYNktIL2VWTmFzams4eHNoK20z?=
 =?utf-8?B?YmRsR2JDaCsvKzNNVUZUZGNRSUJHREZuSmN3V1gyelUrT2NwQzRMMzZkaDdK?=
 =?utf-8?B?Y0ZkdzczTmJVZmNlZEx3ZW16Q1dDVU1KOCtJeWlWRXFjWXdPSlVkMDVVV2sz?=
 =?utf-8?B?dGZLekJtM21tQVo2eXNuakFUMmdBWHlUcXBidkpWNDF4eVpkOGI2Ull3UkUy?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZHSMoPCQx8s/zdt9hGg4O205fpr88Ke3L4O0qg/l1JzhFSsSwjO8mFUkKDFNbvyk6xcSatui6rToNA/1FyxB7c9VoNWieTq0xtk+MM7GNdkOa+E7KcqIqCADB1gQpYa36KjIXBypfg++6+ldgl6YrtX3GjroC7Y8dAMAxQqLnbi+FlCEJcbv0WqecqDok1JWC5PvkNKPIc6KPNerF7sjDtx2i+KNDqV6EfNKln9avBt0w3j+Xp11BC0CrjN3CaPSdhgK+vM7t3vYwtzmiHnTnnJqFBO0pkkf23ExYyHVdYxQ2HfnjeW99TQ4l03SAvus7FvTXEroBKPj2v9tIs3HPTYIorw8nhYuhFUJEe7s9tHYzNiXEEHcvSn0+p8S4qZnJ3xtQj1VgMgO67Tiv94SJzzNKDyuUPq51LI98QyA1LxXiMgC8MeTFSFiV/xn8irXZo2TNjtSzQvtoHGG4oh354+qMkqshW9Lz+4KieHv88yGDWvF6sKJV7l4VgPvPftu0iAJRlvuqFBpO+H4eR/AKSxJEe4F2YwKUv142nsbd/5v6qvGsUsygZd4ZRgbfW69R410nTrecP7sk4/BjL5W8FqEjHO7vq89EL7ngw5dnjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24da822-7417-42e4-7f4c-08dde9ee32ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:59:02.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krcV/Iv5GCCsbSQQLD8OCovSFh+iTbIUMtAlKlUUcdQBeQLu/+SlGy7k25umYyJithHAhyYcSK+liLfX/qgyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01BF54C53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020068
X-Proofpoint-ORIG-GUID: O6RS267xH0MwSutKTuV0h8f9Jr7RfpnM
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b695bb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=mOa3dlkvei2mQtE-i8MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX8CY7fFkiHHO8
 At4OTOBvdPvhNedKxGQrEYb171pGR23DgE1R2F4hbP0K9ABIx0MwulW2GNg6FRrQGa+7MEs23R4
 2bDimGfojg3EA2C3U0fQp5qFdLTHNQxxW7qMgHuxlCBf3ZeW1NYkWg7czKGjKa7RqUx9LXh67Ej
 bK863qAclIKCUftum+8HoWca0aSxvdv+1/OmhytccVg4WY9Y/sQpmgFymUFTYlke/6JPLyrLQGY
 TNz+j3bY6FgpsI5VOTMVGhdDRh8CnDsR/Dtq3q+JHVnwnB2WFchpiVYbKMViiCP5gSFfl7j7fgo
 tidot57XNWMrGkhwTNM1pqFKo+NRTRJ0u2DuyfyJV1DrCJ5cdMLwbLVdM1HZN4DQ6Hphqhb4kRg
 PQVH4ClPQlcYZZlUF4JKtLtKD8WKHA==
X-Proofpoint-GUID: O6RS267xH0MwSutKTuV0h8f9Jr7RfpnM

On 02/09/2025 07:30, Christoph Hellwig wrote:
> On Tue, Sep 02, 2025 at 07:18:01AM +0100, John Garry wrote:
>> BTW, do we realistically expect atomic writes HW support and bad blocks ever
>> to meet?
> 
> That's the point I'm trying to make.  bad block tracking is stupid
> with modern hardware.  Both SSDs and HDDs are overprovisioned on
> physical "blocks", and once they run out fine grained bad block tracking
> is not going to help.  І really do not understand why md even tries
> to do this bad block tracking, 

Just because they can try to deal with bad blocks for some (mirroring) 
personalities, I suppose.

> but claiming to support atomic writes
> while it does is actively harmful.
> 

There does not look to be some switch to turn off bad block support. 
That's from briefly checking raid10.c anyway. Kuai, any thoughts on 
whether we should allow this to be disabled?

Thanks,
John

