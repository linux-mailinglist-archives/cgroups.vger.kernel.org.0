Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2054BC3726
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2019 16:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfJAOWv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Oct 2019 10:22:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbfJAOWv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Oct 2019 10:22:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MtfeD-1i0GXA0Ilb-00v9b6; Tue, 01 Oct 2019 16:22:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Qian Cai <cai@lca.pw>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] mm/memcontrol.c: fix another unused function warning
Date:   Tue,  1 Oct 2019 16:22:12 +0200
Message-Id: <20191001142227.1227176-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:figbJF5L6G0XEWx7vE37p+1HREP4pdaUF1hixuKWiSXi1WhSqjN
 1mFGZ1tTDFVzveitQ5dJm1AfeFw4+iQGprrZcQpcp3bgMfPAhxpWPB+9wFKeiUuUZZIh2io
 fKyAJSH7VFXtGs7nVJ2mRRs08ZUxBzWzQqfb+pARALNWlmIGBdxJ3hgENkjgKXJrT63booJ
 oF8KApMv5rp9nj27TuJow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cz+DaDPdK8A=:2nL8zO8obyUue8/B1m31Mw
 w7MDPepr2NIk/8jEqB17L8KReB0/sC8EuopUyWdwqJqlVcvp3IQxT2oKvNAJVDKUnviue6PeR
 wIcmeLA66NBBAU4oXNJhVez6AvFXLQ5pmYeEAr1ifiNfKKoNiU7quSbvLMSnWI4vHmEIn8EY8
 YWevjG+lYEUkz/gxRFFwQLNgF8cTE4qrsNGE7ZhE4GzS8Bqttluzugmj690TKdGNVNOPTVNOW
 wUOMhG58H6zDpFSVAXPrAjtUdf6LKC8aHbM2oZz0fCxNiD0UtxN15MbsAEX2/BnNGgzZDIZ5Z
 nFzqD+I/8uHKBRL6BGc540dfvuRUHxZaihiL3sC7pEDhnfPLqRAQhdagKAGVPy+dQr59WsDKI
 /U7PN60uf17KvbPNoh2oJxNUYZHDtYm9ClaXAmkLLtxS6H5Pq7+02FwhUQF8Bpcdc4unnK17I
 yjxptXPhtiFjgWbf7y6KGYFe0VgGsOTABwaetxrbxERmrNiuZmMrs68HaJhJNpJerd7TFFapt
 4S3LG3iz/3iK/Lvpxg8eSOSe3tfEu8HiqHFe+DKOLglC9DLB6JcAUtXvsDHlrF17J+sgDkQhc
 2qXBl2X+ugs/PMXMBsT1CoXL3Va/faJ77hBN4msDlp+BTP5ND57SWAqR66UxTtUeF9YcZqiu1
 9nAgc0uz6fFA4PEe23LNPB4p3mFah+U+Zi0gz8FUDrxlnIhcDkHC+nnPIHWbH5B8F6sSHYXXZ
 9mbOaXyAtbDR/icX0VfPaEESg1YMZNQ+e1zqPdMxSwDClUDfAgVg0VF2MjwtjcdZbsnh4/k6m
 jniImRYGrZzQZvT0JS/EtY/rVgs/bFaeuc73VNwLShU10MDLcsW/CUEUHfbHeQ+bbjPfsL8IQ
 ILrUXkj5IUCXuCgsn66Q==
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Removing the mem_cgroup_id_get() stub function introduced a new warning
of the same kind when CONFIG_MMU is disabled:

mm/memcontrol.c:4929:13: error: unused function 'mem_cgroup_id_get_many' [-Werror,-Wunused-function]

Address this using a __maybe_unused annotation.

Note: alternatively, this could be moved into an #ifdef block.  Marking it
'static inline' would not work here as that would still produce the
warning on clang, which only ignores unused inline functions declared
in header files instead of .c files.

Fixes: 4d0e3230a56a ("mm/memcontrol.c: fix a -Wunused-function warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c313c49074ca..5f9f90e3cef8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4921,7 +4921,8 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 	}
 }
 
-static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
+static void __maybe_unused
+mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	refcount_add(n, &memcg->id.ref);
 }
-- 
2.20.0

