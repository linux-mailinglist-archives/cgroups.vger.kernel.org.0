Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576B22B538F
	for <lists+cgroups@lfdr.de>; Mon, 16 Nov 2020 22:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgKPVMm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Nov 2020 16:12:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21832 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732587AbgKPVMm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Nov 2020 16:12:42 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AGL9Vvp022514;
        Mon, 16 Nov 2020 13:12:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=o1iZuedaHVX9QPpoa8Tlvfg/x2o+U3Mjh57arAG4JDM=;
 b=Fgu4ngqZTKM/M7RkPoZt5gV6/gGqBUqkQMQf+Jnwrjoiv3VbGsw3jGn+Yx8+18ylXNql
 4bL5lEG1K3Z1FPvrzp/XLIEhV8B8J1V0/TkSY1DcGYCK4qwZ6XbWPsqrIk7m8n8b/DwW
 VBvpadhBjDkc/mIPXHivzfQ3OHlIo7NIS64= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34u09gy4nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 13:12:32 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 13:12:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHeKYWA4zaqivzPgjK/wIzlQDnky+rhoxQOQrW5ancpnFsWL1zIuiBxBqpXMug/rue3N3qvBAgM0NmjZxsvIjjrMpe8VnquH05TLKCNq9lZTYbVenTn8zzMWeeFsCnTGzAjoqcSDmP5jXa/GInGm8+BSK8s2h1o7wP/mes6Y58IXhWhSwS1OCMQO6APNne2XialaKxSYCMN8FVBAt6wYirdxrnvO2TPljjuMjgPkzfNm3w5XFCU3QHY2HWsQwJV7cvkRyH2uCzFXYlLdgAONm1vggGtqQ2+GnX+55ZHKIop2+n7JVvYX0CEJCoN5akramuWaicSmY9BbwM+fmVZ9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1iZuedaHVX9QPpoa8Tlvfg/x2o+U3Mjh57arAG4JDM=;
 b=GOZOJFhde+qamoP9yAHZORQNGCaXiXwRydErw9A5E2aKmlBC55EA0j7rTvZVHeYKusInm5o8HNSEhxQEhq6DTseKAiBIHNyVjgap1KulEFpBU6ZxcHohUVW8Kc+61Zz2+wxQ9BXbh1QuUPs56c2y083qbSHm+JYjz6ULr3A4nJYbqRe74/iZG4+3ykiuimYb0JfpuUxaut340u8r61MXKlDE8TcWGe//tN0eFmLAbuL5g0vMdk8MA/CbJciqwHPNBLKs63/rFCaNJqmYpY/yAsj1FQcCU2bloelcpb+2PTy7/C7jSOG2N2XxiGdSK6W1Umnm5H9f6sQbbViGqKjsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1iZuedaHVX9QPpoa8Tlvfg/x2o+U3Mjh57arAG4JDM=;
 b=Jris96DEucHJbGCxbzwXcrR1zveuLzrEMh5ij7zAYxxiKM5MYKmiXRmDEuURLuJT8KAb/knfc8V4OCkMo1dUkf07kMB0wYzvnyP0EBqBQsMFKKWORt/AVJLfURT+iaWzWD4o5g9mV29JeJiuxuRpL4JEpkA9GftKTTbntGED54A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2710.namprd15.prod.outlook.com (2603:10b6:a03:153::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 21:12:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3564.025; Mon, 16 Nov 2020
 21:12:29 +0000
Date:   Mon, 16 Nov 2020 13:12:24 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <clang-built-linux@googlegroups.com>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcg: remove obsolete memcg_has_children()
Message-ID: <20201116211224.GA45468@carbon.dhcp.thefacebook.com>
References: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:42f]
X-ClientProxiedBy: CO2PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:104:5::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:42f) by CO2PR04CA0202.namprd04.prod.outlook.com (2603:10b6:104:5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 21:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff15417-37c9-40df-535c-08d88a74537e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2710:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27100A0B3EB919E2B6061D47BEE30@BYAPR15MB2710.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJcwVOEEwB6X067BDJkKsdizni1sIhDgG/Rovafz2ZxQI9FwxT6yWr9kAJoYaifB+i/VhiwA8YdovOjzfyOZ6Z02G/uKug6Hnhb9VzdlZzN8SlIEGLia/GNVP6A5GP3xxnopAgjTXq69u1wYGCVwjy6oF6VPobncwO8+zWqJZ9TXao74so9SVMKcyNxYlHESmsYB2Zi3T4fAagXQKsybQwHqr9gx3KgLW6l5xvk/tXh8lt/TseNBygDcqjMkhItlnrSJ5btTC7JdeLhK2svo1MT6FlU1zZ5tW1710+DJ8rIxwd2xAU/53jDuXd4Oydzj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(366004)(346002)(39860400002)(54906003)(316002)(7696005)(52116002)(6506007)(66476007)(66556008)(66946007)(16526019)(186003)(4326008)(478600001)(5660300002)(4744005)(1076003)(83380400001)(8676002)(8936002)(33656002)(9686003)(7416002)(55016002)(86362001)(6916009)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Me7guhPtroKjVxPTKr0uc8prD0LiHFnmhRmO3W8WYh5ZsSwqWL5tbc3oH0z3CzW/ZhNrmns8sFIqvlpnkYtSJ4dWj01VY35S7I9GRxeNujxEe5e35p31zI23ESHh5tTYH8HWvTHS5A1TQGnknK43lZWnRjprxFgBsl/oCdB+Rct06X22tB2gz536hmwbuy38HsbPdSVEr83SEj3sDwjlQuDsO88rk+EliWRQ9frvoueJwTExYJFCQUVNzClYZsg50r87Mh4O3v8r+BrmLuFO26yl3QpQqxjV+Ypfyxz4xVYSrHBJ3760bfmMh6azgpjdVVPG30k7nR/Kt3PK+JAR97JXKUsImaznkuTTHvZDKC5EnaNIdNv5rHfOD6XTPhDJbEBIyLHAVsgTlM9qU5zgpDqIbWppnlc445CKKXL5yJY5IUPSWMhL20H7df3IoJUKzoxdOUIaJD4O642CvW/shuBonGkHctIl/HYTeUAoSVJ0j2MGEdgbPdWjJoF5BCO4iZTQNADkzm8Kq6BlIOuOs6Og6RffF+6eK3RuoWtZGEtaIa7Trdcj8XGzO8quS9ESQX3esKmqNkqGjtGtiFuB7K0DJ6BV/PU/OweQ1PRtJUVWskaCcN++7BtPK7Q9zIDQqN8esLEz0JO8atpzXKLU5kxiWGF8peyJcaM6G0PVdts=
X-MS-Exchange-CrossTenant-Network-Message-Id: eff15417-37c9-40df-535c-08d88a74537e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 21:12:29.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJ4mKEihpNadE6xtI3JP7PPwhKiKIlKmKpFtUiAVH/Yk7FwEvt9v8kH0WyKIxLp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_11:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=623 suspectscore=1 mlxscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011160126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 16, 2020 at 06:50:43AM +0100, Lukas Bulwahn wrote:
> Commit 2ef1bf118c40 ("mm: memcg: deprecate the non-hierarchical mode")
> removed the only use of memcg_has_children() in
> mem_cgroup_hierarchy_write() as part of the feature deprecation.
> 
> Hence, since then, make CC=clang W=1 warns:
> 
>   mm/memcontrol.c:3421:20:
>     warning: unused function 'memcg_has_children' [-Wunused-function]
> 
> Simply remove this obsolete unused function.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20201113, not on current master
> 
> Roman, please ack.

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
