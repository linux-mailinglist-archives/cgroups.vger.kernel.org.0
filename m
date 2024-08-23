Return-Path: <cgroups+bounces-4429-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E595D34B
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB89A281FBA
	for <lists+cgroups@lfdr.de>; Fri, 23 Aug 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03618BC02;
	Fri, 23 Aug 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="FJCEeAV/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610018A6DD;
	Fri, 23 Aug 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430443; cv=none; b=U50dmFJaxEEKODk1OewvQLc8b4bas2FS38/Cn4rNr2DB+cu+rNJTTWo0Ac6dPjyNVRmdWo+bwrppFpaeJd/34ngtxWl+7Q54MUqjyqelXiqt5umZEBr2GxfTe+dnYgzIvVjDFNeIoFArKuvs77khrMj39G5EoDL8lY6a8AsTudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430443; c=relaxed/simple;
	bh=UZRVPr9cRDGbKrKHVfX/ZAxRQOUzaQ6IaTzBeM5P0wo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyQthLooW0CqQtXdDA1pArKnbPk+z/tgoMj6Lwg9dbJWSOPtDRzsfmMybOYZk6Emis1mwK2cwg5l2xn/nXCFVkiF6DqyuEa76HF3eCACBwRO7jfIYG40gIFWeJNjmYUxtzHJqFGBQ7eCT0YvpKqNfngFBTqLiFlmg5QQ26+LuKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=FJCEeAV/; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1724430433; x=1724689633;
	bh=pPXe71q6zQu0gR03S4i42QC6rYTNhfx/AM5wdnFWiQA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FJCEeAV/aa+vtVuUy1WGdECUAyqfATK7G2xjTJX0LpFlfr4g88ffgiVBfgvOlQ/Cq
	 YjZGWPHpkgqxfdzFx3zMy4FEcROwykDQm6cf93oklMGIjN2DshieH126wQUK0qUKYL
	 Z/ZRIeXAcKRikpnJ1onggF+6VVeis2kz1jiwyA8A13VW2WC6U9w7HCvqE7GxpbJ872
	 eA5xqJKaN8+uX8Dx0ka8wXgV7FPgy3HeGDvRAbQvNy9nEoPIfZ0U6QTIABzfDmQXNm
	 Z1pi5U6GtrdsqORxW1cCiLrOWMkUHV6ptKT/M5IdXaOgRP8boKV3hKlWRRcA8spke7
	 mUzpcZ1zjSFuw==
Date: Fri, 23 Aug 2024 16:27:09 +0000
To: linux-kernel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v3 2/3] selftests: test_zswap: add test for hierarchical zswap.writeback
Message-ID: <20240823162506.12117-2-me@yhndnzj.com>
In-Reply-To: <20240823162506.12117-1-me@yhndnzj.com>
References: <20240823162506.12117-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 253c4c7b771f5dea02d28fcf54ec72ae63c6395f
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ensure that zswap.writeback check goes up the cgroup tree, i.e.
is hierarchical. Create a subcgroup which has zswap.writeback
set to 1, and the upper hierarchy's restrictions shall apply.

Changes in v3:
- Skip the zswap.writeback test if root cgroup has it disabled
  (I still think adding a whole new test is a bit of overkill,
  though, instead came up with this alternative approach)
- Add comment about hardcoding child cg's zswap.writeback=3D1
  which might not be obvious
Link to v2: https://lore.kernel.org/all/20240816144344.18135-2-me@yhndnzj.c=
om/

Signed-off-by: Mike Yuan <me@yhndnzj.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 75 +++++++++++++++------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/se=
lftests/cgroup/test_zswap.c
index 190096017f80..40de679248b8 100644
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
@@ -321,12 +319,41 @@ static int attempt_writeback(const char *cgroup, void=
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
+
+=09if (cg_read_strcmp(root, "memory.zswap.writeback", "1"))
+=09=09return KSFT_SKIP;
=20
 =09test_group =3D cg_name(root, "zswap_writeback_test");
 =09if (!test_group)
@@ -336,29 +363,35 @@ static int test_zswap_writeback(const char *root, boo=
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
+=09/* Reset memory.zswap.max to max (modified by attempt_writeback), and
+=09 * set up child cgroup, whose memory.zswap.writeback is hardcoded to 1.
+=09 * Thus, the parent's setting shall be what's in effect. */
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



