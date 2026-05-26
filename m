Return-Path: <cgroups+bounces-16296-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOSjAZVaFWp7UgcAu9opvQ
	(envelope-from <cgroups+bounces-16296-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:32:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD55D27B0
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0477C3021665
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD853CAE66;
	Tue, 26 May 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fVdVxm5E";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QqQxantm"
X-Original-To: cgroups@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E320FAA4;
	Tue, 26 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784337; cv=fail; b=YU6Q39xVHA99YFwU95Gr03SCsf+DEbe7J17PDEcwosqRMcAApCim7osxFLCgLv+8rEvfizGKpcZRgKfZV6/2dYeASqn+EfT93ggT9dK6CYo9EFcyPB0GC7TYqJ6dvy0/n5CVYPoep4DOk8nfly0hvBVM1gyGXRSFt5qlPcC07Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784337; c=relaxed/simple;
	bh=wEBFzEU0r4pmSFU9SuLupbTIyOw1CNiBrvzI0JnzpcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtHbwenA+p55tOoBiCLe7v+qKZ+YWgrmlvuMxMFEocmulJubGBC868x0TjCbvdrs6qiLXBPGY/W+ePMieGv57uvZ/FSw8rJLLqjXbYTPzUT00dawrBCUy0/GGe7OgIazcuIpair5vVE30hcFJpNhHYWimlAXOxt9AwOelJ3Ca7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fVdVxm5E; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QqQxantm; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779784335; x=1811320335;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wEBFzEU0r4pmSFU9SuLupbTIyOw1CNiBrvzI0JnzpcQ=;
  b=fVdVxm5EuLEyB6amtxJcbUgB7kPh6Pdqc/pwqcZaex+146ID+LsODarJ
   cr1jF7sVVmY0XnIAhaawu4msV6XRoywwCRgE693q4xs9p/ttRWhpOH0G0
   CM4t/22zCwlcKfvgw0fwp568tKVOpQomemk80WQOSM09pX3rxJYBcgXdU
   KjurD6FwAQmWOLZbPba0lIvuuipdOLIuZVlWai2JD0eLTOTWsL9TXPdla
   8dj6uMM9eUfdRB+GZ/Bs69nvJPW1Ow15MlsMXA9qqtbWtGbUDJZl4jDZG
   qFl1RaPqDTOiKJYehcuI8kP4RcVhqvHDQD9FNdIqoieXy66ctAtjm4WKW
   A==;
X-CSE-ConnectionGUID: 3ZziJprjQ7uDIZjJWsAM3g==
X-CSE-MsgGUID: i+RQKKW2Rje40f0cCGLZ7g==
X-IronPort-AV: E=Sophos;i="6.24,169,1774281600"; 
   d="scan'208";a="148615651"
Received: from mail-eastus2azon11011039.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.39])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 May 2026 16:32:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3sr4YYhDbZO0hQ/1vKl7U4LUqHhJx+U1D4mJmUoOtU7rogvE6u8clt5SIf7hpkUwIwcC8+rC2dHVSE/cABJyhUulmIG8ziHe7vkO8qtGxhHiIZBavgjre3Lj03LnZ2+OzGAHzLYBNlw1hVJ59pTtE7aE3PDVaKZwJ/OZ6V+LVtvEXGWXWkvhZqHTaHmAdmiZhEIwWVJpA+F5xv6LNHKnP1RUDNoNIP8Wa/xMaqd0iYx/mtSU+3pYNQKB3ndeFh3X3aORukMh8QpS5sYhWCx/HdG7EUcu2s/08w8wA8yBzId/HWd+Tbh21YWb7TxOXlKtz9nAUGGha6jr3s3mNMkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBqKrYaPuUOZU2VaKXzqtNJZ7pg/1zV6fqm+UT7Ara4=;
 b=DEyg7MaGvZnXGsGE7YQn0sHn+vA25BdOoG6ThsZ/Zd23hHORkuUEZBwn5yym4DpLRfg8IMmyZ6TDCpaD4qxY8yvx/+A+/stmGc2/q6iiO7a+G7GFGwJBwG5mvxsj9WVvMA/e16V2lprjaySU+WM5USTgrX5Fo6yN1jTWuJXPWnY+aLoBuFkgEVXbQ30eXdZZfcPwk+TtIU04tu+U94hJbL4QjiPzyzlfhSXUd5/59cNFpfF3H+ZeL4Y/QRA6ReUFi1SMnc/4QHRN36XoPi4zOUicWG2oHSmZ1fW48oBtuTLzzdN3ZribzC21lL2r3uWktCrjgMMHOCchXvStxfRE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBqKrYaPuUOZU2VaKXzqtNJZ7pg/1zV6fqm+UT7Ara4=;
 b=QqQxantmk/xNxexnV3ryomTJS5gw9U2NUpagQM7mYM6cm1hWDCJ8gcA5APAL4Z95/3YpmkUkYDLgaD68AzyeQMxrVbpCcFxD7w6nwm0doKmCgKEqP6F4m+dmblGecr1UTUaSBYPxEnrovnkOuaDAuRYW5IUAp5ueBnmBRsxKtCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7515.namprd04.prod.outlook.com
 (2603:10b6:806:14e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:32:06 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:32:06 +0000
Date: Tue, 26 May 2026 17:32:00 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: schedule parent dispatch in
 tg_flush_bios()
Message-ID: <ahVZaRJbKBq0eSvU@shinmob>
References: <20260522091530.1901437-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522091530.1901437-1-cuitao@kylinos.cn>
X-ClientProxiedBy: TYCP286CA0236.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bcd54f-e605-4e72-dbeb-08debb0144e1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|56012099003|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZtzfDO0FMsS+2tBOOLS7YdqDSKJeajW2r+U3z0eL5Vb637owa9Ys+nq/s4HduZM/hP4Gl5FoBG1FdToUZ+XEiCvSnbc1T73W6GoQDR58QnnJgcJLhPCbGT3eOSfYkmm3LRgxcV+46nV3nwVAwJYob432db+WO4m0W1mu9dcmUwYhgJKCJrKlbvc3QAJ56ElGUtEss7bThvQydARxUFM8qvQu5ctvlW23UDorbJfUkB5twd4oeGfiVpyvWjEc3MCxr4mpCN1jsR3/yAb8AE10NR+NjgvWRhjTQxdl07hSNRExzhRL5/9pk/GzgdsSYkyqkNTL+R7lBBS4HtM7bJu+DzOdrEDzUyFcWscR/Xmb5/9ntUfd00xbW1W8RXRqBnQ3hy1NtBeNlsHDXandxIoLdsxIFJlh3V01+MjbtSaVd25LKedhhBODZmpFZ7wMrj9FBylm+4rV/NLH1QHioMzNHhBVQHldGtwoEPa8CCgqmTHG50EAA1KXIeh8aheARrEk0YxxK5xZIIEOqROvmQkdVKyThbfcByL+IfVdSoMnP4JVlBwo4LDR6dHbfj4R7x9AOuR7LMhUgNgWEplZFpROxeu3+0f3Vin9E8876OenXmgLXGKG11gcx3GbHQNUFU/d/EcFcfhPdVAZfTEJ+LvUHW56agcDhaet7gawnCezJalEKtxrF53Bi8Y3/zrYA6CR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(56012099003)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2DxgWcrPHuhB2ZQeX6LD7CIWjWstgXMbqRB7UpmnTLZ5c3Dh/tig4YW0nCL?=
 =?us-ascii?Q?f9x3XBtCVWa1YYhdO1WNAX2an8pxBbF5OfVPcWbzFQyBf27l4Dzt7z9TMkCB?=
 =?us-ascii?Q?ua6yJeJo/B4v+G/h5k85zDhQD4sTccCxrHD4O5jiXIK0DlwgJJSnbfmz6ZDK?=
 =?us-ascii?Q?L04qEEBdV1jwpMhVADzCN3KzLp/LbUQ8AyRYK5UGI3g50/pcijLI1K/VRi2N?=
 =?us-ascii?Q?nVTdXNRF0mPQnK6HjLiXSfwn63J2eV4/hTdWFidzb66WHMw4Deo//zUKqe9q?=
 =?us-ascii?Q?mqLt6pP0JT/oqSsMhswvEaA1g5/YcTqd2UnRfHmvIIWzBllMqLU04N09OF3O?=
 =?us-ascii?Q?mpclaPID05sAlnp3cTQ/+cefCIPXFjRO7jHaoThkv8SsrHaz7sCNAXQWSzjT?=
 =?us-ascii?Q?lz1V/xHOqf5IZ4CEIu70iTADpIO3m3gDCAlgJ7TOoAyjXZCnQYWcImeaSDGh?=
 =?us-ascii?Q?Lg4JfLAkCcNk5UF4yZUWHSvqMVxhA6hcXorQ+YNRiHf/VwBhxBoVYjxU6n8s?=
 =?us-ascii?Q?D8Vn7uE+cQkACRGW1pZMnkmyDTKNVQJyuNJ45kgZO5OCBZRs7E4GV5OttgbP?=
 =?us-ascii?Q?Y7VN6HgXsNoDXnravggxuClATJ/C/l9l4NPBehiczruo3srUfOzlBRIH10y4?=
 =?us-ascii?Q?R9Hx+VC2hLga+vGl89xeD9CJxZchAwRLQJ2WfvCuFW8h2TNPsysbphr9oCF6?=
 =?us-ascii?Q?CG3v/6PCogBpF2VlMoN4LWSl6szFWNwIvjVMLwKiESNJx9FhcJh5KBk9i9g0?=
 =?us-ascii?Q?1w6QxCceSzUExEGeDSRZdaS7DQDGBMy6vyeslGB20CeBrJAJ7mHGJlgp+wCm?=
 =?us-ascii?Q?JTRJRYg5e2JNI7iUs63SIHTzTI1n+F0llOBktNqzIRwTlG0GL8usE4bhzGcd?=
 =?us-ascii?Q?iBLSRUPTkw2ZJ0uaet06oRPjMEYNf9jYiM/LH07rUTmIGPUqY9J9Ap4P73nL?=
 =?us-ascii?Q?SmzXw0vwwvBvLiwuYGrJQNCrGItJ07BDqX/3Oi4zHlw8HSk1RWM7QFkBc2pu?=
 =?us-ascii?Q?UGwdLCVvV8atvsXcl5bWfWYUY2JaaMzA5hnD4Y8rD23GnzOL8KoRyQ8NtubZ?=
 =?us-ascii?Q?pxJEzPKYaqtH31kTZcVJs/U0PqfFjngmLdnQX1zW7KPyPLQHVuQnwXcv2vyq?=
 =?us-ascii?Q?uW3KuicKlu5yujCSHjaqy+A99miFyuLV9lTaIhqCRfoTut+MMQxFH/9YPTja?=
 =?us-ascii?Q?ECV1G4yjsxOUpu99J5e2YFNs+zMyjo9hbwHTIkuF6jBBF4/dJiOScux9r/Mp?=
 =?us-ascii?Q?4eSffuUTeo1t/YwU8uxEdh3NnkJVUssQUBqYXpUzC1kcXvg9raxIsj3ksnb5?=
 =?us-ascii?Q?Wq0lE1vKKqa9hjmwiQWGFWteVhfuBVoEmP6rpsqJhUqA7wkcJVEdDXTDWu+M?=
 =?us-ascii?Q?47LJxhlnIwzmYTo1ReGwej1OlRy7WGoMifKptTFSm8tgVX6ABtbz4D8FgXYb?=
 =?us-ascii?Q?ckehn/nGfNYqKH/uI/NCeDV0R4rEtsnvkSFwwZFjlzqQJoCDMv8Wt5kCjfFn?=
 =?us-ascii?Q?vRhPwLzhb/oBODaDUW6RJNhvS6OVGAbqBzEWUgRX/8ZtWFiZv9SbnhZDRDfJ?=
 =?us-ascii?Q?J+Fo39fcLce72s+VXlTu1Xmoy/UCf6DVnMYf+dHgwumoc54q8UrGQEMKsJxl?=
 =?us-ascii?Q?j6661kj1mY4YqKK5rj1duC/0oiEsvYTByqopDRE0GDLqWOuXT4o+MyO9ezSj?=
 =?us-ascii?Q?k9EPTkDE+yvMecEPOHvieMGMKAgojYYKQLM7u3VMZp1iIJ9H7lpBevRXUQl0?=
 =?us-ascii?Q?8TCPf2VSsD7rDtV5NiykFCZT56TUEUA=3D?=
X-Exchange-RoutingPolicyChecked:
	WzViN4PbpLH29n3wWk2MdfzK/HbOMwPsovdbtW/Pk6y1lJ9p5wF/NbWqhc5JQPgH5lbdxFXePMQhdBFWkZNwekbDDoH6aACNdhrvbpfT4d++90DekwqN3VL0ZZhCf5fYrM5dUqOuulS2CgdvR+j+J27SxUSshqXWz69MqCGUz4cunlKECthW7ovFmighwdecDA4xxgUzZ9hm34grgp2xs8RdDvdGKNn+1BEDBf4VSFGsWyRXcAffy7ou4IXdcTrwmHu3d7chGZIsYWiEYucW++juErJLxclASFAzQhJnglIJVv263GSCZP7CSvTf8B8e/UwPkD21Mdx4TjYDXeHPfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yMtZaJ3zQmtkEaH9pyNZ4PK7igU1U1Ufnl4Mg0RN/1TOSIGJg38ZoEcW6TCjd8LQnCwZs5JP7gI2rqL2ogQqOe9dU4zUeHZdY7T9R/Nwwi2TclzF701kevC4rUHecFH37T91W3F052Wh97hcJ6e6M/SghWwnxsZZ45ZaKUTx7wPW3P3/hvwOuhjdx8L/PB4doe8BUTmGSaJb9tnvVBz1jy42sTPoeVzM+d1QahBKUNnwo9wm0eDmNBxRTRsoFH9msJn+G64wverAXT2DOpRoOlWEcxd9Gd1KJztYLZdpZYyJfjSZ4mUT1nNVE/rBbJsD8PjZI0BAP0fNtcJl3w/y7oEgExTV+pDG4/9/D8Zc5QcRjyS/p2b6HWNqNlqGQ3JZOie5U0UNi/LqArS5IGVAf9NBzM57EUbXieZx5MajK5G3M55BI7xusiezqK0hr/KmZhlL9+uky/FESXs+yLGvKwtJk81bzFB2WgDYqmfZXgQ3P/gVusy2bxmcGh79X29y0ip4zFqhr78COxvGYQbXXsUYOt9Zgu4LFTstZgM8v/iQF8RVOsHKjwh063t+TyCtgRGWcDLw4yXBttOSsMTMxE5vmfdbjqapaovNWXbGiJlER4JFXvTZLI8HgT28zttX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bcd54f-e605-4e72-dbeb-08debb0144e1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:32:05.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW6Prl89YjfsuUj945guccFeuerazZ0c/CJp8xpXDmJSuLA+6w4K3iplwydpQca01IWUxuATVVA2Q4ZUl41oMISPdlNWbkyEApzN9KvxmTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7515
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16296-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 74CD55D27B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 22, 2026 / 17:15, Tao Cui wrote:
> tg_flush_bios() schedules pending_timer on the child tg's own
> service_queue, which causes throtl_pending_timer_fn() to dispatch from
> the child's pending_tree.  For leaf cgroups this tree is empty, so the
> timer fires and exits without dispatching the throttled bio.
> 
> The throttled bio sits in the parent's pending_tree with disptime set
> to jiffies (THROTL_TG_CANCELING zeroes all dispatch times), but the
> parent's timer is never explicitly rescheduled.  The bio only gets
> dispatched when the parent timer eventually fires at its previously
> scheduled expiry.
> 
> Fix by calling throtl_schedule_next_dispatch(sq->parent_sq, true)
> instead, matching what tg_set_limit() already does.  This forces the
> parent's dispatch cycle to run immediately and flush all canceling
> bios without waiting for a stale timer.
> 
> For the device deletion path (blk_throtl_cancel_bios), directly
> complete throttled bios with EIO via bio_io_error() instead of
> dispatching them through the timer -> work -> submission chain.
> This avoids a race with the SCSI state machine where bios can reach
> the SCSI layer while the device is in SDEV_CANCEL state, causing
> ENODEV instead of the expected EIO.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I reported that v1 patch fails with the blktests test case throtl/004,
but I did not report the problem that this patch addresses. Then I don't
think this Reported-by tag is valid. Please drop it.

I confirmed that the recent blktess CI test run with this v2 patch did not
fail at throtl/004. Thanks to your action for the failure.


