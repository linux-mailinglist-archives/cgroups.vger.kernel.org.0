Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4114A6881
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 00:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiBAX1M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 18:27:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbiBAX1L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 18:27:11 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211MNIb0012539;
        Tue, 1 Feb 2022 15:26:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kWQGnlsnCQQMA5/UZrmR7fJWxEg/FG4Vtq3Dbuxs0wc=;
 b=aE8VBWGw+iLxQFmkF3hVYk0f5ik/T4l+rbo9tZSVNWhwkGAhMBHqVPTKP67FSrBy69Xg
 LxyFPZEJqGqfxLG3zCoykpl/pnoheAJexOpqmJTFtAyaS0BuFjvWtcr47hjuRM6IzHuu
 +zGPYuo/JH6KXiyl/H+ItTbD2cMP7pHBv1k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dy6n9uhuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 15:26:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 15:26:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC1Aad57Ooi3bU9pI6B4zQN7KeJxSV/z0Kg6/RlbJreKhGBRuu4TLDP9XYXJoBNufhosWpFFcfkro3OhxE3FfqStm5R6dAnyUbfD6I2TEMBn3UPmwjeSi4DdBexDh4J/vcbDuzFw279zbEOw4ZunBSREC8nQLvGS5np/W2qaOqmFybffCdAYLHvN66lE7f95hGAG9OuJHdc5M7VHstubAYwbF+sLNFnp9ZFv6+pJY+wXZoEqydsbNswnLbpCkIB1Dut3t3bRFtOo3lm9zfU2g5FsEkv1KPBXpdURXEzUwXhaOMW1dTfNBNQRp0pU0YFHoVfZj1LnCQWUucpkY8IAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWQGnlsnCQQMA5/UZrmR7fJWxEg/FG4Vtq3Dbuxs0wc=;
 b=n1XJpLP54CTyD6Im0tfiBbQqNwbXeyhecEPawYpa0HsGjpSnA3kpplRSngMNPA+va+bq+KzR64w6qDnQRULQd4KoM4CAuZsbKmRWYAMDboFf090ELDQAdhoi96MpvBhStvvLk6ns9ZkReIm2M6tmgP9zdgxx/cXw/iR2fUKT+gHPwrNxcfXeNzIdST4GvN96fzyvSPAVTg4eT2n4bsgltWa8zsIfVHddOJzLoTOIChTZTMnfmbYoGqNDJxsMOF+k9/74b6UFFyy7QaSzQqUIXbvleGNYH+nQZS8L8q2T7a2JAp8pu+UNfKgct/I6Ql/5MHncG3ACunV8wIoC8pj5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MWHPR15MB1517.namprd15.prod.outlook.com (2603:10b6:300:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 23:26:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 23:26:53 +0000
Date:   Tue, 1 Feb 2022 15:26:48 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH RESEND] mm: memcg: synchronize objcg lists with a
 dedicated spinlock
Message-ID: <YfnBuNYkoTlaX+Wk@carbon.dhcp.thefacebook.com>
References: <Yfm1IHmoGdyUR81T@carbon.dhcp.thefacebook.com>
 <Yfm4yfrrJeTlaJZc@slm.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yfm4yfrrJeTlaJZc@slm.duckdns.org>
X-ClientProxiedBy: MWHPR1401CA0017.namprd14.prod.outlook.com
 (2603:10b6:301:4b::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d04985f4-2a33-496e-678c-08d9e5da5419
X-MS-TrafficTypeDiagnostic: MWHPR15MB1517:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1517F85E83AF37C06FF0BB62BE269@MWHPR15MB1517.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64mwq0trNIa/CjSTq0XXcCVdXmiibkt135F1jhCwxQwM4W0oTXwUb8+dDjlHafsaWLvfrk+S07ytOt81FmAtpqU7bVxjmmHZDpwJrOztfT3EKpP463xpWBKXMFmGpapKSmwflxh10Dv8DPI7aP952up9fxloYXEVWTzTBU/xlUojlvQfVCCsunhsLDWVMgXJsqLC2qbYekGMvsun/8NigSUX7/tfUPZSSG9TxhG2em0KaehC4x26rtie5B9bcw8/RtBqCHAisfyN9oKeMY+pNv4B1xladhVCqTr3YBo4oV8zy6tArBmtBkNRVKj3Ll312G0EdqIYCjqzUhDfm7go//KncdeslqSA0GYFknQxs9YIFQJlH4aVtYK5EE884ej7ZtmP2vYV2cuTc9iqKDeoUd30CJ+Yrz8I7ajVG2PCslUqg6cT/oCGXd8FBWCls6mkLbnTRm618eFPAvriv+9di40aWinZMqoUqH4z539HT/M+IeVYTWuz9cKIw6q5ADy9rE9hTInk67/lYqkYC9Aze60QfdkhPMS9eOrKL/woS9DMmbS95I5q2vpe2stc+EInkPqZEMU/Sbt9M9aJ8NQCNqKbIcqkSJcLxXpDxR7Aymsxpyax9cxJzcbbUcjdaYHSByVuctqWrtOvh8ex9eRMoS2NZFuO8+oEI6h29p+9azMOlFeLKMBhiReClBWX3KMVKhv+oW9Au1ZFIKBQKWOW3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(8936002)(7416002)(5660300002)(8676002)(54906003)(6666004)(4326008)(83380400001)(2906002)(6512007)(86362001)(9686003)(38100700002)(186003)(6486002)(52116002)(6506007)(508600001)(66476007)(66556008)(316002)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GNhhFGgmc1h7W0fKg9mkSK0kQvFjLAA1f5re7nMGbzxgKx4V7m3nb4TswSVv?=
 =?us-ascii?Q?1eEgbImz7vPn0AACTAVY+cFol5ByVaG2sXn85b5WuJ6jYNRWJWHxNLoZD1Yx?=
 =?us-ascii?Q?U986XwInR1SrJewhv613bisUvj/OhX71Ob/IIF78OpGrj//HC9JlSxCWScIf?=
 =?us-ascii?Q?0rzmrv2gWLaokeiPHe8SiqKrYt7z4H0uz2K+z9mXRXle+3UrlALoIHOVwgL9?=
 =?us-ascii?Q?yV6i+bcs1YUEW6zl7FM4WuhIKdy+x7YtlcLS4O4+hxmZw2g4/ygR7IqYGHLD?=
 =?us-ascii?Q?fSkFkWPFHKcCwjFqytFwbYuFWSLlmIfYkXXGYK07kiJZijGT/4h77IUxsCcN?=
 =?us-ascii?Q?VH93TVxBUbfo3039uRkFO8pptqmZlI3MIHee9xU8bsxSviXKtN9E/1S7aSrP?=
 =?us-ascii?Q?eEDpLIOx5ih6F97K7/zGOe5i6c4nk8rYzdhmRAuGLGXm+JkjUNBjjNO2zvAX?=
 =?us-ascii?Q?RcvR6UbnQu5uIrN0PqCN15a4Tk3u+c0zzoapKByKcNBaGQxr1YefP2UMt6s1?=
 =?us-ascii?Q?3NKK+ojqe+891SLqyDlljzhlLFhUHGEhvN8wUBYyGZy+oRyGK9IH2Kph1oCz?=
 =?us-ascii?Q?eAdT6NMnpH1x2KvRkkfk6BxiC4O+/u06mMwS3uhHJcZTA+505i1TGSU7tDQX?=
 =?us-ascii?Q?ysiDhZvKOfoljLl6akJO7YO876jZmFud2RDEb7rkXe3/uTOYJb6t0iLZV87i?=
 =?us-ascii?Q?GRZ4+6hZ3JCBYMYZOaghhsQro4XJVUW0OVU3EtR+wJCy0rai7SuSJUrMzMrT?=
 =?us-ascii?Q?1XthbmLi1y447i57+aE7x3J9qg4l528J1Hm4x9b00agTpBSutrSZYFvJpEGI?=
 =?us-ascii?Q?Ym6vuk5OgcF8nlqbnycEMHNM9wxdNw3sl8D1VuFMfRuucVX051aW7Cnnez1v?=
 =?us-ascii?Q?ay1NhL/v58cVUlfBFslpRpXiiBrs0R/c1FQV3J06yBPBaBpNRABe/5NCbCtv?=
 =?us-ascii?Q?pYeau8NgB3RDZXzXKcgT091tQmroiEv5DQSem6zlP33ksakqABSJ3o52LTm6?=
 =?us-ascii?Q?rFkXDbRfsbS+2XwgjqvZBmT/XwTmqDDA1TCerJ1VYmoeUXcpoV9qe32o83l+?=
 =?us-ascii?Q?Ms7alY80u/qfkN1AKr4IJa8WKbCTO9mRBJ+wBZSsKdD1QHtkVpcvU0PRZsiI?=
 =?us-ascii?Q?JNEpCWEtWCi4i3A5xNyelP+Z46GfiEVAk2QPQhdhradIMRPjiuUvJPkz57E8?=
 =?us-ascii?Q?xJR2ZdHD8Zh4BETdApfdbMUqgPPlGM8FsoouUUhOPkaXAHT5Sif9LZd2elTA?=
 =?us-ascii?Q?rimQvv2VGPsZee8WqtS1XiHsqtWReFIgk11PPSKIWBHrnwzY7hDjZK0fqR2X?=
 =?us-ascii?Q?bQmLihLH9tq71wIdgT/w9hGvAUc7LNgaOn45NHl2ZAksMOmgXMjfbX5jAiJh?=
 =?us-ascii?Q?w0V8wUj8nn3NfKqfGugrKSlFkUiuSHWhc8QfxloIT5goqDF2NxcgCMHKc6E6?=
 =?us-ascii?Q?4R+U2pjxRzyAcJgVP/hR8UnunoWjb+fX62/29t5ayZzdepZokr5wNpTxG9NI?=
 =?us-ascii?Q?DfqN5pqojY7hOs910nMeQ5AyFa6/pE7R1to7WpTeOulPqOjx9DOH5aRdJDrg?=
 =?us-ascii?Q?R/uEfoto5ENzrcUpCm7Z2DRBpe+MarrSNqqsegQ3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d04985f4-2a33-496e-678c-08d9e5da5419
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 23:26:52.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eWlyYS8OSMyyRPPel+OeJaB3rHw87qx1Xi+/bZIt5oDTzlLsw73BRN6PqUYNqQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1517
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: CTJutliaHOOlBU0Qs-GA5zeDyN7EMnvI
X-Proofpoint-GUID: CTJutliaHOOlBU0Qs-GA5zeDyN7EMnvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 mlxlogscore=259 mlxscore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 01, 2022 at 12:48:41PM -1000, Tejun Heo wrote:
> On Tue, Feb 01, 2022 at 02:33:04PM -0800, Roman Gushchin wrote:
> ...
> > In this example a slab allocation from __send_signal() caused a
> > refilling and draining of a percpu objcg stock, resulted in a
> > releasing of another non-related objcg. Objcg release path requires
> > taking the css_set_lock, which is used to synchronize objcg lists.
> > 
> > This can create a circular dependency with the sighandler lock,
> > which is taken with the locked css_set_lock by the freezer code
> > (to freeze a task).
> > 
> > In general it seems that using css_set_lock to synchronize objcg lists
> > makes any slab allocations and deallocation with the locked
> > css_set_lock and any intervened locks risky.
> > 
> > To fix the problem and make the code more robust let's stop using
> > css_set_lock to synchronize objcg lists and use a new dedicated
> > spinlock instead.
> > 
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: cgroups@vger.kernel.org
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thank you!
> 
> I suppose this will go through -mm? If you want me to route it through the
> cgroup tree, please let me know.

I think so, usually this stuff goes through @mm.

Thanks!
