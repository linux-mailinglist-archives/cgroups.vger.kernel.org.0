Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB156C4DA
	for <lists+cgroups@lfdr.de>; Sat,  9 Jul 2022 02:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGIAFP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Jul 2022 20:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGIAE7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Jul 2022 20:04:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965FA7D7C
        for <cgroups@vger.kernel.org>; Fri,  8 Jul 2022 17:04:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p21-20020aa78615000000b00528d84505b5so26689pfn.13
        for <cgroups@vger.kernel.org>; Fri, 08 Jul 2022 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z+JHBwxAxDgScZtO1p/+es4hJDW+SiPZzqWzOE/0rOo=;
        b=FM9Dmst+4r/eCIlrO0NIewdKZfGIpGWmXrkjfyiCnHGlO+FW3rZHJdcwkrNHgDaTY+
         cvSYpDa2VVz8F5b/HJk2BsfHzDEHYzxa91MpEdZrSY4qCNp+aQGUemw3B+BBN2wVTepD
         IMDuPcDtlPxcTr/9vxUCX+eFJDXNBb+wibjvwy3nMSfNb27E8YxtzMH96QbzdtOJNFWi
         GDPEPDNWf0f1RW1m8z9GtmDs2h6Q2PqyNj6+5ie+TBMvfXKwUN8BGxbqZXCks4Nl8kEE
         u5szkY6eBbLmh9vcfQeF7tEyiY5MgEIXNcmRC9xkHn1LF9PtT+MBlXQoXha+si78OTkH
         13MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z+JHBwxAxDgScZtO1p/+es4hJDW+SiPZzqWzOE/0rOo=;
        b=zX3B7iKllJ8I8/yu4qri+/FyUjz3CUXWlwBTaV7J+GqN0H/u/3oNmdK0gRGhDU9Syn
         gYHluh+4YRW66b9Upg9xq8LMt8Q8OY9hQVkz/BaP0PNPuuCAWBOUI6uSBCz1mBV/Y7Wz
         VmkWiQuv1Jy+rox5VK7wW4ZFeP2g3IUoOKGeQkKtNs6RwQq6QlgdkGzpMLsTlUGUWpnu
         UNjwNRklrQDhpy/X82JFKeCW+SXomkA+nmkpfN01KkV0HVKHmOiiVYD9e0OAqo64mN4H
         DWeoMYO3s9mT1lHRz4QBsssof8hAuRpAC8zFLbt7G6QJgS/fPuAln1g38Twdb3Kvebr2
         Dk1Q==
X-Gm-Message-State: AJIora/c7aw/KKvA/k53DyQlJiXdLBn+cXsrNgBHBPNkaAL1JgdJzlx7
        gqSxCNd6Ra58Xw+/8rkec183cvyKTvw49sZy
X-Google-Smtp-Source: AGRyM1ufvN6zG8QX4o7lGTyaqM53ImlvEYlHfwqxbRh1DGpIE6etmZTIKsXrAdCkxaqLrYyu8O+dj0LKvGFHdfxm
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:d191:b0:16b:ea2d:60f2 with SMTP
 id m17-20020a170902d19100b0016bea2d60f2mr5961637plb.24.1657325092664; Fri, 08
 Jul 2022 17:04:52 -0700 (PDT)
Date:   Sat,  9 Jul 2022 00:04:34 +0000
In-Reply-To: <20220709000439.243271-1-yosryahmed@google.com>
Message-Id: <20220709000439.243271-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v3 3/8] bpf, iter: Fix the condition on p when
 calling stop.
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hao Luo <haoluo@google.com>

In bpf_seq_read, seq->op->next() could return an ERR and jump to
the label stop. However, the existing code in stop does not handle
the case when p (returned from next()) is an ERR. Adds the handling
of ERR of p by converting p into an error and jumping to done.

Because all the current implementations do not have a case that
returns ERR from next(), so this patch doesn't have behavior changes
right now.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/bpf_iter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f64..4688ba39ef25c 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -198,6 +198,11 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	}
 stop:
 	offs = seq->count;
+	if (IS_ERR(p)) {
+		seq->op->stop(seq, NULL);
+		err = PTR_ERR(p);
+		goto done;
+	}
 	/* bpf program called if !p */
 	seq->op->stop(seq, p);
 	if (!p) {
-- 
2.37.0.rc0.161.g10f37bed90-goog

