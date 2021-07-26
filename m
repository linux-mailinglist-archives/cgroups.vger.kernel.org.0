Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C953D6728
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhGZSVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 14:21:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:55482 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhGZSVU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Jul 2021 14:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=fzoFoDaPrywkHjs/msWPtHPRzT9tQ7zWHa/Zk4Ahhwk=; b=E0d60kxWZKRomOGRI9M
        rsXEypCV6Lr4pFI9fwHEqT0+83v80Jz8pq/6+qEPa/zhQw/7uWVfvjWUZREuT2aVCO7hiNWGg2ywN
        35XrW9Yk1+Do+X/qd1KOcBj5mODHVwvqUwqlG/FkXcPWtY9ZmF9FZsljgKQNEQXQ5/cF4Tm0zjk=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m85rH-005JXP-Nn; Mon, 26 Jul 2021 22:01:47 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v6 15/16] memcg: enable accounting for tty-related objects
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <9bf9d9bd-03b1-2adb-17b4-5d59a86a9394@virtuozzo.com>
 <cover.1627321321.git.vvs@virtuozzo.com>
Message-ID: <15860ed1-2c2a-b667-da07-6e54029167eb@virtuozzo.com>
Date:   Mon, 26 Jul 2021 22:01:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627321321.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At each login the user forces the kernel to create a new terminal and
allocate up to ~1Kb memory for the tty-related structures.

By default it's allowed to create up to 4096 ptys with 1024 reserve for
initial mount namespace only and the settings are controlled by host admin.

Though this default is not enough for hosters with thousands
of containers per node. Host admin can be forced to increase it
up to NR_UNIX98_PTY_MAX = 1<<20.

By default container is restricted by pty mount_opt.max = 1024,
but admin inside container can change it via remount. As a result,
one container can consume almost all allowed ptys
and allocate up to 1Gb of unaccounted memory.

It is not enough per-se to trigger OOM on host, however anyway, it allows
to significantly exceed the assigned memcg limit and leads to troubles
on the over-committed node.

It makes sense to account for them to restrict the host's memory
consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 26debec..e787f6f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1493,7 +1493,7 @@ void tty_save_termios(struct tty_struct *tty)
 	/* Stash the termios data */
 	tp = tty->driver->termios[idx];
 	if (tp == NULL) {
-		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
+		tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);
 		if (tp == NULL)
 			return;
 		tty->driver->termios[idx] = tp;
@@ -3119,7 +3119,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
 
-	tty = kzalloc(sizeof(*tty), GFP_KERNEL);
+	tty = kzalloc(sizeof(*tty), GFP_KERNEL_ACCOUNT);
 	if (!tty)
 		return NULL;
 
-- 
1.8.3.1

