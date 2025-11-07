Return-Path: <cgroups+bounces-11655-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE3C3E2B1
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 02:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4CF34E4105
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5662F616C;
	Fri,  7 Nov 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e6fM3f9B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bLa5Cgoh"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D4548EE;
	Fri,  7 Nov 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480543; cv=fail; b=q9wztEqH7R0oPdtw7QtvWczD1gMkYrpBELR1zj1ma1it1R6P8Nh0Am+e2FsHsVg02bvzIuMTmjgIyJLV9OF/Rpc+G74TZ43bRlZbs9EJH08RgLdGJLlZSOM6mLnfC5wi6p8MI7uuey1satI9q7MSD4vyTp2SfxKMumjcJ/TGevM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480543; c=relaxed/simple;
	bh=hEHhWwj6GHcNxWUHd2UrBYOhLXEW6vujwVXsEyqYxt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ohSYQ2GwUn2aRLZNrIgCL5M2FOPg/RuCb2QH+0PMJ+nLueh/1Lu6XiAZ48GBpeeeYN+wgWXbfniyIzBDuVc+AVPA6PYD91B5Oh7oCwi6VV/KjX+J7joTmNl4mXUiIv7mfyW4aoUtYNn6Hrq2P7oeCj9frqymQA3vC49mwoWYISY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e6fM3f9B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bLa5Cgoh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6LNi2v017685;
	Fri, 7 Nov 2025 01:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dz9YTdqO7UcDiKGFi9
	pokFvh+2p08AG3TcrntlhgPQA=; b=e6fM3f9BpVzTsN60ZKlenyzYT0kis8mzmT
	Ye2Yqi7m3OM3EQ0c4BC+EHpc1PcBsA5OD9RKt4wTRk+h0kjEpWtVwfV3t3JMNjJF
	agEBFq45RatRP2VbD7CSTvCiiZUC5u2OHEL8CKq0+RQbZSQAZgavW4gOkucHE+P+
	EksYI9A+XfCti+24eWZTCRj6ObtV7gU+LsMt+eMCxE39Jr5L7T8Oz3lnX93ofzr8
	wnDbJC+AgvRzKCKmQinCHZmV1dRGRHHBjgnIuYW+yaqegAYBhAYHBx4rUTbdZgKt
	AeCqmFg1EQSE707OfMhqf+lbm6nbUPA9jzHFx52ep9E5cjHAPNaw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8ytw8v7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 01:55:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6N06DF035982;
	Fri, 7 Nov 2025 01:55:19 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nq0m71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 01:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArAB8ZIHqi8oQiM8tM2KTIzWo7wceGDFkYW09I/Y6EL48rQemj+qXYB7zc2R97YCtkrVErQttZ+bb+H7py0S3NGU03D5EzvwE9FAk2LddfsRlQ6uc90iPVzoD1sGpa/wF5OhZEtGA81N9NVa8G3GqzNYeDuvTbPrXCpim7QPqhMicMParpNC5QBbwiIAo30ZXGW+aitUDIJHJKvCUgzUWdQGsOtilpF42J7bV4vsQomkF/83ImA8+Ut1gJMM2rlazBNTOQ9Fvh0p17LAWcNteOeZduW08HhI0m6fttuxVYkk+vaHqo+9k/dkL6lc3yfPVgxTV4uq4HYahNaigioYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz9YTdqO7UcDiKGFi9pokFvh+2p08AG3TcrntlhgPQA=;
 b=geg5msIepFQcNGeMLqh6L8YHejzUodjegFTtE1UGczrlIEF+vHKtMr869grn2HIg0GS37qck2GG8/vK4gtSHeONiupXxixI4KkfVawVWd6jmQSoNLsDs5RTBMhZSaW6PPURPUtra15YMPFgtAHDXSnzGDV+Nf30d0mxmLoxJHCF538/M4DybhkxbmXqLRUXwvGBDESa/F0CbR3OuleuX4IR6L1QAdiOi3ZVz5LDKYjHciKf44M/GEI3Z3G1GRoGOh7z06V70Fp163xiIXWUpyDqvzXauvxh0oRKkxuGyjx1Et5f3V1L2ee3DVntBbugUvUgKI5OeNsCz2VU7KYjinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz9YTdqO7UcDiKGFi9pokFvh+2p08AG3TcrntlhgPQA=;
 b=bLa5CgohhOnO+uhae3+eeCq6bOFBT801EbqQbolzwgcKmlmG+SUQ/9d6xQObTah1g8Q/FZD1IHl8lzcq81zcyzAXIkU3HA182x/YRNZPxsnay9bF/VIrv6oFMWQl7kx3PpWiVRuNlNhqrianOo9YhJlYnXLMI5SWIt4E1Q1HdwA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB8219.namprd10.prod.outlook.com (2603:10b6:8:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 01:55:17 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 01:55:17 +0000
Date: Fri, 7 Nov 2025 10:55:06 +0900
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
Subject: Re: [PATCH v1 02/26] mm: workingset: use folio_lruvec() in
 workingset_refault()
Message-ID: <aQ1ReoRlI9J25p4c@harry>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <02536beaa78aeaafcaec40d4fca42ccbbd9f8643.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02536beaa78aeaafcaec40d4fca42ccbbd9f8643.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SE2P216CA0035.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a6b3ab-f0d9-4887-ab77-08de1da0b309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFc7rOAo69mIFgcbxEzdpju/g+8V3Y335W4s/Q8ozy8PDqZPHaF7NOzKAboW?=
 =?us-ascii?Q?tkoiVEKH9lbZyMKerxJ8xaWm19f3AhML8TUBc6tqAVSt++6pWsb2eIXczmH/?=
 =?us-ascii?Q?df3v6qKj+gPIqxXpCR17JoQtxO5zktBqk/Ph8mZ8U6XHcx61fo1nOf+cPQWj?=
 =?us-ascii?Q?hKPTinirMDExQRON7FHJxwjOGQBc6qSv6xhpEPwgeiijOWmnPpMoT+TCIe0s?=
 =?us-ascii?Q?Ai0vxMb3IQFpqSJgHwgy9Y2Lde3hgm7VHtb2fozUeMgbYshfrmSjBZWwjSN5?=
 =?us-ascii?Q?LrCzUzx9MqvygE0iT+weGGV04m10u7HwFBmIBnvKedroOFzCsByi43CVV7ia?=
 =?us-ascii?Q?dwWCJPy4NOV7xIyBu/24/b705/Yl6XDJ6J5fkf7gcbXrB8Nl4G4qv5BztUKm?=
 =?us-ascii?Q?Xnt+JS/HZJ5DKD026p+CTTFnGEzgo2GczdD7t0/l78Gk4Qf4mf67mq6GD+Zx?=
 =?us-ascii?Q?ixvV97GlS0UVjw/eeB1gNt54VpFq800KGLRdHGJyXqkJPeBmF6hUFZtD7poC?=
 =?us-ascii?Q?jpIqy20oJ8+3Kl2tqtLFf6dJdD20LZWU1O/IwKDxyMv7DVr6Oydo+7sj2PlO?=
 =?us-ascii?Q?v70DhfpUGP7lXfYZEkD8rwQNX3C75OSi0Wpb6riQjqIIziVUk9DGRygk2a7r?=
 =?us-ascii?Q?HYIQuMW3gLYixlCFTRxxtLhYpo6AYN5NYgoI6fjpNZUe/0ayNJQtOefK0zUd?=
 =?us-ascii?Q?3TIgH0R3ZFNPh0Hqq0X2VRUm54EKThMxGgze38PIR3lzPnaVt76wvoo58tlS?=
 =?us-ascii?Q?WW9+e7w7q7CJWJHfYbdL01ognMe/p8A4kBLGdvwU2zKw/wJzzZPfJag2U13C?=
 =?us-ascii?Q?C+9OuGKmQXuDH1bxr7OLO9WkoxLOymHjBhB0WlFwDWDw2+djbuYRBAZeeL9x?=
 =?us-ascii?Q?/g952j15X32b1BaluipEPMBZXbiOq/B4FQPG9mUvWxvD3231dM1JiekQtYlU?=
 =?us-ascii?Q?D+U1DL6d150PJSBpLNLyxYI/jdbSRwv3/zB6tSQ4D7pgIN+5eSRfUzMvTCdV?=
 =?us-ascii?Q?VH+2i3FQRMXu0MOuOZJdqEluEOZciVPmpILKXQpgwl5RSCD4LI7sPrO2S3n4?=
 =?us-ascii?Q?1JvDqtfxFu9sOSAeyC3M55LDNCZyHs5/0LrVr/WvGAwgHvzlTgnYbU8o4ujR?=
 =?us-ascii?Q?BwVdioHQ2dVb5M3lLwEeaQDYYlwXuwLf7aDz5UCyX05ABeclsIJrqJZpsc6t?=
 =?us-ascii?Q?b7xIy20tvo13bfjnwHeNAxjMoRv859jTa4RdhdJ3bHOEnOQtJTnPo4VQ+WdH?=
 =?us-ascii?Q?StqhHJGDqLuFfhCtxkct2HN6YTUaGulJGETtTc7Y9Dut42mS7jyqT8FaV9V4?=
 =?us-ascii?Q?66oi9WFW8Z6yR9KINnf4ecDVHZ8aW4ap83SdpBvY4NLlCwqHWjcC57AqqKFm?=
 =?us-ascii?Q?9fNTDweRNmyjGSzsi2YGL2jvFlXjBjdTbDKFPeIlPCADmZftKj63Lgrn17Pb?=
 =?us-ascii?Q?NwvbXKKxnMOhun7gDIJtegC6Tm7QxKj7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Nh+iq9fKAuvkKYablnuurdETl+SnVHxakkSbk6rEE864wWSaNpwA0ccWsCB?=
 =?us-ascii?Q?9RW2wDMKdbahNBUCcBXD+oZ25qfS9y8vzkKHZrowejBETJdwFTInKg/13SoO?=
 =?us-ascii?Q?h6k2sqFnxDa56bVFQ5YURuHmgu1d9jtzCzkjFXB0v1NcHESYLzbXN1f/hQly?=
 =?us-ascii?Q?80h0J+rGqYHPmXbDyGUz7uXlEltf8TsVRmWGqWgdMWIIkFFZ+5R4uhzGix/x?=
 =?us-ascii?Q?+uuwHoqfLZhBaEGH398gdYc0sItPFINTN6uWR48/fJRyvDxDUu+KgEp6kh2w?=
 =?us-ascii?Q?Sat19jnO4kTJaR0P9sUXHP+N/uoJC25MTfmSRHTluBRxkYccHoP3bvgXmZNq?=
 =?us-ascii?Q?o1R/mrORRycwdKpPDKiP25xzk1zofhy6YQ8K1tej3f0nue+HP9v0zvWjMJff?=
 =?us-ascii?Q?sT2YA594gmle+3tSkzNXtk7Ck0ymJ3rQkrHZTny1RKLHksFespNvm48d8F5j?=
 =?us-ascii?Q?ZSp0519kt5C2phAsGAW+6pJySwpqO63GNi3c0zh5PPhN8g5lss/suPwiAqyl?=
 =?us-ascii?Q?UQvOlEclz2nxZiwfxamahjbZG2yQWgLw6Rg6Y1sN3j/HJzksrLublTbB+U/p?=
 =?us-ascii?Q?d3OJSblhc6BvsJ8WpGQGlC3zGXKXQtCp1/+TLvUgCeLlAbw/5IEaK6Eyfc4v?=
 =?us-ascii?Q?+fbhR6ZlnD0vczqXO4Il04n2CJ/j6vP0AijNIIPiJDhnBqYyZx3iE02l5/Ak?=
 =?us-ascii?Q?62NVsO1OsvQeN7uxtT2083tD27VbD1r1p+djuNexlSaeYz0Tqq3Js6ZX+aKj?=
 =?us-ascii?Q?fwV3YogTHPfuDhNxtjZmJnvOUT115/uZEavlVVXNtwnlU23chNy/wrc4tEGz?=
 =?us-ascii?Q?5m6oTMRAYNy4MRFJB1sDTwvw9G6p2ByiLWNR5Ae7UiDfIbLMUPf18mBERXoy?=
 =?us-ascii?Q?rUOANBjXpi2Qf5PjSRLGNjRHQoFsrMckhTjKrzOhnXdDcDm0QNJTuaUJKwS4?=
 =?us-ascii?Q?aABg/sT2YUIMgcWZuCUG/mXcULNLadJtuk1R6yZ6FluJEiiN2EXMieSCbZwf?=
 =?us-ascii?Q?VLGMTWOrubhi4maVh5+b3S890onNfxkejcR78JderNyvgGZUk/5aVliZzPt7?=
 =?us-ascii?Q?+jSPx0T00bXShdvwbSrb0y6GmQJA6XvBBAYZUZfDBaXUB/RK1fgoX/HI1hqN?=
 =?us-ascii?Q?JKbGS2esoF37M2GCpVHlTk8npoZWOuw2szgL3M4voFPmJPFkyZZXkB+szkot?=
 =?us-ascii?Q?sabYXnLy1waE8FdfBrmZs04v1BBowPQfehFSjVYxFCFblouTByDJTD0ZqCkD?=
 =?us-ascii?Q?28zE33QoxhWDXNiONBXW8EWTCqJbOI2530aiGJ6hq85qi3aqIcPacXv9mZsu?=
 =?us-ascii?Q?rZjlNZMtEcvp2+VnRtNjCMdIY0WZUtVbZ7BbQkMQ+AMxLrzmJOzkOdinwWP7?=
 =?us-ascii?Q?CqjvAitwNsXqh/jpumotz9Dn8FZ2+u1BDdEpCx2vRV+FNLM85dnM0AaAS7VE?=
 =?us-ascii?Q?Hluhpm8iae0ohPvW/7YoclhFU/HLOG0z8VedzkiZ3Oc3WqJ8/Bx5v1qe6iT4?=
 =?us-ascii?Q?VxO3KgqUEAr8tGsUfQNPTZyk7/+lO+ELFD5+TvmUYb3eJK0CYJAqzrfpdNGR?=
 =?us-ascii?Q?PXuQdXomoP1rPWwuLoP/oYdum1jKgt9IHdKby/andRnjDSl0VCHNVmEOZxlQ?=
 =?us-ascii?Q?AwLwsNSDOHkYLiZOpNah960gJBQYycINbALAo3oGc19I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gHsPiyCshk2uNpVwOSjRzW4V9VvyoYm74GSW/QmwBT7RPW2ms+zjKF+95FWeZa0ZUCj9mlpHNV/VKiKsoplcmwR7GSSe7XgHKtHjy/CUaPmKmPkEkhBzZrhwHhBGR3/+Y02qTiNSAElgH7t9oF87IB7ZVVn5XezK8/WWAZAo8t0fDMkQ7J2bjZHEaymjWKFj2BIEPEqP54ktttYVTbVgUddXFZI96AR0b/nRfjPNiwlZ/VmTaDwSF1FpN5VMUag9XjcqUiB1eWVz4x76GCVws9YjW8Qh4oTdosuvMREPO9w2Y2jNSmHiID9UBKRDmzW6gMuU3+fZ+3ys2Fjh0kz6BTtWF3n8iV+hprQSeIOkozQRz7kWScCmZfD8EePmRGo9n2durWO1ydspr2QAyKVbJCWQx35k0QQ/mZQGpdnp7N2ecoujM1GsamC16BUR5incclTIGWNxqHbJ73nU6OQGXE7HqIWUgXyyLKKzDzBzFmOOTuTLGA3fAQhQHCHPNDe+EhlM3M0A5FJgSTD5QXXMTmtXPwY/IxBYXfZIjUwdSoFdGtV69FEUr3DUiiDzK5mUG2UlxhvZ5S0ObAUAW+NymcCGPkNAd4nvWNyPh42Nyyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a6b3ab-f0d9-4887-ab77-08de1da0b309
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 01:55:17.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mqVffWWgU1UdfGsvFsi5wAKu4jGWIfuFMiutpBEyV8TxALUB9hlUbNCUlVU91y/hhLXL8wxnq0KzFKTJrGwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070013
X-Authority-Analysis: v=2.4 cv=L/wQguT8 c=1 sm=1 tr=0 ts=690d5188 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=ufHFDILaAAAA:8 a=yPCof4ZbAAAA:8 a=hMMI0poUion4MMAo_soA:9
 a=CjuIK1q_8ugA:10 a=ZmIg1sZ3JBWsdXgziEIF:22 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfX+3ZWRHngtWdx
 /ZQi+UBt4pPbi1hdaEKC6B7buW7TroMwEl3MggR+WxQa/qnOwRdpaw0FmIgegeXdf/8od1Fei5Y
 K5yZ2rDHbjrCJwBAgKmdm/5jIWm02Lp2h+PA8YfySfEEvP1um1Dk7UyKNeF8yCZbGm4IhYWjVOX
 PTOudD38tO6/qbTQOM9sHzuShBFviMxHSFX3UNOq7TEHNylGjpjog/sWp5EJa284I82P743ilYM
 gSg8RYTyoTgZSetaoizSVrPID2UdzulMn9N/kbtnksSjVObLZgLv44gkukLmcKPn2yQqvJC1zEW
 8BHx+zrdgpxk/o4adPeScGFylVB8nSnK06zZOHXqbba4GRky02WOJrWj4LYvlD6D2hxA3tH+ToY
 Bth4Gq7XqE5ObrucZw8KKM1PKRurwIfWzKyEL8Lr4y5kD5sSMFo=
X-Proofpoint-ORIG-GUID: sfSqB-cKdgbtqBg-Z5VL8lA4qWAtqy65
X-Proofpoint-GUID: sfSqB-cKdgbtqBg-Z5VL8lA4qWAtqy65

On Tue, Oct 28, 2025 at 09:58:15PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Use folio_lruvec() to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

