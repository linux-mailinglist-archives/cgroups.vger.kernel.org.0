Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9881D57FB
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEORcV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 13:32:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60764 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgEORcU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 13:32:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FHS31T015496;
        Fri, 15 May 2020 10:31:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fff8INmGrPkWukb8lVnvz9ySQRHkmmYenu+695toJNM=;
 b=Zj7VKKXIsVYd6CL6TxyVbOP2Tw8JZGDckYQuhpuYW04ELNBFvp+8RTwDXeAXXN4RKm39
 p856DYK2gQCvHBxxLqdfy4WffN22iKOOS19wX7edYwkRl8AGbwYVH5JgOqb5UyQzB8JK
 5Q/UDSyw0NsVRvOVY7ybQ7zq0KSZnUxuP/I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 310wax2c0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 May 2020 10:31:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 15 May 2020 10:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV4l5rYp/be60othaCFiYULdHDUiqDS1rWQgVf4MvFXcYMGg/CZBMoNlYr7gWBl0I8jxkPGJC2VLruBtIl1U3iC4g1wa1yPpHwDLUc63X1tBjPJMWV8Beej5iOz1A3s7ybqGMhsWn2+xlEIcEBTovlieZiheOY8liHc47E9OZ3kdpzxFwVBgI1iMMqx4glZsC8HQOs0F2w+oOag789IamJi+stgYu2LYQyK3q55Mf+J7MPlgmtnj3eb66jMIWukVAG6E2j+UvqWufFUajTtNkfSsPGFagJTM3dKiYjHqLONCOx2u7AXzHjOOBrCGXI1Kc7bMnGfS/WNGbcUes/7TVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fff8INmGrPkWukb8lVnvz9ySQRHkmmYenu+695toJNM=;
 b=IoeNm9lAgaeB+85E9yGHMJKTlGu/z3DVHX7lm2rNFdYz9wpKhvCA/93zSRHy1uKhnQrlfYOZ06+cjLodxUieWtxeboe8ixx++L7FJlwozMhX1eajdV9ULJrTqZKSXmQv0ekWinc+9YYUC/Uy6PJzVH5qiNfWHHcfzBeBr397aTY438DcmWPoEQm3gL7zcjKYE2iHP5ddCruspGENJzpcGGvRV8hOK25ju/azh3/CT6dY85ezIcOW7lDE+EigCs6sT9aRxmFGARPxYzbWZ+PAiDsqmi56t9CHZpdEED6fhc2bGfFucF/rqrz0qdnw0uyEOohN33kAdZzH1fEiGnSExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fff8INmGrPkWukb8lVnvz9ySQRHkmmYenu+695toJNM=;
 b=ZpivsFou4ZAroJgfmSyZHI6M7YFqMr50u/n9jVhREWDfsVFJbq1XUJRvbGJ6zl5MWMc9+s+gDzTawbhWCySBLDoDRmAHDsviLzPfk1h6rsHqmmfPYXraRiV/Jy3PJohqzXBLf7qFxcUPwFpohqbD48sueFgopG9QCUfd/gHiuwk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2679.namprd15.prod.outlook.com (2603:10b6:a03:15b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Fri, 15 May
 2020 17:31:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 17:31:14 +0000
Date:   Fri, 15 May 2020 10:31:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Michal Hocko <mhocko@kernel.org>, Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200515173110.GB94522@carbon.DHCP.thefacebook.com>
References: <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
 <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
 <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
 <20200515065645.GD29153@dhcp22.suse.cz>
 <bad0e16b-7141-94c0-45f6-6ed03926b5f8@huawei.com>
 <20200515083458.GK29153@dhcp22.suse.cz>
 <CALvZod64-Yc0firp9C8MNhEaF6FTiKmSx2B3HOrvi8GkyOD-7g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod64-Yc0firp9C8MNhEaF6FTiKmSx2B3HOrvi8GkyOD-7g@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0075.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b821) by BYAPR07CA0075.namprd07.prod.outlook.com (2603:10b6:a03:12b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 17:31:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:b821]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d93a40-c130-416e-b9a7-08d7f8f5c40d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2679:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26798A48F8835F03138E8376BEBD0@BYAPR15MB2679.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65MZ9Ohs8Xng20DMg4iiQzl5FE+bxju31hiK/LhujMtZOQuwL4VwDY61VbcGKNWaUsAi2KDSm2ucNaltHhBhVcAxszXS4xee0OBUhkVq9I7EvMGBwECWWHa4AJhEWBVPA5Ak2VzRwx7OQiaCdAAOKlMB0m2pk6K7a+iS/pC303gzz4hNkkqrLMomVKoY5WLUJBPAnBzUU9MrhvVsMhjShOQP2p+1RxxHQORm4bqU5tUkHDGTDkGJrO6v1pDp7iShTvYp9QZgGAiN078Be8VaZ+VGh+fvWHHWqB3QP1h6WC3bgpW1ym2gIcdKh3qGc5KtDboIphmCW+p/nYDfZ0och5Rw/20VPThTAvTQeMtkcg8mZ+yTU5DbVh38/IhvRpukHKmm26laDFj76vkaxJdcjUViZ9aqWa0Ayd1DX/y31V+1yPUoKsUxJHuKUG/bcm9p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(346002)(366004)(376002)(8676002)(2906002)(6916009)(4326008)(54906003)(1076003)(5660300002)(316002)(7696005)(52116002)(53546011)(33656002)(478600001)(16526019)(186003)(66556008)(8936002)(55016002)(66476007)(9686003)(6506007)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Fv9oWq8LnIJtT68Ac48KtRXGX+KmQJYTzg++TY7eFG0Ej3UH+ZfzZOONkKYijcwnTiTdTc1YKWBic9jBxqRaHU1m3w8KAK9+sAwHaB+/PAUOIrih+bCDOLyIXAUq0mqVK7mqu4iy0ylSK/MIYJ3HjLOqvlBgOsyZLpIEb3J90at/1am2JSFzpiCsZsCQYsD84NOTR1uwilblftaClb1npMdcMSvaTRTaJwbRiugvlwL5sGqzXlmjtGaPZLepEd5qMCejRj50AjG9v/5UfJUlDot9vcZBn1slHpPDRDsVu81fAcqNytxdoaVmtbqfihm/QN6hbIleFVw/Ghs4DWPgk99Iz9nOA2Z/IMHE80slt2PFNwa0xH4sQ86cSaSv6QU2ICrGjFVSNbiq+wpqROdCjQWv06Bo53mLkxrI6/n6ktMqeCw7YLaYQ35Xj+d9bUBEDq5gJXTZ5mowL86tMCHjtu7NqisF2fRz/GLFRkTfmAYWuim44n5N29fPED2No5jZheg1EihFokQQLy6X5R0sbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d93a40-c130-416e-b9a7-08d7f8f5c40d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 17:31:13.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DexQTaeCzIFFz2BQU88Ewe0aoHUAaKNjlAAo94j6MqLSPb0HoquOCGVC6MoQwbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2679
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=763 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=1 malwarescore=0 bulkscore=0
 cotscore=-2147483648 spamscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150149
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 09:22:25AM -0700, Shakeel Butt wrote:
> On Fri, May 15, 2020 at 1:35 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 15-05-20 16:20:04, Li Zefan wrote:
> > > On 2020/5/15 14:56, Michal Hocko wrote:
> > > > On Thu 14-05-20 15:52:59, Roman Gushchin wrote:
> > [...]
> > > >>> I thought the user should ensure not do this, but now I think it makes sense to just bypass
> > > >>> the interrupt case.
> > > >>
> > > >> I think now it's mostly a legacy of the opt-out kernel memory accounting.
> > > >> Actually we can relax this requirement by forcibly overcommit the memory cgroup
> > > >> if the allocation is happening from the irq context, and punish it afterwards.
> > > >> Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
> > > >> objects from an irq.
> > > >
> > > > I do not think we want to pretend that remote charging from the IRQ
> > > > context is supported. Why don't we simply WARN_ON(in_interrupt()) there?
> > > >
> > >
> > > How about:
> > >
> > > static inline bool memcg_kmem_bypass(void)
> > > {
> > >         if (in_interrupt()) {
> > >                 WARN_ON(current->active_memcg);
> > >                 return true;
> > >         }
> >
> > Why not simply
> >
> >         if (WARN_ON_ONCE(in_interrupt())
> >                 return true;
> >
> > the idea is that we want to catch any __GFP_ACCOUNT user from IRQ
> > context because this just doesn't work and we do not plan to support it
> > for now and foreseeable future.

Actually, why not?
It should be fairly simple, especially after the rework of the slab controller.

> If this is reduced only to active_memcg
> > then we are only getting a partial picture.
> >
> 
> There are SLAB_ACCOUNT kmem caches which do allocations in IRQ context
> (see sk_prot_alloc()), so, either we make charging work in IRQ or no
> warnings at all.

I agree. Actually, there is nothing wrong to warn about, it's just a limitation
of the current accounting implementation.

Thanks!
