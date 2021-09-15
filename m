Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6113C40C072
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 09:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhIOH0N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Sep 2021 03:26:13 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:45272 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhIOH0N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Sep 2021 03:26:13 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F6NW3F003204;
        Wed, 15 Sep 2021 00:24:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=9aNtL+I//91GWdN0xvnAGwpNeIQvwixdOdyIGWfVgZ4=;
 b=QmiP17vs7wLjCV6/JiCEmT/5VMMQl+VUasCQDdxodan1eVbAt4q3GWrXrJq9qr7EvvmB
 9cx/6YEiZc//g/CdSR/zKnY8AjftK+faoAVzS0blkIZz8umV9W6T2qKroalmUQaNpmoz
 eQnoElHyYQf6l0T9+a/wzoNZIkC6q3oyWthQpqNs8vgcM6sQU3uprarxjXmCZKAKeGyK
 thFTFBcFUqLfUhDtNLx4QAlZ1uTHcsQWbTnj8Fp2XIM/02ea5P5kFxQa1FksyrvKd0l2
 QEK6qycQayoMyty5deAfAHTivU3igU9JWPp6Pg8OM/DLS7BmUCzDiNrQokE93CeKtLfh UQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0064b401.pphosted.com with ESMTP id 3b3amyr28n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 00:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg4Jkv2tSUu4kDrSaxYFmf+ZYackQ8IAZ2FKY4gT/N7HjY8ROTRRRKoNpQSwyN96w/y09S60ITX/RsIpAlEQGx6TRSqV1zYt16MCc5VJqBo+jM2/Yxu58zEOzStaBDYH5fUdqMlp96jPRe9vz028T/5kNGUn16yxb8SJxWrE7N1y3C7lzzrUTiapx1DGwalVhOhUyE6hwvtaTxbg7BWFUCOZ002Vr8U9HGFTF+UjmUdtk1E+0BLhUf7rH7Am7xZWPBmdXYuK4ItYGMZiT6lGvaO3WWcGOhNVxzHfcasFSFs7cTDm3ik7XcGyOANoWYrOy94B2a0FQ2s774vnv/GWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9aNtL+I//91GWdN0xvnAGwpNeIQvwixdOdyIGWfVgZ4=;
 b=FWCWGn297/zbekBauTwLZLmf/OXwRmHi/VOugUzkQFcV0cvMnyUSDkBk5DSWnIKq4ibXHEGwq4prWe+B0eyEoi52Y/aJRbhVjstGkQ5khrc1nQRT5MTo0sC7IJdqyu9iJmgyQBf7p1fcUObVPgJgA/VLDXENWVQf8n1C7qKPKLk3s6AV7bmKnBBv8H4Po11VvQLZGX1dnHyaAtOx4I666bjQkGQUt6hdau9Mh+WmlwLzfceaO9n+1V1wXtuj/ws3cvCCc6OucXBQk4v000zcZF/FuFXLr1S3+YytBgM+9DvO0fhfmu+gWK8pKDRXnWIfLx3CSe38yAhNcPwxF2QJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3706.namprd11.prod.outlook.com (2603:10b6:5:13e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 15 Sep 2021 07:24:50 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 07:24:49 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH] blkcg: fix memory leak in blk_iolatency_init
Date:   Wed, 15 Sep 2021 15:24:26 +0800
Message-Id: <20210915072426.4022924-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0221.apcprd02.prod.outlook.com (2603:1096:201:20::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 07:24:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28abac19-4e2c-4761-7280-08d97819e702
X-MS-TrafficTypeDiagnostic: DM6PR11MB3706:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3706B03FB999B55F135C957EE4DB9@DM6PR11MB3706.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpPL/XLwqnpMb6drqRNeA/1/KvDCA1KlTNtRtPYapW3+fhp7jOQRXsOz5aYI+ACOMJ5ms6xg4kmXeAoOLjiaqXlDTqnnJflcViWwPteW5nQTg/+ImtX6IHDt/sbd+oCjI5u63k2LMihHm7wzmMyODIdJ5YVEChenZ2rEVuYMtgh+pxG97C3shx0iFGgpgw3A8hBTG4RKyngNZjA5EDnofu4Q+k8JxfqXlQ+haNWPwqoEhzdP66oZDhsmCwLVp1vmb1Lkm32FPDOg8cpXYGMY/3KVJr7uuYgjYrrZaIMqevqD8UaJ5MOTo67GK6kpa/kEu682ImW+POG7VZKZGYUBUWc5lnfoxm/jEQZSXoTD9V9R9JsIex3vNn9cyT7opIudylp/x9ncitDhPZ8DZqg/RY9Iubhf3klzyikkWdJB1O7XFpSbEfu+wfAk82noAbXFS7QxWUcYapRFGBJUdrxovgwh/wQ1ox3hRIXGxFYswU0Rz/1HYWe5NkzSV7QGiJ5v2L1ukxZnnsBYNQFwfXmpgkqdOit+Ybsh60X9loocaNW68CLrURPrwGO/FVi6oE6tDITw8mbAQlWM59qh7SHT0sHPV5sikJiAfqsOO1PoGQYn8NJumdlSDo3xQrz8GajFmUqFYbtlk2CWtEXPxtGPJ1dGbASIGJFIsX13guOPa73BaHg1aYn2b0gOphayOpD085qhQ2tSWI4eIveT0q21gFn0KVSJ1MGka1n5teUod9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39840400004)(396003)(38100700002)(478600001)(2906002)(38350700002)(66476007)(1076003)(6506007)(2616005)(8676002)(52116002)(6512007)(26005)(66946007)(956004)(5660300002)(86362001)(6486002)(186003)(6666004)(44832011)(83380400001)(66556008)(36756003)(4326008)(316002)(8936002)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SIYtpN3Ay0p4XQ3CAsVIXem7+QKjDu9w3rJ9NXoJ9FfruEQyz+7L5ocLY+cx?=
 =?us-ascii?Q?PN64rZVyl0pwlMnvh7IrLPZaIWkkHx+pyLH6VL+HmiYD2uWru+LkLxpugrh5?=
 =?us-ascii?Q?ehdtfL2tiN487Dhv63fCCDP/WIRHLreJPGqVGzZk+FkyL0m9SUlkFZ+uucdg?=
 =?us-ascii?Q?j1CPedji+HfYFyCDKf2JR3FNB8yReiM1a/6HzPcdyrko0sjWiOMaYyxd5wVL?=
 =?us-ascii?Q?s7ENfMS1TNW5pemy/dPe0JvAJBGXkMR2Mp74C2QQN+rFm/d0DL4nRKSwgyHy?=
 =?us-ascii?Q?Tj53VmMWi3kH1wXC/tc6DTt3n86M1txTY0PqigXis2T2ILbDqRoaSLOyf8Nv?=
 =?us-ascii?Q?inplim+2lTVxR+0KFacOkMc4oHnB2GqNUMVV//nNOpiPc/3k4x2nsu9EEI9J?=
 =?us-ascii?Q?8IKMrvsEdXA0T6Zd1DbeV2WTN1whkqofDrbrQl18p43C8nFeuGGKNTkmPuR3?=
 =?us-ascii?Q?5n9gVWFtXNYqmfQt5vhXdClKTPi70j/CZzOglvId0+2kB2Esv0CbYqnjlXcD?=
 =?us-ascii?Q?yKoDgyAvTPnPbR8zlnIrcJPk1A/NJpILyrxCeC5CXDg4ijYE7DH4KKbsIk65?=
 =?us-ascii?Q?CPmIu6AfLl2P1oYh9lDHRXIjMapB8WS5rPAYU1aGx1No1pGkXeaixC9hcj6C?=
 =?us-ascii?Q?+HOOuHChGSs2ezC3nM0otbOy4xfH5kRRlUp4nYYcmJdYu0wTEDOXC6X+7kAJ?=
 =?us-ascii?Q?dXzMlA9tNskC727NO5POFuLnsSN/M85dBGLYehYp5R2/UBRXW4mamxJwNOzr?=
 =?us-ascii?Q?8+EV8Ma5g6pEmJWdM4wECd7ZnXC2/giMIoufVnGVVpF9B5o7hdLd+3ZwspcA?=
 =?us-ascii?Q?Y7IpBm0szw220DLv9phcfkadHtUmQ9V+glnOSMb8QS/bX0eOBZm1VV7U7J9q?=
 =?us-ascii?Q?CesnuZ59VNloBUJigrKqCtyjXvy+wnrhAgcRp0XjmWB4KDLIRDG+Yq8v8XqT?=
 =?us-ascii?Q?6oVCtp3aL36mdbm89ZlF56vOW9t6YOMDnp2utnjXK5TU334tw4GuxsNFmX9E?=
 =?us-ascii?Q?fm0c1RydJHIJ5VmHOVC28N/LJ1RV+6v12moRR2Z8rBdqXU0LI24hfmC7OW/D?=
 =?us-ascii?Q?H+56xlG5ZKBRXMWPlD2rkmrjSIaI+QipPkiBokZIFe6dZkASnS97Pl/djzjH?=
 =?us-ascii?Q?/ufNJsoppkbHLYqU2CSobTKXVsa7N1p3UOADSci3/LLti68CU5LrPyE5YMOp?=
 =?us-ascii?Q?JsWOJLfD/aE0lhexhE5PBI6fnoqLz4bBYMslDULaA4zrMmQHOhRoCiQgO2bk?=
 =?us-ascii?Q?5jG/N9wCy1d4SWj0R2r6UZR0EJHBq1ZlXB4JqH5LtyoNJG69LnnSdoMvExEA?=
 =?us-ascii?Q?SjeK/ShdBirKZoyV4E9787sI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28abac19-4e2c-4761-7280-08d97819e702
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 07:24:49.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8DYiwkoBcA2v8bbV4/RDjm9qSqJwksnXW7UWqAvK7/9hUT0mfDbyVI37bRAMq/pKGQZNYXBWt/dhn7h2nrmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3706
X-Proofpoint-ORIG-GUID: erv3ngBzDIMr31yv5rgMTznzGwORWZfi
X-Proofpoint-GUID: erv3ngBzDIMr31yv5rgMTznzGwORWZfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_01,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=695 impostorscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150045
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

BUG: memory leak
unreferenced object 0xffff888129acdb80 (size 96):
  comm "syz-executor.1", pid 12661, jiffies 4294962682 (age 15.220s)
  hex dump (first 32 bytes):
    20 47 c9 85 ff ff ff ff 20 d4 8e 29 81 88 ff ff   G...... ..)....
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82264ec8>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82264ec8>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82264ec8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
    [<ffffffff8225b8c4>] blkcg_init_queue+0xb4/0x1c0 block/blk-cgroup.c:1185
    [<ffffffff822253da>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:566
    [<ffffffff8223b175>] blk_mq_init_queue_data block/blk-mq.c:3100 [inline]
    [<ffffffff8223b175>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3124
    [<ffffffff826a9303>] loop_add+0x1c3/0x360 drivers/block/loop.c:2344
    [<ffffffff826a966e>] loop_control_get_free drivers/block/loop.c:2501 [inline]
    [<ffffffff826a966e>] loop_control_ioctl+0x17e/0x2e0 drivers/block/loop.c:2516
    [<ffffffff81597eec>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81597eec>] __do_sys_ioctl fs/ioctl.c:874 [inline]
    [<ffffffff81597eec>] __se_sys_ioctl fs/ioctl.c:860 [inline]
    [<ffffffff81597eec>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
    [<ffffffff843fa745>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843fa745>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Once blk_throtl_init() queue init failed, blkcg_iolatency_exit() will
not be invoked for cleanup. That leads a memory leak. Swap the
blk_throtl_init() and blk_iolatency_init() calls can solve this.

Reported-by: syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com
Fixes: 19688d7f9592 (block/blk-cgroup: Swap the blk_throtl_init() and blk_iolatency_init() calls)
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 block/blk-cgroup.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3c88a79a319b..1ded4181a6de 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1182,10 +1182,6 @@ int blkcg_init_queue(struct request_queue *q)
 	if (preloaded)
 		radix_tree_preload_end();
 
-	ret = blk_iolatency_init(q);
-	if (ret)
-		goto err_destroy_all;
-
 	ret = blk_ioprio_init(q);
 	if (ret)
 		goto err_destroy_all;
@@ -1194,6 +1190,12 @@ int blkcg_init_queue(struct request_queue *q)
 	if (ret)
 		goto err_destroy_all;
 
+	ret = blk_iolatency_init(q);
+	if (ret) {
+		blk_throtl_exit(q);
+		goto err_destroy_all;
+	}
+
 	return 0;
 
 err_destroy_all:
-- 
2.27.0

