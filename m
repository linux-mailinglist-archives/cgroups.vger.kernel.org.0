Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC1336BAB3
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhDZUaR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 16:30:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235996AbhDZUaR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Apr 2021 16:30:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QKORvm021559;
        Mon, 26 Apr 2021 13:29:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ry//vdskWCikoDYDP/MqQBfvu56aeeQCMaM0+qLdlI4=;
 b=KXyePZeIkiSeeSNIKpP3Q3TmZ6l0s+DpKJ0TB/y9AuzZzm1k1NgQFJHdoDEF6Cl/NsK9
 g8OXzSvkGU6SKJjtjwa2lEPVuTM2u9Syw9/I5JkgUypowxcuEIvOS+9/OJ5Nw3Xgb8Zn
 JcPIG3xJR4cxs9VH7YpBGNewnjY03dfuDNo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38627r8wjj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 13:29:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 13:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLZMOIagg98CyANaJftP+wDoEqrnik5A0F3jZQh6dwYir384/+OBHEXjnL5FXsFhu9McX0cwaJsis51A6sGZIfLDFsUXSPj2QdTbOne9GvVzAKYWjkP2mfWk+poNkwHsYSQiZa6wtCnTvGhaAPK2X/GdHWRJ0v88yc6HeZ2/8/QNSvA2guWuR+A+8fRAORTvMfzNLlvwzYKozQLYQvqDcl3M1HQ7kFhYMzBuI1Ph4Fe4HfBg6nIoVEn3uGeHoijV2iG3oG4pEiSjcg5Zj/ELkTmoxTzE1PCXnD1lxIyfD7DEU9dNwh4dI2+YevmWgpcBLyAFknFYLcVAnxx1d0xt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry//vdskWCikoDYDP/MqQBfvu56aeeQCMaM0+qLdlI4=;
 b=e7h+5oE/MQt43nUkAYcvWEYNLUxTTGdcyfGIGbQxYi7SB5mCZ7cEringgVDJGpC9A4GEuas9PN41HKptzEckfz9esPSG6q/qTeGHyJyUUC90oWQrxOO2Wzs+RRjybCXKJfqf2LWxdTGmqBh1fnt1b4PI6/8miVrqpWtv558m8fc6qd6bNXpgzNrNZa2QXjz7bNTPTooVitRfWYqGYNxmo6H94bEtB4LrXNATQmft58ovsA1B6eMMouvQFO+OygEcTciY3i4LsenI8F91rP5/J2t01B8IVeoFewFxrAqUi2JzA/FjrR/Fq2FKd9/IB713OCE9HDot9JezhYkvpOA68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3031.namprd15.prod.outlook.com (2603:10b6:a03:b4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 20:29:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 20:29:25 +0000
Date:   Mon, 26 Apr 2021 13:29:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     Michal Hocko <mhocko@suse.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 1/2] ipc sem: use kvmalloc for sem_undo allocation
Message-ID: <YIcioHGrtjFHoDej@carbon.dhcp.thefacebook.com>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
 <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
X-Originating-IP: [2620:10d:c090:400::5:9e88]
X-ClientProxiedBy: MWHPR21CA0049.namprd21.prod.outlook.com
 (2603:10b6:300:db::11) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:9e88) by MWHPR21CA0049.namprd21.prod.outlook.com (2603:10b6:300:db::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.1 via Frontend Transport; Mon, 26 Apr 2021 20:29:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac3dab6-b72f-45de-cad5-08d908f1fb98
X-MS-TrafficTypeDiagnostic: BYAPR15MB3031:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3031D407CE69B2BC59795CC3BE429@BYAPR15MB3031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cPx9T/JVUuTRuT2i0/n1vtbbFr5wdkM9LnQ3h4J/KHkgPtmB2Q0UpsC2IrCuSm5VitKqVFfiPPcRQW2dfe30OJoEEdGIIqDDb61uU6B9eWIsB0M0BH8EmVk9ejmc8E1tI58/0ouJDJbrDZ0MroHI0pNCiKtiVpplUl5S5v7MtNvFzBeC/mkzk2phVPs6TAJzJTkDo3OciJ2wd9EQdORHq3vNsJiWE4ncQiEZ3e6uD+7J0EXGM14V4yhU2imUvxyVk4eDdN63DPST6W/NZ5UjOkp/aXstXfdkrz0v+2ffMo5FzTC6U7zNDq5WYdwle0rZ4Q9ceK9wxZgeIhQbjmKqVRnCZuOaXO/2pYtcyCxauqHo/ubbfNr3/188bPwpOyH4oOThRntfecnq1rqNxvzohZR9FmbHc/0RNtIGlLJprYiT4GyXloxrCbLI1ATUfATcOdcQKeg2JUbSU4K6cmUodAG2LhSWKgjeUuOSmTEIG7aAyttvSu8Ja91pInhwCSrOV5P/qrTmxQpIQcXgJW0liIHx0F04BoHJWMJVUYj9z3B2WeCVxKk/eYeF9bBu3FgTXLqw8nBsbvbH73pBarXKiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(8936002)(83380400001)(38100700002)(54906003)(52116002)(9686003)(86362001)(16526019)(6666004)(6506007)(7696005)(4326008)(7416002)(8676002)(5660300002)(66556008)(66476007)(2906002)(66946007)(186003)(4744005)(478600001)(316002)(6916009)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eGAIi5keP21jdoZcNdnKXTja3R5nMb1Cz1MkUB+QzxspY2pSurknERX6y/gR?=
 =?us-ascii?Q?jA9m+e3glT0IPpZdSmibPBge05X05uKOrKel1lLO3nKg+ibsPaXgaEpfuyBD?=
 =?us-ascii?Q?I45JNPdbyp8NgVvUiZS1UoAEdxqD0lQhhWGh8fH5H9rUjW67e4aAlxRMdxNd?=
 =?us-ascii?Q?Mvfrz3UWV/JkElO7Ke+dIvPdVj1UKV1ZmC92BcrP1tayNndiVE98D+jvFE/F?=
 =?us-ascii?Q?00TwEfldg+yNF8zh/kohuNhUjwJEbAbmzt3ZWHHQoawmJMG0gJh020XzHTPV?=
 =?us-ascii?Q?7pOg4Q6W9LTIleuZGis6yXZgi9r0/tN1espPtZ94fSuRGyxTB6/IOJO4ECLX?=
 =?us-ascii?Q?+tBc67w6OfezEZR8PZMYgUHul/iU0Qidfms3xpjuMb7htj6myoJMBXqCiVNa?=
 =?us-ascii?Q?9fVcod3ZAhP7tPnck/EdLxDsfS7HHEXAXegwXBJ0L7fhoNiH1GHkfslrJk5b?=
 =?us-ascii?Q?e1fpVmV9J8nFnpBga+k+XASSG2/Y7Bqe4Lo92HWMXFAswnrcGMzPpzS+dQxx?=
 =?us-ascii?Q?tdqGSONAVlfHHB9nU8quzX9vri06m/aFh4W3xqTzcFshsm/tJMVY9j48iasH?=
 =?us-ascii?Q?ZLB8eBlmL9xHSa4umLzX+7yc32oiLFsqJlWrgrhbtUuWXsLi7TF2cujm4yMs?=
 =?us-ascii?Q?CrpuvFBTCNDZhM9Crebbqv52zuqTGJzEtFR4qHGEIh7/gHdk7plL9dJ11AJu?=
 =?us-ascii?Q?b+NIVRGPC3j3DOcGFbK3h7S3QP0RivDOhgfZXPezXNbM4k1Ktr1R/ZP9EoG/?=
 =?us-ascii?Q?2PDYltv1AikaezN9LphIH1Lu7CQHNt9a9/asvRuYSKk1I+7Dxm8OKA4wUtMa?=
 =?us-ascii?Q?lrWvoTULSOl5e4XTWqqHwQ+fwGujHXyh8K0CX6ce0/ybu0sYNU8Whjx0XEoF?=
 =?us-ascii?Q?pIhvdueClL33IOkg9xEy/Z68mCPCTwDaQ1+R+f31wlsm9Ie7Henaae/WgK7z?=
 =?us-ascii?Q?m7tDm8GWj2zNge513m7XfLj5vlhZITem4MS9KXvTB2pjy+iHAvXA2ri6pY46?=
 =?us-ascii?Q?WAgya66j0AbHJw4rodAA44u1FN+F3AXQaFbBjNYp+dSugGHq1xsEF8Fi+evU?=
 =?us-ascii?Q?95S38r05zbKr3nZwT9EB3O1VdmgF14GQAaJQMbAuEwxYYs8N5TtCgBH02lLw?=
 =?us-ascii?Q?3WT5hJGvsax0SsXzjzeQxA8XpGLWVhVehNihqSBB+Yq6uZuz5mu7p6+n5ajL?=
 =?us-ascii?Q?m63qn/JZ//rk971U+lRYs0OBNKQ9IxXcC4wpLvqKA7Po8dNeNAFqMa+8wYUy?=
 =?us-ascii?Q?fFo60m1ukaPHdcCVUzKj/xtkCnCIlaA1Kf+0QySczxdrWvkt8K9+lGVwOB5A?=
 =?us-ascii?Q?Lq5pL7eaMKedmqy+z6PVYFyq6hHvSrkvo2R5Zu7BYM/VPw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac3dab6-b72f-45de-cad5-08d908f1fb98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:29:25.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2y2kr8d43hDLTPrdNPY4L1Hxgg75+jQF09qaHhx19Ywc1hfcJoWvUBMMeD56jI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3031
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: izwM1rpMxTc09c8dHfTBoJlH4Dy4HSTf
X-Proofpoint-GUID: izwM1rpMxTc09c8dHfTBoJlH4Dy4HSTf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 mlxlogscore=691 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260156
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 01:18:09PM +0300, Vasily Averin wrote:
> size of sem_undo can exceed one page and with the maximum possible
> nsems = 32000 it can grow up to 64Kb. Let's switch its allocation
> to kvmalloc to avoid user-triggered disruptive actions like OOM killer
> in case of high-order memory shortage.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Roman Gushchin <guro@fb.com>
