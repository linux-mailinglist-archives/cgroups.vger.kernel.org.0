Return-Path: <cgroups+bounces-3583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7892BEFB
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4980C282430
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9BA19D8A9;
	Tue,  9 Jul 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HK6rUnSn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LnUZUwPP"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C419D09C;
	Tue,  9 Jul 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540727; cv=fail; b=CavZNIIGF6ZLqMNkCYUvfCaUIp1in9lXRrCh77jBb0jzL+K2lz8gn8OaSK66cOAWN4gX1HoELMeUQNXIiar/4jWr+7SdkRwZt2LIlHAA3HNaUpsSPQaOsF9urW7t2lYUDJxRzdPbjUmerDLfdZaqxq2TS0IamSGgPHBeSe4CzUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540727; c=relaxed/simple;
	bh=QO1PgfMpmL9CSUTgQ0dD514aXdLbWZPGJDqCSIBRg9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioEptH8KTasl6rpM9APUUYLWYSZYSUIay86JMa1OVa8zBiywfPu8e0NEKqF0D485AqSlpbK3bwyRm+WIrep0uPCoaEBup4CEd6plPhqaQQMSmGxEqULe62ZREk1D5LnC/JW2R55SmIG615rr52nd053p7LkvP7J3TXOkfTc2h3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HK6rUnSn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LnUZUwPP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469FtVlG031861;
	Tue, 9 Jul 2024 15:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=YLIEwkLcBvuE8NoKH6SiUlDBtDXZ50HEMydRbkGPtDM=; b=
	HK6rUnSnLz128CqyL+t++/mGcHzYa3Pm3igVisgWYQIUdQ44WZR0gh9t08sqV+YU
	dWlJXdhonKl/LgcdI3Y6QWL+T5/TfxexlE9mV9fu0hkeNnlMyHqGYGY2+hp9zhkR
	fADXSigZPb/8TQYnndxJ2WQ+Mu4uvrOyGc5Jh8xbR11Od8K4HoSKoBb1dmSD9Szq
	WQaKN3Jj3iqaDD6gOwYYKAJJcBTDtEF9pNO5HviY2fXnioDVY6VFRrOnLlzQj8KX
	jdQOEnZrhrnuQhqnkEIcOSgL2k9QEVdlwI1j01b0DkS3QTVxY81ouQ5GGSCPRkQL
	BZFWNWeJQzPCyD0GQjaTlg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybncj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 15:58:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469FlEHl014256;
	Tue, 9 Jul 2024 15:58:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txh64q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 15:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPahD8JN1gsPLgBlKBGabq1ieeSIHE/xn5ZSviScpaCxVII/S5lv6inSXTr0n7vEroXZk8nwvqaeVxS8EEjdizLir8K6+wt0j4/1bqS22HbYltiQ2j4l4ITdngC/4MHhYHEvuNOGz3S72kxJN0QtYqyth/TA1j5b9uSrkUHL371PTo7SkrrjjVkNmaOgdluzGVg4ulDmt3mLyQ2dxtozWxRWA7VeLzGKWvkvOovpgUGq/N1lTkTFgOa51X3ky3EiGya6LYgSY+yaWDP0SuC6qdF4VnZfdF1ha/wOJIDLKoJrPykPEe23zLNY3pwFADZ5GVhtTTup5gb4GMFjOfpwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLIEwkLcBvuE8NoKH6SiUlDBtDXZ50HEMydRbkGPtDM=;
 b=ecBr3Gp1EumNOsxOVyCyG7eUbtN2wyZIeSpowKew33EaDwtxzLB5wFD+rAuJQt/BJOyO8sFH8SWnbx95ftbpdTKLMKRNu0NT3SlyHPMo0xqKqXYt8fGn+FbOLgjsw37Nl+OxsZRtV5kuiodzSU2Kd4nPuXhGkZajSGDQwnM8+UsieXoZre8nLqGjaa/0Idi9AZXsbpbj+YayKVSXlT+CINJyUflN5++UeLGOYdZK3D0duLHKnEGKZQngn6UOnzOTZv/D1SKeAI4Bf8VYGq8je5RHEk8flfaEIvhV4g1apQhdzkYZNALsEhAghyUv1qUmxhBQJQ7sAQDqCnGUWk8nUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLIEwkLcBvuE8NoKH6SiUlDBtDXZ50HEMydRbkGPtDM=;
 b=LnUZUwPPdg3ycSJBcCEgXzJJP3CBCUMVcY+Fzt5r3lIIdDgxobHhBNhMRbJMrwTfAz4szKYqD9oFx8bleARH9BIWNFqxXbJEn964EnnYaMDHzAtY+hMOlZoACs9jCsgLGeThHsE6QW4+wdqKAPU1xDa74nHe3TBwYfqrD1Y9MkY=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 15:58:26 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 15:58:26 +0000
Message-ID: <1c0d9ee1-e80a-46da-a48d-2ab23dd04673@oracle.com>
Date: Tue, 9 Jul 2024 21:28:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root
 cgroup.stat
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240709132814.2198740-1-longman@redhat.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240709132814.2198740-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0037.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::25) To SA2PR10MB4777.namprd10.prod.outlook.com
 (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|MN2PR10MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 56756d25-b3dd-46cd-12d1-08dca02ff816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RE9jdG4vN0M0RE9MdS9jTUkzQWdUVzE5L0dlaWdMd1dET3lKaS9vdmdnRGw2?=
 =?utf-8?B?NGNXa3BmZUdaSSszSmc3bEFDVVJyQ09NNjV3Z1R6eGJNZWQ2S1BFWHBFWlg3?=
 =?utf-8?B?cHRycTIzS25nWENpd0lIWUwwRW8zUDI1QjNDbUxLRnA4ZmU1MzlkNSsvb21p?=
 =?utf-8?B?S3hKR29ZMVNkbXR6eDBXRTJsT1UrbG1GbnBjYjRyZkxzRHFVS2o5ZnE2M0VV?=
 =?utf-8?B?ODhSRGFJQnRmVmszUmNNd3F6NTltN09hWHZIWVd2UmVMWWFndUFHYXRSOFho?=
 =?utf-8?B?cmlYejdrckxDOXlqZXNxdjdnWldUemZkemJ4cnd0dXZPVVl6NnRLcmlGR2Rr?=
 =?utf-8?B?bG5uYlptNmxwYXBjNlpMYkQzclpiajJjMFI4TkRqQWtodzRiMmxrRG5mTjNk?=
 =?utf-8?B?VVBCMmIwTkZHdVplRGlTb2htM2ZaUklOTzBFWEJCdlpWSUFJdUljZEdJSzI3?=
 =?utf-8?B?RDYzRUNyaTMycE9CWXg3Qno0eFZQTm1OelNodmZHcVJHbWZmb2NBRGhLbWhP?=
 =?utf-8?B?MWw1aUVSMHp0aTBVZW4za1Z3THlMMVVZR3pFWjFhVndHcEg2SmZraytzdVJn?=
 =?utf-8?B?SWpuSFl6OXFPTXJqc0lhNjBac2Z0bk45eHJVOEZQQlpiaWNUeGgrUHJqeExv?=
 =?utf-8?B?RDJidTQxek9kTFBtQmZBWms4VlJUOFZYVDg0ZHBlZUVzNzhMWGkrRm5Uak1U?=
 =?utf-8?B?L3Z3MFp5YW9sYnVoQzlhU01UMHUzM2JFNmZEUWFJbUFBdVlyVnltdnFvclQy?=
 =?utf-8?B?dWkyRHRuWU5iUEZZUmtTVCtCQ1hQSms4QnRaUmlSdUlYdHlDbTdIMkkwa2ln?=
 =?utf-8?B?N05TK0lSTWFTS0VQakZhR2JFZUtnNk1TVkxMajhONGNzRTFIejVFYVUxTjBw?=
 =?utf-8?B?c1dCT0NRYWltTGh6eHpVQ2tob1R2R0lrZnYyMXpJOFovUXpTUnorMGFCMmor?=
 =?utf-8?B?K0xwQ2hUY2hUT0N5TzY4MVdocE1jTUNHNys1TkhtREdUaTkxc1BQZmV2UFpl?=
 =?utf-8?B?OHRXSnhZQWdWMU1DMWtlQVFjNFN5ci82NkZVUFlHYS9mWERibCtQcUI1dkxu?=
 =?utf-8?B?anlzdGNKdVZPTUY2KzZja3BRVE1LRGV0WFNkL2h2Y0lrMkR2dUdGVndQMXBp?=
 =?utf-8?B?bkFUejhiN2Jmc1hIUVZVOWw0aHRwVzJudFNFKzZyb2JHSkRnd3BkbnV5cHJo?=
 =?utf-8?B?WEJsaUIwTTFjMGUwbzZaRTFMVkpuWG9VRTNnN2lDQUlhNTU5dGtQR0E4d1NX?=
 =?utf-8?B?ZFI2RjZ3UkZRbUlmTmhLTWlXa1BkNnZNdVUrQ1FETlYxYkowMTlPa0prekJS?=
 =?utf-8?B?UkE1Uk9ZVHpGMFE0a08vM0gvZk9rc2VYNTFBVHo1M1pROXRURHZCTExmUncw?=
 =?utf-8?B?cy9EL0dFY1NCdDBIYTdRUFZpZHhaWXdBUThteEZJZnp5MVlVaUZoWXg2WlRw?=
 =?utf-8?B?TzljQVRZaDJhZS9aV3djSUFQMHk4SmhaZDZCVUUxOFFUK0FZaHhPSEdId2k4?=
 =?utf-8?B?aUpTTlg2ZzVEd3lRYnFKcUl4UDZBV0NKTU9QVFZzZm9DYXNZSkk3Tnpmek5V?=
 =?utf-8?B?c2NHL1VQbWVSci9LQWRneWZMZjY5YUFQc2ROTnEwTEhKc3BkTmsxSC9ST0tP?=
 =?utf-8?B?SE1hNjZHRk0vQzFucy92ZWxVQi9zbFN0WUdvQ1BXdndwL2RSZEFzb1daYzZv?=
 =?utf-8?B?aVQ0VWwzUjdpWXZRQm95SlpsZDhWRUt0bFpEeG9NV1JLbGNzMUI4eE9pb3l6?=
 =?utf-8?B?Ri8xM3QwOTFMN0Y3NStEcWRsSGxyZS9FVUZXSk0xN2h2RVpuRzZKU1R2WWdp?=
 =?utf-8?B?TUNBSFgxSmYxZ3dlOUU3QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2gvMXRXcXdvc09CaHRPUmx0T3BnN3hPOVovY2V6OHF1Nnk3S0kzWm53S0cz?=
 =?utf-8?B?TmNpdmhQN2t2cDluekd3UDRwa04rR2M0MjlDUWxNWnc4U3Q2N3ZEdDZjZFo3?=
 =?utf-8?B?VEgwY3A0Y1NOeEJpbzhRWWFVWTFIeGM1QWxFVUN5SCs4clhQOGh1VXJ6eUFn?=
 =?utf-8?B?bDdtQ3VVcTliSWlvOG0zSkZvZzZIdGhIRzVtZ1VaM0dpY2FQNmpiODdIYXR4?=
 =?utf-8?B?SUE2S2VDWTc3MnRjWFNDOUUrMmswY2JWRXd0blExTVZJYzBvUVU3WDJJdElK?=
 =?utf-8?B?ZFJvZVhBaUdSK1l2UVZidVlZSkZ5RHlIQ05YZjVpOTF0UE5jcTVOWFpvclR2?=
 =?utf-8?B?TEI3QUpQZytGaEZPMTZFOG9DNHV5enhuWUYweWhUY0RISTNwaU5XL3ZNd3hs?=
 =?utf-8?B?ajc4NWxaT2dtWkdTN3NqMjJXQ0FVTUlycWxaWjdMdHRNMDdVS1VBd21pZ1RI?=
 =?utf-8?B?a2JJYVpkc3ovWWhVL2NvdmhYVVNBd3pPWXZvS3NjRENtQTdUSlFJRVZJczRa?=
 =?utf-8?B?RnZaYndTdTVJSHJ5SG1LQnlxS3pVNTJoUUZxY3JSTjNhdzMrb2E2dUxEU1Rq?=
 =?utf-8?B?a084L2NlZnlDcXdwczdvUWxheHdxZDlCSkZaZWZMUVE4aWgwejF0VXZGMW9U?=
 =?utf-8?B?V2xIc2FER3JUZkc2elJvbGJkOFl6eno3dVVjUUZaTDk0QkZuVGR3VlVSRWxn?=
 =?utf-8?B?SWJBR1RYY3dTSkRzZk0vaDhoNGFUdTF0RGtSRW83TkJYRWxTSk1EYW5iSmNp?=
 =?utf-8?B?aFhaekNpWTU0K203RnJpdmxXY0l6cCtZN3EwNjRzNE9BUEVRRmFNU3hocDZm?=
 =?utf-8?B?Ri9lM1ltenhldUd4OVlKS3RYTUlOWW1zcnNVcWNNRTZOQXMxbmNyellDbG9N?=
 =?utf-8?B?S2hWdzJ2Y1EzVEJJL0piOTVhTDMxVDZxUUZqd1Z5cjdYdEpnSk5BRXpjTlFS?=
 =?utf-8?B?MnVVTHBTa2dKTmFPRWhKRzR2bitYaTcxZTlod1kyWm92TnhESXRFR3pMUUhT?=
 =?utf-8?B?eFBUU2VYbnVPdWVLb2VNN2VXZEVGL2k3VFVMOHpoaS8zRHhkVFZXYk5WK056?=
 =?utf-8?B?ZXRudEtxNjduNzFGSHM1SHFiaHRQSVAxcll4bGZWTENab29aQ25MRXFwWWJC?=
 =?utf-8?B?YkVqRHpwZ2h5bmpEYXY3V0xCeVAxUnBvMU9QYmtvNU15QVpYUStlMHFGalgv?=
 =?utf-8?B?RzhTU3hRMm9FdjZjaVgwWTZlVXRLNHRXdUY0QnJRa2g0dmpiTXBsTXNqSkkv?=
 =?utf-8?B?aHYyY2ZGOWoyS2t5Z2hhazdYUFhtN29iMTZoNitxRG9IbEcxS3F6d2d2dHQ3?=
 =?utf-8?B?SkE0VDZIaC90T1hyaDVZcFA1U2FubHorbTJxVG81QW1yK2RQa3ZOdy9qZ0F5?=
 =?utf-8?B?c2p4bjlkUEtTbXNJTGR3bU51WjRIUFdUUjlSbUhnMlE0cWt1Q2ZoQmR4VkQy?=
 =?utf-8?B?ZWtsTzVQOXVWY1VIaVRlNXd5bUlROCs1b1dBQnRyUjcvdy81NWxoaCtOMVox?=
 =?utf-8?B?d0NqSHZLRkdiQlhPcWpIRHMrZ2E1WjNHV2laYm5wWWN5aHp2VU9lWmhwRmd5?=
 =?utf-8?B?Y2gwYmhjWW54VWRaT1pOWHM0bllkNTJxVjR5UCtPN04zYmVsUXFPbVpLZ1ZF?=
 =?utf-8?B?M1NWQUJzYTRnYUhWNTNYNzVldWFCQjZYdm9PTjJNdEdnTWxxaklqQ1Z4ejRM?=
 =?utf-8?B?bHJyWmFoUVV4VVgrWnpETkY1cEorMTRCcTBqRXdKKzJaL2RIa3VCckRVaGRH?=
 =?utf-8?B?djYweit6aFlSVkRnOVllY3JQdWJBcS9aT3lhYnF3QzlPZURldkZEU01KT0RR?=
 =?utf-8?B?cFYxVk96SktzTEtqRmN0ZGg3d1VXaVhDbm9NZGhvSHArV0M1b29UdER4TmN4?=
 =?utf-8?B?bjJ2S3krU3FaaXdjQlFkTWsraGM1Yk5iSjF3V2NHdmFTVG9MQ2ZnMGFrMDZQ?=
 =?utf-8?B?bGwzZUdjYlpnQmR4THVkcVpLUHNRNkprdDVrcm43NUYxWG1CeExWQjF1akxi?=
 =?utf-8?B?M0FnK1U4SXRqdEkyYm16dkMwWVUzNUMrWG1JVXhoU1F5VVRmYkdkemRXc3Nl?=
 =?utf-8?B?L3Y5dWxTWEcyRExoU2NvZ2htT3VNV1RxYTBqbDVMeG5HTVlYOEFaOUlJbWtm?=
 =?utf-8?B?eVplSm5HZ1A5N1QyeUJVUFc3ODlpd3J3MTZ2SjVLaE5MTTA0VnpxNE1FOWFJ?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QYrXuo6KNSMPWYkWO7NYRQrGXo/LoFF75pj9CpmomTf6X00emxBgLcj1sb6OmYzFueMvpdeJEwexNJaAr2wOXEzt6o/PRK7EBFq4802vcnLpPwnd13Pst5LJ1/y4G0AaueyZYZl9pfdXFhYYJwRcst6ReQQ8nFGn+eHlWaynhtIYlCGlMLLZSGfK+yQwYGFJOs/XHKtY4i7KGl8rVliw/FW9XCyCtgGLMFDnTrgo5Mewcj+7avIngmOStmiIvptNRwgtodF0HRohu1fE7BbZv3aEGqrDgGOnjaPjuRpdhaBQSxGK1lClRccK62ufWcz+08Jml7IWh6ADVFNTwGYGs6usT4Rr66w2rF9sf0QAiWH1CQ8ehtRj3cY5Qjhk6pguA91LiIk9V3TwrPGbqDhwhleE/pTUmmh3Xk89awru2VRH4/EMa6ukhZJiW1SgvViDxnHXlx8UJjNY2VLU26/jMSXees3QzQfkSMq4HBJ5Y6gkH2EJSlCtxWkXH4ux4l5OzbE9dx7ZkVjAVl3SxBfaVtSo+YDb9GuS1BqbT7701hCiVZqev9V4OrAAgsOU9m1sB6TDQN8rYsAyQXQieE/fvoton9IrYqvGTcf8vSAmrME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56756d25-b3dd-46cd-12d1-08dca02ff816
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 15:58:26.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbF9aikbk2jKG11+a97gn7z1czGNjfa1V/lq9hLffocrkkuoAbsKQm9G2/D9ZNL9ud1PlT3bhTNRmHVgQB5DMqUJhHZt23u/xvqOnDvb35c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_05,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090105
X-Proofpoint-GUID: fnSXZ4uq7B4nZlCIwgHFhItJg8DNoVyB
X-Proofpoint-ORIG-GUID: fnSXZ4uq7B4nZlCIwgHFhItJg8DNoVyB



On 7/9/24 6:58 PM, Waiman Long wrote:
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups. That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may be
> responsible.  This patch adds CSS counts in the cgroup_subsys structure
> to keep track of the number of CSSes for each of the cgroup subsystems.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the root
> cgroup.stat file is extended to show the number of outstanding CSSes
> associated with all the non-inhibited cgroup subsystems that have been
> bound to cgroup v2.  This will help us pinpoint which subsystems may be
> responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 53
> 	nr_dying_descendants 34
> 	nr_cpuset 1
> 	nr_cpu 40
> 	nr_io 40
> 	nr_memory 87
> 	nr_perf_event 54
> 	nr_hugetlb 1
> 	nr_pids 53
> 	nr_rdma 1
> 	nr_misc 1
> 
> In this particular case, it can be seen that memory cgroup is the most
> likely culprit for causing the 34 dying cgroups.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++--
>  include/linux/cgroup-defs.h             |  3 +++
>  kernel/cgroup/cgroup.c                  | 19 +++++++++++++++++++
>  3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 52763d6b2919..65af2f30196f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -981,6 +981,12 @@ All cgroup core files are prefixed with "cgroup."
>  		A dying cgroup can consume system resources not exceeding
>  		limits, which were active at the moment of cgroup deletion.
>  
> +	  nr_<cgroup_subsys>
> +		Total number of cgroups associated with that cgroup
> +		subsystem, e.g. cpuset or memory.  These cgroup counts
> +		will only be shown in the root cgroup and for subsystems
> +		bound to cgroup v2.
> +
>    cgroup.freeze
>  	A read-write single value file which exists on non-root cgroups.
>  	Allowed values are "0" and "1". The default is "0".
> @@ -2930,8 +2936,8 @@ Deprecated v1 Core Features
>  
>  - "cgroup.clone_children" is removed.
>  
> -- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
> -  at the root instead.
> +- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
> +  "cgroup.stat" files at the root instead.
>  
>  
>  Issues with v1 and Rationales for v2
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b36690ca0d3f..522ab77f0406 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -776,6 +776,9 @@ struct cgroup_subsys {
>  	 * specifies the mask of subsystems that this one depends on.
>  	 */
>  	unsigned int depends_on;
> +
> +	/* Number of CSSes, used only for /proc/cgroups */
> +	atomic_t nr_csses;
>  };
>  
>  extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c8e4b62b436a..48eba2737b1a 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3669,12 +3669,27 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
> +	struct cgroup_subsys *ss;
> +	int i;
>  
>  	seq_printf(seq, "nr_descendants %d\n",
>  		   cgroup->nr_descendants);
>  	seq_printf(seq, "nr_dying_descendants %d\n",
>  		   cgroup->nr_dying_descendants);
>  
> +	if (cgroup_parent(cgroup))
> +		return 0;
> +
> +	/*
> +	 * For the root cgroup, shows the number of csses associated
> +	 * with each of non-inhibited cgroup subsystems bound to it.
> +	 */
> +	do_each_subsys_mask(ss, i, ~cgrp_dfl_inhibit_ss_mask) {
> +		if (ss->root != &cgrp_dfl_root)
> +			continue;
> +		seq_printf(seq, "nr_%s %d\n", ss->name,
> +			   atomic_read(&ss->nr_csses));
> +	} while_each_subsys_mask();
>  	return 0;
>  }
>  

Thanks for adding nr_csses, the patch looks good to me. A preference comment,
nr_<subsys>_css format, makes it easier to interpret the count.

With or without the changes to the cgroup subsys format:

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

-- 
Thanks,
Kamalesh

