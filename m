Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB44A508E
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 21:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376536AbiAaUwZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 15:52:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63956 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377191AbiAaUwV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 15:52:21 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VJxNdU001174;
        Mon, 31 Jan 2022 12:51:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=95JG+QtaVSGl2156CP5p8h6tN0m4sX9mBTEerW8F5EI=;
 b=FUKalRO0Yw9Ya3qvrDMkCm9QSxzwRbcInhP/rk+OTbJyKil7/aTKgkrpCG+H8DRPVu1+
 Z63JoW10noHuAlYHbtHBCEfNBQ1qhmxDImlMfdnqvrHnZrga7L2j0gLiah4imOiubqij
 EimctkSTchWVDZneedV3g7e7vCMovfou2QI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxm4a1bfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 12:51:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 12:51:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNOvnkMCUBlvqmG4Ltkqtb2y9oTO64lZZbFSZENM0y3bUxCveuMRM0VC3ugzJSIO2w3givyX0pSXDntVryhMhH5EBZiAKiscwVksM+Hr4jOI1aZOWAC7JqHPsDLsa8zyvvlx9cloGXqP4S9QQtC68Qnza780fD9YOiOjV232xCA+t9UbiM9qCFoF32BemJwO/TX6qPf5gjBtNSdfcpvHhTPD/zwhVr52zoEjhitIFw0xNU5SMH1A/ENxrCYVAym2+5KRa4VvBAlwcLfQL1WbEyCK/O379YQ7tbnCdNcs6yACqMs41UIukB7AdC2T6EtA3iq/uogs8dMX3qIt1vSwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95JG+QtaVSGl2156CP5p8h6tN0m4sX9mBTEerW8F5EI=;
 b=jrqIVFpWx78OVWY+d5uT0UX1W4O178AsnuNsWIQ2EExbNz8ggSOn9IdFssO3Cg0beEdUz/nMm82cefBRN8wjuWD5s3pO43eKVAN2GeMWrRQEZi2eOB+0GrD0pR4WCJTq4N50MtJ0bWiDDVCTfP7VZgcIla4c4O2TxYkyoxCsG4ljk+cOA8Ht0l7bLGSKfPyKLNpC4g50nBtKsIKoTsuIKrCmZv2AoMwUZRTjxLMxQPB4PJB+Vo31+BLHGPTD324KIOo/LUeve3atwAmtJElNf6uqcPrDN+0UcGl0fuVrKnUiWrkj+ZWZ399RgAPyAZPgZ0obqpvOTLTaiysJwlD3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MW4PR15MB4364.namprd15.prod.outlook.com (2603:10b6:303:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 20:51:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 20:51:53 +0000
Date:   Mon, 31 Jan 2022 12:51:48 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3 3/4] mm/page_owner: Print memcg information
Message-ID: <YfhL5FIoFWuqWaEN@carbon.dhcp.thefacebook.com>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-4-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131192308.608837-4-longman@redhat.com>
X-ClientProxiedBy: MW4PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:303:86::6) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9329a63-6bb3-4c9f-64f7-08d9e4fb82c7
X-MS-TrafficTypeDiagnostic: MW4PR15MB4364:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB436409607FEE3EAF873E4E89BE259@MW4PR15MB4364.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBYrPwRbYYLKwNyJFvjAWS7E8/2SlMybV2sy6WZ3RExeP+dzgLgZGRCztP4iTW9U+Picdx/YV21AxPp77zQeveO+cdjiMnf05WqhSNOwd0QG3MJO7bX59Y+B24IaACI+8e1UVvps/H8rxzt65L7F6GBCQRb8Ja1YdR07w7yMDn/ZIA7nPpKnw8Fz2fHmW4PTm+n7JYrZ+PwTAJk7+KkBv7p8fBEEHCYo0verbczZYKm6D/3Op6EVEsLNV0c5Fr1KOcBPGTCfqJ8S6eCX/6USFCm7JUCgZNX1+P3Av/e6Mqgl1ehoJ4NBE3/znymqIiJ7AMjmAOe9pW6ZdD0UbUecUhZyjV0EdmHkCXuBTOXVrXjPLuc2BGfiK6KcgYhiwv2BJbt+1QZ2kLZJB8LnEyzL3QF0KWd8BL/sc3miaYFafHzVuSauGTqH9pX+MNjVShXPF18ema7a3lSSmnJ5sCSVyUDLVCXx6XQTQUT8cYZz39ijGMbNadaPw2/vxxNIEOl53+ZGyq9XmY/Ckymof8DgcksJqWKjhThYhM2nUKlqnoTFC9K8Q7LxXL6lPnNTQ2qMUKqwHW+A7l5hZc9eISQSAT4aqkfn1ADmJ3H7I9dWBVEU27CfaWw/D7vvH+/spSqxxqlj4nWl8kuaOvzANjsLQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(83380400001)(54906003)(6512007)(6666004)(6916009)(316002)(6506007)(4744005)(186003)(7416002)(8676002)(508600001)(4326008)(2906002)(66556008)(66476007)(8936002)(66946007)(9686003)(5660300002)(52116002)(6486002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEF1teq35nBJ65OTxYjQGsAyn7qJlmj1C7m9lWwtpvRfqRivhgyOqtbTzS0o?=
 =?us-ascii?Q?ZjsRBx7/AFQEsGm76XJ0NExZ0QR6ARKSNZufN6SdFKXAEfSpEUVaJDfeO2bw?=
 =?us-ascii?Q?mcenQdB5nppBGRKpA7d7mPQf0C0VlO7OtebZJRupKY852l/XEFzAnDOzJ9yW?=
 =?us-ascii?Q?YgLyguhlAMco3cUGqgTvLoRh6RNFguJ2un6WQoQmHgIagCWSAdO/Vdm1jLtZ?=
 =?us-ascii?Q?L9gFadM2h6TUCu9vDRbh4Eymt9XzPTsdIEnpCZcjTZ8oAUb+VMu+lqQB6GVa?=
 =?us-ascii?Q?6fIz3PR6KnJwU4lVNPh2mrKTMQaH9v0T5COdln7zm0T0xvaLVN6ngfsW1xZF?=
 =?us-ascii?Q?5FVhDD5YoW7LT80uGG3zpstp2RH/sqPLfGWjZcK91EBJIUgPdSzEtEES90UL?=
 =?us-ascii?Q?jyqX/r7Bl7esf+ItrgMoVHzAvXrdNJC4LObaVZPFt90siWejVdYiNBL2ciO3?=
 =?us-ascii?Q?8/t3EL22GxFRVaB5Ae+gUJ+725pDxpdnXx7L4LCeOmcsl5JjvNUfLN3p11ay?=
 =?us-ascii?Q?iLXffltQA8UlrYwrO/KjEVkHJmGKQ5RR7dqDQxviV0Gb5jEdW3hIgKJzdiWZ?=
 =?us-ascii?Q?L1jLvHwoT8FmuNntUq+rBGOJn6zdnxKQE3oXHjC4WOoqa2jF6gZhEV/aiqQH?=
 =?us-ascii?Q?rhBxVGwwo3Fm8KMnHRiOBLYthgZFpuGmTHzuzJVBQJCyYwu5K4CrONgPyqjP?=
 =?us-ascii?Q?1qyYItPRtObDklyLZrQ6EuFdJ7wCHc/R88QwsI091NEwOv6ZTmD30cREgdwv?=
 =?us-ascii?Q?lsekJBtudPcu0OLCAHbvPqidACis5punJesr6NIgJtaWZQxpVUtvCyeh1zv0?=
 =?us-ascii?Q?YyjyKgTE3hpo0Pa6QipyR13o/JqPbMaI1ZLl1DnQ4GLpHfbV3I2z8TL0ydSZ?=
 =?us-ascii?Q?9bzGUA50hou8kQ1gdKRY5sqpWjNl6K53LsFB1sC/HrnS3iIzZ6cWMmsZJCMV?=
 =?us-ascii?Q?OSKwSk+sjm91DdXOghHQG9dcJmTXWSgSlEJg27NnAcBumXXv345Xg+8A+jVd?=
 =?us-ascii?Q?upRsb0y/kBwYUukyop5B1J5LdrAvRG52Eeqclptso0oywxdyqskgZrtNQhYo?=
 =?us-ascii?Q?8kDfJlf/JQ+Q0OlPuM3UxySlYr+nwymsIMFG8/wwnb/nadKNmAwTLkUd+k8F?=
 =?us-ascii?Q?ibggJAhe/3WrKsyVgzCz7s82haW7oacYkzxNck5dhdWHqQYMqXnBXdlwSjQe?=
 =?us-ascii?Q?t5lrGAUdKXg4YebClk1faxJt0fgyZf/1vt3+ExAh5891kCZOhuHd5/IAPZCY?=
 =?us-ascii?Q?qUsXlRf4DCjZYVBZu+FR8Rh0ULMinnVTevrpY5njGRk9kB9afzSqGYcw8aer?=
 =?us-ascii?Q?aZsMcVfzupAHupimDanYOaGAiiX5FsxIePgL0y5jefBcGYFXk+aRF8qgfSlT?=
 =?us-ascii?Q?68P/GlXZxWOAjRRwXuyIDLE+8TCdcmeV2EEq0FjHhNho7de038bmN3NM5Ecy?=
 =?us-ascii?Q?9lgy7bUkK/SSi5YF2AXEsZq56QMr//Ox1o23RB/ZlSCJEirvvubE9UECNf85?=
 =?us-ascii?Q?Vo0+M83W2XRQnoGgap1TtwYcINaEr3kYmD+mmHBuA4Zt1XYEJ5PLhoQ0wcbL?=
 =?us-ascii?Q?rYFDB6dhTzTJ30+XYJEZDadDi5EURyUOMKO/4c/C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9329a63-6bb3-4c9f-64f7-08d9e4fb82c7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 20:51:53.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7F2/0ei2c4soFyJ+PayDxSCI0PRtZX/iGqE6wfUybNN5ctgzAKsbfJQI9fcPjmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4364
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: VtOWx2ZsIY2sO0ycXZHGoZh4vNUlOebl
X-Proofpoint-GUID: VtOWx2ZsIY2sO0ycXZHGoZh4vNUlOebl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=782 malwarescore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:23:07PM -0500, Waiman Long wrote:
> It was found that a number of offlined memcgs were not freed because
> they were pinned by some charged pages that were present. Even "echo
> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> offlined but not freed memcgs tend to increase in number over time with
> the side effect that percpu memory consumption as shown in /proc/meminfo
> also increases over time.
> 
> In order to find out more information about those pages that pin
> offlined memcgs, the page_owner feature is extended to print memory
> cgroup information especially whether the cgroup is offlined or not.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
