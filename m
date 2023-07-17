Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128DE75669D
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGQOkB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 10:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGQOj7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 10:39:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA0E3;
        Mon, 17 Jul 2023 07:39:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAnX4V017703;
        Mon, 17 Jul 2023 14:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=2gMdCwqc6k73VPCUkJoX2Jt9fijqdm0vuWMqllzxYDQ=;
 b=zcWwN9or1ZRoXzhhtMQHQo2sOCKea2rMmMpqFstVB7gG6uX4SmkBDLXr/UxYMiXA6NGx
 UHIl8r0oPtN6tksnrushNC6VKjbbQonQo4Ss45mez1Zcd+TxGWw5My0OX4ie/UqCpY/2
 Qbd+9MPE2s/ljJ7CVkk3YTUOavARvCwuKoDwKVoDH+Nc4Uxkxy41qQD6lcrRlc4/MRYz
 nWxtZcmkn0o18iPFKy/Ir6k5OWfN4AIoSB5BTGel4Q6NDjsWL3py5wgn6YL3aeqB4O+m
 dLl2NR7VnMElvXbGe/ozVqtcLwyvmBUsKudsDg48wnqySj4vGF4rSlVR7/4ui9hJohQh ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76tuxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 14:39:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HDF7is000832;
        Mon, 17 Jul 2023 14:39:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw3r2cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 14:39:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3tbnE18/7GuEEiJHjod0HIQOliFMvV8CxXp+G0iZ70742uDs1ImVsLzFuX765sjjhcLBj/TXKMFIPfGRRIooUhBjZUmohdC1lJO0nE0NCX16jLZoQOaiy0LYXDA7TaNdya6uTXiHeoRIaoQBNHu9aQx8sao9dNJWu5uQ1NL6v8VHC86CSRlFs1IwKRuUl98U8PPBgdLOBDBIzvzUYJO1pj6vdirodazjv7bdP+mYbwSSebLuEwB0lb/UUzJ2472UGy94vUGHxu0G0f4kcZQOYvqUAcei8RvDM3hDyn5WiEp5zBNXAcuF+rVsh3Vj94/MQ6X5YBVhmZVVeWApbqyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gMdCwqc6k73VPCUkJoX2Jt9fijqdm0vuWMqllzxYDQ=;
 b=IuISIrsXMhu4oB4XsuZJcSVAfLqsIIou8SUTxCQTpQ5BgLt6BfAhYlqm/Fit71yNd+mhNYqrDK/4ySjSOFVGzKsE+QEinGmzmHHPJ4zr63RZyMkHGRXchZ4sWrX7DvppzMA+uXSh4RGGGx7m3sw7XCP6i/i1PuIXV2LgQcmScLdJMOtSsAXmWBn69E7OQrS9WnABW3ORtcZlz5hCqK4227Xp34GZr8kxgcQpei5kNdQmVaab0NILRRqYzYYRwP8BqhGGkC0X2Q9S4vcw3WM2RuEbbB2sp3yLL8LSbzad6KVvQyT9vkb7fBxAegTcShYVE+cpT+P2ahtg6pwre2iCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gMdCwqc6k73VPCUkJoX2Jt9fijqdm0vuWMqllzxYDQ=;
 b=hs6tMUcUIDf7u7qAGYWCj4l+MhDz7faDdS65cOfUn+/Q8y4DDQddHMu6fIcwgoMhHHm81Lgcf99462YLZ+qb7bgkpbr+MUmENX+qzSGNto7GRAaaOXgO4ArQ2SJbhDkVptIFPsoPI0hEdCZQxecBY3owQs4iFmhE22979rRpfKU=
Received: from DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) by
 CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 14:39:32 +0000
Received: from DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268]) by DM6PR10MB3001.namprd10.prod.outlook.com
 ([fe80::6487:e5c7:ca75:6268%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:39:32 +0000
From:   Kamalesh Babulal <kamalesh.babulal@oracle.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: remove cgrp->kn check in css_populate_dir()
Date:   Mon, 17 Jul 2023 20:09:23 +0530
Message-Id: <20230717143923.1781747-1-kamalesh.babulal@oracle.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To DM6PR10MB3001.namprd10.prod.outlook.com
 (2603:10b6:5:69::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3001:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: bc84667a-39b4-409b-2a53-08db86d3a272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34yZHLWvcKoFKgqDLd9LyINkYPGKyAzy8rbUdpKtmNA63pQhoxltzI6Lhpf4ubreOTiCPljutgotnrU0uhiMy2xVX4uCG5f5FQOveDVSf0JAGZtB5clpCnCx3fssV3Rdo9No7O8g0DAjTR/dHhrBXCr0LMTyYL2D4GD5nWqI79IaHozxKjt06eR4XSM8Ju3yB8pqPUTqd05sCaTrJNCibVmXWHj2GRsjXZX9H1jn/9BLdXPjXDRQZAsAtKbuULF8pArl5LaadFGq1Ai+gd/MLCazLru3h021Tc81I+fp/l9bNPo5iKBFgie8zQ2IayH9SBrGFdFbwVXkhvE9BDsijlK71hn/YuvAjC14T1/4lgDSCEMzum/CE2OFO2LS7M9Sz4My6vpor+bBW2y0A43x/JA5PAdboiLLa0jxfZ6SlZbUONs9hZLrmzRUoGLVqYn7dpIlk/pKwy/9q+fzaFmQNsuHCFyDY7Y58KrTlQ7mQc8AvHVxuOPcQk7UacjXMyat64c+VNgqxaSgu7mpiKgzyzIRRynkyePkFvWUQ9extmTksWnWCQPZOyO3E8IEWRon
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3001.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(8676002)(41300700001)(44832011)(86362001)(5660300002)(8936002)(38100700002)(316002)(4326008)(83380400001)(2616005)(66556008)(66476007)(66946007)(2906002)(4744005)(36756003)(110136005)(478600001)(6486002)(6666004)(6512007)(186003)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zhplCtvhnnObq05om86OScCKsfDsUJ7P6eZhsuw7DcQpYkW8Y8wOPYLiS6Ox?=
 =?us-ascii?Q?Dh3Eso8AoHo/DM4LuSRGLpypDDEMIj27XVv9MbuDlvlFibhkXo7BUKcDv4IR?=
 =?us-ascii?Q?eGjDVZQCCbKJbhthnkNbU3zyY4FdlUpIhBeA7IWnITXpJ/gvrDANd7tY13y6?=
 =?us-ascii?Q?kD9It1clUK/gD3iBaBeylxhyMa/aug0WmU4XwuN1oOF9wJlOSsk0FCdMumF1?=
 =?us-ascii?Q?Rf8N1ypp3SFrOsBka3aaWFiFECaqTyrgEQItdrjZsDFVEffXn38VhDO0I9eG?=
 =?us-ascii?Q?Iu/IX+zA+C4IUjJuh5KQQPNNnK4OBe0D8D1WYGwjE1I1lhzVOUMwyPdL8J54?=
 =?us-ascii?Q?d1RnGhNpN8Ee1hnM+zpaxA4C+tNS3Q2wyOc6X2nQ9b5KMXo8YAFTQk14OPyY?=
 =?us-ascii?Q?607ULXvUfA8jGcA8Vfbue7a/AaLjjQcy5X4/mpMLnj8Xm/G5y+d/es/94JJA?=
 =?us-ascii?Q?A8hG5+uYvbUXkBZ1wmiOhfcLuzfTyjyGlnUzTHBYhnL73X70UilSJAfzyUwg?=
 =?us-ascii?Q?83fdCLglgecQgP/K+4iO+D4S9+7S+oS+gYKczSLr+IW3FcJfDvP32NaoJHM6?=
 =?us-ascii?Q?UrjwVbqbRWIsvazoSft0mamu3sVGW8GnvAa51X/xdtVyEE4Jb1KsqEG+aaAh?=
 =?us-ascii?Q?EaNdmxa/nHUd2Rw7CWASaU7A/zOZ9Kf5u0LN5xaXhUAAgQ78LypcQSpgpBgm?=
 =?us-ascii?Q?M71qvUyuEiLawqYvLNuiKRTr3vs3jikxvJCIegwsvzLn9vZHVSLT8CJ5D8ko?=
 =?us-ascii?Q?DqEGymEygPF2Rq7QS9ifQ7xu+SIMOvQnnwYNxivftSG3xivMkE3fRjiURW5E?=
 =?us-ascii?Q?3O6S4sE+C/p6ENTBxcx8wF2cuKlTvNCzVjCfZofNme1VuPzpmF9O9LLxBImI?=
 =?us-ascii?Q?OA91f5MtJgvyTqmD5WgaW/DMqvR5/xyJIkGcJZUCESAnF7VIGmqj7FT7ATDd?=
 =?us-ascii?Q?fj3Z4oiIJ87VyP2r6AYF5S2FSJajLjdwcfx7rCFZOXFXnLzQGCDH5PaKCtMW?=
 =?us-ascii?Q?dh6jBOjSSI2FI5TX7Aa886a4d725wHhJItLY6GXaEjWtj8ZHwpw1Yj1+dYmm?=
 =?us-ascii?Q?q2DhBeX7LOGzph03AD+KNea5hk0HDrp7BgbKJqQK6GdtKNG/9PZLMAqSdpeS?=
 =?us-ascii?Q?oPQIeCkU29Tm0FzTsCoVVCBDXm71HiK5fY1RoAzo96Zzi3ITABv/18SCplVt?=
 =?us-ascii?Q?DaUWS2ULUGtZEw9kkknnKMR3PuNrJru4PBtn8hTiYq8ci6bgikMAJJ+R2q5N?=
 =?us-ascii?Q?aPI5toC7FWD2eNaQMr++3+3tVRDncbAdX5h4T4ribSehB4ofYRknVCLYnlOm?=
 =?us-ascii?Q?cbeDthE50ah07q2w0GTymgU76lcdPO6FAMpT/8fGtga59Qou1Pd2q8qakhKt?=
 =?us-ascii?Q?jEGoYcgjMPMDKbigmp27aAHCYBeyqGcjN+nJ5nVABJpJgbDYFZggEYiVCuu1?=
 =?us-ascii?Q?m9baZI9+LZEKjBNGfM/+DcK0ge7vnglTGQuD4ePcJcPorce4iSwb3t2VKjxd?=
 =?us-ascii?Q?jQPw1cTEMyPMaBUk9lNnyse8gVJ24LzP3gBbfyyv+8BmLQaKb+Olin28ob7S?=
 =?us-ascii?Q?OOYqeLDQbkbq6VvBrQl3UFeM4LrFs7ka/QnYlHVLmvj813CdWMsPY0yN4QOh?=
 =?us-ascii?Q?mv7J2cK+0EV9duFtmdTCNFRGBFNdHud0UWs6YGHTgxVl0kLccD/ymjuQ9K9R?=
 =?us-ascii?Q?++h0wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pwp0WvN1M8hnNATGD0krfZt09tzlr04INELZHg9rH2ZwTYNl2zBEUZskvGhCMWnbCsXG4VaFvlLfEj9atxQJf4hYCDw8b9eD0Rnhhl14fF5QCVg3luTKh9fsq7NaTZ5aopXAHxoR/5hOZqpgg8SSMb3Ohkc2E/zHR3JEXUxIxrdzpCxf7d8dgpdp2uZsdFpw01ri+WMJXP8/FIrnjTIXvsGTT3SyDc9/HUFY4/jVDuYiyqrEH/LhYdQz80POj6lQWUm9HdBKv++bdckTqIrpA5BoUZGCL1HnstidHYK5Yrd0PkKxrT04vIv4sHh77OeFLr1lf2c4lM/r2Db7LearVuGM1dVh6R2gZzfK8MAbYfIBPIECVlUww8jULyqnVN67GtNnVrjp4y+57NSWnLlT2TcG2KweuGNCe7SvK0pNSbAy2OEPZRQefM/agEqdlufLsMN6Cnm4EwWDxItqFH1+5aR0ZM3Hb/4ZNVZd3IYOL0GtNfWzVGb6F+D7HExrC0MF7Dy8JJHiO9j2jmyPjaq6lbZJ3IVOCIMiXt3YugTf2Io3RZVdpLjquRJI/1oap7aARDhQ1lyIvpKWMYH5mXnUHy5K3tgRSNORUUxDA3O2ciw+5qNiNQ5V2LocnTo3bzxad7QDpUPQ2JijAhO9Ms9eOSQq2EI5do/C4KN5Q8l2EL6jDXjfea+HugOCtDlnNclPpCLPbVdueN1tLbgi8oFg+a4Y9wIRP/nT0obSqJxoSk2UABob14gfh8TVHlCBk9ji2SvqMZqaqtehc6Hnwx3yuAXyHopU2J+zgFA1P1yKbU8iJR0SwE33FuaT1zq2zDojUpidiYOxbndFAEB269e5rA6aQ3TsbLUeLhRGqKt5Iwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc84667a-39b4-409b-2a53-08db86d3a272
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3001.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:39:32.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x279OtjhOhHxsMlEVHcbhh+4fCeGdfU9fOqV9EOUnkQP/+ncbC3mgVbmxIU0QbaqzeVW7GtvGYc7cRF/8HzgCx/lFUa9vcWlD358EOWgtI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_11,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170134
X-Proofpoint-GUID: egpXiFJWmYPnwVmGQ367UkaYvYS3R8zt
X-Proofpoint-ORIG-GUID: egpXiFJWmYPnwVmGQ367UkaYvYS3R8zt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_create() creates cgrp and assigns the kernfs_node to cgrp->kn,
then cgroup_mkdir() populates base and csses cft file by calling
css_populate_dir() and cgroup_apply_control_enable() with a valid
cgrp->kn. Check for NULL cgrp->kn, will always be false, remove it.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f55a40db065f..5294fbfb4bf4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1736,7 +1736,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 	struct cftype *cfts, *failed_cfts;
 	int ret;
 
-	if ((css->flags & CSS_VISIBLE) || !cgrp->kn)
+	if (css->flags & CSS_VISIBLE)
 		return 0;
 
 	if (!css->ss) {

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.34.3

