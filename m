Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5029C7C1
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 19:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829110AbgJ0StL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 14:49:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21432 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1781685AbgJ0StJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 14:49:09 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RITOQ3031547;
        Tue, 27 Oct 2020 11:48:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YYIDm6vBky5b+eR+z0XP0sxL+m0uO6A3tNoGMTT1CtU=;
 b=QJu+uFzi2/eCW+w1xci9H8MxDFqBLAuAb8ww+S4MVcRG0NGjwCR3ndTCzCej7ugbJ032
 LCk8qKomLUwNiz1fYKnAMOTCXLUouLLlJRVu9ipQbpyy6uGyhXB9nho/6MJ5zkYjSmwq
 pDZj/2yTOsMuGcX8FJNoGciP/UjObPagdos= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34d4hpn29w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 11:48:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 11:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Z0SWYrb3DA7Snb7nUTXAvNR/AUfr0kNT5G3fHDkN/uIGyeTe75wOjCRWXDSu6mBwVGc8W8DTT0esAuMk9/Q/j4QbtOH0doGGhx+ksE111mHM6gNWZpEg3bkdo9W8YB+EB7lpP4YOMowNLu0mPSmTkDn70ioURp4Fobm/sWGJNQYBVU2aE5fhS7StNXxWvH2CMNJPr1zMTrzay2Iam2ZB/nuazTZDXSnSNEN6KoGfzTIzUud6dHkUYtmPdhAFFsgVV8110cS0Xqf2DWIy8Q3havbDvzYuUGmc8C682vszU0ZxTPFfjim+Vy+SzNvrDUxbrFkRqasQAGOVVLRscQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYIDm6vBky5b+eR+z0XP0sxL+m0uO6A3tNoGMTT1CtU=;
 b=Ntpy6ICivinwBRWUpcbTYWTZY5Ko1F24D0OeSK2WJXuEnTNp+IPqR91bmeo73D8UkFJ3dgqXQrkwjiMnfZI3zqBiROYPTCMcnkEC4zkIq0brmQAmA9d/tcg6LEg0Z60qf3z5uKkyhZ5TSjVw0ZPC2Ak0sTV6xJ4IJdiRw/4mUpx0vR+L/aoSZcgSrhUoJdpAge1hjFo2TCYJBtFxpBkbDQn/Wk4OkQprzU094+0AGwqKaKUoeZeNRZqFlIiGus1qUFDAtqLQ/hq0+Zdpv5khBlSj6fUK9ydZ1nieTbH1GOvrDen8Yt2BhFIx8fSchKSsbq85090CIffHRba3EEtP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYIDm6vBky5b+eR+z0XP0sxL+m0uO6A3tNoGMTT1CtU=;
 b=aMocAEx+niVj5PB+ozZM6l0WeJSAzmfS1J4ZaunRT7bniKnoY9EHhIoxINfidWlUygLULUqaTvAuVtonM7wSpqWpLajb1uy/5+C8Bq+qH49vRcmDZ5luNJLuSB1WxQT+TqbhjGUW8MLpMpEQwAb1swKzXRVLvJtzA4K9V2oedlo=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3554.namprd15.prod.outlook.com (2603:10b6:a03:1b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 18:48:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 18:48:42 +0000
Date:   Tue, 27 Oct 2020 11:48:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <iamjoonsoo.kim@lge.com>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <mingo@kernel.org>, <keescook@chromium.org>, <tglx@linutronix.de>,
        <esyr@redhat.com>, <surenb@google.com>, <areber@redhat.com>,
        <elver@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
Message-ID: <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027080256.76497-5-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::4:e2f0]
X-ClientProxiedBy: MWHPR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:301:1::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:e2f0) by MWHPR11CA0018.namprd11.prod.outlook.com (2603:10b6:301:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 18:48:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af5703e-a61f-4dab-4145-08d87aa8ecc8
X-MS-TrafficTypeDiagnostic: BY5PR15MB3554:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3554BD58825D203982AF6FA7BE160@BY5PR15MB3554.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyqRvGYHWoDgki2DIlus+Ek006ci0yq4YH6s0Nlou8y6a52FYxy3Zr3NZBmQkSTEu8aJz1yuLj/1uLO3kyiUH8oEmvyMNeeNKLUFDx7Kv3nJbwYxez5tSbJ4LpPTFh7UO8dACiVFNppIRlxrn3+oSQnOpMVIq39RO346epwZKOGF7dv2Cj+BrVbqffUZEQMnZ3zc0uKOTKWAiya3MCEl0LxYgsvAUaoNkgrYRnyfOvAUeX/sTrOPahmGtdd8dsUdp1mLy3vtKt4NThBDhgzhmmFZ2ovfD0Umc2m2xtReyXdUZmZ460hvanaKxjBDtHrF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(39830400003)(52116002)(7696005)(1076003)(8936002)(8676002)(33656002)(6506007)(6916009)(6666004)(7416002)(66556008)(66476007)(2906002)(83380400001)(508600001)(66946007)(5660300002)(86362001)(16526019)(186003)(9686003)(4326008)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: B02udqK7EclvDo+ZImAaXPfDEt/0NOr+TW8xyOQBVZL58gAzqXDuK/NuPkoF0e85FQGmK15U04t3LkdlpxUuUCoK3UkPNpNRdRHsX/uP1qQBT048fPiBIyvrUCG5RJfSgmka7lqO4H8xvBw+FJJ27CkdZZOX4Kq7Ss0cE3Lfhfo7Qsb74UCJMHRVCE7mE68RadQ4ioXPdLLGdx5V2Kpn83bZ0XMJjo1p9u79NrN1ogjJgScAR4ejm3Iqk+LYfiE2Hs6BT+X77BQWSgVnU8rlddjtSFbCMr4tQX2LtioWrm4DJ/8IcQnzb42eleooYqZ9yjbSYXbYMbVXN6chCVTugxhY8sLVXvRyrvHvLzN9dl0ncNK7lVzRL6aLDTFgjzE2a+KUQbBejDYfBWzuPZtvHecV8JYPsMXVgQ0s12JDOZOrt/rSCvWpBnNLQrCijIj2lgXwgXf3XJZ9R9FUildGY1eesxoaZ6Hn9kqo8Pml8XWGOydpGXTmaiKMbg/49NaLswNcOnAfcs9Vb8aKdFNeUVoMk8uDiUXKZSPJIit5ErGRciFIryz6qb7mS5XjpHGyy3s3XGMkHPSoOahKW7PwIUR1Z9JEO7817ta5s7j4xHof+Zay8TdD5nm4YmYbEge8mFE5qVYoEnHPHhlAw6/WFl2P2bzM1sZ5p6+nrTwpqQU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af5703e-a61f-4dab-4145-08d87aa8ecc8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 18:48:41.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI6Gp/q8SWqKKXaxrmaGNMFEczGyn6/0zBXurEHb8fcBvYWNWLfMX6TRMFogaeiF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3554
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 suspectscore=5 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> If we reparent the slab objects to the root memcg, when we free
> the slab object, we need to update the per-memcg vmstats to keep
> it correct for the root memcg. Now this at least affects the vmstat
> of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> size is smaller than the PAGE_SIZE.
> 
> Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Can you, please, drop this patch for now?

I'm working on a bigger cleanup related to the handling of the root memory
cgroup (I sent a link earlier in this thread), which already does a similar change.
There are several issues like this one, so it will be nice to fix them all at once.

Thank you!

> ---
>  mm/memcontrol.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 22b4fb941b54..70345b15b150 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -875,8 +875,13 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_obj(p);
>  
> -	/* Untracked pages have no memcg, no lruvec. Update only the node */
> -	if (!memcg || memcg == root_mem_cgroup) {
> +	/*
> +	 * Untracked pages have no memcg, no lruvec. Update only the
> +	 * node. If we reparent the slab objects to the root memcg,
> +	 * when we free the slab object, we need to update the per-memcg
> +	 * vmstats to keep it correct for the root memcg.
> +	 */
> +	if (!memcg) {
>  		__mod_node_page_state(pgdat, idx, val);
>  	} else {
>  		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -- 
> 2.20.1
> 
