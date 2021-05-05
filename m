Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCEE374816
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhEESjg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:39:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhEESjf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:39:35 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145ITjOs000616;
        Wed, 5 May 2021 11:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=RAVf5S2ap8edtOM0cctuOMXgO8QEiKmMqbwR9owORi4=;
 b=m9TzShrDWKfcklKq/Y0yhNazXkHPBbEyfb8W343lCC6ulTPFhPvPJghEBubDI5QHxd4W
 4e8IAojpL3XgCKJ74ilzv8vpOc+xwFSm8dgyOVNCGhuyPq+jtiJmeRHnoyk1AVRQethJ
 a7wy1sG+wSQtK5JaGGVHLth5TNE4EGM/Aeo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38bebpn7gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 11:38:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 11:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3tlr/DALV39Sgz/lLDQO7d8ijL0LCxClmkvHqo6d9kF9euzzvvyzWLL9sEMimn0N4bc7mBq7Fi9eavjyJ9UzQ9OMYAZDo4pHCJTuMMVs7KZYQ5qKkItpZrAuIXs3LYVm4IVFHsAa7ha+kTDv80oJKZFC5YqeD9OuL8i2vkumM5BXH5uBlNLRnMJTg1ntrHsaHjTdJfWff9fswh2ETrKGxi+qBUcWkYgKItPTyR0JEANhwsZhddfHvCmwdrbyDhYcIVfq0yHwA78B1CIQ9+f8Gzir7W/j52kdn3ZGlYJPHnz869n0KOMsOGxsoxbt7s41gVU4TUwLpzrd/FRnpbWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erEg8wksfxTxxVOqxDatwgWvr14UqnoynNJCkkOXQV8=;
 b=friMS8GMhwCz58RbyvBViDSM0xVzrlElwg2qsQ231wInraIUanKx9RKE423dtdIO+lgDkvLzNCgdTkFBVnyadWIXrLHA9IvcflBIc2HFY4hdeEsnhaiqdok0KKTXBoLSZqzvGG7YobItKgNM1hGVBoAvc8VSIh/ThrEz0NuFh/uMBouHVg39eydrfoP8LujX60d1ceJFcQYaLWXUY1Hjzvz6Usw2qMb1U52h3xNltCxWyjXuWY90N6l2GNBPnKU7n83MIjs2rvIywv2iVEQ08ntVUP/4xZAhIp7m/IQTBx93oblX7nAEKomKblHgV/STzih3MVNDK/wzis1S0aQXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB4135.namprd15.prod.outlook.com (2603:10b6:a03:a0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 18:38:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 18:38:22 +0000
Date:   Wed, 5 May 2021 11:38:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <llong@redhat.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <YJLmGcGYLZwqehIX@carbon.dhcp.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
 <4e4b6903-2444-f4ed-f589-26d5beae3120@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e4b6903-2444-f4ed-f589-26d5beae3120@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:3b50]
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3b50) by MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 18:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3a953e1-eb10-4b75-3134-08d90ff4f632
X-MS-TrafficTypeDiagnostic: BYAPR15MB4135:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4135BB4A4EB8C70EAFBC8AADBE599@BYAPR15MB4135.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBI4PrVrGWiqXFrb+SN7nCRQ16h8Q4LC/w3WzvSXgayygJ3m6og+f5TpF5/ejHPFKUJWM+EYIO2J5kkq++IhvGC5GTiSfTHPDcQb6s0wfdnPXGyldax+3UkNn17nGX/6bLVXrihQUCa6hN3WkpiPT+c9bgnZJXnpER4IaAg2QL+CL4QdvJls4bIMs6h/4UMBw9Mxjvu8ITcmXmPRjeMxOeSUHHcXYUaVC3bu6ZJ4suC9GVlSD1Z5TTp/DisXde/LGQiIOnYnDOSU2a99zs7EuOYwef1SMghxl75yZy6eUbj9RRP56lvM4/jBAklAPQZ2kKIxZl1ctYOiO7HnOLaLoV98YcmicyPLZ+tMbXY/ogA9TC7s6kP83B7+PaZ6dtrwjTdB03YWWo82SWfUgYArzrRO3LLSpD9nQRgHi2KqdpxjAK0vfMSxV7HmcEATM546RVULQpowpWHpCvgiSOBfqKchFmVCxG1tNu71FXsOa0+r3E2ueC+is06balGBC7DSE6Cld9M0OeL7Z8AUIpLcsigeGmVIdzz00UvZokD2ZC5Y0itwzLf0EnGY9fN78OVA7hnhQL8F8UwvXVUwUFclHhIzl4PrwArWiDFcFAZJSlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(54906003)(8676002)(6916009)(5660300002)(316002)(7416002)(16526019)(86362001)(186003)(4326008)(8936002)(83380400001)(7696005)(478600001)(55016002)(38100700002)(66946007)(6506007)(2906002)(66556008)(6666004)(52116002)(66476007)(53546011)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?B1cPMAxRYqjHQ/TgsA2CjYSu7LnXB4XP9z8NgvG4qQmV3TA9EAaI7Gqooz?=
 =?iso-8859-1?Q?8vVi41cFq/wh0jubShSWbWWMHXRS7NOgwzzIuPJSwyTycvIb+H8f8NyVZX?=
 =?iso-8859-1?Q?E68MqMb7nxXpLoajuk/FNELM2DVNNlGFN1SjMxE50KBmxNky0lsxRictVg?=
 =?iso-8859-1?Q?gMwBoFDeMT4gD9cjRVlPJaKkwQPDAiV9P4QETVLHdB/NARH1tP+4t6xqOR?=
 =?iso-8859-1?Q?wcGh7XzkvJYKdP7nNAKqQ7x4n6aVXy04twqRG1NiCSxFJj0cIZj4pCG9nm?=
 =?iso-8859-1?Q?7lGkgEhXVj7OiJFrDt5EEuBhp7rzR+yhRKzgQqEg0/HJdtx3mWveaIUImM?=
 =?iso-8859-1?Q?CkeJPyxkB0GQsLhzt2+QbNAHcCSx0UvUeqY71xBm+z5I3y4g3A2wr6UfZe?=
 =?iso-8859-1?Q?vXcVzDj0EcFGkq4z4sUUX5mQZbzM8W89ywxNPaFBwilBjVRNthF7N156p5?=
 =?iso-8859-1?Q?3AvjX1V+YUK18qgoDVx0CO+fA88hfrlDuJUKOXooyM05WLPkhar1p8HWwD?=
 =?iso-8859-1?Q?zuaLbYmPD+qC2o54UNcCJNbS4mOtZVvTBoWAxHNeRdMczhC25qujs3Z3u/?=
 =?iso-8859-1?Q?pODbmRFeTvtYxQPbowHlNz5u6tJmcCXWV2uYSRgi97FrgcU/JqKEO0gsu5?=
 =?iso-8859-1?Q?9n6Gw4vSbchR2QKvUvOOaH7TnagBYxwTYD2T4t6EiCaU1SbizCYY8zIFZq?=
 =?iso-8859-1?Q?eFTx6bUridAifsqDrdFHBmovfd/YpeeInF0BsbDhoe4qY5GxxikAfhLwlR?=
 =?iso-8859-1?Q?kHrgxo0SQzLAANYVqCeSdhmimvGk2kOVBvG9lQuH5SYTqZ6tV5T1OAVJ/3?=
 =?iso-8859-1?Q?xY7wILrsJdDxHyJIzImcWuD1v18d4HI9S5WdhfCGimJqgHL8ToIUVqrGAm?=
 =?iso-8859-1?Q?ACezSHf7VJ29T2/5buhVTiOBWo2F/wqZAs9o+TLmBfsq6V7c32NuDpxCyq?=
 =?iso-8859-1?Q?B38H4XQeqKd2QXl3GeuFRy2dAuAwTckNBZIO2Cd6x7bt/Q/bCP73nbx3T3?=
 =?iso-8859-1?Q?vh0ikcmMkR9w7pgatXjauigVu8OcZ7HoGQSTbhKj8bzo61PEbAXQZpSI6D?=
 =?iso-8859-1?Q?JgSx6UE41hTHlqCwkLQi9YPAaFgCCiYklhtfy9WZ3yD7shN3bz9kDmMFVK?=
 =?iso-8859-1?Q?jxunfYM0VBMwfiXEYslWYGwnBW0DtSyTvS8r5w6D2auUnqqLcYV3qLtH3j?=
 =?iso-8859-1?Q?NSmjfC/MHxtbHD/G/w8GuQD1R1cj0kojExjDsZOnRbdBGuqZe9mEHXEIQ+?=
 =?iso-8859-1?Q?HLP2cS8LhchGnwdN9TABtQRXDzNk0kZ6IU/7i9CSCBFvjYwMPgLClAJgCY?=
 =?iso-8859-1?Q?9pYbXUtWR1hdz+FJARRmfqHUohx1jFW/687immySO9QtgUm8eS+fVx+Dnz?=
 =?iso-8859-1?Q?lvoSeA58vCL7wOu2YAqYCXP+LBoPFbHw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a953e1-eb10-4b75-3134-08d90ff4f632
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:38:22.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVFvUt6EE/J/r5jPmc4IjmpQgrONdR1SL/Q1LPkTMthVh9DSl/+rdA85d/3jQ2Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4135
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ZX7caCyFhhDDYMMlTpJ2-PHOZGbtC8p-
X-Proofpoint-ORIG-GUID: ZX7caCyFhhDDYMMlTpJ2-PHOZGbtC8p-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 02:31:28PM -0400, Waiman Long wrote:
> On 5/5/21 2:02 PM, Vlastimil Babka wrote:
> > On 5/5/21 7:30 PM, Roman Gushchin wrote:
> > > On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
> > > > With this change, all the objcg pointer array objects will come from
> > > > KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> > > > both the recursive kfree() problem and non-freeable slab problem are
> > > > gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> > > > have mixed accounted and unaccounted objects, this will slightly reduce
> > > > the number of objcg pointer arrays that need to be allocated and save
> > > > a bit of memory.
> > > Unfortunately the positive effect of this change will be likely
> > > reversed by a lower utilization due to a larger number of caches.
> > > 
> > > Btw, I wonder if we also need a change in the slab caches merging procedure?
> > > KMALLOC_NORMAL caches should not be merged with caches which can potentially
> > > include accounted objects.
> > Good point. But looks like kmalloc* caches are extempt from all merging in
> > create_boot_cache() via
> > 
> > 	s->refcount = -1;       /* Exempt from merging for now */
> > 
> > It wouldn't hurt though to create the kmalloc-cg-* caches with SLAB_ACCOUNT flag
> > to prevent accidental merging in case the above is ever removed. It would also
> > better reflect reality, and ensure that the array is allocated immediately with
> > the page, AFAICS.
> > 
> I am not sure if this is really true.
> 
> struct kmem_cache *__init create_kmalloc_cache(const char *name,
>                 unsigned int size, slab_flags_t flags,
>                 unsigned int useroffset, unsigned int usersize)
> {
>         struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
> 
>         if (!s)
>                 panic("Out of memory when creating slab %s\n", name);
> 
>         create_boot_cache(s, name, size, flags, useroffset, usersize);
>         kasan_cache_create_kmalloc(s);
>         list_add(&s->list, &slab_caches);
>         s->refcount = 1;
>         return s;
> }
> 
> Even though refcount is set to -1 initially, it is set back to 1 afterward.
> So merging can still happen AFAICS.

Right, thanks, I already noticed it. Then yeah, we should make sure we're not
merging KMALLOC_NORMAL caches with any others.
