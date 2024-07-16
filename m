Return-Path: <cgroups+bounces-3693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45E9320E9
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 09:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74DD1F22DC2
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 07:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72522339;
	Tue, 16 Jul 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hpGPlBDh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="toomteGe"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6C219F6;
	Tue, 16 Jul 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113584; cv=fail; b=K3VEiyYDbVI+9K5Lx6l2xhY+gylpq7l5WYTA9tHEOg0zobWVd0LUJiAU0RLaCL8rSk2H61Ns3qbiJSzdRgurOyndl/x5cvZrWlhFDJBr3NAsK5WfgKm4yYCPqk6KgCLAw+9tJCqu+/1VDnqqv5eeNFyYkx2W1c+qrUvErC/NyUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113584; c=relaxed/simple;
	bh=Z7+DUAKwSFDHfAsUp73OlkF81m9FtXJFOeAS7Artwuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMCIHfaf1ZYxNFnprZZYcJO0eKiPecwiy6o4NzLT54L4VaaflIqjafgxT8iX8WbNz7qEuSinETAQw3D2DNexBJ8gEZecWi9fLXv47mUAoijiKkbtv9WOX5Vty8BUdw5hU5Gyj9r5zlN4WnnJvf1ndky1HADB/GIPjwTuWUsdBJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hpGPlBDh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=toomteGe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G2tT82025506;
	Tue, 16 Jul 2024 07:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=huVsarbt0PQqy5nxw/xMenY1wVvkP9AxlM9b4f340Ws=; b=
	hpGPlBDhKNohYLSzOWoiEy6cLE4bbe9ajrcbMqSxBbfUaioQWjYqK/oLJQhgLFz9
	6YoK2GJv+4w65MYMFpoqaEY5YAknBi1RhIr7Ff7W/EPfP2EOMp+qP6IqWiq3nKnW
	SOEM5TeXMSvnj9IK15sDWvGEH5NM8mK4pXtO+I6Aor0SqlgQAF5b9OeJPtnIiO9D
	08Wjd2flcjtwbXunWoApVH7WO1QyTPC6TRygZeGrcFnqx7zSp67q6lbOPvnOTyCT
	rgDaVDdcG7ns2F96wv7T9445xnnLU2gtFpxiEhobGRnBVFOQ9t6HhSWGxmkJj3Gh
	LCrCnWXYAS7K3Ty4N/8CWQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhmcmwkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 07:05:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46G6E8Ej023520;
	Tue, 16 Jul 2024 07:05:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg1f733h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 07:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFPFI4mHwk8mBmb5tG1lL0nMwzb9oWZr/OF8889wzFPMuwIg+J9s5ozdMNN8GQ07PkLhYqnPqGSRzEITLyV9v3e8kON8+CO/7imhq1/grc72y2vR+uoeRQGyD8h+B5s9RYv6pAmZtmIkTwqED1c2cBp44qzIV1DsMthLQYi+TZ+yWxKA2+wcLC0UxB2aH2yZk4Oy3LY7B2Az6wp6hAEZcCf3sMjAnQZ2A1/oqT+OsvMZRI19bWct3rcqb3P46hEFV/K7ehDciJ1QGrqX3KZHnkaigtTXLEJqn7Cwjrt+qYJKT4SGjqRyMgYLT1QxPiL5SF1uKYony0ktOr8CahvGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huVsarbt0PQqy5nxw/xMenY1wVvkP9AxlM9b4f340Ws=;
 b=DJFEYRFZNgShELLpVYqu8joDB6qdXqMl70mwBFkJSA6Imqlsv319YkadMnZaLFZj/czyn+D6AjDskN3PkXzW24hZoFDBMB4g5PLqc8/1L3FDu4n3R5MSpay6yCsMC7qOJXHZTNJ8XU9vkPF1lw3I+luVUMd4gHyac7T9XkjBqIhU5UEZKofQnSahZgQ8yL3Y4+dTkztvn/mOXXPLuB6Uj6/vPDqT1W3DCJukEusfnxUkJf7m/0p1rqrVJ8UMhoWekQprFql5PT6Evsl6U0lMT+O4mkmzdBOHcurHDUwdaRBaayMWAdtjO+vCNi1F8ngJmzvtvi7QJlLP7oEbQdiwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huVsarbt0PQqy5nxw/xMenY1wVvkP9AxlM9b4f340Ws=;
 b=toomteGegobDVD3+wmh7hMheefcAKU768PdIdNG2ll3Fbwb18xfB3R714KcwqZbQ0N05P+w12Hq5xuSFefKfdFW/CZ+NkbRMaTaWjU8O7hnckrYK2jxI3tNhiN2Unh4tfCzL3zbMnfalMMBN9Jzg0q/cH0cIY2qrACu5dcoFzXw=
Received: from SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 by PH8PR10MB6291.namprd10.prod.outlook.com (2603:10b6:510:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 07:05:54 +0000
Received: from SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce]) by SA2PR10MB4777.namprd10.prod.outlook.com
 ([fe80::1574:73dc:3bac:83ce%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 07:05:54 +0000
Message-ID: <d095d235-e769-4472-9fad-339830277301@oracle.com>
Date: Tue, 16 Jul 2024 12:35:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v7] cgroup: Show # of subsystem CSSes in
 cgroup.stat
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20240715150034.2583772-1-longman@redhat.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240715150034.2583772-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4777:EE_|PH8PR10MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 4595edce-c774-45eb-1771-08dca565bbc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cjBWWVc1V09aWWtBQ05pWG9tWDhSeHl0OG5xVXdPVUdHWFdzZXlFMnJscURt?=
 =?utf-8?B?a3lnbkh2YTA3UWVVSllBcXhGYUxHUnlkYlRhdDZuQ0NtNlREMkhZb1BiTXN5?=
 =?utf-8?B?anlaV2toTnplbUs1R2QwMlJzVTV5bDNheU5qV3h5SXdKKzRJRzNmbzdIZjZu?=
 =?utf-8?B?bmt3QTY5ODNHTHVyTWlva0NtSFRqZWU0aHZsL2M5dVBVV2F0cG9veldOaExD?=
 =?utf-8?B?Q2tKSjVCcm1lYWxFSFZPeUhGMTh1YVpvRE43amVJekhaRjhIV1Zjam9YbXNC?=
 =?utf-8?B?bmttWDV0cHcwejZlUHVSelZDcy9EZndNRmVoTEQ4SlRjNkxJY1dFdEZvL0Fq?=
 =?utf-8?B?WDJSYjcxamp5WS9nZUQ3cEU1bFg3Ui94YUN0R1Nlcmo4Y0VZb3grelQwVmJN?=
 =?utf-8?B?aUFpSmNTMWl4UXV6YmtHOEVObGl5czdzYmdjWFVGOCtiOWlUYVliRjFmNERT?=
 =?utf-8?B?ZkdiZFdnZmJtVVdtVzkvRWtHUFR4b3NWQjNOdE5adzJKcnZnUHUrSW9oK0Ur?=
 =?utf-8?B?djNWSElqdE9tU2hidnA2QXNFMlBINkRESWFodFdnU0F5VUhzdjNGeVZhYXlu?=
 =?utf-8?B?N2l4YTVBTTdKTGMrc21qSmtHTU9TcW1nWUFYVGhMZEZoR1RzNDBuY1JzMmJS?=
 =?utf-8?B?RUVuSXNoamNHRzlSVXAvQm1NVmJVTkRZN0tFaXRtbTN0d2loVktBR3lBOFNL?=
 =?utf-8?B?NEtIeWRaUnFqcmgxK0gxZTdsWDI2akZhK3BFd21KRUF3ODBNVVdQNFA0V3FN?=
 =?utf-8?B?QkE5SmxELzdnbmNKS1EwV0hvM2g1NG1HUmFJWUgxVFVOU0xlaW5wS3JKQUk0?=
 =?utf-8?B?OGh0U0ZBUTRPTnFYTHEyL05ucTMvbUlrRVRmMmdCK1FZSmFtb1FndlhZWVUv?=
 =?utf-8?B?N3RhbkxMSExyL2Nob2QvZjB5emRYSC9jSExLNlV4Wm5wdHF0QlJpcnk3Qzlj?=
 =?utf-8?B?M21sWEo2aUQ4RjlBVmQ4aFl0ZjdWYW55NEJRUVNJc1ZiSGdxQXBBRTJEMU05?=
 =?utf-8?B?Z1dIdEs3RFBiQmUzVmZkcFdQZEdFOWxpUlNOMXR0MDRnRlpVaXVmNlBFYjBq?=
 =?utf-8?B?USszRE9pRFBvOTNOUFd3ZEs5cWU4U2E0K0J0dXp6UUFPYjhHU0pCbUJRODgz?=
 =?utf-8?B?TVlXZEhCcS8zaUE1TVVqYW5IbTlpMHdVOGo1akd1eXJmb0ZjZFBBdjhvU0tw?=
 =?utf-8?B?dnRMRnJVZjBLUzNRV0NDMTRhb2h3WjVGMjhtcDhoYzZNdVdkYVozaThZblB0?=
 =?utf-8?B?THNnRHF5SjB6dmpwZ1piTmc3dXhid0Z5VmxmNEpkNlF0R2Nxa0hmYjFhSjhK?=
 =?utf-8?B?YWZvOEVNa2dPUHJoZXc5YVlCenNWanhWcEw5dFRiQThCakkyaXExU0FpbC9t?=
 =?utf-8?B?VUhxWnlhdU9la3dzREdKR0laUUJ1Z01NQURUZ0wzSUNoMG5vUkNubGtBam95?=
 =?utf-8?B?bUpRRzFxaGRhRXJvSldEbWh3SEFvODE5Nlc0VGVyNEx5SXI0bjJtaHg0NUpv?=
 =?utf-8?B?MVRDZG1na0R2cjZsRDVmSGdCNGdiMXZVb0VWdG9MNGxVbS9wbCtZUmpyL1dN?=
 =?utf-8?B?UHRnakdueVhDN3IvQXpKNDhncGJPMmVQM2QybTczM0pmSHZsc1JzdVpUbHpj?=
 =?utf-8?B?UWRESnp3ZkJuWDhrSVRocnBNMHNOSlZTWk14RHBmYUFxcG1EYVd1a01IdzM5?=
 =?utf-8?B?ODMydWZyU2M4Y05laVF2WkNiMUcvSTgvaE01K0FoenNOUnZmSERTOElxMjB1?=
 =?utf-8?Q?ck7ZcYHpuSHU/71yMs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cEZ1Q0QyWjV3M083ZWQzdU5DeGczd2ExQS9uSURsVXcrYUhENGJHRHdUbFRu?=
 =?utf-8?B?c0p0SmpNeXIwZHlreEVxWE1kNWN1SytpeEwwWG1iaVFPZk1mSmR6VXpic0Fn?=
 =?utf-8?B?VG50cStncFEzWllqSDNWSXlDY3ZPN3NyaXFnSG1jc1FmWVJvdjBSbnN2MUxM?=
 =?utf-8?B?VE1ZUmt1Mm93dEQrVzJFTWJRSzRyUzczV01abUNONW1odzhPUTVjcXhZczV1?=
 =?utf-8?B?c3NIUkRUY1Bqa3lHTW42OGV5dXJsempTc252VkVodlMzK3VUU0FkN3pkaEdP?=
 =?utf-8?B?ODlNQ1dhdWdTcHl6c2xFbzNhMkV5ZXVFc1YvWWF0RTVaMjF2NlUvQ3YxMStW?=
 =?utf-8?B?b3dtbjF4RkhGWUxBbzByaUdaaDRuU3VrSk01Z245VlFiQnkwUEdYbFB3aCtT?=
 =?utf-8?B?aXpqWFFKN0FwMG9yZmMrMGwvRnpsTGJMM1llelZrUVpiWTh4MnJ5UFBQWmw0?=
 =?utf-8?B?blA4a09YUEdNcG0yWHRsWjkyVnFsVW5jcHd1aVJJUTVCbitkUWp6Nk5JbUxo?=
 =?utf-8?B?R3hodTl1NjAwQVZFRWdONUdSazlpWi9XbURJSW1jYXhkMkdHblk0bWZCRFl6?=
 =?utf-8?B?Q1ExUTE3U3A0cmp5REhZZXlhYUhBY0JWTWFhVEdxLzB3NkRMeEFmMlNGakU3?=
 =?utf-8?B?eXc4VjQxV0Z6aHNFUjBydEtZT2l6eTNoVTNocGE0WVQ1dmFmR25MOE9pMlpm?=
 =?utf-8?B?OTBtcW1DOXBIeDM0VHpFSHhDK09rdGk3SVE1aUNBOUFhbFhPRCtjNEwyZ0t6?=
 =?utf-8?B?MVZxYy85bUxCTmlhQUNPMjh4U1RtMDZtTG4wWkNvY09xekJZYjVrTzN4M0FV?=
 =?utf-8?B?Mnd5T0FCOWY0TVo5R1dwSVpFOHI1ancyZGNKM0R6R3FHMlFrQXBraWY0TDRP?=
 =?utf-8?B?QU5Venh6bjRYTFN1a2NlR280SEhwZmxRNVQ0M2prMDJjeGp0a3VKNHMwY3Qr?=
 =?utf-8?B?ZHNlWnlOdkd1ZkgvMERkcER6SmNMTkJRZGgvTUg0R3pwdnZGZHE1T0h6eERO?=
 =?utf-8?B?S25jSnZIM25WTk5wYTBUaDZYQ2Q5UXI1MUM1OXBhV2FTc2dORGtmSWxxdnB5?=
 =?utf-8?B?RVQrb1dEcUhydDJ1UGlwUDFxQmd4MWk2Qmh6SklZQXQ2WE84QUR4eFU0dnNU?=
 =?utf-8?B?aDVGTWRybk9udmU1YmltMjdrazVBVDNJbXV6UElnaUVSRXJNV2JwejhucDRE?=
 =?utf-8?B?TU9lamFXZDd0bWhhUjdaZlArUkx3RTJ3VXF6V09TQmJNMXRVRTRSZVJIUURS?=
 =?utf-8?B?SEg1SVJvemRKUzlpZjdsb0JLckJxZmlGZnZBcWRjNVpmZTQxM0RpbDJPLzJN?=
 =?utf-8?B?d0dOUWVtdi9YUi9VdG84TmRhMllyK3ZKSUgwdlNGVU9JME1aTFdDU2lzN0tr?=
 =?utf-8?B?Q1RkVHFaam9GcGJaYVRVMS95NEJJSEh0SW5BcVVvdlhxaVRid1RvbGxLZTc1?=
 =?utf-8?B?MlBnS3ZoRHlvNC9TQjNueVg2OWdEZENQSVgvMG1ZdFRyTUFCVmdOcE4wV1c1?=
 =?utf-8?B?MzdBNWFXbWR2VlYxenZDbTg5TXpUZ0crS1NEMnhuTHBCQVJSbnk2UWxaU2o3?=
 =?utf-8?B?KzcyOXRpVFhIUlJCdnZkYWJBTUQvalFLZ054UmVFcUp0VFJMMTlpd0hPWlNQ?=
 =?utf-8?B?b0xac0ZGMDRJT0IzZUZVQVRqMUdiZ1dSNzQ1OWJHUnpnTkZZUm9yb0NYUEdR?=
 =?utf-8?B?U3QrZXFmVnpRN0lxS3d5NkcwOVFON29kMXZQTFZsTVdlSEhZdFNqMjhKTWkv?=
 =?utf-8?B?Z3dVZGZqYjcwTjlDNXpGbWU3MVd0VmlMZFNpMFlQRjNZL0x1cDkxcFZyamU4?=
 =?utf-8?B?SEo5aHk0ZjBiM0htT2pxbkhWQXVuSHRYT3h5UXhxVzRtOGlBRDRoNllvNnlr?=
 =?utf-8?B?MFhxU3RVWm1SY2YyRHFNMi9lUWErTno5SmdWUDBxZDVKbDNjaDZuNEJjN1hh?=
 =?utf-8?B?dnlEdjBOb09ld3luT0thMENNa0RqejNmdE1LZFExL0gxT2VVTlJ1UVZxK1cr?=
 =?utf-8?B?Q2x1ZGFlbzVCK0tDTlRXTkVVdDIyR1oybmlVdXc0WXNBQUpybmNZL0ovUFg1?=
 =?utf-8?B?MlJROTEvUGlkdGZlWnBtN0N6bEJ4TmJQQmd1MWZLc25TNU41MnlPS3BQZ0F6?=
 =?utf-8?B?UHpFdlFMeVUxQldJbVlxcWxIRXN2cWdyS0lEU0RJdEhrUEhNS1Q5NHR5UVND?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RDRj5Ufy9T5YRJNkpqGmbE9wWlzHHeBtFknLPcv37fDPAbaU2vV7+DmJOBdAklT+sgScQkdisbDsEbneuaHwqn8af5OCj9HA7193htvnxS03AvWBa4fpsMG+9n/5k1AKo1UjLOKC0Grg+5Y89QAn/AwOalOmtQMzpyO8Bf/eAklSPk4eumo+y5sq42sVjkww+zhZM831fhNv6iXL+N5BAC3ITZ4ePyZnsHCJriLFNQb4YaZDuokyLQtUIwcjGGsooTyGVYT5+EluTRRt0T5qPG2sal54v7n+Qbpc4TOIeiQtXRelWtzEHHXIv9GHORosqh8BgWLssDZ98mw1xme1P23jpQLtQaRpkltwXqpxjrSrR9A9l9mIGCQ0u+vquQNGnRl5UkL8ZAh7b/qSPZarpp/odgF9mGpvekh8TlBQAyNo9lQmCuHGCTuaw+Vq3/Py0W/ZCW9usumvWHbf1N/g6PiSiYuJQ7ENcTUxT2kDCZbYikDmN6tXmL3ML+nF7rAsKl5FgnbAuU2d60ubRqWYGk6OV3dNe3G1gnrEIi+aqtIaNNRJZ3GnQwfizhISWQltJu440PwbLWtrsaznDIp3bksqBzyx20mKbph4l68q0SI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4595edce-c774-45eb-1771-08dca565bbc1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:05:54.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqjTmKXDpD1Nibm6Fvn+qZji8r9H6WSmgaJ6BxacKmGKADnnmJL0gurnQC0M/aL4stLSSmJRwvxZYtwrCbQEwtdwzJDno+TnyxeQfUxUyTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407160051
X-Proofpoint-GUID: 9nSDxTZdTmXUpbh3ZpsOUDoI0s9B3oem
X-Proofpoint-ORIG-GUID: 9nSDxTZdTmXUpbh3ZpsOUDoI0s9B3oem



On 7/15/24 8:30 PM, Waiman Long wrote:
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
> dying CSSes associated with all the non-inhibited cgroup subsystems that
> have been bound to cgroup v2. The number includes CSSes in the current
> cgroup as well as in all the descendants underneath it.  This will help
> us pinpoint which subsystems are responsible for the increasing number
> of dying (nr_dying_descendants) cgroups.
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
> 	nr_descendants 34
> 	nr_subsys_cpuset 0
> 	nr_subsys_cpu 32
> 	nr_subsys_io 32
> 	nr_subsys_memory 34
> 	nr_subsys_perf_event 35
> 	nr_subsys_hugetlb 0
> 	nr_subsys_pids 34
> 	nr_subsys_rdma 0
> 	nr_subsys_misc 0
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
> Signed-off-by: Waiman Long <longman@redhat.com>

The patch looks good to me.

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

