Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0764A771A
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiBBRwN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 12:52:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232989AbiBBRwM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 12:52:12 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2124Rv71025943;
        Wed, 2 Feb 2022 09:51:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CSAOF8y2oShb7pKB9BXGHxcRfFq91WItrqZCP+LHSBI=;
 b=iWUu7PeM2a6PLAiqcZNuQPaccog6cjjAZRxUrlaVE1y4hXkEajM5WTA/KCs6yBVn3Vgo
 P5b+a8YAKOdDjVLbN8BWP2vOtBKUWkqISVETWczKyWkxFvH2IFI8jJ7X9NHP+/iRuAzF
 1MVpDXAq3x13S+miNcSFHpbM5Y8T7yOMtQs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyjxu3xpv-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 02 Feb 2022 09:51:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 09:51:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoDwlIGHVaJYqqcKEbw64BCY9pH7xClsQp9Jx3xkYkMWJR2bhcHoLmiyjAgRw+h+40CgEiCCCpGOTDt3sFG6r5jvaVKICRRoXUqZzX7B/qHCUuflFk2j+DTwY+V/F1syx2EVOsa9OS1wUBIHm6UcDQtHdZIUVC6U8Rf/cn21Hh5WvT7JBEswHwu2WbxLEN5CKkWGqp4ztXdRb72HtzjUXmggmzQ+pWmJqm0S/Y208DmuUMUvUkb+8i+5EHbCKNoRmCkttzC0pKk+ltMOvjKVu2t1/MfxbwITg8OQ+8P4Ew0g3kYSfhW4+xImzAV6gd92xleGLsRbB+0Yg91jUoNFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSAOF8y2oShb7pKB9BXGHxcRfFq91WItrqZCP+LHSBI=;
 b=J9mUj26yg9QezeJCcJmTcrwodGsWTPxFfOsJ6GiSNIK/OCEeXRnq2LdaZzMfC2FpxxmpXJrNMCDR1wt1Y5WQdnTAGBpx1qWQfAyjmlwe4FEF7bNc0/dVf0dh1omnr3txd+Wp2AyoWV2ZG4QKUlAlASRIpYSagba8wDYxsTnkWESLxvLMYXkXphQzNUC9Dd2LQKcn+OwEmL4Wb5q9uWTQGB2v6XDPHeTHeYVGHHOQflIdfrcwRdD+Ou3R7W05DDSgLWBnHwx0NciJhCfzZv+wWXtYN1xEZxfapeXZLVwlKLnIbx2fcuv+wLdbCh0pV/oZCVWESu/+p4AdhyR28feUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4600.namprd15.prod.outlook.com (2603:10b6:a03:37d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:51:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 17:51:36 +0000
Date:   Wed, 2 Feb 2022 09:51:32 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfrEpOGObnc0mYAW@carbon.dhcp.thefacebook.com>
References: <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
 <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
 <12686956-612d-d89b-5641-470d5e913090@redhat.com>
 <YfkQJ4QhfY0dICB9@dhcp22.suse.cz>
 <268a8bdf-4c70-b967-f34c-2293b54186f0@redhat.com>
 <YfpHbtffFi2x1L4p@dhcp22.suse.cz>
 <YfqpSPLC+LAdqbJX@carbon.dhcp.thefacebook.com>
 <YfqzbwAPKpshXSLK@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YfqzbwAPKpshXSLK@dhcp22.suse.cz>
X-ClientProxiedBy: MW4PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:303:6b::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca44078f-a967-4a1d-4575-08d9e674a83b
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4600:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4600BC0D2646E4290BA8F30DBE279@SJ0PR15MB4600.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RC9XIw9H9GVANHyrkDBuoPi+GbdDwTvJf4jb9/1actjij9Uos6bu2ccdIIH1fDHAMdiaB16Ilkk/agXjYWQA0u0eQCrIeuaXRewtVPsCOgyXIxoqvdjSs5vnYf2Aw86wCumMGZ7gP+PNjbwvmjnzSkENGDxY+wkyzwz9nuFPllITX3Cpicm7FUbkACGw5oAfv/Ace/vYiHbsEoT8Bu9ZSxN2dDcqQT1E8pJSK+LyhbJJCtn1+MMbM15SGPsjrky11KjK8YLNMM9M6kheEnBXvfQ1B4a7urwa63HNoRPGkgY+P/Y4nJjVqop7jaWC8xEZODCHYzCQ66TmgZ6vDMyIemAY5GwQB3Ej1tZOjozx+KIUJtFqepPI0kv+hcpWpLHZvZNfZ7DUgyVtHoU2ewLwSKalMIbv1yMKccyufA7QsuQYNGyMYPRUfo69i+7ZlNDVkcafVWXJ7e7UYmP/lvA1RuUxI+Lc3/bKfnfEqGeirZtsyp2f9/Z9l0E9HL4eTiGE+aDs+TUxoiTIpxPSmoz1DUWo1WD3Ds2nX7MqmTCyzDVh08u7+sG6oY1nYHdd2T5zj0cwkvO22zVlAfUXKHEwdKlnpxXsJe/E4BWRhksPGmorrC8mg0lQc48I5AhAgiSZccf8QpgkVUlzWxm8mHxK1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(54906003)(6916009)(2906002)(9686003)(6512007)(66946007)(8936002)(66556008)(4326008)(86362001)(38100700002)(8676002)(66476007)(508600001)(6486002)(316002)(186003)(7416002)(5660300002)(6506007)(6666004)(53546011)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7qsojFVNHVwCD+69LDeNdR1D2VBVNXHaJV6uBZZPPX59a34XSGO44RERTGX?=
 =?us-ascii?Q?41Qd0SLhX868H5sEwLT6uEn+FmePw6tBVFdbNGP6hyEUfqeu5ZEIC5lnbN1F?=
 =?us-ascii?Q?ZkWsmpmjWFxsUsfcQYUWiXmmpRWU1f4BX5gIYq57BhxlWPpo6PFR0aGFcW1B?=
 =?us-ascii?Q?1RbjF/+IV6P1DGsKFQHIWSV5NsGXsldiGDM+oQG0X9v4WVdNmeafooQbSADT?=
 =?us-ascii?Q?R4Y7nDRDUY1+4Rzeskupebhmq0YAx2/KTBq4XOwA+vsHB0LR4rEE5jTPSgyi?=
 =?us-ascii?Q?Wp+x1uIDdfK7bZgwQgBm8WLDOq1lQy5lWPGyr+WZwy/MCMFV66PKeLqz5yce?=
 =?us-ascii?Q?DgpLstn0Nqg9aJhnYdLLUwDeR1Xz+WFgeonV/DfV/qhkrfTHj9md0L67jsJe?=
 =?us-ascii?Q?Hqw0InS4MNi+QN5N7FTiHUy4rMoCyu9FoshLx8ZQu5/GE4v/DGjR+DsljQ/A?=
 =?us-ascii?Q?6+pI8yPHj+NNu3Uw/hb8ExU/NlNH6AXKNQiTXBr6O8BmAYMOc+RhreEFBjX7?=
 =?us-ascii?Q?mKHp5tgliapOqegmrlr3ZlyKzgRpvl4COGysXlU4ru2UKSDrhWAB59f6Ka+x?=
 =?us-ascii?Q?5G1hSM5fhUsk03WJ+xU5PE3osQEpjWFT5COpyJJ1Y72xBSZ27fFtvlF0+YwY?=
 =?us-ascii?Q?v1PjUm5GmJbt2iVDyBwT5A0PnELlGg0nanpA/V7SZr6HKmN/4t6tNRZZuLHA?=
 =?us-ascii?Q?RsDR1A9OrVhJlVTmiRTK5sgp/ri0XUrhiDGd7ZK8turMWojShiFW1MNX2F2A?=
 =?us-ascii?Q?cYvpgNntcMk/ckJrdlWNMlT2LocFU++V5gV8YWc81sEygU2UGl1VsGa/SerO?=
 =?us-ascii?Q?YqDlkl4qJNxOnFS7IsQtBUYpCg9DrF/nQtCcPDek83051JkBl6dxsyhwGvSs?=
 =?us-ascii?Q?sHbycZP551H/hG6jg3hFUHeTaW+AqOXTAZgZ9tJdhtRYS5f1aKejKj5ICPpu?=
 =?us-ascii?Q?VBMEQu5ZKAUi4pfJTFcwWxt0GYVwUgwAfs0a/ljSD7TLF1G8OeL3qV/wuXr7?=
 =?us-ascii?Q?krP+dZXq8JQ+CJ6ifNqvLoI+vWRlbSY0TKMyfLmVdviOAlJPhL7UrEoTb74s?=
 =?us-ascii?Q?yDcfNuTluxZSFLs9OJneKz75TgBnXly9mPKoO452PIlh+2siHMc3t20emjk4?=
 =?us-ascii?Q?fx2z4Wpuzo3wEDB4rE3HMKTWRHj3+IuzUmkJrkgrTU4+ohrPb59eJgoESff8?=
 =?us-ascii?Q?TSEnrIqnxNbt2OZ9eY1A6yYPyhsaraz1+tpYO0YIFIj4L9OsAZlTcOzq9RUr?=
 =?us-ascii?Q?pByHYbyZtHX555DDhROmDzzqFarfy4MSMbuTSIez0jh2rLnm3xeVmyrlC+eN?=
 =?us-ascii?Q?u6ZcnJgZcg1hxnp575Z2CaWA1gnf3VfEUb0yw5wf4R4smEr+U9fGtaPq0Dn2?=
 =?us-ascii?Q?tEPfa0bvPJOlinlBInRDM2Bq16OPAvYRe3rGco2J2syiBwPaqvJ9y9V3RJ00?=
 =?us-ascii?Q?/fP5py6EhWI4zCcGhhOdzMC4r+Cs1MUWc2Bs4ZXFC7K+FaKb96GCJP7yO/AD?=
 =?us-ascii?Q?4QN26VMaW+aUHqYzelcp1Lz/8FRQDN5p1/mVzuGghmXyqoL91Sr06yqr8JR6?=
 =?us-ascii?Q?DqcaSS7eidBIaGtYfIxAja0USGLwS7zpYefIb3Ct?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca44078f-a967-4a1d-4575-08d9e674a83b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:51:36.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3npXZtvbS1C18sqefPk/VadDMnzZdxHlZzwQO44dGZhMGWabzVpUQ0EJfrpD1f4z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4600
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OqWeYJJXvvBujFEcsUpfg34JSu5dvZ9Q
X-Proofpoint-ORIG-GUID: OqWeYJJXvvBujFEcsUpfg34JSu5dvZ9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_08,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=487 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 05:38:07PM +0100, Michal Hocko wrote:
> On Wed 02-02-22 07:54:48, Roman Gushchin wrote:
> > On Wed, Feb 02, 2022 at 09:57:18AM +0100, Michal Hocko wrote:
> > > On Tue 01-02-22 11:41:19, Waiman Long wrote:
> > > > 
> > > > On 2/1/22 05:49, Michal Hocko wrote:
> > > [...]
> > > > > Could you be more specific? Offlined memcgs are still part of the
> > > > > hierarchy IIRC. So it shouldn't be much more than iterating the whole
> > > > > cgroup tree and collect interesting data about dead cgroups.
> > > > 
> > > > What I mean is that without piggybacking on top of page_owner, we will to
> > > > add a lot more code to collect and display those information which may have
> > > > some overhead of its own.
> > > 
> > > Yes, there is nothing like a free lunch. Page owner is certainly a tool
> > > that can be used. My main concern is that this tool doesn't really
> > > scale on large machines with a lots of memory. It will provide a very
> > > detailed information but I am not sure this is particularly helpful to
> > > most admins (why should people process tons of allocation backtraces in
> > > the first place). Wouldn't it be sufficient to have per dead memcg stats
> > > to see where the memory sits?
> > > 
> > > Accumulated offline memcgs is something that bothers more people and I
> > > am really wondering whether we can do more for those people to evaluate
> > > the current state.
> > 
> > Cgroup v2 has corresponding counters for years. Or do you mean something different?
> 
> Do we have anything more specific than nr_dying_descendants?

No, just nr_dying_descendants.

> I was thinking about an interface which would provide paths and stats for dead
> memcgs. But I have to confess I haven't really spent much time thinking
> about how much work that would be. I am by no means against adding memcg
> information to the page owner. I just think there must be a better way
> to present resource consumption by dead memcgs.

I'd go with a drgn script. I wrote a bunch of them some times ago and
can probably revive them and post here (will take few days).

I agree that the problem still exists and providing some tool around would be
useful.

Thanks!
