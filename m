Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40223F938
	for <lists+cgroups@lfdr.de>; Sat,  8 Aug 2020 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgHHVvj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 Aug 2020 17:51:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57526 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgHHVvi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 8 Aug 2020 17:51:38 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 078LoVuo015561;
        Sat, 8 Aug 2020 14:51:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=shnf3XUgsWxS5mb56nP4OtfUtcLVG0fBIS33PQJ7Yxs=;
 b=J7G/GPP/vEc6PNiadBQK7JaBSYjB6uEZyIFj9QlTkcJMoj96aS62Wu90YrFAS7SUUrOe
 UQsumHCHMs3YhiRAAH8w9eWRLgYphFy5tJP4pXwO1vQx/7ahPYWG+wWMUGSF8gtDILFE
 pTEt514/4GgXz6Koo6C8/iZyK79yB38CTqw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32ssjk1np7-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 08 Aug 2020 14:51:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 8 Aug 2020 14:43:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfJg/5SDpBmbTG+V4LfoAlwFY9uuDtFOCDeor9fYbrvnZGz9uS4nym5HGGYaAlYhwhE4mZJp02XzfPF50RezhSEHKr1PsLWh6BAPL+5VwoDkzunENtxEJlUM6OukX98EiL/RYrZb4SIzh9WqC86x7OwLeoyMJBzP6QIRsLox4jnQK0P9KcGo6yCggDJwTQ+YAbvOzmro59LeGm29lla/uVn+k5Q8h9h4Ms7seO7HNCJSEOmEJoBoQHazws3BjeBD524pxBApfW+n61axMPgU0wxwb4nb4oABgpaeQuGkCOaotrZox6js1IxY/TRfB+HzR8U2xqg20SV73DZBTSgYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shnf3XUgsWxS5mb56nP4OtfUtcLVG0fBIS33PQJ7Yxs=;
 b=KLImhLBZLIFUcpHWFMKr2LQ9Y66MYkX03dnHB2ORA60HsyhHM3OGuRdyqhjp0DNvXQvMnQnzmrT3XsNmKjcqFShGO5ZKdpIlDIwJuU7WduykjJjM2hZhW2XIGXAQbVVII5uDaOnFNaWtbtOh5PcrqtGA35dQ4CSRzwxJF0N0seEG5sI8gl/KdO5MkPbosa+bBwa0hsJa+NpCxeDF0uxQeJDk2xL/sg/2fFHnOZDDFvji5TEfQiNNcobKv0qOwMR+KNmXMpog9BZbT7Ac0chLYD49y8u6Cxjnp1oG/v9KrZhhoe8mt8lAFrsCxggsaNm7MS7zDAoRoDtOzUI2DnWUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shnf3XUgsWxS5mb56nP4OtfUtcLVG0fBIS33PQJ7Yxs=;
 b=SkKAmV3wTQNoFBzbF9n/Y1HlbhVvxJ8FB7lOB4plKtLB28KPffMqzyx6HFV/e5kCeBMlSP8GwtbKQJb+NV7XLWhzXWYLX1jZFWdXfjU/gXh3ZL8VtaKPBMM4OPCOzhDf4AGh1K4J0SC7deAetmoxdLArSNPXYxuZljcNhjOl4wE=
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3952.namprd15.prod.outlook.com
 (2603:10b6:806:8d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 21:43:11 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::197f:d445:824d:1efa]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::197f:d445:824d:1efa%6]) with mapi id 15.20.3261.019; Sat, 8 Aug 2020
 21:43:11 +0000
Date:   Sat, 8 Aug 2020 14:43:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
Message-ID: <20200808214306.GA1409287@carbon.dhcp.thefacebook.com>
References: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200731151655.GB491801@cmpxchg.org>
 <9338716f-ca0e-057f-8d94-03e2b3f70281@linux.alibaba.com>
 <20200803081815.GD5174@dhcp22.suse.cz>
 <bd61e672-b997-c4cd-2047-fca9dc11cc4c@linux.alibaba.com>
 <92dd8e68-8095-72c5-0144-2a084e4d5993@linux.alibaba.com>
 <5622ef68-5e70-d1a9-d1be-b45411b6be5c@linux.alibaba.com>
 <4740bac1-72f6-a640-ab6a-a8801e68c27a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4740bac1-72f6-a640-ab6a-a8801e68c27a@linux.alibaba.com>
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a2b8) by BYAPR03CA0031.namprd03.prod.outlook.com (2603:10b6:a02:a8::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Sat, 8 Aug 2020 21:43:09 +0000
X-Originating-IP: [2620:10d:c090:400::5:a2b8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e17b8cd-3a25-46e9-a694-08d83be40b98
X-MS-TrafficTypeDiagnostic: SA0PR15MB3952:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3952F4B3FD54ABCC32A8F9F2BE460@SA0PR15MB3952.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vY6OM+dFvNJdYV6ZEq4ihnekAMtHh3irqsh7V1dDqR3GIjHZ3pakqvKgenJGTN5r+NMnxGCA4DSROqMdSnltAale+O9NOtYoWda2/TCkaBmItwkB2R8ndHPtDbDWN6OgDj+NYK0AVITAxyMh//6dChBB/22Oa+2MWK4+6s/u6qR8QcW6pBPorM/a74qDNYknzq4dkRXaoFm0hN6uuC5MwXozWiTSuLumPsYK9SmtJJGsafhX0HFB0eUEw/hlNArZ7toKygYsGhQjZOiNCc3YZYs7BJ5idlXV3JjOYgQ3HiPbFj7sej/fWWACmlKMNOLwyK/HX2Q3mspahw4XbBWoYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39860400002)(396003)(136003)(346002)(16526019)(186003)(6916009)(316002)(2906002)(66946007)(66476007)(5660300002)(8936002)(478600001)(66556008)(54906003)(83380400001)(52116002)(55016002)(33656002)(6666004)(7696005)(86362001)(8676002)(53546011)(1076003)(9686003)(6506007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Doo6V85qf02dtQ4HVz///kuqFHmRmqnBSyRTCojcm5IROT2eCqrgVqyuOSaPvP53Rl0a7XAlcskFpOWXyMWO4ekcKkuVEdICxhHrmwltCdReijDwYF/RqlR3Vbh3F7npZ1cK/Nhc7xoImvGId2FnSwZSsqz/ZSuH2Szhxd6uyYn51vnHoNavQwzJlCWCXqKc0440VH6A1j5mxEnnHrKcyXcbR012V9VP9FC3x8lif9VtXOz3Ol9V/ZPKF+0XwJDyz6b/wddT+CJryRwVvGuds+b3xwQn0TgH+Yw35kUiqtorrWLB2HjbhGcz1gfxzRyTHpiisWchr/R7N0sdy8wFMNewzb5GnOoE7KRjDjXeFbLTFabOlpz6P7gWshtipxfg3x1hpS5EZJ4YxCvPiXGFYfTQcqcj52N+4mn/g7PqWJZjtL3A+6ZjqVrSEg0bHDlZkWGiKs7moDKq308yVjC5oMroXpr/pTcN/dF5Cseg2FUkH1R6bzw4bl8I0lFCZMSM0Vz4YAV1wZ7/PRJl5vT43htQnVaHzlVZnlzG+P69PIc0L0Er3EQ1xKVtYt//kgsvmrJH6+D7wDjW4I+uImPoj48ILFHLer67rkCLK/P0ggFiNqgOeE7B49+WDk3PEEKBnaLhFonWRTeuLt87rJsiHLgIUOlZXwJnnETk36Pg48c=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e17b8cd-3a25-46e9-a694-08d83be40b98
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2020 21:43:10.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qZJEKxkxpIhy2e4yro6JK7Or8oasAm8Owgrq3MHpsn2l+Y/GFHMUMv9c6t48E0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-08_15:2020-08-06,2020-08-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 phishscore=0 suspectscore=1 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008080167
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Aug 08, 2020 at 09:22:29PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/8/5 下午9:02, Alex Shi 写道:
> > 
> > 
> > 在 2020/8/5 下午8:28, Alex Shi 写道:
> >> The last patch has a problem on define. this version could fix it.
> >>
> >> BTW, I see some !memcg happens when MEMCG compilered but disabled by cgroup_disable
> >>
> >>
> >> [   94.657666] ---[ end trace f1f34bfc3b32ed2f ]---
> >> [   95.138995] anon flags: 0x5005b48008000d(locked|uptodate|dirty|swapbacked)
> >> [   95.146220] raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
> >> [   95.154549] raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
> >> [   95.162876] page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
> >>
> >>
> > 
> > The following patch may helpful.
> 
> Any comments for the 2 patches?
> 
> Thanks
> Alex
> 
> > 
> > From 8bfb26a2e37e08dc61d20212bcfa5812a367ba94 Mon Sep 17 00:00:00 2001
> > From: Alex Shi <alex.shi@linux.alibaba.com>
> > Date: Wed, 5 Aug 2020 20:32:12 +0800
> > Subject: [PATCH] mm/memcg: don't try charge swap if memcg disabled
> > 
> > If we disabled memcg by cgroup_disable=memory, the swap charges are
> > still called. Let's return from the funcs earlier and keep WARN_ON
> > monitor.
> > 
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: cgroups@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/memcontrol.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index cb07a48d53aa..65f2b42d25af 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7163,6 +7163,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
> >  	VM_BUG_ON_PAGE(PageLRU(page), page);
> >  	VM_BUG_ON_PAGE(page_count(page), page);
> >  
> > +	if (mem_cgroup_disabled())
> > +		return;
> > +
> >  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >  		return;
> >  
> > @@ -7228,6 +7231,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> >  	struct mem_cgroup *memcg;
> >  	unsigned short oldid;
> >  
> > +	if (mem_cgroup_disabled())
> > +		return 0;
> > +
> >  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >  		return 0;
> >  
> > 


Hi Alex,

this patch looks good to me. Please, feel free to add
Reviewed-by: Roman Gushchin <guro@fb.com>

What's the second patch?

Thanks!

