Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047162EF81D
	for <lists+cgroups@lfdr.de>; Fri,  8 Jan 2021 20:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbhAHT2V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Jan 2021 14:28:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35738 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728954AbhAHT2U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Jan 2021 14:28:20 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 108JEqeu029823;
        Fri, 8 Jan 2021 11:27:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0GkABvoaXUS9nZ30gCzV+pqN8dB12iWOT9cT9ktb2bo=;
 b=pbI5xnU9ZUesl0pszt6XgjFTckzsnKTmHX1FbEB1w16WQAUcq2tqXvAYMKZl9XKgxp/r
 4NfSp2+y1POcDNx7zbyLgbqzOSGlBqs9O+F3joDoOkNnYh/4LXwS+U01WDNV68dfwLpl
 SjVjqhvTrarChGcswWCa6wuUMDtffp5Mdm8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 35xu1t0urj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 08 Jan 2021 11:27:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 8 Jan 2021 11:27:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv9alQwXi1uKhC6CzkhnSMzdJGyCTYHDYHod3Swe+4UIiRCp0vhRQEqaKCDg/fE2r98cQqgAlxTtQrCw0jDmFMPZ6UI8En3CWP4726cqvz9ocoedJpwBnYBTxNWpOrVGpME+SspcgTuw0t4hk0C4DySKAfqDcmL11GhblaGjM9AYCcXfAL2vstyiJnxOnsW74uDECngpg50aI9qIzKeGLxsgaALfwPc0G6aMkfvRYIZHoi86iLqENieEPjhuqHuizzV24OWr7wYqEPE8C8IOLT+LolmDgwFFJ+YCK0T2i3BppCBLlUPYSnPV4s4f0dtuDA1JE0ce+8sbbQqhgswqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GkABvoaXUS9nZ30gCzV+pqN8dB12iWOT9cT9ktb2bo=;
 b=RxR47g79GX8R7GjEbTSdzNdgYtvu5+q3cxledpSg70zZgiLSsy94I6m6dawlXvQAuHfY2Me/Qmpp6F/5R8Zwo/rlZVaiHTGPY0OQ3m1dwG+wKePjvzkvESr7LPzkt+p3w0Muh4vrd1Y5tnxeCV2bUNL/kotDXGDWR3F9E9ALxFrv9gE2GH13DckmP+wr6KyrllY7ScUqTyKwlGqI+fMHewmEzXfKoty79gnGNjvri+r/NQVDESI7ixAOQ/IxRqagWMDHZgAI9op83fknT3l+7TQo+eufwReldVfXnN0JUtTtgu65JXDfndAJGCuubF07AeB1CClg6T+1rxN1+FYSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GkABvoaXUS9nZ30gCzV+pqN8dB12iWOT9cT9ktb2bo=;
 b=Nw1jOlCdODDt/qzdEw0D9dKznoFlT5/X4EQe+Fv7v6WVrAkhIsxgJLUxuf09lmM44/878s8ci9/B/+Tj+7TqRUfwILKTxFqu/ZBknMg1VpUqlJ0Eh6n0DwCQxV+fVBEDaRPccw0gWhuj6QOoFTlrCPuLiVg87J1A8b77hFJM6EU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2870.namprd15.prod.outlook.com (2603:10b6:a03:ff::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 19:27:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 19:27:28 +0000
Date:   Fri, 8 Jan 2021 11:27:23 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 3/3] mm: memcg: add swapcache stat for memcg v2
Message-ID: <20210108192723.GA1388856@carbon.dhcp.thefacebook.com>
References: <20210108155813.2914586-1-shakeelb@google.com>
 <20210108155813.2914586-3-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108155813.2914586-3-shakeelb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:a1aa]
X-ClientProxiedBy: MW4PR03CA0396.namprd03.prod.outlook.com
 (2603:10b6:303:115::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a1aa) by MW4PR03CA0396.namprd03.prod.outlook.com (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 19:27:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d749e8a1-6f52-4574-f504-08d8b40b6fb3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2870:
X-Microsoft-Antispam-PRVS: <BYAPR15MB287044F12A2F5614310FB819BEAE0@BYAPR15MB2870.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaqvig3BYgdb3FO4RAqtUnG/5rrMaMS2PdMlYHD2+tOR8o1TfQ48xsfWEtBM1PF7b0v+Q6ieM8F0Su/hIQREpkiR4xjZrse/LBNI+7hCBT6ZGBMp1afG/K0akeCnO88b+UJXsFhKTdpbvpCcuSnO/5h3R/i6Fj7vkc1IBI3SnU/roy0YzFxw7sbyVXtk5RfBvn+oULHf4ldSqq1/ePjBfTgmx9JHLY1we1dczxnRKBQ4Gugb09ZTTd7Ow3inymumqA10nsFYBnFdci8nkaT5QeGRhpsct0zeORcEtqyk1qfB71+lTYOHABHsV8NuYI3peq8ZJEFf8Im215ZjPw8FvFZB5LWULDxjVFY9+i98xdI6OWTJP77CUINlTyEcIj7pe0QQIvdOH0tfvxiIwYqMMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(186003)(16526019)(8936002)(33656002)(6506007)(2906002)(66556008)(4326008)(66946007)(66476007)(6666004)(316002)(86362001)(5660300002)(8676002)(83380400001)(6916009)(9686003)(478600001)(7696005)(55016002)(54906003)(52116002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NAp4eL6TLl20pM9n6hxU2vuRD1ynBiYFC3aTXj//hSrqwKTUp8zQf53H7ne+?=
 =?us-ascii?Q?C7Tl5SLBoMk6FEIJu7RV7DAYADAFNyX0vz0SSvyJ5ajDAz4orFLJ99ezFcAZ?=
 =?us-ascii?Q?x3aGqmgyBBHrbXmRZZ84yFH4K1c0hJMSTi52HRyLKM6ewUw6zZNTTzshSGf/?=
 =?us-ascii?Q?0EKAgiXFQ26cbYIT+XlbCwjStFpxtMClq1ZxJtPEVLteTMuwPZthg2XUEBtF?=
 =?us-ascii?Q?RtXSU3IYqGTfcTvQDIozaLe5kZgrSuG3ozhVgEEAXRqUau+Atks2oJJ0bmaj?=
 =?us-ascii?Q?U7c16/XgGeLplDwvR2p587xzq0VG/dOywAXcqeLLrjqE8si6ajF68R47V7Tu?=
 =?us-ascii?Q?pYl48CUOzbs5MXlZrKxNhRfhUvU/5xWqZxoLGBELAr3GLVNCQ4ksHftrE5sO?=
 =?us-ascii?Q?MKqL4s+q1RDQXOxmq5g8HZlrFrtVx8Kl1XGiwgC6ad6OGO6BDn3lOGC8u0p5?=
 =?us-ascii?Q?dDGcC5OeIPOflKDy84NN4xqQJQ5ZV1KebJTSq3vD0LkTpItN0GtHs337Od9d?=
 =?us-ascii?Q?ZRlVCcFCH6WaG9p2PzIjVijcWCspDKA5hMhXrqY0pdhXQpGs5wYbLxLs+Vls?=
 =?us-ascii?Q?yk4+SE/tq4kQkT0+lKHB7Yc7WImyO9S/iXi6fTvzX4uCo5e/AprkMcg5Dchm?=
 =?us-ascii?Q?VW3XASsyHSC3Oeh3WqZnxdheVDpTAnFu52c3Mv4gJJtXyV1vnKFSs7dL71MZ?=
 =?us-ascii?Q?VnT5bKcJuMR/5q04YcMcKHeD6hRxtjjNks4pleQqmflUeW5cVWLR+cqOWem5?=
 =?us-ascii?Q?DY2O/R0vtwR27rq8yD4uIgzzK++l1YyZnreuxlqlKst7NVvywLlFbvzemtV7?=
 =?us-ascii?Q?wIb2UzVdQe5M/BXO4gsrWz3HjjmvdufFu13G+JyU/xGqpqkOxLQmaO0T75Tz?=
 =?us-ascii?Q?SL2P97CqeCwNyItwt3IGZRHMM1RpM0IBRS4V9Sk84bWmLqnShDFfXzBsII3s?=
 =?us-ascii?Q?5yk6+9m9JPcz4SXDoP5yJYmnXkwZ8D6sNMMqoNJAc0DqHm1oM05NUL5TQRSH?=
 =?us-ascii?Q?CgOdTm6ZN6c/vxkQQScfgHKCOw=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 19:27:28.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: d749e8a1-6f52-4574-f504-08d8b40b6fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTEHmoBi+YEJbdfdjBdYR2C60RBF0N5IpFZqe3VcGbntt/+JSeHPr5k4dbZLENUW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2870
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_09:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=701 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 08, 2021 at 07:58:13AM -0800, Shakeel Butt wrote:
> This patch adds swapcache stat for the cgroup v2. The swapcache
> represents the memory that is accounted against both the memory and the
> swap limit of the cgroup. The main motivation behind exposing the
> swapcache stat is for enabling users to gracefully migrate from cgroup
> v1's memsw counter to cgroup v2's memory and swap counters.
> 
> Cgroup v1's memsw limit allows users to limit the memory+swap usage of a
> workload but without control on the exact proportion of memory and swap.
> Cgroup v2 provides separate limits for memory and swap which enables
> more control on the exact usage of memory and swap individually for the
> workload.
> 
> With some little subtleties, the v1's memsw limit can be switched with
> the sum of the v2's memory and swap limits. However the alternative for
> memsw usage is not yet available in cgroup v2. Exposing per-cgroup
> swapcache stat enables that alternative. Adding the memory usage and
> swap usage and subtracting the swapcache will approximate the memsw
> usage. This will help in the transparent migration of the workloads
> depending on memsw usage and limit to v2' memory and swap counters.
> 
> The reasons these applications are still interested in this approximate
> memsw usage are: (1) these applications are not really interested in two
> separate memory and swap usage metrics. A single usage metric is more
> simple to use and reason about for them.
> 
> (2) The memsw usage metric hides the underlying system's swap setup from
> the applications. Applications with multiple instances running in a
> datacenter with heterogeneous systems (some have swap and some don't)
> will keep seeing a consistent view of their usage.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
