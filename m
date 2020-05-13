Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059721D1ABD
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgEMQMw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 12:12:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730831AbgEMQMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 12:12:52 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DGBUiB002049;
        Wed, 13 May 2020 09:11:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=igsYSo8Rnj6AmhEEXQNL3hz7d88Zd8kYSLUh0Cs0nos=;
 b=MXedZEZyw5bxnxbfGeyniV729AsiWCIr0AWvMRoaQlNsZgqidsm5cDO4xBi1dX61FP3k
 IXylAtDI0wxu6hpx9mISYBvsm8sJ4ir1KQyo5FiY5+Ot8DSBpSa/DqTBqhnlWvtZFrGE
 cuNNBjLP1514vRzJrVy4Rkly8ptPEENb7z0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xb5qg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 May 2020 09:11:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 13 May 2020 09:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR0H+Iz7MZWrNIL+7u9wzuZPDtTvHAaA+SCdiiQv6+jPyMleHpepWqP5LXeEyd+6R0sv4f9qdnzRdWP2bYT/2qShDFzvS1ufHJtnioELicWvv0BvGa0f2+ZL0Yb6jzKkqqaKSl+r3ObvZdZ/6NJSHXxKqLHPSEJPvBi0zWBxFjG5Tk+su8DK+WkzMw9NX5Dno2FnzziRtuUqMy/F13U/KmhSA9L2IPbtSKyZTeuUfBcX6cxHUSa2xmtDiUP/ZxPOW7adUqq/kpAKvmLfnz2hvjvEQP/B4hiKUBALorsnwNnoGA4AiLP/rmZzUl0ABD0UYuAVOqYmmo4jF7aJF9dguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igsYSo8Rnj6AmhEEXQNL3hz7d88Zd8kYSLUh0Cs0nos=;
 b=cStSckZrfC3WwYXtMTQppsH2SqWdlxRzFtNmWk7IPZEss5jDFPjZ9mD27g/80jQDP0A2ycuXocTeN9O4LRCnrsFiq1qhZDbNA14fMMR+3/EtKvwGTTd3mhXTA8KtD5sa0m48LoZe08zY0Tm62t1cIQrLCd9MwEJ+47rW3uz6CEQAaq6Io3GUrnnMpz6eEy7SBaxCkf88kIK5NfW+HDXNa6gvpr36dkQm+H02yFna2R/+jM8P6dfKcQZihu83aP2CPxs2Cu0T0Jg246nzCrnibfiVbALQcEzlVg5uJy/tvRgYFdC6Wf1uVjS9doePi/CwlZS8vj4xN60vB9tmPCxcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igsYSo8Rnj6AmhEEXQNL3hz7d88Zd8kYSLUh0Cs0nos=;
 b=MJZvbtQGba6MreT5VR30DnXgtFKRGpjEiagFzp6TTr2Q9+MiynUxof2a5t+wc8GI6Eln+rcObrXkW8fvNdtDgns0GYzadcHEVRCQlbdXR4Cx86CMrTWXgUTX8Hz1ojygmHY2YBmKU17f6jDaXdAg+DrRXuLYmWJEzdvJ7/eznFs=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3429.namprd15.prod.outlook.com (2603:10b6:a03:10c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Wed, 13 May
 2020 16:11:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 16:11:13 +0000
Date:   Wed, 13 May 2020 09:11:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Zefan Li <lizefan@huawei.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
Message-ID: <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6c9e) by BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend Transport; Wed, 13 May 2020 16:11:12 +0000
X-Originating-IP: [2620:10d:c090:400::5:6c9e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 905db2fb-b8ee-4ed4-ce66-08d7f75841d1
X-MS-TrafficTypeDiagnostic: BYAPR15MB3429:
X-Microsoft-Antispam-PRVS: <BYAPR15MB342987CDF155CB9FD1AC0619BEBF0@BYAPR15MB3429.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkHE76BueKd70voW4UKblcz5Oy47a0yLBzZFC+awpJhtMf08AAuzOAb4u6junyBw6q2rR352XahrRzuPEy2zBtROfAizj0CZLH2S/YPQM89hMYOHoKVhUNN2a+BFbN0JIRCxxcXNysiImexvBGDN7OQriSftryo5H9MKnLDguz0CuGp8vVTQgzhh3cbX6jtfhHOm2pLn3J2bzRnXxYuTzNXenOR6aWY819fWqTtd7vMCDb0HVlQTY4S12MFA1BwUmuslZebjNP2s8hytW43Yl4uveBhUZCJ6U9HF8NnmsGdFv/wEKdedLyjk2sSd36/XnQlZecVW8GH67v0QRWE7ECt+BlixPPmVmlKnMc/RwZU0ubT7sfBSxpJvc+i9bKGhika5zxxXa2AnjYR+B0oukOHC0ir20LEr2hBZg0HIdNvj6BdxJJ8Uz18xTge2cCR3XnqTQY4kSKNP4GdsothU+wba+wpCaIC1tvvDZYC0HAM1M6qnFNy7GDwZwg2wa95hDrwHqljOdB8/eE8g5PWExg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(33430700001)(16526019)(316002)(54906003)(4326008)(33440700001)(66946007)(5660300002)(55016002)(66556008)(86362001)(1076003)(66476007)(8936002)(6916009)(33656002)(6506007)(478600001)(9686003)(52116002)(7696005)(2906002)(8676002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mNUYSSF8FbIaOzTReXX1sMSp9ytrj6/Rq4ODmx+5+yDvme9MM0JMgK+FeK7t9SSMCspN6jIeTuwJ2RJMCyFHlasscaQ8MRk1TuqqosXf1aEsdv/P3YqegAW+OZZIsIZ+E1qEKj8gzHBaNErWdLEI+Z0lfuwMmMo0zxLQRR4Y5hbmm4KfgKxVOk5erE2bmY9g9VZ/cRkrHc9sHQEhiFlNTusL8gCiNfOSedUNKd0en0c1MmUko0SMLpgjK9rw2bTb5Z/VWRlzSx5jX0aTl/3x2/4VaJvguKA4oYSJHgoLSfQ8XIA8RDp6Hp2yPcO31SFog9YeiYWC9JJMF0lKBXX7V0QWEBpfMh5ZZsC1lX9d1vKvvI/Y6mVHMTjMovxk4hwjpHfDi/LNhxjAZdYRCSxtysmoyQXP+j5IjTvTmIHnBKNFsEp+51SmgNdXZtSQ8F8c9HwuGAzFSMb3ntAJpibfjMbaITug/TyB7o0P/bKrAm1yQbp7dPxb6W8itiHvT0Hw0Rw7pJIQ4GIbiIj6VILeKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 905db2fb-b8ee-4ed4-ce66-08d7f75841d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 16:11:13.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k35ZsA6RhK7r1cTGIL2llwM2g2XwFhZwiqSYs8XTHx8iOQfWMGQDkMn63v0+8WmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3429
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_07:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=1 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130141
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 13, 2020 at 07:47:49PM +0800, Zefan Li wrote:
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
> 
> As we will probably encounter this issue in the future as the users of
> memalloc_use_memcg() grow, it's better we fix it now.
> 
> Signed-off-by: Zefan Li <lizefan@huawei.com>
> ---
> 
> v2: add a comment as sugguested by Michal. and add changelog to explain why
> upstream kernel needs this fix.
> 
> ---
> 
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a3b97f1..43a12ed 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  
>  static inline bool memcg_kmem_bypass(void)
>  {
> +	/* Allow remote memcg charging in kthread contexts. */
> +	if (unlikely(current->active_memcg))
> +		return false;
>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>  		return true;

Shakeel is right about interrupts. How about something like this?

static inline bool memcg_kmem_bypass(void)
{
	if (in_interrupt())
		return true;

	if ((!current->mm || current->flags & PF_KTHREAD) && !current->active_memcg)
		return true;

	return false;
}

Thanks!
