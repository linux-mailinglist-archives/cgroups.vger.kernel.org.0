Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01EB1A69F0
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgDMQ2P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731551AbgDMQ2N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 12:28:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A575C0A3BE2;
        Mon, 13 Apr 2020 09:28:13 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m67so9974507qke.12;
        Mon, 13 Apr 2020 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVee5LEPnYY6zF34ZuR4jFCQhJmfapbvjjnOL4aQYjw=;
        b=Hot53CJtn2fBB2y8DyRmzWibMmNk9ZIIP9y86sAKCSgqmJRIirb7rq/rg9vVFHnIyo
         sGfhoI7DFFRLH49s/i6ZBGxgN9cU8CP3sIam6U57heTNuHtE6eu57i83Q/cMpPPgMUH3
         t4W7ZyclBAcEs7wR7DokFFMkT/QQZ0R82M0sgxt0X04FRNhUQVgAVsrfUeM7//RUt1WK
         vlCFv+UR/M4mB8KVZ6MRvJfNaKEnuqr/496K+TXk/zeglyn27a3M38gm74aKp51oPdOx
         WQYfkSoqQ91xCveNYnKuabqx7uksKGngDPt6EYC3tj1VTLrYCuwID+nggxy2DUlBqQTl
         +MSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IVee5LEPnYY6zF34ZuR4jFCQhJmfapbvjjnOL4aQYjw=;
        b=PAn81Euw1aBi3YsajVkElnbPMz65FB9+v0E1NT4UJ1hHx3lN48lk5q9/btWjD+4uyV
         Oqd1/T+9CeQujZR8uQZCFC8e0cj697s+MsH/HQG2v+QSPo+Lz/ViS/Y/HEoSnYpHKDMH
         g8XsuRDhnZGjanikmqVtQu8InUz31iOmp25wo543LtRwGKIPmJtAEkGaFr898A6wxPvp
         1XSH+bfxR0ltgXLzeBMd5NmW9cnZupBlos81fZPT9pIdm9duozHqGhjsvXBoZ1mzf28A
         +3hP+w7EnclRy/5mmc5aGsXkQfMM/5P7lZHIjCsDTpXsC92SAE7JogtaoxSg9zW2SZxf
         b6AQ==
X-Gm-Message-State: AGi0PuaB6mNrLw9Y3T7aGAUqh6zZf4vv7H3cEUzIbBkLTd+HxUELGpYN
        L6OX15Hduu2ZMLEOuavx7vE=
X-Google-Smtp-Source: APiQypIA6+LanoMTgQgStyIDckI4dzIeJrzHna7Cz2nic3/Xj6lgKMjyy8a9jBX4T+nZqTM7b+uqAg==
X-Received: by 2002:a37:54e:: with SMTP id 75mr17288729qkf.257.1586795292462;
        Mon, 13 Apr 2020 09:28:12 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id n190sm8497416qkb.93.2020.04.13.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:28:11 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, asml.silence@gmail.com, ming.lei@redhat.com,
        bvanassche@acm.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] iocost_monitor: exit successfully if interval is zero
Date:   Mon, 13 Apr 2020 12:27:57 -0400
Message-Id: <20200413162758.97252-4-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>
References: <20200413162758.97252-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is to help external tools to decide whether iocost_monitor has all its
requirements met or not based on the exit status of an -i0 run.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/iocost_monitor.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/cgroup/iocost_monitor.py b/tools/cgroup/iocost_monitor.py
index 7427a5ee761b..eb2363b868c5 100644
--- a/tools/cgroup/iocost_monitor.py
+++ b/tools/cgroup/iocost_monitor.py
@@ -28,7 +28,8 @@ parser.add_argument('devname', metavar='DEV',
 parser.add_argument('--cgroup', action='append', metavar='REGEX',
                     help='Regex for target cgroups, ')
 parser.add_argument('--interval', '-i', metavar='SECONDS', type=float, default=1,
-                    help='Monitoring interval in seconds')
+                    help='Monitoring interval in seconds (0 exits immediately '
+                    'after checking requirements)')
 parser.add_argument('--json', action='store_true',
                     help='Output in json')
 args = parser.parse_args()
@@ -243,6 +244,9 @@ ioc = None
 if ioc is None:
     err(f'Could not find ioc for {devname}');
 
+if interval == 0:
+    sys.exit(0)
+
 # Keep printing
 while True:
     now = time.time()
-- 
2.25.2

