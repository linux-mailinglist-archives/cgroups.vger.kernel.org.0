Return-Path: <cgroups+bounces-11792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBAC4B879
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168473A7567
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 05:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBB27FB3C;
	Tue, 11 Nov 2025 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nz0uZ+qM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rc/c12gZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED7237A4F;
	Tue, 11 Nov 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838496; cv=fail; b=TzAPWnAIUrhcUR0Wc8Ylt4CTHjKHTjL8l1oDa3dUJ2AeCT5QEfi3/alSIGI0Sk7EdKYiBeYJkYabM12+19kHeHZX7xVVJ4tAChCFrz1dCmbM8JrIDRpLejE0G1V3/GT+pTJUze/i89hzA97xo8RftoNxpGhVEq4zpjMPSCYaL1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838496; c=relaxed/simple;
	bh=26+ckbfjiHOHJO6raZ9tK1kD6xqRSQx6nmFX8/Ko4H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mGZp2OuX5gnYR4wQ27I/6RM8hWzo4Lr2uxuu7Awtak/kPWrk+c8QX/LiaSWeAus9cFCfA1TR3ZHNqbRvQG4eUvi7QN8IznQh+OWrxdmVhbNWsOrKKHOdFyIACNIJc3IGptD813h30/wO/YUgMWdR7V0YKe7EWLztukrpdRLPmEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nz0uZ+qM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rc/c12gZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4t2AW029069;
	Tue, 11 Nov 2025 05:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jQkp5QfWzBb8d2tL4T
	nKbVMTZHfIFh4Fw9kVu3f2Jpo=; b=nz0uZ+qMP1j6bZCGb2KmthPzla0z7p6JD7
	rp8GScgq8dF1A6dt8oTtuJRNvXko62i19yNC5IbqMfpE3rgoSvCcySWAScQf2TWd
	EzqzWlYk0C22HA4fbA4zEgIf1p/vDKVYQDe5YAPT55al3/H6c6MxRSqy8+mm1iJ5
	82C3ZoOM7UsMu0lng85vssAHWgF+WZPz0jywwMnmABFas444f4FFTCX63gtyGXXg
	baQsEitq2sqvbRk9HgWbY7KJ2/qkuukDo4Bekt1Q5pdd5IpRMnP9RdxgVg41PwKN
	xQSTWUybGbbwSTlemIplmHIUJQAPj3UxG2YShkY+wGKeFnuq+L3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abxhqg1hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 05:21:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2Ca9r040864;
	Tue, 11 Nov 2025 05:21:21 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va92f9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 05:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4imBGngwpMGEEDnZ92cQb+kjDqM7V0K14Cy4rCoHhUhgsk498pCzyBsDPJ7hcdDUT0+AZ5ToaOg47Ie7FyfTbwOw9lXMK3Bm9AnHnZ+QP3evwRrbi0wlpp25qT/ETzmMFtaCOIv8d/FMyKGdsABA39IObAJlfpPtIuu+6q6x2hBdoFjWX2HoLKNZFWKTj3HWgNMD3p8otvprOJPHlAocM9HnMsQgJ6SEpiBtYRL+BlIj4GAlfauD/TUGOSc8tgBHrVqF/Z5TlP9hJvTGPs4xIv57H9RkSHI/kEbpNCDy8I4OPRyNiJ0BeJ8vr+Drlq7ewk22tvpmnrR6U1ceQMiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQkp5QfWzBb8d2tL4TnKbVMTZHfIFh4Fw9kVu3f2Jpo=;
 b=htb6m7PgWV/lRCP5yRIPE4R0CqKbbb8+QV8MM5+pDzqQ99TjU7U/IQHcfu8oqwsICb2hHmDH/QdJWV0mnZlINtjVb+nkHtB1mDC1uInZQc4yKoGSsOHUshOdQzFev+T0JIaOjllF0tKS3sjuVbTVDYpfC3hIgFOZ4jsLriufAJGZakBtfZLUCy9gCTkk+ECNHNN2PeP0057OgYEUd3kwymx5N/jJA1tzliq0Wkttg0c52zdmQKIGJsjjykFXvF6WbpG89S4OZAewRPe9nhiiy/C81k358yvao9SKfS8eQYD3Tr6DZ4+iA2VD2+Eo17WJkhYCGUpwgYnJbPSBHLTlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQkp5QfWzBb8d2tL4TnKbVMTZHfIFh4Fw9kVu3f2Jpo=;
 b=Rc/c12gZ81ZZ/EZ7hK3HlilvMydHHQB9biQtxmzeKaZz/sTnspIU24G9nBngFrROU7G9mvpjHd8cRaX+gt5TftjZrRLs7bh3uBHtj6Is88tsPqJqrlxTei7N6+k44CHMGdJX+MhD6uvsn+BIBjCq+lSjJsN8KT0afOL57EpLghM=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 IA1PR10MB8210.namprd10.prod.outlook.com (2603:10b6:208:463::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Tue, 11 Nov
 2025 05:21:18 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:21:18 +0000
Date: Tue, 11 Nov 2025 14:21:09 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 3/4] memcg: remove __mod_lruvec_state
Message-ID: <aRLHxZo1K7damagn@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110232008.1352063-4-shakeel.butt@linux.dev>
X-ClientProxiedBy: SE2P216CA0053.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|IA1PR10MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: d506ded3-81b1-4c7d-ac73-08de20e223ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoT1yDdcUQfO9PIODwF0v6ju+xaMq62MQq0kgwT6Mqb8QNHtgfF6F2Y53YAI?=
 =?us-ascii?Q?H66+joC/PgnTeCEAl+sbphfW0bMdAUwj8mtUH2kK4e+XJersiRoKbP5UQ8SV?=
 =?us-ascii?Q?O8S//mbhbHu+IKSNxY/62sH4iJaY/tCUfUhzWrYyCcQAW5Cts1vcGum7FZ6T?=
 =?us-ascii?Q?xFklxawhRt0F1jdQT1+d0N6QVqgXAlMmxDhWEdXeBf0EAYuoZGOHnqWGU3jR?=
 =?us-ascii?Q?dA7BB8Fk50bRhkntm2jpL9IkC1DDLxbVdG/ZOPUNPYWIqfo/5f5xR0ykSfyE?=
 =?us-ascii?Q?Gh1/pUBBqui4O3PtVTPdFVjSjCJwqp/1VDiW5bmTsTu1fYJ6tdHRDg6mii+M?=
 =?us-ascii?Q?17FXY7nrDSvAMaOa8XX3p2n17UDnfIUy6fw/skfQY3ZRzwhO8xVpFTV0t5/X?=
 =?us-ascii?Q?txwtpAspZ9aw/ErQSXRTq7bUaUATazmK8MoLprWUuN3R2eXl3w0O+9N7sPK6?=
 =?us-ascii?Q?EKmjeJ0KoITnReWFBta5XUaRJkMaahBoD4fTEHcDoLPqauKAvQcL0X5oLitD?=
 =?us-ascii?Q?48TqNDW/SbX05tJvvuFN5nImSQ9mTD+KZ3RbmhsHnNy6GQ3CBcb9F65ELklN?=
 =?us-ascii?Q?lvzJcy6GrdfcwHnr7blcsa7ZI3MGJva6uXkk0jdrevkY+4SFftjYlpb9EUPh?=
 =?us-ascii?Q?U6dd2ovyCx4XVW4boXhak2H36hIyBZOn8F3jvpLrVEzA4P2wyi43QgyG86U/?=
 =?us-ascii?Q?ABaKlv+Mhqs6KbjxJCf8WywliSy5jC5oDG1Y9wBoXvfthv4nLC9AuF8/9DRG?=
 =?us-ascii?Q?SWlClCYhJcLDPipKtq9+KVF+WMmJOReQaoLScrLtJ4qSEqHGdtmJqyh59SQR?=
 =?us-ascii?Q?MY5mz66W18Yzcn5S0VNf8j52k3hzuc93r9YI6nJBz70tT1Kyj5cGLDtP03kf?=
 =?us-ascii?Q?5RTHJ0fy8XHpYtEm4Wf32SP5RnJlBrlVH5HUnCtlbwnI+67r5Dj1BHk5EBTD?=
 =?us-ascii?Q?dF3fJ/BIsOWIz8W0XCXWAEn9Q9DdarghJzLaQTwOb8wxKwy6Jojr1R5vS5wb?=
 =?us-ascii?Q?8qDJvyeaWH1Gh72HfpzxsfSXwshmYhNQCpRYnz88JNirnzAQVffrgWsUczZY?=
 =?us-ascii?Q?qx5SY8YGHwiJaYtOUNS40VlykPNK/h8AXHF27y15nPrMwPBz2sjouQF/iojd?=
 =?us-ascii?Q?MnQJBU5ne8P6Pu1qqTJbwd1R4Q8eitRRJLUT1PkrZ8/y+D12ZLXBpZHlTSYn?=
 =?us-ascii?Q?Dg+boUakIXb1VQqQnYGv5h2n8iZMOxuEEFrRcQN1UQ4IIm7+GAseGU8RwheT?=
 =?us-ascii?Q?Uz0m/bhuIyi9jrA/EfixoiD5d4njzPNuaj9m8d+0vFn9d7neLbH9ugjA8Okz?=
 =?us-ascii?Q?ly7fKMasrI7WewOntC3sfCO7fXGExvbtfimJTs09sp9UyJdq9TZ9CtrLxd20?=
 =?us-ascii?Q?6skAjGiQr3dfE70m88w9+UBW/HIrxi9JsAmgHj/wqHgEdZQIn7SL4wonXUP9?=
 =?us-ascii?Q?pJUY8Zd3q69qMvlMOop0YYBpbGKnkphP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWXnK35gPPwXv7HdG348MHk76YvWFq6NnAbWFD4AVRgXJfW4fVilMIpISbsI?=
 =?us-ascii?Q?qPFEbA3d3pzNgO1QUicsUoT++uS/00tiDsQoQNM25NZWtr4/5i0yLLbsGlw3?=
 =?us-ascii?Q?6HZ2BTeNs7Nz9ZYNl3Ngqkv4MZGKi3PSRvxiKO5EZOEegl5dOPfLXuUk+R5Q?=
 =?us-ascii?Q?u2bRhkryKp42g0kc8jr1dTIMmQJp1fU1H+tYDLegRwPe2zJAE+lkK+MP7rx8?=
 =?us-ascii?Q?+npMaRYIrY1zcApaBQQCXSO5DPge+bZ19zlZO373t/rGrXqif9JxMpYvFwkD?=
 =?us-ascii?Q?Hbz0NPax0TRnvsDd/z5QRxMEuEci09Fvzg0dRy6Anp0FsFdfsjRIGLi96Pih?=
 =?us-ascii?Q?t6XooZBLfr7eY31MO4DmqbWiY1uBidTDDOj3ApyNjUBa89MsTr/4sb+lZIXO?=
 =?us-ascii?Q?3oAv77t7XdKFYAuZeCBNWvDhEFvhCspe7It2H/hOigEZckqtEX27UR/oW0oz?=
 =?us-ascii?Q?J58k/imSECa9b0MmJwOcBTS5sG0lsPAVMsQKMMBGwPqLYV8JnCiKBreFSYxE?=
 =?us-ascii?Q?H4YSCcIT/OaT68etI7Ql1/MqDtVFszsqhavFZIPIFHeqzMWjdh899OloCo5/?=
 =?us-ascii?Q?w3xQWN+ul2fQXaQqybIco3F1/XfEFfPxnAo2n1n7c66c1Mee5NCZbqTF6h2r?=
 =?us-ascii?Q?yH3Jr5+lZQ8z9njFF+JCOQLTFoIIWYQicwVjP/Vqp1L18xKielfnKmRk4b6K?=
 =?us-ascii?Q?Yn3x0IZwhjoJ7jqhU3qPI5a66T7jWAaT8AOZk5xI4u54Hre3KDnxdpqGJ8+h?=
 =?us-ascii?Q?1ga1Qq06TNaiKtCCe7a82FxQ1QmC78PyrbS3LGcP1wOBKS1gx+4IUvLMF2+5?=
 =?us-ascii?Q?oiRzg36R24Ga/NriCwrsATyUMdM1tk2tr/ZkyctB9VKKNT5B1mzqOQCYAnor?=
 =?us-ascii?Q?wzs5TsoeFBfx4XJehR5KCBABKsg4jbsqSm79d1R15AZzpK6JhxTa4Q7gZbry?=
 =?us-ascii?Q?k44gzgo0RkT/Pju0TUBOUqW6o1FC+5OEzTohPt6JhFXk2glWmMvLovRBRZZg?=
 =?us-ascii?Q?Wbn6jrF1VgKvbTFltt4XFSTiSm4YZX3Hg2Vmwc5P8TimXzcoiGpQ67YQooWZ?=
 =?us-ascii?Q?hXI+e5l3iPRx9pZVEq1H/8BWcomnXS3Z/7oLdH+MJ7KwF8hdOqtDynGylI2N?=
 =?us-ascii?Q?l8ZAwVXBCJ5TbgouBEcQyg7JVQstN5WmbSfYEx6wDe4qEFJJT+uB/LAQ5P3s?=
 =?us-ascii?Q?7WRalKn2MqbmOurqeWyGIX1DBp3Nk2LIjTbpxsLw+MIJzsp8W7VTeE9Pnigm?=
 =?us-ascii?Q?1bxPDJ+vX6PtF1m9p0AZ2OMpqgtO5mKyrVj0fLSOcHN6p9lcOIaAXCH3xnrB?=
 =?us-ascii?Q?Yu2iD6ylqdvi9BCOS1xB2E0SuOBXAnr6vMPqqkKhkgWkvDBlajc8i5k+go+r?=
 =?us-ascii?Q?DqeuS2Y52tMgOB3PaWvnEnF4PMNJEi+MHHvW4loq9tHp+HM13VrKehPfbgBi?=
 =?us-ascii?Q?n7jJFIV0xoHVhd5rZoHUaTxHrCNozLW2imPlEDF5fgpvqfSrYHeT8fUcR+a6?=
 =?us-ascii?Q?dr0cqDAJI9SIC/ouVoHshPBGz6hemS3bPWmkqXMWh8spQnVFlIxGeb465A+l?=
 =?us-ascii?Q?0I4eSnuA5KlC3GTbes8kB9FciNK1RiHfNyOj3HXt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	687HQAX9dP8wVgkrOiPmdqiFXiAsLex3js8OMYTNoaNoha6X5Z3GZDs6o2Bg4cC1ZAKYLbG5ArunpulWVCJ0xLimbIGSVWZfXdD1PDQGBOayTmFP8O1tAxtzqDCXHZcqYxByMsGLumVBZtUTevZK9PvMHhFhPEaoDcDmDSbu7sHCt5v7NUtr+rzUu8zf0JKSqCAN1igwsruNI9n7K07LV34qwco0a+tyeXav8Of3y/Eo+0ioh15+ZVyQ2zBBR6rdu1fhw47EHNAWmYqsSp00NlVyLFAf5lihaXbO4RYkHWkPe0nv1pBhzY80W5XUGRj5XcZwC3EddwI6OL3J3kk7f5zsNrE/12C5nq1Jwy7qY8EW4LpjOkYueYnTJNwq54DP51dZ0XKJTmSip0s6RZAcyc6NvDDh1T+4Ix9iCHEbrFRt/i5RVj62icsUZGpEwFBG+7zztLcb1JhO/O4GDxmoAwHaxrbcfKea7miOJkHggPKqN5+lJ5YyMTGczZiq4q4+DXI3/QpfqYw55XKHg8LLMw/Ibb7KiqDVV91X/6G6D1elmBBmkRALWCh3am4BgEUKGuaya9r+93zncUhIIOe/R1nzVFKRGMZz8zgvik1a130=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d506ded3-81b1-4c7d-ac73-08de20e223ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:21:18.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPEF/wIgNIkvq3KI64DYSsfvFGMfO87ZlBrvXRO/wfaeRVNKZiXvyRE0qNmr857+DdykPyGIdaP8yH/hhJXmWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110038
X-Authority-Analysis: v=2.4 cv=VPPQXtPX c=1 sm=1 tr=0 ts=6912c7d2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=s2KlgTw7U1jQNQ_BAaEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: m2l7H4oGqZ8sxwryzXHM8LbTcA_puDkr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAzNSBTYWx0ZWRfXzMUuUGIIFPsg
 NGvqLEbrWQkCgFtQnvH0OeK6gwDChZk2dNvMIePbk5bu1epRYLZPw1SGKR6AImR01W2j0CUpFF1
 xI39130I+s8O7we7gANttuj1CybkoH8n4VMyu1XWHP6Y4q9pGZnHQAHPB96Y44PIcMlwaNcOz8E
 7EI/MUGRK4vBF9UOYihp2SSiCKf4UCvDO7JXy0l0zFlfd9f1+tLPSbuCVxLoSXDSm92uz1zc5UZ
 XhuPfVh+btSoMzHS47imnQYPeRYSZEGdbxnWYEd8FUk/IVjVhnhAXZFJLlKJaLlT4042nh8l3wv
 jJ0KcMpeibJEgeRyQl05v06dhY0S5O4WWXST4Eoxeu44jBwQoqD6VFu+4zc6zZli9nxUb4stuOs
 c0SGOSaZhBlGtV0ujZWxf4ATsQgzkA==
X-Proofpoint-GUID: m2l7H4oGqZ8sxwryzXHM8LbTcA_puDkr

On Mon, Nov 10, 2025 at 03:20:07PM -0800, Shakeel Butt wrote:
> The __mod_lruvec_state is already safe against irqs, so there is no
> need to have a separate interface (i.e. mod_lruvec_state) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __mod_lruvec_state to mod_lruvec_state.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

