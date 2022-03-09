Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518BB4D3B11
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiCIU2w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 15:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbiCIU2v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 15:28:51 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2797B4FC66
        for <cgroups@vger.kernel.org>; Wed,  9 Mar 2022 12:27:52 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso3379472pjb.0
        for <cgroups@vger.kernel.org>; Wed, 09 Mar 2022 12:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GUbtsiwXo7ZWNRfgZSEDw0U2PipEoXKr9rZN+rhPk3s=;
        b=SUA/yFMpMyj5GekKm292AylNufR9xs7Du5jXCeQmd7EDE/yZMieHd8zw+20EBhKiQL
         LJe2ZwA2+pASXKJsll9JWWryWd4G9oTsTuYX82IA+q+SPzHKJekgLaaNab8Xoyu9Gnqy
         Qz7YMac23398Ydaq3cXWbhq4tDiaaJVSvRptsejR3kcCTP/EB4VUbOpF4UQsCPU4Rx51
         3Fuu7Ibt7wDy7KsmMQe7ggwIZQiOO3dDhmqD4aAN8+jbToDTslnbCLrcVbmCm0EAbncQ
         R6OcG5gB5m1EOfF4dGm4mpsu6deOZl3okcWyQJMnGFQz7NB1rU0OvIpFNgP03LAS2ngx
         JdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=GUbtsiwXo7ZWNRfgZSEDw0U2PipEoXKr9rZN+rhPk3s=;
        b=S52K4QoPRrh5VzB2VMiQ/T29BtShVEtzdHmHLFfKbwIfyMpOMGMRj+UWHT0hQgjtGN
         6v5/5I6DvlHInaSIxzmij4m7L7+dydILkz/uxd8bvnQn8A1BOr/hK+HWNcesoehfwD8b
         YOBjRWVKLk9Ezpcc8u/GcUr9wMltDjnh4PkWD1BdGE2Dq7ofKinGuaRtlFP+va3qCneA
         wUB2CWAR73MAeUDvvwg9fELr6rGvElLr31saWp1XMCdrVwe6d+GTtdr6m/PR4MQvImsf
         P4PmGqvcTCiMwroMHWLYPoIWUc2rTH6Fqnqka3IKWdyn6TwKXiDjIbJohex+JSMC8paz
         Yv2A==
X-Gm-Message-State: AOAM533WhH03/Eia5yvm9m42MSYIcsrUfgbcgbb4LcPnq+BNuH90bZiB
        9KyIPRcCpDYyo+sxOdRvvRcg/qaLaQk+DRP0rHXloBPo3gybVwq7
X-Google-Smtp-Source: ABdhPJwJjCsschFnpoiZo+TBwCCYDT3Ute/Kgm6anN+K+zvlADEqrOAkki4TZUAVcrxor/K17H58isMDi+V4hORr64Q=
X-Received: by 2002:a17:903:41c9:b0:152:ab7:438 with SMTP id
 u9-20020a17090341c900b001520ab70438mr1315823ple.162.1646857671071; Wed, 09
 Mar 2022 12:27:51 -0800 (PST)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 9 Mar 2022 12:27:15 -0800
Message-ID: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
Subject: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hao Luo <haoluo@google.com>, Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>, bpf@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey everyone,

I would like to discuss an idea to facilitate collection of
hierarchical cgroup stats using BPF programs. We want to provide a
simple interface for BPF programs to collect hierarchical cgroup stats
and integrate with the existing rstat aggregation mechanism in the
kernel. The most prominent use case is the ability to extend memcg
stats (and histograms) by BPF programs.

This also integrates nicely with Hao's work [1] that enables reading
those stats through files, similar to cgroupfs. This idea is more
concerned about the stats collection path.

The main idea is to introduce a new map type (let's call it BPF cgroup
stats map for now). This map will be keyed by cgroup_id (similar to
cgroup storage). The value is an array (or struct, more on this later)
that the user chooses its size and element type, which will hold the
stats. The main properties of the map are as follows:
1. Map entries creation and deletion is handled automatically by the kernel=
.
2. Internally, the map entries contain per-cpu arrays, a total array,
and a pending array.
3. BPF programs & user space see the entry as a single array, updates
are transparently made to per-cpu array, and lookups invoke stats
flushing.

The main differences between this and a cgroup storage is that it
naturally integrates with rstat hierarchical aggregation (more on that
later). The reason why we do not want to do aggregation in BPF
programs or in user space are:
1. Each program will loop through the cgroup descendants to do their
own stats aggregation, lots of repeated work.
2. We will loop through all the descendants, even those that do not
have updates.

These problems are already addressed by the rstat aggregation
mechanism in the kernel, which is primarily used for memcg stats. We
want to provide a way for BPF programs to be able to make use of this
as well.

The lifetime of map entries can be handled as follows:
- When the map is created, it gets as a parameter an initial
cgroup_id, maybe through the map_extra parameter struct bpf_attr. The
map is created and entries for the initial cgroup and all its
descendants are created.
- The update and delete interfaces are disabled. The kernel creates
entries for new cgroups and removes entries for destroyed cgroups (we
can use cgroup_bpf_inherit() and  cgroup_bpf_release()).
- When all the entries in the map are deleted (initial cgroup
destroyed), the map is destroyed.

The map usage by BPF programs and integration with rstat can be as follows:
- Internally, each map entry has per-cpu arrays, a total array, and a
pending array. BPF programs and user space only see one array.
- The update interface is disabled. BPF programs use helpers to modify
elements. Internally, the modifications are made to per-cpu arrays,
and invoke a call to cgroup_bpf_updated()  or an equivalent.
- Lookups (from BPF programs or user space) invoke an rstat flush and
read from the total array.
- In cgroup_rstat_flush_locked() flush BPF stats as well.

Flushing of BPF stats can be as follows:
- For every cgroup, we will either use flags to distinguish BPF stats
updates from normal stats updates, or flush both anyway (memcg stats
are periodically flushed anyway).
- We will need to link cgroups to the maps that have entries for them.
One possible implementation here is to store the map entries in struct
cgroup_bpf in a htable indexed by map fd. The update helpers will also
use this to avoid lookups.
- For each updated cgroup, we go through all of its maps, accumulate
per-cpu arrays to the total array, then propagate total to the
parent=E2=80=99s pending array (same mechanism as memcg stats flushing).

There is room for extensions or generalizations here:
- Provide flags to enable/disable using per-cpu arrays (for stats that
are not updated frequently), and enable/disable hierarchical
aggregation (for non-hierarchical stats, they can still make benefit
of the automatic entries creation & deletion).
- Provide different hierarchical aggregation operations : SUM, MAX, MIN, et=
c.
- Instead of an array as the map value, use a struct, and let the user
provide an aggregator function in the form of a BPF program.

I am happy to hear your thoughts about the idea in general and any
comments or concerns.







[1] https://lwn.net/Articles/886292/
