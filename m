Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7623747EC
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhEESUD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:20:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229901AbhEESUD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:20:03 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 145IEfwR004761;
        Wed, 5 May 2021 11:18:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=URX2LCB9E98x3Y2KMWEJAsVr8eNAqHlMYbvf/ZBNu+8=;
 b=NyNuc/JO7oKUYin3k06k2ctQ9OD563wwrlug40qXqlGGDSTCIO4kapQm54W32l6y0mgD
 JTSR2qxK6cSKbNeCNyYor7PnDgK5K+t5H+l6gPMTfBiRHT42iGYRfMgKjUIFfA+IqmTd
 X5reC+ewVqzv5n/DmlE8iJ3lqpu7RSH1zGE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38bed1w2rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 11:18:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 11:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwGu50qjpJbvmCo5TeYqAtZlforkiayzi9KMCaRsc48H7QGsNMBML16S93mKnVzVj7t2L16+08fEDXnf6Iy68Uq4u++AKU85/l3n5G0wQXbs3cqUcURcSxxddlF8rCb0O7LL5TrVyGNzpwdgm9y1jv8Ri6163rojAjsDT9Osdw1mdCHm4rBA79gIPJsuqpYeobp/bnjJkVpYJQVFmR5E6689mOobOO6vmC8D9Ynx+yOvUPkCg4wFS0ByTB48416piuaGpbCLVxuQU53bUrpqiwIQrzHvlL6WJo4s34YzWVMgYYP3fg23QNPkSNhMMN8C3hWwoY1PZNyguVq+9JDY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URX2LCB9E98x3Y2KMWEJAsVr8eNAqHlMYbvf/ZBNu+8=;
 b=EZa/IX7IAsb+aQSlHoUPNlp5m0+Sdmrj6SxfUapv9hr9nKCKtgkuBO7R8jDbAIqwR3h2eHClj017v14dcaKs2+ncmoEuvMUI2Cf6iiB442tg80Qwj3VgUx15WR8s79G6UJcs0faxMNUExghMiLy6pIYp3YTVB1wMik1caSpDRC2yVK+l38WM+fynp0a7qPIgLU3Z5oYoP/er5jT9b/6hO3hOLIR4RFLX4lHZGNXCpjfWCUVQEqdnWFc0qmK+tkfz9uxquLrto5z4/JGy2w0Lr+F0IzjeE2ow+JkNTWVOBROHmyWccluEMTHzWlbAFAN4p8mW+x8ZvcacAn1kU15EoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY3PR15MB4961.namprd15.prod.outlook.com (2603:10b6:a03:3c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 18:18:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 18:18:52 +0000
Date:   Wed, 5 May 2021 11:18:47 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of
 kmalloc-cg-<n> caches
Message-ID: <YJLhhw30+Z/Me8+x@carbon.dhcp.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:eb2d]
X-ClientProxiedBy: MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:eb2d) by MWHPR01CA0048.prod.exchangelabs.com (2603:10b6:300:101::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 18:18:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b5a1dc0-3d56-4283-3c9b-08d90ff23c68
X-MS-TrafficTypeDiagnostic: BY3PR15MB4961:
X-Microsoft-Antispam-PRVS: <BY3PR15MB4961CEDC3FD32383E910522FBE599@BY3PR15MB4961.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3YH+/FXlCfiCtMmpiCltIumVCFYBC12Uca0AlNbHLngxJAJ+y81OsIPegQBym2p4PWrymcs+d94xZCyXHLYcLCR79NhvzQ1NXqQr0hhhfsMALv34NmPN3V/w12KNQPffwRTtYzf4/XBC+pvyFK78h/RqenmB36Kf78YeRArutFKYyOeWX0mS1Nzxp9ot5xYnYZ3a4UcWfV5L/TrmON4u0/T6u6uEor9C+8hGSRsbVbSpX1zeWDzDeCdkt50lcwDCAbAI3hESE0zvLxoFMN+HfZnnYC0KLSDYEvgq+2L2F/UQ4BVlzrF2j1N09av9HzTEs7MjcCWAuWxaelFj8GmhAWo4UtPimOiWaE0L7aV84az7o7+k0NnN81hjrMUPHD2Hzoqy1IvS0GHXSEETmBJKvKjiog6bXUY7rFPHURbF04hdn2EkhdZ6DTwLobzF3jVRE2Go8Vg0JkEz/DVcl6z3B/TIxKG3KU4PFsZXzupzwSqF7ipXuysomekXuEiIEHuVW1NMri4FlEx7X6WT200xIJxnm5HGeIpXC8BJK4jmasY9aysH7r/X8eWWyrpK1Y4Iw9VVxkl5WWYU24YDg2H83ZDu10VgWdrksTyeBY0Q8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(316002)(38100700002)(5660300002)(52116002)(83380400001)(7696005)(54906003)(4326008)(9686003)(66946007)(6916009)(66476007)(66556008)(8676002)(2906002)(6506007)(53546011)(86362001)(7416002)(186003)(478600001)(16526019)(8936002)(6666004)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GADervPJWHHmvtE0jKPpO9lWdlsOTtTK1dd0JhA99OBD5N5Zt8morKiL5MHA?=
 =?us-ascii?Q?w0O7jB9805HvIq4qPjGT/pJOYzP1lq3sTDMOKV1eAFH0EpMp368FN4rL131h?=
 =?us-ascii?Q?0/yiyOR2ikk75RE4sP/785Z0GjR3hyxPJT+8WRbxiPn6vKxkVxdX89srV9JA?=
 =?us-ascii?Q?XDAOts9gPg95CiHE8aHt9OSfmcLfbOG0rv92+Mq02VdeQ6dp5m+S/tN2bjw9?=
 =?us-ascii?Q?u6fsywOuGUetexgdorWfHb2Fy1QiSSSjAiTiADoRNngSMIq2/TloEtRI4yXu?=
 =?us-ascii?Q?vajRR6IEKEl3vDAebkVHi1gv8uXFybfWsVRbuSk6FFsW5BZXZOZ+ocBhRBLG?=
 =?us-ascii?Q?xFAfxfwERRDZnfOKbPU4Stwwn6P302bv//eT2O0ZF2Jm/aBfLCdhU6PfRUqp?=
 =?us-ascii?Q?X1n5X7ieedRGPccXTeQYy3m6xsC2WfRpwtliwHZV63wfYcKO0lL+yemjXbsA?=
 =?us-ascii?Q?gRCUcBBetATlLBoH44W4WAT3m7drqJE8ne8rd3F/N/hzY11TqQ1ClXOnofxb?=
 =?us-ascii?Q?FNpibqoNTgT6ScepELo5zFhRm9Rf8AxGUYvvMn+oTdaMiDmVVOnPCPu3DyKa?=
 =?us-ascii?Q?IpM6TvGrIaqHchRWPwlYBmg6Nla1S7Nu7dq+GZlh8HUdwER/15Ni8QKK+wzz?=
 =?us-ascii?Q?2kfTUrUBWS6iwiojvj2xXs1YC5TZS9nEYVZF1NZS2/fMVMNfioHGvoMBrNTS?=
 =?us-ascii?Q?EQb52tE01XkMXbPH9CdYELHEGZ1i0F4Hxet50ig0CKuKkKO5QcJjL+3jmFk4?=
 =?us-ascii?Q?Z+JJIf+oBcJSnGYmyVWJN15zPCSzk2fhPUy6nPghwQCltNhf7dpijLST/y4z?=
 =?us-ascii?Q?EHi66e6MuJLkIIzV9WuFQeAaZfGEIC0uHqguNKxWuxxIig4f2VHmJ+GdWUtV?=
 =?us-ascii?Q?Jq9n5ize1ROg29TXjRC23oRe8lW3CISEy87PLVtyrp1ttvE43sCd3a+TIu6w?=
 =?us-ascii?Q?pCHPie7GG3rHwxwAugJ6nZsZpNFuFBVChTpKctpitCgs7nlueUrackXUna3f?=
 =?us-ascii?Q?2w33ExhPHGdwRLFwD4NwJJOcO/kL9Rohproin7sJLrEwOr1059dvXw2rXzdI?=
 =?us-ascii?Q?0jDIP2T4ZwzmOgpgf9WFrMT5CL65lPkJseRrJaQxzqQAhcfRvqT133qwV6YT?=
 =?us-ascii?Q?ELUiKNanfSElqPNEmGUJCJBS7gtQtw+ZVdS2HDtUL0DukJCWjPEouRzS+NUi?=
 =?us-ascii?Q?kyar4sCgjznwT75QJoNt3LAOQN1M/ITwddqFRoTT0HSTms+Pw7BwKhVUtYKH?=
 =?us-ascii?Q?5EzlzimGfJmP2rCWY8G9ZTtbiaW+hEd5mgCPDpuuGDaavuyq2zsCmRdvKwKm?=
 =?us-ascii?Q?TeSotRnVJkkGFkS3lbR+yUZzxMRLpexxHT1c5FJtts8Y/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5a1dc0-3d56-4283-3c9b-08d90ff23c68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:18:52.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egzZYR5pCm/8lGHWlljs7ccqH/r1MyvWRYxjnITQ2ZcOCdAaIXQb/x9e2P0t1bnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4961
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jHYb4A2A5JNFpFV_-1W2-kEll8-DTAU5
X-Proofpoint-ORIG-GUID: jHYb4A2A5JNFpFV_-1W2-kEll8-DTAU5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105050128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 08:02:06PM +0200, Vlastimil Babka wrote:
> On 5/5/21 7:30 PM, Roman Gushchin wrote:
> > On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
> >> 
> >> With this change, all the objcg pointer array objects will come from
> >> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> >> both the recursive kfree() problem and non-freeable slab problem are
> >> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> >> have mixed accounted and unaccounted objects, this will slightly reduce
> >> the number of objcg pointer arrays that need to be allocated and save
> >> a bit of memory.
> > 
> > Unfortunately the positive effect of this change will be likely
> > reversed by a lower utilization due to a larger number of caches.
> > 
> > Btw, I wonder if we also need a change in the slab caches merging procedure?
> > KMALLOC_NORMAL caches should not be merged with caches which can potentially
> > include accounted objects.
> 
> Good point. But looks like kmalloc* caches are extempt from all merging in
> create_boot_cache() via
> 
> 	s->refcount = -1;       /* Exempt from merging for now */

Oh, interesting... I wonder if there is (still) a good reason for that? Maybe
we can remove this limitation and save some memory?

> 
> It wouldn't hurt though to create the kmalloc-cg-* caches with SLAB_ACCOUNT flag
> to prevent accidental merging in case the above is ever removed. It would also
> better reflect reality, and ensure that the array is allocated immediately with
> the page, AFAICS.

That wouldn't be enough, because a !SLAB_ACCOUNT cache can still have accounted
allocations and be merged with kmalloc-* cache. What we might wanna do is to
keep the no-merging rule for kmalloc-*, but relax it for kmalloc-cg-* caches.

But we can do it later, as a separate change.

Thanks!
