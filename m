Return-Path: <cgroups+bounces-8212-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6BFAB89FB
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 16:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A885518954CB
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240B202F8E;
	Thu, 15 May 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k26MzzcQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qC2CQmmv"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6D1FBC8C;
	Thu, 15 May 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320821; cv=fail; b=QcscaU0tlx8AHlU0LrjYBgcyfcYIqyvY+G0t1fB7L+0p+XlGcJGXURBRIraTg8wXOw84r5UDpnpVltVAxliW8j5IiEbL/KZFuZ+SJnFldOW+wgqzANE6xCzTgpSQZ6+YXIE4G1l2fljcqvhH5lUH/qzur/WWVzI/Bus5LGHtKzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320821; c=relaxed/simple;
	bh=oG1OAiqscNH9HVW70OSkGhdA9bgEDGA86ZVnTVDwEKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WMg+R+CbZ8AAKMCDN5raiMBmkpZpUZiTCzxZpU8L1pTfY5xlNMu50jLZuMgAbGwrmvpengxrEX9yVW7OwXpIu0dY3sjnASjrq6878sPVRfGLluubsyK0//aUQxJ9Ku6S1u7lMmGWpaLavulMeUyufuGODbCJCTYw6VyFsHoNNMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k26MzzcQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qC2CQmmv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7C4XA023268;
	Thu, 15 May 2025 14:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JqhcNPYBKliZ8NMqBoXF0o2IX72YjIOKZfHU/mfUs68=; b=
	k26MzzcQSZ2Bpr7imxecLnJj8orRj+nRYWyz9BWtoXCqS64dl2A8jPkqZbsvSRuP
	utJRKrV+sTW+9MMP0+PDVw4XXtvX/KesPiSw5eIgnriS7tr2w9MtH/JpXiNrKJMt
	HZTCbG0yjvmmsy6zR1x0p3bZd2hTPjH06gRnPqK8CYRpu1yoOy7wansUatqwEyMS
	IjteANgfmrH1hXgHYT0OxVJojazU11ZUnwPsEyAVF8FYqqvpD0gJn48YLXebfiWl
	uDa5efFVnnAigVd7WguqebwL6NfDAqeKWPsK3vGiyJFulS74QR3Hl2FxBYUGjMhe
	SxISYQ0ABE7AFUBrBhEqQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgv8bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:53:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FECxCN016906;
	Thu, 15 May 2025 14:53:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc34wjje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 14:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC1X55CPUvdA43sRrkQoe+fnHAeJsLBMpJjA3Px5dkeh72uPLc9aCZWkBra94xCdn6DI/AKq/8VxXbhCJViql/JJ42vwR+0DKi+AsvAFfpbGbqO5ulQRvSg3DyK+puIfho7z9Qt2rEDBZaTdB5J0pEo+AQfK1jA+r++SiJ7cQLvAVHFeFP6XWLmpQookum/Bea2WwnF0EOz8OabuLqi4+w8XAHt1TVgpC9FPCjJPNzk9ZQ5PKuELx7Dar4VKq/vwBtDfTjnYnM7ms4xWC3MXtBSi94VpYEa5wEBUhnatcZTyHnEGyFLIGfNUUMVKlaY3koVGTM7AXeJu6+smJQ4RuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqhcNPYBKliZ8NMqBoXF0o2IX72YjIOKZfHU/mfUs68=;
 b=hI5Q72uGhbiLAZt7I9TRZYpyUHhux+bAIlfW/mWkTbLgBxcoPF4Ou+KeUGywo04Kq5baEkE9zKUh9BhXS7+ZaAPNLiErJ+w9OC8bQLSAqJiOiAJrnEof8LDAwf9xL7bNMO1PxJRTjlbhQHHMFxv6i2zSimKOVePpJSWn2e/DSscMvkkGkI6T3Zkk5jD0QjXYzT2J1RAVBrBrTTy87uHVbeDqC2zfolLfSObcQ5wtro9mrQcqkO/WZcnS9aiIZOktQWiiSARX+NoUbVykME17XMWxZ3AavKJmwHCYNxh4OlbCZI1T6b1kxGeGFvnj0+ORMmgj0d6YxpnuGdQfjUwjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqhcNPYBKliZ8NMqBoXF0o2IX72YjIOKZfHU/mfUs68=;
 b=qC2CQmmvIPzgp3Tfjd4tggP+riIFHWceWUEx9baHL8M61lgQVfGHNhO2IPmMgFttHnSyW8xhFj3u+zrHG6NS4tfV9zVigEGldwTld08S48+qZwH/wx02kamvHWM2Fq/8ncclPRPYIGpTOjO96PptVd+itxwNGQKz1E6qrF35C1g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4668.namprd10.prod.outlook.com (2603:10b6:806:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Thu, 15 May
 2025 14:53:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 14:53:19 +0000
Date: Thu, 15 May 2025 15:53:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Message-ID: <a0328dd3-db4a-430a-9018-db796d0cf76e@lucifer.local>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev>
 <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
 <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0538.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d65f3c-2fda-453b-c045-08dd93c03b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVBjb2Y2MDhrNlJ6U3poeDZHaVV5bnRwTGoxdkxxTitMeHZCVGVpR3dtVm5l?=
 =?utf-8?B?WFRYYXZLNkhZcWJwdWpwWHc1clg0Z1FnNysvOEF6L2JKVFRWOUFBZDdHM2Zj?=
 =?utf-8?B?Mm1sVlBJL3ZXRnRSS0pianRYbXZ3QnhrVFZwcTd1OW1Fd2tsM1JUS0V6dk1r?=
 =?utf-8?B?em51ZDA5VkFQNTFmOG9FcExCMWZjQzRKaFByeXlKOURLdEhMb0RSWjR6TW03?=
 =?utf-8?B?Uzc5VEM2cStha3RkQnpCU3owdUhmM290NEtsb1NBam9LblpUQ1ZMNU8zRUw2?=
 =?utf-8?B?b1ZsSzFWVWU1NlhQWHZDdjhZV2tRdXk5NmZpWXl0MlNZT0NxNExyeEZxMmJF?=
 =?utf-8?B?UDBzcEpLWllPdDFIa2UycGhqV1Y1SFRwcmdBTnZJQ01XV1V5aG85VlIvZ1N2?=
 =?utf-8?B?NWVFMFBNREIyd1dPVnVaWnE5TTNESUFDa1prV1d0aUJEUDN4WVI1a2owSUpT?=
 =?utf-8?B?WEdGY1hYMjZ4eHhITFpYUXJnMmZFLzRXc0ZiYWdYcUF6dXlaeDhsM2J5R0la?=
 =?utf-8?B?d0pSdFFBT0FPa2JGWm9ESEVzNkg2TzBSRmFMQTFvV2l4aGtoVWRrZ01QTWpz?=
 =?utf-8?B?Nk9oUnY3S2xyUWVzNXFKRCtOVG51ZVhKQmFrSkg0a2RxLzNRNmtlNElCRHZQ?=
 =?utf-8?B?UlY4S3BpeVh0b2tueEt5aVVJRkpBbzlDRFpRNmpZREdjYS9TL2h2VkxSb05w?=
 =?utf-8?B?VW9EN1V4TjY4UFJ0LzJpZVpYOUZyNVpDdlJYNGd6Z0kvN3JXVloyRlcrbk1n?=
 =?utf-8?B?OU5UbFZTcFJvY3FQd3VzTVlSRlZNM0c4QnFiWDY3bkJaMUpPcWVYbTZYNTdh?=
 =?utf-8?B?Snk4VVhCNnBRSXlTSGRJdFhVOUVCaEdTV2JIN2N6S21DNnVDbTZiM0pheEJy?=
 =?utf-8?B?N3FVMFlSY2pLeHR4SVNzU1M3aFdpUFUxS1grc1gvbDQ4bHdlbmUyVDE0b05p?=
 =?utf-8?B?bDR0Sjl3SlZ3b0Yyd21ESEN4UDlBQzhaZFJRa1hzV095MUhwdkg5TUtnbVJM?=
 =?utf-8?B?dDJaR2p1T1QrUktBYnJMelBsRklQK29vb0R2WklEaTh3MmR2dmswaTRLZEpt?=
 =?utf-8?B?bnJhNTdWZVpNakx2eDZVbEloMUIrTG83VVVrYjJHSVpmS2VRb2gva2ZZb2RK?=
 =?utf-8?B?VE5iNTdvYzI0cTVBL1owWTNLOE5tTUVOTXRWYmNTOENHZ2ZnY0Z0ZENJU29q?=
 =?utf-8?B?aW54citkb21mNnNsUHRrVjVka0p5WG1HMEZERXBmakFMenplaWNNNyszRll6?=
 =?utf-8?B?REdGSWduZDliNG43aU00K1BRSFlTZnRLSUh0OHhBc3B5eGJCSTRsSnp4RkdY?=
 =?utf-8?B?dkc5aktrRGpLaWdyUHl0dnVKQWs3dlVvTXdITlMwUHBpVmNhZHJ3Q21JdFU2?=
 =?utf-8?B?VHVjVzZORWhJTHFYT3BTR3k4L28ySzQ5UnNJbkxad0JZVThXNEkxazF3T0lC?=
 =?utf-8?B?bThvUFAxWDR6MDEzT21FODlTU2xXekdMVTVOa1R0LytFMERHNGhXQ1F3akds?=
 =?utf-8?B?UjNVMVNnaGJocEZIRXl1NGZ3bTRCc1UzN1htOXFkTHpJak1qSVlmTklpbHJZ?=
 =?utf-8?B?cWtqQS9ldHV6VWhxaTlZOURobmlmOU1VdlllVm80emFZSGEzTGJ2dUNRb2Qz?=
 =?utf-8?B?bFdXLzd5NkEwMlFVWmkzUVp4UWRMbjNHdTQ2bGRvYjByS04zWGFqL1dhMFEr?=
 =?utf-8?B?MVJlcjNvUEVjTzgwaTBnQXZsSXcwREFPOWozbFlkbHdXYUtWa3dsdjVoQjlu?=
 =?utf-8?B?dThBNk5wNHgraVVKQWVWTXdXUkxuMldXalRnNnhwKzdMUk9RNWJFdDhWT1Vt?=
 =?utf-8?B?blFTUG1XQkhLNUgydFRJTWdSQ2JRN0ZxcGtOeXVYUUxHcW9BdXhaVHlSditm?=
 =?utf-8?B?MnJmMm1WRndLaWlHMW1YdG1UMGluTjZkV0xzS2dFWnRNS1ZEWUtSQXcyajF1?=
 =?utf-8?Q?Vx7kiVnz9FU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkZUczZxeXBhWEE0TEV1eitiaVhHN0RlYnY0L2pWK1pid1RjSjRoQXl4MHdM?=
 =?utf-8?B?NjdmRjMrTWRJS05JZzF2ZWNGckdKU1dqTkZhRmhtcktNV2dObDVGdG5TSUp4?=
 =?utf-8?B?S3lQM0k2K0x2RUN2QzhIY25RWFY0QytabWV4Rk9zUUh6K0tDRisrL1pHSnR4?=
 =?utf-8?B?VGJpN2dxRit5NFp5Q3FkZWNRQm1NaU9TYzVZMmczdVR4USt3blN5Y1NybW5k?=
 =?utf-8?B?Ky9qREh6UzF3NFBLYndsMnh2elgzUWZkZFpFaXdmNTluWW1NWTI2NEJLRm5H?=
 =?utf-8?B?OS9oSElYS3ZyZUFyMjdxaDN1dXBaNXo0bE9LeVVibmlSWjVGSnlEVW00UG55?=
 =?utf-8?B?TlRGbDBqOEFza1E1ZDNhYUNocE1GWk1iSmVyc2FRb2hySDdrc0lDeGtQWFRW?=
 =?utf-8?B?VzJDaWFBbmpWazJoY1NRRHA4OEorcGZUS2dnYm9sVUZ0VHUwRHhsK051SUxN?=
 =?utf-8?B?SFVvSmR3eS9VVUFYVkt2SFltc2xrY0FQbDJFQ1lsVHNWVXBQZGpCWm4zZTJY?=
 =?utf-8?B?N2J2cDFlTVY2bkxDZW5vME16ZHpubUU1M0tIR0hUc1YxS3FXcW0wRFhvSWUz?=
 =?utf-8?B?YWROOU04ckNSNGJaUUI0dGdabWs5RllNL1RuUjRHdUczSDdaVEZjWWlHSW0r?=
 =?utf-8?B?ZW05SDNNbk9JQThzcFRGelNBUExjamI4T1J2bEtpcW9nekhBaDZlbXVWYmRt?=
 =?utf-8?B?RHlGL3MxbzNXTk50bS96YlJESWRDSjNIZ1M2ZnFXNHZJL1FxMjczUURlZGZ3?=
 =?utf-8?B?QlEyVE01aC9hRXhocTlEbStRK0I2a2V0OTk1VjVpMzYzSUJiQWVlRlYxUk5S?=
 =?utf-8?B?bjZCTUxOcjNVcEc4RWdQUDZNbXpUS3JUbGIwQXo3a1l3N3NkdjBCQngweVNl?=
 =?utf-8?B?Q0tDdTNiekZ2VCsyQ24rcnkwZU9YUjRUKzdIdXdDSmVBTXJBemlnSWptZnl6?=
 =?utf-8?B?dWVDYncraGVINWZiRDRjNU5STU9ZZlNUbHNvcVhpRTVDenc2ak9VYkNlR3Vs?=
 =?utf-8?B?eWp6bW1VT0Z0aFNOb0lxbjNEUU90Um91eDk4Q0xFbXZwRjVpMUg1ckNNU1Zt?=
 =?utf-8?B?YTlKTWhLR2hkSlVZaCtOdE11MTJOMjdCeHp1WmhPdzZxN3Qwa3BUMEIzQnpK?=
 =?utf-8?B?anlhN1RMVURtenorc1ROSnRIK1BjYW5HbkJGYjduYWE2Mmt6cUpEa3lTNlEr?=
 =?utf-8?B?ZTFlTVp3RWFEdGpwUi90TS9kRlZJT3NHd3FKdXdYMklyTDZJVHlGMkc2OTlL?=
 =?utf-8?B?N056blNjNWR6M1U2NUxabnl3Z0xpOEJLdFN5VE9NMkxUYXRnZTZ6aTAxNzY4?=
 =?utf-8?B?NkZjSk9tRWRua3g0SlNMTW9JczNwQWl5WVVnNVhGZk40WVgybnRUditmZzhR?=
 =?utf-8?B?REtDL05WdUdrUnhXbEg4eGVXTGNaVXRiZ3BMRjRveVBoeGZjaGMraHA1bFpR?=
 =?utf-8?B?M0J5RWNMWXZ3WDg0a2U1U3FNUVRyK2lleWtkOUNzeDVzQjNkejJqV1pqTmU2?=
 =?utf-8?B?WlZSVy93dDBkTWYxQTg2ek9YRXhZR0kzSWpmelFUT3JCUXAxZzM3b2hxT29E?=
 =?utf-8?B?MjZ0ZXM1QndnNXByVWZLMGJTWG9HVEVnVlFvWTFGUmJKa0NuK0RwRWRxaVJF?=
 =?utf-8?B?UHJMUFlSOG41OVBkdFJoMjdoTVZXdHlJTi90WFczbmdkR3QycC9CMk5aSEFa?=
 =?utf-8?B?L1dIQ1BuTE1aUVlyY2N1Q3RQVERDdW5VNnZ0SDZsMm5Md0cra0FOU3FvU28x?=
 =?utf-8?B?a01ITVFmNVhKMVBySFlzZ29kR216K0tpQ2swaHhDN21MRWhQNVhsZ1V2T3JY?=
 =?utf-8?B?TEhlcGdZTDk1V0g0a01DTkpTNXpkVnRFMVFHMkJKL2JEME9YYjRzTG1KN0FK?=
 =?utf-8?B?ODZpVS8yeGdySURZRjhXUFV5Y2c1cnJUZDNhK2d4U0IxejhPL1VOTnA5SWV1?=
 =?utf-8?B?QmRjQUxIRE4wTGFoR1VJWmZTZEtnN2lwdjRkMmJVOE01b3AxbE8zM2NuNG81?=
 =?utf-8?B?TnZZZXBzRUNQdmZidmM4TzR2a2hiVzZoeTF6cEFMT1NMMTVPaDJnczJvcU44?=
 =?utf-8?B?b3U2YW56SFlJcGZXK2J6ZUFoTGxEeHJBUDc0dUN5S1Nxamw2ZkpLaUp4a0FB?=
 =?utf-8?B?RUFwYW9MT0diR2Q4QkEwbEJLVzVxdGFYeEQ4UFBUTUxHOStnZXRVYWlXUzdq?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	osGtdvrwEd7u50ZBpVqR1h018LUxjIWDruFNPnieTR59umEAq/mwQ8/FpUemxd0WzA49Z8K8gox+lEblmYVvRlMK2dqGLyJ/eZ02qoEbaz3HNL1rEoFp8HWoB/YU0ZEKuzt/xrn6CiLGbLzNGBTvyqdqfFWQrFvtom38qKbURFNa/LUHWuoIjZUddnbcoEyXjLvld4yqnoLrCpNiNmMYFLOyl5XW3tH/CmAPuAkKcmh5tvuJNnl5+0flFxZVXHE6j1XaNnM+njTURmNr24tLafOQVtD4EjDaoA4u1Myj/ByF7bEWO5o1j+junXXDxVQU32rwZAynxH42ySbcyqIgg0UgyeWiEr/qp+Kse1TM/aoerOQG59X51xvXy5NGrht1HYd5PGXBX5YJ00+rlUGG1GRvIDa7kx1igN1xrBhJREIIwqzixh5Q7BdmPc996rQCYXjcaq65E/ekG/G0MTxxMOTvDeCjfdV4DTjknHQKjqpWqh7cVNat0dDTbISprjBoc5ItfZxkDZWVu8ALMTV+dnnqYUixq3fF9gH6KJiW3vW5kwqKteX/zMf8JksSlAixbEajVP5doGhcE7KBSPUo5rcqAi8Z380Bb8iAGZVxa4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d65f3c-2fda-453b-c045-08dd93c03b43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:53:19.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwYUTDUzLFIn7yLEaB0izvImgbNV9d1SSRlcOtYOt4QSwCRsDcfhHe9HIzBhVE05eaI0OPbcIxP2UwumSQNy4XVHqGcWvn3Br7YfNlLROnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505150146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE0NiBTYWx0ZWRfX1ttiStdoV76C fIuzDQp3j+l4LvwwGVHJ+BftmE6E3KyeEQBZsISD8PFPK2edYzqCOg4WUS7qowLZtP+9OUT9eud q8ga3NNJpGPcRLJNDcHcCEOXyzpJgxaHEZefYePjXGMqX2hjiaG6VWEoA+GZLHRyl9qMd1wywAz
 4/nL/dReELTSFRQ42xRpq+EB/4GnMS4Mqs6R3dNmSbRcIIukWTudm9+5dO5APmbPMWDirnN/qiN Mbn9Bn66fFM9DKAFT3x5ofyWYJt1Lsi4NoP2DOoQ0lC44I7VpVwW/m2mvlxMqVi2fsy+LIkF8tB Ge98bRFw5VxqDCdAYfG24tYc1XsdOptzKTkApcKu0xBoeM/7L6tbBa27513C6InzrJX32m22C+b
 goDiIwpmhfKNqyQStyNJsTyTOUuB6xbQJRcTMP2GD0kVgzA3FoPhVS6myLOH4G5QOrFiFJd8
X-Proofpoint-GUID: wkRxwfzlOL5SYJ8tNrWR4NMFQqetqYCf
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6825ffe4 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Espr6FYpZztMIyn2qC0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: wkRxwfzlOL5SYJ8tNrWR4NMFQqetqYCf

On Thu, May 15, 2025 at 07:31:09AM -0700, Shakeel Butt wrote:
> On Thu, May 15, 2025 at 5:47 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Shakeel - This breaks the build in mm-new for me:
> >
> >   CC      mm/pt_reclaim.o
> > In file included from ./arch/x86/include/asm/rmwcc.h:5,
> >                  from ./arch/x86/include/asm/bitops.h:18,
> >                  from ./include/linux/bitops.h:68,
> >                  from ./include/linux/radix-tree.h:11,
> >                  from ./include/linux/idr.h:15,
> >                  from ./include/linux/cgroup-defs.h:13,
> >                  from mm/memcontrol.c:28:
> > mm/memcontrol.c: In function ‘mem_cgroup_alloc’:
> > ./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or ‘(’ before ‘__seg_gs’
> >    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> >       |                                             ^~~~~~
> > ./include/linux/args.h:25:24: note: in definition of macro ‘__CONCAT’
> >    25 | #define __CONCAT(a, b) a ## b
> >       |                        ^
> > ./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro ‘CONCATENATE’
> >    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> >       |                                 ^~~~~~~~~~~
> > ./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro ‘__percpu_seg_override’
> >    93 | # define __percpu_qual          __percpu_seg_override
> >       |                                 ^~~~~~~~~~~~~~~~~~~~~
> > ././include/linux/compiler_types.h:60:25: note: in expansion of macro ‘__percpu_qual’
> >    60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
> >       |                         ^~~~~~~~~~~~~
> > mm/memcontrol.c:3700:45: note: in expansion of macro ‘__percpu’
> >  3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
> >       |                                             ^~~~~~~~
> > mm/memcontrol.c:3731:25: error: ‘pstatc_pcpu’ undeclared (first use in this function); did you mean ‘kstat_cpu’?
> >  3731 |                         pstatc_pcpu = parent->vmstats_percpu;
> >       |                         ^~~~~~~~~~~
> >       |                         kstat_cpu
> > mm/memcontrol.c:3731:25: note: each undeclared identifier is reported only once for each function it appears in
> >
> > The __percpu macro seems to be a bit screwy with comma-delimited decls, as it
> > seems that putting this on its own line fixes this problem:
> >
>
> Which compiler (and version) is this? Thanks for the fix.

gcc 15, but apparently 13, 14 also fail. It seems independent of config.

