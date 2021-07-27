Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B113D71F0
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhG0J02 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 05:26:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:37346 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236140AbhG0J0Y (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 05:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=aA4OKvIJX54mPh9QQGvJAgE1NSRLlK28/A5Ft+jS4wk=; b=jEfB9MJFSdPNiqdCXAZ
        3Z62IS2ffQzJuMY15RKM/nZj2NYL3YFhbyT+VsHbbsPTdRe+NwSfHQGgrtyYhaB99zj3vqsE9f1If
        Spm8IT/7BVz3qp2ClvJzlF10US7VmxGpWgxtKo3esF27NAaRlPfO6ZBAwV4PiZMazGttnQltqCg=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8JLo-005MwK-TY; Tue, 27 Jul 2021 12:26:12 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH TTY] memcg: drop GFP_KERNEL_ACCOUNT use in tty_save_termios()
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d42bd2a3-74a0-163f-6e3a-ad702f6d2817@virtuozzo.com>
Message-ID: <afbaec7c-1872-d43a-1240-e077adc0d6d9@virtuozzo.com>
Date:   Tue, 27 Jul 2021 12:26:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d42bd2a3-74a0-163f-6e3a-ad702f6d2817@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Jiri Slaby pointed that termios are not saved for PTYs and for other
terminals used inside containers. Therefore accounting for saved
termios have near to zero impact in real life scenarios.

Cc: Jiri Slaby <jirislaby@kernel.org>
Fixes: 854dd8a572a0 ("memcg: enable accounting for tty-related objects")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e787f6f..a6230b2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1493,7 +1493,7 @@ void tty_save_termios(struct tty_struct *tty)
 	/* Stash the termios data */
 	tp = tty->driver->termios[idx];
 	if (tp == NULL) {
-		tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);
+		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
 		if (tp == NULL)
 			return;
 		tty->driver->termios[idx] = tp;
-- 
1.8.3.1

