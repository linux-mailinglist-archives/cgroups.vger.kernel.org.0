Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09057650707
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 05:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiLSEW2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Dec 2022 23:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLSEWW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Dec 2022 23:22:22 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52165B1;
        Sun, 18 Dec 2022 20:22:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so7831743plr.10;
        Sun, 18 Dec 2022 20:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/dEEVX13cf5N+hd3J7uA7Y2/NQepsAAVSk8729Qq40=;
        b=qFO7HG25w+cLED22tN8Huxazgyrk+kzJbcPjLeO6N5NIO87MAUVwX6Mumxf/9vIlzh
         +SYfE99b2GWxjvw+XvnIxmevcqKVbYVkJwRKvvepIVV4eWzKf9wEw+N2umVIZRO4JXBV
         ekPbMz+RLOENjk59Ctzt6ajDF4ya3KrNjAHvEJIPbD7d88ck1eOcPWWojDK8oQYLwEeG
         lq8QiVRcQPU9zlXHRVIsRlNveA6XFeHGCtp7y8RJzugbu2S5Vpxgtxzo0GpeE1l+3WDV
         vDrHp6LeT8Pi4lu3o3MPD/ixNr4yiRXnmlBF4q2vBQU2dEs/UVzFDkLwqOcTdpML+5qC
         eGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/dEEVX13cf5N+hd3J7uA7Y2/NQepsAAVSk8729Qq40=;
        b=MkUn123ZIukvYcQdfI+nszcXtpXVgUzG5x/BRXGP7IuVpgGd742ujVfKbvTUb+YtKm
         EOd7QgaMLg/hXBrQ76B5YO/pwDcT+hVrxq5qSgXjsgdQlKvVLKTQgV0FjbRRyLbcvm8i
         dGx4p0IR48IdSuaVh1H7Fxe0Gb0UxVVnuc7FvLd/pVaIfyHR0yFcYEVD+18ep2jDKc7X
         eCAzkysfaVCYw20gG1Jj3DlsZw90T4Igp4XyuDkjeXTTDuv+Y2xUbCXjCoS+8M+N4fUR
         n81TcBaLsAicrrUXyjOLeTR/ryDwcg/wxfYJImkFrfl1eJyU88gbW2TrtswKX5QzYh/w
         6XwQ==
X-Gm-Message-State: ANoB5plL3fcaivlygyZrig1J6ZoMquuXbvugqhhwiwe28ukp3aEIDTPs
        YGeaz2AnlWj/5zXv2+A0cmo=
X-Google-Smtp-Source: AA0mqf7Dj9UJegqhAEUhYQZb1em+WjZomT0tTm+r878JDjrhX6fvMKEXBZnjRus0pjIo2fhCrCzOnQ==
X-Received: by 2002:a05:6a20:bc9b:b0:ac:3bb0:5346 with SMTP id fx27-20020a056a20bc9b00b000ac3bb05346mr43688488pzb.49.1671423740291;
        Sun, 18 Dec 2022 20:22:20 -0800 (PST)
Received: from debian.me (subs32-116-206-28-20.three.co.id. [116.206.28.20])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b00189a7fbfd44sm5833480pln.211.2022.12.18.20.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 20:22:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7F17B103FA2; Mon, 19 Dec 2022 11:22:13 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 00/10] docs: cgroup-v1: formatting improv for "Memory Resource Controller" doc
Date:   Mon, 19 Dec 2022 11:21:59 +0700
Message-Id: <20221219042209.22898-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=bagasdotme@gmail.com; h=from:subject; bh=9tZWDHm18Fs9yM3gahlNr+8oWRyGbaFrmuTs8kx2K9Y=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMnznz2bYXQ7luWTyI/JguFViRrree0P749+tHGCyfZ/H1fn l6hu6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEzoQwMmypnO4aKnYoMvXzfpaNH5 nsvnkfjGxNmL9ZdUlKie/SozcZ/sqVX7ghs/N3p7WjUsRC2TXvBUrncGjOPObadH9F/ATTqZwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

"Memory Resource Controller" CGroup v1 documentation has been in reST
since 99c8b231ae6c6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst"). The current doc look is kinda ugly, so improve the formatting (only
htmldocs is tested).

The first patch is a fix for recently reported htmldocs warning, which can
be pickup separately from rest of the series.

Bagas Sanjaya (10):
  docs: cgroup-v1: extend underline of section 8
  docs: cgroup-v1: replace custom note constructs with appropriate
    admonition blocks
  docs: cgroup-v1: wrap remaining admonitions in admonition blocks
  docs: cgroup-v1: use code block for locking order schema
  docs: cgroup-v1: fix footnotes
  docs: cgroup-v1: move hierarchy of accounting caption
  docs: cgroup-v1: use bullet lists for list of stat file tables
  docs: cgroup-v1: use make swap extension subsections subsections
  docs: cgroup-v1: add internal cross-references
  docs: cgroup-v1: use numbered lists for user interface setup

 .../admin-guide/cgroup-v1/cgroups.rst         |   2 +
 .../admin-guide/cgroup-v1/memory.rst          | 290 ++++++++++--------
 2 files changed, 158 insertions(+), 134 deletions(-)


base-commit: fb94e0734a2aaf6fc11c92959efc640370df8d42
-- 
An old man doll... just what I always wanted! - Clara

