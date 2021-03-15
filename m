Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7FE33C6DA
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 20:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCOTcl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 15:32:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45308 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbhCOTcZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 15:32:25 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FJTwhr020476;
        Mon, 15 Mar 2021 12:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8Eic15bnwssyrTC0MtuFIgfAK3NI+tsH0PxRIioEzGc=;
 b=BdWoyIaUOgf2LdUSQ/sX36cR3MC/GI45abvSvDnz7FyR/BMqukyL5UHIQuBS0D6rC9SG
 6DcTkoGKgV9vGq4duoHXfQnynSmxTsT2SHxeqrohHKd7b2Go+HXF5ISUq6YBYsIQ2kA9
 2WettMpPV9AlVJrSpjjy07jHm+vfLiF3BfA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 379ebty5ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 12:32:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 12:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQAiUubPY+Dvi02ReTqWs0GHgp0eEHhn04EzNBLoBmmloJukAPmEfZLRfbOEfnYv3RC0NPeJxcqqAfDVMw0zySQF9lIZxQJ93KT/gmYgIr5f+01kg4sWYrKZyhzuer70l9anTzrrcofABrRNas+A+UGPCBxVEph60WZg4iESgtCYUYgOQ/F4qUSe7JruXxZyB06y2JqBrFV61pLl7EBYb2n62rNd3EjJOJLPbDJbjC6TaxJMFJoSjcvG1xBogpHVz/CB4V/jzJ8e7ly5dIyD/ZR2bYufDLORwMaxGgYDn9UHFWQfRe9fqHBj2uRaM3P9kdJjL+HVJ+szOoptvC+L4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Eic15bnwssyrTC0MtuFIgfAK3NI+tsH0PxRIioEzGc=;
 b=ikDr1pvvTO+FRdGBG2xa07uJ8O1d/SK0BPMSAez2nZyUharkq+8xXUdnhcblKLb8jVMLwG+dFKvbqTyo0pU2DIsjpauSH0sTxv5eEHa0S/bF7Lw2cgy8ybjEPuEjzl4m0hU8mw+TCDdzZXQikpUE+Y8SYP3k2lfxnd/9ERbw1KKSJHAubGsgsb683xKIvOErt6cEPmhvbL8m8cgvECv8FA+arKZ0YD1px/CWHJB0zqqmUcnjQiP28l94mMa3z82Nn9+1OgnP8Q4nu8kyd0cUIPd6Yuw6IQzLLmU1YetNr7XrQ1GPHCIkr0WC6czNlzqNyj2JZPDqgGNQVt7NxNcU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2390.namprd15.prod.outlook.com (2603:10b6:a02:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 19:32:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:32:11 +0000
Date:   Mon, 15 Mar 2021 12:32:07 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v2 1/8] memcg: accounting for fib6_nodes cache
Message-ID: <YE+2N0zb9wKTriDH@carbon.dhcp.thefacebook.com>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
 <85b5f428-294b-af57-f496-5be5fddeeeea@virtuozzo.com>
 <20210315100942.3cc98bb4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CALvZod4ct6X_M1fzKufX1jKoO2JEE_ONwEmiDWTbpt-fut85yA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod4ct6X_M1fzKufX1jKoO2JEE_ONwEmiDWTbpt-fut85yA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:ec57]
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ec57) by MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 19:32:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03408409-8371-4b8a-982b-08d8e7e907a2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2390:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23907FE50C3FD1A4F09F0D11BE6C9@BYAPR15MB2390.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAQ6VNNIcgJs5FOzQiU1lVVzGOUOBAnZrtwevIrbINNso8bdxafRWvSDRZ2Q+cU1BYpTubk49H80/0tmsT9/d7ytdaQ43NC67JyU5Q5BL54yp7OKeKSS51ouvOHE2K6K1OygMAh63T4lT2WSgCMaZVaZADvJeZX0hgsIrsSBmcL/yMyA5vhvjANztPLdm2tRnRbDwzyHbVE3aeRoO6Dgzg6nbz5S2GA1ug0XKdjIzedbhy9QOY8PhSwsMhEbAdEZ05RtO5hnD8mOD/W4j1oN4h/jUpe9dzqONeBkjSoy6l0V0lVO+EFICRSlOByRhll7WdNGEF8NmANY4W2XSljj8L3zIbo63hB7qWn/1hjM0d+s/v0RPdRHuRxoecl2rhtmprZqzeSVF4TK6W6yb/jScRBgeZAt90awgfJ0tM8TYFNm1b7utzCDqs33p8/eDkpr6BkVBc85kNuGLA4MHx9BSFZa5La4hl5EviLGoDmdLKUNNzpkakBo6fuYonAYu288aBUMvvnc2Tii8n8IZPHJ+uKBBK/ap5rcRAOCbqEAdMYh0I5Tc0LuX4CIEd/yFS9Q97uboUPc1pP69RepwUz4xzVWI7cS/qC70SqQIlHSOoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(39860400002)(396003)(8936002)(7696005)(15650500001)(53546011)(6666004)(2906002)(52116002)(186003)(8676002)(16526019)(86362001)(9686003)(4326008)(478600001)(55016002)(5660300002)(54906003)(7416002)(83380400001)(6916009)(66556008)(316002)(6506007)(66946007)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OtjomDc375J+CzG5e8xGsDeBbtwmhbkmQJjsajmKrru+YzOA4cnMccIbMDIb?=
 =?us-ascii?Q?Ncxtuh6ninHHVxnpbYRc7K9tuYX54pzlh852ylpqgvdP1yl/dOwlrcJX/Zww?=
 =?us-ascii?Q?h5fWdp1TgOf+OeEm0AFki4TMDG7QNRm5TlVW8Wsp0TnKMBv4+EVQ96/hkMqE?=
 =?us-ascii?Q?Fi/fdDkkMkmSIOmZ+CzayYfaIL72RsrKmmIFFBqlJFWEG37+0aaliRc52ibm?=
 =?us-ascii?Q?+W7O4dGguaOqMd/wj3ooczOVUjXbR1U/NX3NzDT4ZP6lvW1Xl8ADGcPo4vfV?=
 =?us-ascii?Q?9YohesQ0OVcLxq+ZLwCX9BBQ2bstRov9zwV6c6y8Nie5N2UjtiDJU9wbEuLs?=
 =?us-ascii?Q?Zkgwf69I5fvgOBOsqoiygvJQBkX36yQtJNNbm2l+zIpyxekptSL7W6F4j0Q+?=
 =?us-ascii?Q?DPgLE0VVIzCeTU0sanobp3iIgHY6lS7B+P5xZ6NJJcz4Ub7fqvrDnmWqtsMc?=
 =?us-ascii?Q?p1jWBjR1TOWnV0k1TStQsPEBzVi1VzE2YF8uR/xmhYLu/j6BRYZDB7mQkUY5?=
 =?us-ascii?Q?hb2+wjITIoMCqwFjkh7L+G6RYXd4Vhf3qzcRWlgYgDFAgI3XSmMMZ8Np4/47?=
 =?us-ascii?Q?hvwDWVOGbGgPvMYkwWZ/wA0Zak45UdrJe66tFQQi3c+ZsWLvUItoFgAJpCQ2?=
 =?us-ascii?Q?UiNdaT+M+x75LAqpf+XlYKgP2kScF89SeCKRVbTl9us7QjeqI1JyrlcEin2G?=
 =?us-ascii?Q?2IQh9u8X2Rpg/G2nXsYWNROqvRmQIqgENnzFT3LmbDPFCPFiBdnNe++4mGt8?=
 =?us-ascii?Q?blJ58oNA7kvGBigCW1ylUJLXGNZInDe8LK4fHZLulkdD+vzOx0CdJlSga1pk?=
 =?us-ascii?Q?cY4d2/LH3VcHQ8i6JZaiuh3OBcZY6lkPSgwmG8dauivh9mOYX1Qxed8KKpJ1?=
 =?us-ascii?Q?A5fx6CJIG66aEMm4v/G11L1pt60e5iO2dD/g74tvwUbu5Yv9A+xcrqXX1Ai7?=
 =?us-ascii?Q?DDPJ0ZAV1oQGaOoyX1Ppq02Hrqeeeo5hQhGBjd+I2tH9RETMQ2wlFRMc1OgH?=
 =?us-ascii?Q?Ot54XWvPlKPNvT/JEesLh7iJdOcFe6S65+NOcg+YjsOjdADAvcwNI0u9jy55?=
 =?us-ascii?Q?ZqhV/y5Dtn8ngd5DN+bJq03bP6bZx8MRbru+oCqT7WTF9Z3I/5wFEFPFZUDh?=
 =?us-ascii?Q?f0m8uZMnnJhdfmf0b9XnLWSBuloPN0ML5fWvwrK4YLfRM1ijQXmAx7+qk4IQ?=
 =?us-ascii?Q?GsogI1eBS/R7j7DMj6KYtOMZYnAjweuIg9SCpdVLc88yNRz8R+VaOoDD4gI2?=
 =?us-ascii?Q?mxzYfEf1DVVVe9R8nCTz/FP0FPtRnACTrITK5r7fcGFyN6x6XaMOW7rpipXP?=
 =?us-ascii?Q?Bma1nuUnNuPwNmJCqYGs+t4EUHvd4T5sV5UE2kF6TeZpEg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03408409-8371-4b8a-982b-08d8e7e907a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:32:11.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzLtPIkUjUG/RCVRU4Ubiyqmqp0eun/QTyfTdhCXwHyp8oGzW8Ntqx23229iVxM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_11:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 12:24:31PM -0700, Shakeel Butt wrote:
> On Mon, Mar 15, 2021 at 10:09 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 15 Mar 2021 15:23:00 +0300 Vasily Averin wrote:
> > > An untrusted netadmin inside a memcg-limited container can create a
> > > huge number of routing entries. Currently, allocated kernel objects
> > > are not accounted to proper memcg, so this can lead to global memory
> > > shortage on the host and cause lot of OOM kiils.
> > >
> > > One such object is the 'struct fib6_node' mostly allocated in
> > > net/ipv6/route.c::__ip6_ins_rt() inside the lock_bh()/unlock_bh() section:
> > >
> > >  write_lock_bh(&table->tb6_lock);
> > >  err = fib6_add(&table->tb6_root, rt, info, mxc);
> > >  write_unlock_bh(&table->tb6_lock);
> > >
> > > It this case is not enough to simply add SLAB_ACCOUNT to corresponding
> > > kmem cache. The proper memory cgroup still cannot be found due to the
> > > incorrect 'in_interrupt()' check used in memcg_kmem_bypass().
> > > To be sure that caller is not executed in process contxt
> > > '!in_task()' check should be used instead
> >
> > Sorry for a random question, I didn't get the cover letter.
> >
> > What's the overhead of adding SLAB_ACCOUNT?
> >
> 
> The potential overhead is for MEMCG users where we need to
> charge/account each allocation from SLAB_ACCOUNT kmem caches. However
> charging is done in batches, so the cost is amortized. If there is a
> concern about a specific workload then it would be good to see the
> impact of this patch for that workload.
> 
> > Please make sure you CC netdev on series which may impact networking.

In general the overhead is not that big, so I don't think we should argue
too much about every new case where we want to enable the accounting and
rather focus on those few examples (if any?) where it actually hurts
the performance in a meaningful way.

Thanks!
