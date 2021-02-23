Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368CD322DA6
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhBWPgw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 10:36:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40618 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhBWPgu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 10:36:50 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NFNgMX023753;
        Tue, 23 Feb 2021 07:35:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=t7MoVFMyDGzTVq+Xv80L4c65BmjPKBTDREne1vgTmrg=;
 b=Czk8fnyYOX62zfB8HvQSTeZlnxbxI/ed3Ec393p72x/VxL90o2dhIHZM0v5+1NGJWJvf
 icSUwFtOEQ15aYbXPZZ2iPl6cMN7Rfr9TibCdTMJ+Lxnu51ps9bwNpEm6ICBDmMdnoX+
 dQsEJ6Bi3azYoViBfXCV+hCUhlQ4T1B84mc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36u14q6q1y-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 07:35:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 07:35:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAhFCsmEr22CLT0x3Ji06/AnEtSpvf0Tv5p3Jo2S080zf7+IKvUuT4mAYXOPp0/BAT7i1JDZUOu08fEiHPaly97loGOpbm3jLXZOGSA6mzo2MIhiInpNBuMTUdpgvHvkaACnwXnq2nqeCbgYdmo6SzrB4xPEEPqjjA0i+49holUca3OGMvesBasHgxw0JgioJQ4FuQD0pxBCmTfiROLx9EZmgdZSscxTqk+/D2n+yuSYGgqXvUqVJMWEIJl1JMxcwFe39aDkSPmsFYn0rfvfZzpKW5h56/SUq2PK4Fnzs7x6to/5ERu3XrS8N88b2wZ9TZH7LLTOzSJ7pJb2VVQTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7MoVFMyDGzTVq+Xv80L4c65BmjPKBTDREne1vgTmrg=;
 b=d4X7sOBeH/oK4TMNsWNO1COYF1tqKzHaoB47twvFgdl7r0Mbusu0J39ZtVqlBvHPHlQyI0dkzt/TQ7xjsv5/yrdPk9z114lrlckxJUPu9DxBwlBzTTPuNfqqXXZXdAwvIYzC266VVxRtFYYHCBDy3EmUKRnDVKCwkf96RFw6vjneh8TAA6LFbaOonuWp/9RhrOVXjLnHd9l52uapz9ZSsL17oULVYEF49+3A/nasGCj7mGgkGD1nhUkZmjIPPKacJWAjUevRvxevxdzYSzsJeAlvBz4tL2MNREtWlqqas6OF4JDk8Qxt8p5hp/kabotFLZwLAdPxOSmNtg9mKRI+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4406.namprd15.prod.outlook.com (2603:10b6:a03:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 15:35:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 15:35:53 +0000
Date:   Tue, 23 Feb 2021 07:35:49 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: fix get_active_memcg return value
Message-ID: <YDUg1TJm5NBvLbQS@carbon.lan>
References: <20210223091101.42150-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210223091101.42150-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:719f]
X-ClientProxiedBy: MWHPR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:301:2::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:719f) by MWHPR12CA0033.namprd12.prod.outlook.com (2603:10b6:301:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 15:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f091d385-83cd-46b4-49a0-08d8d810b4ae
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4406:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4406527EB2A10E1F6461E055BE809@SJ0PR15MB4406.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k78fYZM7PEtntkggaNE8jSzDJKVIQKVwKhiE2W9qtXMLjMDOZK5PCxpZRTCo5nk+5eoSYahz/YqMBg1TC+jCETX5qbKfvGHdMgkHrh6Qqz51zScYswqgR2bc8mAcEFWO6L823UEpGvrOPKu5IHxkeV+TLCicFntCW8/6tx/AhFkigBhtFZFCWJ4AWNnQRaKUhpB2mmFkel9MgOMPsz2BwPos/U97YfdQOelHVBbBT6PlOlx9ZDrQO34P4MBP4B2QJBMhvNSdEBqWLQrIVIKxyZPkz8LEcLUjZ/dQjPF5ny1NXkkQFO1Uuo2RgjNpkguMD3C8KsLBH8kdirQrHu1O/lOT2O1KYyLkcrXk+BnWSv+wJTy7LBrG9nkBWziSr4b4X6U1PMa2g975+Xmf4G/McvTqXiPW6i/4JLIyMtq6dsdFNzsqla8dRViKpqpB/68A/loljiwV/kFLNILNn5U369cfWGlXR5PiCH7Bn12nKrF6KGYHrkDNcC6EGvv5J2CFAH62RJqvbsH2UMeKhDHrSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(9686003)(6506007)(5660300002)(52116002)(6916009)(55016002)(66476007)(66556008)(6666004)(66946007)(83380400001)(8676002)(8886007)(8936002)(36756003)(316002)(186003)(478600001)(7696005)(2906002)(4326008)(86362001)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jjCyry6OWXYa6/qgyTrFzuXhjxOxUzf4Kfrv2WhyOFKupShx/DHKSLrg+gg0?=
 =?us-ascii?Q?VIWVMKl+uzc6Nj5nPXEEGiiYNasX/TO0C+pJ0pD010QSCFKkFe1zyjQLU3bn?=
 =?us-ascii?Q?g4gR2tLZDGgQpmXn7szFvj7AIvP16YetzR/Wwbu2WQkTlNElSR4RRNdJnAYs?=
 =?us-ascii?Q?Q3W5Pw79YiL7DOr6MajUDMSjohIjDRosIT1cJEnnoytr9uthrmmyg/wd5DXn?=
 =?us-ascii?Q?D/gdjYiDP7ZA7nJ/CPBeosoowzxPEOA91FRFe2WyrKqRXm7aKTlKXvD6tWTn?=
 =?us-ascii?Q?XQSzMPTpfhEkWk7Scf35wf0uTGiRa77zu3r46DTNkScEgYuKvgs3k3S0cOYg?=
 =?us-ascii?Q?I8ESXHnW7/6ii3IxGfWNwT3EwprAdxGvDs7F5+XSjSLKOtTWHLQLoaU3Xa6Z?=
 =?us-ascii?Q?vEG4TQDbfTbyKOq0mL9dcjAEkqhqzZGVHwCwyEnbp9ypKDQO5Er+gUD+Ft+9?=
 =?us-ascii?Q?obz4oVULNShHtDK9vFdS2IWJ389wtRuWNojjMjkHXcyniUIPYImKORZlC8gZ?=
 =?us-ascii?Q?C0Sxkjb2XRDOUL8VwbeTn6QI9gfW7rQg/qWIN0J5cawHQf1RZKOyB1EbH05z?=
 =?us-ascii?Q?jMdjbiXbWyipLiX4e3RZt/3NrVS6nf8JvtjVdrtlXcTw1CHCX/DkT+snwSBP?=
 =?us-ascii?Q?TLajIQ3OaQXzOm/h8F1rTvU9fhSLXyM3a0pN0mYj6vSYTwh9WPRQ+wvsicms?=
 =?us-ascii?Q?OP2NYax2zZf+yqSswJjlmZGxMEtK/2y8S+WuV0So0pl6+HBnB3osANSWSAaM?=
 =?us-ascii?Q?5I/baD9b863IrgBFuNskPBBr8kjC3d9KI4faBtA3l2buOs97oA6TN5zfQE2J?=
 =?us-ascii?Q?py9p3qcJsQ+OUeUAjQayam2LjZKlk0izKaCVmleDrRoEe6RJdoAnPWeT1TVu?=
 =?us-ascii?Q?b9bRB676wsfixU9Xczj4eczoqorCfEoHwTJtkO2vfgTMcMHscLnauCOiYPyM?=
 =?us-ascii?Q?GPDaH32B6sj6cjNavL9yJ5lp2FXKJmD6V3rP9rZ6/7y06FdHz0hGyMmdHmmm?=
 =?us-ascii?Q?/YhoPAshsahLGm6Ir2xacZySPS7Z3UxXQoBADZX2wlMi9Zkbm0jIa4l2PGwO?=
 =?us-ascii?Q?wV865xwBpGZstyGk8NgzsW+yEIeqY9R8b3N+EbvGnnhHVMSklTSBtTauzoZu?=
 =?us-ascii?Q?lXFugsrIQFlwaz9nYG4yFN/Gt2J36nznFdhIDBp6JsK2oiYvVZ7PXxMjLnLL?=
 =?us-ascii?Q?3lmKhckJP74VDkHWBhd6pVMjXBhvd2UX1/EdRVrMN9c3GBZ7kZa7Mi9299E6?=
 =?us-ascii?Q?HSf5/r5nNnhclbdKhPqbWIZdA/DalfBaywATGO+tTnDONAsA3Gzew/7mC704?=
 =?us-ascii?Q?NZvwpNQNOZnoHOljP96WJZLsMXA5eCHDAzUzV/24H91HtA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f091d385-83cd-46b4-49a0-08d8d810b4ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:35:53.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX5vopOqr7jIiDsDO6jUmeS96ufesCPCUbts411Y3AgTGGdIE/AAfwl4x+g76Jar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4406
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 23, 2021 at 05:11:01PM +0800, Muchun Song wrote:
> We use a global percpu int_active_memcg variable to store the remote
> memcg when we are in the interrupt context. But get_active_memcg always
> return the current->active_memcg or root_mem_cgroup. The remote memcg
> (set in the interrupt context) is ignored. This is not what we want.
> So fix it.
> 
> Fixes: 37d5985c003d ("mm: kmem: prepare remote memcg charging infra for interrupt contexts")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be6bc5044150..bbe25655f7eb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1061,13 +1061,9 @@ static __always_inline struct mem_cgroup *get_active_memcg(void)
>  
>  	rcu_read_lock();
>  	memcg = active_memcg();
> -	if (memcg) {
> -		/* current->active_memcg must hold a ref. */
> -		if (WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -			memcg = root_mem_cgroup;
> -		else
> -			memcg = current->active_memcg;
> -	}
> +	/* remote memcg must hold a ref. */
> +	if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
> +		memcg = root_mem_cgroup;

Ouch, this is a good one!

Reviewed-by: Roman Gushchin <guro@fb.com>

Thank you!
