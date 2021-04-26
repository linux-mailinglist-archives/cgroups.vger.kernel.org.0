Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141F36BAB5
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbhDZUad (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 16:30:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61072 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238426AbhDZUad (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Apr 2021 16:30:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QKO37M008225;
        Mon, 26 Apr 2021 13:29:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rXDcU7tQ5Vc69pZk5LRI6xLe4iooIoBoOjybRbWdmVk=;
 b=aJVNqtujGEW2WopKlcDV4ID1yV094eHTY52PMpIyAcH8wXGvkS0uhFDjN/r5BAZ78Wff
 PEzbzVY0MVdRXgnTYX43UNjpTSS/K86BX5saewRDp2rsXkbf8mlh/w4NHHISzcjrkIn/
 FdwI/7oaN1WPfWax9Irecku8qGdXF4oZ46Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 385v2hu5mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 13:29:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 13:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaVoU53wKXybf8pTNqg3aMM/KnHi0UIe4zaW/70COS8Xi/IJUQPb5rJ8Bfj4++LSwTHHECpgP0jWyGRGQCLIC8etEtPHtWuQPQ/T6XeJww4rsFF8kiyvHlEYsPztZm/Gxzx11lOJhaNUw6Lgj/ZEGOO2knsnpy0YF4s35cItYFEOuQQsmtWao2+hylkrt/8oNCEqERxwaGZMoirk3Dozb3+x4me0/MEDrmfqfCZlOCkHIJI14sPSFMVXJbX6IUZ06M4z04zZbTDnC1yNxxbh1fPx58cKyPnTyqMZjm0jpLFMi6asmdOK8cxbwjWq0DIYDQAeP5WzUWhzU/0qIG6ueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXDcU7tQ5Vc69pZk5LRI6xLe4iooIoBoOjybRbWdmVk=;
 b=JR5pZ4YJ0cnUWkzUnUfZM2CKgZb4FJ5qNdCrgwoamtSvi5EB0efzboxP+OqCURbPNQ0e9dDZ8IO8wLq8mUIpe2oit/pZjEgmFyd12OPQneMFRuG4mfHFCMSiVWwx+940Afbj7fyA6aK7Pl0yphD/FfBGwVmALQZHMFMlpyjfnHtYSsRbB0WDLEEmkIRdSgMs5Sjbr3xsLGo44IDBgFsos3X7mFK7aNmIJAesEgnGxq0NC8wmDezVXGI1lMDfVitRHxJtuAZ17Vv6YvU4rp+zSe9BGFBIDp+DH12dybxei/Q3d2mOgqdRGAeTRKaD2B1nIh/zL/xTj7XkQMwNyahxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3521.namprd15.prod.outlook.com (2603:10b6:a03:1b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 20:29:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 20:29:43 +0000
Date:   Mon, 26 Apr 2021 13:29:39 -0700
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
Subject: Re: [PATCH 2/2] ipc: use kmalloc for msg_queue and shmid_kernel
Message-ID: <YIcis2fFx7aWIF7r@carbon.dhcp.thefacebook.com>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
 <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b0845b85-f4fe-601d-3328-d707d7db27f5@virtuozzo.com>
X-Originating-IP: [2620:10d:c090:400::5:bfec]
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bfec) by MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 20:29:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff971d0-ecfa-4273-bb6a-08d908f206af
X-MS-TrafficTypeDiagnostic: BY5PR15MB3521:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35210AB35827E5FAFBA81BE5BE429@BY5PR15MB3521.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdtldPzpgWpyC5G5kWQCZAU0dTi+7lHBmo4PSmWSSg2p+/pnL6XXTBONpmuQgLBUiTWSl0hSsiTZwkkPudC3hJjGYvsvJsjcEuj6eMp12icFaX55KZ1TlYoO8VGUUggRURhp0UG0/SuEJ2v4cC/0GMf0186hM4xhv63Ui69x3aQ72+PJvTM3yBr87PLHZLOcQqd/9XqvkmqtfHrvLa5HWl5+rDQubkB+slHGY96eILKWEDFfLVaulajqFCAGTN9Xooq+XkwcbqjfM4C1CMaS8ePWoeJQmz6S4JyndcwBfQHuSe7QnNI2ej+D4W9rfvUG+63XmdjpNLLMnKswuVqSSSkfT1Wy1PC/dK8eQSouUSj61co8TFOK3IPZILGcNZghaJUAtbWfJiKRdcE74yhQ3NnIy81ru5SPISw2C95z9Nf6eJD9KldWTCsbcZ9we50lN3/N2HQBNVcPzF+uA0L6HUaryXwslO3vaJxifsdH4A1zKRUNxZPGv99TqIZzrMcWTOoT38WSyGkoNCKkgd5VGomsGvTfJXgtcW3PuTkeuLvaT+XC76CTcwDgidsOCzsHg96Z/3Fn2/cKPDThN8qtSP3JraljBK7hHcRHC4Xuqlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(8936002)(8676002)(9686003)(5660300002)(55016002)(86362001)(478600001)(54906003)(38100700002)(4744005)(6506007)(2906002)(7696005)(7416002)(4326008)(6666004)(186003)(66556008)(6916009)(16526019)(52116002)(66476007)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jQbx5EQ73+afRF2YsRXh5s+G/lwoSekPjQmi07r9Iph34UHAlYvJAelueG8d?=
 =?us-ascii?Q?fDYEcWHdnbQ2jUwqGlAfON/ZnWk2qTSfmXuitLIUlBwT/fii7TS89Xu8S77l?=
 =?us-ascii?Q?p8zZR1Mf/oLqilpX4kT93jFyq1vYC2lVbscOYX7mkk02AGqiBHKwQG0G6SNc?=
 =?us-ascii?Q?bhgaxX7ob0yr4p1f3E/xJKQg8Bvy+toqY85aaLoMJL2vO8DKHiE6hk8Ppr6f?=
 =?us-ascii?Q?Ksf3hZ6kgQxt1AC3exGHqsrwZ6Hr5wT5efAmEemHrNBneWwFmVlpaRGX3oeW?=
 =?us-ascii?Q?DLziVKQv6IR/WyQGTEPKRNcg6581Q+uJy+MnlGzDt0VITEZMXRD1aocZ5K/1?=
 =?us-ascii?Q?pEgEyxrz2O6y3rvVhK/ILNJ44hXO5eNcg4w3bzcgMiheK6NiK+rjoW0+bdq3?=
 =?us-ascii?Q?wIycFHhbGnkIIC+En/Jq2yK5LGa+9fZPO50eVVdSinoKS94xuDG50b2HMYDS?=
 =?us-ascii?Q?SLO0MRgbjZHRtLxdHg7qALTBmbJLknIxBJD6qshWSR0+Dvtmt78sbx5AWOXN?=
 =?us-ascii?Q?hyfQfD9b1uOI/QkQjw9mFTFQ06I4tFSCOAA311QKG8itt6HFZmDlAQDvyWiu?=
 =?us-ascii?Q?8PDsRw3QljLyZPC+vQehODZ6Rab+/MnialtUK5sp+UW++V+IuekDQkF8g1SZ?=
 =?us-ascii?Q?3Y78BD8AdjnezebzT20PBpgGUF6zOLvKSYZQOl7EBHG4OK0YUW0GMFKMe6WA?=
 =?us-ascii?Q?QvYa3Ldn+7sIBmGcnAvmbSPOeaVyRY5yxWaTqrNpBDb9YfSTTdSe5WllJjP2?=
 =?us-ascii?Q?ZZnv3qTWLT2MTUrll+T36elshZ7JB1t9dBRco9sEe73PE4OF8XoC16OEsjF5?=
 =?us-ascii?Q?Lb+YUAfyV0MaMTgSJVx3uEoyM7ArF9VyxFhZnCCA2PeXs27Po4sBfJZO1MVY?=
 =?us-ascii?Q?aoLSWve7vwelKyi4dKFFF+/hVtzs/Dvq8UFeFEry0E4uO2Ja5/4F5g7abCDf?=
 =?us-ascii?Q?VaZXpACkEcAMvQTrfC1U9BI+gvhq3CBtELM9GXB+T/yzIdENZftat0Q3OOnj?=
 =?us-ascii?Q?zopWfcZKBinZwHRclaJ/plI8SZPGdZ5oj55fpgFlFx/CBjwIsKe/dzrHZHj4?=
 =?us-ascii?Q?S3VUvp72D1MAOJLaBclFlLmSlEWuRp/ksL3lm9+ctOx3LzqfQoIMgoPaOU5V?=
 =?us-ascii?Q?G3VzhsK4a15fn4+bdQPkO15LGtSSezkO4eBTs7Glu9Ykw8fsGZ80yX9mYkoj?=
 =?us-ascii?Q?D0ytyqoEA5entX2LnuhSoEvkKk2IxCA5iH42Zags3cLFCl+b21GPlNtB09Rq?=
 =?us-ascii?Q?sM0zMaIsqowcOs6K4UmLuzg5tpBIh/GZKqg6wqRTYOEACsrpEkF/2G7UBedA?=
 =?us-ascii?Q?kGCm6iv8mlHr/2cd5JrRcJgqT0HPUJhbUhmIgajOLW7ogA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff971d0-ecfa-4273-bb6a-08d908f206af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 20:29:43.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqrscpNe78lioKgRkOsHBommDEmna9iwkO9K5vk/n1hE7JyOk3P0vLGRBR48lC/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3521
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: NogMSpnIinKGFMOeYfsVocoZ9-8C6PH1
X-Proofpoint-GUID: NogMSpnIinKGFMOeYfsVocoZ9-8C6PH1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=945 lowpriorityscore=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260156
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 01:18:14PM +0300, Vasily Averin wrote:
> msg_queue and shmid_kernel are quite small objects, no need to use
> kvmalloc for them.
> Previously these objects was allocated via ipc_alloc/ipc_rcu_alloc(),
> common function for several ipc objects. It had kvmalloc call inside().
> Later, this function went away and was finally replaced by direct
> kvmalloc call, and now we can use more suitable kmalloc/kfree for them.
> 
> Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
