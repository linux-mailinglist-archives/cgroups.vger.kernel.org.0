Return-Path: <cgroups+bounces-10910-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D594DBF4AE4
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 08:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6413318A1E1A
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACD923EA9B;
	Tue, 21 Oct 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ht/NPOrP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W5xpT5k4"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637586340;
	Tue, 21 Oct 2025 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027027; cv=fail; b=IQNTvnyc5kVu9ekuGsXHhkUI989fBzN3qEVtDveT2VBPn7E5nAtLNQdcxwmYuOFQlKveLINIwo73Uka2AI1iH6fIFmxtm+sC6GfztT5I1tKbHgART0TBJIMlD54xfq4cmo6AU40VGiZb9oXjz2/jzD3sSO/RGBkE2kIrR8bF+zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027027; c=relaxed/simple;
	bh=doq8+4jiQYga/DfN6/uv6jxYVPKvkEmX7NXSjSlYTn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjLeakAmh7GTP3vuoIbZsViMGhl1tDDY8eWiq5Jlw3cm+BMQVz/4Uy6AxMne7HQinVqUTE7vwnvPyHa1XDUbfmHW8nqqbfVj4uYfzWqZbYi7t2xIVF6nEHdLwcQQ9O7geu8MdG3Lzqp9+hvUbtax2ybwA5RYf9WYTPHwNAGCf7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ht/NPOrP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W5xpT5k4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L5odWc025694;
	Tue, 21 Oct 2025 06:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=M357IoKeVOKQvjdbhz
	0y4cYqIS3QyFWXAhgc90NYJEc=; b=ht/NPOrPMNIpmvT9zm3J+SvvMknARJoAgg
	uTn79oPwoQFwobh4glkGz8AWWbP0AiQ6r0nb+ilUUHHyms4UY1LjttcMfqhSiBpt
	DF/yuHr+Y5cs9qdCMJDVKM7DzfwdfjJQNijFrqr8nErmVNjHqYLWegCXZ74H2YvZ
	LZwtZ+ThNPTIlu1fH9lUMCb5xGTOzaMwc5YX/UZ0z7H0FQsx7OhcOG8tt5S/Rf+y
	JoR8KF4vCd9HkauigeRPzHoG2Oec3NLSxQoAuJbvhcCzmGWGGi+B4wg0S5u40q76
	X3xIK1pe/pg2FIf9eF2rfa7GRo3BIbM6i0K1j/HyR/CDWx/OCnAA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2wav0ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 06:09:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59L63Z5X035192;
	Tue, 21 Oct 2025 06:09:44 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bchgas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 06:09:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9M79E/XS6AiHwxhAxhsBYNA2zmatha6m8iMIs02/4gSI8cRlK6wJ3Y04k8uSw+mvArvA83GvMSLskArKS3ml+lh3xCjVBe+2QMvroYCS94xWnUqCiB4/IVxj65br+7TCd3a4DclGOa2xXOcnXnTOsgO3LSYb1yHXNRCq7yFXFoMubbqC7+QBX5pqVYBcM+lPCGzW8wVIFpfLQkCUqodGGMtEIZfuO2Zom3upHB4o8FWO8bNLz2AvdblgDJIsZS4xPnkqyitlr3+JV5kKUcTMxYqybh82HWKC6+QHfkSYEUNMkJp1yWGeqwwtg4l4SOzZlZCY/ZYCVVjwCZq6KbfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M357IoKeVOKQvjdbhz0y4cYqIS3QyFWXAhgc90NYJEc=;
 b=YBITxl8lCSuj19hJblRF+8MHeKNyKB7P5o9ont0QKXKUQVT3mtn+TS6GEa8mkKNnOKjGnLx4vJU4hxH7TCqrM6agg7cwAAI7FNP7Cr4ZwAk1vY+wOAckP1ZrDZg239GKXzPeHS3VT+fIkurmiB3vUR+8uzJ6v0TB4XoQk0nkyLosPElcLU1L5TY9KyiIMACiaALmVILhJLf49wy45KjQeQtZf0lrz+CJqcTlGSoAPZYN8JHf0Ctw+8gtzmKw+NSHOh3r/ykljccTSB7fuWGT/WX6hy5XT8AnkV1B1D9jBf4pJBYDV/2tseRZDjlzecSQZ0txmtH6y+CbJfa5rdZOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M357IoKeVOKQvjdbhz0y4cYqIS3QyFWXAhgc90NYJEc=;
 b=W5xpT5k4x7rdoMU5q5bXWf/31TyPD2ZktlFD+l4FnLg8GdOmrLl9mb/EeSqOhbHJTR6kcTZDIdhzP+rfJgyXJdrXiHJqNYPoaHoahEdvI+5d3w8+bUGFQpJ42PzWWMxYYvGdBqxhkybAyqLUULGN6fzglz7WLgH6/VKwdWO1WC0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Tue, 21 Oct
 2025 06:09:42 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 06:09:42 +0000
Date: Tue, 21 Oct 2025 15:09:32 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <aPcjnKAapap5jrK-@hyeyoo>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
 <645f537dee489faa45e611d303bf482a06f0ece7.1760509767.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645f537dee489faa45e611d303bf482a06f0ece7.1760509767.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0206.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: f1182f5e-1cf0-4d82-9a9d-08de10686c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RBnbngbxXImTUGaxR8EVcMIKz+q/b4jid3DBn83sB/kCtJTfpfBwfh9gnnRz?=
 =?us-ascii?Q?2O9mNW9b8U65aYn5C+zuoXKrZj5WqvuhqrPNJgrxwrkCwCKpsVZkrPGBIMyd?=
 =?us-ascii?Q?93l6B+qxH5EddZIGVpGOZSHPSqIqO1qUa1ellBkTIN9/o1lV2ys4P8uLH2md?=
 =?us-ascii?Q?q6OHODO+JdWp2v4PghFRzqv3H9ocuuK7Wn8ifT20LquPU1OUgHjZLZWzxFwS?=
 =?us-ascii?Q?a/gSLJYb/4iI2mCrCv/M+DVlGm24bxd4uKD2qP5BLKQk1x5O7P4EkA8BHdd1?=
 =?us-ascii?Q?5HutIMmqatHke0c3oZXg2lcTvebc5wrjhdvl8CcrRQS8hhQFAuRrFQdlK//h?=
 =?us-ascii?Q?G3nBgQHZLPQqq6Mr1W6iI+s9RnVxYtRhM/sijt5ICs1Q3pRKMz7mZkjyKBC0?=
 =?us-ascii?Q?NGvhHrDtLvYbFGAsPDNBXCS8AgmoyxU+jNU03u8Zm+RZHamm0ZBvkSdsDf/4?=
 =?us-ascii?Q?SVx18xq9c8Q+nHbXtgN6vLa9JeZov+6X2n1IdHHG/p/5cQfm8kAwTUsWgfNR?=
 =?us-ascii?Q?z6x9egaolI/ipinjond/2aNZEubI1dzDhx/UC7MIM/aJ+r9sJRBqy5qNNDwi?=
 =?us-ascii?Q?m7sH0xA7o/RYQPr0+S368kIUPKOB3RJbGxmNLuKJIHiUAmNpHEc/saJQhsr6?=
 =?us-ascii?Q?f3Pv+gFp3jXDLZK7s4jfrcmQWdO/Zgmd9OTRvkEvwg/uB8ImaYHHppZGTT1R?=
 =?us-ascii?Q?AMq8lC8t++YFya5C8Z39TdneGLqDB1HTR2HDI1oqDSzSxa9ygSh94Wrhh9hb?=
 =?us-ascii?Q?OK22YMlMyejXkKVQpYLR+YudPIpKSg3QZlEXrJ/FnVwrD9NyoapWNnKjduhl?=
 =?us-ascii?Q?7SnzbRx22mFqVs9D5SNzANCmVEyHtzcdXoGsZ1QRE3Wu9jQ+cLZagqfVtK9/?=
 =?us-ascii?Q?NnvrqHmCnDHNOo1NfCu8+Y+gRgjWVm6YCyIIvCK+zzTiQ67xH1zrHdyWTd8t?=
 =?us-ascii?Q?bvdMrNT8+zJPXpwrni9CfxER4M7hmIBJTDwkfr6YZjmLjagU02PSZbLmcBZt?=
 =?us-ascii?Q?suVC7zunmUQ1WxQhHBPFk5LghADVfhTJkPCkUlQCafbEw5115s3QN9mmJJJ0?=
 =?us-ascii?Q?IGJK+40R5UNrmelbox+Pr/sfCtErccMJZkUPKOazOSbVU3EV/oU7fcnBehad?=
 =?us-ascii?Q?OzUJ3DPOQ+T93J+fnzimvByubSZBvJL5fSCSSXZucqMg3cCDhFb1en/isNQf?=
 =?us-ascii?Q?LeVby+Gz/F7OjTJnVoeYFL5n+UAUAAnG0Uin8baeOUbAgkYnUix27CM1U1VL?=
 =?us-ascii?Q?7k5gIiGNTPQwGMni9+uXNq84Vq1ix8Gi3XfX76fW4AfxqDPA+X0rfiBGxLa0?=
 =?us-ascii?Q?K2rjpUvgxJ+GTVEtM+Wzu6mUEnhLIXHs9KZ6HYyKsTb+G6caS23BfHJGclJY?=
 =?us-ascii?Q?U/1BCzl3qvbn2BT6ePMlc0tbeIW9NypbrtR3rbX6PDkV71cQx9WvlbowlyC0?=
 =?us-ascii?Q?XA9IMhgD4PKozKE9KbyRU7BV0wuTreq/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BsriPNXoe/Bre7NH4ur0utEtMhBBz+cYyP2o2aBMbxknHxw3hDSvKhJzOjch?=
 =?us-ascii?Q?HGup+bDrRwENNIjXOZqNHeXwC3YJPLDYhJkhprG0mUbA+sSbZzTm8zkWcksK?=
 =?us-ascii?Q?C0fuJqA3bELfgd4i3cZ537dCMGYDd5S38OOXrE+NEkk31EU8pAtmg8qlwtWr?=
 =?us-ascii?Q?2fixu9rZLQAdBIw5juQno2k7IT9xQrT0DGBFSl20YBZQH7RXctTf6GHeanBa?=
 =?us-ascii?Q?WyNAlZgFSkIj9lTKO1JCXYV+drUb4ZMZcwVrYMBGfUHgNKv/NHP/2ETX5KTI?=
 =?us-ascii?Q?cxM6wZp869wdgNhPwptB27bQGonMyGzj8iWj/4ODfEyra2YZtvDm+T9a2VIp?=
 =?us-ascii?Q?+oPOGZfUP93Wwv99+3EB/OxtwGObVipBVxtY1sdcp3HafrH/KnHNOR/SpAvH?=
 =?us-ascii?Q?/B8faY2LrTAEIWz2guyuWXvxLFaTPpetk5JBloenf7tUXjTEumElJx/wDDj0?=
 =?us-ascii?Q?XnS3JTrLntyPdLsRrBYy10ONo3lN0EvZIyiwakJojw2E8ynjnTO00eiTA5LS?=
 =?us-ascii?Q?cy8stgwDMXfqcHwkp5GutAqGE4lea7BEX+sHHy4OtSq5f29FYOYY4UqlR2zk?=
 =?us-ascii?Q?BY4tBGZqQM3IYDcTyAyLrfhnSDWs1NKv+0eNpbyChzO0uMwyZeqDPF2Oe6HH?=
 =?us-ascii?Q?hIZfZV6OZA9H+7e1AwHw11c2GKh/NBpM73K6uYBhpqejvrSC/RQ9BbTCAsk9?=
 =?us-ascii?Q?ZKQ1fxvYFuTtbDxAYKQTiNquIzfnqAelq7MbNYipgmlGpb4MKo8JwadS9kYW?=
 =?us-ascii?Q?gBJkNCCz2JVaSexYaZ4TXIVJtA+3zFUjyVXDpo8dE4gVPhhkuFTbjIrmKgCx?=
 =?us-ascii?Q?6aVgNKCzbbQ3ADySHIK3d7CMOvaYEJOZXyuEBfWPCBmIlVbo8wNZvIa0eJdN?=
 =?us-ascii?Q?XWZ4u+Jn8Ctk+yleifYXCAeVM4+cranVBDCkL79OypAFJv4oISDnEFHQ8OB5?=
 =?us-ascii?Q?lbvqnTHqrvtI8vY1RNKpbHh9o4Wc3jcGAbQMoY5+M1pwRa+s9Kkely2wWrOZ?=
 =?us-ascii?Q?7p/PwmcnKaqMa2+iZYoPtIkIuwvXyJns0WhTSxB0jF2CznbgL17dy9XEAuCv?=
 =?us-ascii?Q?AJgwVqtL8J5oLyk6Y+8ZlDI3fH6kNtaSLv4SRFDDxfdaRSfABcQ1tuiOyFsn?=
 =?us-ascii?Q?1YGWSylZLioCkW0LUyhGwGK4ssXNI2ODKivNj8+7iddkJ3yJk2eOGqkCLxJC?=
 =?us-ascii?Q?vOp74xfc4Te1kwQee2U97XxeKwhtjVcgO1pvyhiBxcpoBKEggdXlF9qW8EST?=
 =?us-ascii?Q?2oCOMZlHhEq4TRDD7JJQn52fySXSBBYkMMLXa6sDo+Q/IhpAKIcrmQj1ecb2?=
 =?us-ascii?Q?lCbiaSZeYo0nQvJAsHGoEtHKN1+25t7alrr5RijhtyhfLQacy7AHhR8vFtH/?=
 =?us-ascii?Q?V9gpSUtok5krh9TLgPWfLk2hVkjeOx3hYQhbzXBEYd2ZEJwx+RsMlbvmjMNs?=
 =?us-ascii?Q?y4NHM4dfZ+xh96a0PTBtdSBJzVM9k3A2lDW9uV996h3tmnLxdfnbdnLc2tg6?=
 =?us-ascii?Q?Bs9Px3o+aJnJMMxs9ySTxuk+0h4CxeFgDUEucpynAWqAEdG73j670/bM2vpM?=
 =?us-ascii?Q?/H4D2aWRt7dWu3Da/hzqGSR/ex5TOOwN+qx4R34K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EzOlY2/F7rUD11CbYV/Kd9jjMNM43AQCCutb+Tvf7DrFkBN30sekSBplCrdw/Ln+qtGo344iL86U7g6dF90A1Gyg/qCsT+fP9fb0UUxaYS05SXzcDiGpCUNVUtHd1erWJfdtjuB/DKMOb28HwZj61sZ1oiJLGYLpcKR6aM2ZmlvIgYZ9gdV4cyx6tNVuTWaQGEGV6+lywSbFfmCZb/0x6ghN8227/6QbaKhWJ7edLBxDOHh0k20uEFG9yhVel+uDi6UiP+aElwHE2bp8dlsRJ4uBEZrSKqU7L9Wz110224YQ77kxeLGhVjrcknHXMKewxqpD7Daw2KH9eWNdg2F3cOezKDDDIk3Ow1UWrmvTpXp4FK4hpgy8uf2ACyE/5cFJHURUWhu4MengPX9XioWWEPoMO7nZHH6T7emfiGbw+wsAIXAP6NXKeUszxK7Y7H8cP+uFT9z+6aahGsKeVk7D12HnkVMU5Kwg4XMYaZvD3ei8rpmDI/pl3Jm3k772SqCKhLI1pJY3EpjdHa1ikSjUhKXuDqzmarF15ZKg4IJPwqawcChqmQvZQus5nySSEhbFaOFMNGljkUToz7R4uqSqq2Df/8hapsQpUVRdlcHA4uM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1182f5e-1cf0-4d82-9a9d-08de10686c8d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 06:09:42.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/ejkhPQdKCmBnn/WGJ/Dsa1S4gem4ffwy6oD/fXkIbtRdmimbNcoxJGK2r0D9XYcfQsCIazg/sECNQV8XmOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210047
X-Proofpoint-ORIG-GUID: 7risCcktNpQ5iwlNymdXbLq2ZKMgG8ZC
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=68f723a9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=BBR-Z9LqnkxWtvKk0KAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1z2uwJFfUvBq
 53ewoy91MUPMtE2bbBAJYtooXdNyRAT7hu0bDyB+4foob338OAYnPYWNdsSFh2+XhW2Vt+Jya5Z
 m4hnscTQwPBvNZeLpfuqZI/kcj7d5s/MpMFHF53x1jfSaBnT+9/ooIz5sWfJ2DYIQLFWdc7uVSF
 laD9RAxW6HLujIV9e8MlhpGSeCArILKytVi7tW06IvpdR/AFdPG+/NaoiZ/QOdeP4qWmGMqB0YA
 n2laPkhMI/uFT3jDk+Y+p8dFiuj9rn+wog7daFUSjGDnROLD4keXN/Hf+0Q9rlBABSAoSF/VP5u
 yXhus8PH6DNXo/9+nKF1X6iQRpQ44ve2t3R4AEnDM9i2GoAzBuh8HbkQKT3s8yxQp+igeTcywez
 faaGiEJAb+8OWlZGgkCGUz1TWOLvxXjh9CpLRCZ+Wkhe5W5NDfE=
X-Proofpoint-GUID: 7risCcktNpQ5iwlNymdXbLq2ZKMgG8ZC

On Wed, Oct 15, 2025 at 02:35:33PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
> 
> This is also a preparation for reparenting LRU folios.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

with a question:

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e850bc10da3e2..9323039418201 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1117,8 +1117,19 @@ static struct deferred_split *split_queue_lock(int nid, struct mem_cgroup *memcg
>  {
>  	struct deferred_split *queue;
>  
> +retry:
>  	queue = memcg_split_queue(nid, memcg);
>  	spin_lock(&queue->split_queue_lock);
> +	/*
> +	 * There is a period between setting memcg to dying and reparenting
> +	 * deferred split queue, and during this period the THPs in the deferred
> +	 * split queue will be hidden from the shrinker side.
> +	 */

You mean it will be hidden if the shrinker bit is not set for the node
in the parent memcg, right?

-- 
Cheers,
Harry / Hyeonggon


> +	if (unlikely(memcg_is_dying(memcg))) {
> +		spin_unlock(&queue->split_queue_lock);
> +		memcg = parent_mem_cgroup(memcg);
> +		goto retry;
> +	}
>  	return queue;
>  }

