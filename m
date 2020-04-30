Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2821C05A2
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD3TG0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 15:06:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbgD3TGZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 15:06:25 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UIk7Zw021042;
        Thu, 30 Apr 2020 12:06:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=izMAJz8DJVs85exNsDSF0g00gieebqbhFq/VLhscdPk=;
 b=LmahK+czBUQ9NHDakW0O/IPvAmo9wvBjbXymAtqv1ePSD7ttgke32LAMZKguOm1Drfdg
 7RxheLnQUY/HGP3YJJEO3rqZ0fp7rfmiwmuakTrfXbuf8Qwm1W2XHVng+nmRBQiwXcEz
 WRp6u6m/8SzZ8I1lnemZ1pMtPr7SNjFWZRA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30qu5mbag6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Apr 2020 12:06:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Apr 2020 12:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUt0ANLxbZTYwrTIN1FXJ0wO0YMjKoBVe/jx0visHv1fNuZ4pCSNVkxL3QyzlaU+ehfolnST0Fb+5Z1T8lDvBJ7tVgsP67wnsi2Zg86ytbUE7dFmZrlRQafFh7n2HGhK3CE//N0fW6t90J6twfCs2/WG8Y/gMP6ZQIvR+yqYCJAmLP9fwGSacX01GTfY2Piw+Lmmxh9SVMfpLYPJY2XxUu6qkz1CqR0b34firDpIzl4LDh/i3cHEETwPonMQywyoHZqOf8QadnVHuJ7Uk4WYfexynDzV8CLCNfC4Ry4ihFQGXMzqP5tuSDDVhTWxAx4XKyEnQaoTp4VOlvcIlVL3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izMAJz8DJVs85exNsDSF0g00gieebqbhFq/VLhscdPk=;
 b=YLuXx7Z4dGAuhHHfKQSQ3Mjd0iD3ZfR+27Xtz+irsV53ctEmdFbRGztYD0h1uwreGB5RnEKhjuiRsyScCYjVcwCWcIW/P/lJWVIl+XnYmG2ErmeZWZgxmnXKI6RGRZy0AUiZgGPX92zrHz5yjzZce+zi8WLxIeelQEZBs+YpVLLEh6+uasCMMDSnZTXp6AibL31kXOBjcoj4CyS1BHudnVYGD4BfFtRekXADK5dFUGorY10BaEJnVyIun8AfozZkLyzMuKT0zDoD82LWd92N3bZ7HQySi1zwLvRagl2F6Bh7CoJqZInVi6PJhSQ95Chs7G5EN+IMmWzvCEUFdF4vQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izMAJz8DJVs85exNsDSF0g00gieebqbhFq/VLhscdPk=;
 b=IJemA5xFGWGxib2c3wopxExH+ydDTC6i+wn8i0iQ01Yi4FE6pzgczw93J6Fm8a6yPo51Fqn4R1scfX8/uSzZHxlcGpyiS90qau1/HEAMd8tG972J42kHw9eK9n27gYD3W9IqCQYgot5T2cRrn2mixR4l+rFjonQ/EVXyp5dK51U=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2389.namprd15.prod.outlook.com (2603:10b6:a02:86::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 19:06:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 19:06:14 +0000
Date:   Thu, 30 Apr 2020 12:06:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200430190610.GD339283@carbon.dhcp.thefacebook.com>
References: <20200430182712.237526-1-shakeelb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430182712.237526-1-shakeelb@google.com>
X-ClientProxiedBy: MWHPR2001CA0006.namprd20.prod.outlook.com
 (2603:10b6:301:15::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6bb9) by MWHPR2001CA0006.namprd20.prod.outlook.com (2603:10b6:301:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 19:06:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:6bb9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32467cec-af2a-40c3-d046-08d7ed398daf
X-MS-TrafficTypeDiagnostic: BYAPR15MB2389:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2389D76F09A56FF8293E506EBEAA0@BYAPR15MB2389.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7v2dGTb+RMqcKT2+kKphjClvpDGx9eaa2PH8XzgTunPXy6sua9I4IsLEFk4Sn8fHrWMQM93vsFqOQwL8fIpNXwymoMVgFoHo3uUVzm8xf46mx3w3TDO2x1cPKaqLTcGLq/6OFeJLhBA60uh52DdJ0P6kMT2LdHPedDlptsAVOgCeCaTV8qxu8mLGzC2HJX3hl2EBiOHol0/vRKZcTTF7J+BORlcWNf6A9NH6q/E2902hsZ41j1G1oepQHzAs5aY6HVq5Ei0Jx3xZ0px1fHz+LDzKEdRFDJ+oIqfxBVn6Bl8Mpq0CIlriTYmNK2/K/6aPp5j/8VIkyf6CXsTv52hTajK+uRzcjF8aH5/6x+37/K6Wd+Ar9h0owhRs16TkCVm/KbcA80/BOK6RZQTDJZVupDeAhR5oP+6L0sQoze1PtdFEoLOMeae7lanxhNFQ9ve
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(376002)(39860400002)(346002)(16526019)(6916009)(5660300002)(54906003)(1076003)(6506007)(52116002)(7696005)(186003)(4326008)(316002)(2906002)(66556008)(66476007)(66946007)(8936002)(8676002)(86362001)(9686003)(478600001)(55016002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mcgRZXS/Il/+qrj0AASXSql4oWJF8tri4YW92oPAxRarUtIA64kACv7udp1Blu1FR8l+rlPKZUdm8ybzV2TMOa0+c/svH5Cd/gvqNPOqVwmxE0y30d4dMz//w7tf3sECDHGAwGg6yrysp3XNs2YujhHkYkKkozSmIr5nxducut54NIWO5S1lyosDyPSwpc1ktwPbhA+jz3yuW6q2tnf8ED7BUIBwafjl48Zt5y2N631w+9J+tq2GQvCTZhTQjh0+rQ4kAJm6lkXvWzSjji3niTBBC6TR/LXq26b5tYcwmydcayiktsCEEwqkp3Qv1wVVxHQ8sgkdpxvWevWDwf8EOoWVK8f6OD+p4n9qQyCNlABB2AdaZwcLAzKTgCMJ0iRi4aeMDKFu/VzAklMkRTctb6AcSdQn9xtEThaGbDz3uNNA7x/odid+/r9Sa4PgB10I2kZrD+UwKXgC+uczqkN9yiGiwib5kDJCVi0Ki4RHKiq2pjCpBdyOyo3RhC3D5xyQ4JKX+ojXbvIRBIUmjvNj6hc89sQqkWADPISi2Ek9Nrda5Q7twCDE9E1W6F+XgvsfwKih4jRJAIk2jnlPDW9pxeb5TMCumpW7d9//b7lCekrsDmfaYV+8wUiOd/5WlW6VaIJbkd2c6i+2Ch5f+CK4Kqs4PFWlNlCEyY1oeLtxY70W7+7BMhbYOsgmKGyaKJY0chWBKeN2znchBQMZP8Ekb33pwMSv9/gDTssIfVkSeCacfctfs4+YW73xeDI7zqeptOaYX1ODwyGSHAp2Hi/31PVkx13eOj5VC5iUsqjERzrXFl+QaSAcFzeyuMaoEdwwltfkKQ//d4IRW1eGudKwNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32467cec-af2a-40c3-d046-08d7ed398daf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 19:06:14.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uywNr/QS7i6XSv1XFlnGos/zRok4knM9lvqOeSh9iGeow+ybIht3sbqhVj5uxabs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_12:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=1 clxscore=1011 phishscore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300145
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Shakeel!

On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> Lowering memory.max can trigger an oom-kill if the reclaim does not
> succeed. However if oom-killer does not find a process for killing, it
> dumps a lot of warnings.

Makes total sense to me.

> 
> Deleting a memcg does not reclaim memory from it and the memory can
> linger till there is a memory pressure. One normal way to proactively
> reclaim such memory is to set memory.max to 0 just before deleting the
> memcg. However if some of the memcg's memory is pinned by others, this
> operation can trigger an oom-kill without any process and thus can log a
> lot un-needed warnings. So, ignore all such warnings from memory.max.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/oom.h | 3 +++
>  mm/memcontrol.c     | 9 +++++----
>  mm/oom_kill.c       | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index c696c265f019..6345dc55df64 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -52,6 +52,9 @@ struct oom_control {
>  
>  	/* Used to print the constraint info. */
>  	enum oom_constraint constraint;
> +
> +	/* Do not warn even if there is no process to be killed. */
> +	bool no_warn;

I'd invert it to warn. Or maybe even warn_on_no_proc?

>  };
>  
>  extern struct mutex oom_lock;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 317dbbaac603..a1f00d9b9bb0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1571,7 +1571,7 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
>  }
>  
>  static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -				     int order)
> +				     int order, bool no_warn)
>  {
>  	struct oom_control oc = {
>  		.zonelist = NULL,
> @@ -1579,6 +1579,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		.memcg = memcg,
>  		.gfp_mask = gfp_mask,
>  		.order = order,
> +		.no_warn = no_warn,
>  	};
>  	bool ret;
>  
> @@ -1821,7 +1822,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		mem_cgroup_oom_notify(memcg);
>  
>  	mem_cgroup_unmark_under_oom(memcg);
> -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> +	if (mem_cgroup_out_of_memory(memcg, mask, order, false))
>  		ret = OOM_SUCCESS;
>  	else
>  		ret = OOM_FAILED;
> @@ -1880,7 +1881,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  		mem_cgroup_unmark_under_oom(memcg);
>  		finish_wait(&memcg_oom_waitq, &owait.wait);
>  		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> -					 current->memcg_oom_order);
> +					 current->memcg_oom_order, false);
>  	} else {
>  		schedule();
>  		mem_cgroup_unmark_under_oom(memcg);
> @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  		}
>  
>  		memcg_memory_event(memcg, MEMCG_OOM);
> -		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> +		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))

I wonder if we can handle it automatically from the oom_killer side?
We can suppress warnings if oc->memcg is set and the cgroup scanning
showed that there are no belonging processes?

Thanks!
