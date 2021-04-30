Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC136F48A
	for <lists+cgroups@lfdr.de>; Fri, 30 Apr 2021 05:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3DYf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 23:24:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229590AbhD3DYf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Apr 2021 23:24:35 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13U3NcWf024598;
        Thu, 29 Apr 2021 20:23:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Tv8xAodhZB1pPWLe3ajSdpX6HV4ol17IoYFcGyP/eeg=;
 b=E+BHothG1Roe92Q5gkeQbZdXeOpFQ/j1tns/2OCleu4fbNdYUED4zqAz41XnU6bzTlVO
 ZjRtAVCnQ6p3KixOOE57HuSA6lZgfECwYzX1EYyKakdbPypZNuPcDrRALHnGi8Lq9thF
 tKzjKScGIvUXvwIqrQPQiKjr1D/FrMSEbto= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 387ppaphse-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 20:23:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 20:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmicrxttM5Y5rSAjMcMUaxb+Af2UhYs24birBuvk5pUwHRGqkkZb8PrwgxHL/7tOxnRzSklfEGDpOOnuclP+xqDcN+ZqrcRgZtY7Utb3qEQWQ2o0VeK6vDrRABjK9NyHHg+MjfPS7WGFdKmsaikuQm9wd6gQXSY5QMohHIpNLrq9WBSSxQX29B6NtAYsYx+87BidUbpLVjp7tQwMX6CmD92CrsRuZZFvj8MwRJoOwGawpP76fqW7EP0OJ68pJL+9z1uLq7Vcnr2eC4Kf/TjclUVp+Ohy0eCoW54qD+c/ZP/4y7y+9aHq+pe/qvIBuSUFp785lbvmbgxocN/6M384XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv8xAodhZB1pPWLe3ajSdpX6HV4ol17IoYFcGyP/eeg=;
 b=k3jnV9mPC3GnWhVzIWED92ASJZietWy5TCXpR/Rpm9Xv68RpZQ2OHJ/MHUklnH1YTCCYwmo01tD/eMcY0+6o2lCpSlStyOyfCVEmmg8s6bhoguv46JlCm3PlU2beqhcJs7yABDvyvjnPhEwTH+3Jk57TnlB+aeqGzQg7YfHNkCA4a8MHCAx7ianu+r+EA1ATrjVItUceEj0aVxAZPMhNG1swoMeeqp5/sKOdP0pUu4oKALaPP/G9PhIq0Mn2ruqgGs7cTDexI16IMrAJdnkFjcAWB4C6qN0//jwHBQwAhvFTouNz4dM0VR4NSGQc7prvZ3UOpCtdAi1hhVH//jrFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3141.namprd15.prod.outlook.com (2603:10b6:a03:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 03:23:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 03:23:38 +0000
Date:   Thu, 29 Apr 2021 20:23:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 3/5] tests/cgroup: use cgroup.kill in cg_killall()
Message-ID: <YIt4NhikbQKc0Vku@carbon.dhcp.thefacebook.com>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-3-brauner@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210429120113.2238065-3-brauner@kernel.org>
X-Originating-IP: [2620:10d:c090:400::5:9c78]
X-ClientProxiedBy: MW2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:907:1::36) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:9c78) by MW2PR16CA0059.namprd16.prod.outlook.com (2603:10b6:907:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Fri, 30 Apr 2021 03:23:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffe8cc35-cb3d-4210-c2e8-08d90b875867
X-MS-TrafficTypeDiagnostic: BYAPR15MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3141D2A6534F0B99F3D2EC06BE5E9@BYAPR15MB3141.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQKx1HLVd5lcEFGzfUc8pNb6EjM2hN0cYEdTp45flrJ5L5MB9isJT/SGKNmV3WgejXcWDbMn5WMCM3FdutVBFNIl6H9SYvO07nGCE6wwDnfx/A7aDtjDutvRheCa23Cs+3tEs4Lxj1mCNuLgFIRA/5kGBkWio5UOwI+V1g8+BeEaf2i/XU1noosCS8UxVuHrhfVHFeqGsw2/GSXeq8Iw/a9GN7SMnTY7i/g4bOPLyaZlNTgnXtWjqvy16b6+o4GHFduODnxs19H3ngPiUq+m+sefUQ2JecUC8/pXqV2MHNBmRK2/lHCRSOhFKnTZp9D3Zw+j9FPbRWAlolzpGo5JWMtxT3HTWFOYL3w9XA5GGsYMagcFW+gzukgRlIA8+rfViWEReGen4a/D4S5vQTAAgJholsSV0nYm8BUhBPFEoXxJef8jbXPP0V3mn8yQFddwHQM3C87JtNfztLyNzk5EnanXwSiHClL5gHQXzUtwge9TRnqNFhnQo9iTZ28sNIxGFKXSkOLP0yvp6UMNiEPlSgmi45xaKRqt2tFVu85cZpZ9SAEhKGFStP7GAW4VCRgvdKNBw/HblBPsf4BQ/tRffIImhyd+DZEL0kJ6nDNjWI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(5660300002)(2906002)(8936002)(316002)(66946007)(55016002)(66476007)(38100700002)(6916009)(6506007)(52116002)(7696005)(86362001)(6666004)(8676002)(54906003)(4326008)(478600001)(66556008)(16526019)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Wzf1rqaNiuLqyxN+ck2PkDmR5vATXk0/kUiUCysCs+3JQ+IOXrYmdCVgmtEu?=
 =?us-ascii?Q?a5u07aXkrusO2yny28L5aLo26lEKAQgwGSJKqPbIb+7iphtrkg8/P1tZQ/aS?=
 =?us-ascii?Q?jsxecSN4OKA1mH7UDV058yYUwsfal5bY+vixFANJPyLzyiJhiAWxqbGjndiy?=
 =?us-ascii?Q?Kh4vDTE4ldnRQrV0JhaBK0T/HYEoK3JmqSHhxy3Ms82Y5KC7+dlef/6j5UUP?=
 =?us-ascii?Q?zdHkQZDLJgsb1g7aOkmOV8VufD3Bf49Fy3OS/J+Bveea52rca1rFxuYwhlDj?=
 =?us-ascii?Q?bP4eNVXd2HEBdqBAEKEdRZ0r0AuRZBzFRRY/eXekK5DBfHvAPBHPu2c80Frh?=
 =?us-ascii?Q?gLhmc9pqGFIFlPrF7hIVdgh990JSyebd8IdmSczzK9v4rST14fstuQGYf8Xg?=
 =?us-ascii?Q?TGmlKW5udwo9caxILDXlOiWYyFNYegaUgH7uk9Ayvx6aYWwFAh54lveMWGr2?=
 =?us-ascii?Q?OlV2MpU0KDa4KI4AqKpTlsOE0by1N8mYFtJDAAtjtza/4ghu2918RJIdFKzE?=
 =?us-ascii?Q?q7bneAGSpJ00onohNB7mZS0lJk84PYQOQqIOIwJUHZskaLe8nezG2biC/XPN?=
 =?us-ascii?Q?aUAGJbAoNYW4vCpuRiaSFE2vcfnIbh8FsezGFG3G5SYlFrmLLaHK1Dx8DOIS?=
 =?us-ascii?Q?zGB+322k2H/ag2H63z7WuN4cKygbtv7KUu8jXNKNn/pICjahF+v8PLZmuHQY?=
 =?us-ascii?Q?qpVPtbrzaSrsOnjMQm4rViJoSNDTBd0xzzzXYASVJ3ClQ2iZzDRJcA3JQyGJ?=
 =?us-ascii?Q?ZDTAostOHwStWvdMxcIaMCg5og1e6dtxRtOfn/Y9YWS43EvVpHg59N0Ca0kb?=
 =?us-ascii?Q?Lk1iRzbpkDPLUIJkEVqxpvYKxGi74cXT66xQP1pjzWYMnHckUitJc35220f1?=
 =?us-ascii?Q?LXGUDHHHm2rCujcluRjR1rH0vRO5dkpy2ZZeeAtJ2ZgLVlggclnSoSvKcJBk?=
 =?us-ascii?Q?vSKUltsv2OyHg2pQR9bI4EJt3Ik70uw2+rOzx8gmPR2+2dzCriOYej6pxfqS?=
 =?us-ascii?Q?R0C9RTWuMawOxlOGn3zIa4PPA+2oI7OW08sYdvAflTciQjQ77HY0R0NEqpzg?=
 =?us-ascii?Q?sJCuqvd3aQ1jPcInbHMgEr+T1bBNULe6E/Kl+8Xa5nrn8fz6eNnj9YVzy15Y?=
 =?us-ascii?Q?2VQObuBCqmwgdizzOzNXIRxRJkST3bFh3v0EJlTmRx0tdTUYiVksyXKHt2o7?=
 =?us-ascii?Q?FjASvTxJc7zjCy23OSkNhVXroDYQLqOTvOxwvRC0w1hsV6Dm8dYz9E7b8eA7?=
 =?us-ascii?Q?fbyQ99bFbrzeqq3aus1xyZRl88KfB9y+1VmbASKAUmYVpqBencCERYyG3wVV?=
 =?us-ascii?Q?VEKeq/x94Lm3qRRUv7HWERsYLBBNigiCzyYI4SwVy+FNLA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe8cc35-cb3d-4210-c2e8-08d90b875867
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 03:23:38.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VldT1ScAAKb+vfor1dF/FgOSoFRaWUXWol7ROtc9j2GrdVnfJsW97u21E6gBIClv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3141
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: MhYzd8xKZrxXJyzGSsl9pEAYP6tRB0uL
X-Proofpoint-ORIG-GUID: MhYzd8xKZrxXJyzGSsl9pEAYP6tRB0uL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_02:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300021
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 02:01:11PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> If cgroup.kill file is supported make use of it.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 027014662fb2..3e27cd9bda75 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -252,6 +252,10 @@ int cg_killall(const char *cgroup)
>  	char buf[PAGE_SIZE];
>  	char *ptr = buf;
>  
> +	/* If cgroup.kill exists use it. */
> +        if (!cg_write(cgroup, "cgroup.kill", "1"))
   ^^^^^^^^
   spaces?

> +		return 0;
> +
>  	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
>  		return -1;
>  
> -- 
> 2.27.0
> 

Acked-by: Roman Gushchin <guro@fb.com>

with a fixed formatting.

Thanks!
