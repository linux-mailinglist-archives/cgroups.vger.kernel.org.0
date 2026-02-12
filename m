Return-Path: <cgroups+bounces-13890-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD7eLsSTjWl54QAAu9opvQ
	(envelope-from <cgroups+bounces-13890-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:48:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00812B85D
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 09:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92AF33020A7D
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601C2DB792;
	Thu, 12 Feb 2026 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o+2L1E6j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="naoJKFnz"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1162221D9E;
	Thu, 12 Feb 2026 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770886078; cv=fail; b=J3Y9sNRi4/chMmUow7sTGaOaZds2rbFCuMPaivkruOOW1hPqj7ckJdVWSlvOcDN9OIWwNo1vwIHJQimFcUQM2abigV5I6sTfCyvHUPlcHE1dTNQhna5P0iiUBGIWfx9YAJdKW52mMrvUaIGbqcmLVKK39ovt/qlJDv6emJ7B2bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770886078; c=relaxed/simple;
	bh=juGgbQfjFbXw/F9z8Jzz7FlL/HLp0PrFcHT3x+9lMVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pfaVXohwoea1fNP/HqFEaBlGcutMCKes30St6fFCS9raBFO3FOwQ+gQk+r2CWiiMfMdcOkJEaXhpNKmLL/aAS0rfxeCvtmDu8JIpopfBE5jR1/aGWgsVGvSIj7y5Kh6DQkkEKHirxDLYzZDK8r8rMPt2lacKIRaGmkgk25ZMPXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o+2L1E6j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=naoJKFnz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61C2DKo8592955;
	Thu, 12 Feb 2026 08:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+H3yUkYYPuJBgtJEXf
	AzS6DPP0LsV5xELvsiJ6fHBeU=; b=o+2L1E6jR2m4XpgQJY+oNWQbjiZ6ggSIFi
	1PCH1nzT8tBfr32M858+iZe2vpsRnqozNRmb3QooUgfmZonsvVhgRTmJkaNKL6Pl
	9er8bU0rCMT9gDCQ0B0HyGQtMBlcC7Ww0iE0PaadC2j9/um7pQD+0yy5o/zTSR5I
	LVIxhSQYNmJGsZKZUwSLOea59UdNNsPIOIVNhSANcIsHVCPzVRM0jMlPLn+RKTE9
	M/V9lhNBHIOznCBPyTOKP1jT8MhOu0t0MIVgp98o4nxXoPrDT3gKtFK8pLjAvuCV
	UJtP8//DZx9gHoaaBs32E49Nv1FLk25gNxKobvRyveh/3Z4xWZ0Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88df33wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 08:47:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61C7Ramc008291;
	Thu, 12 Feb 2026 08:47:07 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8236w98k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Feb 2026 08:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuytLtW/W+WbzHW94jnWduyLVTv5g6Q3MMPPmHSFJ5K1xiN5MbPI+WZJAIXyCwiD88kUZOxJ94eKb0U9vh/z5mU6NB1jJP1ht+3iiZZi+3uyAMCUs9TXQdPpWF/59Wf7xJiYgXiUPcdF/ukqEEdLDx/E9sHZ7jkuH1CqXOgBTm9z1Cit6bCx5HRdH3pOpJC9K4CbLkE66dvF3S4l9vMV4lN47BH8FIH4WDxITCtQCueq2I2bRjLLZGwl/ym8aaBgU9RF5FjLoSNQTfuhC9n9p19QsS6bTS82XQJW9MjxHLV4JEROC4LVyz4bJQ/giZI6KUGN92HOrfa1/MeQRNhbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H3yUkYYPuJBgtJEXfAzS6DPP0LsV5xELvsiJ6fHBeU=;
 b=xgTzFnedXZ+kS7tPbNB6ddQk9Um0wM8mWGk4X/7EMNwbslfM8sr0bRKzP27HzWeKpRTBpTIQUJyX8EdUwaU1rC8Q0RZCxDPv5e9ncMd5SzQ7cahX5VgvYm99p2AO64xodpGCtaEgjMWC6ZwEsCW50U0NP4rDMTAf9gt7ijkid+eS/acIEwBFOjD1VBIHOdwyi2E4GSKap70JVIPJuNvWCL9x5+KEZS7ZgSiGH/7Y9Q7iOF6Q79rqBbcubDFGzdJxRgXhVN+Daoh+XPLmBTu1aFqtKYcEbWljkQ5QqS9bFkokvInOeUBmK5dAreyMDhM6136PW7FuRGAa3IZ1ar/miQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H3yUkYYPuJBgtJEXfAzS6DPP0LsV5xELvsiJ6fHBeU=;
 b=naoJKFnzBexLzwB33u8dykt4cUmPmOZw/IOHMVYhPs73U9Eh7iI7dpELI7/MufaZ8HSmX6YRXoO6y9/SUcE1KBXc2mi3qZSAPCIAWE1mkC+h8mAygc8d18rw7w3feRpbhyycpMm38/En78J4sb4PNYG5o/0CbEjKFlotpLvgBdQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5575.namprd10.prod.outlook.com (2603:10b6:806:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 08:47:03 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:47:03 +0000
Date: Thu, 12 Feb 2026 17:46:50 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, bhe@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 26/31] mm: vmscan: prepare for reparenting MGLRU folios
Message-ID: <aY2Tem0Fn6dIknXP@hyeyoo>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
 <2cea0e0cf208e46dc55f2baef8162bedba2db47e.1770279888.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cea0e0cf208e46dc55f2baef8162bedba2db47e.1770279888.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0105.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd59eb3-c456-4355-495c-08de6a134ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6LccrNM2uROY/G5zbcXZa9splxZwebTTCAfOkSfZI0Qbsb+X0+x5On/4inCG?=
 =?us-ascii?Q?OrCancCh48G+oxcqqhWWM+ekV/QUTQGQC4xnBHSoRr/0aUVYogbK2WfsePJa?=
 =?us-ascii?Q?AWg0rl+TxoQVXXnpMtg4JOC9idn6J06C9V5Kv9KYzsYQxp7+lNUwn1Is+ltn?=
 =?us-ascii?Q?rSJ+ed4OG9BhK3T8R2LlCgkvmeheZQ1b8DSCljEnh2qeAsaX/3qPpxd+LP9q?=
 =?us-ascii?Q?wPvEBsN6cUmHUpAC9WpdpxfliRo6eX5ubpi0raUw1/k5CZ7Y9+LaJGKkuhq6?=
 =?us-ascii?Q?DcMcVUfiahpsZlKt6591ziHXsXMG6CLvIkFXSIjKxeNnEhFbCwxIN9VKdrvK?=
 =?us-ascii?Q?VJPMI6DMncxROKG3UIpmP+trcQs11uy9IZQLv2TW/bawMhgqLxxcaMw9OrbJ?=
 =?us-ascii?Q?Jmxh0rJCqP0oslV0FJy7H6XLsMkFoZG13CrSvxFYAmps374tU0iudDxXMuUx?=
 =?us-ascii?Q?AkKo8yJYhoCJjX9YQp2QcD6lPguAqdOSaCIsk1q8Um/YUsjBwklv2I66R20T?=
 =?us-ascii?Q?u9TbzFF/fyIGPOYTS9CQAT0Jl7Djg/8RKU9HTXWlo0s+pE6429B+3T8qdIN9?=
 =?us-ascii?Q?PnUADLkPvdoslY+Jhozpl/1Wz8T+R0PfgqvUwF3QC5R7DW3hKfvz8z6uQoMi?=
 =?us-ascii?Q?UlojKHa1PpR3JF3xpcqbhH8H/I4WbAzmj/ERsiZ029WPuNgZhf5SG0lHjbO3?=
 =?us-ascii?Q?IuJQB8Cr/FCGtIXvyjMSE85WeRvj7LVimwugw0/meGYMM9Yg3MxQPqRbKjLd?=
 =?us-ascii?Q?07aDkUPjA5ipCEPghxVIrb3vn+D7UTdv5u2+3kvW8snGb4h8OTk1kkm/rzUA?=
 =?us-ascii?Q?8IXq1cqufIJ1rkQwDXSH/xZhkWrU7P/LvVQ4FwlOTj0F6nvWjv2x9fvbp8tr?=
 =?us-ascii?Q?+DHvfsHrs/DsgaDPPXy6gtaZ+NpYWn16/ri22U9/mUoG7TH/HAQSfH27Kjh8?=
 =?us-ascii?Q?gRT+yAP/usewXim8xSQdFDXOo8bBEXFPInEDVHUzD3tvDD7uZ4ybud7VqHIt?=
 =?us-ascii?Q?CRWsTaU4S7Pu4iMbZlFhN5Rkq5sJshL2iEs84ob5SCHt2QTl0HzOxytE+RLU?=
 =?us-ascii?Q?dmVyerRlbkMd7y5BOjo/40Ql06WYiLPRgy3s5HiebatK5Lkp4xHIuSTfjCBE?=
 =?us-ascii?Q?f/eoHAKu4ANzWnFutgJQ7es8/h3eAvyiAZrtUh4c9unc3u4WP14brKwB+PCA?=
 =?us-ascii?Q?rp50WmpuUY7BxejPuOWctX2XekV+88zmAraFwrxCtC38NsaOKboZfA+rPOEB?=
 =?us-ascii?Q?CGFUlEhiW/GzNaRspKckE7nCgwxYbns23egHgBxMsjxSpGIxZhP0+1rlAHWq?=
 =?us-ascii?Q?jPyy4riwQhWDSfhZnMiZfNsdYzz2eQ5ZGCBMbObPp792zSGBTnpKBRAPptHy?=
 =?us-ascii?Q?gVx3lLzXri3AZI8uJXjoAueS6QnMIQ56ypzBsEIyxi9vZDJpAMB2Q4QRb+t+?=
 =?us-ascii?Q?OcRjsblt+iGX9iQjvGsTxPzyNOMoYQtxOln6J7u8Tn4PpwT9/0jSQdbIl1dM?=
 =?us-ascii?Q?tzpQheYWxkX4tvKINGduwLyhjjvi5m7BeqWj1tFFv7ELNX1S0FepN+sncn2g?=
 =?us-ascii?Q?K4zlfSIbIWcFFMqDz74=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Meg0c9fWbQ+OeS0w8UmksSgi2zOh3F1es+Sesk97r9KiQfAmKXt7zFOjUMXG?=
 =?us-ascii?Q?EQqR/8OdFrv5v2jHAkSvDk3yxdf5a1XwGsu5iwPeNZdusjSPjqyy/Q05803A?=
 =?us-ascii?Q?6AvdIvPeV7Vjleq0JOYv2kEmCwcZgnznsLQhlAb/Au0Y1zsyoeZvxVlBGO6Z?=
 =?us-ascii?Q?rDKyLYorAU/3ZxiJb/FsqlG7tkmN4qY+hUDHUA9mLIV2/ayn60WxYNhVD67F?=
 =?us-ascii?Q?qYgyNjPWtoEX64Ts3NAZoACCb/YUw9+MRf0D2SWzZJ0x1sUEKUDJXgLg4zXJ?=
 =?us-ascii?Q?GN6Pgx3LDsL3XlKYV6X7M4pppNd1lnvMtjx+83tayYvKfBl2h9ISYb4MkuPy?=
 =?us-ascii?Q?jKVf4AiealbnQVyGOSU1SXEJU1/GrBQWVCnsibLT2gQkjA2YG+Ci2pHiT13z?=
 =?us-ascii?Q?4f1HFaLmiQlQAIMsdNboS3LnK3yk3txeGf86DWSM4YGKOiLqXLF3rMaX3vwy?=
 =?us-ascii?Q?tZUoOoWgLjUIwPDP3z7ou9texRKOL+D6Y7trM4j3VVNVge00kh2n0Usk6HKU?=
 =?us-ascii?Q?wOj0SlJHFJMB6V5BVOd9CyGiKCioZ7cE14XCegt2NH+e/TTrwItjwbtOu0Ig?=
 =?us-ascii?Q?SVcLrxZ5ZODz5NkbTPfM8/tp7o8fD5JHf6dIvFL6Sal7Qbb12CxIzFGa6XdP?=
 =?us-ascii?Q?+fvBhS6qUQsdps0Yppen/Yo/KYP+ZYY0/GZJIT91gC5Uv5RPYZHGUhR9Ii4a?=
 =?us-ascii?Q?AE2YV9MGRfkwQf+VQe6BAymWEzakpTMjdAvjqXEMfoHxWwFuCtq2erkvNvM1?=
 =?us-ascii?Q?BX3yqlVYgSr/slhs78Wlc5PemOsFkobb/z43N813VqvMxvg6fNvlz7OhWVbM?=
 =?us-ascii?Q?RyYESAzDa76n4A7x4WmWXHux6J8JamFXCRoTjMAoPPRceT6jY8aylcGABXJ0?=
 =?us-ascii?Q?yysRX752gVRHz3lCDYgRL1xi8zFHfaDYvgJme+6zd5x2jXAHTROtkb5UjzPE?=
 =?us-ascii?Q?sueghiqnCvy5+ObJf7/B3kBx9xt5Tbi19ER0tAmrxl73C6ESVvUa1rdFaUqD?=
 =?us-ascii?Q?44FarzXwmAahVB4HOTt2XdMRYWKbiksBXXMOtGRAOZSL+dDHXzPNKcnvdS7O?=
 =?us-ascii?Q?Jn1aMWlqFcZj6Vk4D2ve+MK8EFMRPdwKGAu6NiP81gvrSBHOCrt7Kbh1HJRB?=
 =?us-ascii?Q?q64S7hp5ok5KwPad0dZLrKihyoz44T0GusQwX/cvKTzq9vxcsdiX9y0e4LKz?=
 =?us-ascii?Q?hQmF1re3447kIYy6sJT+PdzzHTmL6wAbUsx0nK8xBopN6jYhOW9FOdw8A5bV?=
 =?us-ascii?Q?DOc3hcJZnUx0pjegY2Dj+SAxO7yspmZE3RiG43VEbL/tSPzXbNfW/mgcZLm3?=
 =?us-ascii?Q?HHXwWj+Nhz9wqz+fg8QxDAnrviyxpDNDfvP4AsjQIK+o5opfZCTeSPCuVzar?=
 =?us-ascii?Q?9NzvIljfAI3lUeSeMOBgu24FYTFU5Sl+2XNnZxwXOaNlNI3hIl+EQl7sNCPB?=
 =?us-ascii?Q?g8PX6E4z7bAi25vcStTSFYyNU/lJEJNlcDP817fRdLUcRrhhmcDaBk6GT++W?=
 =?us-ascii?Q?ilYWpuuTPOjFNdHcN9G3U0BuWYwKC6cja3majOyc6YaMMD34ZkVU6qeKxhbU?=
 =?us-ascii?Q?itgko8Go0RlOysPcg45yblC07Scw9kAJXoOolewLPKwgU/fyvh2G1K289CFG?=
 =?us-ascii?Q?q8orW6UB1iWqQzF+J+JmDA+nxddYuUSZBBdn8hVEqqIZgfaaYOBb79TcZRgf?=
 =?us-ascii?Q?53BvpwI/o2uagMc4fMdi3MDUhQZMqI2Bl1wt19pulTrxAzqx1/23d8G8tkWR?=
 =?us-ascii?Q?GR/jdiwbeQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kvu4Wz/pOFQmnRTL5ASHeR7x1NME2veFOK8C+sl8Nm86O/rWkrPOu4CLpO/7kjQZJmBvjeM4LYi0vLOTsEpdVuzypHsLuRLd+Uuhuxg2EWk9xhEkU0UrC1LRF6ch295jQFpKj3zg3SmxK7yzfV1qnfT49/2vLeEn1OZEWb3OvDLieGrequRrTDbVP55D41Qq8A4dTkRlpxrBSMxQBjPrTtQ8AJuyJOfwqa0riNqKoB14rl4QZnsY/X5u0ilrpG9ZXfPWuKKAyj/VegQddngaily6W4eEZshP6Rr7Uw2DePeahVl5JOwDaLsWza4bjLXcdZHwBHdY673fDkm+k4fJL/ZkOY2xjQq4TmiThFznzGjzJFZVLEkHpOHGBk65oVIFBaBfngi2co3KjKfZe/i/66TaMvVUGOKz34KTxQHxostZrD+nBU6ILBbu2OcmyrjdfiouVkjSBVo7Qh8AZV5divwth+U2XFG0CDzhlCnHLte9E0lCPimk2QMoQ6Zimh9vog76bE71X4aqEsSRG5QBbW4EXLtFpjAZ0KU/hmEqnRqfnCcRpFwVZAVtZ2kvdE7VS0GxVab1P6MfhvhxdT/xIZTKMgtG1DncuGGSG87d8Do=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd59eb3-c456-4355-495c-08de6a134ae8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 08:47:03.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx1o/srGv/5nJVVMl4wcZlGOQ7kyoYZJXOCXqcVOLNYB/IFWGzkRG8Q0nI3Ff8CIO/NvzhN9YIotRohikS5sYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602120063
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA2NCBTYWx0ZWRfX6y2zjr2iPlrM
 XNDg4hwxMR2sxoMEI9GpV1XnB/vHKclTLE0GNSz8xMrc1Ct3yZ13ginJxfOQVZ75l84evJjF4a/
 hMcG/hds4N0ZwG5oxKS2y4cuuTNShHCxrq9amevQ/0UY1G4BfV0I9cu0pBkad7qyRUWZBmbuly/
 xjm30y49fcnesVpDiFMyp7DjcpULR+yCXgajdwK8Vx/ZE5mT/T3YYNS9XaIhGHOmEWTj5luownb
 TtU8+r3Sk+fdD2f9y+SyLh3nQuN1Vsb0m4UuWzA/dkOBipQWoefr+8aZ9f/5Agkf3P5IRMUtZXz
 3vf2FOmj408BWd4yfn/LxWOi/d1SUTNFLpxX1U9oFP0GJxfX4IBl3rlakCtBXY5LU+eDqoxkW6w
 C6gtPF6uI5By9SZZXFVGz96Q7DrcYExdYkoxMP4oifY91QoNhO0fe9zz832Dg6ytAMrIKwKiMZL
 ycpl3z6TWqREr+H0u7A==
X-Proofpoint-GUID: dQVVZHW3L_Fznl_as1JRulSt54Pwk4Lz
X-Authority-Analysis: v=2.4 cv=AqbjHe9P c=1 sm=1 tr=0 ts=698d938c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=968KyxNXAAAA:8
 a=yPCof4ZbAAAA:8 a=x5uecv13Lt2QD8M7IZYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: dQVVZHW3L_Fznl_as1JRulSt54Pwk4Lz
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13890-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,bytedance.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1A00812B85D
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 05:01:45PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Similar to traditional LRU folios, in order to solve the dying memcg
> problem, we also need to reparenting MGLRU folios to the parent memcg when
> memcg offline.
> 
> However, there are the following challenges:
> 
> 1. Each lruvec has between MIN_NR_GENS and MAX_NR_GENS generations, the
>    number of generations of the parent and child memcg may be different,
>    so we cannot simply transfer MGLRU folios in the child memcg to the
>    parent memcg as we did for traditional LRU folios.
> 2. The generation information is stored in folio->flags, but we cannot
>    traverse these folios while holding the lru lock, otherwise it may
>    cause softlockup.
> 3. In walk_update_folio(), the gen of folio and corresponding lru size
>    may be updated, but the folio is not immediately moved to the
>    corresponding lru list. Therefore, there may be folios of different
>    generations on an LRU list.
> 4. In lru_gen_del_folio(), the generation to which the folio belongs is
>    found based on the generation information in folio->flags, and the
>    corresponding LRU size will be updated. Therefore, we need to update
>    the lru size correctly during reparenting, otherwise the lru size may
>    be updated incorrectly in lru_gen_del_folio().
> 
> Finally, this patch chose a compromise method, which is to splice the lru
> list in the child memcg to the lru list of the same generation in the
> parent memcg during reparenting. And in order to ensure that the parent
> memcg has the same generation, we need to increase the generations in the
> parent memcg to the MAX_NR_GENS before reparenting.
> 
> Of course, the same generation has different meanings in the parent and
> child memcg, this will cause confusion in the hot and cold information of
> folios. But other than that, this method is simple enough, the lru size
> is correct, and there is no need to consider some concurrency issues (such
> as lru_gen_del_folio()).
> 
> To prepare for the above work, this commit implements the specific
> functions, which will be used during reparenting.
> 
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Suggested-by: Imran Khan <imran.f.khan@oracle.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/mmzone.h |  16 +++++
>  mm/vmscan.c            | 154 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 170 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 3e51190a55e4c..0c18b17f0fe2e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e2d9ef9a5dedc..8c6f8f0df24b1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> +void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		struct lruvec *child_lruvec, *parent_lruvec;
> +		int type, zid;
> +		struct zone *zone;
> +		enum lru_list lru;
> +
> +		child_lruvec = get_lruvec(memcg, nid);
> +		parent_lruvec = get_lruvec(parent, nid);
> +
> +		for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1)
> +			for (type = 0; type < ANON_AND_FILE; type++)
> +				__lru_gen_reparent_memcg(child_lruvec, parent_lruvec, zid, type);
> +
> +		for_each_lru(lru) {
> +			for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
> +				unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
> +
> +				mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);

This part looks fine, but I think the nr_pages parameter
in mem_cgroup_update_lru_size() should be long instead of int.
Could you please update the type as well?

Otherwise looks good to me,
Acked-by: Harry Yoo <harry.yoo@oracle.com>

> +			}
> +		}
> +	}
> +}
> +
>  #endif /* CONFIG_MEMCG */

-- 
Cheers,
Harry / Hyeonggon

