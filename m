Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA2423560
	for <lists+cgroups@lfdr.de>; Wed,  6 Oct 2021 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhJFBSF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Oct 2021 21:18:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16424 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231582AbhJFBSE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Oct 2021 21:18:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1961EtIt007109;
        Tue, 5 Oct 2021 18:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=k0tjnFViLN2uO6CvVb0hdc8X4ETpwvZS8qXlOiNEIvY=;
 b=hLhUQb/iFmkHGhFGvdwuyvN8chUKbVOAN6eu6hbSE3OMMIDLsx9x4C2PbOSGxj4AvU4r
 ERgR/HYQc/iwYHScFB0nAEpIHZ5hFwO/3JFH/tvSo5ycLaBsX1JYH3L0S0Qu0QjPRBAz
 dwLU4RCHKxyGIdS7+VTiDrzH7Qx4piX2Z24= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bh1y8r096-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Oct 2021 18:15:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 5 Oct 2021 18:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US5DO76WyfRbixLZJhk6DYKw+PHoqkb01VDJONjH8UQzBe85+d/OBHNz+R4IhclQyqN+56xyo1T7BGAL+g2G4cUWrQt5xt9h9URCB4UOnvt++M2v6OzaGN5Jv9Y9YFeIqyZz0StdJg1ZvDhE6H87u6YgDxoYrFaJWfq7jqm/0wE87KC8TXWLncfE9zkXQnk6FnlJ7KN/fU0Vf3S0g97Lg1JbAcA2tutbOtpLERrojH8ha59jbDbGhGljR3OCHBRMXTAooZCyHqgheKdarKsEROR6vQ7tXu1hMdHrsGmHzjeCgC2uDcPJBjZkhVLyioHCANddFhjtrGF/tuHVa7Drlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0tjnFViLN2uO6CvVb0hdc8X4ETpwvZS8qXlOiNEIvY=;
 b=Y1q8KDtys3rrcMSeWW3IfiO1q39WAbW2TsaC+fFNBFnIOhKgYqwtcNzsNt+ZLzX5nWZUQp/WXd/WwpewBZY9NoA7ICzxBsSnHZyat4rLSdkfAJcWsN9o2/Vuwvhsxz0VlGatdrvfkYp2DfBt7pdWePRHwOv39TbanxMWbjtxHXSlhYVlt8fZSXpcNCgerrmCao4xDr64TYpAp5P+ZlsOoW1ao3lNd7kKW3SDcq/uWkUBV2W7AEz/zx6veOmDbUhhq7A67fR3CxQfchFqxFEl/9y+7lr+jnQ5MZ7wF52GdHJnOfScAaJeApnfY1msT9Ip9Ffpyr08GLOyf3FC1iQm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2214.namprd15.prod.outlook.com (2603:10b6:a02:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 01:15:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 01:15:56 +0000
Date:   Tue, 5 Oct 2021 18:15:52 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/memcg: Remove obsolete memcg_free_kmem()
Message-ID: <YVz4yEziz1sBwttv@carbon.dhcp.thefacebook.com>
References: <20211005202450.11775-1-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211005202450.11775-1-longman@redhat.com>
X-ClientProxiedBy: MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:eac2) by MWHPR2001CA0018.namprd20.prod.outlook.com (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Wed, 6 Oct 2021 01:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f7187b9-7cc1-48b1-23d0-08d98866d978
X-MS-TrafficTypeDiagnostic: BYAPR15MB2214:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2214AD20286A7AF1F7DCFAB2BEB09@BYAPR15MB2214.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jz9hhFt2Ykp+ZD4csjCbGqvCgfAWAResgySwLFu6svqRrWLj6tZuSvAiK/Ts2YILtvVJ/fnwnY4QRvfGu3mUWpTpLK/jTy4So7HxvhsKz/vKx7kj4W3s4TGwjZe08iCkmdN1PqV1XRDP8L3m9zIsDJZkrQXnRVA8VjpE8b7d4jhgd4h1qIHk0QnN68WD726loC+1yXj8p+ZEdvq+xazxCL5Js26H0XtwIpL/5Bay+a8FTMaM9aQ0FPdyFssnUndT+ILBBCpyLxzRhZPw1aESEITP94bjHpiZN/FDzaTKjO+yBRAlCQgJYxHGis0l3Ys+pdHYnhlyZUvwvUEnA+wTAFxzYZ36GKZ6d9myhkRemqa3wLAw1WruxCiCHSJk8Cunwyu5YMkx0Gy7WpcDbvqCX6HaAp9XXJHS5ZfHoxPcK+LgcQ/7OYXlo/+JzB3oeQs5AAdFR98okaH96FRTEGP2r+NzD2PBlXyLNeoDagD5MEN8+Fu8aZaV18Fq4Z63Qco55TeAowXAKdELZNPasznY6zUybUGOUJGXXTqjHKB5ctpn6jTUnNjXX9eiTWGg8uY9+bT+DbpjBzXXR17Ymn4aa9giNOke9tlXqV3WJCx6xaVMdBMT3SqsGrxC+U8tBd4+HZV8VCbh2c+GPdFbJ1cfuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(7696005)(4744005)(5660300002)(6666004)(54906003)(6506007)(86362001)(186003)(8936002)(8676002)(508600001)(4326008)(9686003)(55016002)(52116002)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nJUEck9IdiVkkleMnoTnulHsn/ChMFvoiPsJar3Iky0af+WTD8inFbc7WGQ?=
 =?us-ascii?Q?91HTPPmqEksJEVBR+Piyfls7ur6DusezGszfjQh2hLmOdaoVdCXlU5ImvIJT?=
 =?us-ascii?Q?QGrd/ekkwO2rH1zB+NaSG3fsY0xrJKH0ODEy+haIuKprshUv9oLC5Oiu7UQp?=
 =?us-ascii?Q?4zpMAZj5YYdU+ugI03WZgHV8Cc3qLYze0MxAVYrYJrQO7b526+vnMa62RbnH?=
 =?us-ascii?Q?aX9fdy1qEAHkO7ijo23AKYq+rJzsr9NXj9VrtO0N9mCcO1ywWA4GUpdc8g2i?=
 =?us-ascii?Q?4L4yHlSLqMr6cfhlweU7/pqRLybPj1hCa9NKSyTqbY2yJrt0zbx1gZofIj98?=
 =?us-ascii?Q?8A/NH/UkGzvZV+BslB64I9tE+eGKi++tm/2p4wNZ5l4vJMBg1OuAjmkV/QU6?=
 =?us-ascii?Q?Q7FJRZ+NfSZaCc8jlwpImCr0b4KvTcmXonTh3phlTiap0CqtaTwjstoy4vl4?=
 =?us-ascii?Q?FVLlaKYVhnFsEZSxOLQKaXlGrTWXYtrS9Pa2UiA8IKrXHK0XkfCNYXhXRrFu?=
 =?us-ascii?Q?O/QFNJmjnb6VQD+yDtPXXL5Jqi6oo81pmJ6H2RIFUvcMDUV67QSvwz5Kk/JH?=
 =?us-ascii?Q?T3PUgkww2u9iwpblQMuGiDXOuuPtyBviL9tabfSSL/TnxWm0Adi726T/MTVX?=
 =?us-ascii?Q?VhYIt+tPk1gzXrtUQn54IyPbjNKc+yK9NqYjsLQ5jX9ulVC8Fsv5o5CZrvW8?=
 =?us-ascii?Q?rJrJGDy+oqzIGFaTi02EWUbG0l71PzrCg65kMz5UVra3DMkzFG64g6I95pnV?=
 =?us-ascii?Q?2NVUukxC3AsH+SQWsI6cch2vuet1zpsNyuW1cghdzYhfp0941Uo4By1uXti+?=
 =?us-ascii?Q?V6tA0b8WXZnC05HoLw5K0+vMo7IXcoSkwBshEwnfqsEJL1m8fnzVWsQnhabH?=
 =?us-ascii?Q?2yZePxMDrbxTVpVqCZWbBWE/uInyM7hIZwBISJu2hFW1zRa6nP+xXKe3Yv8+?=
 =?us-ascii?Q?qlIDHFIR6fR33MVZNJKmd6rsOb+1HE8KCg7wYa31q4d3/GIhMH0DYCBe8vzt?=
 =?us-ascii?Q?vn7cTWJd+bFJ0LYQXy92M8X2h2OkTgMc7n/tRxdK9navN6UZA3UFC+7bWwRv?=
 =?us-ascii?Q?BTedmk4s46takLiaqzAA6eJsrfStf1bBjZwhSkd2KYYKyqVqUG2kQ4JD0WSG?=
 =?us-ascii?Q?rM+zOFaSaAazAxZKCOsANC/rFuzGnj9J6W9cbL3nV3QBWfPQlKeBRgDQlfIh?=
 =?us-ascii?Q?bPca8S2VJCeB25WoqP3g7Dav8yUEuhOd+gVxOm6h82xbXLKqML+qW9UV+WFU?=
 =?us-ascii?Q?Mo0ExL7QgbnhtNrTiV7r/miVy+8Wsq4Eqt7/flnJanIvLPyIXtDmu7lUXtBz?=
 =?us-ascii?Q?uQkTcO3KUdNP/os3EeRh04IxgkjRvVNTxM+ClHKrP8K70A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7187b9-7cc1-48b1-23d0-08d98866d978
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 01:15:56.8295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMP20MZw18VL5rVPQkhXzjLw22puoiq0tXqHUIIvRpBErq+CnXj6lApJo9hxTDkz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2214
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: mOuxTGr5DEGxsqut9Ycy41S022Rc7LZz
X-Proofpoint-GUID: mOuxTGr5DEGxsqut9Ycy41S022Rc7LZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-05_06,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=685 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 05, 2021 at 04:24:50PM -0400, Waiman Long wrote:
> Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
> irreversible"), the only thing memcg_free_kmem() does is to call
> memcg_offline_kmem() when the memcg is still online which can happen when
> online_css() fails due to -ENOMEM. However, the name memcg_free_kmem()
> is confusing and it is more clear and straight forward to call
> memcg_offline_kmem() directly from mem_cgroup_css_free().
> 
> Suggested-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks, Waiman!
