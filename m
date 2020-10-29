Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0537429DBD7
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 01:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgJ2APz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 20:15:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37532 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgJ2AOv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 20:14:51 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T08wGZ028583;
        Wed, 28 Oct 2020 17:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=e4qfs3c6hq3qjYfIkZbRYlr987dDDr1SrVeVnLIVytY=;
 b=BCnjdE8miFZTGvw73MM1WJfUTq2WD9Ck/jXMWtjx89Yx7p4OxYVdhh4RED3qr6U2w4wE
 7y5K9rXIuYi+nO06VWUrt9wH7k5RvOUAsHqE8L2uLtyhbvXAP4AZWo94Lq5yreOOuVS1
 7zH5yq5Au6mbcu1FULQDBKq0UqEHtkEqlGo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34egnfb337-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Oct 2020 17:14:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 17:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0ruUuJZ8fuRmos0ck5pyOWnL50iF2s7S9YTaDBqfPFDCzsTkGuzwpO5nvkNmzfGD7xj7pCbXinzRF0Lnsf1iUha5K3afmWzvWuH1nQqCD44Vcpvo6WARfXGUaXZQ4pShm/IMH0ldOFmYuolVJ5Rv28VvHDuVDHUTPwsJdt5m0YVJp1aR+CIWBajeyb0rm3pjlo9Y2zY6K4PDSQJzjfyI2sZmBHWjaMcJ+TnJDH6hFvHwyzerCC8/kW8QPqcybw43oAdJELy3WcmfWgP44bAHx7bDOCRIbtSBsAVrCXEtUzbJ7tEJkbNOuJ6Ieo9yk4sur6DluDQhwtP+tNfzBmp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4qfs3c6hq3qjYfIkZbRYlr987dDDr1SrVeVnLIVytY=;
 b=R0QZXnLmVsLU8YijmBl5fksRJXKc08NsfawswtfQdgYBgbPmxi+uO/TiMElYocHMYsmUh/Kr7PCdvJoxAFpp3wnGOgJQ/FKjs1u5ClWBXwNMp74edpdt7JTHH7YoaWOkF9RrIPhyGxEAtHvc9pK2HyOmJJal3qWTq1qHOqdb3wTMG7vdUO6DsJPMNIxLMNUjnkr4tNbT716iR+AsV1BrktSxYdlY2l1q0y/l+0WIWGfI2Rd17bKg3iCgdgSERYFyY8vdpxuVbJ9ljUFFny7y295zTCwHlzc7FoxDecKSda/s1QzPb2qaKp4xPxLfHvNrfItXILcfDWDOK+3s2tS5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4qfs3c6hq3qjYfIkZbRYlr987dDDr1SrVeVnLIVytY=;
 b=ZH7NUGHHjQOVtdvr/VTyuYtoHCzC2t211QRqE0B+Q/vfhqPe9lTs9Rw+N3Kts8pdiysNQI+o46Q5k0Rf9ilHd1bhLxnZFcHgjrBvDvBR/ULuxR+UFd0TR0mfd7X87BVitAA7OsmLjxVwjAtGEZHLBYOk4OoSwufDwyERY+9n6J0=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3352.namprd15.prod.outlook.com (2603:10b6:a03:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 00:14:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 00:14:13 +0000
Date:   Wed, 28 Oct 2020 17:14:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, <esyr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>, <areber@redhat.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
Message-ID: <20201029001408.GF827280@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com>
 <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
 <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::4:cadf]
X-ClientProxiedBy: MWHPR22CA0033.namprd22.prod.outlook.com
 (2603:10b6:300:69::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:cadf) by MWHPR22CA0033.namprd22.prod.outlook.com (2603:10b6:300:69::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 00:14:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee3e4fdc-1a7f-48f8-42a8-08d87b9f90fd
X-MS-TrafficTypeDiagnostic: BYAPR15MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3352923646DA993C81676627BE140@BYAPR15MB3352.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZ3f/Vzr8ENbGiR46eu6b2FDGUgHKW6dgdD+0NM3TzFOHmL6gdARJFpM3K5u9SB6Y+SwxxTKSw484NMS9pOpzUQeiSHrmdf1qiQN2iYXE+f6rbQqIgwXlL/6kA5crEhJam4+7tZbShN5KyBJp1oPM94sSZEpFtOo8pQX8+65fwMSDJTYZueoK4dMxZPxjkPYfLqDtxQfFr5aUFcVoRDPitZTNRFmP/5Wr6LxgB0QjXEY30XzDqwHZiSzlMH2BDVPf5sMDAUvM7HvWCtjmnj3m7OOu/UoGjR16gk7HkEM2JAEUbic7iRW/yE6btNWExcBD4yIrUa0hVYUSWhBOFbE++d4DSMxQakLWbMa3uxlt7KmePdMsTUUpGYNqhryFq2C9nv65oDKgulAO6gM+QXkdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(5660300002)(2906002)(7416002)(86362001)(83380400001)(55016002)(8676002)(6916009)(66946007)(66476007)(66556008)(1076003)(8936002)(9686003)(478600001)(33656002)(16526019)(6666004)(186003)(52116002)(966005)(7696005)(54906003)(316002)(6506007)(4326008)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rCGfQO7XyYY3DtAoGfiWB/dvXR2CGNtfmzB+lMC/ikf0lrF5zKPfwpgWSeT0NFCWfUc2NY2hm1MS8DmFJiD7tQnSi6WUzSv1dbgoZD7aTmSn8DNdk5qc/22cWP07+b9Yze8thdFisOHA77oayyxdfFt/mRD5A44g3vkr2h5VLfrvotvV1PXLRnGTIL3+qucR6r972/tpy91wPtlPnBgV2sBbTL1myGF8mzQtF3TGu1mRNIEfzKVX9NIePkXr3yF4cRUbpYa1ctTJ6scz/pLkg0FEN1uTgfF3JIQ66GgpegUVDLvJLVvrrWb6XMKFxVBs1Tjx5+DO3mJcnZ9MYWc4TvVTkV+wTdRC5rfptScIdjcOakaKZEAgehBphr5ET1Ngm2GTesUHE60ZCva/XohW0XH2t0fES7hv87VXJ4L7C7JQIJXIjqQvdUToI8NAToddg4ZlZBSlhqpXBmaH5BwnTxMMn69tB1/QPMiAOGCmI44j5fDDPH1kd4bs/KW3w9ex6nL4Pv7hK6M4w9vNJ68flT2kN8ggPnvw4Qlu6H8w1+KJUnG91zbCVGX5XRNMRpufpbfc7HRshYp9DEnCEeBzM06APSrJGS2JwvRyP2W3vCznaVjP6pCeTrWB9OML2QACArY8pgDh7CofFCkKzDXGqnTcggW4TLVvY5aJkq1bwWw=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3e4fdc-1a7f-48f8-42a8-08d87b9f90fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 00:14:13.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZeJO55DuMQu4Q40pIKKSc9mSRKQIJYfCPVvMQp8KxnMqKxqzDKM9OlaZ2JlaWEQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3352
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_09:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 28, 2020 at 10:56:20AM +0800, Muchun Song wrote:
> On Wed, Oct 28, 2020 at 2:48 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> > > If we reparent the slab objects to the root memcg, when we free
> > > the slab object, we need to update the per-memcg vmstats to keep
> > > it correct for the root memcg. Now this at least affects the vmstat
> > > of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> > > size is smaller than the PAGE_SIZE.
> > >
> > > Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Can you, please, drop this patch for now?
> >
> > I'm working on a bigger cleanup related to the handling of the root memory
> > cgroup (I sent a link earlier in this thread), which already does a similar change.
> > There are several issues like this one, so it will be nice to fix them all at once.
> 
> I have read the patch of https://lkml.org/lkml/2020/10/14/869. You
> mean this patch
> fixes this issue? It chooses to uncharge the root memcg. But here we may need to
> uncharge the root memcg to keep root vmstats correct. If we do not do
> this, we can
> see the wrong vmstats via root memory.stat(e.g. NR_KERNEL_STACK_KB).

I pointed at a different patch in the same thread (it looks like you read the first one):
https://lkml.org/lkml/2020/10/21/612

It contained the following part:

@@ -868,7 +860,7 @@ void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 	memcg = mem_cgroup_from_obj(p);
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg || memcg == root_mem_cgroup) {
+	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
 	} else {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);

So it's exactly what your patch does.

Thanks!
