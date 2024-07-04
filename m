Return-Path: <cgroups+bounces-3537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4951D926F22
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 07:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007FA2833D7
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113E1A01DE;
	Thu,  4 Jul 2024 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M2J8+pr+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MzRtHSyu"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F8157A43;
	Thu,  4 Jul 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072536; cv=fail; b=UOsAq2VneVFuf39/nBNkIgEvF5Hca5NYBYWWajdDdDMpO1wtho0Hx1UrQM/LkeCIW1EYm1awyyqpM8mJ1qA2v1aU/iFkqt1mt6fDGiMR4xF7iKAbJGtyrwVDvljnzPjtpzi5v4yNwtM8P9Rbn37LglQDSnXwrK36H56wAYfuZzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072536; c=relaxed/simple;
	bh=DKqTGffrLo81VJzKk/LuahLOP+EtH3o3NKFBOm7oyxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLpPuPa4ql+RX8ssjYWzkzShbWzbqwj5i7aUCDnhkQZWQbBUImoEupHVT1QbcMsfafKGHPl9/F25MEhKgFYt9GD4a1DOJmo6ZrfALyOUI2jALxResv+XLxZPzHQJ5ULYHlD4+jcXUGKmeJ0h/ZjMN8CzN+48GhHH+2Tf+iuJkQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M2J8+pr+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MzRtHSyu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4642MZWo032216;
	Thu, 4 Jul 2024 05:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Z7MDfHqo1aSKgTq+TQQ7HPAOMjJ3ApXjfQwa0+oFHdw=; b=
	M2J8+pr+rwhGIirBDC5q12toxYDszFvdZMdWUFTPAUPkJlyesQgbvkT3IOoD50J/
	l6FodIKOOs3f9Zblz3OlAJbMqpD16U4nBE+jr+BBq7WM96NxC4Sz3k/ofJ2TlsvK
	zz5rp4eLD2JZf3YXye2Bz//PWUsbFPl4QbkKuMfaP9zG6gLluSNlCIfSX+S2Ik/w
	BO/UcyrJ+mmO6yD6cUqFAObRMhUzxnsrQMam032l7q/aKLCkL0bEJWbDj25iOVAA
	oojhrA4N++qVsx6yXIYtuCg5rmuDVANob+E+frl9hPEZEr91F5uP2VpQQS/cXGST
	l1dRYjfs2Icy2FmAHfhh/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a599ayf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 05:55:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4642Z050035991;
	Thu, 4 Jul 2024 05:55:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q9suw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 05:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZANGhhXCw6RlxP8kdDXDLWopC6Lmsqavl+XJjNRkOSbWz03JZrFEJlJc2iebewRYGYgMA8PsdfzOpH2EX/LPEughMWHQGcL0VziSZzgfg0a6hq9EYDMVBFnxTLpDoo2Yi1Z674yIJ1yPymncVyx/449+ru3phANdqLqe6LhojlJZaz+mq519RrjQyCDL56gNQ2v7Pb3M1ZmBfLLF6xBjIrVN6vwVL2TlYASiVOpvkLfBiocjQ8ToILZhlXbjIOsPbG/ouumoBZvRNyM1lqvLNGlDo9za3jcm29Te58WVf9KKlUPtMf9LwkdDjP2hPO6UND7Jkp8XMcfSlF5eePuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7MDfHqo1aSKgTq+TQQ7HPAOMjJ3ApXjfQwa0+oFHdw=;
 b=fuA7eOCIgLWej4y1YJE2+c5xCL4svnWohVwyf2/0FBA4Hn7HONVuiUn52gDaQU9xiLPUxWA0xklH4ANlsMlDjPdW8jXChLTfoPYJK7HjQ6OJ2SQS0q592WEVd7SsQoqlI7EsvssAqQHgIBOWSmui3Fyvw0Z8K/8KkfIwvEIbqxVxSgJ+kRkw6dIu67sAS/uLg/jouehFMgh4wQGCOT+cePtuJ2j0j0IQofzC4HQURBpshMnzTY3jc7mXp+EprXzaemghfd/Q9c13lL9cYvSARLd2dXVsfBEDlWdlmb1pcKsUesXyw0k+gLMerWWJ8ZF+vjXlwwEpQ4y8uzPOmojOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7MDfHqo1aSKgTq+TQQ7HPAOMjJ3ApXjfQwa0+oFHdw=;
 b=MzRtHSyuQ96z4NcEXU2vYF5X+3+GRygr/1kHXjxV4KSOKL6+eUcVlO83UNtsRO4LwBPXYyCm+3TFJ5Jjq2K1eqHC6fY4LCw0Jl8RRmsKOU+vsUImlb0vF0jxFIV9mJri0P0CcBR/iW2YmXlV0gcF5YDMMxvY1v0jmW5aSvHMa2U=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 05:55:06 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%6]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 05:55:06 +0000
Message-ID: <562ee18a-d433-4975-9737-a88ac6006916@oracle.com>
Date: Thu, 4 Jul 2024 11:24:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 -next] cgroup/misc: Introduce misc.peak
To: Tejun Heo <tj@kernel.org>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, corbet@lwn.net, haitao.huang@linux.intel.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240703003646.2762150-1-xiujianfeng@huawei.com>
 <cb6bc4b9-bbf3-4d43-aeb8-8efdcbf94a9c@oracle.com>
 <ZoWSVBVAbQjW0l34@slm.duckdns.org>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <ZoWSVBVAbQjW0l34@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 529da0c0-b1c9-4f81-c5aa-08dc9beddb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?alZvTjNvTktoY1FlUjVWVTBIT3c4alVCRXlRNWdORGN5cGlQUElmeXNlb0Nz?=
 =?utf-8?B?MmVpNEtibUlTcVF0NzZIREoraThzVW03Sktva0dTaWdENHREMmZZNmVrc1ZC?=
 =?utf-8?B?eG1zcGtQTi9sTDQ5aTQyaThGUWw2aDRNV0ZqRXVpTXVaNGlnKzNqRE55dXY0?=
 =?utf-8?B?aVBDZnp5VkRkM2tienhtL3ViMmMxTVJRaXhiT0x0V09IYlB4eFNkZC9heEJO?=
 =?utf-8?B?TURJUHl2N2JnY051b2NsdmpWN1hMK3dYN0wvZmlxR1FEOElnMkZrTHFiTUJn?=
 =?utf-8?B?SVcvWmNvUDJKdndhdXErcTRWRzR5MUNTV2VSYkZZS1U2TnorT1RFNVhKVHR6?=
 =?utf-8?B?N3hHUTlOMUFZeGMxUDdkcXVjZTVoVFMzaUhzdy9oR3lmK04xbWU2RTRyWW9S?=
 =?utf-8?B?WmVicTBoeE50UWFqUmtaUkZwMjJuRW1GbDhPK0J1Qy96Rk9yQnpQT2VmWitz?=
 =?utf-8?B?WHV4NE5zbkg0cHc0SlNwRXJueFcrWDhUVEFuRHhkOE01T0JmSWVpQmUydzV5?=
 =?utf-8?B?cisxYVdhNHhwUXpwUWgrc2hUTmdzaXh3SERiYU9xazlTYzFkZHhURFRiMUgx?=
 =?utf-8?B?MUcxZ3gzZm9XTDdoYWhTRWFQRXNEQnNRTDhrQ0lwWXdRT1czZUpPcDY5eFRT?=
 =?utf-8?B?SWpBd1B0Wndab0NRTjB2YTVCK0xrc3F5YnZHWm4zYk1lYzk1Z3hpWEhzMHRT?=
 =?utf-8?B?Tk0rU3l6SzF1RGkxRlhwSUIwYTJFT2l2clRtOHNkM0lTK1BxMmFEYlJsQ1U5?=
 =?utf-8?B?Y1dyZDd3RkVCTWxVZ2NHWTZVWTFudXA2elgyb3hVK1hoQVB2dzQ1MXU3MCtJ?=
 =?utf-8?B?YWZxMFcrSzdGYW1kVy9Ta3RFVVFlR05ISWxuMkFscW1mb0gzODFGTktPdVps?=
 =?utf-8?B?NmhLU3hRalZvSzhGVTJYTjRXK0RXaHpQWGJhR0xsK0cvbVR2TWpMaVgxQU8r?=
 =?utf-8?B?Q3NqYUMxOHpPbVl3MzBpaGlsR3lJTlh6RGQxTEtTbS83TkZ5bUZ3SkFVbHEx?=
 =?utf-8?B?YndPRzMzNlhhWTRlQnVyN2U3RmZkRjJpMGxHZmdLN3E0ckZIVmkxSy9tby9G?=
 =?utf-8?B?WldEZEhoOFlJcmhSbEtBMGZJOWJqUU9IT3Iya3FYeFdub1BjSXR6SU1kd0RY?=
 =?utf-8?B?a3ZVbjZrRXBySzB5ZmJTYzRwVlB5a2J1R2RZaVdLWjR5d3V4c016NjBDVldp?=
 =?utf-8?B?eHJ3QlBhaUl4SnVhTFAxaHAvL3czK1JjSTJzenFoRXI5ZWZGNmJwYTJlVDNH?=
 =?utf-8?B?T0NuazB3OS9aQ0diVkpHTFUyQzZkeDVVTlNZWStBd3hIYmRncVRQbHhNbWtG?=
 =?utf-8?B?R24xWm9kOVluZUVhRFAxcFA4MHhodERMRTFxV1RiaVNrM0x4WnRaSVFaMXZu?=
 =?utf-8?B?eEh1ZE1kV2xEa1JvZGhvVFc5NkZQdVNXSGhEV0Jza1JIb1VmZmhPQTdXNkZm?=
 =?utf-8?B?VUpraTg1WVNFUU5WWkhtb1RTWGxZbWd4SE1FQVJxSmZ2enBXdFlGdFJOd1hB?=
 =?utf-8?B?SlFnRGlyQ2pXQUdPczN6dHlCZlEwbGQ5bjcxQmRjOFBvdmR4RTMzUFNMbU5F?=
 =?utf-8?B?RVBRa0ZkbUU5NThwaDBrcDJlLzhndmVLcUVMUXNGTXJnWE9OWXQ5S2VFQzFa?=
 =?utf-8?B?cDNuWTB4NXFJRDFhL1YyeXppeG1LRFZNRVo5UGNYUHRKUkt2RmZhSmRhMEtU?=
 =?utf-8?B?czE5V3ZVeTExMmhmMzRCTDI1WGJiRHEycWhlSUt3TjF1VDBQNi8rb2xRK2p4?=
 =?utf-8?B?dVZmWmRpeG5CTjdKMFQvS2dnRHoxUjRZN3ptdUdQYjZOeXJpTk1IVEl4bmRV?=
 =?utf-8?B?SGlxVTNxd21lYllGNnFJdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWd0bFNWU3IxdWdrTjhVSklWa3dtZStLc1hPNzVvRlcvM3RScTdNMVRxbkxS?=
 =?utf-8?B?aTZweUhEdi9iWUU1cWRyVThKQ0pSbmZQUmtOODZRYktIU1B0ekZibnlhQ2R0?=
 =?utf-8?B?V0xPYXBsZVl4TG10NXhjY3dvVS9HR1EvMTJRNnI4R0dQT005RjVGNTYzeS9u?=
 =?utf-8?B?dWxQcGh6ZkpnUjI3YUhmNW44OUFUbWRaTGYySzgxWkt1bFFWYXFjTk9Sa0p2?=
 =?utf-8?B?NWpkMUJNQlVyUlpuT1VxMmIwdmxPNkRXSG1Dckt6eXNxb0REeDRtUnZnY0tZ?=
 =?utf-8?B?cEM1N1RQNHZCMGoyWFhEOXBCK0QvRHlrelNXdE05UC9ka1ZWZXYwVkY0SDI4?=
 =?utf-8?B?cXdGOEZkOURaY2JKUUJTOVBtbndJQklpSHFZek9vMzVveWk2SDdDQnpCdlpV?=
 =?utf-8?B?bnVCVnBEMzdHeHlrV3lxNU11blpnOWxONVZZT1grY0ttNUk2MXd4MmpyMU5z?=
 =?utf-8?B?b0hpYmZFVDJzMDhTY1BOK1RNK1JVQ1BwSVRGNU9ESGxRS012MnpwU3FaUE43?=
 =?utf-8?B?elZvNnhiYXdUeGRtcjdOcEU5aHNXUWROcU1xcjRVSlhwWUxXajc1dFI5K3h2?=
 =?utf-8?B?NFpvQTZ3THY2Kyt2M2NqZGY5bjVqcm5Ncy9UNGVFSGlkL1lMUGE4R1R6U1NV?=
 =?utf-8?B?MkYwWHYxa2tJNTBZVEUrdkc0N1lzZGh3bVRnd05OS3VDd2xhMER4RFAzTWYx?=
 =?utf-8?B?RHBCOEM2bCtNcVNoa2xiSWxqRnZpUG5oWHUzNktad3BzYllSenlSQWgxYndP?=
 =?utf-8?B?VzVvS240YWdLSmxCZHp0Q0E0cXluc2I4eHdrQWJhTHpVRlBuUitRNEY4QUpo?=
 =?utf-8?B?QUliQ1hyMUdYMno1OFRQaFkwR3pXdjdtdE56TERKT0hvMjdMV01UNHFCSXhz?=
 =?utf-8?B?VHB6N1JTOTY0TUxIVHBMaGVsZ3ovNldrSlVIVDZhTkFJaTJxeWVTcHYyT0hm?=
 =?utf-8?B?SnczeG53THZUakNsbFJYTEVaWnhObkZsNithNk9nZ29TM0tyeVU5L3htVW1y?=
 =?utf-8?B?MW9rOXRTMGpYOW55MThtdVNhc0dDTXYvV0pJWVBNQzU1eVZTK2VlV2JCU3o0?=
 =?utf-8?B?OVNUUmtFbC9pWjRzcDl6b2FDSmNYQlE3THNGbHd1ZzZoa1NNV3Z6WnJUS3J0?=
 =?utf-8?B?ZXJFWFUrNTBMUStjUGM3Vi92T3haNXBrTGE3M2ZJd0R1NjZRNkZnbVhWVzBn?=
 =?utf-8?B?NGYwQldNUVgvRzY1VUtmYnRTd09pb3hKL3N6WHN0MjU4OVdMWHZXcGZYaDgv?=
 =?utf-8?B?VzN2c0Y4MGowQk82c0Nkekh0QVJDNUg5eERTbUVpYitCdWc1Ly9PNFJmWGtW?=
 =?utf-8?B?NDB0T1lUbTYxdXdpeGUrQjJqQTJOOGd6ZHUrbm1SbXdnV2JLdXpTeXVWZHky?=
 =?utf-8?B?TzEzd0tzUElIa2o2Z1dXcVhRNW9Pajk0MUFsZVNYRVFoeEl3K0g5VEkwSG51?=
 =?utf-8?B?L0hmTVQ5cXFscVlEeEhqNnR4MDY3L2JyYTR6ODZ1ZVhzTDcvZWx5TnhRbyth?=
 =?utf-8?B?RkpoK05Dck9ia0pENFErV09VSldxcEd4a2xFemxkdXB0T3VJeFA2b29KWGZP?=
 =?utf-8?B?YmV3Vno5cERoejB6azJaZExGbWc3dFRRYXFsOUp3Z2VyZ215N3BSb3BrcnB6?=
 =?utf-8?B?ZFZISXFUZEJqSkpRUTRyaDJMNlh0TE92aUk0Ulh4cFVObHorak9TeUo3UG5o?=
 =?utf-8?B?bmRtZ1lsQko3UEM4NVFGOVJpazJhNDFJL240azgvZkFOL096ajZIamlNN2FV?=
 =?utf-8?B?R1d4Rllocnp6NHV6UTZ5SWRKWVdZa1dEWXVnTmZzSEE3SzRwalBoY2h2cTdW?=
 =?utf-8?B?REcyTHRGSHV3L2VFdXRuRHVHaFIyYVVIS3lhK3Nub3NDSjhWZFRYTUNZQ3NZ?=
 =?utf-8?B?OVVUMi9FcllGdGNydlkwVXljaHppRnF3ZmJ1Vnl5QldLNUFIYzQzenJSVG5Z?=
 =?utf-8?B?UmJJcllpWnhOMzZwaTRpcG1YRUdmbTh1L0trcmovZzBmbkFPQ2NWZ1hXWUpH?=
 =?utf-8?B?bnpBQXhKR0tRMEYyUGNmWU8vcDRyWklWRVlMeDMrMisrMEtrSWx3LzVPRFFk?=
 =?utf-8?B?RzdPK0grL3J6eWIrVFFuS0xrWXJJRklMTGl1VXlUdVJLWXFITkNaK0Jzc2gv?=
 =?utf-8?B?UWU5bit4TGFYODZxTGluY2dDU0tHUlJ0VmM1L0hNZCthbjMwMUlTWE1yTWZj?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zAFQUF6uaXhNv1kX8OMoAmwFK4MLD2JimX+1TXqxD3qv8cmWH02vLrDp1KtBTXz3Kxbk4XdGMBbI6aLxLSuhNGwHB30OY3FiJOqx/bz/DIPfsDS8/+TjtoIeXKT91m5DPAtfr6L+jXPH9JyB6HX/0icULqWzIrJaOQWtC7zxvIUJgJhyVvIXJYNsHOqRGuoCLl3ghbntN8LUL9yE5JG+YO/r1xjhn/qMmilsDgyJCc83J1iwi1TK8/yN0pbKv+ny1XjNYYHmuL6Gwv1SUxcj8iN3CW20QjVNMHcWH1ox3b1Aq04l/vcQJHoiFgofwpvfEhRP29FyunE9G+PzYuCFFkqUc4tlOBPxonhiRXrhWnhD0pbHZHSmMT0UIqfElhRN9SzlkwXtKQxYP/yhoi2wF9Y3KOcLKZM2CnjUuVa46eV21MQHd+c5mFY5bSYkEjxgXHFydyRgr+pbTwwk9A4Kx+AG+SuB+qprzkIMX+MX4nknrHxEPHDaW3YW8bYKumtbxpl8vf4iACDJS+Cms8fo5tRgiPj4TIqyrKDP+CfqOYp6w7Nv4s491/wsg6q6srnzy3nqHhaueoEcuBcF1e1hN+LjkxwaQj8AioP98yTG+mU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529da0c0-b1c9-4f81-c5aa-08dc9beddb09
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:55:06.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEH/9YyK0W6dFhzv5e7sJgFDgJ+k/W87KF87tR389NM+sJ5cL9EHGH3wF/z6JUom04kVT/0rohDvVp+R3vbyw9ZGdgxF2UWBmTOasKGYg0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=929 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040041
X-Proofpoint-GUID: iR3YWGirjO9Dt5fEScP4xzwiCKOMkyPK
X-Proofpoint-ORIG-GUID: iR3YWGirjO9Dt5fEScP4xzwiCKOMkyPK



On 7/3/24 11:33 PM, Tejun Heo wrote:
> On Wed, Jul 03, 2024 at 03:13:29PM +0530, Kamalesh Babulal wrote:
> ...
>> The patch looks good to me after the atomic conversion. Sorry for bringing up
>> this question so late into the discussion. Given that misc.max is available
>> only for non-root cgroups,  does it make sense for misc.peak too, available
>> for non-root cgroups only?
> 
> It's more tied to the usage - misc.current. For memcg, memory.current is
> only on non-root cgroups, so is peak. For misc, as misc.current exists for
> the root cgroup, it makes sense for .peak to be there too.
> 

Thank you so much for explaining in the context of misc controller.

-- 
Thanks,
Kamalesh

