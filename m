Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCB29DBE6
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 01:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390499AbgJ2ARn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 20:17:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390722AbgJ2ARO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 20:17:14 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T0ArCr003722;
        Wed, 28 Oct 2020 17:16:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Wezy4DYR5kvzfw0GSzM0X3/leEpFzBtL5X/O9Zeyxko=;
 b=SscM3TDBZWuMkz3Obak3AvOpVvnXdSXywpBNgsYMkW6aX+DM9J7mEfavbwsH7vbEunlL
 XXsaSGObuAIkpfLRKp6Yuv07cRQgN3IhDQC/B9ZPt/s3PvkpKBDxbNUCkVoF0br8IJNp
 v03AR9ZsN9NQf2Cxv9w0EeVU3o6hiQURASc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34f7a6m5s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Oct 2020 17:16:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 28 Oct 2020 17:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTVwyfjETaJWZvqVhHuz0pxd5FgczQvHh7Vvw7DVOAsqewwD4+21atdpJeHfvXgRcdHuBQpGEQ9yMgms+c0maqycf7s3rTiAAXqgcFW95UPKyElAHU/4OJAnfi3Mrb8rvMBznJwqvl2XshoEspe1zpBD8diPcqJxNKSkG0JMxjVxknusa1UXhQqE/8fKMr4r6k/q7UA0OCyRpNeUW8wW+D4I2gkRo88dME/VZH+jVxWpudlKK2oQOvWJE0gLTIlNX2NgvKRWBzEgag5cEdlxOXRFQ17/+NG6fbzoAK87ETYBM3F79xaS+/zG3bphSZvdxDpd3SXznsBqs5IEzTMSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wezy4DYR5kvzfw0GSzM0X3/leEpFzBtL5X/O9Zeyxko=;
 b=a6+DevktJdtg2DMYLEQw7C0EopMtTzsa84qxwfw3uzz3zl0z7yiu2gt6a6ExCSsrducQ6H+r9+TTaoj0sEOM4+iPCt48n3uZJWn2aD1Pq0KDXPs0hzxw8UpubMTm/v1kYWfgYlK6bWaZ5Vg53JscLYrBvXEhgkwogyxovvAGL/PhssuM3K8rFHri+tViXHwD+P5vGsvgxXqAHmoUOcSqdHvl2ZctlNXy2/AfASo8d6kZ/jkaZvdqCLMUqLjPeVK3yeuPOuQdVTD4dOVFM2h0OzkWgbv81k2/SeswKby0a5JFHbKOJR1hlal0hNnzUyMCrwwY07ZjjvDQ88uZ7oqVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wezy4DYR5kvzfw0GSzM0X3/leEpFzBtL5X/O9Zeyxko=;
 b=WYpHDni9tTu12RxILlCuUr01baxJbhEhVyEefgaKu8mCB+4aZuEQeGi+msyX9/DndLCTnmsqslWCebFiO2TMMNiOkp5dLizqobX+bKQhfDM4eejkX3oI1ln8Rzy/4JBMGo9Kv7Fgheyc83adHa7hRtPWLxCndKtEdUK+h3MZS3s=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2486.namprd15.prod.outlook.com (2603:10b6:a02:84::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 29 Oct
 2020 00:16:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 00:16:39 +0000
Date:   Wed, 28 Oct 2020 17:16:35 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <iamjoonsoo.kim@lge.com>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <mingo@kernel.org>, <keescook@chromium.org>, <tglx@linutronix.de>,
        <esyr@redhat.com>, <surenb@google.com>, <areber@redhat.com>,
        <elver@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root
 memcg
Message-ID: <20201029001635.GG827280@carbon.dhcp.thefacebook.com>
References: <20201028035013.99711-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028035013.99711-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::4:cadf]
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:cadf) by BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 29 Oct 2020 00:16:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfcc79a1-fe17-4d35-57f5-08d87b9fe7cc
X-MS-TrafficTypeDiagnostic: BYAPR15MB2486:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2486C646095F9A36F59E07A6BE140@BYAPR15MB2486.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDFLtyVTGCnVIYEqqAgxOxhb6uXdr5RXmfsDOlF0C57ywlcSA331tsQxgz03WNsnQeCwQ3c5yWk5VMvGomXWxBUJmGRdzdsJeoteTBenAzwyRId9ZWPbcm6Jxb9Eqv/EYhwJ4xu+wYmU944ABfBQp6BIPIjv2FEqMA69ueNnY5hY+wJqMRAExYZ80G10k7z4WpWdqGwBmatuy7WF0CBt2P7DjfdxGQUuCEvm6nFo4OeK5YsGHeahukCiRtFmWVP4gbHqgZVYRc5hCxH4B37IaIuyimNGxJ9stAccdXfbck9qCgrpG8FNXxpiK/EkIYiK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(396003)(39860400002)(6506007)(5660300002)(66946007)(1076003)(16526019)(66476007)(7416002)(8676002)(2906002)(52116002)(7696005)(6916009)(66556008)(186003)(86362001)(6666004)(316002)(478600001)(33656002)(55016002)(4744005)(4326008)(8936002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: I9KIMuFh9nH2ID+jcQC3h8LEmY10+0JTQ1VK4eCc9H37XVZ2dPS4lBGLAGN/ape0soZznXd6sQb2E8za3HR1ZusxZZrVKitC8+G53xgd+dHCm21JkXb4feY0spJjJFz5W54bwceBQWX0Azh8qk5u8Qg00YN0gj+v6LS3/qZ/isyq8cWuBiNYkXvMWTPwTadKUqXMhLS8KM2pO1EmoQBU/ThQVmFkyMLRJiw8YcS4p1y5D4RR8y3C0AxTzrAP+wdasnBqqFZBoOrMkFlrYOHTeFWsG+6dL1s/soA3275kqDf+iHPkf6yR3xLQraP1nFSqhVS/GjUmShgElvlaYX3taTauCl2IVSvmn1jZbDTbD01kQOQ3Bxuze+knHGGNdNA6Twe1B4aRrfh3KGIEHYgOjHevpMoPh9btCxVqnp0j8rgFshXNYGPa8TWDfKJ38HX4dOrA7woGOnLcT4KvHBZZm/0owbDxz6tiC8VAyQGy+/Z4UavVZp+G7P/XvHrJ7vHYO7ELwJNH94W67PuwZk/SE79nMZpHfFGOcLx9BpBkqmdM1ivN0p8EAMgh1bEUeAbJjlVTDvG87lNSPhh2OwkB/b3L6duxtDD448m65dnbk07t82wFGgjgrWjhfm/OTs1WrPraMFsr8gEurSTVofP1SASyHvyan9YCr1mMA0HDcV0=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcc79a1-fe17-4d35-57f5-08d87b9fe7cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 00:16:39.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJmntRJQQ1qTSMTYJRvZSqjy/Lya1mJmievTlEt2gLCORk/1F5mL9HpaB4XNgh3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2486
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_09:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=873
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 28, 2020 at 11:50:10AM +0800, Muchun Song wrote:
> Consider the following memcg hierarchy.
> 
>                     root
>                    /    \
>                   A      B
> 
> If we get the objcg of memcg A failed, the get_obj_cgroup_from_current
> can return the wrong objcg for the root memcg.
> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
