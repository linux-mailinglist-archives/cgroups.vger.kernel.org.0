Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ADB30D0B1
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 02:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBCBRu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 20:17:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229729AbhBCBRs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 20:17:48 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11312w0x022754;
        Tue, 2 Feb 2021 17:17:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zDRpj2EF0xCpbfhBFAq4gRCEHgVcpNC/vHwFLUaoGJg=;
 b=Jq+OZEwtwRPA8PW9PDphVMlRKHxvLrxVl6Pg0OdjaG6ymg3oixyEFU5hiyBqQ3qOR8cm
 IC+/BkihXC58TF5ipgUSi9lofqPKqGiojboHJe+QITUJV+RLxh+ECdYOXsucuIIvTLC6
 W5kxuzFuUq2WRYgRTodZkld6FgxuliRK/sw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36f3ehw356-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 17:17:01 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 17:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSfpGrlpisslM16HYUcOOsOqj+a/hsWXEKD2uA7xY3O7qNpGDKDd8ZJO4HcZ3Okvz9YwB2beH2anqUIlCWHMxTPun4dbWYQcPKwPiG9GKSNj4HV1HCGb9h3AvaowIvPQ652jSZt3hWQFw7++QJ4B+Q2mHvtplfsuVe/gtVYuJFrhdQHr8A9WB17n/X9NdUvJCMV91mCFD5998z2qD1t6nlQQ0m31CWRtVQhAlFZv5tuJXpa4IVUXGKdfSKWYdKxr0bSwsqbrXqHZLOvlRxNIkWcmT0RC9VO8MPgTFig69sgZrZoyndS2+6zMtSCEWIsBDjNmJmXqzVNkwEsl8BZOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDRpj2EF0xCpbfhBFAq4gRCEHgVcpNC/vHwFLUaoGJg=;
 b=QShakK3ctaCzvF0xeWOk7sYuCT6d364in/ZIQ7gdkYGl56m5str68E2MD+GeW0dBkO9Elct/blPe3NqY8o6sRWWplG42rh3r0nAX7rvx8OTlVBwT7Kab3YWm2Pzu4WWpn6m57Gfyv1Rv4kAz/Ta83CNniq0Y5mJVh3WaxImBv/x6eLyVCgA7pN8vLhXInUYifTH6etmQx9zlcWFN9X6ngBlXXvTDCIhjHsnvEbhkwvCWxBQz5MoSuAZmsht57NmFptOKCTZstcva0swi9DuzB2GKl/uFwpzp3LmMitlH1Qt/F/6FYrVM69B+RLs39+AUjwxyVv5hkpNVAuQ6MnVOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDRpj2EF0xCpbfhBFAq4gRCEHgVcpNC/vHwFLUaoGJg=;
 b=SYG8cC5YC3M+x6tC+YdGqNWjTh+XX7wuyOXsepQ1qe8Dt5lfcJ5wvUX9gDHNjrE48MNjm4cuqRQsc95tZvVoQ1Py0eL5Te74iRLUPLDR+3zFXjJGqV1adf5bYyW/80cOlBRDYaaqwLRWtTagYU+DATG0K7kZgFd2lmLcIzskKK4=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2632.namprd15.prod.outlook.com (2603:10b6:a03:152::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 3 Feb
 2021 01:16:54 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 01:16:54 +0000
Date:   Tue, 2 Feb 2021 17:16:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 4/7] cgroup: rstat: support cgroup1
Message-ID: <20210203011649.GD1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-5-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-5-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:a726]
X-ClientProxiedBy: CO2PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:104:1::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a726) by CO2PR05CA0091.namprd05.prod.outlook.com (2603:10b6:104:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 01:16:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8234ad-d216-4828-b338-08d8c7e164bf
X-MS-TrafficTypeDiagnostic: BYAPR15MB2632:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2632EAB19819467811E03ABBBEB49@BYAPR15MB2632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ix2kG48q3/KkDjo26pCThhT8Lchf8fLzhNdIwkEaPTygWFX5wnSR/D3APwG/8hWqCckzmBKwW9KQZrgMCO8PlGEFBFJiv8qm38G4SonDEdJlUqcCzdvFOIPQxAOE3IQGahVN9dSlXRnoiTBY3LXQOKDYATuwxw8CU8dovyOESy6yX/pVKWAU7yMRBe87iwxBjCLHRTplgoKYFstXgLl/dTH0lwePs3anYNqAHlPEECEdmCfGVfBFuJvHVgsTN+7BYOtg7aHsdX5sJ0glhGb08sdC/F7BkndAkerYHx8x3oZdJQ26HllwKOZO5EH/q9vbuyKcD34t7N3IHSIOr2vVJBlYtgTDgC40Ae/R7DxXgjX2H4Uv05l2kGt+pmpsz8fF2q42OOm9hs6tKyZ8TjCFm13mhb4JeyCWDk3d2tvyf7tmwao1a0FagUrvOCi98Zk4qoSnAEwtCB4syCs7EN2bzdYnFDqTrI9v6FbajZYmv99/O+D0gwzAF4ABEqs25Le4Ult6dmk/oqIKoThynUctFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(376002)(136003)(4326008)(33656002)(5660300002)(52116002)(478600001)(186003)(1076003)(16526019)(6916009)(66476007)(7696005)(55016002)(6666004)(8676002)(66946007)(66556008)(316002)(83380400001)(9686003)(86362001)(6506007)(54906003)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L8O/LEZ3iKuXolh7wWMS/OLbaR/IUbDbpNZeDc85N3+h6vj7hFgy+FUJPRjs?=
 =?us-ascii?Q?+Y5tHVKfdhyLXaCo2kl4mdevZpX0h38JtZGz82ejOdJLs058n3rxMhteevUX?=
 =?us-ascii?Q?Iixr1iP/wqXnF11Ok27zpHbF+lVaRplyJR3qTunxpX+rN7Sr2twswnf3wXc9?=
 =?us-ascii?Q?KG+AluAPcCK89Q2grPVWhiHuUed7J1ZGA4GFs0S94TT+zQqArQ9ncJQNL/7k?=
 =?us-ascii?Q?WMVGCylayZpsIif1PPfaHGn6i0adSvAc8ICND9Sqh0xvjAGZWFCPBC5/cG9y?=
 =?us-ascii?Q?03lmn+Lgjv+r/93qJSl31lf7nyIL1bvOdYQf/r6mVQSbn7rA4knKSSygwjaf?=
 =?us-ascii?Q?LCKLL2hybJu03+DTGcdG7ipc4tdq69OofC4Ny1jRfcNHhJDbTQUPjm/z3wU0?=
 =?us-ascii?Q?Yb7o+EhPyWxNM47EVwu/EhMPv8KIU8ko5AILxzXQ41v2vtCvK2VvgS4a5zeM?=
 =?us-ascii?Q?8PO43RgisD/J57pw5PJQyg/zslqyOvIeSYIUS5RZLK44Yi+Ip3jS3ElUOo6n?=
 =?us-ascii?Q?Md8Q67qAuSBH0uKcWDcfyBYhwd960u0Kq6iWcxhLLIAgtrWUZKoAn7u8PV7D?=
 =?us-ascii?Q?btVdcAiaNdILohY5bWiZqUszugIHXmefgRu47GIBzF6mi5KDqN0aw1FN/Ki+?=
 =?us-ascii?Q?uJq6/O5fjgxC3R7N5NR2M0AltX+zfeT2GZtVDKHHQeiW7UrnRfkDEgLoMSbK?=
 =?us-ascii?Q?D2wd1i7P/OQbP8xKkmPeeRuK7PMCvSsngt+Z++XOtWbbboDMf4mbLW8Stp39?=
 =?us-ascii?Q?BTYjYi1+hOVc0Pgjx5fl2kNMpG/CVmjB4BT923nXgVuTw2K1OUZ68iy62flO?=
 =?us-ascii?Q?3P3Fs6H5sRt4cAb2HiLIRpPmVMDnHKon0CtXlEwPBzpIVHwsMcCdbBQeUx9Z?=
 =?us-ascii?Q?rCNUn56oYx97avxlSU3oGCcuD2uIm6AtW3ocOGmI+K9jJ9CHjYb+maIC9rqZ?=
 =?us-ascii?Q?/rgmy2F/zNxO8ScUWfVhINAMVmGP1owRAo/PONOeROTdv20B9z5oWlay49xr?=
 =?us-ascii?Q?J8yfI3YtMCjKPAk27/Hr5ZjjFO3q+iH6bSmPcCMA6IO5kyFu6twYKsCfERiV?=
 =?us-ascii?Q?2+02FtjQgVvC2MZfc7gZP1CCcRjVe8PeODGryqu8666faC4LH5g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8234ad-d216-4828-b338-08d8c7e164bf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 01:16:54.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RJjzyzgpDSyJqrnkHsBDCCMwqZ3fKT8CVLMgL4OQYeX5jRmtfWkmcuhqaEwsUYh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 01:47:43PM -0500, Johannes Weiner wrote:
> Rstat currently only supports the default hierarchy in cgroup2. In
> order to replace memcg's private stats infrastructure - used in both
> cgroup1 and cgroup2 - with rstat, the latter needs to support cgroup1.
> 
> The initialization and destruction callbacks for regular cgroups are
> already in place. Remove the cgroup_on_dfl() guards to handle cgroup1.
> 
> The initialization of the root cgroup is currently hardcoded to only
> handle cgrp_dfl_root.cgrp. Move those callbacks to cgroup_setup_root()
> and cgroup_destroy_root() to handle the default root as well as the
> various cgroup1 roots we may set up during mounting.
> 
> The linking of css to cgroups happens in code shared between cgroup1
> and cgroup2 as well. Simply remove the cgroup_on_dfl() guard.
> 
> Linkage of the root css to the root cgroup is a bit trickier: per
> default, the root css of a subsystem controller belongs to the default
> hierarchy (i.e. the cgroup2 root). When a controller is mounted in its
> cgroup1 version, the root css is stolen and moved to the cgroup1 root;
> on unmount, the css moves back to the default hierarchy. Annotate
> rebind_subsystems() to move the root css linkage along between roots.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
