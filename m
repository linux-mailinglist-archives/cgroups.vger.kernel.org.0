Return-Path: <cgroups+bounces-6365-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A26A21477
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 23:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CE53A7AD0
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A293F1ACEBF;
	Tue, 28 Jan 2025 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/9uT3Di"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0E18FDD2;
	Tue, 28 Jan 2025 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738103794; cv=fail; b=Kfz6R4sZOShoLNmmkNZ+amcmQed9lW9R2bp4gLPAY1prdQ/4lE53lberMcU0k4K3LrprI0XjfYnjTSmr3mFeoSF07FblPbbTmjtLZXgG0WoRo6sbfDfG2UaUSxUu6lRbRDqWUUwcPwY4ebc2vnmfHZSAdpaYZOoPJjxwsh9QlbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738103794; c=relaxed/simple;
	bh=76e5IH99+2vbHvMe809zlKJNEsM3CY967ERvEvCGmSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KiwMxXkdk6bFSE2dNBWLmS4xEuDklNhrCXp3naa++ehWMMbCHq3Y4lEMG2Y08mTH2CSMIRpgnYq98y4SsilSttdvWxXS7mKgNZMIPezCWpxHnId3dfzX5w/4jpoaTPAjOLZOQWwhjJ/c/vIsR7D2itTpSrfRnKkhwFIvnnDP0Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/9uT3Di; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpnsKe1T9r6ko7JZToLZykeuW36MPuDJYTJQV/qs0+e4MIyw6c5LrnJ0jfnSXXhxGD14UavqeY8Tx9X8NJIUO0JtkFkoCcCqXUhDdtRtQqE9NQuqRTJZ+ShQyB4MxseBmnFQPDU9zGyeXNmCnW+6Z8/MaebzbeoGMqfqI6wC2m0Y9+sBmATLSHI1c7zFrRCyZDGbdApSe9CIZTPD9Wigt07kkZxmspk/W9NSVP9wuudg5QjHhOjgvzMstsYSWhiOOBrL6O+NODFL81unuTeBAcd0J99iQsZa3uu2NOODMhi3h2VVXVzZaFUkEpfLPkaVkgL155ZRR6FECkxKPnIJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAm6olGqEOfGgz/t2M+DhDAzqvDxNU5NYGtMpkoN1js=;
 b=SZ8ds31OYSTw+XNLBJV01QOIWoG3CSFJxUG0MKtQZSL3EZTX2GN6uAWwsztP6aNAOoycgeBWtAU6EGvx5WGMwJc5baf25qt64d+F/JMo8DlFvyPuXQ+BuzLHJhFzV8SkP8+F1PoWEtyMnsZHjG5ngR6B3pSW9pf4kdO0fdqZ+myxoNiuS/blt7b2gTQPj5QZb75f67jHiXhCv0v8I/kda95lxJ4LaCGE73YRgqWE2WCw6dwmsF4RoCGQuXqEesQhUwcbviNc8sV1nsH7MWq1p0a0E4ciVOYVMy7USGfMWz/cBhSUCJgxXHR1+gO/Be+F31cdUHTvDb46/yKsa6IYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAm6olGqEOfGgz/t2M+DhDAzqvDxNU5NYGtMpkoN1js=;
 b=c/9uT3DiDU11Qp2ZYxfvdbxL5KBSZdEIy2Akr5ou+irzXTO5XU5H4cr6CoDVpd3lwfSeVh/Oe1OCv31RxhqznfMSX7V9UlJqn+R3O0YBuaTl+BOoOZmE3bFsPHHT8M7wtlBknlIzDHk1RCw/Jlw806aceMz6rwrUP7OToF4XSfAQjXEVm+nmgG1xAkl1/uKZDHiN7nrbg0kk0NAtCT/jxYq5KJqJukbAPHmueOJU3e7jZ1wLFt7dQHl1ipxYlF1YbUTvhmTyJbJHM0+9rS/OZmXihkntNP2asPfsKb8plqOWuVUKIPawRxSsS4tlCK9ikmSGOAhQovvB67Bor/2e7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 22:36:29 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 22:36:29 +0000
Message-ID: <742df0cb-1214-46a9-b004-97dfa8433f49@nvidia.com>
Date: Wed, 29 Jan 2025 09:36:22 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250124054132.45643-1-hannes@cmpxchg.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250124054132.45643-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6c1e81-4ebf-4c2c-a894-08dd3fec350a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkIzQlF3R1NGNVFBZU82ay9HSEY0c3FvdnBpN0lzY2xOTWhURVFWUnNaQmFT?=
 =?utf-8?B?QjAvcjdKdE1SWGxuTWl2RDlyOGs5Ung5YUNVaTJrOUxYMS9JV3FoM0IycTFK?=
 =?utf-8?B?T1RrSUJJSUZ5Yy8rMzJHTm94cTNNRkFkaXp0Wkg3YXZ1VE90L0FzdWxrQWRW?=
 =?utf-8?B?ZENKZHZJdmpLZmcxajh3UzhidVZ3R2x6dU1VN1BaN1V3ZXNoNk9TaGUzbUVt?=
 =?utf-8?B?MytNNllKOElsR0hjc2hpbnBXY0lYV0d3MnpLYnF2Q0pPMnRZNVZaZ3FHeEpZ?=
 =?utf-8?B?bHJ4U052OHFBQXUyaFpUZnB5VkVGWlcxWURXU0dTUjI1dHB2ZjB5Ull4Tjla?=
 =?utf-8?B?WlJEbng5WitIK2hmRkJZZ3Jqb0JxV0xCVUQ2ZlBLUnlUN0lxZHd6ZWtoZnhW?=
 =?utf-8?B?YzNhT2lrcnRRZWNpNFoyUHJYbFhkS2JLeUhKTnZvanpsY3JlTDlRSVJTMWt5?=
 =?utf-8?B?SjNkTmJOR1VXVS9uQXJkN3kvUjRXeHhreE5lUkJMdGtDeGJDcWQrVEswRlZU?=
 =?utf-8?B?SzdjaC9zTjdWQng0MU90ZUNTN2NrdXVuSE1DYXh0N3NKdU80bGNiRlBQVjZx?=
 =?utf-8?B?Nk1aZ3h3aGRJTHFTVHpjNWNucVVCQjFNaDBJNjI1ckVXMkJyRWpaczhWaC9Y?=
 =?utf-8?B?RUlMTDkwVEtmQXo2L3o1RnVEeWxBRGEzTkVTRlorNkdkZ01JcFcxUFF6MXZM?=
 =?utf-8?B?a2Y5QjRQZTBXa0p0MktiUWJvclh4dFVNeXIwQjFaQzNrWmZWVjFWMlVwUVZP?=
 =?utf-8?B?UnN4cmlrdndCdjRvVDU3SHFwUHErV1M3dlVSZGw5bHczdnJKT3RYMUhCT3dB?=
 =?utf-8?B?WXh4WUtldXhtWGZYamtkN3VYaXJiazFwNWJOc2IvZHhzclhvK2xDb1VYbzhG?=
 =?utf-8?B?V0pRRzBLQWM5NGVNNEFibkV5dit3UVU0bE0zMEE0LzhkTGVBSFQ1UnZLVkRF?=
 =?utf-8?B?K0RCaVNWRlAzTzNHdzMvaVUrTkxkT2RtM3QrM1pFK0lxcEpnTjIzVW9aMTNy?=
 =?utf-8?B?WXhuYit1dVdZUERNSUFGL0lRbnVNWFo3TGRHYndYSjVjTm1aVkQzaUdLdnpM?=
 =?utf-8?B?WUZVUUdUZnAvQ3gzdGwxZ1NRWG0vN0VMZ1BTQ2c3NDkrbXBVaDZ1RUJYbDZw?=
 =?utf-8?B?V2p5YTJlaS8yVXZKd2VIVnVhUHNEQ2c2NktVMmQyaEFTaGFiS1FlMlROZFI3?=
 =?utf-8?B?Y09rczhXYXZaRTgveEhPblFhbGJmenU0R3NZVkxyZlZ1RTYrRVQ0RHJ3WTFB?=
 =?utf-8?B?UnBwTkdHWlM1cUhEREM2ajNuNU5JNGgrbWt4bXBCNlVNNER2QkVPYXRjWFdw?=
 =?utf-8?B?QmJLTXB6ZlBDSXM5ekJMVmhFZ0IrdFZuSU5FdkNjdFA2bFpXb2U5Tmd3QStF?=
 =?utf-8?B?cHgwWXlTMHlzOUFUellNcmpkM3kwWHRuNEt0c1FLbTViQ3g2QUZ2OVhxRmli?=
 =?utf-8?B?TDhBTHVyWnRncE9Td3lJZTNoRUVtRExZWE8yWWliM1RiWWhkWGk3eGhuTHhy?=
 =?utf-8?B?VWJoTHF1RmoyQ2lvK3BNaU9CRGFjQUlFWG12emM4cHpRYWo4TFM4MFdJeVpl?=
 =?utf-8?B?akZDV3ZiMFRMS3dEdnRSVU1HeVVCUHlFWEFyTmpDNjhQZDB1eTBCSVA4eWEz?=
 =?utf-8?B?VG1oYnZLeHFyeEkwS1lHLzhZemV1dTFOVjI3cDg4NzlyUjNUYi9UVlozaE9p?=
 =?utf-8?B?MTR6UmxicEd0S1ExVlV5aElIdzBxZnlFV2Z0ZU9UbVRweXdxWWNsQjdiQ1JK?=
 =?utf-8?B?ckZzWkVmTmFodXh1NTQrSUh5WXVOM09pbUw0Q3dsbGYvdFN4d2d3cUJ3ZUZJ?=
 =?utf-8?B?SC9NVFNXL3ZkQlcwNU9rYmg1QnExbm83dmgrSkNxaXhuNFUycVNYT3RVU0Jn?=
 =?utf-8?Q?THKaqu/g1QE+n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhHNFpyZE0wUkNaQVpHQStmUC9YLzZ3MENvTEJxVnYyU0xUeTdiNmpmNlM4?=
 =?utf-8?B?a0ZNWVl5d1FoTW42d2x3SjE5S1VOTmgxbXFmZzIrcDBmSGZ6RVoyS1ovYlRX?=
 =?utf-8?B?Q2dNaXhhM0pYd2pUMmR0YmtZMDNLalJzMGZaaktadmlxcnRlRjI4dkxLTndn?=
 =?utf-8?B?dzFmZmxuaE13OUxMK3U1ZFZqNDR0NEVkRDVzNjFTR2tmRVBmOG05UnZmdXdo?=
 =?utf-8?B?M3NNQlhWZlVKSXhiOVFUYnJDUWlKTGFqWXNtUTRHQTZYYk41Z2E5TFE1V3d1?=
 =?utf-8?B?ekg5ajJMYUo5emRFcmZ5R1lJMmdXMUVzZDkrTW45YmNJY1MzN0dpU1czM21a?=
 =?utf-8?B?Mi9VYXZOZmlqYmFRM3FxdUgzWG5lOU5KdnpmdTZmVTZSdkJKeGRuSDZqWXox?=
 =?utf-8?B?Wm1YSUxjTmVwbHlhTTAraFJwZzRobVE4aXVOdFFzVzFNbm5mQ01wYVF5dlNu?=
 =?utf-8?B?cFZBTjFqVHBmVVZlN0Q0UWNRMDE1MGpsVDQwWU9Jd2tNUUdseUk1YWwwU1lh?=
 =?utf-8?B?RXFPLzhkWjUxOHhOcmNJc0crck9XMlF2Y3NralJtQ2dGeXFRK2xGV1hZeXg2?=
 =?utf-8?B?bkQ2MmdMcnh2byt0SkNweGVUcHpDRHBTWFowdUlVbnUwWUF0dEFUR0ZYSFRQ?=
 =?utf-8?B?ZXNibVJTcWUxaENJTjRlQ01jd2M5a0JobkQ2VkpITm1TU3FzNEp1QzJGLytP?=
 =?utf-8?B?U0NybDg4Nm5vdFJ0RDdOeGxsaUdYSnpiVzBxZFhNY2lsVnRhTDBDa2lKdVBq?=
 =?utf-8?B?UWdXRFFXbXAwT284TVlsV3B1WlNQQ0p2M1pIRTBOLzVmRHNnditnUWVhSDJt?=
 =?utf-8?B?RklVSDVhak9uMHlnVStpaDJOZWM0dWJGMWw1YzhFRWpFVkdESjg2U1hYa084?=
 =?utf-8?B?bzRxeEdmeDlFUFN1ZWVOZWNwWXJYTjRyaUdQT3E3ZkpDaERGL0hhMlNYZVNj?=
 =?utf-8?B?d1ZWSEw2VGloVjBSUmxtRUh0dW4wQTNRa29lbFY5OE1meHV3M29nMkd5RDNU?=
 =?utf-8?B?WWFQM3Y2RUhWeDFaRjQzR2lncFc0dVFKN0srT0xobExxSXpSQUIzNVRrNzFB?=
 =?utf-8?B?ZExKcjg2Nm1kWmhHdHVjMnZPNjZTS3BpbUIzZE9TN2M1cnZ3ZWhOMHlWcEYv?=
 =?utf-8?B?alpJYisxWGkyL1BjTzA3WlhXejkrSHV4Y3l0MEpUSjJzV1dER1ZTK1pMdjRa?=
 =?utf-8?B?VHdNQUljM1U0cVhJWE1QV2VCbDlJZjh2U3owelBVKzVSQmNpUFVidDFaKzdi?=
 =?utf-8?B?ZjYxMHlmeXBQWmF0SXl0TnphMFFkZGxzQyt0ZUtPVFdYRWFJSHVuV2Nxay9j?=
 =?utf-8?B?anpyZXJxdmdNR1VGYldIWm5wTWpONis3SndKNklPSURqYytTUjgwZWptM0lt?=
 =?utf-8?B?c2lvTUx2aWRpdXNBMkUvdnFYbERNTXM1VWU2T1RGOEJqVFF5OE5QS0xWZXBw?=
 =?utf-8?B?bDFtTVNHT3FlUlo3dXV1aHIvZEFFVGx1MXlNdUUxd3gzaVgwNFBLdTJ5RFlF?=
 =?utf-8?B?eWxtVzI4alBZS3RYUWdtWkxtYWRONWFpczR5YXZpYWRVUWFWemdRZzdJbUR1?=
 =?utf-8?B?MU1mVUdja1BRQ1pMenpTRkpRSWo2WHBMYjl2Vk5mSGhzQ0R6eDM3V1ErUTI5?=
 =?utf-8?B?cnBTMlZGZE1nVVVVSTdOTDh6WnNLZG5tSUVzSGJrUEdNdlRtWUJoN0pVYyt5?=
 =?utf-8?B?T01VMnB4dUZ4UERoZlNHcVpHUWhPZzEyOXUxK0Judmx4dmpkZzE4VDdGdjdN?=
 =?utf-8?B?L3g2YkRaN0tVeUdCOGIzUC9tVS9lVFBaSlhMQXd4QmQ2dk1yUi9wVHl5TGpw?=
 =?utf-8?B?MkJwWFhvMVpLTEpDWEVxaGR3cE5GMG5XdjdIK0ZXZFdodkpsbWgxTzB5UTFk?=
 =?utf-8?B?bzg3WFZQSHFQYXE2Nzhna1dybHQzQms4cmxPKzhoUzhYcWM4K0Fra1QzdUtY?=
 =?utf-8?B?alpCUGJhNzRiY3ZzWEJQbkRsYVZlMnptcDVjS0c2VlcvVzZNa3JvT0x4dTY5?=
 =?utf-8?B?UDRFVVhpZVgySHpHWSsrTnRic3IyMFpJdHFRSy9ReTg4cGVmQzJpSnc4SWVG?=
 =?utf-8?B?TnFnNUlrOG9zSGg3THg0TGNGZ3JBMmNtc2Zjb1NhTktCQ3pZd1ZId0pKbzVK?=
 =?utf-8?Q?vLOja18vmzS9lTzJt3JclyuLu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c1e81-4ebf-4c2c-a894-08dd3fec350a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 22:36:29.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJNPVVr1KF0eTqtkv3vI9/Lqj/rb/Z7yjFSJeOXH0+3zYuT3+YJSOb6pyP5Kx7P8+S9f/F9VNYbW6umrP6spYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

On 1/24/25 16:41, Johannes Weiner wrote:
> The interweaving of two entirely different swap accounting strategies
> has been one of the more confusing parts of the memcg code. Split out
> the v1 code to clarify the implementation and a handful of callsites,
> and to avoid building the v1 bits when !CONFIG_MEMCG_V1.
> 
>    text	  data	   bss	   dec	   hex	filename
>   39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
>   38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Balbir singh <balbirs@nvidia.com>



