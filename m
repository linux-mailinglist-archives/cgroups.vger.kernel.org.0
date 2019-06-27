Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6237958B15
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 21:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0Ttj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 15:49:39 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46404 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0Ttj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 15:49:39 -0400
Received: by mail-oi1-f173.google.com with SMTP id 65so2466087oid.13
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2019 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AesOW3EmeuBjZTWgdRCKfU4DW0QAsRu61r3/LGTQTg8=;
        b=NCZODYSjpvpfxj59czkgru2M6MbuOf355ojoS6qv35oesf0ZPEKewPbzf8Q6hUTwNZ
         63GC9qzntLhV3BXxzsA1wfMonAydRnckvGu7+Ty6+pC2zHJpo0wDteG4b3WNGiac6WEN
         get4j9BzPfJbNVLnEdYRJcAD/bpv4qOuVvgK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AesOW3EmeuBjZTWgdRCKfU4DW0QAsRu61r3/LGTQTg8=;
        b=fSjGGqZmLq25Fw/oJSl7SspuobCYxDUB9bOFGkWdP0Ot9TtaalK8MaZukzRfpvTWxh
         dryxKyUyTfQm32NZx8dGUiVsOdsXJtfnS/+Ie88QijL68ngbh19NQHDVh7SdhdDB9RgA
         NijrogafFYrYC36XQjW1zvIK4b85MPVrXIEzRZGBdSo/ie3MvW94ItfkXeiAirO8Iabc
         erPgmyn8r4s4dt3mNe54y1W0gfAYfcWncH4UZy4jpLTfabA3UtuGkp7yXJhe734iavoA
         CcXObHyUkL/nj2mxpZ6EJt2URLdqrQTkervpCZIQ4Sv7y/DHg26Ed5zBtR6g93mpdpr0
         iOwg==
X-Gm-Message-State: APjAAAUF2lQ9PFFU6Emlbk6Fb92m5uaf9LE0mXeBu/p5l6lNYuRoerkl
        lA7fbqN8z6FnhQiH1RH3RygZDw==
X-Google-Smtp-Source: APXvYqyVAP6KFgB2RBp3IQGLzuIHqYp8k5AhEcsIAc1tToG/shUzilO1cd2B6XGEl8mHP2WOzj0kvQ==
X-Received: by 2002:aca:cfd0:: with SMTP id f199mr3076083oig.50.1561664978390;
        Thu, 27 Jun 2019 12:49:38 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id d200sm1148032oih.26.2019.06.27.12.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 12:49:37 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Pqhil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v5 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Thu, 27 Jun 2019 14:49:29 -0500
Message-Id: <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changelog v5
- Based on this comment from Ben Segall's comment on v4
> If the cost of taking this global lock across all cpus without a
> ratelimit was somehow not a problem, I'd much prefer to just set
> min_cfs_rq_runtime = 0. (Assuming it is, I definitely prefer the "lie
> and sorta have 2x period 2x runtime" solution of removing expiration)
I'm resubmitting my v3 patchset, with the requested changes.
- Updated Commit log given review comments
- Update sched-bwc.txt give my new understanding of the slack timer.

Changelog v4
- Rewrote patchset around the concept of returning all of runtime_remaining
when cfs_b nears the end of available quota.

Changelog v3
- Reworked documentation to better describe behavior of slice expiration per
feedback from Peter Oskolkov

Changelog v2
- Fixed some checkpatch errors in the commit message.
