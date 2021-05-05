Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B280374B19
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 00:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEEWU5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 18:20:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhEEWU4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 18:20:56 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145MENSV025153;
        Wed, 5 May 2021 15:19:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ByFq6507AVEX59jck3ULXtpF9kLypXjISpI/R9rYpbE=;
 b=C0V6RorqIcPEfZYTdvU7i04Dv2sUutkoz3BohZ6GR3cguQeWFO5sL+fnyQuewDL1TrDQ
 nPrWFkgdydVbu1EGKm3FATk3r4dEgBUtPoTaIuRXx7c0X2xq+bPyJuij/ICPePRb42IK
 x8BpK1pNcqtVmbVNmndoyGgPVgPrQsfQjUQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38beb56d93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 15:19:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 15:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk6LjfHBYPw9TzgXFCgOafmZTAmp2adCmLqkH7IZiD1bypiAH5IOShc0eDzTFb4mPRUu+m+Jnkl0hA4uJph/iTCR/lzZsoqmQ35L/0Orw5Uprmcm1ddCljgZvstmrM+d/B3eboiwNjHZFiE9C+0Mrun0Jv5zzkSOuS7gB9p8eqdjx5Y6Twm1c4eHMED5C3IU9lXDVv6KBgB8XSlmUfyMphRy+HlIWCfSMacVW1cKcQiz6PrJya6DZNyvpYXN78ESwt1McH23Kz5k5vithWYwXsOhElnu1FqmXkOHSK3QQWrmSmagubgXnEiu/r/39Q2STK9uaehHdQev8p4A11G4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByFq6507AVEX59jck3ULXtpF9kLypXjISpI/R9rYpbE=;
 b=nGYetQjt3H8m6Di/LIZXSXtDThqxb3NptgYNzjz+7LjV5DGRTCrznFDCN7SKp6pzvuALBuT1Re5GU4tYMjTr2cL21v3oqBEQUFLs2vvPMH6dNmJ8Q6CCjPHZMJPVsbL2dqmKxW12PAIN2xHR1L/6Dxy+sxu5TsIuuEeA33Em4RQ7xBS8DbFKVY2mzrhizUEhjH3NZQvXAy/qbEKigLPLYbNtrcuNCwN0UFfocZMcySqQ7XpFUSFqkzfe2LRD06+2Pz/qCtcMjZLeV8WfONU/uFuPGp5vbj+CZBWOqUlcYrqOrN1VFPSBNmizxSWCy2fnccu/YxLUvFsSph0Ab6vw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4134.namprd15.prod.outlook.com (2603:10b6:a03:9a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 22:19:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 22:19:43 +0000
Date:   Wed, 5 May 2021 15:19:39 -0700
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
Message-ID: <YJMZ+542NVnbWgat@carbon.dhcp.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
 <YJLk1tmDeGed58yr@carbon.dhcp.thefacebook.com>
 <f73cc1c6-2950-c56d-6a57-8cebb23db65b@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f73cc1c6-2950-c56d-6a57-8cebb23db65b@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:c814]
X-ClientProxiedBy: MWHPR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:300:ad::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c814) by MWHPR15CA0028.namprd15.prod.outlook.com (2603:10b6:300:ad::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 22:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf4a945-df16-476d-3de2-08d91013e224
X-MS-TrafficTypeDiagnostic: BYAPR15MB4134:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4134C5858AF7848604ABC12DBE599@BYAPR15MB4134.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46vcrhbJfmfMrxBFQpYH8RQXAEcr8tqLCdsw/pG6SRJrqEfMUfrz/m3fkfHPeWBpPxy7DxS1X68HHzVF5ATggMxnOtIOkbF/soJhWwYMCdBHZ1k5rT5xxf7hBJHk17NxPg2UrkLY8jOdbEZRfElHG1ZvbVuUAkwrgMu2YMa16JATF/iAlxpom6yhg+RMMhQl03Evb4V6hPu+yqL6u6HtkOLLjFOn3rTOVxQcqG8oYVL7l4P066lGGU7w0WtGjNsDAmZoUB0jt+mkZoYYp9+murG4zWSiE36BcmQY9vuXQnOsJdlygSIGPetnSief/8emq8PbEevJTZNJPAg//vshvzLudbG8j4+W+pru3otVgUhghZGxmI7PFoULYHAUEU+fo9myYYzLG4KCAqU/lfyIgoMPYejrvCFN0l2CVy4Zn5jNqh0JB/lhNkOoZLkS8lrLpQR0/G43bV3uVtcHPh5/v9jK9tX1JMj7XnJ3TwTPjTC4Rgb5ZzUnWmpEaTWc9zsyL0ENN1z9oXaCeBKoU0yv5qwW/4+Mh3Y/IynBxwtrMog32YpZ9c1e2jPoIJKfkow2Aj9WMAW0AeoeGt6vIrkWl7BBrlA/BLb3506ZQZJyioXhq7iYaXG336EP9joQjg7+GbpgQ3D9geaiTg845HVySQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(8676002)(86362001)(6506007)(9686003)(6916009)(55016002)(8936002)(52116002)(478600001)(7696005)(6666004)(2906002)(53546011)(66476007)(66556008)(186003)(16526019)(316002)(38100700002)(54906003)(5660300002)(83380400001)(66946007)(7416002)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ouSmmwjPnTIvEasYtrZhszyDqT+Fa3aI5xYQObv15wPNpKcf5rVcab/Ikj7F?=
 =?us-ascii?Q?BexNkwmerwfwsPa53QkZu6aGmnBQZvt0ohPxtpc0RHOcp/ht2r9wdwfGJyKB?=
 =?us-ascii?Q?89hBOsCrnpMFA8Olrwb8OeOxCzmh2od2NSDWaXVcMuiSKnLA84X+NBVKwybP?=
 =?us-ascii?Q?rJ53i0t906NzoVQzeEbXVt7vuXUQ4hKjLXdz1RbHKjRuAPlc0NnQWUah/XMl?=
 =?us-ascii?Q?2gBAYwdNEgLKtugNUQwSX3Y/4sD2Q/H4AUcFi8euyfOahce7r+uvA3FpWU+I?=
 =?us-ascii?Q?fV4XrkvEVGY2FSoNGFKfJd9kqOVOc7lNHZGlwm5bQ19vScEgWLSeapOdPQhx?=
 =?us-ascii?Q?GjagXlotaXKUD9hN/D4jI9CBohFboDetqIzaJpENW1Sfxy8JYa5nKBpvdHrm?=
 =?us-ascii?Q?1xwhtpLY9y5tjwaUoSvTEP2fG5ijPu/eoDKwKYXW8MWtIz0sAxPKs2OSr6hE?=
 =?us-ascii?Q?urQyTCV+FmIWPCihr+wYiN3/6WWkAZhk1DA+BlXqEU1chpqm7dmmCxo0oymg?=
 =?us-ascii?Q?WkmfDhwvek+TdLdkm/1volLItkHzkKwRmMyZ0RchXqasbBSy7XVJdlrnBsc2?=
 =?us-ascii?Q?uwQW2qQXuU/xZHE99NDUwFHXTLmwLepf54OvGo5M0PcI64C23NVjv2o2URPS?=
 =?us-ascii?Q?AGSPz4Awakq6cNvvELO4ZOkeXvAKeqwq+LCrlGw2ZWNAGZYdC66OygsCjmZB?=
 =?us-ascii?Q?ZBJUPZFZltJ7yZS/xn2rk+fxIhOlfW6c8Stq/xn9Y0lpsYgaJQww8/ILDCRj?=
 =?us-ascii?Q?BQJwx3qIIuwgYK+jTnMmWfzXFB4Opra6rsozcUwJt5Joa/rwFr/Ny1fUawzM?=
 =?us-ascii?Q?1kwbnX2nkgkOXVcwB4HWSXGS/SgJ56kGczq6foid/d2lQF9Tku/bA2WHcpAA?=
 =?us-ascii?Q?D/1YxML6ckC4jIzqREIiPQeQCADCfDw4aMlB8G5XF/ydg3mKiqMM+h8Ww08G?=
 =?us-ascii?Q?XaDoPGrBPtK4SzWNjJmVTcPwcAz1kVnS31NvTx2+RTPjiiLP7uIiTQv422ST?=
 =?us-ascii?Q?koonJf2bLb4OKhurCKENpA+JGLQgjCA4qb0oCjJRP8OSw7MzosMeXiPe1A3e?=
 =?us-ascii?Q?B1gNgexHh5YAEAvC/DNfxnAV6sSoPNjJB2p/DKMIW1xMwAR2dh4Bd/spzN1q?=
 =?us-ascii?Q?f3w4YkWCi7ic+TRRswbtWYWomAh4Nd3f8mCM+p3+J/HOnvDjp1/a2wdnJOHu?=
 =?us-ascii?Q?2a+rwImSM1i5d2v+Y0qgfJ9GtJ7b+WTJMKWT7X22O1sTLzXM1JS+8vvW3fyo?=
 =?us-ascii?Q?RJYWVhF97Fq8zBPL1QKPGre7pMdMlwWdVPYeN3la6xqFD4fyQ+i4+vCM99uj?=
 =?us-ascii?Q?x5pfx87zjKGDOBMTZFg60mJ+ZrGODtFIYDZoIcSDrUHBmxCqwYlQx4WFt7NR?=
 =?us-ascii?Q?GNycze4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf4a945-df16-476d-3de2-08d91013e224
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 22:19:43.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB21CQ5bLPCUpxUQeYaIqLxNImbGRoCWE8wY1aNrubdOhXazkDJX07keM/+7WlVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4134
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: b4BecweKQ4cqmy4BdmhlA8g_sSVtAMx1
X-Proofpoint-GUID: b4BecweKQ4cqmy4BdmhlA8g_sSVtAMx1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_10:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 11:29:54PM +0200, Vlastimil Babka wrote:
> On 5/5/21 8:32 PM, Roman Gushchin wrote:
> > On Wed, May 05, 2021 at 08:02:06PM +0200, Vlastimil Babka wrote:
> >> On 5/5/21 7:30 PM, Roman Gushchin wrote:
> >> > On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
> >> >> 
> >> >> With this change, all the objcg pointer array objects will come from
> >> >> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> >> >> both the recursive kfree() problem and non-freeable slab problem are
> >> >> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> >> >> have mixed accounted and unaccounted objects, this will slightly reduce
> >> >> the number of objcg pointer arrays that need to be allocated and save
> >> >> a bit of memory.
> >> > 
> >> > Unfortunately the positive effect of this change will be likely
> >> > reversed by a lower utilization due to a larger number of caches.
> >> > 
> >> > Btw, I wonder if we also need a change in the slab caches merging procedure?
> >> > KMALLOC_NORMAL caches should not be merged with caches which can potentially
> >> > include accounted objects.
> >> 
> >> Good point. But looks like kmalloc* caches are extempt from all merging in
> >> create_boot_cache() via
> >> 
> >> 	s->refcount = -1;       /* Exempt from merging for now */
> > 
> > Wait, s->refcount is adjusted to 1 in create_kmalloc_cache() after calling
> > into create_boot_cache?
> 
> Hmm I missed that
> 
> Now I wonder why all kmalloc caches on my system have 0 aliases :)
> cat /sys/kernel/slab/kmalloc-*/aliases

Yeah, I noticed it too, it's a good question. And I remember a case from
the past when it wasn't true (kmalloc-32 was shared with something else).
