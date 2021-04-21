Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7D36758C
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 01:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhDUXKK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 19:10:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31390 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234826AbhDUXKF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 19:10:05 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LN3mbu004620;
        Wed, 21 Apr 2021 16:08:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EnFPed14JJKK4kfYWEkFku45rv9aEq2HEWAVsbhS3iE=;
 b=kKjjkKZtBSFXw1c1zcomGZXMmINz3K8TxO6AmfTTjjEIz283lYCHAVC/25I13aHKNjVZ
 MLBGcLTlk3Zas520dy9ddEae2m1AVqyyA0jpKCTk5srdYnd4o+IDeXkcz/oOoZHUUNvw
 7HoP4JIpqJBExUHPslSqUKzXrlYs9YinxwM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3826yufgjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 16:08:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 16:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEvtvLWsi/b1UwG707bl9qdcjuGtwIc0J7wHcpU/RfP6lIJwAMwJDlHrVKrYE7MbxjWJlutyzej5STAojzCplaDbJ16zEI6/hXwhqiUXlAD+cDxjtSuO0MHkOEisP0oC5kzKZv+9+LpHSxVRyY0wC/zRemAO2OJ2vFDWxfjk9lmvjsWtwOYgtQQ69Q4cnIPJPeA4D/kL7j9F4AE8oLnqWR5lsdL9HmTkfakIGGG3gTz0qk3loSSQyXjr0fZZdMgX/huzyHIW+O7nEn2L3ii/DR1x35JF+kYzRV19XmMjy+SP1UtJDjEv+KBcn6Vlels5c+W8x4bIyGX66iFwQDUIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnFPed14JJKK4kfYWEkFku45rv9aEq2HEWAVsbhS3iE=;
 b=e3FtQvo6UM0nvPu3OltXXLFHbK0s+vTa6DsezKIQmNnCLGRhstA9vgJXFfErMs+oETKzZc/EPoo1WX4GGD8bw1qlwMtI/isy1pK4j7DTZGXeUp+9T9j574mFA3TafUEgYyllcUbrtiDUP7N7Ws0CoapBK+aZKDszbYKiCy8Gmz61OYiChKYH8mrBR3Szy6CekHwXCb9g9QmB7yC+sJWAJecJtUS7dAHoPn9rbZQZqr4FQVt5LBRbsYHsm1UyQITr7pGj2Yrc/Yul0IIbB+yRTkhcLeZydV7KYe2IqikJ+AbS0Wq89ReXTEhhVV0B0oC2DBAui5O+I0qZfexw2oR+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2984.namprd15.prod.outlook.com (2603:10b6:a03:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 23:08:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 23:08:52 +0000
Date:   Wed, 21 Apr 2021 16:08:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH-next v5 1/4] mm/memcg: Move mod_objcg_state() to
 memcontrol.c
Message-ID: <YICwfY6VmqPbuX1g@carbon.dhcp.thefacebook.com>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-2-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210420192907.30880-2-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:a02a]
X-ClientProxiedBy: CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a02a) by CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 23:08:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b7bdd4-dcad-447c-76d4-08d9051a6ddb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2984:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2984109ECFF10BC87B731CD2BE479@BYAPR15MB2984.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mcITcwTUc9mOF0tijCw9nuL3rpRMcVQOGj+bwlQ+478+MtYlYtKBll6hMDScBec4drnXg4jvkE6fZ1DpuFDCR5I/PNR2wYtPvuxgtjXvqrOaDiA+P9it6fpwNr49j4ulfz4b7p2arTEZvfQ1Z0rxa6es6C18Bh3LnrsriZ41AUKK88IEF31iSn36Lr/0RqLvEnu8nguxOODZmQxqYpsQRhgv/6U8X3zXye+6tG9F2PoZlKrYr2ZjCwhdeuWdgmgNFBg1i9GV70dccQUz797YXJGZg/BPbcByqBrZegZ5IuOaCihNO6woWz+AudjTvQ5BJHTnv91SwIhD+FXIUy0iJAxtEo+pCa6dqOxz0qdqQh3ba3+H6Z9wmPL8sH3Z138IOuvtWu5LvfSW7J905gnCw8Ecum3znTE/u4WT40A6q+1n7zdSbfLvx67Xf8nog7dU2rSXtvXwh4cwSmM3cGbRTwjKa2r3WVRkhJ9LOlH3QfEaZqOsg6+MQu7npcJJpqUHsqYUVpjaG5GAb2BqjQziSFMk+08euXe2wI8jeWdZwwtQZmcCnPt42D09qLm/bSAdmU4k+IMFWb18fbOYzod2m/m682w+a1SHJbcE+iMDfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(136003)(39860400002)(86362001)(55016002)(316002)(66476007)(9686003)(2906002)(66556008)(6666004)(52116002)(6506007)(8936002)(8676002)(54906003)(7416002)(4326008)(6916009)(5660300002)(7696005)(16526019)(4744005)(38100700002)(186003)(478600001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mRZ8pU0b9OKO57UUoEdIe+LN+v19yXSBLsYNuCf/L2ugPr3X9OT7U7veayJv?=
 =?us-ascii?Q?ticSkA4rMmv2oTQdXcibaN8+KD6xp8f0zjkj+xuUoU9U7mNc/mrudNkIwX14?=
 =?us-ascii?Q?NBcqsKeiBJdv3gOonYf94gH002k1V5ZAXyPS4noT3SxhhY7a7weTOaYanHMh?=
 =?us-ascii?Q?Sk+CEvzeEmc1V1/nEitWSE6O+1Gv/rO+bKLP2E8FMLiIhC8UVf5kXT56FaOs?=
 =?us-ascii?Q?oh8cflTfw4CcHa+JHzBGgR5cIH/elAqdAKG4v9CTLDcn6En+c6im1BD+OMH6?=
 =?us-ascii?Q?Sf+a36ng6K8bpvKaAJ4qYqc73geW3x/wHAweOF+7mdSTO+spF+twx+JIqTq+?=
 =?us-ascii?Q?IFl3Ua2gUbLeyh1hyamAsdT23qE9Vt+eofrFiy+Ss5HJrvFBlhhzHTJHEzp3?=
 =?us-ascii?Q?cMKkW1Wfx2oeJYiKm8rHDntKt9+4YUDD4YO1EV/oZZNtVMgME66VCxMwT2QS?=
 =?us-ascii?Q?5zls9EJ4V0cVooCp7PkFBqbEJZElsqMwmS+ncleve9CN2NSGSXxo3lWUXvtD?=
 =?us-ascii?Q?x5/nP+UDaYsG+QLZGEUMUn2u+6k8nsyMH1lCxQlW9zkBqOYi0G/DqMFTIZdT?=
 =?us-ascii?Q?FagGhhSbwTUfH3fT8lZBISDvohD6W+3vo0Bqcm59Kfxg+Wa4OtIBberZsjoY?=
 =?us-ascii?Q?d8DjrFyX0HUtGK+GnVCAxNMwbQ2doKIcti0BgaTNTZC41O5rl/19ajjsTtqQ?=
 =?us-ascii?Q?TlXkyFSVmVT2aiJSfDsUa0s73/Fb2vxL7vime65bQuz9+R5yrzSfApzU4a3a?=
 =?us-ascii?Q?VUkHKz8hJj9xS9xb702cFEUeUtTJGPYdmEDOUVszc49OkxwtNdthv32a237t?=
 =?us-ascii?Q?7R5Lk+Gij+wrNVbeUKQdFjH4BeYGOsOvc5omxCCcgS5jH7oMYeqNFsNbjvr4?=
 =?us-ascii?Q?zkmMNAw/U0ebRXIGFu7NoHlmYotGwzR2evR/YU1MsYSV9jpIDeuqlx34qrYH?=
 =?us-ascii?Q?ICUsfrpygeorleNbdPxQfmahADizqFv/xiNZt8GX8kfTtqQ+kT3TyWpZDyoG?=
 =?us-ascii?Q?aIbWtrNuJc+rNu0QJy4sPJ0BoSJtm1ucA8JLFRL4Iv70WYb55PdjrsUNONrI?=
 =?us-ascii?Q?TAkdBTCD5NnS2Ubbm0v0+COgT7XDH+Mx7NSCsFOsL/MqCdc75KK01rV2Ujcb?=
 =?us-ascii?Q?TgkYHO4Pl5pIk4D0jhkFClrQetYmkhV6hUDZ0fD9/CEwK8XodCLdMfKYxULt?=
 =?us-ascii?Q?m40pXco6Q1rZKU/i3yhcq7OUmxQJpoCNQlXSnp3Akf0JtTsZIPe0qWfnTroU?=
 =?us-ascii?Q?gW3YK+EeTQARNaMN0+2MYMYYEJKBkPKcHbeKUdZRdAN2zS0k7dKtDHpDleGO?=
 =?us-ascii?Q?Hdpqx7MmDThZAxpmrOP+x+ZSE+OavjQhnjUmPC/KYLHXZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b7bdd4-dcad-447c-76d4-08d9051a6ddb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:08:52.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfrWQ86Mv83gWsGGfSSof2hhc6k6LQW0ZBXIa2qE2WMRPSnudDWiumq16Tj59cCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -KjTOhFLy45JgI3rEqG1WYL69DUVFIYQ
X-Proofpoint-ORIG-GUID: -KjTOhFLy45JgI3rEqG1WYL69DUVFIYQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=904 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 20, 2021 at 03:29:04PM -0400, Waiman Long wrote:
> The mod_objcg_state() function is moved from mm/slab.h to mm/memcontrol.c
> so that further optimization can be done to it in later patches without
> exposing unnecessary details to other mm components.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Roman Gushchin <guro@fb.com>
