Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0815F8E7
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 22:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNVrp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 16:47:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729434AbgBNVro (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 16:47:44 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 01ELiSHo018210;
        Fri, 14 Feb 2020 13:47:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=piEDK3sQ58eGY88b0/ZoEju6n9YkDVBjwZwW0orWUZc=;
 b=Nir3ex2agghP9Ed5QjdUx56ukqp2kn9k+JkuhD0a/nGfW0uYNlEGyLl7oD9PnREtL/je
 AYsNky2Pwa7LOXcI+MFkqjD+ss4EFBvLYonnv9rBFAOAQ2R61N5rDwedy7970QuI1gFe
 /iTzSNUJb3bXnh0WQOgGqRmHOr53qYH79ig= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2y5x9p9rnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Feb 2020 13:47:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 14 Feb 2020 13:47:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMKktoaF1IOxW54uInQ/BBY6ukrwNpSEsYGbXWfgWmg3FLb7d+J3EivaiesZPP6HVUV17IgDIg3+XVOyC7m3bLXf2cSJHp0CAUqtbggvXS3eP0BxGFieuWwGHxVFESxMJLevcp4iC0iFIIuyWnZt1oRGpTkoOGbuoHzYulrbVq8oGTXP/3hpzPkfxBADrMADj4DUNG5p2rX+aEpkphiWezTXltBnTFMs6JaxhB1iHFjC+k9w5BKl+qJenJkVVn1O6w1zVtz4yQUBdDF7w+n4VYou8r9RzB0pr37alPAsUkOvWjDJYOeslVL5fnjOyy19xBngTMym3dtrNPFLILG2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piEDK3sQ58eGY88b0/ZoEju6n9YkDVBjwZwW0orWUZc=;
 b=m5hkPQMV/kxqFfWs1nuzJXqAfuGfkxuz2law7LRxZAtAMGOtRsepSuOT4B4HuCWuVkfN5L7cdVptVwU/xSz68GYem819+WxnIx7iM70VEYuskmE2CBG15PgQi+EO9ZsEe4nA0Ogjx3koFnJk4w0SmV7n70HtDTYQo3FaEy7V6VtMjnIfJTkNX6M9uqYzWNJ76ZzITURY6qoWJDRmxINoycQJh9tj9wWXcd+LhK8PafnivM+8cjjhExU//N72b4Gvt18xLiOdu2SPlyNio7YVgoLEhv2htENH7mSX2R2joAQpJNX/95fuI/XH7TTf/YG769PPujV/NVVOc6z1gNtfcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piEDK3sQ58eGY88b0/ZoEju6n9YkDVBjwZwW0orWUZc=;
 b=bBQfcFyNWqOmDbVEkww4oMNcUKDrez8i2Prqf/aouOklZ31aQvtjKEr6SNR27+56SoQg5jL1qQQBN7tXB5Men73i6Zi3/qOpJqzQoGG/LVr8Aj0xXwSTwuQUFlawu97ruwk+NuC4SQcRD+YkpvtjsUXYHgPB/TjgTcQkGw1iNuE=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2263.namprd15.prod.outlook.com (52.135.195.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 21:47:35 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 21:47:35 +0000
Date:   Fri, 14 Feb 2020 13:47:30 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: net: do not associate sock with unrelated memcg
Message-ID: <20200214214730.GA99109@carbon.DHCP.thefacebook.com>
References: <20200214071233.100682-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214071233.100682-1-shakeelb@google.com>
X-ClientProxiedBy: MWHPR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:300:93::31) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:500::7:3162) by MWHPR17CA0069.namprd17.prod.outlook.com (2603:10b6:300:93::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 21:47:34 +0000
X-Originating-IP: [2620:10d:c090:500::7:3162]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f5196d-5c87-4eaa-b801-08d7b1978077
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2263229D93F7B15DB4AFA385BE150@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(16526019)(33656002)(7696005)(52116002)(9686003)(55016002)(186003)(81166006)(54906003)(478600001)(8936002)(81156014)(316002)(8676002)(7416002)(4326008)(86362001)(66946007)(6506007)(6916009)(2906002)(6666004)(5660300002)(66556008)(1076003)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2263;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIkluUCsrMkYs3e7Ov3cnv0SeLWdS08ZSa6d11Sehx9US4PmKlG+Rz1nJ/kYqljUyJJwyiuSuT9Svyz/IhGlDbR/ITZBOaLrkWvR32TwvDBygQ//kkY6aCulezNdm+9BH1/jKSswXsg+qE5Iue9chHsrj78Ii6QFcvGK8gTkMQsNojpcXnEgfK0fUVr6Mi4Vcsx/+kp4sCjEtQVsMczlynlqQ8qwha/R2DjoVp0rU8uFdMEUvxe7fdRmN5wnNPd7QYSijML5OT4+KWXHD3BE0iA1ICD+cQqJ3leiAdJ8X2OoUgU+7tUKScYjqNBXokgprRK54K3MXxanNPJcyhuKAU6DYq/ZMu+OgAWEAoPjIWTwUODHootalJt8xi+kzk9H1eJ4h0X5gcV6zlOiYUjYE4++R5KgN+kz5ERDaY+ohgMhftaljlOEbcR3iVC1tcyq
X-MS-Exchange-AntiSpam-MessageData: 00Fx1XrI+7ddk7D33gpAXgmhY0KPhngn9En2+4LCeu1N10uTsfJHN+Y/J8PxEFvVnT3Vu6VdhTXa90AHNRAWa6sgaqKSaH5Lfv9IeB8r+mK+KdtDnYkJaiaUR76pINQmVL64w5lobzM2Okgu92Tverl4CityllyPsGtjtlkJKAHAgsLbfRcYtNaz7u96Cz0N
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f5196d-5c87-4eaa-b801-08d7b1978077
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 21:47:35.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZDwy2j0sttJMKsaMybBNYyuTOclH26BgHxD4pbkROHR4qWUUNoZGLnjedINl2B3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_08:2020-02-14,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=886 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002140159
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Shakeel!

On Thu, Feb 13, 2020 at 11:12:33PM -0800, Shakeel Butt wrote:
> We are testing network memory accounting in our setup and noticed
> inconsistent network memory usage and often unrelated memcgs network
> usage correlates with testing workload. On further inspection, it seems
> like mem_cgroup_sk_alloc() is broken in irq context specially for
> cgroup v1.

A great catch!

> 
> mem_cgroup_sk_alloc() can be called in irq context and kind
> of assumes that it can only happen from sk_clone_lock() and the source
> sock object has already associated memcg. However in cgroup v1, where
> network memory accounting is opt-in, the source sock can be not
> associated with any memcg and the new cloned sock can get associated
> with unrelated interrupted memcg.
> 
> Cgroup v2 can also suffer if the source sock object was created by
> process in the root memcg or if sk_alloc() is called in irq context.

Do you mind sharing a call trace?

Also, shouldn't cgroup_sk_alloc() be changed in a similar way?

Thanks!

Roman
