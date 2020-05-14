Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBAE1D4155
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 00:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgENWyF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 May 2020 18:54:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53210 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgENWyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 May 2020 18:54:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04EMoHiG031938;
        Thu, 14 May 2020 15:53:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HGw90od6mcudMqWqfdvgQX2jvVOafuIk0BIBifNjZsE=;
 b=Y+IdxBmhxSBRzxMCrjis8PnkSc80DZNztulzqbrABYnMuGD8JJgAPrToFCKPn72N3B1U
 6Y7ESH5AoYGMGQX3RNxz5PuDYbgrWTtQjElVNNdRTqupK4K8NHAEDCCIeJlpZKt4dziz
 rXEsoN6KLZaHcvVSTkeRjWRdh5th7tHVrTo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3100xhefnb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 15:53:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 15:53:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE3DScgmPomR1dY96hBq/vE4kefi33Ix3mPUu+Z5xfoc3gvsozsuk/gxwMfgXa9zb771aSJLKo1F795W9P13zWnYoUE2nzm7vbc7rXGraUz1yH1XXj1Z+Y+ioBwWSSXaels+LhtEceoJP48MugJdVkGFVctv+ppfSpFhy3D2xaYnPXgHlDqirJWBpRG1/WCGOR9yOguexoBOpIr+L6MOQJQg2LaZz+rwHmEMPcSjxfQdOUODnJBP1m9hX/V5sQVT51M1OmlBjuvesFJKRnQ/OihCDira/2mACSC6/oe9PLPAvza7RNlHSg28Wsf2Oi7N3axIVCSyKuCrKXujeOl/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGw90od6mcudMqWqfdvgQX2jvVOafuIk0BIBifNjZsE=;
 b=TbxeHdEA4Se3SZmihsFqbHRtO2bttWP7DYUM12t96sh/ulpDKOpPaeHc1zBdRiJY1KLKRpivKemWLdR4IibUZCh/c68AzsDckDf1PZiwpSZXAMeeD9dUSLvbHNchc+kAdpur746WFIjFVkEbf/mqXh58KZWqnX02CXRk/XWeQxcTtXkb9W0olK+okAsiv2N2te0zB3R+N5cB/0g6k4+UoXAMLltTeNiVgmcgZHLT//rifQyTv90mCkTgaCkK94oey3MMW7QsuPm9llfwv0qCqpvu9x0j5eYa1X+uVmSGEwsdNOpJyGbG0LtlptvdtB7uy8xNIXuC7KsUJLOOZW8ejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGw90od6mcudMqWqfdvgQX2jvVOafuIk0BIBifNjZsE=;
 b=kGpWVEtPyzv884SGU88/0NCHqWNb5GnIXJIgZfiEnQy+rcSNUwrXR1K9zed7uuwI8L0TZkmsc+6YZMPwyyy4SvV9+VSg1aQu2Wvezx+OcNIJEMhSt6L9VNNmUxd/gp/Umir6enuD/FEot8B9gRZe1oKbSr/ITMXOLw6fqlDiTw8=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2533.namprd15.prod.outlook.com (2603:10b6:a03:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 22:53:02 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 22:53:02 +0000
Date:   Thu, 14 May 2020 15:52:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zefan Li <lizefan@huawei.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
 <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3924) by BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.10 via Frontend Transport; Thu, 14 May 2020 22:53:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:3924]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66df402f-f937-4f17-ac75-08d7f8598e99
X-MS-TrafficTypeDiagnostic: BYAPR15MB2533:
X-Microsoft-Antispam-PRVS: <BYAPR15MB25337393986D4D3F8A6F8DAFBEBC0@BYAPR15MB2533.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8z1ykxqhEo8TJnGnhkgrqFAGaha9zO38Gt0yC5+DejVfMLtahqlkYhzle/Y3SUYi1qJMOSGaxcllWanGXD4Zv2r8S+Fj7VSWM20EYRxerOZmuAy2loZ8pxUfWLYX+J/1Y49+NhnJXfICp2gLOESG8KhhB+V4FsIW4OWFGs9ZLUPXQkxj2TUFBOXeYhhg2Z6NrOT1YDT5TRi+dZeLFLpQqJzsJqpgKKzxBlf+b83xil89ksoLaqxyP6oXA3xU8T4zzNF0iB3IyxT37cwWFtiovwr0CYD2s9Kqnd8zoN2GsCKrNf4SJqZ4HrRMvBSIVzyQoofidC8xjGWmt3u0JEfW0Xk3mHFH5jWhfQQp4ho00IKxT9802lQnFtJF9v78ExYzwtiyRbLKZnLRZvKTmC9zVzkrCRGhbf3zdiOK6GoMIvfgVMNvFsvDMUIqxyaK6Pqf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(55016002)(4326008)(53546011)(33656002)(316002)(9686003)(54906003)(6916009)(6506007)(7696005)(186003)(16526019)(52116002)(86362001)(6666004)(66946007)(5660300002)(1076003)(2906002)(478600001)(8676002)(66476007)(66556008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Br9e4J3hLStIq3bTmYxg7HuK6qSLOD8M2T+9cWxfyAuIbk3czxkUrawu0VjINZLdd+nWkCB2YQPb8ypVeYudlNqGXKcBFngkkR8IziOSqKc6Dht5DImQPHTcfdk22T3pA+9JyN3KYtADVe/kK11YHAuy0s3rUCOumdbeau65fKLwx0IXVXKxXYd/Tp1lLOvRK4jTDaGZUZviGw/INcaxDH9n554Zc+wHCtLXTad+34hoh7i3QOnl2fj81W6EW4LilvWlV1PNAFaCRRw7MlcmSme//r3bH7ec7oR1Bx1auzyNYRrcU/AjJLBSS4ifBpC0QcDKUPJRzzDtsApzQwIh7adn5Lnxbba8P7fCCOiM1Z598ejCrbLqDmvVKyxZdKAm0QaYlBUSHZ4/dvs6Qt4Rj6suYFdniyPAkxAvBTvFOLkyImC9+HcWRAS37ReJbbPDjbCCUSTh05GY688jRjFSDz0YrgFhUyuIZGAL3RMj6MQ+EvU15ZAbp69GoON4imXldUaPVm7X+ELY6MiTtSkKRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df402f-f937-4f17-ac75-08d7f8598e99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 22:53:02.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJigZkOblaL90fwsTvKPxlFgFZSCGpZpoi3JD/nbDA4yD8Js37QBhIxF3Xl4A311
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2533
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_08:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=1 mlxlogscore=999 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140197
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 14, 2020 at 09:16:29AM +0800, Zefan Li wrote:
> On 2020/5/14 0:11, Roman Gushchin wrote:
> > On Wed, May 13, 2020 at 07:47:49PM +0800, Zefan Li wrote:
> >> While trying to use remote memcg charging in an out-of-tree kernel module
> >> I found it's not working, because the current thread is a workqueue thread.
> >>
> >> As we will probably encounter this issue in the future as the users of
> >> memalloc_use_memcg() grow, it's better we fix it now.
> >>
> >> Signed-off-by: Zefan Li <lizefan@huawei.com>
> >> ---
> >>
> >> v2: add a comment as sugguested by Michal. and add changelog to explain why
> >> upstream kernel needs this fix.
> >>
> >> ---
> >>
> >>  mm/memcontrol.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index a3b97f1..43a12ed 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
> >>  
> >>  static inline bool memcg_kmem_bypass(void)
> >>  {
> >> +	/* Allow remote memcg charging in kthread contexts. */
> >> +	if (unlikely(current->active_memcg))
> >> +		return false;
> >>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> >>  		return true;
> > 
> > Shakeel is right about interrupts. How about something like this?
> > 
> > static inline bool memcg_kmem_bypass(void)
> > {
> > 	if (in_interrupt())
> > 		return true;
> > 
> > 	if ((!current->mm || current->flags & PF_KTHREAD) && !current->active_memcg)
> > 		return true;
> > 
> > 	return false;
> > }
> > 
> 
> I thought the user should ensure not do this, but now I think it makes sense to just bypass
> the interrupt case.

I think now it's mostly a legacy of the opt-out kernel memory accounting.
Actually we can relax this requirement by forcibly overcommit the memory cgroup
if the allocation is happening from the irq context, and punish it afterwards.
Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
objects from an irq.

Will you send a v3?

Thanks!
