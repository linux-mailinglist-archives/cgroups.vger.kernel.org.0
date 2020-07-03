Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0506213CFF
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGCPvG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 11:51:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726152AbgGCPvG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 11:51:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 063FopgE017594;
        Fri, 3 Jul 2020 08:50:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DOcCYCRB4XfTEDIs7MNiR/yhRdd2F+O90NRnnfO9C2c=;
 b=pJFhCArgRqeDZ/NqhIoEaZG0CDaA0hN7HiMWBT3ri4KroCCcW57iJ6Apf5QfVvtaPubz
 9eORplTaRh3xI0USCnM7h0YbPpWTmJisIer41MV5zFVnj53TIPJ9jtdXN5Q6psuLvyXA
 kDIEYf0lnZrqJpVnqxjXaITh6gDoRKI1VB8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3216k88406-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Jul 2020 08:50:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 08:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oER130iP97jU4L4Sjhw+8U6UjUT6c9ze3GYWjaEhOUh+yVXczYHENp1rAQEs7IM4gkFim4ObazoM8oQDviV92/nxTMCjgxND3gZJsNKK3MIpfro7qu4Wgp6nNdhbvDDSFXsaI96cxOab9Y+X5zHHpJQv/QDYwWGsXC9w5E9JR519o1OqRJuCgXcAI2Od6oWp9WaTPpsZJw8W+HDtnYPwcfgsvQFV5a80KitTYs4gd2JmaZRwXGS0WFAoGRMiPChyklYbwJt/CNYCcP+aP0cfB854RiQzXo3qDEpeHNMLFzygODzvUngBrIXQZpbxfuKinbidaACmEjJ6I4+f7oB4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOcCYCRB4XfTEDIs7MNiR/yhRdd2F+O90NRnnfO9C2c=;
 b=IXHu0daL+UhQ+eLpUSEMF7tK5NwSZz3tB5OWwWpt6205jxUYOaM3J61j7tU4zXRXbsj/L3PMkR/OaA9pu9MSdHwlsFAloPHN6tDsxpN9/wZCk5zdGZ7TE0Qr6BQNFRPCS+vTUobrqrVCIePCyXOVhFy3xLgCjAn7xyRNbI2e16oXOTx/iIGUXrqDDMAxysMlj60YMqO6X5SOzcE5KDcJxJ22xgDtLGCPfKsKOuZmLY7Q+SkJW1dniOc7DpsliAFvJglCTg/VTIIzroQVY8KiiJGchwVRujw3n7u45wag2eonH0olu5OYLS+sgRaRko0kB9LJE3OEq8W4QJnaDKVs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOcCYCRB4XfTEDIs7MNiR/yhRdd2F+O90NRnnfO9C2c=;
 b=dADx657th+/HWQyt7uhNfD2tGwIeJhmC4X1wQG46y7tHi7NCjFM0OgnPuZH4nJSDTAIw2TlzjlqOEGdiws0N3V+WtPZTemWNvgrNLgYflhOh60YNclQvXGYNHrlXwAwEBbDxETt62shl1yBJ6+AxbOB+p/AO+6b6P5JENPIpHbY=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 3 Jul
 2020 15:50:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.034; Fri, 3 Jul 2020
 15:50:24 +0000
Date:   Fri, 3 Jul 2020 08:50:21 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
Message-ID: <20200703155021.GB114903@carbon.dhcp.thefacebook.com>
References: <20200702152222.2630760-1-shakeelb@google.com>
 <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:93e7) by BY5PR17CA0029.namprd17.prod.outlook.com (2603:10b6:a03:1b8::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27 via Frontend Transport; Fri, 3 Jul 2020 15:50:23 +0000
X-Originating-IP: [2620:10d:c090:400::5:93e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b068f59a-963c-4cc0-6067-08d81f68cc8d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR15MB263085D6A2D81C7240D963CEBE6A0@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umkhnyktxUMEfbwt4DIko2R88Wt5LxnVytX6/1MHoVN4I/46rbdkN/xFjxswj5YLCCuraAHHY/tw1+gkO6MK0EKgEHoUgrDMVae0hugX2e2EyU268ndsw8D4Vh1wBEav97LnLV0zlF0r/KukMBziFI4neq2SWNfHPt8RwR3IOnsHstkKTf1vKy24O1fLYHLDxerk44kFFUxNgMa6hu6xA2238CnGmytWtNzJFOeC+DOXpmyePeF0i+4WZVOO8azqw0Kv2oOaXIWLPIY43cfeCBaxu5cntADDAWgksAUxWR0NvL9FihsVTVXYDshJBI/SeV9CKD2TFHF7VVGXxjbgmt2Wapi/lXDSu7GY/v3MQ4Rk6SFG+PFU8ifrmPLRGmSL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(9686003)(55016002)(316002)(8676002)(83380400001)(7416002)(478600001)(52116002)(7696005)(6506007)(53546011)(8936002)(66946007)(54906003)(1076003)(186003)(16526019)(5660300002)(2906002)(33656002)(86362001)(6916009)(66556008)(66476007)(4326008)(200143005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dm8idg7kyxPF+wZ7p1zEnQ/im5ff9X5JFrtB/n3sKONeUMLNQ+M3ggceoWCbs/QYtMQWebG84cSci9vo274x1WsaRiWlcAYRmaHOGWIZIAatc1gv0QXGgEATqiLw9w3vkxeWIKt2j9HUhZtu7CM5gVDzLhoT1QDWvFu0Lb76rbZBl4chq6Mlj26sz6vLVCBeTVsELyBsEHuUq+9iHFIAYzPDRIKCuqJOS6XGHXmmI1yGw3+LJWAodAu/No2ruhHEBSe2BH9wGa5zvOj9WMNuY1MkAmKtpwY7Z36nD63/BanTMk+JKWBMWqHI93YirGRUouHKCi0fR2xrbWjZGXenE7E6/RkfZ2l3pYRdYYyBbPPJBE6xapiBH6kiaDKus69AcxIIokEY0dQ9/Y9CtD9+u+cNfCfsXjixaK/Mv5KnZurneVlPx+5n1UUmqFyUJpzXE3z1QBB7WY00SIThpYrbGOHROCMvf1LHsF5ikLZI60ZATq3gB8ypVOhDrE1TejrD1aqB6oDLx5QO3g6QbJSqsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b068f59a-963c-4cc0-6067-08d81f68cc8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 15:50:24.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5O0ZX6NyuR5e0FeAKzjJ0ie3fJdhCK7bH3mYkrUtZICnyrPfxLzIR+qKx7S2IY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_10:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=1 spamscore=0 mlxlogscore=837 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030108
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 03, 2020 at 07:23:14AM -0700, Shakeel Butt wrote:
> On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > [...]
> > > Interface options:
> > > ------------------
> > >
> > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > >
> > > + simple
> > > + can be extended to target specific type of memory (anon, file, kmem).
> > > - most probably restricted to cgroup v2.
> > >
> > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > >
> > > + more general and applicable to other FSes (actually we are using
> > > something similar for tmpfs).
> > > + can be extended in future to just age the LRUs instead of reclaim or
> > > some new use cases.
> >
> > Could you explain why memory.high as an interface to trigger pro-active
> > memory reclaim is not sufficient. Also memory.low limit to protect
> > latency sensitve workloads?

I initially liked the proposal, but after some thoughts I've realized
that I don't know a good use case where memory.high is less useful.
Shakeel, what's the typical use case you thinking of?
Who and how will use the new interface?

> 
> Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> but note that it can also introduce stalls in the application running
> in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> and we want to reclaim 20MiB from it, we can set the memory.high to
> 80MiB but any allocation attempt from the application running in that
> memcg can get stalled/throttled. I want the functionality of the
> reclaim without potential stalls.

But reclaiming some pagecache/swapping out anon pages can always
generate some stalls caused by pagefaults, no?

Thanks!
