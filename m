Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5130FCF7
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhBDTfu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 14:35:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60952 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236942AbhBDTfn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 14:35:43 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114JSjmb003247;
        Thu, 4 Feb 2021 11:34:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vAffmpZQSZNrq9QlG5aecpm2gnNvWjPrGoPsXJRkgRY=;
 b=MFZV4JLz00hWFA3G/+ecMdD737xMxwnjlEEXpCBEkd3dOUfDdXAoNhOSNix7kxu62DfI
 1+E0iMQWNY9T8BdU7XNJWjhDSuohnWlNVeFBuBKcn6yXRnSfpB1o/7ZXWD9FmB7F9sGP
 HmX2+XV2Lt5ipiZeVC4B3ClbB4SlyTQi07E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcs64tng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 11:34:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 11:34:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMwQNHz46nZc1P0kqo+kCzi6eDHzjs/6o5WyfrEY5WS7BFJl6n+ouk7sEKxNabMvAq0Rzndn7AldUPE528vk538Y+XMILnqeE4phUiK9i3SMeDpp1oZwqC+ybncMxX0oIducXmJcb3/6Lwokl4SYbA8wdNDc0id3n8mduizkZ1G2vBmdN6TBgzCXbAbJ2k9WzNWx55yGucucJkvCBSwDP984p6KrdTugN4nO7ZBEOsPaDjgyI2kUO5NGQMHu0Kl3g3v/oWfX6DX2Qalc9RZ9tGypPQiDsxqcVqfvfHRGWoIwl+znre17w2gYBU9O6Hl3WvdttJfBpYyVMOuSCwhGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAffmpZQSZNrq9QlG5aecpm2gnNvWjPrGoPsXJRkgRY=;
 b=NyIsFYGNhPt6p8DreEtbb4F3iMoj/6+d59Msr0jL2T4AfYgEsA3lGWF7a6iAEbMtvjD2JpMlOr70q/q7mqk0DKrEB8G7VRm4BFlj///C6j7DRPsa3mrM1lksaAJE/6vhMlvdjLn1X/5Vgg8dqKJvdIQsln8AUG+iLpzjDHtlT5mpu1I3equUN5Z8WBV0AtLqbaXqFny9okI5ONXxddFid/xOaZOJJIHMNCvAEgYfFG+Fyac3v3zhkLuPSALW7MB+Y2Bhmq57Wo/G/HR/HcXdspnEbRrps6zuhJdJovQGbKnSGhpe6/PniWlBIgVRtOpZRgUpTiXKtCts3BeypK951g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAffmpZQSZNrq9QlG5aecpm2gnNvWjPrGoPsXJRkgRY=;
 b=PE8df40JP374yTZYXAk7s3nOKmD2toOX2gTditTCdevBTV74iEby9lwVSgiVwoAwExpZY0k62S5UiVEjt6dTHkJC//R4IGvoLHSLyVumXq+yde6e+4FaTvNTJ6R6I2E0hqzAr18uOG5SruhMMS/9jCqIfkthumjoJLOjBLHwsJs=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4134.namprd15.prod.outlook.com (2603:10b6:a03:9a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Thu, 4 Feb
 2021 19:34:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 19:34:49 +0000
Date:   Thu, 4 Feb 2021 11:34:46 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Message-ID: <20210204193446.GA2053875@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-2-hannes@cmpxchg.org>
 <20210202230747.GA1812008@carbon.dhcp.thefacebook.com>
 <20210203022853.GG1812008@carbon.dhcp.thefacebook.com>
 <YBxLNZJ/83P7H8+H@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBxLNZJ/83P7H8+H@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:910]
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:910) by SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.15 via Frontend Transport; Thu, 4 Feb 2021 19:34:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17d10d2-164d-4273-40a3-08d8c943ef9b
X-MS-TrafficTypeDiagnostic: BYAPR15MB4134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB4134E749969130D006435C5EBEB39@BYAPR15MB4134.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JwlLMO1TkWo+k9rdSGRlX+HkrAKh+2e5EeFisTglxt19ZvDK3J1sur/pChRjgPeYLoaEwWgCUbzTt6MLtIyYYTlIdWECRKFwLZyWGzaRKCUO9HJ3p+62i6sYdeVma+1MsljlAaep20RtSXm26Heu7GkaYoUNhNmFggomzAQqweCHHE0A2BcvqJ9rs9fUlF7sFIY6MFOqbV78sHEnL7w1zurW/eHefWQcxGWL67KBW6SnEmsVf0z+gEp6r85t+8URtIdTfCCs6kZVaMt9JId4/6eWwbhIM0loh0hzECafvm7IQ/bNfW7lBsmwIQVybPkuBGbiwvbD8d9F0A67sp/ZH9sxVkBshvxYS+1r730eP69zd4fL+WUY7yC53uacp8OW0/9U/tJ+oJkEy77UqOAhl0MabXlRvypx7p4DwdW+XjlYh3j+bIqhC6KKJS1zeTBoR5n48HGFuPPPSrhSVccn3zS9slnj0R/kImsLYhaqX9X95SiJhNsfD1Zwex9gevYW+0UNJJImZj+sDAwwuup1sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(136003)(396003)(4326008)(1076003)(54906003)(5660300002)(52116002)(8676002)(7696005)(316002)(55016002)(6506007)(33656002)(66556008)(66476007)(9686003)(86362001)(16526019)(478600001)(2906002)(186003)(6916009)(8936002)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uqdYx0zyVNbUNYuZniwoh7BC3SxnndLzJeABzgUKiqYi49ayg/VkYO4Nq7ql?=
 =?us-ascii?Q?SCEda4AN3YZHqJDlxJD5D2V8Il6jNTrVk8ZHzxK5maXUNPUBMCcYxXwOzRaP?=
 =?us-ascii?Q?nMM+1SYeX0HtgrMiQA867DF0Cj1LVFAVOb4S+xEw4By2FFcRklqL6ukCLXJD?=
 =?us-ascii?Q?G7CM32oVA7XMVNHQovcUUEXizX72oVPhFo8b+9IKovIr1j5w0A+NL9jtjwLl?=
 =?us-ascii?Q?rZlLaMN3CYSviUmEbrUfiR0DLYVV1JBWmQ2Znno3PB5sEqyD/8X7onCX6bF+?=
 =?us-ascii?Q?oauJ3XTYnSIEbcZJz1fU4zmdN+9aYs9gOVA2vStxAEwOL1KmJeCnyBv06V3o?=
 =?us-ascii?Q?CQSo5yb+8D7iYxPvT7sa7haFja6mxybozpTPUVmKQC/4vc87P3AvumBEIyOa?=
 =?us-ascii?Q?I6NPLtwCZw9UKMV37SdPG9oAVa0MAlMbdcdG/ItPljYrNMdcxgHaTIaoMqbN?=
 =?us-ascii?Q?yq3bbjDLswzl4Mg0KasRw4ByEH/uaw4hpzvEWXA42JVGNC2zhBC3Gq9VfbTW?=
 =?us-ascii?Q?Azudc3Qx/Hz4kJBmJn3cVYWHVzSYdtWntEJCMoBdZ9lEnaQyFAgYeUJzWf5u?=
 =?us-ascii?Q?vhnl3tOvKK6rKJujXKBe//orrnP1dLVIACqnP8AAAkQ8QjQqysOujd3puUPU?=
 =?us-ascii?Q?eW9cM7/DTu1G4Wvj4v/enlUuHTqs0tK2EC8kjSjT+N7+UNwth57h88yacSmw?=
 =?us-ascii?Q?pURfxQHqMsYV5DKXWi46sleE4f0KNrz1iw+7gCmLvFY1hwjV9WdiK9R43W22?=
 =?us-ascii?Q?VbO80/zoOykCBX/JMuYnLHX3f+x1S8lblwqxVXvwfHjNeOyJZ6R5ZE7rLEa9?=
 =?us-ascii?Q?jkwp9CLuHVASGbdghpapNsZ7tp58Ewj2/4KqF/NjdK9oAdECGAThVtubpuJe?=
 =?us-ascii?Q?2aZ7Ab9UxDTwr7PmzFzPPcEKVUb533mAXuDDYu4L9Aq9zVlHAaUo36LMLeIq?=
 =?us-ascii?Q?rQbaJSFaA6/klA4a5zFIBQzfNZ7At1GZ3YLm0ePQHrePNrseN7JHAFoiThgx?=
 =?us-ascii?Q?dnnr4bn4Sk86H4zUtJimC3tgNOB/+47K4CKQ3OWdrcuU8+NZnxuFBNQcTFVE?=
 =?us-ascii?Q?iJ26Ji6fxwkNlxurOsxhp9s7zdTAPDNcvQQfNt5ABXpxfz+vizo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d10d2-164d-4273-40a3-08d8c943ef9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 19:34:49.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uV2C4Y7Yhx2djH31EkSP4rA5fz7h7p3Plh3qa39EejPRSQKHBvn2x3df++Musl2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_10:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 04, 2021 at 02:29:57PM -0500, Johannes Weiner wrote:
> On Tue, Feb 02, 2021 at 06:28:53PM -0800, Roman Gushchin wrote:
> > On Tue, Feb 02, 2021 at 03:07:47PM -0800, Roman Gushchin wrote:
> > > On Tue, Feb 02, 2021 at 01:47:40PM -0500, Johannes Weiner wrote:
> > > > The memcg hotunplug callback erroneously flushes counts on the local
> > > > CPU, not the counts of the CPU going away; those counts will be lost.
> > > > 
> > > > Flush the CPU that is actually going away.
> > > > 
> > > > Also simplify the code a bit by using mod_memcg_state() and
> > > > count_memcg_events() instead of open-coding the upward flush - this is
> > > > comparable to how vmstat.c handles hotunplug flushing.
> > > 
> > > To the whole series: it's really nice to have an accurate stats at
> > > non-leaf levels. Just as an illustration: if there are 32 CPUs and
> > > 1000 sub-cgroups (which is an absolutely realistic number, because
> > > often there are many dying generations of each cgroup), the error
> > > margin is 3.9GB. It makes all numbers pretty much random and all
> > > possible tests extremely flaky.
> > 
> > Btw, I was just looking into kmem kselftests failures/flakiness,
> > which is caused by exactly this problem: without waiting for the
> > finish of dying cgroups reclaim, we can't make any reliable assumptions
> > about what to expect from memcg stats.
> 
> Good point about the selftests. I gave them a shot, and indeed this
> series makes test_kmem work again:
> 
> vanilla:
> ok 1 test_kmem_basic
> memory.current = 8810496
> slab + anon + file + kernel_stack = 17074568
> slab = 6101384
> anon = 946176
> file = 0
> kernel_stack = 10027008
> not ok 2 test_kmem_memcg_deletion
> ok 3 test_kmem_proc_kpagecgroup
> ok 4 test_kmem_kernel_stacks
> ok 5 test_kmem_dead_cgroups
> ok 6 test_percpu_basic
> 
> patched:
> ok 1 test_kmem_basic
> ok 2 test_kmem_memcg_deletion
> ok 3 test_kmem_proc_kpagecgroup
> ok 4 test_kmem_kernel_stacks
> ok 5 test_kmem_dead_cgroups
> ok 6 test_percpu_basic

Nice! Thanks for checking.

> 
> It even passes with a reduced margin in the patched kernel, since the
> percpu drift - which this test already tried to account for - is now
> only on the page_counter side (whereas memory.stat is always precise).
> 
> I'm going to include that data in the v2 changelog, as well as a patch
> to update test_kmem.c to the more stringent error tolerances.

Hm, I'm not sure it's a good idea to  unconditionally lower the error tolerance:
it's convenient to be able to run the same test on older kernels.
