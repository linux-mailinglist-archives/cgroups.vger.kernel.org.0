Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6548B568
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 19:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiAKSKU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 13:10:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350401AbiAKSKR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 13:10:17 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHRLMx023785;
        Tue, 11 Jan 2022 10:10:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=U1FW9R34RRwKTnQuKIhL5KdS/m+UI9gJ902cIt8RJog=;
 b=EXJOQDz5wR0jxE7ikPyQIN8CAV5Yhr9J83RgymFyYXLvKppFmsXV1F6OEwyUlKCNL7/q
 ZFuTTaQCJp4lDfPp7WF/4hlwIKc8wlyvBPkxpxG50v6lH68bCgaK+wNWlkHxtDz+jj83
 3NZPQKSKo1RODftCZHccDwEpCld6YGMNS2g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dh86j363v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 10:10:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:10:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUKWFAblm2D6kDeVCCO209pTIGgX0SeIJ9GFZDve+Br8JNoaQY2U6NKaLmU2SnDIABabsE+/FwOx1xUXLttOtlnvgER3SZCVMWtIE3d5BDrbFWgpC0Qftvxsjs9lgkaaenbQaumuaueYsBKzeN9VIOwCsp0F36b5OA6S9eJeOVfzTYKoeWvJXjF645UpVp4kAzW/fsocXMlm3TwfzVKm+i9UWUVLoX+ltIUgGLCB68lkH01FxVjS8vNYTAQum2ww++OXNbpSbFqA46ponT07OXjXv75Z+dZL89izALz6NESQ7UEkvoMudw48/pG75r0kCDxGfRNa5sPgIxqoizIxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1FW9R34RRwKTnQuKIhL5KdS/m+UI9gJ902cIt8RJog=;
 b=EiXYb0CcubwOmfmhRF9+zEteCTM+N5WcklpCDfq4bFHLiLBJs4MXyYaq+BqCdlrDyw/ZWhtBCkIbPAqBJIZ9dCka0yCxu+jUwW5UdxZYlRoWzFTSdfGoC77n2z+c8Shm3NCeouirV9n2FxAIywjON2tzxfhiCeB7w+RfN6ZF7nnDYJn5l4YlT8kf0R122vbLeTTGAgVVpT3kpcH3pMyQSFh48Qzg5PKpHvkStNtF1BG3WhrHqMFKCooBofWOZPUxqoJhygPOSVooS+tCAHkukUNv3W5l5y+bKPtrcOEeyrUnrBGAXm+AjCjdKYkaMxMtcZ80uJJe4QcHbsNP6kbYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 18:09:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:09:56 +0000
Date:   Tue, 11 Jan 2022 10:09:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
        <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <surenb@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/4] mm/memcg: retrieve parent memcg from css.parent
Message-ID: <Yd3H8Hea6dBlkzeW@carbon.dhcp.thefacebook.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-3-richard.weiyang@gmail.com>
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47701baa-87f9-4bb0-35ab-08d9d52d92e6
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB2759073E5361996AFF472E84BE519@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vz28BZoOQnYNanfS6glOtZ5ere+5LNCFtrrdD+m5AeCjuKBYcOxSVXbPuspl3xPEMg5T20+RcH1nHN2DV46WXVrux3mvW53vTAE+vN6IHF9Y7RoK27P0W91L253RMl1cTWrEVLNbzS3IvylT/8Y/FFr75TzJflaXVaFDKO3NSMuHNBRkAC12Ou+Ps4nJXaq8BAVDS/T6iuJ1GhmWUnH+8VCPFCiR2SjSVJhT5paH18uj5S4DtnQ9Mg2rCBB91Ml7iiTnswcj7+2BXpQgpM3g4KfQIQOH6GAnMZ+t4ZkNoeuICjI6UQVoxDw8Bux2toQnmrSecNxKLAJ+Mc3zbgF3cWD7/Pjt21fLRPO5n0zfL/HxGl6plODMFDMuheKAyr1/UQfRMyPJl61W62g5DAl+DJsIn+RsLB2+jFxu9w9bEe5h9xwWdg8Z4/Z2IPjH5ZPi10yayBVxiCV2M7UIK8WzWwr2TqXuUwWM/FssUnkB69DArwmRX6C+kLMUPTwq5IIT2hbebnS8KiQM71IROQjDQQpnfjvpFqK2wdd8sbmPO0b0gVQ72WBmvMZzsY5xFQauP3bKgLR3NHUjwUYtZT+QcszmtRu5yfFx0KUVVY9WfvH3HgvD4R8HyhH2b5lltx4FLoBJ74ltGzKFCvN8DUrR6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6916009)(6512007)(508600001)(316002)(6486002)(86362001)(8676002)(52116002)(9686003)(186003)(4326008)(66946007)(5660300002)(66476007)(4744005)(7416002)(6666004)(2906002)(6506007)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/R4Tji1HxQNZMDhjuqAj6vawx8P7kNWmRwxJiSb06sj7fl1K1/L+dVo6q/++?=
 =?us-ascii?Q?IXb3DY1LQPWq2XUBbSJhlbUupWB1pWmu/zeiR/dbbuItAJ8I62bGhahYbvOg?=
 =?us-ascii?Q?UwLgc9PdWx7XUiNgLz0mCYmOAVLsBDbxR0pkN7aMrOg+vfL56CUy1CFFmcwS?=
 =?us-ascii?Q?rmaQ+/S8tXlurivHOmr9UF5/OPbrLnAtBGocO2U32dpHIwjpaE8CLwjzIu+O?=
 =?us-ascii?Q?3caZ4Daxg1jZXqwwDtzcXImBrPST10HtI51Bs2jAxpfdos+SJJafeGk6T6rd?=
 =?us-ascii?Q?QMfmf46PEWuDw4icWxfvEsdNK65/ZVzW7nn7RTKvzexJvJERh1UF8Fqmx92j?=
 =?us-ascii?Q?E7Ska7Lg1I/5MnuE5eFx1FegUPFymPLUP9ikS1mQh3d5Jh8zu21x3mh+meNz?=
 =?us-ascii?Q?fhXv7TIX1Qd4yY6JXhX/K5hRwOlM2j+xSpTnQMtWbebhhI9Zj7YWNwJ7cXOt?=
 =?us-ascii?Q?jQFydeeLq7gZ+LldgqYrKT6EcRHHp8QJlK5KO3Ueik/MvktR1i7P0xCoCwM8?=
 =?us-ascii?Q?j0aj1E4/murlLA0C2ZL0qs1WFO92+g1eEgmYTCoLFCPvwsjzjAOfZwEPrYUq?=
 =?us-ascii?Q?KA4zbMuFbPmelse5LV2WpDM/ncY+BOvhdvcjS8jbIcoMz0lSq/yX2qNt8qEc?=
 =?us-ascii?Q?LkmvObNTdiZpLFwwQJq+t2g6D+GYx+sNMr0BlN/7y38AIMo1+J4PVhu/aQM/?=
 =?us-ascii?Q?Dog7Jaijzenef5i2iFxFRpRHLfayDhTUrkGLphOv2/IfmaAAyAtqMI/BiIGG?=
 =?us-ascii?Q?7mCHFMoYZrX2bFY1MXJOe7SgTwAIIPu4jSXOuYyVZlwQTcWKN52bZ+pTNw9t?=
 =?us-ascii?Q?dpkuK1JAJBK0htCeKyblmIRqGXhUfsNlnJ9oiBUxRbMg9J0aIQ3dAnH7dvdm?=
 =?us-ascii?Q?uMTa67symO+7q0EhwLZ9CPTPZg+Dfxwb2oxH1j6aCPe21O2HxY5hOR7v2imP?=
 =?us-ascii?Q?rZ2HVimY0ROrDb5KW1xpkDsgFyhhvtZegLJ6KiiVv/A0a4TdthQnc1kj+Q7W?=
 =?us-ascii?Q?APmnZyODuAmBKdkIwIyp/yOioGeJvRTKbe/T7d3DIV4wVo9cOoKMfj6FBNOr?=
 =?us-ascii?Q?ne9TveZz/VAj6beZ72VLxSBZ5FcYQSlWSxvUKsB+/pt0JbKCqJuhB+NjPu2Z?=
 =?us-ascii?Q?uzhSSxI8+N7fpHPZGYQ7PJ7RKOV225taN4/7MTh4V2awpbjyTzm4npO7L3O5?=
 =?us-ascii?Q?+jhiXj3Z5KlBajxAlzDugRU4bPFxupuzlEaXPW9M9DReU7R2bxiV+9p8Ws5+?=
 =?us-ascii?Q?53sJ0XqjnWiywQodLLdH40Ups6rSMji1/OHJSjqXXdmqjmkqHFnjBmjhPpmG?=
 =?us-ascii?Q?+0ChoVMN95YVP6nQS2PYvD2seGmMdk0xdnM2k5ONLj1FNAe/pYduyvgsRuyw?=
 =?us-ascii?Q?vjeosPU7FOB9oEzxA/Uw/kFo5nz+4BavHWTlwhGQPogz4w4GREf1Ssspz3kH?=
 =?us-ascii?Q?M1OXLB5lUmIvCor5LAnRVvYOwcvQq7QcyGvAw/Nk05WMBa0OflmeilGcn3oU?=
 =?us-ascii?Q?Z6VcTVNZuCi8PYJCVcTOyJFyv4ovpuucYi5ze3HWT2vKOfIW6oHT51g4dLlX?=
 =?us-ascii?Q?DBmyvj9bIak4JO0GO5NLBwqnpNJ1di5DjBn9gG6L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47701baa-87f9-4bb0-35ab-08d9d52d92e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:09:56.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlCRZFv+QNTR0sQ4G1frSmijlotVtu+v+k5BNnV8sJvXXVscOsfyIS5k6Lb5X/kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9lKjd76Xez-u5qC1ZY_W21HZDmJNXl7x
X-Proofpoint-GUID: 9lKjd76Xez-u5qC1ZY_W21HZDmJNXl7x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=717 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201110099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 01:03:01AM +0000, Wei Yang wrote:
> The parent we get from page_counter is correct, while this is two
> different hierarchy.
> 
> Let's retrieve the parent memcg from css.parent just like parent_cs(),
> blkcg_parent(), etc.

Does it bring any benefits except consistency?

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
