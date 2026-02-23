Return-Path: <cgroups+bounces-14142-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDlADug9nGklCAQAu9opvQ
	(envelope-from <cgroups+bounces-14142-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 12:45:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA612175A8C
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 12:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0261D302BF59
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 11:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB6D364E8C;
	Mon, 23 Feb 2026 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gUTWRxUz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NieIHU72"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A335B643
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847130; cv=fail; b=D/fDkDy2Gq9gE7NoQS9PyyjtK50K3T15H7DoFIAhrPl9X//IRWcOqhduVoP6buzqh6njO9MTTqvVZAQVWnZn0Rn9w6ZFPlzzQX80oEvYHTKzXytXmxpfl84I8KnzQyX+DyaINO09VFeJPsgtmTFJp5TjQAkdA51jF2wTZoaTxV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847130; c=relaxed/simple;
	bh=LKB6ZI8gmQhIoJoAmpwbvi79LZ7jpBP33eztASDCKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sau+WihP5m/4TsK3BZGFPr5CEUOOw+PjnVwxJV3HMcxTvWZlPXOLVCfzOdzw+n0oHsNjVj9PYsqT6v8/FMqLbtfM71WuXr8BBtrDAIJ6rxXpUwMGZ2UiAxFLzBjxefOc6Obg+M1qm0rJnEXI3kIsOJg9kCPdP6xHuUhEP0tC+Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gUTWRxUz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NieIHU72; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N1DQ2n600220;
	Mon, 23 Feb 2026 11:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3+RtHRQDqiLhfJ3QpT
	WsRbdvJ/vKmcjE/h9/xTR1sTU=; b=gUTWRxUznZtsS5h/ydKOq3kOFyBKJ0vrsU
	vN5h0TaaBUB6X9JXCseWJ3rXtoZ15PmtcRPpLPg+7FVcwyYf+7qlWx2ybHcnozvm
	ef1gLe9p53bL6+rpLlPGEJgYU+UOhCh34eBCkJahTROigW8NY2B0SCHANPrWYqRl
	qHvBBfJop3NNETsu1bpwHt0wQXyBdjWByQGXCpNIeKb7nClUcKyclkGN0KgdQ1+F
	MWi8aoLiqOHt9nlXVVBg/6J+Kv8kFK9jKY6UBTnsig5H2kZa/qAMwCIVCyumpvnC
	eWFqaDEZQSHJ6DWADVt1X1rz9EtVobHNkfyg7AHg9wX0Gcxe6afQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3g3j0wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:45:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61N9uK4u038739;
	Mon, 23 Feb 2026 11:44:59 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35jgb78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9O0xaD7hBkML4MUYQsjp5ZF2742T4aQDSZU8J8AFYYs3VSjIvPnV694XYGPI9G6YoY0IR8j15UTcvdIeGmVHstllU9UAMKput1/tjU1BgXh6IIW6b74ZPhU00Mb/hiT+i3ybiSh4P3PJh48HxQAdJq3iGkYmr0cmPcxYWp5DmLwli8h7qDJLbTnT8TaYepNgrYuVU5NkGLpe8jwVPk7EcQGGweySQSQaQxfa2lapqM4LjXgN9v9sTz1TYfiW2eQ8Oi8ZiBr/96N//23qLVv2p+oGjjBBk6r2/VGFArozfkh3FefplTjPil0VgCZhpEU/3v+6C2ihjhDY/7d8mjHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+RtHRQDqiLhfJ3QpTWsRbdvJ/vKmcjE/h9/xTR1sTU=;
 b=avUmhP8dt2yFtynAmn7X2wZPK4RsybWu67yjyGihAEkg0ftWoQy2AtsQPjV3atdaZfYQGD780FHH6OoJMc4P3cJVAUfEHMzqUTUc0vBAfkTEaGTebavCT5m9STi+D09lJt0kRaVGf9sDquYW3YKcVM/kxFCr0CNjj7uxsq2Qid6ViF5wolweH6qRkpy60NIWZvzLqpyI3ZahejC9vQ7n5rBuLKg5oAieCwf9wjl+GKYf07hncXV21yHA1cKk/OCD9VdFUR3mGeXccvWKXqY63h4F+3LP2IVRZdfVV2JdIVAy8h8KdTK+1I5opPA3qcypIVI5Q2TaMVLFauP1LI0O7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+RtHRQDqiLhfJ3QpTWsRbdvJ/vKmcjE/h9/xTR1sTU=;
 b=NieIHU721Plizqe4GH/KLZFbAL4cqN0K3Qf6JrMexOMiAEUsM23McdwyppxVhIajBrzzl+lp3qiSNMC+65TV8+Lsk0rqbQdhR1eYW+oMeX+B2l/SfyUOsSvqZUD0BNCr0wwcPiH/X5TPCfPJt4iqVSpnVioGkqeEnlRxnS2jz3k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 11:44:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 11:44:57 +0000
Date: Mon, 23 Feb 2026 20:44:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] mm/slab: initialize slab->stride early to avoid memory
 ordering issues
Message-ID: <aZw9sIb5yyhwZKek@hyeyoo>
References: <20260223075809.19265-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223075809.19265-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SL2P216CA0222.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: d9174cc3-eb9b-4f09-17f0-08de72d0f7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YJZfanmRfHAxz/9YfLdkUPezb8QsbLdSrOJTdnOtX0QpDk3b62bwSdTfTLzC?=
 =?us-ascii?Q?8FPu4g5Iho+fpKchQVVDXTJjO9RVJe92Ng5KZVz3m8Yfl9308VmFwtNSTbte?=
 =?us-ascii?Q?j8JkjEh4UTMQVi6U6jpDBXIDaNgqo80QgwdTYsK82a11/rpC3AYcZcyVxSJJ?=
 =?us-ascii?Q?kTXrDH/5U09hTrBI/MoBNels1qkFtzqg/47HK5l6lnLDf6nSGi3dCne1VrKy?=
 =?us-ascii?Q?SuG+B9MeKN5AHAn1xGstZuEotz726xgBPRTm5szWkZUOr7zbcGu3bEDDzhS5?=
 =?us-ascii?Q?jJ3oirN8ED7mTSoN2Ul6vxaekr9Z+VoeL3wle8hkR/CWRpcyLFP59jL95nlj?=
 =?us-ascii?Q?Ep2LXFyLZ8yalcJzefdTxwFWW2i6CD4YqJ3ioIcShf3iFIxlqDtPv08vE6CS?=
 =?us-ascii?Q?bS0LdKH5bNQwLLBiCHU17WizfknsJkR9H/kFW9G4hhOOzYhG/ajPX/xhOGed?=
 =?us-ascii?Q?W/qyIl3IvH4YoYHLDp81tM2/ZzBdJbsEJkNgON3GteEZ1Mp74+LkYsZpEWIL?=
 =?us-ascii?Q?OHzP7eDJR88ekMC+ch4Y6oVmfps9H9B2FH0X/BjUHUVgqfRmGZElFkMaZ7jT?=
 =?us-ascii?Q?C20MRncZEf7bhXaRxCJSBF3yNIsLsznGlh7ESlAz9Pgr+6qDkZEL60GDc0tl?=
 =?us-ascii?Q?bd0HuLoasEaB419yWC6mA5MDDdR7ktaud1OiojCxHLZXGfxunB+VzaGoPNnD?=
 =?us-ascii?Q?D/6jCb/dstWIDWIOypvjj/Xbe8+wJdsTmWnqe3wdXeI5a7JvxeDktZ+bg+AD?=
 =?us-ascii?Q?H5fh/Kr1DLareveoTku0T3YGojxfcobHL9fn3GUF2XVVoOEmOnbN88NBUnpd?=
 =?us-ascii?Q?TkC0QNHqMI4MaWWhr/GSlRvs9vaV2MA7Io6xk1iWoswb3Oq1E/5tSRDm8vYI?=
 =?us-ascii?Q?+upTpebIx2uanPBa2kE/jEBZ6g93hhY/0bV37D3jBV2/x1j9qSu2kgdQqh3g?=
 =?us-ascii?Q?sItrnG9ShnLxzGvzS/kXc8YwabaZwak6ls6WHV4hUFuikD6UAKHjJeF15ATX?=
 =?us-ascii?Q?nZ0N2ius8sdWeLRmOdgnuoGBV7RVgsUjDY1m8k6pMutiIQVLvFF7+kDUIhLi?=
 =?us-ascii?Q?BPoxr+lQMTtZu8g90WNurbi+Usgt6jl9DlHhMo9FmZsEe/vflkHvM5TF9t+h?=
 =?us-ascii?Q?SnQfzc1uEm0763apgjdJX4VUXq1zLkOFYPTmA/7jbndKXruYB1AvPNT+1/4T?=
 =?us-ascii?Q?Mq8HS/YDvgcoMOLmls7+2s3H46NF2ZKvbewJEmfx4q6jFYqB2OVZT2iAcCiU?=
 =?us-ascii?Q?tPHqmze9RexzejkRE4/wW7Vt+9hl5SHqjcJaDRSq0uLIN8DQKoudzVS/djti?=
 =?us-ascii?Q?yI8tK9LpE/8ASeEBDQagarKuD0buthEalxgnL8hciiVAoLOjDhQpYB6fkFOX?=
 =?us-ascii?Q?fRrEdFcZ7aMIWHtijKCrxjZ5dY1LB42pNQLsSwLDLAV1OtijjJ9oSCCy+hcF?=
 =?us-ascii?Q?jDeLQh+Nx3RKqYREGKmDWEk4sbOdD5jKBp3GG9tKThk8w+xAHcUJQPBPaJFG?=
 =?us-ascii?Q?gIJ+L+aj4iNeTJSEAMYKYzqgHIE5fD7JhQxvfaMSZp+ATon4zamROVp3hGOy?=
 =?us-ascii?Q?TdiGDa8SYCYh0hWNPJF/mpRsplykZGBmA6TLTweS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PfrsEgKUwDEjbfJiA9YuBD38PWOFODlQtvst/R0rCTcDfvzAEFkTR1eOLxs?=
 =?us-ascii?Q?NfUYizR8Zo6lAaFd8xPxEP/n12jca6XYGTdKCU8mQbaXAShO1cLDnzZXQVZw?=
 =?us-ascii?Q?NiRWYFIiFZI0vp9c2TXVF9i4X3QRKCOlsjBqLqZAv/YtkjM+dawwnE5OXO2+?=
 =?us-ascii?Q?DTyXMQVmCxsNwJUFmBTEmMMWIVL7MVqskG0bdR2vDhwEfMmjAj9vTituHUuZ?=
 =?us-ascii?Q?CzjEgo+6BOCpwE4Xv6T7jp6KlHy5Hgk55IecxwRWU0blRbROAw8r/kNtP3Bi?=
 =?us-ascii?Q?rbvsrG+PzNZ93MKuqIvskC4YSvIKWsGLnhn8GXvfGWsUkDADxuYvZDxJHwa5?=
 =?us-ascii?Q?VIyqDfv0qwS49xahFATZG+yXg3uADioKtpTbZGobyk1OOvpGl63ehdrZn5Cm?=
 =?us-ascii?Q?queK+HM6BhOHaQhLJETgk4dqlKdiOpzoMGTlF9Q7bbeoOyRl0YQVHyHG/i9C?=
 =?us-ascii?Q?9fQrCJ2QcGnAmVYErnPCqoquweMpcRtW0w6zL78KU+Ih8VGwFx2UXdMfoTaw?=
 =?us-ascii?Q?4Vm10fPXsa5cUeKJDolODqt66lfxUDcEBWxJADPTFD8I2D2fOSyDxze5dm/2?=
 =?us-ascii?Q?d8y/ONZ3fyIrMKFGIp2r7xl+Yh/Jnsedor6bZtuUSDALFd9P8D0I6NZ/Xs5r?=
 =?us-ascii?Q?0dw0rPEc1EAlwcOOClkYrsQgKA6vO0V91U5aNvwF86e+DDb3Sv6ggEVgkFHY?=
 =?us-ascii?Q?aYHU3LbBCDyLPqFDfZXRuLLv5CjlMEqiu36JLun+uABcjiKJ43zv5rgzsfzq?=
 =?us-ascii?Q?04Fff5nIa2CG6A1lGVnz4YV/knjtQqcoE8Lh1KbtSJo7kVDTDK4M33zBbgaj?=
 =?us-ascii?Q?MJOdiWPuUCSRoUvxhntGccg4b+rat68U2hScm5x1AwAScdWKui+wz4hQsP3q?=
 =?us-ascii?Q?y6Xixy4B8CyJLk+0pWXRBBOJKDi/zCPO/FdrU/FyhPnmYakBIKCUI60v+Sya?=
 =?us-ascii?Q?/hg3oWuw/SOnSajHCeBUlvU9iS1wxzpT7r1JBrRXbE/sJ5ML9DySq8qzg+SU?=
 =?us-ascii?Q?ToPfhn5h+GJXWM0M2Bfeu1OR3L1SkBXABFl6SrEB4umIqGAiarKI5Hn0Uftx?=
 =?us-ascii?Q?Rp+ecRDIo+CB/2wI93gaW1gYMZThS4oC5HDEk/Fb+okvBw5szhD0vYfCfVfl?=
 =?us-ascii?Q?c6oBxrPt8jWu02XtM5g2hbDhig4YNOLfNYVpVaVjyjrxFDYaGhRO6+8HJ2a3?=
 =?us-ascii?Q?7EzL4kqEhnhjTp9M3M8HlTdas9RT/7+8H6vIwpRyVv8uzE2Hb5SnMQjQ2/2X?=
 =?us-ascii?Q?lYUUTz59ovpDk5XFR11NsvcAguPqraPPKmFJvMZyqdMOqJoRWHth1l3tEPHP?=
 =?us-ascii?Q?LQ14j4op8WTbM+RRT3YCvLBgYap2EX81NpPpjazJhqRZsT1Fd0r56oRIz6sA?=
 =?us-ascii?Q?Zam2MMC/FoGLtjFE6gIQ+CLC90mKkZu47HQ1+avRU/IVZR5+U/VZFG9X7Jl3?=
 =?us-ascii?Q?BEeerPx2CSWTBZK7tGjBa4rfIzSFusevF1rQ1fbf1P7KvbfSIdNFFZy5Avlg?=
 =?us-ascii?Q?15+E/j5lOPDA+6/HaigvpxfNsTpl3CIjCDfmYZJNeZndtEVYk+nR90Di6T9F?=
 =?us-ascii?Q?zHkotxVWPnY6wj4Wen91I+eTQ2K09TSLaHJ5hHy/8hRxuINueLLj0tNE3VPx?=
 =?us-ascii?Q?BPTYOvIAOV75XNWNAPHIaxLrOojjJndAHKO0vPhkmPp6cWZ5yVkZPL87ykh8?=
 =?us-ascii?Q?zsjNwJswC1+moiA+r5UPngEfKCjkRFvdaTJI6quLRqX6VQTTlMY7kqPPotLk?=
 =?us-ascii?Q?5VStLqDfnQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UJzwM0LCwpIjB9oeH2v2WWNOTcy8xKXt9dZZW/ooKm9hOz0Kg2yh7660XGlqypDuLmJu1ct/fniM+DJKPlseoj1xaz7mAGw++mOVvRUK44pdN6alWDjt46lOZA0Hjp7ebbynQAbP3IuPSDNOA2ZuFWanRpFBClKL0+3WmZYRpJVa0CFyYfL/F8sRjfK1EgD/zfop10h/7FaONttGyDOYZ5GES/aNr8Frsl05oCTmfZ7LPcGM36CR0164KTNY9EtWSBL+Lr1d0VPfCfrHW6fvhpHV2RaCIM4Fh6jFJ+xcjKYSxg4MaLKpLJGz+Uw+gFdbzm2YLw+gbsxt5F7M87yR61ep3zBd4APkuUC2/pp45xJGb/jpGky6kmbAZJBOdYXet1ry4dvaSUWikPtSHhmX7AUfDHsvD1N5hlUKMgMtUdSllElqMAYeLn9AX7p+BYEm8yID/5evboWPSiu9clIGdfE1H5rDbTd82vUhuSdKpwyOyloSRIG/96ohycbVcT/IjMcvMYaYzdO6m9OysAnLmnBD0Q7exl8vJvspDEaC5+qJHJkGhqOtDDqQVim1qM7FyGkYA6SgYCDNNDgLNCPfC4KYHc91EivlbL8oqf0c50Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9174cc3-eb9b-4f09-17f0-08de72d0f7d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 11:44:57.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b34emSoHd9JSVOpmTSgv112M5FzO5Arb4pNu1Q603pYfQOk3soFwm7IoLWFjcT5XZkQH8IMHbu5dju/WrtRYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230100
X-Authority-Analysis: v=2.4 cv=Y6r1cxeN c=1 sm=1 tr=0 ts=699c3dbc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=uwGLaBwdBThCKQ70_lIA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: A8oBtZiiA0Vk5PfOrFUYPKJ_Jok-E-js
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMCBTYWx0ZWRfX9a2DdmDBcKlZ
 SNMgwgmIyHoyzdKaMkebbv9RDGeh6XjJuJoRUiSGThx4ywOcsC8eajF5mTmpGqlCrWK/UxWAMao
 7tI1C8wOU+pps8/9sBUEPauUibFZ6C2CqxzKF2R9uQQVRvwZJAdriwiw+N1jzC0P1iCiSHPPDua
 8eTOtmUp+NrrdFAhNDnk6f2wVUBSFg4TscEZeBfHdgFsHPdtGffvI9nmpRMrWEFvZOQYkWZg16d
 JfF4qjTlqqZuXKGqTKbnqnCOuo4na9znsDVGNLhWmZnJYHOxMqWvSx0fmrza8xk3TqOvkInK4fX
 rlvxFtJmDGskE1h5q3lXxSTuZVZZKgFarpoqoFYPxkn/iBQh1fVWCOI9+xvxxy7RTv2O9/PsTz2
 bnrFUgMpatP8r50hM2lQ3b8aLOr4zyAaMZjxOMfAdG3EAzwcPcWcq0aCqSJ+7RdtFo0JqKWwvVJ
 2rGTf+nDFYSXAsJUSirmhZ9zsx2SmZn63+MJYpUw=
X-Proofpoint-GUID: A8oBtZiiA0Vk5PfOrFUYPKJ_Jok-E-js
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14142-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EA612175A8C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:58:09PM +0900, Harry Yoo wrote:
> When alloc_slab_obj_exts() is called later in time (instead of at slab
> allocation & initialization step), slab->stride and slab->obj_exts are
> set when the slab is already accessible by multiple CPUs.
> 
> The current implementation does not enforce memory ordering between
> slab->stride and slab->obj_exts. However, for correctness, slab->stride
> must be visible before slab->obj_exts, otherwise concurrent readers
> may observe slab->obj_exts as non-zero while stride is still stale,
> leading to incorrect reference counting of object cgroups.
> 
> There has been a bug report [1] that showed symptoms of incorrect
> reference counting of object cgroups, which could be triggered by
> this memory ordering issue.
> 
> Fix this by unconditionally initializing slab->stride in
> alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
> In case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the same function.
> 
> This ensures stride is set before the slab becomes visible to
> other CPUs via the per-node partial slab list (protected by spinlock
> with acquire/release semantics), preventing them from observing
> inconsistent stride value.
> 
> Thanks to Shakeel Butt for pointing out this issue [2].
> 
> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [2]
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Vlastimil, could you please update the changelog when applying this
to the tree? I think this also explains [3] (thanks for raising it
off-list, Vlastimil!):

When alloc_slab_obj_exts() is called later (instead of during slab
allocation and initialization), slab->stride and slab->obj_exts are
updated after the slab is already accessible by multiple CPUs.

The current implementation does not enforce memory ordering between
slab->stride and slab->obj_exts. For correctness, slab->stride must be
visible before slab->obj_exts. Otherwise, concurrent readers may observe
slab->obj_exts as non-zero while stride is still stale.

With stale slab->stride, slab_obj_ext() could return the wrong obj_ext.
This could cause two problems:

  - obj_cgroup_put() is called on the wrong objcg, leading to
    a use-after-free due to incorrect reference counting [1] by
    decrementing the reference count more than it was incremented.

  - refill_obj_stock() is called on the wrong objcg, leading to
    a page_counter overflow [2] by uncharging more memory than charged.

Fix this by unconditionally initializing slab->stride in
alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
In the case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the function.

This ensures updates to slab->stride become visible before the slab
can be accessed by other CPUs via the per-node partial slab list
(protected by spinlock with acquire/release semantics).

Thanks to Shakeel Butt for pointing out this issue [3].

Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com [2]
Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [3]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

