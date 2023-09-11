Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC979A51D
	for <lists+cgroups@lfdr.de>; Mon, 11 Sep 2023 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIKHzl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjIKHzj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 03:55:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::723])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F42CDC;
        Mon, 11 Sep 2023 00:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZ+J06hVKfKF68iCYKvHRa46lza9m9MqAKz5YQbg6DVfa482v5NkXk6dpp7z/ovBxfYQHnb2Ip15uj4oBk0bxeLI48AVC0M+i0v8ArCABFU3+QdKoyLAm0h93omLPUaZuN36Evszvl3zjA+c0eiB7t+gtCo6OiUn9s8hq29l5BCIhk3998LYH1jg/z23TZN4adCMtmoe+ZH+ruKK30liYSfgctEaEjURaTWI9gvarkcdMg5BaYOa74f9X1IyXvL97oJOfTRa3Ac3uP2oAOV8CO50m9/PokpmIEl7lHt5khhFunE/0VpDgu5gQnUIzRKaGgljyeyljWcqycyHau6uNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs1ZCDDoENjULFOlfJgGzX2+wQ3stP8WoMAjcuMWdmo=;
 b=UD4N8gf7pB/uMDD2QQgLDj77HQCkvVjeeZRFGfp1nFswvhJ4iKOk/OYiDt6umPYq1EDadkHPfpGQBWRgZVy94us861nUZC8cYqgnHUn+e9uVMyyY2qE+jP314ku/PkA5aqGhTRqa366BphVL/N7OlZB3UScrB9Zg8aBY5azehSAOq08hihqm1uCBnaXcT+S6gjKTWLHOSr/YRSOvnBCaZzIsrvWSHdRD3rHgYWe+N2knrZHMPzFHUNJbWgRL/98JrQUXdmgh9/B1sA42juzoTixfxFu9hsqxrqB142lKHHEhBPPQarviM0SEdcHY1nah51cy8sOADRLCIUyT7yU9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs1ZCDDoENjULFOlfJgGzX2+wQ3stP8WoMAjcuMWdmo=;
 b=USF3bFUiw13spjOIDG+c2JYMAC+S4pDYVAOMPlwCFud4aMRd5+T4b8YZ51lULULY/SWEK2QFLLys+PNijhefOhx/fY2d6igsG8rLNolOi1bFbt1ianSqXiLS+1+STEU524YPtScyLuXNpWzfUvun104opKX4oSbs7dserEbyTIH3VcOIDzZ92TaueBHACeNveb0kqBvPGdthAXsGxGqSiNL2+RN/SsdNnlSWmoRIv0AaDJUnPr5DKZj9NFDThzPSs1hovPakrhE2QKE6t5xNXxdk6v9vEWwcj7gqRRkEzsX0lnvCPezUhQhabpylnHX8HLR1r00t/AsXioQVuoRG8g==
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3a4::9) by
 DBAP190MB0840.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 07:55:20 +0000
Received: from DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3]) by DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
 ([fe80::1dc2:35fa:896c:8ca3%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 07:55:20 +0000
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
Subject: [RFC PATCH 2/3] proc/kpagecgroup: report also inode numbers of
 offline cgroups
Thread-Topic: [RFC PATCH 2/3] proc/kpagecgroup: report also inode numbers of
 offline cgroups
Thread-Index: AQHZ5IVP2/T8/rYz/kmqVYV4jrzxrQ==
Date:   Mon, 11 Sep 2023 07:55:20 +0000
Message-ID: <20230911075437.74027-3-zeil@nebius.com>
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
x-ms-office365-filtering-correlation-id: 7b404bef-c28b-48e7-e05c-08dbb29c7263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AT0emg6GlZHSr6l27B75O0Xvp9nrRCzuPFfZZxTYSPMAD4SaGpuJWCWlrdoH9kN7iNTGe0ESkMgMAedLtQdbb5TbobkT/JuUVaEKd1F2n+e4aTjiUA8VzgznVQnsxjip9gqdyyF97fWxvUKupube5FaqJ6RWtkNVaz7o3eNfALb0sgYIS03FQB+p7Mn5tflyRXo7n/M571VjXom4/g92ehJKxcCsjeWS3P8qPuVfZFPWcpeqI9UDfxLAG+km7P+VjWzGRItt+/zG1L1L3YIEm8dOLXz8RUkzy8AbIknLTZVSxVYvqmEJGR1XJdzOj3LpxoZIPGqC5XBdfzbTQp5kPobyJAmjYLbR+d0ANQYpMJgKCfV7+zbl+jVfs32jcNJOvb1WXNnCoDDWKzGajR8Lua4n38co8bD/Kmi9YVX1NnNdx7IjQVQzje0fQ9T2OOxA48G/GzgEPpRtGZSYx3DH9Pj7Zp0o9xmqT3SvZaKKzbyfYBWmP+h9I/+MeUGhdPzTc4Bwn3XOYWHhFyoQK2Jg/Woi0PXUrOSouQkRFDfym109h+dtAkuCo2Qr/8AjyuinFmj0mJhZXh+K6YNOySPTmzJG4qSygZROKNSMSqbwSw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P190MB1860.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39830400003)(451199024)(1800799009)(186009)(6486002)(71200400001)(6506007)(36756003)(86362001)(38100700002)(38070700005)(122000001)(26005)(2616005)(1076003)(2906002)(966005)(6512007)(478600001)(83380400001)(5660300002)(41300700001)(4326008)(76116006)(316002)(110136005)(8676002)(8936002)(66446008)(64756008)(54906003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wS/EC56qsihhzY4AsQPKjooQgVQUPKlM7xdYLN0GbJMs8108NS2ELox30D?=
 =?iso-8859-1?Q?mwQFj7r7NpAgvnEoRGUW8OAQ7rs6e7vg3xanQqSfZTdVhR0J4j8CEFW/mN?=
 =?iso-8859-1?Q?jctYqhYuD1uFT1Z+Y2VvjSWtupReKKUKHJFt2P+pW8FMOVpdVgzrg0rtif?=
 =?iso-8859-1?Q?Ego34kR8UrSG8exCC9neyBtGot2GExS9x3c0TJ04a7nVrqK2iLH0shhovb?=
 =?iso-8859-1?Q?qt1kuy8JpRrxo69rJSQ40GYMzfcFX9KxWltSo/Jk+nhbSobuLVId68BZT4?=
 =?iso-8859-1?Q?JxTJ0abRGIpmbzfCIzqK6EWp9Y3RvuY0/7VwXVPWvuskEjn7u1Aw90ylCT?=
 =?iso-8859-1?Q?qPda+X6YUo/IvHq/wBAw2hxdcAconl9LOFJdykwasl+UBf5AcfFHfPdDFl?=
 =?iso-8859-1?Q?e69ZC59BkIxmVdrymBybS//AIpGsgrgMXTkzTV2vUYcZTl1zOg6XkSKazh?=
 =?iso-8859-1?Q?3YIKUEBRiaN3n7tXotKAJYGtKLNNWLugCECYPAT5x6Vys+dCfO0mH9tS6S?=
 =?iso-8859-1?Q?1blgcJo/9LCeqtpbRhVJ7hXoJ8Qcx7Sfn4NhiH47Mh00uCvQyUFO3DoK9e?=
 =?iso-8859-1?Q?ZUJoMGNQjAWqMKSqWRXORT3gD/4Yl7JwcfAZaDNCUcdb0LTZUP1bwWCjd0?=
 =?iso-8859-1?Q?y3oNho+tJoQrwzfLJ6uNS3CtFPokEqBCOw3emS7fEJ7JWbWnpOfZvFwkZj?=
 =?iso-8859-1?Q?OX1dreoEIpRS7gvPeuD+Uk17xCPkuybXtPSGD7bdEWBq/k8qy6YEKSO0vQ?=
 =?iso-8859-1?Q?2ShKfi460eh0WtcUpWWRRAXWPPPLvcgpUPjK42uI6vLx9eH59ZW4fZ84eK?=
 =?iso-8859-1?Q?hZCkicnWFAVk5EpN9Ldf3atIUWRRFDhfjBsqvP0zgZdUxFXIduRHm1txOX?=
 =?iso-8859-1?Q?7W6StKKVAt3I9qJnhC9FuWfJ9doDOI24L9a/b4nJHnzGoBWCI9c4/RVdoa?=
 =?iso-8859-1?Q?Vvy4aUE9jvskZytC7umUabd/VPLsMuACbr8Z8E/KSRDuiWQ0k1/HBCCujM?=
 =?iso-8859-1?Q?t9GAI/SodWNJWaLVRVO+msPOFpgxRNfkVobrb2b4+/5BB74mg7JdxFij8X?=
 =?iso-8859-1?Q?WXqQ63lxNlYdgYlmbT9JQfNbRkTJCzPbFd3o/nHxFgVSjphCh6uitYlbha?=
 =?iso-8859-1?Q?e9Dx+skImnVLKVkrWZ5wTiApEalUpYciWMwzXkrjOSuVuMMgIeDLn4Fk6R?=
 =?iso-8859-1?Q?FP6ExVKrrgRVAU0heP1MVTdilHS+SNhCUHSvUMcoa2yOnGVeYn7rbuLOiv?=
 =?iso-8859-1?Q?kQVOic7J2+GXjCvAl2xAGnpxC7T4qv1+Xrm0kAKUBNtmkhyPshbg2Bo5Fi?=
 =?iso-8859-1?Q?gbg2Jn/2alOsamKd1cVVoUPoNI4Yo0bwRdF5A7ByDDlc7QaelrvWBbyHmP?=
 =?iso-8859-1?Q?j/VaMDXWFYAWKEQlVHm0iGJvp7YWwC/lWGJJI4kDYjrqRpvWT/eUWUwdxv?=
 =?iso-8859-1?Q?sPshHQmUDGPSvffjKYxHX08XIk0VQ5/ZnyxYyz9kbp2n3prjTwS5JvbEjX?=
 =?iso-8859-1?Q?GhSY0ZHnYZDUWwPk0RGl6HzjNhJyiNq/V953wxogIiU/2FAYTMYxtCtcuy?=
 =?iso-8859-1?Q?MGW6nqDwbMjfi7TUN6zL+WAlaUsp5SAdDtKYwWI8rGNpPG6N+8/m7htF9P?=
 =?iso-8859-1?Q?Nua5krdhRKzLw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB1860.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b404bef-c28b-48e7-e05c-08dbb29c7263
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:55:20.6506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvbHEnOFef1b0DKBLx7L0hvqK6hxIQVP08aCXx6Inpt8NEyYXq/GRyv5FuUD/kK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

By default this interface reports inode number of closest online ancestor=
=0A=
if cgroups is offline (removed). Information about real owner is required=
=0A=
for detecting which pages keep removed cgroup.=0A=
=0A=
This patch adds per-file mode which is changed by writing 64-bit flags=0A=
into opened /proc/kpagecgroup. For now only first bit is used.=0A=
=0A=
Link: https://lore.kernel.org/lkml/153414348994.737150.10057219558779418929=
.stgit@buzz=0A=
Suggested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>=0A=
Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>=0A=
Signed-off-by: Dmitry Yakunin <zeil@nebius.com>=0A=
---=0A=
 fs/proc/page.c             | 24 ++++++++++++++++++++++--=0A=
 include/linux/memcontrol.h |  2 +-=0A=
 mm/memcontrol.c            |  5 +++--=0A=
 mm/memory-failure.c        |  2 +-=0A=
 4 files changed, 27 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/fs/proc/page.c b/fs/proc/page.c=0A=
index 195b077c0fac..ae6feca2bbc7 100644=0A=
--- a/fs/proc/page.c=0A=
+++ b/fs/proc/page.c=0A=
@@ -278,6 +278,7 @@ static const struct proc_ops kpageflags_proc_ops =3D {=
=0A=
 static ssize_t kpagecgroup_read(struct file *file, char __user *buf,=0A=
 				size_t count, loff_t *ppos)=0A=
 {=0A=
+	unsigned long flags =3D (unsigned long)file->private_data;=0A=
 	const unsigned long max_dump_pfn =3D get_max_dump_pfn();=0A=
 	u64 __user *out =3D (u64 __user *)buf;=0A=
 	struct page *ppage;=0A=
@@ -301,7 +302,7 @@ static ssize_t kpagecgroup_read(struct file *file, char=
 __user *buf,=0A=
 		ppage =3D pfn_to_online_page(pfn);=0A=
 =0A=
 		if (ppage)=0A=
-			ino =3D page_cgroup_ino(ppage);=0A=
+			ino =3D page_cgroup_ino(ppage, !(flags & 1));=0A=
 		else=0A=
 			ino =3D 0;=0A=
 =0A=
@@ -323,10 +324,29 @@ static ssize_t kpagecgroup_read(struct file *file, ch=
ar __user *buf,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static ssize_t kpagecgroup_write(struct file *file, const char __user *buf=
,=0A=
+				 size_t count, loff_t *ppos)=0A=
+{=0A=
+	u64 flags;=0A=
+=0A=
+	if (count !=3D 8)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (get_user(flags, buf))=0A=
+		return -EFAULT;=0A=
+=0A=
+	if (flags > 1)=0A=
+		return -EINVAL;=0A=
+=0A=
+	file->private_data =3D (void *)(unsigned long)flags;=0A=
+	return count;=0A=
+}=0A=
+=0A=
 static const struct proc_ops kpagecgroup_proc_ops =3D {=0A=
 	.proc_flags	=3D PROC_ENTRY_PERMANENT,=0A=
 	.proc_lseek	=3D mem_lseek,=0A=
 	.proc_read	=3D kpagecgroup_read,=0A=
+	.proc_write	=3D kpagecgroup_write,=0A=
 };=0A=
 #endif /* CONFIG_MEMCG */=0A=
 =0A=
@@ -335,7 +355,7 @@ static int __init proc_page_init(void)=0A=
 	proc_create("kpagecount", S_IRUSR, NULL, &kpagecount_proc_ops);=0A=
 	proc_create("kpageflags", S_IRUSR, NULL, &kpageflags_proc_ops);=0A=
 #ifdef CONFIG_MEMCG=0A=
-	proc_create("kpagecgroup", S_IRUSR, NULL, &kpagecgroup_proc_ops);=0A=
+	proc_create("kpagecgroup", 0600, NULL, &kpagecgroup_proc_ops);=0A=
 #endif=0A=
 	return 0;=0A=
 }=0A=
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h=0A=
index 222d7370134c..bbbddaa260d3 100644=0A=
--- a/include/linux/memcontrol.h=0A=
+++ b/include/linux/memcontrol.h=0A=
@@ -892,7 +892,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm=
,=0A=
 }=0A=
 =0A=
 struct cgroup_subsys_state *mem_cgroup_css_from_folio(struct folio *folio)=
;=0A=
-ino_t page_cgroup_ino(struct page *page);=0A=
+ino_t page_cgroup_ino(struct page *page, bool online);=0A=
 =0A=
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)=0A=
 {=0A=
diff --git a/mm/memcontrol.c b/mm/memcontrol.c=0A=
index 7b3d4a10ac63..48cfe3695e06 100644=0A=
--- a/mm/memcontrol.c=0A=
+++ b/mm/memcontrol.c=0A=
@@ -380,6 +380,7 @@ struct cgroup_subsys_state *mem_cgroup_css_from_folio(s=
truct folio *folio)=0A=
 /**=0A=
  * page_cgroup_ino - return inode number of the memcg a page is charged to=
=0A=
  * @page: the page=0A=
+ * @online: return closest online ancestor=0A=
  *=0A=
  * Look up the closest online ancestor of the memory cgroup @page is charg=
ed to=0A=
  * and return its inode number or 0 if @page is not charged to any cgroup.=
 It=0A=
@@ -390,7 +391,7 @@ struct cgroup_subsys_state *mem_cgroup_css_from_folio(s=
truct folio *folio)=0A=
  * after page_cgroup_ino() returns, so it only should be used by callers t=
hat=0A=
  * do not care (such as procfs interfaces).=0A=
  */=0A=
-ino_t page_cgroup_ino(struct page *page)=0A=
+ino_t page_cgroup_ino(struct page *page, bool online)=0A=
 {=0A=
 	struct mem_cgroup *memcg;=0A=
 	unsigned long ino =3D 0;=0A=
@@ -399,7 +400,7 @@ ino_t page_cgroup_ino(struct page *page)=0A=
 	/* page_folio() is racy here, but the entire function is racy anyway */=
=0A=
 	memcg =3D folio_memcg_check(page_folio(page));=0A=
 =0A=
-	while (memcg && !(memcg->css.flags & CSS_ONLINE))=0A=
+	while (memcg && online && !(memcg->css.flags & CSS_ONLINE))=0A=
 		memcg =3D parent_mem_cgroup(memcg);=0A=
 	if (memcg)=0A=
 		ino =3D cgroup_ino(memcg->css.cgroup);=0A=
diff --git a/mm/memory-failure.c b/mm/memory-failure.c=0A=
index 5b663eca1f29..6734489b2435 100644=0A=
--- a/mm/memory-failure.c=0A=
+++ b/mm/memory-failure.c=0A=
@@ -267,7 +267,7 @@ static int hwpoison_filter_task(struct page *p)=0A=
 	if (!hwpoison_filter_memcg)=0A=
 		return 0;=0A=
 =0A=
-	if (page_cgroup_ino(p) !=3D hwpoison_filter_memcg)=0A=
+	if (page_cgroup_ino(p, true) !=3D hwpoison_filter_memcg)=0A=
 		return -EINVAL;=0A=
 =0A=
 	return 0;=0A=
-- =0A=
2.25.1=0A=
=0A=
