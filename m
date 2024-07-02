Return-Path: <cgroups+bounces-3489-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E227E9238AF
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7DA286464
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9315381C;
	Tue,  2 Jul 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EXvsFRi1"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8F152DF1;
	Tue,  2 Jul 2024 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909979; cv=fail; b=nv82G5ej2kcaXI4uoksgAyaG4HPD+8Tsl0nvUyytZlxMB4mnXU6DiKTcZXK8tJTLccW7CjRc4j7+rxL9zaHGx333OL1lFzRQgmiWQbwa4iQ9bFpi/SNBsR8Pkkj4H+FTboyih9CRGIMSXXSCRUwLhveuLU8hmGvROr6juyUxWRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909979; c=relaxed/simple;
	bh=umZjQkmPExVF9mjm+W4YEm9OcS17G4xwfLsC3/18sgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sR3+1ZKBjr7ha/dllq59eFHaeMdYc4rUWq0OIM0I9yyGoETmJ8imk/G/Rz3rjh5Xskd1ShpMwhTXtdH+3ICY4+3kzcVgZQzma/UloKV4/qlQWDn7jYoFl3sSiveRdgOHvrbxbFRv+o6ZEOhGuD7zvngIvUD2FfhgPZ+kjmGpWFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EXvsFRi1; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NG0QT6WaQyDMRNhuKpwKm4IjyN6ujj4mv9OjwCybe07stJvxBXnODj5XQo4R6+aGR1LFplJoRWF1eSM9nuazxdi0oO8QlzchB14CR7t2xPm8Mp3d5V0rZKwLRQRQ+bBvt/LgrMcNN+9nBYscp92Z14c43nA2ch78kyODkZaqEt97YZ8ELfc3yPESpAglE55NNWGg4L0XfFPH2fJJKJSeZ8UzX956EDiqglbXuS09osPj7Av5qsrAPPJhhHTJz5KQseffF2SRUvbCu1IUxwp6yKb7ejrZoex+9guTWCpCKr0Xg/SflpwsWufTnNppbV5w+YUYQ7jZ75vxIeNOglCbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHncJhtTb2CVCgR6KyprnXFeC/NMYgOPEuy1IeHa92A=;
 b=gWM7HRpHHNti1miCfZWpwf4Er+XP5/Z0vnPPDJqfzCyDiBeGajzkFZS+FanDXCUTBSmZR5WacOMC8LVwcX+2AYBVlTbTC2kiIvEK9l3hT1xIGQo4nb78M92FLRVBcJRsvFtMCRaZajwQYFUVI49Dcb6IjMxTQA0ItjGyqqh1C8nCxkRL/7eou/icHfrOYugVadL3udXI6kEacox4OFTDcRM7orZt6dXhvEf4nUBuMQqRBBlCpQxJEW5maMVDGvJxv9+X0gcmfd86dPSsRiSP+MNeoBKNxX3ZTPLEaj4LbtFJDi0EPKmbRrGP18f3IUGQ9/zV6+XcSbFp/Il6K6P8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHncJhtTb2CVCgR6KyprnXFeC/NMYgOPEuy1IeHa92A=;
 b=EXvsFRi1MNmtpSI2shGOY8GWVHvzvVZNozT6or9XUJHiM5GIYo/fKOl8hRUt7nW9s/hJWbln3yw+OikN5mC7fp9Q0Ttbm//1MIIQJ8qzRB9V0omtK5CEVi/TumwHze603NHGVAqB34zT41OlcZ4qog+xAJkN3tI8AFhNDedKbXo/8WELMroCD+hP2emNMVfGbT4SNBCsIDJ8E7jE+eyR6Fqpuwx7kwgTRe23qn4iGoT8vs6Z/6oBcDm/PXWJJESM9Vrm24EBY3WwmG71+qafy7n/WzZVVZ0kln54An/ha8rR6aJMybtp7u8MxkgldIRTkeTsVfUvp68wuuaMtbHSMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 08:46:15 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:46:15 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Chris Li <chrisl@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Huan Yang <link@vivo.com>,
	Kairui Song <kasong@tencent.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: opensource.kernel@vivo.com
Subject: [RFC PATCH 3/4] mm: memcg: pmc: support reaper
Date: Tue,  2 Jul 2024 16:44:06 +0800
Message-ID: <20240702084423.1717904-4-link@vivo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084423.1717904-1-link@vivo.com>
References: <20240702084423.1717904-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c9a2ec-00b6-4829-04f8-08dc9a736ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+ALswNfFrf7uwYXx6CNHD6PVJXXWXMzyIzOMBrmf6WIpIEbzYtLvmBLFD9v?=
 =?us-ascii?Q?+0eCUNthFpaiSC9Gigy4S+GSUyxKpyAiXRw28OV9k2w9LTGmwnk1CFz5Ld0+?=
 =?us-ascii?Q?rUn3AZpMsR1/j79+pp9Ok87mEW206l2K0A0RuGyuoG3lqkKix9T/Fk7lEQXm?=
 =?us-ascii?Q?HwJzMOF9kakAEpI3BAGFqCiaIf80+hlTIBdekNoQvxQNACAyyv8V18ypMD0h?=
 =?us-ascii?Q?Y93bTS/0+xhnS8kAm9vRSQT8x5VX+DZNGVLcwZBBfiqqOdjOyG4lOgIGSxXW?=
 =?us-ascii?Q?V4ig7ivvBfbxU0dylMuRZLE7yE9kt/ejp08mcsu98zZBJTCWYfyl3akI2vfY?=
 =?us-ascii?Q?GHtaYEYWl1SjiIoBeDwI9ZK3jt4vkMlXwxqQ9Vy/WFAoiuUqnVV0WosJwHgt?=
 =?us-ascii?Q?tx5o3UDJmXZW5QJCzsXhWcDc2MDvk4oYkaGK7CnaWWnfWuxU5foTowNGMiB4?=
 =?us-ascii?Q?FBpLyKa2q6wYFVJMpPUcKuGSYByIb2WkIS2RKEBDM15V2IJdhn/KwS2a8AhU?=
 =?us-ascii?Q?ygXngxxlwdrFTUnXjRrkaY9DUTETw3c6OKw3SBsXPBqMytLefR/t/skwpNy1?=
 =?us-ascii?Q?gWa2RX++wL5Xk+32XbRdgZupSE73qJJbcwGfLSFvRwMXMuBD20veYtypoQob?=
 =?us-ascii?Q?T3sn/5SXcjdB/z6oOd45TNIaa5o2xXg9TkqlYrZ0v3dARE5WKAlWvX5dPaKR?=
 =?us-ascii?Q?U3EMhtzhOkv1NBX0KXW6+q2xp0MvdWhanKrP9alMN/MmqkFqyXZ5Gw33V55C?=
 =?us-ascii?Q?z0dbZgYRrewqEjfyn8eKWqTxnM/NkmfngMcwnNvV51bmbt+SxF8Tb7aq+PWS?=
 =?us-ascii?Q?pQSPXVTFFIyXuKm7LQUAvDe+Ve6aXmm88W4cdWSToovYtP7NtMq23yOvOiGp?=
 =?us-ascii?Q?u7I+0unOMaoju6LfO869Z0FImcy61AYt/vnQpI/sQQW+lxGqu4QEsVLJIV0l?=
 =?us-ascii?Q?il/cUwIj3FrkNq2bLaPQqB5HGTd+uhtIV2Weja5B96WX3DCck5J0+Ci2MIoC?=
 =?us-ascii?Q?Etqh/OOh393KNHbqyOHxKRr3nXoz00P6lBu6cP+t+y4Etn1Ujd6F8Vty64kx?=
 =?us-ascii?Q?qJlmSebZwQT87VXm205iwdpfqJZ4d/chUJP6sOlE15zsVbBGfEiYhEUkzXNk?=
 =?us-ascii?Q?pLThqXPdfxLBqPoOrsxxDGh807r4LU9cmdPu02Xk8mJize1FWKHZ3ch3lYcz?=
 =?us-ascii?Q?MHyIR9Dsn4CoiMybHIpkxas2U8PICwR0+q+CGAJRpRAdyPLrlWVXU39nmPFa?=
 =?us-ascii?Q?2CcJ7HiGrWn/ExEZUz9+v/qpLWJj2mEAZwbRytA8s8lA4vRn7oxBXKwtL1xB?=
 =?us-ascii?Q?smGAljwHbzQQogMHb3+vBBFQeeoGbiuezULJMeRQkeVlsTtteihdbpG7jq/O?=
 =?us-ascii?Q?tSaL3J6RTaDd6fsntly+K54Igcz+ia5eJy9C4iBEdtxE7uOEUr1hkmAkyH9U?=
 =?us-ascii?Q?q2Ag3N1cgqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r45KEwGVvi1egnDNkWTzmCZ0Dq3RfYHlV9fz3IMCmCE+tjCO1/SRF+yW+Yf+?=
 =?us-ascii?Q?sU9C3Fd1wfn/vBpIDkVCzhkmIGkO49J+N6mgsjrye7e06+izDoLlaFFHVXGS?=
 =?us-ascii?Q?WJ7eMG9Q+RPa1U7Pq9FAhf+mzu02y5L5VMMqPxu1llfbLijAPzQVnVRv1lys?=
 =?us-ascii?Q?2shyonsFRvQ1NmX2OgWU6QYGoymV96VWZGjNX27xTyGUYCOTXnTYFBXVb3CR?=
 =?us-ascii?Q?/FzV3QNn5DIhouVPs/q1sB9nWLUlK6CrFd3itd3lwnW95HJOAt5ANZOPIEb6?=
 =?us-ascii?Q?qgnzCRVLzsvWhVj9n3OgK86HO7p/tOycorKw+0svgBOhJiyPqDpik/q48ZQ/?=
 =?us-ascii?Q?H1cjguNRb/J0RtNYI9i1LGerUTPXjxXkEEGzXIkF8B2LYecxB4Yo0bcwfMrA?=
 =?us-ascii?Q?7SKCceqVtOBWm6wjOA0YYs8lIowhPs78sVJcss8pM9TwbEEs4foE9HjKfFs0?=
 =?us-ascii?Q?giJuVxezPIzlD9ZLJvmy2pgR7rxNwD4vp0BWLhAkJygx0bqxA7edaY+l0MFE?=
 =?us-ascii?Q?S3H1K9uRr5fT4fjHVKa7a4SVkDVUXxfTwvk0EWQgPJlG1DL9JtgBDjHkE+vm?=
 =?us-ascii?Q?CAnJUkAstvYUpKD/xbMo7Zm1luGWdfgrOJt+kjP6s1Z21i5IAVpXnd6JyJMK?=
 =?us-ascii?Q?suRxYcwZwUyqjAqoPl8kFphfotD2NNa+3DU42kOU7a0muEjvUbTYN/jTittf?=
 =?us-ascii?Q?5gQyZ5SN3P8KhyVnYvbnX5pjcQB5e/mZiXyRUhfylKFhprJvSH7PawEFbU88?=
 =?us-ascii?Q?kbIv8XXpcPvEMiVEYM2vuxyn3y2LYnOwNY7m08gjqAUjR8ftDpp3Qg1hWQZO?=
 =?us-ascii?Q?AfwbZ6ToLJArYQEKPr4VjIQ/8KM6LwiPhnYk4iEitCNDKE6qOB4yM3ZAVmsz?=
 =?us-ascii?Q?c9cZnsDM632zftROOtJRgYFv9Q5bvREee6MIZ01e7JUlSpMf4WjT3TIllWYM?=
 =?us-ascii?Q?SxFCIncKT8fJAUbQhjwBlyEXrLW4bbMQlCSCXTrIr1S9bO09sqBCtHZUd4fT?=
 =?us-ascii?Q?GsjKMYG65gqyt86BUjLqB9eVeSUlw44FK2hZcUxfdDoh0tR3Tpn9Gqd2EWXL?=
 =?us-ascii?Q?cPR+zMf0KQ7n5AWynaWyZeKrb5ylqSzkG8tnvZMvKl6OjCl65y73BQ/YlOwp?=
 =?us-ascii?Q?XYJFvzJXYS5Gi1LT8VIC94zybgxXB5NLx4TUiZ0K8VmZI6nmQtpwX7qnt/0Y?=
 =?us-ascii?Q?lXCCkXbgT+w9PZZqTiBjVG8QMUFn4HGhmWAfJTKYgGRab86PtrcohDzMshXk?=
 =?us-ascii?Q?DAfhQlh2m21ebf9OBhSj9NnEqaAAk4UwvmWzXrJonR17O3zzb1ZUynJFiVJ0?=
 =?us-ascii?Q?XfA2Qhx7hFLIwhoOVym5cgIpUFRx0RsGF9Q8DzIDrNUnNVrwXxM8fbO6ybL0?=
 =?us-ascii?Q?PVW7gANQTIAO/M6eL0g/ZQWFnKRL8TQMT7fNYuG6Tq6T4fgeDFmDdvZSnSST?=
 =?us-ascii?Q?iQ+gvV5kO/kmZR9xiZNTWgGyj8hqGLEhFcxVZZZgu5vNVDOpKveYmpos60LF?=
 =?us-ascii?Q?aMhtFMtj9zHCfaRJRLg+ZskpO1uIxBmkpWUB9jEqwFGlAiUggtRtThI0vlqB?=
 =?us-ascii?Q?j3CQz9HWTaLUk2akv3MQkIuKEY7Vy5tdr4IOoCUS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c9a2ec-00b6-4829-04f8-08dc9a736ef7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:46:15.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQlY2azfKDb1kg7oQIMdIERcJVFFW+6CsslydbbvgCpB/EyythP7qZTREJ9qZsJ2abYPA7x8j4htXKNs8EJ+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790

If memcg enables pmc, it will cache some pages. However, if all
processes in memcg exit and there are some remaining pages in the cache,
those pages will not be used unless memcg is deleted.

To avoid this situation, a periodic reaping job has been added to each
memcg when pmc enabled, which will reclaim all the cached memory in the
memcg at regular intervals(default 5s).

User also can change reaper interval time like below:
  echo keys=reaper_time=8000000 > memory.cache
This memcg will reaper cache each 8s(type unit is us)

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/mmzone.h |  6 ++++
 mm/memcontrol.c        | 77 ++++++++++++++++++++++++++++++++++++++----
 mm/page_alloc.c        |  1 +
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 773b89e214c9..b56dd462232b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -608,6 +608,7 @@ struct mem_cgroup_zone_cache {
 	struct list_head pages;
 	spinlock_t pages_lock;
 	atomic_t nr_pages;
+	atomic_t nr_reapered;
 	atomic_t nr_alloced;
 };
 
@@ -616,6 +617,11 @@ struct mem_cgroup_per_node_cache {
 	struct mem_cgroup_zone_cache zone_cachep[MAX_NR_ZONES];
 	struct mem_cgroup *memcg;
 
+	/* cycle cache reclaim time unit, us, default 5s, 0 means disable reaper */
+#define DEFAULT_PMC_REAPER_TIME ((5 * 1000 * 1000))
+	unsigned int reaper_wait;
+	struct delayed_work reaper_work;
+
 	/* max number to hold page, unit page, default 100MB */
 #define DEFAULT_PMC_HOLD_LIMIX ((100 << 20) >> PAGE_SHIFT)
 	unsigned int hold_limit;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9db5bbe63b34..ae6917de91cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7101,6 +7101,39 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+/**
+ * This function use to reaper all cache pages by cycling scan.
+ * The scan interval time depends on @reaper_wait which can set by `keys` nest
+ * key.
+ * Default, each memcg which enabled cache will be reapered every 5s.
+ */
+static void pmc_reaper(struct work_struct *worker)
+{
+	struct mem_cgroup_per_node_cache *node_cachep = container_of(
+		to_delayed_work(worker), struct mem_cgroup_per_node_cache,
+		reaper_work);
+	struct mem_cgroup *memcg;
+	int num;
+
+	if (!READ_ONCE(node_cachep->reaper_wait))
+		return;
+
+	memcg = node_cachep->memcg;
+	rcu_read_lock();
+	if (!css_tryget(&memcg->css)) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_read_unlock();
+
+	num = mem_cgroup_release_cache(node_cachep);
+
+	css_put(&memcg->css);
+
+	schedule_delayed_work(&node_cachep->reaper_work,
+			      usecs_to_jiffies(node_cachep->reaper_wait));
+}
+
 static int __enable_mem_cgroup_cache(struct mem_cgroup *memcg)
 {
 	int nid, idx;
@@ -7141,8 +7174,13 @@ static int __enable_mem_cgroup_cache(struct mem_cgroup *memcg)
 		p->memcg = memcg;
 		p->hold_limit = DEFAULT_PMC_HOLD_LIMIX;
 		p->allow_watermark = DEFAULT_PMC_GAP_WATERMARK;
+		p->reaper_wait = DEFAULT_PMC_REAPER_TIME;
 
 		atomic_inc(&pmc_nr_enabled);
+
+		INIT_DELAYED_WORK(&p->reaper_work, pmc_reaper);
+		schedule_delayed_work(&p->reaper_work,
+				      usecs_to_jiffies(p->reaper_wait));
 	}
 
 	if (static_branch_likely(&pmc_key))
@@ -7184,6 +7222,7 @@ static int __disable_mem_cgroup_cache(struct mem_cgroup *memcg)
 
 		p = nodeinfo->cachep;
 
+		cancel_delayed_work_sync(&p->reaper_work);
 		mem_cgroup_release_cache(p);
 
 		kfree(p);
@@ -7207,7 +7246,8 @@ static int mem_cgroup_cache_show(struct seq_file *m, void *v)
 	if (!READ_ONCE(memcg->cache_enabled))
 		return -EINVAL;
 
-	seq_printf(m, "%4s %16s %16s\n", "NODE", "WATERMARK", "HOLD_LIMIT");
+	seq_printf(m, "%4s %16s %16s %16s\n", "NODE", "WATERMARK",
+		   "HOLD_LIMIT", "REAPER_TIME");
 	for_each_online_node(nid) {
 		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
 		struct mem_cgroup_per_node_cache *p;
@@ -7216,13 +7256,15 @@ static int mem_cgroup_cache_show(struct seq_file *m, void *v)
 		if (!p)
 			continue;
 
-		seq_printf(m, "%4d %14uKB %14uKB\n", nid,
+		seq_printf(m, "%4d %14uKB %14uKB %16u\n", nid,
 			   (READ_ONCE(p->allow_watermark) << (PAGE_SHIFT - 10)),
-			   (READ_ONCE(p->hold_limit) << (PAGE_SHIFT - 10)));
+			   (READ_ONCE(p->hold_limit) << (PAGE_SHIFT - 10)),
+			   READ_ONCE(p->reaper_wait));
 	}
 
 	seq_puts(m, "===========\n");
-	seq_printf(m, "%4s %16s %16s %16s\n", "NODE", "ZONE", "CACHE", "HIT");
+	seq_printf(m, "%4s %16s %16s %16s %16s\n", "NODE", "ZONE", "CACHE",
+		   "REAPER", "HIT");
 
 	for_each_online_node(nid) {
 		struct mem_cgroup_per_node *nodeinfo = memcg->nodeinfo[nid];
@@ -7242,9 +7284,12 @@ static int mem_cgroup_cache_show(struct seq_file *m, void *v)
 				continue;
 
 			zc = &p->zone_cachep[idx];
-			seq_printf(m, "%4d %16s %14dKB %14dKB\n", nid, z->name,
+			seq_printf(m, "%4d %16s %14dKB %14dKB %14dKB\n", nid,
+				   z->name,
 				   (atomic_read(&zc->nr_pages)
 				    << (PAGE_SHIFT - 10)),
+				   (atomic_read(&zc->nr_reapered)
+				    << (PAGE_SHIFT - 10)),
 				   (atomic_read(&zc->nr_alloced)
 				    << (PAGE_SHIFT - 10)));
 		}
@@ -7257,6 +7302,7 @@ static int mem_cgroup_cache_show(struct seq_file *m, void *v)
 enum {
 	OPT_KEY_NID,
 	OPT_KEY_WATERMARK,
+	OPT_KEY_REAPER_TIME,
 	OPT_KEY_HOLD_LIMIT,
 	OPT_KEY_ERR,
 	NR_PMC_KEY_OPTS = OPT_KEY_ERR
@@ -7265,6 +7311,7 @@ enum {
 static const match_table_t fc_tokens = {
 	{ OPT_KEY_NID, "nid=%d" },
 	{ OPT_KEY_WATERMARK, "watermark=%u" },
+	{ OPT_KEY_REAPER_TIME, "reaper_time=%u" },
 	{ OPT_KEY_HOLD_LIMIT, "limit=%u" },
 	{ OPT_KEY_ERR, NULL}
 };
@@ -7282,6 +7329,12 @@ __apply_status_for_mem_cgroup_cache(struct mem_cgroup_per_node_cache *p,
 			    STATUS_UNSET_DEFAULT_VALUE)
 				p->allow_watermark = opts[OPT_KEY_WATERMARK];
 			break;
+		case OPT_KEY_REAPER_TIME:
+			if (opts[OPT_KEY_REAPER_TIME] !=
+			    STATUS_UNSET_DEFAULT_VALUE)
+				WRITE_ONCE(p->reaper_wait,
+					   opts[OPT_KEY_REAPER_TIME]);
+			break;
 		case OPT_KEY_HOLD_LIMIT:
 			if (opts[OPT_KEY_HOLD_LIMIT] !=
 			    STATUS_UNSET_DEFAULT_VALUE)
@@ -7319,7 +7372,7 @@ mem_cgroup_apply_cache_status(struct mem_cgroup *memcg,
 }
 
 /**
- * Support nid=x,watermark=bytes,limit=bytes args
+ * Support nid=x,watermark=bytes,limit=bytes,reaper=us args
  */
 static int __mem_cgroup_cache_control_key(char *buf,
 					      struct mem_cgroup *memcg)
@@ -7361,6 +7414,14 @@ static int __mem_cgroup_cache_control_key(char *buf,
 				return -EINVAL;
 			opts[OPT_KEY_WATERMARK] = v;
 			break;
+		case OPT_KEY_REAPER_TIME:
+			if (match_uint(&args[0], &v))
+				return -EINVAL;
+#define MAX_REAPER_TIME ((10 * 1000 * 1000))
+			if (v > MAX_REAPER_TIME)
+				return -EINVAL;
+			opts[OPT_KEY_REAPER_TIME] = v;
+			break;
 		case OPT_KEY_HOLD_LIMIT:
 			if (match_uint(&args[0], &v))
 				return -EINVAL;
@@ -7402,7 +7463,9 @@ static const match_table_t ctrl_tokens = {
  *   1. nid=x, if input, will only change target NODE's cache status. Else, all.
  *   2. watermark=bytes, change cache hold behavior, only zone free pages above
  *      high watermark+watermark, can hold.
- *   3. limit=bytes, change max pages can cache. Max can change to 500MB
+ *   3. reaper_time=us, change reaper time, default is 10s. Set 0 can disable,
+ *      max can change to 10s
+ *   4. limit=bytes, change max pages can cache. Max can change to 500MB
  * Enable and keys can both input, split by space, so can set args after enable,
  * if cache not enable, can't set keys.
  */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54c4d00c2506..1fe02f4f3b33 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1310,6 +1310,7 @@ int mem_cgroup_release_cache(struct mem_cgroup_per_node_cache *nodep)
 		}
 
 		num += i;
+		atomic_add(i, &zc->nr_reapered);
 		atomic_sub(i, &zc->nr_pages);
 	}
 
-- 
2.45.2


