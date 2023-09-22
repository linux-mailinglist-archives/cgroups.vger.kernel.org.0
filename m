Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385777AAC89
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjIVIZw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 04:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjIVIZw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 04:25:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8829E
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 01:25:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so2359609276.2
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695371145; x=1695975945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6DHfRiy16OkhCPchGcMG2Wr8n1hI6+/4vWiAKStiZAI=;
        b=PO4IDZ1CB4avwfl3+ABGZsQgyS0OgbqDTbDSsd/oo5A1NOkxQyfLG/b+73VZ8Q2Jmc
         ogmIkaIDH4lSZuvsRh9BHQiMjpFuLjnl6mvazisQhMeZprACGdFk9EBsXfgbDKXOIhOp
         UUqr/8pj4b8na8fxqnevO6zqQiFohqr+Cde1vQh5X/xTfiVVfohXV6Eo7pDCLQ1RzYJ2
         nqxm1ccoeJlcpcucz//1Zl8rUuZiZWtrlCpy0HeCDj61qvqMknFC4JVsy1EjiaSwlH+3
         BjeJfyodIQiwAosBX6lrTU2GZiVnN5fKqxHX4FUT4zqhQ39RuzJ0LmMySUNiZzfFkC+Y
         /FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371145; x=1695975945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DHfRiy16OkhCPchGcMG2Wr8n1hI6+/4vWiAKStiZAI=;
        b=SprR4GtJJnFevUjZ8geSc4fwyN/7YJ5/EEOVJLrGxHaif8NmBy/vfE1OUirqzdLdWF
         5RQ2WV0lB2xqxNGNB7MOkWrX7+3ASWFDwaq3Eanx0m7iGv86UAHiZh+gJGOeso+VdkSS
         o9rqPtuW9wGMSDuS+y3m2zd5YnAFFXxm9LGXxAnrnejQRPJcGFQXJ+D+C6F0HG+gMI0N
         aknM3DBX3ahzd9HL3XJERdihY3pyn5ZnS/JJXZCss+0phkNm35Mybtpah+Lw0Q/sS5en
         OJO5BgofQrwRGgZsR60LQhMDPuytCQRQvhhQ1XVsvP+V/B4VVW6cWR8QGbzNPq9XFw9n
         O70g==
X-Gm-Message-State: AOJu0YzLCE64KSuXUDyFOapG5p2Ih49RdaP+h29RQmL9HihFbUfmjX06
        SuJj8tMP3lyKdDZ4/COcDMbBAz6xUgEzvKZ9
X-Google-Smtp-Source: AGHT+IE3FBqDUOqRr+DcHoUUQ9BpPeYFPo2AfexflfmNzR4QbtyXevRCS9yUS0doAcOFrE4Z0r+YFn0lXrwSsS7T
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:ac55:0:b0:d80:cf4:7e80 with SMTP id
 r21-20020a25ac55000000b00d800cf47e80mr97585ybd.7.1695371145763; Fri, 22 Sep
 2023 01:25:45 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:25:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922082542.466579-1-yosryahmed@google.com>
Subject: [PATCH 0/2] mm: memcg: fix tracking of pending stats updates values
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While working on adjacent code [1], I realized that the values passed
into memcg_rstat_updated() to keep track of the magnitude of pending
updates is consistent. It is mostly in pages, but sometimes it can be in
bytes or KBs. Fix that.

Patch 1 reworks memcg_page_state_unit() so that we can reuse it in patch
2 to check and normalize the units of state updates.

[1]https://lore.kernel.org/lkml/20230921081057.3440885-1-yosryahmed@google.com/

Yosry Ahmed (2):
  mm: memcg: refactor page state unit helpers
  mm: memcg: normalize the value passed into memcg_rstat_updated()

 mm/memcontrol.c | 64 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 13 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

