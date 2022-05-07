Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5D51E43B
	for <lists+cgroups@lfdr.de>; Sat,  7 May 2022 07:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356753AbiEGFNF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 May 2022 01:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEGFNF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 May 2022 01:13:05 -0400
Received: from mail-il1-x162.google.com (mail-il1-x162.google.com [IPv6:2607:f8b0:4864:20::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39B5523C
        for <cgroups@vger.kernel.org>; Fri,  6 May 2022 22:09:18 -0700 (PDT)
Received: by mail-il1-x162.google.com with SMTP id o5so6024476ils.11
        for <cgroups@vger.kernel.org>; Fri, 06 May 2022 22:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:content-disposition:user-agent;
        bh=zrzqKK70W/pOx1iBnr89i/xaqiudUyZePB/8DQdsNpA=;
        b=vXX/CO1F3jbvS0XgMAyZFpfWrHhu8PrjWeZ9E9vMwsy+2Vd6BvZ05wZuHGLJLAdvxe
         U9oIZqwBceBFhF4gZ/W+1hKNXt3//jyNb9xbnXT1PhTd/Hioz2uTgHtwW3B9DvraMH+z
         zL0+TpdmXAOzWS1039s51Eid0yQnfBSOUVKXnARFqjpRvsz8G5rVQE0rz04BT+77N3dE
         yMcObOM8Vu1gQ7Z4IEwEqVaJ9nrDKQFUjui/nVpRTQQwMbZSYXsZmVsyu10gt+OuMif1
         h4O0FMB1hwsAqfSQY9S0unaRIQoCregcu9c2b155Wi1rrF68pr2pckvM1HE00IRyMxpt
         hs9Q==
X-Gm-Message-State: AOAM531P62LlSKiddvLu5kajzXVAKmgjDnovxmW2xU5i3NcVf6oL4yUv
        Y7IDlMl0ge4iCCGewT9jv0yXYmKA0goHnX9YnyAo2jHtLYEm
X-Google-Smtp-Source: ABdhPJy6br2UBVMUyCBX4XgG/5VZOi4+GqCYkiS5K1y2Ax03MjjRZc/Fc88E+lTsPV9umemoQtAAGD0rD7EK
X-Received: by 2002:a05:6e02:1187:b0:2cd:9df5:bfd2 with SMTP id y7-20020a056e02118700b002cd9df5bfd2mr2853047ili.121.1651900157795;
        Fri, 06 May 2022 22:09:17 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id p3-20020a056638190300b0032b4d24246bsm657199jal.0.2022.05.06.22.09.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2022 22:09:17 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from us192.sjc.aristanetworks.com (us192.sjc.aristanetworks.com [10.243.24.7])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 4026551D32E;
        Fri,  6 May 2022 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1651900157;
        bh=zrzqKK70W/pOx1iBnr89i/xaqiudUyZePB/8DQdsNpA=;
        h=Date:From:To:Cc:Subject:From;
        b=yr0x5+aowZmQmo7lmY/5Wg6PNN8487hbz++VV/j4rk5A6Ko/8U6vVAsn43VRQh0FU
         knA6/6JPM+Lrb+jK31NXKsREjg1uMcE4wc3s4XHgU7BzJ8udqEWZa/3/eUr352XzaN
         24hILD5pM7m0SWvE4pMY5juLZUGzOTt9UWIoBADvbIr/wmeAm38mGFzkm9+PNsc9uj
         IIIbKDu9HO/avJ7DjP1HLdR5G4tf8F6U5144z4ezwNUzyNuFzOUD5qm9U1u0vxe7cg
         +v4E3DVGSZ8ZDLDUdvYks4sk1NJyVsFYSqWIj1F7Wp8G+QEhLN9o/Vr/8ppyL+qLmt
         LDKcg14kNUfIg==
Received: by us192.sjc.aristanetworks.com (Postfix, from userid 10278)
        id 209966A417FD; Fri,  6 May 2022 22:09:17 -0700 (PDT)
Date:   Fri, 6 May 2022 22:09:16 -0700
From:   Ganesan Rajagopal <rganesan@arista.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org, rganesan@arista.com
Subject: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for v2
 memcg
Message-ID: <20220507050916.GA13577@us192.sjc.aristanetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We run a lot of automated tests when building our software and run into
OOM scenarios when the tests run unbounded. v1 memcg exports
memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
metric to heuristically limit the number of tests that can run in
parallel based on per test historical data.

This metric is currently not exported for v2 memcg and there is no
other easy way of getting this information. getrusage() syscall returns
"ru_maxrss" which can be used as an approximation but that's the max
RSS of a single child process across all children instead of the
aggregated max for all child processes. The only work around is to
periodically poll "memory.current" but that's not practical for
short-lived one-off cgroups.

Hence, expose memcg->watermark as "memory.peak" for v2 memcg.

Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
 mm/memcontrol.c                         | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 69d7a6983f78..828ce037fb2a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1208,6 +1208,13 @@ PAGE_SIZE multiple when read back.
 	high limit is used and monitored properly, this limit's
 	utility is limited to providing the final safety net.
 
+  memory.peak
+	A read-only single value file which exists on non-root
+	cgroups.
+
+	The max memory usage recorded for the cgroup and its
+	descendants since the creation of the cgroup.
+
   memory.oom.group
 	A read-write single value file which exists on non-root
 	cgroups.  The default value is "0".
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..88fa70b5d8af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6098,6 +6098,14 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static u64 memory_peak_read(struct cgroup_subsys_state *css,
+			    struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return (u64)memcg->memory.watermark * PAGE_SIZE;
+}
+
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -6361,6 +6369,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "peak",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = memory_peak_read,
+	},
 	{
 		.name = "min",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.28.0

