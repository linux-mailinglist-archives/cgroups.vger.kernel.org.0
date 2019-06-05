Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99CB3620B
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfFERDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 13:03:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38909 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfFERDg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 13:03:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so18826165qtj.5
        for <cgroups@vger.kernel.org>; Wed, 05 Jun 2019 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i95vFPoXF2aibM9zJc0/oYy2BodI27H2qyuN0bQw9Yc=;
        b=jxSiakHOlIHT8jsCZ0Q5g9RtHfHfE81IkoIm9MAtVRIkOHhscsS5lkb3YSnrUNHQKE
         p5lyxlZnJOtfWCyAQxZsLVi/xJb4YMifYynY3avwjMBtQQP+8YKwfi1s85zn/jqGO6zV
         IlD2FkP2jGteUprB+vB44NKzM+a7S+lRCt6xz9twYJ0OWo/Cu9JTJCVoUcwWH3tORJXB
         00K1815DunnsYDPtNC5qapP1hceu+97AK8i9lgYB62Nt8P2uUl2Babfm6gSToS13VYx6
         gdAPCiKLAX4rqb2isBYGK8PuD03U8kqJQiI9cZs/+cd7no17LOZDsL7CZQw/L03ivTuA
         ppXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i95vFPoXF2aibM9zJc0/oYy2BodI27H2qyuN0bQw9Yc=;
        b=UnJ/7zOFIPrsFA5oyGicWeF9Dm2JmmZbPbIvqulNYO1BOvm3+O1fzlsJIr58Gb5bXv
         BEd6O1aDagIyOkMCNJZ5asGPAfKjUBhdX4ih+7a+ls2vz2iWRjf7Uo+x6zsIVgrI5RyH
         OfSV9E5iaydA4A2ra67T5CrMuUk6c8HKwQnO8hKRzOjtWaeUKCe5diMPkHQ2nKmFejPy
         BdsvO57KJNpWpvMaxxEgeDarF1ex2nPc02OAwgEb6D5X51UcllzDsCgjIJ3TRE2HHuoH
         MIRP7WyOJNxF8a4aXpS2uQiCJoVHGHjJHD24A4cf9UHnWr6GFFwKy29AyQzaGuQg8XXK
         G6Rw==
X-Gm-Message-State: APjAAAUkV1lCfevsep2+W/2Dpx5sgUQ5XzEHfsGaWjQ7hjZ5+zg40mmj
        +1a4dMr789C4gxH/zWL3lPE=
X-Google-Smtp-Source: APXvYqxtd5z5cGbGq5TjeCwdNUerioeji7UmkR6Nl7UyUP7Rr6RVrJqbhYnygtgyEynEuGlrwtVqLg==
X-Received: by 2002:ac8:1750:: with SMTP id u16mr21378557qtk.90.1559754215607;
        Wed, 05 Jun 2019 10:03:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id w30sm8885985qtb.28.2019.06.05.10.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:03:34 -0700 (PDT)
Date:   Wed, 5 Jun 2019 10:03:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Li Zefan <lizefan@huawei.com>, Topi Miettinen <toiwoton@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, security@debian.org,
        Lennart Poettering <lennart@poettering.net>,
        security@kernel.org
Subject: [PATCH 4/3 cgroup/for-5.2-fixes] cgroup: css_task_iter_skip()'d
 iterators must be advanced before accessed
Message-ID: <20190605170333.GQ374014@devbig004.ftw2.facebook.com>
References: <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
 <20190530183845.GU374014@devbig004.ftw2.facebook.com>
 <20190531174028.GG374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531174028.GG374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From cee0c33c546a93957a52ae9ab6bebadbee765ec5 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 5 Jun 2019 09:54:34 -0700

b636fd38dc40 ("cgroup: Implement css_task_iter_skip()") introduced
css_task_iter_skip() which is used to fix task iterations skipping
dying threadgroup leaders with live threads.  Skipping is implemented
as a subportion of full advancing but css_task_iter_next() forgot to
fully advance a skipped iterator before determining the next task to
visit causing it to return invalid task pointers.

Fix it by making css_task_iter_next() fully advance the iterator if it
has been skipped since the previous iteration.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: syzbot
Link: http://lkml.kernel.org/r/00000000000097025d058a7fd785@google.com
Fixes: b636fd38dc40 ("cgroup: Implement css_task_iter_skip()")
---
Applied to cgroup/for-5.2-fixes.  Thanks.

 kernel/cgroup/cgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a7df319c2e9a..9538a12d42d6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4550,6 +4550,10 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
 
 	spin_lock_irq(&css_set_lock);
 
+	/* @it may be half-advanced by skips, finish advancing */
+	if (it->flags & CSS_TASK_ITER_SKIPPED)
+		css_task_iter_advance(it);
+
 	if (it->task_pos) {
 		it->cur_task = list_entry(it->task_pos, struct task_struct,
 					  cg_list);
-- 
2.17.1

