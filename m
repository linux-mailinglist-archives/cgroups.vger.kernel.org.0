Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC01261C97
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 21:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgIHTWT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 15:22:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731105AbgIHTWN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 15:22:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 088J4RjJ018544;
        Tue, 8 Sep 2020 12:22:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7QX1xtipYv2lrQoBAp4Kh3zUfH1Nj+wYaDl8hnBei/A=;
 b=QmuXPmdHgFxlLIP29OexIvi79JSmTw4nJJENBSgQbTMbjKGPT5R2sReSr+Txim1h6BVd
 2gwLmPK/yTFHBk+V4J9QMME2jEmuVn3OXrsQUpNd/mXMnWymSPZpEDIHEBhzD13UPfc0
 nZ99+egAtvXUC/AxLyME5qvK5RXF4w7P1Rg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33c662635j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Sep 2020 12:22:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Sep 2020 12:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMXMMm1FE9D3UEARdjDiqTzMcuq+WxG8mmiJyNg7Kp8o8JwqrQZHiAKN3ng+TDe34NmYi7JYbx9EZduKRCsYtazNDi/79IqbSP9UForgBDaWsvuSexRlS2QjxLPchmKnuCUjoR2W0TCcqz5BPT0OAgijydJw6PeVTkVbISOJCqHLt15pf87WHVHOusgvtw/lYslo0pQlqhxs92X/mFzRNoFRE3vlZojv4h6EVaO9q9khHt5lRGW1vI3DpaMhecGjgNNeHHIhxf2zzaLFOnZXdXAJPPAseWh+nA6zDszVhPaARsg8ZaK5QH1CN1WA3wa7tLYXALC1KbBlCCGmM5+7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QX1xtipYv2lrQoBAp4Kh3zUfH1Nj+wYaDl8hnBei/A=;
 b=EIvykbsQFciJ4aMIP0uX4XsJ/B3WwmW/fSCQdPMzmWNF1cr6cylDHaI4Efd969W315E7RQwNqjjgchXhK07Ig1Z7A3gfMRqqE3bwjF34GHKImdNZVLXaG1derAq7fIWkr+yNo9dtgHUu34J4xnhmY73jx7XgqaUgTti0cuYqSU7UMj+ZYG1N5ruwvHx7pR4Z3vku74hySodGX0hCDXlBJ4ffFskVmDmcF4QUk73HAEzCMWViZpkvEoLvgQaYSNwT/kzhau4LuzsuJi6NtcFF7icvV41kA7pKNqf8h/fi5Datxt/ElulOhW5rNG+Onkr/9cI6wubr537zifaOu+DENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QX1xtipYv2lrQoBAp4Kh3zUfH1Nj+wYaDl8hnBei/A=;
 b=T6yomLM4mbZJxH0RZEkpenNWeu7il9BxRS/FnHMz/OAfbI1pEt7popifR+Yb0GxxGsvG2whBNppxNDv1FnVJwSI1Rm+cpiUHHfdgQISA9D8hHL24aCyd2rU6T1CXTBKg2651/xwOeuDGnAaoS8xhVJx5oaQHt+hUV9+7sBR5y90=
Authentication-Results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2663.namprd15.prod.outlook.com (2603:10b6:a03:15c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 19:22:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 19:22:03 +0000
Date:   Tue, 8 Sep 2020 12:21:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Julius Hemanth Pitti <jpitti@cisco.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <xe-linux-external@cisco.com>
Subject: Re: [PATCH] mm: memcg: yield cpu when we fail to charge pages
Message-ID: <20200908192159.GB567128@carbon.DHCP.thefacebook.com>
References: <20200908185051.62420-1-jpitti@cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908185051.62420-1-jpitti@cisco.com>
X-ClientProxiedBy: BYAPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:a03:117::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:62d5) by BYAPR08CA0040.namprd08.prod.outlook.com (2603:10b6:a03:117::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 19:22:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:62d5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bccfcde2-21b3-4704-9efc-08d8542c7730
X-MS-TrafficTypeDiagnostic: BYAPR15MB2663:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2663430FD51986747A4DBD86BE290@BYAPR15MB2663.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVF9Rl/ZnLpJ/LRXc0q5heGk5hL1nsT26BtMLcIDNe4TjhwVmFDSmC2TPlae/hHxxNQnmMij0dmeIxIjPkFmhutcP4qKIuDzamtJdRG7GegF9FgehlfIZaZ+T0s1SJjZ/PE1DO5XFfWJ8+qmHVID7IfRQGpPhniFgOXwaIvk71ky0bxv4sY2Elf89lJOqmYW0xd91Zc37A07vKLFjbe3XSs2GEwS+RoTkyBN0wjRidSQqHm2niEz3d87za6fAChNF0IikpqLlK+HCu8bAyD5kqkG99HtWZG7Wsgy651PUcQP4+DFt5e/FpqakNMzfu5MJJ8/M/Dr5VYJtKp9b+/NJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(66476007)(52116002)(8676002)(1076003)(7696005)(2906002)(55016002)(6506007)(83380400001)(316002)(4326008)(86362001)(66556008)(9686003)(66946007)(478600001)(16526019)(6666004)(8936002)(186003)(6916009)(5660300002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nthxTpZ8Y6yLNx42T2jgHwUurHEOGcNuYVXlHROsFoaoXGbRLho2Fuuwjp0vuYkKNWPxML9dQk1eKR+LfPmlCnD/wbhu3dQvZnfBa/Kdnq90YZ9IiRpl2TXW5js+TebORYto6GlHcplvJJsaCMqr9yraYbmTP7Qxx5jnfFAKdBzzvsol8YBEamI6u2HXivcfB4vNgksyDKNydtUU/vzTz+W8nV9Sf5Y6FHRdbGbM8qAzjQVByU5VFa/xNNGwNjehys2PfR6bVUvv4kdPQaQ1mwI15fc4+WUdabSJOMhCOg3j8X9dWf/bHUCRSCiln81EQO2EkWhBRHC0pMQVsDge71u6HR/ZSYofFpoYGpzHzoSVJNq9BMDTC+lcZayznCm2gn6xttfwUmNK4TZbrHI7reg2J18L6InsCqhgt1gsgSCifphNu6TF144MrcWcj5CPVZ9nn0xq/rFiNb7uyHUUCWq0eQhJBp9jvtQngIXIp2SVZP+w0E51YGBkt4qmq3XSf0tTFbuUtSFRo9OdUBd7fruk+Wpg9tYAIrpKOj1zWKFErdJY7kSy1hV+q/RvvOjKM8CfLibeLyfadwvNC+pAIRw3J0J2RHVw9aG9SRGPtbx5uSFeuiZhK/LRNjVjTQI9oan4dspki4imn0imf4Fe5Y/hxwmcVmqDMIH1VefuAJY=
X-MS-Exchange-CrossTenant-Network-Message-Id: bccfcde2-21b3-4704-9efc-08d8542c7730
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 19:22:02.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieXbSqFp+Q+4imjGRfmJIaAlWq/veOsv3UGyf6n1aGHT/G28UzOAWA7+RAzrcsWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_09:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=1 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080178
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 08, 2020 at 11:50:51AM -0700, Julius Hemanth Pitti wrote:
> For non root CG, in try_charge(), we keep trying
> to charge until we succeed. On non-preemptive
> kernel, when we are OOM, this results in holding
> CPU forever.
> 
> On SMP systems, this doesn't create a big problem
> because oom_reaper get a change to kill victim
> and make some free pages. However on a single-core
> CPU (or cases where oom_reaper pinned to same CPU
> where try_charge is executing), oom_reaper shall
> never get scheduled and we stay in try_charge forever.
> 
> Steps to repo this on non-smp:
> 1. mount -t tmpfs none /sys/fs/cgroup
> 2. mkdir /sys/fs/cgroup/memory
> 3. mount -t cgroup none /sys/fs/cgroup/memory -o memory
> 4. mkdir /sys/fs/cgroup/memory/0
> 5. echo 40M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
> 6. echo $$ > /sys/fs/cgroup/memory/0/tasks
> 7. stress -m 5 --vm-bytes 10M --vm-hang 0
> 
> Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0d6f3ea86738..4620d70267cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2652,6 +2652,8 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (fatal_signal_pending(current))
>  		goto force;
>  
> +	cond_resched();
> +

Can you, please, add a short comment here?
Something like "give oom_reaper a chance on a non-SMP system"?

>  	/*
>  	 * keep retrying as long as the memcg oom killer is able to make
>  	 * a forward progress or bypass the charge if the oom killer
> -- 
> 2.17.1
>

The patch makes total sense to me. Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com> after adding a comment.

Thank you!
