Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7479A521
	for <lists+cgroups@lfdr.de>; Mon, 11 Sep 2023 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjIKHzr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 03:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjIKHzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 03:55:42 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22BCCD;
        Mon, 11 Sep 2023 00:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHDtowSMnFUQguuso1HC6RoDLD8ms0IILc+9mL3TNfPHXg/ga3tuUSAJhq8g4J4rrZXlsNaF38EmTeW2xGlMUmN9e/5+wckMuMpvdLxNvJlhckavbGh/YYLr5aVCHya1/PNo6/DwgV9Ixy7PwXHIrGqKv4C9tZb/IR9jC/XZqPtVoQEIQB1f7HS+2NWr18yTwOJ5g98YZbbn3S7Vl2uZtpbaVREDaiMSCd4lrSnINocZweyzUHrJqM36tkocNLFACWpqnfeZGEhUz1HmC96I8y6N09J/dXbfuCelPAlxnCL17vYmZ6ssKfTzfWBR2FT/p/miRu6SCXjyVO/JUH2AHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djIfp3mP/EaWX+nVlS1KCxNUabPAfr87Moa3tT7pOBI=;
 b=NUbosNja4+kIb6OYBjQhI+WeDLZxswcE7QdKyoez3AF6CyfOIjBSltqbbNpMOXe1jxQKxU9Lt3s4lglWvWvf0t8y39egyXkoRgw+bVCs7JC6ksrtSAv4F2W0qgFoEIh/Q42BZK25dSxnwSIVQ5dRTaHiTE3HQM5VA9YC8fTUeEeAFEMx0yQbjiHsY2PjagN2Q+GJQ5XJKgU6m672olUYT/SCGsU5UmG8oFl2+9/oStxi+tnY8c1P4jD5M9qXqFulZa1o9PDONxnJBBzzZycQ1GTp8qsJt0MGPknuzk9ByhnqHyl+4g6f/AqINgsubKd20BQ53bDJlg3jL5/sovNAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djIfp3mP/EaWX+nVlS1KCxNUabPAfr87Moa3tT7pOBI=;
 b=WhbBLQeEOyvzsdmhSh4D9X4EVIOvGwUplB9RcpcNRz7ONfTJ2sqnBcn8htUdIbXqC4klOgrdbajGO7hF96ht5rUy1LxyXzrQBkkZcVH9HR5d+0w9s3h8ldgKBJJwM1YKg4JZWESHK7KjNx1+aAVGyBTWokjDY4y2lM4UyQMWgeuGfvcKEi8QmhFlmo+YKp2/iHXdaQ4zJZVUYQg+NIo0t8nPz+rkzxmTSsbm4b9yTvzxRGy/BlxYl9Nf3vKFE07smHIY7qabntYKhcMclw4pfADwCZFh2TmAj3Zu9NQ+Yq6mEBqOHPtEF0/aLG4VVntX7y5bFRJTcNpSeLi+PAFITQ==
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 DBAP190MB0840.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 07:55:23 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:55:23 +0000
From:   "Yakunin, Dmitry (Nebius)" <zeil@nebius.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     NB-Core Team <NB-CoreTeam@nebius.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "Yakunin, Dmitry (Nebius)" <zeil@nebius.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 3/3] tools/mm/page-types: add flag for showing inodes of
 offline cgroups
Thread-Topic: [RFC PATCH 3/3] tools/mm/page-types: add flag for showing inodes
 of offline cgroups
Thread-Index: AQHZ5IVR2s/Ayjgc40OYZOhxdjcOng==
Date:   Mon, 11 Sep 2023 07:55:23 +0000
Message-ID: <20230911075437.74027-4-zeil@nebius.com>
References: <20230911075437.74027-1-zeil@nebius.com>
In-Reply-To: <20230911075437.74027-1-zeil@nebius.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB1860:EE_|DBAP190MB0840:EE_
x-ms-office365-filtering-correlation-id: 4dc5815f-838b-4323-a31a-08dbb29c7421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/nw/9fnuoCDlr6bgCKlUQlScBCrO6ZS9t9dwN7dzTnBAuYHuWooJthI5ei5buYZvcFl9NvXCd1kj8nG7hufaAYjfl3sp20QmZsXaE/NZvEb8zSzPFRRg7NrrhKybxlobDiQlHZVMDOBUUoajGg1Bc/yItGXPX8cLxFcWwi0m79c+I9uYSJXcZ6D9W7icG/UCOKVaz/ia430RACQYqAQOFnkxau3NC31IVJHymfi2xKBEXxvGshHMjgcuFJy+9liAE+KB0SuCNPTP0McsjuP4hArUSvnbG88hO0/4OYXxnzQLGN0cSZzyQfFNhPK1pD6xTkNB37pqHL9ckWaBUZRGslpVGTbnGGPYeVVIuh8PaOT9CB/ww4pAz2qZDy0GkXFmyVqPWDFaebSbr1rVhiXJNvZ9JqLLPcJl+Wy5BFcjnrPihDxqsS3EsYNpiYCaGGXC+92R/i/T4sw+sNnLOsyp5cMwH6Dxg14GaJjuW30n6RvvOZ2StF06vnbASMJqyDfUIYYDxfT+mk7/wxd17LK5KZQ5xODgWc5LVP/bgz4Bixzpy+tOhC3QxiJLpWkoh/S7vXDEhGr+YRxyFU+Udoz47W7gnV9xrYHk+OPN4s14ZY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39830400003)(451199024)(1800799009)(186009)(6486002)(71200400001)(6506007)(36756003)(86362001)(38100700002)(38070700005)(122000001)(26005)(2616005)(1076003)(2906002)(966005)(6512007)(478600001)(83380400001)(5660300002)(41300700001)(4326008)(76116006)(316002)(110136005)(8676002)(8936002)(66446008)(64756008)(54906003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ow35UQh0oVf9gSmNT3Xd61xsGwqQmt7DDWm+gtn/RZC32zdTeV9eZ4FXGZ?=
 =?iso-8859-1?Q?iRgMXzHZt1OI/6mD0C/kZTujObGhswrj9tE4U8CVxNgtm3n0D2COAhbe3Y?=
 =?iso-8859-1?Q?UkV1qlGfgly93fEw9J8R9WunBKLEVyzqA73gGQwMom4zQAmsqJQOwws8fy?=
 =?iso-8859-1?Q?E6a9EaSiDV058YC1emqbfqRdLpH3DH/XXoOQkhxGICRnWQpwGz70flKGLa?=
 =?iso-8859-1?Q?zppYaT0FkxWvhnIZlv/vIn0XX1gFjGzkk5K4EVUf3MsWT+tkTO91OOJ+Y3?=
 =?iso-8859-1?Q?+jNynY10Sr0GmWM+Onv4R9/PraGKXCaQ4gDPLt6bAhEUr3aYjXFrd7QD7a?=
 =?iso-8859-1?Q?9LPW9deMiru2UvurkmhKuVDOrNCdSS7XSDmPTuwQ8xJBcfAgoZKY1xwkIa?=
 =?iso-8859-1?Q?K2Eof9+jG3a7+jtpU/MLk6TWtMxEvInPpMn/Fs70IrfmtmSzwhyOmGSVQP?=
 =?iso-8859-1?Q?J5TYYcwU9Svyr9LADQxlEBOj1KJHetkpae2CE76hR3rMATHYJFBBZuH6Y7?=
 =?iso-8859-1?Q?icGwOq/rl1Uc7bPke5eO56mkkfnnV131ib51rwGoN4TGvP0FJqXm4BIxAN?=
 =?iso-8859-1?Q?9s5F3vZW7cIYF7heI+ZdOyVM40J941W8MrAaU1tMyEWSRvYp9ArfmzYb/i?=
 =?iso-8859-1?Q?PHpFFXXJD7GeS6bfv85El77f2DQQEVPkh5FBDuckVtwdpPU6wpqSOPQY3U?=
 =?iso-8859-1?Q?JAE05SvC0VFfJ73VAPXjkw0zvTTueNqUtILauE+zO6OcXOVOSu+MErqRSU?=
 =?iso-8859-1?Q?g/vV4ZrI7PrmfBc/2xPsL0x5Q9IJZL0KLcSUTMUy2I33v2V5tAMdMs4wZP?=
 =?iso-8859-1?Q?YXnAhwzEGaPSx90kn1ZakSEE2MF9q+w9XCdwz4wjto9w/kkmvTHXw4Bc35?=
 =?iso-8859-1?Q?r8qOZxQ2/cVt3cpyh2uFC1Z/u7fECJhc1jaK/XWoK5YcRP0+yUduqvfn/R?=
 =?iso-8859-1?Q?SgVj+3CCC0TeCE4xZ0TKXVlOsFIxtQHOl+oQf5+vgf78BVbKEsPUhARYQz?=
 =?iso-8859-1?Q?mDO7/77bPnieuH8OoIoqJU+cTs0xGEi4KIT+fxoCGZcmkDTdVQ+NQYT3Yv?=
 =?iso-8859-1?Q?6WFXQxG6WSZeA0RL+jqlDr1qOzWwUw2Y78M6TF5rRKzK9OnBksL64ROHu8?=
 =?iso-8859-1?Q?plk39Mj63cHuToy3cy67bjfI/yTo37SbWVWpeD85RC+Lp7b7TVs/8oKVh6?=
 =?iso-8859-1?Q?iP6XYlihIii8BemHnGrUOCUbAmUmqiUxLlIc1S6f7m/KCqnrpRcIx4poqd?=
 =?iso-8859-1?Q?j9nnlIHhuVMUUMkK9HtCrCwboNPdaRl9c3pZuWADwD46lhfRtDi70vS9eR?=
 =?iso-8859-1?Q?gkNAwBAEiTDJLAJJXw4hl2SOIaiGwXUls2QFUpfD610b4A8vyGnQLp7tqH?=
 =?iso-8859-1?Q?O7DxG+iYom5mnhwqQ7U2uzr9VUQNhQd+mVpFlC5rLay+gfKkpQKtNxIU+5?=
 =?iso-8859-1?Q?kNWkQ8B67XhL3AQGzIACrptVO5jeRGV7Qy1dPBQBnawkrE5pzkJu1sW2Fy?=
 =?iso-8859-1?Q?KsuWTI9K7bBKS34B2tQpJ+UvSOs/XEUy6NlgPpTxkh1JsHelDXNCAXxMlg?=
 =?iso-8859-1?Q?KNUw1ZhYvpsFyHUpEmuGURZadZ4Eyc8HOGOGWNbC4MqqNRa6NYiO7DeMXS?=
 =?iso-8859-1?Q?9qjYquJB2klo8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc5815f-838b-4323-a31a-08dbb29c7421
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:55:23.6059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wE5N7L6IZZVkOB5GEJdcYv6XdEDFT0xCw9ChgezIpIfL0HIkzUYoYURWh5Bc6Qvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With flag -R|--real-cgroup page-types will report real owner.=0A=
=0A=
Link: https://lore.kernel.org/lkml/153414349419.737150.8224164787883146532.=
stgit@buzz=0A=
Suggested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>=0A=
Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>=0A=
Signed-off-by: Dmitry Yakunin <zeil@nebius.com>=0A=
---=0A=
 tools/mm/page-types.c | 18 ++++++++++++++++--=0A=
 1 file changed, 16 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c=0A=
index 8d5595b6c59f..f26035b362d2 100644=0A=
--- a/tools/mm/page-types.c=0A=
+++ b/tools/mm/page-types.c=0A=
@@ -161,6 +161,7 @@ static pid_t		opt_pid;	/* process to walk */=0A=
 const char		*opt_file;	/* file or directory path */=0A=
 static uint64_t		opt_cgroup;	/* cgroup inode */=0A=
 static int		opt_list_cgroup;/* list page cgroup */=0A=
+static int		opt_real_cgroup;/* list page cgroup */=0A=
 static int		opt_list_mapcnt;/* list page map count */=0A=
 static const char	*opt_kpageflags;/* kpageflags file to parse */=0A=
 =0A=
@@ -837,6 +838,7 @@ static void usage(void)=0A=
 "            -l|--list                  Show page details in ranges\n"=0A=
 "            -L|--list-each             Show page details one by one\n"=0A=
 "            -C|--list-cgroup           Show cgroup inode for pages\n"=0A=
+"            -R|--real-cgroup           Show real offline cgroups\n"=0A=
 "            -M|--list-mapcnt           Show page map count\n"=0A=
 "            -N|--no-summary            Don't show summary info\n"=0A=
 "            -X|--hwpoison              hwpoison pages\n"=0A=
@@ -1257,6 +1259,7 @@ static const struct option opts[] =3D {=0A=
 	{ "list"      , 0, NULL, 'l' },=0A=
 	{ "list-each" , 0, NULL, 'L' },=0A=
 	{ "list-cgroup", 0, NULL, 'C' },=0A=
+	{ "real-cgroup", 0, NULL, 'R' },=0A=
 	{ "list-mapcnt", 0, NULL, 'M' },=0A=
 	{ "no-summary", 0, NULL, 'N' },=0A=
 	{ "hwpoison"  , 0, NULL, 'X' },=0A=
@@ -1273,7 +1276,7 @@ int main(int argc, char *argv[])=0A=
 	page_size =3D getpagesize();=0A=
 =0A=
 	while ((c =3D getopt_long(argc, argv,=0A=
-				"rp:f:a:b:d:c:CilLMNXxF:h",=0A=
+				"rp:f:a:b:d:c:CRilLMNXxF:h",=0A=
 				opts, NULL)) !=3D -1) {=0A=
 		switch (c) {=0A=
 		case 'r':=0A=
@@ -1297,6 +1300,9 @@ int main(int argc, char *argv[])=0A=
 		case 'C':=0A=
 			opt_list_cgroup =3D 1;=0A=
 			break;=0A=
+		case 'R':=0A=
+			opt_real_cgroup =3D 1;=0A=
+			break;=0A=
 		case 'd':=0A=
 			describe_flags(optarg);=0A=
 			exit(0);=0A=
@@ -1338,7 +1344,15 @@ int main(int argc, char *argv[])=0A=
 	if (!opt_kpageflags)=0A=
 		opt_kpageflags =3D PROC_KPAGEFLAGS;=0A=
 =0A=
-	if (opt_cgroup || opt_list_cgroup)=0A=
+	if (opt_real_cgroup) {=0A=
+		uint64_t flags =3D 1;=0A=
+=0A=
+		kpagecgroup_fd =3D checked_open(PROC_KPAGECGROUP, O_RDWR);=0A=
+		if (write(kpagecgroup_fd, &flags, sizeof(flags)) < 0) {=0A=
+			perror(PROC_KPAGECGROUP);=0A=
+			exit(EXIT_FAILURE);=0A=
+		}=0A=
+	} else if (opt_cgroup || opt_list_cgroup)=0A=
 		kpagecgroup_fd =3D checked_open(PROC_KPAGECGROUP, O_RDONLY);=0A=
 =0A=
 	if (opt_list && opt_list_mapcnt)=0A=
-- =0A=
2.25.1=0A=
=0A=
