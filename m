Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891692CF697
	for <lists+cgroups@lfdr.de>; Fri,  4 Dec 2020 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLDWI7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Dec 2020 17:08:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1936 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLDWI7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Dec 2020 17:08:59 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4M0BtF005024;
        Fri, 4 Dec 2020 14:08:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xCuMDqKmf4r3RjVCZ2F0m5yMJtln7l6L8DwWpETl2Io=;
 b=OOF7DKvNZ8R8DHyZgHToP3x+DLMyPqteSVnnzaEZlB4+Z/FBrw+ZggS3FvQY9XSdRLof
 8lB9n0lkDGRuMS57uDKAlrq+SaTeC2auN0me+O7G33c/FgZ5Y6JvJTqcUZ49094Nl1zu
 9ptRHsqedhwgR59uGPvcdU65mJQ1da4Z08s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 357c7v6d4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Dec 2020 14:08:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 14:08:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/gHGsg0HImNtSgsM4lxTliCd/N+8Z1aAtjLYDhgQGWUXMWTlIsVsmFRfZOnbnVfBJsyvtEf4K4Fw2c/+xw2+spZU4vs68VzEBORw7HHWszmuW5p1FjUaFNRAOPlzVUyYzFqW2xiL4vBTXTc8IIdg7/dXWpPieUwsGMjwdsgKUrYlaW0lYUCJ09pjsJmIakS+PTKnK4GigqBL5bvVC4yHpINMknZtTfx2nGPcvWVTTHCrOytiyTySwtvYoOf0jzjf4jRU3510zVdfFVUZYL86NzoiySDaaCValTWHpwWbj7GfJAEo9o33VlUaNe+z3HNnFEzPXwUpDdNAhjBPYGy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCuMDqKmf4r3RjVCZ2F0m5yMJtln7l6L8DwWpETl2Io=;
 b=YoUioWOiPeNHaqO0pYfkCVYwOWr2BNegb4kfrXAHrdGFAFhCjPjv2QiZmWtCPLtkLs0DJD2RGbol7HK5USNr/l9PQcb0x69PqaLChOyYrGL4mXQX/5sjETNxrKjs3nb2SB6TmVN99Ow4RIaGaJN9L4cmRyZaUqqCRm9zM8hNGMq7yrztfzIozymmbL1BCFihpcpR1810Tx6ZoIgZ2kWVJkVJmrBJcD2WCnnodl0B12kHJ7R2frvkQ+x6L6Tgih6fu556a3+li4aRHKY8+ZMGVS9LMNsYgGNeOWK5JhOD8/6h8Gm3UzXCYqdT0SoYGAbsqPqmTJPDOV9AF1uS5r7RbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCuMDqKmf4r3RjVCZ2F0m5yMJtln7l6L8DwWpETl2Io=;
 b=PuKiMuotcRiKWBHpSVC+vJD+J26B7RC+7kTXI2UJARhk+f+kAo7BfA34yZmCe40XK/wMi5ZboHC2REDuJMDcN+NS0r22kohTqGk70nYtFs3qNKBFmh/TiUIUwNmXDFPCsnjtk76Iqk5x4rbjM/0E2VVVJOJSlAPeTPg/TDy2dpg=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 22:08:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 22:08:09 +0000
Date:   Fri, 4 Dec 2020 14:08:04 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Muchun Song <songmuchun@bytedance.com>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/memcontrol: make the slab calculation consistent
Message-ID: <20201204220804.GA1772002@carbon.DHCP.thefacebook.com>
References: <20201203031111.3187-1-songmuchun@bytedance.com>
 <20201204154613.GA176901@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204154613.GA176901@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:6638]
X-ClientProxiedBy: MWHPR2201CA0039.namprd22.prod.outlook.com
 (2603:10b6:301:16::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6638) by MWHPR2201CA0039.namprd22.prod.outlook.com (2603:10b6:301:16::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 22:08:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1108504-5263-44ef-b320-08d898a115b4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2630A546614C8F5D7AEDAFC9BEF10@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6A+JxtMd1n3uY/LxgMI+71EryKuVQfz5qxvX/gACVNafQSGu+O2LDttTdZvJ+D284UWaC/RryLbKpZVpKb/j5nVMM8Ed9cmtTm/JpXQCNIfAbloAXRWkzAO3Vo+m5Ou3863GRGkX9HkJlaPE5E6Qw0DJxJt4kf/E5NioeVihLCdWYhKAXeLxb4WVgh8T5HJQhI7ZJepj0Bzm1iNuxQMz9Q5RlQnW2Y/1X1pC4Z+Yruggr146krMxxq4AYMoQuztGHuAUaGblWJ1S/6I2MbtaWixZJmGQXEpFSXjLTZ2KzQpL0HG3ahHsLJY5RWfQN1AYbW2dzDjjJPriAQlW5yaMFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(52116002)(6506007)(16526019)(4326008)(6916009)(7696005)(2906002)(5660300002)(9686003)(478600001)(1076003)(316002)(55016002)(6666004)(8936002)(66946007)(83380400001)(186003)(66556008)(86362001)(8676002)(66476007)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xf/9e1ksZ3w2qlZdgGdnbxgdApNPhmmceF6xgiWK6rrL2n8ikvhprqFGlgFr?=
 =?us-ascii?Q?m/BriXWdUIfoFRsT9HoK3c7LkMAZL6SMUZbfjNr8GKf5WYQrX8872irW6yWi?=
 =?us-ascii?Q?qohUriQLhl200prvaIB/TWW5GD7SVdYuREkFlH2Ozm/o2MHIxDOP3vU1Hkmh?=
 =?us-ascii?Q?dbGJWpPC4nIawzAuiNIBbwypyIsBz6P/RB+BcU2/tzarhejLSZQ13ViLKGyy?=
 =?us-ascii?Q?QNef51xKTz4jEoDNwm7iEF9BGW6RuZ7UZJIC2WM8bW2BJX8me3JoDh/74ACl?=
 =?us-ascii?Q?62smUWhLeDuRn1dINWbqcbW1pE0ASxxcYlrLivd/zd7PdbyNDAYy5eIyGbMA?=
 =?us-ascii?Q?HcxvXC9wNkQYnSHJnFoBFUKlzd5qv3L40+mLhI+QvPodfQHRjKAcss34fNby?=
 =?us-ascii?Q?BWBHpi3r2GQorofxqY9ew7OmqQ465vzva9Eow7OlHzYQvRMoFAy/JXeyXc0F?=
 =?us-ascii?Q?RNdx7ilTJMZngxecmr57Jmg1XODJ8kGo6yKLau4WfNvZ8n6x21tYchhFOjKg?=
 =?us-ascii?Q?eW4Ak0zZ8YxvgPtASIHOcja0vDu9A2JPgwee634kLQgad9+r12S8OtiD4zXo?=
 =?us-ascii?Q?b1t5CPIKDlPJKeh6pHUo3NtFTiIj7uas7vr7Nc+FDUeWnFuM+hQVEC+clPw0?=
 =?us-ascii?Q?39svFjfVqJRsskTT3Sh1/SuQjLHFfx5qVxZW3ZtbJ2lViz+3wQFL5bz7n0Pq?=
 =?us-ascii?Q?azpM+HPpkM8yWBOHLDc8BvbIj8MIiBoZkezt+3G2jPwSgjt8qamgbXTpenZ+?=
 =?us-ascii?Q?LsOdFdHFrRiR3M0azIxQ20AhM7AYk/SdhTiMR7dhsibdWy0nVK+Fht2ymeQr?=
 =?us-ascii?Q?O6OlG8+jfZvMJ4jcDqtaMdUNhSUaoLTURlbN0GlC10dLBNZstJr6cWjN5KJ7?=
 =?us-ascii?Q?43xx394XH981mH6MPx5+g0kV8W9BBf5Eg/Jct9578uEEmJmDcp+7PDn0pkE8?=
 =?us-ascii?Q?u5aAocIU8rIF/xdsZBiCzr/kNGXvTcxE+0clC1id/IL1iSa9tDmf5KAtwIFo?=
 =?us-ascii?Q?ccZ5ywmA2RcVNflhN8gX2tSQfA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1108504-5263-44ef-b320-08d898a115b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 22:08:09.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmnu1OFZmwHSEF49aEi9Ejfxtf0vi2iP90kTtVv6WVbxnTxnwU/feorQb80WAiwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_12:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 04, 2020 at 10:46:13AM -0500, Johannes Weiner wrote:
> On Thu, Dec 03, 2020 at 11:11:11AM +0800, Muchun Song wrote:
> > Although the ratio of the slab is one, we also should read the ratio
> > from the related memory_stats instead of hard-coding. And the local
> > variable of size is already the value of slab_unreclaimable. So we
> > do not need to read again. Simplify the code here.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> 
> I agree that ignoring the ratio right now is not very pretty, but
> 
> 		size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> 		       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> 		seq_buf_printf(&s, "slab %llu\n", size);
> 
> is way easier to understand and more robust than using idx and idx + 1
> and then requiring a series of BUG_ONs to ensure these two items are
> actually adjacent and in the right order.
> 
> There is a redundant call to memcg_page_state(), granted, but that
> function is extremely cheap compared with e.g. seq_buf_printf().
> 
> >  mm/memcontrol.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> IMO this really just complicates the code with little discernible
> upside. It's going to be a NAK from me, unfortunately.
> 
> 
> In retrospect, I think that memory_stats[] table was a mistake. It
> would probably be easier to implement this using a wrapper for
> memcg_page_state() that has a big switch() for unit
> conversion. Something like this:

+1

> 
> /* Translate stat items to the correct unit for memory.stat output */
> static unsigned long memcg_page_state_output(memcg, item)
> {
> 	unsigned long value = memcg_page_state(memcg, item);
> 	int unit = PAGE_SIZE;
> 
> 	switch (item) {
> 	case NR_SLAB_RECLAIMABLE_B:
> 	case NR_SLAB_UNRECLAIMABLE_B:
> 	case WORKINGSET_REFAULT_ANON:
> 	case WORKINGSET_REFAULT_FILE:
> 	case WORKINGSET_ACTIVATE_ANON:
> 	case WORKINGSET_ACTIVATE_FILE:
> 	case WORKINGSET_RESTORE_ANON:
> 	case WORKINGSET_RESTORE_FILE:
> 	case MEMCG_PERCPU_B:
> 		unit = 1;
> 		break;
> 	case NR_SHMEM_THPS:
> 	case NR_FILE_THPS:
> 	case NR_ANON_THPS:
> 		unit = HPAGE_PMD_SIZE;
> 		break;
             ^^^^^^^^^^^^
These can be easily converted to ordinary pages,
so we can completely avoid this exception.

> 	case NR_KERNEL_STACK_KB:
> 		unit = 1024;
> 		break;
> 	}

And NR_KERNEL_STACK_KB can be converted to bytes.

Then we'll have everything kernel-related in bytes and
everything userspace-related in PAGE_SIZE's.

> 	
> 	return value * unit;
> }
> 
> This would fix the ratio inconsistency, get rid of the awkward mix of
> static and runtime initialization of the table, is probably about the
> same amount of code, but simpler and more obvious overall.

+1
