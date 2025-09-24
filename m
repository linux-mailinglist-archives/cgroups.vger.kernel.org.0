Return-Path: <cgroups+bounces-10432-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E49FB9A3B0
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A928119C858E
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAEC3093DD;
	Wed, 24 Sep 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPLytmVp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mdOW8MSs"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3C307AC5;
	Wed, 24 Sep 2025 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723812; cv=fail; b=cdsaToJLkSCoYdIaSs0gMl2lTvxXjLK+Fzk5VfEzXdT+Cbr6B8lW12go48Hx1EvzaIylY6qEYdbnR6PmIvX8WcOXeOAtRK6FG6mIntj6YS2/EpD4LdLvCfdO0X6mPSktlJ0YOjGmeVyuy6O5hzX8I2edrnUNfwzKjWyEhMgR318=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723812; c=relaxed/simple;
	bh=bdH77j6x9ipSfUTjhB0k2cxsZt1/AoXd3MrkW4yu3z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M00OMHFrtwPqvS2+npU2cja70dg6nID3nVed77mdUy95AJCWMYQwI6mJpwF9tPdH/RQ3U5qdUpnaMZmhY5LFGlWnLWl9e/EfC3duMf2fBh+XtpEfcrS1baUS/aG8gWCEzgGBeavi0KpTOOuvdqmQwAhaMruyyP2Y3UfnVOSEz34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YPLytmVp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mdOW8MSs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODRJPd002397;
	Wed, 24 Sep 2025 14:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=72b1LKzDa0mEMcExKs
	4oX9fK7nRqwtk51Yhrr3mnGnw=; b=YPLytmVpfanOEDH9Ed9V8XREl+8sMitMHJ
	wh08lGEnwQBS3yoAfTfqCKF9z3+k1ZOIUzIpV/0P28O31K9PUP7VxuY4fNSaKY+x
	4vGL6er/k6wNBFuvpsSGLyENzsoqLu3tmF8lDjzEDp0zEiSOILPQWwh+pnzrt0Ix
	dhk7/sv2qk1qyko2GLu6yLxZbFNxrc0HQuXq2hb2TDElIhtBS86oRUYih4iEm6ok
	mQNuQA1NNNUw5DPryS7mHVl05ltopwdn6O/p9MyhKlKSQafSbol/k6h7jP+aZgWr
	8K9cova26VOdjEz/qbGF1CZlITaWrj3R/H0Fi4A6A8Ps5IdDCsDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6ayu1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 14:22:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58OE2T4B000434;
	Wed, 24 Sep 2025 14:22:50 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9qddx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 14:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqZYMZA3yv6wh/BhdJTGogebUbRBwsAfkGCIaIuoR0IwPlH0fal4AAS6/aYRtU6R86jFX6T29JQsSJ7U4zoQzIiurOArbC9i4aspmxrnWG/Id3DPAShPSFp+kbyWv3ZtC42olrgl8kQeIR7WANl40zhqxWn7mBezqy25ipAuBxP4VgNxe8SlLFkSk6ebA/NW8GdjJoJbW3d1kcROGJPTVIZtHOrfPo7VcGIln+JQVaE+qKS/Azm9V0a3kwHnk4TPrI5JaL/Al3Xjcfrxb6trc7tH6qWxZZPz6Ricld2b42xN5XD507691NjmfVZjrlm0aUYzx/82FqDjQkE8/0q3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72b1LKzDa0mEMcExKs4oX9fK7nRqwtk51Yhrr3mnGnw=;
 b=On/kj6qCWLYQ716vQAZp/3lIV9icAWrlxCw9ICSAPvTC9WQqCXgf3jgzkUBH5RMAq69aRdtO8AhzOs3T9m1KiAiydHzlJ4qjWqp2Zjdij10P+WBgsX4CVqFwHH7NHK7uXq0Q6GHnMqbyN28DiiXUbeyflxM/H4AtcoLEmJ5E+c4Mg4cMcErDYFF3Mexvrkq7b0yOhXZsbiCT+y4WCv6p4ZnrTutCeNy0KiJuT0XTjrThwJ3lGwUb/8IQymJ/s0PpVgyyhXvrJmjVh77kcU2juoJx0438Hvl/cxj2UpybpHgdcCUaApxvgXtmNOislQPmM58SveW4MuTJaZgHPXqG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72b1LKzDa0mEMcExKs4oX9fK7nRqwtk51Yhrr3mnGnw=;
 b=mdOW8MSsc6sUZ1ZsnP8j7JMhS3YERgb+vUGDu75/RwPrzXq/XloEgAE8PLgsY2IYI6g/GHMn2LMTeoaqc6PXYUE5AMrwN/TNpV+YP+ZK6I/LvfEaHJyCi0jdbOueIXew199LW80QiExXsdsUvqyH9+YKs5Wz+RHblXN3ysrDNaQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB4874.namprd10.prod.outlook.com (2603:10b6:610:c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:22:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 14:22:48 +0000
Date: Wed, 24 Sep 2025 23:22:37 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <aNP-rT1neQB0EdyQ@hyeyoo>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0042.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f62cfaf-8125-45d8-8214-08ddfb75d62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z65GbA3AUMtJ+4P3xCvJIkIuhbZQWWnfW1nPBruuBdrC0kp4Q/lzrwPPgUyP?=
 =?us-ascii?Q?4lrRDOq3izP/nbpRMJjLMgGHx69H//QXr+2sHlx3JB6fMSXUoefUUSLU4dCt?=
 =?us-ascii?Q?u79GXwwwkDeaA0/JqYVmqTPSreYvBsIjSXkj3oH0yAweCVeljyuxwerHpVtp?=
 =?us-ascii?Q?nLWMqUQy+8eMx8eks3qrWAO5AsD53VQn/sGJoWoEdXIVFb+FJY/BIfprm4An?=
 =?us-ascii?Q?8BkBgGgiuoBqb7XdEavndLNHihtNP5+4QSDPhfKdVZYsyP1Ky+Wqx7JYHaj2?=
 =?us-ascii?Q?THsWeTZgLn2E0Od1G2MGCjbNk4jMGMjeYWBsB2DevwhCssYJqta5UkktFwgi?=
 =?us-ascii?Q?j0wkre6PNyvvnj8x1m65A/xJ0OijRPl+wYIEeRQr9+GT70X9kECUG2Tt4/Nu?=
 =?us-ascii?Q?KmZa2cnha7zBuD7/5IwIpveuGYHam2UH/cu4PMFANxR2rP24/0t3o3fa1iXD?=
 =?us-ascii?Q?toFmduzrhnCXMONnBZBfw0li/9Nyfn7j/D4my1Gca/FUrMYSJM0Fb9XTKUnF?=
 =?us-ascii?Q?qe6ljzWsDFKQpFMqLguQQ5P9ycblIq/X7DUU076LecUb8bdXaG4JikWJyqBz?=
 =?us-ascii?Q?IHnrT+N3DMkCS4SNM8YL1S/eHaFrW+Mqs00IAH/18x1uxYFeUB/77ek1lu+A?=
 =?us-ascii?Q?GYjXtaRdJz4Tv7bG8rEHredswnlgdnO7wCpGVZNWmsubMOrXqVy/lseBsfSI?=
 =?us-ascii?Q?P3ctSdSV9f2OWaAZstiGwsqzHa4Ymv+dLh/nQy6OvrjLv7/JX8CzOmyNwVvl?=
 =?us-ascii?Q?HyfgAJ4Am2gGk9DYQc8wYCF9D1OlJU1+jt69S2M+tZ9iz96CTE34OYki5mAB?=
 =?us-ascii?Q?2kZKyese4z9/ccPIIB7vt/cGzOQhPxBX03HYCy14yXCcV7KTPJygOLdXSZMc?=
 =?us-ascii?Q?TDgGISfHjxOh+ZMQkWf3FU6lTge9G2be7R0zElaB5Fgm6YuWrnHAarG3B6p6?=
 =?us-ascii?Q?CUaOW+Djnn9VAOUmT6NLXavanwGk/0DWTT0jd1XhAWJ/fzZZXa02uqHJyPfy?=
 =?us-ascii?Q?UMkFhefodZSvBa63yHS4g5xZI687OQW/0pBlHaUqXSuAH615wBPVZAh0vr8D?=
 =?us-ascii?Q?+5izGEyJuilwsaGeoelEY6KDZFI63tDy8IxpNsC15hSdo8F+NoYZaAGAOv88?=
 =?us-ascii?Q?qKag5Hx/HR1yqScrgdtHbJopEi7FZTJVswO+//Jsie9VjRpq/KTDBhfeEJHH?=
 =?us-ascii?Q?rWhluGx/svCp8s0K3T+w0x88l+zjBB4HTRiFp3Nyj2sVukD7/iNm4h6+/1oj?=
 =?us-ascii?Q?9KHS+mdcrTbn+vUxmrdhbCHw6fZ8hPB2+4DgPB1OVfE0+mnsFY0GV5lrcQlR?=
 =?us-ascii?Q?uAsQPfyzRNSaTGNikx4NjTKPN6y3Pj/Fqw5DShsnyAZwVhd5jjPuvQ3RBF21?=
 =?us-ascii?Q?Lr4G+w+CI98N6U4Df7H3IFvd/CS+f/aMQqkWh7Bblr7NT1wzdB3QoiEDd5E1?=
 =?us-ascii?Q?LGHHSJDTykY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MFB7z4RMUk+OtlhQPOOHXjhvPYQ47T4w2Pju+bD48UpSDPkPY3czfuO5Flvc?=
 =?us-ascii?Q?nbZCKfRXLN+nm2f1/tY3T43prOURgzqSpN49S1yopySodnS23NEHU9AjEyz0?=
 =?us-ascii?Q?ckt2aBD14XuwdrWO6gWU64sEzutxaeK3+CbL7MpBtjAKdIugBSCrFe54cMOI?=
 =?us-ascii?Q?3qs303R6ywWvXaQ02jcHPtVRtUEPlOhgTVz8sQk0ql4BXSVo98Sit+Lq3+lx?=
 =?us-ascii?Q?rWg1A7SyXMtSkgAmPxrd/vUnPBnMFIo6SPXDYHtmTXbeegxH8vsDN5Vw/wA+?=
 =?us-ascii?Q?eUVvFfLBVsCTz4bDr9+KarYWtNCeem0/YEloZB9nWur93zfrYyiP9vxCq57E?=
 =?us-ascii?Q?R8lkHCxf+7TFYB4e+fFMI9LsWpVuaFWF5yoHEhb4/3wXF6hlltMClwCXPHcX?=
 =?us-ascii?Q?Cn/AqWf3Tf0TkuUFTefzjUKR5x6Tzqf/+iWjC+wnrxescLQxP+ZHr4IBCh/j?=
 =?us-ascii?Q?i9+N6n+DQwPQx7BZPGuMG0kV9wksKu8LyaYY08fy+8+QYmXaL6MEB7NVk/E2?=
 =?us-ascii?Q?qCBB8d9bxWZN4qvpVLv8bvaTTYsZHCamZRyVdJjJ6QZvpdQ5f4uSpizbHos2?=
 =?us-ascii?Q?uvcP0iq/EGM6Sz89aHv3obq0cy7memva2EwOIIp2yoYpPKulCTdGl+r50MZP?=
 =?us-ascii?Q?RMkDAfbKIeeZX/tn0bmIId41ZHsi6sy5mhfxyXSCYbk2yJyO+Bl5p/IVeNC3?=
 =?us-ascii?Q?+3fSdsd7QfcJqD1+8sCjcTNOE6MSqPWPywjMzYxr6KetC6A1UIHpJZiGR5ua?=
 =?us-ascii?Q?Xqvzc2t8dNz0mCHRLACCXctwJ+yJSNU6y0wUQReI1prpcZbodZH50nOepKto?=
 =?us-ascii?Q?+sSC/xicrNKKzVRIEkoFekZNFaIursDjLlg+75PPhSIHbmVqP9InHpib7aAq?=
 =?us-ascii?Q?WqTl1VNG/OW0quzL/Jeea4y0pq+C2L43+AC2NbcdH6IPRQ3ZMS0xGnuFQndx?=
 =?us-ascii?Q?y6JdhOUp95SCNb7STq5Fczxqb83vbyf+I1OnZdfXf1bw9WHlljdjt0iaZu64?=
 =?us-ascii?Q?bdfmvPhkKbj7wCWfFXUVBrA4vpq4+Vwnxxdz3Fk7xLSGXPEdMOjkf9yx1t0l?=
 =?us-ascii?Q?0qhMenZqwYz3zalom7aHsrlhxY3wRoW+LhGBYJem39/B3QEZORZBnP0hT7fh?=
 =?us-ascii?Q?QiXw7tLQFli4QL8YtivlMJc06hw8U9IER/CMKP0OLoZExTTcH1YXKJxiWV7o?=
 =?us-ascii?Q?1sxX++jZWtakrz7LMhtHGBgtbSDvqzFQhb9GnBteIAOWtb6IqCC2qI/83yBm?=
 =?us-ascii?Q?RKYv+D9EWvKW53NuPK4L6U7oPCJLFzdNp0MnZn3Z1WPHZG9mN8WfePdYxjWo?=
 =?us-ascii?Q?1kuS4qDA37llpei9GV/1RtdFnjlZ92u44Jh3iLhG26BPaI+C8dxB4IcUN8k1?=
 =?us-ascii?Q?Ct8VFyIUL2Cirp0cn9I5wVNgM6faTtvyoNbN6v1TQurlVjstFuIrt83RTGRa?=
 =?us-ascii?Q?5xGycVv1XMg02u2zCFW8bgOZBIuyUJttj67/agHSjflX6y5dWyaJ0SWjeMmh?=
 =?us-ascii?Q?xdAqYkIwtlPYGdeT1CVfzpMwYnKfsQPbtVWiKKGcKQjla2O9v2lCiNTXOlwk?=
 =?us-ascii?Q?RcjXfdHFmztYCN2yRSMPEZkzPc1Yzq/IkT9lCNOS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nkQAImmBXD8Hv83ixX5icgSiYxmoccQJAYY/q+48RC363mVeIG9QvkYe8Uwh8RFnQqXFeMqj/64lWBopURZmTq2lHCc+WV992QDDPGEg0/qRs6UTapes5X1R0Ld1G+3s7M3BLcn8vLbMZF/jE0qftzK8z6Pmj9w3p2fK0lQTcMlw0A66pU4Wo5gseL3drgikrLLxlprv8YmlurNw+p5cbUF+CZeZfjQghEHx6kOcYP5tLP7to6D0VCBRXuLXd5/VZEU+J5CgBoTo1tuYnHT/oFFNjDphBdASG99AwJlcxkKwVdbbHxnFteZDmHa1mRXHOzwqTQ3PW/P0al/wdNNmKD0u2MCWd1WS9Pm0uZ79lOvcgvcnL8HHsIYTB3/x3mdTIlgu9Lto89sThKECk39p+5KwBwFUMHCH7uc/ZM7/a88cgEiFgFacNClXQRw0I5NfhOOCEw+pM6JZ7mM0w6NIBJsxbNU3fGEErQcottV1/0Y7tCAYiOLL6JDNUJ4eSqNv2EVdNxNi0ydZRHS1lybPhJAbn5fpOXSb31LGgQ6LE4pyivJHPlCsWZCzIcxAmvdc9QKVkZ0XyaLahubAvqbJe8WLQzdko+hRiTP1JFZC5BI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f62cfaf-8125-45d8-8214-08ddfb75d62f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:22:48.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ImlWnsW/ImJAA0jAw/sETJTxKVFRqs2MQCwf5Dof1h2z9ZXQlh3CuEZVhYOGy8nBkfh1ckMPfUEDsiOEPiQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfXwykzFBdnVNCY
 Jij22Mc0kpfhTK7FhHnZPGNjkp1RQ71ziXcUMJYtwc8Pm6Rs7jWSci8KLlZdMKIgpTCIhT6ZAEk
 d+1LT+6Z0BoiMhm/4qQFJuUo2gUyLEtZQtidPUdsAFVhsvWG/ugwK6gFb6OU8w79uthylaFj8LC
 g2ssaTYIoTFN8IoIf4Ck8Ka5nguMfZ1zzoQOMQLmKatLJXqrGx6/0Q2mPpWlbVofceMe5ZwEV3C
 HtjZnxdb8vfA6h14bT78EPopgTD3yCDHM7XnGWv0S2X7NltYnnJAHoSwp6/Cm2he6FW8db0UcMZ
 VmO3CWFkdtWNcvkAHgZi+ZWEfRG6V+eiZXHk8j7jn8kZEjaObsfb/H2DEEK94VP8G9tQiNLBTdd
 v+0Ymmg6LvI7EtD+vBpjkZoT7BNFvQ==
X-Proofpoint-GUID: yvgDRPVEZMnroJ0dwZWq9gXioS8nVuLw
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d3febd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=O7fDqmEyEwJhjZEX60cA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12085
X-Proofpoint-ORIG-GUID: yvgDRPVEZMnroJ0dwZWq9gXioS8nVuLw

On Tue, Sep 23, 2025 at 05:16:25PM +0800, Qi Zheng wrote:
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split queue
> to its parent.
> 
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the same mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/huge_mm.h |  2 ++
>  include/linux/mmzone.h  |  1 +
>  mm/huge_memory.c        | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c         |  1 +
>  mm/mm_init.c            |  1 +
>  5 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..a0d4b751974d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,7 @@ static inline int split_huge_page(struct page *page)
>  	return split_huge_page_to_list_to_order(page, NULL, ret);
>  }
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
>  
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze);
> @@ -611,6 +612,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>  }
>  
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7fb7331c57250..f3eb81fee056a 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1346,6 +1346,7 @@ struct deferred_split {
>  	spinlock_t split_queue_lock;
>  	struct list_head split_queue;
>  	unsigned long split_queue_len;
> +	bool is_dying;
>  };
>  #endif

The scheme in Muchun's version was:

retry:
queue = folio_split_queue(folio);
spin_lock(&queue->split_queue_lock);
if (folio_memcg(folio) != folio_split_queue_memcg(folio, queue)) {
    /* split queue was reparented, retry */
    spin_unlock(&queue->split_queue_lock);
    goto retry;
}
/* now we have a stable mapping between the folio and the split queue */
spin_unlock(&queue->split_queue_lock);

Oh, I see. We can't use this scheme yet because we don't reparent LRU
folios. (I was wondering why we're adding is_dying property)

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 48b51e6230a67..de7806f759cba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1094,9 +1094,15 @@ static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>  	struct deferred_split *queue;


For now it's safe to not call rcu_read_lock() here because memcgs won't
disappear under us as long as there are folios to split (we don't reparent
LRU folios), right?

>  	memcg = folio_memcg(folio);
> +retry:
>  	queue = memcg ? &memcg->deferred_split_queue :
>  			&NODE_DATA(folio_nid(folio))->deferred_split_queue;
>  	spin_lock(&queue->split_queue_lock);
> +	if (unlikely(queue->is_dying == true)) {
> +		spin_unlock(&queue->split_queue_lock);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>  	return queue;
>  }

-- 
Cheers,
Harry / Hyeonggon

