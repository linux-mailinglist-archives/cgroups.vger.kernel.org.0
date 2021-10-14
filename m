Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07DB42CF6A
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhJNAJc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 20:09:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230331AbhJNAJX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 20:09:23 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19E03Hgi009174;
        Wed, 13 Oct 2021 17:07:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kOIvmYwfcct8O15b9j4U2rcCPpmYFpboayjhaKQdueo=;
 b=qKjrE6h7jRZpk3aFdsB0+/v/ZFLx/RBM2MqCm8pe+2muU4pIfQtlDT1vccAC1kQSvo0R
 CdDZBnAi5zGf5qZ/CGCtTcpbbSgG0PyHbQVbXshJ4cMyZTsZdqwZSzTWasxcZUQFDdYu
 09v6linhDg6nXEAoI072QSw7wtRtF/dJ32Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3bp8vqg914-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Oct 2021 17:07:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 13 Oct 2021 17:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndvT1Abo7MkK3mzHSsZYLoM00mXWwffJwcjdikPjHFSweI5vNPwryIxMYSHkzIMx6ZG02jonjBOOuLmOKgg5bc1dDYpb9cG1RUplhcgv9GXwA7sw+NZwLeoV6C20TpWei7bUQxuLCVUB+E7sug7m8EnfAXJasQLg0F+D1HiBTOq4zfoCH7V8qQiED4gSjP0YM2qHPeYdBJ24K/VrpJloMWKJ8Vt/grf2XyjGQcOeHIQXpZqzJ4PTzBlfwbS/yRj1HJUIcfG4kRI69xfojlV4uQv2eKKUhFM8wsTrbfUjpOxx6/HRUOMFHw86kmGWGr0xQVak6hlGdiKJZjKur8XNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOIvmYwfcct8O15b9j4U2rcCPpmYFpboayjhaKQdueo=;
 b=aSAbbVzTCVKire4UPmKTYj+aci1lVI2K9wPb2w7aWrMhM2F2itCpDY89DvasX65XdadXPZhQxgDeaaFkL1KfZ6gamEMFAAgi1m0CkCU7prLC3+NG2AGE2tOrnFTBHrqyp8ZK9Qxq7cYbqsKDQxlq45TYdLVyGpU8MdE5UkcTfxkd6m9VY6tZuvhPT1hge4F7UROISpz9fZuRbvmSY309EGsEqmRasAwhtMRAxZCDrXoXCUS9MB1VietAAdF2W4vA1p6W82Nx2dgZRZjefrn6Y4hJrkcSYF37JwjvwyjgGNAFLlajBRvQ7WXmL9/9E2PWZIgE3fA0oajwKR/739Dljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2519.namprd15.prod.outlook.com (2603:10b6:a03:14f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Thu, 14 Oct
 2021 00:07:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 00:07:03 +0000
Date:   Wed, 13 Oct 2021 17:06:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
Message-ID: <YWd0ohzK7RScx9TO@carbon.DHCP.thefacebook.com>
References: <20211013194338.1804247-1-shakeelb@google.com>
 <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
 <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com>
 <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
 <CALvZod7oYyGvHAQVO5fg5eCJefeU1J70iUS6-9k0gQ2S8-y7NQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod7oYyGvHAQVO5fg5eCJefeU1J70iUS6-9k0gQ2S8-y7NQ@mail.gmail.com>
X-ClientProxiedBy: MWHPR17CA0077.namprd17.prod.outlook.com
 (2603:10b6:300:c2::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:284f) by MWHPR17CA0077.namprd17.prod.outlook.com (2603:10b6:300:c2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Thu, 14 Oct 2021 00:07:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2456f236-6802-4ce5-0dc3-08d98ea68cce
X-MS-TrafficTypeDiagnostic: BYAPR15MB2519:
X-Microsoft-Antispam-PRVS: <BYAPR15MB25196E735A8DDE806E8FBC04BEB89@BYAPR15MB2519.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2829Wd7KM7Kj4y9s06VbwwW7w148ZuIfSu/aRNlYfuvQ1hffFGHi9IHxvknU7YVzYInsN+maj7Jc0jkrYLC/xbArllxdY+iIipqXARtSp7rCQQa9R965H082jzxd2x/lJysGKuncRlg0/9o4KtRQoiUj+yDBDvdrDG0Drldk3ACwq+Y5CwKhJgu3iqzZz5b1dFmaoxwGNWMS6OU3U/sYMsH1R6IPfhfJYhUR2yektflDjA7jF+FtNKMPBIckS0620Xn82QArxPmUEo6+4cZMD5cwiADDcbXqzcgVrZDYCAGJsw5GtXnbAHKE220brdk0aqld7rV83yiqHsN6Agb3eTYnOnm8Avh3RZXtgyBtNmmx1N7R4ccJc4oSeAznG1R9e1eAEx3EpW2GHHcY74IPibDBpGM1HYMS3Ot+B9Y/NYuH29CzXkWV42tBHV8kXXIGZ+naMjW+vON/KpEtBRHngmKWM6K1hk9m4IWRunzupDBf3SoyWa5Xh7Drgjt1lOPD3BpDVAGsVPz3F8Kl+FRuT009UdWIpGy2QRa54kcvdyFhtF+1UHbsrrvfbWu37nlyjnklqEv8hk8DL2HJml+0Eueg0nhHaz4ZxSZZf2+N+y5d54qX1ABuPETgj4b8yK5ErOhOhF0O+PwTgDv2Z23Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(7416002)(9686003)(4326008)(53546011)(508600001)(6666004)(86362001)(38100700002)(186003)(54906003)(66556008)(6916009)(8676002)(316002)(55016002)(2906002)(66946007)(83380400001)(66476007)(52116002)(8936002)(7696005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k3uVahuG8Ql9Yqbh66iCi0uKEFrnR3FCjv2f8+bIWqdBcPGbzYm/HhBg1gXw?=
 =?us-ascii?Q?tOgyoJ3tc9gdMtd52sqNYVdqFs8jgbttKclSRq34j1oK9v/4z0yMd2eX3GeQ?=
 =?us-ascii?Q?ArmlqPfKaX6GBS8xAc1NfCbtxhdoKscsXy4Oa3t+qEIonKHgOgBKrbwrwTwO?=
 =?us-ascii?Q?dJM2VJ1Mu2m00BsMj66XodsOhV1ELnu4kGkxfqUfxR2MFNyEcMzV2FSQOsuC?=
 =?us-ascii?Q?WkQfzRRt9y02mwCyari6XsbaT6WYWEIU0ZGvF1hZqkrTiyaUXh5CuXilVZ3h?=
 =?us-ascii?Q?tKIcD7LHe1nh/4foFkrvhEBRx9qmvpFH25VzIYrj5rXcthTJWrZWud+VXjic?=
 =?us-ascii?Q?aS4W1phN9k/6hUoE0VYGl2QNKu3nyofEp5z9mWYKNRuITImO1a20m6FPJsj+?=
 =?us-ascii?Q?Go68YUtPcOt/wrgmerrW62sds9MIa0BOgqML+T//vM37lBwExlY51xTqHn6c?=
 =?us-ascii?Q?1wCA2naaMcGA370beMmsxZdGtcaaCSwGZjsjzyebR4DTBhBek2t7W1zbCCY7?=
 =?us-ascii?Q?1JYs85cV42yoRreYuz1JuNcHDm+mdeZLMn2Ct5dtcuzYKeINDglUZuuTkOhj?=
 =?us-ascii?Q?4msJ1Wh+RcWpA347GbDo1FcWQmMnloAdvvmdwmzyU1pwXHaCz2FbZ2IA4krp?=
 =?us-ascii?Q?GHDAHvegmESxNICsBacltV3LWXXz8udFsN6GLFtWYQ5xSzsx69whHz1WRnLC?=
 =?us-ascii?Q?azyDeuFxhqdJRxkVmNEY3eQ//scyFV0/UvfWVMeUyjmVrc4FEr38dbIJUEbw?=
 =?us-ascii?Q?vwgMWgKl87jtdzi6QLNx3VlloU1UOftv+UtLIsBS1x4loH5OiMMlTxpcpp24?=
 =?us-ascii?Q?WG8M52tTHCALpzk/Sd9UHBjBbczgxbG0cmMY5kaEC3yTGU30psTKQ8n1k0RS?=
 =?us-ascii?Q?3gJd90z+Xo0IASjfYmfppivKzdoH/4sKyRZ7pQbgi4cOmBfevcu3ohTRbox8?=
 =?us-ascii?Q?bDbbUdEQskTfkXpjivZ9gtRrvbyQqduZd6TIrazWRUi2c1MndZMh0fT7U8mJ?=
 =?us-ascii?Q?DeOtejIa0xEP/O+idGIEjqFHSi9hDh5ItkZbqShLadqb/zQRcZjmnoHO5QUK?=
 =?us-ascii?Q?/dGEH3oGfA3RyKtwoK6rTGJ1rf2STuWn5pfgriktwu4NY5hNgWkqrQOHBDq0?=
 =?us-ascii?Q?dwah0zIzZnSveLHAYt0QJZV3y2rFZI95kHru9RcRJyfpUifgeJQzB3GaPcoo?=
 =?us-ascii?Q?EkhEPeBoxmCQ5bgIDbZ1Yjt2ciuMZK18QGTri80ygeS0GoIPOcAO5K20Udgw?=
 =?us-ascii?Q?Sj8pS1Al8YIUHuwlSASYaRpylYp8Mes7nW+LdOJloU+3SCATmrK7njS7sNzv?=
 =?us-ascii?Q?W5t4GICCnta0x7S1GrEsVa/7qFA1hWjDfZEZK/luEKwIFeg3ccx29l1Z5nwF?=
 =?us-ascii?Q?UfTaMSA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2456f236-6802-4ce5-0dc3-08d98ea68cce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 00:07:02.8794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQcWawxBkFqExkJA90DJPRWzNoZmbdtYPFEpr2QN09SRtI7V5Br9aG0TWlHTZDvQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2519
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: lmM-v9Uro8Dq40K-DSuZQYso06W0QR6l
X-Proofpoint-ORIG-GUID: lmM-v9Uro8Dq40K-DSuZQYso06W0QR6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_09,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=732 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 04:45:35PM -0700, Shakeel Butt wrote:
> On Wed, Oct 13, 2021 at 4:15 PM Roman Gushchin <guro@fb.com> wrote:
> >
> [...]
> > > >
> > > > Isn't it a bit too aggressive?
> > > >
> > > > How about
> > > >     if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))
> > >
> > > We actually know that kvmalloc(__GFP_ACCOUNT) users exist and can
> > > trigger bulk page allocator through vmalloc, so I don't think the
> > > warning would be any helpful.
> > >
> > > >        gfp &= ~__GFP_ACCOUNT;
> > >
> > > Bulk allocator is best effort, so callers have adequate fallbacks.
> > > Transparently disabling accounting would be unexpected.
> >
> > I see...
> >
> > Shouldn't we then move this check to an upper level?
> >
> > E.g.:
> >
> > if (!(gfp & __GFP_ACCOUNT))
> >    call_into_bulk_allocator();
> > else
> >    call_into_per_page_allocator();
> >
> 
> If we add this check in the upper level (e.g. in vm_area_alloc_pages()
> ) then I think we would need WARN_ON_ONCE(gfp & __GFP_ACCOUNT) in the
> bulk allocator to detect future users.
> 
> At the moment I am more inclined towards this patch's approach. Let's
> say in future we find there is a __GFP_ACCOUNT allocation which can
> benefit from bulk allocator and we decide to add such support in bulk
> allocator then we would not need to change the bulk allocator callers
> at that time just the bulk allocator.

Ok, no objections from me.

Thanks!
