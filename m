Return-Path: <cgroups+bounces-3665-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C4930643
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101CA1F21D0B
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07513B2BF;
	Sat, 13 Jul 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6DGiPKU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q9Wi72jK"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676C168DE;
	Sat, 13 Jul 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720885876; cv=fail; b=iKf958SMgWFuB1mA9EOpw7N0fJHUIrc6RthAA4+cgp9KFhbHmr0ZWtkpp9wH28clNOKF57LCF3M44x/meJz8iOVpmDXPIkV4tiMeYtgn7BYDR/CHcdss9J6jH6f9g3oghsfagIXCBCjS16KOQdxRX6RzP98ksPOPZqfeXypKsI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720885876; c=relaxed/simple;
	bh=9MEI8vsWQyNy9h2gC9oPRZZUPWzqmnVcJNgTwRyj1HM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=epLIXBGzUUtjk2MQvnI97wxKjfIjscAYHoDzGv6XkNYtBpP4rQ3b+uuHZ+4vxAkS7Q5bDip70QEqWXPBbKXpL8h5FMWatv0UCMFgzDdOdHc3tGnNFsFrW2R6RD1n5Ld3fITUmTUcPm4mXz62Lp7sjnVXOwTNlfnnlZcr2u03aLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h6DGiPKU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q9Wi72jK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46D9kGkU032208;
	Sat, 13 Jul 2024 15:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wTbU53pGsAeQsG5ox6ubhsitR4KnXS9+87/+zPOh+H4=; b=
	h6DGiPKU6jwT9vuXoE8Lh6Z6lZ9KCm9s7fjV3RoMhsD1k+I31GK6eY1IT/Sj6Nhy
	A0CZdPEnkq+JAN9OH9F4GAmTTGCTGdwJq6E/d0a19zdXBKlCPuwkWcFN+HpGwP61
	BXyH7Sh2y7GgldWwL5w9S6mm0cQ+YFWI9jVagQsEwKLIay7BQMV/K2SQpISlW9ID
	AX/21D0C/LcEWpyUHjSoov5d/VcTFuFWhxVJN7Q/zm8zlNEucYoB4klObKMgkDlf
	RzsrujxSPZpX9Hkm8sCqUFxx/4dye3kr9py5K2ilhKcluOWG6A69bv1omsoz6bFI
	XVpLeIk62zUfWi2TmD8JaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bh6srp99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 15:50:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46DFlE1K024357;
	Sat, 13 Jul 2024 15:50:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg15chye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 15:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKFklH/jTNJxj0u69pAgiCpF1QPPzV3lQ9bM/L39sGRgEI/5RMt5HxivFhU+LWXgEUVzX5qxOW0iXWxT9ox7uazo/W2XyHEabU7ec1yREs31Fm515Gm0CqRh0AIvrH/yNeyK37QQ80lEIHLW/cNq+yjeArhDXSTx+k5U/HGQ0vniIfWuYOCy9AUpiG/pFvp9P6gHzW2+eO1EP16Bo1FW0tQXVuUMDazJo9wM9sbWEjfxJr2GmpROn/nugGH7lokNpBlrv0E9kGy1SQ2WFwBJgMgjCc34r7VudJzAuXLUfuwwoj6vPxrJo8vrMjtEWi7NUB09HxF1P6qnYkD9392o9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTbU53pGsAeQsG5ox6ubhsitR4KnXS9+87/+zPOh+H4=;
 b=ZNG36VKmR9bnxP0oQ/YIrKEvtQI/8jJeCy+mfe9MYqgTQGJK8M+ZeRCalTzZO36H0tzjxb/PB4h9SuRvUmZnKg6Q1umjsBfeReMu0gmiY8V+iHu1Jn6qQn7NF+bAtMvxY3MDcDpWgYqf/4Xl0k3Fd1Y+8Y2DR1MAFSAGxYCQGKemTD51Dsa5QctzyUwszlDkgNSnXapEa1A+w5dtDC7yMrtmHEUBbODMLlkd+kenwLZVE0WhycqiAfWBwm9DU8nuiWIJGRg9dnqR5m157Zurk8kkiQ7fHuC6ykHStTe1TIncRTcer2m7Q5XmNGbiNBh6Rcp0nTCm3zkUM4Rc9xuBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTbU53pGsAeQsG5ox6ubhsitR4KnXS9+87/+zPOh+H4=;
 b=q9Wi72jKDAyo5OPiNLh7znQsU780VVt+cBXfdZhtYX3pPFKnDaovse4110O/9limaH57gILGnIenFi3lN3Ic1xmmscsH21xzmE49/0kU2SAy3EoVgaW2eEMTZtwf+BSLc+Xb5P26aNymBv+WVg+2yW2ZtiPTOckKtb/+Y5wX3EU=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 15:50:30 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%5]) with mapi id 15.20.7762.025; Sat, 13 Jul 2024
 15:50:30 +0000
Message-ID: <8481d9d6-04dd-4c33-ad38-fc8ca1667d16@oracle.com>
Date: Sat, 13 Jul 2024 21:20:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-patch v6] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20240712232959.2494935-1-longman@redhat.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240712232959.2494935-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: b1efc8d9-36e0-473d-06bf-08dca35385de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWZyVy8wMWpIWnFTTkZEZitmVHQxc2xCM1NDYUFSRlBuYWFDeUFkOC9pNFJS?=
 =?utf-8?B?NG5POVdHY1NRWElDeXFOd3k5VWxMVlNGOTlPT1pYTW1hL2FJSzRXY1BhTnZv?=
 =?utf-8?B?Vis0MXVTUFlsZzBGU3hRdHJOWDhrQXkrbDB4U2E3Wk9zZy82eXZTcHV1djYx?=
 =?utf-8?B?NkdvU0d3YTBZdkFIU3hqNzdBcXBicEsvcUQyTmhEUHlGMmJNbHE1S3doUVB2?=
 =?utf-8?B?UWRhL2tOMzN5Y0dBc2RxdkdaYUNyd3BYblF4RnBOcU5STUVQdlZ3WkladGdX?=
 =?utf-8?B?c01zT0NKdXNpOHdqRW9UYW9VTThJODBROXJiTXg4bjBvMmRmVU1YcFV2Uy91?=
 =?utf-8?B?L3YydlYrLzNDUzkvQXRIakJ1TVduTVF4Y0tUdk5jMnA0QlJyTStnbnNOQjND?=
 =?utf-8?B?TDZ1cE51TkhuUDhOSU9scXBXYXdqeGMyemJ2ZE81SXRVTFRSNVh1UXp2ejBx?=
 =?utf-8?B?TmVNZlVuMVFvOVZCWitna2FJWWRNQnVTejFFMmY2cVdXLzVtQTVabTVodTJl?=
 =?utf-8?B?Yk8wY2orSW93b1pBMFVsZk9KaSs5YWxhNmhYNWRUUTlHemJTbUE5SVZqMVZv?=
 =?utf-8?B?OUh1Z3RQRGRkZUxOLzE1YUY3YXhXRjRNV2pJRDJrdzdhQ0NrTFZxcTlVd1R1?=
 =?utf-8?B?U3pYL2IxaHpTOVVadUNLdi9DUTZNRGtyR0ZTR3FtbWgyakcyY3pzc0pJbU5Z?=
 =?utf-8?B?NDA4UktrQzRsaGlldzhCNW1abFA2SUZnaUZDRW1GYUJ4eitjdWRXeWtJN2Yw?=
 =?utf-8?B?Wk5LZUh5Rko1UXdaNjZsTVNKWjEvbENxcXdoZG5hc2UyeXQ4K2pnYVFEaDV2?=
 =?utf-8?B?QzJzT0NpeGErS1FZRGFUaElkMU5rM1VtMGxnLzBQdGllYjN2WW4yaVJvZXhl?=
 =?utf-8?B?RmJucWRzdWwvbGIxalhrdDNoMnd2MU53THB6bEpWakVURzJIemRxLzg5c202?=
 =?utf-8?B?b2RFTmUyUEhrYlJ0UzlSWm1pTVBSdVRraml6a3FWMjExd29LZU1NbDRCdWF0?=
 =?utf-8?B?ZXlheE1ZZmVXbXVuMDZJK3hCV0hsZFl1bDVRM0xxNkZPV3ByVGx3a3MvNXpt?=
 =?utf-8?B?SzZmR1dwQ3c2ZEhmSEtQQWV2SU5uWUlQY1AzSGs1K3pvUzBkTzJKWVcwVHlw?=
 =?utf-8?B?Q0NGT3lNQjZUZ2FpUDdQMGs3M2pxMks3TkRleTEvQWRmalltTU9ZWFJSSjhX?=
 =?utf-8?B?WG9iZFdoUlBoNWM4SU84a1VvVVhzbkc2ZmgxWWhuYXdISURld3pwY0lrODBi?=
 =?utf-8?B?OGhOMXhibWJabzZ0T1IraHNKQUtaTFhYUHZ1b1FwR01xTWRrTVowVmlwNlRF?=
 =?utf-8?B?MktJbWtlM0VDWEhkL1l2ZXNjcjRXZHA1SGtjY0c5OUExcVFDeEJpeW9IekpM?=
 =?utf-8?B?cE8xV2VXWmk0R1llbHpqclRTYTdEWmNlbW80OVlETEFKUTV5SkRxQ0JxZFZz?=
 =?utf-8?B?d2V2cHpYK0FCSTdDOUxZUkovYlBLQ01rSDljdk96b2VOZUZYdnh3VDUrS1hF?=
 =?utf-8?B?WktRM016ZTl3QWRlcVNQSlpVUmRpMVRJajVuVGJhNkhRQ2VvcFU1UXNMdFF1?=
 =?utf-8?B?Y2FNNGE4VCtoSG92YVVocWZCTjU4bTdPMFp6Z29YTWpKakF2WGJZa0tMV2dx?=
 =?utf-8?B?ZkZyREhVWFkzcE5ZOHN1aDVYQkpYaHozcjNRZEV0cmdqdU9Lb200Z1BqTUpi?=
 =?utf-8?B?bzNtN21VZzZuTDhpTytNRVM0eFQwSGVYTnI5MVZhYjAvYVo3bTdJWnZ2YXJW?=
 =?utf-8?Q?1oNp+K1b/z9gP6juYE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWZhSDRnbnBjNldWKzRDSC9QK1dUSEdNRXFuVk9YRWVadXRVb2Z5R3hzcWg0?=
 =?utf-8?B?a2dseTZ4dk54dEovNkZCSkR0TTdVeEh0YnlWTVhpekVZNnZ4TjVzTERDcHpO?=
 =?utf-8?B?L1JSVHlJL0pTaGd3U1ozODB2dzRwd3VVWnpnQVY5RmNSWmd4Y29JRGlJSFU1?=
 =?utf-8?B?WXlKUHJHc0N3TGtwM3k4eXU5T2kxdzkzZHQxTDdGdTF4R1IyZTVISkVSSk8x?=
 =?utf-8?B?dzEySzN0dk03Wmxhb1hhMStDcnh5TmNLVmNyVVRWNUVFQlRXRytVRUpBMjFV?=
 =?utf-8?B?elBTQ2xpZkc2YjJRaWsvbFMyRmk1Mjc2RXVHR295RUtoemE3VjBwTGwvOERD?=
 =?utf-8?B?ZWlzRmZnc0F3ZVE1ZUNJMDhwMFAwRk9MVnB2QTVjcEFuNkZqV2R0ajJCZnJy?=
 =?utf-8?B?WnJodjhJNlhRYVFRc2VCcHBieTFrSjNJUTJvelRKamJ0elBwaVByVUd3ckJ4?=
 =?utf-8?B?OVBSNVE2L0xINGlFeGJwdkgvUlZhZnFDN054ekhqYzlPZnpTamc1RWZ3aURZ?=
 =?utf-8?B?Q1hDTVR0N3gvM1B5YkxkUXBFM2lSbjQ5MkhsSDl3TlA3UjVRcFN5RDd4S21r?=
 =?utf-8?B?bnNvWU5KWWNhNnNPdktOL2s4aUFJMUxXUk9uTGpqOG1aWUQ4YmI5cVNyRXVJ?=
 =?utf-8?B?TlpIQmQ3aWVhQ2NvcnZVKzZtWEtieVV3Q1NpZkxGMHVJMkJSdi90L3RnMlZw?=
 =?utf-8?B?U1dXY2dhOFZNUlROYXhMOW03TWRmNHFJQ3A2b0tWZ2dSa2VHWTI5RUNDTFIy?=
 =?utf-8?B?aGVXRnJWcUM2WktJdlJjTFFXN0I3WWliQWdJZjVBZmVZQ2J4N0o5K0FNVDBY?=
 =?utf-8?B?dnkrclY1UHBPYlo0Yk1BRlRYcTVBT04waTJ0TEVCUVNMcXBXL1VvYWttb3B0?=
 =?utf-8?B?ZU1iMk05VkZxakFmWERaUzBBaGNoaGRZaXBGV2xUY1VPTFpjTEtxWmpUdWQv?=
 =?utf-8?B?YUYvSlJsL0FEcmtkZTRPTTFBaFBFVFVZenl6WUJCeWFEZzhrR2lnK013SG92?=
 =?utf-8?B?OEprWDFSNEVVWCt6WVhIK09JcGdsZ2pzTEM0UEpjU2NlWkZ2MEJyemdsUjAz?=
 =?utf-8?B?RVFGeW8rTWlvR0VkVGh5UkJ5dXNVUU0zUlZkTXI0QlpvcCtsOVVTUjUxZUd1?=
 =?utf-8?B?WEJMdVlwazk3ZkdzbHBnWHRlZEw4enZZeFJBZ3o2TEg1dWpXblkwWGkrcDJj?=
 =?utf-8?B?UVZRSGxtWUlac1ZsZWdaVlMyMW9wTkF2Ky9jZHcxa3hGZEtmazBaeS9wL1I5?=
 =?utf-8?B?bytBTTlINVlIRTdYb0lZcDJtcXlTcmxCZ2dFUzkvQ1pTWDltRmtJdkhvYWZS?=
 =?utf-8?B?WThRSjVoT0lkYnJVU3FINVBtZzBJVXZTZ3lMMmQySEh4VEdVNEZXQnAvdERW?=
 =?utf-8?B?N2h4cE5IL2dFUjR4bWJuY3pGZE1tQmh0V01ZVWJuRFc0RkNRanRXK2F5K0tM?=
 =?utf-8?B?RU90WEUzNmFRRkc4VFJPQ2VxRVVPbkJmVFNYWXE4U0RsWjBlUHJHa2tyU1gr?=
 =?utf-8?B?WmFOWnpMaGtlWTYzd3ppUkJlZ29GRXVvbDFsK2VOVjBTR01HVElmUG1PS3dT?=
 =?utf-8?B?M2xqdHBjand6UlZuelpYZHNxeGlRM2d0K1FydkJDMkJXelJQRDM3RG00VHMw?=
 =?utf-8?B?bzZHUGFWRW0yZ2tXZXVRblRWUWpZK0ZGYkpPRmoyVzZyWXlEbEh4QXhRL3Nw?=
 =?utf-8?B?V1hGVnV5cGxwN0Nka1pRN1lyYWxTR3gxVTN3S09hQ0ZrTGNGUjY0Lzg2TUs3?=
 =?utf-8?B?cGVyMU9XVGpZeEdrOUt5ZVFMbTZid0lDOERWdkZNK0xSb2hnQ0M2QldqVENK?=
 =?utf-8?B?N0FXWEFCb3VuUTI5Q1BabzBQSTd2MFVsRjJZQTlId2pFK0E2cXZJM1Q4VFA5?=
 =?utf-8?B?cHdCNUtSZUExV2hNYmZkbHlZVXp2amJqV28yaHRYR054QmJkL1VhQ3pOOWdZ?=
 =?utf-8?B?SVdFMFl3NTdYd0Z0QVZCZkVXZjlocDBLSDU1VGZBSThmK1FlYjlrWUliTXJ3?=
 =?utf-8?B?NU1oNHRIZlV1UnQ3dW1hdFFlU2RPVXZ0QTZWdkxQc2FCRFlQMmRsUGNDSC9D?=
 =?utf-8?B?TW0rNGxDSW9JZUdWbFRkcmFodktQTW9aNjdzRy96RDZ0QnRRcXVSWkNnYzRU?=
 =?utf-8?B?a1ZjZUpZcjc4MHRRTDVYVUVibWtMb0greENRYjJrUWQweU1oWFlCSWdjNllS?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cc5UdGb7j/FwNyPBkJWfaK+sojXgOxjD49r7+kCYvle6MUTj+1BKxuJ4b55dKVTO2UCM7bYbWGB9t9ZDCyHwfXfRVRM9UyJO9NB3XziVzm5VhhxqjLoJN9615nvlkgTEDpnQDwHrCv4qeilwq3iAre+A/Xj0ZPLBcaKeluoPSNVeaGnoe2HtQR9thYx0FDwkb4oaoKIdz+qJkKgIZVVkUUcJbAt1pjSfZyQ9yr9lc1lSljJ4B8560keu7x/hXGirTuXB7qge+w6uiZG3OHgyMPeDBHxahyg1YOjZgR5wZ7EBKI9NcCDuAb7ELGV8pLqFm605Hy8QQTIIk0de7z8SkcP+3ZkzOCl5x9hdGAvnr47gJFTSQE6cgoPCICX3C5XqghpV6jjrTGse7pRoiT7hLjkBLPyAszwMZh/X+rBek5LyeiVazR8GQUZizupDGA3m/pDVi27Cau/7+KoRaXrSk84R76PuQiXiCFX9MMkXxeXtGI6oaYtjmqaRBIrKylG9mFeQcn84ghHplLp0xjRPnzFyqudO/wbTLn0JsWIufSLjdfh4FT6804sCjpWll2hgHBtpk73iRda24X20oOf2x/dqHO32m49ZDPQ/RZ0PoKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1efc8d9-36e0-473d-06bf-08dca35385de
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 15:50:30.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZyzZzIQWCoOjW4+/kmIDE7o/It7YVyfXSjV3k3v11+CXayx8mrhIw8QubJd47kbmbeiPWG6/dKkWNDSlovShaGsMEf6oCbLvu482n6Qtsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407130119
X-Proofpoint-GUID: -3u2eW3QGzzwBsDwzHSnbKE46vrHmumj
X-Proofpoint-ORIG-GUID: -3u2eW3QGzzwBsDwzHSnbKE46vrHmumj


On 7/13/24 4:59 AM, Waiman Long wrote:
> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
> help manage different structures in various cgroup subsystems by being
> an embedded element inside a larger structure like cpuset or mem_cgroup.
> 
> The /proc/cgroups file shows the number of cgroups for each of the
> subsystems.  With cgroup v1, the number of CSSes is the same as the
> number of cgroups.  That is not the case anymore with cgroup v2. The
> /proc/cgroups file cannot show the actual number of CSSes for the
> subsystems that are bound to cgroup v2.
> 
> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
> we can't tell by looking at /proc/cgroups which cgroup subsystems may
> be responsible.
> 
> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
> cgroup.stat file is now being extended to show the number of live and
> dying CSSes associated with all the non-inhibited cgroup subsystems
> that have been bound to cgroup v2 as long as they are not both zero.
> The number includes CSSes in the current cgroup as well as in all the
> descendants underneath it.  This will help us pinpoint which subsystems
> are responsible for the increasing number of dying (nr_dying_descendants)
> cgroups.
> 
> The CSSes dying counts are stored in the cgroup structure itself
> instead of inside the CSS as suggested by Johannes. This will allow
> us to accurately track dying counts of cgroup subsystems that have
> recently been disabled in a cgroup. It is now possible that a zero
> subsystem number is coupled with a non-zero dying subsystem number.
> 
> The cgroup-v2.rst file is updated to discuss this new behavior.
> 
> With this patch applied, a sample output from root cgroup.stat file
> was shown below.
> 
> 	nr_descendants 56
> 	nr_subsys_cpuset 1
> 	nr_subsys_cpu 43
> 	nr_subsys_io 43
> 	nr_subsys_memory 56
> 	nr_subsys_perf_event 57
> 	nr_subsys_hugetlb 1
> 	nr_subsys_pids 56
> 	nr_subsys_rdma 1
> 	nr_subsys_misc 1
> 	nr_dying_descendants 30
> 	nr_dying_subsys_cpuset 0
> 	nr_dying_subsys_cpu 0
> 	nr_dying_subsys_io 0
> 	nr_dying_subsys_memory 30
> 	nr_dying_subsys_perf_event 0
> 	nr_dying_subsys_hugetlb 0
> 	nr_dying_subsys_pids 0
> 	nr_dying_subsys_rdma 0
> 	nr_dying_subsys_misc 0
> 
> Another sample output from system.slice/cgroup.stat was:
> 
> 	nr_descendants 32
> 	nr_subsys_cpu 30
> 	nr_subsys_io 30
> 	nr_subsys_memory 32
> 	nr_subsys_perf_event 33
> 	nr_subsys_pids 32
> 	nr_dying_descendants 32
> 	nr_dying_subsys_cpu 0
> 	nr_dying_subsys_io 0
> 	nr_dying_subsys_memory 32
> 	nr_dying_subsys_perf_event 0
> 	nr_dying_subsys_pids 0
> 

[...]

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c8e4b62b436a..73774c841100 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3669,12 +3669,43 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>  static int cgroup_stat_show(struct seq_file *seq, void *v)
>  {
>  	struct cgroup *cgroup = seq_css(seq)->cgroup;
> +	struct cgroup_subsys_state *css;
> +	int dying_cnt[CGROUP_SUBSYS_COUNT];
> +	int ssid;
>  
>  	seq_printf(seq, "nr_descendants %d\n",
>  		   cgroup->nr_descendants);
> +
> +	/*
> +	 * Show the number of live and dying csses associated with each of
> +	 * non-inhibited cgroup subsystems that is either enabled in current
> +	 * cgroup or has non-zero dying count.
> +	 *
> +	 * Without proper lock protection, racing is possible. So the
> +	 * numbers may not be consistent when that happens.
> +	 */
> +	rcu_read_lock();
> +	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
> +		dying_cnt[ssid] = -1;
> +		if (BIT(ssid) & cgrp_dfl_inhibit_ss_mask)
> +			continue;
> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);
> +		if (!css && !cgroup->nr_dying_subsys[ssid])
> +			continue;

Sorry, If I have misread the discussion from the other thread about displaying
nr_descendants and nr_dying_subsys_<subsys>. I believe the idea was to print
them for enabled and disabled cgroup controllers, so the output stays consistent
and does not vary depending on the enabled controllers or previously enabled
controller with nr_dying_subsys > 0.

For example, on a rebooted vm:

# cd /sys/fs/cgroup/
# cat cgroup.subtree_control
cpu memory pids

# mkdir foo
# cat foo/cgroup.stat
nr_descendants 0
nr_subsys_cpu 1
nr_subsys_memory 1
nr_subsys_perf_event 1
nr_subsys_pids 1
nr_dying_descendants 0
nr_dying_subsys_cpu 0
nr_dying_subsys_memory 0
nr_dying_subsys_perf_event 0
nr_dying_subsys_pids 0

# echo '+cpuset' > cgroup.subtree_control

# cat foo/cgroup.stat
nr_descendants 0
nr_subsys_cpuset 1
nr_subsys_cpu 1
nr_subsys_memory 1
nr_subsys_perf_event 1
nr_subsys_pids 1
nr_dying_descendants 0
nr_dying_subsys_cpuset 0
nr_dying_subsys_cpu 0
nr_dying_subsys_memory 0
nr_dying_subsys_perf_event 0
nr_dying_subsys_pids 0

> +
> +		dying_cnt[ssid] = cgroup->nr_dying_subsys[ssid];
> +		seq_printf(seq, "nr_subsys_%s %d\n", cgroup_subsys[ssid]->name,
> +			   css ? (css->nr_descendants + 1) : 0);
> +	}
> +
>  	seq_printf(seq, "nr_dying_descendants %d\n",
>  		   cgroup->nr_dying_descendants);
> -
> +	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
> +		if (dying_cnt[ssid] >= 0)
> +			seq_printf(seq, "nr_dying_subsys_%s %d\n",
> +				   cgroup_subsys[ssid]->name, dying_cnt[ssid]);
> +	}
> +	rcu_read_unlock();
>  	return 0;
>  }
>  

-- 
Thanks,
Kamalesh

