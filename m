Return-Path: <cgroups+bounces-4330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00754954CB6
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C311F22288
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E71BE85D;
	Fri, 16 Aug 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="JjTQLGGi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C21BDAAE
	for <cgroups@vger.kernel.org>; Fri, 16 Aug 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819468; cv=none; b=FbTWW7Ah4tXz2OxktqousGXrYQNOdKu2s5yOUV/RMsNj9ekrwgGqzxDpUoIW1MQNxElBzEUYr68fO0e9GwlOsgq8+Nf9aEioBmpusGSYjGw+AoFxrv/LWz193/iyNvC0+qxpIEDiOtTuJZcI3EFQ99gr+hspoesgYQv5dLNFLtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819468; c=relaxed/simple;
	bh=Gc1o9cTUJaR+h1yUcosk0h+kJQ8Gs/QU31qzG4T87Rw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0kP9w5NdQHsTXGzS7YCuSqAqOE5VCyF8+qDGDd3oFlWOmPyLgyTisaPYhDDRWmPdBB8aZ6V3i0u9iDcIw0Puet/+otFzoiPnIyoyi6HCqHp1yubEgLk1l29bBcjlNbUQ0+RyTV/OLYzUM/8R/hgtFaztDhmxpEKszDQx/1A/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=JjTQLGGi; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1723819464; x=1724078664;
	bh=Gc1o9cTUJaR+h1yUcosk0h+kJQ8Gs/QU31qzG4T87Rw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JjTQLGGikdm9o1KJKl5Wy2RXkAkVAlk2WRhuTLS+tj2GTKMACiDWbyLVz+xj5DUeF
	 yt7pXmuEFlIYlNMzMEg+cGwYiWqMA5qAVlTITTF0XKbIQ5bKA536tY8eJOBysCVcOX
	 iN5TQTWzMmSQgFJToxGs+tVNbJ08ko0Y4HgUhpcj+UMfQm9nQS22iX+BCZH5wp4eMk
	 wIX232jFNlAit5iD1RqUbaV/x3J/sHvB3eCWXkh3NMFfWfkgRXfoTB/2t3P8WKlZ1w
	 Yq2ALMWShSWVJdsLoOgTvMveUsPrV5ghncW41HIkScRxSTa9hu+b4iqTc4Lt6SmpHN
	 awwDbuBpyTBzg==
Date: Fri, 16 Aug 2024 14:44:19 +0000
To: linux-kernel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v2 2/2] selftests: test_zswap: add test for hierarchical zswap.writeback
Message-ID: <20240816144344.18135-2-me@yhndnzj.com>
In-Reply-To: <20240816144344.18135-1-me@yhndnzj.com>
References: <20240816144344.18135-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 98424e4be63cbb1cd3dc1512fd5d74a155ca5d44
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ensure that zswap.writeback check goes up the cgroup tree.

Signed-off-by: Mike Yuan <me@yhndnzj.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 69 ++++++++++++++-------
 1 file changed, 48 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/se=
lftests/cgroup/test_zswap.c
index 190096017f80..7da6f9dc1066 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -263,15 +263,13 @@ static int test_zswapin(const char *root)
 static int attempt_writeback(const char *cgroup, void *arg)
 {
 =09long pagesize =3D sysconf(_SC_PAGESIZE);
-=09char *test_group =3D arg;
 =09size_t memsize =3D MB(4);
 =09char buf[pagesize];
 =09long zswap_usage;
-=09bool wb_enabled;
+=09bool wb_enabled =3D *(bool *) arg;
 =09int ret =3D -1;
 =09char *mem;
=20
-=09wb_enabled =3D cg_read_long(test_group, "memory.zswap.writeback");
 =09mem =3D (char *)malloc(memsize);
 =09if (!mem)
 =09=09return ret;
@@ -288,12 +286,12 @@ static int attempt_writeback(const char *cgroup, void=
 *arg)
 =09=09memcpy(&mem[i], buf, pagesize);
=20
 =09/* Try and reclaim allocated memory */
-=09if (cg_write_numeric(test_group, "memory.reclaim", memsize)) {
+=09if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
 =09=09ksft_print_msg("Failed to reclaim all of the requested memory\n");
 =09=09goto out;
 =09}
=20
-=09zswap_usage =3D cg_read_long(test_group, "memory.zswap.current");
+=09zswap_usage =3D cg_read_long(cgroup, "memory.zswap.current");
=20
 =09/* zswpin */
 =09for (int i =3D 0; i < memsize; i +=3D pagesize) {
@@ -303,7 +301,7 @@ static int attempt_writeback(const char *cgroup, void *=
arg)
 =09=09}
 =09}
=20
-=09if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/2))
+=09if (cg_write_numeric(cgroup, "memory.zswap.max", zswap_usage/2))
 =09=09goto out;
=20
 =09/*
@@ -312,7 +310,7 @@ static int attempt_writeback(const char *cgroup, void *=
arg)
 =09 * If writeback is disabled, memory reclaim will fail as zswap is limit=
ed and
 =09 * it can't writeback to swap.
 =09 */
-=09ret =3D cg_write_numeric(test_group, "memory.reclaim", memsize);
+=09ret =3D cg_write_numeric(cgroup, "memory.reclaim", memsize);
 =09if (!wb_enabled)
 =09=09ret =3D (ret =3D=3D -EAGAIN) ? 0 : -1;
=20
@@ -321,12 +319,38 @@ static int attempt_writeback(const char *cgroup, void=
 *arg)
 =09return ret;
 }
=20
+static int test_zswap_writeback_one(const char *cgroup, bool wb)
+{
+=09long zswpwb_before, zswpwb_after;
+
+=09zswpwb_before =3D get_cg_wb_count(cgroup);
+=09if (zswpwb_before !=3D 0) {
+=09=09ksft_print_msg("zswpwb_before =3D %ld instead of 0\n", zswpwb_before=
);
+=09=09return -1;
+=09}
+
+=09if (cg_run(cgroup, attempt_writeback, (void *) &wb))
+=09=09return -1;
+
+=09/* Verify that zswap writeback occurred only if writeback was enabled *=
/
+=09zswpwb_after =3D get_cg_wb_count(cgroup);
+=09if (zswpwb_after < 0)
+=09=09return -1;
+
+=09if (wb !=3D !!zswpwb_after) {
+=09=09ksft_print_msg("zswpwb_after is %ld while wb is %s",
+=09=09=09=09zswpwb_after, wb ? "enabled" : "disabled");
+=09=09return -1;
+=09}
+
+=09return 0;
+}
+
 /* Test to verify the zswap writeback path */
 static int test_zswap_writeback(const char *root, bool wb)
 {
-=09long zswpwb_before, zswpwb_after;
 =09int ret =3D KSFT_FAIL;
-=09char *test_group;
+=09char *test_group, *test_group_child =3D NULL;
=20
 =09test_group =3D cg_name(root, "zswap_writeback_test");
 =09if (!test_group)
@@ -336,29 +360,32 @@ static int test_zswap_writeback(const char *root, boo=
l wb)
 =09if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
 =09=09goto out;
=20
-=09zswpwb_before =3D get_cg_wb_count(test_group);
-=09if (zswpwb_before !=3D 0) {
-=09=09ksft_print_msg("zswpwb_before =3D %ld instead of 0\n", zswpwb_before=
);
+=09if (test_zswap_writeback_one(test_group, wb))
 =09=09goto out;
-=09}
=20
-=09if (cg_run(test_group, attempt_writeback, (void *) test_group))
+=09if (cg_write(test_group, "memory.zswap.max", "max"))
+=09=09goto out;
+=09if (cg_write(test_group, "cgroup.subtree_control", "+memory"))
 =09=09goto out;
=20
-=09/* Verify that zswap writeback occurred only if writeback was enabled *=
/
-=09zswpwb_after =3D get_cg_wb_count(test_group);
-=09if (zswpwb_after < 0)
+=09test_group_child =3D cg_name(test_group, "zswap_writeback_test_child");
+=09if (!test_group_child)
+=09=09goto out;
+=09if (cg_create(test_group_child))
+=09=09goto out;
+=09if (cg_write(test_group_child, "memory.zswap.writeback", "1"))
 =09=09goto out;
=20
-=09if (wb !=3D !!zswpwb_after) {
-=09=09ksft_print_msg("zswpwb_after is %ld while wb is %s",
-=09=09=09=09zswpwb_after, wb ? "enabled" : "disabled");
+=09if (test_zswap_writeback_one(test_group_child, wb))
 =09=09goto out;
-=09}
=20
 =09ret =3D KSFT_PASS;
=20
 out:
+=09if (test_group_child) {
+=09=09cg_destroy(test_group_child);
+=09=09free(test_group_child);
+=09}
 =09cg_destroy(test_group);
 =09free(test_group);
 =09return ret;
--=20
2.46.0



