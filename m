Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737CF35D00C
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbhDLSLF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 14:11:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59582 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239584AbhDLSLF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 14:11:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13CI3N7H016151;
        Mon, 12 Apr 2021 11:10:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=weMYcAe94mdC/xewN3/3e72atG668XwPCObPWeBweY0=;
 b=EMLq6T859mVY62rS9tY8wGrSKhTjGui6uE22slhrhj0COu7lmuWD7IlodGxMOLy1GRIH
 aKfATAq3of2+LdFUfuophL2P9/Jg5xssR+CGJNRcPq74AnxhxZAkcKPsUKzEEbqPXEbC
 5yOdpAwOX0P7IyQ5A0FOyUpEAh2bPrHFBLg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 37vkb2tnh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 11:10:30 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 11:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+0D+fKKZ4zLokO4UrsJrTVpMM3J4AtnhfFc2nz8duejK5mNKNh8NvDJ86oi3kpUt/5hnp47qg6iA3YnNpy0DvE29Hm40CXUSokVs5tBoHdmu8wn2bh2T9EVPteo+V1cSQjY3eFeVTcqPaM/BSNLKQywOGsAI3oGZnEJjVHxfUVVKzd9DWp7pDjbYn0+Hazweru2WQAfxM0HcUtthf1ifjEVtqAdELXNioP2CozGTnzRjV0pTgj46HNFeAIE8xzDPIAVpkzDANVGMwlC/hvXj4R3kpRvVLwGEAag+ZpATAGfoDDLLjM02ZkNKaa52n+Z7Kx0y+hdpoRivWBAaIXR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weMYcAe94mdC/xewN3/3e72atG668XwPCObPWeBweY0=;
 b=YWpYlktFAT7C9Zb80zc5DS/uJ+kvhWGTbFZUFNt6w4RH0ZEjyaPyiWM+xJ7m4AFg0HGCCbUkCpqRDB3HRpi/S2dCqascaQLBX/YYryyCYfEdgLXFkxFHa8c5yFGEtDAlH1z5S00cqTJ5KWD9gHZw7FvZ++7r8tc9NdDJG5twlfqfKlf/YS/pF2nwQgcJzIq+ahQSlTdNea4auAuclA5wk7yBhCCy2LPWFpui8W2vsnFnihHubaZgTLZj3Sh066e8vcWALC2cv6Q2ACqRrXmWLN+2ZL3FTObKWfY428hKzvLzYZWxGx7c2OGyBvNab29s141rJnAhfIRDFVC1f0YH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3224.namprd15.prod.outlook.com (2603:10b6:a03:105::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 18:10:27 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:10:27 +0000
Date:   Mon, 12 Apr 2021 11:10:21 -0700
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
Subject: Re: [PATCH 2/5] mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
Message-ID: <YHSNDaPzyQJTt3sb@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-3-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-3-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:ea4e]
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ea4e) by MW4PR03CA0125.namprd03.prod.outlook.com (2603:10b6:303:8c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:10:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22d5cad6-b350-47e7-f962-08d8fdde4019
X-MS-TrafficTypeDiagnostic: BYAPR15MB3224:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3224F550352688D3EC887B63BE709@BYAPR15MB3224.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyw23JWYMosfgQUQXPwvrWyMItGtjMaCvXghrSI74QUAVTHcx5QzNwwzM8976YFffRgfPAr60umll3SA2lepoJAyd5BVJ6YKwlHanQyXdkQWGjdrqVaM520wCWuirdU7gnGeC39CSUc195oLHaRN155N0i3BMrncizqauDijldxgG9RyRKKHWq8rGFQbGHfT2FIEw9EOPCqKCdGrJRbUMPyiczixA5HAHiLcEeR0PNjw1ExRD2LWJh2V88ZQsYDj4Lmi2qnNz7HNPtdWiAB6cJKaTG0PT0XsEovAn3fqIF+PVOWmipgFw75cqW77sycXJjbvweZAQ/SwMlFDLoNNY+0+BuCmzWtKM0kUD10J6n0vuvFjlnu97FPSSG8b3iwV0KOoPJboFUD3LmZAyfk/1dZLP6rC3Z/6ZiPn+Em+dlqz13j9GK0ZlUpizPPKpgTPPeZl/v2wTToo/YI9XJrm8H5/BvRN4xLYNqEPdaNjVNnf58NApcLz2Qw1fI1vV9ye90SNoPWKXkOmTa6ZHSFq9Ber7lqjEQ1/vmrFm7nVYdSyINbgCHFJDym4Q4yumy2u2ek0Aw+52L4WArK+GlivuZcIUOhb4KLzyB5Q69ecI1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(346002)(136003)(83380400001)(66556008)(86362001)(4744005)(16526019)(186003)(7416002)(478600001)(9686003)(66946007)(6666004)(4326008)(54906003)(8936002)(316002)(8676002)(52116002)(6506007)(7696005)(2906002)(66476007)(5660300002)(38100700002)(55016002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?teH7x+43VnUd/NVPUx1DyrSF3kIxLHG1O4UvddQcfl18+7qCzn1uz/qGqc8t?=
 =?us-ascii?Q?Z2qSvFRdFhLo0cu+kAFXN573GGwF7kvg9VHJ9zhdfSPdJHGLKUQYXP3JYscO?=
 =?us-ascii?Q?HZsqT1wD9RsYT7bmS6YcSdNOjFvuqFEdB1zHePuxjqls2KoZOIxEwkoB/uUz?=
 =?us-ascii?Q?N+xH11T0TX76Iltd2tVQcoO0Nx3EXS0hjPMFqTdmlUVeAalaBnHVsoCDAU29?=
 =?us-ascii?Q?F68scIHcErDnzEbnA3LBgzJixjngtuOk2dxI3NiheZA8Lgci9gKUWip14xLR?=
 =?us-ascii?Q?aI03HGAqLZu9B3Biehasjj84Uizl4hCUacZHQEttXE9NjUM6UhtEr3KLuyBd?=
 =?us-ascii?Q?oLjSXfx29tWvgEASmYZHZUW+kwwv2XdlTU0E4Bpbfqvwf6kyGLLXPlCTwRKK?=
 =?us-ascii?Q?DSrG/opB5ASnEJgJcCERx2qroKUvUdlt3GA/xvavoJl6V+zFpGZtZ09RDsP3?=
 =?us-ascii?Q?WpUO0q9e+Ry+ZyFD/x2PauHzd3qzfwc2/KyVzO1hf+TeM7bXWjUrCmZzafV8?=
 =?us-ascii?Q?0pjLbBrg2KDE0nYvMwSk74EevXFT9EwK+cttbHd52gWBgD5G/Kh9lEUf7R3a?=
 =?us-ascii?Q?vUEbtbpbEs4sVDOvSqmPs4PTQ1j5Lkv57TSD4/vNVcLdWHKaaPWsXthZxdQM?=
 =?us-ascii?Q?rywuvw61k8uOBdB+dMCx4q6FrlZspAvn12c6ioatgOVxCe8gCryV09Kcgzz3?=
 =?us-ascii?Q?RiMXptEZhDrVZh6v/azI+F4wDkkmblkcvrbwQyVmD0ru5qQFceZsvAL6B9Te?=
 =?us-ascii?Q?H2ipzxM0YC3zUo7NEwFoiuBa/w3OBxhmT2Z5XRjGIuc4xv6HS1SMQP6DU5K8?=
 =?us-ascii?Q?mz/28EK1sTIVavkTcrHUBA3uTugmut9Dk+fWoJ1JxjHhrT60F2lv87/Ih/1c?=
 =?us-ascii?Q?ci9/t5RUl196gmK3JkMcNvQAbelA1rwTkf/c6ttqy00uTc69j6yvnaHGIhKL?=
 =?us-ascii?Q?OVjA2BrbKrMbZgCSSNVIIK1FhksrHK5wmkM8J+AYxves4DycDGOGp/4kq8UW?=
 =?us-ascii?Q?1okyjpAWP3Ps5CHtWJpxhM6X6XrYBgo6VxfX4rAkZQNgja9flnWB+tsjnb+y?=
 =?us-ascii?Q?AB4sUNl/mW2Zi2UINfgzSc7aIK+YorWwx2koThXH+52W0dWigZxDRYRyH/qG?=
 =?us-ascii?Q?u1EJPkUfI8aQhK2cqHNKeb+C1VL6nsFNj6G20WGIz5sCyNc6BTbBuke0h+cp?=
 =?us-ascii?Q?zJczP1m8asjQ2kzzDPrQaV/9Op53KCePB9nZRGokPpTXdQq1wkEYzCK16Z/U?=
 =?us-ascii?Q?xn8XpukfrSbbpjl6UZU1V2iau72vgdM2z4juXUbtkPoLNg9vv53a1Uv2FORP?=
 =?us-ascii?Q?7x11HoI5NemSqImAqgZGlvXKRnEKBtVQWd6+i+G1C8FxaVO5TlzS95w/DdJA?=
 =?us-ascii?Q?2WS6laE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d5cad6-b350-47e7-f962-08d8fdde4019
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:10:27.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnKALRq4e9BufdRY5VwEQbM8bCcUSRzB+lidApARiaKN5xC5cQ9ZrmfSokGt5WSL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3224
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: mwnhq4iQaS6LhsZACTd0mZuVU0d42pB3
X-Proofpoint-GUID: mwnhq4iQaS6LhsZACTd0mZuVU0d42pB3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=748 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 07:18:39PM -0400, Waiman Long wrote:
> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
> function call goes through a separate irq_save/irq_restore cycle. That
> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
> that combines them with a single irq_save/irq_restore cycle.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
