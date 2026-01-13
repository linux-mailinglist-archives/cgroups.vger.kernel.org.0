Return-Path: <cgroups+bounces-13130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BBD16D2E
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB5F30B2C2C
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8036920F;
	Tue, 13 Jan 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ev6QoGID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lBTLScc6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE062F6925;
	Tue, 13 Jan 2026 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285197; cv=fail; b=UhK2aTu8AUd5ETfAZ7BFo1aDE8OwU86z7tsFiyRNrI8vsZPKoUYy5z625liaQk86JoamYC3K2wxFgirhVNDvVdjc7jRxSjK+7v+wIOih8lfE7DEzQhDd0Yvse9E4EzhQtGvtVmYyzzadoJnIrAYg+D3f1mZPOAGp04gKbtmFfeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285197; c=relaxed/simple;
	bh=1Y1wdttmg6i81kmQgc940m2Ppt83MuTkn3QwkUDjKf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xz87gFh73m2gkLdf1b7YBI3PLPCvbuSxDvQoj8LfQSKisi3vTbV9wRrfN76eJmS99HBzNox/WRFphwlcaEJ67Uj4Hzv0HW3HY4xwHimFZ33MSODzXkLjMMzegv44M9wJ+A852g4WMqisxmU/E3yxoXY/lqISXpnrl8y2RfFnZis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ev6QoGID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lBTLScc6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gvMR2396125;
	Tue, 13 Jan 2026 06:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HnXsFNZToNoi09G/P8gJwQcmm/Lt+fUjFgTF/4/Lt5I=; b=
	ev6QoGIDB3YFErzeKcqsPvFAcclho5cifYMZ/QKhXInrKpAvUGELbbJ5j5c1RA12
	KRR48B5p+nRhKfbyEXr21jqjqSFPgBjOMHeR3ZtJAX87SrSOw9QlHp1yPI8ekHfA
	RCl90Stz1WXS2AM1FY4p7E2XLANpjU7Bp1t6JkG9JU4J2nOhUq8gtQsLa90CRGxK
	Eb6t5HZzk3nf4N5d3v47sJfmbhA0+lW6kPOZ/hqassUxxxNJzA1OsHlBlX8/dvwX
	JoaoQjC8vKWP8goc13amC2S4f6p+2g2QKluyKfjmPpEeiMjwfkT18qDOV0/w0FTE
	z/CyePmEzE7m/5jEsVWn8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkqq52w8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5bDQ1029103;
	Tue, 13 Jan 2026 06:19:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7j3tew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPOdHHV9Y4DZydHVRRzVDLZ5sy4LDmGkln1thPSMVPfJ2iloIavXg6Hr6qG+2pBqNxgVBizTmhMTsp+j13xsQDER8wlM9zx8oa6bFdyiMFhVmes8mGXK6eSxxklPEbp51cMYFmZwlzVBAjztMHYGiMZtZAThCH7iwR+QV0OHPHWfzDgr9u/2Yj+aE1wG1zDBxNMaeBw0PHWgB8hb1CK91MHZB6+WrwoxSHsab5C+XQ6yHu+Dhx6FOJbAlRRaz1gPV39GLK3ucH16Ntl1U1Z93ajByqv3k5Zc28LyqrauBW4LAhnL6yQMLZPhzdJ9bdYgAZ2H6o1jNXp9wWU2/zc9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnXsFNZToNoi09G/P8gJwQcmm/Lt+fUjFgTF/4/Lt5I=;
 b=CCEVMcQtissRRg6HYnpQMdVIWF0MQTe5Fq1Lhq6Av9EAi8Jh6yRh/uO2X/ndTQ8wKp47I/AXcLAHKZrgmN2TWVZklEmKSZTtAlHd9TPU7fRn6h1mYJsfd1SYruSbrQ82oz2Daoda/bOHB2lIAwOUTcM8RUdH1u/WZbaAKeAeYusWo3WlHR6KThM/p3Ck41zFhmqxyZWT0ysUj/yHjlIAC6kHHCubfE64DFIZtEhxClzlY5pSQmfI6HP6sUWXk8sxnlcfIWUMY6uGrfKrTZqR7axVRk6Z/cGORT9PzDxODSPzrjjU/WahzbYoxCuFoo6gXcV+tXxGH4mmv9PaAgdh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnXsFNZToNoi09G/P8gJwQcmm/Lt+fUjFgTF/4/Lt5I=;
 b=lBTLScc6mYca5SJ0l8SpPVivGjuHsDzz9WeKD20wtH6E33ZckyWwILHdkeKGOpGs02LpJTyt07WUgz0CiwufPpisouxgKe3zLuO4vH9bQu1wrOPOt9sJmisXu1+vgB+sK2tBGavfBa7mYFDcPDu/14mZiGqFrxegaOnjY3aSEeE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:19:25 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V6 9/9] mm/slab: place slabobj_ext metadata in unused space within s->size
Date: Tue, 13 Jan 2026 15:18:45 +0900
Message-ID: <20260113061845.159790-10-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0125.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a39aa6-21f3-4244-b2de-08de526bb2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GwnNwzMyiAiYzUbQ+3FlBMETR80IYOCwZHkT5jb0nr5YmLuU5r/tt2dUj++d?=
 =?us-ascii?Q?e8eRXL8nBiFRIHSLahgoBB1ma6lgRdPHu6UowjscVADGXYyupj2yM70iP5Qo?=
 =?us-ascii?Q?ST5wn40MMFH7Gac42DKW73rJLJrB+7a0t6dNcv6f5Y7N9KnGinFpjvWSZD0J?=
 =?us-ascii?Q?n/8SepaVjzEA0CsNuzlRj6wMJ23yblskWNEOTF3tmryO7GaHnEVvoQ7klbbs?=
 =?us-ascii?Q?YYXLVFnonDURjIabVrV2+pAS0ctgkbrs94wnRkD6juJsUH1gWIFoHPihGMFH?=
 =?us-ascii?Q?2xDtYPqKLaggkPv9I63S9YPHcTrf7srdJH1NVIVxy0E/J0YrJS7XwG3gMefO?=
 =?us-ascii?Q?WcyZ8LQeVQwNt1V80nUtHAIUKowmXZ7EM6IOtGBg5g1Bv/8IAUfjXHN7lZmG?=
 =?us-ascii?Q?6TFTUUBDwB+fE3A6+5bFJOrbTnzx0a/0I9151ChF+2OHDOyooT7Dz2+Vp3/Y?=
 =?us-ascii?Q?KYUASCa5dZDhZj00pLRC1o0tyqwKnH+SW6iZVplstTNNNqU3/hbmTKh9Ew55?=
 =?us-ascii?Q?OyWk2k+pYtPqcn+j0r63L7TcwpsjJNcdb3pBd5FQedcokDZ0aKngxNlWv1O2?=
 =?us-ascii?Q?3+AGx1Fp3n0CX4kkLsUA7+E5pXDSAetzgjQ8oqLAr/cFSl7wT0Bwdt+yXTMg?=
 =?us-ascii?Q?KxRpWMSH10HaHSgZcMFVnGIxnhqDTs44YcySTWh38NJCQc+ix1S7ntiKX9yL?=
 =?us-ascii?Q?U9LAYxUxW6jB03HQsze3xxKdfonk59xm/Hz6dhZh7S1qJwuZS9j+erfqNF/J?=
 =?us-ascii?Q?I51WpaObd1ZbbSxb5KK9e5vQ0Au94TGLoH4O6A6c45D1cuC+REaUFwYaORJb?=
 =?us-ascii?Q?XLYPALb/dyti72+E/zFVwg1I6d9hVnk5Kmzsg44zh/F3zsA2GLrCpAR6n0I/?=
 =?us-ascii?Q?kREHVl9+WtZYLPIzUVMj8CInhgIYLbe8bU4ilm6ofZCcqzNrJ+mS8zRfj0fd?=
 =?us-ascii?Q?jxBL92MItbsxcRx7njsC7jNDSvafEEgf08is4t+OhKsbccDvCOQ+GarakZYK?=
 =?us-ascii?Q?9KTUCmHWtb5jK3Dgp3mm/SWzLGK988O+PpY3nHqTixOgcl/Y+V/YApHuV0Ty?=
 =?us-ascii?Q?+AkXZtBAiplGQIXYJLTaA3clSnvQFxj7TxuCg8dZvGDZPfyCKfGVON14javM?=
 =?us-ascii?Q?HSCxNlUQJ/qBsrdV6yCUns3iKD+aY1hIxWh1UKxsmw8pq+WjRKIjxiSMIOeP?=
 =?us-ascii?Q?cc1sgesP8Wi4s1umru6kqlm2z7EwsGobYWlvC0QCAXrBWceL9JirRBbtpvIr?=
 =?us-ascii?Q?1FH/ObcYc10/XgBo/LQFt+ktTHphHTFEF1z+Q+a7kv89DrC/I9gITxnu4MZn?=
 =?us-ascii?Q?40wICT20pZJGuuTFg16srtJhDu6TB8jpg3Yaq57KCxYhWRDFMzN1YGfAy9dt?=
 =?us-ascii?Q?QQQsZE56CuCIcIFmU0RTbEmO7gZQKw4z9kmyBPbIm+/9+NVVX9f0izfs7Mlt?=
 =?us-ascii?Q?siJewAksS96QUIbXtAxr1h9iytBpkeAT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MCKkpuWkxLHuXOB0dgz/7SgCRd2BukgSwq83Ro8KtIr0Zg08zbSpnDIGYHgE?=
 =?us-ascii?Q?OJFeT2SY6z/9IVzNlnakkw3EfF6xeLqMOa+SEcwwEWIjSBTDRNd0l8qhhkXW?=
 =?us-ascii?Q?L5ruz9cuFmEXeE5AZSBGsDOmK0fdk5oXrSuEZNEF07IPv820cEHJpxWpNiVX?=
 =?us-ascii?Q?9aYge3MAxYPwzftLC7nIYTd1pS+aKqysL5cUPMo98hOVAypjWiHzxmyzH+X7?=
 =?us-ascii?Q?ifXToUzi5tRPv8jOfxG+UTCqm35nzVqN2NlnijIEP1sQrYm78JGImFU0kjPW?=
 =?us-ascii?Q?7q6pwRJ145TCsNZSv/qDrTQn5bDN44EWQ63l1YetDg6+kj5g4p+zB31vpePP?=
 =?us-ascii?Q?NZfmCYwK9L0kEIgRWa5JZniEPKwhgY4rDqhlfsK8JCEEgUUom10+OkQubc7L?=
 =?us-ascii?Q?R1hqr+1q5oYVO1YiSGws+CFUPjeXGxFDq8o+2BswW67cPRTnFlBs8sdgP2M9?=
 =?us-ascii?Q?tHX0qp8lHFc+C1TXMvPGxrDBk+zdL8F2dsB2MS6QPrvd/BYtkcID3QL7Y00F?=
 =?us-ascii?Q?yJ3gZUZy2Yus88fET5bxD6ctT3Ua7u9/5rTj5SWBcphkhXSX/LJuXfEd4nf5?=
 =?us-ascii?Q?R3lYkzF3ZfqiGb0EmED8u9xDRDjS0UBpqX14J9Nag/VI+jLT/cFRSYVfUU/w?=
 =?us-ascii?Q?7bRZnuuMqMrPtnK/85WgqWyEnoog5NrJx2DuVzmhSI2JKoezxUJRuFqZGny5?=
 =?us-ascii?Q?X16ObeWjAe9d4ls9xa9JZjuxG9NsFqOW50CM4iEw/MAPjT88zw6+tvsUpIWc?=
 =?us-ascii?Q?f1OZfYzz89XczmUFLco2q8aIZlsVgDHxof5RjhJnj1M4oVAjylfU3pG5UxKo?=
 =?us-ascii?Q?Mn1OOCRRxM2SDi5crL6BZFi3gur5j/v4BB7ZSO1di56MLgpWDZve/uYa5VMY?=
 =?us-ascii?Q?MyDp2LP1OuxgOhGQKMjb7YAy9IRebcPaOIVheicPlG7OunsEZH9cVmKfe8H9?=
 =?us-ascii?Q?eqadVx93qfRj8RuVOK5WU71gJbLhRcAgUl9cY9Fn7NzgD7+lq5A/IsJlYswM?=
 =?us-ascii?Q?dyWruBPdzBknIkjD+zwf7aGMLu37m2doxDesoPoVTRsnj74TFu6nWC3cO00z?=
 =?us-ascii?Q?ZXBfChANhDXiWINXxwJ8+zB7J06RIaP/5HXrAdJYEiKTn5CwvQ0iZVZnVFEo?=
 =?us-ascii?Q?tzzmKbhqzXX24DF+ubjnKQ5LC34TFS1jX7aW1ncgx9BNrpp81XcHjDcpOVXf?=
 =?us-ascii?Q?FVAgBzLSMdFU1XxLUlFgqoU9DOn5jh7JMKmDdnWYenXf8wgyogyxFXabtB8S?=
 =?us-ascii?Q?FdMaqfssdocuSdeYeY9IgtmQTPLFdehDj4XnvKQhzAfAIvY7iP89jzfoEvVr?=
 =?us-ascii?Q?PZkFXVYb/FsdPzGEt9MaRoOVlXXQ5AZC1w9Lm8m+5lRISPfsdTsiGTNeaNpM?=
 =?us-ascii?Q?DykgXxFqp+qi7nCrNY5kRumJAccpO5D2xAr9wVBpucY67cNNTeYOzL933+qI?=
 =?us-ascii?Q?ARtPm3yR7W2M0B3bzMXblguEJQUxMsCstE96Q3R83nNgG/zknXId7Vjhv7Cj?=
 =?us-ascii?Q?SgEiLTIJUG1wg7AmKNtJPYBXGHHMTfaTk5w2FmIFZZUr98XvdRolRosoCOMg?=
 =?us-ascii?Q?7ZDq9tIudjV6eLlSkEY7bq0PyfbqU/7eZWFiplmzpkXvRYNqHs56wvclrfEZ?=
 =?us-ascii?Q?0wk3aUuxbSUntxeU4/BDBOLnWgXayyYeeWzUSgcckhvfQGQkANG2HWqpvEx8?=
 =?us-ascii?Q?lcagg3kcL10ohr9EsKzHKNbsTkX/PoHAEl0ry7zC682CHFA53iqLgD2uaRhW?=
 =?us-ascii?Q?xS1qdjEBcA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RkshYZtr3DzJ25rEYAJSjIWRQHtXX/QtZf7WouO557FglmAB72rmajU4NRSL5SAy5MIELbEa0rYFEoAULMlPZPEmKdX7s8l8nVu8yP81pRSDI6+cUSSb49SOKubhaWImveafrASrjJ9RjUqFjTWZFucmyLIEjZeZ2xsvfUQqQDAA+t2+yrhQxwqiK5scnS+Lys6+fPGMeiAppbmAraKDR4HZPepD4SCpbDOn8hhzkO31j0XzXBMttdGetqEFJsZH4G8qark8rCFv1tgCxJ55Egu/lEJ8W89ZAayaU/LrDWhic/ALsqtVILrSjcFMqcyYhNldUX4QH+9AXHE6plUHnJ41say0NAMCqi+rwqR8rrHzoQiA2tkpX+qfxqUxlSJQQ8xq5yZlNwa0qZF40V7RuZV0r4gWMHbosM7IjDS2TBb4PhzscLKYqTEOhwVCha+u/E8zilnIXhjRsFitQmVdHGx6o1obanlYJWrGJL2Db9+h2nX3iN2Jy2dCiJ+bAAkNFU/29nZYMK7Z4RrcoOgfgR6GpeZFoayNoTLRKsWusfNMhp/wtf7jYGgFJbMo32Ic83q7VLVBT+SNVKln6O6TV3X9fwlVdF4gJIhT77uEmTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a39aa6-21f3-4244-b2de-08de526bb2f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:19:25.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZyETy2r6vSO1CO0pUGM4gmVt3sV1W+vIty8gRgT3to87raJVSKRqg64Ok236Ejdu1ZiSINtmsuTUTCeTFTk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130050
X-Proofpoint-ORIG-GUID: nRrzOP2sXJyRdH0rcLerh5l_KPSZGxdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfXwrdHoB+xGAuR
 FNlrYhUsOrjg/4b9L5YdyVhUBeldeyoFHotK/skA72gYpEUigvU2Sg2fk8njSKyif7U4Zrfbkz/
 D8UsE6uXazQ3tUB3H3F3HjmorBpUyO7YnHaUm1mIVaqT2m35rtHUGKyzqnTOnTTgh/ofVi0itcp
 Tp0QpLlTrv1PUJyAPDLxI0F67waiehL4MrPn7p8qKuFeZQhnfIBcThJuk7f3f0FN3za70yHNpi/
 4bhvEG3jq8qpRv8xj5F36/9evEZj/qCg5JZHo5HC4ZkSBJ6IGfIlB7fl7MxkUC1DhcVYLfB/jPw
 forOF/WwDJR10nv3OoUlZtWTCHRqXpk6pQYdK0b5le/j06xrMm6A3iZf/FqxVvFj/01CmlkghTe
 OWh4Bp+NSvQ5oTXs1cZPxI6Byh7Lyq2uFsLt7zibyhw0Qv+Egb89i+7pKumpcrrjIQyJFhuhgPj
 XVr/XLau1PEPW6erLEEGmiBd64kt/cYIUaZ4tfc4=
X-Authority-Analysis: v=2.4 cv=J9KnLQnS c=1 sm=1 tr=0 ts=6965e3f2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=DIVfZmhqI3ZMOncJ1qUA:9 cc=ntf awl=host:12109
X-Proofpoint-GUID: nRrzOP2sXJyRdH0rcLerh5l_KPSZGxdn

When a cache has high s->align value and s->object_size is not aligned
to it, each object ends up with some unused space because of alignment.
If this wasted space is big enough, we can use it to store the
slabobj_ext metadata instead of wasting it.

On my system, this happens with caches like kmem_cache, mm_struct, pid,
task_struct, sighand_cache, xfs_inode, and others.

To place the slabobj_ext metadata within each object, the existing
slab_obj_ext() logic can still be used by setting:

  - slab->obj_exts = slab_address(slab) + (slabobj_ext offset)
  - stride = s->size

slab_obj_ext() doesn't need know where the metadata is stored,
so this method works without adding extra overhead to slab_obj_ext().

A good example benefiting from this optimization is xfs_inode
(object_size: 992, align: 64). To measure memory savings, 2 millions of
files were created on XFS.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating ~2.64M directories on xfs):
  Slab:            5175976 kB
  SReclaimable:    3837524 kB
  SUnreclaim:      1338452 kB

After patch (creating ~2.64M directories on xfs):
  Slab:            5152912 kB
  SReclaimable:    3838568 kB
  SUnreclaim:      1314344 kB (-23.54 MiB)

Enjoy the memory savings!

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h |  9 +++++
 mm/slab_common.c     |  6 ++-
 mm/slub.c            | 89 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 93 insertions(+), 11 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4554c04a9bd7..da512d9ab1a0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -59,6 +59,9 @@ enum _slab_flag_bits {
 	_SLAB_CMPXCHG_DOUBLE,
 #ifdef CONFIG_SLAB_OBJ_EXT
 	_SLAB_NO_OBJ_EXT,
+#endif
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	_SLAB_OBJ_EXT_IN_OBJ,
 #endif
 	_SLAB_FLAGS_LAST_BIT
 };
@@ -244,6 +247,12 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
+#else
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab_common.c b/mm/slab_common.c
index aed91fd6fd10..7418719b5ebf 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
 struct kmem_cache *kmem_cache;
 
 /*
- * Set of flags that will prevent slab merging
+ * Set of flags that will prevent slab merging.
+ * Any flag that adds per-object metadata should be included,
+ * since slab merging can update s->inuse that affects the metadata layout.
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE)
+		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
diff --git a/mm/slub.c b/mm/slub.c
index 2b76f352c3b0..ba15df4ca417 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -975,6 +975,40 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 {
 	return false;
 }
+
+#endif
+
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
+{
+	return obj_exts_in_slab(s, slab) &&
+	       (slab_get_stride(slab) == s->size);
+}
+
+static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	unsigned int offset = get_info_end(s);
+
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
+		offset += sizeof(struct track) * 2;
+
+	if (slub_debug_orig_size(s))
+		offset += sizeof(unsigned long);
+
+	offset += kasan_metadata_size(s, false);
+
+	return offset;
+}
+#else
+static inline bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1275,6 +1309,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s, slab))
+		off += sizeof(struct slabobj_ext);
+
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
@@ -1456,8 +1493,11 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  *     between metadata and the next object, independent of alignment.
  *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
  * [Final alignment padding]
- *   - Any bytes added by ALIGN(size, s->align) to reach s->size.
- *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
+ *   - Bytes added by ALIGN(size, s->align) to reach s->size.
+ *   - When the padding is large enough, it can be used to store
+ *     struct slabobj_ext for accounting metadata (obj_exts_in_object()).
+ *   - The remaining bytes (if any) are filled with 0x5a (POISON_INUSE)
+ *     when SLAB_POISON is set.
  *
  * Notes:
  * - Redzones are filled by init_object() with SLUB_RED_ACTIVE/INACTIVE.
@@ -1488,6 +1528,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s, slab))
+		off += sizeof(struct slabobj_ext);
+
 	if (size_from_object(s) == off)
 		return 1;
 
@@ -1513,7 +1556,7 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	length = slab_size(slab);
 	end = start + length;
 
-	if (obj_exts_in_slab(s, slab)) {
+	if (obj_exts_in_slab(s, slab) && !obj_exts_in_object(s, slab)) {
 		remainder = length;
 		remainder -= obj_exts_offset_in_slab(s, slab);
 		remainder -= obj_exts_size_in_slab(slab);
@@ -2340,6 +2383,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 			obj_exts |= MEMCG_DATA_OBJEXTS;
 		slab->obj_exts = obj_exts;
 		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
+		unsigned int offset = obj_exts_offset_in_object(s);
+
+		obj_exts = (unsigned long)slab_address(slab);
+		obj_exts += s->red_left_pad;
+		obj_exts += offset;
+
+		get_slab_obj_exts(obj_exts);
+		for_each_object(addr, s, slab_address(slab), slab->objects)
+			memset(kasan_reset_tag(addr) + offset, 0,
+			       sizeof(struct slabobj_ext));
+		put_slab_obj_exts(obj_exts);
+
+		if (IS_ENABLED(CONFIG_MEMCG))
+			obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab->obj_exts = obj_exts;
+		slab_set_stride(slab, s->size);
 	}
 }
 
@@ -6948,8 +7008,10 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
-static inline size_t slab_ksize(const struct kmem_cache *s)
+static inline size_t slab_ksize(struct slab *slab)
 {
+	struct kmem_cache *s = slab->slab_cache;
+
 #ifdef CONFIG_SLUB_DEBUG
 	/*
 	 * Debugging requires use of the padding between object
@@ -6962,11 +7024,13 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
 		return s->object_size;
 	/*
 	 * If we have the need to store the freelist pointer
-	 * back there or track user information then we can
+	 * or any other metadata back there then we can
 	 * only use the space before that information.
 	 */
 	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
 		return s->inuse;
+	else if (obj_exts_in_object(s, slab))
+		return s->inuse;
 	/*
 	 * Else we can use all the padding etc for the allocation
 	 */
@@ -6987,8 +7051,8 @@ static inline size_t slab_ksize(const struct kmem_cache *s)
  */
 size_t __ksize(const void *object)
 {
-	const struct page *page;
-	const struct slab *slab;
+	struct page *page;
+	struct slab *slab;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return 0;
@@ -7007,7 +7071,7 @@ size_t __ksize(const void *object)
 	skip_orig_size_check(slab->slab_cache, object);
 #endif
 
-	return slab_ksize(slab->slab_cache);
+	return slab_ksize(slab);
 }
 
 size_t ksize(const void *objp)
@@ -8119,6 +8183,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
+	unsigned int aligned_size;
 	unsigned int order;
 
 	/*
@@ -8228,7 +8293,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	 * offset 0. In order to align the objects we have to simply size
 	 * each object to conform to the alignment.
 	 */
-	size = ALIGN(size, s->align);
+	aligned_size = ALIGN(size, s->align);
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	if (aligned_size - size >= sizeof(struct slabobj_ext))
+		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
+#endif
+	size = aligned_size;
+
 	s->size = size;
 	s->reciprocal_size = reciprocal_value(size);
 	order = calculate_order(size);
-- 
2.43.0


