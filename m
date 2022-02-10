Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C504B193F
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 00:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiBJXPn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 18:15:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiBJXPn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 18:15:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27FA5F5A;
        Thu, 10 Feb 2022 15:15:42 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANBSeF030065;
        Thu, 10 Feb 2022 15:15:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=dRAJShx2hNO0nyEkkCJ86DsNPM8DCyUoDPBpOJEvCrE=;
 b=XrB//CH81dyKQsDU1oGkGeFcUVezb2Pppcu+KajuL2ZNnkTsfopf8yn+tXir7wvfn6p7
 MjULMJ8mCCql3Rf7pqNUEpCfp9PIbr3E7xsIlmIaiha59q4v87VhTlmNz5v1slO+VKJ8
 yFyIlItRpyah9AlCgeoMZ88kFs5gZZ+4Ygs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e59rps1cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 15:15:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:15:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTgJsrPz7LEfsvwuxDo+4An9VOpOmTb+Gkt5psnEOAMV4dHaF7VRbYWsv4pKJhiytJTBWP7onOIM2o+jes/X2AOhUvdtf23aqTPJ+Ese8Z7sLHbvecWk/KLovmCjnlp+qu+3Ee+tiNspBQklVnYhbolpuZfHq9+lhruA5oV8/tLBRsyfisQSofNeIDjv2yCtqxVeAXzuXndtVIc8EeP4ZBGPT1xGQsVr30I6bVKXDijdLMz4Oxq/xYL43CBt/2CtppHjKCAitGgN42trihru1/AphrTvw6XBZgmjmVCS5/zrhag24zeBEecJnHUSDgKBkOnwdBFqh7GmFCKn9QebqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRAJShx2hNO0nyEkkCJ86DsNPM8DCyUoDPBpOJEvCrE=;
 b=jYoCGfJSS4xRV5IARnO+DbJyaEq6iWPC9uB6oHiY/v87azvj3peow6XcOXuJhLiGQ5A+ELjamiMFXKEbz8aefD1zav/ANqzb++mRajfGrHXUFKoDGjlN1Y7WmUr1xG8S4ECLa8xI/SMVVMW6+jXaAwBpBuqnhgsMpoJiTBbECg5s57hGjSqU9nkhJBoIbxPwI2xQMKTR7hWe9MUrYcUpWaZMv491QU0jD/tO/uPTnfDIdc6yYg74LBhNAC1phwTMrQ01fLYJmXkVS7snSZ5Q/ovMVg6vnofuiknlGdSvoS+Ye3Sn+AyTsAA3De9jqerGlQOpIB5YCCExFKqG+5aXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BN6PR15MB1635.namprd15.prod.outlook.com (2603:10b6:404:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 23:15:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 23:15:30 +0000
Date:   Thu, 10 Feb 2022 15:15:26 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] memcg: unify force charging conditions
Message-ID: <YgWcjv/D7wy4dxXR@carbon.dhcp.thefacebook.com>
References: <20220210081437.1884008-1-shakeelb@google.com>
 <20220210081437.1884008-3-shakeelb@google.com>
 <YgVvgCbbTrDPb5tT@carbon.dhcp.thefacebook.com>
 <CALvZod5FBEHzNcXD-Wo5BPmMxu+Kf-ZA8s6N9EmD6TeFocs3_w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod5FBEHzNcXD-Wo5BPmMxu+Kf-ZA8s6N9EmD6TeFocs3_w@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2db30471-6f09-497a-b130-08d9eceb3b23
X-MS-TrafficTypeDiagnostic: BN6PR15MB1635:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB16353EA38034BC7E29282A5ABE2F9@BN6PR15MB1635.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YM0L0HJGTvyF732xN9CWPM9r/cNVFW6z+rN5FgYb9YMrYi4sUttMRzT0TB/bxmuJH8OKrWa1sKwzsb/KmAbCC7OOH8QYvp9xhdheNEoDVljzBocAoqBus8UBtCUauOdr8cDOnDVa4V9FsePZ/kU4a83AndQjWbtOhm7qijpYYcovAKeLS5mP4VU3C3UixbrRTKpJhfxhGNdlI5SbbSt62Mc0c0tz5BhPGOUe3DCR5uYR2gvm2TQa061Io71F93/huapqmoOqKVTsLT/ST+uVoCxCKFo9UIYYMkuMSDJfkZHbjLcYq0E1Rd/znbpqaKwg4Su7YalKH6P312Zys2Hw15WYRaH5cQidJWS6X/twQZxBMlwszqF/XEVI327CgtgKQfpHr9vRRNnH8DnmQGp2wVLumg/c+3XGsE89LDfEGcwoH6YaYKC1xKkj4iltO3BjvR44qZmVidC+qciShAhfnPTXKk8xXqlrTChE8FIR9+Q/1fkq1FGGpcwHMrtdVvByBU3QuqXKHxbCR7ivTfox6jWYbp/GYH/i+lnV8BrrBf6q5zxnh8oyFw/dWkX4bYxoTiArkzqDJUIHCt6HHTXSr+sP3wJKXMEIx8FOBb5ubznyYiN3Q8oVjcG7NUT9DymnqcXfPuBA/EPn0VkIlxMc3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(4326008)(8676002)(38100700002)(5660300002)(8936002)(66946007)(6916009)(316002)(2906002)(66556008)(66476007)(6512007)(6506007)(53546011)(52116002)(9686003)(186003)(508600001)(83380400001)(6486002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woltYTYH9+qaKpKWYUb7JKiRwCHa/f9Jw+angsdSJKZaILxIp3e956kwUiro?=
 =?us-ascii?Q?YqBXLiNDxKPrZ3D+lQR8hpRVI2jHDXSBWKwnFsX9yOOqwwV1Xsi2WQ5FyJNb?=
 =?us-ascii?Q?R2KeUVUwyQRwMvn7svzqO1KcDj7n0roXydWeZegfhc2xmdAzebaAmGiwSQXA?=
 =?us-ascii?Q?5ym2xVCqivXLXLNOnuIp0jsiu+thXhfrLwEagnTjnDf6GZMzQ9pjkAoZS2Xj?=
 =?us-ascii?Q?VwjEy0mnV1m1/q4h0eZ5BcqlA4RaBU8dWR0zGh4cXujEv61Qpid1USMYplNs?=
 =?us-ascii?Q?pSAjbhO/biP4KJwbvVp9zSs1z/0m2NVZk4enzNQxcsSuvvKTMZ3ozXHdseR0?=
 =?us-ascii?Q?noJUvuocpl6t8viO6hB8qnWCEXJETZJyMuHCZp8k0IK41cNvq/MJpHehh1qI?=
 =?us-ascii?Q?mL5k89e6o8RlNiadYEl46KZuWUmuCqHcXOMKzQYLFn3OOGrJM5G/olVhrCMN?=
 =?us-ascii?Q?QZJUso57UH0evfxtEMM4OD6YoJ7AMzo9DDKkOAOvHVqrO/xa1lg0BYzX7K+6?=
 =?us-ascii?Q?MwGkx5RD7fU5Wl+vc0aHyS1fp4UdrAZekVzzNRp43VWFTD3TTKYOIPtoY+et?=
 =?us-ascii?Q?tRH1QfQb1CNkx3GJcynAYxoMfseDvBEUYy7Km8FGjusLJq3c+CNFwXf1//Av?=
 =?us-ascii?Q?/pX2lyOndSJGxCaWH8mEs2vlh4OUvnaqyuimOrw8OIcOv3yYbdCR/Btq1trQ?=
 =?us-ascii?Q?E34kW25+rJC5Y6HgHr2/o1Pv/GnxtsfkVeNs5GwIwpiSRNoxfkV6DSX9TFsY?=
 =?us-ascii?Q?2aBpz7/Y+bDIVOi/2nQ+pAIXNG41WjRDpRbS9LTp291p8/oTz8zArvyfNUzE?=
 =?us-ascii?Q?HW8CSLbqoeSRvrmdpqe54PQkMXzgW2df2RdIEZ1tSjFBPd9UiYtrKkSqzhct?=
 =?us-ascii?Q?+c+35iORd/SYrCrQkknMASB9F2PB1iil51nGgEm3yA9n08T70L8vPlXr0ZfU?=
 =?us-ascii?Q?2zou+6lQowvdmE4hkD8zMNtKdP7v0p6IDb9amp++GEXOPprUb7ff8xq40/m/?=
 =?us-ascii?Q?YiV9rrWzfwL5+mRV+GFHdV8YFw7OQWVs+PS//89NkqSODMZn+K/M3hX9xA75?=
 =?us-ascii?Q?QjuIpiPVLMGfOCXizQV1ooQ9mVdxb1QVLnJtq8wETAlRttYS7x4jTctp2fAM?=
 =?us-ascii?Q?navmykQmp/XblHkK+B8Qztx77sHGTbmcANKhxwdSR7BGMDllkaebQQ/3qv6f?=
 =?us-ascii?Q?pUvlv9VK0ipS294HAHaW3D/6pCv9xa8zWk1qIGmFLqdSWADFZIoUm0AfT/P2?=
 =?us-ascii?Q?vpbAzMjT3FFbeoX1UMG2/cVoS0QyJ85Ayudtx6A9hBtthaGaETD2i4T8MQ3P?=
 =?us-ascii?Q?OBUtxQnGBrc8Gjr7jVx0r+OQxVbPQxEJVSHVao4w2Jh6Haz5WntXzz5j+0Ae?=
 =?us-ascii?Q?xVQgH6Zwy4w+Q/hVTI4+VgVEH95KqoOtOGIdtm5FcWxpKh4mx+++IViGWZm1?=
 =?us-ascii?Q?0apqg80k8RElMvybZosZ4KSRdgSVqjyKqo7c/hBz3FWv8isnuBGdx2pcr3iE?=
 =?us-ascii?Q?S2pbusghhdd9FFxO2P/I3iB3KvrwgidYtgPKhI1N2vt+I03Pmx0JjnhPtnAO?=
 =?us-ascii?Q?VNq25t5rnVbbPt3yGyos9JM+D5LykVRwEor+dj5s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db30471-6f09-497a-b130-08d9eceb3b23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 23:15:30.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWd52QuUIC8MEFnnb4Sv737YkXjtLCYNDXbC7wnrBDhr6pWhvNEQZGQNJ6tmCnyS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1635
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: EWefbp9_3qaQlFh0WCyk1IrLIhSH1Zsh
X-Proofpoint-GUID: EWefbp9_3qaQlFh0WCyk1IrLIhSH1Zsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 spamscore=0 mlxlogscore=951 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100120
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 02:25:01PM -0800, Shakeel Butt wrote:
> On Thu, Feb 10, 2022 at 12:03 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Feb 10, 2022 at 12:14:35AM -0800, Shakeel Butt wrote:
> > > Currently the kernel force charges the allocations which have __GFP_HIGH
> > > flag without triggering the memory reclaim. __GFP_HIGH indicates that
> > > the caller is high priority and since commit 869712fd3de5 ("mm:
> > > memcontrol: fix network errors from failing __GFP_ATOMIC charges") the
> > > kernel let such allocations do force charging. Please note that
> > > __GFP_ATOMIC has been replaced by __GFP_HIGH.
> > >
> > > __GFP_HIGH does not tell if the caller can block or can trigger reclaim.
> > > There are separate checks to determine that. So, there is no need to
> > > skip reclaim for __GFP_HIGH allocations. So, handle __GFP_HIGH together
> > > with __GFP_NOFAIL which also does force charging.
> >
> > This sounds very reasonable. But shouldn't we check if __GFP_DIRECT_RECLAIM
> > is set and bail out otherwise?
> >
> 
> We already have a gfpflags_allow_blocking() check which checks for
> __GFP_DIRECT_RECLAIM.

Indeed. Please, feel free to add
Reviewed-by: Roman Gushchin <guro@fb.com> to the patch.

Thank you!
