Return-Path: <cgroups+bounces-12916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E177CF251E
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1B7830C59F6
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CD82DE702;
	Mon,  5 Jan 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ng3IOlcT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IhAOLN64"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91E20DD75;
	Mon,  5 Jan 2026 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600226; cv=fail; b=IvrBpouK12YTNqEtEXJnYmg8Hy2FDseIoE6TZ23xw6EM83eAKKivfSGH6gs4UxBteDCCkucjGh/sjb6ig6b93v7kl9Np5V8tIn/4d/Go2S5C3IM1pWY8W2XeLUCXoAm34uzL2X2Y9yZSXN67nYXUAod81WLpWexalbEFVvThVDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600226; c=relaxed/simple;
	bh=LlWUwy6VHw0xZilkI4/XLt7SY6jSX5eoVPqx+sqBwe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYu86PXfOtCAXk14LW6Nby3+kN1hlmRZeAPjAg5bIjN23ImTDxSu+csyYbBeH0XgWD/91ezrUfVErTaQLxYxhgpbHDlLRnN2/FFAeULOlNGSxtqJBT9WFW3E5lF4Vy5v6CtHg420gS2+PAC7mYVtndej8kD0aFWp7M7q8hnSJPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ng3IOlcT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IhAOLN64; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6050QSB7743125;
	Mon, 5 Jan 2026 08:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LutcvEd58bIa+FBZh8bC07A6Xg+DVVD42vxRy1H9Qzo=; b=
	ng3IOlcTo2CTtiBU6i84dT9K3JAJZoicGEjiqMfOkwh3lXAMj5CJEXMzesaQhQtf
	K9nNL4azpNVWQQvE6h1ReG6LJe5xyIHXY3Yvp9euEebuEsytChDKYKmlRKy/23Bz
	g/8yeFwqJnG3q4lYjQgXJ+2QCc1HvuHaWY89dJ97i7OkInmxiOpq1Lqw3dgdxZcq
	eQv7Z8BIaJlCpjP79cQ9BSkNze/rc7LubkKNFNHBzDW2F1m01hH+7MziducaZSRa
	uj1+cbeQJKqZatDpl5P6SRDF86vbGlAY4eGLVntBjJ+2G1Bw/hlbNQTQjQVWw5Yu
	ySYDMG2Eo2rL+1zEHqyK6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev2jhcbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:02:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60573VIe026358;
	Mon, 5 Jan 2026 08:02:46 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhc07u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0Du2ur2lsBBIeBMuG7lPOKRgA1U9k7gtVsSvfZZvYDGCvwpsIyAIFrH1Sr00ISjjeTYFgEdQenHdwH40E0pmD5CVIg/cDyNcKrVkKkh7h0yvbWp6Whf5gjixi5aTYRq4eazM4j+x96YQcw1XpSpIzMHtf3A90Gd4UbEyB8fSK0TTQPiEmWdjYiACV/qlTL3OeLv51FQHlAPrrzGlqfsfOLvjm9BfpNFafOgBILqMOnM51ydLgwABTSo3c9iUOu8x5TzoOXwc/Hv4v2f+r1DqNFn89ke5i+YmYkqtbj4WOXDiXVAztOYU9Hu6zGWUdvW2q7eSjYsu0d4hT11JS3dqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LutcvEd58bIa+FBZh8bC07A6Xg+DVVD42vxRy1H9Qzo=;
 b=dKVvDx2reDEK4gytrQ+Vmrur7K9yBEjaxSmoAIeXzLiwZQVPi7qbJSFYHUJokrbiggnMEoCsEw7ARxTTirhvZM2VoCMgwJDC1BwemwNzuGjF4ZYDZDXoEUy/esOg/IwUmk3+77EPcpp++s/WYzskBQLZXxtRPJ2DI3IOk2Aj+G8ljWi/Za9BdotrNWYGfmY/a86j2fCAfTJ7WLXbySmoGwci6zPXIOkVJlrOznvdYEPgffb67qr1R/raxfpQGgVkNug1qnBDWBRozcoGPFqCWrC/Rt5ZVq/6mKXUiqBZtOA3vgBOO0ZNA3Q1CIfOfBCNMX/7XbBVHOXtvNEmofbZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LutcvEd58bIa+FBZh8bC07A6Xg+DVVD42vxRy1H9Qzo=;
 b=IhAOLN64b/8x0LDkDomaKaDsm/D2fw+cPzuoRN8aX/oLgqVuJi6LWF5ClgbZDz6twnkDdPrQJF4smeD4qgkmx54oH9/D9A+WD8BbGm7sJcBVU0KiNithBJnGTymZ3+lki83IAOw2PjlkzJUu0jyT7AYy1Yg3p4ZHnsrhJlV0Jl4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:44 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:44 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev, stable@vger.kernel.org
Subject: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to ensure proper metadata align
Date: Mon,  5 Jan 2026 17:02:23 +0900
Message-ID: <20260105080230.13171-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0093.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f06cb1-cea2-4a79-786b-08de4c30ce50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STp4SkMf9h1CR56N53VTnXKYY7Rd5tcQ0D46X3sk5GZk6RHVNCBKhGkN7Qy/?=
 =?us-ascii?Q?F1HFRA8xqFItuaJ2FzvBqBlg86ETSfrS3TGSTNqJ16/xFpwrkXsnEbCdAnx6?=
 =?us-ascii?Q?5BgWJhSmFlL9J8K1P09DopfjTldqxU9tQPoY6u2h2nor/2BImDIb6wBf46+c?=
 =?us-ascii?Q?W+oVHmuLaPPepype4KH3w4O8Fvi3pkAROmGufoLZEVGsJhwNJrZQET4iPQxP?=
 =?us-ascii?Q?mI8GvqsNwfoxl+4INpru/grTUZ8Waf9p32L5sxfr+KHuqZ6st/UuCFN4/Izw?=
 =?us-ascii?Q?3DLwQLEKouxIVGPdr5hpG0jaScnn+q2zaBoKhrtUE0zUYaoS80EXexqNfPxy?=
 =?us-ascii?Q?V/9nS4Dnk85ZD3nVIMKoDqf9bsg3Yhl9kifjOqG2Yn3LnnJreg/5uDUpSTR2?=
 =?us-ascii?Q?Bhpkp2W3fn6A7ygdYnHNv/Zrlj4PODfwC0luI5eGigBn+wEfBmzw/AQGGfdt?=
 =?us-ascii?Q?MBKLKLvd0t7k0SClvDEl2ouz8TUgH9+qNdc9aE7Mk7XYUEHucuKNZtnCumoX?=
 =?us-ascii?Q?L/R3Khktcd5i65YgNzCK0Im7xqnkGi0GT6JWWxwZtYDUp58iz0aI3WwM2/se?=
 =?us-ascii?Q?4xFWWSpABm41om0Y/BwqRpNuIlZSXMZgXHo6xpSzLkoObYKJWGmDeyZwFJuf?=
 =?us-ascii?Q?rkUNGnYZUTVRWyOipsMZX/TiSVNGsWXtZPDv3K4UDPkzm9YVYyEE6VpwVeB+?=
 =?us-ascii?Q?i4IWDTNHLpCW/XhgLcvpZoTjsQWXvt/rW52XTrf1C7MgVwnHbT56d6X3Q2iA?=
 =?us-ascii?Q?1FG0pZ+FWTGBPD9y6a0K1LFecd396IEZIuTG/oegho6DObdUyzEFFQiUb84m?=
 =?us-ascii?Q?KA3re3dWpMBS0LSGvQ2UIuVEEWHq0GkwviIJ12tIXFTIuxY1EATpHh8dew5O?=
 =?us-ascii?Q?2fgYAjD5Ep6h9B6z4QKZTcSve6MYFlrPQKOO4cdGxUrTgR3BVGG6PmZM/1Sp?=
 =?us-ascii?Q?pClE/0DiItfVk7+liLkwhT0sjEp4WtYzCiglO9R1VW5RIekirtxtKUjfLAkm?=
 =?us-ascii?Q?zHOiQWehbhmOjpAQVQ3yLZsASrRmpLJX4YfMdR+2BgZAIfCv4LK1aP6m9TRd?=
 =?us-ascii?Q?1LS/B+g2XhaTn1mcjOrBtYI35wGP/UEavQzp4W87H2u96IHvvLoqhG/L/HbK?=
 =?us-ascii?Q?zR0FiI/puJ29oDYhb/0a23V2FoGHZCozNLhqoh/96hKefkETGO9Od6EbDaL1?=
 =?us-ascii?Q?YrOEyALvgBwrtmXdsbUHW1oexhLKABmoFJXXLsBg0xAxGXATt3GzgMXgnuz3?=
 =?us-ascii?Q?1shhSvWeCB2y+K4s6lX9tEBDB3ITMulnyaZVOvABwNY2B9sTlVwIf1yi6VOf?=
 =?us-ascii?Q?bhcK4VPzZPouAcULABzYWgvsy0/fXvrqLsxV95SvPTbJP2XiCuJGfS2dS0u+?=
 =?us-ascii?Q?l98CfgXDpJngQPtTGjAIYICUQs6BfDLBJejbyBGTJfXE0L6tuflNSAh/lKHU?=
 =?us-ascii?Q?9jfYKhIhXuV3DJrdN0WaHd/rV2it8Tny?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ZuKb1HK4c5PyjHs7TtOQr0U2fvmz1zNEDcNUh8+twJFqN+xyn4D7xuTncZf?=
 =?us-ascii?Q?0euLGF156lGDQadeblyxX+3jYLJL5koVa/V5/Bx6Dbaplpdk1lh3U6pKLocs?=
 =?us-ascii?Q?aEEYOTmdr1QMDtSPNX/RIs+BE27+4gTDPLFmsdvyzznFoJ7DvAXoXZcE5lKx?=
 =?us-ascii?Q?L3GdeCwM7oz2Neh9aHuGhLul6aT0HPEHCmbXRbQ4e/hatox0vqmiknT8+v9w?=
 =?us-ascii?Q?mMqQUl2yNC+kJuLdqbYmS+E/ERXDKnl1KkVIRzjMzsxYkhT7J+1vrNk64Sdo?=
 =?us-ascii?Q?iBvOYpmMksIFSZlxeTiKmnmGhZlAozZbacZfY0WDrfeM4HQtTMsbeOZRzeEJ?=
 =?us-ascii?Q?ojO2tU/pFVIeB3/Q595F0eBxOT0QviH/bQN/MFL9t8jHRPC22cIi8nDJPEfe?=
 =?us-ascii?Q?cFJddpx5kbq6oDUvjtApIs8/XXwQahb/hhYJ86CXn8AebSuXX0KWaA2uu408?=
 =?us-ascii?Q?mC1WV6cRS2QbSMR2nf4J2E/zGdAwpkJnlU7OcdZ31pEQ1I2eAgB+qhTN57jJ?=
 =?us-ascii?Q?ncX+P65wiq4dz2+APD3kCnxm4eagEc46oevO3+ZIVvJIIOOmaETC72qqf3X6?=
 =?us-ascii?Q?ViBYKVU+Wv+EyCFk0uvb97RD0jZk9UgzshF5f01a7u2cpD0wr8VIk/gvB84J?=
 =?us-ascii?Q?PRMCp3oNUsm61YCdSVY53aTVhcbvlBP/yIY6/GvvFaRyHZ4kihx7Q8OSaZyG?=
 =?us-ascii?Q?+eXujgX6OMjiFxFD4yQlZsU40OUJOY7XmXT/4vAYT25SmqN3Hs8hDRyezCq4?=
 =?us-ascii?Q?4U3xiwA86FzHCMHis4gfZdnHlPkHfdMPW20/jXLvmdUt3WiOCf6nanVuxfnV?=
 =?us-ascii?Q?x9VridjcWfgBHFLf3BxqKlMWw31ecqKuahBMbCmLf2IqClXPHkwqdcN7ep7i?=
 =?us-ascii?Q?yuVag+1+QVPDEc4I8t9mdr4zc+Eh+sFWjlq9pDCmNEOr0fCMtp8nyHEvb4bn?=
 =?us-ascii?Q?eTiJ7U4p2q7bazFGEXBorFyiWHwap+d3RzPyPzdgYkb+tDBj7lavtFaToAk0?=
 =?us-ascii?Q?v200F4SQmdB9TuRvOBjM4TlrAvYlrR6MqiMbaoynWwyovktv8PEBQUmhsqX9?=
 =?us-ascii?Q?T4LsDEkS+ko4R03Ms+eff32QscyPaqtBExgokxrkQIvnRsXaJVwkb2W++yDt?=
 =?us-ascii?Q?CgPHsIMOV6wobkXsURxVLgBj6+pJsD11Mjr86o+jEs1wGH8tareXynBAhTYU?=
 =?us-ascii?Q?jCXyhXVJ2F9Mt02beb/0GiHfTconB/3u+nBed4I+n3S21r2fCuzrGBvqdS/a?=
 =?us-ascii?Q?BZQfbhoE7+qu3g5OY0abaPan9rrKpvF1IydlSmRYPFx0OdW4Bnub3TQdvoOY?=
 =?us-ascii?Q?PIuwlflqMcOLkWsIX34c/EnrfmOCPWkpcO6CVu+eG3L6/83IBWiW5WGS9E5K?=
 =?us-ascii?Q?u3AED7D1pQewbnURpuT8/d1n0h8ZfcThSd02vOUV9Rp5/q2lbzbFx4qhVU70?=
 =?us-ascii?Q?gm8Q+KfzQFJDfE/tpuxV6rab8tM8r7WQr/mp/ehWgnqxXRmHafgYfyRRF4KT?=
 =?us-ascii?Q?sLhw/fxT8KnTU8fN05vHzxRcd41OWykflC7oKQTt1Mk8+KxBlF/C+PDnzddH?=
 =?us-ascii?Q?SYqJVWDGpsOLLqBmdG+V01TU93Z0x3Ihp/LX0OLaMzJaAG26BX9NDcwUBHTC?=
 =?us-ascii?Q?26m9JONSA15C5953LOYIqoATE7KCZB3PVllPC/sSYv/D265VYeGQlthmDqrm?=
 =?us-ascii?Q?98q2kahiKU6Bc4oPlwJkMONgy2yG1KoE7kmCT20A1VSH+UYeryimd4WftZfl?=
 =?us-ascii?Q?g0pSql7hVQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FqsH8pwkulBuZcIxWssjWDJMd8xcNyNSXVnHuf13gBdLNjfv+Qemb5U8ICeKxjO7VCB79vHSiJncJQE3qoW2dZE1LC2Dn7ZBztNl+MRYlfnXwYmg4uu7ikN6glmSRqfib5rBJQSbjR4qJ7YFpVahpuA+Qo9a3YUihG+QA3K+JXFklZ39dUU21orQnfYB2dH7xq+JznfHUpCebiOZBgI1ZkzrqDgzRmejUGuzyr8ClAGW1I8AzmYbGOELsGZp1upYYDjXSsqHph5Xwu4LS2EhTVikGX+Gw8vCXqpWXUONW9sTDjg0u5zSkq5uoKhMmz5AVWx+4L/yeWHDQSKdYs39r39sdtb4SrLv+ECwEiGiINxmlXElH6CHQ6KtDIWww93hxOwEY45gZG2aatPExcsA9WNo2Ecu69+PAczCgrYRKQdSPNfP1YrhcC9WmjkV+l+FQ9yvbGSmWeZRjsNlIA5pHWsVMVbaQw3gd96n4jRXQ4/97FMXR2OuXn3tzW+bLvFXxpsuzBTlIDFyU9wLOP9Jf6JebJuK1fyOoxiLZHwYNmDzwdRWNwugkzRHgG7+aGZlo5hco1QAGxPvKEs/g2vC3LOtridBqY2AvhTWEVuwK2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f06cb1-cea2-4a79-786b-08de4c30ce50
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:43.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCjeTHrMRUAJcWJxXk/Sn3f4urHSkRyND4wbtaxDILrjPUhvPTKk5rViXrDYgSGLOwwlC0bzabilQhG+b1/seQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050071
X-Proofpoint-ORIG-GUID: I3Azak4qLZt7cIC1uopattwHEg7GfdBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfX0akq8MzC/VuS
 klXMaYrNN5R6v5jH3t/OtlFYfZrnp7beahhE2xUrGPU0v5WJyKqXqx3ZfNxRVs9TrqoYZ/hzH5T
 DeyDJnNKWrNaVEe4ziNIGo+OSP6S39IVm1zVKByD+qK+nzmudpYi9eLvHOXuFMTjG9iff7Y5Sqp
 eIHuBgcxjEkLyectFuPSeGakUc8C85cL3xFaHDl5NcAGsYRQYWHIgM0AKWRQmRDT1SbD6YPv4bW
 OH4PhEBld0ee9u4ZLYQnl7wy6R2fAGZcXhTJQ4hZP+XUvFZn5Xaq0GmQIlM8+KHauC0tiN4TzLq
 8JppLVdDnpUgaI1UVhOFKCZcchrSTHoH4twv/miRT5RMfdXLbyRVFWe/Z+BqqG7FXjZI+VG3hzK
 1uSN0FGT0IaK4CtKUoAfoCrbkfu/OvgsWA594+zqxO+URLTiq3IVKcy8tZhkRY5iozxVCwMmgcL
 jkBotii3gbb9ot5Ry3BLaSUOggQrsrguYr0iHfQI=
X-Authority-Analysis: v=2.4 cv=A9hh/qWG c=1 sm=1 tr=0 ts=695b7027 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=60bAUpEqyJ0hnt3RZ0MA:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: I3Azak4qLZt7cIC1uopattwHEg7GfdBN

When both KASAN and SLAB_STORE_USER are enabled, accesses to
struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
This occurs because orig_size is currently defined as unsigned int,
which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
placed after orig_size, it may end up at a 4-byte boundary rather than
the required 8-byte boundary on 64-bit systems.

Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
are assumed to require 64-bit accesses to be 64-bit aligned.
See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
"ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.

Change orig_size from unsigned int to unsigned long to ensure proper
alignment for any subsequent metadata. This should not waste additional
memory because kmalloc objects are already aligned to at least
ARCH_KMALLOC_MINALIGN.

Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ad71f01571f0..1c747435a6ab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -857,7 +857,7 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
  * request size in the meta data area, for better debug and sanity check.
  */
 static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
+				void *object, unsigned long orig_size)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -867,10 +867,10 @@ static inline void set_orig_size(struct kmem_cache *s,
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	*(unsigned int *)p = orig_size;
+	*(unsigned long *)p = orig_size;
 }
 
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 {
 	void *p = kasan_reset_tag(object);
 
@@ -883,7 +883,7 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-	return *(unsigned int *)p;
+	return *(unsigned long *)p;
 }
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1198,7 +1198,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 	if (slub_debug_orig_size(s))
-		off += sizeof(unsigned int);
+		off += sizeof(unsigned long);
 
 	off += kasan_metadata_size(s, false);
 
@@ -1394,7 +1394,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 		off += 2 * sizeof(struct track);
 
 		if (s->flags & SLAB_KMALLOC)
-			off += sizeof(unsigned int);
+			off += sizeof(unsigned long);
 	}
 
 	off += kasan_metadata_size(s, false);
@@ -7949,7 +7949,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 
 		/* Save the original kmalloc request size */
 		if (flags & SLAB_KMALLOC)
-			size += sizeof(unsigned int);
+			size += sizeof(unsigned long);
 	}
 #endif
 
-- 
2.43.0


