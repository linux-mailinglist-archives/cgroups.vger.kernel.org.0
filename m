Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4D216102
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2020 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGFViu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jul 2020 17:38:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43850 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgGFViu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jul 2020 17:38:50 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066LapdW017402;
        Mon, 6 Jul 2020 14:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lwkY6r4OZaHJitgZp0xrDtujuSGt0l8XV3LwLLwc4HM=;
 b=mhpD1Dbj3kno709ho6TEPhCGrkAw+cWjIjUwPLCeeg3KQ2KMlrh6YrzAvBPXQVmX8I5J
 //dM++JrUH15mZnFrPP6lCqx7xUG5B1zS37xcLtHWQykuy4rakUy825sLXeGu4FzUVQf
 m2qn/0wXU3AyH0g216yOPaokaXXTMV8btVk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3239fnpj6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 14:38:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 14:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFJCRXKmAof1tksSepXGR/u9YPDFfEv68SRsc5NLS1DphWrpMf7RCd5x2fSOnc33hxHlmf+W9PIaCcI5cKZx8MYrqaSwubiNo5/GSUHZwSzbLWk5jTg0znG8cB7wivgO283rT5A+/mY70tDvQDRfTR/Tg4u80mZzNMZsQRWcMl2zNKEoLYGiMlQXgkgnXZ1JpPMkmLl2P8FoREiQODA2exeu/SiHp7cHzrb8gfwD9Ns7GHUgbfQhCgvKFjgN+vn4pvpTItqcMjzAV+zbHnkjFGm2aDF/18p3PkXDkDL+j8kZU6h6zywu7ootIWdxyrB51ppBXIfVvpWCtLaS+75EFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkY6r4OZaHJitgZp0xrDtujuSGt0l8XV3LwLLwc4HM=;
 b=Zl9RcM437okC9SsSPfTe1q2lX8Im0V95AGcb8enfzAmaXjcHOpaWmwta+Anf2iOqlfSvxCdlTYyNUmiie7VlgcvV76eGd5bN/f8aCmVDH2m9F/zxax4WoCrpS9qNOmM9dsxMyq1KpRx85Xuq8P1yz2ke0Fdmajfq/Vx0uz8LPzDKlFOhDyJszSHJp12ET2aiz/b46/ZNsHtQl2drzCbksBiGp3FOrCjCwBLSNILQDIArBCbZbVypyCckp8QoDYMmG1j/wsf2WyjwjhB36n4NDUHzB8Nrl/pdxMZn+udgU47MfbYOypjWNPIjni57BQ6rzPcahYaaDPqYj0Qa2Yu5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwkY6r4OZaHJitgZp0xrDtujuSGt0l8XV3LwLLwc4HM=;
 b=NljN1bmL/MqBvRrNQ9bUoHCu59KXqdO84jje1Ds6YsANgPHMffB7EglrQz1jTopxnRIO+uqCWvLf9rHkBH9jZQbikWcUyj2hi3PP6WcYjSGnMjr4rhXHKmajC0IqybzNOtJrLxMHYmXRIO7SluL7s8/eK9WuMx40pWE3ITtl/xQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 21:38:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 21:38:36 +0000
Date:   Mon, 6 Jul 2020 14:38:33 -0700
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
Message-ID: <20200706213404.GA152560@carbon.lan>
References: <20200702152222.2630760-1-shakeelb@google.com>
 <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
 <20200703155021.GB114903@carbon.dhcp.thefacebook.com>
 <CALvZod5Z4=1CijJp0QRnx+pdH=Me6sYPXASCxVATnshU0RW-Qw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5Z4=1CijJp0QRnx+pdH=Me6sYPXASCxVATnshU0RW-Qw@mail.gmail.com>
X-ClientProxiedBy: BY5PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:f033) by BY5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:a03:1f4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 21:38:35 +0000
X-Originating-IP: [2620:10d:c090:400::5:f033]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 369de30e-9f98-4c31-ef9b-08d821f4f039
X-MS-TrafficTypeDiagnostic: BYAPR15MB4136:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4136AA82D396A1BA8C08FAD3BE690@BYAPR15MB4136.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ESyWGh4Wol/vg2Yf178zbrkzCxnOFPNIgl94Z7mWRXeudRqYJxtLA4kjCIF+ZwX8zX8qx+SOOMR+LpoSwNGKLQe12OByOX//3qAVnko278IQtKUIOdgvGfQSft/JoP+z9nH54idVh4YRMp0jZChnWMdLI/Nq2/jc/OA8PUA4DffsjHp0zrCy5ZZHrdLL5A6Am+qXcdGTcgqlkVucdJSmCgtAoUmPpRAGjn5S5dFXvbLUZ2rzaaa9iElG4JqlH/zCQ+4Ig6HV6d/d9gkJlI+kjYWS3F8Ol5B2mDW4++eC5YXLIqeH82SIdprvjqYOBq6GhzB0mocDX3nudAWciLDnu1c7sz5SM0mSl71rfvhTe7Anp2nhul0uXzGIuQQ6A/ScHh+WsY0SEdpk9PC0IcOC9PO8xVOvIgY2ICtGaULOjy31t0CAs3M3WxBaWJE3dhmxOMcuhKwu8eSvLsGQXdV8UeQNkV2J6I68/OetT+mE/3TpjUOVdlqe6jKnWk3zmsj/59a1exXEigJsDTQ98bz8Ddm6aWL8xejPCJvb2FP1tW8tLEfxDMGwk6JlYD4RDqE/Mth4qlrWnCe7SSo34ue693eDwV31YQAuJabgnCDcJbPAKg/1bNjaFuZnglvTud3aTbm1TALplcMyiAX1zGo1FB2n72d+ivfHoedlrXZV6jUNYVOk0oOP0ebLJF7U7rKfQvqHhrnc7xq7Gge669CmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(186003)(5660300002)(8886007)(33656002)(36756003)(1076003)(316002)(83380400001)(478600001)(4326008)(16526019)(7416002)(8936002)(66476007)(66556008)(66946007)(86362001)(54906003)(8676002)(55016002)(7696005)(6916009)(9686003)(6506007)(53546011)(52116002)(2906002)(27376004)(200143005);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: wbCyazRi1Ge958U5+BnprjG44a8+2OfMZoMyi/TxvcqStQ/hAVjAkQLK8n7AQRiCTc7B/hw/XNlkUt2dAJHmPHvkWHpmzY4rypWy7nVO5wNA2hQhYQz75GOwSDIz8M5QL3VdSvTmvnKofykKjq+VOIiGY95Ng76oXPEuvi4CFu60NSRQt18PSSYybj5F18sihBU1WYOx+AZxkfjzOKPCuxJ6ZBJhQXnRQJOSjffrG5LWjiIV7ko+8JamYZUUOePwfT7nYRNRquscsP86olLwBs5AmV+DyCut6gagoyidqDCmi/ETFgM6xNTNqMOPn0Rt/lKcUIpqUTQTBidLzcwl5eiysB+/ti1EtaMrsT+ikTp+5xtlHdPi6hJIZgsW4evMsuRHnI28XO0g0BqnGlqQuRvQjOKK4VM9A4BSccsAyUAd7zBpr28pyJet9jAEOn9/g8+AYcsZJ8rxtzFdNewx6l38Dcog+HRlsjK0gh7Q4YAdNgZMImVQanvVs3c9rMDW3L80I4BXWG/5kl1dimOlmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 369de30e-9f98-4c31-ef9b-08d821f4f039
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 21:38:36.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5CVvcBJbIbxDzPzuZlf8x3iYTPTUzrNAYktkNDE9BzK613Wef2l40ZmCdlQCpfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4136
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_20:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 suspectscore=1 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060147
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 03, 2020 at 09:27:19AM -0700, Shakeel Butt wrote:
> On Fri, Jul 3, 2020 at 8:50 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Jul 03, 2020 at 07:23:14AM -0700, Shakeel Butt wrote:
> > > On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > > > [...]
> > > > > Interface options:
> > > > > ------------------
> > > > >
> > > > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > > > >
> > > > > + simple
> > > > > + can be extended to target specific type of memory (anon, file, kmem).
> > > > > - most probably restricted to cgroup v2.
> > > > >
> > > > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > > > >
> > > > > + more general and applicable to other FSes (actually we are using
> > > > > something similar for tmpfs).
> > > > > + can be extended in future to just age the LRUs instead of reclaim or
> > > > > some new use cases.
> > > >
> > > > Could you explain why memory.high as an interface to trigger pro-active
> > > > memory reclaim is not sufficient. Also memory.low limit to protect
> > > > latency sensitve workloads?
> >
> > I initially liked the proposal, but after some thoughts I've realized
> > that I don't know a good use case where memory.high is less useful.
> > Shakeel, what's the typical use case you thinking of?
> > Who and how will use the new interface?
> >
> > >
> > > Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> > > but note that it can also introduce stalls in the application running
> > > in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> > > and we want to reclaim 20MiB from it, we can set the memory.high to
> > > 80MiB but any allocation attempt from the application running in that
> > > memcg can get stalled/throttled. I want the functionality of the
> > > reclaim without potential stalls.
> >
> > But reclaiming some pagecache/swapping out anon pages can always
> > generate some stalls caused by pagefaults, no?
> >
> 
> Thanks for looking into the proposal. Let me answer both of your
> questions together. I have added the two use-cases but let me explain
> the proactive reclaim a bit more as we actually use that in our
> production.
> 
> We have defined tolerable refault rates for the applications based on
> their type (latency sensitive or not). Proactive reclaim is triggered
> in the application based on their current refault rates and usage. If
> the current refault rate exceeds the tolerable refault rate then
> stop/slowdown the proactive reclaim.
> 
> For the second question, yes, each individual refault can induce the
> stall as well but we have more control on that stall as compared to
> stalls due to reclaim. For us almost all the reclaimable memory is
> anon and we use compression based swap, so, the cost of each refault
> is fixed and a couple of microseconds.
> 
> I think the next question is what about the refaults from disk or
> source with highly variable cost. Usually the latency sensitive
> applications remove such uncertainty by mlocking the pages backed by
> such backends (e.g. mlocking the executable) or at least that is the
> case for us.

Got it.

It feels like you're suggesting something similar to memory.high with
something similar to a different gfp flags. In other words, the
difference is only which pages can be reclaimed and which not. I don't
have a definitive answer here, but I wonder if we can somehow
generalize the existing interface? E.g. if the problem is with artificially
induced delays, we can have a config option/sysctl/sysfs knob/something else
which would disable it. Otherwise we risk ending up with many different kinds
of soft memory limits.

Thanks!
