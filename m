Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D3D35D0A2
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 20:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhDLSyH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 14:54:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229879AbhDLSyG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 14:54:06 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13CIrNBT017702;
        Mon, 12 Apr 2021 11:53:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vpX9TYwH70BjUfCH2KyC4LurozlX0Q4cO4JSOqSJ9Wc=;
 b=kqsd2dnXjE0q7e+XK0COTmPYm1zz1+ryBQZppeHKEyPO8rMzDMET9JJm/n2rUxuGRvc3
 50ak7muECB0asmLt3leBbuahoRTw6HuiBxcKuLqCeXzUAxxV3AyeF6ikU7qFLMLpYpKH
 VbWSON7LfgCVkWtgX0wrv5ek7uu+AZ8eWDw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37vkb2tvug-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 11:53:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 11:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CC1et89XdZAgIyspyp+7q75JaasaicVK38ocCExbZhcs0+BbrQ7ZQ/wBRK/NyzfOx6HabXktQ1bC9AFhBG8QpDEDQxMiqU1HlT1DAJAq2FzLOkcE9rfK/IlESlVT/vsmKiPtKAIbPdXEQKiIC0Wd6mEXc5xaTTTidA3ktQWaPdI52kDcV5+6tqslrBAhwd9FlSp2PEcpAh7FJ2eOeNWw4kd1DwJbRrkrtQIZO6Ucjo5Ek/jadcOowdAtwDI34FPnxoiPMk2P6a6GudRnHs9aJ5I5h19fbqNJWerZlYhkoWbaX9zCaTatOvagxDMlyl/uBdCf7bGZcXPTIJw+vBldsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpX9TYwH70BjUfCH2KyC4LurozlX0Q4cO4JSOqSJ9Wc=;
 b=bNZ3P2W6Fw33rzcYPwnppQ8ZdyEhDfAQZerEqQVW9yvomdBJ2M4XyzhjLtpfL3uA3/KpS/gGeMsfgksWej8wv8RXxmyNZF1fgFfJYBFjDxYFl7OP3shpY493QcNPpPKiu2GRKg/o113cVrf7E3mpEglCCcXdZicCfXzS7NyzcmrZB2EQ7rH6G7rjl5xZ11kjzHgJkiNceTTllo7K5UmoTjdUrU/VcsRuaq37KwQnlh/8Olxmx/89BlRexWkGdmxkSkxdUgK3k1vG3OD99Ll0RrPzgVAkkii8fngsR5E5EobSCY0bDptj/0F3wnQAM9LvbMiybWImr+2npQx03hmE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4501.namprd15.prod.outlook.com (2603:10b6:a03:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 18:53:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:53:28 +0000
Date:   Mon, 12 Apr 2021 11:53:24 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 4/5] mm/memcg: Separate out object stock data into its
 own struct
Message-ID: <YHSXJAwYusgP/0xx@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-5-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-5-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:3051]
X-ClientProxiedBy: MWHPR21CA0065.namprd21.prod.outlook.com
 (2603:10b6:300:db::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3051) by MWHPR21CA0065.namprd21.prod.outlook.com (2603:10b6:300:db::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Mon, 12 Apr 2021 18:53:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b708aaf7-3cdf-42c8-9b11-08d8fde442a1
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4501:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB450118F51A393B03437EF9A4BE709@SJ0PR15MB4501.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NkiwADFpRRa3M254RzCLt/VZkPyK5mvTj+U0JWwZSs0RxxKBAuPD39qoyrDcABvQCH5Kiq6ShrSHRJhiiUMMl38O3DA2hG6/9oCVoS7AHAIw6Aj+JBuqYf+imL1qzlGdQl4iPYb049ENQkaWycIvUbRXItSm4wTNb3u/JxAV7nBnY72IMU9q+cLQ9VK0axqw9byIBhpVG6NbcXBzPOumc0qtjtrYNSKT9MjJKtrrkXexWDUxdTCo1N3wSnXo9uE8t3Thi72rUpxaqG/ktFGvfNrbqrReUcrRKabKDd8dTVatujHl3hlXOZfPxBoHRePHXubqB4ULiAIcCE4yEOdadf05Bi+nQavzEzRB4f/2mY/rKK1DFW5CIgnfKGawTc4fr1vEFyUnANPTORFA1LqNTBWXIdnV3vmzPuA1xpDxenozeNz073wwvtt9bHowkIT+7hPJjQccyJ/rCqgI2v2MQAQLFQKoASDPp2aOLqHjNpvSRfr7bMDOFFqe5cl9lFOIAH7cP48fzryQq5CM+0Qy6Pi4sRDYoGyJHYmTlcyReOnelu5DZnoKHeTl3gUW9iCX1/qb1x9fr0gM5yd4DLFPER6s0GD7F/5y3WEwLVm9n4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(7416002)(4326008)(66556008)(86362001)(8936002)(186003)(66946007)(66476007)(16526019)(8676002)(9686003)(478600001)(38100700002)(54906003)(55016002)(316002)(6506007)(52116002)(6916009)(7696005)(4744005)(2906002)(6666004)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1tMuuvwrq/pdEQGv4di1JlgjS7Q9kj4pS2er3jSOMLK6nW5P2ux4T9XqfrNh?=
 =?us-ascii?Q?sKAZXW3R2V0p7ImVqCGA5svBlKcKNIMxDM1AsLlh4YKZiOp9hPz49IrV0MLX?=
 =?us-ascii?Q?Wp5fIY/RsCtUvjhc6qSTdtzeOLqoFT3usl3DpSvdiajynpYNVM83wzMRu3nU?=
 =?us-ascii?Q?1mz4JWWb8AqCo0n3XYD1dGWi3F3H4Yg4VG1OLwt6HViZ9Pzm/NhUvgH4mozw?=
 =?us-ascii?Q?5ksOaHTnlGkahPJu6ikOEobXnrFtSh57UVNf0hz+RTqdTlj6cOOISH8I138Z?=
 =?us-ascii?Q?5LSN/GenG+p5CMu197GPLqC1nHdo8j0fFjBPgR4gyNNJUpEBSDNZkD/jnuuW?=
 =?us-ascii?Q?KfymzC3ZbJbSZC7VKlhonOvymFxtt9/14LB8hlNXUblw+7rB/D+V1N5SJZFK?=
 =?us-ascii?Q?wvTt9bbYZKWN0NaO7MM7xNw+rGY/yRZ3xi8KgLy8LZyz4mQWSmYkX38wsShz?=
 =?us-ascii?Q?vqfhbsgZadntN7LUrQ0UZ4HfR8DM/Iz7mqjrHZSUT/JaSpXHR1cx09yMHD1I?=
 =?us-ascii?Q?WBrTrJhNggaCtmdrKAU1+YsYpDggVhORpGozpzP+nmQjIXQ8a23Eo366iq42?=
 =?us-ascii?Q?xX9p5G20UKad1Ud01M2HR5FxB5cwdTL5oCnuriL211JAXmCGoe/pekCMvjXP?=
 =?us-ascii?Q?NS2Le6gjbg3gTq30wKL30AIampHXKlX+kCX9xatet4WKzwJzErNUBTWYItU9?=
 =?us-ascii?Q?3YNp89fwgdkq7eeNf39AfBP+8drv8ST/sZqXDGWkfdsuCf0MW2oFUrjY0+fF?=
 =?us-ascii?Q?7StWeaeeLZSenQi1XJgz7tMEn4V08Xu04G+y9p2sAhj/vdV9/MWJUxmNqisO?=
 =?us-ascii?Q?Gy5dvj/fs0cfQ++wNeZgiJufua7aoVR35UX7bWDfP2+6yFveSBocoMHwYYLR?=
 =?us-ascii?Q?V8PhaZ1L904GQ4StKXYrKM+nEahrqAUDbgCBAYdPFHHU+rkfecN4rSTXWn+K?=
 =?us-ascii?Q?6+rysxzxH+BkVSnsXJnMwKVzAvx5yRpi3eSjSL2LdUxLbgHzE4z0EpxhQRXC?=
 =?us-ascii?Q?ZXmEHNUq9U/HwYNBT3lbXThBrZGKA9/Z7+M00+jQL4Zcf55uG+pL/h4LSaaE?=
 =?us-ascii?Q?UIjNwPBe3jVanb3K/A0uUTZevPbkOKYsUTnEdJM/jLlpTuSH/pWCoXuITVAa?=
 =?us-ascii?Q?iyKfz1W5dp0Mv9pbFb2yGnGQai4sH48JrirOgyHaoV3Yhj3vKroQ1pACXq8s?=
 =?us-ascii?Q?4uBDzOOO+/ZDHFLl+/AKW/q6UkbpnclEFqwBXaCueg+Eu6jiDg+wGeFer4GK?=
 =?us-ascii?Q?LNM5p/zhAhmbVOYPlJpyIwTcXHgqiZqE9GLCZJPwHgOjc176/3Hno1/J82Pe?=
 =?us-ascii?Q?LIPqMj8snZ+Xh6eLCrXK1omE1qRougrHlNX9bULYxpoY0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b708aaf7-3cdf-42c8-9b11-08d8fde442a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:53:28.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5geoufSybkemb3JIbjPsUv1C76jyHrzswjZJEoKqZ4F2y0pV54wpFwALBD7KKLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4501
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Fh1Ogptnc5LXKpsDI0qgAuZ6pCvwX0yY
X-Proofpoint-GUID: Fh1Ogptnc5LXKpsDI0qgAuZ6pCvwX0yY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=782 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 07:18:41PM -0400, Waiman Long wrote:
> The object stock data stored in struct memcg_stock_pcp are independent
> of the other page based data stored there. Separating them out into
> their own struct to highlight the independency.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <guro@fb.com>

