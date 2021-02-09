Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCD3157EB
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 21:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhBIUqQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 15:46:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233554AbhBIUhc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 15:37:32 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119KKneR009967;
        Tue, 9 Feb 2021 12:21:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rQZ+1AV1cqgvwWTAojFxcAp22b/WbMienHTZZOLmlaY=;
 b=QJVbSMAnSwX4yKvePwDX/odVGv7p5u7kr545GNN5ZfHKbeYpnKRSZgjomhmNzYcqigjH
 bmMe20pTM5FXa4n60Wd5C+39ZZuWVqLfBmfwQUbxmQJ9i58qMFgDosafWIFFiJ4LwH01
 wwuOkxKxmFLsGnEftg3r8grleAqXHLquYg4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jbnp5d12-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 12:21:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 12:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjl/1wSTkgRs3szKbXKMNqcRhKzS69pCSIg/xOHauW5NrGOkVLDapbA7xxIIoY/Fk5wGegTu1CK5Um48gTZjC9mKJD/VPgqClJDG6aCEdt40/ZzpwSP+ndGu51Jyvf87dQIW+PKtT5q1DlPfQFtzUrnkfTBAqaLI9LpUQ5FdD0WVVZZQEW6s5EY6wSeBK6wtybLAFPlDWx82S4YtTVVR4J/TgfyxX+Yln8uMVxt5Kr6RNp+eMYAeNLYuJuBKmdPOBU7rYxFx7U0DHdSzGCBiaHChjJLrlrQ49FSH72qH2NNSk7j2AM4U30Cp3+NiL/KjIrmnmJ3rY8yKUSj+iRfI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQZ+1AV1cqgvwWTAojFxcAp22b/WbMienHTZZOLmlaY=;
 b=GFq678sI3qYop9ZFfPfNjYpm/9JmAsm8lV9zOnol/F7X1LcCyLclmnZudalMYQjkfmaafdrF4p6opARgGPanyGi8GLhE5AoMY7GA00PelznfNsVDshBPPndwGa4hfBETwAnBJuVVrr4Wafwz3x/QiGgwwFAEXleyIC6uFDnYBUGxrNBmEcS0OQCgr3Rbi6xie1KW4FhoBwe0NY5ohVD7itINsR2XACHOStGqYcn1C4pWUm2ODWz063yZnhveMPhg93MP3lGCb+R0+utPCTTaCw0irbxPsyfapsxHgNA1EugRrs5dbeVChPxciWYnZNQEgzKarD1vZvC7DNgeJ+KVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQZ+1AV1cqgvwWTAojFxcAp22b/WbMienHTZZOLmlaY=;
 b=FVh4sxX7Sf57gDlmV3Qym0WiB6hI9ljKkJ0MYPJv6ChWTFYW4/FfghaP/ZQkNaIej7tx4sPEnf9em2aohR0/I9ht4CJGtxCK1bRNrjOsnvNzFrAba8+g50bP/FYg/ERwYBAM/jdznDTx4+GHQcpx+8fF/xmnJ9v5dbtfyP95Ujg=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3555.namprd15.prod.outlook.com (2603:10b6:a03:1f5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 20:21:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 20:21:31 +0000
Date:   Tue, 9 Feb 2021 12:21:28 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v3 7/8] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <20210209202128.GD524633@carbon.DHCP.thefacebook.com>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-8-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-8-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:654c]
X-ClientProxiedBy: BY3PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:654c) by BY3PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:39b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 20:21:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df7c0a17-6857-4c48-ebd1-08d8cd3849d2
X-MS-TrafficTypeDiagnostic: BY5PR15MB3555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3555DEB50FFF515D2DDD00DCBE8E9@BY5PR15MB3555.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnJFDe5n9l3/n/UFnspSjw1qaOL8NmOJG8PSQffUV1743gPoHr/louyIOmITa5o6pmMl3p1XSCqzwgBZsH3L2PGAfrFxXpPQkaazxqyaMQE6RArmnfVsVUcgOn85NYEWDgD9Rp/BvTedmKT6QqxlUJFbF99qGAvzdrbKP7br2ubmE+Rz49mEBYbXstIAQk07hOrgb6HKsoZGiA1k4ExkGTFoKep2OKrG7vDNYwbqXZTfkbIYJwtI3mJXNH4tsm2gCSxUep1FhPezoRhmU1E5jzE48faQPPLZRFrozZWc6/XAHNQEmZAE7Im1mF+MZpKJHkjMCVwqgEgYs5t+kKzE24bt8TaLunY2pqU+stmCjiYvtxg7Vv8vvZ9ac70zUt5sVyyMU1ckSch51J0+ohDAsB4MsuCJ6m1CZ37hv+L7xtFp/23MSZD7E0dCv2PlcbhtlYRPjYUz+GIOAbfRE/kNlWotNGCRh3n/t/hMfrnUFp3EcrPBe+/LD4VH+NesCBkjzJGQUYfp1jE2GSt9IAEEWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(54906003)(9686003)(316002)(6506007)(55016002)(86362001)(4326008)(6916009)(8936002)(7696005)(66946007)(66556008)(66476007)(52116002)(16526019)(186003)(4744005)(1076003)(478600001)(8676002)(33656002)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?++gIJk1UiGyFYGhNPDhYVq0B+1HSn9t+gVXpykHIhFgrLejj15JM9R0V4UAU?=
 =?us-ascii?Q?77Df8DfqAW0catDoymPJ7NcdUp/mK4NNvPYPtHUoOw95vB7WAdNMwaxSucql?=
 =?us-ascii?Q?AM0iCO+2EabLDS1f3WFhSvbOUdmAK0IOoYJR0r6K+AYORQfdJy94NXDPog4M?=
 =?us-ascii?Q?8VqblkOhr++BE/D7u8+kVhZmtUlMRidZQOSEHXtMeTxUTEl62Sen53lusGTO?=
 =?us-ascii?Q?jZIS5JS5Js+wU1Fsr3yt4rkmlkF0VL+qs8FpuCo0YNbyk+DD6KJL6nzaBBFC?=
 =?us-ascii?Q?Wn0dqKQ6GRjk5aTMpMmyWncwv2fF5wqLL89jG3t6mbvtJjerDcJ8j48Ct7S/?=
 =?us-ascii?Q?Ay5cj2sCy6AlLtEGRux1qkboNcw2UIA8b23vY2jlJBlobhmUD8uPDWOGvNvB?=
 =?us-ascii?Q?+G9VuPsNnk0aPQbncW5L3HrBiFuTCLy3PUxkfQOOaWqMPy50s5gK9JDg3url?=
 =?us-ascii?Q?yC7x/Yr9qL3cz+R7UArL2GISv6vF0vBqZNvS205Ut+q9Ga2DOsiNxoPvMDCG?=
 =?us-ascii?Q?0h8o/OywFnUTIX8sUr711sRQJo79JbAktDGNladAiqnzp+8NzfRTFQsMBEoL?=
 =?us-ascii?Q?H85Xr1y1CC88t6JuKzxwjLgG+ld3iGqQathbCPRKCJOKnh7kTv2RvDTZiwRI?=
 =?us-ascii?Q?hT67jHd/IbD1nVWRnn9Sm3sSnd3XnaDnVDNCLcNwxqVUg/gPcO9+mPXEf9st?=
 =?us-ascii?Q?IzEfGezvC3S553s67p+ezOn4WtDOCXtZ5s+ENI9+ru9qHWabpiMQY5+2AfJT?=
 =?us-ascii?Q?Pv1nF24RRDslvL8ZPqmLQPTU8Wmrn79WXkUzHJTZHq+tZPABtJM96w1h6gKW?=
 =?us-ascii?Q?WrJ1wMvyaed26wenzM6eVJps8gNZQtjs1yG5MgP6dlqf6wAgzZaly3CyO4v3?=
 =?us-ascii?Q?3eWgnGiJkDUbreuY0qd52l2CZabSm3lM/Q8bKitn9ukOAG5YxD09ecWlDsfN?=
 =?us-ascii?Q?y8wUiNp+oYfeeYxguokTfuoqsq2/7WhQCIPOac3L25sCUulCXBZ+Ugfb/Dka?=
 =?us-ascii?Q?mAT7Ww5u0WPWrOgbXZg8eIgdkLbVeqg3/8JuoULdvZr6RM6KZh+0LszS/Gbm?=
 =?us-ascii?Q?5aTtbT8EwUlDoAlNCjM558WIm74wj4+Ssj+ZfqHzq7V3ldweD38DxnZUEBpQ?=
 =?us-ascii?Q?un+GO2/UDkhlcbVFQeksw15MlvEp4PUGMVa5rBPmNVtEz1vv/QIZ2yE+LV9O?=
 =?us-ascii?Q?HfZ7G+cH3TceNujrTp/YIgO/jwiWEdzbKaTE4rl5ptIdiIdQIi3gHRQjW73/?=
 =?us-ascii?Q?o9o4DVWyc6+XIhvP5c3QJeQMyC7SNILj8NsZMFlcQuGM4YRouaoO8W5YuXbJ?=
 =?us-ascii?Q?UhcMYoLTvzj8UzMp30ngoSDD3OtMyl36Eg6JrEr0J51+og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df7c0a17-6857-4c48-ebd1-08d8cd3849d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 20:21:31.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMV36rv1ZuZvePpVrfemuBLkTAorqJ4ne4HeDWiJV5Yj4BrJaUWxuE7hgLjbDgDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3555
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=695 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 09, 2021 at 11:33:03AM -0500, Johannes Weiner wrote:
> There are two functions to flush the per-cpu data of an lruvec into
> the rest of the cgroup tree: when the cgroup is being freed, and when
> a CPU disappears during hotplug. The difference is whether all CPUs or
> just one is being collected, but the rest of the flushing code is the
> same. Merge them into one function and share the common code.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
