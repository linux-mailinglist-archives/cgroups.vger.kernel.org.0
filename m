Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055951D58AB
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEOSJf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 14:09:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25106 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOSJf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 14:09:35 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04FI4Qoi021254;
        Fri, 15 May 2020 11:09:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RcI6OHGgK4YWHkA1rH8nPRWPfe72HImVBKslGk0WzHU=;
 b=Di3hwkUHf5rWB9TwGxAqPp58046vqQFKhiJ18Dhk18BFhw2r+MHc3qlbZ98rYKVcvrPU
 n5FCSn29mmI2pnTJ+KFwokaO/3uLqb66lYYO1mfeyFWn4DKzJnDj27u28i3vHDfIRidP
 gvOFKzzVRtgB8DqRhF3A4V/5gKwaglnf3us= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3100xhkbgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 11:09:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 15 May 2020 11:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0c6ecFZSqF0P9GRUsPqAGvG+Y86E0pDyxLMfL9wlb9HYr447VkU3vmDk/LroYYFYdwvcMjHodBjkroFueR9xHfjF3+g7Ilq5CqJtCyAwwZlpRZASzxMMvOE8y8RkMQWYHMo5OOedrVviSqBJbaHoBFpRxpLYUGVg9hZ00NzxmbQ9QG5Op+s8PINB5KbtMCITNvDTpbwjfvH6WbmWSvounwUrgink0qkcjFTcX1W/BzsmTs/rPYvQiUTtzTi7MepnIB8Oij4CAFFitKdxCpR9ikfyc94iIz86Y7Xhw3fV3ug46HxnP+UnYPkjcSZXZF6kC+4fziNdK83vu8BwhoHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcI6OHGgK4YWHkA1rH8nPRWPfe72HImVBKslGk0WzHU=;
 b=TCJ8eUmu3ehyQ9O3DkutkW5O3azpUsUo0c9LS6cOMGl+jHZDowSU7USbmX/rmgsBaPbgn/MeZYUYhs5hHvBB5GJKEvpcvHGk6VxWCWftXdlEuiv46U6Q66iu6Pr5aq8TM9FKjb6qZv1NaknP9qqVKNjklX4MXRxWQrBuyahm0D9O/FEfeFpOU8YJx4QL3U5CtljYELZuSXQ4pyY7lWDqCfAc4a0zOrKzNdsLQXlx7R2XhUXUqbCQ7A+ztpZKeEolfW4/xqJkKJdbbYXOTmCSvD9nQckZBAW4BxyxAhksP/Wj9XKxkUUSo5g47vi1vs/ZP3R0Es0A2efcYKd344Lcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcI6OHGgK4YWHkA1rH8nPRWPfe72HImVBKslGk0WzHU=;
 b=BLVTxonYwgJvhMVlhQuA72IFi509vGgnc3MxwclyLBFBg6kBS8jMeMWi8qfhAL19p2eoPSXQKRH+Jf5GI4XREhBA/z7kffU6H+Eh3GIPYpwlDt3WikmwuY2EFpxDj7ecgoo0cyfTJnqHBuOdvTHCwobyvUG2KvFGyJoAQSrn6kc=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2278.namprd15.prod.outlook.com (2603:10b6:a02:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Fri, 15 May
 2020 18:09:23 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 18:09:23 +0000
Date:   Fri, 15 May 2020 11:09:20 -0700
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
Message-ID: <20200515180920.GC94522@carbon.DHCP.thefacebook.com>
References: <20200508170630.94406-1-shakeelb@google.com>
 <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz>
 <20200515132421.GC591266@cmpxchg.org>
 <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
 <20200515150026.GA94522@carbon.DHCP.thefacebook.com>
 <CALvZod5EHzK-UzS9WgkzpZ2T+WwA8LottxrTzUi3qFwvUbOk4w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5EHzK-UzS9WgkzpZ2T+WwA8LottxrTzUi3qFwvUbOk4w@mail.gmail.com>
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b821) by BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:09:22 +0000
X-Originating-IP: [2620:10d:c090:400::5:b821]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c18ce7f8-5db3-47c0-53f1-08d7f8fb18c1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2278:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2278ACA00B11F62040A36F60BEBD0@BYAPR15MB2278.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pk0Ux00MBHZXqacdiDgMHPWFovLqnIE4q9UCYaarvRU0gfVVr3BNXItQtHm78TEAY666iVLt2C+l0ygQglZwG40MD6E3nltDKYuYFzZKckz4qBtIb3mHDdbuimYwL43KOlKblxuujyDJNv1skh9KCZ7vHzc61tEnJYz1d9cSiYz9TUSLOEXI8jVPDfoqtm0fxAeaSKqJ5fZUkyrxM7sIj7axHivY4Oq5Guzu8gs7XEhfCidCYQKQEqkxLc0AvB18usA77z3yyyCu2tY/jGrOeKMU+ylp0drI7NJqyuux/YscnPPF4ZwMTaUyToAuQTrG+sTDeaePIH2ow3GN4neunHxbnhVoC2PF8hhXgY2QX3iun4h0LBUjo/pCY3e04IokpZIP0hCx7ua1pXNQ9UxdVIDfXsJC2VAKdn+xv7lX6S3KT9Z6FqIifSptwPwPJKrK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(52116002)(33656002)(7696005)(55016002)(9686003)(5660300002)(86362001)(4326008)(478600001)(1076003)(8676002)(66946007)(316002)(6916009)(2906002)(54906003)(66556008)(186003)(6506007)(53546011)(66476007)(8936002)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bQujxOmwXCJUkg48tqXAm8Ku20k7JJdQakWs6++I6Odmsgq/v07fs3uTJKMIfX/ZLKw8q1AQpVfbBJ8k8v2NpqkuKoWoD5MuothT8GSk9DkF609458mEPw3j9C0tR2uDh4/t08QIN2tte7OSeAFLamZZgTtZ8dffxXfcnsBsHXdrGAu8WlJv/aHNWBcMglyVGTxC3zZMmWLLjnjq/OsCV8VTQExNP5d/2W5ZhmAliPTg9qjFHwuSDnnpfCY3drpxL/83xrS+XNARtxnv/tlrFSILKhlxC+7hHf750zAnungUQ2qrMDhUc/lj+V3BkWZ0A/ajWxMhJBEI9tIAP85etiJJeFt/O99PUCKuDbAJsQDKaGts6uXgIvJaP0SrL7jcGqhU53zQbMUBdLho3NlmS58Lk9m8tt5xl7UhE9lwp6ccpNs7bnpX2Q1p8Rim8Kfi86+bnApVcw4OmJ5g4wyH039Vuj8rbVG4Io8+eCv6C16dDQskx4huffuL/ZTAikru+kCsYI6IsYTAT+VGDFyKAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c18ce7f8-5db3-47c0-53f1-08d7f8fb18c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:09:23.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aeF8aNOiYmzyr4OszQiSMtncn36/iN2NQVI4DJmUnqMVKpch5L+SuIymAKwCgdT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=1 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150151
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 10:49:22AM -0700, Shakeel Butt wrote:
> On Fri, May 15, 2020 at 8:00 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, May 15, 2020 at 06:44:44AM -0700, Shakeel Butt wrote:
> > > On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Fri, May 15, 2020 at 10:29:55AM +0200, Michal Hocko wrote:
> > > > > On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> > > > > > On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > > >
> > > > > > > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > > > > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > > > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > > > > > not updated consistently at the system level and the ratio of these are
> > > > > > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > > > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > > > > > reclaim.
> > > > > > > >
> > > > > > > > Please note that this difference is only for system level vmstats. The
> > > > > > > > cgroup stats returned by memory.stat are actually consistent. The
> > > > > > > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > > > > > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > > > > > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > > > > > > cgroup.
> > > > > > > >
> > > > > > > >       from Johannes Weiner:
> > > > > > > >       There are subtle differences between /proc/vmstat and
> > > > > > > >       memory.stat, and cgroup-aware code that wants to watch the full
> > > > > > > >       hierarchy currently has to know about these intricacies and
> > > > > > > >       translate semantics back and forth.
> > > > >
> > > > > Can we have those subtle differences documented please?
> > > > >
> > > > > > > >
> > > > > > > >       Generally having the fully recursive memory.stat at the root
> > > > > > > >       level could help a broader range of usecases.
> > > > > > >
> > > > > > > The changelog begs the question why we don't just "fix" the
> > > > > > > system-level stats. It may be useful to include the conclusions from
> > > > > > > that discussion, and why there is value in keeping the stats this way.
> > > > > > >
> > > > > >
> > > > > > Right. Andrew, can you please add the following para to the changelog?
> > > > > >
> > > > > > Why not fix the stats by including both the global and cgroup reclaim
> > > > > > activity instead of exposing root cgroup's memory.stat? The reason is
> > > > > > the benefit of having metrics exposing the activity that happens
> > > > > > purely due to machine capacity rather than localized activity that
> > > > > > happens due to the limits throughout the cgroup tree. Additionally
> > > > > > there are userspace tools like sysstat(sar) which reads these stats to
> > > > > > inform about the system level reclaim activity. So, we should not
> > > > > > break such use-cases.
> > > > > >
> > > > > > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > >
> > > > > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > >
> > > > > > Thanks a lot.
> > > > >
> > > > > I was quite surprised that the patch is so simple TBH. For some reason
> > > > > I've still had memories that we do not account for root memcg (likely
> > > > > because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
> > > > > are slightly different here.
> > > >
> > > > Yep, we skip the page_counter for root, but keep in mind that cgroup1
> > > > *does* have a root-level memory.stat, so (for the most part) we've
> > > > been keeping consumer stats for the root level the whole time.
> > > >
> > > > > counters because they are not really all the same. E.g.
> > > > > - mem_cgroup_charge_statistics accounts for each memcg
> > > >
> > > > Yep, that's heritage from cgroup1.
> > > >
> > > > > - memcg_charge_kernel_stack relies on pages being associated with a
> > > > >   memcg and that in turn relies on __memcg_kmem_charge_page which bails
> > > > >   out on root memcg
> > > >
> > > > You're right. It should only bypass the page_counter, but still set
> > > > page->mem_cgroup = root_mem_cgroup, just like user pages.
> >
> > What about kernel threads? We consider them belonging to the root memory
> > cgroup. Should their memory consumption being considered in root-level stats?
> >
> > I'm not sure we really want it, but I guess we need to document how
> > kernel threads are handled.
> >
> 
> What will be the cons of updating root-level stats for kthreads?

It makes total sense for stacks, but not much for the slab memory.
Because it's really "some part of the total slab memory, which is
accounted on the memcg level". And it comes with some performance
overhead.

I'm not really opposing any solution, just saying we need to document
what's included into this statistics and what not.

Thanks!
