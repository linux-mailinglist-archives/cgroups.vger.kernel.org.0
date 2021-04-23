Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B37368A1C
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 03:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhDWBBS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 21:01:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230367AbhDWBBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 21:01:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13N0ure8030782;
        Thu, 22 Apr 2021 18:00:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=czRWEv8DAevHs/uHzIbfNz+74FqtNrYGOYxOol9fBdU=;
 b=ewd781BPnidm2V5HZ1S++zgHuRegx72S957wqqTigwDxLUVNETTJ4vD5P4x9Rj+Ma7kr
 cMEZL5E6P9oxxEgJ1ES+by2qKX8+uT9v2ydH92kgnKsmePcv0RsBVbu6nPckDPayK4W1
 ICho4RcOLTuw6XJhN/JHZE9D0t1PHIbr0Xo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3839vukwqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 18:00:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 18:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqD3BktVY/PBDbc13aJ/nj5XPTTw5zdnmoxzxaAhTk/iNEs7CfCRgvxk31Gdsm4NH0rJVxIrAJTdxTHx2veC1JHKqdiNRD03JN/tyl+mjiStuWXyYUocgkfa2xOVnm3hwHzIveKJqnCboqOT34fAY7uNl2yqqLMVR+qpgJ3c+1st1VVfFgX/7cM/BuFztfqEAGmAXCWu01rtVmSENlJfrU34HDHj24dlJY5lgmiKjxnIatcZb5ndMzCF1CX6Hcyo6F+xxTfaxPozNRFyth8IRVUmhj2K7vZ3wimtr85X0dZ+PuqT4e+V3ewxDTug5QmG4Bgx+XRIOl4W60OtgTDODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czRWEv8DAevHs/uHzIbfNz+74FqtNrYGOYxOol9fBdU=;
 b=FJIxKaMvc7PvF6fYvyXcPe8mpeQXxL4YamoAkCVsk1t+sdQSIrJZsAsHrvgmWBMZlekSZUEFmJPzI6NwBOwBNclnJSUcJqPvK5cTFvVV+83TVcKffg33XU2q9TzigC9QQkceSxaujC0Uk8iO/BF0ddOL7aOhdr+jIcl9yGdhJMoXUOw42Uc4WuaavJO5jhx8IWn1d0wvfzP7euXkK6FaKQaRA/aoe+eCmprLBh00yLdNIAYvXfsLbaL84c8/Xbfor1XEFfN428TsHdB6lQY1LLFLblKKMYawzOHMk0Ibre7iPJzqFUzzyv9z0CH8yIo4aRf9WJwuC7z7F2gZX6EQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Fri, 23 Apr
 2021 01:00:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 01:00:29 +0000
Date:   Thu, 22 Apr 2021 18:00:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     <cgroups@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH] memcg: enable accounting for pids in nested pid
 namespaces
Message-ID: <YIIcKa/ANkQX07Nf@carbon>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
X-Originating-IP: [2620:10d:c090:400::5:f6e3]
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon (2620:10d:c090:400::5:f6e3) by MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 01:00:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58616579-fa10-4088-f122-08d905f33001
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3144870347473CD2FD5828E2BE459@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ut7ftOIQhla3cyCNgk5KJDLuDcc5lnT4eS1abZTw3dC/5dB1hm574AgM08sHDU/D0M/ffiiya21LEDZbM53Kg5tUX+Dx3+ZD9/W6/0hcrPnpuH4wlA031SIRcOdnOXa2hPR/U4QB6TaBvWs95YZ6Lk4Vd4kBNaO0a4A/mZO6bqr+QndXGtAaxDpAmuLq9nJ0mlZsUbwwXmF3N/CbGKh74gFDGI7ZN4mRiR6FKxoydBRN8EqThy1e986NzSiL1yMT9XJRV7Osqzg3hI+FkRa/M3tY2mJ4PHyFxHh+48Dtl2w2dGUd7K9xTTjEI7l+pPYYT5aA75sKl2hDicB4Su9EP2uFC40bMWntM7vkvF3D8/lBcg9xStk5lx2NwNafpeqOANFGVSc2ybY80e52jOcKomGOgH7TILW3fP4LDP3tIaaeFXwEsRIQWdAtSPYCJflJyxC5qziVcI+sO58XShceAQIpVNartekbDdGcSLMCV5Au/jcu6VlRPW2gd7J/L1Pn/i1vC/lmQVci88C4ypbwZuSpLhaxsrZPE1KDxlUh5n1TgGDnTB29G0jIYM9pN6bW+7AChVSI/aC+eYbcHPH/O9t+Gbcel7S9K3kK5qtIDk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(136003)(39860400002)(6496006)(66556008)(52116002)(66946007)(55016002)(9576002)(33716001)(4326008)(54906003)(6916009)(5660300002)(9686003)(6666004)(38100700002)(15650500001)(66476007)(83380400001)(86362001)(316002)(478600001)(186003)(8676002)(2906002)(16526019)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fA88kWiQ/VwEhlNuhuKhwEvn/97qWA/t24bdbx9mqApmMApj6WSq2KBYz7pY?=
 =?us-ascii?Q?o9HRkuoqasLb1GTjeRC4gjTD/WQDzYuaSxp57ajmIhE+XnlRTlUiJPmOsAGi?=
 =?us-ascii?Q?pvbXFldmV8sbp66KKc35bAo3V8k4h8hZ4AQOyVTTthVXQevdwa2VVZpr1ZmZ?=
 =?us-ascii?Q?NBJRKpkQXRsExWQaQrq5VxOOvj261mLxbOicXGhCyHXVUS37dfWql38sD+Es?=
 =?us-ascii?Q?Fgze1eYm5ZuwsrYk2gB0uUqs1R4VeMLkZ+K032fBY8cnOz4pHFZ2i8ab5Yhd?=
 =?us-ascii?Q?J3XmB7Yxl8ZI37oZ62df2Qqx+CaXjdXXeAlZkLhADnPm7jqcKWpzT13S/Zsi?=
 =?us-ascii?Q?nJ+fOpQ5SNYxbcrWz6ln6WIRraqi2hsTJJ0uYSQMtn0SCoNUVYHfKR+wezpN?=
 =?us-ascii?Q?c/i5ppUQIMBxrbhLacbO8thBY5yYBMoK5DWfPY/0anb5Dwwf1dgsD8oQTvKN?=
 =?us-ascii?Q?AvNwaEGTQbUdP7p0EfdXkobvNd92mNS+uKTsTmvUrg8g5kdFSVCwavyqg9K7?=
 =?us-ascii?Q?0ZljdRUc2PapupmtC1uj445nMLhGBFjxQ+8BF/jxBej8zpvHOOwLztQhLKwL?=
 =?us-ascii?Q?9ybwPWzB4jQWLh9Czj7/1wkonwDh83IEZNzdYyWFNdvyYesHUtdRFR4aFtu7?=
 =?us-ascii?Q?gdI5DOrDINJVoj3QhDit8UXLZQBAncAT1QgHLVwhpU9ySWbqOFAZdCYvb/pI?=
 =?us-ascii?Q?8LUmh9MzbDgzGZOrh8GW4hmVWhq4hB0xIy8xPl6LRfhZv2yDnfSDvgkbWRmn?=
 =?us-ascii?Q?22bKxALcLw6Dehgg2qXZLZ9RWgz4TMEQiq0BwJW16o9DS29ZcrhBjbxBhkcG?=
 =?us-ascii?Q?7AgaMX/rgUq58FMCwErlugH75xHVuCey3yEBTJVUHr+TNYvXc78fRCmtvVtV?=
 =?us-ascii?Q?6/Vde73jehKqJ2rJU9qM1AvBqsfjSbBlXNajs5GWuK7kxh1sbUY3i1AaQKGF?=
 =?us-ascii?Q?l4Efq24+ANXeQl3MQd4n14Ewxr42U9aQEZr4SvNCKbx0AO3CPcqxsNjaYFZg?=
 =?us-ascii?Q?1mvrcBb4wmY8c8BektEKXHQBcXvZKW+AhEpi2mEejLszsD966JZfpB/FjBC1?=
 =?us-ascii?Q?gC594jb28MGV297GIHy8omBNPaKz07bFH7zJF1ZMN2wie9uHkmNVjW8GgZCg?=
 =?us-ascii?Q?oCxv837d/A8X6hvjV9LvqOg/lf1infWZDONZbLe2MKEYbIe6hYHJ/5SNTqhv?=
 =?us-ascii?Q?LhhKKZ3e2eKf4c1a48xAW56E6lapilDqFk71xFeYY8298tyFrUNK6GTC4AHq?=
 =?us-ascii?Q?Azr5+hZEgCRJArf4/3QqMknSgPA+J+lrc2ubRUXO1N1lr2GgaslLyA9xdlav?=
 =?us-ascii?Q?VWs4YrVMq2L/M98+rsuae/cAE4etDWt5/soserlwBr5+SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58616579-fa10-4088-f122-08d905f33001
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 01:00:29.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpTaBbvw1c3pqRDlkoodT8R5/rRVizH5phAqr8nf7f8AN6xxxDQEnltPwiDaGElK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: N_hNj5ufdtGMkU7PRhwo52ZJ_W9qBlpf
X-Proofpoint-GUID: N_hNj5ufdtGMkU7PRhwo52ZJ_W9qBlpf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_15:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104230003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 08:44:15AM +0300, Vasily Averin wrote:
> init_pid_ns.pid_cachep have enabled memcg accounting, though this
> setting was disabled for nested pid namespaces.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  kernel/pid_namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 6cd6715..a46a372 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>  	mutex_lock(&pid_caches_mutex);
>  	/* Name collision forces to do allocation under mutex. */
>  	if (!*pkc)
> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
> +		*pkc = kmem_cache_create(name, len, 0,
> +					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
>  	mutex_unlock(&pid_caches_mutex);
>  	/* current can fail, but someone else can succeed. */
>  	return READ_ONCE(*pkc);
> -- 
> 1.8.3.1
> 

It looks good to me! It makes total sense to apply the same rules to the root
and non-root levels.

Acked-by: Roman Gushchin <guro@fb.com>

Btw, is there any reason why this patch is not included into the series?

Thanks!
