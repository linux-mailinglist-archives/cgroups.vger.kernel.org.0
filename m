Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82264392DF3
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhE0MbE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbhE0MbA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 08:31:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D944C061574
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:29:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so347917wme.5
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fRBr6xZkzmbnPWuRrXfAqA5xA8c0t9k1LP7xSr+ydFk=;
        b=cJcApNTb2Db0TXRi89IcQr4nyCEsRga93qLPHyDs6EU05t1h6i/oYDaF12n8b+GavG
         ZTXVAtZCnQhfQgxMigaLcHpVNLryZuBBpuoW+KlpDBxJ54QVoLEtjvPgnDCkYZ6+SpJO
         2F1ysEYzdiZdJ9PUVM4ZgwEEsp8DQWN4MaZmWb6RSReO+9x4XZLMAxkH722s9bc2tS6m
         bdewnwiQO7ZPndm31rDyT/lUAtMij5Cy6RClkiD6m0x5b4koK80XW+7mBR8bZa/7rgVw
         c9ZhhwQw3YS0E2+Lc9cLJjDmwMUzc+1oWkkn3adS8EQV8WITToiaSbWN/GdJthsLhKdK
         tqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fRBr6xZkzmbnPWuRrXfAqA5xA8c0t9k1LP7xSr+ydFk=;
        b=lgdvQ0AIwm7BJQ1ynr7wQ138svYI2LRpwHCnyqgnWhIMIBL4rIWJoM4seoWEfUySea
         W9vYFQrugJjdhpZ6tQHeSKNWK/L0M9IypCkUEu8KbxqbbEthNPgq5sULeTxUGUsPlWxu
         o23TAueZhGs8iYZdqGBT9wjTnJPugZiZ6F2asx7XGLpi/NsEc7+lv6JIT74AzH2LmvtJ
         VJ/PT7Fsvwkoy7+szrWZoh6VaR8un30ODNMpMVY8H7iFlHXG1Rwna/f8idJBIi2jrpd4
         p0aV4BxZd+zMA4S20em/tKbIMeAt4OkXhLWjy2Sq5vK+IxhF95Vl0VEYRKXrtbXwQfIW
         bORg==
X-Gm-Message-State: AOAM530BQcAykJHdBXbbHnUTdPtYAQIAH+4taoUrYY4ka6Jk0/eoaG0a
        2SGAU8/Ms9pwc3EyV/HaNfx8oA==
X-Google-Smtp-Source: ABdhPJxwXWYlSzkfdCpPq2hqRvGToV4bq8IdyAbufEtlz9TIqwmM8pdsrrDfEYmYfhZiMB9DJr3ClQ==
X-Received: by 2002:a1c:e243:: with SMTP id z64mr3167979wmg.25.1622118563877;
        Thu, 27 May 2021 05:29:23 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3db3:bb86:bbaa:56ab])
        by smtp.gmail.com with ESMTPSA id z3sm2917721wrq.42.2021.05.27.05.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:29:22 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        odin@uged.al, cgroups@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] schd/fair: fix stalled cfs_rq->tg_load_avg_contrib
Date:   Thu, 27 May 2021 14:29:14 +0200
Message-Id: <20210527122916.27683-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Odin reported some fairness problem between cgroup because of stalled
value in cfs_rq->tg_load_avg_contrib:

https://lkml.org/lkml/2021/5/18/566


2 problems generated this situation:
-1st: After propagating load in the hierarchy, load_sum can be null
 whereas load_avg isn't so the cfs_rq is removed whereas it still
 contribute to th tg's load
-2nd: cfs_rq->tg_load_avg_contrib was not always updated after
 significant changes like becoming null because cfs_rq had already
 been updated when propagating a child load.


Vincent Guittot (2):
  sched/fair: keep load_avg and load_sum synced
  sched/fair: make sure to update tg contrib for blocked load

 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1

