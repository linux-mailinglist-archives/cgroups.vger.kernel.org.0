Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF92CCD42
	for <lists+cgroups@lfdr.de>; Thu,  3 Dec 2020 04:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgLCDV6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Dec 2020 22:21:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60542 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbgLCDV5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Dec 2020 22:21:57 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B339ulc014538;
        Wed, 2 Dec 2020 19:21:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Zs34bp8bHYjIfBzqirNIIUOHJapdSElegqWQGPxT5wg=;
 b=h5HFFrmfUYSzhNQYZqcsc9gAB6S+FIMRHU5Y3xHWKH1nrVFxqmlMLo7KdrnXRXNWqewJ
 f+9xuN7vVSmwbeZjQe8mkvSAHVBHLLGxWDWpx7brMAb+GDeh61K1efH0XbQpceIwtL63
 pvjqEmZrWxxB5Kjz7DTmg13nTPLhYA9Dl+M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfkadvm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Dec 2020 19:21:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 19:21:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5nM55h0HuZqEc07BlMCCoORlRGxu0+JJYy5eIknCHq3zzoOCAeSM8XEBeZ+cbYS7r53rzn9CLHMuSkDdoqxSDrdlYbL1PUXFm0Q41WCp3tls/K+8HDiJFz5Jsf7KAsk5pJXTnf2bzT2urG0eDDs8r8R1jBdVPSsiUjlvYIHE4g1TdqqLZWPv68ZQzruqEZP5dOEKp0F676Uvz0Sls4QqCSh+pRkYHoTzrwhpl6ZcMIspEIP9IDRgvOyna0Cd+r5sZ37I8F2CYAtNKNhZ2qsNarsaBR2gkW7DGDax+9CpqBnAIyjIC78dGDChy4le9oFAEvJSrdylKqxnuLfMlYGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs34bp8bHYjIfBzqirNIIUOHJapdSElegqWQGPxT5wg=;
 b=J0VqeI7+Zd6GurfElxnD+3A1QXseDLXoqpv2xMXjQjCpqVDP7WeyXe9JX7KNAxQw4NfRxVXrWI6Y/XzvF2MFdvFBv2Udk2Tzbku8bK1K9oaCll9nbGzlXKaSJH2DOYT6USqvy0ZgEETbydW1kobm2BdrKKbzrdEkw8SW3pxec7WYjlf/lxZtrfH2/GR1BRJzXKWe25KuqEoq9UHRIQPUYxddMislkdxlnQ7nwv/ZkIqP6IkIZydfFu6uSQNO5LOCC9/nqpr9y9jKLnyKK0Gzb4OyXIkTC2vlI1b9MHXU+vg9Od8L/yngDE51ycxribEX+dO9MAbGpY8RNor5x0l0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs34bp8bHYjIfBzqirNIIUOHJapdSElegqWQGPxT5wg=;
 b=csDVWBPhhfxMZbEDXmxTISZXMWmsDrGVUSnZF8kfW0a0Bip6wLDzcrVxiWY1vp4iOCZDZSaIPTfdKBwdTNg3Xhmmb1O5Uzjuc+TFsy0L2IOrAQtlRy9yPvWOcwqw8BE5lVcefL6I8I19zJ3sWL3kKrYYQHf03SxQEPn7YIJtDgQ=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2760.namprd15.prod.outlook.com (2603:10b6:a03:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 03:21:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 03:20:56 +0000
Date:   Wed, 2 Dec 2020 19:20:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm/memcontrol: make the slab calculation
 consistent
Message-ID: <20201203032052.GA1568874@carbon.DHCP.thefacebook.com>
References: <20201202121434.75099-1-songmuchun@bytedance.com>
 <20201202211646.GA1517142@carbon.lan>
 <CAMZfGtWUWAO8J6iBpQLV0T8xPAuQvFTfX9UQ7G2eM_O9C7w83w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWUWAO8J6iBpQLV0T8xPAuQvFTfX9UQ7G2eM_O9C7w83w@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:5b23]
X-ClientProxiedBy: MWHPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:300:116::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5b23) by MWHPR07CA0018.namprd07.prod.outlook.com (2603:10b6:300:116::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 03:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 997ccd0b-62fe-4d43-aba6-08d8973a72cf
X-MS-TrafficTypeDiagnostic: BYAPR15MB2760:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2760BD3FD1BDE69ABC07A57CBEF20@BYAPR15MB2760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dCzwgle5G215Ep+5gL4z4hrGSQVsg93FRVJUer0o/2xZpQqQJ/pSLNaWkD00Nxf7fWiExlQ6f8ZZe+cHU2UEYqBIqfCl6kGLpZeJ1jm7aZC3sPTzhe3IaZmxzVXraamcG2HaUUS2sVVbeQlpdgvcZ+gmmSvP4z5dX0+PxFao48WuVckpFEv4iRrHPJnerQ6LtwANVkNt9KSg6+GNMBIOlFgeOXjQzdrIbeYNmgr4+U52RFko3Jo5ntOoGAv89dhqTNpGB0KWAdd8oxKCDU7AmDBy8AMx2iW7cp4hFfEyC6cflv2YDOSFsXetbT2d+0lbDDL5vAViu6HW9BddjpMToQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(478600001)(6666004)(86362001)(66946007)(55016002)(5660300002)(1076003)(83380400001)(66476007)(66556008)(316002)(52116002)(7696005)(54906003)(2906002)(6506007)(6916009)(16526019)(186003)(8676002)(33656002)(8936002)(4326008)(53546011)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Wal68YEdaWBeM8wujAJrhE01M6ZaDbfL2AEvyJQEXDZljgOMOSUtDsDEjq61?=
 =?us-ascii?Q?jeUNcVdCvC+z0bZvxuvbGMSyrqmqbngQWlSqYG9FM7pRD4TcEmLAlEXu4UbZ?=
 =?us-ascii?Q?RQd826cWHCRF/Omaf0YdPTJ2Nw179XvMYhZbw+XSmBw0AILUyG7lsQKUXhvN?=
 =?us-ascii?Q?2LaTh+Z7Ppq4/Tex80zp9aXz3/mX6gRbhUxGroj2YxQbQxKMHIEObopt6FCD?=
 =?us-ascii?Q?2yKrHax2GVPWfzm05XQycL5jBIePEgR4o/x/1cHqVbu+Hw/geb4CPAV2zQIO?=
 =?us-ascii?Q?k/Z2uqAfi807BZYi5LNhwnzN5kYHt1LdGx46xOwopkPMcG8HVe8ggq5Mh0PD?=
 =?us-ascii?Q?wyKpVSLfATKj/twgiXkXQoE0BvZp/YLUqk20QU27i90Aq2PDhmCy15b7I5yo?=
 =?us-ascii?Q?i9yK7rS4f+mBhBiO/JifRfXkCYNygWMxWq6sGLIfMGbywvfSKuA38/rX0cJ1?=
 =?us-ascii?Q?1keoK65xZdgl9hussAVEBuGH78NO9Y99sAnKHDCwfRBCmzFgXpXMqIfzPyeh?=
 =?us-ascii?Q?3B9BHH/Wm12YqCz44VqX+DzO+CX/iPZUi5/BPlwtl0fsDkMHu8yBsdaZDMKY?=
 =?us-ascii?Q?/kFM6d5r+3/SVSWUCAewpA0Se6Kg09gvYo/pWZUTsv/lDMiLoFwN/OwZt0rT?=
 =?us-ascii?Q?J+QokVEgwISgbdDLuTNSuwMZQeG4u+ENY7Js2WkQtyKDtoW5DjznkGPcRvoc?=
 =?us-ascii?Q?hcUk8W5oJKNlVmeLZBiUtLvk/331l5IbtaUCFZA3gGY6z559RVwC8MzJJzcD?=
 =?us-ascii?Q?5h4HnR7fiG3H4O2k3TnvHtNHnUHwD6UEK+0VsskVCBxjngLFvxcadhCXHAqZ?=
 =?us-ascii?Q?IlnaHox5Drn1d19kCnlBItdFMB99MBrRRowAJuJADa25uBOxFduQtkdIy+Ld?=
 =?us-ascii?Q?Q/qTSDoEo7HiHTVZrvJTH/5k9JfNPSoogU+/wWRUN6pRqcZTPZISUm+6YGyL?=
 =?us-ascii?Q?xU6mhvh+oywZcuUfqmraVUBjMS9ZcFfl8oR69HgnS6UVuHmOKjX3psmugGYA?=
 =?us-ascii?Q?/WRpDhn5Tn0Irh68NOqn+Rfdgw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ccd0b-62fe-4d43-aba6-08d8973a72cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 03:20:56.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFazO+f6RvKOKM5+pTotgyvN13mI5XOZWB9hg+A98wLITQw2mb3CZWGokd+HgK+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2760
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_01:2020-11-30,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=1 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 03, 2020 at 10:53:33AM +0800, Muchun Song wrote:
> On Thu, Dec 3, 2020 at 5:16 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Dec 02, 2020 at 08:14:34PM +0800, Muchun Song wrote:
> > > Although the ratio of the slab is one, we also should read the ratio
> > > from the related memory_stats instead of hard-coding. And the local
> > > variable of size is already the value of slab_unreclaimable. So we
> > > do not need to read again. Simplify the code here.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/memcontrol.c | 22 +++++++++++++++++-----
> > >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > Hi Muchun!
> >
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 9922f1510956..03a9c64560f6 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
> > >       int i;
> > >
> > >       for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
> > > +             switch (memory_stats[i].idx) {
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > -             if (memory_stats[i].idx == NR_ANON_THPS ||
> > > -                 memory_stats[i].idx == NR_FILE_THPS ||
> > > -                 memory_stats[i].idx == NR_SHMEM_THPS)
> > > +             case NR_ANON_THPS:
> > > +             case NR_FILE_THPS:
> > > +             case NR_SHMEM_THPS:
> > >                       memory_stats[i].ratio = HPAGE_PMD_SIZE;
> > > +                     break;
> > >  #endif
> > > +             case NR_SLAB_UNRECLAIMABLE_B:
> > > +                     VM_BUG_ON(i < 1);
> > > +                     VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
> >
> > Please, convert these to BUILD_BUG_ON(), they don't have to be runtime checks.
> 
> Agree. But here we cannot use BUILD_BUG_ON(). The compiler will
> complain about it.

We can!

We just need to change the condition. All we really need to check is that
NR_SLAB_UNRECLAIMABLE_B immediately following NR_SLAB_RECLAIMABLE_B.

Something like BUILD_BUG_ON(NR_SLAB_UNRECLAIMABLE_B != NR_SLAB_RECLAIMABLE_B + 1)
should work (completely untested).

> 
> >
> >
> > > +                     break;
> > > +             default:
> > > +                     break;
> > > +             }
> > > +
> > >               VM_BUG_ON(!memory_stats[i].ratio);
> > >               VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
> > >       }
> > > @@ -1587,8 +1597,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> > >               seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> > >
> >
> > Can you, please, add a small comment here stating that we're printing
> > unreclaimable, reclaimable and the sum of both? It will simplify the reading of the code.
> 
> Will do.

Thank you!
