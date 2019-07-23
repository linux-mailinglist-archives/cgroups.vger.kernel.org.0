Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4624471D10
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 18:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbfGWQpK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 12:45:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44295 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbfGWQpJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 12:45:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so6246702otl.11
        for <cgroups@vger.kernel.org>; Tue, 23 Jul 2019 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ADevYrTtujyVPlK2tuwzFrUbRUoPbF6rtrn0E36CPHM=;
        b=Jh6y+i7ilzxWsEyzWSh5ajwKZ3FeaRcz5c8xrmJ1BaE6ye4FKc3bYOK0/IPng058dI
         vaXiuqO3ZWMsCAKZ07n/iVLG3THw1XMi89oOPXPxBeLWjs+0Ny3RFcpdve25jPP0+Gdb
         hvd/8UiFnj7jNfmaaswaFUfXxGn4mHrGa6QpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ADevYrTtujyVPlK2tuwzFrUbRUoPbF6rtrn0E36CPHM=;
        b=QiU99n9tGiEXxpJza5emX7/vbIuzxj5wnCoHXckUcZkvD7AjpeAEbd64FGOvJVK1fh
         pRBhG4Lv5mi+DFWZLvf8OzInvhqEDIabauWcX5+hNoUBqXVflqcExH6bwcscnMEkQNul
         MgcbdZVMtBJgsPV/ORaxu/hnUeSV6VWaFcVbv8tcC/O/aBXD2536ljHpGa+Ok5BBSUgR
         OzRFjsU8pSOwLZg1/0DDCk1m7SrX5f40H1tBGt3AsZLS/1C2Ws151fWs18ywVT+31i6+
         PBLGsWCJkKS7+Pklh/r16sLYUbPRYyiomDjrAMDjRolVXyFdK7D8zQYwlzy37uK023yR
         beLw==
X-Gm-Message-State: APjAAAW5u9Evqsv4v5gCF4DYdHTpgyi23lgQ5nIRnYj6nSGcWp7GVNao
        3wUmIQrziwGbPIMS8k9AEkl5dg==
X-Google-Smtp-Source: APXvYqzL573W3YN7hPujIgZU9FHf6KOYF+tUoiFz+r5UIB2LRrk29uxvKLYvtzCvG0M+hnD6Ll/pMw==
X-Received: by 2002:a05:6830:154e:: with SMTP id l14mr21648154otp.365.1563900308442;
        Tue, 23 Jul 2019 09:45:08 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id f125sm14937391oia.44.2019.07.23.09.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 09:45:07 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Ben Segall <bsegall@google.com>, Phil Auld <pauld@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v6 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Tue, 23 Jul 2019 11:44:25 -0500
Message-Id: <1563900266-19734-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changelog v6
- Added back missing call to lsub_positive(&cfs_b->runtime, runtime);
- Added Reviewed-by: Ben Segall <bsegall@google.com>
- Fix some grammar in the Documentation, and change some wording.
- Updated documentation due to the .rst change

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
