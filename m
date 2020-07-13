Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E7121D523
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgGMLmR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jul 2020 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMLmR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jul 2020 07:42:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A43C061755
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:42:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx13so16666642ejb.4
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TvJxYzvOgzlC3BuPyn0KYnjcr7/OFk0QNHyHHZoEtGc=;
        b=rO39pjE0Wei+6nLZvaupuo2Ex4KuQD2qZ+3t6eBYQNcRJtvYdxAC8ONfkblcinlcJO
         CsVJ3UHvyqauDlk9iXmWwHEWUAv6UaIhcERBX4YfcmGPRVnAF+ubSh8IYXCZ3iIBZhvT
         yOhcnmyjlTvVR4JTTXRQsTb9HRlMgpn7BBmrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TvJxYzvOgzlC3BuPyn0KYnjcr7/OFk0QNHyHHZoEtGc=;
        b=jnQE++p2banFcwMB5r71EpAxs7ZlVFZXLVEDqm64uUjL47Lc2Vqjm4DtTWyywDAGLt
         wMf9Y7kSYvKptR9R9+ObBuRBxZuyp3ArWOfHuDMzMCZhqArQtK1TIijVpTRqAOn4zaa8
         mgrWB6FTe7Y7whJeBTX8jOcH/a7kTdTgxozo1ZktlsC/XslPcM8m1jbqT3hMMRcEF8o3
         TkFRQxeUhO7hV+mzKV/MR5mEKtoYwBC/Rxq53Rfcjig7B6fNx+TRYofRrmFsZ9xJ4Q5z
         woZdyFTaqpYD+tM3P57gdFi8Et6FMeYCjTs1enoT86iAHM2IIYEr1KMxngpKRz4BZFdI
         SrRQ==
X-Gm-Message-State: AOAM533iAS5Yvzov/NKvA1YARXn+7XkqMi6wxnxz4C2fMnqDsfGHm2NT
        LaE6Nrj9KeAmFLz/gKX1CMQWww==
X-Google-Smtp-Source: ABdhPJzGgq6RGP3XIbwumibrODkGvKT1MpPv2MlO3N6NK25YXE3CCow3QCIXO8inZ0byPzPoTPrA+Q==
X-Received: by 2002:a17:906:c142:: with SMTP id dp2mr76749291ejc.541.1594640534092;
        Mon, 13 Jul 2020 04:42:14 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id bz14sm5377849ejc.88.2020.07.13.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:42:13 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:42:13 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/2] mm, memcg: reclaim harder before high throttling
Message-ID: <cover.1594640214.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changes since v1:

- Reclaim only SWAP_CLUSTER_MAX pages on reclaim retries, and add
  comment explaining why. Thanks Johannes for the suggestion.
- Unify into series.

Chris Down (2):
  mm, memcg: reclaim more aggressively before high allocator throttling
  mm, memcg: unify reclaim retry limits with page allocator

 mm/memcontrol.c | 53 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

-- 
2.27.0

