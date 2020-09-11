Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75872266A51
	for <lists+cgroups@lfdr.de>; Fri, 11 Sep 2020 23:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIKVwB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 17:52:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgIKVvz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 17:51:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08BLhr9V021238;
        Fri, 11 Sep 2020 14:51:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+cHyWJM/k6ZvAGNU1rhyNtRlMgYYyGXeA8nsE+XExs4=;
 b=qtUJMGD4ittKGAab9GoWTFdNnO57VoeRfbKBG9J/dfGWEIq+l6ajhCF0mvTeZVR1H3Bz
 0VPrcPukSnYMqDT72At1wGUu3rNEeA5+yJZEDOOxCwdzx5YKP9b8/fV0cW3qCkd+xRcJ
 ii+vGVNWFJzyhWAHbVcOJoOALJq/Om0/kvM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 33exvj71ux-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Sep 2020 14:51:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 11 Sep 2020 14:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWqSedXmmw11IxZjESkRUM3ObYGEo6Dv4CUPMB5BmMIGissNQHW7MmDNVyRKx5ZvLRRjcs52FWRFeOd77xrP41CtKooNKQQ8lc9tRWI8eymy4n7ifYNCos4zjjPcPVhMUWKs0+56rC1AiwR6Eop2iVQCPtXi9vEB3/vPvDH4QyNAC52xVBZYwFGtqCYO4RxrdDaEj9BLTfc053sgR6cbJYQ1DM97Zb18s40YGLpyd8ZJFF5XX92U8LDxNsXQzmXQeEjWmFTe6njErzTl+glPuMy/we68GYIy8y8fx3jw7ZHot3rFoZSYLY+Vz1Nxpyj0X9DF1Rpg0mj7OlWFncfTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cHyWJM/k6ZvAGNU1rhyNtRlMgYYyGXeA8nsE+XExs4=;
 b=njwRdy6uxiFnBEyV+jFd5ChpD0e/luZUoZDIrIr1mDKc0GUXW8Oe5QJkbTqW7b4Bd5V3PQJw9z/X5wfvMZlmrb8H2xmlbcUJrPM960TN5abtJf/SlVk7BUtqarZFSD+aOr0vhyxsqR9NDKaGFz1DUgPtMmH1dRu5e8P9Ejp/DBRHgZffW8+EUbYOG/c6SyoVsMVlyXNM4qrBwlyqxJLjJmtvGHoakzQG0WCB7xikWGsj/6o2c+pi2zqwKCjmdKXlL8DauADcg4txawG9ESaUH6Hj0a8CHVR5L9xwbHyIn0EdcgkK+rab0wzRM9O1jKOyErDwpp9/PKiDDOSSZHWPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cHyWJM/k6ZvAGNU1rhyNtRlMgYYyGXeA8nsE+XExs4=;
 b=BWoNeM4+d2BGt9cA7hcV4/vwCApbH/DGxZNR49OFQ8wt/TQVhRooBfLGXc04BaJD6RfyyvEmGsNlvZ3JpcrGMH9LVVNO1FOLhfP0UFMLCOBuDSqdsqWydzyp5SavrlPWDFcyxHSzr4XKdL9WkAR0Cx8AM2sJv3qHxiNnLc6Fens=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2215.namprd15.prod.outlook.com (2603:10b6:a02:89::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 21:51:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 21:51:38 +0000
Date:   Fri, 11 Sep 2020 14:51:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Add the missing numa stat
 of anon and file for cgroup v2
Message-ID: <20200911215133.GD1163084@carbon.dhcp.thefacebook.com>
References: <20200910084258.22293-1-songmuchun@bytedance.com>
 <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com>
 <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com>
X-ClientProxiedBy: MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c003) by MWHPR10CA0005.namprd10.prod.outlook.com (2603:10b6:301::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 21:51:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:c003]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d57eeb-8400-4727-a99b-08d8569cdc21
X-MS-TrafficTypeDiagnostic: BYAPR15MB2215:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2215CD1AD112606EF8F50FBEBE240@BYAPR15MB2215.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9w2tY8xpUYo7G/ZoEVIXajS4Yi+vJwLpDIOHvmSPFnkKDlonnRu0qe9J/ZF+2/lW0rGTga1NG/P2j+CALeW6FivB7NrnFcCdW9bxaCZ4vJQnhsOZjcxaiYkZpwCl5U1SsyqkQ9nwlRePlxBwYOAFkYqNCEfAdjslMFbOj7C4aip0FsYihzwN8qPBcaDxjZ+3asrSx20mXlnkBldJizoCyI74YUvcYYBSKW2WvaZuN6+qOBVh3t7YrvBAGxRniNoJ/+vZB3neJs6JyKytUZAVKR2+t/y9j5Z3xgDKqjVNnPIpS6tmLVF1RQm3xIi/EuwXJSxSLE70pnQ5emu+qCht2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(346002)(376002)(366004)(8936002)(6666004)(53546011)(8676002)(6506007)(4326008)(186003)(6916009)(55016002)(66476007)(54906003)(86362001)(33656002)(16526019)(66556008)(66946007)(9686003)(478600001)(2906002)(52116002)(83380400001)(7696005)(1076003)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: L3mJxHH87JyRvHKpibNC78RDt4ETir12hBhiJbw/0q+JgwrN7LAlanklxV4WaypEK8CyRdRMFBYRuXb6/mICOaf7G2uULPD4BpMiljcJJKrPidoBl6Qs6UVCUUywZSJpRvYgkDXo9OjU8dgntQDg9wo8nEdcM4OSS0L1XtMIOiS6OgeRx4IPqoziC0pSxvnDi8r2SqHe1+O/xN/P1sNFODA50dWIWYUhywLCgzzusHOYfsbIEIgfrByCYXcVAP6OiLHzI17W36Z8s98uM8ESUGx2BeScFzpT0gnJxoibtu091kLbxLyU0JOqogxly6QSgzcKk6mWIjByGAHX7FOxxgadUarMkFPPqzGJZw2ZOD7h/sopYabaJI9AXnIfHeh8d1iC8BbQEjYaEZDaFPP3m6Jt+sqx3sy1iLm0T4UTVKbsvlPLyn/rSanNEcqxjXdbkl45vF8CxR7UjHh00UsSZIUoG2070r0S6BMgWCD/fd7//z304c+ZIsjUcmWWU58WEI5UJAtHZNODvKzgmdR3Kx2o8VuTvnPUZd5V0BHJNV0ViOCMdAiybWW+G6Pg8Fy1ji2Wk2raGedc4U4VTa5IncqwfRBkxsmL4EaMs0LpvQvtHOqGuoGj9rTOUEKJ7ac5bCR+qjDpPzaH3QJ9MQ9KIQaDRvD/Jc9xF16BoFwLxpA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d57eeb-8400-4727-a99b-08d8569cdc21
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 21:51:38.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTVkD+goG6xbjoGq/Tq+rNpokia05ZLLUb9WVcWv5ngOgPmMWi+pPVVbSlnjskUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2215
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_12:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=1 clxscore=1011
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110176
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 11, 2020 at 11:51:42AM +0800, Muchun Song wrote:
> On Fri, Sep 11, 2020 at 12:02 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Sep 10, 2020 at 1:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > In the cgroup v1, we have a numa_stat interface. This is useful for
> > > providing visibility into the numa locality information within an
> > > memcg since the pages are allowed to be allocated from any physical
> > > node. One of the use cases is evaluating application performance by
> > > combining this information with the application's CPU allocation.
> > > But the cgroup v2 does not. So this patch adds the missing information.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> >
> > I am actually working on exposing this info on v2 as well.
> >
> > >  mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 75cd1a1e66c8..c779673f29b2 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1492,10 +1492,34 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> > >         return false;
> > >  }
> > >
> > > +#ifdef CONFIG_NUMA
> > > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > > +                                          unsigned int nid,
> > > +                                          enum node_stat_item idx)
> > > +{
> > > +       long x;
> > > +       struct mem_cgroup_per_node *pn;
> > > +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > > +
> > > +       VM_BUG_ON(nid >= nr_node_ids);
> > > +
> > > +       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > > +       x = atomic_long_read(&pn->lruvec_stat[idx]);
> > > +#ifdef CONFIG_SMP
> > > +       if (x < 0)
> > > +               x = 0;
> > > +#endif
> > > +       return x;
> > > +}
> > > +#endif
> > > +
> > >  static char *memory_stat_format(struct mem_cgroup *memcg)
> > >  {
> > >         struct seq_buf s;
> > >         int i;
> > > +#ifdef CONFIG_NUMA
> > > +       int nid;
> > > +#endif
> > >
> > >         seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> > >         if (!s.buffer)
> > > @@ -1512,12 +1536,30 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> > >          * Current memory state:
> > >          */
> > >
> >
> > Let's not break the parsers of memory.stat. I would prefer a separate
> > interface like v1 i.e. memory.numa_stat.
> 
> It is also a good idea to expose a new interface like memory.numa_stat.
> 
> >
> > > -       seq_buf_printf(&s, "anon %llu\n",
> > > +       seq_buf_printf(&s, "anon %llu",
> > >                        (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
> > >                        PAGE_SIZE);
> > > -       seq_buf_printf(&s, "file %llu\n",
> > > +#ifdef CONFIG_NUMA
> > > +       for_each_node_state(nid, N_MEMORY)
> > > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > > +                              (u64)memcg_node_page_state(memcg, nid,
> > > +                                                         NR_ANON_MAPPED) *
> > > +                              PAGE_SIZE);
> > > +#endif
> > > +       seq_buf_putc(&s, '\n');
> > > +
> > > +       seq_buf_printf(&s, "file %llu",
> > >                        (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
> > >                        PAGE_SIZE);
> > > +#ifdef CONFIG_NUMA
> > > +       for_each_node_state(nid, N_MEMORY)
> > > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > > +                              (u64)memcg_node_page_state(memcg, nid,
> > > +                                                         NR_FILE_PAGES) *
> > > +                              PAGE_SIZE);
> > > +#endif
> > > +       seq_buf_putc(&s, '\n');
> > > +
> >
> > The v1's numa_stat exposes the LRUs, why NR_ANON_MAPPED and NR_FILE_PAGES?
> 
> If we want to expose the anon per node, we need to add inactive anon and
> active anon together. Why not use NR_ANON_MAPPED directly?
> 
> >
> > Also I think exposing slab_[un]reclaimable per node would be beneficial as well.
> 
> Yeah, I agree with you. Maybe kernel_stack and percpu also should
> be exposed.

Percpu allocations are usually spread over multiple pages and numa nodes,
so there are no per-node pepcpu counters.

Thanks!

> 
> >
> > >         seq_buf_printf(&s, "kernel_stack %llu\n",
> > >                        (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
> > >                        1024);
> > > --
> > > 2.20.1
> > >
> 
> 
> 
> -- 
> Yours,
> Muchun
