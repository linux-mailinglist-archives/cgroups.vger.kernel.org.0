Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D751C03B2
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgD3RRo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 13:17:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgD3RRn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 13:17:43 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UHBAOb012372;
        Thu, 30 Apr 2020 10:17:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=a7sxeF2d5y5y2WLPeH6+YxlwtfDmnaRPsZHXN9Zo3ns=;
 b=UwYx/u+0fh241hUNcZgGKqHL5V4ELty2RWpCdqgMT0ZBbPxqdU0Fhqfi75w7nViPe61G
 /nslJTapzyDzqKfO/nu764IjVrHPiMp/1mdYpj8Q9fEtvtKTcah9+yEP1LcTi4GYvg/d
 A6pRWbpmk0PJe6L3ND12b3RmWUold9m26TU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30pq0dqpwj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Apr 2020 10:17:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Apr 2020 10:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMJJQmzBOBq4gF8UBT4wLBmavJbI4FbOmKUl1gWjVXpNPC1HO6y7mlUP0lcOXFKG2DSKV7Iv7XdWjU2b8ACaJlQz4z6skil76gXf7wEZS6CF8kVmz+Lr2kniFqUYLhAwvQfACObE0DOX95I9nFguJnHz82p+Ey0SF94aa6+/kdDOyBn2XV1phPYMVJOCpVdD1346FUpPY2j3elA/q+r7vvZQXbFYdbNmbK5rIgW1sBJk9JvLMS8RGcMFG5SEJoVUea92Wov1mLuh/6A2t3vPzwPB4Pb4Ufr1P9NFlva914SmT+v6o0NhmeTTro2HzHAL4LcnSN3YQmGwOAjrk5amkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7sxeF2d5y5y2WLPeH6+YxlwtfDmnaRPsZHXN9Zo3ns=;
 b=PWC9qXK0EXI8Fak4JC3kKMtc9NiW0G9dyaBVxxntUd9GauyBpF1HVUfo4z/3FCgWMXLzreV3W1LEvAPhQaHED9HdoAyL3x3rQEVH9W0WBu7cIBJj/V7mbH6m8Z5QPx42D+yaSdoGItl7DI7FuQMIGWbDRCmjxF5+MqvvYKNXsMoUr7wWVuOEQpN07v+I3QyWikmKo999Ad0EfuaixwHwYGcVu85JqZdwAJVjsXjOxV8euJ8oVWB2ZpNxFFivhyUFOgJjj7EzWJuyQi4X7pK3dio9Y+Fj2pBzYrNz6aFIOj3e6c/nzL1TUUAAon5rc9vxGdoIQGgno11oP5Vy5gnU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7sxeF2d5y5y2WLPeH6+YxlwtfDmnaRPsZHXN9Zo3ns=;
 b=IiYRJSAG8ViIvXxNl8nEmF22Bx8P+m9axmITxNB/qM9OFs7hvByoOT9FvSDdCWa/m7mU2YiC7sGwOFAXwneX1d+M2K+Z1vVdL+p+HEjTvuA6qLq4WzWaVuQW9TlG3Lx61ZcuaZBuDUwENC2n9j9aQWaM3wVVMa1zVd3uyJ/26m8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2837.namprd15.prod.outlook.com (2603:10b6:a03:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 17:17:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 17:17:20 +0000
Date:   Thu, 30 Apr 2020 10:17:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200430171716.GB339283@carbon.dhcp.thefacebook.com>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <20200429140330.GA5054@cmpxchg.org>
 <20200429150414.GI28637@dhcp22.suse.cz>
 <20200429165627.GA24768@cmpxchg.org>
 <20200430145721.GF12655@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430145721.GF12655@dhcp22.suse.cz>
X-ClientProxiedBy: CO2PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:104:7::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:cc83) by CO2PR04CA0115.namprd04.prod.outlook.com (2603:10b6:104:7::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 17:17:19 +0000
X-Originating-IP: [2620:10d:c090:400::5:cc83]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1325a6e2-998c-41a6-850c-08d7ed2a5704
X-MS-TrafficTypeDiagnostic: BYAPR15MB2837:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2837AF00BDC7A405A7C4678FBEAA0@BYAPR15MB2837.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: easJJzHz8As8dVFzKMW6GeQL2GQ6vU6RQK6uZL4jDrJuc1yyrfIEfZ7jsGN30BQXsnvjmNTHTll8Fj3udUcDpCzfc7ueP2U+tURze/geFheWAneLrouNVZcLiI79pc9sW9yVdjK41hncG9xWBq660r+6DJpqop5K5U88fpY/JsH7rfc+lBdBoqr2JoLmNctgWgEJHLvSUg8I9txls2nO3UFhTFoejlGPJrM9mbut1b1R2LJ8Q5Jj2jfMItmQiGtc9E/Zy2RyX7NbjvVHX/c/erWTjun8V9Te9t4W4QnyWjyvfWtQaA4SisGzA8sgjrlUKxwwYJMWgWzDQ0mDfisIgXDz+BPtw6IjGo14J+TNaJUdPkwtM0X35B64s3FbQ0lOeZsguMizuL/zFZvTzKpHQDWucPUvu3yLf0Xh9NQWJVgoe3m9cedhyoWHWa8JvhDpVWfK+dUBIPhMlxAvdSny1FP5WkjqsZOIhOHNekABYJ0qWQr9BsW3OFuCgme+Gctm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(8936002)(8676002)(6506007)(55016002)(2906002)(16526019)(186003)(9686003)(52116002)(316002)(54906003)(33656002)(7696005)(86362001)(4326008)(478600001)(5660300002)(1076003)(66556008)(66476007)(66946007)(6666004)(6916009)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tBQG51XtAKwy9D/TGpnLEujVwyabrd2Zs9+U0oQL4pCRw4RAFnIZc4FhzPFmSIleynE2vihUPuFV6QfKpwDupmZQ4qyg8Jk+pWwLeMypbLrRR4tIMgj5hH0y9sLkuWs7j+0fqNtFHJQb0DkoikdvtfgebgTAhIiiERn91ppAU3J1bunKz9wubLOdHyoarOw9YAcMGDMb6hhKXAHNWEHktoPBdyQ8IZ3t736E/46SNIVNHDw82eq4LkPzV355/b9bzaxXR5SybZmcI4rylyqVyiNwz/zvo8V7yoMsI/Cg+oLTr7hcv/gZahyj0rerbhjqB1McjHqXJ4R4gOrQpGail+PAvgLJYX1eFTIQwpsGsELTswbfKVZefPLacFZcNgrTExyhX4gTgCwY+Vw3FUR9pJjzMVZHfVmxGYkby3pT/aV6AkdJtNksPUVm5Ltm7DayOAQ2EMrnaXlTdthfMPWfkIkHjQI2F29odIEwX7mSpduI/k4uOINbrTK+gjUtSPFiIWa9cHHV15KP9XW+fm+kW8sZHDqNH/jOohCYKV+udVQOnmGpgaNoBMJ12u/xwx0vNsd8EATjDnNq4qwH8lWPRMIY1bB9AHHGsJgS5VAXDfYtvG5ptf0M+Eozp13t/QSth7P+HwXeWQS3jasimz3gL35GQjOYgkjl9LFuUg46vO8DXk7+Dyz6vOm6bSvi7w7BlKtTbyHivNnQrmRhOBE4t12ydRegThoebPh/wfTy4xdzryeex5LlIH19rsTS1oVg6FY7XZoBlU9oQcURHr1XXyKKwmU8lZBe/q44IdUNHFiV/gJR40TAgA0ib7rWKCsIHwmVXXu8a/pAlC+2Ls1PgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1325a6e2-998c-41a6-850c-08d7ed2a5704
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 17:17:20.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oTmHraNNsociSBsOeyxzbOXgQ2s4p1gQFN2q21FGyCPT2zyCc0q3+34+8bphoF8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2837
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_11:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300136
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 04:57:21PM +0200, Michal Hocko wrote:
> On Wed 29-04-20 12:56:27, Johannes Weiner wrote:
> [...]
> > I think to address this, we need a more comprehensive solution and
> > introduce some form of serialization. I'm not sure yet how that would
> > look like yet.
> 
> Yeah, that is what I've tried to express earlier and that is why I would
> rather go with an uglier workaround for now and think about a more
> robust effective values calculation on top.
>  
> > I'm still not sure it's worth having a somewhat ugly workaround in
> > mem_cgroup_protection() to protect against half of the bug. If you
> > think so, the full problem should at least be documented and marked
> > XXX or something.
> 
> Yes, this makes sense to me. What about the following?
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1b4150ff64be..50ffbc17cdd8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -350,6 +350,42 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
>  	if (mem_cgroup_disabled())
>  		return 0;
>  
> +	/*
> +	 * There is no reclaim protection applied to a targeted reclaim.
> +	 * We are special casing this specific case here because
> +	 * mem_cgroup_protected calculation is not robust enough to keep
> +	 * the protection invariant for calculated effective values for
> +	 * parallel reclaimers with different reclaim target. This is
> +	 * especially a problem for tail memcgs (as they have pages on LRU)
> +	 * which would want to have effective values 0 for targeted reclaim
> +	 * but a different value for external reclaim.
> +	 *
> +	 * Example
> +	 * Let's have global and A's reclaim in parallel:
> +	 *  |
> +	 *  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
> +	 *  |\
> +	 *  | C (low = 1G, usage = 2.5G)
> +	 *  B (low = 1G, usage = 0.5G)
> +	 *
> +	 * For the global reclaim
> +	 * A.elow = A.low
> +	 * B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
> +	 * C.elow = min(C.usage, C.low)
> +	 *
> +	 * With the effective values resetting we have A reclaim
> +	 * A.elow = 0
> +	 * B.elow = B.low
> +	 * C.elow = C.low
> +	 *
> +	 * If the global reclaim races with A's reclaim then
> +	 * B.elow = C.elow = 0 because children_low_usage > A.elow)
> +	 * is possible and reclaiming B would be violating the protection.
> +	 *
> +	 */
> +	if (memcg == root)
> +		return 0;
> +
>  	if (in_low_reclaim)
>  		return READ_ONCE(memcg->memory.emin);
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 05b4ec2c6499..df88a22f09bc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6385,6 +6385,14 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  
>  	if (!root)
>  		root = root_mem_cgroup;
> +
> +	/*
> +	 * Effective values of the reclaim targets are ignored so they
> +	 * can be stale. Have a look at mem_cgroup_protection for more
> +	 * details.
> +	 * TODO: calculation should be more robust so that we do not need
> +	 * that special casing.
> +	 */
>  	if (memcg == root)
>  		return MEMCG_PROT_NONE;

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
