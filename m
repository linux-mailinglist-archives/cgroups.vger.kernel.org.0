Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8C30CFCC
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 00:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhBBXSe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 18:18:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232410AbhBBXSc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 18:18:32 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 112NEuP2023414;
        Tue, 2 Feb 2021 15:17:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sUuBUZeXj9tKYEB1GqqpNJRPCnyRfxNPeiFY6u2bwZc=;
 b=SYK6gr5FcMfUCfLNz2XQuIE/xjfH4goCirSEJQjZlXpCKAGb1gqOWQpSFOJqcI045J0i
 WeT5UHwFC3ER103kkv/A9hLA7PWEHK38K7povn8bHRpwXJ2WM6csk45G7RM2/DnnUIOl
 /x4tUmiVUfZ7Pdi9IYQFJYbmghlIjmcHHQI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36drcupc9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 15:17:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 15:17:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBjo0yd2547MviSYh26QFb5HPWxbSfjgQVVdFQO3nTwTSR8h7L/YESVL+Mh3TB/+1pyOCJXGlvPJvEMNJVkP5LnVLRQUK9Lvx7ebEXRBBHpFuCVQ+XBFXTpQ41g8PeLQrodc4BS6kgDwGA1M27s/8c4zoW60SNXwRXZOSWsWsi+zwLyFytiJIamm8zEwuAt23EPecVRs5beLa/m56XLeqyz77uIgIvNzhxNuH9YRNMywLYY/RcLqnAzho31j+DjGk5RLB2+lHve5dkKjXkkPN+Q5GLjYZjVRLHacvOJrK/14S2amoUgOmNZdphDeaqPcmYC0YZEvLOnTjhNBE+OdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUuBUZeXj9tKYEB1GqqpNJRPCnyRfxNPeiFY6u2bwZc=;
 b=jNMdHmxZ6C/s7xjqIhLdZIe4Ba5ISzXON57nLqv4HDr8kfaBMnRxeU6kKVTKKuYDPke9/O7M0KAdtKFeFE5Ze08tbMwEQ9bTUsWQDSnw5dv+dS2jh1v3Ee6XaI48LsvSKdF75OX950jr6aHzWpFkfn8c62NE4NYu8xhobnFawNfmBJdmg2zEeisH93miFXz66+wz0Ljt1VCisQKNuWyfUpZgzR9qbe8J8aS8WkbK+6EVZquIKwD17bVaMB/0LWXwKHtO7sv+Gm0SlajEN8MURVNKriNwbLpR/myo/0I4i+X2cuXVW8Wo3xh80hdH3gN9ZaTRmsfu93IQYZTj1I4rTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUuBUZeXj9tKYEB1GqqpNJRPCnyRfxNPeiFY6u2bwZc=;
 b=fPjfhOZYqFWjuFj7qMIUGWAt7swnrss5zIrpjh+8EAkJ/YA0aHhUn8CFL1MFAq7FVPuw0knukB7VnB2umm3AF/99wrFvELPmQ8PJFCLaeOvd8X36WGrPK8SkbwcSyIkEf6mKlUMzYgqrUbq0Y88RRI66Sman0oWJlzFGhPvssJQ=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2389.namprd15.prod.outlook.com (2603:10b6:a02:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Tue, 2 Feb
 2021 23:17:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 23:17:42 +0000
Date:   Tue, 2 Feb 2021 15:17:37 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 3/7] mm: memcontrol: privatize memcg_page_state query
 functions
Message-ID: <20210202231737.GC1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-4-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:7ae2]
X-ClientProxiedBy: MWHPR2201CA0057.namprd22.prod.outlook.com
 (2603:10b6:301:16::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7ae2) by MWHPR2201CA0057.namprd22.prod.outlook.com (2603:10b6:301:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 23:17:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a3230b-3826-4306-e597-08d8c7d0bd81
X-MS-TrafficTypeDiagnostic: BYAPR15MB2389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2389FC7E19D9DA8321516EF2BEB59@BYAPR15MB2389.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HLKP79KlnM22z9JudJW1t+xpJhnRX3l57zQm5k9fMRqoQfSO002epdR17smIexxQ8Lq+VdJMcadXCxJquXw5u2kmN88EHvtpBNtBHrc4wGonuVg2rYTbnoMg3MK3huOYBOGmwXiRnE9dx4Kx+WNEhq2J7paxcZrRAp0qlO+/5Vj6VSAAdYX+ZynzOXFWz0RQZ+wSSkIbcgbEGulYYP/aX+yq0IZuJrIYodOnU7tq/nyqhrUTi8HTNKTO5NiXZe1nzBSj1N2BxBUZBIoBFyNyWl9KMIaX4uyuJuc1y3WDsP5NYMD+Yj1Yk8hr3FMRDWeoDxJW58swurMyR5fR9OObPEO1HJ56BpLiBlcJ6eGrLbB/CR2jKXcLIvIcl00fvMg4AlttCSXVStGn+CxDcBGj63ZHG9o8uKxvp7PTJhKWb1WCahhLyfwXoFXWoun1J7thmnmbwdhWobIxcVPdcD3Jmxqz2VlrOK7qLPZ/FyFb1z7FxZ3QocrTYVTCYMKLQJrgsNg7pcBvYUSzQphnUexBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(6916009)(54906003)(55016002)(316002)(33656002)(1076003)(5660300002)(6666004)(186003)(66946007)(66556008)(6506007)(86362001)(558084003)(4326008)(8676002)(478600001)(16526019)(8936002)(52116002)(66476007)(7696005)(2906002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PXyRhDHRKL4RNnf/FvEOXgzsXzhH543hS1vjBCZtGfhRobNxSihmOALFFboI?=
 =?us-ascii?Q?dGYZYs1xNv7bZLOvQ4hpB04pQ06qKd8h7d+Twh0IDHHQHz3GNxVHxK6ygQFQ?=
 =?us-ascii?Q?ruvA6clx7Pe4OEpjMhq0g7TDkskXDao7vc8PIWMOuBPQKARSMnB9Name1Gdi?=
 =?us-ascii?Q?0oO3DdlHcVYMjvOGv/mEJ8CsqH53mwKKnyUM1nNx3PAkXzvk8odImQD44usU?=
 =?us-ascii?Q?jLOoHlRMaw9vPafM+5fiC5kXX1ljBAbGQTsH1Xlv0XHJkf/2kjuVIHgAehE3?=
 =?us-ascii?Q?Q3m+OYkt/fTBwqEo8q7sc2ZZ5NwVN2e5Cn65osjz+Rsa00T3kGcx7mCy6hph?=
 =?us-ascii?Q?iSH2BENYpDwWWuPzFx5Hp0W5Uz+F+o1l3ZRO57FtOryRvGJTlIv4jS4exKI8?=
 =?us-ascii?Q?J8mXAbj8JHb9xt4nKlIIWY6gFpB7Cagy2t7dJ4Q65AaCP4ECZe66cS6MxnM2?=
 =?us-ascii?Q?IwCof+68FxZHBp9EtLovArucbC1LwxyMpYdCiTv58lgpp78uJN2m7dICBT5V?=
 =?us-ascii?Q?CjvaJBvm7hCoO3sBoQQ8bZW1//dU8T5qpyj+QlPZ693kWnak8oVCc+RcApLY?=
 =?us-ascii?Q?+JXxNUWSF+ZUpyDVRVbAbiUSbYuW9CLZa04g/gqv/J420/pYi2hgh5uPpIL7?=
 =?us-ascii?Q?jt5xycOjjfcJa4t4rt6Vad8zBkmMGJezYipLWtdQtntZML5C66LOx3OE7jHI?=
 =?us-ascii?Q?EkcTNdrFDXfc+dMGA6doZDinPCYTahF8U0DJaQjJmxF8l2AZIyv60eIXszdG?=
 =?us-ascii?Q?tlPMgCLQRj4oJ7Ktr5hz87ck7fYfybrUMK83Hmv3lycg4uQPiqIvjJQz5puw?=
 =?us-ascii?Q?nn3kzg1muVtopcp8X2F7gI8KhIzhLkgS5Dk5m7qS6DJDZo8mBy/nKXENADCy?=
 =?us-ascii?Q?LqjSnkGNrrosOt9tlRO2rzk/SI/wjgx8FEokG1f3sdLOdILWdqQGOTlzJi/s?=
 =?us-ascii?Q?uS8X/RpI85I41M3xnxgEMBG9Fph8gd6wGZOVywn9ptsZMlQWkVxekOXbEBs5?=
 =?us-ascii?Q?Ay9kxK3CFOZ0Y1gYkLLX2TJ/mjduwIYNSBqtUsI04ye1ZxzDaFXDXI/x9JLx?=
 =?us-ascii?Q?enASWTxKXrW/AnVU2pUUm8QXE9cn89q/2fSfQ0OOjW7K/RBZtyA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a3230b-3826-4306-e597-08d8c7d0bd81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 23:17:42.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c3lrKvZD/CylWoejY0Jz0CzsCuWsAtfEfG+QmAmDn/HU3/Z5vsQMjNGwmtk1K2L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=713 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102020148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 01:47:42PM -0500, Johannes Weiner wrote:
> There are no users outside of the memory controller itself. The rest
> of the kernel cares either about node or lruvec stats.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
