Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE843CC29E
	for <lists+cgroups@lfdr.de>; Sat, 17 Jul 2021 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhGQKXP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 17 Jul 2021 06:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhGQKXO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 17 Jul 2021 06:23:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3BBC06175F
        for <cgroups@vger.kernel.org>; Sat, 17 Jul 2021 03:20:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y4so12582191pgl.10
        for <cgroups@vger.kernel.org>; Sat, 17 Jul 2021 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+StolKAcDufVlmzojkSC3TjMvCFftVBsdtQJ52EleJY=;
        b=Jns2zr2mXKa/1SI1vWueB4vMVJ2ot3Vw405+C5xjcQU4KrIEF5mq7ltcWCbKzf5UdS
         aXFUOSLIdbtzDS41F64DGUbAl2t8cXIfxRUTGCsALub42QITeLC1d9mYPli6gMakRYC2
         ynKij2pzLRF+9ckXst5vlg9aasuqT1f9dhvTKSSTS9ssKvZ34W3g3vdgJWO9OjZe8tFG
         MW5TAEOY+O1eHxeB0d1HXSWe1jYoIs/3fqkWYabv4lriA9HWEGKxh6KHfhj+TwppX0zi
         MSaarbS23cUIAjyYtxrK4RLHfHNX9AJ8k+wda1fEJQjXIUpXVN4QYFqAVhyoylaMjc1W
         472Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+StolKAcDufVlmzojkSC3TjMvCFftVBsdtQJ52EleJY=;
        b=Xao0LKib/2kxQ5zj9IFeTtinCAnC2dso3yzFzRzRpG+dm0kj0DGv6hIMwsaTrV4s/W
         8/m1reEf1SXAjWJPJflB639NqJHgDxbD1F6WdSTd1oXhwHBi9RHkL9gLFohlYcf8VNot
         P6rLvZjwtiJPEe5HZghleIyJheFkxcsiG1ROTvdY3ldsI7Tkdd6jJgc1MhEQE9DPpIMp
         98hgjlG98TuFlTp0aFcIuKgD3yxcjqhLqbr7wiU9RxJf6my0GqBYtD4sRZZfr7zglelx
         +eVZ6cxSmxQcOLAM1lnmoe8+MupGzIqCbqDCoU56lkcqmJlO3xyKsWx7DK8QYgKgTfL/
         O2eA==
X-Gm-Message-State: AOAM530PEn4rPmQ4eguGXTbSSPo6NBulm8IzHYKy5pbqwO/ju+CIPgd5
        Qdy4FGBGWBcIPHZopXLfcTMRpSyppvl00+/sbzs=
X-Google-Smtp-Source: ABdhPJyhB4vIYsRTlhbL+Sw67vvnSkTnHDK8xLi59hoMQnYOk5viSUPvn/lTX5e49o7VuFsiEt7N5Q==
X-Received: by 2002:a63:5144:: with SMTP id r4mr14462549pgl.223.1626517216587;
        Sat, 17 Jul 2021 03:20:16 -0700 (PDT)
Received: from honest-machine-1.localdomain.localdomain (80.251.213.191.16clouds.com. [80.251.213.191])
        by smtp.gmail.com with ESMTPSA id u16sm14638454pgh.53.2021.07.17.03.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 03:20:16 -0700 (PDT)
From:   Yutian Yang <nglaive@gmail.com>
To:     mhocko@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Yutian Yang <nglaive@gmail.com>
Subject: [PATCH] memcg: charge fs_context and legacy_fs_context
Date:   Sat, 17 Jul 2021 06:20:01 -0400
Message-Id: <1626517201-24086-1-git-send-email-nglaive@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch adds accounting flags to fs_context and legacy_fs_context 
allocation sites so that kernel could correctly charge these objects.

We have written a PoC to demonstrate the effect of the missing-charging
bugs. The PoC takes around 1,200MB unaccounted memory, while it is charged
for only 362MB memory usage. We evaluate the PoC on QEMU x86_64 v5.2.90
+ Linux kernel v5.10.19 + Debian buster. All the limitations including
ulimits and sysctl variables are set as default. Specifically, the hard 
NOFILE limit and nr_open in sysctl are both 1,048,576.

/*------------------------- POC code ----------------------------*/

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/file.h>
#include <time.h>
#include <sys/wait.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <sched.h>
#include <fcntl.h>
#include <linux/mount.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

#define STACK_SIZE (8 * 1024)
#ifndef __NR_fsopen
#define __NR_fsopen 430
#endif
static inline int fsopen(const char *fs_name, unsigned int flags)
{
        return syscall(__NR_fsopen, fs_name, flags);
}

static char thread_stack[512][STACK_SIZE];

int thread_fn(void* arg)
{
  for (int i = 0; i< 800000; ++i) {
    int fsfd = fsopen("nfs", FSOPEN_CLOEXEC);
    if (fsfd == -1) {
      errExit("fsopen");
    }
  }
  while(1);
  return 0;
}

int main(int argc, char *argv[]) {
  int thread_pid;
  for (int i = 0; i < 1; ++i) {
    thread_pid = clone(thread_fn, thread_stack[i] + STACK_SIZE, \
      SIGCHLD, NULL);
  }
  while(1);
  return 0;
}

/*-------------------------- end --------------------------------*/


Thanks!
Yutian Yang,
Zhejiang University


Signed-off-by: Yutian Yang <nglaive@gmail.com>
---
 fs/fs_context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 2834d1afa..4858645ca 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -231,7 +231,7 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 	struct fs_context *fc;
 	int ret = -ENOMEM;
 
-	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
+	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
 	if (!fc)
 		return ERR_PTR(-ENOMEM);
 
@@ -631,7 +631,7 @@ const struct fs_context_operations legacy_fs_context_ops = {
  */
 static int legacy_init_fs_context(struct fs_context *fc)
 {
-	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
+	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL_ACCOUNT);
 	if (!fc->fs_private)
 		return -ENOMEM;
 	fc->ops = &legacy_fs_context_ops;
-- 
2.25.1

