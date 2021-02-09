Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E22315784
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 21:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhBIUK4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 15:10:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59544 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233781AbhBITxR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 14:53:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119JFcig014002;
        Tue, 9 Feb 2021 11:20:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=TvFQt/37N+pab5u4BkJ+omiVcJ0zEeZ4RjfMbC/IUVQ=;
 b=bckJodcqj+cA6C24L6fksQywtXGtRRdTNgB9yyBJpLnD6ewAxk4/N10Wme0EkDf9IWeH
 nPm8oCWoVjwVobZh8SHCP3ivoAUHx2dPa+9wK12CU6JxSWPLugc+rRhQDRzoQMAoYadY
 +1jdKSjTbeykCZU5veZ+wSmtIMZhOGwVEaM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1un44d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 11:20:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 11:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWZ6BK7Wi7/gzMOpb4lkiz3XTJG6DqVbmE4lcuyRVE6B+3ehTzwSn0mBJklg393z1GEFYjPOsY5s55LZG9kvlAwKIjriTAOS074gWkfwYGu6Bg3wOWAJlUCkHKWE8AQjj8HKFfhNaovDc6AJDZ/TC/g7DHtKkY6vnoIGh7ih866ssjvyf4gbrHjKC2sOgTiMAxyyoPj/GniUW2FH/BNU7kD5cijQUS1bXZVG6OUK6TTEpJKXzybnMc6JYaFJItK+674vpdUuiL2LoJFyGJpvGztcNnENkAMsa8AxHuX0PgQk50v2jtARuhQw5mrtcp5YdUY0l61nEYJDctjR0F5iEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvFQt/37N+pab5u4BkJ+omiVcJ0zEeZ4RjfMbC/IUVQ=;
 b=ocNYR8ehXvElUj9L+GCTV6UddPMxVUznTM4SyGUd2LC9oBiZMULtwPJKJNzuWQDMoA4wWmgbvc12dJQUSX+WCKzm+M8j355nM0ieXOXitX9sQ8hUFUHIAWWyAVfXY53hqqayOl6CVH+RoxyrJOjEVHeFAbIVPYgOCGJMG53McPczG5n06ZWBViXcWL6mtFYsxA2S8ckNQcuooWwD4LopI7X4h2KtAkipc8lvFcgkCN5uiSuuMcdRD8oSnSSCLoSZPAsb0vc+seQg8MP4q62uZ+9GVtA2eeSa9q2a1t+yS8EUuDhSL+LBuqedyjJUYXQQ6ojPzRo2fINgqObc4CbjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvFQt/37N+pab5u4BkJ+omiVcJ0zEeZ4RjfMbC/IUVQ=;
 b=BaOhtVbAMFY+oUEaiGWTKKFCP2WOYi/zr961K+A1zvrGfiuAc26JodWUo3FFRkUCNttIp/Ve16FVd3J4gBdLscgz1BBomFFsSSCj4qUlgXqp50Is+BWd6dNjPv44Xwo5pOIC8jPSbf/Za202MlhiySymPtmqHwy93U+MI1/TwmE=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2709.namprd15.prod.outlook.com (2603:10b6:a03:156::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 19:20:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:20:05 +0000
Date:   Tue, 9 Feb 2021 11:20:01 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH] fs: buffer: use raw page_memcg() on locked page
Message-ID: <20210209192001.GA524633@carbon.DHCP.thefacebook.com>
References: <20210209190126.97842-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209190126.97842-1-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:c244]
X-ClientProxiedBy: SJ0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:a03:333::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c244) by SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Tue, 9 Feb 2021 19:20:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af9bcf2d-29ee-468f-32ed-08d8cd2fb46b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2709:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2709EF3B9E55AC174D390B57BE8E9@BYAPR15MB2709.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/10iwoPuT0A0GbwQQ17N/zen9aZsBIvQY+cBUG5EYzvRXUkMRrwKPkfL1gtywjgBu3x2qroZHLHrXA9GjZN4jFGpspOqgtONzxwsCdJJlDaKaOlG5hK5RszTR19W0Z3KLVYTdSRW5jZnWUzj8Tbv/5Ye2mjoMyXPXwwS2DzTisFFCjZyxUXNdBKUu6VBCPzt+D1Q3/XdZE9N8MrRqjvWmlSfkRIQBNCYB3G+RXyuLoAsd6NBHvJu8e+o5g3Sr1jkm7YwkX8EY5eUhlzPD5AYOh5n3BL+ZFrTqIEZkGcWOgmEJGB63DmIKYMLfRI411iUgowvb8NLW8KoGU8W84jzzYMOV2kvx51tIT38RNJABhBBYcvq9v18AnNL8FQoy+PZBfKVV/I4SJNx2jOQf0sBXXgtdW9WZ61Or2ML4gyfvxevijzejXYiCWyJC9uWWGlFL3IvH9pC8hlzZBbIR/was5jS9xGfzcnenkMbxEVTUrbKnXCF1+BKJ7/0VZruiFSAJANF2nfouIoqfA+nV9meA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(7696005)(52116002)(83380400001)(86362001)(16526019)(186003)(5660300002)(1076003)(2906002)(478600001)(54906003)(6916009)(4326008)(316002)(8676002)(33656002)(66476007)(66946007)(66556008)(8936002)(9686003)(6666004)(55016002)(6506007)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yh5qEMZNtK2iANA8O6B+fIgbIlIcXU0PMvG2mVVbi3ypbpV1QhwuXjV9gyiM?=
 =?us-ascii?Q?lJeeuAF+w05hKLsmgEmlTIpdDHRIiU+IjcR7p8UOeUf6F14BF1xYeA9EfEbX?=
 =?us-ascii?Q?abFGW/uEFfPua6ON6Bibm211sNGDbMyWnjr9xdbfqKeYgzuJqOuA42/8H8on?=
 =?us-ascii?Q?yA9ML4x6Psw4QpkFvi43Mi7LVVDql1tSAaelRqXahBPBlDo+BaXK3DhHyCIg?=
 =?us-ascii?Q?jnvFpCbJAJqWaJ93hA4oUgw9A3e67/aH86nGM6LpRFXVud0DFFFyI7FZeB19?=
 =?us-ascii?Q?rYFIl7y6EVsyXHd/eCsOqJY9bniSd87kzcsgE1bRsrkfRf1uFFtabog8Sqlv?=
 =?us-ascii?Q?JAlt45rho4/gehCHMfCkojeiMIvScouPR4bQ/NkWMf3PQChkkldLxjSO8rKY?=
 =?us-ascii?Q?D9h39R0KAsO2rtFmzx86D51ET998tBtByu2admR48o1/Byn3MxYzWVVztLxo?=
 =?us-ascii?Q?JbsEZ4wTJVAp1epmB4d5XQ1K4KLnuaFB1NRb2ClRV6lRmDIi6VHU3Vy8/ZlG?=
 =?us-ascii?Q?JJavZBfGKmsDnVSj4us6IeYE6IYcFgRXAtn+Xwqr5otwO4AtGa5KwygoVC8g?=
 =?us-ascii?Q?1PpmRBS9G1TSkO/okOLCUDMer5P4G6VVwwcIo/cGJFkZHMcD/7/xIuCQSBhs?=
 =?us-ascii?Q?fLPC3hNlhz8T1aVoZCPH117NRFosiWfbRyxyU9IlVLOm+Mts4d9bMYAK+MuX?=
 =?us-ascii?Q?LMbcEw/o3Xw7dCe88cQC6LKa9wuBVBRuCDgW230l+4Buw5OAfJtyvc+0VVcE?=
 =?us-ascii?Q?9ZJAC01l1BurSSZVnCLGsRoZL1stBMDf65ZJLv3RhkMrfOwSFQNQs1h8J+UT?=
 =?us-ascii?Q?WoU6N8eKNDyHrNcV/msuTqsENIrypWz7SbzFwf5Q9pQMpGeFOQAPPdqGDW3m?=
 =?us-ascii?Q?fNPlul6iZrZiMoo6PZ321OoEvH7uN57YkNuZ7qEqYJrJahFn/SQMlvkObS+8?=
 =?us-ascii?Q?UZlsil7OPCJC6xH2bPkFjg4xD4dPlXr/wnxlHrv9Uvo05bCemydZukyQDL2q?=
 =?us-ascii?Q?Bxa6U+BU2X+x7L/2mcNZG7p/NvYz1lzSffu+007GqCiqo08E7we1R2hHdAF9?=
 =?us-ascii?Q?gR6W3ZnFwEnsdTHsYNZR/nCyh36z7H8Adgw8akDLIL94Qg2oS6nCSSEAm2sO?=
 =?us-ascii?Q?QV+rJ9WK0RrIPZaHOhuEMT/3wLmKhVr5XlKlE48aZv5gAY5ym5mKhbj4Rcik?=
 =?us-ascii?Q?Z6bmvP5/41BEl0K0RGvTFgD6U0hl5HJmDXtvN46mmwfIywH0MKgNflKcJmJ0?=
 =?us-ascii?Q?nxLa9dVxXS+LZYB5jwCveCgbkNIdmBI86O4AEwRiRN69WYjvymISL9uNgxV0?=
 =?us-ascii?Q?a4zVU+EweKkILvqSUDfrHDt+AhH1Z6g1ibR6MmPxHAisqQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af9bcf2d-29ee-468f-32ed-08d8cd2fb46b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 19:20:04.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJdjwHUI67EEnvT9kAakVBTY4Gf1Mg0ZF1Rpvg1rLOOTJHmbjXQ6WRHc3Vpo82PS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2709
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_06:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=690
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 09, 2021 at 02:01:26PM -0500, Johannes Weiner wrote:
> alloc_page_buffers() currently uses get_mem_cgroup_from_page() for
> charging the buffers to the page owner, which does an rcu-protected
> page->memcg lookup and acquires a reference. But buffer allocation has
> the page lock held throughout, which pins the page to the memcg and
> thereby the memcg - neither rcu nor holding an extra reference during
> the allocation are necessary. Use a raw page_memcg() instead.
> 
> This was the last user of get_mem_cgroup_from_page(), delete it.
> 
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
