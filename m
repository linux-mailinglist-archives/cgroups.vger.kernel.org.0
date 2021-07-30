Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89E93DB1A0
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 04:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhG3C6f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 22:58:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56540 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234089AbhG3C6e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 22:58:34 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U2u6eH018100;
        Thu, 29 Jul 2021 19:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=b7+F64tGd49kJFmP7N73M1bi2RLTlWLW+wo/KaW/1Qs=;
 b=iolj+3YznkBlYOBWAgqK1kUzK3YEqu93py8Z/q1F2oHCy3UV2T/PgcTEI6ssPo7tGsq2
 2eT6nu2GW+siB8mVWdVngEt/6Gh1PQlTtQmQfIfuZgwGsOCDcmPJXaEI8yG+zNmOirlO
 Rstmlf6WU7C9EdARk1AzWgi7VUEsPDER4T8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a491c80uj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Jul 2021 19:57:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 19:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRl/eQNvKJMDkghpX11Bl6mDXyZXDPmMiT+Sj/UYHDxavheNYUKY0FUC/X6h1y9epGNpjkbtfwKBtRoOavHSt1OudUyGB8Q5fhvlA0KFVbVCLGPQSqoUwTr5mwfVXFH/rqfk1b8hGB9LyXE8wYZZeanQ/iPsYlECjs8yVilcA/zjHVLRMi3ZLXNp3bU0EbjqnRZSaxAntsuEkzXg9VeUgMI3EhIuI1GN33CiyKEiUyuNk1eA1i9zvSHxw3u5lg90xlkipU5Qa3Yp0/7n6Yja/qG37uZAjiQf6sOlFgkOxs33NCGCy3b3l819HCEtLCzpE2JYMhTE/xnAwZZSjdDWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7+F64tGd49kJFmP7N73M1bi2RLTlWLW+wo/KaW/1Qs=;
 b=BQVY1HligwgeDTuByCGeSu7/iNHXag/2clh2uONqTJaiIQeTOeMzMkhqmWxWpTCZeSzVA2Mw8npIi6KsMsx8cDJGz8J34OSKK+AR9pSr0yPohYYdiNPw5gcoToJiDMQ0eLEq1DzJiOtt9zQGPP/fX/+ymLO8mRJQnML0ohDuKeuYe0qgHhPo/NwkHvufOv9qVshlmitHy8uG6x6EYW2V1piKdT4ssHTUbYiNII8r3YtWPRJjevsA7Kb/rp1KN0NYO8vf7MKAZOh66k6kvse48bqCo4OOaGZcN5jg9fhXQe1sJD+cs+sIb+yjpYsgq53qlSt7JF3j4lrOyJcyy2vscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3158.namprd15.prod.outlook.com (2603:10b6:a03:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Fri, 30 Jul
 2021 02:57:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.034; Fri, 30 Jul 2021
 02:57:26 +0000
Date:   Thu, 29 Jul 2021 19:57:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH 1/5] mm, memcg: remove unused functions
Message-ID: <YQNqkdR6o1ddqtVe@carbon.lan>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210729125755.16871-2-linmiaohe@huawei.com>
X-ClientProxiedBy: MWHPR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:300:12b::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:166a) by MWHPR14CA0037.namprd14.prod.outlook.com (2603:10b6:300:12b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Fri, 30 Jul 2021 02:57:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd1b2973-7fac-48a4-c5d3-08d95305c31f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3158:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3158CB919B88F9CCFABD8B33BEEC9@BYAPR15MB3158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjwM6aVJWxDvOJmRcmV+7LvM43i3tLCRSi9yDMFSKhNy9ID9jPczF0IKZSK2bun8a/P/EMJNlnY3hRnPUMjkIoiXfo22Cc+F60EpiaTd4pB0eBqgEC6RShAq0r0NFNgSO4BzRs9BoJGzT1f88GnD+BrViWVbptrELxF3cu6k0iQAOWr+iXzD2+K7CPRTGMQUe0V4J81arFoYJ8uxSuR7DyI7aabxkX99uQGnlzhWfe/iic9a8jGi7xvwWixnmaqjU8AHOSsU4r1c5R064jXc3JLtMmcf3/PzXDss4i6dOtHW7DSpPo+I523rmDMO4D+6a/hhKFSqlUIEYj27Raspu/mIUmEGidAelhtisUwJ88m3Z/1terH05nSt0TBOE1m2Xw7tqoYdToJP10hBt11PkQl0EmPMqLEwAIPoTIKGuTAXi3E+m5vplnBLkGffQnygRnxJ5gkR2e6uQlLxWaEPLOqTiT268A8FpvmaaHhUh1lPmF6i0npkCtmMq5iq69szIZpT+PZvRbYHPNCkPHjG+aTLJNTyzwO1V1ezoZQnIXwvxFWSSWKU/Crve5qF6IbdMw+curBu/I3RRIk8ebdrvVXdsIo6QPOh4wLQBvcX9++GkGVKcD2B7uQA4GsrF8jsHiwoT3uuT5U3TFLXuJ5lXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(186003)(9686003)(8936002)(55016002)(316002)(6666004)(6916009)(36756003)(38100700002)(86362001)(66476007)(4744005)(7696005)(66556008)(8886007)(7416002)(8676002)(52116002)(6506007)(4326008)(2906002)(5660300002)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9i03cpvNXJaiDY3ofJSFZThVR3ljv7fI2aVTl2ulDKfGhhMAOLTmx4DMQJn?=
 =?us-ascii?Q?w6+wwdMwJXHO1dkc1tY4FY83ED9oEAsc/eSRKrofRvVx7sAf/rA+iwY+PuKt?=
 =?us-ascii?Q?e+xW9XGaICAdzhCsdZgIRtHGGrigdluNawrK2pA3eORVxVgFetUY9BhhhsW9?=
 =?us-ascii?Q?lzVP2PTzWaKFrjkg9O0xwy2Mmy68sbaMK5+fBjaIfzTNpNZSlwsY9p4YApyX?=
 =?us-ascii?Q?6pNE0a7SGepjuPEPlfu/vtZU3kf2d/mbETNozqhkcVIxlDUOP8X1HypACbWU?=
 =?us-ascii?Q?SyTlF9wDL4ACpdM1jDBgaRWro7svIYp/pakjCObipfmVXfwUAqaYpUxKTjql?=
 =?us-ascii?Q?DU+P2CTMncWaAa7tb2CBe08CGi6z3NgfC0ehIlPl8hCTTNSZPfH1tcb6V8mZ?=
 =?us-ascii?Q?0WxQWQ4ezSzRx0uYYSVGwAAsyGR4tfJqWGbgg9TuMQGj19DewAyA3F/0FDSs?=
 =?us-ascii?Q?rl0YgHhr0bqFszch/oAM+Qgv0tMczfb8bQ7zH1OWJ9kT0xQD4wTSnvdF+013?=
 =?us-ascii?Q?CYUbWeNQOuFnAINC2KGrMc02pXJvHpP3+wD/C4ghtRiv9wlb/Aa+PEqBFzN5?=
 =?us-ascii?Q?ImDkROq6GWKod+L1StoMQT6+3/Ugo+Zo8MQfm0t0Rl0bvMFlCUNip0OfCVay?=
 =?us-ascii?Q?L7BeGegKD08MErTXcDlDXm3D/6mPYsAm+9v7dIQAAx6bIMVfvLalow3A5ptg?=
 =?us-ascii?Q?ESGlu6flxnnqskQ+gb1N1Rge4FZqS02j9KK+BV0HnOXyiPQeOo4yZYxNAx8C?=
 =?us-ascii?Q?vJAJnKur6Q0Vc0R/+ukK7etAbCWqiS+F3TTQio7XHtrfVCNwfkvJQXAnOUxL?=
 =?us-ascii?Q?tJBsk9+11cTbHLYer98Tqg2MMhi792fDgOnGOFhJsht+1ePIn42Pji8zgSZk?=
 =?us-ascii?Q?6H2RMbxQgf9ZkUFGK9LQUvQ049/wmPSKUBf0L9XFNPhB3lyxQUNgAw+3zReQ?=
 =?us-ascii?Q?X/gwoidlQgYEW+EHZtT55dikvVu21GOOZIGunhmpKz9dyLUX3ZQ+Xixzxm2h?=
 =?us-ascii?Q?Fmwr/QwAkz6HjDHs40eifzBmbxmajISdU/boQXca7WXcwr6+qZpRjrc6g5RP?=
 =?us-ascii?Q?uKQCQSyA5FJ+lKp6QicAJcD0t9HAj23ySu5GWSC3W8AgvnYZvpIxLCohghKL?=
 =?us-ascii?Q?PIqUyTmQxeykmuTPqY48KLiVsyJHtBGA0UqqXrEe7yYHpVIVYE+X97a6Bfsv?=
 =?us-ascii?Q?paAWyT7vvg4jGLHEbJBywjVGpq1qwWC8d1QsP7VSFkeXgH5F+iRj0c9jd0pm?=
 =?us-ascii?Q?x1grtefvK0/wj3ZuxreserckAPq1wtVippNJSlzO4CJyX5d+eO9yUxU0zQoY?=
 =?us-ascii?Q?xdyB1S9PssmGG5VYWRho+LxH0ZOZnGYdESuNrhxkfVfXLQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1b2973-7fac-48a4-c5d3-08d95305c31f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 02:57:26.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Em+rmFHgRcOq9mQtPSjawgrlsVmd0eW5Oq2vyJBPy9NqcJN25Ax2ygQbcVymsRCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3158
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: XGO_8VPFT4t1IeIm-d7v_cVNK-NTLcFx
X-Proofpoint-GUID: XGO_8VPFT4t1IeIm-d7v_cVNK-NTLcFx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_20:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=959 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 29, 2021 at 08:57:51PM +0800, Miaohe Lin wrote:
> Since commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat"), last user
> of memcg_stat_item_in_bytes() is gone. And since commit fa40d1ee9f15 ("mm:
> vmscan: memcontrol: remove mem_cgroup_select_victim_node()"), only the
> declaration of mem_cgroup_select_victim_node() is remained here. Remove
> them.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
