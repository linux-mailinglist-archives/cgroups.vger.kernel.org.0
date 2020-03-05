Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A152217B013
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 21:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEUzf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 15:55:35 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:59937 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgCEUzf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 15:55:35 -0500
Received: by mail-pj1-f74.google.com with SMTP id z5so3425583pjq.9
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 12:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mljG1c45tyBHCNvH//AiEZZTlDTTk3P0kV7UDMwCvTs=;
        b=DiLLZ921cvStv9VpgT9chw1u+67yb+Jf1wZHKgKeRrtR6Vd+VVjzBFoE3075eabKkB
         vL9Q1THdoudDtlzUB2SlXnPecVbbuAg124mgQ8cq9H95q1YMiqQXbrNKd7dT2fAnUn3n
         dPRVeotMzxE6Byy9sl8GMe1jbOn5REl2Dx/4Jw3dbu3R5Z0VldYTbblzUPZ/nq/hvU5m
         UW41Z7wBfxhTTlXQkI1TtX3zZrz8D1ZvUtgjIr8/MH5OdVN/TMfeA6uQ38HLwN+syvBs
         NSC1Z9sBv8MySgOXqKr3+c5YO5Dh9yruYybkpx5dtHt7G3kaEndhLvrvjxgKLh+C3qkQ
         DSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mljG1c45tyBHCNvH//AiEZZTlDTTk3P0kV7UDMwCvTs=;
        b=VAbEJXQTIkywaM2xxCDVlyLkh1Xd8gIfI60831S5dzEnKk/6V+yxde+Z+26mJVaGKK
         GIpcwW1lgtPhh4npCGGPUi9tMLk120y6lfYqg1MNQevXzPV1eFar56abBUf89vzU01tt
         8hsiLwJH2eV+dZ3tUNmjJsDMWGxflhadh6UP9LHwzYrOpgCylylMRd6RjOyXhK9mO3rh
         sfPVlhken5xAsysehSizqc79x/DIJpW2VWiOOfMp7PMUV44Eo6RAfX7Y7edCQ2ab+oYQ
         AB0ZrELWsOkVTifFm2ceMpw5M12xhZ+2UkiW7u0RoIMlrNg8K433rf4JmocqDqVJOqXN
         /s8g==
X-Gm-Message-State: ANhLgQ36BtE73kffd1oETKAxxZPFXil+KRBZWvkkGtfgkC+7GXTN6Say
        WJ8NrLLzImnEEvqxiFLMI4YdTG7dWaHhjg==
X-Google-Smtp-Source: ADFU+vtVGz7DVOErF5e2OURgUg2ecxIgD7Eb6KdrmeesDbmcr0yLA+SUXXXVg19kGdyFzvBxzDpSLTmT/w31sA==
X-Received: by 2002:a63:74b:: with SMTP id 72mr19359pgh.320.1583441733885;
 Thu, 05 Mar 2020 12:55:33 -0800 (PST)
Date:   Thu,  5 Mar 2020 12:55:25 -0800
Message-Id: <20200305205525.245058-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3] net: memcg: late association of sock to memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a TCP socket is allocated in IRQ context or cloned from unassociated
(i.e. not associated to a memcg) in IRQ context then it will remain
unassociated for its whole life. Almost half of the TCPs created on the
system are created in IRQ context, so, memory used by such sockets will
not be accounted by the memcg.

This issue is more widespread in cgroup v1 where network memory
accounting is opt-in but it can happen in cgroup v2 if the source socket
for the cloning was created in root memcg.

To fix the issue, just do the late association of the unassociated
sockets at accept() time in the process context and then force charge
the memory buffer already reserved by the socket.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v2:
- Additional check for charging.
- Release the sock after charging.

Changes since v1:
- added sk->sk_rmem_alloc to initial charging.
- added synchronization to get memory usage and set sk_memcg race-free.

 net/ipv4/inet_connection_sock.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a4db79b1b643..5face55cf818 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -482,6 +482,26 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
+
+	if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
+		int amt;
+
+		/* atomically get the memory usage, set and charge the
+		 * sk->sk_memcg.
+		 */
+		lock_sock(newsk);
+
+		/* The sk has not been accepted yet, no need to look at
+		 * sk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(newsk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		mem_cgroup_sk_alloc(newsk);
+		if (newsk->sk_memcg && amt)
+			mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
+
+		release_sock(newsk);
+	}
 out:
 	release_sock(sk);
 	if (req)
-- 
2.25.0.265.gbab2e86ba0-goog

