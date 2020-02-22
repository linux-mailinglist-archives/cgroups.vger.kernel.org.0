Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588E9168B67
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2020 02:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBVBFN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Feb 2020 20:05:13 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40136 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBVBFN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Feb 2020 20:05:13 -0500
Received: by mail-pg1-f202.google.com with SMTP id n7so2094450pgt.7
        for <cgroups@vger.kernel.org>; Fri, 21 Feb 2020 17:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/3yl8VhgDmjkXmLfWG6CmIalz2F0UKze8er/2PUvhvg=;
        b=Ymt8dFnWLKbA5tN9IDfmujvOxbWEG48HlhlzvroTZMjYPzSWjt8utQxlTL3bXJPDYx
         3+TiA/F/b9pYowmG3T3VbN/DGLEOC2bKTeD5ayJ2A5UsPgaDnjvvNH9PposF/IfzuLNU
         qPiH1MUNmwrRUgprTKTn+LoFP4wLI9l538CvuVVlgYb0B5bgOpORGGZ5hL6/+iBY5dTl
         GGDZy85UVPb6XXZEBAg8tDB2ikz64+InMXYMGnjlQIl+q5P81K6yA3IIrP0cxI7g2DiY
         45WmsE4Hy/XwAldUMG09+sOyAdKtSqw1bGbN4rfRiDpOgO3mSN3xbiRp9ddpm4e2Mq6M
         7rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/3yl8VhgDmjkXmLfWG6CmIalz2F0UKze8er/2PUvhvg=;
        b=FowwVRHOjhxC5O7LnHQDO34ZJ/nZBOJtvUnxUZ0MTx6cEqtvPerhBLmY+PcNzKv6sy
         efZubLC4gLwdPABPMONjyebIgu8rXMrwJ2SQiEQuduz1pR4Mzza3+tdZ8U1kxNNh++9Y
         aLtP1APN7g6iEm5taCr+fiD+fXazPCUf0kM5NMQWS4gNmRVjye2M9WM8HBRZwJWh2D+t
         Mpy7M8yRQ3dU2vV3ez1qcvsSyFXnqtAKf287e2QLYn8BchPA1pkKpJj9zPf4NIaNx0FG
         Vkic0/sEk6rTHGwfn1uactmMtT1wjR+LzbNZX2R8Ot1bTJV9MItC6GRv9ymWK4Dw8Azv
         Pa6Q==
X-Gm-Message-State: APjAAAVGMTt6RnZP2Glt44jvumGmu5QY6kmKS+FkFmSxc+52w9rxhY8S
        +62bCEl1J9WkpvvV0gtq5LqHABXxmNczSA==
X-Google-Smtp-Source: APXvYqySyYWuzpx0yLr88ZPOnTJL5Aj9ggpD223mgI5KwnpI3NXOrlQ8OJZIxV17ZZyymsTdktXl89KbgD69Wg==
X-Received: by 2002:a63:d710:: with SMTP id d16mr40563177pgg.393.1582333512913;
 Fri, 21 Feb 2020 17:05:12 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:04:56 -0800
Message-Id: <20200222010456.40635-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] net: memcg: late association of sock to memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev@vger.kernel.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If a TCP socket is allocated in IRQ context or cloned from unassociated
(i.e. not associated to a memcg) in IRQ context then it will remain
unassociated for its whole life. Almost half of the TCPs created on the
system are created in IRQ context, so, memory used by suck sockets will
not be accounted by the memcg.

This issue is more widespread in cgroup v1 where network memory
accounting is opt-in but it can happen in cgroup v2 if the source socket
for the cloning was created in root memcg.

To fix the issue, just do the late association of the unassociated
sockets at accept() time in the process context and then force charge
the memory buffer already reserved by the socket.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 net/ipv4/inet_connection_sock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a4db79b1b643..df9c8ef024a2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -482,6 +482,13 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
+
+	if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
+		mem_cgroup_sk_alloc(newsk);
+		if (newsk->sk_memcg)
+			mem_cgroup_charge_skmem(newsk->sk_memcg,
+					sk_mem_pages(newsk->sk_forward_alloc));
+	}
 out:
 	release_sock(sk);
 	if (req)
-- 
2.25.0.265.gbab2e86ba0-goog

