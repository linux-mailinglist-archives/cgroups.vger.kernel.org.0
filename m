Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA91C49EC
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 00:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgEDW7d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 18:59:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727806AbgEDW7c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 18:59:32 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044MxMhR008053;
        Mon, 4 May 2020 15:59:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qk7zY96zEAYh4rvMwIjk8A7NLJslV82xfWPmoz/2mbU=;
 b=fIxd66/reIR7EQggwvNULLm2WznRadcpp00bKTN9nPdo9AQsKFgcRkaUSKlvWXvhSZUD
 7kRxyDnQdOk7SkLoGzC2jWHJihgTPNgso0cKuErKZwxW3n9zYYziw1m9udpl4UgrFhs2
 18d7OqBpWhbXu/d9tEld+EGgi06etafX4UM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30srse7rgq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 15:59:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 4 May 2020 15:59:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfEe1geZxFltqHmRFsIob9MdKEkWAkBk6nMeoJ6ngV+aUAtcWHYTe341PeLxNXqDGfho9wtGklqpkMIsJCDHSpYQDodaD0supgsf0SgdjGJ7ueDqcYoCmIuq2Si/ednrV/T4k0huHAkGZZkoWgU6r+X8xmIf9mXlKMpZBJi9jvMP71XjL8MJDm4aw9vdFPSYzFYJSZLqKG5OIKoz9dIMVKdQ1m6BB2K3C2WnggotbRjkqwLKmpk7g22wVJeaa73dsb1P/mPDQIAWuKr2+UyOpNkRj8OmY+vbKJ0rSvqxTEyTyth45W1PAhcLCM4frWRHguYQApRkq4y9AXoWK3dK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk7zY96zEAYh4rvMwIjk8A7NLJslV82xfWPmoz/2mbU=;
 b=AxieFQOTW285u5JTeLRnwP0jSi0xIfQYCB26b0dmgBa90sUHXX/42Csy+UJyYXpjAQYWIVLmPJI+knfl5mapVkucFRIqxmjP8HplUU4xCMlLKwItFf1N9qCdLZigBpuf/ZWGceCtLFLgT7Dt3iu/HBKiTpfjE96H0wwcJOegmlamv4sAfbsj8ps2fnnNGYtu6i0IuA9NeRjqZOEbTKF/wU1D61diSeKXRFdJykysRR1sIBzn/jnUHvyyBYPjtgXQJPKw+vt2P9s2xJDm8WNCqHW6XOvajLxo06D0lYo9ripIhmX906n8kC+nOsUuafB0B22qBJLOn1I8SE+hWI4ULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk7zY96zEAYh4rvMwIjk8A7NLJslV82xfWPmoz/2mbU=;
 b=PUIRW1JkeV41KwtyqG4/E+k1B8wpw4w1VD9eOsNSiaGvKcmBaEKyhxcIYToRbe0Qwg3EktK6A/tKx1eE2Ny/xS1SbFGfKGjUjfKthsG2uJG5VflXo8Bx0Iq1JaM0t9B7bzunPHUYZQUzn8xXzlrRxLnv59YGgzktA7Wmfu7wE1o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 22:59:19 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 22:59:19 +0000
Date:   Mon, 4 May 2020 15:59:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Yafang Shao <laoar.shao@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200504225910.GB20009@carbon.dhcp.thefacebook.com>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <20200429140330.GA5054@cmpxchg.org>
 <20200429150414.GI28637@dhcp22.suse.cz>
 <20200429165627.GA24768@cmpxchg.org>
 <20200430145721.GF12655@dhcp22.suse.cz>
 <CALOAHbBub_oojkb5DpXUoHV=-e9PDAeVzJvKvDtyk-9Jg6_Pkw@mail.gmail.com>
 <20200504072342.GD22838@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504072342.GD22838@dhcp22.suse.cz>
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a48e) by BYAPR21CA0006.namprd21.prod.outlook.com (2603:10b6:a03:114::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.0 via Frontend Transport; Mon, 4 May 2020 22:59:18 +0000
X-Originating-IP: [2620:10d:c090:400::5:a48e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9740123e-76db-42ad-1d93-08d7f07ec6ec
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159BE30B19F0544BBDE0390BEA60@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCx0LsuuqfEXljgIlLDyzSOrExeFLuXMpzD497BgnZQTJ5zxsMQ/5cTpSUWx2FpT6KuYZ1QfTpZTvdOAvtrIrh2LlYL4WvUsPnTQfcYfWpB0D4ehsh3/l9YFnSZT+bqauvWCKhFPYnJw42k01sCznaYQL7ik5daRpQQKyvOf7kmXktkmQhvy53bPRvoTtknP1JeaaUJVpcGAxom2sRgadrVLrezK57jNrdwZV1mwFwCIQPfOev9Gw147mKli86pBYvJ6NWdLIR3NZrkFVzTyDn6usArkociN7NGHZQrBqustdEqj+sOrm+ijuYn7gCFxlerz8y4s6f5K2InWtLDUtTsXEUdAjKBhzFksIHqWf3rEMHAG5W1qbYea9J/HWgjZAvM4y0Va8wvYfIQUk7shoJRFL72R8Wb7ALxWSQ9WrjR2YzvHLHyBUvhLQRKWV5/nL8ac+/DO0vR0cgB2CwafMzdquJir1ph975Uj5mfe8U+sTtRR31qabhP6skYfYGhuAPOtX/Mk5opdXKOYEeathfGYCS41jeeMsF3Y8qQeGjFHhtSpKE+UA/Nfonj2sSR9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(33430700001)(33656002)(478600001)(86362001)(33440700001)(8676002)(5660300002)(8936002)(1076003)(52116002)(54906003)(7696005)(316002)(53546011)(6506007)(16526019)(6916009)(66946007)(9686003)(55016002)(4326008)(6666004)(66556008)(2906002)(66476007)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6+QD4e5m7ayVr0G6oEVORVotSfjLFjGlB+BwZ7ZfNrTtnfC6lvYt+ibyvlx9o5Duhxv/Szhnan7VIu4nj+YVYJYWTd9JzjB7wvY5vAyZ9QjCx/q9jCSC+MwApQI+oMxIOBe5tpP6YE2OppdvrA/wjzCp+s60d2FQz9blIT0n6inlNc0BENLFmsFKleaJNYTMeqwICeoCFQc1uL9Cs41SHhN0cQONn69zwGj0OqRl15VMNnPrO3WW+9z6IS058dz7KnaDhdAUUPGMO+HrI1pr+okvB/ITJjZ16SRI+ZcU9r/MQ8z8uS/QlvBjzAI58aIJ/LSE7j7931XuvzBzv3vVDanZjxqePBK30o+FvXYITd6d8lK8iKFGdA+s646zoXbwNx+yWkq+TsXWjl/TquugV2iVREXd1bP8lYMXqGJU00DTRFHWv98Z4CASRG2mL7AW3bEBz9BPo7JkLbhV8FTzN6x0vg/2LZEFog0V5+u6EtL1y3R9gYdK0O57zkchBur0sEFb/tBTVMtFPy/SwMRK/jbA/UUBDHXL/tceEK7b82wXmfIDdHAWAJLlpQ/W/Jz5GVD2CIY1dJyq3Om+/nhZr/ZMTOg3/TyfR4fqz5H5Qt/NPbGM6hdCbxGyHjD6EQ2X3J+nzKSWhXIoS9Danq+7z9JDP2B+mNjWQvgp8K0vJssnYaFdAHxG5FchrbSF1Fm3HtrAilXqmRB15kn9UiTp4XdvbtTJNqf/ygzVZCM1vqi+A0Jp6DRnmy1zLsi7CW76Dwe5dHSr4aaMqgasLDPYLRN/UVH/EaAoO0/duRsj5W1gpl0nbsV6FC7bP7szcxDI5Cds3rt8Z+UuZ3x6hykEhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9740123e-76db-42ad-1d93-08d7f07ec6ec
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 22:59:19.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKg6alOpswuKFEycZ1tD8Kh+vGjGSgNlIlvYF+6hXNVCrnGMAhACMD0pTkJSrD8q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_13:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=1
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040179
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 04, 2020 at 09:23:42AM +0200, Michal Hocko wrote:
> On Fri 01-05-20 07:59:57, Yafang Shao wrote:
> > On Thu, Apr 30, 2020 at 10:57 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 29-04-20 12:56:27, Johannes Weiner wrote:
> > > [...]
> > > > I think to address this, we need a more comprehensive solution and
> > > > introduce some form of serialization. I'm not sure yet how that would
> > > > look like yet.
> > >
> > > Yeah, that is what I've tried to express earlier and that is why I would
> > > rather go with an uglier workaround for now and think about a more
> > > robust effective values calculation on top.
> > >
> > 
> > Agreed.
> > If there's a more robust effective values calculation on top, then we
> > don't need to hack it here and there.
> > 
> > > > I'm still not sure it's worth having a somewhat ugly workaround in
> > > > mem_cgroup_protection() to protect against half of the bug. If you
> > > > think so, the full problem should at least be documented and marked
> > > > XXX or something.
> > >
> > > Yes, this makes sense to me. What about the following?
> > 
> > Many thanks for the explaination on this workaround.
> > With this explanation, I think the others will have a clear idea why
> > we must add this ugly workaround here.
> 
> OK, this would be the patch with the full changelog. If both Chris and
> Johannes are ok with this I would suggest replacing the one Andrew took
> already
> 
> 
> From dfcdbfd336d2d23195ec9d90e6e58898f49f8998 Mon Sep 17 00:00:00 2001
> From: Yafang Shao <laoar.shao@gmail.com>
> Date: Mon, 4 May 2020 09:10:03 +0200
> Subject: [PATCH] mm, memcg: Avoid stale protection values when cgroup is above
>  protection
> 
> A cgroup can have both memory protection and a memory limit to isolate
> it from its siblings in both directions - for example, to prevent it
> from being shrunk below 2G under high pressure from outside, but also
> from growing beyond 4G under low pressure.
> 
> Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> implemented proportional scan pressure so that multiple siblings in
> excess of their protection settings don't get reclaimed equally but
> instead in accordance to their unprotected portion.
> 
> During limit reclaim, this proportionality shouldn't apply of course:
> there is no competition, all pressure is from within the cgroup and
> should be applied as such. Reclaim should operate at full efficiency.
> 
> However, mem_cgroup_protected() never expected anybody to look at the
> effective protection values when it indicated that the cgroup is above
> its protection. As a result, a query during limit reclaim may return
> stale protection values that were calculated by a previous reclaim cycle
> in which the cgroup did have siblings.
> 
> When this happens, reclaim is unnecessarily hesitant and potentially
> slow to meet the desired limit. In theory this could lead to premature
> OOM kills, although it's not obvious this has occurred in practice.
> 
> Workaround the problem by special casing reclaim roots in
> mem_cgroup_protection. These memcgs are never participating in the
> reclaim protection because the reclaim is internal.
> 
> We have to ignore effective protection values for reclaim roots because
> mem_cgroup_protected might be called from racing reclaim contexts with
> different roots. Calculation is relying on root -> leaf tree traversal
> therefore top-down reclaim protection invariants should hold. The only
> exception is the reclaim root which should have effective protection set
> to 0 but that would be problematic for the following setup:
>  Let's have global and A's reclaim in parallel:
>   |
>   A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
>   |\
>   | C (low = 1G, usage = 2.5G)
>   B (low = 1G, usage = 0.5G)
> 
>  for A reclaim we have
>  B.elow = B.low
>  C.elow = C.low
> 
>  For the global reclaim
>  A.elow = A.low
>  B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
>  C.elow = min(C.usage, C.low)
> 
>  With the effective values resetting we have A reclaim
>  A.elow = 0
>  B.elow = B.low
>  C.elow = C.low
> 
>  and global reclaim could see the above and then
>  B.elow = C.elow = 0 because children_low_usage > A.elow
> 
> Which means that protected memcgs would get reclaimed.
> 
> In future we would like to make mem_cgroup_protected more robust against
> racing reclaim contexts but that is likely more complex solution that
> this simple workaround.
> 
> [hannes@cmpxchg.org - large part of the changelog]
> [mhocko@suse.com - workaround explanation]
> Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  include/linux/memcontrol.h | 36 ++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c            |  8 ++++++++
>  2 files changed, 44 insertions(+)
> 
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
>  
> -- 
> 2.25.1
> 
> -- 
> Michal Hocko
> SUSE Labs
