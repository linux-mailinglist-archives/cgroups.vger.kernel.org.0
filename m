Return-Path: <cgroups+bounces-8123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AAFAB219B
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 09:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100E64C1952
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 07:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6851E51EF;
	Sat, 10 May 2025 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMmH2IO9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ilRdZ36g"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CE1D63E1;
	Sat, 10 May 2025 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746860512; cv=fail; b=HLG5xPmzkIUnyhzOD0qLbkt9gQhsoItvnjnzqeT8VEtoTGOBQOBNRt2l+0NjWRU03hbrEUyueEyxTpAknogYtoGsTodsPut/QSer79bl6+i0z+khK7heywhO6vqdrokDgDBbP/RN8EKU8s72kNn6vru93gqI/7BCBO6W6iQGXdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746860512; c=relaxed/simple;
	bh=kh2TIei8JszaoIqba77vmmdevMFAFw2Dz1yBxgbvAQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rBl70pSzI88ne62s0vAJZYtEjTES8XOSXgU/RDocJYDYC2n/ruOUYNG81I2a10edREx5lbj1qLSQito2x1nifr9dyNkz6bPIy6KYX8CQ7sIHYZLk63DCcPo8S6qf8OpDKUhmqOOeIQ4HbKsnCGV5DlqoxfUUZZOt7XItZGeLZZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMmH2IO9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ilRdZ36g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54A62w14001905;
	Sat, 10 May 2025 07:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dtpGPOKdgnk2XKIp0Q
	6wQqVJkEMM2a689GyauH1wiPQ=; b=HMmH2IO9gFXuFb/opA5Hu1IfY+a00EnjdX
	RwFeGoeCBrtrbhgTk6NLyHGYTwVoM40M5JQyoqSVUPN0Vq92lJmID0SCEHNl6Q7s
	wtXWZYQiF/W0II+b50Z1zizkurd32J7R4JbOp9b2r1cbiUTl+jYlV4c8/oI0Y0GW
	2L5LEOxKetG6y29NfJ3Oe5gUS+H3bv1HYBYuLHgL25MgCNmTaIht0X1lh+JVZtpJ
	AxCuEFzluITW40sAKXJTU9SiryngI4izTJEh2Zpcitq5sboGMCvi5NrjQA2oEacA
	XZiSjyJ0WNJP+LxEoRuvx1b34QfbDqJIxjA3nmn9hX8UvQgkiXbw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16600yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 07:01:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54A6dCAs037448;
	Sat, 10 May 2025 07:01:07 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw85vbnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 May 2025 07:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwXECtgtSXFIXNSZaSYSLyIV+Ar3i2KWEzVdP/jNr9fI94fjWo6S+e1lE/QlMZMfPfwFOaWJCr3TCyVFr7JNGAnzxQHz3PIiVBm61ZLSVu6s6D0vECEm7ST4EallgNkiS+iP7KHRpVV7q8qfNtSgF+LFk3eJ1thEyzEMRDXnnhMZ6nnf84RKKqU7LPWKspVBn5tUn3dmhQpY3ehfS+lBRaEHn2B9J6FlXtwpY2Q4JdUlend6s5onTcylvpwvMiYBEXwd/1suLA0/DK2kqxhQU7veuUGkMI3N9ZnOiPaDma2GPQDVKG3f+8/j83syS44xkh2dKLlkeQbyQBpcGqmgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtpGPOKdgnk2XKIp0Q6wQqVJkEMM2a689GyauH1wiPQ=;
 b=sQoT0GOQ1dnKUqreMAsWHKjoe/jDA1ORv0UMd8E81h8rscOHowlrRusofpp5Y7qAWeTSe4rN4QWWzo59zBZus3csoJmI8p5QujuGU9DMhctuwEzkw8ayfrBKfCo0QplIFj/V3OfopAvzjO6fHIH4xdIUpoDrWDNCCAbSFRobJr3blpsSNOUGE4Esnah9MiMRdoVEGsdCb/ZyFn4y4GyxaL/UwT2nJbBqR3W21sPNHEy62dIE66FObXZ5QzNhcy48iK+ezM9ZZn+rkIoK8gCyVZ++ET7z/R94mkG8pisqSYQ1e/koF+0z4B/eWr+cykwOTKF2kYoVx68FsyQWpkdb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtpGPOKdgnk2XKIp0Q6wQqVJkEMM2a689GyauH1wiPQ=;
 b=ilRdZ36gOBsbSsHZ1E9jDUYJPlpeN0VItRVYrULGmA5pcp8mQUhOkibh5WYs32zt6oh70djouTt4csNMnI6xn/zpHRCMse/jNzRssFuLQ1Atx1H6HTxHL9/v78HiVoNH/ZAVvEqm6KS24Vi1jilcjDr1t2xzkwldGpsU9lOp8aQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sat, 10 May
 2025 07:01:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8722.021; Sat, 10 May 2025
 07:01:04 +0000
Date: Sat, 10 May 2025 16:00:57 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Alexei Starovoitov <ast@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <aB75qf4hAccygyCV@hyeyoo>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <20250509182632.8ab2ba932ca5e0f867d21fc2@linux-foundation.org>
 <xe443fcnpjf4nozjuzx2lzwjqkhzhkualcwxk4f5y6e5v7d7vl@h47t3oz3ippf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xe443fcnpjf4nozjuzx2lzwjqkhzhkualcwxk4f5y6e5v7d7vl@h47t3oz3ippf>
X-ClientProxiedBy: SL2P216CA0177.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 194fc667-8d8b-4fb0-71fe-08dd8f906dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OS1DoyT3PLJD7nizPZHOj0huTKAtcm0RKAj2SOYoR6jMndajSseQMg7SUWvS?=
 =?us-ascii?Q?39J/AkvjaCZh2Sx3uT+MdebKyIMDlK2GVT05mIlDzqObBlq/T/eFoGWv7+t5?=
 =?us-ascii?Q?31YZdHzGEwoZLDBU1Rd+k4nwLJt+PnNOENK9xnN8SFZAjPlTeMdZXctxIkUf?=
 =?us-ascii?Q?hIANpTacEgQD2seDZ2Ph0PuzDuK9r5OqztSXcnxW+MjdbReOyPRL7P+g+0NT?=
 =?us-ascii?Q?5tTJlORewa06WgayJW+C2rpiN0rb+EX1HZJDXrd3RMYmzIH7L6EuvYOZKwLb?=
 =?us-ascii?Q?Ert+AWwixLFWkSSrlshNhlFOR1hHUahLl9lcHZpzEamxnooP6tU68QRMBp/Q?=
 =?us-ascii?Q?be0LqZuDaZdoqogZ83hkFZgaRlUgygsqSYg//W56d/wyWsvRvFV1oQ3oErUu?=
 =?us-ascii?Q?wGpalC21Y/yb0M6VDztsUypF6dtVp7jKXrbRWv7A3V8M8x04zil1tYV336Dt?=
 =?us-ascii?Q?Ntt3/PxYvEOGgrlOF36emp6daOjgkzvbM0jCnJDzWQ7cHJe7+P8gMARZCu6s?=
 =?us-ascii?Q?3HMhPNs3gNvThrOYkGr40QhYjRh3RuO4E1YCPzDcWHEaaYNTEZK73PeM0cL2?=
 =?us-ascii?Q?tg6OMN6YEiIGqNfqlVRh4tBM2VLCzaGw2bTzJMw96/Jxz5qapCPGIAw74D1F?=
 =?us-ascii?Q?kMKW9EBG8hVqDQSry9kxpKK2N5JGJTgNsit0n+mRabyEE36eoXVUAgOM0lIN?=
 =?us-ascii?Q?6LoO0oM5ch7Gp8ncrGLaSXnEndmvEmzAkP6P/xXfDGG4CI/euc9g1blIPJn0?=
 =?us-ascii?Q?zQFH4Zl9bQdZtDpc/hJZt6VHyedXWGMgLgImuZ2+sksOwBL+ArIblr0upmOf?=
 =?us-ascii?Q?zbCn2V+IXGpYNqmiBBOTs4Qi+IrJcKD5lTzQrhIbcIDZMQAPzjXaSvhAHU1E?=
 =?us-ascii?Q?593Ucpaiq5j541Zga/dE1hPd9R63PFadDGtd4xH5yFkV3DiUaMsOendQe9Cm?=
 =?us-ascii?Q?+j9bEFVK7wD2LgUn84nJSVnH4TJPAFNYQOEcTSY+uxAJHq1gUYFbEnr20cLk?=
 =?us-ascii?Q?vSrBQJqx8/pzVcVVbpFzfTO7YsfTNvse2a9ana1U/g7BpE+PveTWXHLVf65G?=
 =?us-ascii?Q?wPKhSAD8AY2xrJW8sitICQ8eBQ6ct2Uhgmu2lvIjMllIwhDU9pZ09SJI1wUQ?=
 =?us-ascii?Q?9XHID9/4EZLUNxJQB/upcRHWaqcpeEXa4zoxUb1BoPoL3f8uZHTt+T5bEFLt?=
 =?us-ascii?Q?zgA88yF6R62/Raolq6iyfNHdGQYldEI3Mg8V7CmkM2TSJ9lGrSDzh12AXKqs?=
 =?us-ascii?Q?5u7OgzyXyrdEZdziXhkNRGxPLtLlG/al+8sDpRKkTtLn0SUduThCjloiPpCK?=
 =?us-ascii?Q?nzvX2o7LRgpgWDHnvp7R/eAj7xTujJTbtH7Y4kJOXL80RQSaB12jDHWRAC9I?=
 =?us-ascii?Q?aP0f6iNRr3PDl5z8YFSYvfJxnFLy8kMo4PopnvyCtijUIEcPa72TqaAp2f4F?=
 =?us-ascii?Q?8dPzLB/IL8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbjIsvXcc/BF6Wu56uJfTFl8HRLJYozRyInqcRWut7F+iDDA+x/L3KqpxDUf?=
 =?us-ascii?Q?qKxSjsjtrza387jrd7tTZGIWtrVzd2+SrDE64yQ5MrDzxBJo8teTcl/3O8qo?=
 =?us-ascii?Q?hr//xoldfYCG/ueNicnAiYijov3sin6VdfP0QDUpCjF9veIn+rNCzO9X5l1q?=
 =?us-ascii?Q?eSZCh+gDvta8eZwi+IEyFWAoDj9xxpskWtumZojpwHHu4LCnGAYojSbhpOwi?=
 =?us-ascii?Q?r3GxWSnO39Qz4XIJvUGL4A8XSYSMSgDcjBIugGgRmqsbnnNTMUQvhXXm//D+?=
 =?us-ascii?Q?bP+LlL+dH4B4jJGifNSWzvmXYO8K7y0TcgEZhVlUDeCINk5NIY4wjol0KV2T?=
 =?us-ascii?Q?9iNpcoeNSHmeo2HDuR6Th299ruxRbo0O+tgOyAxJKTYCOh4otOPsdAjsIq2z?=
 =?us-ascii?Q?8B9rSH5nvsNuIWKZIXuwKBUWc/1o8CQam6b/qxqpV5KGOnJPhBk2NHL3rqL0?=
 =?us-ascii?Q?3OsNam7DjCP93mjUgzQir0s6Q3tv716o+caiYNhvt/XeXgx05b/EzhGeK7gx?=
 =?us-ascii?Q?N/JorpiPN/qyUrMs/EFgDM+xTcfKgb15H0YERotW57swv9Zge8FpgmoZKxdZ?=
 =?us-ascii?Q?cMwWJwhuozVctKhpj/4zaFQPCNy3FbulI1QV8qCYDWIPOHj0GpgM46EvBagl?=
 =?us-ascii?Q?HHVXxUz7WnxPxTg90I333pSJ+qHeEL6ldjojf0JxbOFqdnIFDTS3B3nlMhAM?=
 =?us-ascii?Q?7RBiXvdd2pSRy+e0hEGMDoSKGZ4Ko4YLUG6BPxsfZTYeBdtnHVT83btRex9k?=
 =?us-ascii?Q?+RWM7QpOTYqxjHDT5xZznAxbTWAA55oGJNzXFfHTdRxS4CJ8WxSZ4qsJiqcQ?=
 =?us-ascii?Q?XP3+R4V+JIYa/hFDgf7yH8gccE+Yr9Gg0hj6ZC5bv0HL3uOuOTqitp4lyB93?=
 =?us-ascii?Q?a3UChSpjDOiYB2tuzDdCTNywsISGNmB198Z15MaDv3js8DAHigPt5yzYvsqe?=
 =?us-ascii?Q?/m/hFiZT8NLjwVGQ6vLjlDC9z8Gi/1pZxxG4JYSkff7uAeCWcxdrXiNpy+w4?=
 =?us-ascii?Q?6Fr5taeq/sDBzM2Hm9vJd0f66vaK0uB63mYtoDxQEsj+Ilfd11IJN3DGvvWH?=
 =?us-ascii?Q?hEjoR8stgJIs4by8/mYm6waE7Igrm46Bd0YTU160UgZiZCA/wXWEz7O6PyZR?=
 =?us-ascii?Q?f4IS6BFFouWMzuUfncGJjQqTxV3iumKON6SAR/Dz7Fje7QD2RRveD1fOr58w?=
 =?us-ascii?Q?B2nPUCQ4bV8w8CIxHOPfJZoMfr1CE4noe6w4bKt1ysSUs9IJk2M35ndPjyK1?=
 =?us-ascii?Q?mGs7VPbcTNdgrC4BvDIuumaPx+deiWa3X5j4QRtYa1Paulf7K5Ys1JCFRk0d?=
 =?us-ascii?Q?NWS6duP68UieWFz4otASGaeTE1+YH9/FSclCBE3JSr2R6QGEO2P0rOuyI6MG?=
 =?us-ascii?Q?mbqObWHIV/4xTqd6cvz5Q6EIGOq/OyVYsp8KwuYK76csuNXCSk0QDpugqsoH?=
 =?us-ascii?Q?/UYBJaaSodv4ZH4tG+IGmJ76S81uMRq9RRkUUiLbzMf00fbs7+i5L42jLxja?=
 =?us-ascii?Q?KzO9msS/logpBbYeJl95R90hrS5NWsWgj05lSn4G6SobwvyvGhjMlKJt1Q+F?=
 =?us-ascii?Q?fS1fOIRFBtuy1hq4QFfPogzwDUWx05OnslKOn8i4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u3A20DBza+t0vdUoW4GBynra/WKAB4ZPQFae49WktIGYRlRr/ailI164KMwfkASCXyJHliKEkQ/OrwaROpJt2+zqXDN/TuGkn3kPBbcyDBsv9kPZN6vekwJkKB0TTrb40dTrWirHeHC9L7ASEHRdoIMe0tGHvC04+I8Av5495ikOzhjns6hCpguPclpDgzzJ5FSUFgG9jXQxCSITxvhoe7VzPjCn+b5D3FkO/Spo4h+Om+5ZThcgWfpcLoLYkMqz34FUsW6G1nej8lavx+cacAvXTEgwWOC2pHsc4WkdnCiPps+E4zR3Nfx0iu6fR9ZlbFaeCaeUepvlsE09Mw+Sqn65uh6Ulz5Md4Idd0LG/rfJPd4pJtrCqkSW+hYWKEdKHl5wh2BAga8uT7ZVugKmcZ1A4Lta9RxAkZR1yU4iGL/GwcD6CyC+PC1Ai7FDTkxGESD6RDWDy2a+laYjr5FslRUfiDaTbZCZTG7635btjXdwoG4CFaNspZTTHOKebHAKvkAFZw27jJg8kzy1PRagzyBqNSI1uIgHPCMy8np7AWQ/cFY0Yd3sxzMtg5KLpL/wunYx67wD9Bjun8c20KjY1ffn9eQ2ZU5OqlbFc63MjL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194fc667-8d8b-4fb0-71fe-08dd8f906dee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 07:01:04.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTH9sMj8Uh3pQHUxXDOJrTU2iJFiaa4Or11D1uAufZmCeMeFwA3kw3IATJoRCHsWEppIDHAG2r3mfo2l4YOJqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505100068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDA2NyBTYWx0ZWRfX1wpXf6p/dImD CPm1c5LZTS9zBVE7vRhd2OKe0M6WsrQ5t79wW90XKTK+02KezjfnzUKvJ4lnXqB/7sP02F8CYZw 3TVAan62RYaYLd3KXYwsfYlHjpYb7XM9YAev5HjRvOBbqYtBB4ykzgO1/sNLIvptr3I0rkY1S+N
 pLv0aMGq9H3c3old+s5HKWPHHaTIeitYDP4atRzYxWql8bloRyMfa/TecqkDjWBEWxpzXEa/cfh xHzXpvH5GhTAjNPYnAy/lO8ct1+Lyqgx/4m9JnFvpZj4ku7whhU3zVnJH3hWm4pTJYr+ykzY64w qd8xSgQB0CHes0UhJr1Ijl+B60ZRX3PWbI6hblPyO+AIpI9GsXVYFaRu2bo+bc0DfeUu2T3rJjU
 rwX0PaIZwNBrkd+wbil/brCSmiVjW3wN9c+6ObvxGsEV/986+KYxHsi2dSy0GRQgIKRKas1z
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=681ef9b3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=6T-3zjojH1Dtb0QKpbgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: mwps2HKKkdVxInG3N9RZuhDRBYIVQLMG
X-Proofpoint-GUID: mwps2HKKkdVxInG3N9RZuhDRBYIVQLMG

On Fri, May 09, 2025 at 08:11:55PM -0700, Shakeel Butt wrote:
> Hi Andrew,
> 
> On Fri, May 09, 2025 at 06:26:32PM -0700, Andrew Morton wrote:
> > On Fri,  9 May 2025 16:28:55 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > BPF programs can trigger memcg charged kernel allocations in nmi
> > > context. However memcg charging infra for kernel memory is not equipped
> > > to handle nmi context. This series adds support for kernel memory
> > > charging for nmi context.
> > 
> > The patchset adds quite a bit of material to core MM on behalf of a
> > single caller.  So can we please take a close look at why BPF is doing
> > this?
> > 
> > What would be involved in changing BPF to avoid doing this, or of
> > changing BPF to handle things locally?  What would be the end-user
> > impact of such an alteration?  IOW, what is the value to our users of
> > the present BPF behavior?
> > 
> 
> Before answering the questions, let me clarify that this series is
> continuation of the work which added similar support for page allocator
> and related memcg charging and now the work is happening for
> kmalloc/slab allocations. Alexei has a proposal on reentrant kmalloc and
> here I am providing how memcg charging for that (reentrant kmalloc)
> should work.
> 
> Next let me take a stab in answering the questions and BPF folks can
> correct me if I am wrong. From what I understand, users can attach BPF
> programs at almost any place in kernel and those BPF programs can do
> memory allocations. This line of work is to make those allocations work
> if the any such BPF attach point is triggered in mni context.
>
> Before this line of work (reentrant page and slab allocators), I think
> BPF had its internal cache but it was very limited and can easily fail
> allocation requests (please BPF folks correct me if I am wrong). This
> was discussed in LSFMM this year as well.
> 
> Now regarding the impact to the users. First there will not be any
> negative impact on the non-users of this feature. For the value this
> feature will provide to users, I think this line of work will make BPF
> programs of the users more reliable with better allocation behavior.
> BPF folks, please add more comments for the value of these features.

If kmalloc gains NMI-context support, preallocation would no longer be
necessary, eliminating its memory overhead which has been observed to
reach up to 1.5GB in Meta's fleet [1].

[1] https://lore.kernel.org/linux-mm/20250327145159.99799-1-alexei.starovoitov@gmail.com

-- 
Cheers,
Harry / Hyeonggon

