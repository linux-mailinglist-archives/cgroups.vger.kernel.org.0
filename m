Return-Path: <cgroups+bounces-9622-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0EBB407C3
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730A63AE1D1
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B2320A07;
	Tue,  2 Sep 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCM8NnHt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TBUUkewn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0732038B;
	Tue,  2 Sep 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824558; cv=fail; b=gcC4TIeq33kyRclybOv9sLTOj9hWXFC2Hqq4cIqtgsQ1yC4RV0gLq80NRr0VHfI8Yzc7Ai7yzjy2yqydYltzUhgau/bV9IO5ISV/rF7jYNxejRhkfWwj+D2fa5l2RWi9eXipNXuBWu8TnVMw919STcNJG7787cgZJ4YIZrDUD2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824558; c=relaxed/simple;
	bh=k82FElyi0iTGUUUL4VVckcGA03zT0PuzxzHELo9rrQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Me1Qy4GzMQljgOfvnQKf4SwaBJcCn56wndS7sEV5CRppFPTCN3BxCRO0KfNqclQqzg9OLs9BiUux8QSxshYm/n5v7WWuRbQ4xul8qhvG8oWQN1CLXhYIbnJ7BvogVe/hF6G6uR4wjOlHXdKmLzKr/TPn2owIpexGXpaPpD3FYus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LCM8NnHt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TBUUkewn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DfoCq016794;
	Tue, 2 Sep 2025 14:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KOZCAjLDWksIXfbo5j+IWlIhQyaEGHC/p4CzGEyBNVk=; b=
	LCM8NnHtSyeZb8cvcS14rGoK7HLOwJaIfvMJfTBif9PtKMe4JKnaw1+BxumRFcjK
	npE0bH2KDePigIjQfwgExlsz72IHeWjMWgvutJlWUWlqgr+tBFU3mOX4v9vtZHa5
	a7UAlSynpxe927wtmGgO0a8UTwmuBDJ63i6/M3nyew+ziOzoglbmxqDHGkyMkZO6
	RVwPLKAgZoLKl/9NLfBouIFE9B9dWmUphmO7mSMAa0eO0NckfMJ0UxJ2NaIDLm4w
	z2asIeiNtKsFEpnyxzuqZtGpRSbWGAfOhBASWkYlhaEJqD41ELEDHLc/Y+QueyKJ
	HLzl6Nstmf648nrFUoe8ng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgv7em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 14:46:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582DMJvT015822;
	Tue, 2 Sep 2025 14:46:38 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01nfh2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 14:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foq2d9beMMfC7EgOJz7bndiQgnykU9D2U2StCci+DPnUx0mb4xI7S2OH+D10hhmWFPW5UX5OHDoYJADO50uH+wWiA1oAFREGvj2RJFBiWPl3WWbFgIr5MkOytitkp/BPDdtM0dO0HcnMP3zA/XJc9s5E1jC+ffefu1Dbwllk4o32Y7VWAXz2vRrHAPpXblFpZLQ7UmiKUaxh1K1MYz9EQ0fIAgMdJYNmOZODKz3VXFsfk9j0EUut8p5XIqt+Hm/ZDt02XK3efNyzTUYvFN44/uDxrs63v7EFdGTOavzjEeGvUjXwhxQZzOw45yV+J9wfEmB3MDJwNkrPmwTya19k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOZCAjLDWksIXfbo5j+IWlIhQyaEGHC/p4CzGEyBNVk=;
 b=MqrcOEHGsbFgmXBUoOBvOf0Ih75I8fWC9scv30bUNcvVjhYAZ6nklm9oZpq617rjDR8P63tZrNbTQg6xS1MM4LLNkr1iJDxlqfQoXDE8+Ibcf+zkejfQV2kyJliYiLqyhUX/tIDOW+w2mYZ89DP2HEolIATppuacgnkhN5FfZU8w9pe/y0DhikZPHMu+Ome80v4gFHjH9gCKZurybRQeGAub6ww6bVh98lMyyabdnJSGhM4vom1ZUHc1KGLEXxa5oRsyvlT1UH3xt5emIz3n6edamdCqhhzrpzNPwm2saAzMhUyhzrVjmDW6duHChTMHnQ3pJ8IM926QWWqxbZf6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOZCAjLDWksIXfbo5j+IWlIhQyaEGHC/p4CzGEyBNVk=;
 b=TBUUkewnLu9Q+zjtn2rkuaUy1oGR+kPLxwtaxcGnFRcD+cojVUUOTTVDTI2HJRIFWqpl9SxkigErnq/E5P0dEfHy/bh0nMDffaa3kx7cIs/UZHLb/yrLJCXYL4P+aH+sTcF+HDTA1kPBc0ENfoCiX6OBSs8lcvY4KY3x3WiS+fU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM3PPF59D9BB966.namprd10.prod.outlook.com (2603:10b6:f:fc00::c29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 14:46:26 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:46:23 +0000
Message-ID: <b45b719c-109c-46ce-8ab8-6ef2410c2a45@oracle.com>
Date: Tue, 2 Sep 2025 15:46:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>
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
 <bcdb3af6-44b4-44f8-b03f-a89f98d8a71b@oracle.com>
 <4a360dec-79ff-1444-6c1e-830f43b13c2f@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4a360dec-79ff-1444-6c1e-830f43b13c2f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM3PPF59D9BB966:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f911d8-51db-44dd-862e-08ddea2f7cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWpwVXR3WmV3Uk5qeHVhZXdyeDFEaDYvWFlJR1l6MWxxMDRSQ1p5bkpUUDBk?=
 =?utf-8?B?bzMzYks2UDZmNFVOZ1FPajFQa20zY0xlNHJNbXV2VGpOQStKOXhOZFRkOEgw?=
 =?utf-8?B?d2cyR3dlYWpmMk13aUw3U2VKN2lCWlRDNXRHT2Y1eXhGb01mNyt6S0x4bXJL?=
 =?utf-8?B?ajdGRjh5S0NwWE9RYVFvdTYzZG52aFhxSGNLWU5CVXd5Nkc4eENUMUowM3Rz?=
 =?utf-8?B?aEVVQmw0NlpEbi91R0tJN1JOaHVZaFFJYWgzdjFncnlDWTFMRWZxakJoZEhG?=
 =?utf-8?B?WXlqdE83L3psRG1QVHhtMm5lQUNJbkgwNWhaQnhmdk1VdDBWdCt5WEVqZXcw?=
 =?utf-8?B?cmdyWGlNZldwWFJyRHhNQ1p5T0xQOFZlSUhhMnMxNm1PT3gxTyt5OWZPWXhm?=
 =?utf-8?B?b1NqSXcyc1N4Rnh2SnRzeDNFMm1FTzBmaG91OVpjbmVzN00xeHEyMkp2ZFNn?=
 =?utf-8?B?OVA2STFJeFhndmRMMmQrTW5PejdobS9SYkJGUHFrTlQxK3YyeUZyc01kTy9L?=
 =?utf-8?B?T0c0R0UzbXNvR1hxMjRCQ2R3MWY3WXF2S2FRYklSQnpyQUV1K1YrVGcra3Nt?=
 =?utf-8?B?QnorRTNqeHdqNlNuYkNpTG0xQmtxK1R4SE80SVROQTZHcHY4RDhTTGV0WXVj?=
 =?utf-8?B?NHZOcU9GRk1Nckc5QWRPbWVEY3dkUEpwOXR1RCsrU0tPN2t4UXBZMUxkb3Q1?=
 =?utf-8?B?NEdXZjd3U2ZOL3lycXFuUzZ5R25TUDl3Qng1V3pwdjVOWk44bStwVkk0eWps?=
 =?utf-8?B?alUzWWJwOFpjTGZidjcyZStjeUphbjFqTjNxbityU2xMbHowUVRBRjFzQVpP?=
 =?utf-8?B?VE91dmZGcHUrUDBxTTJjSFRIcEtQYWl3cHhrQWZMcjI3bG1MOFhrTnRtSEhS?=
 =?utf-8?B?M3JLSDlncjdqZERQZ25RYlVZaUZWRWcwQ2hhSndOVVhDUENsMlcyZ1dPRy9J?=
 =?utf-8?B?b29Eak1SQWRFalMzWktpL3Q0NEtmM2h4VFVUS0NmN0pIZThDRzF5Q2NGU2lS?=
 =?utf-8?B?MnNYbHRiTHA2MWZZcUh1bzlrbm9NdlJpMFdSL01Gc3p3eGM5UzU2bXd4cFJn?=
 =?utf-8?B?SndTOGxlY2J4YlJubVdVandPcWdiekFBT3FPNm93VEwzWklCSXdub2dsODBr?=
 =?utf-8?B?YkE1bkZtbXJVNmkvNXFQRTMyajJmNW81b3JZV3hQK0M3RVZ0TlcveU5uVCt2?=
 =?utf-8?B?STFHOTFlaVZZQm92WXhjcnp0M2VkbUhPK203RFpkT2xOMGpheWhLTGxlYkZY?=
 =?utf-8?B?TVl0dXBNenpmdGt5UWkzeTJYMkdlbFZQa3pxUVZNOEJXSS9GaCt3a3R5M3or?=
 =?utf-8?B?RDMzeUJ3cU90bUs1NWMycTVRV3lQM09IM3RMRlMwa3BCSjJSY25TQ0dwRGxo?=
 =?utf-8?B?MGtwa1NEK3RBSWZkUW1zbzN1TkZUSkdQdXVRcHk2OVR3SGFEYVBNNkVlSFhT?=
 =?utf-8?B?Nk9zV0dZZHk0ekVuejhmdk50ODRJMUlLd3dVNFVwZXA1bmlzUktqSnM3SDJJ?=
 =?utf-8?B?Wnd4NmNBQ054a2tYYXpHWVhwNzJGV29mOXNvRzBJMWZtMVhBTUxRc3VtTGFJ?=
 =?utf-8?B?K2wzQS81NWxZc3lkQzNlMThTam5rSTJyYWNXd3lhUlg5aXcreGoyOVBwemxp?=
 =?utf-8?B?SVhqSGdxUFNmZ3dTVWV2N2ZTL3NtQTNYaE93TUtXMW1OcTJ1N1R6K1pBTC9E?=
 =?utf-8?B?OFk3K3h3ODZTcnM0dG52QktVUEZIcU5jNXBFK21aUHNQM2hqNG1LblcxVllE?=
 =?utf-8?B?SmQ4eDJ5VUQrNnBWb2xlTFU4Wmp5dEtaYkpHdThCb3dGRFVXVHF5d0dkbHNM?=
 =?utf-8?B?aWxtN1YrbDc0UCtudXpqSkxoRUxnQlB6eCt5c3NWTzJrT0ltclV2aGZpUmNY?=
 =?utf-8?B?bTV0Qlh5VkQzdktpK1VrL2hHaWZmMWQyaWViZ01qaEdJdnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sm5YRkN4Ukl5M2tFWFhvblFZODhxOTR3bmFmaG5jaW5DTjJyVjFKMFVTMCsv?=
 =?utf-8?B?V0NlTE81M1VoeUx0YlV5dlV4cDRBdVpUMUcvYzVPRFlkQjZKdFRHOWNRK0ZO?=
 =?utf-8?B?aGZHSzZiK25Tb1BnQ2tldTlVaVdNWE5qYTdRR1ZtSmN5eHJDU01mdzBFUGZH?=
 =?utf-8?B?NkdoemQyVzZvdUFWR0g4eE05VE5BUGc3M2xpWXlXNVVwdVpLazRKYkx5T21Z?=
 =?utf-8?B?SmdYWWxHQkxBTG03R3RRajlKWWhRTGE3TGtlSVVkRjJjb0w1dk5aS3VqR3lO?=
 =?utf-8?B?TytUUm1PZkxBWHVLUWIreWU1ekNNaUpKVjFUYk5oOGFqK2N4U2NPSU1hVHB3?=
 =?utf-8?B?amlrWERnYUpRYXRpNGJtcTdIRXhySkdiRFR0ZE1RQzJPS1diS0M5UWJXSDkv?=
 =?utf-8?B?WGhWNlFwRW5GODJCUnpOdjNpaUhEL05rUnl5Lzc1L1ZtejZlS1VDOUNmdmE1?=
 =?utf-8?B?TXdWZy9OVVVhOG5IQ0xoejh5YnBUY2pTRUh0cENtNjVoUTZyMVBYRnNHUklT?=
 =?utf-8?B?M3QyWURRQ3BMRVJSRXYzSzVoVmRjcnJZUGpQQUMwVXdYZlF5YWFjczZjRnJX?=
 =?utf-8?B?TXd5Y3M1SUZOdjVTZkh6UC9CMnl2WVJTK0U0cTZYbjA1TSsycE8vTGdRdGN3?=
 =?utf-8?B?WUxhRHRickVMUis2OGVreDFxd1lmaHpqNXZxOVVjdW1NamorcFlhMEw0K1FJ?=
 =?utf-8?B?S1pGR3h1T0ZQVmY2RThJcWxSZWtOK0E4YXIwMThtdG1mT2twM04xODF2RGVr?=
 =?utf-8?B?TmlESUIwVlpBL1BIMEs5OE8yeFRMb2FlckpSbVAremhwSkpWQVk0aGNQcXlO?=
 =?utf-8?B?MmJUUmU1UXQwQ2dRcU96Y1doQk50QzUyYXVuTU1VSlVQVUNwbE1oYk1RSkdE?=
 =?utf-8?B?Y2pRL295MXJpcWRZUVovdFBLdUh3eUcraURiRlJzb0hpNTdGV29sZVdrNjN4?=
 =?utf-8?B?ZHFTNVE1Q2xSY1ExNmNUUnZFQWdrcXRWV2tOcERpMWhlMWlmaTYyZm5aRDRs?=
 =?utf-8?B?aFhqQ0FEYlFrQ1BDM0kxdkpkSkFiRG5tY3RCak1kOW9yMlhubnFKN1drN1NK?=
 =?utf-8?B?ZHBBUjU1bkpHUGNraGFEcHBralBoODlzUkdyaFBmdXlYUk9uRGp6eUNKVWl4?=
 =?utf-8?B?WmFtRG9VOCtPQXdmbk1lY1Q5M05HRHI1ME83MUVpbTdUdG84NmFmdmtYcSt6?=
 =?utf-8?B?RHlUbk1hK1lxSlE2cU1rZmVweUx5aFRmcUppTUNsODB6aFZCZFplL3E1K3BC?=
 =?utf-8?B?Sjk0RnNwc2lDbjh2Q1Nna3VlNWNNaVF4OXlZakRFcFVhUnBYZ20xdWZZc0Vp?=
 =?utf-8?B?VnBLK1IzdlRNQjR6WE9YUVFMcnZZaXVVOGRtTTBOVTN6cmE3cXJMTCtBaUlt?=
 =?utf-8?B?WXpjdjA0clBLTEZmdFBLWVNXcWJ5Q3pYb1lqdWgyZVo4U29aOHFwS09ZWEIw?=
 =?utf-8?B?M3lXZzdnWmJTRXlFUGJjRi81cXU0NnFRN3FSTUtMZk9aZk9NYTFtRHd3QVJD?=
 =?utf-8?B?ZDhSUEtHeTFJRURCRVE4TXhsVkg1NFdwZnJSQ3VUc2laZ0RrU3JpWE12RHhs?=
 =?utf-8?B?RFRmSWFsaDZnVWV5NWpsTTlnZzhEU2g5SUZIcHZEZWFHbEl1cHdZMHh2TDVS?=
 =?utf-8?B?dHZHb1ZSRG96UkJLWVQ1ZitoRlJQcS9pSUZpbHpaSE5DcmpHb3QrazJvS3lH?=
 =?utf-8?B?L0JsOHV4TnZZOUk0VW95MzFQQzl4UlZNNFJQaG1ubmx4bXBLQjlGZ2RsNG1C?=
 =?utf-8?B?MDJrSHpyMEpJZ1ZEd01oV3A1cFBrOERRNE81VEpHRjJSMlFrb0plYjZVcFkw?=
 =?utf-8?B?cFFnOVlWRFlGM21zM1FMSStzallLZVVRcHRLaTRiU1pkbGZEYWFSUmlWakNX?=
 =?utf-8?B?MUZoUWdrZklWTkJMTFl5ekN1WWVVOE9ZOTgrdlhic2hJYnFwcW9ieE8vVUlo?=
 =?utf-8?B?WmdFMW5MYjJDdGRVbXNlTkVmL0JRZDNUT1FNcDQ0dVZ5UFdWa0dRZi9HeWVY?=
 =?utf-8?B?ek45cTlISzV3aGhYUUE1dzY0TDhKOHdsSjhMbElqSHJsdFVqRXI4elp4QlUy?=
 =?utf-8?B?V1BPNDlNSnlTd2RiTmUvUitQSHBZNGU1V2ZOQUZ1a3VhMnFLRjNWNWFHYmZM?=
 =?utf-8?Q?AB6ssHZrO9FzNbWJpj0Od8QoO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6cu3Z+/lOc3qvfhc+JMH85sijZp/8wdoY6nMmeo2F0P3t5tO2Op0km88pB3M2qmztha2tXIjttlzhjLK6cYAUP04/gqI9OPBFtBtDJBux9Mbxs2xtIcyiaBFTXjSb4GRTb0xGDPkADIryVymr4Z+RM+BlukXGUwZQgz3SvdzAG6zhJoUkuQ9v0mIGZC89JBnpuUv+DXVSzKtytuV3oqUNLdX6WfIag84HwZiJQ+H1Dc2TcwPr5IW1mdkh2ZLaXClo+g1CgNE6BYeczhDe5TVdsG6IdggQO+oSvHXQBjmcYdallnlkeS0J2JYez0fj5sQF6DlETi2OYMO2trQyVSPFgYNp2cpDBated01kP/SvUxCscSEMkLpjwa28Xz5FNEPzqgeLB/OqUbp37ne0/UV9yHlx7MEYL8+uUmyj87ZqknPV60NZmv2IFMN2zDM5nQ4utVEQLTjFRvcKw/S/rUUEj1xdCSonnyDLDXicaGMBdoFpTngMXoTI9L/NlVGltRpmo0JlFEEBRyuyE8ZSiDoTA8kiZtDwG4fAkY6pqYEiNsgnNY+hotIf24EwX1LF4k4pDWmtfr0hcE4P/gvoDBTKRxtFMHh48+lJ1O7P3H8L5s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f911d8-51db-44dd-862e-08ddea2f7cd1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:46:23.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ3tRKthRvwxOObjAe3v0CEEoCgwhVrY6brdN/a7dx21il3wPS/AbqfUR0ZKRlWaOyeJTHEGuijwwfX5odCtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF59D9BB966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020145
X-Proofpoint-ORIG-GUID: lkjFlpbv5-KUmOn4_HLU2k5z2PeN1MDz
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b7034f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Ccdj7GaeH1t_N_X7AN0A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5iREJyz/KZO2
 LEIo0rv4Mw5T3tpeQSzpnOdaW6XSpilJORelQt0DiaouaEn/X+Pq9d41ckzuMcrHshk5r8036ck
 HKqlPHmvUlvZeR9AqmEywz7UkhRpTRV76TZ2jqUe4u6XrbcOQ4yxj8JPjZmMJitgsRVIFcblW0D
 wyrbLPWXhjnzC3SL8moiz+7Y0ILeXYTWKPq5VtGklIPhirCoNoMZYcT5dO3+1HMHKfpDbnK6lpO
 he0OwptIOl8MtKC0Ke66MVsTkfixLKFuJQF4sUoPf4ENVz+nYLTUMrLDJtQSUnIxBe125GGltf3
 Drsug0B6UetANq6i6607JuiyJBWu5xG619Y4qTq4ThnMMsKAeo5krt3gKN2M2/rfLzF823KyTPa
 QpIIEXIS
X-Proofpoint-GUID: lkjFlpbv5-KUmOn4_HLU2k5z2PeN1MDz

On 02/09/2025 09:25, Yu Kuai wrote:
>> There does not look to be some switch to turn off bad block support. 
>> That's from briefly checking raid10.c anyway. Kuai, any thoughts on 
>> whether we should allow this to be disabled?
>>
> 
> I remember that I used to suggest always enable failfast in this case,
> and badblocks can be bypassed. Anyway, I think it's good to allow this
> to be disabled, it will behave very similar to failfast.

ok, I can put this on my TODO list, unless someone else wants it.

Thanks,
John

