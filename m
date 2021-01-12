Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664C2F3DCC
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 01:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbhALVqR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Jan 2021 16:46:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32434 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730572AbhALVqM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Jan 2021 16:46:12 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CLXB7j031011;
        Tue, 12 Jan 2021 13:45:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zy2Ra99zxj2w3tnSLq9kjegLjUfMyCheRbE4VSZFWVQ=;
 b=m7T4ZMnlHMmgV/1tiUUV6a3G/X5M7/4wxLpRd3nviHHVVtPdq6c90fdq+KuZwPt0lvMT
 LoQ44/jwqzh0YB0x8jM9+xiKSTnm41yc1AF+vJ/O+t74PkXa7xOYhuLt0USfpnzoiKSB
 8q9nQIuOuznAa3BZfOE9DGyY9lXfYJKaKY0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 361fp51pcf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 13:45:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 12 Jan 2021 13:45:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyv9zZHusus6u+Li590WylGxP3KTLIyRxsfjsLhNNn27iqUY0GRtKIfKfh3j3qTtjLY1OWZwDi4af27k1yoQLbVVwWzOTpbupiwoZkdO57yZrsXevoZulm6ybCcqrL7goeNJB2RMFGeLw7rGqJz7wkJX3eyUgsm5IhV3Tr/MNXFcfDeFmkENGMEJ/hH4h/SUVAHUaf79GCI+BOgXw9lvq5Gfzsk3xzUEIHZhg942IgYvuxRnyYlyX1eAP852Vtn4ivyyFld2DczXpUzzVvmfrAN65weR/q71j7eH9LaEBAz1bHgSeoNSIPdBML82Pi5YypHOK6WFNcFHJMmVx9RrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy2Ra99zxj2w3tnSLq9kjegLjUfMyCheRbE4VSZFWVQ=;
 b=BQ40CGHcTUw+3yrFE8QfuddusiwlltiNvcVj5Z0pI2lqy5BszWyaIpAhGJSLEnVhtU8C4VM2A9cLrTX0E+5XrknSaQd/4qwb0EufxgMJknks74sXLek1nbR42wGg+rGLokUTjppW7h/6rl3WNityN30Ss69pG8BPO/ZyVH0bMwR6Yn8bWyUfnLCA/wAsg4CXg1hUWcVbwY+RPEhmIjQ6kBUiGzYVHAgcKjwrzu0LrIgupvX+y7j/vdz6x6Ocjig7Cj7uAyyNBCS9pKvkWZ8ZK6U6cfvU2Fml6zy9tZOq9DHJtfR4zI8XA3My7U9vU+1Ar7CUT9PVu28mzwiiD8ktgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy2Ra99zxj2w3tnSLq9kjegLjUfMyCheRbE4VSZFWVQ=;
 b=IOEI0jKmeIO5z23pcCSjB524prSbEJJ1x7oHXD5mKBzpFDPU7fKq6WML0jAkL/6EPAwi5UX014Bp3CmQJo9/iK5U8zAJQQ+WG866oJm4rjji8EoCWIaYPuCYvVshvqwUDCxhfw+7jCAx/mS0cr10lpP29+m7D3hyiw3/9N/nCtI=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3554.namprd15.prod.outlook.com (2603:10b6:a03:1b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 21:45:17 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::780c:8570:cb1d:dd8c%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 21:45:17 +0000
Date:   Tue, 12 Jan 2021 13:45:12 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210112214512.GC99586@carbon.dhcp.thefacebook.com>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210112170322.GA99586@carbon.dhcp.thefacebook.com>
 <X/38ZwyOE96SAfa9@cmpxchg.org>
 <20210112201237.GB99586@carbon.dhcp.thefacebook.com>
 <X/4Qfxe1OKXACDLM@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/4Qfxe1OKXACDLM@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:ce9]
X-ClientProxiedBy: MW4PR04CA0298.namprd04.prod.outlook.com
 (2603:10b6:303:89::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ce9) by MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 21:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0db03f-75a9-46ed-709a-08d8b74359e4
X-MS-TrafficTypeDiagnostic: BY5PR15MB3554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB35541D56895E39F2D39AD41BBEAA0@BY5PR15MB3554.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04IFoWKd+qsgQdNlYgLOakYc9b7xhC8BZ6w9d6MMggCuQyoAr/p1br1ZdPeYbEe2NCtKxscqaEE3KIZOMlZZGz4t8V5ki7V7++8f7JzBGQyfAuGY4Rs5VvnzrjxLPbO+KVFlU1rdFWyTqjN37P5U9nf3gIxQP1H6Gmk/9OP6vJZBf53ZnQTvTugXnpWrUyA0Ga4ZIdTfWu6O26L4JspdBNNvQjoRaATV6dvedbT4yXBdhKAY4ZyTQXOYSD8KRaSvwYh4GCpTcdYYgugks0MqimK91vBQfH7uctbIPJs4dsjdlfuYHNNIEygKZNzQLny8hw0r85H3oeU0WWL1EhJS5vs381LR8JaZ3y86Atos6YfKcWVrnZ8kVr2q8KPJvugA3K1EjkaySAnn7xzhVV6dXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(66476007)(186003)(4326008)(66556008)(5660300002)(8936002)(6916009)(2906002)(16526019)(9686003)(33656002)(66946007)(6506007)(316002)(8676002)(1076003)(6666004)(55016002)(7696005)(54906003)(83380400001)(52116002)(86362001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mjrA3w1KA9AZg3BgGvhOc34BkRbJr43liVIqjJRxZU7s0TonQuZ/JQ8w8y/Y?=
 =?us-ascii?Q?Hd5+tZqktiawb+3tecUWgIgfoJw3cY25ZgeqyLQvZb4/h+CEFVa5DQE/LBgv?=
 =?us-ascii?Q?t6x/HuXT0W0MbQD7pUzAPZAPM9lQ6Ay5r5CMS5KyyGecBDywarJdxQ29lVnV?=
 =?us-ascii?Q?pZFMAmHFr+WoZqUYsdd7nwy6YCQ8Rs7FMINW/ydbNE4koxXEUv/LyNhR0XZA?=
 =?us-ascii?Q?qG1IeRYEd83syeLvvUAc7V7KZJoPJ15DZ1R2oHxc526WTzaoxjS7U0tGGe4o?=
 =?us-ascii?Q?PDMKx4cm8gTyUn74jpuybReMPTWzS4YsIrVUiUXTGKucorEBmfiyrirju2AK?=
 =?us-ascii?Q?Mlb1bfgushd0teC6mO6l8Gtx9/E2qw6yUYHnGzX9B3lP5H3mc3gLQBvFE6O9?=
 =?us-ascii?Q?UP1BqjJ8YiUjkcxFDcFtT3ExEBVYNNUH3GODm4sde9DLx6MW3SLvwHSbEiiX?=
 =?us-ascii?Q?bv9ga7dCiDoC3+q1WFRphQddBCtIi4EV0JEQNfi+MNavjIOxHQFnd7zj8bwL?=
 =?us-ascii?Q?Vb2H9OewpbkAonjTvi/n2XjOikhcrg5zBzlk+GTNBA629BP0xZDPGFHezckR?=
 =?us-ascii?Q?SR2hBS+ulYmhTYUiEGwHXG9AYv/YI3NaWUA339ivDykM1KDIMQhirn3X5KfZ?=
 =?us-ascii?Q?Wwl8yg2ugOh7tI0PpCQp1jN9wHAiSnEYKy3Qa9dMXeQggoWFbpjTWdFkt1ZQ?=
 =?us-ascii?Q?rEIMFgaa6GeTtcN9wUQUs9URnGXnxqWqMJXkzUILdofofc8cXkMSGzX8cFKT?=
 =?us-ascii?Q?1d3GV5Siq4V5Um/r+6xBKilSl3i3crIG6SbEV/rr0+dW41KDjUKipY71LXgI?=
 =?us-ascii?Q?3UefN/4ZOrDKM1z+Yj+MeFcX+pVVA5LuSj9Oh4gcVrSOi5i93PB7Lyy8mc+j?=
 =?us-ascii?Q?73LtfoBKhE64dkyPRxzxPnWUaO/RzWzb08BT1ScKtNGzBH+dXnQZYDvINi60?=
 =?us-ascii?Q?Xn1An8CTULqwdbt6ezjwMJD6skSkXk/JBM5CD5CSsD96o5JKG2B+KUamT0wy?=
 =?us-ascii?Q?nThDuAsl1a6kAog9zDrJMNye+Q=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 21:45:17.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0db03f-75a9-46ed-709a-08d8b74359e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNS2AKcFY7P848WJWF9DSWPBWW6lRM1gDoMfwezm/SGpd4ujhP6ZYTe3D3lhGhL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3554
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_16:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 12, 2021 at 04:11:27PM -0500, Johannes Weiner wrote:
> On Tue, Jan 12, 2021 at 12:12:37PM -0800, Roman Gushchin wrote:
> > On Tue, Jan 12, 2021 at 02:45:43PM -0500, Johannes Weiner wrote:
> > > On Tue, Jan 12, 2021 at 09:03:22AM -0800, Roman Gushchin wrote:
> > > > On Tue, Jan 12, 2021 at 11:30:11AM -0500, Johannes Weiner wrote:
> > > > > When a value is written to a cgroup's memory.high control file, the
> > > > > write() context first tries to reclaim the cgroup to size before
> > > > > putting the limit in place for the workload. Concurrent charges from
> > > > > the workload can keep such a write() looping in reclaim indefinitely.
> > > > > 
> > > > > In the past, a write to memory.high would first put the limit in place
> > > > > for the workload, then do targeted reclaim until the new limit has
> > > > > been met - similar to how we do it for memory.max. This wasn't prone
> > > > > to the described starvation issue. However, this sequence could cause
> > > > > excessive latencies in the workload, when allocating threads could be
> > > > > put into long penalty sleeps on the sudden memory.high overage created
> > > > > by the write(), before that had a chance to work it off.
> > > > > 
> > > > > Now that memory_high_write() performs reclaim before enforcing the new
> > > > > limit, reflect that the cgroup may well fail to converge due to
> > > > > concurrent workload activity. Bail out of the loop after a few tries.
> > > > > 
> > > > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > > > Cc: <stable@vger.kernel.org> # 5.8+
> > > > > Reported-by: Tejun Heo <tj@kernel.org>
> > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > ---
> > > > >  mm/memcontrol.c | 7 +++----
> > > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index 605f671203ef..63a8d47c1cd3 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> > > > >  
> > > > >  	for (;;) {
> > > > >  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> > > > > -		unsigned long reclaimed;
> > > > >  
> > > > >  		if (nr_pages <= high)
> > > > >  			break;
> > > > > @@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
> > > > >  			continue;
> > > > >  		}
> > > > >  
> > > > > -		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > > > > -							 GFP_KERNEL, true);
> > > > > +		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> > > > > +					     GFP_KERNEL, true);
> > > > >  
> > > > > -		if (!reclaimed && !nr_retries--)
> > > > > +		if (!nr_retries--)
> > > > 
> > > > Shouldn't it be (!reclaimed || !nr_retries) instead?
> > > > 
> > > > If reclaimed == 0, it probably doesn't make much sense to retry.
> > > 
> > > We usually allow nr_retries worth of no-progress reclaim cycles to
> > > make up for intermittent reclaim failures.
> > > 
> > > The difference to OOMs/memory.max is that we don't want to loop
> > > indefinitely on forward progress, but we should allow the usual number
> > > of no-progress loops.
> > 
> > Re memory.max: trying really hard makes sense because we are OOMing otherwise.
> > With memory.high such an idea is questionable: if were not able to reclaim
> > a single page from the first attempt, it's unlikely that we can reclaim many
> > from repeating 16 times.
> > 
> > My concern here is that we can see CPU regressions in some cases when there is
> > no reclaimable memory. Do you think we can win something by trying harder?
> > If so, it's worth mentioning in the commit log. Because it's really a separate
> > change to what's described in the log, to some extent it's a move into an opposite
> > direction.
> 
> Hm, I'm confused what change you are referring to.
> 
> Current upstream allows:
> 
>     a. unlimited progress loops
>     b. 16 no-progress loops
> 
> My patch is fixing the issue resulting from the unlimited progress
> loops in a). This is described in the changelog.
> 
> You seem to be advocating for an unrelated change to the no-progress
> loops condition in b).

Fair enough.

But still the question remains: what are we gaining by trying again after not
being able to reclaim a single page? If you want, it can be done separately,
but it looks like a good idea to me to bail out if we can't reclaim a single
page.

Thanks!
