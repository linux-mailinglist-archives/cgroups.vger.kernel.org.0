Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A1330FBBD
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 19:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbhBDSkY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 13:40:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36474 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238874AbhBDSii (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 13:38:38 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114ISpWu009686;
        Thu, 4 Feb 2021 10:37:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=I+wcMkxu1gHxvwkIdOKsW51gMV+OmCz66XS8BFzjvio=;
 b=DMipOF940rKIY7luBNZy3ohCcaR/lnZSIQ612+Wh69Gw5sqjqO6hBLBe97AgzSb9WYkW
 IGT3NvxQ+3Bmg6C91tr38KLGRA8YnhvYBfHpNzDAjjo+mDJmZV7J6MCk+pgbx/K5PMV1
 EHZvQ3r52BEKvoVe7giQ0JZyVa683KRSrho= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fx4nqsdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Feb 2021 10:37:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 10:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJhKJdz18xdBzdwCs8KELdUqqcrtEZw2Hfjs6jgd6BKCuz9Hhre1zKL5OjRv2nE1BKFO+4p46oVhahyc52xYJTiORjEcyhRbIQFY2WrT7vYGsnaMuAg/Bn5vTDE7FXHAtB6lofSfWhhEz/kL5vWhxuahDch1ieJMU3LPyLCGH81dE5s+XUVdjuZ4sP0b+p/RnHP86/rn740HgGMutemmS+4ko9lgxFwu7der2AmApBNNvYD03WnRsK0kZjk3fu5LlBR5A44e9ZhjXywLlyeTg/2Eh5yyat/VyJ5K356h21fdLUFzvsaGgFYdPal/VkHAZ+vOAz8td6PYuBUa45r29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+wcMkxu1gHxvwkIdOKsW51gMV+OmCz66XS8BFzjvio=;
 b=dA69uvi1fQgEjzuXyFYoZS/S5to7LLvE8lJVgD4XDXAeo92NwXpstGkH8rvWbVsQDLdP3E3/WqdaAhQcyv/Zpxh2hnm21Wx9jwmrJYYmrpuR/nFgbm7MZiNpumEERFOjJZXkAGntKdSJJc7XovJIcKvyIQzYOeuoGGEoDvyrtHi/xfy+jfpdqjD6qDLE9p0hqDTQAopfDW4z88Zk97VHZZn8LTbZRM4kI9YiJe2vcGv1I/xLWWZKOPHnr+k4KApoIzX30R+iUXWaDC2XIQSXjIRpf9+EFexlw9wjOzgYfsGLqJxsjFTL0efOAEkM4l94BJh/iA+oJ4tRpoYk4I29Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+wcMkxu1gHxvwkIdOKsW51gMV+OmCz66XS8BFzjvio=;
 b=HNY5O6zS32kjp3jXkpXafmnSlBjsRLO1iP1hTirncRSpHgDUDOtmQaW8GAUxYXKzFWkI0wGNUuinNrPsGxlSRPpvHphTGgUGc1S+rUNxCT5EZT9J8cPNj/dx9+Svt9ZrT6J5AR75tw4OJygoip/a6TsS3BSpg9riQqFMt9fZIds=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3286.namprd15.prod.outlook.com (2603:10b6:a03:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Thu, 4 Feb
 2021 18:37:47 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 18:37:47 +0000
Date:   Thu, 4 Feb 2021 10:37:43 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memcontrol: replace the loop with a
 list_for_each_entry()
Message-ID: <20210204183743.GB1837780@carbon.DHCP.thefacebook.com>
References: <20210204163055.56080-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204163055.56080-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:b3b1]
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:b3b1) by SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Thu, 4 Feb 2021 18:37:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c54c98-d99a-4fbf-5a0d-08d8c93bf7be
X-MS-TrafficTypeDiagnostic: BYAPR15MB3286:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3286F3AB6DC40F9CBF66367DBEB39@BYAPR15MB3286.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iha5FZvqO9kPaDuw83o9oEqleltx2UvNNKs0ODj4MDLjwLOdndFaZckCK6o7QHku49zda0gNrL9M9uKf7PUAgl8I5jsnYdutdSTX9YMHAvh2I0S9Yn4Htu84k6ZHBaEUX4uyKSJ5IvMDuL75RwLbq1EkQR0jK+wkT0vYmn1/ijvQYuncvoO5z1PAu6S4KSbXdeH+kjXN2HQ9hklpL+2pjttxW9747SupqSwYyeQ4GHtFA4WYhcAyeSLtNuRvC7DX0RtBG3Mx1Q0kbPLTzFWthg0YgoKxlrfBdLTRW8a0k0o6jzzrSILM6RpWb2Y0ZjgjyvPObHvPM7fO9wfhGXgQwFn4uSVHXeKql1VeAraVGnL1cgwA9t/SMS5QuQ/8TMilBN0szd8UwLd5fsjSV22REYtIHn3PXagucYr7yM2sSh2zSXgbeymfacL6OcwZ94FhpJqLi+WKTFSv9t+AKMsMGZfRhZz5Mvm1fM5WJWBL2n4D+lfUVboadmwLOUsCjMFoYAqVD0lIpeFL+6YGeQj23g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(66476007)(33656002)(186003)(2906002)(83380400001)(6666004)(7696005)(5660300002)(4326008)(52116002)(55016002)(8936002)(16526019)(1076003)(4744005)(478600001)(6506007)(6916009)(8676002)(86362001)(66556008)(316002)(9686003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?e99Gtp/iFY0ejctUqPTgFk1/20Quq3i8fiLgjf0KFx2evjh1K4DOs889tA1B?=
 =?us-ascii?Q?npFExTdN5c7d1uwxZpJJVrUl8C2ZDRcVDkjNg2oXPrabMnCdpsFiRQ3v6KwH?=
 =?us-ascii?Q?eBvdGyv8ckT9Sua1dVCEEKcrUwjisUlW+NsmiAEZqzQcv3njpEibYn9d3IUq?=
 =?us-ascii?Q?NlJm1DcgguusEIK9uUHPFlggLZD8I2KFM6HR7ZUT59ev3cQ9rJPuLowrCars?=
 =?us-ascii?Q?XAY/tLRfjKaMjqiUt5VtEzXsdaxfBM2BQiD0tew0BY0YwwK/XiFR5uRlgdXM?=
 =?us-ascii?Q?lmoGGX7PzXHhNgQgNkXcgwc4y5kBpZzCOKPkamQxXy0unmNS5QekczeJyxmi?=
 =?us-ascii?Q?2w/pVld3axdZ4mPsn7x+pA0aGADiyBXTWirl8M2qBF1GMuGCEGYQ2mnG6Jbu?=
 =?us-ascii?Q?E1n1YxXS5yO9RapvJ4pi86wJ/MFbMyDSX407Tieq6wKzYRXeqLOsOmfDwgbH?=
 =?us-ascii?Q?VyuHW0jKp/hJbj69/n/DtXe3UVTj7vteyP/TEA92XeXYbcBOtkm4ubLZGya1?=
 =?us-ascii?Q?/2/eEH54WLrfVAE9ScLqXzXB2XPeIXQVtKEwcL6RH00iKvkmizpmEsT8pS/9?=
 =?us-ascii?Q?M4ax6h6ManI8lfPnijS/BtKDDBj6558Oqf8ZJo02X962r/NmEz/lIfbYW4eU?=
 =?us-ascii?Q?4hqQOkJgCJx0rVqSahk59FmRo5ZLgSxcldlphN5BoZ7hbwN+NhWCYzO7N72B?=
 =?us-ascii?Q?ifVjnsBJGtLi0T+NU2bOX/7TlcUVsGcnGgI64gxNnjBRVzy4Ue1RC89INkip?=
 =?us-ascii?Q?2s8lffNoIMZlCA++VezLFE1O+fMzr87JeDLTiGyqlm7N2I4TOilWx+r83LOm?=
 =?us-ascii?Q?+L4C/jnFrAGCk22ka27DedZe7Ku9rbs4F/uHjdmz+tGVWUInXCDqWSJlqox1?=
 =?us-ascii?Q?HIGUpTKelrmImCjo008PQ5AAJVOANm6vaSa6Vk5PsYBU3u6xoXBLbLieGHrc?=
 =?us-ascii?Q?JKbRkbN+NBrxz41+vDELhAHlHCn1z80pI+iGxyS3FBXVO0E1frx4O4tYqVI3?=
 =?us-ascii?Q?NMPKKCPNHTtFbhqBlKq/Wtpz0Qh9D5Es5oH9W8knNsXJ0vkDbg+NGlU3oSDq?=
 =?us-ascii?Q?LF/cAVajzcIQxx30aSzKubR5DS4GMFrKn2LDNk662rMk8VlpJ4M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c54c98-d99a-4fbf-5a0d-08d8c93bf7be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 18:37:47.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjCrwmhI1KgK6M+eh+6frdv8UxKoBIZc4oKsj6+1C2c+ejXLiPZizoFKYINN68cm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3286
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_09:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 bulkscore=0 mlxlogscore=644
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 05, 2021 at 12:30:55AM +0800, Muchun Song wrote:
> The rule of list walk has gone since:
> 
>  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> 
> So remove the strange comment and replace the loop with a
> list_for_each_entry().
> 
> There is only one caller of the uncharge_list(). So just fold it into
> mem_cgroup_uncharge_list() and remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
>  - Fold uncharge_list() to mem_cgroup_uncharge_list().
> 
>  mm/memcontrol.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)

Nice cleanup!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks.
