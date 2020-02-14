Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B415F9CB
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgBNWds (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 17:33:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12164 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgBNWds (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 17:33:48 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EMXeh2027295;
        Fri, 14 Feb 2020 14:33:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=NJTCcEwcFzO2aUI9k9ewb64Ri1G+6mIFbjLWtFbHefE=;
 b=LEH1TER7gEPZ07wjd/1jpte9TS9BerO184Mky1raPY0w0WpvcshvHMApqlghotUF+dmS
 +JSJ6VUUnmW9jIDZwNbvraKzBNpmHxH3IJuGm+PD+AFvGSw/gYhCK3fr/ojcp16Ku5fs
 PtA0fxqanoZylMg90AAQNoNilYmmUeVH+zM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2y57e405uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Feb 2020 14:33:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 14 Feb 2020 14:33:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEDodpe4uW/P+Z9d7hdf6KsY6VcNXuAOU9jckm6afr/N/77Wmgrayk+5XG/BKdrdTOF/3sI1J0+ZGSTrs46tQ+LsHcgLifjwp6/dm+dEIp241eJttisN26WwKyrM5koZkbA1cvQgWPiMAe4myQtQYrnv3ZjDY+FVNUBJmbtNKVK7nufTBal8JPLbEEWBEPRkKR4lAFwzcaTsgYtmn+mtEbwKKP98x8UXNY5hXeY6nlSxuKc/MlRqcrZ+R/FK0sYdQOnm7dLpqwHRmub9z8Qv7tKcy+z2P+02LgNMX2D4Hn7vMV7401OnIgKE1D4U+Ullyg+L97/ZHvhZUaj4LR5IDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJTCcEwcFzO2aUI9k9ewb64Ri1G+6mIFbjLWtFbHefE=;
 b=DRxABSisIpMHuHV720M4Y0AQHuw/fmuYxmFpJ0Kqiz9R96RAH4VNSZVvRsmSnncy+cmpBKv2gfu/JhAcUMP60PJVRW3YyHUjc1C5oGBlVQ5DGyb46YV2uH1gfYOO/2AKL0V+WbGUc9nY2KUeRL3asv+FRw4jUcitHDF4TlN8YynVxxonM2UG8ZYdCe7DA4Srdv6hZW4ZVpScwZrGE5c7po84SQ5Biq6wRs2md1h/vEciuD4L3cjxmxe1a0H/ICH+gDbU12GqpKlmno8di7MWnVOAIeNSW+8d+mUWjDaotjn5Qz0airED2Aqge1rGNUuUXYxBbYdPEJs01hs2w3NOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJTCcEwcFzO2aUI9k9ewb64Ri1G+6mIFbjLWtFbHefE=;
 b=S8dvvSHw8lHN+K+Bqn0GhMTW6NrU8NEgLAn/Fj1UcJx8z9xQcAKppgwd/GuXfAhygC/whWhO0eELEqSzf8Je9MF708mN/Lgs1uITc0+5vPtdfaBxFUoNBq0+Ixh+7gC/peUmEwVPvolixkcWjwYAzQjyTvBzUF0SQ3f5rGUrULM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3478.namprd15.prod.outlook.com (20.179.56.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 22:33:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2707.031; Fri, 14 Feb 2020
 22:33:07 +0000
Date:   Fri, 14 Feb 2020 14:33:03 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>, Tejun Heo <tj@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
Message-ID: <20200214223303.GA60585@carbon.dhcp.thefacebook.com>
References: <20200214222415.181467-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214222415.181467-1-shakeelb@google.com>
X-ClientProxiedBy: CO1PR15CA0054.namprd15.prod.outlook.com
 (2603:10b6:101:1f::22) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::4:56a4) by CO1PR15CA0054.namprd15.prod.outlook.com (2603:10b6:101:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 22:33:06 +0000
X-Originating-IP: [2620:10d:c090:500::4:56a4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0335d3-503d-4297-0554-08d7b19ddcea
X-MS-TrafficTypeDiagnostic: BYAPR15MB3478:
X-Microsoft-Antispam-PRVS: <BYAPR15MB347885D7ECEF1D5159BF03FEBE150@BYAPR15MB3478.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(396003)(376002)(189003)(199004)(1076003)(52116002)(7696005)(86362001)(16526019)(478600001)(5660300002)(6506007)(54906003)(6666004)(186003)(66476007)(81166006)(8676002)(2906002)(55016002)(9686003)(66556008)(6916009)(4326008)(81156014)(8936002)(33656002)(7416002)(66946007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3478;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMje0lagG2hqWp9JgRNAuW8PFM+eKdiLn8Xrf+QNttk0irvfSqDqIhYKDwstZ9cqwPUo64p7/GNRhW0Bo/rcazjoRO12tsrIL2SO6vSOuyiEtEf+iSVk8oSEUzVAVfEAGohimuw6nuJ3zNv3LqI9MEpTBzYdyl8fvLF0SOt08lQOwYYYAe0VRkPekRwJ7O3idR6MMkyoVVWdpTJwAulII9KNiRELrpx7WxzxIZmVKonT2VGtbCssp/2MAtklwjHrSeQtg9bFmicDVZZ4IOO4KhIRS489GkKWZV6J9wvgk60himIdPckY/hyNrCEbpxsxLzexmqeJnxvAzW3yL1oczsXBL8/3ve4bYYIbIdjT6EuzYosUcc03a/z50jyFPI/uEj90gE/U2igo0ax+YhBxGYWsRGsF09NIU0umRtAUnVH+jcBdk8V9M6zfpUCrFliV
X-MS-Exchange-AntiSpam-MessageData: 8hCXHACHN/8RaO0x7NaTo/PjtUrFRKAPvGtwqMSHnBY0JIDTWIPmosmerkMgNbT1kQAjAUVfwWcsI32GP/DI5ctZID1G3hMMtsOHD8Sn+KPaqEJImaukeEXyT7py1xlHAA5XHnqgu13XdJvdtuawy430jyrQdmYHV3z2nOHbWSPWVnRIjeGXbbHTAe30FgPR
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0335d3-503d-4297-0554-08d7b19ddcea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 22:33:07.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC1uEX4/5ox90tesRLBtLjXOIuhfROh8jrdE+ewxwC5gTAZELyiFMYzZ2R1+bru0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3478
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_08:2020-02-14,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 mlxscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140167
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 02:24:15PM -0800, Shakeel Butt wrote:
> We are testing network memory accounting in our setup and noticed
> inconsistent network memory usage and often unrelated cgroups network
> usage correlates with testing workload. On further inspection, it
> seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
> irq context specially for cgroup v1.
> 
> mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in irq context
> and kind of assumes that this can only happen from sk_clone_lock()
> and the source sock object has already associated cgroup. However in
> cgroup v1, where network memory accounting is opt-in, the source sock
> can be unassociated with any cgroup and the new cloned sock can get
> associated with unrelated interrupted cgroup.
> 
> Cgroup v2 can also suffer if the source sock object was created by
> process in the root cgroup or if sk_alloc() is called in irq context.
> The fix is to just do nothing in interrupt.
> 
> Fixes: 2d7580738345 ("mm: memcontrol: consolidate cgroup socket tracking")
> Fixes: d979a39d7242 ("cgroup: duplicate cgroup reference when cloning sockets")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
> 
> Changes since v1:
> - Fix cgroup_sk_alloc() too.
> 
>  kernel/cgroup/cgroup.c | 4 ++++
>  mm/memcontrol.c        | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9a8a5ded3c48..46e5f5518fba 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6449,6 +6449,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
>  		return;
>  	}
>  
> +	/* Do not associate the sock with unrelated interrupted task's memcg. */
                                                                       ^^^^^
								       cgroup?
> +	if (in_interrupt())
> +		return;
> +
>  	rcu_read_lock();
>  
>  	while (true) {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 63bb6a2aab81..f500da82bfe8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6697,6 +6697,10 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  		return;
>  	}

Can you, please, include the stacktrace into the commit log?
Except a minor typo (see above),
Reviewed-by: Roman Gushchin <guro@fb.com>

A really good catch.

Thank you!
