Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2679A51C
	for <lists+cgroups@lfdr.de>; Mon, 11 Sep 2023 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjIKHzk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjIKHzh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 03:55:37 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4598CE3;
        Mon, 11 Sep 2023 00:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENRBrncko2IZrJLySO5XTo5zpFNtPe0y1MbRN3POPmZkw+BAh6FuZTqoyLbtUEwRv46T4NhyFc1M6hHusnblqllcF7bdpm+YNziL1JQqEg6ddZS4ETEWp+gArg92HO/qqFN0LFPj84mcdxHDPge5WiJE0vPLOuORwBUXAiEegl48UilT7Mx70FaFdBrg1icgWr2s+ElrkqgPKU4+uSdPY+/YIyvOYYC4qTS5W8r+BEU2sc1LVM09ry/s97xxAnu7NelJjjyreM+y1Fx1khPzVQU2hE/pn3U2Svr/HcISybFH3MmaQgnA1a97vba3zIJXlWs7CR4aJaPB02/BH11kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DKyGwIj4jv7VDoNrsbW4MCGeMC+A7Fjxr12aryd/0k=;
 b=P3oS0xGEyG/aKRfJcALzD8HK+Vep6qP2TutsmjfZwY9nLU1WwZpwP0w6FK1ule0+cJP9VaCw669uMXuUgKe80i0Zy2Y+cA+X5lpVwGTamkBZJlHWv9fd3nI0qmUg8oC+bz1BT4bS4Cv152YHsfVuYauWaE3Dh7h/HqwRADSuxa8LHvDEZ6snLRiz9LbwFjA4gi3Vk/HUQutbyagb4O4pKoEpREq2rYFiWPyD+5lN97a6tzgE6pTxxqfMBVSx5KSSEBbA9CBwBxWHjZOQiQqvcjgplcNGbSJW6xKGfSB/rwmqxOgXb3K9K4Iqo6o1BoeOoV3txmCHOAUYOhEskaIdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DKyGwIj4jv7VDoNrsbW4MCGeMC+A7Fjxr12aryd/0k=;
 b=LujzvkldKVdvzkRN2XebIglZAKv450VcgxhrdZKRo/lHjfcSjBuehaMQAFJFZ2LzKKiPtMvBIS+yXuzP4ERRek9DutT5TGoEtx1qp4NKyY2JTDlW3hEpb84/MdsfcrJG//G7jsINTQhbC8PEyEs2Nz+kS6RQuzx2xjloGmBAsJPoohzvhasnIjSTn6W8A69dAj0Ab31gsSxpFGemRW6igDJbanyfF0NkFJMLz7m8mo2veVn6ZMQplqSqiCCufQaDwZLnRI66FSxjNfj9bacRGfXdjcDKd5+HuUTb0iMvk39CGJxNLsT97OU7ncoBjr/9YAI2Sq7eSZgycySwjLEOkw==
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 DBAP190MB0840.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 07:55:15 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:55:15 +0000
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
Subject: [RFC PATCH 1/3] cgroup: list all subsystem states in debugfs files
Thread-Topic: [RFC PATCH 1/3] cgroup: list all subsystem states in debugfs
 files
Thread-Index: AQHZ5IVMonqYoLV7B0qibYNmxbXARA==
Date:   Mon, 11 Sep 2023 07:55:15 +0000
Message-ID: <20230911075437.74027-2-zeil@nebius.com>
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
x-ms-office365-filtering-correlation-id: 1acaef6c-91e9-4e0d-90a1-08dbb29c6f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppn0QukgfN6KAteDgq51Ije4yeAt6vGJHRWzQ5q8Z0BUtjnEiyJsRvQlmAqPzNK9GJDETRcFDmIUHs5b3BwK5ByKAs+Fr8f0ezF2EtU/9+3a0zJF4Ya1kIieQx4qExtqjH5nRP3xAHPiM0s7ewPKSwDG8uDPBdQsXbK4MV4Bij8WeVaI3tlyQIVakc2k+dPyoy3JKaA43AhlRMW7eoNyAk7VJtOIR9xcXoT7/lgVBJS7qxMYfCqRaOllsbzMRqKsBKXA3/D/5mspNYamjvWG6Ti9VMNr4NZELbIK8yA3UOcEAcvkfo4/elBBM7cM9YgWPqFnKXzmahaLPDtgGS7Mub489+XxgRB1b+YWKZQs1u7gjKLCPCRvZ7xi5Wrn4cG6Zj/+P4Livfwzi3wTi7BYnG1ZNEAgkSvYymn5tPV00vjBj26/Eokr7LXfS5gMm6v4+Nf05ZveMrWZvawYBKU+t7iNWIzXC0NYprdBRz0cGJXSBnif/JnmrbOiO4pMAcAgUDG8vtNRtYlFfv4TMIbuKQQg8lJ/QmqyjO7V61doGdr6ffTgRvVXNUOv0zWOlAVP+Oh4+sXdjnlJIbEooHrLDSL254lgu9fbc9dVnhvWk6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39830400003)(451199024)(1800799009)(186009)(6486002)(71200400001)(6506007)(36756003)(86362001)(38100700002)(38070700005)(122000001)(26005)(2616005)(1076003)(2906002)(966005)(6512007)(478600001)(83380400001)(5660300002)(41300700001)(4326008)(76116006)(316002)(110136005)(8676002)(8936002)(66446008)(64756008)(54906003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uk1um9NzmTDYpWtZ8u9SzU9Y5/IznmX/vusa9tOa7sCYPmsJ89eb5Q5IZk?=
 =?iso-8859-1?Q?K+6AjWpAliUZMaIt4y5eqkfKJJ4+m5rRGPmb48MlsvvQMIPhVIH1J4b+R3?=
 =?iso-8859-1?Q?uQnbS/1E2s99GS2cC3WG9jCQ84YAw+OXkq1rVvH1VUUz94UwiDOpwB1ohY?=
 =?iso-8859-1?Q?eREBk5zl7nfznUtlVyhjrsCYnOrU/ch8wJKj4Ts3p5j7hVqQpsx6gVp5Id?=
 =?iso-8859-1?Q?nbaG/MLGF962Lys3pXtGIMH5nU7KMfd4PH+WbRytYKjdD5+hZxtfISdoRA?=
 =?iso-8859-1?Q?zhxIQWOdNhjS58qkiRoqgrjOE4ulboR0IPns4yHqFhp6+KvAj42qJSkx8L?=
 =?iso-8859-1?Q?eqWC+lwfWiw9fZn1umZ+zeCE81Njh7mqvk5Ta5yImLYtOfw096pSj4WR/5?=
 =?iso-8859-1?Q?xjJWIeZy61sKfC8UJBsNEkBgyji+xmDI+Qmw5qsbQefjGKLGxjNsQtWwvC?=
 =?iso-8859-1?Q?SuBrxd4e0Pmy562AxwncEVGh4/JGhfCHYiG+oAIaKKSm7hdS80CuM0n+Lb?=
 =?iso-8859-1?Q?xLWZUZwdanqFOctgfv3Kt2XEzFli7bSoYC2TGlJ8iAICmDKanzGGkfPOXF?=
 =?iso-8859-1?Q?hsCnXb/rAABz7deCl4Yfn0QA+FNGzsPLiJ3Or8NLCKQEDRsSJzqwykHNnP?=
 =?iso-8859-1?Q?24dnfjg6gDIBsVeroEtVyOFm7zc0aYBe+6icKj/MgqE7vytgCAP4fKOf/i?=
 =?iso-8859-1?Q?/IR1E8ae7S0csO9J9Gair59S9dIUX0pGA9iauzGkbOnaimfhqPPXlXNVHG?=
 =?iso-8859-1?Q?hhfVhpvPstLgiN7djmTvoNthFaMK2vIIUjGM53zhRRX061NohGnNlGCBpv?=
 =?iso-8859-1?Q?okawuSHCObEzzgNtZB7QGkn/LxndobC0UfjKZUeXuL+8zIERkYOiESuSHC?=
 =?iso-8859-1?Q?mVMOppcSyownRse26XbyEe6CtvG0IzE+JHIe9VjH7Ch2icOvy06qxhpGAA?=
 =?iso-8859-1?Q?A4KfcqKg8g/RuTBvocuS17GKKvLCzN7fi1d5/aK3n2PtXcwGLkAVV/n0me?=
 =?iso-8859-1?Q?LIq7odcZH6mAlWWh2x4EGrxM46yA80ZrN40+FXuokaWczw1M71hsmFq5yV?=
 =?iso-8859-1?Q?FApnMKyD225f2xxbj0mVW+Gjetm8h6A2qrWZloFOfHPxtNvZk3ZyhvbM1M?=
 =?iso-8859-1?Q?/I+MlkYXiomr2Vr8yT/HMmvbQb1PhNUdwj+QgZ1a09/jUTRKs4Vq0HHLCK?=
 =?iso-8859-1?Q?RxR2iOEF8ydd24/+PyaeaaAZhbPIUyueq3/QLzSsaPoEZD8ASbzf1oXmn1?=
 =?iso-8859-1?Q?xQGbeWux7HKJd+e7nEW1P44HfBVgty1FS6msXHumqJXPtjGI5OGc/LeLNA?=
 =?iso-8859-1?Q?qb3v4UfD7O9wseMFChOKELmwu7fqBbkOdiVvgiTRaMHCvN7jPGaecui86F?=
 =?iso-8859-1?Q?C3Xdv9DP69c4fYrZXSwHETUSAaRcgBh+kyWRHMR98RskZeZD/37Mcz/4JO?=
 =?iso-8859-1?Q?VLJ9EAHLGyXejEpU+m4T/ZSlM0HWh7rYpCtd9VtcpSd1n1bvpoSjsYs5ht?=
 =?iso-8859-1?Q?iw15SLJrSgKVGvzu2Yd6QhFvSipvVT7CybGNaFnLvLg2TO0+GaqQ60acxz?=
 =?iso-8859-1?Q?tveIQNN3WtuQ8MUDHb+vlzuCJZx9xIaMe85P5ctxax2RK/pPf077rzwIUs?=
 =?iso-8859-1?Q?w3jNTnKyR58I8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acaef6c-91e9-4e0d-90a1-08dbb29c6f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:55:15.1918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3P2kjfGUyyP3F5sEc+FsRNrne79XP4BycDBWoowRaWzffu1QHnaqTTs7Baeq0TD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After removing cgroup subsystem state could leak or live in background=0A=
forever because it is pinned by some reference. For example memory cgroup=
=0A=
could be pinned by pages in cache or tmpfs.=0A=
=0A=
This patch adds common debugfs interface for listing basic state for each=
=0A=
controller. Controller could define callback for dumping own attributes.=0A=
=0A=
In file /sys/kernel/debug/cgroup/<controller> each line shows state in=0A=
format: <common_attr>=3D<value>... [-- <controller_attr>=3D<value>... ]=0A=
=0A=
Common attributes:=0A=
=0A=
css - css pointer=0A=
cgroup - cgroup pointer=0A=
id - css id=0A=
ino - cgroup inode=0A=
flags - css flags=0A=
refcnt - css atomic refcount, for online shows huge bias=0A=
path - cgroup path=0A=
=0A=
This patch adds memcg attributes:=0A=
=0A=
mem_id - 16-bit memory cgroup id=0A=
memory - charged pages=0A=
memsw - charged memory+swap for v1 and swap for v2=0A=
kmem - charged kernel pages=0A=
tcpmem - charged tcp pages=0A=
shmem - shmem/tmpfs pages=0A=
=0A=
Link: https://lore.kernel.org/lkml/153414348591.737150.14229960913953276515=
.stgit@buzz=0A=
Suggested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>=0A=
Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>=0A=
Signed-off-by: Dmitry Yakunin <zeil@nebius.com>=0A=
---=0A=
 include/linux/cgroup-defs.h |   1 +=0A=
 kernel/cgroup/cgroup.c      | 101 ++++++++++++++++++++++++++++++++++++=0A=
 mm/memcontrol.c             |  14 +++++=0A=
 3 files changed, 116 insertions(+)=0A=
=0A=
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h=0A=
index 8a0d5466c7be..810bd300cbee 100644=0A=
--- a/include/linux/cgroup-defs.h=0A=
+++ b/include/linux/cgroup-defs.h=0A=
@@ -673,6 +673,7 @@ struct cgroup_subsys {=0A=
 	void (*exit)(struct task_struct *task);=0A=
 	void (*release)(struct task_struct *task);=0A=
 	void (*bind)(struct cgroup_subsys_state *root_css);=0A=
+	void (*css_dump)(struct cgroup_subsys_state *css, struct seq_file *m);=0A=
 =0A=
 	bool early_init:1;=0A=
 =0A=
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c=0A=
index 625d7483951c..fb9931ff7570 100644=0A=
--- a/kernel/cgroup/cgroup.c=0A=
+++ b/kernel/cgroup/cgroup.c=0A=
@@ -40,6 +40,7 @@=0A=
 #include <linux/mount.h>=0A=
 #include <linux/pagemap.h>=0A=
 #include <linux/proc_fs.h>=0A=
+#include <linux/debugfs.h>=0A=
 #include <linux/rcupdate.h>=0A=
 #include <linux/sched.h>=0A=
 #include <linux/sched/task.h>=0A=
@@ -7068,3 +7069,103 @@ static int __init cgroup_sysfs_init(void)=0A=
 subsys_initcall(cgroup_sysfs_init);=0A=
 =0A=
 #endif /* CONFIG_SYSFS */=0A=
+=0A=
+#ifdef CONFIG_DEBUG_FS=0A=
+void *css_debugfs_seqfile_start(struct seq_file *m, loff_t *pos)=0A=
+{=0A=
+	struct cgroup_subsys *ss =3D m->private;=0A=
+	struct cgroup_subsys_state *css;=0A=
+	int id =3D *pos;=0A=
+=0A=
+	rcu_read_lock();=0A=
+	css =3D idr_get_next(&ss->css_idr, &id);=0A=
+	*pos =3D id;=0A=
+	return css;=0A=
+}=0A=
+=0A=
+void *css_debugfs_seqfile_next(struct seq_file *m, void *v, loff_t *pos)=
=0A=
+{=0A=
+	struct cgroup_subsys *ss =3D m->private;=0A=
+	struct cgroup_subsys_state *css;=0A=
+	int id =3D *pos + 1;=0A=
+=0A=
+	css =3D idr_get_next(&ss->css_idr, &id);=0A=
+	*pos =3D id;=0A=
+	return css;=0A=
+}=0A=
+=0A=
+void css_debugfs_seqfile_stop(struct seq_file *m, void *v)=0A=
+{=0A=
+	rcu_read_unlock();=0A=
+}=0A=
+=0A=
+int css_debugfs_seqfile_show(struct seq_file *m, void *v)=0A=
+{=0A=
+	struct cgroup_subsys *ss =3D m->private;=0A=
+	struct cgroup_subsys_state *css =3D v;=0A=
+	/* data is NULL for root cgroup_subsys_state */=0A=
+	struct percpu_ref_data *data =3D css->refcnt.data;=0A=
+	size_t buflen;=0A=
+	char *buf;=0A=
+	int len;=0A=
+=0A=
+	seq_printf(m, "css=3D%pK cgroup=3D%pK id=3D%d ino=3D%lu flags=3D%#x refcn=
t=3D%lu path=3D",=0A=
+		   css, css->cgroup, css->id, cgroup_ino(css->cgroup),=0A=
+		   css->flags, data ? atomic_long_read(&data->count) : 0);=0A=
+=0A=
+	buflen =3D seq_get_buf(m, &buf);=0A=
+	if (buf) {=0A=
+		len =3D cgroup_path(css->cgroup, buf, buflen);=0A=
+		seq_commit(m, len < buflen ? len : -1);=0A=
+	}=0A=
+=0A=
+	if (ss->css_dump) {=0A=
+		seq_puts(m, " -- ");=0A=
+		ss->css_dump(css, m);=0A=
+	}=0A=
+=0A=
+	seq_putc(m, '\n');=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const struct seq_operations css_debug_seq_ops =3D {=0A=
+	.start =3D css_debugfs_seqfile_start,=0A=
+	.next =3D css_debugfs_seqfile_next,=0A=
+	.stop =3D css_debugfs_seqfile_stop,=0A=
+	.show =3D css_debugfs_seqfile_show,=0A=
+};=0A=
+=0A=
+static int css_debugfs_open(struct inode *inode, struct file *file)=0A=
+{=0A=
+	int ret =3D seq_open(file, &css_debug_seq_ops);=0A=
+	struct seq_file *m =3D file->private_data;=0A=
+=0A=
+	if (!ret)=0A=
+		m->private =3D inode->i_private;=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static const struct file_operations css_debugfs_fops =3D {=0A=
+	.open =3D css_debugfs_open,=0A=
+	.read =3D seq_read,=0A=
+	.llseek =3D seq_lseek,=0A=
+	.release =3D seq_release,=0A=
+};=0A=
+=0A=
+static int __init css_debugfs_init(void)=0A=
+{=0A=
+	struct cgroup_subsys *ss;=0A=
+	struct dentry *dir;=0A=
+	int ssid;=0A=
+=0A=
+	dir =3D debugfs_create_dir("cgroup", NULL);=0A=
+	if (dir) {=0A=
+		for_each_subsys(ss, ssid)=0A=
+			debugfs_create_file(ss->name, 0644, dir, ss,=0A=
+					    &css_debugfs_fops);=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+late_initcall(css_debugfs_init);=0A=
+#endif /* CONFIG_DEBUG_FS */=0A=
diff --git a/mm/memcontrol.c b/mm/memcontrol.c=0A=
index 4b27e245a055..7b3d4a10ac63 100644=0A=
--- a/mm/memcontrol.c=0A=
+++ b/mm/memcontrol.c=0A=
@@ -5654,6 +5654,20 @@ static void mem_cgroup_css_rstat_flush(struct cgroup=
_subsys_state *css, int cpu)=0A=
 	}=0A=
 }=0A=
 =0A=
+static void mem_cgroup_css_dump(struct cgroup_subsys_state *css,=0A=
+				struct seq_file *m)=0A=
+{=0A=
+	struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);=0A=
+=0A=
+	seq_printf(m, "mem_id=3D%u memory=3D%lu memsw=3D%lu kmem=3D%lu tcpmem=3D%=
lu shmem=3D%lu",=0A=
+		   mem_cgroup_id(memcg),=0A=
+		   page_counter_read(&memcg->memory),=0A=
+		   page_counter_read(&memcg->memsw),=0A=
+		   page_counter_read(&memcg->kmem),=0A=
+		   page_counter_read(&memcg->tcpmem),=0A=
+		   memcg_page_state(memcg, NR_SHMEM));=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_MMU=0A=
 /* Handlers for move charge at task migration. */=0A=
 static int mem_cgroup_do_precharge(unsigned long count)=0A=
-- =0A=
2.25.1=0A=
=0A=
