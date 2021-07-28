Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179043D85F0
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 04:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhG1CgT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 22:36:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233223AbhG1CgS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 22:36:18 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S2VAnv029142;
        Tue, 27 Jul 2021 19:36:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kHzxSIG1kXwazlMs5QTdLmJpjwkb8TVxu0YndxzDXf4=;
 b=C3sZLL54CAef15Jvxk9En260/fUmh2Pp/EB84NlrAP6N1ADBccrD/ExTe4Noc9aCZwew
 pH5H0UHM0f4qJTMscasLzVQ2K99DnozOe6BwMwrpsoKpXTqjIs5eXEPYY4/PfLVVW9wE
 9jyTMQsoS17X8HPsGU5TLhx3MfpuQi12kQw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a235hhec4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 19:36:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 19:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfRITTibO3fTvWcUsMdivC9Tdxqhles6fdMZHpY4SWQbD8n1Hg+tGYBPwU0xQMyyQigFMABY681L7pUAzkeWuSI9t0QvYO2v/9ffHr81YnzedIoeuRw5e37ER4uQVOy02TqXCDLQ3MZz7fvOxChyJyrkP6AUBiFSP1K8bBdt0mQ3s6tZIqP4J3x2bDYXvhv+epPmQZyd5ZGSuhX1cUXhJvku/mXVCKReoIjNXVMcZREuw1cHfpwSiO2OfnXJhA+iLcPB6gojEWXESEt90I1tddWr40PmEcg/3hrN2gbuc7RyQzdzYKX4f539pHUVGhRghwBocpsL5bGZA9/SnyP3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHzxSIG1kXwazlMs5QTdLmJpjwkb8TVxu0YndxzDXf4=;
 b=ZHFEm5SU+A3GTJ8pVraIL64Iow3GBdYdUaYhZ3if3Fe1u7yUAfHFeOJElh70pj6BARkeva2lwj3t/6lKbuEWXZWU6ktWt5aNcFgG3HwaWBchajysLAs116Ueel7kK9++3wk/i1vRbxmExzg1//EAujqO8ahhnz53ucwFe+jEbxMYJE2v1Iy5jPw++V1pR7jkmrSvBK01VeMQFHFtCyFrOhPoM/fNTX2bU2e8CsmMVyqCBA3zhXAJI9OFJBdaouwELnYaA/ocDjZdO8KG/HZmLXp8Kt14CGLAs6juIVMdU8kbv6nrYOCPRDbZ0MA7OwHsegKdRZ38vDSdxjOxObGaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB4305.namprd15.prod.outlook.com (2603:10b6:a03:1ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Wed, 28 Jul
 2021 02:36:06 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 02:36:06 +0000
Date:   Tue, 27 Jul 2021 19:36:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: cleanup racy sum avoidance code
Message-ID: <YQDCkeFxSnh2GR7I@carbon.dhcp.thefacebook.com>
References: <20210728012243.3369123-1-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210728012243.3369123-1-shakeelb@google.com>
X-ClientProxiedBy: MWHPR14CA0019.namprd14.prod.outlook.com
 (2603:10b6:300:ae::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c008) by MWHPR14CA0019.namprd14.prod.outlook.com (2603:10b6:300:ae::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Wed, 28 Jul 2021 02:36:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3c6a2b6-b959-44fe-6d3e-08d951707314
X-MS-TrafficTypeDiagnostic: BY5PR15MB4305:
X-Microsoft-Antispam-PRVS: <BY5PR15MB430526D114BE68F255D3256FBEEA9@BY5PR15MB4305.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+MEga82IEh2q+gPl2Y2vSDvqn6/JbxUeD7rn27lpnOdNcLRVNPQkK//aMx45RwGnYjQUsPtmBKyaALcHctr/yrW42ZT9+ynRr8+sLh3z10JbC0P6GYDqgnTRR/vCEmQaSQwqj7tRl8F66I1rogAYw1ffZpiRj7sRKki/d0l7PRH9ihBIUboRezP0iUaK+7yGNo8D72eZEoolWnDAOOJORI01yPp8WTZZzJvW3tdi7hiCjUX3hrCyPKXU5lYg8Yh0rGCrtAq+YQujQofXOmmG+pG2tCOmxmQZC8cRNqze+Y5ETPhfQswsnmERyEYNFDuSn0qXPFjfblCxirr1pPKkT2NBfOTpuPzTIo/FWzP2ZMnATJqecdvnNEthWLgjScGh31yG2crdBeYx5r9ikL7rxBJ+JAhLiaS+kGnCroJkskOtByg6otmK49X/J53AOblxfsy63Nevt9FF33eI5WopEFe7aYve1QwxevgI8nhVVo954KFodKcYKc/+TBsat6BPY+H8Uq6DIP2cV4IhtYHukBoKCLvNFtIQoVvvM9PCis8/8JuIG/2xAEwzoaPN3D5x/aBLrsxn4Y3D8OUB5F3BFLO36g25FbGEesN7XnJDZWiJGvMqFkTTECtcmXqM7AMDFiBvf8wMZwPLScOtFJftg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(54906003)(9686003)(316002)(4744005)(8936002)(55016002)(66556008)(8676002)(66946007)(4326008)(6916009)(478600001)(66476007)(6506007)(7696005)(38100700002)(86362001)(2906002)(186003)(5660300002)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8DnRTYZ3DBJOPrkPO7p+jlchX38xqgDtUDL1mQ7DJ4y8Nz9DIt0JVoD5UDF?=
 =?us-ascii?Q?BzpuLclXdwu+YpkzttFX3BIAiN031KdJf070DacBV6h7FoHnbF4/rWS4RmbO?=
 =?us-ascii?Q?S4C4ev9h0wWypv47BHh/SVJ3AtYwFY37OXrCOLcYQ6gmcSm7cLaQC/VMN+9N?=
 =?us-ascii?Q?rmdgE/UY4HVPRvDqRN/1uJ/pZkhCn5r580N+SHF7EtV98LgcB+ZcnUb0yNg6?=
 =?us-ascii?Q?BVV8cR3VSZGzx2m3Hqih6Pw0TKvxEHBc4N1/+j2bEsTXQEEZSgHxDLXjV3u9?=
 =?us-ascii?Q?3SjTNiFuA2Bpp+cfiPqWqCeRotWEVe+o+iqVwZ4SOx7XieezoCX/WDj0guQo?=
 =?us-ascii?Q?65YXnckjodswrLSO4Xd324n5ZSzlCJDIGB1a2TFURmB7fMg1erLE3REK2ZLF?=
 =?us-ascii?Q?gCo1WhX0YMzUvYeow/xcg65OzXAVaxByWKpAd0UobwDbzg1bt54ZHgiA6/1N?=
 =?us-ascii?Q?jcUfwelxcS0xVzQdRswt9ZwcUT99nie6mBODuCHIEsPCAj+qErLhX7ZaY/iz?=
 =?us-ascii?Q?yl+YYT5sO0TfepiOOOdE59PbAW6OaJlnQ09eYaSIZD5UK9MNMoo7CrCduJs7?=
 =?us-ascii?Q?dVXX+BslxkxU7y6rNnH79XpVaBCNof/tc0bdXmzPfEai7O7CifKD+9+IEL1g?=
 =?us-ascii?Q?eo8mPqLx1rJIHW47JydTN3Ax46Sc264JW5rNTgVYakKjhids1s6sFnLVL7GV?=
 =?us-ascii?Q?MUw2alJgzYYb0kn3xdcMxboZeU9jZT07lOEhTETzCt57fpj7Tr7hSWym8P63?=
 =?us-ascii?Q?6S1ixi8o2kCtEc9J2echOzw9jb0PPe/fzs6PF4r0yf7VxcrfC1m/BZY8eRHF?=
 =?us-ascii?Q?+bBxRrEjWW+gJKOAjT49J18IqjmDMp+sQVElsc3on6F5RNe5nWdPKUL6mH2z?=
 =?us-ascii?Q?0AfEJxrlFfdbVs6wxn6f2CQi2NDClmaEaA0N+TnH1WhpXT1Hi5yMXrY8zr5h?=
 =?us-ascii?Q?gpsnB5gQnJwrXZr6ZPoGfenYqyqxCRIJAr9bOIz7eYKSmL2ORegZUqkKZ48Q?=
 =?us-ascii?Q?D70x4KU+SxlvjrnAKkqcg4ZC11bHFqhG4z5q8ahkUsLfTNJEwkdJ9Ff/evz6?=
 =?us-ascii?Q?I3ucGfyH2jLTYnxB0sIPDQFM7gYdcvsg5t4SqaOrDXhdZMlv9giOYUUx1Xk+?=
 =?us-ascii?Q?QroSRP5TBcAA5LXvFyRJSH9MUsmlaK7UxR/JqlmMPeFKP9SHlfqK5EGrjryM?=
 =?us-ascii?Q?+wwCOulC+YratO5cv1U4/IZVxXE73R6kQaslwO4yitT0YyZwSmmBeW1xFYOk?=
 =?us-ascii?Q?tGrLOt27ZrcW5vJ5AN4zWfOwDNjPX6FAJEJyabve66Q1t22DZRGS4r3suZGZ?=
 =?us-ascii?Q?jRYK0dCHRbMUg5kqmLTmeuAz3zShG2sGmHx0srKILRryGA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c6a2b6-b959-44fe-6d3e-08d951707314
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 02:36:06.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PewKNW0FZciGjrkpHqiaYIY5WTayREZLCQMTZA2dhgklg5aRqUG4De5Ks5yDtKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4305
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OXk75RpJqpBnAjAnREwOiFo21nFYnzrj
X-Proofpoint-ORIG-GUID: OXk75RpJqpBnAjAnREwOiFo21nFYnzrj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_01:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=452 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 27, 2021 at 06:22:43PM -0700, Shakeel Butt wrote:
> We used to have per-cpu memcg and lruvec stats and the readers have to
> traverse and sum the stats from each cpu. This summing was racy and may
> expose transient negative values. So, an explicit check was added to
> avoid such scenarios. Now these stats are moved to rstat infrastructure
> and are no more per-cpu, so we can remove the fixup for transient
> negative values.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
