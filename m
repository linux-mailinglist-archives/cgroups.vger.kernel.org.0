Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE8C30CFC6
	for <lists+cgroups@lfdr.de>; Wed,  3 Feb 2021 00:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhBBXOn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 18:14:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232820AbhBBXOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 18:14:40 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 112NCvZL020878;
        Tue, 2 Feb 2021 15:13:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7tzVTPyx4rpKoIzpxIZnjNEZZVV9myz618FwTDHYA1E=;
 b=NgiauNtJg9b9WxytAsO370Zmh68281lDc45e0Lmqh95n7Xf8z5MciroDhMBc+/RkB7o4
 AQu9JMAhDLdq2E1qgQYqPfPUp8DQmEAk82lciqTIUYPJWNtDQ+UWj7kHLZYsUhVoYZvl
 Ac4+ARtzr4wCfGTUuireogzjJ5jr+yyL+lI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36drcd69cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Feb 2021 15:13:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 2 Feb 2021 15:13:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNnpTmTyeth4qkN0FcVd/DNvLhbqWxlB6MRxjgv10rTDyX7n0VsWeziTDIqvYVvgVYmlw4qvUjDUWH9VQQxUFxBjvjjXy9HLFaesmW/dphKY9VVR2QeOVq7W7YzMRuBrzEm2jFBSnYY5h0LopZYPTYseSdD3m/1tQUSeuok/+f0Laq43+uhi8c4hAIjHUjA00wR/RbKacACQuUZ7D1oeBNB0riuo7GJQ9Zj/4shR/gvmUjzedaxhbyVltiELSAwlFLBE9GO5tPTp7883QDQqvl22bTt0ntps64MIGoaJkinzF2qnWlSFaI83kLAmM9yWimnZsV10MMnr0Hfi7IuWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tzVTPyx4rpKoIzpxIZnjNEZZVV9myz618FwTDHYA1E=;
 b=nteRh39TgVc4iZ3fUlk9ySSP3uLL0sUTYEr+uV1nAanZQHmCcC8NyE/1QVPuzzwNRABKTvg9N9cOq3+o30Y8s07r8uGlux/9qlNyAJbmpDnbtXsaJvLuJ18Xfh5+0MPXeUJlA8VuaQcZpN1lg6q0IGlCoUa7r7vlVOqGI09QYg8oRVx8zpM8mWMoHw3gRnKi4vvN59wQeOYvmcK47Sx/4wvHldtK2R+q4jh9jyOFd6ZlOjl/XbWLq11gDngxQzFpP0vvw9SODkRNeb83yl3HtD8Kg+1bOiflTWyPc+VrHZktTY4IrA/s3C81MZ6z5dgRTn6gX+PPD2sqSbn1XGUGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tzVTPyx4rpKoIzpxIZnjNEZZVV9myz618FwTDHYA1E=;
 b=YPUscs+iHlUvABdiSwUVPZyrAay2czkfvzFI+SKPmG4MoHXFv/nrZl17mdpL8Rmg4OHCon3mGLT8tbappeB9T6Vp545o8jOB99LyjtxjYLFMky3DRc2RkXqZ1iMRTNg0ZTcvkH0krCI3Vp+gpAc6ZjrtHBq6CAG4YLexMB2hThA=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2389.namprd15.prod.outlook.com (2603:10b6:a02:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Tue, 2 Feb
 2021 23:13:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 23:13:49 +0000
Date:   Tue, 2 Feb 2021 15:13:44 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 2/7] mm: memcontrol: kill mem_cgroup_nodeinfo()
Message-ID: <20210202231344.GB1812008@carbon.dhcp.thefacebook.com>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-3-hannes@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:7ae2]
X-ClientProxiedBy: CO2PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:104:4::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:7ae2) by CO2PR04CA0179.namprd04.prod.outlook.com (2603:10b6:104:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Tue, 2 Feb 2021 23:13:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6887d268-7b31-4beb-8701-08d8c7d032e0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB23896FBCB38B8B9E1001D299BEB59@BYAPR15MB2389.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ADsYEbCl5lLWZlTX65datpN15YOl3uefdbGVHKK4ubUun6H8oV0dejtM7oyN6Gk8fDylyhwKb05w7ns+QbYhg3/Oz0/hKynAls7xOFGTeZMC64N3GD5nMqEyT4L3ezez8VXICWYBh/l4+Yi5ZVLFDXNYsAGt0leBQxIHOeMwREND3nXfOxnE+u9jVMk84B0g2RFcdoon19OirENGKJ6evoHP1HTQlQLE1fYlHCCHZ30A54mJIxvIcmEbvbdC3mnZ+gqAn3xGizp0qjRwo4OVHjTIhpKlmJfSmZsU1t+3xeUbB31zO/asLl81RKoQfJt80Fn24bT4Ps/JZvFPc0p6bVfiLjp+V+KTpjL04smtzxdMthaskatiYj33reuxFXg8ycd+/oRqZj2wYC6j1heLE/kst4N/y43TBxv5N1W63WvGkIvNPLXR1uXp4jiQgwWlpkRcuFHd5RGDwQnjYYpBpUoy8o2Y8g1nPjUwl0ih7Jqj4hwfx1FrcFgyI694P+TQrcI7G824HPGHXvepCcsTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(6916009)(54906003)(55016002)(316002)(33656002)(1076003)(5660300002)(83380400001)(6666004)(186003)(66946007)(66556008)(6506007)(86362001)(558084003)(4326008)(8676002)(478600001)(16526019)(8936002)(52116002)(66476007)(7696005)(2906002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XlFIAQeTW0+CIPmd5UbXcgKt1m6pdv4jR0YZSAj8bwV2eIWlqY3KK9uhozER?=
 =?us-ascii?Q?YDziZrMCyosLw1LdVBxE5Z9ARscOPyTNC2XAJDeyd0xNQyW1NmCOghmI3NfY?=
 =?us-ascii?Q?HMkrSGorMV1gaB7fHSCwwJ+VarA2/2/yOjSYbvtBXRRBGlZe022RhGP1lTDt?=
 =?us-ascii?Q?y+jGcBArTtVqsGfrO+USNYQSudfVtGPrwAs9i0BKJ8gkfRrGyWbE1HLoLuSh?=
 =?us-ascii?Q?kEFothrsgm/16mxZ3tNItUj70+khr0wLvI0T9qwhmB4q5GD5qO73hlmxzYhu?=
 =?us-ascii?Q?+xHhrl6rPpNGAwOk/lY5tKcWYZmSWwpbajqECFdf1RqjXZCQe7TpjqhH9MbA?=
 =?us-ascii?Q?u/CfRLycLQh0fA7hEntQHRXXp6ivFF3qYhfcYuIVztkUf1kzQ29Ub3PMlJ7K?=
 =?us-ascii?Q?++sM0EdNaGTr2ayHCQ99XZ7VipwMyTwAMg/n/6K6O6mDiu/60dzhPWhJ9xhj?=
 =?us-ascii?Q?8TeYrX8Zj4ZqLeRptvTjDRWJ/ToJDyPSJqwXzdjpYi9iT48mglZulgsK4cJB?=
 =?us-ascii?Q?NSXx+VYJNtk2JjEGdcsLPWlX5vwxSyrYsrYDvGXNrL+LVtUKiflOYqwSqNHJ?=
 =?us-ascii?Q?xHs/aL22J7ZKiFH8Ol4Dy5WYk8MCOavDbkINqMS3VSGgoEyqkFj52YNcWtNA?=
 =?us-ascii?Q?/AitpZHB4eyeDiyaJ49yFlvbh0jYu3Z8jfo27JtIC86BgYjkKIsvyO3HU9uz?=
 =?us-ascii?Q?NsUg/QzjvJtT5CzDcMvC7p1sLQQvQ3hLLCTwUIrsK6M6O5Kcp6q2BA6sr8Bj?=
 =?us-ascii?Q?Mnph/jYQXck3tufV/I9CoIzJphaiVF/Htucd5Q3g80K6Ykus2Hr4epRxGwNt?=
 =?us-ascii?Q?Psj2bIRfI30N2jk4VSJfsS5O2hHwZakNvWgcjDUCQ6kUmXGF/MmwMIwenG8j?=
 =?us-ascii?Q?y4yhXwLrFMMGrthABqhF2t5AtzxBEQ3WwOUJbc1YSNTkz7dJ73shtGc8FAcf?=
 =?us-ascii?Q?gNyNiZRBAOB6xAKiaEBe8ircd4YBE7kgTwCqBaU7TdnttHDQ6QjHqDK0is+w?=
 =?us-ascii?Q?fqSBs/rfzNgytbxWwbalycj3UU8lS3D+0D4TD2KN1BrRf0AhH/hYGHzJcWOF?=
 =?us-ascii?Q?Trtwvj7BKHFyMY4HQzUYcFVIngIOZQ29vmqmz7SlyTgx3rvQ8Cw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6887d268-7b31-4beb-8701-08d8c7d032e0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 23:13:49.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jqO3Gj6ACQ9d+aXoAoABQJmIPmYw1y3TtWPN+LzT6pweFFc/PWuGvD8btqegnJk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=725 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 01:47:41PM -0500, Johannes Weiner wrote:
> No need to encapsulate a simple struct member access.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <guro@fb.com>
