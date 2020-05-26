Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16B1E2617
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgEZPyj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 11:54:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727862AbgEZPyi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 11:54:38 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04QFhw7W002830;
        Tue, 26 May 2020 08:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1fdj+iq3jP1MBWtdJyigG3N2HI1VPzgBImfCNqGNDFA=;
 b=LEQGdAShHkvE4a0qJd45NOUc0imlSZy1rrq9fAJxadbQ0smpTboDuT6/ZRioeZSSkYta
 OZFv3jqaQu14rL/wDOHK6PDwiY3Bno3S0d4A4TImfOHerSyieeDbLaKVrLkw21497Fpk
 GgsgE3tY9acZKLloBh8DQUz7I10mx1G/Kg0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 316yb11xw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 08:53:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 08:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aq1ALz2QJc9SAsY/QRXKliy95XRbVKVpTgUQQpgGixQ6hoh3t3EBrIaBpwUVO5A1S+5e1AlCMTUlDGb7To5DdPgYNqBVqDP1C0Fwm12TZRxL2oKHTNAsSgmHqdmhgLrCefrnt/jxLgGpabYZpgN8MmRovYaF6cH8DggzQMfDW66ub8uWTeo/7Kd8UQZBO6fe/v0/VpPURKJcP8oFz278VJkZS9Cz7pzEfUDzISM8DR874lSvfGRA/fu9WGWJmCRoNj8wYtVYltuR1ZthcsDcJyMpEsBvoWxJpvEHNJhOWxKThs2vsV4AdS70H9ehoF+xOqj4XjOGvPZGdjbwq0CDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fdj+iq3jP1MBWtdJyigG3N2HI1VPzgBImfCNqGNDFA=;
 b=XLwM+2TDXVJUVwRuymJO9MGOLC5kvfjcKr22EFPSRvikeUJoZU2MG1UA/IXVqBlchFI1cxyBX+4bh7YB21r2DsEF63VzPcN8aTt7MZz6ML43Tod1t83j42IQ/9P9Nh0BtboNl1nMcJL8KBISHSijFvtPBeZvBwBwzwdl7/ZJBtqFRxkeKauWowzDHFMkGbZdruzVYi8nriEQCqZwg4cFy/9OfeLiTsx9DioFnWD8V62AIeAgludJNGn2Je79W6oICRUVioIpM65QYhWRPsDIPoLjkaMwGrf6dSkzJ/r42RHuBUKIaFgA9/2kl2fhrNkPD/M/5h+NWjy9EkKTGLxpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fdj+iq3jP1MBWtdJyigG3N2HI1VPzgBImfCNqGNDFA=;
 b=b6yzFseVvDRRrbO49Ox8iQkxDiDdk6w0D9Q7qEYtNnTaj+qjco+MrpDTFiyAtZDQzva5CW4kVCQYDMIY4HV+PCrgZtyg9Nvoz5OiyJTfailqcwqWhyIBRm/yrpUUURVuOQvVTby5hHfEB4SJhpWpLeUYb3NqL0hMwLB187H+w0M=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB2061.namprd15.prod.outlook.com
 (2603:10b6:805:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 15:53:32 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 15:53:32 +0000
Date:   Tue, 26 May 2020 08:53:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zefan Li <lizefan@huawei.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v3] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200526155323.GB364753@carbon.DHCP.thefacebook.com>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d202a12-26fe-0012-ea14-f025ddcd044a@huawei.com>
X-ClientProxiedBy: BYAPR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::48) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c3d5) by BYAPR02CA0035.namprd02.prod.outlook.com (2603:10b6:a02:ee::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 26 May 2020 15:53:31 +0000
X-Originating-IP: [2620:10d:c090:400::5:c3d5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecf5cec8-a9f5-41ca-62bb-08d8018cf10f
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2061:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2061B3FE87DE4055E7A347ECBEB00@SN6PR1501MB2061.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJrjSqZxDFPKXeTpDAysa95Qr3Kgr8ptlzL5FyRKwO94mCdJROixT7Y6mymebUACCIjBgU5H2RfjUzliv2BA5/Zpfg8ToxAIN9awPPp1umcoGZ8ANog/nTHjsyuHIARh1PO/AlyGYvuaQ9xMz6UahnhX6LsPYgPLs9Jjt/WkzKy656AjnTOsJWjDNILqeNGUCb6lwJ3772jX5KdhdmO84UsB1o/8RY/ve8gd3q8OM0n6ChMwIPbiunnDyvQMUtGv67n8XBGAD/B2vSrX5HKIPkB4jwNKnmzQuKdfyTaEgIJjG5wUbCSENrzZ3IYG1sKVs+KohfZu+jYtdL+xKZSkVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(86362001)(16526019)(6506007)(186003)(8936002)(66946007)(66476007)(8676002)(66556008)(2906002)(5660300002)(4326008)(33656002)(52116002)(1076003)(316002)(54906003)(6666004)(478600001)(6916009)(9686003)(55016002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: qxEl84UIH0zTOiZ0xgauns0/20LHTx/XZjLKAG+AL0fcGOXGL6eeFAWrLNhb1xQgHa7lbzD5vhIjqhy4iKqsYn0g0LLpl3DvspJBcfqACtWFpx7U6IGnmS1zrBCMQtqGWE3hMtR/4iGMvfg9YrwLFn8iXWqOQyc26Nri8upqQH2f19sviBSO3ogXeNvSwL2g0TUYKdbIf+isaPptH4d36ETewdtsKOuHgpePpNB7Sk2sUq2N7ollkpOjPbr1O6Y2tMV+M7cpheZxZnTi7Jqc99tVYu4FuR7qPZTt/tIn/rwdyX7WSOpRjTxvM3uCKoyF8g+Z7nF6cdazR/hULypQy1E0C3X4k9dQz0koPKScAHlFX4KIuFNUkGwQhOpgtuSgYi5loF8jqvDxx9jWIgpXq2j9LiURwgwM3Ww0na9p+9TpJfI7kXAwK8JqZyUIbL9GFDCpeHT914vXrQuXu9xWv8aP7WGIEiwqYzMJzRN2MZH50HrBlzqpcX3T7YHDEEGloG/VctwQCRh+QztPmLIJ0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf5cec8-a9f5-41ca-62bb-08d8018cf10f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 15:53:32.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOLhXIMJzbDkaDME8F/yiV5oc0rbEs8cokBzsLIeR9+Y1BmgZHhs87WgthPKpXdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2061
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 priorityscore=1501 suspectscore=1
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260122
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 26, 2020 at 09:25:25AM +0800, Zefan Li wrote:
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
> 
> As we will probably encounter this issue in the future as the users of
> memalloc_use_memcg() grow, and it's nothing wrong for this usage, it's
> better we fix it now.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Zefan Li <lizefan@huawei.com>
> ---

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!

> 
> v3: bypass __GFP_ACCOUNT allocations in interrupt contexts.
> 
> ---
>  mm/memcontrol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a3b97f1..3c7717a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2802,7 +2802,12 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  
>  static inline bool memcg_kmem_bypass(void)
>  {
> -	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +	if (in_interrupt())
> +		return true;
> +
> +	/* Allow remote memcg charging in kthread contexts. */
> +	if ((!current->mm || (current->flags & PF_KTHREAD)) &&
> +	     !current->active_memcg)
>  		return true;
>  	return false;
>  }
> -- 
> 2.7.4
> 
