Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E56333233
	for <lists+cgroups@lfdr.de>; Wed, 10 Mar 2021 01:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCJAOO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 19:14:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59556 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhCJAOB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Mar 2021 19:14:01 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A058wX005276;
        Tue, 9 Mar 2021 16:13:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ujkvm2nAZ7bhInatZ2ieQWioqdcNWNp1J22DUEpB7hk=;
 b=o0Y2V44fTAoWgJ+YiNxaavdmjUnAiI/H6V6ALJwebXd9qbrbqTMQl3oYua0iv3o8lgmS
 hQwM3tqPFayv28lVJGS97n2IQ7bIQW9U15C2iP1H+uXO8ainLaoWSf64eMo3EZovl/VW
 s4nu0MQQqU27Gzl6pd+ybPZevpu7GB2CMYU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3761q8dg9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Mar 2021 16:13:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Mar 2021 16:13:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCAqCnbmDXZTor4zSi8+w2JGAWZ9C8MJpGlQKg/trNKDILmGf2h/8Nb/+vdyXMRh1sA64S+sCbHp7G9spHvzf6+4Pvuh1idlIxyZf0Fdmp7YJ4C4DsVKWo5c2jnpAeu62LuKclhKzVJQ6qtTTysaJbLdC7L7b6ioyxZqPTl0pLMlCIgYlhOsP+ZDL/I+w1DLz/5lk0cv1M6oO8Uuhskwuezc8UP73yHa51gpIPdaqwRXLyiMTYBh99b/0dmLsPrQIHMbTDhF52CV+TxjntUwWGibIFkQ/ka3+fU+fdMq60NNCLfeQ+RE8rSca929g3JjVPWDz2K8OrPDwEx5n21IoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ujkvm2nAZ7bhInatZ2ieQWioqdcNWNp1J22DUEpB7hk=;
 b=MX+65fPP4e7V7XKNfla+/ehvJqYIw4w6tq4SmCxR4MLJYfsNBWDG7KPh0U9lmHoosZN49JtxgZ6HR243dH5jF8Jbh7+2QN0KX4E3fWgHhFYAsTapfnAKIJE+dCZ8rx3/vBCK1GS+JPWm9WnAtmevpUxx4FjA2sqidWnfmO6mrvZoa7pCQakTxRI8Y/i3Of8Nk3WGiW4XWflmKQuIT01wxrl4Nwgip4jCyT1SQ8ezVUG7soLILfKsf9RLwQIsrV36kNCuvk+fU1TlPIkjMPf0xIGIylNvBhQDrHuw/O6v2Mli7ZExriuccgzlTijs6kCv1Vot7bUt38FS3b+KOqTVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4630.namprd15.prod.outlook.com (2603:10b6:a03:37b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 00:13:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 00:13:53 +0000
Date:   Tue, 9 Mar 2021 16:13:48 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 2/9] memcg: accounting for fib6_nodes cache
Message-ID: <YEgPPLYHnaphsB7V@carbon.dhcp.thefacebook.com>
References: <f105248d-bd21-8e6f-bdac-4f2c4792fc4b@virtuozzo.com>
 <CALvZod5QnzwpKwGqCYDKMUpHgPcvtS99go+u34NYGKaWsr0UAA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALvZod5QnzwpKwGqCYDKMUpHgPcvtS99go+u34NYGKaWsr0UAA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:389f]
X-ClientProxiedBy: CO2PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:102:1::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:389f) by CO2PR04CA0062.namprd04.prod.outlook.com (2603:10b6:102:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 00:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7cc89a6-bffb-40a4-296a-08d8e3596367
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4630:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB46307D0B892EE427993A58D7BE919@SJ0PR15MB4630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmeiJzZ0bRvxmBUhd4do6ifKS8ItILu41bvNti/0nrYd+gWWBVaIUyW3j/89I8U5YpQ/IeetU1EHE87ndNXH3qISG090QcSAkThqo3sBjwnoS+Gz4Hw5HpcmYRD7CMDSlfOywuAe3kJXs1xvAVhAWdwKbdwFvK8JbHS1kLAXnY1oXtGKti5ZqN39iVkO2mM5tacL3Bd9Z1MfV2CMnYbM/Iy/6GxrRJo25Qhv+S+eo2N2xbQAn4pl72aQ8egSfG3XShPu066LA3VucZhbp2jeG/RiVx8ohV0uMxJPqtLv5u07rQ/Zd/XQ8sYsFu6Z3rHVrYdUShiaZoDnSQSJDX3+tuPQV43Xzm4APSyjABUnz2oZuyrroLUbwRGoHHJywDyyv9ILm/3rfPmX59840gQwk09Lc9dhDa+oCdfwCdV2vGkZXS6OH55Q/btPPMz90T+qrW9QZ63tDWAFyN2vYO+d1TV2rMBhilaA/bHSlGLIQm9pt9ypYnv31SC04VHcinse7qpCfflOAoppEUOr40bVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(52116002)(7696005)(8676002)(53546011)(4326008)(186003)(6916009)(66556008)(478600001)(54906003)(4744005)(6506007)(16526019)(66476007)(316002)(9686003)(5660300002)(86362001)(66946007)(8936002)(55016002)(83380400001)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mc/YYKFwIRa6UvaSgg3vyOCG7E0X1fDP7JDWvp8Rsnq6FnfTpbLeFwKQBK79?=
 =?us-ascii?Q?B0dEcdrtrtWvr4QxMZf1rl+6uBKe8TP6Vpp/vs0gSTSw+cB7ybTyCoznVofF?=
 =?us-ascii?Q?9VoMzvppBhKiCzeGHioNOkjg+JaAUwfYa+rgXt7TrcRAmuSPoZzPGUePTznk?=
 =?us-ascii?Q?fouC9t3391vp53ESzLxn4pKPXVySr8jND/ZYzlMz1QsJAuA0XwGNosa/KcUw?=
 =?us-ascii?Q?di/f40IJR1mS5oZcrub1SAMwWX0ByYLGtlecNyhMk08Akg5+zlIPKtEZWVur?=
 =?us-ascii?Q?X12SpLQhgBMACNw/3b6eq9risoo7agP/XW+4rylKQntcPCXNSeHLSD8aJluX?=
 =?us-ascii?Q?iKonWEeKKENoiPM6b8TufiuGJDfXvBkW55olHyf/49SFhGIOC6tAyY8G2hzD?=
 =?us-ascii?Q?/TuIeSOmlrgIqPUdBMpy847t9vLX2P8JYnLT6Rpi7vp8xE2t6ozBS68qNanF?=
 =?us-ascii?Q?txKLS+/hn7MVyWjKWZUbc5no/DvNESx93mfJ4o1Ejx/fDF86jkcXa5H7F+rQ?=
 =?us-ascii?Q?Uy6ih6Nk2wgEAQfuo7TV35nQCbJ5hASwSCPEa/GMjohQURh6bEifaaTZPLZD?=
 =?us-ascii?Q?wf625Z1Q5F3sURusxTFINrc+Ut3DioHn5ZO/Obm0caLsh8uodFte9Bzpt8fv?=
 =?us-ascii?Q?a8LDGP4FZQsCQPkv0y80ID/ZrPXFI6arsWv+VXt0fqPhTEkNCa5IHVMs8aWP?=
 =?us-ascii?Q?BWZz/g6/ZvazvmyxbYbvydwIymnfEHpIURQK13Tr97+DpjjhZG8Y+fgLdfQP?=
 =?us-ascii?Q?Gxjlyv32gohP6XmxS01lzFNUSQ7JN+mG4LwG4gUG3oB9j/kTuG//T+F/eWQa?=
 =?us-ascii?Q?EfB43GLGIcGJJC1f0CMFnssE/S9bna5aZDtSdLQKuey5LYKC46qYal2/em7r?=
 =?us-ascii?Q?S0zeX8/zRG+GvwMOS0pw6OgTujT69GKZ/2mwjgC7oZOk2gzX58cIhsheS9Ep?=
 =?us-ascii?Q?ShbycJIpk1dy2et3fNaYe6673CQrUMeEkc1CTgasro7DpamNP4bi02bDMb9U?=
 =?us-ascii?Q?c4FiL64TWXr4XSRz3hL1uu2VEkhfRl3ZcFrhupxsiMqnywQUcD+nAEnSm2aH?=
 =?us-ascii?Q?6edkGR7PoLMJfkT9BJpa8TlB6g1p8tCSG0VntjlsPK8V5MBxO3/WFmUIBG4k?=
 =?us-ascii?Q?/1yfnwgbzKkdRWLZ5Y5OFfBnJWfRH2U5CZsjZFe755bWLNuwHdQzCHzPPRv4?=
 =?us-ascii?Q?tg4o+1ufzEEbJ/BXeYtryX2W+DlTxAl+Od5zFyrUnN2Y80qKxwqoBUyGmymV?=
 =?us-ascii?Q?JI4u+Cjjv3w41I8zs+lsdlMu0GbW7VZ2ChYZbO7uArjsjgSyj0Ogwoqcoj/a?=
 =?us-ascii?Q?UBgL1Fz9cyd3/z1Ct2i74WlMkzO3MNSOzRzYVrM9W2/6bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cc89a6-bffb-40a4-296a-08d8e3596367
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 00:13:53.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIL/ojosTjKHNMYyHoZY6MWTkGc9JawJ9zpz7v7D7mxEOqRopve946/QhWXlzy7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_20:2021-03-09,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 09, 2021 at 01:16:13PM -0800, Shakeel Butt wrote:
> On Tue, Mar 9, 2021 at 12:04 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >
> > Objects can be created from memcg-limited tasks
> > but its misuse may lead to host OOM.
> >
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> > ---
> >  net/ipv6/ip6_fib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index ef9d022..fa92ed1 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -2445,7 +2445,7 @@ int __init fib6_init(void)
> >
> >         fib6_node_kmem = kmem_cache_create("fib6_nodes",
> 
> Can you talk a bit more about the lifetime of the object created from
> this kmem cache? Also who and what operation can trigger allocation?

The lifetime is less of a concern since we have a slab reparenting mechanism,
unless it's a very short-living object.
