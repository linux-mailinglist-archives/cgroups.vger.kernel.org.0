Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3534F29C76E
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 19:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828465AbgJ0ScP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 14:32:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10190 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1828451AbgJ0ScO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 14:32:14 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09RIUCFE003991;
        Tue, 27 Oct 2020 11:31:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CaNNTAePTb/2NKJ5qDb+sog4vtTEV6NufAX37X6coe8=;
 b=OR8DIjj171ekol9EyXRSIQLLV2ow9RGUu6w37G66Ae0caNmw/2cJHRUF1Ry/VLtYFGua
 gvUSFJNxw7b+gR8spWgwhzsnNl0T3R0VeL33FQ8Gd+lvc7WXqe6AGimlLPWS9VNdMIpd
 /RSGP7atDlKEzgVeduzqbXoriQ9nbj8WMc8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34ej3nakm9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 11:31:47 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 27 Oct 2020 11:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awHiMo8O0DS/KSbqLMut8P8iE7xfJ35KbuJp4uzILU4erSeWw7lDcQ2zg6cnw+RRhdc++D3/XawBWLKsHFtPyOAFdvFdKM58M7Emh428uPHwkqBp+j+Z1WqVMurs1YMne348TaWUKRyNhsiqBoA/LWiyPUvLFebokVSAU8Af0++M2LPW/LnBllA0cIbF+VQRBthKc5WNPTpSlUpHzpygXznB2ybqVDMPZsEktik8Qaj6xCYnDVlRgDmZzaXYTbG25waPCefbF+MlZWqaWKqru2/pU/uoLRsN0VyRCJ5bnn8mUoVA8+NAnqF+btyIp9q8Ih8T30VMX3o+3hB7pGLzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaNNTAePTb/2NKJ5qDb+sog4vtTEV6NufAX37X6coe8=;
 b=HLFboI5xF08xBNMqaejjeX/INcuZMQ0wz6BsNI0eXX08rNrRq69CI8f1nfEPUI3YOvQ6fZPJXA8BilY4i0ZWhCtFMsSZB/0698mrYnZ48BQeDoem7vYOszn61jtwVyw9/om31ICH1BkXBUmqGGkoC+Fe0vvqa57UeV8fgc2+mprIoEYhJ/oqFXtkmagX0GsSB1alByBtzA0KnyLfcJnmBPFrSHh29GlVp/oWp4PsjLh9iNQzBiMte8UMlvnyAIJLpp8o0xK49N3PrFpPK7JXePZNdVnYz7QdiAyJNZDb4D/Kq3nC7i5ADFQ854CDJbbKsOFZ/gkCBcwuJSb61YrWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaNNTAePTb/2NKJ5qDb+sog4vtTEV6NufAX37X6coe8=;
 b=ERGoWPm9/13BoZepIBZgMlL0npkLSzOS6b8fZXVGlkdN4HVyMzMGhK3OOa297mv2u4ehl6VjDWqeyjDeIjofQa8/GnkXmOtZQtcWkTPKgHz4yz9zGEJbucsODr9al6xg/zsHie0Yu7BSwfwERPVPwUmT8rgTzfbcoRvfLHyQTPA=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2933.namprd15.prod.outlook.com (2603:10b6:a03:f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 18:31:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 18:31:43 +0000
Date:   Tue, 27 Oct 2020 11:31:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <iamjoonsoo.kim@lge.com>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <christian.brauner@ubuntu.com>, <peterz@infradead.org>,
        <mingo@kernel.org>, <keescook@chromium.org>, <tglx@linutronix.de>,
        <esyr@redhat.com>, <surenb@google.com>, <areber@redhat.com>,
        <elver@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 2/5] mm: memcg/slab: Fix use after free in
 obj_cgroup_charge
Message-ID: <20201027183132.GC725724@carbon.dhcp.thefacebook.com>
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027080256.76497-3-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::4:e2f0]
X-ClientProxiedBy: MWHPR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:300:ed::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::4:e2f0) by MWHPR20CA0035.namprd20.prod.outlook.com (2603:10b6:300:ed::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Tue, 27 Oct 2020 18:31:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b264e1f0-d810-4e7c-1d3a-08d87aa68dbf
X-MS-TrafficTypeDiagnostic: BYAPR15MB2933:
X-Microsoft-Antispam-PRVS: <BYAPR15MB293319B1671983465239090ABE160@BYAPR15MB2933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C63rp7E0hh7fo/ZcVxJu8fnSzdjpD11M6GztxNk0pr+Q+49Zn+K/IcUP8iKVNS3cbSpdZZi1WlgkQMH+LP+zCCuyuKfsMAjWdMeEHT2tO/v9/0eRBWzjFO/pZyfhdZ5Hz3D7FJBoxPMgTYjEf1U0AacajfEB6wfKjbO78iPR758pML+XiG1DxA29+ndn2JAjsKY1dNa/ZvdlHbKhhMaxBa5VcVKJn2fE+DnTAE97lj3Ijpxd2yUEeVtjh20qF56scr1liVbW1r8q2Hwm0N2DAxCm5joUD5BQheD6InysavUshJjZ8kReghQfrLM26x6d6DgQNCErRvWCkcOOXg//kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(346002)(39860400002)(2906002)(9686003)(478600001)(6666004)(16526019)(186003)(55016002)(8676002)(7416002)(7696005)(52116002)(6916009)(316002)(66476007)(6506007)(86362001)(8936002)(33656002)(66946007)(4326008)(5660300002)(66556008)(1076003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QcNnCIkswAxXnmamRiIBXsU/ti3RHN0dGoWTFvxcFExRdm1gkYQbis/Rf2WJpFb241NVzyrrAtTJIMYgRlS9JBhCaK1fTR53s8V1pG3BS4ej4vj9DorHhiNcTQWHjz4ShnQ+7IVIv5vbSB8hpN1wdrqanGCaIZNrfIP6HgWhGuV5OvJidtvCZC/llaJeG+pG3p7D5hUMzXaKvw60X6vBbC+u3kquVO7w8rH4ktXSCaJTi6rAzZHSDsulzLlDEp/wiAm/gQmJbRux+XLuI0zTNwS6RHNLPn9Rm07fbwoaoU6aqvyT6ntEhvSFmbHIYHqSfRr2+exK6p6sFW7yJvhteHCZutbZzRSDpf0YKQP6GuBUixMk+lA+hhLhR1gXmQk3HzMTl27KWPVoOWkb1lqR4ffLIWnHl1PCdYhu/NJELOOYYOOPQr74i+JR2L3n9Vq2J3AFZdX2Uk6EjOwVWQXYNMopwIn9h0gcJw5YQd959aaI39leKN0dr4IWZ6z7Eb/DBnwwh+p2R9FzOJJkhwXIhk4i5vcQUQ/9ote1bOQx3GrjfqNhVppw6AneO6nbsLryte8XV1Zv8/2RXwx/bNVheVqvks5X9spAuvo+9Ms4AJURS2MIFHR43+rdGzGKq2ZU4racgXVN/eziLRG0qJxjl571hmxQVkVq/xdkpSdMfi8=
X-MS-Exchange-CrossTenant-Network-Message-Id: b264e1f0-d810-4e7c-1d3a-08d87aa68dbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 18:31:43.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Twjf7j+PRJOiZ4is1jgEyHgNp0QjbSfrhDUGlotF8ILa3cLbTQAur7YDSaqHDCcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_10:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=720
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 04:02:53PM +0800, Muchun Song wrote:
> The rcu_read_lock/unlock only can guarantee that the memcg will
> not be freed, but it cannot guarantee the success of css_get to
> memcg. This can be happened when we reparent the memcg. So using
> css_tryget instead of css_get.

Hm, I really doubt that it can be reproduced in the real life, but
I think you're formally correct.

If the whole process of a cgroup offlining is completed between reading
a objcg->memcg pointer and bumping the css reference on another CPU,
and there are exactly 0 external references to this memory cgroup
(how we get to the obj_cgroup_charge() then?), css_get() can change
the ref counter from 0 back to 1.
Is this a good description of the problem?

If so, I think it's worth a more detailed description and mentioning that
it's not a real-life bug. It also probably doesn't deserve a stable@ backport.

> 
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fcbd79c5023e..c0c27bee23ad 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3223,8 +3223,10 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>  	 * independently later.
>  	 */
>  	rcu_read_lock();
> +retry:
>  	memcg = obj_cgroup_memcg(objcg);
> -	css_get(&memcg->css);
> +	if (!css_tryget(&memcg->css))

  	if (unlikely(!css_tryget(&memcg->css)))
            ^^^^^^^^
	    maybe?

> +		goto retry;

Otherwise the fix looks good to me.

Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>
after extending the commit description.

Thanks!
