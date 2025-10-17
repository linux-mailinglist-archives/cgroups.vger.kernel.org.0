Return-Path: <cgroups+bounces-10836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E727FBE6718
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 07:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4F4EE027
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 05:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D08C21C9E1;
	Fri, 17 Oct 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DEicWG/C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YnlTUF0i"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF8334686;
	Fri, 17 Oct 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679575; cv=fail; b=PvIEOli/6uJnZJmcOV0ncWexaufr3rcqbEViFYnr3BqJZTHGqYcV/p7EzqXAJEipQtMG2aR2qANAQvQsdJgD5mdaQsRclA2LmoC50VKZ1zLM4qaELr5k1Z/dmiF6FI48hUUa8/dYW4YDU8QGRmgD/N6smgJo+4yM0JAtFiCbsAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679575; c=relaxed/simple;
	bh=KwGCjDvHW0RofjXecWT2qcdxf7W8C5OArgTnlZOyhf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BnOI6K85DMdJv7JY92hU38uSBvizoPh5i/Yqq01yfac69JW1RSrbaqCDc9X4ElWaAemaI4ofZhwI1xicTP1a74BAhUWufQhx0UMpHRY+Rv9X6W0NHYfAunQZlZ4xVgHFXlrKy9ksptHftw1zwwLf5CEtYBnp4MKTxqGDskGM4sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DEicWG/C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YnlTUF0i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLu99r032266;
	Fri, 17 Oct 2025 05:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PurqZoOyAQqghDYRVO
	4dP8Ucrloq6RZpO+1oz9WadKk=; b=DEicWG/CpLXfE6TP8Mwg9yOtE9XS4guncy
	UDkFtUCWVsLzQdraaNBf8BuEos60yhUW0CdIF7BziMOldMl9iNW1/D81cp/ZNiYD
	459vUl5dzH+53GdnUF36XCQ2dFU8g9OnHDeb77LzywhcW23eAvBfycIc1AjJkfQq
	snm/QM9+PU3U2ak6Gr3gXEKHFlWxDxinTwDlm9pXh5+JXvy83zpaqpUB1LL1kEVi
	Ea+cXS1CP5ENjZtvskC8x+Q/fYF5Nm4TfIBogeovtcG8Y/0xTkgzYaBeEKbFrt+3
	Q6g1q85l8Vg8T+5GAFZMZVPM/2M6C9HvzfEa6pF3jgjMB1r1ealQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qhby7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 05:38:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H45kV0025938;
	Fri, 17 Oct 2025 05:38:57 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpjn7xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 05:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFCftijaUFoBMxTuPrKzaHtt3V6yzY3eylvGpdAeXU2vGCNRC7kRgf36GenEfv8knGc6SK2TPtszVmSySoU0Oa52wC0XfWydeYmmkCDDXirY0plyfnkMgS9TeZ9AE6cOd/8l953O929TcDlTGBGD5R0qaPjd2VhjjKt1xq+RI4eR1CvQkt8/nR9tFWJp4RmTWBzUw5Hy21QEUVMSRFFjtymBf7T145CUS/8N3QkfsIm9I5GUaSQHRzIfO5c7riNx/2rOyx2W/8XXZY0mueQy5ujWUtYvAAyiOtR1Q/uWLEiaEErszvIWB7c8/bQ+D130Q4slYfpq5zqpT/DRc0IaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PurqZoOyAQqghDYRVO4dP8Ucrloq6RZpO+1oz9WadKk=;
 b=xQkXkbx603xOtwMnHCSX8KsarW26tTM3pbdUNe4N8oYfAU5sqpznb9HhfS+NVTYrCUUWfS/XoYibLK3zCfLgp8bDQ86ibVfx913O7ViqCgUMQEhE70t2zxjTvHoO8ULYYND20otPf+OzSnmL/EpGT/HSXH8y3Jg8U1yVnLvAzhJA2jApatZqlCcD3fnTYIqTY9WvWU82lIJGIauIOhQzLeSrnng/2CgWjl2sb87pcqqVigfLwBNe3wCIrXTXoMhmb2lNBaUdyZh2SDVGPlDj5FjFOGpyUefPw5B2aA9RoDBnf3M2sghwiK7RqUZNe2x3euW+CowrDf7F87n4KpjAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PurqZoOyAQqghDYRVO4dP8Ucrloq6RZpO+1oz9WadKk=;
 b=YnlTUF0i83dZmrrpAWEWmF3SAekvo1osD6Cx8YBMPUdvq5S8BRrpZqE25RGj+92MVGa1rW2VCWJPp54xuRaUoS68VPMKCdmDRctE3UFKnkZSVprU5oBkuhkf/P9wIXaItpfsIb2HjVIffLZIz8m6VXw1F0pYzU+3yYA360nVFb0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4403.namprd10.prod.outlook.com (2603:10b6:303:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 05:38:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 05:38:43 +0000
Date: Fri, 17 Oct 2025 14:38:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Message-ID: <aPHWR3VE94qmjWL5@hyeyoo>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::35) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: d90317f9-3281-4786-ecd0-08de0d3f6ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwYEVWTK1waOou161+bmnZSJ+cWzpOc5T2iTk3ftEeYPkCuxQU19zGCKoOCa?=
 =?us-ascii?Q?nc9Prf6KlK/yM5fUWWZPeNCobY5G6I7Ogm03Ujnvh45LbgyEyM51dIhe1vIa?=
 =?us-ascii?Q?h0IUqVRBd3+j6e8coBtsHVAEXeJ6LU5D6GvgLotA7TgLMpk5CaiPt0slgdc3?=
 =?us-ascii?Q?UHlMWJsERKbq92av27vS4Me/mSaAXzu/cQhhj3KUx0SBmpGJef8FIrjKcC6l?=
 =?us-ascii?Q?63iMzneIdajNkcrC4X02gzUrmUEVQtbEOgJHgQjoPrqxtC+xkHByquDaNpM3?=
 =?us-ascii?Q?vIS2CUcbnh7IQte+M7VKDZ1wcpBOTFIZWi26Ue/vlfpY3HQUVvqqljGpp9BO?=
 =?us-ascii?Q?Sv4/GAzDqVG/hsh8j3+Hgh4ATjj6KFMX5vn9JKOX5XQIHRu+/l4CUtb+39zX?=
 =?us-ascii?Q?FtVDOhIRUqTRJhiYhq0I4kgJdBUjV7f8h16o6CMTSlwHMX3Hx56KA9zQgMdy?=
 =?us-ascii?Q?4E9lrQUVaS/naEyob/XA69vvPMl6wfH6wHr87OLpYbFmLnY3WeKc7n+exWEo?=
 =?us-ascii?Q?E3HZ2ieemB5zfkGNMI7w7HgV4CXWAlOJaZreV34wMqrejy45DmuJBHtirVnB?=
 =?us-ascii?Q?Y6jgmDY+PFlJw8WY35tnouwbNQDgIc/9nvuRxbsxzHdjcXr03ym+8C2Buvs0?=
 =?us-ascii?Q?fKu/zET2ZNHt9h8pUKOi419VMZe991tHaj1RxlxcWRhP+p4Ot7GLocLk2AMV?=
 =?us-ascii?Q?PRYUFM3F2RgDK4rfbNPH4co0H8Vpqe92dPc6KoeGphoOlZTg6ji06EJ7eBNM?=
 =?us-ascii?Q?xg5ImObxExiQQqnPhGPJ6WKNu8CVminCEaw4X3uPpFphHhcIKHtY3TjKry+d?=
 =?us-ascii?Q?CoUBd9pyhBif4JH9hxAMo5/pdei8Oq2vJzhlp72i3jpwa8Pa0o5MVkECh9y1?=
 =?us-ascii?Q?UBFY4hxXryi6Yn+fMfhP4WwWClYIPXsE8JPR+oz3uNW1MpTFB3m50AgeXC4h?=
 =?us-ascii?Q?avkQF98lXAPwHU7nNrMblDF9tSE3hJu7gy2EAL81VXMwawBr8vRIJimgI6LT?=
 =?us-ascii?Q?Fjco2wl1y2GsESKsgbqvRrv3NW1OEJWL2Zjlo6skSkTIZMJ+QXvVUQdSYbAW?=
 =?us-ascii?Q?aOhU4VxPeKfchhfUNbAgvJmQ4wjntyaL7FgWjRy1Sj1gLhfP8sS5iVV9sGiN?=
 =?us-ascii?Q?TiQz8VrVsBrxfdTpmELAgAUaEjwAgNbbLUhqp3lHBOqIRfq1i//jxmbWhabq?=
 =?us-ascii?Q?C4LQ8zCsY7Yf+572FnMvrro4pcbZuEh0JEZV36h9ctkkSawKJ2T3BpnhQjfs?=
 =?us-ascii?Q?mnAQcLggE7JtRHQUIyOlJ1Jhzlah6faas4eY513/6Cv60B3erfoT7CSc+d7p?=
 =?us-ascii?Q?696EtNeqwLABOnHuIRlFjrR5pckQcVMr03u2zVxDvFObjR8aKbIWFRAr+4ZY?=
 =?us-ascii?Q?t0U9eHNUvAkinb/qCTxAd8OKOE2g6rzkfPUVHfOAEXrBf9QVcL0/+KsKKLu5?=
 =?us-ascii?Q?qlDqg2Dlh+nQu/NnMRTC/GPwxZgosb+4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MxgZqdWMz/Hxw+Y11L1kguVI3A10ZiXjaoh84Ae/hAVBzW7z78c2hva73Hd/?=
 =?us-ascii?Q?xPgk9WfwnEhctG5HLjAirCF1W+4CEaX/VaeqagZ7VQ2CqaIej/KKe2aabOff?=
 =?us-ascii?Q?YpnCpZ1/mn1Cz6r+zDjZoLmas/Es7gxjiACiG2PytncttVVBexYUv1fOdtz7?=
 =?us-ascii?Q?FRsbd8vMb/OFUeIdi6jX3a3FVDwGRIEv/bJAjdEHoN63a6KqIGzcONlAXFVn?=
 =?us-ascii?Q?GX5PK9JXAPnKaBU01zUQ5plgRFBGHsS/JG+6uLxqauNmqZf1CCy1MRaAuB7a?=
 =?us-ascii?Q?8rTcbt0wBSOZwcw0EIBMwnXCZMZ9758/4C5EW+kUspg0NEcpTeg0kCHhP4zy?=
 =?us-ascii?Q?CnGCgxFqYBPTknq2tdSgK5YMqFuqT71OPpWFcfbJ1qWZemBKyToyhj2abNmi?=
 =?us-ascii?Q?Jos2K4aPvAYVhsS0XUu1GbDaFkK/xzGN/k9s6rboJrffgjILIRZ2XZEH9qLi?=
 =?us-ascii?Q?zQHcFhemNA/GU56hgxqYwGAcyVofobbT96eWfcXBgvzRA3OyeMeDJV6R/tL0?=
 =?us-ascii?Q?X02H96iSEX+VInZF1uXv/dfOUYXPlIQ1QTYRYlZ2wo7uVbA7oCgZazoExvOm?=
 =?us-ascii?Q?obadnZrcMuqi/PYxctSuMc7hsR1vXGZ9loNOcpkvnoeZvx8jNX32tCJRf9Ct?=
 =?us-ascii?Q?K7k+oUem7dZehK1WT7vdRh9EtMzAWb09CuBgOFn2OhOY5/DQ938a/Fd3q+rX?=
 =?us-ascii?Q?OX7dCAn36KqtpAmWt5U+dqZTvyJ6gIgV6nHJHa0EAKO7VJ234cygZleBmVhu?=
 =?us-ascii?Q?NCXLRkqgkF5wTPswKG4OcvC/DUqBrdWdEcpr3CB/T65I5JQGz+hf3ZH12sAU?=
 =?us-ascii?Q?74bAowyOOQ8l85AR6/XJPiBiYey65+Movdg/SbvHPfzr1GDoyVokKHTrf41D?=
 =?us-ascii?Q?zsRLGe+ukyuFAJtJggZV5tCAwoNCsgTOqaeK1am/JNW0InTEKeOxgHS55hHX?=
 =?us-ascii?Q?N3G4YQ1WUnInPSbuGYGDPxQzGf0mNlcAnSwLlFPEBNjRom49SqQ12cnzUoHd?=
 =?us-ascii?Q?Bje9zgQ+3VJYn4iS4ilZdNp8shRMiRP6VOfHoLVIhhIeCm12DOOOQChZYOAz?=
 =?us-ascii?Q?Un/0Jb41nTuNyIAhH6cGlJ15XHRdWg7ISmCcoJcsBeneFzcCDAm0EZ64COyu?=
 =?us-ascii?Q?8tc1sQvfqS1zu6oIfPx6YvzImPflTMjdrSYAoMwxAiEajxXR57gWgTgqUb2W?=
 =?us-ascii?Q?dHTIa+YMzhQC2wVdVoD1df57441jgeWAF6hphu34fTaS0abfOXuBTx4Y6fXT?=
 =?us-ascii?Q?mCwvVJZZx5zHGvnbzR/1r7mpbjXrKU4YBNTIXUJ/c85oOn7S97bzlLcNqONZ?=
 =?us-ascii?Q?g9ry3hy+OSm7dhyoViLa+6n8IgXnLBtP5bzQu5GE9c8kPv+HCgLgpTT2mb/s?=
 =?us-ascii?Q?qxs1lOMqYPX2SSpcj811LlQAixhkkzOdNJXlxCm3t6kA1rhpFTcSYhLv+C5X?=
 =?us-ascii?Q?rfjWmRfFt+SFMMXOYiHWyiurw1kQuOquS/nDB/jWsjauPbv63Ae2sBa7zo/H?=
 =?us-ascii?Q?k/WX40KY9AsrlqpZvVhEW4Fk+ds40/bpoV6vJMYgsnY9lsdbpxGu612IwwgA?=
 =?us-ascii?Q?EDmxG6wkaZxiZ8Dgr5Q79nlo2DpXhgTt1JlSBTvP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	upo3Jd+bXX3Vt6tZR/E6KCgLS6uC6cprfwvTdsHuGm6Q2H1Nbsxekl4A13u3uWbbVFDOBLpe8MArLlyu1vazotre06v0bQZ/MFd5nWCTpQVWFEAZ/ZQZ1TZNss1UNyP90GAO3jW6Gl81DZIA1TgKK7C7Tq6uY9B9NRj4OhAQv2Rpqtv5nf3HVbaYXPCVkYamBXjNzQ7tx2H9rMkhx9nUrNNOROgXfGFBTT8RkDYEndBfILBUKj7xZQgqKU+fzRvLqTnBh1eiAgxm6wBEN65cmqp0BnzS+BARAto0SvsWhfrDmKNLl+xYqhbRfyhDC0/NQVH+4mmfNuqvSPtJCa2Gb0VuYDjfs3ZMQDcbEE1pjMWeS07r6t/ly6/Pa3/iq/WKR95zXIMN1ScnaNQKU5u76ehUZVwNqZMNcw7rmaQukCj4mNwVgStsvDhBMw9mElnwkcU4uss/QnMnK9VYbbEejk/cdefFmHhFv9C56OqPTkZ5DPLLj9Zzl/yVdluXGCJMAeO4HX2il5mJ4G6wRAvLXzndma0mHlRYy1xyTTXQsQm5vz+y78mdkH54zKYdUdlxkW/CPDK7hW1k+QWvpmLBZq9wgGiqL+cMhF2n90Sm6U4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90317f9-3281-4786-ecd0-08de0d3f6ebf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 05:38:42.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ua16FMMcqCHFw/XlERLUlnw7mu0I756dTWcPk2E3XH3NCd+I1cd5qkH+qkRdJve37/jgfcXdqQx2bnUnxnNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX7dAAIvR0hDH1
 SYMwpJUpF/4j0M9I4M3ZEf1HLE7jebA63vovvT2zIVL1NlI9dBEQygrq/HQ4bc/SdbPMVuzIF7Q
 ETjNQWCWCmA4muSKINJIbQxIbSgGubn1rSPOKe+qjfB2YkmLSaNCmfh0zpLj9rdH5zncVxkGKEG
 YdCwl4gPqXH+5uSwfiUz/d8SwESUiA3XkgSNrW+0/GDVVG+35/LFsmUW6ZKUka17EK/i5KOzGTR
 ctzq4VHLKpnOBsCPWmTWEHgIDjOzHHyJ70bGDs1vTfDs56Ol3FdBHLSHOwHkczO9FmTtdfEEFXr
 TZAnjjr12eSckF8iXC0x2sSfZpi4SG3OlEXEt/sGtRPgchWBCxhoUHVzLuZ098kGHsg5RunBn+5
 evZuixss0os7cduTHlFaqUti1ax2Y5IPbR59D/U78FrYOL9cQIM=
X-Proofpoint-GUID: xtuBFYmlBfGorEwO3oaH0XoBYFEuIXax
X-Proofpoint-ORIG-GUID: xtuBFYmlBfGorEwO3oaH0XoBYFEuIXax
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f1d672 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=wjPibnQ-TMmD0LTstD8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091

On Wed, Oct 15, 2025 at 02:35:32PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> The maintenance of the folio->_deferred_list is intricate because it's
> reused in a local list.
> 
> Here are some peculiarities:
> 
>    1) When a folio is removed from its split queue and added to a local
>       on-stack list in deferred_split_scan(), the ->split_queue_len isn't
>       updated, leading to an inconsistency between it and the actual
>       number of folios in the split queue.
> 
>    2) When the folio is split via split_folio() later, it's removed from
>       the local list while holding the split queue lock. At this time,
>       the lock is not needed as it is not protecting anything.
> 
>    3) To handle the race condition with a third-party freeing or migrating
>       the preceding folio, we must ensure there's always one safe (with
>       raised refcount) folio before by delaying its folio_put(). More
>       details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
>       split queue not partially_mapped"). It's rather tricky.
> 
> We can use the folio_batch infrastructure to handle this clearly. In this
> case, ->split_queue_len will be consistent with the real number of folios
> in the split queue. If list_empty(&folio->_deferred_list) returns false,
> it's clear the folio must be in its split queue (not in a local list
> anymore).
> 
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent first. So this patch prepares for using
> folio_split_queue_lock_irqsave() as the memcg may change then.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Nothing unusual came up during my review, so:
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

