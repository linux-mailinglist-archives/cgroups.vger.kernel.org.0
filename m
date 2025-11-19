Return-Path: <cgroups+bounces-12084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64BC6DAED
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 10:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A08B92EB42
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554F33A01E;
	Wed, 19 Nov 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I6lCl4Bw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lmKtHDbD"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0B3254B7;
	Wed, 19 Nov 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543964; cv=fail; b=HYnOLh3lH1mHgtAvQZnAs8KZsR3565W/gZI8kpizKxP/ltaABHHGR56w2EYB6T7Gic0pIC+FkVB2AIm8rOe5ohHHw9oHafPs2CXZA1qNcBx1icnIZSaGBVXUxVInKNiClbCuCN6u5Kh37OfTIPVeUG11jGLszVy9SENXkVa2cAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543964; c=relaxed/simple;
	bh=03nGqoVWCf0Rv6Bm8ACOjIBM0WJ/psFoBF0mbuZxRMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VL1jEsn2FGD2ofWuHXhZtU0GnspPQc+7SEzrcnMB3ojAs7xS7y9x9bHn4fToxgPIBqw/kEmWQtz0VoD6Gk/OztDdz26kGHRtXokMWsFGIeCNnLdDIDiDDtR+zK/UdMRToOCSx12hm3nLXH2WlWqJHxQ+QIAOqbyAsK+KKzCf2Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I6lCl4Bw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lmKtHDbD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8vP9t001186;
	Wed, 19 Nov 2025 09:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZVSXJI0sNu/Hf5hW+m
	QYQ9Y2L3ZJvDlS623hSXqaa3c=; b=I6lCl4BwOxaQY14nIuRneQMzUq0Utb4hrQ
	OZ+u+QDKtAONTk7t64GVtto6C8SJy1YbliSUOxgVt5vl3am0cy8SXmQc0FRWYOsR
	V8hxU3T2aiC8JAAkm+tgL4sfn2kwORyRwNK6zGJAg4QBL9PDwEzlc7tC2Slssq5f
	GWE/JMU1MHLLC3g2K5N1O2mWJd4LWB3ofLish7TXj1bsmS/+sJZHRRmMAneygCt5
	hajQy4A6VjDIDEXoJM3c+EKCP5Okz9lQzTY3/B7+JRSEVBkbknY4HMH/oxkQp2KA
	WduDRD9vpyI3iR9qYrApnZaSxcmxxePWVDsK1pgfk2/m659d3szQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j6p90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:18:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8G5JH004268;
	Wed, 19 Nov 2025 09:18:46 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefya30tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV1ZRV9aJPaMdMBXnOFqB4PTCKV9XtEav0+cVH6QqGuWLf3ofsGdPRcuYfcnTffVGQRdMxAPYxSgQlMqJKkeT0aJuc2nb9LkAWMVq9rkXrw4f8gLdQf6gWTrq7GFivVAyXydK4cljiRgf/+YBClU3iuQWM3AOYTMfmBqfrWQcqhuVOYIk9lBeojAfBfTuNczBN5IW8PZKi2/dUZ5QijGtqrL3oABZHriD8xRJmfuLZib/Ugn6QVBJGlcquqNIaSnqCG7rBHaxBHkzYD+xbrAJyz+UZCjwDgUozqcYQnqv8ghTKUEnYk/cXTNaa3qlJpKClNlr7JzqX3Gxxl9qG3zEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVSXJI0sNu/Hf5hW+mQYQ9Y2L3ZJvDlS623hSXqaa3c=;
 b=N43HQWkJ+UOUeeA+aZ3NpxJYOKfQOv/FX6r3wuCgfaq6J0iiJsOK4BG0Odqv48q9qgqWHJS41sEo1WF4tg0PEsVl6zsvc2Jy6aWpRmvdF6gv9iLPZNjWKkK/uBfd80F8hiCFApU3IfIOxO0JoIk8ZreWQs3u6AP49wLyyXxx/XqTtKAN1h2y5ql/07mH2IFxnvgzY77foygImxiakIn609IiwIDEQ8yhO4l61LbCFsrsjaKYLwWcK+tHVCsbNWPNTJZ+qVJst6vGUxGOhftanncFS07PHo/Vjw5QgzoLgO5BOwWZYMVPEUhJ6Yn3hncnu1J1DLmtcaySKJ8wAN4A9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVSXJI0sNu/Hf5hW+mQYQ9Y2L3ZJvDlS623hSXqaa3c=;
 b=lmKtHDbDaNZb/tdx/zCBwgzMBz9unrr3Dz97gGKVr3pbB983q25x0DgH+Ogr0kYf6HDIy/mgVNi5jN1kHgcFM4LGYi1WezEu4LZmZzysyLYmDj6dcQ6h/ZUGiGHeLTgQTTT9WMq7BLDV+dOpJK01zt7WYqrt3aGyVuu6ujhnBHU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:18:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 09:18:39 +0000
Date: Wed, 19 Nov 2025 18:18:27 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 09/26] writeback: prevent memory cgroup release in
 writeback module
Message-ID: <aR2LY9V8EsCAKfR7@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <c1d571a61dcd8591da86e5dc036175f076cfbf1d.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d571a61dcd8591da86e5dc036175f076cfbf1d.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0083.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: d576b3f2-540d-4d07-5f7e-08de274ca00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5wzAY8tQ/t3h33kxe/gtjSSXpTQzgu3RlHy+DidrEbWbi1oQ+BEj17esqHW?=
 =?us-ascii?Q?4BOA4f1yQ0KB3BjpVYpLkSNSanbOEFyXtsqmRNlkm0UgttmYs15svoQwyFDF?=
 =?us-ascii?Q?AeJus3ygKZnXYj+kp6m3ILY7t1TWSRruG7A2zZxMbbx9LmtCvCyMntUr/tCh?=
 =?us-ascii?Q?1dknhjy6MZiUjM58OYzF/u6414C2+hrCoYOTI63cYBBO/9aNsH4i8/+iVBFT?=
 =?us-ascii?Q?Wl1ux21tQn0XL0COBMzW3VPPCkMovNzsYvcsg1XJWnwgSm8Po+cy5EG5GkmJ?=
 =?us-ascii?Q?LMejhpYnp+pFdhFxAB0Rmev4tIWIJLBymjh9qZnVwi31ONAmj5iV4aDYwCI1?=
 =?us-ascii?Q?ERXcHd/buQH1BwXtmSOAc5fQiO2NPLnQDmx0x78z93HbFVgqZ8wvp0CdkAJU?=
 =?us-ascii?Q?GZK+Ijcg6xmcQYO/4+mu03SPM2nrXJfn+TqpgMibtBTxlG2ea+9AgIzKUo5f?=
 =?us-ascii?Q?BhWB8JRVQYkjLnDOVEJMkDbWteBcaNCm0U4EOgo0E5+A2qOuvrVBbeAIygQp?=
 =?us-ascii?Q?hBw/2SE2YCptq/mkAJofiJ9jA+xhZRIzyV2u8VMzf5ZBc4hMnT1LHjKDvWol?=
 =?us-ascii?Q?2QeSTw/xSEUKChciMkv5Hy7IPIrVuV4P9h3tfOFOpoLmyP2sJmT/+Zufcbxl?=
 =?us-ascii?Q?cwB6Ox0zi0KPPDYjot80FqODmAkhHAJU/LHONO7Td1lpaBbaRAcovE+YYosi?=
 =?us-ascii?Q?9WLaUrkHmiG7PX9KTf0Qacd2Q+cVN4QdNQaCWkos7N0Ohsbt7Y8v/N/EJx68?=
 =?us-ascii?Q?kz30uEVa1i8JAfeCy1YsmOt9KMpr8a0uG/2+s/vEF9ytA2fDRxytq8kx26T+?=
 =?us-ascii?Q?FquEwgNIi3aITkZwB0ZejZcPnySlIhsgn6/RuXnMc88WkjmcF9g533oBYA+A?=
 =?us-ascii?Q?o7pCiBVJn0CrEx8UAu+I2pDZYGmqZ2gD2Q00OjpDwubC3tOQ/+EQ5qR+YkA4?=
 =?us-ascii?Q?qjc7QfMDg45kT01EIHU2YE8mub0Pjf3f1iDZpcbcU1BTCNWjYfPBoGF87rhd?=
 =?us-ascii?Q?uuwRgOkEgAUmetaz9IL7WOjS06i60gEMpuXk6c9NMG4DYO4hJDwTH7+d52zJ?=
 =?us-ascii?Q?PMyq8J9orCyQ7W6BrjRsIMmL4mnSc2lY3pg9wyihgbwobvtZmN3yGr1gI2+b?=
 =?us-ascii?Q?tO4WwI++aUnWnVjw4qAH+lISoHTrnJ+Xk/smxPv21wXsC0LCgGlsNKFsC2/u?=
 =?us-ascii?Q?E3zClKZUDQYVvOkKys/luzykkbARCBC5be4DmBqjYLGVD9k4uNapSB7U9P2O?=
 =?us-ascii?Q?+6+DuoHNPd8ySuEOh0bd208pFaLGODKa6kqEY+M7/g3oj0a9NHtrqGF8Yqre?=
 =?us-ascii?Q?4CWowxxfoYE4vl0TTMaDtSXAzvwBeRilIbbRWCwEuHG9jMekda4Kf7Elkdis?=
 =?us-ascii?Q?t5tHSsJUWVeC8HKvfc0FbFkqcxFE2RUVVy+/aiTsg5pIGgHs6z6tbLm+kCD5?=
 =?us-ascii?Q?wuQKvd47x3BnmYMvDcYKjsY7HN6KmOVZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+/MCn4uK1ILwvatTOEQhMuw/9nDtjhE9SZsHspI7A64GFaHNdEZLWIAYrQP?=
 =?us-ascii?Q?7Jv2CXgkXlH3z7B5PLkVXlZq4N3UsuVK7Ho8o09sU2VPH3T0CnxOWoICzWYp?=
 =?us-ascii?Q?0KcoutNOrd/KlqjyinhIxuB8gNz/Ec5CvY3Mcf5GGYnaTVnRRKsqW2G6Wryx?=
 =?us-ascii?Q?jtxRe1p/F4VdVVNqdBaInRqH3NDZB3nlSkxHqdquWvht6AjYJa2iCACTjwr9?=
 =?us-ascii?Q?BKwgHxv1F74PgELUi/zfQSUA7UH/r8HXi0PpyT+ChBKO/TBjGAQQn9UPRxhv?=
 =?us-ascii?Q?VRfye+tIiccKdAGKlP6o1Dn8JhWfkicgjp6owR8U189/yKuy8X41IvXJ96/E?=
 =?us-ascii?Q?iv6CuF0NnszzP40AXaVtdjfa/D2HffhsWVHytx3hQGczO9W+copd0wZDyC2i?=
 =?us-ascii?Q?2Gg/nJ7u4HW0zP2HDu+QFaFTKwziF7ABWcrM2rOZpVaPsulfJILpllZjDpt3?=
 =?us-ascii?Q?tzanUcI1prtn4S/4+EAkVfhP8y7XkTWnv5rf8eaU4kbtsho9YpDoi5r5r4QR?=
 =?us-ascii?Q?RDEQ/CCjWC+DsVw22IfQlScSpd6PlH7tQIFvvl/89eZ9ZLzMnTc8K8FEQb2v?=
 =?us-ascii?Q?T+ajNm1D6EgVEVL79Gd6ANzuVI85dqOhdGtqvN933A5h6JYFj13dJ/klUvjA?=
 =?us-ascii?Q?f4G91oYCYyuR6SyPLaIDHkT6J3emT4RqQHDHAMkWEj0jWjqTpcTVPRWqd9Rg?=
 =?us-ascii?Q?teKzp5p6fePeLiScv0Q+j2JTuB2TmxkX+Z4anWcRGDH8OCInY31egeHUgZWT?=
 =?us-ascii?Q?P5hCkIL5bdWjkkYlJa7cjtE7aEXBqIuk9/1zAr2MczpRh5nCHyGiMeRc2bpf?=
 =?us-ascii?Q?TR8U5a6jSrFeVpHbv2VsHMgj+9cWJsqg+Nm4uXvCDZ5Jy+lYcw5G88utf/Ed?=
 =?us-ascii?Q?2HW9xcHEzfp7RkfbxkWJbWIVc11jHxYg4lnP7rfAmgNo+NaoNj5jVH9nHLut?=
 =?us-ascii?Q?GbLl0YnJ43gh+vz1bYAWH0yevKJy5mdDHcfWZLFwzd8yIVoQP+DqYh0bhvwi?=
 =?us-ascii?Q?DTUPVXWfZOJUBuo6+ZR8TB/gb1PXsgPN5WEqQhSsHZ4QnspvXeKWOVQbF0jz?=
 =?us-ascii?Q?AdUC0+8DS1QqOq+0jyetrSAd4bDHabESYEJOgS1653MY4BTYbrhvefwk136Z?=
 =?us-ascii?Q?unaXw5jkopgWMygmntdbqJF2L6m4XsfxukJYhCMu3GEZCx/Brs+DcoJz8P3X?=
 =?us-ascii?Q?Cmi7Y+3730RRrny6Zm+lJi+WUSmGuNKO3AZ1CvlOlpumyA7a6CuCNe31kwkJ?=
 =?us-ascii?Q?6IN+qbB6pGIdxFF8jqbpoQeE8dr5zNNLUwtEb0wVzWR/hI4UMf8Ievawy4jG?=
 =?us-ascii?Q?dyB2YfNSetK/FkqYeXbuP303uiNhO2vQ5csugUOQTkihUwd1DkzJ52yauvlo?=
 =?us-ascii?Q?nBo1VBRNB4ZGZs+EwqQevLGqQpKoHkgmrGdo7uYCLtGqJTe2kG9GYFxPbHjz?=
 =?us-ascii?Q?lFXG8JpJhHQ8SordEpCmf6DB7XwYQgvuXyYasFbJW+216V5dVsFtpGsWs1m0?=
 =?us-ascii?Q?tleUbUqqAxmed02UJiraSM9EAQhChvNWYbebAqfbJ3QJPRNQ6+BoBHzyHGSH?=
 =?us-ascii?Q?PNlm5k652k31gmXzxdJ4+op94i0HaEsUb9fgk5q8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hAB7BxSOw9aeusMk7x4dWrfdpSsoCyw22cE9c/nwfqQXaGbeTR+8KRYCMM8mLJqeKaFxq5/zJyhj2POy2ngNfZw5obWpJ/taDzN6F4OHNz2q2tWB2UDweBY5DftoDsHkHvb3yqLI4BIGRD1Isaw4vejw6DJ5PDLEjvjmV+CJUY0UmFjo0tf5WBKps/CrV0/+k3oD4zV3jhH24PZi4R+RMjRcUP43DSFVLHakb64R0Zdfw7nogS8pQa9RIt8yor8G9dnZ2juT4km54r6iIKFuUn191A9KCKc/Mm4VKx/GBtBc5lsE0898vWFSW4V1ShXHdXmzGBeL5etBkFkEaaY27XTvcDVhK1xPrTAtlvevd0GVe5D8bcsfqlJRDpwJGwaClYFTMNl/4xX/dNysperh0TW8Cd0+LMLVDNnoG7FvMb1nWWfPZbLxPCiDcvwV0+sPOk4sycV4L36cvRh3HPvkdsobP4I7SNLaiBgovAPTJ+88CVdAZSV6/DJCM+m9n0AODhhlgGLy0Wtd7/PldSSA13pNdk2S87HBQXnfakjtXaMCu8ENzMmyCAMfiuWibg+cw34veQDVPBzIcwpP3XE5z6J0sMX5YKaTrZFeLL6SJVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d576b3f2-540d-4d07-5f7e-08de274ca00d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:18:39.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on9WyG/7bgFUB49KuPcgX7MLifPhy1fgZ19HyHMRtFegW2dNChheweRiU2jrgBAbL5tfWusM8nGc3SRqnNPycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190073
X-Proofpoint-ORIG-GUID: Y_MXxBexzNnsLHuIJxi-h123h_7CLhIP
X-Proofpoint-GUID: Y_MXxBexzNnsLHuIJxi-h123h_7CLhIP
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691d8b77 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=QJzjRwIWDCW5RRPxT2EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX5Fh4DCA+PNf2
 UreZgfanqt4kioNTcuCiYYO+QF/j9fRz3AdG5w8T6cPA2JH153w/FbkD2iP4AviQH9fPGSIueI6
 l0IYXgn/ClxTwFfDOoh5Wcom45ygj0xyFWmTp8iYoE++9fvMxfnF5SFWpAb8RTWyVH6YmcnXVs4
 kz3OIV4VY6kR4zrH8vI0WkWfyfUW4fG8U7HdrURH4uiUkVNW1DGFbFnJH/tCgV/Hu3ZJchVvnwx
 jtj1eygL0+6c7A/njiovpBxFkVameQ0OrSpL67CyIYkIiytt/OXHnI9mV36wVafCU2JZbZXQrhX
 rPWNHWVCKffefy6ft09USO+0QJ9FdD1dhzCK8ib7PkngJT3wnYWPcp+lWax+3XcQQgbyf4sQqgB
 9r8hHM5dFUecv+3WcK8Ihr8Ixf38rg==

On Tue, Oct 28, 2025 at 09:58:22PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the function get_mem_cgroup_css_from_folio()
> and the rcu read lock are employed to safeguard against the release
> of the memory cgroup.
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

>  fs/fs-writeback.c                | 22 +++++++++++-----------
>  include/linux/memcontrol.h       |  9 +++++++--
>  include/trace/events/writeback.h |  3 +++
>  mm/memcontrol.c                  | 14 ++++++++------
>  4 files changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 9fdbd4970021d..174e52d8e7039 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -895,7 +895,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
>  	return match;
>  }
>  
> -struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio);
> +struct cgroup_subsys_state *get_mem_cgroup_css_from_folio(struct folio *folio);
>  ino_t page_cgroup_ino(struct page *page);
>  
>  static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
> @@ -1577,9 +1577,14 @@ static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	if (!folio_memcg_charged(folio))
> +		return;
> +
> +	rcu_read_lock();
>  	memcg = folio_memcg(folio);
> -	if (unlikely(memcg && &memcg->css != wb->memcg_css))
> +	if (unlikely(&memcg->css != wb->memcg_css))
>  		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
> +	rcu_read_unlock();

I was wondering if it's fine to record foreign dirty info to a dying cgroup
and lose this info, but mem_cgroup_track_foreign_dirty_slowpath() says:

  "The mechanism only remembers IDs and doesn't hold any object references.
   As being wrong occasionally doesn't matter, updates and accesses to the
   records are lockless and racy"

so this looks fine.

-- 
Cheers,
Harry / Hyeonggon

