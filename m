Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540812F87AC
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbhAOV2Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 16:28:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbhAOV2W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 16:28:22 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10FLKeIN016843;
        Fri, 15 Jan 2021 13:27:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TGv8+tiQluOxzdEi4rn/IaPCPnwCDLYSKoUBMnhCqWk=;
 b=c7nrVyZzd6AsEEa8dMcPTP5vfnYe8/RiKLPaQhlY9ewRu+VYrOMZ/R5yVXXsCV9wFjxO
 gKbbIEe4pGHRTwTmYlFUOvIEoCka8VYIl9dVnrAhANJ4yt/EmXVL68salzwBsxOVnO0d
 2SZd6e/NMKJzu6NSR7rDK7Slg+ByyfWDZ+k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 363fn993sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 13:27:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 15 Jan 2021 13:27:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbSNo4bG1AaE0cD5NFfEDdM1pwxp9kIbkbjCAHa3dd0FisIrHo9GdaGQTqTomuQykbY8/TFLCfACmzGGdvVvM0SLPidMj11PKowmKdEe4jBQc1jE+09btRupk83CYxLTH4jJrHQp+He3/O+59xvidsp4Ag/2szf6FJ8Bg39LHQrLjiwQhfoME5YYWZ/6a2FKojmmbUBkMiGIQcvdT3w42PM7JAswFMzkT9G+l2+48RByPxsYXwjo3pnfzRkEQntjFEC6KWpIBdMEX70UcO+kP4R3T9e/cYyENhLb7h0/I8eFbRNdbmgoiS5hqutEYy+H4cQEUgZo40Wl/jBee/7MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGv8+tiQluOxzdEi4rn/IaPCPnwCDLYSKoUBMnhCqWk=;
 b=ocuqtRhm8qDVei21xOyJ5D5jeF10ocwiYR8eaKVtK4MjzC9sSAmyq0Rs3C3lHAerVsLMf9KxFpHqyjxxeKGAxEGpt5Q7DDxwEGP0Kz9I47ggGT3KRr97L65JjbnLlOYZS5Sc7GwEU/ZPMw/i2XiiscgCgelMfvzD46/BMg6Y3zaxPuyPThmzV+QHGecGdvQXidBZG7XnDc8+HRA78L+LljEpq92C3taeq2+hBlekgKZPLvOfu5S1eWaLbBI3+qQZIGIYtSctyaIybpPgAKvCxOY+apOfPHfZeSlYTy0z5PllSG0OZhY7ARpl0eajQblHOleYaXJHuDvymnz+EvdGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGv8+tiQluOxzdEi4rn/IaPCPnwCDLYSKoUBMnhCqWk=;
 b=SuXu61Ca4l/o/JavP/pkxQi30TktAvw51In7wnrliFtdTJj8NEGqrMDfqVZxp2F1qBaGDgMFS3BkiBppgO0E7KBZFiqweESmP/BLBHw5qpQyORLc9dF8OPCkp1eG9H8MwgBjr1WflPN7nisLkr3pmC2zR6IbkMObrRCPIOfXmEI=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2519.namprd15.prod.outlook.com (2603:10b6:a03:14f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 21:27:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%6]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 21:27:28 +0000
Date:   Fri, 15 Jan 2021 13:27:23 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <20210115212723.GB631549@carbon.dhcp.thefacebook.com>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210113144654.GD22493@dhcp22.suse.cz>
 <YAHA4uBSLlnxxAbu@cmpxchg.org>
 <20210115170341.GA631549@carbon.dhcp.thefacebook.com>
 <YAIBSJg3btQ+2CNZ@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAIBSJg3btQ+2CNZ@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:b65a]
X-ClientProxiedBy: MWHPR18CA0065.namprd18.prod.outlook.com
 (2603:10b6:300:39::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b65a) by MWHPR18CA0065.namprd18.prod.outlook.com (2603:10b6:300:39::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 21:27:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47187f6a-6794-4307-3d78-08d8b99c5bc7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2519A024754646E2C22C11C3BEA70@BYAPR15MB2519.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA3beTaZlWUH4f46DqLhscwuuVSpnDZjHcgtAD8Kj9GJ15Udz/Lv8Wgt9+ng+wounpdmkYVvY58tUcdliyYsO1zseSZIS0Fg9fGXlTESbJH6pn7CMscP3M3sIB8n0NgYyNsvYtzPiyFRzTR9KuOwSjiwD1UaHU4g+WeRwlNXN92xNr8nnc/i2wICjjPMRZQ/1xipG3SAB5/On3WNSl0ZL2x8Cz0k8LFGW4Mw7IL7GI4DyHwuUxEH/WUX0UGO3ARK+XQDaSGAcLM+HiIVm+SBSq/VnfwYK0tJTNokFWIncdotIG7gaxiBu3S7DJ2MiSapEXs/tET1Bjt62AnLDXHx7vV/4+VtVhFV1P6kQ7kVGCdHWAjJ+UgVe2zt8oN0C6BVYysYjqEoEsI+kzUF1QoQ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(33656002)(83380400001)(86362001)(8676002)(8936002)(186003)(54906003)(16526019)(478600001)(6506007)(316002)(2906002)(66946007)(9686003)(4326008)(66556008)(6666004)(55016002)(66476007)(6916009)(52116002)(1076003)(7696005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wGFh5grki6alJj5T63dgitWa1n8Xq+GcScVgyoDXVA86sZ1qiPO3IYTtiGIF?=
 =?us-ascii?Q?NclNmI3n0DqXjsUViCn2Y4GiDZx63rDUBjGqXLZVFHP3MoNWbc/r7+3LEhOT?=
 =?us-ascii?Q?8bMa+03K6qlVyubxJLB8ab3/J9EUhLQKqMEkkE3R3f2ME56v9ktYngB9NrfC?=
 =?us-ascii?Q?d7avbgPMIpv+uqYzmv8kkVMOfoClGx8kc5bcmFWAu7Vg8pIHIfNDXwgtmW3K?=
 =?us-ascii?Q?PfDeGSf+1TqpbUf/d0iskOaKKpGVXKPwkMgc1a4lzv6oIIuFjUohq8ASf3v+?=
 =?us-ascii?Q?lKPkGnnB95EwChaAlr6U21rIvjj+EGsr/Wu8VCt1Hx8inp2MQqFEtDbNy8ju?=
 =?us-ascii?Q?DYkRcW6O/ZBDEsgCRTCPaa2pb0Vd2qHjD3OdJbe3yFPbrkMvblpFX12z9m3P?=
 =?us-ascii?Q?BMWnKmwdRaUTCTFixpqiU2+2BFFbRgM/1drxH3W6UpgcwEeAj/lu4QUhXt6p?=
 =?us-ascii?Q?3QZpFX4fKHE8zGUqVB7hGqtRbUQ7uPz/WRIZXpNeTMtFSZoXB3XAJc2QjHuU?=
 =?us-ascii?Q?yVTRonL8NFpl+D9Xly9/cqvLqiXytIAyTEVqTOCqLajh8Bz/HXYIjOAZLayt?=
 =?us-ascii?Q?U5xZVbz+o11wRpzdyb7Vk08uQPYVyQxnKoB9nbCYU0W62B7Nbp0IOIFviwhA?=
 =?us-ascii?Q?cL1PEZAkw694iOKR/KkTefpJZNjM6AIiFC74pdf7bfmPmB1DSDD6wuwfIyOv?=
 =?us-ascii?Q?VwL8ccBecoRVJkDTA7WprBgNe0VVeGqNQPkIBa/l998sToq6EACT+v7JA4n0?=
 =?us-ascii?Q?oxZEiIb7daIvOfnY2tUzWWuWNQz44yP3wJwphXun46PT1WhyrcSwsBnPc22Q?=
 =?us-ascii?Q?BKO6hbgFdNucZsgkBzjjUQeXui8ylgPwBSEN0/tF0KYXaLg1SAOY9tlJclhw?=
 =?us-ascii?Q?4nckgnaXniaaW82duThOiMISw37QbdtAVLr7zegwQNxIO5EyJy1Ny0Su4nBI?=
 =?us-ascii?Q?w7+DFS/hKc1VBmngMIS5gb/hCRIdzLJAtOctw28T45SYT5KWF8pR3qv9gaub?=
 =?us-ascii?Q?cQNszxyf7oRBzlrspS6ZPfGbig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47187f6a-6794-4307-3d78-08d8b99c5bc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 21:27:28.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltvmSW7aNKorT4jnfCRgGY8+CfIssozWUxXcle5aFJ3pEWjT2JTnWuSiNerB2A1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_14:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 03:55:36PM -0500, Johannes Weiner wrote:
> On Fri, Jan 15, 2021 at 09:03:41AM -0800, Roman Gushchin wrote:
> > On Fri, Jan 15, 2021 at 11:20:50AM -0500, Johannes Weiner wrote:
> > > On Wed, Jan 13, 2021 at 03:46:54PM +0100, Michal Hocko wrote:
> > > > On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
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
> > > > 
> > > > I can see that you have provided some more details in follow up replies
> > > > but I do not see any explicit argument why an excessive time for writer
> > > > is an actual problem. Could you be more specific?
> > > 
> > > Our writer isn't necessarily time sensitive, but there is a difference
> > > between a) the write taking a few seconds to reclaim down the
> > > requested delta and b) the writer essentially turning into kswapd for
> > > the workload and busy-spinning inside the kernel indefinitely.
> > > 
> > > We've seen the writer stuck in this function for minutes, long after
> > > the requested delta has been reclaimed, consuming alarming amounts of
> > > CPU cycles - CPU time that should really be accounted to the workload,
> > > not the system software performing the write.
> > > 
> > > Obviously, we could work around it using timeouts and signals. In
> > > fact, we may have to until the new kernel is deployed everywhere. But
> > > this is the definition of an interface change breaking userspace, so
> > > I'm a bit surprised by your laid-back response.
> > > 
> > > > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > > > Cc: <stable@vger.kernel.org> # 5.8+
> > > > 
> > > > Why is this worth backporting to stable? The behavior is different but I
> > > > do not think any of them is harmful.
> > > 
> > > The referenced patch changed user-visible behavior in a way that is
> > > causing real production problems for us. From stable-kernel-rules:
> > > 
> > >  - It must fix a real bug that bothers people (not a, "This could be a
> > >    problem..." type thing).
> > > 
> > > > > Reported-by: Tejun Heo <tj@kernel.org>
> > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > 
> > > > I am not against the patch. The existing interface doesn't provide any
> > > > meaningful feedback to the userspace anyway. User would have to re check
> > > > to see the result of the operation. So how hard we try is really an
> > > > implementation detail.
> > > 
> > > Yeah, I wish it was a bit more consistent from an interface POV.
> > > 
> > > Btw, if you have noticed, Roman's patch to enforce memcg->high *after*
> > > trying to reclaim went into the tree at the same exact time as Chris's
> > > series "mm, memcg: reclaim harder before high throttling" (commit
> > > b3ff92916af3b458712110bb83976a23471c12fa). It's likely they overlap.
> > > 
> > > Chris's patch changes memory.high reclaim on the allocation side from
> > > 
> > > 	reclaim once, sleep if there is still overage
> > > 
> > > to
> > > 
> > > 	reclaim the overage as long as you make forward progress;
> > > 	sleep after 16 no-progress loops if there is still overage
> > > 
> > > Roman's patch describes a problem where allocating threads go to sleep
> > > when memory.high is lowered by a wider step. This is exceedingly
> > > unlikely after Chris's change.
> > > 
> > > Because after Chris's change, memory.high is reclaimed on the
> > > allocation side as aggressively as memory.max. The only difference is
> > > that upon failure, one sleeps and the other OOMs.
> > > 
> > > If Roman's issue were present after Chris's change, then we'd also see
> > > premature OOM kills when memory.max is lowered by a large step. And I
> > > have never seen that happening.
> > > 
> > > So I suggest instead of my fix here, we revert Roman's patch instead,
> > > as it should no longer be needed. Thoughts?
> > 
> > Chris's patch was merged way earlier than mine into the kernel tree which
> > was used when I observed the problem in the production. So likely it was there.
> 
> Chris's patch was in the tree earlier, but the first release
> containing it was tagged a day before you put in your change, so I
> doubt it was on the production system where you observed the issue.
> 
> As per above, it'd be very surprising to see premature sleeps when
> lowering memory.high, when allocation-side reclaim keeps going until
> the cgroup meets the definition of OOM.
> 
> > I think it makes sense to try to reclaim memory first before putting
> > all processes in the cgroup into reclaim mode. Even without artificial delays
> > it creates some latency and btw doesn't make the reclaim process more efficient.
> 
> It's not obvious that this is a practical problem. It certainly isn't
> for memory.max,

Because memory.max is usually not adjusted dynamically?

> and there should be a good reason why the two should
> be different aside from the documented OOM vs sleep behavior.

Maybe we have different examples in our heads, but mine is a cgroup
with a significant amount of relatively cold pagecache and a multi-threaded
workload. Now somebody wants to tighten memory.high. Why would we put all
threads into a direct reclaim? I don't see a good reason.

Memory.max is different because nobody (hopefully) is adjusting it dynamically
to be just a little bit bigger than the workingset. Most likely it's set
once that after the creation of a cgroup. So such a problem just doesn't exist.
