Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B477C368B09
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 04:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhDWCbO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 22:31:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240154AbhDWCbN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 22:31:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13N2O66E028514;
        Thu, 22 Apr 2021 19:30:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Dh8IVCSVnsBkGkxmdUYPMFZOeNBa7YoWkLVqqlwpCww=;
 b=ALOvqaz47c0jMHNsPtoChr2WyCVsogfoz0IB++EKEKwTCzgIqS8r86TVZLQTzIi+TtJL
 KqHLS726y8B560dvuZ7BIuyFLYvIFEGduVSpibMtGyTRAPoPKtkA+iedm5ZyrW9IstMu
 YQkCjOkc91x2kMS45FUOQXPLZV3cT8MJgiQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 383kvngg04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 19:30:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 19:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hR24wCeFt+q7gVUvrTCsC3thal3XTB61d2xvp+LtXDsaatvEIaVLWzJtVuw3Zu+gN00Nbgh+hK66/yMTt7v8G7mXqHpV/5KLBkxyi+h0oqTpqy0sGlxo5jXdxS2OODr0EobmDefUGLYupFwuOdhtMahYPb0MyCcRF8rvBEd/SmcPSOf4kTjIH5LA7lTASGCnqg397qIsVVUDM75KahubW89A+QPOD4ni3O6qTM220F8HY0rlIkZBQfN9o62ZvmI4hKEbrPJBIjIiL3T37E9m7YtoWStlOx6KjhBrdWlx4cf05LU+18RWHhnrK3i59i1qoT7G4+JjWK+fXOzdvbYIlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh8IVCSVnsBkGkxmdUYPMFZOeNBa7YoWkLVqqlwpCww=;
 b=NU7a3fNi5Zca7auVNABMlolwR/THKXEcn1fzI/pIrLk3zUxSO/Uydgo8n8VeNgBfl6gycpBdK1CHFVkW2FNuNVdhpgLkuWN+KM4nE/qlUUBcpa+8oZ6pvSl9fnuV0XsTqh6KVgxKfUA7mT48pPfiPofGdYFWQPLLAYhTlBp0VVY8igZevBkxhBbso59J3hUizUx5uL5KyASSE4ekCte10W+EyhZYkQA3mhAbbemtmsjOi7k26ol16oLM4B1/to6NF3/4Nns3eThdSyBXp4x6FWq/0UNKpZ83g80S6c1CdUphWdZou9/HCiwIIelrN3yQCR6hfiaoksTiBdMd8YkQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 23 Apr
 2021 02:30:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.026; Fri, 23 Apr 2021
 02:30:25 +0000
Date:   Thu, 22 Apr 2021 19:30:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>
CC:     <cgroups@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH] memcg: enable accounting for pids in nested pid
 namespaces
Message-ID: <YIIxPAcdd4p4NTxV@carbon>
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com>
 <YIIcKa/ANkQX07Nf@carbon>
 <38945563-59ad-fb5e-9f7f-eb65ae4bf55e@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38945563-59ad-fb5e-9f7f-eb65ae4bf55e@virtuozzo.com>
X-Originating-IP: [2620:10d:c090:400::5:9121]
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon (2620:10d:c090:400::5:9121) by MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 02:30:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75606dce-75bb-4ed1-7319-08d905ffc048
X-MS-TrafficTypeDiagnostic: BY5PR15MB3602:
X-Microsoft-Antispam-PRVS: <BY5PR15MB36025003509E2A65FB6535A2BE459@BY5PR15MB3602.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ll1ek1qZvdksOfSIEq8bx7FJZ1/RSiUQ16Lwwl/HesL/BodjXgR+zDQxVADHrPyunSBrZcH97K67Y6yCye0XOH4HCrwZ5mnYF8fjI1LkeYPJFkIqStny+D3iUx4t8v30dDh1NmkSHke2pOUHmvt0pwlZUjWPLmUngL7snuE557Yf8ukDdJ14Pk1KXUCYdWHumKQ+9t98jvbaUyOKjJCg19bEl5MTNAOYaA7dx6Qr71R7sdQU6SPRPgVRS5juhtPkv1PusZnY1YJ0epT9+jaV/lVcQxQ0qFITBT7rFKoPeeCegm7xq0yEco96TTIOW9oTbAyeQz7ccUJq5elM2ZFm75ieujpFHJgx+DrSjeq1aOWasKYLv7H/wi/PO/VHtr+kzkhIlSIPVqtLWrJkX8Q6BpuCLdXzV3NsOcqAs9hY4CGcTnwD6QQc1qZHI4M9NI0AWAn7TlJAUbaTDN1IqhikMuitAP0uftkAAazPjKdzHLOE+yl8DNL0UWNJTrVkX0RT216QDMpw57nMw6IQ211YfAcJD+Y/+Hmid4BO7jNTyRBnqjrKn4/C7WqXe3Q2F2pGo7i2eTQDdnbp6Re8GMXvLW8//VRz9K+a54TwszRPd1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(316002)(54906003)(33716001)(86362001)(15650500001)(9686003)(53546011)(66476007)(16526019)(186003)(8676002)(6916009)(8936002)(6496006)(66556008)(52116002)(2906002)(478600001)(6666004)(66946007)(83380400001)(5660300002)(55016002)(38100700002)(9576002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gX1EHalXGbLFnM7/J4fxYQwWUoGfgbzuL8CAiWpYAV+n7N4MGC6Xgjq14Xj7?=
 =?us-ascii?Q?/l4pOgiCVM3h8vLXuekzB+3fNfGZQFtjFtoqy//hWWw7CO7OqGIpn3z7aFU9?=
 =?us-ascii?Q?/OHaVvFq1f2Xh0gHFt91OA7IhJL7jAq/asfEhvZcWRVgrk1JMwXxD00F2Nmi?=
 =?us-ascii?Q?FNn0khhVZGL8MZoNBr0tYjCftwNqgkrBXMJuxh9uOeky2SwnAkJnXFOYY/68?=
 =?us-ascii?Q?xqIf1FcfQnjSeIC58kyO3xY7+4Ng0rA5GlegXWTLePLR9NM28QOly06nj1z+?=
 =?us-ascii?Q?ulBOg3Hc9trIqadvS2uElbHo+BWDjouY6VSACkrxyHzvUaJ2l+uuKUX0d05p?=
 =?us-ascii?Q?qIAOtlAeUNB8/qpvaUZqLfX5x7sEpDe3vBVCbCmjCc6dfaI/10r7dSVT/b2D?=
 =?us-ascii?Q?/TlM92F05NLsOQH/A2iU+X8JT39ChEqvEdk/G6tvNt5zN+70WVBDcMVDV4Zb?=
 =?us-ascii?Q?yqPhoMeKJoYkTNxXFuB94bdcn1E6mgwVGHw1RT4UJwm7sI8dMyAFP1sPhwh/?=
 =?us-ascii?Q?7M0X6AXPhag8FTJKSg4UgkVMNBhSwn+WqBD2B6YVg0tEykP5uO+zNo99bgJn?=
 =?us-ascii?Q?jhzePP+P3YrpIx6li8bM6LhIGXu31VAViVzqs/7t6uzX0gg3W27O6XpuIlE1?=
 =?us-ascii?Q?YwVggh8ENAFa7Bc3UG3AJDDWJCncOxtN5a6cQb/KadjXsm3ConPFF+m8yyfw?=
 =?us-ascii?Q?qbaNNjhyb7eJ3oqE8v21psT9awdi62A4XWQg1qNV35d3jYAc58LWrgvzTBMc?=
 =?us-ascii?Q?fPwJpZgJgYXI6jXtiFZnGi4c7E0SBr4K7M1zeLsmpe29OQJ0Bn2XO9JKYeUA?=
 =?us-ascii?Q?YD03l45tehf2dLVMhMpIs2RIydCR+h+xvu2vZoOoOmPjjb5s6ixlPcxt56oS?=
 =?us-ascii?Q?O7F95il+rY6l4J0QU/57hJm1gZjdZ6PPKusyFg2XpEXo1+uzCE8Y/RThy0tj?=
 =?us-ascii?Q?v7Gel1zVBgOs4+Vw001Kvmz3XGY/ZHdf1Tj8ZF6550y7syIo/xW/+hTRCtv5?=
 =?us-ascii?Q?I0gSksZK194WyhAYb2Bnno1yrtOOFrxV2Gp0Wed5S40IqA3dG6TXuGyqC1nS?=
 =?us-ascii?Q?i57KDpRWqdQ9Iux03tawXRfutDlFGdeC0ZAXoaLibQs6FpL0t1wm/HC6j+Xy?=
 =?us-ascii?Q?L9/G60j+f9AkxUiIYXhN3/J4+T+USY3DHPzp433HJqhDkwkflh0LH40brZxz?=
 =?us-ascii?Q?EbTN7jbSFs5iq1Xh+f5lJuwVOAuxgzZh1+06Jh0+qaXbGhiBK5GHCyJXqsFi?=
 =?us-ascii?Q?OeMqZ8OP2G1B4q2YS3r19+k+yQZCPcXIfiyoMypobOuWr0GTNW0FQCH2gBjB?=
 =?us-ascii?Q?1sCIFlzycrDnPmZN6k5BZ59KWMhigCsRDz06iNt2YpWzuQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75606dce-75bb-4ed1-7319-08d905ffc048
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:30:25.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5KZ99RbYxSRtBfnVrUrOw1eE+bqU+/C7V2YSGZ5vF/mYIHxCy+vtzhLIMxqz6nw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3602
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JgaxjuYeXy5GKsrZRVlMzgNxlsEudeR5
X-Proofpoint-ORIG-GUID: JgaxjuYeXy5GKsrZRVlMzgNxlsEudeR5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_15:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104230015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 23, 2021 at 05:09:01AM +0300, Vasily Averin wrote:
> On 4/23/21 4:00 AM, Roman Gushchin wrote:
> > On Thu, Apr 22, 2021 at 08:44:15AM +0300, Vasily Averin wrote:
> >> init_pid_ns.pid_cachep have enabled memcg accounting, though this
> >> setting was disabled for nested pid namespaces.
> >>
> >> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> >> ---
> >>  kernel/pid_namespace.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> >> index 6cd6715..a46a372 100644
> >> --- a/kernel/pid_namespace.c
> >> +++ b/kernel/pid_namespace.c
> >> @@ -51,7 +51,8 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
> >>  	mutex_lock(&pid_caches_mutex);
> >>  	/* Name collision forces to do allocation under mutex. */
> >>  	if (!*pkc)
> >> -		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
> >> +		*pkc = kmem_cache_create(name, len, 0,
> >> +					 SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT, 0);
> >>  	mutex_unlock(&pid_caches_mutex);
> >>  	/* current can fail, but someone else can succeed. */
> >>  	return READ_ONCE(*pkc);
> >> -- 
> >> 1.8.3.1
> >>
> > 
> > It looks good to me! It makes total sense to apply the same rules to the root
> > and non-root levels.
> > 
> > Acked-by: Roman Gushchin <guro@fb.com>
> > 
> > Btw, is there any reason why this patch is not included into the series?
> 
> It is a bugfix and I think it should be added to upstream ASAP.

Then it would be really useful to add some details on why it's a bug,
what kind of problems it causes, etc. If it has to be backported to
stable, please, add cc stable/fixes tag.

Thanks!
