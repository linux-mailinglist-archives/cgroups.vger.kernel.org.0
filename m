Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14B48B5A6
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 19:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiAKSYJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 13:24:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15686 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241941AbiAKSYI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 13:24:08 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHS5ie028122;
        Tue, 11 Jan 2022 10:23:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4DkgckKu1aYww/oMAjDAT/ZhOrmTVFeQMTlbRqBXSdE=;
 b=MtiND26ytQblQnQlBy/9NXDbH+OiTgF9FJxDzJkP0iQ5yP9OI8zIWo/ZLd8FiwSOuJkq
 fxAia0dD5sn+oX561ZAaEsKaHrNJkHAekTszhBDLTy5XCnjHUsP2tEjWLNHVWJj0gWAy
 p1cqVXFAQtHZRJknupYkpuypU1iYRVetqxU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgtps7jug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 10:23:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:23:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idZDlQNl9OUYlkxR7l7ahKL5SLhhWlhoN+Eq2eNnS5gzRhIoKTSl48ye3r0KnbflhKrIlpQcDKlvmAFRvvKluj+sX/i49BQVmz/aEePMscp8oLPRFVDKQir8aR9j1dlPUArzU5qSGjiTeCxRVf9JwYaCgK9jTQ260mL2FkKPfc+k31lmzpiiHLWiZauJDqY12SBpIJkitiQw/BeZ/vZueQnvempuT84MS5Q+1MF1027CJzwUqBQfJMl/NJgMeyQTQ2d6VtkPskltpXMrzD2B4p2qEgaw65nc52hCBmZD6W321xKYP649pf1B6da5K93pf2UP2RjMHYySRTg3h0qi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DkgckKu1aYww/oMAjDAT/ZhOrmTVFeQMTlbRqBXSdE=;
 b=mTficDk4D9CaWQKGJdgZv8airx4Tr/0RFW/L5wBeayK/MCGfVnlfRYgjq7ptnTsnI/wpKeArht8vrWOqIydDuw2zicaHm95yHte1Vsu+Yk3MjahLeOODBkavBrgtnQzOayfy0FeBril11uom2e7Fd83lQ0JA3jdKFR0ksD5TuUxixYvPjn35RTmz6wd/w+iBshnRcvC6lL/5K53s2/KTBHGwvuz32T4rp5VOV5ok6s4lBirfAHMStOueOuR/a1Qn80LR6zkNqa5HYgmYfmgz44BQIHgE+jb2So7WjtL5TB7tCXt9RklnW6Fm/9bcgxgs6NYXWT3k1dGmv8QewD3tDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3127.namprd15.prod.outlook.com (2603:10b6:a03:b0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:23:45 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:23:45 +0000
Date:   Tue, 11 Jan 2022 10:23:41 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
        <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <surenb@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/4] mm/memcg: refine
 mem_cgroup_threshold_ary->current_threshold calculation
Message-ID: <Yd3LLalWzPy17PmR@carbon.dhcp.thefacebook.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-4-richard.weiyang@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-4-richard.weiyang@gmail.com>
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4afe0e78-fd37-41bd-1936-08d9d52f80b9
X-MS-TrafficTypeDiagnostic: BYAPR15MB3127:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB31271BEC613CD2BAF8734512BE519@BYAPR15MB3127.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCng/vGt5kkyW3hYQ8vWuKUW592yJx8yGKLpQcheL18YQuUha5ByG45j6ak7IjKhETzFPlqJaT0gIShdc3dp74b0OztgbfaJRletFqTYKTmCoUvHMFHSwr5whvk3lSaJh3cc9kNndbODhFbL6f5zmO+EMBN761MsQv2ijes26JmR1QW7NaPAY+aOfSTeiEankYPQkx6wWIM5Chn5KBS1THdkqfVyVBPht9/l/HPda4MvD7jtaBU/OLrf+q5dIWuSDx6ArnzjyfvdhQkLpBLs6HY4fK+OOL+4zRvPOxNumDOQH/1+hRLxS7fvVndgMSBa1h7vDeyTwxLiOmbY86r3A44KklPqEAgqiNJLUOsjrjCOI6aR9BRRWhwvuvsqaWaSAU53hmO+gP74J5QOrDZs7l0H68fuOVL+3wNVerHikdbQlZL/CuDXzcTg00PKNd19hpXlDttbL1ys2p7Ey6h23F5+JMBYqG6ZO+wMmBQFVUg6bC41nbPEye+qpCg94ij2Vbhzntb2ehNyCIwI5usBLeYrwu1/C7rMJbJ06BquY2POcYbTNlojkEb9l10zQrBxtrsceca8tvEgkY82Rm3CkMEZv+v7TEjROp1/e/lwWCsoMIPBUDDethCDdwYxmEO5/Omxw6tiO3sOzftWseYi3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6916009)(6486002)(52116002)(5660300002)(186003)(6666004)(38100700002)(8936002)(2906002)(4744005)(83380400001)(508600001)(66946007)(9686003)(6512007)(6506007)(4326008)(86362001)(66556008)(66476007)(7416002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dDOyLYw5MJ88Jaw3ySUcJLml/tJ0ppiID0NKHqIwVUupJBVG1lk+62J34pXR?=
 =?us-ascii?Q?RuEyRcMfX96LTbzmoNKYXXg2mtx79usIR00kow5C4CJSNHhsHH/XHAx7YSU3?=
 =?us-ascii?Q?CCBgNAdVY2XraRxcNmbUzcVgWrT/+MIwalc+RlI+8YwNbuNXv9nckIjCV7ic?=
 =?us-ascii?Q?+YEjiIigyXEHvIx+Gs1zq/ju2LWa4jbx+13R0ppdev+gwmh4LuYzdTDIFM84?=
 =?us-ascii?Q?RcFML/wWx1wQk7Em0CjCwT2IVnfbTuOTP9oUVhR61/ONsY0vGYrvzd715Qdj?=
 =?us-ascii?Q?nUv44k45JInKCzyZ+zxEJiARXlSNWzb2DFy5aYLkqNegWzkRmrB5E/JJ5U6V?=
 =?us-ascii?Q?KZlAg39kodtI/9hbIR35Y21F/9gs6dV0iEQI/xctbouzQEhYT40TPjJ45hL6?=
 =?us-ascii?Q?n3GlvFhHYugB7XqKKKfZp5sbBwQn/PD7dO3trHdWB4snDC5ePTB8UySs/LPU?=
 =?us-ascii?Q?JFH14XfwpU1djNBClzqh8qfgTDHEZnP/+msMtXSrTLtOCyJv6/PCTvxeokXV?=
 =?us-ascii?Q?vWVoGevHNwiGACak1FFPYNyf5GxEAMjCrOA5axluIHEW4VYahkrGWINk5V95?=
 =?us-ascii?Q?3dpqQGpNdT/qHVxXxwki/hcpYZcCB8mf8OC/csOWnk6rRj187y0tnThHBXIa?=
 =?us-ascii?Q?01erVeIXK4b6e8T7loXg3f0wSvr0c3ga0dv4ud1lZ6B7yZOqcSjvMP0BU6/C?=
 =?us-ascii?Q?QdADbRYwsRFrFL8/JFCWa5kkMsrgMCrEhkAUupBdl61bClXWqDhrNoSQVN7s?=
 =?us-ascii?Q?G03z4lr0thzqXZxjPjoxF6OEyXYR1O6JJMhoiKNh3Xj8UrBtXJelUticeURv?=
 =?us-ascii?Q?4mBJ48Ir+S0PwQ0tvsB3k6YsGpTCgTcDQOddcfe2Qu29NjRpvFVvkwI+pEin?=
 =?us-ascii?Q?h/y8LtHuXGcyTywCWSvf2MNHAe8fG7TkK+4gQbbzf2ixpfE85qKHDN3GkJHe?=
 =?us-ascii?Q?feOp/I1jEWVI2JrZ8Evfh2LcGPNzXHW9tvqv1TErWaJX6Af6Kj0WNHwJq+Qf?=
 =?us-ascii?Q?ZS1nKkYamjc39W1k/UUhwBETpO46bgJPscDuNYOXocQ3xfRtAz9w14O9rPY8?=
 =?us-ascii?Q?SBYx48Ca/kTCLxrCaXJd3LqXtuqNx8ZR/Nl8PaeoAZovod8j0jJU6PFd1PsH?=
 =?us-ascii?Q?wGX1uRn7ATEt3VSnhzl7KRLySXI38R0LXd8tMptdJ8Gg9ayfL0+7E1at3DvM?=
 =?us-ascii?Q?SbuUUNIMntZF3BsbaGS/eOyA8GO/HFzzwQiCN7TdFKy7wDfzi7zzSu/Rl1kB?=
 =?us-ascii?Q?WVtRNCTxGsBuS9YdBAVauK5Zt2E4Rz6dfZrTGUbaYPK27RQPSWezUHToaxhH?=
 =?us-ascii?Q?DBPklEuQLypszFdzcO1DZkeKh9IKvA4qhMAVgAORxGUNrtOwtw0DxGK2Dpjn?=
 =?us-ascii?Q?25Gi/62vK98MPMjo35FTNo8BaJkGfcBOiZMA6e9r7k0ApwcMMx3S7fXuV8vp?=
 =?us-ascii?Q?RustIS68+V/2wOEbH0XzsVo930JQRTXsk3Jvq9zeqv/tkhl8C07lwrXNP7PH?=
 =?us-ascii?Q?QJ8DlQ5mDhBhkERkYhUrV3UYze8EZgIyJizfvJLT4yPrs6qZbJVdrhf7Pydg?=
 =?us-ascii?Q?OCkY6I+k5JkJGM6Bv8Kk03EG0BMUsg3w+cGZO6wg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afe0e78-fd37-41bd-1936-08d9d52f80b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:23:45.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3wPxqY5wE0tLoRiQdULu+PZOaS2rgYhMIbRJhJIChIBcjmYtpZG/oK1JInLpy6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3127
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: pDyiSlfSajJ0tXrLD5wyRXbXknqI_y4-
X-Proofpoint-GUID: pDyiSlfSajJ0tXrLD5wyRXbXknqI_y4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 01:03:02AM +0000, Wei Yang wrote:
> mem_cgroup_threshold_ary->current_threshold points to the last entry
> who's threshold is less or equal to usage.
> 
> Instead of iterating entries to get the correct index, we can leverage
> primary->current_threshold to get it. If the threshold added is less or
> equal to usage, current_threshold should increase by one. Otherwise, it
> doesn't change.

How big is usually an array of thresholds? If it's not huge, likely
any savings won't be really noticeable (it's not a hot path and there
is an rc_synchronize() below).

So I agree with Michal that a better justification is really needed.

Thanks!
