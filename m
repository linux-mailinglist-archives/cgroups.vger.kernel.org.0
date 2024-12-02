Return-Path: <cgroups+bounces-5727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FB9DFDF8
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8D7163BCA
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2E1FC7E1;
	Mon,  2 Dec 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ov84+4bM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g794Ev5i"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9C1FC0FB;
	Mon,  2 Dec 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133603; cv=fail; b=kIyoUqGN/bLzBlC26vWDcCa64VAxjyCf3LxiDm4b6D9qN4nG3NlTxJS6ChcwkoJHsxDW/dwWCGG5gAIIBhboDwjPU+TQ+Zl/ZiM02DowZBCJz8zXSDCKOci6ub48W3sCe0kStOF0aTaMUqaOSllBiCtTfaQZ1ffLiR/4ABpoias=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133603; c=relaxed/simple;
	bh=uwPLuOU4ILWYTOCPCY1cX9toyYDvZYy+qhBncDKYvXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbr9YyERzC9gUoUwpT+jnkc9rOxAa/OEmocyuIhp4d9w2MFWNNDN0HOgTx9wMxltL9zKytgQzQP+WyPR1Xon3/ZlqxqYPBDcz0DAOGf/1X8XsmvtigsjOG70GN2/JCJ06f4Fw43UgBIlxmwKco2BRctrpfg9N0yMgf0u/J3kDrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ov84+4bM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g794Ev5i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WujP024793;
	Mon, 2 Dec 2024 09:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YcEmB4ZP4kQoAJfI9HnWYcu5flJ8w3Kbp3iiL39OVIo=; b=
	Ov84+4bMwiMcbiXAgcrucr/V4W/57VRTfGuTlxW2cZJtg543qj6bwxO+bgkLFmPW
	sKeAEp3JA+FD5ul+MxOZk9ijWSK9Jqpueyd7dknT7vcK2uoDTYNGzlw6Fym8Kv3E
	KblaOPI4FIprnYHMeq4abv1Gfqvr+KWuced9i6ZleQF+TiDHR6K0Du3TjXlJ9kUJ
	hMmRNAe5ioC2kXSjUFhZFtKWyto15yothS8vgWZMC1SPU69rdpksn1yBoSlg2Gm7
	9ZFVjXieR86uFobbMY5xA9P/kzHz9ZbrBGFTq+0scxcyX6umGPB5yTVWdaglG6xB
	cpkQlA9CtNnHAmRBDPxa+Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg22jgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 09:59:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28b7xn001920;
	Mon, 2 Dec 2024 09:59:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s566abb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 09:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVbdZIL9GVFWTiZ7fKu33xfjNKoLFtkEzMKETXt+igI9JCEYUE4rMEYmLaCeZCvMN2zOIyaU/leTakLkq4IM1wJdujhKUyj6Q2PtDkppre7OZ5h/zIXYxvRr2UURys93Wdgim7Y75EdCgX+R0/lXKlD13Ae2bsCj4ahOrnMwxiMD76EXNd5cvnRfGcre1AzOjJ0Or3x8/ExohTpI9PuqE9xRELd8uImDezbg0W7sOb8VSYNaxhRz2whykAN/8Ru14G7xoQY26iVG95KIXsVZgkwcowcSjT92lhaLKIVKSS+IeD58ofJIWh9BVlwzzThZ7FIWzVN8qx7PVhxitk+2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcEmB4ZP4kQoAJfI9HnWYcu5flJ8w3Kbp3iiL39OVIo=;
 b=MghSC7hzveqxfUgqcOBoEpjhX2+0rs87xRpJk9A2ucAyJZg2/diPPDXXH5yY0pdXONIr9eJcTpUuAy0WGXmXWLhHbRfQyCppW+YPtRvTM0AOtgDEabicA3PnELDQlNLSKRwKwqsNiNUVOWuxFNhs6xzHZVbhncSDAuRRT3+/ToW/sBKupvvZIEL41MK5GH123muv1mkGX5EIs6MN22/9XDv5jl4RV/Q+unf9tHrp9tK3rfrBzxsL4nIe2Em3B7lFEY4EkQ5db118/lvYsK5BT+wqx9H7EG5TlaSAC0TFTKHjynG2F8lFEgQ1OmjxOYMiT/aNCakO+amCeET6VMZZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcEmB4ZP4kQoAJfI9HnWYcu5flJ8w3Kbp3iiL39OVIo=;
 b=g794Ev5i+SO1SaAtwubStuQOOBMJvRy7+s78pq+NqTp7+78n86gCptDhrTd8+SMpvMMA/yOrAOjZJv3ZeqdKdmkWlkTvZd2/ImFmN//3wEMNUXRlbSezvcMRZh1ksKOrooKxg1uQx43G9UX77lbmliWCFEvZnTbKDRvGC3ICEtg=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 09:59:52 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:59:52 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2] cgroup: Move rcu_head up near the top of cgroup_root
Date: Mon,  2 Dec 2024 15:29:26 +0530
Message-ID: <20241202095926.89111-2-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202095926.89111-1-siddh.raman.pant@oracle.com>
References: <2024120252-abdominal-reimburse-d670@gregkh>
 <20241202095926.89111-1-siddh.raman.pant@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::12) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4f7896-4116-45fd-0d24-08dd12b81118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFU2bFU0S2lsQ2xTNzlRcXZXeTFOYXd5R1ZhTlY1eXQ5aDdGaWxhazJ1NjNM?=
 =?utf-8?B?T1lUTGVMdXZESTRBLzBlSjFvR1IrTGlFRVgrY1Y0Q25pRVpOenpab2dtWGxl?=
 =?utf-8?B?N3YxMGtoa3E3MGZmNWhBaE93Z2FEbktTeGJPQUpLdm9hbkZDQmlwMTVXMDVE?=
 =?utf-8?B?S0h5Sjdtemdnd2w4VnRlMXpkTFUwSHIvMHl1bjdEV21qYXVkRHlObWRDL1ZG?=
 =?utf-8?B?UVdOa2c5NlNoejBGRUQ3OUIrc1k2cHg2ZXRIZVdCY2VocHlDaklrVFZ4cEQ3?=
 =?utf-8?B?dGtvTExSeEErdm5xZTVXT1BxelA4QXlTSW9zZm0rbmsvNDN4bnZqVCtiQkhU?=
 =?utf-8?B?Q3kzcFRSL3ZjR09KMmc1N0RSM0R1V3hkQldKMVZlMzdZMTdEQzM0cERkWElN?=
 =?utf-8?B?ODh2Z2dCUk1RYitkUCtZeWhYcm14MjI4U0VaVzVpSzVOcjVrSlVjWXB4cFNq?=
 =?utf-8?B?VkFRb0txaE5JM0hLRUJrMStqczB5VlUrdmxrZFhvVkdUWjdtdWtiODdoUHd3?=
 =?utf-8?B?amJoc3h0N3lrWWp6cmtJaHg0OWhxa3dwaGFJL241cWVFWjlEa01zRnF4TVRM?=
 =?utf-8?B?UC8wbDhSSUlzUnBXTGc0V2ZwOWxXc2hucmRMYVkxY1Fldnlkai9tVDA5Uzdp?=
 =?utf-8?B?U1htNHFiUXZodnowUXVKUXJONkYrUFJyMUxvWjd0SmZMRDR4N1ZSb1hJS3h0?=
 =?utf-8?B?eGFOVFVMRmNwZUd3V0w2MDhFVkppVTl3TDdadTIxMmpkQXBkRjFDbXV5akcz?=
 =?utf-8?B?QnQ0dnk4aHFMSWx1RXBxZmp2Y2lGdDRsdCtwMXpFNWxyQk82b3NZL1cvamhU?=
 =?utf-8?B?TitScWV2SWpHaTZpOWJlUFNPUWZ5UU5mZUp6ZEwrR2dIcm5sZUt5WklHUWFh?=
 =?utf-8?B?M2lzTE1rbkF0Q1BVZHNEd0Y4NmpSdnJDVkVjT2d1NlEzWXBVdDZPSkxvcGVD?=
 =?utf-8?B?VTZxekN3c1FFZnREdWl4SU5vWTloVkVmdEw4YTFPVS94RjZkOHNWb2M4TWkx?=
 =?utf-8?B?cXA4ZjJPMUMvM2ttUThDaW1hQ2o1WjZWNWV3aGwwa0ZQMUg2TUFBT3I3ZlJ2?=
 =?utf-8?B?dlN1dHFjMlNFUFptaVhuUU9FSnJtUi9iMzdXVkpwNzRaemdmQnFJWkdld3Bz?=
 =?utf-8?B?aWJqZ1B2SXd4U0o3ZXJSTVRSY3BLVHZuclhFTDdXMEU1SzVXM0M2bkZLMGYr?=
 =?utf-8?B?UEFJSGhtaitmL2VrQmUxdStwRkRnL1FsamNmMG5GZU9jc0VNYkdGOVN0eEFK?=
 =?utf-8?B?bExUd1JaUE1PZXQ5Y2hhaDVlcDFWMkkzcUFHTGhWSkMxRXRSZDVhelJUNDRS?=
 =?utf-8?B?S2s4L0FiS3p1UmJvdzVuSFlISU5DZEZIZm4xMHlzNWJYMUlnS3lYTFVHWVo2?=
 =?utf-8?B?VW9MZkZwYUN5QWRBUTFKazVmTW9VVENmZ2hKNUl5NlRYOHNER3RKVldFbzlx?=
 =?utf-8?B?Yml1b0lxak5rbDVQdUU4eXY2RUc3VjZRdDFmWU5UdW8rNnlLaHFTdzVWR29G?=
 =?utf-8?B?bGRrTHlLNlJLWXdkOTYvOHVWWmVXZUoxcWVuRzhyZWt2b2Y2dzVnYzFWNGpQ?=
 =?utf-8?B?Qkp0NVBpWWROZEIvT0drdGJLRXFNS2hJZXYxK1VjZEdsS0lkNjM1dmFKbjds?=
 =?utf-8?B?L2tJbTVPVkMxdU9qamN6clhCaXdiekplYkVobGxCYVRWaC9ZVVNTMGsyM2dU?=
 =?utf-8?B?bGFRa1NzeVRoaWpidXROa3YzOGx1bXVPU25XNEIrVHlvQ3hEQVArOHBoWUtQ?=
 =?utf-8?B?YlI5UlBQbjMwT1YzWE1QRWlDK3VUSHR6ODl3RDVmby9ZVnNUTVhOelRKMVhr?=
 =?utf-8?Q?EDRWRpg/TdFqNPq+Eah032RcDELP4oY2PQidI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhucWROdVhEeXdYR0g1ckN0dk1iTWx2U1VlMW1OVTlrNlliMUtWTk0xam5B?=
 =?utf-8?B?cTEvaWNWRVpDTXRBdXR1VW8veFRMNEJ2Q01EK3RIVWIyWnZ3bks1MTBycjdO?=
 =?utf-8?B?ZEhNUXBSRVZzMGx6ZXkxbFc4SmpwRjNYRkFMb2RGNnJTSDYzUE5ZMWZQeElP?=
 =?utf-8?B?OUZlMzZlTWN2ZktQbklwZnNjWkdUYnk4d2d1RHBJZk90NC9GelloMkNuZVFr?=
 =?utf-8?B?NTJOOGo1U250ejNScFN2aUZXVjFFR1MwUHNNTFc1M1RUU2JEVWFYN1NLVXFl?=
 =?utf-8?B?T0M1ZVIrcU83YWljU1gweEtJMUY1NzNXOHR6TFJRSDVZM1JGV0c5enJFT283?=
 =?utf-8?B?ZFozeWZYbTdIbTh2UzRoMS81VWlSUSs3T0xFK3lPc2k0ek9vRC9QN25vTXNv?=
 =?utf-8?B?dUt3TVQ4a2JjRm1yQ0VETEgrZktEajBrK25Ea3pHWFF2NUhYNEZUNGdoVVRX?=
 =?utf-8?B?czFCZjdVQkRVVVl5cTF0dHV3UEUrMTZTV2tqZlFGWW4yOEozRkFQWCtjdDAw?=
 =?utf-8?B?Z0k3QkZqeU5VZCtkVmsrcU5TNkpKbUdTSnNiOHhkTDVveGJlMDhFbmZkZGxh?=
 =?utf-8?B?RVNMMDFUdFFsWXM4M3RFNXFpcjhITzd0a0RVaXNrT1EwZTZIajlnNzlCbzFu?=
 =?utf-8?B?YkdVNHh5UUNZTEFtQVkrNEg2dHBHWkw4L09WL1V0cHJXWTBOMzR3OVFoUFk3?=
 =?utf-8?B?UDdudW1qRFlhRUloS0NvbUxXb0VwQnFHekg2NW00QkJKRjdDWjZlWU1rd2lB?=
 =?utf-8?B?RGpQVnRYU2J6bUJPbEpYUHl2cmJvaHMzK095WmxtbmpiT1FDTk9INzJGTUI4?=
 =?utf-8?B?eExtRWpnNlpoOHZ5bXFZRnFXTDFzcFNEc1N3V0oxZm1pQlVFVy9IL1U1L0w4?=
 =?utf-8?B?K1pMa0dWM2U2bmVnbkpDd0tLUEJyOFNra0hLSS9QTmRaY1F2NTkwalVEZUZ0?=
 =?utf-8?B?VHFpUWRBR2g5dGZXcXJ3UVFBVEFLNVBwR0NzQ1YzMUgvZXNTbXY3ZFhhWkxq?=
 =?utf-8?B?bUdVMDM0UWFpM3o0djBVYXhFRUpEVmhEemc5S0wySXROcDVRUHNwRGRUMDV0?=
 =?utf-8?B?ZkxNaHkwUjlzOXBXS1hrbjRPcUVtbHFxcDhTK3FnN0Y3V1dVL25UcDBITlFu?=
 =?utf-8?B?NVI0WmdNTGVFWUxtSUVzbUtxU0UxTEk3Zis4aXRqajJtUHdmbEpQemczZlBa?=
 =?utf-8?B?K1J4bjVnR1I4MU9VN2xCMGxaU2thZU92TXlqOGxWK1l5b3RSKzFSVHJxUEZo?=
 =?utf-8?B?SUJHcmwwYlNmV09zZFNiVGdYU3FhWTFUSjlOUEJlTkZpL0tVMzFLQ0Y2emR3?=
 =?utf-8?B?dzYzaGgvOFJFM2ppNlYyT0tSLy9jZWh6VlJFZm0zd2szNEJrUW83MXQrRGdJ?=
 =?utf-8?B?SFQrMEtCRC9IYlcrNklTQ2sxNVZsWlZmcUVUR0liR0xwRzdRSkZmWGVuaGRo?=
 =?utf-8?B?clVma015K05seStXZzhjaWpBYXJIVHJhTEZYamxsYXF2cmZPTG0xZ0tkbEtV?=
 =?utf-8?B?RkR3UjhmUzNZem9wZUV6WHV0REJLckZ4Sm9YSnR4cmJyVURtOVZ6b1NMd0lQ?=
 =?utf-8?B?ek9OdXlMUGpIcGRRekc5aVB2bEFrOU50a2NnSys3Rm9YY0hjY0t0YnFNN01X?=
 =?utf-8?B?aFA0YjM4TzBhbS9qZ1lZWE1NaEtWcE1KcVFDWFZyWC9xZnhWdEN2M2NBaUVF?=
 =?utf-8?B?TlU0VXhsUzgzMDNUNUxqM1BQdldSbWx0WjhkWFFZT0ovKzNoZ2NFMXNKVEVs?=
 =?utf-8?B?OUVpbjduOFRPb0xvVm5wSW1KRTY1ZzUvaFYrZldYZ0NXSkJLaGNSMUtYdEp0?=
 =?utf-8?B?MGl2cG8rRGNqaWxySE5iZThRQmFQTnZUdDR2SXFMYUJzUUwrcFd1UUJ0R1N2?=
 =?utf-8?B?MTdGOEljM3E2bWk2Y1pKdHNsWHRxcUxrZDduSUxndVBlUDRPdUtFaVBMaXpP?=
 =?utf-8?B?MWZzaTM0dC9zaDhNM2syeFdyakpxR1YrUHRqRmkwaCtpdTErY1U3dE9tU1Q3?=
 =?utf-8?B?M2tuV1g0WHVscjVEMFhjcjM2U1gyVmJKQWc0OG5DbHpQL3J6TnZ4ZFQ3Tmxh?=
 =?utf-8?B?OWtIQ094SnE3d3AzVC90dGd2amRTRjFHZXE3Rm8zRUFNaElQcThpNjh0aUN5?=
 =?utf-8?B?VjZzNHNhNHJVbzJtNnJaVGN0cmJxd0FrUktZdUR3N08zVzg2SWd2V1Zad2p4?=
 =?utf-8?B?WUd5ZC91Vlg4bDlUa2lrNk5JQWtybHhZQVpaWkJtem56ZFR4N3ZMa0pwMGF1?=
 =?utf-8?B?VHIvZWlXU0dFWkd2K1lGVHd2ejlBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YZkQ8u5ARaybjZcWulqxZK6o9jCJ29CFMdver63xwn7ALxc1+G9rqyavw4PARR5pONqmHRIKXQ76OGnC4WXIC6o6YOPdLI9kyojFs9ZRbjsz9MoQZFpaOYaEyGGkd8Q/20R3YWm7wq2NCYRiZnPLPWsSGnFITcuwoRuy2Bq0qZ59O6DfUqRA5IIowQ6LbfiKyxhGFbhfO1VnxyPNBEXKCS3+VCDeF1mhgFl0ps424roWZ6suJm6yDoSCSlK7GCmPaQ9+Ppz/t3/f/GOmE6iy1ZnRN3GW/5pX8enahGSoYQK4m5QZyPqPE42ZiTgoOa6+hQFgzlMltv2ntWKvdd2fO7bDSvFgfM+r6gqaZVQZRpI7/a4I8CvJaHdkvAsYTEXRKB/ktYesshgs2xH15z9kMUGqlgwDctojKqpPsRUV4ciawuWxtkfl8IrC09qN5I5CqayP7iRMs63UyPrfJaAf98eIwO50kk7Ckl7UwtLpT9fKa0VRZd3CIjmnpwj3o6mwHQQ4OadmQqDUpbrAUByK9fi+uE2+pNtIBEe58pBnWqTOS04xnYY/drZJCGyYp2OrZryJe9VlO1fhVfDEMQZDrDF9cvXvewtJ0sWuZ5a2Na8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4f7896-4116-45fd-0d24-08dd12b81118
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:59:52.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpdw2POvf1B7PPI1vEpkV9bsPZixMcTH0a6dqLuDjd45YrTTe70Up03b1SM8QU6l2pne62hpbdNS4QXOBX10watUykfkxGytjIQB3OUEMcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020088
X-Proofpoint-ORIG-GUID: 0tezmr1PiTtfWB3a5VJEQwdAguXE1jFn
X-Proofpoint-GUID: 0tezmr1PiTtfWB3a5VJEQwdAguXE1jFn

From: Waiman Long <longman@redhat.com>

commit a7fb0423c201ba12815877a0b5a68a6a1710b23a upstream.

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The current implementation of kvfree_rcu(), however, has the limitation
that the offset of the rcu_head structure within the larger data
structure must be less than 4096 or the compilation will fail. See the
macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
for more information.

By putting rcu_head below the large cgroup structure, any change to the
cgroup structure that makes it larger run the risk of causing build
failure under certain configurations. Commit 77070eeb8821 ("cgroup:
Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
the last straw that breaks it. Fix this problem by moving the rcu_head
structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c64f11674850..f0798d98be8e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -506,6 +506,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;
+
 	/* The root cgroup.  Root is destroyed on its release. */
 	struct cgroup cgrp;
 
@@ -515,10 +519,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-	struct rcu_head rcu;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-- 
2.45.2


