Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586F229630E
	for <lists+cgroups@lfdr.de>; Thu, 22 Oct 2020 18:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902038AbgJVQtu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Oct 2020 12:49:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54152 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2902036AbgJVQtt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Oct 2020 12:49:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MGhFxi031419;
        Thu, 22 Oct 2020 09:49:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cWne/3p9UxzZphn+Oykp8yjMla1uGUvvusPMVbkP5Nc=;
 b=hpKh2aP7i9RsE0XMzgGc9lrjXzrEJ/eUAjsVw49KZ7uOP4JpSxHFy8hTzveY0cDOfgM9
 Q0ld3GSm3JcVYFa4UeCigdsc937WQVOwLx9LKGyBCuPNm2Wp2aEPeQdynHsJ+c6lZn9s
 BX0FvJ17bVuk+YERx36mAxdGvSxkj6dKFPk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34a1ttd7j0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Oct 2020 09:49:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 09:49:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfpHk9GIlawNNc5apJ/ejuV25C9qJ+W0LbAgY0Q9dzk1VN1sUIEvH+XhA9zflQgnwazJdYfhpTA0OwgYtdXpxew6iCPgi5A2/CR/pGi7aZJ+Gx4ROL7j/bR3tac9cc4yCDleTpy4stAgj7gEHkyZVkPypL29ERIIWFLe9HfpxhE0PCk1fGt7lfgkPwbSNTXA/3V7imWXOyLUDwRg7V6a1QzDEztVnxr9g/lxvA6m9Hf3djZzT5JjhKJc2taiPChRaGJt1cJhJt53UdSqekawo16CWd+gQyNVxju4OTFqorJTPxyevIfUzeozQjYH7+JVJ9xsoAyW6/B4C4vuTDGdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWne/3p9UxzZphn+Oykp8yjMla1uGUvvusPMVbkP5Nc=;
 b=eC/Z6ZqSssGKE9mU48t93Bl94RVQaOHcuJxSWLj/GLMbq8JHi3BFD4uz36M4gIfjl6IbmaLoSeWYROdFKn97azHbjjDnDirClWyyquxMnw/lMrlJL761SBDavt327eKyzsniMscFMaRY64VeAaSiTQ6CqLmnZNPdjEgOH7ZnaH5VVLLLRPL2wg54za1lMlp17AEcK6s+2vkVPeULsRYhJurJ8gaidZpbpNElF8kk8bvOg8baD2vEr6lnmK4jsnmJjlWrTZHc+rcXbmOASKaewevxEwfdPUnu0cZEIZqVlWmnwV0JtxOtwgbEdmMV27+H0Lb6IdAj2ilDdWUNcUm2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWne/3p9UxzZphn+Oykp8yjMla1uGUvvusPMVbkP5Nc=;
 b=S4s753GOHV9B8pEgOmUHIv8KvORGWmBhnZOhWSK7gPV1ImDxXbGPQUutApVv0981VrFTcj2kBFnwNX030+nJmw9dh4sAqBFhp4/0x9sejkSEy+KjeAizd13Qopz6k51Kj2vIwaPnVBYlSCZblW7h+uJ7zOZHV8sjI8CmxBqMGwY=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB3037.namprd15.prod.outlook.com (2603:10b6:208:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 16:49:38 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::a124:777e:37bd:2f1d]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::a124:777e:37bd:2f1d%4]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 16:49:38 +0000
Message-ID: <db4f86f30726a1a33c868155b4c681ac25569179.camel@fb.com>
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
From:   Rik van Riel <riel@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Date:   Thu, 22 Oct 2020 12:49:34 -0400
In-Reply-To: <20201022151844.489337-1-hannes@cmpxchg.org>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
Organization: Facebook, Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:fdc6]
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To MN2PR15MB3327.namprd15.prod.outlook.com
 (2603:10b6:208:fd::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from imladris.surriel.com (2620:10d:c091:480::1:fdc6) by MN2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:208:e8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 16:49:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd2a4354-6f7f-46c4-9d10-08d876aa76e6
X-MS-TrafficTypeDiagnostic: MN2PR15MB3037:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR15MB303784EFFD75EFA4494D6407A31D0@MN2PR15MB3037.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yC7joLTDMc+axOaSmdbGIM1Pf5jCrv6SxxsUmU1N3pDFKK220xUDkL0fFhu6qFReNmpGsTERS6QpWB9cZ7ZwZYRVvD9qmrlB68B/M23GLD3S9LqLpr0BEXvTJvfev3dYE5X7tdNpwASIxSPOInjhd4CQQY//ipFoFqhBKkzvHS9uKoclRdgvL2y4tj7wA6ZX+UJt3OTRISJ8Dv2kc2b4Wpfu6V1nfxsSVHVLJDChwcmSJbVQzzBO6Us1rpIjIHTcnW76khaTF6ZB+Sr5xrWFhyyDMfGln1uzJ6qt9HkNofrdWeZywXt6w/dz0i5I08LOwYS4XHEoeiUGZ3idQ2F7cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39860400002)(5660300002)(83380400001)(2906002)(6506007)(66556008)(6512007)(2616005)(36756003)(6666004)(52116002)(36916002)(6486002)(110136005)(16526019)(66946007)(8936002)(66476007)(86362001)(4744005)(4001150100001)(186003)(478600001)(8676002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FGnOs9csIQvZRpOYt+ElkKqTMQf2rAMpwtxm1wXS7EvkrKCF3G76p0ll0LFXMgtE+HsQIoFLn1aFUFU9JSHiq12hrI407qQ0KzMEom4YnWsJz6ER2zkwQf7AAV2LeaQx98ErpGe2Azayl2jjDEBn5Q6R1eAps/zEex1NrCUS9vB/8siVBJR3yAeLuLzSQakBZAtOP7xt1T/szRSx1xCzmqtjUhPsSuVxgY5nxbIhy8hmLAPK8z5U1eppOVcM/csZ3RETp0//ZRKL1IqiIl4PbdzzjWNa+vQaOKn+G4KqyI+jJGczhY6i93B9EE0Su06hkTyGPmTvlAbmZu2mPd4QewJx8dG6EmKZJyG2sSWEhkm4jnZK9PRNsuahvT+cye9zJLZn3uvN/cKGsind8fT9MK6nCd1sQgIIs3p1v3uvCtI0slR+EGWtMJDf5ogPsW8v+ulBbC59GEq1FHfUe3HWcoMv+uclanDIxX6iszQ3yHGnF6sYcnNH7H5e34U10wOtlXmJrJplPaUWnKc9qc6lwzY8m0JrAbK8PWKSdcmAmMXWTwPgr8YbRFhYlnqL9FFm+4fxlzTANl0EdNlULudYBTzxl//Ta2DdgeYmOaYc8EF4lrRPo9tIF7RiPbbn506WCoUfzYIYgtnIOQc/8YEfCYab6txQZqTuTYQBPwNDfStOmSFtIBuCgG0SUtcm3cM6
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2a4354-6f7f-46c4-9d10-08d876aa76e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 16:49:38.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO+W3nh+oT14ZSQZDWSGr90aW28Yr4aA7M9ZX6Mwh5hhSOHweBkIb37p7VGldokg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3037
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_12:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 clxscore=1011 mlxlogscore=908 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010220110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2020-10-22 at 11:18 -0400, Johannes Weiner wrote:

> index e80aa9d2db68..334ce608735c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -204,9 +204,9 @@ static void unaccount_page_cache_page(struct
> address_space *mapping,
>  	if (PageSwapBacked(page)) {
>  		__mod_lruvec_page_state(page, NR_SHMEM, -nr);
>  		if (PageTransHuge(page))
> -			__dec_node_page_state(page, NR_SHMEM_THPS);
> +			__dec_lruvec_page_state(page, NR_SHMEM_THPS);
>  	} else if (PageTransHuge(page)) {
> -		__dec_node_page_state(page, NR_FILE_THPS);
> +		__dec_lruvec_page_state(page, NR_FILE_THPS);
>  		filemap_nr_thps_dec(mapping);
>  	}

This may be a dumb question, but does that mean the
NR_FILE_THPS number will no longer be visible in
/proc/vmstat or is there some magic I overlooked in
a cursory look of the code?


