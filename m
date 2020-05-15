Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9611D52C7
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 17:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgEOPAn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 11:00:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44616 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgEOPAm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 11:00:42 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FErJTU022436;
        Fri, 15 May 2020 08:00:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FXFoHMcftAIBfyNkY53nBPS4LdgInjr/xrQffhf24K0=;
 b=peCNMd+/qci3NvmEQOI2kBqhxxywoWn0pZjQ5W7s89K006cxKDkjkgPqrRjEzSHBLGtO
 ZS1cxJqn752AMFs1DFVIKfilNs/X/Q/jbLblRu6hYf/DQVbaMksuSclCHHUIuJaGDIdh
 2fZxc22B+OcdVqEMIcTV4HEwpQH1OBMz2EA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3111r0rd1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 08:00:32 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 15 May 2020 08:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSmumHqNujZrYW5nCCFRoszvjAN0XWftIqp35QilGf/Hdr4x9sddqV3Zh0eFTpqvFb5nkNeb8ewNHUm6vaw1URvBwqMs0tHUvf5xKgj3zGDg7jd5expmSD+z4FTOdXbtfgBRgMMyKDRqx5/p2/DzjIvm4M352QXx4OJhpzBcOmhRhf2q5IlZjCub3ELxBOL9Dufcw84dc0kKJQRmynp6tl5Bc5XVn6m5OZLngx0ltePbjalLCBwuZHoFAU6jQrvUo0I5nmQlhED6XfYcWUCL3jSBn/PBK6JZlLBhzEHuumMYYneV+7xzs/xVuQzBKrviO3sjsCtHb/F064g1N7QG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXFoHMcftAIBfyNkY53nBPS4LdgInjr/xrQffhf24K0=;
 b=WesUBPevTS8zJxm7XmQ0BsGwYBlutH53ddo5f9imgYDzvH9LTLgCaH4/ERaxDaVzP/PhkjYqtudvxfGjwV+ElfsYl18+36oVRy9wiwblzK7Yp8EIX5CsDgqJEqmdA2gSpol49n/fDLvUISKdE2enEJFIRL0AWMYrI1mbmApVXJjXLf3RRejSMWAN8lk7OGtG5+gXLblKGVB2JfT2XNjxpK3wCafWmW+IEEiq68W16xpSJMgNX8L+hcDtjH8U5DZKGfNMfCvfw5IekAxU1ysNC7fCM96qhrujZguEkzN3QyV698ls5+GERpaM7xn0LyvJA9cW+4wqbp/HY+EzirXaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXFoHMcftAIBfyNkY53nBPS4LdgInjr/xrQffhf24K0=;
 b=EdiXJgHSKPV/6gtXdM7sOScafdrVk4Qb7u3cuubR6eG/wn9F2YzAXc8NpgY3pSbeqeFwCdC4Xub+BdTYSfkJwV+8zd9XX/feTtJZ+CLuqALzv8e3ZCpDE5UDITwDgxzV+HppSOXRuZAADIdyQaKxlOpbxChoFmQmBmhYmXZaHYs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2328.namprd15.prod.outlook.com (2603:10b6:a02:8b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Fri, 15 May
 2020 15:00:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 15:00:29 +0000
Date:   Fri, 15 May 2020 08:00:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200515150026.GA94522@carbon.DHCP.thefacebook.com>
References: <20200508170630.94406-1-shakeelb@google.com>
 <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz>
 <20200515132421.GC591266@cmpxchg.org>
 <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:a03:80::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b821) by BYAPR11CA0071.namprd11.prod.outlook.com (2603:10b6:a03:80::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 15:00:28 +0000
X-Originating-IP: [2620:10d:c090:400::5:b821]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f620c5b6-0d85-41b1-0277-08d7f8e0b512
X-MS-TrafficTypeDiagnostic: BYAPR15MB2328:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2328ACEE756FCC5B8626031CBEBD0@BYAPR15MB2328.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahQmdiLCKT4tnSfuZMwaFm9WRFp3Hf7DNq48oVTxrX2yvcNTnDuyfJ+jt8V26AY2k5/1++sX+j0AkHDX8/Oj0x5c5eQcrjFBhMCmRz3OduMt2u83bo+tYqpXCt68UzG6XRTVVaqN+ig/XJixaKT3o8kFg91fjtkZf6+iaognH1eU/SYj2p21E6hsMX+uq0oUCD/4AY6iznj0SxBE7Q1dfY6RZL3cLZZ1fzzl2KqakWGxnS9tPT7p+vF0j31eQvUZUtpS+Spwyl2cbG7M7dA7Uw7uAAtiQiA1w9eUhBwdf9ecjFl6fdqc2W/LdyShKC6AaRTii9lvyKXCMgxavrqnCG1oM4vyAfMTe5j/ZPjimpmap6OKRXgIfVjJhcx5eNKp3/d53tjciFDCcmyAOfdKlGhqlwl2v5sitA5zmN91rf7Gv0AgpeohH+j6G/T/2gjm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(186003)(478600001)(5660300002)(4326008)(54906003)(33656002)(16526019)(66946007)(66556008)(66476007)(52116002)(9686003)(316002)(55016002)(7696005)(8676002)(6916009)(6506007)(8936002)(53546011)(86362001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6Md74/1cYsxtHOzzei7uMqX2MDerZRNsLpcZAxA9hP8W5O9WFKm65F4/VkVf4nOV7n3vKt9oqq+oMnbh9WCtyZYJHfDHfuOLEpyS7nYsDK7x5nnBvmUc/vt7iay4MyUjO7tHJsWcLh/Ux7IQUJeyrP9s2z+OOJgG5F5TlBfm8tDkcNgBLUKqSe/pzCeHkeeo4p9WFrJll3QJteDXKQvRmyR4m3LEzq3tIF6qoHxm7D74kxiJ5xBHDiwuIDjVzakqy9xFd2afkiIjSJUd3bUorEUXVFsQ80xrlt8QktMDSxr1vhCd9ulfj10OnKXOIMUmlobVq4XlhWHc8ARoAYvL3Dt76prKdVcR8E8MeIKuXRTAT7cQLy6HFfJq94rbg/WdwZMviRdTBZx6Nw0Y0urHYwOUoq8ou0MauHH+LMVsqGU/+51RVJ1onEEREuQ0bqkM3VBpx10oePmPJuy16InE5cV1sHPQgTaMjXFb3bJoq1ArzyNoSmx2Fok50pX+8AXbH9/MElnmMAZ9pWz84wk+pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f620c5b6-0d85-41b1-0277-08d7f8e0b512
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 15:00:29.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbcRMctCfwB09M5aTwMxXMK4Ln+C/+roFMRTZyglXxwvxPK2+Caxq4jDkCm1yenj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_06:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 cotscore=-2147483648
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150129
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 06:44:44AM -0700, Shakeel Butt wrote:
> On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, May 15, 2020 at 10:29:55AM +0200, Michal Hocko wrote:
> > > On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> > > > On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > > > not updated consistently at the system level and the ratio of these are
> > > > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > > > reclaim.
> > > > > >
> > > > > > Please note that this difference is only for system level vmstats. The
> > > > > > cgroup stats returned by memory.stat are actually consistent. The
> > > > > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > > > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > > > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > > > > cgroup.
> > > > > >
> > > > > >       from Johannes Weiner:
> > > > > >       There are subtle differences between /proc/vmstat and
> > > > > >       memory.stat, and cgroup-aware code that wants to watch the full
> > > > > >       hierarchy currently has to know about these intricacies and
> > > > > >       translate semantics back and forth.
> > >
> > > Can we have those subtle differences documented please?
> > >
> > > > > >
> > > > > >       Generally having the fully recursive memory.stat at the root
> > > > > >       level could help a broader range of usecases.
> > > > >
> > > > > The changelog begs the question why we don't just "fix" the
> > > > > system-level stats. It may be useful to include the conclusions from
> > > > > that discussion, and why there is value in keeping the stats this way.
> > > > >
> > > >
> > > > Right. Andrew, can you please add the following para to the changelog?
> > > >
> > > > Why not fix the stats by including both the global and cgroup reclaim
> > > > activity instead of exposing root cgroup's memory.stat? The reason is
> > > > the benefit of having metrics exposing the activity that happens
> > > > purely due to machine capacity rather than localized activity that
> > > > happens due to the limits throughout the cgroup tree. Additionally
> > > > there are userspace tools like sysstat(sar) which reads these stats to
> > > > inform about the system level reclaim activity. So, we should not
> > > > break such use-cases.
> > > >
> > > > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > >
> > > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >
> > > > Thanks a lot.
> > >
> > > I was quite surprised that the patch is so simple TBH. For some reason
> > > I've still had memories that we do not account for root memcg (likely
> > > because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
> > > are slightly different here.
> >
> > Yep, we skip the page_counter for root, but keep in mind that cgroup1
> > *does* have a root-level memory.stat, so (for the most part) we've
> > been keeping consumer stats for the root level the whole time.
> >
> > > counters because they are not really all the same. E.g.
> > > - mem_cgroup_charge_statistics accounts for each memcg
> >
> > Yep, that's heritage from cgroup1.
> >
> > > - memcg_charge_kernel_stack relies on pages being associated with a
> > >   memcg and that in turn relies on __memcg_kmem_charge_page which bails
> > >   out on root memcg
> >
> > You're right. It should only bypass the page_counter, but still set
> > page->mem_cgroup = root_mem_cgroup, just like user pages.

What about kernel threads? We consider them belonging to the root memory
cgroup. Should their memory consumption being considered in root-level stats?

I'm not sure we really want it, but I guess we need to document how
kernel threads are handled.

> >
> > This counter also doesn't get exported on cgroup1, so it would indeed
> > be a new bug. It needs to be fixed before this patch here.
> >
> > > - memcg_charge_slab (NR_SLAB*) skips over root memcg as well
> >
> > Same thing with these two.
> 
> Yes, we skip page_counter for root but not the stats. I will go over
> all the stats and make sure we are not skipping the stats for root.
