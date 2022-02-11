Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4C4B1CAF
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 03:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347385AbiBKCoY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 21:44:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbiBKCoX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 21:44:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643F558A;
        Thu, 10 Feb 2022 18:44:22 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21ANrWgY028405;
        Thu, 10 Feb 2022 18:44:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ASp7tkiRac7NiliMWRsvvzTDctAxguEQSGC/PRhMxbs=;
 b=oSezFnCIM5/9LfGf/ZkXABeBT+dP+1ppuQF/pCxTGrZ9CPFQ8aN4DFPqWa1/QriXjbMm
 6Nu2d7ZWLvOOY2L/fw+Fh4/rntRdXdLmqN07nbdB2vZLrHBiyZe2zMJoLnn01IwGxC0+
 t5VAwyewq0iVb5u2Q4AvVxlFBg69j6CDZq4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3e5882ty9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 18:44:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 18:44:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPmvDRT8ndsRo2i1643HLEO1UMpUM2kRxcJAOspmSqnMucL1r2PeneoUIq1J3A+Q0wd8WooqIT5oV8KOEX3I48gI4BxIe9PX276juICkkSOVYws9GHM0hBb/6WaPJAgxE14jpN8XSVfIwszzyzy5tJmnWmxcNueaqBcnAwgtq/OXLrvATmLR8lsO5+acd8CApcZyxS6xG56C8APinw/yjmGa3Kv2blyWtLlHuJKJgS6dE/DCIsG7wE4ON+FwUzibfIsX4Yuygf1LKQ1hnO1fJERMovrBC4j6DZQGYChMZawbaV6+VHj/fzJwbJEfBP/NMde6Fx1K9+iWAuA/XxS8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASp7tkiRac7NiliMWRsvvzTDctAxguEQSGC/PRhMxbs=;
 b=obwYXL/pakMTcJJl5xMe+1bLOaiSABCwmep0KGoFGLHp5r1JyQdBWiSMP6W0V0Ta4nj1hlC4Hv+HxPXi5CKDss3pJYfIcwA3EZRPScJSsW8R0+u/usMMu8lYO1l5qyl0Nu0mFOs5bFQwMybyGuuzYe9+qu1gzYZK8AeKK65G36HhFErwFTrgHntkI7Qz/B7c1gnsNpvb/cmrLfWIGQDCDC6eO4yr2S/k4A3NlKVylYfxjwAs6jl0g2UBxfIIpN+Oje8OHa3b7d7bH2vMrzX9ceiKRwwPKaFIU80z+6WTw8eNTtsskSMJyd+D0Xb1g1/d9H1p64vqy4a0xFDy9TQdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BN7PR15MB2372.namprd15.prod.outlook.com (2603:10b6:406:81::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 02:44:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 02:44:12 +0000
Date:   Thu, 10 Feb 2022 18:44:07 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] memcg: synchronously enforce memory.high
Message-ID: <YgXNd11XK94PM89+@carbon.dhcp.thefacebook.com>
References: <20220210081437.1884008-1-shakeelb@google.com>
 <20220210081437.1884008-5-shakeelb@google.com>
 <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
 <CALvZod5xFmCVV_AZO1be8pYakmDvYh-QXmNYtTNT4zvCw-m4bQ@mail.gmail.com>
 <YgWf0wL5RoSpNrWn@carbon.dhcp.thefacebook.com>
 <CALvZod5XstvNB_=qprW6_bx33h8JeyE5TjvX3UDoqG8XHBr14w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod5XstvNB_=qprW6_bx33h8JeyE5TjvX3UDoqG8XHBr14w@mail.gmail.com>
X-ClientProxiedBy: MWHPR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:300:115::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7da21205-775c-422b-3839-08d9ed086282
X-MS-TrafficTypeDiagnostic: BN7PR15MB2372:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB23726357BF15ED99FFA33AEBBE309@BN7PR15MB2372.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4ZIHmfCeZfd0N8r4S/JzKz9uoTyS6TkpJK5mUu4Jmk8kPCFFcf4AKGj+AyMuKhFA3F4qjJTy6ZWxCBOU361wkwaW9Dr/X+KmclFfCxV/zIBxW6dp1BUdegB0YFlz/EL6tmfnhPNsuak80bcXil/AUYI48Nz5PbrSefi2BG59gf2deq5Bauh/jhj+jeKmF3e0I6Je0Zl/3ZJBMqkvZhK7A++uaJxe+AjN0tIpQ5mPhgyyflNMs2suSEngE4A5DEcLpSqPKR/SjoqCoeQrJeJ7yI+sWSb+VXnBkgfeMlUTiyyBCTSHsBOINNbX8gdsuLCVzIu2ulujn0lgRWvROsEi4u/5D8Mg6HMXeq5892ZxjzJRYCZXA1AoSSGTpuRgDJ9hLpNyey8m7xX+t17vZes8NrR5dySpMejStjwm5bVCg81Owpn+CyHAtKubbtXpk25wM5L+oGr4AqV4M/wilSd9H3U1W9sh56xkPY8DQBbhNre4haj9muj/7zaavBFamfm6fRJ2Wrx2Ul67kSbO0PDKwyrZIl+Y1BfT15rbOR2i+X6NE2MVyNFemfck2yywqXLBJ0ADwYCGn1DuxEYmh7U+54mmY9HsxDi0UqdPSltFZEh/DXU8ovYC84MHqboHO4aMV4aZV/0VGN7v1zs7q3Q9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8936002)(8676002)(66946007)(66556008)(4326008)(6506007)(508600001)(53546011)(6486002)(5660300002)(86362001)(52116002)(83380400001)(6666004)(2906002)(54906003)(9686003)(6916009)(186003)(316002)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Yqz/CIHjPCeiqrXBU5pApn+pqiKvAJQuTJnRjyNFRS+v4Y49oUs5oQLnS3w?=
 =?us-ascii?Q?iPvK9faNo4lfENb/qi3DuhN6aF7wOQxG7zAxbViWlXl9ReWrfAt3lhAFYkkh?=
 =?us-ascii?Q?gn9WaY7jK6tcpROZYWLchkPer6JWtWejbRseEbW20etlWjzHYlKA27PY2jvX?=
 =?us-ascii?Q?koZqTox8qMqd0gLY6uvnnXdMA6zdxxpTEJs0jfUVIhM7gf8jM33uPuuuTimN?=
 =?us-ascii?Q?g9wJOU63lIle3ENBWRvgYcJMfw0EUdAsY2tuZHonxRyzLngdrE80Uz++a7pa?=
 =?us-ascii?Q?A486kvSHE/r8JQi9HQJaL/taFGMCWYDHaPyEAZA/i1n4vgjQTrxBbm0rJOP5?=
 =?us-ascii?Q?MptbIgc+M8Axr+UEHnIvj6d+agdpIgw7t+82RyT7m7NoGNAoHO15KS30Ca12?=
 =?us-ascii?Q?3XtxcGd6vtdKMYkXps02Yi8SxUoXt6C9kR0SaL1h3MZQ/WpOEWAWe6+S4Dkz?=
 =?us-ascii?Q?49LZ6ynUFkH6UgCnBcDAOKxllJDAE+FntLuD7PHbBboahtBZ9rG3RUN8tKE9?=
 =?us-ascii?Q?EAkbIuYgOqtTQjAUOqHV6sO/XNW/AyrAFmDjhCdYygJ9ufihOp5G0m7COJhL?=
 =?us-ascii?Q?x/WXMcOsfWVfkYXwbk+78zEZUMe32oKiCq1fbGZRToEXXErCDY6hUy3uGUgB?=
 =?us-ascii?Q?mH/vwcJfKzYR29RQAe/+zIblbSpVkKBgzpw+PjU3bRtXjUqt/UhBYZ8P7vgz?=
 =?us-ascii?Q?GRZO3hYvcHE94Ukqkau77zHwTRkczZJ60IkAZ/FPEu8HNmwOaPPHJM5PBeGW?=
 =?us-ascii?Q?ldvYbzDnYVInC25Ail03QY7DbvPegd5A0gIouf+/F6Ki9/QJHyJetv8dRX5l?=
 =?us-ascii?Q?AMwS/Im3l1UoROEXU3jvlAsJVKPxwhozKDfEy1IKrENHycr6gSxopOYvgQG+?=
 =?us-ascii?Q?NYOYxP1CubDCFzIC7kn1Vw8OmHuDOuDY7XtH26IWSajltDo1dR42FV/4J8yC?=
 =?us-ascii?Q?KZ1gcyCIUmE+h1PExDbyT3LhPN6EYqv3jT7oTlKveBuLTOZwUY5fAdKFmUgO?=
 =?us-ascii?Q?B+xyjgpLhgUaNTtuvmmUNLGhf14+4SeqU2C9ZAd7+Vqg8W1vFB1KqJ6NU5om?=
 =?us-ascii?Q?40uljyiZ/UsG3T78r1Fw32F3WPF08jaFGMqIEZTHDJdFsvrTXXf9zCthR6xE?=
 =?us-ascii?Q?U0QnglVDWzubaV9weZxc0zPJtHz4kh+BdsAVSZZUWWF9RXj3QV6noWsb4Oaq?=
 =?us-ascii?Q?bIetp+/vgcjkVP/plLGYRNhP5qRR6iIZel4Zrbr3WNLKwoESXrhOVVJq7ELG?=
 =?us-ascii?Q?fmOkp7mgth5F1IXZROyCmQ+z1/OL6BbGtR69B7pqkExQjF4E3vPST+Ys4Hkz?=
 =?us-ascii?Q?7yNq/pSyjReIFZ2OXlVvjp8Sx2ra10VdwR+HBNCcrAlcNojX395E15av9QZ1?=
 =?us-ascii?Q?dlVMpCjQXebNYKe5J4HC/o/0cP5xHmvkUEEZlSt/Ua4KPyZWPuw96HSigWFs?=
 =?us-ascii?Q?PCwolUcDGZhoU5SQF2gDYOz9cGNIFCaQ0x8EhZk05AAMkDUFVzZ3VjZlGAaA?=
 =?us-ascii?Q?U2TTa/5MbwdXk0P5NYVfXAEPtop08H2nt7XzzCBqG2HzWZvwP6uXScmHe/Uy?=
 =?us-ascii?Q?k7b7OJrX4J9dIPh64/+z5Yy/+r7aveCHaH5r8dlt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da21205-775c-422b-3839-08d9ed086282
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 02:44:11.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UcBs+zc7BHB2vON6uxZlks4xtCjn24QKKL8Ty7Vk3Vxm4FK/3FSuEJvhCkkBglq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2372
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4OzCqrIRTYwkSBorQU7UMVv7nyqxGUF1
X-Proofpoint-GUID: 4OzCqrIRTYwkSBorQU7UMVv7nyqxGUF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 mlxlogscore=951 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110010
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 03:53:00PM -0800, Shakeel Butt wrote:
> On Thu, Feb 10, 2022 at 3:29 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Thu, Feb 10, 2022 at 02:22:36PM -0800, Shakeel Butt wrote:
> > > On Thu, Feb 10, 2022 at 12:15 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > [...]
> > > >
> > > > Has this approach been extensively tested in the production?
> > > >
> > > > Injecting sleeps at return-to-userspace moment is safe in terms of priority
> > > > inversions: a slowed down task will unlikely affect the rest of the system.
> > > >
> > > > It way less predictable for a random allocation in the kernel mode, what if
> > > > the task is already holding a system-wide resource?
> > > >
> > > > Someone might argue that it's not better than a system-wide memory shortage
> > > > and the same allocation might go into a direct reclaim anyway, but with
> > > > the way how memory.high is used it will happen way more often.
> > > >
> > >
> > > Thanks for the review.
> > >
> > > This patchset is tested in the test environment for now and I do plan
> > > to test this in production but that is a slow process and will take
> > > some time.
> > >
> > > Let me answer the main concern you have raised i.e. the safety of
> > > throttling a task synchronously in the charge code path. Please note
> > > that synchronous memory reclaim and oom-killing can already cause the
> > > priority inversion issues you have mentioned. The way we usually
> > > tackle such issues are through userspace controllers. For example oomd
> > > is the userspace solution for catering such issues related to
> > > oom-killing. Here we have a similar userspace daemon monitoring the
> > > workload and deciding if it should let the workload grow or kill it.
> > >
> > > Now should we keep the current high limit enforcement implementation
> > > and let it be ineffective for some real workloads or should we make
> > > the enforcement more robust and let the userspace tackle some corner
> > > case priority inversion issues. I think we should follow the second
> > > option as we already have precedence of doing the same for reclaim and
> > > oom-killing.
> >
> > Well, in a theory it sounds good and I have no intention to oppose the
> > idea. However in practice we might easily get quite serious problems.
> > So I think we should be extra careful here. In the end we don't want to
> > pull and then revert this patch.
> >
> > The difference between the system-wide direct reclaim and this case is that
> > usually kswapd is doing a good job of refilling the empty buffer, so we don't
> > usually work in the circumstances of the global memory shortage. And when we do,
> > often it's not working out quite well, this is why oomd and other similar
> > solutions are required.
> >.
> > Another option is to use your approach only for special cases (e.g. huge
> > allocations) and keep the existing approach for most other allocations.
> >
> 
> These are not necessarily huge allocations and can be a large number
> of small allocations. However I think we can make this idea work by
> checking current->memcg_nr_pages_over_high. If
> order(current->memcg_nr_pages_over_high) is, let's say, larger than
> PAGE_ALLOC_COSTLY_ORDER, then throttle synchronously. WDYT?

Yes, I really like this idea: the majority of allocations will be handled in
a proven way, however we'll have coverage for large outliers as well.

Not sure about PAGE_ALLOC_COSTLY_ORDER though, I'd probably chose a larger
constant, but we can discuss it separately.

Thanks!
