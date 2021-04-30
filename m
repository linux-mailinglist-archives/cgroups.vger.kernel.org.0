Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4436F489
	for <lists+cgroups@lfdr.de>; Fri, 30 Apr 2021 05:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhD3DXE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 23:23:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230011AbhD3DXE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Apr 2021 23:23:04 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U3AIYw029919;
        Thu, 29 Apr 2021 20:22:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QM3TwYOmgGt8gt7A54p7wXFWNh2YZdFv2N9SQ0DZZlY=;
 b=OTaDRaQkhkvuD1/3zGSq1g5WfTs3cMAaQaGwFhQnoJjmLJafrEyPg2ySc77GoqnbdIOh
 JWZg10vOr6JW+teKUy1aew5Iw5UbWIefABk6dARkDVfPGR/yz+VCKi23IwzZxPt9jyLX
 Et1eTHCPXc6Bq5u80m/FlyS57v6A1d/3nrw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 387udunafj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 20:22:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 20:22:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQu1hXo4p1CtnXfipPWTx2S8IJT3DUaz568Vmki1/L5nk7OoTf3nH3zpecvCW/nlbxrYEK0ap6OPZs0I13ADLr9cG8+MbaqOsYUI1GG6qIBvkNGPW7JMCM4EuPp0ZyTdukaK2y63XFgHOBGhboK2Go4YDQkAd5to1qoSTxraurSM6mb5Lj15FNQhMM9ZgcZtpjJfsvb/EuOidaGeHySnTCLl627BaN56SZI3GOrkLHIvIvy3Uk9YsQlHkRLXBY4F0MVQe3pG8WJs2s6dBbX8rArY3TfabOYGltdhIbMlq1WqUk2h5lys2rbssFIj8iNPMkYxhsIKGrw+RtrJfeBVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM3TwYOmgGt8gt7A54p7wXFWNh2YZdFv2N9SQ0DZZlY=;
 b=QW+kKnOUxmh6JA9C0fBr554QaTjyImKodRdNBzA2UtXi41dkKA8ATnE7n1EJcSzZgnGne6g2XmT2MfQnOk7ScZUdVmnrgc3+Ei31V5Esm+wu05lTN0S+c70lill19/79N2DD0JKZ6mY7tQA3FkJLBzMxTk0gc6tLVdpE7EsThtLGXfNZUxocPkiDAkxBQNUB2abx+sRVJ+tj+L1vPHNq8mOAA+BUCySt/LMYUG+zeTIybSDlMft8t9mR+oAgg8tLYQXRI2NbxX3+vtIIGMXb741EnV777psgbKsujlJ4pS90kJZPCHaL5JKfXiuNvzpUqU8cNZZ4yIXkahY/+tZiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 03:22:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 03:22:08 +0000
Date:   Thu, 29 Apr 2021 20:22:03 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/5] docs/cgroup: add entry for cgroup.kill
Message-ID: <YIt32/aQJfkw53ic@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-2-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210429120113.2238065-2-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:faaf]
X-ClientProxiedBy: MWHPR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:320:31::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:faaf) by MWHPR18CA0034.namprd18.prod.outlook.com (2603:10b6:320:31::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 03:22:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c09eec2-2d1a-4be1-7d7c-08d90b8722b1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31410AFEC62A2A012D2FAB28BE5E9@BYAPR15MB3141.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lbq+46qFYcuAWThumKV8F5/FAvZYmbB4ZRBYtb2jBX1KNI7S8nuLrSgPZtlu5ZFcew8aFHGYijH/i6Hog4W9kpgkA319BiNx8fbyd92+y/mTpJE5x93UgBrJXxVJsMZ/Gu9d7bG6NXs5IhVmqzHPpIqWFM0896mjdG32AFyuhatShohF8sk1ryd/0AcLRXEjP9hZt3AkzEuHd56S415r9r2R59jGZAdoz5CKKI8w2wpbP4HoK3IpfSi+WDKu4efmXG7ylfGn+Ba1zeprzKAnCbCF1QMiYPgXGnbFoDBx4CGBfpBGbZPhKENem+ORa+QKJsupdoX+WUbyct5e0TptbUl5ME30zJWm9J1HpxPT+3Wf79XHoFCD/kki4S0PEiwyTKxHJm2fAbp8kFxnjcegUtzYaPvEamtCSzDLQog7q+cSEkUl2X3wcPf8vv/2gVU77zoeN8xYxmtnEvQtrtVOWY4W15bGzOvZwv7vP8e16plwPeHz5pWEeaBgfIilf9RdhlS/RFC8e6lpjRTa7gSER4SuaQiZdhaUgF+3YRNUAZDX1P/z/6l4EPSV+32R1gCu/CSMuiUYQEnPrlCfuq6dhEboHocskixZb/idVteqPAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(5660300002)(2906002)(8936002)(316002)(66946007)(55016002)(66476007)(38100700002)(6916009)(6506007)(52116002)(7696005)(86362001)(6666004)(8676002)(54906003)(4326008)(83380400001)(478600001)(66556008)(16526019)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y53St4CAWdZfwoEXkI6W2zqmTLFmVCLlkcUeZs1ZuFp14hDQqdO0YeDv6Imk?=
 =?us-ascii?Q?R1kzWKgsL70DQgmr36OcpFMrmjND8ifaVTfnmYu/9zzMLCD7HoxdoJD6V2rD?=
 =?us-ascii?Q?QKkBXeCtwTHzWzWFdByEp/mlkB67Va2A4+B+8Ujcr/DKwMHvNDSmSJi8+kPd?=
 =?us-ascii?Q?mkFVK+Rxcfg2HsBPtGkOHynHpx8Lf82xWBnQ/WWMLZ9InV53NAgkx9f1EX2W?=
 =?us-ascii?Q?yeH39pVPxz3n6KHyK8OIOpTLXkwnWFaOnAzWeuLcTm5/y3aBsQRa2Wg23HG8?=
 =?us-ascii?Q?ZMum0memh0JqXzS5HgKkABhjHxSorGpR6KNspIwpId0XMUKnXnlVK+YROFhp?=
 =?us-ascii?Q?IZuE8WTl5cL7zTD9rNEBszjuu+TSYPc1k1+zsfQ/5zYNIyrpbsCJJmJ+UkcV?=
 =?us-ascii?Q?ATbiIySFh7nJcBaieNgP8FqwvArznojt2lx7ACRV4IkB/21PV+MlxVcx0ytF?=
 =?us-ascii?Q?dEd7qV//dwwnhUB0uQFQf9/c7izka7UEtI7/2wGWbtwXJCeo+4UE4RYTfKgD?=
 =?us-ascii?Q?HNe5rWKYPfMIiLlk9guBT7CWHPNja9BMKiLDLi0egvKQhKaELuExz6D41BrS?=
 =?us-ascii?Q?RX2B94mcjh2NwKNGL/izMB8YLPAMzvbk9VskOg4mWYGgLQUnZxIsY1JML1t5?=
 =?us-ascii?Q?4QY2LMr7S28uItPAh/0bRrrVK7Lr8otQaOGEgMU05GtMEYHNEiMtut6AutUM?=
 =?us-ascii?Q?maPXpIwQ/PXArk5CnFKEIBPK0UMFxxaPbV7DFNwfaN6LTDVd12a18deN+9yZ?=
 =?us-ascii?Q?NaEDmOU/5VYeaLCckyALZulhnBLN0I6fgAFIPTR3ffvTyfsJV2oAjSyhsl6j?=
 =?us-ascii?Q?5MsPZVbVvO6Yddk9M+fjHSsLu+Cl2rRKJc+m/odLLZlBuQL+Waua46sxlc/6?=
 =?us-ascii?Q?VZlwAB7rT+BndEVPPAwsSVLE0Y+mh7fi9bK2a5bKA9mqIdYo4ZhMbRar8bbB?=
 =?us-ascii?Q?ddK+6FYbghYJJJMhF2yC2OufmsBJdcDfjQEHMn300hnKRQJdWT+iK1kJ6rj5?=
 =?us-ascii?Q?dTrSsXu9zJozAXBIyVDvT26GVtXeEDGlIlk6fo4AM44qruP/VamNBNEZuiLP?=
 =?us-ascii?Q?aiAptIvtoTwQegyItpU3OIb3FoJYxz3ABUbjAWN9vYTMFDVeqn9G7lQ2QDZK?=
 =?us-ascii?Q?aBaQZmsGGI8A9sfbY96TS/BDIoRa57Drw90VcXCbCrbFQmRAjvewg+df/OhB?=
 =?us-ascii?Q?K1mIGZduUB3OeSEmIGxAEYXrjCwX6xGQhqy7/ape630tTDeq3vWYq4TuQj1P?=
 =?us-ascii?Q?wwNjxllM5XMRePgbtMsoFmI68NGZMmAeYoNyDx9ZNo23QF/3xEbfM3TBZEyM?=
 =?us-ascii?Q?Z9mKkoIiTtPo/9s1L3pX2VJECxnfQATjP8k6/52TBj+gYw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c09eec2-2d1a-4be1-7d7c-08d90b8722b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 03:22:08.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Xh3zY7DgQ/E2it6j1xdhfjXZrRzSlS6o8bWpyBHmxMdjx/hjeirdUECJZRcR2c1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: S5Oiv4ANx2piUCp2mtoPlNBxoz9Fp0F6
X-Proofpoint-ORIG-GUID: S5Oiv4ANx2piUCp2mtoPlNBxoz9Fp0F6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_02:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=918 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 02:01:10PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Give a brief overview of the cgroup.kill functionality.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 64c62b979f2f..c9f656a84590 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -949,6 +949,23 @@ All cgroup core files are prefixed with "cgroup."
>  	it's possible to delete a frozen (and empty) cgroup, as well as
>  	create new sub-cgroups.
>  
> +  cgroup.kill
> +	A write-only single value file which exists in non-root cgroups.
> +	The only allowed value is "1".
> +
> +	Writing "1" to the file causes the cgroup and all descendant cgroups to
> +	be killed. This means that all processes located in the affected cgroup
> +	tree will be killed via SIGKILL.
> +
> +	Killing a cgroup tree will deal with concurrent forks appropriately and
> +	is protected against migrations. If callers require strict guarantees
> +	they can issue the cgroup.kill request after a freezing the cgroup via
> +	cgroup.freeze.

Hm, is it necessarily? What additional guarantees adds using the freezer?

> +
> +	In a threaded cgroup, writing this file fails with EOPNOTSUPP as
> +	killing cgroups is a process directed operation, i.e. it affects
> +	the whole thread-group.
> +
>  Controllers
>  ===========
>  
> -- 
> 2.27.0
> 
